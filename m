Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130797AbRCFAZx>; Mon, 5 Mar 2001 19:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130799AbRCFAZo>; Mon, 5 Mar 2001 19:25:44 -0500
Received: from [199.183.24.200] ([199.183.24.200]:39449 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S130797AbRCFAZ3>; Mon, 5 Mar 2001 19:25:29 -0500
Date: Mon, 5 Mar 2001 19:25:24 -0500
From: Peter Zaitcev <zaitcev@redhat.com>
To: alan@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Patch to ymfpci from ALSA 0.99
Message-ID: <20010305192524.A19811@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

the patch does not fix the buzzing, but it does not hurt either.
And the way we loaded the microcode before was seriously wrong.
Please look.

-- Pete

diff -ur -X dontdiff linux-2.4.2/drivers/sound/ymfpci.c linux-2.4.2-p3/drivers/sound/ymfpci.c
--- linux-2.4.2/drivers/sound/ymfpci.c	Fri Feb 16 16:02:37 2001
+++ linux-2.4.2-p3/drivers/sound/ymfpci.c	Mon Feb 26 23:56:53 2001
@@ -2185,8 +2149,8 @@
 	ymfpci_writew(codec, YDSXGR_GLOBALCTRL, ctrl & ~0x0007);
 
 	/* setup DSP instruction code */
-	for (i = 0; i < YDSXG_DSPLENGTH; i++)
-		ymfpci_writel(codec, YDSXGR_DSPINSTRAM + i, DspInst[i >> 2]);
+	for (i = 0; i < YDSXG_DSPLENGTH / 4; i++)
+		ymfpci_writel(codec, YDSXGR_DSPINSTRAM + (i << 2), DspInst[i]);
 
 	switch (codec->pci->device) {
 	case PCI_DEVICE_ID_YAMAHA_724F:
@@ -2201,11 +2165,11 @@
 
 	if (ver_1e) {
 		/* setup control instruction code */
-		for (i = 0; i < YDSXG_CTRLLENGTH; i++)
-			ymfpci_writel(codec, YDSXGR_CTRLINSTRAM + i, CntrlInst1E[i >> 2]);
+		for (i = 0; i < YDSXG_CTRLLENGTH / 4; i++)
+			ymfpci_writel(codec, YDSXGR_CTRLINSTRAM + (i << 2), CntrlInst1E[i]);
 	} else {
-		for (i = 0; i < YDSXG_CTRLLENGTH; i++)
-			ymfpci_writel(codec, YDSXGR_CTRLINSTRAM + i, CntrlInst[i >> 2]);
+		for (i = 0; i < YDSXG_CTRLLENGTH / 4; i++)
+			ymfpci_writel(codec, YDSXGR_CTRLINSTRAM + (i << 2), CntrlInst[i]);
 	}
 
 	ymfpci_enable_dsp(codec);
diff -ur -X dontdiff linux-2.4.2/drivers/sound/ymfpci_image.h linux-2.4.2-p3/drivers/sound/ymfpci_image.h
--- linux-2.4.2/drivers/sound/ymfpci_image.h	Sun Dec  3 23:58:10 2000
+++ linux-2.4.2-p3/drivers/sound/ymfpci_image.h	Mon Feb 26 23:44:52 2001
@@ -1,7 +1,7 @@
 #ifndef _HWMCODE_
 #define _HWMCODE_
 
-static unsigned long int	DspInst[] = {
+static unsigned long DspInst[YDSXG_DSPLENGTH / 4] = {
 	0x00000081, 0x000001a4, 0x0000000a, 0x0000002f,
 	0x00080253, 0x01800317, 0x0000407b, 0x0000843f,
 	0x0001483c, 0x0001943c, 0x0005d83c, 0x00001c3c,
@@ -12,7 +12,7 @@
 	0x00000000, 0x00000000, 0x00000000, 0x00000000
 };
 
-static unsigned long int	CntrlInst[] = {
+static unsigned long CntrlInst[YDSXG_CTRLLENGTH / 4] = {
 	0x000007, 0x240007, 0x0C0007, 0x1C0007,
 	0x060007, 0x700002, 0x000020, 0x030040,
 	0x007104, 0x004286, 0x030040, 0x000F0D,
@@ -791,7 +791,7 @@
 // 04/09  creat
 // 04/12  stop nise fix
 // 06/21  WorkingOff timming
-static unsigned long int	CntrlInst1E[] = {
+static unsigned long CntrlInst1E[YDSXG_CTRLLENGTH / 4] = {
 	0x000007, 0x240007, 0x0C0007, 0x1C0007,
 	0x060007, 0x700002, 0x000020, 0x030040,
 	0x007104, 0x004286, 0x030040, 0x000F0D,
