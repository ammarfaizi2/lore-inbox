Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283284AbRK2UGq>; Thu, 29 Nov 2001 15:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282910AbRK2UGg>; Thu, 29 Nov 2001 15:06:36 -0500
Received: from dandelion.com ([198.186.200.2]:50450 "EHLO dandelion.com")
	by vger.kernel.org with ESMTP id <S282623AbRK2UGZ>;
	Thu, 29 Nov 2001 15:06:25 -0500
Date: Thu, 29 Nov 2001 12:06:23 -0800
Message-Id: <200111292006.fATK6NMF021272@dandelion.com>
From: "Leonard N. Zubkoff" <lnz@dandelion.com>
To: pascal.lengard@wanadoo.fr
CC: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0111291939310.17742-100000@h2o.chezmoi.fr>
	(message from Pascal Lengard on Thu, 29 Nov 2001 19:42:01 +0100 (CET))
Subject: Re: dac960 broken ?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Date: Thu, 29 Nov 2001 19:42:01 +0100 (CET)
  From: Pascal Lengard <pascal.lengard@wanadoo.fr>

  On Wed, 28 Nov 2001, Leonard N. Zubkoff wrote:

  > Hmmm.  Nothing you've described makes any sense to me as I don't believe
  > the driver has changed in a way that would break the basic detection of the
  > boards.  When you say that the card is not detected, precisely what do you
  > mean?  Does the driver report anything at all?

  OK, I did not write down the messages, but while testing, with DAC960
  compiled as module, It did load and initialise but said "no such peripheral"
  or something equivalent once (I know it's not precise enough ...).

  I ran some tests to record precise messages today:

  Here are the messages from the kernel 2.4.9-13 shipped by redhat:
  -----------------------------------------------------------------
	  Loading scsi_mod module
	  Loading DAC960 module
	  /lib/DAC960.o: init_module: Operation not permitted
	  Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters
	  ERROR /bin/insmod exited abnormally!
	  Loading jbd module
	  Journalled Block Device driver loaded
	  Loading ext3 module
	  Mounting /proc filesystem
	  Creaing root device
	  Mounting root filesystem
	  mount: error 19 mounting ext3
	  pivotroot: pivot_root(/sysroot,/sysroot/initrd) failed: 2
	  Freeing unused kernel memory: 216k freed
	  Kernel panic: No init found. Try passing init= option to kernel


Hmmm.  Can you check if the following patch is present in the Linux kernel
you're using:

--- linux/init/main.c-	Sat Oct  6 08:49:16 2001
+++ linux/init/main.c	Wed Oct 10 09:06:07 2001
@@ -221,6 +221,24 @@
 	{ "dasdg", (DASD_MAJOR << MINORBITS) + (6 << 2) },
 	{ "dasdh", (DASD_MAJOR << MINORBITS) + (7 << 2) },
 #endif
+#if defined(CONFIG_BLK_DEV_DAC960) || defined(CONFIG_BLK_DEV_DAC960_MODULE)
+	{ "rd/c0d0p",0x3000 },
+	{ "rd/c0d1p",0x3008 },
+	{ "rd/c0d2p",0x3010 },
+	{ "rd/c0d3p",0x3018 },
+	{ "rd/c0d4p",0x3020 },
+	{ "rd/c0d5p",0x3028 },
+	{ "rd/c0d6p",0x3030 },
+	{ "rd/c0d7p",0x3038 },
+	{ "rd/c0d8p",0x3040 },
+	{ "rd/c0d9p",0x3048 },
+	{ "rd/c0d10p",0x3050 },
+	{ "rd/c0d11p",0x3058 },
+	{ "rd/c0d12p",0x3060 },
+	{ "rd/c0d13p",0x3068 },
+	{ "rd/c0d14p",0x3070 },
+	{ "rd/c0d15p",0x3078 },
+#endif
 #if defined(CONFIG_BLK_CPQ_DA) || defined(CONFIG_BLK_CPQ_DA_MODULE)
 	{ "ida/c0d0p",0x4800 },
 	{ "ida/c0d1p",0x4810 },

Without this patch, which Linux has repeatedly refused to include in the
standard sources, it is entirely possible that the root= processing won't work
correctly.

		Leonard
