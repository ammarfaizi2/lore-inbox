Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263159AbUEKUMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263159AbUEKUMO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 16:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263574AbUEKUMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 16:12:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:9096 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263159AbUEKUMK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 16:12:10 -0400
Date: Tue, 11 May 2004 13:11:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: geoff@linux.jf.intel.com, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
Subject: Re: [RFC] [PATCH] Performance of del_timer_sync
Message-Id: <20040511131137.2390ffa8.akpm@osdl.org>
In-Reply-To: <20040511195856.GA4958@elte.hu>
References: <409FFF3B.3090506@linux.intel.com>
	<20040511004551.7c7af44d.akpm@osdl.org>
	<00c001c43786$f1805000$ff0da8c0@amr.corp.intel.com>
	<20040511121126.73f5fdeb.akpm@osdl.org>
	<20040511195856.GA4958@elte.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > Ingo, why is this not sufficient?
> > 
> > @@ -331,6 +331,8 @@ int del_timer_sync(struct timer_list *ti
> >  
> >  del_again:
> >  	ret += del_timer(timer);
> > +	if (!ret)
> > +		return 0;
> >  
> >  	for_each_cpu(i) {
> >  		base = &per_cpu(tvec_bases, i);
> 
> it's not sufficient because a timer might be running on another CPU even
> if it has not been deleted. We delete a timer prior running it (so that
> the timer fn can re-activate the timer). So del_timer_sync() has to
> synchronize independently of whether the timer was removed or not.
> 

Ah, OK, the timer handler may re-add itself.  Really, that's a bug in the
caller: once they've decided to shoot down the timer the caller should have
made state changes which prevent the handler from re-adding the timer.

Still, too late to change that.

Neither AIO nor schedule_timeout() actually re-add the timer so they don't
need the full treatment, yes?


 25-akpm/fs/aio.c              |    2 +-
 25-akpm/include/linux/timer.h |    2 ++
 25-akpm/kernel/timer.c        |    9 +++++++--
 3 files changed, 10 insertions(+), 3 deletions(-)

diff -puN kernel/timer.c~del-timer-speedup kernel/timer.c
--- 25/kernel/timer.c~del-timer-speedup	2004-05-11 13:05:41.997859088 -0700
+++ 25-akpm/kernel/timer.c	2004-05-11 13:07:32.493061264 -0700
@@ -348,8 +348,13 @@ del_again:
 
 	return ret;
 }
-
 EXPORT_SYMBOL(del_timer_sync);
+
+int del_single_shot_timer(struct timer_struct *timer)
+{
+	if (del_timer(timer))
+		del_timer_sync(timer);
+}
 #endif
 
 static int cascade(tvec_base_t *base, tvec_t *tv, int index)
@@ -1109,7 +1114,7 @@ fastcall signed long __sched schedule_ti
 
 	add_timer(&timer);
 	schedule();
-	del_timer_sync(&timer);
+	del_single_shot_timer(&timer);
 
 	timeout = expire - jiffies;
 
diff -puN include/linux/timer.h~del-timer-speedup include/linux/timer.h
--- 25/include/linux/timer.h~del-timer-speedup	2004-05-11 13:05:42.012856808 -0700
+++ 25-akpm/include/linux/timer.h	2004-05-11 13:07:01.905711248 -0700
@@ -88,8 +88,10 @@ static inline void add_timer(struct time
 
 #ifdef CONFIG_SMP
   extern int del_timer_sync(struct timer_list * timer);
+  extern int del_single_shot_timer(struct timer_struct *timer);
 #else
 # define del_timer_sync(t) del_timer(t)
+# define del_single_shot_timer(t) del_timer(t)
 #endif
 
 extern void init_timers(void);
diff -puN fs/aio.c~del-timer-speedup fs/aio.c
--- 25/fs/aio.c~del-timer-speedup	2004-05-11 13:05:42.028854376 -0700
+++ 25-akpm/fs/aio.c	2004-05-11 13:07:14.591782672 -0700
@@ -788,7 +788,7 @@ static inline void set_timeout(long star
 
 static inline void clear_timeout(struct timeout *to)
 {
-	del_timer_sync(&to->timer);
+	del_single_shot_timer(&to->timer);
 }
 
 static int read_events(struct kioctx *ctx,

_

