Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267981AbTGOMcK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 08:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267557AbTGOMbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 08:31:36 -0400
Received: from mail.convergence.de ([212.84.236.4]:39840 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S267563AbTGOMGN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 08:06:13 -0400
Subject: [PATCH 16/17] Update the av7110 DVB driver
In-Reply-To: <10582716601905@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Tue, 15 Jul 2003 14:21:00 +0200
Message-Id: <10582716601185@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold (LinuxTV.org CVS maintainer) 
	<hunold@convergence.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[DVB] - fix DMX_GET_STC to get the msb right
[DVB] - follow changes in saa7146 driver core, separate some data for DVB-C and DVB-S cards
diff -uNrwB --new-file linux-2.6.0-test1.work/drivers/media/dvb/ttpci/av7110.c linux-2.6.0-test1.patch/drivers/media/dvb/ttpci/av7110.c
--- linux-2.6.0-test1.work/drivers/media/dvb/ttpci/av7110.c	2003-07-15 10:59:54.000000000 +0200
+++ linux-2.6.0-test1.patch/drivers/media/dvb/ttpci/av7110.c	2003-07-07 13:28:54.000000000 +0200
@@ -3257,7 +3258,7 @@
 	DEB_EE(("av7110: fwstc = %04hx %04hx %04hx %04hx\n",
 			fwstc[0], fwstc[1], fwstc[2], fwstc[3]));
 
-	*stc =  (((uint64_t)fwstc[2] & 1) << 32) |
+	*stc =  (((uint64_t)(~fwstc[2]) & 1) << 32) |
 		(((uint64_t)fwstc[1])     << 16) | ((uint64_t)fwstc[0]);
 	*base = 1;
 
@@ -4327,6 +4328,9 @@
 	{ 0, 0 }
 };
 
+static struct saa7146_ext_vv av7110_vv_data_st;
+static struct saa7146_ext_vv av7110_vv_data_c;
+
 static int av7110_attach (struct saa7146_dev* dev, struct saa7146_pci_extension_data *pci_ext)
 {
 	struct av7110 *av7110 = NULL;
@@ -4344,7 +4348,16 @@
 
 	DEB_EE(("dev: %p, av7110: %p\n",dev,av7110));
 
-	if (saa7146_vv_init(dev)) {
+	/* special case DVB-C: these cards have an analog tuner
+	   plus need some special handling, so we have separate
+	   saa7146_ext_vv data for these... */
+	if (dev->pci->subsystem_vendor == 0x110a) {
+		ret = saa7146_vv_init(dev, &av7110_vv_data_c);
+	} else {
+		ret = saa7146_vv_init(dev, &av7110_vv_data_st);
+	}
+	
+	if ( 0 != ret) {
 		ERR(("cannot init capture device. skipping.\n"));
 		kfree(av7110);
 		return -1;
@@ -4689,10 +4702,10 @@
 }
 
 
-static struct saa7146_ext_vv av7110_vv_data = {
+static struct saa7146_ext_vv av7110_vv_data_st = {
 	.inputs		= 1,
 	.audios 	= 1,
-	.capabilities	= V4L2_CAP_TUNER,
+	.capabilities	= 0,
 	.flags		= SAA7146_EXT_SWAP_ODD_EVEN,
 
 	.stds		= &standard[0],
@@ -4703,9 +4716,23 @@
 	.ioctl		= av7110_ioctl,
 };
 
+static struct saa7146_ext_vv av7110_vv_data_c = {
+	.inputs		= 1,
+	.audios 	= 1,
+	.capabilities	= V4L2_CAP_TUNER,
+	.flags		= 0,
+
+	.stds		= &standard[0],
+	.num_stds	= sizeof(standard)/sizeof(struct saa7146_standard),
+	.std_callback	= &std_callback, 
+
+	.ioctls		= &ioctls[0],
+	.ioctl		= av7110_ioctl,
+};
+
+
 static struct saa7146_extension av7110_extension = {
 	.name		= "dvb\0",
-	.ext_vv_data	= &av7110_vv_data,
 
 	.module		= THIS_MODULE,
 	.pci_tbl	= &pci_tbl[0],


