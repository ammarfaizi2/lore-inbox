Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261830AbVCHHdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbVCHHdV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 02:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbVCHHdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 02:33:21 -0500
Received: from fire.osdl.org ([65.172.181.4]:30103 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261830AbVCHHdG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 02:33:06 -0500
Date: Mon, 7 Mar 2005 23:32:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <christoph@graphe.net>
Cc: roland@redhat.com, shai@scalex86.org, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] del_timer_sync scalability patch
Message-Id: <20050307233202.1e217aaa.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503072244270.20044@server.graphe.net>
References: <Pine.LNX.4.58.0503072244270.20044@server.graphe.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <christoph@graphe.net> wrote:
>
> When a potential periodic timer is deleted through timer_del_sync, all
>  cpus are scanned to determine if the timer is running on that cpu. In a
>  NUMA configuration doing so will cause NUMA interlink traffic which limits
>  the scalability of timers.
> 
>  The following patch makes the timer remember where the timer was last
>  started. It is then possible to only wait for the completion of the timer
>  on that specific cpu.

OK, I stared at this for a while and cannot see holes in it.  There may
still be one though - this code is tricky.  Probably any such holes would
be covered up by the fact that timers never migrate between CPUs anyway,
unless the handler chooses to do add_timer_on(), which I'm sure none do..

Ingo, could you take a look?  Especially what happens if the timer hops
CPUs after the 

	/* Get where the timer ran last */
	base = timer->last_running;

statement.  Do we have sufficient barriers in there for this?


A few tidyings which I'd suggest:




- Remove TIMER_INIT_LASTRUNNING: struct initialisers set unmentioned fields
  to zero anyway.

- Rename set_last_running() to timer_set_last_running, move it to timer.h.
  Then use it in init_timer() to avoid an ifdef.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/include/linux/timer.h |   21 ++++++++++-----------
 25-akpm/kernel/timer.c        |   10 +---------
 2 files changed, 11 insertions(+), 20 deletions(-)

diff -puN include/linux/timer.h~del_timer_sync-scalability-patch-tidy include/linux/timer.h
--- 25/include/linux/timer.h~del_timer_sync-scalability-patch-tidy	2005-03-07 23:28:55.000000000 -0800
+++ 25-akpm/include/linux/timer.h	2005-03-07 23:30:23.000000000 -0800
@@ -26,12 +26,6 @@ struct timer_list {
 
 #define TIMER_MAGIC	0x4b87ad6e
 
-#ifdef CONFIG_SMP
-#define TIMER_INIT_LASTRUNNING .last_running = NULL,
-#else
-#define TIMER_INIT_LASTRUNNING
-#endif
-
 #define TIMER_INITIALIZER(_function, _expires, _data) {		\
 		.function = (_function),			\
 		.expires = (_expires),				\
@@ -39,9 +33,16 @@ struct timer_list {
 		.base = NULL,					\
 		.magic = TIMER_MAGIC,				\
 		.lock = SPIN_LOCK_UNLOCKED,			\
-		TIMER_INIT_LASTRUNNING                          \
 	}
 
+static inline void
+timer_set_last_running(struct timer_list *timer, struct tvec_t_base_s *base)
+{
+#ifdef CONFIG_SMP
+	timer->last_running = base;
+#endif
+}
+
 /***
  * init_timer - initialize a timer.
  * @timer: the timer to be initialized
@@ -49,11 +50,9 @@ struct timer_list {
  * init_timer() must be done to a timer prior calling *any* of the
  * other timer functions.
  */
-static inline void init_timer(struct timer_list * timer)
+static inline void init_timer(struct timer_list *timer)
 {
-#ifdef CONFIG_SMP
-	timer->last_running = NULL;
-#endif
+	timer_set_last_running(timer, NULL);
 	timer->base = NULL;
 	timer->magic = TIMER_MAGIC;
 	spin_lock_init(&timer->lock);
diff -puN kernel/timer.c~del_timer_sync-scalability-patch-tidy kernel/timer.c
--- 25/kernel/timer.c~del_timer_sync-scalability-patch-tidy	2005-03-07 23:28:55.000000000 -0800
+++ 25-akpm/kernel/timer.c	2005-03-07 23:28:55.000000000 -0800
@@ -86,14 +86,6 @@ static inline void set_running_timer(tve
 #endif
 }
 
-static inline void set_last_running(struct timer_list *timer,
-					tvec_base_t *base)
-{
-#ifdef CONFIG_SMP
-	timer->last_running = base;
-#endif
-}
-
 /* Fake initialization */
 static DEFINE_PER_CPU(tvec_base_t, tvec_bases) = { SPIN_LOCK_UNLOCKED };
 
@@ -482,7 +474,7 @@ repeat:
 			set_running_timer(base, timer);
 			smp_wmb();
 			timer->base = NULL;
-			set_last_running(timer, base);
+			timer_set_last_running(timer, base);
 			spin_unlock_irq(&base->lock);
 			{
 				u32 preempt_count = preempt_count();
_

