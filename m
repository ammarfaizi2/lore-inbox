Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263176AbTKWB7u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 20:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbTKWB7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 20:59:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:2792 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263176AbTKWB7r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 20:59:47 -0500
Date: Sat, 22 Nov 2003 17:59:43 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Marco d'Itri" <md@Linux.IT>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: irq 15: nobody cared! with KT600 chipset and 2.6.0-test9
In-Reply-To: <20031122235539.GA14576@wonderland.linux.it>
Message-ID: <Pine.LNX.4.44.0311221741250.2379-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Oops.

 I read your report lazily, and didn't do it right. I just noticed that it
isn't actually irq3 and the raid controller at 0:0f.0 that is the problem
at all: the problem is the regular legacy stuff on 0:0f.1: hdc/hdd that is
on irq15.

The IRQ probe for hdc fails, for some silly reason. 
But we actually correctly _notice_ that it's on irq15, so I

Note how we say:

	kernel: hdc: IRQ probe failed (0x3cfa)

but then a few lines later we _have_ figured it out and say

	kernel: ide1 at 0x170-0x177,0x376 on irq 15

The problem _appears_ to be the fact that we already registered irq15 for 
the IDE driver, which will cause the probe to fail (you can't probe 
something that is already in use).

Can you try this patch, and see if it makes a difference? I'd also like to 
see the full "dmesg" output (regardless of whether it works or not).

		Linus

-----
===== drivers/ide/ide-probe.c 1.65 vs edited =====
--- 1.65/drivers/ide/ide-probe.c	Wed Sep  3 09:52:16 2003
+++ edited/drivers/ide/ide-probe.c	Sat Nov 22 17:59:04 2003
@@ -413,24 +413,17 @@
 		udelay(5);
 		irq = probe_irq_off(cookie);
 		if (!hwif->irq) {
-			if (irq > 0) {
-				hwif->irq = irq;
-			} else {
-				/* Mmmm.. multiple IRQs..
-				 * don't know which was ours
-				 */
-				printk("%s: IRQ probe failed (0x%lx)\n",
-					drive->name, cookie);
-#ifdef CONFIG_BLK_DEV_CMD640
-#ifdef CMD640_DUMP_REGS
-				if (hwif->chipset == ide_cmd640) {
-					printk("%s: Hmmm.. probably a driver "
-						"problem.\n", drive->name);
-					CMD640_DUMP_REGS;
-				}
-#endif /* CMD640_DUMP_REGS */
-#endif /* CONFIG_BLK_DEV_CMD640 */
+			/* Mmmm.. multiple IRQs, and we don't know
+			 * which was ours. We'd better guess.
+			 */
+			if (irq <= 0) {
+				int guess = hwif->channel ? 15 : 14;
+
+				printk("%s: IRQ probe failed (0x%lx: %d). Guessing at %d\n",
+					drive->name, cookie, irq, guess);
+				irq = guess;
 			}
+			hwif->irq = irq;
 		}
 	}
 	return retval;

