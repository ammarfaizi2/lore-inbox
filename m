Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273696AbRIWXzX>; Sun, 23 Sep 2001 19:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273697AbRIWXzO>; Sun, 23 Sep 2001 19:55:14 -0400
Received: from CPE-61-9-148-170.vic.bigpond.net.au ([61.9.148.170]:2569 "EHLO
	front.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S273696AbRIWXy5>; Sun, 23 Sep 2001 19:54:57 -0400
Date: Mon, 24 Sep 2001 09:49:59 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Nikita@namesys.com, akpm@zip.com.au, george@mvista.com, andrea@suse.de,
        rml@tech9.net, Dieter.Nuetzel@hamburg.de, mason@suse.com,
        kuib-kl@ljbc.wa.edu.au, linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: [reiserfs-list] Re: [PATCH] Significant performace improvements on reiserfs systems
Message-Id: <20010924094959.4b6725c0.rusty@rustcorp.com.au>
In-Reply-To: <E15kPGJ-0008EU-00@the-village.bc.nu>
In-Reply-To: <15275.2374.92496.536594@gargle.gargle.HOWL>
	<E15kPGJ-0008EU-00@the-village.bc.nu>
X-Mailer: Sylpheed version 0.5.3 (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Sep 2001 13:18:31 +0100 (BST)
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > In Solaris, before spinning on a busy spin-lock, thread checks whether
> > spin-lock holder runs on the same processor. If so, thread goes to sleep
> > and holder wakes it up on spin-lock release. The same, I guess is going
> 
> 
> > for interrupts that are served as separate threads. This way, one can
> > re-schedule with spin-locks held.
> 
> This is one of the things interrupt handling by threads gives you, but the
> performance cost is not nice. When you consider that ksoftirqd when it
> kicks in (currently far too often) takes up to 10% off gigabit ethernet
> performance, you can appreciate why we don't want to go that path.

I've been thinking about this: I know some people have been fiddling with making
do_softirq spin X times before kicking ksoftirqd, but how about the following?

Cheers,
Rusty.

--- linux-pmac/kernel/softirq.c	Sun Sep  9 15:11:37 2001
+++ working-pmac-ksoftirq/kernel/softirq.c	Mon Sep 24 09:44:07 2001
@@ -63,11 +63,12 @@
 	int cpu = smp_processor_id();
 	__u32 pending;
 	long flags;
-	__u32 mask;
+	long start;
 
 	if (in_interrupt())
 		return;
 
+	start = jiffies;
 	local_irq_save(flags);
 
 	pending = softirq_pending(cpu);
@@ -75,32 +76,32 @@
 	if (pending) {
 		struct softirq_action *h;
 
-		mask = ~pending;
 		local_bh_disable();
-restart:
-		/* Reset the pending bitmask before enabling irqs */
-		softirq_pending(cpu) = 0;
+		do {
+			/* Reset the pending bitmask before enabling irqs */
+			softirq_pending(cpu) = 0;
 
-		local_irq_enable();
+			local_irq_enable();
 
-		h = softirq_vec;
+			h = softirq_vec;
 
-		do {
-			if (pending & 1)
-				h->action(h);
-			h++;
-			pending >>= 1;
-		} while (pending);
-
-		local_irq_disable();
-
-		pending = softirq_pending(cpu);
-		if (pending & mask) {
-			mask &= ~pending;
-			goto restart;
-		}
+			do {
+				if (pending & 1)
+					h->action(h);
+				h++;
+				pending >>= 1;
+			} while (pending);
+
+			local_irq_disable();
+
+			pending = softirq_pending(cpu);
+
+			/* Don't spin here forever... */
+		} while (pending && start == jiffies);
 		__local_bh_enable();
 
+		/* If a timer tick went off, assume we're overloaded,
+                   and kick in ksoftirqd */
 		if (pending)
 			wakeup_softirqd(cpu);
 	}


