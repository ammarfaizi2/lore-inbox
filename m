Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262349AbUJ0J5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262349AbUJ0J5x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 05:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbUJ0J5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 05:57:53 -0400
Received: from mail.convergence.de ([212.227.36.84]:53149 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S262349AbUJ0Jtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 05:49:46 -0400
Message-ID: <417F6F0D.9020109@linuxtv.org>
Date: Wed, 27 Oct 2004 11:49:01 +0200
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH][1/5] DVB: rework debugging in av7110 
References: <417F6EB2.2070807@linuxtv.org>
In-Reply-To: <417F6EB2.2070807@linuxtv.org>
Content-Type: multipart/mixed;
 boundary="------------000702030001000202040801"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000702030001000202040801
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------000702030001000202040801
Content-Type: text/plain;
 name="01-dvb-av7110-debug.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="01-dvb-av7110-debug.diff"

- [DVB] av7110: switch from stupid DEB_xx() debug macros to saner dprintk() style debugging
- [DVB] av7110: fix dvb-ttpci ca write() polling
- [DVB] budget: switch from stupid DEB_xx() debug macros to saner dprintk() style debugging

Signed-off-by: Michael Hunold <hunold@linuxtv.org>

diff -uraNwB linux-2.6.10-rc1/drivers/media/dvb/ttpci/av7110.c linux-2.6.10-rc1-patched/drivers/media/dvb/ttpci/av7110.c
--- linux-2.6.10-rc1/drivers/media/dvb/ttpci/av7110.c	2004-10-25 14:07:52.000000000 +0200
+++ linux-2.6.10-rc1-patched/drivers/media/dvb/ttpci/av7110.c	2004-10-25 14:14:43.000000000 +0200
@@ -67,7 +67,8 @@
 #include "av7110_ca.h"
 #include "av7110_ipack.h"
 
-static int av7110_debug;
+int av7110_debug;
+
 static int vidmode=CVBS_RGB_OUT;
 static int pids_off;
 static int adac=DVB_ADAC_TI;
