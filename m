Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262002AbUBWVLr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 16:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261983AbUBWVIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 16:08:23 -0500
Received: from mail.convergence.de ([212.84.236.4]:49130 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S262036AbUBWVFA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 16:05:00 -0500
To: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       hunold@linuxtv.org
From: Michael Hunold <hunold@linuxtv.org>
Subject: [PATCH 8/9] av7110 DVB driver update
In-Reply-To: <10775702843054@convergence.de>
Message-Id: <10775702853317@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring_mihu_extended
Date: Mon, 23 Feb 2004 16:05:00 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- [DVB] av7110: check result of saa7146_wait_for_debi_done() in av7110_bootarm() and bail out early if booting the ARM failed
- [DVB] av7110: correct voffset for analog standard
- [DVB] av7110: replace usage of sleep_on_interruptible_timeout() with wait_event_interruptible_timeout()
diff -uNrwB --new-file xx-linux-2.6.3/drivers/media/dvb/ttpci/av7110.c linux-2.6.3.p/drivers/media/dvb/ttpci/av7110.c
--- xx-linux-2.6.3/drivers/media/dvb/ttpci/av7110.c	2004-02-23 12:34:27.000000000 +0100
+++ linux-2.6.3.p/drivers/media/dvb/ttpci/av7110.c	2004-02-23 12:52:31.000000000 +0100
@@ -105,6 +108,7 @@
 static int arm_thread(void *data)
 {
 	struct av7110 *av7110 = data;
+	unsigned long timeout;
         u16 newloops = 0;
 
 	DEB_EE(("av7110: %p\n",av7110));
@@ -112,8 +116,12 @@
 	dvb_kernel_thread_setup ("arm_mon");
 	av7110->arm_thread = current;
 
-	while (!av7110->arm_rmmod && !signal_pending(current)) {
-                interruptible_sleep_on_timeout(&av7110->arm_wait, 5*HZ);
+	while (1) {
+		timeout = wait_event_interruptible_timeout(av7110->arm_wait,0 != av7110->arm_rmmod, 5*HZ);
+		if (-ERESTARTSYS == timeout || 0 != av7110->arm_rmmod) {
+			/* got signal or told to quit*/
+			break;
+		}
 
                 if (!av7110->arm_ready)
                         continue;
@@ -1283,7 +1290,7 @@
 		return -EINVAL;
 	}
 	if( crc != crc32_le(0,ptr,len)) {
-		printk("dvb-ttpci: crc32 of dpram file does not match.\n");
+		printk("dvb-ttpci: crc32 of root file does not match.\n");
 		return -EINVAL;
 	}
 	av7110->bin_root = ptr;
@@ -1426,7 +1433,10 @@
 
         /* load firmware into AV7110 cards */
 	av7110_bootarm(av7110);
-	av7110_firmversion(av7110);
+	if (av7110_firmversion(av7110)) {
+		ret = -EIO;
+		goto err2;
+	}
 
 	if (FW_VERSION(av7110->arm_app)<0x2501)
 		printk ("av7110: Warning, firmware version 0x%04x is too old. "
@@ -1497,6 +1507,9 @@
 	av7110_num++;
         return 0;
 
+err2:
+	av7110_ca_exit(av7110);
+	av7110_av_exit(av7110);
 err:
 	if (NULL != av7110 ) {
 		kfree(av7110);
diff -uNrwB --new-file xx-linux-2.6.3/drivers/media/dvb/ttpci/av7110_hw.c linux-2.6.3.p/drivers/media/dvb/ttpci/av7110_hw.c
--- xx-linux-2.6.3/drivers/media/dvb/ttpci/av7110_hw.c	2004-02-23 12:34:27.000000000 +0100
+++ linux-2.6.3.p/drivers/media/dvb/ttpci/av7110_hw.c	2004-02-23 12:52:31.000000000 +0100
@@ -249,7 +249,11 @@
 	mwdebi(av7110, DEBISWAB, DPRAM_BASE, bootcode, sizeof(bootcode));
 	iwdebi(av7110, DEBINOSWAP, BOOT_STATE, BOOTSTATE_BUFFER_FULL, 2);
 
-	saa7146_wait_for_debi_done(av7110->dev);
+	if (saa7146_wait_for_debi_done(av7110->dev)) {
+		printk(KERN_ERR "dvb: av7110_bootarm(): "
+		       "saa7146_wait_for_debi_done() timed out\n");
+		return -1;
+	}
 	saa7146_setgpio(dev, RESET_LINE, SAA7146_GPIO_OUTHI);
 	//FIXME: necessary?
 	set_current_state(TASK_INTERRUPTIBLE);
@@ -265,7 +269,11 @@
 	DEB_D(("av7110_bootarm: load dpram code\n"));
 	mwdebi(av7110, DEBISWAB, DPRAM_BASE, av7110->bin_dpram, av7110->size_dpram);
 
-	saa7146_wait_for_debi_done(av7110->dev);
+	if (saa7146_wait_for_debi_done(av7110->dev)) {
+		printk(KERN_ERR "dvb: av7110_bootarm(): "
+		       "saa7146_wait_for_debi_done() timed out after loading DRAM\n");
+		return -1;
+	}
 	saa7146_setgpio(dev, RESET_LINE, SAA7146_GPIO_OUTHI);
 	//FIXME: necessary?
 	mdelay(800);
@@ -515,14 +523,18 @@
  ****************************************************************************/
 
 /* get version of the firmware ROM, RTSL, video ucode and ARM application  */
-void av7110_firmversion(struct av7110 *av7110)
+int av7110_firmversion(struct av7110 *av7110)
 {
 	u16 buf[20];
 	u16 tag = ((COMTYPE_REQUEST << 8) + ReqVersion);
 
 	DEB_EE(("av7110: %p\n", av7110));
 
-	av7110_fw_query(av7110, tag, buf, 16);
+	if (av7110_fw_query(av7110, tag, buf, 16)) {
+		printk("DVB: AV7110-%d: ERROR: Failed to boot firmware\n",
+		       av7110->dvb_adapter->num);
+		return -EIO;
+	}
 
 	av7110->arm_fw = (buf[0] << 16) + buf[1];
 	av7110->arm_rtsl = (buf[2] << 16) + buf[3];
@@ -542,7 +554,7 @@
 		printk("DVB: AV711%d(%d) - no firmware support for CI link layer interface\n",
 		       av7110->avtype, av7110->dvb_adapter->num);
 
-	return;
+	return 0;
 }
 
 
diff -uNrwB --new-file xx-linux-2.6.3/drivers/media/dvb/ttpci/av7110_hw.h linux-2.6.3.p/drivers/media/dvb/ttpci/av7110_hw.h
--- xx-linux-2.6.3/drivers/media/dvb/ttpci/av7110_hw.h	2004-02-23 12:34:27.000000000 +0100
+++ linux-2.6.3.p/drivers/media/dvb/ttpci/av7110_hw.h	2004-02-23 12:52:31.000000000 +0100
@@ -362,7 +362,7 @@
 
 extern void av7110_reset_arm(struct av7110 *av7110);
 extern int av7110_bootarm(struct av7110 *av7110);
-extern void av7110_firmversion(struct av7110 *av7110);
+extern int av7110_firmversion(struct av7110 *av7110);
 #define FW_CI_LL_SUPPORT(arm_app) ((arm_app) & 0x80000000)
 #define FW_VERSION(arm_app)	  ((arm_app) & 0x0000FFFF)
 
diff -uNrwB --new-file xx-linux-2.6.3/drivers/media/dvb/ttpci/av7110_v4l.c linux-2.6.3.p/drivers/media/dvb/ttpci/av7110_v4l.c
--- xx-linux-2.6.3/drivers/media/dvb/ttpci/av7110_v4l.c	2004-02-23 12:34:27.000000000 +0100
+++ linux-2.6.3.p/drivers/media/dvb/ttpci/av7110_v4l.c	2004-02-23 12:52:31.000000000 +0100
@@ -191,11 +191,11 @@
 
 	if (0 != av7110->current_input) {
 		adswitch = 1;
-		band = 0x68; /* analog band */
+		band = 0x60; /* analog band */
 		source = SAA7146_HPS_SOURCE_PORT_B;
 		sync = SAA7146_HPS_SYNC_PORT_B;
 		memcpy(standard, analog_standard, sizeof(struct saa7146_standard) * 2);
-		DEB_S(("av7110: switching to analog TV\n"));
+		DEB_S(("av7110: switching to analog TV\n"));
 		msp_writereg(av7110, MSP_WR_DSP, 0x0008, 0x0000); // loudspeaker source
 		msp_writereg(av7110, MSP_WR_DSP, 0x0009, 0x0000); // headphone source
 		msp_writereg(av7110, MSP_WR_DSP, 0x000a, 0x0000); // SCART 1 source
@@ -204,11 +204,11 @@
 		msp_writereg(av7110, MSP_WR_DSP, 0x0007, 0x4f00); // SCART 1 volume
 	} else {
 		adswitch = 0;
-		band = 0x28; /* digital band */
+		band = 0x20; /* digital band */
 		source = SAA7146_HPS_SOURCE_PORT_A;
 		sync = SAA7146_HPS_SYNC_PORT_A;
 		memcpy(standard, dvb_standard, sizeof(struct saa7146_standard) * 2);
-		DEB_S(("av7110: switching DVB mode\n"));
+		DEB_S(("av7110: switching DVB mode\n"));
 		msp_writereg(av7110, MSP_WR_DSP, 0x0008, 0x0220); // loudspeaker source
 		msp_writereg(av7110, MSP_WR_DSP, 0x0009, 0x0220); // headphone source
 		msp_writereg(av7110, MSP_WR_DSP, 0x000a, 0x0220); // SCART 1 source
@@ -638,7 +638,7 @@
 static struct saa7146_standard analog_standard[] = {
 	{
 		.name	= "PAL",	.id		= V4L2_STD_PAL_BG,
-		.v_offset	= 0x18 /* 0 */ ,	.v_field	= 288,		.v_calc	= 576,
+		.v_offset	= 0x1b,	.v_field	= 288,		.v_calc	= 576,
 		.h_offset	= 0x08,	.h_pixels	= 708,		.h_calc	= 709,
 		.v_max_out	= 576,	.h_max_out	= 768,
 	}, {


