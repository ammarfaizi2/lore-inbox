Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263817AbUDZNyC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263817AbUDZNyC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 09:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263804AbUDZNyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 09:54:02 -0400
Received: from mail.convergence.de ([212.84.236.4]:47236 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S263817AbUDZNmH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 09:42:07 -0400
To: hunold@linuxtv.org, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
From: Michael Hunold <hunold@linuxtv.org>
Subject: [PATCH 6/9] DVB: AV7110 DVB driver updates
In-Reply-To: <10829868582688@convergence.de>
Message-Id: <10829868842348@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring_mihu_extended
Date: Mon, 26 Apr 2004 09:42:07 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- [DVB] av7110 update:
   - speed up firmware loading
   - follow internal API changes in saa7146 driver
   - introduced some symbolic constants for a/v dec cmds
   - change default for hw_sections to 0 to enable crc checks
diff -urawBN xx-linux-2.6.5/drivers/media/dvb/ttpci/av7110_av.c linux-2.6.5-patched/drivers/media/dvb/ttpci/av7110_av.c
--- xx-linux-2.6.5/drivers/media/dvb/ttpci/av7110_av.c	2004-02-22 14:48:47.000000000 +0100
+++ linux-2.6.5-patched/drivers/media/dvb/ttpci/av7110_av.c	2004-03-23 18:56:53.000000000 +0100
@@ -975,7 +975,7 @@
 		if (av7110->videostate.stream_source == VIDEO_SOURCE_MEMORY)
 			av7110_av_stop(av7110, RP_VIDEO);
 		else
-			vidcom(av7110, 0x000e,
+			vidcom(av7110, VIDEO_CMD_STOP,
 			       av7110->videostate.video_blank ? 0 : 1);
 		av7110->trickmode = TRICK_NONE;
 		break;
@@ -984,7 +984,7 @@
 		av7110->trickmode = TRICK_NONE;
 		if (av7110->videostate.play_state == VIDEO_FREEZED) {
 			av7110->videostate.play_state = VIDEO_PLAYING;
-			vidcom(av7110, 0x000d, 0);
+			vidcom(av7110, VIDEO_CMD_PLAY, 0);
 		}
 
 		if (av7110->videostate.stream_source == VIDEO_SOURCE_MEMORY) {
@@ -993,10 +993,10 @@
 				av7110->playing &= ~RP_VIDEO;
 			}
 			av7110_av_start_play(av7110, RP_VIDEO);
-			vidcom(av7110, 0x000d, 0);
+			vidcom(av7110, VIDEO_CMD_PLAY, 0);
 		} else {
 			//av7110_av_stop(av7110, RP_VIDEO);
-			vidcom(av7110, 0x000d, 0);
+			vidcom(av7110, VIDEO_CMD_PLAY, 0);
 		}
 		av7110->videostate.play_state = VIDEO_PLAYING;
 		break;
@@ -1006,14 +1006,14 @@
 		if (av7110->playing & RP_VIDEO)
 			av7110_fw_cmd(av7110, COMTYPE_REC_PLAY, __Pause, 0);
 		else
-			vidcom(av7110, 0x0102, 1);
+			vidcom(av7110, VIDEO_CMD_FREEZE, 1);
 		av7110->trickmode = TRICK_FREEZE;
 		break;
 
 	case VIDEO_CONTINUE:
 		if (av7110->playing & RP_VIDEO)
 			av7110_fw_cmd(av7110, COMTYPE_REC_PLAY, __Continue, 0);
-		vidcom(av7110, 0x000d, 0);
+		vidcom(av7110, VIDEO_CMD_PLAY, 0);
 		av7110->videostate.play_state = VIDEO_PLAYING;
 		av7110->trickmode = TRICK_NONE;
 		break;
@@ -1094,7 +1094,7 @@
 			av7110_fw_cmd(av7110, COMTYPE_REC_PLAY,
 				      __Scan_I, 2, AV_PES, 0);
 		else
-			vidcom(av7110, 0x16, arg);
+			vidcom(av7110, VIDEO_CMD_FFWD, arg);
 		av7110->trickmode = TRICK_FAST;
 		av7110->videostate.play_state = VIDEO_PLAYING;
 		break;
@@ -1102,11 +1102,11 @@
 	case VIDEO_SLOWMOTION:
 		if (av7110->playing&RP_VIDEO) {
 			av7110_fw_cmd(av7110, COMTYPE_REC_PLAY, __Slow, 2, 0, 0);
-			vidcom(av7110, 0x22, arg);
+			vidcom(av7110, VIDEO_CMD_SLOW, arg);
 		} else {
-			vidcom(av7110, 0x0d, 0);
-			vidcom(av7110, 0x0e, 0);
-			vidcom(av7110, 0x22, arg);
+			vidcom(av7110, VIDEO_CMD_PLAY, 0);
+			vidcom(av7110, VIDEO_CMD_STOP, 0);
+			vidcom(av7110, VIDEO_CMD_SLOW, arg);
 		}
 		av7110->trickmode = TRICK_SLOW;
 		av7110->videostate.play_state = VIDEO_PLAYING;
@@ -1130,10 +1130,10 @@
 			if (av7110->trickmode == TRICK_SLOW) {
 				av7110_fw_cmd(av7110, COMTYPE_REC_PLAY,
 					      __Slow, 2, 0, 0);
-				vidcom(av7110, 0x22, arg);
+				vidcom(av7110, VIDEO_CMD_SLOW, arg);
 			}
 			if (av7110->trickmode == TRICK_FREEZE)
-				vidcom(av7110, 0x000e, 1);
+				vidcom(av7110, VIDEO_CMD_STOP, 1);
 		}
 		break;
 