@@ -110,7 +111,7 @@
 	av7110->has_analog_tuner = 0;
 	av7110->current_input = 0;
 	if (i2c_writereg(av7110, 0x20, 0x00, 0x00) == 1) {
-		printk ("av7110(%d): Crystal audio DAC detected\n",
+		printk ("dvb-ttpci: Crystal audio DAC @ card %d detected\n",
 			av7110->dvb_adapter->num);
 		av7110->adac_type = DVB_ADAC_CRYSTAL;
 		i2c_writereg(av7110, 0x20, 0x01, 0xd2);
@@ -125,13 +126,13 @@
 		/* done. */
 	}
 	else if (dev->pci->subsystem_vendor == 0x110a) {
-		printk("av7110(%d): DVB-C w/o analog module detected\n",
+		printk("dvb-ttpci: DVB-C w/o analog module @ card %d detected\n",
 			av7110->dvb_adapter->num);
 		av7110->adac_type = DVB_ADAC_NONE;
 	}
 	else {
 		av7110->adac_type = adac;
-		printk("av7110(%d): adac type set to %d\n",
+		printk("dvb-ttpci: adac type set to %d @ card %d\n",
 			av7110->dvb_adapter->num, av7110->adac_type);
 	}
 
@@ -150,7 +151,7 @@
 
 static void recover_arm(struct av7110 *av7110)
 {
-	DEB_EE(("av7110: %p\n",av7110));
+	dprintk(4, "%p\n",av7110);
 
 	av7110_bootarm(av7110);
 	msleep(100);
@@ -160,7 +161,7 @@
 
 static void arm_error(struct av7110 *av7110)
 {
-	DEB_EE(("av7110: %p\n",av7110));
+	dprintk(4, "%p\n",av7110);
 
         av7110->arm_errors++;
         av7110->arm_ready=0;
@@ -173,7 +174,7 @@
         u16 newloops = 0;
 	int timeout;
 
-	DEB_EE(("av7110: %p\n",av7110));
+	dprintk(4, "%p\n",av7110);
 	
         lock_kernel ();
         daemonize ("arm_mon");
@@ -199,7 +200,7 @@
                 up(&av7110->dcomlock);
 
                 if (newloops==av7110->arm_loops) {
-                        printk(KERN_ERR "av7110%d: ARM crashed!\n",
+			printk(KERN_ERR "dvb-ttpci: ARM crashed @ card %d\n",
 				av7110->dvb_adapter->num);
 
 			arm_error(av7110);
@@ -231,7 +232,7 @@
 {
 	static struct av7110 *last;
 
-	DEB_EE(("av7110: %p\n",av7110));
+	dprintk(4, "%p\n",av7110);
 
 	if (!av7110)
 		av7110 = last;
@@ -248,13 +249,13 @@
 
 void av7110_register_irc_handler(void (*func)(u32)) 
 {
-	DEB_EE(("registering %p\n", func));
+	dprintk(4, "registering %p\n", func);
         irc_handler = func;
 }
 
 void av7110_unregister_irc_handler(void (*func)(u32)) 
 {
-	DEB_EE(("unregistering %p\n", func));
+	dprintk(4, "unregistering %p\n", func);
         irc_handler = NULL;
 }
 
@@ -268,7 +269,7 @@
 
 void IR_handle(struct av7110 *av7110, u32 ircom)
 {
-	DEB_S(("av7110: ircommand = %08x\n", ircom));
+	dprintk(4, "ircommand = %08x\n", ircom);
         irtask.data = (unsigned long) ircom;
         tasklet_schedule(&irtask);
 }
@@ -283,8 +284,6 @@
                      enum dmx_success success,
                      struct av7110 *av7110)
 {
-	DEB_INT(("av7110: %p\n",av7110));
-
         if (!dvbdmxfilter->feed->demux->dmx.frontend)
                 return 0;
         if (dvbdmxfilter->feed->demux->dmx.frontend->source==DMX_MEMORY_FE)
@@ -344,7 +343,7 @@
         int type=av7110->debitype;
         int handle=(type>>8)&0x1f;
 	
-//	DEB_EE(("av7110: %p\n",av7110));
+//	dprintk(4, "%p\n",av7110);
 
         print_time("debi");
         saa7146_write(av7110->dev, IER, 
@@ -476,10 +475,8 @@
         u32 rxbuf, txbuf;
         int len;
         
-        //printk("GPIO0 irq\n");        
-
         if (av7110->debitype !=-1)
-		printk("GPIO0 irq oops @ %ld, psr:0x%08x, ssr:0x%08x\n",
+		printk("dvb-ttpci: GPIO0 irq oops @ %ld, psr:0x%08x, ssr:0x%08x\n",
 		       jiffies, saa7146_read(av7110->dev, PSR),
 		       saa7146_read(av7110->dev, SSR));
        
@@ -497,10 +494,10 @@
         txbuf=irdebi(av7110, DEBINOSWAP, TX_BUFF, 0, 2);
 	len = (av7110->debilen + 3) & ~3;
 
-//        DEB_D(("GPIO0 irq %d %d\n", av7110->debitype, av7110->debilen));
+//	dprintk(8, "GPIO0 irq %d %d\n", av7110->debitype, av7110->debilen);
         print_time("gpio");
 
-//       DEB_D(("GPIO0 irq %02x\n", av7110->debitype&0xff));        
+//	dprintk(8, "GPIO0 irq %02x\n", av7110->debitype&0xff);
         switch (av7110->debitype&0xff) {
 
         case DATA_TS_PLAY:
@@ -519,10 +516,10 @@
                 iwdebi(av7110, DEBINOSWAP, RX_BUFF, 0, 2);
 
 		av7110->video_size.h = h_ar & 0xfff;
-		DEB_D(("GPIO0 irq: DATA_MPEG_VIDEO_EVENT: w/h/ar = %u/%u/%u\n",
+		dprintk(8, "GPIO0 irq: DATA_MPEG_VIDEO_EVENT: w/h/ar = %u/%u/%u\n",
 				av7110->video_size.w,
 				av7110->video_size.h,
-				av7110->video_size.aspect_ratio));
+				av7110->video_size.aspect_ratio);
 
 		event.type = VIDEO_EVENT_SIZE_CHANGED;
 		event.u.size.w = av7110->video_size.w;
@@ -610,7 +607,7 @@
                         iwdebi(av7110, DEBINOSWAP, TX_BUFF, 0, 2);
                         break;
                 } 
-                DEB_D(("GPIO0 PES_PLAY len=%04x\n", len));        
+		dprintk(8, "GPIO0 PES_PLAY len=%04x\n", len);
                 iwdebi(av7110, DEBINOSWAP, TX_LEN, len, 2);
                 iwdebi(av7110, DEBINOSWAP, IRQ_STATE_EXT, len, 2);
 		saa7146_wait_for_debi_done(av7110->dev);
@@ -688,7 +685,7 @@
                 break;
 
         default:
-                printk("gpioirq unknown type=%d len=%d\n", 
+		printk("dvb-ttpci: gpioirq unknown type=%d len=%d\n",
                        av7110->debitype, av7110->debilen);
                 break;
         }      
@@ -705,7 +702,7 @@
 	struct dvb_device *dvbdev = (struct dvb_device *) file->private_data;
 	struct av7110 *av7110 = (struct av7110 *) dvbdev->priv;
 
-	DEB_EE(("av7110: %p\n", av7110));
+	dprintk(4, "%p\n", av7110);
 
 	if (cmd == OSD_SEND_CMD)
 		return av7110_osd_cmd(av7110, (osd_cmd_t *) parg);
@@ -736,7 +733,7 @@
 static inline int SetPIDs(struct av7110 *av7110, u16 vpid, u16 apid, u16 ttpid,
 			  u16 subpid, u16 pcrpid)
         {
-	DEB_EE(("av7110: %p\n", av7110));
+	dprintk(4, "%p\n", av7110);
 
 	if (vpid == 0x1fff || apid == 0x1fff ||
 	    ttpid == 0x1fff || subpid == 0x1fff || pcrpid == 0x1fff) {
@@ -754,7 +751,7 @@
 void ChangePIDs(struct av7110 *av7110, u16 vpid, u16 apid, u16 ttpid,
 		u16 subpid, u16 pcrpid)
 {
-	DEB_EE(("av7110: %p\n", av7110));
+	dprintk(4, "%p\n", av7110);
         
 	if (down_interruptible(&av7110->pid_mutex))
 		return;
@@ -793,7 +790,7 @@
 //	u16 mode=0x0320;
 	u16 mode=0xb96a;
 
-	DEB_EE(("av7110: %p\n",av7110));
+	dprintk(4, "%p\n", av7110);
 
 	if (dvbdmxfilter->type == DMX_TYPE_SEC) {
 		if (hw_sections) {
@@ -817,7 +814,7 @@
 
 	ret = av7110_fw_request(av7110, buf, 20, &handle, 1);
 	if (ret < 0) {
-		printk("StartHWFilter error\n");
+		dprintk(1, "StartHWFilter error\n");
 		return ret;
         }
 
@@ -835,13 +832,11 @@
 	int ret;
 	u16 handle;
         
-	DEB_EE(("av7110: %p\n", av7110));
+	dprintk(4, "%p\n", av7110);
 
 	handle = dvbdmxfilter->hw_handle;
 	if (handle > 32) {
-		DEB_S(("dvb: StopHWFilter tried to stop invalid filter %d.\n",
-		       handle));
-		DEB_S(("dvb: filter type = %d\n", dvbdmxfilter->type));
+		dprintk(1, "StopHWFilter tried to stop invalid filter %d, filter type = %d\n", handle, dvbdmxfilter->type);
 		return 0;
                 }
 
@@ -852,10 +847,10 @@
 	buf[2] = handle;
 	ret = av7110_fw_request(av7110, buf, 3, answ, 2);
 	if (ret)
-		printk("StopHWFilter error\n");
+		dprintk(1, "StopHWFilter error\n");
 
 	if (answ[1] != handle) {
-		DEB_S(("dvb: filter %d shutdown error :%d\n", handle, answ[1]));
+		dprintk(2, "filter %d shutdown error :%d\n", handle, answ[1]);
 		ret = -1;
         }
         return ret;
@@ -869,7 +864,7 @@
 	u16 *pid = dvbdmx->pids, npids[5];
 	int i;
 
-	DEB_EE(("av7110: %p\n",av7110));
+	dprintk(4, "%p\n", av7110);
 
 	npids[0] = npids[1] = npids[2] = npids[3] = npids[4] = 0xffff;
 	i = dvbdmxfeed->pes_type;
@@ -902,7 +897,7 @@
 	u16 *pid = dvbdmx->pids, npids[5];
 	int i;
                 
-	DEB_EE(("av7110: %p\n", av7110));
+	dprintk(4, "%p\n", av7110);
                 
 	if (dvbdmxfeed->pes_type <= 1) {
 		av7110_av_stop(av7110, dvbdmxfeed->pes_type ?  RP_VIDEO : RP_AUDIO);
@@ -935,7 +930,7 @@
 	struct dvb_demux *demux = feed->demux;
 	struct av7110 *av7110 = (struct av7110 *) demux->priv;
                 
-	DEB_EE(("av7110: %p\n", av7110));
+	dprintk(4, "%p\n", av7110);
                 
 	if (!demux->dmx.frontend)
 		return -EINVAL;
@@ -993,7 +988,7 @@
 	struct dvb_demux *demux = feed->demux;
 	struct av7110 *av7110 = (struct av7110 *) demux->priv;
 
-	DEB_EE(("av7110: %p\n",av7110));
+	dprintk(4, "%p\n", av7110);
 
 	if (feed->type == DMX_TYPE_TS) {
 		if (feed->ts_type & TS_DECODER) {
@@ -1035,7 +1030,7 @@
 	int mode;
 	int i;
 
-	DEB_EE(("av7110: %p\n",av7110));
+	dprintk(4, "%p\n", av7110);
 
 	mode = av7110->playing;
 	av7110->playing = 0;
@@ -1068,7 +1063,7 @@
 		BUG();
 	av7110 = (struct av7110 *) dvbdemux->priv;
 
-	DEB_EE(("av7110: %p\n",av7110));
+	dprintk(4, "%p\n", av7110);
 
 	if (num != 0)
 		return -EINVAL;
@@ -1078,14 +1073,14 @@
 		printk(KERN_ERR "%s: av7110_fw_request error\n", __FUNCTION__);
 		return -EIO;
 }
-	DEB_EE(("av7110: fwstc = %04hx %04hx %04hx %04hx\n",
-		fwstc[0], fwstc[1], fwstc[2], fwstc[3]));
+	dprintk(2, "fwstc = %04hx %04hx %04hx %04hx\n",
+		fwstc[0], fwstc[1], fwstc[2], fwstc[3]);
 
 	*stc =	(((uint64_t) ((fwstc[3] & 0x8000) >> 15)) << 32) |
 		(((uint64_t)  fwstc[1]) << 16) | ((uint64_t) fwstc[0]);
 	*base = 1;
         
-	DEB_EE(("av7110: stc = %lu\n", (unsigned long)*stc));
+	dprintk(4, "stc = %lu\n", (unsigned long)*stc);
 
 	return 0;
 }
@@ -1099,7 +1094,7 @@
 {
 	struct av7110 *av7110 = fe->before_after_data;
 
-	DEB_EE(("av7110: %p\n", av7110));
+	dprintk(4, "%p\n", av7110);
 
 	switch (cmd) {
 	case FE_SET_TONE:
@@ -1138,7 +1133,7 @@
 {
 	struct av7110 *av7110 = data;
 
-	DEB_EE(("av7110: %p\n",av7110));
+	dprintk(4, "%p\n", av7110);
 
         av7110->fe_synced = (s & FE_HAS_LOCK) ? 1 : 0;
 
@@ -1168,7 +1163,7 @@
         int ret, i;
         struct dvb_demux *dvbdemux=&av7110->demux;
 
-	DEB_EE(("av7110: %p\n",av7110));
+	dprintk(4, "%p\n", av7110);
 
         if (av7110->registered)
                 return -1;
@@ -1243,7 +1238,7 @@
 {
         struct dvb_demux *dvbdemux=&av7110->demux;
 
-	DEB_EE(("av7110: %p\n",av7110));
+	dprintk(4, "%p\n", av7110);
 
         if (!av7110->registered)
                 return;
@@ -1397,7 +1391,7 @@
 	/* check if the firmware is available */
 	av7110->bin_fw = (unsigned char*) vmalloc(fw->size);
 	if (NULL == av7110->bin_fw) {
-		DEB_D(("out of memory\n"));
+		dprintk(1, "out of memory\n");
 		release_firmware(fw);
 		return -ENOMEM;
 	}
@@ -1440,14 +1434,14 @@
 	struct av7110 *av7110 = NULL;
 	int ret = 0;
 
-	DEB_EE(("dev: %p\n", dev));
+	dprintk(4, "dev: %p\n", dev);
 
 	/* prepare the av7110 device struct */
 	if (!(av7110 = kmalloc (sizeof (struct av7110), GFP_KERNEL))) {
-		printk ("%s: out of memory!\n", __FUNCTION__);
+		dprintk(1, "out of memory\n");
 		return -ENOMEM;
 	}
-	DEB_EE(("av7110: %p\n", av7110));
+
 	memset(av7110, 0, sizeof(struct av7110));
 	
 	av7110->card_name = (char*)pci_ext->ext_priv;
@@ -1547,11 +1541,11 @@
 	}
 
 	if (FW_VERSION(av7110->arm_app)<0x2501)
-		printk ("av7110: Warning, firmware version 0x%04x is too old. "
+		printk ("dvb-ttpci: Warning, firmware version 0x%04x is too old. "
 			"System might be unstable!\n", FW_VERSION(av7110->arm_app));
 
 	if (kernel_thread(arm_thread, (void *) av7110, 0) < 0) {
-		printk(KERN_ERR "av7110(%d): faile to start arm_mon kernel thread\n",
+		printk("dvb-ttpci: failed to start arm_mon kernel thread @ card %d\n",
 		       av7110->dvb_adapter->num);
 		goto err2;
 	}
@@ -1572,7 +1566,7 @@
 	if (ret)
 		goto err3;
 
-	printk(KERN_INFO "av7110: found av7110-%d.\n",av7110_num);
+	printk(KERN_INFO "dvb-ttpci: found av7110-%d.\n", av7110_num);
 	av7110->device_initialized = 1;
 	av7110_num++;
         return 0;
@@ -1604,7 +1598,7 @@
 static int av7110_detach (struct saa7146_dev* saa)
 {
 	struct av7110 *av7110 = (struct av7110*)saa->ext_priv;
-	DEB_EE(("av7110: %p\n",av7110));
+	dprintk(4, "%p\n", av7110);
 	
 	if( 0 == av7110->device_initialized ) {
 		return 0;
@@ -1653,8 +1647,6 @@
 {
 	struct av7110 *av7110 = (struct av7110*)dev->ext_priv;
 
-//	DEB_INT(("dev: %p, av7110: %p\n",dev,av7110));
-
 	if (*isr & MASK_19)
 		tasklet_schedule (&av7110->debi_tasklet);
 	
diff -uraNwB linux-2.6.10-rc1/drivers/media/dvb/ttpci/av7110.h linux-2.6.10-rc1-patched/drivers/media/dvb/ttpci/av7110.h
--- linux-2.6.10-rc1/drivers/media/dvb/ttpci/av7110.h	2004-10-25 14:07:51.000000000 +0200
+++ linux-2.6.10-rc1-patched/drivers/media/dvb/ttpci/av7110.h	2004-10-25 14:14:43.000000000 +0200
@@ -27,6 +27,11 @@
 
 #include <media/saa7146_vv.h>
 
+extern int av7110_debug;
+
+#define dprintk(level,args...) \
+	    do { if ((av7110_debug & level)) { printk("dvb-ttpci: %s(): ", __FUNCTION__); printk(args); } } while (0)
+
 #define MAXFILT 32
 
 enum {AV_PES_STREAM, PS_STREAM, TS_STREAM, PES_STREAM};
diff -uraNwB linux-2.6.10-rc1/drivers/media/dvb/ttpci/av7110_av.c linux-2.6.10-rc1-patched/drivers/media/dvb/ttpci/av7110_av.c
--- linux-2.6.10-rc1/drivers/media/dvb/ttpci/av7110_av.c	2004-10-25 14:07:52.000000000 +0200
+++ linux-2.6.10-rc1-patched/drivers/media/dvb/ttpci/av7110_av.c	2004-10-25 14:14:43.000000000 +0200
@@ -98,8 +97,6 @@
 {
 	struct dvb_demux_feed *dvbdmxfeed = (struct dvb_demux_feed *) p2t->priv;
 
-//	DEB_EE(("struct dvb_filter_pes2ts:%p\n", p2t));
-
 	if (!(dvbdmxfeed->ts_type & TS_PACKET))
 		return 0;
 	if (buf[3] == 0xe0)	 // video PES do not have a length in TS
@@ -115,8 +112,6 @@
 {
 	struct dvb_demux_feed *dvbdmxfeed = (struct dvb_demux_feed *) priv;
 
-//	DEB_EE(("dvb_demux_feed:%p\n", dvbdmxfeed));
-
 	dvbdmxfeed->cb.ts(data, 188, NULL, 0,
 			  &dvbdmxfeed->feed.ts, DMX_OK);
 	return 0;
@@ -127,7 +122,7 @@
 {
 	struct dvb_demux *dvbdmx = dvbdmxfeed->demux;
 
-	DEB_EE(("av7110: %p, dvb_demux_feed:%p\n", av7110, dvbdmxfeed));
+	dprintk(2, "av7110:%p, , dvb_demux_feed:%p\n", av7110, dvbdmxfeed);
 
 	if (av7110->playing || (av7110->rec_mode & av))
 		return -EBUSY;
@@ -169,7 +164,7 @@
 
 int av7110_av_start_play(struct av7110 *av7110, int av)
 {
-	DEB_EE(("av7110: %p\n", av7110));
+	dprintk(2, "av7110:%p, \n", av7110);
 
 	if (av7110->rec_mode)
 		return -EBUSY;
@@ -202,7 +197,7 @@
 
 void av7110_av_stop(struct av7110 *av7110, int av)
 {
-	DEB_EE(("av7110: %p\n", av7110));
+	dprintk(2, "av7110:%p, \n", av7110);
 
 	if (!(av7110->playing & av) && !(av7110->rec_mode & av))
 		return;
@@ -243,8 +238,6 @@
 	u32 sync;
 	u16 blen;
 
-	DEB_EE(("dvb_ring_buffer_t: %p\n", buf));
-
 	if (!dlen) {
 		wake_up(&buf->queue);
 		return -1;
@@ -275,8 +268,8 @@
 
 	dvb_ringbuffer_read(buf, dest, (size_t) blen, 0);
 
-	DEB_S(("pread=0x%08lx, pwrite=0x%08lx\n",
-	       (unsigned long) buf->pread, (unsigned long) buf->pwrite));
+	dprintk(2, "pread=0x%08lx, pwrite=0x%08lx\n",
+	       (unsigned long) buf->pread, (unsigned long) buf->pwrite);
 	wake_up(&buf->queue);
 	return blen;
 }
@@ -286,7 +278,7 @@
 {
 	int err, vol, val, balance = 0;
 
-	DEB_EE(("av7110: %p\n", av7110));
+	dprintk(2, "av7110:%p, \n", av7110);
 
 	av7110->mixer.volume_left = volleft;
 	av7110->mixer.volume_right = volright;
@@ -325,7 +317,7 @@
 
 void av7110_set_vidmode(struct av7110 *av7110, int mode)
 {
-	DEB_EE(("av7110: %p\n", av7110));
+	dprintk(2, "av7110:%p, \n", av7110);
 
 	av7110_fw_cmd(av7110, COMTYPE_ENCODER, LoadVidCode, 1, mode);
 
@@ -353,7 +345,7 @@
 	int sw;
 	u8 *p;
 
-	DEB_EE(("av7110: %p\n", av7110));
+	dprintk(2, "av7110:%p, \n", av7110);
 
 	if (av7110->sinfo)
 		return;
@@ -366,7 +358,7 @@
 		vsize = ((p[1] &0x0F) << 8) | (p[2]);
 		sw = (p[3] & 0x0F);
 		av7110_set_vidmode(av7110, sw2mode[sw]);
-		DEB_S(("dvb: playback %dx%d fr=%d\n", hsize, vsize, sw));
+		dprintk(2, "playback %dx%d fr=%d\n", hsize, vsize, sw);
 		av7110->sinfo = 1;
 		break;
 	}
@@ -403,7 +395,7 @@
 static void play_video_cb(u8 *buf, int count, void *priv)
 {
 	struct av7110 *av7110 = (struct av7110 *) priv;
-	DEB_EE(("av7110: %p\n", av7110));
+	dprintk(2, "av7110:%p, \n", av7110);
 
 	if ((buf[3] & 0xe0) == 0xe0) {
 		get_video_format(av7110, buf, count);
@@ -415,7 +407,7 @@
 static void play_audio_cb(u8 *buf, int count, void *priv)
 {
 	struct av7110 *av7110 = (struct av7110 *) priv;
-	DEB_EE(("av7110: %p\n", av7110));
+	dprintk(2, "av7110:%p, \n", av7110);
 
 	aux_ring_buffer_write(&av7110->aout, buf, count);
 }
@@ -427,7 +419,7 @@
 			unsigned long count, int nonblock, int type)
 {
 	unsigned long todo = count, n;
-	DEB_EE(("av7110: %p\n", av7110));
+	dprintk(2, "av7110:%p, \n", av7110);
 
 	if (!av7110->kbuf[type])
 		return -ENOBUFS;
@@ -460,7 +452,7 @@
 			unsigned long count, int nonblock, int type)
 {
 	unsigned long todo = count, n;
-	DEB_EE(("av7110: %p\n", av7110));
+	dprintk(2, "av7110:%p, \n", av7110);
 
 	if (!av7110->kbuf[type])
 		return -ENOBUFS;
@@ -490,7 +482,7 @@
 			 unsigned long count, int nonblock, int type)
 {
 	unsigned long todo = count, n;
-	DEB_EE(("av7110: %p\n", av7110));
+	dprintk(2, "av7110:%p, \n", av7110);
 
 	if (!av7110->kbuf[type])
 		return -ENOBUFS;
@@ -769,7 +761,7 @@
 	struct av7110 *av7110 = (struct av7110 *) demux->priv;
 	struct ipack *ipack = &av7110->ipack[feed->pes_type];
 
-	DEB_EE(("av7110: %p\n", av7110));
+	dprintk(2, "av7110:%p, \n", av7110);
 
 	switch (feed->pes_type) {
 	case 0:
@@ -810,8 +802,6 @@
 	struct dvb_video_events *events = &av7110->video_events;
 	int wp;
 
-	DEB_D(("\n"));
-
 	spin_lock_bh(&events->lock);
 
 	wp = (events->eventw + 1) % MAX_VIDEO_EVENT;
@@ -834,8 +824,6 @@
 {
 	struct dvb_video_events *events = &av7110->video_events;
 
-	DEB_D(("\n"));
-
 	if (events->overflow) {
 		events->overflow = 0;
 		return -EOVERFLOW;
@@ -874,7 +862,7 @@
 	struct av7110 *av7110 = (struct av7110 *) dvbdev->priv;
 	unsigned int mask = 0;
 
-	DEB_EE(("av7110: %p\n", av7110));
+	dprintk(2, "av7110:%p, \n", av7110);
 
 	if ((file->f_flags & O_ACCMODE) != O_RDONLY)
 		poll_wait(file, &av7110->avout.queue, wait);
@@ -901,7 +889,7 @@
 	struct dvb_device *dvbdev = (struct dvb_device *) file->private_data;
 	struct av7110 *av7110 = (struct av7110 *) dvbdev->priv;
 
-	DEB_EE(("av7110: %p\n", av7110));
+	dprintk(2, "av7110:%p, \n", av7110);
 
 	if ((file->f_flags & O_ACCMODE) == O_RDONLY)
 		return -EPERM;
@@ -918,7 +906,7 @@
 	struct av7110 *av7110 = (struct av7110 *) dvbdev->priv;
 	unsigned int mask = 0;
 
-	DEB_EE(("av7110: %p\n", av7110));
+	dprintk(2, "av7110:%p, \n", av7110);
 
 	poll_wait(file, &av7110->aout.queue, wait);
 
@@ -937,7 +925,7 @@
 	struct dvb_device *dvbdev = (struct dvb_device *) file->private_data;
 	struct av7110 *av7110 = (struct av7110 *) dvbdev->priv;
 
-	DEB_EE(("av7110: %p\n", av7110));
+	dprintk(2, "av7110:%p, \n", av7110);
 
 	if (av7110->audiostate.stream_source != AUDIO_SOURCE_MEMORY) {
 		printk(KERN_ERR "not audio source memory\n");
@@ -954,7 +942,7 @@
 {
 	int i, n;
 
-	DEB_EE(("av7110: %p\n", av7110));
+	dprintk(2, "av7110:%p, \n", av7110);
 
 	if (!(av7110->playing & RP_VIDEO)) {
 		if (av7110_av_start_play(av7110, RP_VIDEO) < 0)
@@ -984,7 +972,7 @@
 	unsigned long arg = (unsigned long) parg;
 	int ret = 0;
 
-	DEB_EE(("av7110: %p\n", av7110));
+	dprintk(2, "av7110:%p, \n", av7110);
 
 	if ((file->f_flags & O_ACCMODE) == O_RDONLY) {
 		if ( cmd != VIDEO_GET_STATUS && cmd != VIDEO_GET_EVENT &&
@@ -1180,7 +1168,7 @@
 	unsigned long arg = (unsigned long) parg;
 	int ret = 0;
 
-	DEB_EE(("av7110: %p\n", av7110));
+	dprintk(2, "av7110:%p, \n", av7110);
 
 	if (((file->f_flags & O_ACCMODE) == O_RDONLY) &&
 	    (cmd != AUDIO_GET_STATUS))
@@ -1296,7 +1284,7 @@
 	struct av7110 *av7110 = (struct av7110 *) dvbdev->priv;
 	int err;
 
-	DEB_EE(("av7110: %p\n", av7110));
+	dprintk(2, "av7110:%p, \n", av7110);
 
 	if ((err = dvb_generic_open(inode, file)) < 0)
 		return err;
@@ -1320,7 +1308,7 @@
 	struct dvb_device *dvbdev = (struct dvb_device *) file->private_data;
 	struct av7110 *av7110 = (struct av7110 *) dvbdev->priv;
 
-	DEB_EE(("av7110: %p\n", av7110));
+	dprintk(2, "av7110:%p, \n", av7110);
 
 	if ((file->f_flags & O_ACCMODE) != O_RDONLY) {
 		av7110_av_stop(av7110, RP_VIDEO);
@@ -1335,7 +1323,7 @@
 	struct av7110 *av7110 = (struct av7110 *) dvbdev->priv;
 	int err=dvb_generic_open(inode, file);
 
-	DEB_EE(("av7110: %p\n", av7110));
+	dprintk(2, "av7110:%p, \n", av7110);
 
 	if (err < 0)
 		return err;
@@ -1349,7 +1337,7 @@
 	struct dvb_device *dvbdev = (struct dvb_device *) file->private_data;
 	struct av7110 *av7110 = (struct av7110 *) dvbdev->priv;
 
-	DEB_EE(("av7110: %p\n", av7110));
+	dprintk(2, "av7110:%p, \n", av7110);
 
 	av7110_av_stop(av7110, RP_AUDIO);
 	return dvb_generic_release(inode, file);
diff -uraNwB linux-2.6.10-rc1/drivers/media/dvb/ttpci/av7110_ca.c linux-2.6.10-rc1-patched/drivers/media/dvb/ttpci/av7110_ca.c
--- linux-2.6.10-rc1/drivers/media/dvb/ttpci/av7110_ca.c	2004-10-25 14:07:52.000000000 +0200
+++ linux-2.6.10-rc1-patched/drivers/media/dvb/ttpci/av7110_ca.c	2004-10-25 14:14:44.000000000 +0200
@@ -44,7 +44,7 @@
 
 void CI_handle(struct av7110 *av7110, u8 *data, u16 len)
 {
-	DEB_EE(("av7110: %p\n", av7110));
+	dprintk(8, "av7110:%p\n",av7110);
 
 	if (len < 3)
 		return;
@@ -207,7 +207,7 @@
 	struct av7110 *av7110 = (struct av7110 *) dvbdev->priv;
 	int err = dvb_generic_open(inode, file);
 
-	DEB_EE(("av7110: %p\n", av7110));
+	dprintk(8, "av7110:%p\n",av7110);
 
 	if (err < 0)
 		return err;
@@ -223,13 +223,16 @@
 	struct dvb_ringbuffer *wbuf = &av7110->ci_wbuffer;
 	unsigned int mask = 0;
 
-	DEB_EE(("av7110: %p\n", av7110));
+	dprintk(8, "av7110:%p\n",av7110);
 
 	poll_wait(file, &rbuf->queue, wait);
+	poll_wait(file, &wbuf->queue, wait);
+
 	if (!dvb_ringbuffer_empty(rbuf))
-		mask |= POLLIN;
-	if (dvb_ringbuffer_avail(wbuf) > 1024)
-		mask |= POLLOUT;
+		mask |= (POLLIN | POLLRDNORM);
+
+	if (dvb_ringbuffer_free(wbuf) > 1024)
+		mask |= (POLLOUT | POLLWRNORM);
 
 	return mask;
 }
@@ -241,7 +244,7 @@
 	struct av7110 *av7110 = (struct av7110 *) dvbdev->priv;
 	unsigned long arg = (unsigned long) parg;
 
-	DEB_EE(("av7110: %p\n", av7110));
+	dprintk(8, "av7110:%p\n",av7110);
 
 	switch (cmd) {
 	case CA_RESET:
@@ -318,7 +321,7 @@
 	struct dvb_device *dvbdev = (struct dvb_device *) file->private_data;
 	struct av7110 *av7110 = (struct av7110 *) dvbdev->priv;
 
-	DEB_EE(("av7110: %p\n", av7110));
+	dprintk(8, "av7110:%p\n",av7110);
 	return ci_ll_write(&av7110->ci_wbuffer, file, buf, count, ppos);
 }
 
@@ -328,7 +331,7 @@
 	struct dvb_device *dvbdev = (struct dvb_device *) file->private_data;
 	struct av7110 *av7110 = (struct av7110 *) dvbdev->priv;
 
-	DEB_EE(("av7110: %p\n", av7110));
+	dprintk(8, "av7110:%p\n",av7110);
 	return ci_ll_read(&av7110->ci_rbuffer, file, buf, count, ppos);
 }
 
diff -uraNwB linux-2.6.10-rc1/drivers/media/dvb/ttpci/av7110_hw.c linux-2.6.10-rc1-patched/drivers/media/dvb/ttpci/av7110_hw.c
--- linux-2.6.10-rc1/drivers/media/dvb/ttpci/av7110_hw.c	2004-10-25 14:07:50.000000000 +0200
+++ linux-2.6.10-rc1-patched/drivers/media/dvb/ttpci/av7110_hw.c	2004-10-25 14:14:44.000000000 +0200
@@ -110,7 +110,7 @@
 	IER_ENABLE(av7110->dev, MASK_03);
 
 	av7110->arm_ready = 1;
-	printk("av7110: ARM RESET\n");
+	dprintk(1, "reset ARM\n");
 }
 
 
@@ -118,7 +118,7 @@
 {
 	int k;
 
-	DEB_EE(("av7110: %p\n", av7110));
+	dprintk(4, "%p\n", av7110);
 
 	for (k = 0; k < 100; k++) {
 		if (irdebi(av7110, DEBINOSWAP, adr, 0, 2) == state)
@@ -134,7 +134,7 @@
 	int blocks, rest;
 	u32 base, bootblock = BOOT_BLOCK;
 
-	DEB_EE(("av7110: %p\n", av7110));
+	dprintk(4, "%p\n", av7110);
 
 	blocks = len / BOOT_MAX_SIZE;
 	rest = len % BOOT_MAX_SIZE;
@@ -143,7 +143,7 @@
 	for (i = 0; i < blocks; i++) {
 		if (waitdebi(av7110, BOOT_STATE, BOOTSTATE_BUFFER_EMPTY) < 0)
 			return -1;
-		DEB_D(("Writing DRAM block %d\n", i));
+		dprintk(4, "writing DRAM block %d\n", i);
 		mwdebi(av7110, DEBISWAB, bootblock,
 		       ((char*)data) + i * BOOT_MAX_SIZE, BOOT_MAX_SIZE);
 		bootblock ^= 0x1400;
@@ -206,7 +206,7 @@
 	u32 ret;
 	int i;
 
-	DEB_EE(("av7110: %p\n", av7110));
+	dprintk(4, "%p\n", av7110);
 
 	saa7146_setgpio(dev, RESET_LINE, SAA7146_GPIO_OUTLO);
 
@@ -222,17 +222,17 @@
 	/* test DEBI */
 	iwdebi(av7110, DEBISWAP, DPRAM_BASE, 0x76543210, 4);
 	if ((ret=irdebi(av7110, DEBINOSWAP, DPRAM_BASE, 0, 4)) != 0x10325476) {
-		printk(KERN_ERR "dvb: debi test in av7110_bootarm() failed: "
-		       "%08x != %08x (check your BIOS hotplug settings)\n",
+		printk(KERN_ERR "dvb-ttpci: debi test in av7110_bootarm() failed: "
+		       "%08x != %08x (check your BIOS 'Plug&Play OS' settings)\n",
 		       ret, 0x10325476);
 		return -1;
 	}
 	for (i = 0; i < 8192; i += 4)
 		iwdebi(av7110, DEBISWAP, DPRAM_BASE + i, 0x00, 4);
-	DEB_D(("av7110_bootarm: debi test OK\n"));
+	dprintk(2, "debi test OK\n");
 
 	/* boot */
-	DEB_D(("av7110_bootarm: load boot code\n"));
+	dprintk(1, "load boot code\n");
 	saa7146_setgpio(dev, ARM_IRQ_LINE, SAA7146_GPIO_IRQLO);
 	//saa7146_setgpio(dev, DEBI_DONE_LINE, SAA7146_GPIO_INPUT);
 	//saa7146_setgpio(dev, 3, SAA7146_GPIO_INPUT);
@@ -241,25 +241,25 @@
 	iwdebi(av7110, DEBINOSWAP, BOOT_STATE, BOOTSTATE_BUFFER_FULL, 2);
 
 	if (saa7146_wait_for_debi_done(av7110->dev)) {
-		printk(KERN_ERR "dvb: av7110_bootarm(): "
+		printk(KERN_ERR "dvb-ttpci: av7110_bootarm(): "
 		       "saa7146_wait_for_debi_done() timed out\n");
 		return -1;
 	}
 	saa7146_setgpio(dev, RESET_LINE, SAA7146_GPIO_OUTHI);
 	mdelay(1);
 
-	DEB_D(("av7110_bootarm: load dram code\n"));
+	dprintk(1, "load dram code\n");
 	if (load_dram(av7110, (u32 *)av7110->bin_root, av7110->size_root) < 0)
 		return -1;
 
 	saa7146_setgpio(dev, RESET_LINE, SAA7146_GPIO_OUTLO);
 	mdelay(1);
 
-	DEB_D(("av7110_bootarm: load dpram code\n"));
+	dprintk(1, "load dpram code\n");
 	mwdebi(av7110, DEBISWAB, DPRAM_BASE, av7110->bin_dpram, av7110->size_dpram);
 
 	if (saa7146_wait_for_debi_done(av7110->dev)) {
-		printk(KERN_ERR "dvb: av7110_bootarm(): "
+		printk(KERN_ERR "dvb-ttpci: av7110_bootarm(): "
 		       "saa7146_wait_for_debi_done() timed out after loading DRAM\n");
 		return -1;
 	}
@@ -289,10 +289,10 @@
 	u32 stat;
 #endif
 
-//	DEB_EE(("av7110: %p\n", av7110));
+//	dprintk(4, "%p\n", av7110);
 
 	if (!av7110->arm_ready) {
-		DEB_D(("arm not ready.\n"));
+		dprintk(1, "arm not ready.\n");
 		return -1;
 	}
 
@@ -300,7 +300,7 @@
 	while (rdebi(av7110, DEBINOSWAP, COMMAND, 0, 2 )) {
 		msleep(1);
 		if (time_after(jiffies, start + ARM_WAIT_FREE)) {
-			printk(KERN_ERR "%s: timeout waiting for COMMAND idle\n", __FUNCTION__);
+			printk(KERN_ERR "dvb-ttpci: %s(): timeout waiting for COMMAND idle\n", __FUNCTION__);
 			return -1;
 		}
 	}
@@ -310,7 +310,7 @@
 	while (rdebi(av7110, DEBINOSWAP, HANDSHAKE_REG, 0, 2 )) {
 		msleep(1);
 		if (time_after(jiffies, start + ARM_WAIT_SHAKE)) {
-			printk(KERN_ERR "%s: timeout waiting for HANDSHAKE_REG\n", __FUNCTION__);
+			printk(KERN_ERR "dvb-ttpci: %s(): timeout waiting for HANDSHAKE_REG\n", __FUNCTION__);
 			return -1;
 		}
 	}
@@ -320,7 +320,7 @@
 	while (rdebi(av7110, DEBINOSWAP, MSGSTATE, 0, 2) & OSDQFull) {
 		msleep(1);
 		if (time_after(jiffies, start + ARM_WAIT_OSD)) {
-			printk(KERN_ERR "%s: timeout waiting for !OSDQFull\n", __FUNCTION__);
+			printk(KERN_ERR "dvb-ttpci: %s(): timeout waiting for !OSDQFull\n", __FUNCTION__);
 			return -1;
 		}
 	}
@@ -339,7 +339,7 @@
 	while (rdebi(av7110, DEBINOSWAP, COMMAND, 0, 2 )) {
 		msleep(1);
 		if (time_after(jiffies, start + ARM_WAIT_FREE)) {
-			printk(KERN_ERR "%s: timeout waiting for COMMAND to complete\n",
+			printk(KERN_ERR "dvb-ttpci: %s(): timeout waiting for COMMAND to complete\n",
 			       __FUNCTION__);
 			return -1;
 		}
@@ -347,11 +347,11 @@
 
 	stat = rdebi(av7110, DEBINOSWAP, MSGSTATE, 0, 2);
 	if (stat & GPMQOver) {
-		printk(KERN_ERR "%s: GPMQOver\n", __FUNCTION__);
+		printk(KERN_ERR "dvb-ttpci: %s(): GPMQOver\n", __FUNCTION__);
 		return -1;
 	}
 	else if (stat & OSDQOver) {
-		printk(KERN_ERR "%s: OSDQOver\n", __FUNCTION__);
+		printk(KERN_ERR "dvb-ttpci: %s(): OSDQOver\n", __FUNCTION__);
 		return -1;
 	}
 #endif
@@ -363,10 +363,10 @@
 {
 	int ret;
 
-//	DEB_EE(("av7110: %p\n", av7110));
+//	dprintk(4, "%p\n", av7110);
 
 	if (!av7110->arm_ready) {
-		DEB_D(("arm not ready.\n"));
+		dprintk(1, "arm not ready.\n");
 		return -1;
 	}
 	if (down_interruptible(&av7110->dcomlock))
@@ -375,7 +375,7 @@
 	ret = __av7110_send_fw_cmd(av7110, buf, length);
 	up(&av7110->dcomlock);
 	if (ret)
-		printk("av7110_send_fw_cmd error\n");
+		printk("dvb-ttpci: %s(): av7110_send_fw_cmd error\n", __FUNCTION__);
 	return ret;
 }
 
@@ -385,7 +385,7 @@
 	u16 buf[num + 2];
 	int i, ret;
 
-//	DEB_EE(("av7110: %p\n",av7110));
+//	dprintk(4, "%p\n", av7110);
 
 	buf[0] = ((type << 8) | com);
 	buf[1] = num;
@@ -399,7 +399,7 @@
 
 	ret = av7110_send_fw_cmd(av7110, buf, num + 2);
 	if (ret)
-		printk("av7110_fw_cmd error\n");
+		printk("dvb-ttpci: av7110_fw_cmd error\n");
 	return ret;
 }
 
@@ -409,7 +409,7 @@
 	u16 cmd[18] = { ((COMTYPE_COMMON_IF << 8) + subcom),
 		16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
 
-	DEB_EE(("av7110: %p\n", av7110));
+	dprintk(4, "%p\n", av7110);
 
 	for(i = 0; i < len && i < 32; i++)
 	{
@@ -421,7 +421,7 @@
 
 	ret = av7110_send_fw_cmd(av7110, cmd, 18);
 	if (ret)
-		printk("av7110_send_ci_cmd error\n");
+		printk("dvb-ttpci: av7110_send_ci_cmd error\n");
 	return ret;
 }
 
@@ -435,10 +435,10 @@
 	u32 stat;
 #endif
 
-	DEB_EE(("av7110: %p\n", av7110));
+	dprintk(4, "%p\n", av7110);
 
 	if (!av7110->arm_ready) {
-		DEB_D(("arm not ready.\n"));
+		dprintk(1, "arm not ready.\n");
 		return -1;
 	}
 
@@ -447,7 +447,7 @@
 
 	if ((err = __av7110_send_fw_cmd(av7110, request_buf, request_buf_len)) < 0) {
 		up(&av7110->dcomlock);
-		printk("av7110_fw_request error\n");
+		printk("dvb-ttpci: av7110_fw_request error\n");
 		return err;
 	}
 
@@ -457,7 +457,7 @@
 		msleep(1);
 #endif
 		if (time_after(jiffies, start + ARM_WAIT_FREE)) {
-			printk("%s: timeout waiting for COMMAND to complete\n", __FUNCTION__);
+			printk(KERN_ERR "%s: timeout waiting for COMMAND to complete\n", __FUNCTION__);
 			up(&av7110->dcomlock);
 			return -1;
 		}
@@ -501,7 +501,7 @@
 	int ret;
 	ret = av7110_fw_request(av7110, &tag, 0, buf, length);
 	if (ret)
-		printk("av7110_fw_query error\n");
+		printk("dvb-ttpci: av7110_fw_query error\n");
 	return ret;
 }
 
@@ -516,10 +516,10 @@
 	u16 buf[20];
 	u16 tag = ((COMTYPE_REQUEST << 8) + ReqVersion);
 
-	DEB_EE(("av7110: %p\n", av7110));
+	dprintk(4, "%p\n", av7110);
 
 	if (av7110_fw_query(av7110, tag, buf, 16)) {
-		printk("DVB: AV7110-%d: ERROR: Failed to boot firmware\n",
+		printk("dvb-ttpci: failed to boot firmware @ card %d\n",
 		       av7110->dvb_adapter->num);
 		return -EIO;
 	}
@@ -530,17 +530,17 @@
 	av7110->arm_app = (buf[6] << 16) + buf[7];
 	av7110->avtype = (buf[8] << 16) + buf[9];
 
-	printk("DVB: AV711%d(%d) - firm %08x, rtsl %08x, vid %08x, app %08x\n",
-	       av7110->avtype, av7110->dvb_adapter->num, av7110->arm_fw,
+	printk("dvb-ttpci: info @ card %d: firm %08x, rtsl %08x, vid %08x, app %08x\n",
+	       av7110->dvb_adapter->num, av7110->arm_fw,
 	       av7110->arm_rtsl, av7110->arm_vid, av7110->arm_app);
 
 	/* print firmware capabilities */
 	if (FW_CI_LL_SUPPORT(av7110->arm_app))
-		printk("DVB: AV711%d(%d) - firmware supports CI link layer interface\n",
-		       av7110->avtype, av7110->dvb_adapter->num);
+		printk("dvb-ttpci: firmware @ card %d supports CI link layer interface\n",
+		       av7110->dvb_adapter->num);
 	else
-		printk("DVB: AV711%d(%d) - no firmware support for CI link layer interface\n",
-		       av7110->avtype, av7110->dvb_adapter->num);
+		printk("dvb-ttpci: no firmware support for CI link layer interface @ card %d\n",
+		       av7110->dvb_adapter->num);
 
 	return 0;
 }
@@ -552,7 +552,7 @@
 	u16 buf[18] = { ((COMTYPE_AUDIODAC << 8) + SendDiSEqC),
 			16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
 
-	DEB_EE(("av7110: %p\n", av7110));
+	dprintk(4, "%p\n", av7110);
 
 	if (len > 10)
 		len = 10;
@@ -569,7 +569,7 @@
 		buf[i + 4] = msg[i];
 
 	if (av7110_send_fw_cmd(av7110, buf, 18))
-		printk("av7110_diseqc_send error\n");
+		printk("dvb-ttpci: av7110_diseqc_send error\n");
 
 	return 0;
 }
@@ -628,7 +628,7 @@
 	while (rdebi(av7110, DEBINOSWAP, BUFF1_BASE, 0, 2)) {
 		msleep(1);
 		if (time_after(jiffies, start + ARM_WAIT_OSD)) {
-			printk(KERN_ERR "%s: timeout waiting for BUFF1_BASE == 0\n",
+			printk(KERN_ERR "dvb-ttpci: %s(): timeout waiting for BUFF1_BASE == 0\n",
 			       __FUNCTION__);
 			up(&av7110->dcomlock);
 			return -1;
@@ -652,7 +652,7 @@
 	while (rdebi(av7110, DEBINOSWAP, BUFF1_BASE, 0, 2)) {
 		msleep(1);
 		if (time_after(jiffies, start + ARM_WAIT_OSD)) {
-			printk(KERN_ERR "%s: timeout waiting for BUFF1_BASE == 0\n",
+			printk(KERN_ERR "dvb-ttpci: %s: timeout waiting for BUFF1_BASE == 0\n",
 			       __FUNCTION__);
 			up(&av7110->dcomlock);
 			return -1;
@@ -663,7 +663,7 @@
 	while (rdebi(av7110, DEBINOSWAP, HANDSHAKE_REG, 0, 2)) {
 		msleep(1);
 		if (time_after(jiffies, start + ARM_WAIT_SHAKE)) {
-			printk(KERN_ERR "%s: timeout waiting for HANDSHAKE_REG\n",
+			printk(KERN_ERR "dvb-ttpci: %s: timeout waiting for HANDSHAKE_REG\n",
 			       __FUNCTION__);
 			up(&av7110->dcomlock);
 			return -1;
@@ -678,7 +678,7 @@
 	ret = __av7110_send_fw_cmd(av7110, cbuf, 5);
 	up(&av7110->dcomlock);
 	if (ret)
-		printk("WriteText error\n");
+		printk("dvb-ttpci: WriteText error\n");
 	return ret;
 }
 
@@ -741,7 +741,7 @@
 	u8 c;
 	int ret;
 
-	DEB_EE(("av7110: %p\n", av7110));
+	dprintk(4, "%p\n", av7110);
 
 	ret = wait_event_interruptible_timeout(av7110->bmpq, av7110->bmp_state != BMP_LOADING, HZ);
 	if (ret == -ERESTARTSYS || ret == 0) {
@@ -794,7 +794,7 @@
 {
 	int ret;
 
-	DEB_EE(("av7110: %p\n", av7110));
+	dprintk(4, "%p\n", av7110);
 
 	BUG_ON (av7110->bmp_state == BMP_NONE);
 
@@ -812,7 +812,7 @@
 
 static inline int ReleaseBitmap(struct av7110 *av7110)
 {
-	DEB_EE(("av7110: %p\n",av7110));
+	dprintk(4, "%p\n", av7110);
 
 	if (av7110->bmp_state != BMP_LOADED)
 		return -1;
diff -uraNwB linux-2.6.10-rc1/drivers/media/dvb/ttpci/av7110_ir.c linux-2.6.10-rc1-patched/drivers/media/dvb/ttpci/av7110_ir.c
--- linux-2.6.10-rc1/drivers/media/dvb/ttpci/av7110_ir.c	2004-10-25 14:07:52.000000000 +0200
+++ linux-2.6.10-rc1-patched/drivers/media/dvb/ttpci/av7110_ir.c	2004-10-25 14:14:44.000000000 +0200
@@ -4,18 +4,13 @@
 #include <linux/moduleparam.h>
 #include <linux/input.h>
 #include <linux/proc_fs.h>
-#include <linux/bitops.h>
+#include <asm/bitops.h>
 
 #include "av7110.h"
 
 #define UP_TIMEOUT (HZ/4)
 
-static int av7110_ir_debug;
-
-module_param_named(debug_ir, av7110_ir_debug, int, 0644);
-MODULE_PARM_DESC(av7110_ir_debug, "Turn on/off IR debugging (default:off).");
-
-#define dprintk(x...)  do { if (av7110_ir_debug) printk (x); } while (0)
+/* enable ir debugging by or'ing av7110_debug with 16 */
 
 static struct input_dev input_dev;
 
@@ -78,7 +73,7 @@
 
 	keycode = key_map[data];
 	
-	dprintk ("#########%08x######### addr %i data 0x%02x (keycode %i)\n",
+	dprintk(16, "#########%08x######### addr %i data 0x%02x (keycode %i)\n",
 		 ircom, addr, data, keycode);
 
 	/* check device address (if selected) */
diff -uraNwB linux-2.6.10-rc1/drivers/media/dvb/ttpci/av7110_v4l.c linux-2.6.10-rc1-patched/drivers/media/dvb/ttpci/av7110_v4l.c
--- linux-2.6.10-rc1/drivers/media/dvb/ttpci/av7110_v4l.c	2004-10-25 14:07:51.000000000 +0200
+++ linux-2.6.10-rc1-patched/drivers/media/dvb/ttpci/av7110_v4l.c	2004-10-25 14:14:44.000000000 +0200
@@ -45,8 +45,8 @@
 	struct i2c_msg msgs = { .flags = 0, .addr = 0x40, .len = 5, .buf = msg };
 
 	if (i2c_transfer(&av7110->i2c_adap, &msgs, 1) != 1) {
-		printk("av7110(%d): %s(%u = %u) failed\n",
-		       av7110->dvb_adapter->num, __FUNCTION__, reg, val);
+		dprintk(1, "dvb-ttpci: failed @ card %d, %u = %u\n",
+		       av7110->dvb_adapter->num, reg, val);
 		return -EIO;
 	}
 	return 0;
@@ -62,8 +62,8 @@
 	};
 
 	if (i2c_transfer(&av7110->i2c_adap, &msgs[0], 2) != 2) {
-		printk("av7110(%d): %s(%u) failed\n",
-		       av7110->dvb_adapter->num, __FUNCTION__, reg);
+		dprintk(1, "dvb-ttpci: failed @ card %d, %u\n",
+		       av7110->dvb_adapter->num, reg);
 		return -EIO;
 	}
 	*val = (msg2[0] << 8) | msg2[1];
@@ -99,7 +97,7 @@
 	u8 buf[] = { 0x00, reg, data };
 	struct i2c_msg msg = { .addr = addr, .flags = 0, .buf = buf, .len = 3 };
 
-	DEB_EE(("av7710: dev: %p\n", dev));
+	dprintk(4, "dev: %p\n", dev);
 
 	if (1 != saa7146_i2c_transfer(dev, &msg, 1, 1))
 		return -1;
@@ -110,7 +108,7 @@
 {
 	struct i2c_msg msg = { .addr = addr, .flags = 0, .buf = data, .len = 4 };
 
-	DEB_EE(("av7710: dev: %p\n", dev));
+	dprintk(4, "dev: %p\n", dev);
 
 	if (1 != saa7146_i2c_transfer(dev, &msg, 1, 1))
 		return -1;
@@ -128,7 +126,7 @@
 	u8 config;
 	u8 buf[4];
 
-	DEB_EE(("av7710: freq: 0x%08x\n", freq));
+	dprintk(4, "freq: 0x%08x\n", freq);
 
 	/* magic number: 614. tuning with the frequency given by v4l2
 	   is always off by 614*62.5 = 38375 kHz...*/
@@ -171,13 +169,13 @@
 	u8 band = 0;
 	int source, sync, err;
 
-	DEB_EE(("av7110: %p\n", av7110));
+	dprintk(4, "%p\n", av7110);
 
 	if ((vv->video_status & STATUS_OVERLAY) != 0) {
 		vv->ov_suspend = vv->video_fh;
 		err = saa7146_stop_preview(vv->video_fh); /* side effect: video_status is now 0, video_fh is NULL */
 		if (err != 0) {
-			DEB_D(("warning: suspending video failed\n"));
+			dprintk(2, "suspending video failed\n");
 			vv->ov_suspend = NULL;
 		}
 	}
@@ -188,7 +186,7 @@
 		source = SAA7146_HPS_SOURCE_PORT_B;
 		sync = SAA7146_HPS_SYNC_PORT_B;
 		memcpy(standard, analog_standard, sizeof(struct saa7146_standard) * 2);
-		printk("av7110: switching to analog TV\n");
+		dprintk(1, "switching to analog TV\n");
 		msp_writereg(av7110, MSP_WR_DSP, 0x0008, 0x0000); // loudspeaker source
 		msp_writereg(av7110, MSP_WR_DSP, 0x0009, 0x0000); // headphone source
 		msp_writereg(av7110, MSP_WR_DSP, 0x000a, 0x0000); // SCART 1 source
@@ -201,7 +199,7 @@
 		source = SAA7146_HPS_SOURCE_PORT_A;
 		sync = SAA7146_HPS_SYNC_PORT_A;
 		memcpy(standard, dvb_standard, sizeof(struct saa7146_standard) * 2);
-		printk("av7110: switching DVB mode\n");
+		dprintk(1, "switching DVB mode\n");
 		msp_writereg(av7110, MSP_WR_DSP, 0x0008, 0x0220); // loudspeaker source
 		msp_writereg(av7110, MSP_WR_DSP, 0x0009, 0x0220); // headphone source
 		msp_writereg(av7110, MSP_WR_DSP, 0x000a, 0x0220); // SCART 1 source
@@ -212,10 +210,11 @@
 
 	/* hmm, this does not do anything!? */
 	if (av7110_fw_cmd(av7110, COMTYPE_AUDIODAC, ADSwitch, 1, adswitch))
-		printk("ADSwitch error\n");
+		dprintk(1, "ADSwitch error\n");
 
 	if (ves1820_writereg(dev, 0x0f, band))
-		printk("setting band in demodulator failed.\n");
+		dprintk(1, "setting band in demodulator failed.\n");
+
 	saa7146_set_hps_source_and_sync(dev, source, sync);
 
 	if (vv->ov_suspend != NULL) {
@@ -230,7 +229,7 @@
 {
 	struct saa7146_dev *dev = fh->dev;
 	struct av7110 *av7110 = (struct av7110*) dev->ext_priv;
-	DEB_EE(("saa7146_dev: %p\n", dev));
+	dprintk(4, "saa7146_dev: %p\n", dev);
 
 	switch (cmd) {
 	case VIDIOC_G_TUNER:
@@ -239,7 +238,7 @@
 		u16 stereo_det;
 		s8 stereo;
 
-		DEB_EE(("VIDIOC_G_TUNER: %d\n", t->index));
+		dprintk(2, "VIDIOC_G_TUNER: %d\n", t->index);
 
 		if (!av7110->has_analog_tuner || t->index != 0)
 			return -EINVAL;
@@ -258,10 +257,10 @@
 
 		// FIXME: standard / stereo detection is still broken
 		msp_readreg(av7110, MSP_RD_DEM, 0x007e, &stereo_det);
-printk("VIDIOC_G_TUNER: msp3400 TV standard detection: 0x%04x\n", stereo_det);
+		dprintk(1, "VIDIOC_G_TUNER: msp3400 TV standard detection: 0x%04x\n", stereo_det);
 
 		msp_readreg(av7110, MSP_RD_DSP, 0x0018, &stereo_det);
-		printk("VIDIOC_G_TUNER: msp3400 stereo detection: 0x%04x\n", stereo_det);
+		dprintk(1, "VIDIOC_G_TUNER: msp3400 stereo detection: 0x%04x\n", stereo_det);
 		stereo = (s8)(stereo_det >> 8);
 		if (stereo > 0x10) {
 			/* stereo */
@@ -282,29 +281,29 @@
 	{
 		struct v4l2_tuner *t = arg;
 		u16 fm_matrix, src;
-		DEB_EE(("VIDIOC_S_TUNER: %d\n", t->index));
+		dprintk(2, "VIDIOC_S_TUNER: %d\n", t->index);
 
 		if (!av7110->has_analog_tuner || av7110->current_input != 1)
 			return -EINVAL;
 
 		switch (t->audmode) {
 		case V4L2_TUNER_MODE_STEREO:
-			DEB_D(("VIDIOC_S_TUNER: V4L2_TUNER_MODE_STEREO\n"));
+			dprintk(2, "VIDIOC_S_TUNER: V4L2_TUNER_MODE_STEREO\n");
 			fm_matrix = 0x3001; // stereo
 			src = 0x0020;
 			break;
 		case V4L2_TUNER_MODE_LANG1:
-			DEB_D(("VIDIOC_S_TUNER: V4L2_TUNER_MODE_LANG1\n"));
+			dprintk(2, "VIDIOC_S_TUNER: V4L2_TUNER_MODE_LANG1\n");
 			fm_matrix = 0x3000; // mono
 			src = 0x0000;
 			break;
 		case V4L2_TUNER_MODE_LANG2:
-			DEB_D(("VIDIOC_S_TUNER: V4L2_TUNER_MODE_LANG2\n"));
+			dprintk(2, "VIDIOC_S_TUNER: V4L2_TUNER_MODE_LANG2\n");
 			fm_matrix = 0x3000; // mono
 			src = 0x0010;
 			break;
 		default: /* case V4L2_TUNER_MODE_MONO: {*/
-			DEB_D(("VIDIOC_S_TUNER: TDA9840_SET_MONO\n"));
+			dprintk(2, "VIDIOC_S_TUNER: TDA9840_SET_MONO\n");
 			fm_matrix = 0x3000; // mono
 			src = 0x0030;
 			break;
@@ -319,7 +318,7 @@
 	{
 		struct v4l2_frequency *f = arg;
 
-		DEB_EE(("VIDIOC_G_FREQ: freq:0x%08x.\n", f->frequency));
+		dprintk(2, "VIDIOC_G_FREQ: freq:0x%08x.\n", f->frequency);
 
 		if (!av7110->has_analog_tuner || av7110->current_input != 1)
 			return -EINVAL;
@@ -333,7 +332,7 @@
 	{
 		struct v4l2_frequency *f = arg;
 
-		DEB_EE(("VIDIOC_S_FREQUENCY: freq:0x%08x.\n", f->frequency));
+		dprintk(2, "VIDIOC_S_FREQUENCY: freq:0x%08x.\n", f->frequency);
 
 		if (!av7110->has_analog_tuner || av7110->current_input != 1)
 			return -EINVAL;
@@ -358,7 +357,7 @@
 	{
 		struct v4l2_input *i = arg;
 
-		DEB_EE(("VIDIOC_ENUMINPUT: %d\n", i->index));
+		dprintk(2, "VIDIOC_ENUMINPUT: %d\n", i->index);
 
 		if (av7110->has_analog_tuner ) {
 			if (i->index < 0 || i->index >= 2)
@@ -376,14 +375,14 @@
 	{
 		int *input = (int *)arg;
 		*input = av7110->current_input;
-		DEB_EE(("VIDIOC_G_INPUT: %d\n", *input));
+		dprintk(2, "VIDIOC_G_INPUT: %d\n", *input);
 		return 0;
 	}
 	case VIDIOC_S_INPUT:
 	{
 		int input = *(int *)arg;
 
-		DEB_EE(("VIDIOC_S_INPUT: %d\n", input));
+		dprintk(2, "VIDIOC_S_INPUT: %d\n", input);
 
 		if (!av7110->has_analog_tuner )
 			return 0;
@@ -399,7 +398,7 @@
 	{
 		struct v4l2_audio *a = arg;
 
-		DEB_EE(("VIDIOC_G_AUDIO: %d\n", a->index));
+		dprintk(2, "VIDIOC_G_AUDIO: %d\n", a->index);
 		if (a->index != 0)
 			return -EINVAL;
 		memcpy(a, &msp3400_v4l2_audio, sizeof(struct v4l2_audio));
@@ -408,7 +407,7 @@
 	case VIDIOC_S_AUDIO:
 	{
 		struct v4l2_audio *a = arg;
-		DEB_EE(("VIDIOC_S_AUDIO: %d\n", a->index));
+		dprintk(2, "VIDIOC_S_AUDIO: %d\n", a->index);
 		break;
 	}
 	default:
@@ -506,13 +505,13 @@
 	    || i2c_writereg(av7110, 0x80, 0x0, 0) != 1)
 		return -ENODEV;
 
-	printk("av7110(%d): DVB-C analog module detected, initializing MSP3400\n",
+	printk("dvb-ttpci: DVB-C analog module @ card %d detected, initializing MSP3400\n",
 		av7110->dvb_adapter->num);
 	av7110->adac_type = DVB_ADAC_MSP;
 	msleep(100); // the probing above resets the msp...
 	msp_readreg(av7110, MSP_RD_DSP, 0x001e, &version1);
 	msp_readreg(av7110, MSP_RD_DSP, 0x001f, &version2);
-	printk("av7110(%d): MSP3400 version 0x%04x 0x%04x\n",
+	dprintk(1, "dvb-ttpci: @ card %d MSP3400 version 0x%04x 0x%04x\n",
 		av7110->dvb_adapter->num, version1, version2);
 	msp_writereg(av7110, MSP_WR_DSP, 0x0013, 0x0c00);
 	msp_writereg(av7110, MSP_WR_DSP, 0x0000, 0x7f00); // loudspeaker + headphone
@@ -531,8 +530,7 @@
 		/* init the saa7113 */
 		while (*i != 0xff) {
 			if (i2c_writereg(av7110, 0x48, i[0], i[1]) != 1) {
-				printk("av7110(%d): saa7113 initialization failed",
-						av7110->dvb_adapter->num);
+				dprintk(1, "saa7113 initialization failed @ card %d", av7110->dvb_adapter->num);
 				break;
 			}
 			i += 2;
diff -uraNwB linux-2.6.10-rc1/drivers/media/dvb/ttpci/budget-av.c linux-2.6.10-rc1-patched/drivers/media/dvb/ttpci/budget-av.c
--- linux-2.6.10-rc1/drivers/media/dvb/ttpci/budget-av.c	2004-10-25 14:07:51.000000000 +0200
+++ linux-2.6.10-rc1-patched/drivers/media/dvb/ttpci/budget-av.c	2004-10-25 14:14:44.000000000 +0200
@@ -127,19 +123,18 @@
 	const u8 *data = saa7113_tab;
 
         if (i2c_writereg (&budget->i2c_adap, 0x4a, 0x01, 0x08) != 1) {
-                DEB_D(("saa7113: not found on KNC card\n"));
+                dprintk(1, "saa7113 not found on KNC card\n");
                 return -ENODEV;
         }
 
-        INFO(("saa7113: detected and initializing\n"));
+        dprintk(1, "saa7113 detected and initializing\n");
 
 	while (*data != 0xff) {
                 i2c_writereg(&budget->i2c_adap, 0x4a, *data, *(data+1));
                 data += 2;
         }
 
-	DEB_D(("saa7113: status=%02x\n",
-	      i2c_readreg(&budget->i2c_adap, 0x4a, 0x1f)));
+	dprintk(1, "saa7113  status=%02x\n", i2c_readreg(&budget->i2c_adap, 0x4a, 0x1f));
 
 	return 0;
 }
@@ -171,7 +164,7 @@
 	struct budget_av *budget_av = (struct budget_av*) dev->ext_priv;
 	int err;
 
-	DEB_EE(("dev: %p\n",dev));
+	dprintk(2, "dev: %p\n", dev);
 
 	if ( 1 == budget_av->has_saa7113 ) {
 	saa7146_setgpio(dev, 0, SAA7146_GPIO_OUTLO);
@@ -198,7 +191,7 @@
 	u8 *mac;
 	int err;
 
-	DEB_EE(("dev: %p\n",dev));
+	dprintk(2, "dev: %p\n", dev);
 
 	if (bi->type != BUDGET_KNC1 && bi->type != BUDGET_CIN1200) {
 		return -ENODEV;
@@ -299,7 +288,7 @@
 	{
 		struct v4l2_input *i = arg;
 		
-		DEB_EE(("VIDIOC_ENUMINPUT %d.\n",i->index));
+		dprintk(1, "VIDIOC_ENUMINPUT %d.\n", i->index);
 		if( i->index < 0 || i->index >= KNC1_INPUTS) {
 			return -EINVAL;
 		}
@@ -312,19 +301,16 @@
 
 		*input = budget_av->cur_input;
 
-		DEB_EE(("VIDIOC_G_INPUT %d.\n",*input));
+		dprintk(1, "VIDIOC_G_INPUT %d.\n", *input);
 		return 0;		
 	}	
 	case VIDIOC_S_INPUT:
 	{
 		int input = *(int *)arg;
-		DEB_EE(("VIDIOC_S_INPUT %d.\n", input));
+		dprintk(1, "VIDIOC_S_INPUT %d.\n", input);
 		return saa7113_setinput (budget_av, input);
 	}
 	default:
-/*
-		DEB2(printk("does not handle this ioctl.\n"));
-*/
 		return -ENOIOCTLCMD;
 	}
 	return 0;
@@ -384,21 +367,13 @@
 	.irq_func	= ttpci_budget_irq10_handler,
 };	
 
-
 static int __init budget_av_init(void) 
 {
-	DEB_EE((".\n"));
-
-	if (saa7146_register_extension(&budget_extension))
-		return -ENODEV;
-	
-	return 0;
+	return saa7146_register_extension(&budget_extension);
 }
 
-
 static void __exit budget_av_exit(void)
 {
-	DEB_EE((".\n"));
 	saa7146_unregister_extension(&budget_extension); 
 }
 
diff -uraNwB linux-2.6.10-rc1/drivers/media/dvb/ttpci/budget-ci.c linux-2.6.10-rc1-patched/drivers/media/dvb/ttpci/budget-ci.c
--- linux-2.6.10-rc1/drivers/media/dvb/ttpci/budget-ci.c	2004-10-25 14:07:51.000000000 +0200
+++ linux-2.6.10-rc1-patched/drivers/media/dvb/ttpci/budget-ci.c	2004-10-25 14:14:44.000000000 +0200
@@ -500,7 +491,7 @@
 {
         struct budget_ci *budget_ci = (struct budget_ci*) dev->ext_priv;
 
-        DEB_EE(("dev: %p, budget_ci: %p\n", dev, budget_ci));
+	dprintk(8, "dev: %p, budget_ci: %p\n", dev, budget_ci);
 
         if (*isr & MASK_06)
                 tasklet_schedule (&budget_ci->msp430_irq_tasklet);
@@ -523,7 +512,7 @@
 	if (!(budget_ci = kmalloc (sizeof(struct budget_ci), GFP_KERNEL)))
 		return -ENOMEM;
 
-	DEB_EE(("budget_ci: %p\n", budget_ci));
+	dprintk(2, "budget_ci: %p\n", budget_ci);
 
 	spin_lock_init(&budget_ci->debilock);
 	budget_ci->budget.ci_present = 0;
@@ -606,10 +590,8 @@
 	return saa7146_register_extension(&budget_extension);
 }
 
-
 static void __exit budget_ci_exit(void)
 {
-	DEB_EE((".\n"));
 	saa7146_unregister_extension(&budget_extension); 
 }
 
diff -uraNwB linux-2.6.10-rc1/drivers/media/dvb/ttpci/budget-core.c linux-2.6.10-rc1-patched/drivers/media/dvb/ttpci/budget-core.c
--- linux-2.6.10-rc1/drivers/media/dvb/ttpci/budget-core.c	2004-10-25 14:07:51.000000000 +0200
+++ linux-2.6.10-rc1-patched/drivers/media/dvb/ttpci/budget-core.c	2004-10-25 14:14:44.000000000 +0200
@@ -50,7 +49,7 @@
 
 static int stop_ts_capture(struct budget *budget)
 {
-	DEB_EE(("budget: %p\n",budget));
+	dprintk(2, "budget: %p\n", budget);
 
         if (--budget->feeding)
                 return budget->feeding;
@@ -65,7 +63,7 @@
 {
         struct saa7146_dev *dev=budget->dev;
 
-	DEB_EE(("budget: %p\n",budget));
+	dprintk(2, "budget: %p\n", budget);
 
         if (budget->feeding) 
                 return ++budget->feeding;
@@ -171,7 +167,7 @@
         struct budget *budget = (struct budget*) demux->priv;
 	int status;
 
-	DEB_EE(("budget: %p\n",budget));
+	dprintk(2, "budget: %p\n", budget);
 
         if (!demux->dmx.frontend)
                 return -EINVAL;
@@ -188,7 +184,7 @@
         struct budget *budget = (struct budget *) demux->priv;
 	int status;
 
-	DEB_EE(("budget: %p\n",budget));
+	dprintk(2, "budget: %p\n", budget);
 
    	spin_lock(&budget->feedlock);
 	status = stop_ts_capture (budget);
@@ -202,7 +197,7 @@
         struct dvb_demux *dvbdemux=&budget->demux;
         int ret;
 
-	DEB_EE(("budget: %p\n",budget));
+	dprintk(2, "budget: %p\n", budget);
 
         dvbdemux->priv = (void *) budget;
 
@@ -251,7 +245,7 @@
 {
         struct dvb_demux *dvbdemux=&budget->demux;
 
-	DEB_EE(("budget: %p\n",budget));
+	dprintk(2, "budget: %p\n", budget);
 
 	dvb_net_release(&budget->dvb_net);
 
@@ -294,7 +288,7 @@
 
 	memset(budget, 0, sizeof(struct budget));
 
-	DEB_EE(("dev: %p, budget: %p\n", dev, budget));
+	dprintk(2, "dev: %p, budget: %p\n", dev, budget);
 
 	budget->card = bi;
 	budget->dev = (struct saa7146_dev *) dev;
@@ -377,7 +370,7 @@
 {
 	struct saa7146_dev *dev = budget->dev;
 
-	DEB_EE(("budget: %p\n", budget));
+	dprintk(2, "budget: %p\n", budget);
 
 	budget_unregister (budget);
 
@@ -398,7 +391,7 @@
 {
 	struct budget *budget = (struct budget*)dev->ext_priv;
 
-	DEB_EE(("dev: %p, budget: %p\n",dev,budget));
+	dprintk(8, "dev: %p, budget: %p\n",dev,budget);
 
 	if (*isr & MASK_10)
 		tasklet_schedule (&budget->vpe_tasklet);
diff -uraNwB linux-2.6.10-rc1/drivers/media/dvb/ttpci/budget-patch.c linux-2.6.10-rc1-patched/drivers/media/dvb/ttpci/budget-patch.c
--- linux-2.6.10-rc1/drivers/media/dvb/ttpci/budget-patch.c	2004-10-25 14:07:52.000000000 +0200
+++ linux-2.6.10-rc1-patched/drivers/media/dvb/ttpci/budget-patch.c	2004-10-25 14:14:44.000000000 +0200
@@ -30,9 +30,9 @@
  * the project's page is at http://www.linuxtv.org/dvb/
  */
 
-#include "budget.h"
 #include "av7110.h"
 #include "av7110_hw.h"
+#include "budget.h"
 
 #define budget_patch budget
 
@@ -51,7 +51,7 @@
 {
         struct saa7146_dev *dev=budget->dev;
 
-        DEB_EE(("budget: %p\n", budget));
+        dprintk(2, "budget: %p\n", budget);
 
         if (count <= 0 || count > 4)
                 return -1;
@@ -71,7 +70,7 @@
 {
         int i;
 
-        DEB_EE(("budget: %p\n", budget));
+        dprintk(2, "budget: %p\n", budget);
 
         for (i = 2; i < length; i++)
                 budget_wdebi(budget, DEBINOSWAP, COMMAND + 2*i, (u32) buf[i], 2);
@@ -90,7 +88,7 @@
 {
         u16 buf[2] = {( COMTYPE_AUDIODAC << 8) | (state ? ON22K : OFF22K), 0};
         
-        DEB_EE(("budget: %p\n", budget));
+        dprintk(2, "budget: %p\n", budget);
         budget_av7110_send_fw_cmd(budget, buf, 2);
 }
 
@@ -101,7 +98,7 @@
         u16 buf[18] = { ((COMTYPE_AUDIODAC << 8) | SendDiSEqC),
                 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
 
-        DEB_EE(("budget: %p\n", budget));
+        dprintk(2, "budget: %p\n", budget);
 
         if (len>10)
                 len=10;
@@ -126,7 +122,7 @@
 {
         struct budget_patch *budget = fe->before_after_data;
 
-        DEB_EE(("budget: %p\n", budget));
+        dprintk(2, "budget: %p\n", budget);
 
         switch (cmd) {
         case FE_SET_TONE:
@@ -171,7 +166,7 @@
         if (!(budget = kmalloc (sizeof(struct budget_patch), GFP_KERNEL)))
                 return -ENOMEM;
 
-        DEB_EE(("budget: %p\n",budget));
+        dprintk(2, "budget: %p\n", budget);
 
         if ((err = ttpci_budget_init (budget, dev, info))) {
                 kfree (budget);
@@ -251,10 +244,8 @@
 	return saa7146_register_extension(&budget_extension);
 }
 
-
 static void __exit budget_patch_exit(void)
 {
-        DEB_EE((".\n"));
         saa7146_unregister_extension(&budget_extension); 
 }
 
diff -uraNwB linux-2.6.10-rc1/drivers/media/dvb/ttpci/budget.c linux-2.6.10-rc1-patched/drivers/media/dvb/ttpci/budget.c
--- linux-2.6.10-rc1/drivers/media/dvb/ttpci/budget.c	2004-10-25 14:07:51.000000000 +0200
+++ linux-2.6.10-rc1-patched/drivers/media/dvb/ttpci/budget.c	2004-10-25 14:14:44.000000000 +0200
@@ -39,7 +39,7 @@
 static void Set22K (struct budget *budget, int state)
 {
 	struct saa7146_dev *dev=budget->dev;
-	DEB_EE(("budget: %p\n",budget));
+	dprintk(2, "budget: %p\n", budget);
 	saa7146_setgpio(dev, 3, (state ? SAA7146_GPIO_OUTHI : SAA7146_GPIO_OUTLO));
 }
 
@@ -51,7 +51,7 @@
 static void DiseqcSendBit (struct budget *budget, int data)
 {
 	struct saa7146_dev *dev=budget->dev;
-	DEB_EE(("budget: %p\n",budget));
+	dprintk(2, "budget: %p\n", budget);
 
 	saa7146_setgpio(dev, 3, SAA7146_GPIO_OUTHI);
 	udelay(data ? 500 : 1000);
@@ -64,7 +64,7 @@
 {
 	int i, par=1, d;
 
-	DEB_EE(("budget: %p\n",budget));
+	dprintk(2, "budget: %p\n", budget);
 
 	for (i=7; i>=0; i--) {
 		d = (data>>i)&1;
@@ -81,7 +81,7 @@
 	struct saa7146_dev *dev=budget->dev;
 	int i;
 
-	DEB_EE(("budget: %p\n",budget));
+	dprintk(2, "budget: %p\n", budget);
 
 	saa7146_setgpio(dev, 3, SAA7146_GPIO_OUTLO);
 	mdelay(16);
@@ -110,7 +110,7 @@
 {
        struct budget *budget = fe->before_after_data;
 
-       DEB_EE(("budget: %p\n",budget));
+       dprintk(2, "budget: %p\n", budget);
 
        switch (cmd) {
        case FE_SET_TONE:
@@ -155,7 +155,7 @@
 {
 	struct saa7146_dev *dev=budget->dev;
 
-	DEB_EE(("budget: %p\n",budget));
+	dprintk(2, "budget: %p\n", budget);
 
 	switch (voltage) {
 		case SEC_VOLTAGE_13:
@@ -176,7 +176,7 @@
 {
 	struct budget *budget = fe->before_after_data;
 
-	DEB_EE(("budget: %p\n",budget));
+	dprintk(2, "budget: %p\n", budget);
 
 	switch (cmd) {
 		case FE_SET_VOLTAGE:
@@ -199,7 +199,7 @@
 		return -ENOMEM;
 	}
 
-	DEB_EE(("dev:%p, info:%p, budget:%p\n",dev,info,budget));
+	dprintk(2, "dev:%p, info:%p, budget:%p\n", dev, info, budget);
 
 	dev->ext_priv = budget;
 
@@ -289,7 +289,6 @@
 
 static void __exit budget_exit(void)
 {
-	DEB_EE((".\n"));
 	saa7146_unregister_extension(&budget_extension); 
 }
 
diff -uraNwB linux-2.6.10-rc1/drivers/media/dvb/ttpci/budget.h linux-2.6.10-rc1-patched/drivers/media/dvb/ttpci/budget.h
--- linux-2.6.10-rc1/drivers/media/dvb/ttpci/budget.h	2004-10-25 14:07:51.000000000 +0200
+++ linux-2.6.10-rc1-patched/drivers/media/dvb/ttpci/budget.h	2004-10-25 14:14:44.000000000 +0200
@@ -13,6 +13,13 @@
 
 extern int budget_debug;
 
+#ifdef dprintk
+#undef dprintk
+#endif
+
+#define dprintk(level,args...) \
+            do { if ((budget_debug & level)) { printk("%s: %s(): ",__stringify(KBUILD_MODNAME), __FUNCTION__); printk(args); } } while (0)
+
 struct budget_info {
 	char *name;
 	int type;

--------------000702030001000202040801--
