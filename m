Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315491AbSIPHVG>; Mon, 16 Sep 2002 03:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315540AbSIPHVF>; Mon, 16 Sep 2002 03:21:05 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:43490 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S315491AbSIPHVE>;
	Mon, 16 Sep 2002 03:21:04 -0400
Date: Mon, 16 Sep 2002 09:25:41 +0200
From: Jens Axboe <axboe@suse.de>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH?] 2.5.34-bk: ide interfaces sharing same irq broken...
Message-ID: <20020916072541.GY935@suse.de>
References: <20020915213733.GA13938@ppc.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020915213733.GA13938@ppc.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 15 2002, Petr Vandrovec wrote:
> Hi Jens,
>   can you look at attached patch? Without this patch my machine dies while
> probing IDE with endless stream of 'unexpected irq'.
> 
>   Problem is both primary and secondary channels of my PDC20265 use irq 10. 
> When we probe first interface, everything is fine, as irq 10 is disabled, 
> and so irq assertion is silently ignored (but it would die if I'll start 
> using USB which also wants irq 10...). But when secondary channel was 
> probed, irq 10 was asserted, and things went really wrong... So I made 
> disable_irq() unconditional: I see no reason why it should depend on 
> ack_intr. Any code which will cause IRQ assertion, and does not install 
> either IRQ handler, or which does not disable that IRQ, is buggy.
> 
>   Another problem I noticed is that actual probe code in probe_hwif between
> disable_irq() and enable_irq() could change hwif->irq, and so we could
> enable irq we did not disable (it happened to me after I removed ack_intr
> test: irq is 0 on entry when probing onboard VIA, but on exit it is 14... 
> so we enabled irq 14 source without previously disabling it, and it caused 
> bad things to happen).
> 
>   This patch makes disabling IRQ during probe unconditional, and makes sure
> that we enable same irq we disabled.
> 
>   Of course that moving init_irq call before probe would be nicer, and
> it would solve also pending edge-triggered IRQ, but unfortunately as
> code is currently written, we do not know IRQ until after probe, and
> at this point we already asserted IRQ, even on PCI devices which can
> share IRQ with someone else.
> 
>   After this patch, and after commenting out "ide_intr: unexpected interrupt"
> printk in ide.c:ide_intr system works finally fine.

Thanks Petr, very good spotting! I'll pass it along with the unexpected
intr removal, that it seems Linus lost (it was sent). Ed, could you see
if this solves your problem as well?

--- /opt/kernel/linux-2.5.35/drivers/ide/ide.c	2002-09-16 04:18:25.000000000 +0200
+++ drivers/ide/ide.c	2002-09-16 08:59:28.000000000 +0200
@@ -1376,7 +1376,6 @@
 
 	if ((handler = hwgroup->handler) == NULL ||
 	    hwgroup->poll_timeout != 0) {
-		printk("ide_intr: unexpected interrupt!\n");
 		/*
 		 * Not expecting an interrupt from this drive.
 		 * That means this could be:
--- /opt/kernel/linux-2.5.35/drivers/ide/ide-probe.c	2002-09-16 04:18:30.000000000 +0200
+++ drivers/ide/ide-probe.c	2002-09-16 09:03:27.000000000 +0200
@@ -592,6 +592,7 @@
 {
 	unsigned int unit;
 	unsigned long flags;
+	unsigned int irqd;
 
 	if (hwif->noprobe)
 		return;
@@ -623,7 +624,12 @@
 		return;	
 	}
 
-	if (hwif->hw.ack_intr && hwif->irq)
+	/*
+	 * We must always disable IRQ, as probe_for_drive will assert IRQ, but
+	 * we'll install our IRQ driver much later...
+	 */
+	irqd = hwif->irq;
+	if (irqd)
 		disable_irq(hwif->irq);
 
 	local_irq_set(flags);
@@ -659,8 +665,12 @@
 
 	}
 	local_irq_restore(flags);
-	if (hwif->hw.ack_intr && hwif->irq)
-		enable_irq(hwif->irq);
+	/*
+	 * Use cached IRQ number. It might be (and is...) changed by probe
+	 * code above
+	 */
+	if (irqd)
+		enable_irq(irqd);
 
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		ide_drive_t *drive = &hwif->drives[unit];

-- 
Jens Axboe