@@ -1167,26 +1167,26 @@
 		if (av7110->audiostate.stream_source == AUDIO_SOURCE_MEMORY)
 			av7110_av_stop(av7110, RP_AUDIO);
 		else
-			audcom(av7110, 1);
+			audcom(av7110, AUDIO_CMD_MUTE);
 		av7110->audiostate.play_state = AUDIO_STOPPED;
 		break;
 
 	case AUDIO_PLAY:
 		if (av7110->audiostate.stream_source == AUDIO_SOURCE_MEMORY)
 			av7110_av_start_play(av7110, RP_AUDIO);
-		audcom(av7110, 2);
+		audcom(av7110, AUDIO_CMD_UNMUTE);
 		av7110->audiostate.play_state = AUDIO_PLAYING;
 		break;
 
 	case AUDIO_PAUSE:
-		audcom(av7110, 1);
+		audcom(av7110, AUDIO_CMD_MUTE);
 		av7110->audiostate.play_state = AUDIO_PAUSED;
 		break;
 
 	case AUDIO_CONTINUE:
 		if (av7110->audiostate.play_state == AUDIO_PAUSED) {
 			av7110->audiostate.play_state = AUDIO_PLAYING;
-			audcom(av7110, 0x12);
+			audcom(av7110, AUDIO_CMD_MUTE | AUDIO_CMD_PCM16);
 		}
 		break;
 
@@ -1196,14 +1196,14 @@
 
 	case AUDIO_SET_MUTE:
 	{
-		audcom(av7110, arg ? 1 : 2);
+		audcom(av7110, arg ? AUDIO_CMD_MUTE : AUDIO_CMD_UNMUTE);
 		av7110->audiostate.mute_state = (int) arg;
 		break;
 	}
 
 	case AUDIO_SET_AV_SYNC:
 		av7110->audiostate.AV_sync_state = (int) arg;
-		audcom(av7110, arg ? 0x0f : 0x0e);
+		audcom(av7110, arg ? AUDIO_CMD_SYNC_ON : AUDIO_CMD_SYNC_OFF);
 		break;
 
 	case AUDIO_SET_BYPASS_MODE:
