Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318266AbSIOVl7>; Sun, 15 Sep 2002 17:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318268AbSIOVl6>; Sun, 15 Sep 2002 17:41:58 -0400
Received: from p0254.as-l042.contactel.cz ([194.108.237.254]:4224 "EHLO
	ppc.vc.cvut.cz") by vger.kernel.org with ESMTP id <S318266AbSIOVl5>;
	Sun, 15 Sep 2002 17:41:57 -0400
Date: Sun, 15 Sep 2002 23:37:33 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: axboe@suse.de
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH?] 2.5.34-bk: ide interfaces sharing same irq broken...
Message-ID: <20020915213733.GA13938@ppc.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,
  can you look at attached patch? Without this patch my machine dies while
probing IDE with endless stream of 'unexpected irq'.

  Problem is both primary and secondary channels of my PDC20265 use irq 10. 
When we probe first interface, everything is fine, as irq 10 is disabled, 
and so irq assertion is silently ignored (but it would die if I'll start 
using USB which also wants irq 10...). But when secondary channel was 
probed, irq 10 was asserted, and things went really wrong... So I made 
disable_irq() unconditional: I see no reason why it should depend on 
ack_intr. Any code which will cause IRQ assertion, and does not install 
either IRQ handler, or which does not disable that IRQ, is buggy.

  Another problem I noticed is that actual probe code in probe_hwif between
disable_irq() and enable_irq() could change hwif->irq, and so we could
enable irq we did not disable (it happened to me after I removed ack_intr
test: irq is 0 on entry when probing onboard VIA, but on exit it is 14... 
so we enabled irq 14 source without previously disabling it, and it caused 
bad things to happen).

  This patch makes disabling IRQ during probe unconditional, and makes sure
that we enable same irq we disabled.

  Of course that moving init_irq call before probe would be nicer, and
it would solve also pending edge-triggered IRQ, but unfortunately as
code is currently written, we do not know IRQ until after probe, and
at this point we already asserted IRQ, even on PCI devices which can
share IRQ with someone else.

  After this patch, and after commenting out "ide_intr: unexpected interrupt"
printk in ide.c:ide_intr system works finally fine.
						Thanks,
							Petr Vandrovec
							vandrove@vc.cvut.cz

P.S.: I set 'Cc' list to my best knowledge. If you feel that you
are missing (Andre & Alan, I believe that you both work on 2.4 only),
add yourself to the "IDE DRIVER [GENERAL]" entry in MAINTAINERS. There
is still Martin listed there.

diff -urdN linux/drivers/ide/ide-probe.c linux/drivers/ide/ide-probe.c
--- linux/drivers/ide/ide-probe.c	2002-09-15 20:31:55.000000000 +0200
+++ linux/drivers/ide/ide-probe.c	2002-09-15 22:55:41.000000000 +0200
@@ -592,6 +592,7 @@
 {
 	unsigned int unit;
 	unsigned long flags;
+	unsigned int irqd;
 
 	if (hwif->noprobe)
 		return;
@@ -623,8 +624,14 @@
 		return;	
 	}
 
-	if (hwif->hw.ack_intr && hwif->irq)
+	/* We must always disable IRQ, as probe_for_drive will assert IRQ, but
+	   we'll install our IRQ driver much later... */
+	if ((1 || hwif->hw.ack_intr) && hwif->irq) {
 		disable_irq(hwif->irq);
+		irqd = hwif->irq;
+	} else {
+		irqd = 0;	/* Use 0... IDE does not support using irq=0 at all... */
+	}
 
 	local_irq_set(flags);
 	/*
@@ -659,8 +666,9 @@
 
 	}
 	local_irq_restore(flags);
-	if (hwif->hw.ack_intr && hwif->irq)
-		enable_irq(hwif->irq);
+	/* Use cached IRQ number. It might be (and is...) changed by probe code above */
+	if (irqd)
+		enable_irq(irqd);
 
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		ide_drive_t *drive = &hwif->drives[unit];
