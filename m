Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267227AbTBQOKn>; Mon, 17 Feb 2003 09:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267174AbTBQOJw>; Mon, 17 Feb 2003 09:09:52 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:28800 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S267187AbTBQOIO>; Mon, 17 Feb 2003 09:08:14 -0500
Date: Mon, 17 Feb 2003 23:16:46 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCHSET] PC-9800 subarch. support for 2.5.61 (17/26) parport
Message-ID: <20030217141646.GQ4799@yuzuki.cinet.co.jp>
References: <20030217134333.GA4734@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030217134333.GA4734@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patchset to support NEC PC-9800 subarchitecture
against 2.5.61 (17/26).

Parallel port support.

diff -Nru linux/drivers/parport/parport_pc.c linux98/drivers/parport/parport_pc.c
--- linux/drivers/parport/parport_pc.c	2002-12-16 11:08:22.000000000 +0900
+++ linux98/drivers/parport/parport_pc.c	2002-12-22 20:51:23.000000000 +0900
@@ -332,7 +332,10 @@
 
 unsigned char parport_pc_read_status(struct parport *p)
 {
-	return inb (STATUS (p));
+	if (pc98 && p->base == 0x40)
+		return ((inb(0x42) & 0x04) << 5) | PARPORT_STATUS_ERROR;
+	else
+		return inb (STATUS (p));
 }
 
 void parport_pc_disable_irq(struct parport *p)
@@ -1644,6 +1647,8 @@
 {
 	unsigned char r, w;
 
+	if (pc98 && pb->base == 0x40)
+		return PARPORT_MODE_PCSPP;
 	/*
 	 * first clear an eventually pending EPP timeout 
 	 * I (sailer@ife.ee.ethz.ch) have an SMSC chipset
@@ -1777,6 +1782,9 @@
 {
 	int ok = 0;
   
+	if (pc98 && pb->base == 0x40)
+		return 0;  /* never support */
+
 	clear_epp_timeout(pb);
 
 	/* try to tri-state the buffer */
@@ -1908,6 +1916,9 @@
 			config & 0x80 ? "Level" : "Pulses");
 
 		configb = inb (CONFIGB (pb));
+		if (pc98 && (CONFIGB(pb) == 0x14d) && ((configb & 0x38) == 0x30))
+			configb = (configb & ~0x38) | 0x28; /* IRQ 14 */
+
 		printk (KERN_DEBUG "0x%lx: ECP port cfgA=0x%02x cfgB=0x%02x\n",
 			pb->base, config, configb);
 		printk (KERN_DEBUG "0x%lx: ECP settings irq=", pb->base);
@@ -2048,6 +2059,9 @@
 	ECR_WRITE (pb, ECR_CNF << 5); /* Configuration MODE */
 
 	intrLine = (inb (CONFIGB (pb)) >> 3) & 0x07;
+	if (pc98 && (CONFIGB(pb) == 0x14d) && (intrLine == 6))
+		intrLine = 5; /* IRQ 14 */
+
 	irq = lookup[intrLine];
 
 	ECR_WRITE (pb, oecr);
@@ -2212,7 +2226,14 @@
 	struct parport tmp;
 	struct parport *p = &tmp;
 	int probedirq = PARPORT_IRQ_NONE;