@@ -1215,15 +1215,15 @@
 
 		switch(av7110->audiostate.channel_select) {
 		case AUDIO_STEREO:
-			audcom(av7110, 0x80);
+			audcom(av7110, AUDIO_CMD_STEREO);
 			break;
 
 		case AUDIO_MONO_LEFT:
-			audcom(av7110, 0x100);
+			audcom(av7110, AUDIO_CMD_MONO_L);
 			break;
 
 		case AUDIO_MONO_RIGHT:
-			audcom(av7110, 0x200);
+			audcom(av7110, AUDIO_CMD_MONO_R);
 			break;
 
 		default:
diff -urawBN xx-linux-2.6.5/drivers/media/dvb/ttpci/av7110.c linux-2.6.5-patched/drivers/media/dvb/ttpci/av7110.c
--- xx-linux-2.6.5/drivers/media/dvb/ttpci/av7110.c	2004-03-12 20:31:29.000000000 +0100
+++ linux-2.6.5-patched/drivers/media/dvb/ttpci/av7110.c	2004-04-23 22:03:29.000000000 +0200
@@ -30,6 +30,7 @@
  */
 
 
+#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/kmod.h>
 #include <linux/delay.h>
@@ -77,7 +78,7 @@
 static int vidmode=CVBS_RGB_OUT;
 static int pids_off;
 static int adac=DVB_ADAC_TI;
-static int hw_sections = 1;
+static int hw_sections = 0;
 static int rgb_on = 0;
 
 int av7110_num = 0;
@@ -1241,10 +1241,6 @@
  ****************************************************************************/
 
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0))
-#define CONFIG_DVB_AV7110_FIRMWARE_FILE
-#endif
-
 static int check_firmware(struct av7110* av7110)
 {
 	u32 crc = 0, len = 0;
@@ -1358,13 +1354,13 @@
 		return ret;
 	}
 
-	dvb_register_adapter(&av7110->dvb_adapter, av7110->card_name);
+	dvb_register_adapter(&av7110->dvb_adapter, av7110->card_name, THIS_MODULE);
 
 	/* the Siemens DVB needs this if you want to have the i2c chips
 	   get recognized before the main driver is fully loaded */
 	saa7146_write(dev, GPIO_CTRL, 0x500000);
 
-	saa7146_i2c_adapter_prepare(dev, NULL, SAA7146_I2C_BUS_BIT_RATE_120); /* 275 kHz */
+	saa7146_i2c_adapter_prepare(dev, NULL, 0, SAA7146_I2C_BUS_BIT_RATE_120); /* 275 kHz */
 
 	av7110->i2c_bus = dvb_register_i2c_bus (master_xfer, dev,
 						av7110->dvb_adapter, 0);
@@ -1440,13 +1436,17 @@
 		printk ("av7110: Warning, firmware version 0x%04x is too old. "
 			"System might be unstable!\n", FW_VERSION(av7110->arm_app));
 
-	kernel_thread(arm_thread, (void *) av7110, 0);
+	if (kernel_thread(arm_thread, (void *) av7110, 0) < 0) {
+		printk(KERN_ERR "av7110(%d): faile to start arm_mon kernel thread\n",
+		       av7110->dvb_adapter->num);
+		goto err2;
+	}
 
 	/* set internal volume control to maximum */
 	av7110->adac_type = DVB_ADAC_TI;
 	av7110_set_volume(av7110, 0xff, 0xff);
 
-	VidMode(av7110, vidmode);
+	av7710_set_video_mode(av7110, vidmode);
 
 	/* handle different card types */
 	/* remaining inits according to card and frontend type */
@@ -1498,32 +1498,35 @@
 	ret = av7110_init_v4l(av7110);
 	
 	if (ret)
-		goto err;
+		goto err3;
 
 	printk(KERN_INFO "av7110: found av7110-%d.\n",av7110_num);
 	av7110->device_initialized = 1;
 	av7110_num++;
         return 0;
 
+err3:
+	av7110->arm_rmmod = 1;
+	wake_up_interruptible(&av7110->arm_wait);
+	while (av7110->arm_thread)
+		dvb_delay(1);
 err2:
 	av7110_ca_exit(av7110);
 	av7110_av_exit(av7110);
 err:
-	if (NULL != av7110 ) {
-		kfree(av7110);
-	}
-	if (NULL != av7110->debi_virt) {
-		pci_free_consistent(dev->pci, 8192, av7110->debi_virt, av7110->debi_bus);
-	}
-	if (NULL != av7110->iobuf) {
-		vfree(av7110->iobuf);
-	}
-
 	dvb_unregister_i2c_bus (master_xfer,av7110->i2c_bus->adapter,
 				av7110->i2c_bus->id);
 
 	dvb_unregister_adapter (av7110->dvb_adapter);
 
