Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129659AbQKQCTT>; Thu, 16 Nov 2000 21:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129147AbQKQCS7>; Thu, 16 Nov 2000 21:18:59 -0500
Received: from lsne-cable-1-p21.vtxnet.ch ([212.147.5.21]:11270 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S131723AbQKQCSw>;
	Thu, 16 Nov 2000 21:18:52 -0500
Date: Fri, 17 Nov 2000 02:48:47 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: kraxel@goldbach.in-berlin.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] BTTV radio with non-modular 2.4 kernel
Message-ID: <20001117024847.A21633@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch for 2.4.0-test11-pre5 allows the use of the FM radio tuner
on BT848 cards even if the driver is not compiled as a module.

What it does: it adds the boot command line parameter bt848_radio=,
which works exactly like the radio= parameter of the bttv module.

Note: on my system, gtuner does not tune if invoked immediately after
a reboot, so I have to invoke and terminate xawtv first. This problem
appears to be unrelated to this patch, but I though I'd mention it
anyway.

- Werner

---------------------------------- cut here -----------------------------------

--- linux.orig/Documentation/kernel-parameters.txt	Tue Sep  5 22:51:14 2000
+++ linux/Documentation/kernel-parameters.txt	Fri Nov 17 02:21:10 2000
@@ -43,6 +43,7 @@
 	SERIAL	Serial support is enabled.
 	SMP 	The kernel is an SMP kernel.
 	SOUND	Appropriate sound system support is enabled.
+	V4L	Video For Linux support is enabled.
 	VGA 	The VGA console has been enabled.
 	VT	Virtual terminal support is enabled.
 	XT	IBM PC/XT MFM hard disk support is enabled.
@@ -115,6 +116,13 @@
 			Duplex Mode.
 
 	bmouse=		[HW,MOUSE,PS2] Bus mouse.
+
+	bt848_radio=	[HW,V4L] Enables the FM radio tuners of BT848 cards.
+			This parameter corresponds to the radio= module
+			parameter if the driver is compiled as such, e.g.
+			bt848_radio=1 enables the radio of the first card,
+			bt848_radio=0,1 enables the radio of the second card,
+			etc.
 
 	BusLogic=	[HW,SCSI]
 
--- linux.orig/drivers/media/video/bttv-driver.c	Thu Nov 16 23:30:02 2000
+++ linux/drivers/media/video/bttv-driver.c	Fri Nov 17 02:22:13 2000
@@ -3100,6 +3100,18 @@
 module_init(bttv_init_module);
 module_exit(bttv_cleanup_module);
 
+#ifndef MODULE
+
+static int __init enable_radio(char *str)
+{
+	(void) get_options(str,BTTV_MAX,radio);
+        return 1;
+}
+
+__setup("bt848_radio=", enable_radio);
+
+#endif /* not MODULE */
+
 /*
  * Local variables:
  * c-basic-offset: 8

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
