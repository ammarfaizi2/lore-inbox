Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273424AbRI3MlA>; Sun, 30 Sep 2001 08:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273385AbRI3Mkv>; Sun, 30 Sep 2001 08:40:51 -0400
Received: from juicer39.bigpond.com ([139.134.6.96]:7116 "EHLO
	mailin8.bigpond.com") by vger.kernel.org with ESMTP
	id <S273372AbRI3Mkj>; Sun, 30 Sep 2001 08:40:39 -0400
Date: Sat, 29 Sep 2001 21:03:06 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: kuznet@ms2.inr.ac.ru
Cc: mingo@elte.hu, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk, bcrl@redhat.com, andrea@suse.de
Subject: Re: [patch] softirq performance fixes, cleanups, 2.4.10.
Message-Id: <20010929210306.7904954e.rusty@rustcorp.com.au>
In-Reply-To: <200109281618.UAA04122@ms2.inr.ac.ru>
In-Reply-To: <Pine.LNX.4.33.0109261729570.5644-200000@localhost.localdomain>
	<200109281618.UAA04122@ms2.inr.ac.ru>
X-Mailer: Sylpheed version 0.5.3 (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Sep 2001 20:18:20 +0400 (MSK DST)
kuznet@ms2.inr.ac.ru wrote:

> Also, you did not assure me that you interpret problem correctly.
> netif_rx() is __insensitive__ to latencies due to blocked softirq
restarts.
> It stops spinning only when it becomes true cpu hog. And scheduling
ksoftirqd
> is the only variant here.

Hi Ingo at al,

Attached is the approach I sent to l-k earlier this week: if a timer tick
goes off, back off to ksoftirqd.

This should, statistically, do the right thing, even in the case of smart
softirqs like netif_rx.

Please consider,
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