+	if (NULL != av7110->debi_virt)
+		pci_free_consistent(dev->pci, 8192, av7110->debi_virt, av7110->debi_bus);
+	if (NULL != av7110->iobuf)
+		vfree(av7110->iobuf);
+	if (NULL != av7110 ) {
+		kfree(av7110);
+	}
+
 	return ret;
 }
 
@@ -1648,6 +1651,7 @@
 {
 	int retval;
 	retval = saa7146_register_extension(&av7110_extension);
+#if defined(CONFIG_INPUT_EVDEV) || defined(CONFIG_INPUT_EVDEV_MODULE)
 	if (retval)
 		goto failed_saa7146_register;
 	
@@ -1658,13 +1662,16 @@
 failed_av7110_ir_init:
 	saa7146_unregister_extension(&av7110_extension);
 failed_saa7146_register:
+#endif
 	return retval;
 }
 
 
 static void __exit av7110_exit(void)
 {
+#if defined(CONFIG_INPUT_EVDEV) || defined(CONFIG_INPUT_EVDEV_MODULE)
 	av7110_ir_exit();
+#endif
 	saa7146_unregister_extension(&av7110_extension);
 }
 
diff -urawBN xx-linux-2.6.5/drivers/media/dvb/ttpci/av7110_hw.c linux-2.6.5-patched/drivers/media/dvb/ttpci/av7110_hw.c
--- xx-linux-2.6.5/drivers/media/dvb/ttpci/av7110_hw.c	2004-03-12 20:31:29.000000000 +0100
+++ linux-2.6.5-patched/drivers/media/dvb/ttpci/av7110_hw.c	2004-04-12 23:10:22.000000000 +0200
@@ -105,10 +105,8 @@
 	IER_DISABLE(av7110->dev, (MASK_19 | MASK_03));
 	saa7146_write(av7110->dev, ISR, (MASK_19 | MASK_03));
 
-	//FIXME: are those mdelays really necessary?
-	mdelay(800);
 	saa7146_setgpio(av7110->dev, RESET_LINE, SAA7146_GPIO_OUTHI);
-	mdelay(800);
+	dvb_delay(30);	/* the firmware needs some time to initialize */
 
 	ARM_ResetMailBox(av7110);
 
@@ -129,7 +127,7 @@
 	for (k = 0; k < 100; k++) {
 		if (irdebi(av7110, DEBINOSWAP, adr, 0, 2) == state)
 			return 0;
-		udelay(500);
+		udelay(5);
 	}
 	return -1;
 }
