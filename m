Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266250AbUITLMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266250AbUITLMr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 07:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266249AbUITLMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 07:12:47 -0400
Received: from ip-svs-1.Informatik.Uni-Oldenburg.DE ([134.106.12.126]:30152
	"EHLO aechz.svs.informatik.uni-oldenburg.de") by vger.kernel.org
	with ESMTP id S266250AbUITLLl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 07:11:41 -0400
Date: Mon, 20 Sep 2004 13:11:18 +0200
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
To: Michael Hunold <hunold@linuxtv.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.6][12.1/14] DVB: add kernel message classifiers
Message-ID: <20040920111118.GA6035@titan.lahn.de>
Mail-Followup-To: Michael Hunold <hunold@linuxtv.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <414AF41A.6060009@linuxtv.org> <414AF461.4050707@linuxtv.org> <414AF4CE.7000000@linuxtv.org> <414AF51D.4060308@linuxtv.org> <414AF569.2020803@linuxtv.org> <414AF5BF.4020401@linuxtv.org> <414AF605.5040605@linuxtv.org> <414AF65F.2010200@linuxtv.org> <414AF6B1.9040706@linuxtv.org> <414AF71B.5070702@linuxtv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414AF71B.5070702@linuxtv.org>
Organization: UUCP-Freunde Lahn e.V.
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Michael!

On Fri, Sep 17, 2004 at 04:39:23PM +0200, Michael Hunold wrote:
> - [DVB] av7110: convert MODULE_PARM() to module_param(), replace home-brewn waiting stuff in osd code with wait_event_interruptible_timeout()
> - [DVB] av7110, budget: use msleep() instead of my_wait(), thanks to Kernel Janitors/Nishanth Aravamudan <nacc@us.ibm.com>
> 
> Signed-off-by: Michael Hunold <hunold@linuxtv.org>

Could you please apply the following patch on top, which adds
kernel message classifiers to printk()-calls in av7110_av.c

If you don't to apply the whole patch, please at least remove those two
printk() calls in av7110_ioctl() line 267 and 270, because on my Siemens
DVB-C 1.6 they are printed every second and fill up syslog! (BTW: Stereo
detection never worked for me)

Signed-off-by: Philipp Matthias Hahn <pmhahn@titan.lahn.de>

