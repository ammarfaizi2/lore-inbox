Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266584AbSL2NMN>; Sun, 29 Dec 2002 08:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266609AbSL2NMN>; Sun, 29 Dec 2002 08:12:13 -0500
Received: from gw.lowendale.com.au ([203.26.242.120]:23832 "EHLO
	marina.lowendale.com.au") by vger.kernel.org with ESMTP
	id <S266584AbSL2NMM>; Sun, 29 Dec 2002 08:12:12 -0500
Date: Mon, 30 Dec 2002 00:15:51 +1100 (EST)
From: Neale Banks <neale@lowendale.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL 2.2] tulip.c: gracefully handle init_ertherdev failure
Message-ID: <Pine.LNX.4.05.10212300007440.5852-100000@marina.lowendale.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

Appended patch to tulip.c (against 2.2.24-rc1) gracefully handles the case
where init_etherdev() fails.  In the modular case, this would otherwise
lead to an oops at module load time and the tulip module listed as wedged
half-loaded.

This patch has, so far, only been tested as far as compiling.  IMVHO
this patch is "TRIVIAL" and its correctness appears "obvious" - so will
verification that it still loads and operates happily be sufficient
testing?

FWIW, 2.4 already handles this case gracefully.

Thanks,
Neale.

--- linux-2.2.24-rc1/drivers/net/tulip.c	Sat Nov  3 03:39:07 2001
+++ linux-2.2.24-rc1-ntb0/drivers/net/tulip.c	Sat Dec 21 18:59:35 2002
@@ -23,6 +23,9 @@
 	Updated 12/17/2000 by Jim McQuillan <jam@McQuil.com> to
 	include support for the Linksys LNE100TX card based on the
 	Admtek 985 Centaur-P chipset.
+
+	2002 Dec 21  Neale Banks <neale@lowendale.com.au>
+	Gracefully handle the case where init_etherdev() returns NULL
 */
 
 #define SMP_CHECK
@@ -694,6 +697,11 @@
 		printk(KERN_INFO "%s", version);
 
 	dev = init_etherdev(dev, 0);
+
+	if (dev == NULL) {
+		printk(KERN_ERR "tulip: Unable to allocate net_device structure!\n");
+		return NULL;
+	}
 
 	/* Make certain the data structures are quadword aligned. */
 	tp = (void *)(((long)kmalloc(sizeof(*tp), GFP_KERNEL | GFP_DMA) + 7) & ~7);