@@ -186,27 +184,24 @@
 /* we cannot write av7110 DRAM directly, so load a bootloader into
  * the DPRAM which implements a simple boot protocol */
 static u8 bootcode[] = {
-	0xea, 0x00, 0x00, 0x0e, 0xe1, 0xb0, 0xf0, 0x0e, /* 0x0000 */
-	0xe2, 0x5e, 0xf0, 0x04, 0xe2, 0x5e, 0xf0, 0x04,
-	0xe2, 0x5e, 0xf0, 0x08, 0xe2, 0x5e, 0xf0, 0x04,
-	0xe2, 0x5e, 0xf0, 0x04, 0xe2, 0x5e, 0xf0, 0x04,
-	0x2c, 0x00, 0x00, 0x24, 0x00, 0x00, 0x00, 0x0c,
-	0x00, 0x00, 0x00, 0x00, 0x2c, 0x00, 0x00, 0x34,
-	0x00, 0x00, 0x00, 0x00, 0xa5, 0xa5, 0x5a, 0x5a,
-	0x00, 0x1f, 0x15, 0x55, 0x00, 0x00, 0x00, 0x09,
-	0xe5, 0x9f, 0xd0, 0x5c, 0xe5, 0x9f, 0x40, 0x54, /* 0x0040 */
-	0xe3, 0xa0, 0x00, 0x00, 0xe5, 0x84, 0x00, 0x00,
-	0xe5, 0x84, 0x00, 0x04, 0xe1, 0xd4, 0x10, 0xb0,
-	0xe3, 0x51, 0x00, 0x00, 0x0a, 0xff, 0xff, 0xfc,
-	0xe1, 0xa0, 0x10, 0x0d, 0xe5, 0x94, 0x30, 0x04,
-	0xe1, 0xd4, 0x20, 0xb2, 0xe2, 0x82, 0x20, 0x3f,
-	0xe1, 0xb0, 0x23, 0x22, 0x03, 0xa0, 0x00, 0x02,
-	0xe1, 0xc4, 0x00, 0xb0, 0x0a, 0xff, 0xff, 0xf4,
-	0xe8, 0xb1, 0x1f, 0xe0, 0xe8, 0xa3, 0x1f, 0xe0, /* 0x0080 */
-	0xe8, 0xb1, 0x1f, 0xe0, 0xe8, 0xa3, 0x1f, 0xe0,
-	0xe2, 0x52, 0x20, 0x01, 0x1a, 0xff, 0xff, 0xf9,
-	0xe2, 0x2d, 0xdb, 0x05, 0xea, 0xff, 0xff, 0xec,
-	0x2c, 0x00, 0x03, 0xf8, 0x2c, 0x00, 0x04, 0x00,
+  0xea, 0x00, 0x00, 0x0e, 0xe1, 0xb0, 0xf0, 0x0e, 0xe2, 0x5e, 0xf0, 0x04,
+  0xe2, 0x5e, 0xf0, 0x04, 0xe2, 0x5e, 0xf0, 0x08, 0xe2, 0x5e, 0xf0, 0x04,
+  0xe2, 0x5e, 0xf0, 0x04, 0xe2, 0x5e, 0xf0, 0x04, 0x2c, 0x00, 0x00, 0x24,
+  0x00, 0x00, 0x00, 0x0c, 0x00, 0x00, 0x00, 0x00, 0x2c, 0x00, 0x00, 0x34,
+  0x00, 0x00, 0x00, 0x00, 0xa5, 0xa5, 0x5a, 0x5a, 0x00, 0x1f, 0x15, 0x55,
+  0x00, 0x00, 0x00, 0x09, 0xe5, 0x9f, 0xd0, 0x7c, 0xe5, 0x9f, 0x40, 0x74,
+  0xe3, 0xa0, 0x00, 0x00, 0xe5, 0x84, 0x00, 0x00, 0xe5, 0x84, 0x00, 0x04,
+  0xe5, 0x9f, 0x10, 0x70, 0xe5, 0x9f, 0x20, 0x70, 0xe5, 0x9f, 0x30, 0x64,
+  0xe8, 0xb1, 0x1f, 0xe0, 0xe8, 0xa3, 0x1f, 0xe0, 0xe1, 0x51, 0x00, 0x02,
+  0xda, 0xff, 0xff, 0xfb, 0xe5, 0x9f, 0xf0, 0x50, 0xe1, 0xd4, 0x10, 0xb0,
+  0xe3, 0x51, 0x00, 0x00, 0x0a, 0xff, 0xff, 0xfc, 0xe1, 0xa0, 0x10, 0x0d,
+  0xe5, 0x94, 0x30, 0x04, 0xe1, 0xd4, 0x20, 0xb2, 0xe2, 0x82, 0x20, 0x3f,
+  0xe1, 0xb0, 0x23, 0x22, 0x03, 0xa0, 0x00, 0x02, 0xe1, 0xc4, 0x00, 0xb0,
+  0x0a, 0xff, 0xff, 0xf4, 0xe8, 0xb1, 0x1f, 0xe0, 0xe8, 0xa3, 0x1f, 0xe0,
+  0xe8, 0xb1, 0x1f, 0xe0, 0xe8, 0xa3, 0x1f, 0xe0, 0xe2, 0x52, 0x20, 0x01,
+  0x1a, 0xff, 0xff, 0xf9, 0xe2, 0x2d, 0xdb, 0x05, 0xea, 0xff, 0xff, 0xec,
+  0x2c, 0x00, 0x03, 0xf8, 0x2c, 0x00, 0x04, 0x00, 0x9e, 0x00, 0x08, 0x00,
+  0x2c, 0x00, 0x00, 0x74, 0x2c, 0x00, 0x00, 0xc0
 };
 
 int av7110_bootarm(struct av7110 *av7110)
