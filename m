Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263226AbTCUCr3>; Thu, 20 Mar 2003 21:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263227AbTCUCr3>; Thu, 20 Mar 2003 21:47:29 -0500
Received: from yuzuki.cinet.co.jp ([61.197.228.219]:59008 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S263226AbTCUCrZ>; Thu, 20 Mar 2003 21:47:25 -0500
Date: Fri, 21 Mar 2003 11:57:37 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2.5.65-ac1] Support PC-9800 subarchitecture (10/14) parport
Message-ID: <20030321025737.GJ1847@yuzuki.cinet.co.jp>
References: <20030321022850.GA1767@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030321022850.GA1767@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the patch to support NEC PC-9800 subarchitecture
against 2.5.65-ac1. (10/14)

Parallel port support.
 - Change IO port and IRQ assign.
 - Add probing for PC98 parport.

I make this patch simplify by limiting usage bi-directioal only.
Since lp_old98 supports output only parpose.

Regards,
Osamu Tomita

diff -Nru linux-2.5.64-ac2/drivers/parport/parport_pc.c linux98-2.5.64-ac2/drivers/parport/parport_pc.c
--- linux-2.5.64-ac2/drivers/parport/parport_pc.c	2003-03-08 08:25:20.000000000 +0900
+++ linux98-2.5.64-ac2/drivers/parport/parport_pc.c	2003-03-08 10:44:43.000000000 +0900
@@ -1892,6 +1892,9 @@
 			config & 0x80 ? "Level" : "Pulses");
 
 		configb = inb (CONFIGB (pb));
+		if (pc98 && (CONFIGB(pb) == 0x14d) && ((configb & 0x38) == 0x30))
+			configb = (configb & ~0x38) | 0x28; /* IRQ 14 */
+
 		printk (KERN_DEBUG "0x%lx: ECP port cfgA=0x%02x cfgB=0x%02x\n",
 			pb->base, config, configb);
 		printk (KERN_DEBUG "0x%lx: ECP settings irq=", pb->base);
@@ -2032,6 +2035,9 @@
 	ECR_WRITE (pb, ECR_CNF << 5); /* Configuration MODE */
 
 	intrLine = (inb (CONFIGB (pb)) >> 3) & 0x07;
+	if (pc98 && (CONFIGB(pb) == 0x14d) && (intrLine == 6))
+		intrLine = 5; /* IRQ 14 */
+
 	irq = lookup[intrLine];
 
 	ECR_WRITE (pb, oecr);
@@ -2248,7 +2254,7 @@
 			parport_ECR_present(p);
 	}
 
-	if (base != 0x3bc) {
+	if (!pc98 && base != 0x3bc) {
 		EPP_res = request_region(base+0x3, 5, fake_name);
 		if (EPP_res)
 			if (!parport_EPP_supported(p))
@@ -3022,6 +3028,26 @@
 {
 	int count = 0;
 
+	if (pc98) {
+		/* Set default settings for IEEE1284 parport */
+		int	base = 0x140;
+		int	base_hi = 0x14c;
+		int	irq = 14;
+		int	dma = PARPORT_DMA_NONE;
+
+		/* Check PC9800 old style parport */
+		outb(inb(0x149) & ~0x10, 0x149); /* disable IEEE1284 */
+		if (!(inb(0x149) & 0x10)) {  /* IEEE1284 disabled ? */
+			outb(inb(0x149) | 0x10, 0x149); /* enable IEEE1284 */
+			if (inb(0x149) & 0x10) {  /* IEEE1284 enabled ? */
+				if (parport_pc_probe_port(base, base_hi,
+							  irq, dma, NULL))
+					count++;
+			}
+		}
+
+	}
+
 	if (parport_pc_probe_port(0x3bc, 0x7bc, autoirq, autodma, NULL))
 		count++;
 	if (parport_pc_probe_port(0x378, 0x778, autoirq, autodma, NULL))