-	if (check_region(base, 3)) return NULL;
+	if (pc98 && base == 0x40) {
+		int i;
+		for (i = 0; i < 8; i += 2)
+			if (check_region(base + i, 1)) return NULL;
+	} else {
+		if (check_region(base, 3)) return NULL;
+	}
+
 	priv = kmalloc (sizeof (struct parport_pc_private), GFP_KERNEL);
 	if (!priv) {
 		printk (KERN_DEBUG "parport (0x%lx): no memory!\n", base);
@@ -2245,7 +2266,7 @@
 	if (base_hi && !check_region(base_hi,3))
 		parport_ECR_present(p);
 
-	if (base != 0x3bc) {
+	if (!pc98 && base != 0x3bc) {
 		if (!check_region(base+0x3, 5)) {
 			if (!parport_EPP_supported(p))
 				parport_ECPEPP_supported(p);
@@ -2343,7 +2364,12 @@
 		printk(KERN_INFO "%s: irq %d detected\n", p->name, probedirq);
 	parport_proc_register(p);
 
-	request_region (p->base, 3, p->name);
+	if (pc98 && p->base == 0x40) {
+		int i;
+		for (i = 0; i < 8; i += 2)
+			request_region(p->base + i, 1, p->name);
+	} else
+		request_region (p->base, 3, p->name);
 	if (p->size > 3)
 		request_region (p->base + 3, p->size - 3, p->name);
 	if (p->modes & PARPORT_MODE_ECP)
@@ -2413,7 +2439,13 @@
 		free_dma(p->dma);
 	if (p->irq != PARPORT_IRQ_NONE)
 		free_irq(p->irq, p);
-	release_region(p->base, 3);
+	if (pc98 && p->base == 0x40) {
+		int i;
+		for (i = 0; i < 8; i += 2)
+			release_region(p->base + i, 1);
+	} else
+		release_region(p->base, 3);
+
 	if (p->size > 3)
 		release_region(p->base + 3, p->size - 3);
 	if (p->modes & PARPORT_MODE_ECP)
@@ -2996,6 +3028,30 @@
 {
 	int count = 0;
 
+	if (pc98) {
+		/* Set default resource settings for old style parport */
+		int	base = 0x40;
+		int	base_hi = 0;
+		int	irq = PARPORT_IRQ_NONE;
+		int	dma = PARPORT_DMA_NONE;
+
+		/* Check PC9800 old style parport */
+		outb(inb(0x149) & ~0x10, 0x149); /* disable IEEE1284 */
+		if (!(inb(0x149) & 0x10)) {  /* IEEE1284 disabled ? */
+			outb(inb(0x149) | 0x10, 0x149); /* enable IEEE1284 */
+			if (inb(0x149) & 0x10) {  /* IEEE1284 enabled ? */
+				/* Set default settings for IEEE1284 parport */
+				base = 0x140;
+				base_hi = 0x14c;
+				irq = 14;
+				/* dma = PARPORT_DMA_NONE; */
+			}
+		}
+
+		if (parport_pc_probe_port(base, base_hi, irq, dma, NULL))
+			count++;
+	}
+
 	if (parport_pc_probe_port(0x3bc, 0x7bc, autoirq, autodma, NULL))
 		count++;
 	if (parport_pc_probe_port(0x378, 0x778, autoirq, autodma, NULL))
diff -Nru linux/include/linux/parport_pc.h linux98/include/linux/parport_pc.h
--- linux/include/linux/parport_pc.h	2002-06-12 11:15:27.000000000 +0900
+++ linux98/include/linux/parport_pc.h	2002-08-19 14:13:09.000000000 +0900
@@ -119,6 +119,11 @@
 #endif
 	ctr = (ctr & ~mask) ^ val;
 	ctr &= priv->ctr_writable; /* only write writable bits. */
+#ifdef CONFIG_X86_PC9800
+	if (p->base == 0x40 && ((priv->ctr) ^ ctr) & 0x01)
+		outb(0x0e | ((ctr & 0x01) ^ 0x01), 0x46);
+	else
+#endif /* CONFIG_X86_PC9800 */
 	outb (ctr, CONTROL (p));
 	priv->ctr = ctr;	/* Update soft copy */
 	return ctr;
@@ -191,6 +196,11 @@
 
 extern __inline__ unsigned char parport_pc_read_status(struct parport *p)
 {
+#ifdef CONFIG_X86_PC9800
+	if (p->base == 0x40)
+		return ((inb(0x42) & 0x04) << 5) | PARPORT_STATUS_ERROR;
+	else
+#endif /* CONFIG_X86_PC9800 */
 	return inb(STATUS(p));
 }
 