@@ -232,7 +227,7 @@
 	iwdebi(av7110, DEBISWAP, DPRAM_BASE, 0x76543210, 4);
 	if ((ret=irdebi(av7110, DEBINOSWAP, DPRAM_BASE, 0, 4)) != 0x10325476) {
 		printk(KERN_ERR "dvb: debi test in av7110_bootarm() failed: "
-		       "%08x != %08x (check your BIOS notplug settings)\n",
+		       "%08x != %08x (check your BIOS hotplug settings)\n",
 		       ret, 0x10325476);
 		return -1;
 	}
@@ -255,9 +250,7 @@
 		return -1;
 	}
 	saa7146_setgpio(dev, RESET_LINE, SAA7146_GPIO_OUTHI);
-	//FIXME: necessary?
-	set_current_state(TASK_INTERRUPTIBLE);
-	schedule_timeout(HZ);
+	mdelay(1);
 
 	DEB_D(("av7110_bootarm: load dram code\n"));
 	if (load_dram(av7110, (u32 *)av7110->bin_root, av7110->size_root) < 0)
@@ -275,8 +268,7 @@
 		return -1;
 	}
 	saa7146_setgpio(dev, RESET_LINE, SAA7146_GPIO_OUTHI);
-	//FIXME: necessary?
-	mdelay(800);
+	dvb_delay(30);	/* the firmware needs some time to initialize */
 
 	//ARM_ClearIrq(av7110);
 	ARM_ResetMailBox(av7110);
diff -urawBN xx-linux-2.6.5/drivers/media/dvb/ttpci/av7110_hw.h linux-2.6.5-patched/drivers/media/dvb/ttpci/av7110_hw.h
--- xx-linux-2.6.5/drivers/media/dvb/ttpci/av7110_hw.h	2004-03-12 20:31:29.000000000 +0100
+++ linux-2.6.5-patched/drivers/media/dvb/ttpci/av7110_hw.h	2004-03-23 18:56:53.000000000 +0100
@@ -200,6 +200,12 @@
 	__Continue
 };
 
+enum av7110_fw_cmd_misc {
+	AV7110_FW_VIDEO_ZOOM = 1,
+	AV7110_FW_VIDEO_COMMAND,
+	AV7110_FW_AUDIO_COMMAND
+};
+
 enum av7110_command_type {
 	COMTYPE_NOCOM,
 	COMTYPE_PIDFILTER,
@@ -218,6 +224,7 @@
 	COMTYPE_VIDEO,
 	COMTYPE_AUDIO,
 	COMTYPE_CI_LL,
+	COMTYPE_MISC = 0x80
 };
 
 #define VID_NONE_PREF		0x00	/* No aspect ration processing preferred */
@@ -226,6 +233,23 @@
 #define VID_VC_AND_PS_PREF	0x03	/* PanScan and vertical Compression if allowed */
 #define VID_CENTRE_CUT_PREF	0x05	/* PanScan with zero vector */
 
+/* MPEG video decoder commands */
+#define VIDEO_CMD_STOP		0x000e
+#define VIDEO_CMD_PLAY		0x000d
+#define VIDEO_CMD_FREEZE	0x0102
+#define VIDEO_CMD_FFWD		0x0016
+#define VIDEO_CMD_SLOW		0x0022
+
+/* MPEG audio decoder commands */
+#define AUDIO_CMD_MUTE		0x0001
+#define AUDIO_CMD_UNMUTE	0x0002
+#define AUDIO_CMD_PCM16		0x0010
+#define AUDIO_CMD_STEREO	0x0080
+#define AUDIO_CMD_MONO_L	0x0100
+#define AUDIO_CMD_MONO_R	0x0200
+#define AUDIO_CMD_SYNC_OFF	0x000e
+#define AUDIO_CMD_SYNC_ON	0x000f
+
 /* firmware data interface codes */
 #define DATA_NONE		 0x00
 #define DATA_FSECTION		 0x01
@@ -457,21 +481,21 @@
 	return av7110_fw_cmd(av7110, COMTYPE_AUDIODAC, AudioDAC, 2, addr, data);
 }
 
