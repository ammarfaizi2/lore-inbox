Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264716AbSKEFgk>; Tue, 5 Nov 2002 00:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264751AbSKEFgk>; Tue, 5 Nov 2002 00:36:40 -0500
Received: from packet.digeo.com ([12.110.80.53]:22402 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264716AbSKEFgh>;
	Tue, 5 Nov 2002 00:36:37 -0500
Message-ID: <3DC75A69.2B2742DC@digeo.com>
Date: Mon, 04 Nov 2002 21:43:05 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.45 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Subject: [patch 1/4] fix mod_timer() race
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Nov 2002 05:43:06.0131 (UTC) FILETIME=[36E9CE30:01C2848E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



If two CPUs run mod_timer against the same not-pending timer then they
have no locking relationship.  They can both see the timer as
not-pending and they both add the timer to their cpu-local list.  The
CPU which gets there second corrupts the first CPU's lists.

This was causing Dave Hansen's 8-way to oops after a couple of minutes
of specweb testing.

I believe that to fix this we need locking which is associated with the
timer itself.  The easy fix is hashed spinlocking based on the timer's
address.  The hard fix is a lock inside the timer itself.

It is hard because init_timer() becomes compulsory, to initialise that
spinlock.  An unknown number of code paths in the kernel just wipe the
timer to all-zeroes and start using it.

I chose the hard way - it is cleaner and more idiomatic.  The patch
also adds a "magic number" to the timer so we can detect when a timer
was not correctly initialised.  A warning and stack backtrace is
generated and the timer is fixed up.  After 16 such warnings the
warning mechanism shuts itself up until a reboot.

It took six patches to my kernel to stop the warnings from coming out. 
The uninitialised timers are extremely easy to find and fix.  But it
will take some time to weed them all out.  Maybe we should go for
the hashed locking...

Note that the new timer->lock means that we can clean up some awkward
"oh we raced, let's try again" code in timer.c.  But to do that we'd
also need to take timer->lock in the commonly-called del_timer(), so I
left it as-is.

The lock is not needed in add_timer() because concurrent
add_timer()/add_timer() and concurrent add_timer()/mod_timer() are
illegal.



 include/linux/timer.h |    8 ++++++++
 kernel/timer.c        |   42 +++++++++++++++++++++++++++++++++++++++---
 2 files changed, 47 insertions(+), 3 deletions(-)

--- 25/include/linux/timer.h~mod_timer-race	Mon Nov  4 19:19:30 2002
+++ 25-akpm/include/linux/timer.h	Mon Nov  4 19:19:30 2002
@@ -3,6 +3,7 @@
 
 #include <linux/config.h>
 #include <linux/list.h>
+#include <linux/spinlock.h>
 
 struct tvec_t_base_s;
 
@@ -10,12 +11,17 @@ struct timer_list {
 	struct list_head entry;
 	unsigned long expires;
 
+	spinlock_t lock;
+	unsigned long magic;
+
 	void (*function)(unsigned long);
 	unsigned long data;
 
 	struct tvec_t_base_s *base;
 };
 
+#define TIMER_MAGIC	0x4b87ad6e
+
 /***
  * init_timer - initialize a timer.
  * @timer: the timer to be initialized
@@ -26,6 +32,8 @@ struct timer_list {
 static inline void init_timer(struct timer_list * timer)
 {
 	timer->base = NULL;
+	timer->magic = TIMER_MAGIC;
+	spin_lock_init(&timer->lock);
 }
 
 /***
--- 25/kernel/timer.c~mod_timer-race	Mon Nov  4 19:19:30 2002
+++ 25-akpm/kernel/timer.c	Mon Nov  4 19:20:05 2002
@@ -69,6 +69,30 @@ static DEFINE_PER_CPU(tvec_base_t, tvec_
 /* Fake initialization needed to avoid compiler breakage */
 static DEFINE_PER_CPU(struct tasklet_struct, timer_tasklet) = { NULL };
 
+static void check_timer_failed(timer_t *timer)
+{
+	static int whine_count;
+	if (whine_count < 16) {
+		whine_count++;
+		printk("Uninitialised timer!\n");
+		printk("This is just a warning.  Your computer is OK\n");
+		printk("function=0x%p, data=0x%lx\n",
+			timer->function, timer->data);
+		dump_stack();
+	}
+	/*
+	 * Now fix it up
+	 */
+	spin_lock_init(&timer->lock);
+	timer->magic = TIMER_MAGIC;
+}
+
+static inline void check_timer(timer_t *timer)
+{
+	if (timer->magic != TIMER_MAGIC)
+		check_timer_failed(timer);
+}
+
 static inline void internal_add_timer(tvec_base_t *base, timer_t *timer)
 {
 	unsigned long expires = timer->expires;
@@ -129,6 +153,8 @@ void add_timer(timer_t *timer)
   
   	BUG_ON(timer_pending(timer) || !timer->function);
 
+	check_timer(timer);
+
 	spin_lock_irqsave(&base->lock, flags);
 	internal_add_timer(base, timer);
 	timer->base = base;
@@ -150,6 +176,8 @@ void add_timer_on(struct timer_list *tim
   
   	BUG_ON(timer_pending(timer) || !timer->function);
 
+	check_timer(timer);
+
 	spin_lock_irqsave(&base->lock, flags);
 	internal_add_timer(base, timer);
 	timer->base = base;
@@ -182,6 +210,9 @@ int mod_timer(timer_t *timer, unsigned l
 	int ret = 0;
 
 	BUG_ON(!timer->function);
+
+	check_timer(timer);
+
 	/*
 	 * This is a common optimization triggered by the
 	 * networking code - if the timer is re-modified
@@ -190,7 +221,7 @@ int mod_timer(timer_t *timer, unsigned l
 	if (timer->expires == expires && timer_pending(timer))
 		return 1;
 
-	local_irq_save(flags);
+	spin_lock_irqsave(&timer->lock, flags);
 	new_base = &per_cpu(tvec_bases, smp_processor_id());
 repeat:
 	old_base = timer->base;
@@ -207,7 +238,7 @@ repeat:
 			spin_lock(&new_base->lock);
 		}
 		/*
-		 * The timer base might have changed while we were
+		 * The timer base might have been cancelled while we were
 		 * trying to take the lock(s):
 		 */
 		if (timer->base != old_base) {
@@ -232,7 +263,8 @@ repeat:
 
 	if (old_base && (new_base != old_base))
 		spin_unlock(&old_base->lock);
-	spin_unlock_irqrestore(&new_base->lock, flags);
+	spin_unlock(&new_base->lock);
+	spin_unlock_irqrestore(&timer->lock, flags);
 
 	return ret;
 }
@@ -253,6 +285,8 @@ int del_timer(timer_t *timer)
 	unsigned long flags;
 	tvec_base_t *base;
 
+	check_timer(timer);
+
 repeat:
  	base = timer->base;
 	if (!base)
@@ -290,6 +324,8 @@ int del_timer_sync(timer_t *timer)
 	tvec_base_t *base;
 	int i, ret = 0;
 
+	check_timer(timer);
+
 del_again:
 	ret += del_timer(timer);
 

.
