Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272815AbTG3IfR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 04:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272819AbTG3IfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 04:35:17 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:22753
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S272815AbTG3Ie7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 04:34:59 -0400
Date: Wed, 30 Jul 2003 10:37:26 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linas@austin.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: Race in 2.6.0-test2 timer code
Message-ID: <20030730083726.GE23835@dualathlon.random>
References: <20030730073458.GA23835@dualathlon.random> <Pine.LNX.4.44.0307300934530.433-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307300934530.433-100000@localhost.localdomain>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30, 2003 at 09:40:14AM +0200, Ingo Molnar wrote:
> 
> On Wed, 30 Jul 2003, Andrea Arcangeli wrote:
> 
> > [...] I'd feel much safer with the whole timer API being smp safe w/o
> > requiring driver developers to add complicated external brainer locking.
> > This will provide a much more friendly abstraction.
> 
> i agree with the goal, but your patch does not achieve this. Your patch
> does not make double-add_timer() safe for example. As far as i can see
> your 2.6 patch only introduces additional overhead.

I never did any 2.6 patch, so it maybe a different thing what you've
seen, not what I applied to 2.4. Infact even the 2.4 patch isn't from
me.

This is the fix I applied to my 2.4 tree and it definitely fixes the
problem, including add_timer against add_timer. And it fixes the bug in
practice, it usually took a few hours to crash, not it can run for days
stable and I never heard complains again.

--- linux-2.4.19.SuSE-orig/kernel/timer.c	2003-07-02 13:53:55.000000000 -0700
+++ linux-2.4.19.SuSE-timer/kernel/timer.c	2003-07-02 18:32:08.000000000 -0700
@@ -144,17 +144,22 @@ void add_timer(timer_t *timer)
 
 	CHECK_BASE(base);
 	CHECK_BASE(timer->base);
-	spin_lock_irqsave(&base->lock, flags);
-	if (timer_pending(timer))
-		goto bug;
-	internal_add_timer(base, timer);
-	timer->base = base;
-	spin_unlock_irqrestore(&base->lock, flags);
-	return;
-bug:
-	spin_unlock_irqrestore(&base->lock, flags);
-	printk("bug: kernel timer added twice at %p.\n",
-			__builtin_return_address(0));
+
+	local_irq_save(flags);
+	while (unlikely(test_and_set_bit(0, &timer->lock)))
+		while (test_bit(0, &timer->lock));
+
+	spin_lock(&base->lock);
+	if (timer_pending(timer)) {
+		printk("bug: kernel timer added twice at %p.\n",
+				__builtin_return_address(0));
+	} else {
+		internal_add_timer(base, timer);
+		timer->base = base;
+	}
+	spin_unlock(&base->lock);
+	clear_bit(0, &timer->lock);
+	local_irq_restore(flags);
 }

 static inline int detach_timer(timer_t *timer)
@@ -244,16 +249,24 @@ int del_timer(timer_t * timer)
 	CHECK_BASE(timer->base);
 	if (!timer->base)
 		return 0;
+
+	local_irq_save(flags);
+	while (unlikely(test_and_set_bit(0, &timer->lock)))
+		while (test_bit(0, &timer->lock));
+
 repeat:
  	base = timer->base;
-	spin_lock_irqsave(&base->lock, flags);
+	spin_lock(&base->lock);
 	if (base != timer->base) {
-		spin_unlock_irqrestore(&base->lock, flags);
+		spin_unlock(&base->lock);
 		goto repeat;
 	}
 	ret = detach_timer(timer);
 	timer->list.next = timer->list.prev = NULL;
-	spin_unlock_irqrestore(&base->lock, flags);
+	spin_unlock(&base->lock);
+
+	clear_bit(0, &timer->lock);
+	local_irq_restore(flags);

 	return ret;
 }
@@ -274,34 +287,48 @@ void sync_timers(void)

 int del_timer_sync(timer_t * timer)
 {
+	unsigned long flags;
 	tvec_base_t * base;
 	int ret = 0;

 	CHECK_BASE(timer->base);
 	if (!timer->base)
 		return 0;
+
+	local_irq_save(flags);
+	while (unlikely(test_and_set_bit(0, &timer->lock)))
+		while (test_bit(0, &timer->lock));
+
 	for (;;) {
-		unsigned long flags;
 		int running;
-
 repeat:
 	 	base = timer->base;
-		spin_lock_irqsave(&base->lock, flags);
+		spin_lock(&base->lock);
 		if (base != timer->base) {
-			spin_unlock_irqrestore(&base->lock, flags);
+			spin_unlock(&base->lock);
 			goto repeat;
 		}
 		ret += detach_timer(timer);
 		timer->list.next = timer->list.prev = 0;
 		running = timer_is_running(base, timer);
-		spin_unlock_irqrestore(&base->lock, flags);
+		spin_unlock(&base->lock);

 		if (!running)
 			break;
+
+		clear_bit(0, &timer->lock);
+		local_irq_restore(flags);

 		timer_synchronize(base, timer);
+
+		local_irq_save(flags);
+		while (unlikely(test_and_set_bit(0, &timer->lock)))
+			while (test_bit(0, &timer->lock));
 	}

+	clear_bit(0, &timer->lock);
+	local_irq_restore(flags);
+
 	return ret;
 }
 #endif

Andrea