-static inline void VidMode(struct av7110 *av7110, int mode)
+static inline void av7710_set_video_mode(struct av7110 *av7110, int mode)
 {
 	av7110_fw_cmd(av7110, COMTYPE_ENCODER, SetVidMode, 1, mode);
 }
 
 static int inline vidcom(struct av7110 *av7110, u32 com, u32 arg)
 {
-	return av7110_fw_cmd(av7110, 0x80, 0x02, 4,
+	return av7110_fw_cmd(av7110, COMTYPE_MISC, AV7110_FW_VIDEO_COMMAND, 4,
 			     (com>>16), (com&0xffff),
 			     (arg>>16), (arg&0xffff));
 }
 
 static int inline audcom(struct av7110 *av7110, u32 com)
 {
-	return av7110_fw_cmd(av7110, 0x80, 0x03, 4,
+	return av7110_fw_cmd(av7110, COMTYPE_MISC, AV7110_FW_AUDIO_COMMAND, 4,
 			     (com>>16), (com&0xffff));
 }
 
diff -urawBN xx-linux-2.6.5/drivers/media/dvb/ttpci/av7110_v4l.c linux-2.6.5-patched/drivers/media/dvb/ttpci/av7110_v4l.c
--- xx-linux-2.6.5/drivers/media/dvb/ttpci/av7110_v4l.c	2004-03-12 20:31:29.000000000 +0100
+++ linux-2.6.5-patched/drivers/media/dvb/ttpci/av7110_v4l.c	2004-03-15 20:38:15.000000000 +0100
@@ -177,16 +177,17 @@
 	struct av7110 *av7110 = (struct av7110*)dev->ext_priv;
 	u16 adswitch;
 	u8 band = 0;
-	int source, sync;
-	struct saa7146_fh *ov_fh = NULL;
-	int restart_overlay = 0;
+	int source, sync, err;
 
 	DEB_EE(("av7110: %p\n", av7110));
 
-	if (vv->ov_data != NULL) {
-		ov_fh = vv->ov_data->fh;
-		saa7146_stop_preview(ov_fh);
-		restart_overlay = 1;
+	if ((vv->video_status & STATUS_OVERLAY) != 0) {
+		vv->ov_suspend = vv->video_fh;
+		err = saa7146_stop_preview(vv->video_fh); /* side effect: video_status is now 0, video_fh is NULL */
+		if (err != 0) {
+			DEB_D(("warning: suspending video failed\n"));
+			vv->ov_suspend = NULL;
+		}
 	}
 
 	if (0 != av7110->current_input) {
@@ -195,7 +196,7 @@
 		source = SAA7146_HPS_SOURCE_PORT_B;
 		sync = SAA7146_HPS_SYNC_PORT_B;
 		memcpy(standard, analog_standard, sizeof(struct saa7146_standard) * 2);
-		DEB_S(("av7110: switching to analog TV\n"));
+		printk("av7110: switching to analog TV\n");
 		msp_writereg(av7110, MSP_WR_DSP, 0x0008, 0x0000); // loudspeaker source
 		msp_writereg(av7110, MSP_WR_DSP, 0x0009, 0x0000); // headphone source
 		msp_writereg(av7110, MSP_WR_DSP, 0x000a, 0x0000); // SCART 1 source
@@ -208,7 +209,7 @@
 		source = SAA7146_HPS_SOURCE_PORT_A;
 		sync = SAA7146_HPS_SYNC_PORT_A;
 		memcpy(standard, dvb_standard, sizeof(struct saa7146_standard) * 2);
-		DEB_S(("av7110: switching DVB mode\n"));
+		printk("av7110: switching DVB mode\n");
 		msp_writereg(av7110, MSP_WR_DSP, 0x0008, 0x0220); // loudspeaker source
 		msp_writereg(av7110, MSP_WR_DSP, 0x0009, 0x0220); // headphone source
 		msp_writereg(av7110, MSP_WR_DSP, 0x000a, 0x0220); // SCART 1 source
@@ -225,8 +226,10 @@
 		printk("setting band in demodulator failed.\n");
 	saa7146_set_hps_source_and_sync(dev, source, sync);
 
-	if (restart_overlay)
-		saa7146_start_preview(ov_fh);
+	if (vv->ov_suspend != NULL) {
+		saa7146_start_preview(vv->ov_suspend);
+		vv->ov_suspend = NULL;
+	}
 
 	return 0;
 }
@@ -263,10 +266,10 @@
 
 		// FIXME: standard / stereo detection is still broken
 		msp_readreg(av7110, MSP_RD_DEM, 0x007e, &stereo_det);
-		DEB_S(("VIDIOC_G_TUNER: msp3400 TV standard detection: 0x%04x\n", stereo_det));
+printk("VIDIOC_G_TUNER: msp3400 TV standard detection: 0x%04x\n", stereo_det);
 
 		msp_readreg(av7110, MSP_RD_DSP, 0x0018, &stereo_det);
-		DEB_S(("VIDIOC_G_TUNER: msp3400 stereo detection: 0x%04x\n", stereo_det));
+		printk("VIDIOC_G_TUNER: msp3400 stereo detection: 0x%04x\n", stereo_det);
 		stereo = (s8)(stereo_det >> 8);
 		if (stereo > 0x10) {
 			/* stereo */
@@ -624,13 +627,13 @@
 static struct saa7146_standard standard[] = {
 	{
 		.name	= "PAL",	.id		= V4L2_STD_PAL_BG,
-		.v_offset	= 0x15,	.v_field	= 288,		.v_calc	= 576,
-		.h_offset	= 0x4a,	.h_pixels	= 708,		.h_calc	= 709,
+		.v_offset	= 0x15,	.v_field	= 288,
+		.h_offset	= 0x48,	.h_pixels	= 708,
 		.v_max_out	= 576,	.h_max_out	= 768,
 	}, {
 		.name	= "NTSC",	.id		= V4L2_STD_NTSC,
-		.v_offset	= 0x10,	.v_field	= 244,		.v_calc	= 480,
-		.h_offset	= 0x40,	.h_pixels	= 708,		.h_calc	= 709,
+		.v_offset	= 0x10,	.v_field	= 244,
+		.h_offset	= 0x40,	.h_pixels	= 708,
 		.v_max_out	= 480,	.h_max_out	= 640,
 	}
 };
@@ -638,13 +641,13 @@
 static struct saa7146_standard analog_standard[] = {
 	{
 		.name	= "PAL",	.id		= V4L2_STD_PAL_BG,
-		.v_offset	= 0x1b,	.v_field	= 288,		.v_calc	= 576,
-		.h_offset	= 0x08,	.h_pixels	= 708,		.h_calc	= 709,
+		.v_offset	= 0x1b,	.v_field	= 288,
+		.h_offset	= 0x08,	.h_pixels	= 708,
 		.v_max_out	= 576,	.h_max_out	= 768,
 	}, {
 		.name	= "NTSC",	.id		= V4L2_STD_NTSC,
-		.v_offset	= 0x10,	.v_field	= 244,		.v_calc	= 480,
-		.h_offset	= 0x40,	.h_pixels	= 708,		.h_calc	= 709,
+		.v_offset	= 0x10,	.v_field	= 244,
+		.h_offset	= 0x40,	.h_pixels	= 708,
 		.v_max_out	= 480,	.h_max_out	= 640,
 	}
 };
@@ -652,13 +655,13 @@
 static struct saa7146_standard dvb_standard[] = {
 	{
 		.name	= "PAL",	.id		= V4L2_STD_PAL_BG,
-		.v_offset	= 0x14,	.v_field	= 288,		.v_calc	= 576,
-		.h_offset	= 0x4a,	.h_pixels	= 708,		.h_calc	= 709,
+		.v_offset	= 0x14,	.v_field	= 288,
+		.h_offset	= 0x48,	.h_pixels	= 708,
 		.v_max_out	= 576,	.h_max_out	= 768,
 	}, {
 		.name	= "NTSC",	.id		= V4L2_STD_NTSC,
-		.v_offset	= 0x10,	.v_field	= 244,		.v_calc	= 480,
-		.h_offset	= 0x40,	.h_pixels	= 708,		.h_calc	= 709,
+		.v_offset	= 0x10,	.v_field	= 244,
+		.h_offset	= 0x40,	.h_pixels	= 708,
 		.v_max_out	= 480,	.h_max_out	= 640,
 	}
 };