--- linux-2.6.8.1/drivers/media/dvb/ttpci/av7110_v4l.c~	2004-06-16 09:29:23.000000000 +0200
+++ linux-2.6.8.1/drivers/media/dvb/ttpci/av7110_v4l.c	2004-09-20 12:58:16.000000000 +0200
@@ -51,7 +51,7 @@ int msp_writereg(struct av7110 *av7110, 
 	struct i2c_msg msgs = { .flags = 0, .addr = 0x40, .len = 5, .buf = msg };
 
 	if (i2c_transfer(&av7110->i2c_adap, &msgs, 1) != 1) {
-		printk("av7110(%d): %s(%u = %u) failed\n",
+		printk(KERN_ERR "av7110(%d): %s(%u = %u) failed\n",
 		       av7110->dvb_adapter->num, __FUNCTION__, reg, val);
 		return -EIO;
 	}
@@ -68,7 +68,7 @@ int msp_readreg(struct av7110 *av7110, u
 	};
 
 	if (i2c_transfer(&av7110->i2c_adap, &msgs[0], 2) != 2) {
-		printk("av7110(%d): %s(%u) failed\n",
+		printk(KERN_ERR "av7110(%d): %s(%u) failed\n",
 		       av7110->dvb_adapter->num, __FUNCTION__, reg);
 		return -EIO;
 	}
@@ -194,7 +194,7 @@ int av7110_dvb_c_switch(struct saa7146_f
 		source = SAA7146_HPS_SOURCE_PORT_B;
 		sync = SAA7146_HPS_SYNC_PORT_B;
 		memcpy(standard, analog_standard, sizeof(struct saa7146_standard) * 2);
-		printk("av7110: switching to analog TV\n");
+		printk(KERN_INFO "av7110: switching to analog TV\n");
 		msp_writereg(av7110, MSP_WR_DSP, 0x0008, 0x0000); // loudspeaker source
 		msp_writereg(av7110, MSP_WR_DSP, 0x0009, 0x0000); // headphone source
 		msp_writereg(av7110, MSP_WR_DSP, 0x000a, 0x0000); // SCART 1 source
@@ -207,7 +207,7 @@ int av7110_dvb_c_switch(struct saa7146_f
 		source = SAA7146_HPS_SOURCE_PORT_A;
 		sync = SAA7146_HPS_SYNC_PORT_A;
 		memcpy(standard, dvb_standard, sizeof(struct saa7146_standard) * 2);
-		printk("av7110: switching DVB mode\n");
+		printk(KERN_INFO "av7110: switching DVB mode\n");
 		msp_writereg(av7110, MSP_WR_DSP, 0x0008, 0x0220); // loudspeaker source
 		msp_writereg(av7110, MSP_WR_DSP, 0x0009, 0x0220); // headphone source
 		msp_writereg(av7110, MSP_WR_DSP, 0x000a, 0x0220); // SCART 1 source
@@ -218,10 +218,10 @@ int av7110_dvb_c_switch(struct saa7146_f
 
 	/* hmm, this does not do anything!? */
 	if (av7110_fw_cmd(av7110, COMTYPE_AUDIODAC, ADSwitch, 1, adswitch))
-		printk("ADSwitch error\n");
+		printk(KERN_ERROR "ADSwitch error\n");
 
 	if (ves1820_writereg(dev, 0x0f, band))
-		printk("setting band in demodulator failed.\n");
+		printk(KERN_ERROR "setting band in demodulator failed.\n");
 	saa7146_set_hps_source_and_sync(dev, source, sync);
 
 	if (vv->ov_suspend != NULL) {
@@ -264,10 +264,10 @@ int av7110_ioctl(struct saa7146_fh *fh, 
 
 		// FIXME: standard / stereo detection is still broken
 		msp_readreg(av7110, MSP_RD_DEM, 0x007e, &stereo_det);
-printk("VIDIOC_G_TUNER: msp3400 TV standard detection: 0x%04x\n", stereo_det);
+		printk(KERN_DEBUG "VIDIOC_G_TUNER: msp3400 TV standard detection: 0x%04x\n", stereo_det);
 
 		msp_readreg(av7110, MSP_RD_DSP, 0x0018, &stereo_det);
-		printk("VIDIOC_G_TUNER: msp3400 stereo detection: 0x%04x\n", stereo_det);
+		printk(KERN_DEBUG "VIDIOC_G_TUNER: msp3400 stereo detection: 0x%04x\n", stereo_det);
 		stereo = (s8)(stereo_det >> 8);
 		if (stereo > 0x10) {
 			/* stereo */
@@ -418,7 +418,7 @@ printk("VIDIOC_G_TUNER: msp3400 TV stand
 		break;
 	}
 	default:
-		printk("no such ioctl\n");
+		printk(KERN_ERR "no such ioctl\n");
 		return -ENOIOCTLCMD;
 	}
 	return 0;
@@ -512,13 +512,13 @@ int av7110_init_analog_module(struct av7
 	    || i2c_writereg(av7110, 0x80, 0x0, 0) != 1)
 		return -ENODEV;
 
-	printk("av7110(%d): DVB-C analog module detected, initializing MSP3400\n",
+	printk(KERN_INFO "av7110(%d): DVB-C analog module detected, initializing MSP3400\n",
 		av7110->dvb_adapter->num);
 	av7110->adac_type = DVB_ADAC_MSP;
 	msleep(100); // the probing above resets the msp...
 	msp_readreg(av7110, MSP_RD_DSP, 0x001e, &version1);
 	msp_readreg(av7110, MSP_RD_DSP, 0x001f, &version2);
-	printk("av7110(%d): MSP3400 version 0x%04x 0x%04x\n",
+	printk(KERN_INFO "av7110(%d): MSP3400 version 0x%04x 0x%04x\n",
 		av7110->dvb_adapter->num, version1, version2);
 	msp_writereg(av7110, MSP_WR_DSP, 0x0013, 0x0c00);
 	msp_writereg(av7110, MSP_WR_DSP, 0x0000, 0x7f00); // loudspeaker + headphone
@@ -537,7 +537,7 @@ int av7110_init_analog_module(struct av7
 		/* init the saa7113 */
 		while (*i != 0xff) {
 			if (i2c_writereg(av7110, 0x48, i[0], i[1]) != 1) {
-				printk("av7110(%d): saa7113 initialization failed",
+				printk(KERN_ERR "av7110(%d): saa7113 initialization failed",
 						av7110->dvb_adapter->num);
 				break;
 			}

-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de
