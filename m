Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261747AbULJQBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbULJQBk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 11:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbULJQBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 11:01:40 -0500
Received: from mail.convergence.de ([212.227.36.84]:55710 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S261747AbULJPjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 10:39:52 -0500
Message-ID: <41B9C317.4000806@linuxtv.org>
Date: Fri, 10 Dec 2004 16:39:03 +0100
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][DVB][6/6] av7110 driver update
Content-Type: multipart/mixed;
 boundary="------------050300020109090606010002"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050300020109090606010002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------050300020109090606010002
Content-Type: text/plain;
 name="06-dvb-av7110.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="06-dvb-av7110.diff"

- [DVB] av7110: fixed av7110_before_after_tune()/av7110_fe_lock_fix(): firmware >= 261d: wait for empty message queue, firmware <= 261c: wait 50ms
- [DVB] av7110: add __user and __iomem annotations, remove some unnecessary cast (patch by C.Y.M)
- [DVB] av7110: __av7110_send_fw_cmd(): added some sanity checks suggested by Werner Fin
- [DVB] av7110: added support for full-featured DVB-C cards: 13c2:0000 Siemens DVB-C (full-length card) VES1820/Philips CD1516 and  13c2:0003 Haupauge DVB-C 2.1 VES1820/ALPS TDBE2
- [DVB] av7110: follow saa7146 changes, remove superflous casts, and other misc. minor cleanups
- [DVB] av7110: Fixed race condition between driver and av7110 while accessing the COMMAND register in DPRAM. See http://www.linuxtv.org/mailinglists/vdr/2004/01-2004/msg00331.html
- [DVB] budget: various cleanups by Adrian bunk 

Signed-off-by: Michael Hunold <hunold@linuxtv.org>

diff -uraNwB linux-2.6.10-rc3-bk3/drivers/media/dvb/ttpci/av7110.c linux-2.6.10-rc3-bk3-p/drivers/media/dvb/ttpci/av7110.c
--- linux-2.6.10-rc3-bk3/drivers/media/dvb/ttpci/av7110.c	2004-12-08 14:31:32.000000000 +0100
+++ linux-2.6.10-rc3-bk3-p/drivers/media/dvb/ttpci/av7110.c	2004-12-08 14:59:12.000000000 +0100
@@ -77,7 +78,7 @@
 static int volume = 255;
 
 module_param_named(debug, av7110_debug, int, 0644);
-MODULE_PARM_DESC(av7110_debug, "Turn on/off debugging (default:off).");
+MODULE_PARM_DESC(debug, "debug level (bitmask, default 0)");
 module_param(vidmode, int, 0444);
 MODULE_PARM_DESC(vidmode,"analog video out: 0 off, 1 CVBS+RGB (default), 2 CVBS+YC, 3 YC");
 module_param(pids_off, int, 0444);
@@ -117,7 +118,7 @@
 
 	/* handle different card types */
 	/* remaining inits according to card and frontend type */
-	av7110->has_analog_tuner = 0;
+	av7110->analog_tuner_flags = 0;
 	av7110->current_input = 0;
 	if (i2c_writereg(av7110, 0x20, 0x00, 0x00) == 1) {
 		printk ("dvb-ttpci: Crystal audio DAC @ card %d detected\n",
@@ -149,10 +150,12 @@
 		// switch DVB SCART on
 		av7110_fw_cmd(av7110, COMTYPE_AUDIODAC, MainSwitch, 1, 0);
 		av7110_fw_cmd(av7110, COMTYPE_AUDIODAC, ADSwitch, 1, 1);
-		if (rgb_on)
+		if (rgb_on &&
+		    (av7110->dev->pci->subsystem_vendor == 0x110a) && (av7110->dev->pci->subsystem_device == 0x0000)) {
 			saa7146_setgpio(dev, 1, SAA7146_GPIO_OUTHI); // RGB on, SCART pin 16
 		//saa7146_setgpio(dev, 3, SAA7146_GPIO_OUTLO); // SCARTpin 8
 	}
+	}
 
 	av7110_set_volume(av7110, av7110->mixer.volume_left, av7110->mixer.volume_right);
 	av7110_setup_irc_config(av7110, 0);
@@ -192,9 +195,10 @@
 
 	av7110->arm_thread = current;
 
-	while (1) {
-		timeout = wait_event_interruptible_timeout(av7110->arm_wait,0 != av7110->arm_rmmod, 5*HZ);
-		if (-ERESTARTSYS == timeout || 0 != av7110->arm_rmmod) {
+	for (;;) {
+		timeout = wait_event_interruptible_timeout(av7110->arm_wait,
+							   av7110->arm_rmmod, 5 * HZ);
+		if (-ERESTARTSYS == timeout || av7110->arm_rmmod) {
 			/* got signal or told to quit*/
 			break;
 		}
@@ -287,7 +291,7 @@
  * IRQ handling
  ****************************************************************************/
 
-static inline int DvbDmxFilterCallback(u8 * buffer1, size_t buffer1_len,
+static int DvbDmxFilterCallback(u8 *buffer1, size_t buffer1_len,
                      u8 * buffer2, size_t buffer2_len,
                      struct dvb_demux_filter *dvbdmxfilter,
                      enum dmx_success success,
@@ -355,9 +359,8 @@
 //	dprintk(4, "%p\n",av7110);
 
         print_time("debi");
-        saa7146_write(av7110->dev, IER, 
-                      saa7146_read(av7110->dev, IER) & ~MASK_19 );
-        saa7146_write(av7110->dev, ISR, MASK_19 );
+	SAA7146_IER_DISABLE(av7110->dev, MASK_19);
+	SAA7146_ISR_CLEAR(av7110->dev, MASK_19);
 
         if (type==-1) {
 		printk("DEBI irq oops @ %ld, psr:0x%08x, ssr:0x%08x\n",
@@ -493,9 +496,8 @@
 
 	ARM_ClearIrq(av7110);
 
-        saa7146_write(av7110->dev, IER, 
-                      saa7146_read(av7110->dev, IER) & ~MASK_19 );
-        saa7146_write(av7110->dev, ISR, MASK_19 );
+	SAA7146_IER_DISABLE(av7110->dev, MASK_19);
+	SAA7146_ISR_CLEAR(av7110->dev, MASK_19);
 
         av7110->debitype = irdebi(av7110, DEBINOSWAP, IRQ_STATE, 0, 2);
         av7110->debilen  = irdebi(av7110, DEBINOSWAP, IRQ_STATE_EXT, 0, 2);
@@ -822,9 +824,13 @@
 	buf[3] = mode;
 
 	ret = av7110_fw_request(av7110, buf, 20, &handle, 1);
-	if (ret < 0) {
-		dprintk(1, "StartHWFilter error\n");
-		return ret;
+	if (ret != 0 || handle >= 32) {
+		printk("dvb-ttpci: %s error  buf %04x %04x %04x %04x  "
+				"ret %x  handle %04x\n",
+				__FUNCTION__, buf[0], buf[1], buf[2], buf[3],
+				ret, handle);
+		dvbdmxfilter->hw_handle = 0xffff;
+		return -1;
         }
 
 	av7110->handle2filter[handle] = dvbdmxfilter;
@@ -844,8 +850,9 @@
 	dprintk(4, "%p\n", av7110);
 
 	handle = dvbdmxfilter->hw_handle;
-	if (handle > 32) {
-		dprintk(1, "StopHWFilter tried to stop invalid filter %d, filter type = %d\n", handle, dvbdmxfilter->type);
+	if (handle >= 32) {
+		printk("%s tried to stop invalid filter %04x, filter type = %x\n",
+				__FUNCTION__, handle, dvbdmxfilter->type);
 		return 0;
                 }
 
@@ -855,11 +862,11 @@
 	buf[1] = 1;
 	buf[2] = handle;
 	ret = av7110_fw_request(av7110, buf, 3, answ, 2);
-	if (ret)
-		dprintk(1, "StopHWFilter error\n");
-
-	if (answ[1] != handle) {
-		dprintk(2, "filter %d shutdown error :%d\n", handle, answ[1]);
+	if (ret != 0 || answ[1] != handle) {
+		printk("dvb-ttpci: %s error  cmd %04x %04x %04x  ret %x  "
+				"resp %04x %04x  pid %d\n",
+				__FUNCTION__, buf[0], buf[1], buf[2], ret,
+				answ[0], answ[1], dvbdmxfilter->feed->pid);
 		ret = -1;
         }
         return ret;
@@ -937,7 +944,7 @@
 static int av7110_start_feed(struct dvb_demux_feed *feed)
 {
 	struct dvb_demux *demux = feed->demux;
-	struct av7110 *av7110 = (struct av7110 *) demux->priv;
+	struct av7110 *av7110 = demux->priv;
                 
 	dprintk(4, "%p\n", av7110);
                 
@@ -995,7 +1002,7 @@
 static int av7110_stop_feed(struct dvb_demux_feed *feed)
 {
 	struct dvb_demux *demux = feed->demux;
-	struct av7110 *av7110 = (struct av7110 *) demux->priv;
+	struct av7110 *av7110 = demux->priv;
 
 	dprintk(4, "%p\n", av7110);
 
@@ -1119,18 +1127,20 @@
 	return 0;
 }
 
-static int av7110_diseqc_send_master_cmd(struct dvb_frontend* fe, struct dvb_diseqc_master_cmd* cmd)
+static int av7110_diseqc_send_master_cmd(struct dvb_frontend* fe,
+					 struct dvb_diseqc_master_cmd* cmd)
 {
-	struct av7110* av7110 = (struct av7110*) fe->dvb->priv;
+	struct av7110* av7110 = fe->dvb->priv;
 
 	av7110_diseqc_send(av7110, cmd->msg_len, cmd->msg, -1);
 
 	return 0;
 }
 
-static int av7110_diseqc_send_burst(struct dvb_frontend* fe, fe_sec_mini_cmd_t minicmd)
+static int av7110_diseqc_send_burst(struct dvb_frontend* fe,
+				    fe_sec_mini_cmd_t minicmd)
 {
-	struct av7110* av7110 = (struct av7110*) fe->dvb->priv;
+	struct av7110* av7110 = fe->dvb->priv;
 
 	av7110_diseqc_send(av7110, 0, NULL, minicmd);
 
@@ -1223,7 +1233,8 @@
         dvb_dmxdev_release(&av7110->dmxdev);
         dvb_dmx_release(&av7110->demux);
 
-	if (av7110->fe != NULL) dvb_unregister_frontend(av7110->fe);
+	if (av7110->fe != NULL)
+		dvb_unregister_frontend(av7110->fe);
 	dvb_unregister_device(av7110->osd_dev);
 	av7110_av_unregister(av7110);
 	av7110_ca_unregister(av7110);
@@ -1519,7 +1530,7 @@
 
 static int alps_tdbe2_pll_set(struct dvb_frontend* fe, struct dvb_frontend_parameters* params)
 {
-	struct av7110* av7110 = (struct av7110*) fe->dvb->priv;
+	struct av7110* av7110 = fe->dvb->priv;
 	u32 div;
 	u8 data[4];
 	struct i2c_msg msg = { .addr = 0x62, .flags = 0, .buf = data, .len = sizeof(data) };
@@ -1547,9 +1558,10 @@
 
 
 
-static int grundig_29504_451_pll_set(struct dvb_frontend* fe, struct dvb_frontend_parameters* params)
+static int grundig_29504_451_pll_set(struct dvb_frontend* fe,
+				     struct dvb_frontend_parameters* params)
 {
-	struct av7110* av7110 = (struct av7110*) fe->dvb->priv;
+	struct av7110* av7110 = fe->dvb->priv;
 	u32 div;
 	u8 data[4];
 	struct i2c_msg msg = { .addr = 0x61, .flags = 0, .buf = data, .len = sizeof(data) };
@@ -1572,9 +1584,10 @@
 
 
 
-static int philips_cd1516_pll_set(struct dvb_frontend* fe, struct dvb_frontend_parameters* params)
+static int philips_cd1516_pll_set(struct dvb_frontend* fe,
+				  struct dvb_frontend_parameters* params)
 {
-        struct av7110* av7110 = (struct av7110*) fe->dvb->priv;
+        struct av7110* av7110 = fe->dvb->priv;
 	u32 div;
 	u32 f = params->frequency;
 	u8 data[4];
@@ -1604,7 +1617,7 @@
 
 static int alps_tdlb7_pll_set(struct dvb_frontend* fe, struct dvb_frontend_parameters* params)
 {
-	struct av7110* av7110 = (struct av7110*) fe->dvb->priv;
+	struct av7110* av7110 = fe->dvb->priv;
 	u32 div, pwr;
 	u8 data[4];
 	struct i2c_msg msg = { .addr = 0x60, .flags = 0, .buf = data, .len = sizeof(data) };
@@ -1644,19 +1657,18 @@
 
 static int nexusca_stv0297_pll_set(struct dvb_frontend* fe, struct dvb_frontend_parameters* params)
 {
-	struct av7110* av7110 = (struct av7110*) fe->dvb->priv;
+	struct av7110* av7110 = fe->dvb->priv;
 	u32 div;
 	u8 data[4];
 	struct i2c_msg msg = { .addr = 0x63, .flags = 0, .buf = data, .len = sizeof(data) };
 	struct i2c_msg readmsg = { .addr = 0x63, .flags = I2C_M_RD, .buf = data, .len = 1 };
 	int i;
 
-	// this calculation does not match the TDA6405TS datasheet!
 	div = (params->frequency + 36150000 + 31250) / 62500;
 
 	data[0] = (div >> 8) & 0x7f;
 	data[1] = div & 0xff;
-	data[2] = 0xce; // this value does not match the TDA6405TS datasheet!
+	data[2] = 0xce;
 
 	if (params->frequency < 45000000)
 		return -EINVAL;
@@ -1696,9 +1708,14 @@
 
 static void av7110_fe_lock_fix(struct av7110* av7110, fe_status_t status)
 {
-	msleep (50);
+	int synced = (status & FE_HAS_LOCK) ? 1 : 0;
 
-	av7110->fe_synced = (status & FE_HAS_LOCK) ? 1 : 0;
+	av7110->fe_status = status;
+
+	if (av7110->fe_synced == synced)
+		return;
+
+	av7110->fe_synced = synced;
 
 	if (av7110->playing)
 		return;
@@ -1714,16 +1731,23 @@
 	                av7110_fw_cmd(av7110, COMTYPE_PIDFILTER, Scan, 0);
 	} else {
 			SetPIDs(av7110, 0, 0, 0, 0, 0);
-	                av7110_fw_cmd(av7110, COMTYPE_PIDFILTER, FlushTSQueue, 0);
+		av7110_fw_cmd(av7110, COMTYPE_PID_FILTER, FlushTSQueue, 0);
+		av7110_wait_msgstate(av7110, GPMQBusy);
 	}
 
-	av7110->fe_status = status;
 	up(&av7110->pid_mutex);
 }
 
+static int av7110_fe_set_frontend(struct dvb_frontend* fe, struct dvb_frontend_parameters* params)
+{
+	struct av7110* av7110 = fe->dvb->priv;
+	av7110_fe_lock_fix(av7110, 0);
+	return av7110->fe_set_frontend(fe, params);
+}
+
 static int av7110_fe_init(struct dvb_frontend* fe)
 {
-   	struct av7110* av7110 = (struct av7110*) fe->dvb->priv;
+	struct av7110* av7110 = fe->dvb->priv;
 
 	av7110_fe_lock_fix(av7110, 0);
 	return av7110->fe_init(fe);
@@ -1731,7 +1755,7 @@
 
 static int av7110_fe_read_status(struct dvb_frontend* fe, fe_status_t* status)
 {
-   	struct av7110* av7110 = (struct av7110*) fe->dvb->priv;
+	struct av7110* av7110 = fe->dvb->priv;
 	int ret;
 
 	/* call the real implementation */
@@ -1748,15 +1772,16 @@
 
 static int av7110_fe_diseqc_reset_overload(struct dvb_frontend* fe)
 {
-   	struct av7110* av7110 = (struct av7110*) fe->dvb->priv;
+	struct av7110* av7110 = fe->dvb->priv;
 
 	av7110_fe_lock_fix(av7110, 0);
 	return av7110->fe_diseqc_reset_overload(fe);
 }
 
-static int av7110_fe_diseqc_send_master_cmd(struct dvb_frontend* fe, struct dvb_diseqc_master_cmd* cmd)
+static int av7110_fe_diseqc_send_master_cmd(struct dvb_frontend* fe,
+					    struct dvb_diseqc_master_cmd* cmd)
 {
-   	struct av7110* av7110 = (struct av7110*) fe->dvb->priv;
+	struct av7110* av7110 = fe->dvb->priv;
 
 	av7110_fe_lock_fix(av7110, 0);
 	return av7110->fe_diseqc_send_master_cmd(fe, cmd);
@@ -1764,7 +1789,7 @@
 
 static int av7110_fe_diseqc_send_burst(struct dvb_frontend* fe, fe_sec_mini_cmd_t minicmd)
 {
-   	struct av7110* av7110 = (struct av7110*) fe->dvb->priv;
+	struct av7110* av7110 = fe->dvb->priv;
 
 	av7110_fe_lock_fix(av7110, 0);
 	return av7110->fe_diseqc_send_burst(fe, minicmd);
@@ -1772,7 +1797,7 @@
 
 static int av7110_fe_set_tone(struct dvb_frontend* fe, fe_sec_tone_mode_t tone)
 {
-   	struct av7110* av7110 = (struct av7110*) fe->dvb->priv;
+	struct av7110* av7110 = fe->dvb->priv;
 
 	av7110_fe_lock_fix(av7110, 0);
 	return av7110->fe_set_tone(fe, tone);
@@ -1780,7 +1805,7 @@
 
 static int av7110_fe_set_voltage(struct dvb_frontend* fe, fe_sec_voltage_t voltage)
 {
-   	struct av7110* av7110 = (struct av7110*) fe->dvb->priv;
+	struct av7110* av7110 = fe->dvb->priv;
 
 	av7110_fe_lock_fix(av7110, 0);
 	return av7110->fe_set_voltage(fe, voltage);
@@ -1788,7 +1813,7 @@
 
 static int av7110_fe_dishnetwork_send_legacy_command(struct dvb_frontend* fe, unsigned int cmd)
 {
-   	struct av7110* av7110 = (struct av7110*) fe->dvb->priv;
+	struct av7110* av7110 = fe->dvb->priv;
 
 	av7110_fe_lock_fix(av7110, 0);
 	return av7110->fe_dishnetwork_send_legacy_command(fe, cmd);
@@ -1812,9 +1837,8 @@
 	if (av7110->dev->pci->subsystem_vendor == 0x110a) {
 		switch(av7110->dev->pci->subsystem_device) {
 		case 0x0000: // Fujitsu/Siemens DVB-Cable (ves1820/Philips CD1516(??))
-			av7110->fe = ves1820_attach(&philips_cd1516_config, &av7110->i2c_adap, read_pwm(av7110));
-			if (av7110->fe)
-				break;
+			av7110->fe = ves1820_attach(&philips_cd1516_config,
+						    &av7110->i2c_adap, read_pwm(av7110));
 			break;
 		}
 
@@ -1850,27 +1874,41 @@
 				av7110->fe->ops->set_tone = av7110_set_tone;
 				break;
 			}
+
+			/* Try DVB-C cards */
+			switch(av7110->dev->pci->subsystem_device) {
+			case 0x0000:
+				/* Siemens DVB-C (full-length card) VES1820/Philips CD1516 */
+				av7110->fe = ves1820_attach(&philips_cd1516_config, &av7110->i2c_adap,
+							read_pwm(av7110));
+				break;
+			case 0x0003:
+				/* Haupauge DVB-C 2.1 VES1820/ALPS TDBE2 */
+				av7110->fe = ves1820_attach(&alps_tdbe2_config, &av7110->i2c_adap,
+							read_pwm(av7110));
+				break;
+			}
 			break;
 
 		case 0x0001: // Hauppauge/TT Nexus-T premium rev1.X
 
 			// ALPS TDLB7
                         av7110->fe = sp8870_attach(&alps_tdlb7_config, &av7110->i2c_adap);
-			if (av7110->fe)
-				break;
 			break;
 
 		case 0x0002: // Hauppauge/TT DVB-C premium rev2.X
 
                         av7110->fe = ves1820_attach(&alps_tdbe2_config, &av7110->i2c_adap, read_pwm(av7110));
-			if (av7110->fe)
-				break;
 			break;
 
 		case 0x000A: // Hauppauge/TT Nexus-CA rev1.X
 
 			av7110->fe = stv0297_attach(&nexusca_stv0297_config, &av7110->i2c_adap, 0x7b);
 			if (av7110->fe) {
+				/* set TDA9819 into DVB mode */
+				saa7146_setgpio(av7110->dev, 1, SAA7146_GPIO_OUTHI); // TDA9198 pin9(STD)
+				saa7146_setgpio(av7110->dev, 3, SAA7146_GPIO_OUTLO); // TDA9198 pin30(VIF)
+
 				/* tuner on this needs a slower i2c bus speed */
 				av7110->dev->i2c_bitrate = SAA7146_I2C_BUS_BIT_RATE_240;
 				break;
@@ -1893,6 +1931,8 @@
 		FE_FUNC_OVERRIDE(av7110->fe->ops->set_tone, av7110->fe_set_tone, av7110_fe_set_tone);
 		FE_FUNC_OVERRIDE(av7110->fe->ops->set_voltage, av7110->fe_set_voltage, av7110_fe_set_voltage;)
 		FE_FUNC_OVERRIDE(av7110->fe->ops->dishnetwork_send_legacy_command, av7110->fe_dishnetwork_send_legacy_command, av7110_fe_dishnetwork_send_legacy_command);
+		FE_FUNC_OVERRIDE(av7110->fe->ops->set_frontend, av7110->fe_set_frontend, av7110_fe_set_frontend);
+
 		if (dvb_register_frontend(av7110->dvb_adapter, av7110->fe)) {
 			printk("av7110: Frontend registration failed!\n");
 			if (av7110->fe->ops->release)
@@ -1969,7 +2009,6 @@
         /* locks for data transfers from/to AV7110 */
         spin_lock_init (&av7110->debilock);
         sema_init(&av7110->dcomlock, 1);
-        av7110->debilock=SPIN_LOCK_UNLOCKED;
         av7110->debitype=-1;
 
         /* default OSD window */
@@ -2086,11 +2125,8 @@
 
 	dvb_unregister(av7110);
 	
-	IER_DISABLE(saa, (MASK_19 | MASK_03));
-//	saa7146_write (av7110->dev, IER, 
-//		     saa7146_read(av7110->dev, IER) & ~(MASK_19 | MASK_03));
-	
-	saa7146_write(av7110->dev, ISR,(MASK_19 | MASK_03));
+	SAA7146_IER_DISABLE(saa, MASK_19 | MASK_03);
+	SAA7146_ISR_CLEAR(saa, MASK_19 | MASK_03);
 
 	av7110_ca_exit(av7110);
 	av7110_av_exit(av7110);
@@ -2117,7 +2153,7 @@
 
 static void av7110_irq(struct saa7146_dev* dev, u32 *isr) 
 {
-	struct av7110 *av7110 = (struct av7110*)dev->ext_priv;
+	struct av7110 *av7110 = dev->ext_priv;
 
 	if (*isr & MASK_19)
 		tasklet_schedule (&av7110->debi_tasklet);
diff -uraNwB linux-2.6.10-rc3-bk3/drivers/media/dvb/ttpci/av7110.h linux-2.6.10-rc3-bk3-p/drivers/media/dvb/ttpci/av7110.h
--- linux-2.6.10-rc3-bk3/drivers/media/dvb/ttpci/av7110.h	2004-12-08 14:31:32.000000000 +0100
+++ linux-2.6.10-rc3-bk3-p/drivers/media/dvb/ttpci/av7110.h	2004-12-08 14:45:06.000000000 +0100
@@ -34,6 +34,11 @@
 
 #include <media/saa7146_vv.h>
 
+
+#define ANALOG_TUNER_VES1820 1
+#define ANALOG_TUNER_STV0297 2
+#define ANALOG_TUNER_VBI     0x100
+
 extern int av7110_debug;
 
 #define dprintk(level,args...) \
@@ -82,7 +87,7 @@
 	char			*card_name;
 
 	/* support for analog module of dvb-c */
-	int			has_analog_tuner;
+	int			analog_tuner_flags;
 	int			current_input;
 	u32			current_freq;
 				
@@ -122,8 +127,8 @@
 
         spinlock_t              debilock;
         struct semaphore        dcomlock;
-        int                     debitype;
-        int                     debilen;
+	volatile int		debitype;
+	volatile int		debilen;
 
 
         /* Recording and playback flags */
@@ -235,6 +240,7 @@
 	int (*fe_set_tone)(struct dvb_frontend* fe, fe_sec_tone_mode_t tone);
 	int (*fe_set_voltage)(struct dvb_frontend* fe, fe_sec_voltage_t voltage);
 	int (*fe_dishnetwork_send_legacy_command)(struct dvb_frontend* fe, unsigned int cmd);
+	int (*fe_set_frontend)(struct dvb_frontend* fe, struct dvb_frontend_parameters* params);
 };
 
 
diff -uraNwB linux-2.6.10-rc3-bk3/drivers/media/dvb/ttpci/av7110_hw.c linux-2.6.10-rc3-bk3-p/drivers/media/dvb/ttpci/av7110_hw.c
--- linux-2.6.10-rc3-bk3/drivers/media/dvb/ttpci/av7110_hw.c	2004-12-08 14:31:31.000000000 +0100
+++ linux-2.6.10-rc3-bk3-p/drivers/media/dvb/ttpci/av7110_hw.c	2004-12-08 14:45:06.000000000 +0100
@@ -110,16 +110,16 @@
 	saa7146_setgpio(av7110->dev, RESET_LINE, SAA7146_GPIO_OUTLO);
 
 	/* Disable DEBI and GPIO irq */
-	IER_DISABLE(av7110->dev, (MASK_19 | MASK_03));
-	saa7146_write(av7110->dev, ISR, (MASK_19 | MASK_03));
+	SAA7146_IER_DISABLE(av7110->dev, MASK_19 | MASK_03);
+	SAA7146_ISR_CLEAR(av7110->dev, MASK_19 | MASK_03);
 
 	saa7146_setgpio(av7110->dev, RESET_LINE, SAA7146_GPIO_OUTHI);
 	msleep(30);	/* the firmware needs some time to initialize */
 
 	ARM_ResetMailBox(av7110);
 
-	saa7146_write(av7110->dev, ISR, (MASK_19 | MASK_03));
-	IER_ENABLE(av7110->dev, MASK_03);
+	SAA7146_ISR_CLEAR(av7110->dev, MASK_19 | MASK_03);
+	SAA7146_IER_ENABLE(av7110->dev, MASK_03);
 
 	av7110->arm_ready = 1;
 	dprintk(1, "reset ARM\n");
@@ -223,8 +223,8 @@
 	saa7146_setgpio(dev, RESET_LINE, SAA7146_GPIO_OUTLO);
 
 	/* Disable DEBI and GPIO irq */
-	IER_DISABLE(av7110->dev, MASK_03 | MASK_19);
-	saa7146_write(av7110->dev, ISR, (MASK_19 | MASK_03));
+	SAA7146_IER_DISABLE(av7110->dev, MASK_03 | MASK_19);
+	SAA7146_ISR_CLEAR(av7110->dev, MASK_19 | MASK_03);
 
 	/* enable DEBI */
 	saa7146_write(av7110->dev, MC1, 0x08800880);
@@ -280,8 +280,8 @@
 
 	//ARM_ClearIrq(av7110);
 	ARM_ResetMailBox(av7110);
-	saa7146_write(av7110->dev, ISR, (MASK_19 | MASK_03));
-	IER_ENABLE(av7110->dev, MASK_03);
+	SAA7146_ISR_CLEAR(av7110->dev, MASK_19 | MASK_03);
+	SAA7146_IER_ENABLE(av7110->dev, MASK_03);
 
 	av7110->arm_errors = 0;
 	av7110->arm_ready = 1;
@@ -293,13 +293,44 @@
  * DEBI command polling
  ****************************************************************************/
 
+int av7110_wait_msgstate(struct av7110 *av7110, u16 flags)
+{
+	unsigned long start;
+	u32 stat;
+
+	if (FW_VERSION(av7110->arm_app) <= 0x261c) {
+		/* not supported by old firmware */
+		msleep(50);
+		return 0;
+	}
+	
+	/* new firmware */
+	start = jiffies;
+	for (;;) {
+		if (down_interruptible(&av7110->dcomlock))
+			return -ERESTARTSYS;
+		stat = rdebi(av7110, DEBINOSWAP, MSGSTATE, 0, 2);
+		up(&av7110->dcomlock);
+		if ((stat & flags) == 0) {
+			break;
+		}
+		if (time_after(jiffies, start + ARM_WAIT_FREE)) {
+			printk(KERN_ERR "%s: timeout waiting for MSGSTATE %04x\n",
+				__FUNCTION__, stat & flags);
+			return -1;
+		}
+		msleep(1);
+	}
+	return 0;
+}
+
 int __av7110_send_fw_cmd(struct av7110 *av7110, u16* buf, int length)
 {
 	int i;
 	unsigned long start;
-#ifdef COM_DEBUG
+	char *type = NULL;
+	u16 flags[2] = {0, 0};
 	u32 stat;
-#endif
 
 //	dprintk(4, "%p\n", av7110);
 
@@ -330,14 +361,45 @@
 	}
 #endif
 
+	switch ((buf[0] >> 8) & 0xff) {
+	case COMTYPE_PIDFILTER:
+	case COMTYPE_ENCODER:
+	case COMTYPE_REC_PLAY:
+	case COMTYPE_MPEGDECODER:
+		type = "MSG";
+		flags[0] = GPMQOver;
+		flags[1] = GPMQFull;
+		break;
+	case COMTYPE_OSD:
+		type = "OSD";
+		flags[0] = OSDQOver;
+		flags[1] = OSDQFull;
+		break;
+	default:
+		break;
+	}
+
+	if (type != NULL) {
+		/* non-immediate COMMAND type */
 	start = jiffies;
-	while (rdebi(av7110, DEBINOSWAP, MSGSTATE, 0, 2) & OSDQFull) {
-		msleep(1);
-		if (time_after(jiffies, start + ARM_WAIT_OSD)) {
-			printk(KERN_ERR "dvb-ttpci: %s(): timeout waiting for !OSDQFull\n", __FUNCTION__);
+		for (;;) {
+			stat = rdebi(av7110, DEBINOSWAP, MSGSTATE, 0, 2);
+			if (stat & flags[0]) {
+				printk(KERN_ERR "%s: %s QUEUE overflow\n",
+					__FUNCTION__, type);
+				return -1;
+			}
+			if ((stat & flags[1]) == 0)
+				break;
+			if (time_after(jiffies, start + ARM_WAIT_FREE)) {
+				printk(KERN_ERR "%s: timeout waiting on busy %s QUEUE\n",
+					__FUNCTION__, type);
 			return -1;
 		}
+			msleep(1);
+		}
 	}
+
 	for (i = 2; i < length; i++)
 		wdebi(av7110, DEBINOSWAP, COMMAND + 2 * i, (u32) buf[i], 2);
 
@@ -972,7 +1034,7 @@
 			goto out;
 		} else {
 			int i, len = dc->x0-dc->color+1;
-			u8 __user *colors = dc->data;
+			u8 __user *colors = (u8 *)dc->data;
 			u8 r, g, b, blend;
 
 			for (i = 0; i<len; i++) {
diff -uraNwB linux-2.6.10-rc3-bk3/drivers/media/dvb/ttpci/av7110_hw.h linux-2.6.10-rc3-bk3-p/drivers/media/dvb/ttpci/av7110_hw.h
--- linux-2.6.10-rc3-bk3/drivers/media/dvb/ttpci/av7110_hw.h	2004-12-08 14:31:32.000000000 +0100
+++ linux-2.6.10-rc3-bk3-p/drivers/media/dvb/ttpci/av7110_hw.h	2004-12-08 14:45:06.000000000 +0100
@@ -65,6 +65,9 @@
 #define HPQOver		0x0008
 #define OSDQFull	0x0010		/* OSD Queue Full */
 #define OSDQOver	0x0020
+#define GPMQBusy	0x0040		/* Queue not empty, FW >= 261d */
+#define HPQBusy		0x0080
+#define OSDQBusy	0x0100
 
 /* hw section filter flags */
 #define	SECTION_EIT		0x01
@@ -368,6 +371,7 @@
 #define FW_4M_SDRAM(arm_app)      ((arm_app) & 0x40000000)
 #define FW_VERSION(arm_app)	  ((arm_app) & 0x0000FFFF)
 
+extern int av7110_wait_msgstate(struct av7110 *av7110, u16 flags);
 extern int av7110_fw_cmd(struct av7110 *av7110, int type, int com, int num, ...);
 extern int __av7110_send_fw_cmd(struct av7110 *av7110, u16* buf, int length);
 extern int av7110_send_fw_cmd(struct av7110 *av7110, u16* buf, int length);
diff -uraNwB linux-2.6.10-rc3-bk3/drivers/media/dvb/ttpci/av7110_v4l.c linux-2.6.10-rc3-bk3-p/drivers/media/dvb/ttpci/av7110_v4l.c
--- linux-2.6.10-rc3-bk3/drivers/media/dvb/ttpci/av7110_v4l.c	2004-12-08 14:31:32.000000000 +0100
+++ linux-2.6.10-rc3-bk3-p/drivers/media/dvb/ttpci/av7110_v4l.c	2004-11-30 15:26:47.000000000 +0100
@@ -92,10 +90,8 @@
 	}
 };
 
-/* for Siemens DVB-C analog module: (taken from ves1820.c) */
-static int ves1820_writereg(struct saa7146_dev *dev, u8 reg, u8 data)
+static int ves1820_writereg(struct saa7146_dev *dev, u8 addr, u8 reg, u8 data)
 {
-	u8 addr = 0x09;
 	u8 buf[] = { 0x00, reg, data };
 	struct i2c_msg msg = { .addr = addr, .flags = 0, .buf = buf, .len = 3 };
 
@@ -106,6 +102,17 @@
 	return 0;
 }
 
+static int stv0297_writereg(struct saa7146_dev *dev, u8 addr, u8 reg, u8 data)
+{
+        u8 buf [] = { reg, data };
+        struct i2c_msg msg = { .addr = addr, .flags = 0, .buf = buf, .len = 2 };
+
+	if (1 != saa7146_i2c_transfer(dev, &msg, 1, 1))
+		return -1;
+	return 0;
+}
+
+
 static int tuner_write(struct saa7146_dev *dev, u8 addr, u8 data [4])
 {
 	struct i2c_msg msg = { .addr = addr, .flags = 0, .buf = data, .len = 4 };
@@ -117,12 +124,7 @@
 	return 0;
 }
 
-
-/**
- *   set up the downconverter frequency divisor for a
- *   reference clock comparision frequency of 62.5 kHz.
- */
-static int tuner_set_tv_freq(struct saa7146_dev *dev, u32 freq)
+static int ves1820_set_tv_freq(struct saa7146_dev *dev, u32 freq)
 {
 	u32 div;
 	u8 config;
@@ -151,6 +153,34 @@
 	return tuner_write(dev, 0x61, buf);
 }
 
+static int stv0297_set_tv_freq(struct saa7146_dev *dev, u32 freq)
+{
+	u32 div;
+	u8 data[4];
+
+	div = (freq + 38900000 + 31250) / 62500;
+
+	data[0] = (div >> 8) & 0x7f;
+	data[1] = div & 0xff;
+	data[2] = 0xce;
+
+	if (freq < 45000000)
+		return -EINVAL;
+	else if (freq < 137000000)
+		data[3] = 0x01;
+	else if (freq < 403000000)
+		data[3] = 0x02;
+	else if (freq < 860000000)
+		data[3] = 0x04;
+	else
+		return -EINVAL;
+
+	stv0297_writereg(dev, 0x1C, 0x87, 0x78);
+	stv0297_writereg(dev, 0x1C, 0x86, 0xc8);
+	return tuner_write(dev, 0x63, data);
+}
+
+
 
 static struct saa7146_standard analog_standard[];
 static struct saa7146_standard dvb_standard[];
@@ -168,7 +198,6 @@
 	struct saa7146_vv *vv = dev->vv_data;
 	struct av7110 *av7110 = (struct av7110*)dev->ext_priv;
 	u16 adswitch;
-	u8 band = 0;
 	int source, sync, err;
 
 	dprintk(4, "%p\n", av7110);
@@ -184,7 +213,6 @@
 
 	if (0 != av7110->current_input) {
 		adswitch = 1;
-		band = 0x60; /* analog band */
 		source = SAA7146_HPS_SOURCE_PORT_B;
 		sync = SAA7146_HPS_SYNC_PORT_B;
 		memcpy(standard, analog_standard, sizeof(struct saa7146_standard) * 2);
@@ -195,9 +223,16 @@
 		msp_writereg(av7110, MSP_WR_DSP, 0x000e, 0x3000); // FM matrix, mono
 		msp_writereg(av7110, MSP_WR_DSP, 0x0000, 0x4f00); // loudspeaker + headphone
 		msp_writereg(av7110, MSP_WR_DSP, 0x0007, 0x4f00); // SCART 1 volume
+
+		if (av7110->analog_tuner_flags & ANALOG_TUNER_VES1820) {
+			if (ves1820_writereg(dev, 0x09, 0x0f, 0x60))
+				dprintk(1, "setting band in demodulator failed.\n");
+		} else if (av7110->analog_tuner_flags & ANALOG_TUNER_STV0297) {
+			saa7146_setgpio(dev, 1, SAA7146_GPIO_OUTHI); // TDA9198 pin9(STD)
+			saa7146_setgpio(dev, 3, SAA7146_GPIO_OUTHI); // TDA9198 pin30(VIF)
+		}
 	} else {
 		adswitch = 0;
-		band = 0x20; /* digital band */
 		source = SAA7146_HPS_SOURCE_PORT_A;
 		sync = SAA7146_HPS_SYNC_PORT_A;
 		memcpy(standard, dvb_standard, sizeof(struct saa7146_standard) * 2);
@@ -208,15 +243,20 @@
 		msp_writereg(av7110, MSP_WR_DSP, 0x000e, 0x3000); // FM matrix, mono
 		msp_writereg(av7110, MSP_WR_DSP, 0x0000, 0x7f00); // loudspeaker + headphone
 		msp_writereg(av7110, MSP_WR_DSP, 0x0007, 0x7f00); // SCART 1 volume
+
+		if (av7110->analog_tuner_flags & ANALOG_TUNER_VES1820) {
+			if (ves1820_writereg(dev, 0x09, 0x0f, 0x20))
+				dprintk(1, "setting band in demodulator failed.\n");
+		} else if (av7110->analog_tuner_flags & ANALOG_TUNER_STV0297) {
+			saa7146_setgpio(dev, 1, SAA7146_GPIO_OUTHI); // TDA9198 pin9(STD)
+			saa7146_setgpio(dev, 3, SAA7146_GPIO_OUTLO); // TDA9198 pin30(VIF)
+		}
 	}
 
 	/* hmm, this does not do anything!? */
 	if (av7110_fw_cmd(av7110, COMTYPE_AUDIODAC, ADSwitch, 1, adswitch))
 		dprintk(1, "ADSwitch error\n");
 
-	if (ves1820_writereg(dev, 0x0f, band))
-		dprintk(1, "setting band in demodulator failed.\n");
-
 	saa7146_set_hps_source_and_sync(dev, source, sync);
 
 	if (vv->ov_suspend != NULL) {
@@ -242,7 +282,7 @@
 
 		dprintk(2, "VIDIOC_G_TUNER: %d\n", t->index);
 
-		if (!av7110->has_analog_tuner || t->index != 0)
+		if (!av7110->analog_tuner_flags || t->index != 0)
 			return -EINVAL;
 
 		memset(t, 0, sizeof(*t));
@@ -285,7 +325,7 @@
 		u16 fm_matrix, src;
 		dprintk(2, "VIDIOC_S_TUNER: %d\n", t->index);
 
-		if (!av7110->has_analog_tuner || av7110->current_input != 1)
+		if (!av7110->analog_tuner_flags || av7110->current_input != 1)
 			return -EINVAL;
 
 		switch (t->audmode) {
@@ -322,7 +362,7 @@
 
 		dprintk(2, "VIDIOC_G_FREQ: freq:0x%08x.\n", f->frequency);
 
-		if (!av7110->has_analog_tuner || av7110->current_input != 1)
+		if (!av7110->analog_tuner_flags || av7110->current_input != 1)
 			return -EINVAL;
 
 		memset(f, 0, sizeof(*f));
@@ -336,7 +376,7 @@
 
 		dprintk(2, "VIDIOC_S_FREQUENCY: freq:0x%08x.\n", f->frequency);
 
-		if (!av7110->has_analog_tuner || av7110->current_input != 1)
+		if (!av7110->analog_tuner_flags || av7110->current_input != 1)
 			return -EINVAL;
 
 		if (V4L2_TUNER_ANALOG_TV != f->type)
@@ -346,7 +386,11 @@
 		msp_writereg(av7110, MSP_WR_DSP, 0x0007, 0xffe0);
 
 		/* tune in desired frequency */
-		tuner_set_tv_freq(dev, f->frequency);
+		if (av7110->analog_tuner_flags & ANALOG_TUNER_VES1820) {
+			ves1820_set_tv_freq(dev, f->frequency);
+		} else if (av7110->analog_tuner_flags & ANALOG_TUNER_STV0297) {
+			stv0297_set_tv_freq(dev, f->frequency);
+		}
 		av7110->current_freq = f->frequency;
 
 		msp_writereg(av7110, MSP_WR_DSP, 0x0015, 0x003f); // start stereo detection
@@ -361,7 +405,7 @@
 
 		dprintk(2, "VIDIOC_ENUMINPUT: %d\n", i->index);
 
-		if (av7110->has_analog_tuner ) {
+		if (av7110->analog_tuner_flags) {
 			if (i->index < 0 || i->index >= 2)
 				return -EINVAL;
 		} else {
@@ -386,7 +430,7 @@
 
 		dprintk(2, "VIDIOC_S_INPUT: %d\n", input);
 
-		if (!av7110->has_analog_tuner )
+		if (!av7110->analog_tuner_flags)
 			return 0;
 
 		if (input < 0 || input >= 2)
@@ -528,7 +572,27 @@
 		INFO(("saa7113 not accessible.\n"));
 	} else {
 		u8 *i = saa7113_init_regs;
-		av7110->has_analog_tuner = 1;
+
+		if ((av7110->dev->pci->subsystem_vendor == 0x110a) && (av7110->dev->pci->subsystem_device == 0x0000)) {
+			/* Fujitsu/Siemens DVB-Cable */
+			av7110->analog_tuner_flags |= ANALOG_TUNER_VES1820;
+		} else if ((av7110->dev->pci->subsystem_vendor == 0x13c2) && (av7110->dev->pci->subsystem_device == 0x0002)) {
+			/* Hauppauge/TT DVB-C premium */
+			av7110->analog_tuner_flags |= ANALOG_TUNER_VES1820;
+		} else if ((av7110->dev->pci->subsystem_vendor == 0x13c2) && (av7110->dev->pci->subsystem_device == 0x000A)) {
+			/* Hauppauge/TT DVB-C premium */
+			av7110->analog_tuner_flags |= ANALOG_TUNER_STV0297;
+		}
+
+		/* setup for DVB by default */
+		if (av7110->analog_tuner_flags & ANALOG_TUNER_VES1820) {
+			if (ves1820_writereg(av7110->dev, 0x09, 0x0f, 0x20))
+				dprintk(1, "setting band in demodulator failed.\n");
+		} else if (av7110->analog_tuner_flags & ANALOG_TUNER_STV0297) {
+			saa7146_setgpio(av7110->dev, 1, SAA7146_GPIO_OUTHI); // TDA9198 pin9(STD)
+			saa7146_setgpio(av7110->dev, 3, SAA7146_GPIO_OUTLO); // TDA9198 pin30(VIF)
+		}
+
 		/* init the saa7113 */
 		while (*i != 0xff) {
 			if (i2c_writereg(av7110, 0x48, i[0], i[1]) != 1) {
@@ -579,7 +643,7 @@
 	/* special case DVB-C: these cards have an analog tuner
 	   plus need some special handling, so we have separate
 	   saa7146_ext_vv data for these... */
-	if (av7110->has_analog_tuner)
+	if (av7110->analog_tuner_flags)
 		ret = saa7146_vv_init(dev, &av7110_vv_data_c);
 	else
 		ret = saa7146_vv_init(dev, &av7110_vv_data_st);
@@ -594,12 +658,12 @@
 		saa7146_vv_release(dev);
 		return -ENODEV;
 	}
-	if (av7110->has_analog_tuner) {
+	if (av7110->analog_tuner_flags) {
 		if (saa7146_register_device(&av7110->vbi_dev, dev, "av7110", VFL_TYPE_VBI)) {
 			ERR(("cannot register vbi v4l2 device. skipping.\n"));
-		} else
-			/* we use this to remember that this dvb-c card can do vbi */
-			av7110->has_analog_tuner = 2;
+		} else {
+			av7110->analog_tuner_flags |= ANALOG_TUNER_VBI;
+		}
 	}
 	return 0;
 }
@@ -607,7 +671,7 @@
 int av7110_exit_v4l(struct av7110 *av7110)
 {
 	saa7146_unregister_device(&av7110->v4l_dev, av7110->dev);
-	if (2 == av7110->has_analog_tuner)
+	if (av7110->analog_tuner_flags & ANALOG_TUNER_VBI)
 		saa7146_unregister_device(&av7110->vbi_dev, av7110->dev);
 	return 0;
 }
diff -uraNwB linux-2.6.10-rc3-bk3/drivers/media/dvb/ttpci/budget-av.c linux-2.6.10-rc3-bk3-p/drivers/media/dvb/ttpci/budget-av.c
--- linux-2.6.10-rc3-bk3/drivers/media/dvb/ttpci/budget-av.c	2004-12-08 14:31:31.000000000 +0100
+++ linux-2.6.10-rc3-bk3-p/drivers/media/dvb/ttpci/budget-av.c	2004-11-30 15:26:47.000000000 +0100
@@ -563,23 +559,13 @@
 {
 	struct budget *budget = (struct budget *) fe->dvb->priv;
 	static u8 tu1216_init[] = { 0x0b, 0xf5, 0x85, 0xab };
-	static u8 disable_mc44BC374c[] = { 0x1d, 0x74, 0xa0, 0x68 };
-	struct i2c_msg tuner_msg = {.addr = 0x60,.flags = 0,.buf = tu1216_init,.len =
-			sizeof(tu1216_init) };
+	struct i2c_msg tuner_msg = {.addr = 0x60,.flags = 0,.buf = tu1216_init,.len = sizeof(tu1216_init) };
 
 	// setup PLL configuration
 	if (i2c_transfer(&budget->i2c_adap, &tuner_msg, 1) != 1)
 		return -EIO;
 	msleep(1);
 
-	// disable the mc44BC374c (do not check for errors)
-	tuner_msg.addr = 0x65;
-	tuner_msg.buf = disable_mc44BC374c;
-	tuner_msg.len = sizeof(disable_mc44BC374c);
-	if (i2c_transfer(&budget->i2c_adap, &tuner_msg, 1) != 1) {
-		i2c_transfer(&budget->i2c_adap, &tuner_msg, 1);
-	}
-
 	return 0;
 }
 
@@ -593,7 +579,7 @@
 	u8 band, cp, filter;
 
 	// determine charge pump
-	tuner_frequency = params->frequency + 36130000;
+	tuner_frequency = params->frequency + 36166000;
 	if (tuner_frequency < 87000000)
 		return -EINVAL;
 	else if (tuner_frequency < 130000000)
@@ -620,7 +606,7 @@
 	// determine band
 	if (params->frequency < 49000000)
 		return -EINVAL;
-	else if (params->frequency < 159000000)
+	else if (params->frequency < 161000000)
 		band = 1;
 	else if (params->frequency < 444000000)
 		band = 2;
@@ -632,17 +618,14 @@
 	// setup PLL filter
 	switch (params->u.ofdm.bandwidth) {
 	case BANDWIDTH_6_MHZ:
-		tda1004x_write_byte(fe, 0x0C, 0);
 		filter = 0;
 		break;
 
 	case BANDWIDTH_7_MHZ:
-		tda1004x_write_byte(fe, 0x0C, 0);
 		filter = 0;
 		break;
 
 	case BANDWIDTH_8_MHZ:
-		tda1004x_write_byte(fe, 0x0C, 0xFF);
 		filter = 1;
 		break;
 
@@ -651,11 +634,11 @@
 	}
 
 	// calculate divisor
-	// ((36130000+((1000000/6)/2)) + Finput)/(1000000/6)
-	tuner_frequency = (((params->frequency / 1000) * 6) + 217280) / 1000;
+	// ((36166000+((1000000/6)/2)) + Finput)/(1000000/6)
+	tuner_frequency = (((params->frequency / 1000) * 6) + 217496) / 1000;
 
 	// setup tuner buffer
-	tuner_buf[0] = tuner_frequency >> 8;
+	tuner_buf[0] = (tuner_frequency >> 8) & 0x7f;
 	tuner_buf[1] = tuner_frequency & 0xff;
 	tuner_buf[2] = 0xca;
 	tuner_buf[3] = (cp << 5) | (filter << 3) | band;
@@ -679,6 +662,7 @@
 
 	.demod_address = 0x8,
 	.invert = 1,
+	.invert_oclk = 1,
 	.pll_init = philips_tu1216_pll_init,
 	.pll_set = philips_tu1216_pll_set,
 	.request_firmware = philips_tu1216_request_firmware,
diff -uraNwB linux-2.6.10-rc3-bk3/drivers/media/dvb/ttpci/budget-ci.c linux-2.6.10-rc3-bk3-p/drivers/media/dvb/ttpci/budget-ci.c
--- linux-2.6.10-rc3-bk3/drivers/media/dvb/ttpci/budget-ci.c	2004-12-08 14:31:32.000000000 +0100
+++ linux-2.6.10-rc3-bk3-p/drivers/media/dvb/ttpci/budget-ci.c	2004-11-30 15:26:47.000000000 +0100
@@ -844,6 +837,7 @@
 
 	.demod_address = 0x8,
 	.invert = 0,
+	.invert_oclk = 0,
 	.pll_init = philips_tdm1316l_pll_init,
 	.pll_set = philips_tdm1316l_pll_set,
 	.request_firmware = philips_tdm1316l_request_firmware,
diff -uraNwB linux-2.6.10-rc3-bk3/drivers/media/dvb/ttpci/budget-core.c linux-2.6.10-rc3-bk3-p/drivers/media/dvb/ttpci/budget-core.c
--- linux-2.6.10-rc3-bk3/drivers/media/dvb/ttpci/budget-core.c	2004-12-08 14:31:32.000000000 +0100
+++ linux-2.6.10-rc3-bk3-p/drivers/media/dvb/ttpci/budget-core.c	2004-11-30 15:26:47.000000000 +0100
@@ -56,7 +55,7 @@
                 return budget->feeding;
 
         saa7146_write(budget->dev, MC1, MASK_20); // DMA3 off
-	IER_DISABLE(budget->dev, MASK_10);
+	SAA7146_IER_DISABLE(budget->dev, MASK_10);
         return 0;
 }
 
@@ -124,7 +122,7 @@
       	saa7146_write(dev, MC2, (MASK_04 | MASK_20));
      	saa7146_write(dev, MC1, (MASK_04 | MASK_20)); // DMA3 on
 
-	IER_ENABLE(budget->dev, MASK_10); // VPE
+	SAA7146_IER_ENABLE(budget->dev, MASK_10);	// VPE
 
         return ++budget->feeding;
 }
diff -uraNwB linux-2.6.10-rc3-bk3/drivers/media/dvb/ttusb-budget/Kconfig linux-2.6.10-rc3-bk3-p/drivers/media/dvb/ttusb-budget/Kconfig
--- linux-2.6.10-rc3-bk3/drivers/media/dvb/ttusb-budget/Kconfig	2004-12-08 14:31:33.000000000 +0100
+++ linux-2.6.10-rc3-bk3-p/drivers/media/dvb/ttusb-budget/Kconfig	2004-11-30 15:26:47.000000000 +0100
@@ -3,6 +3,8 @@
 	depends on DVB_CORE && USB
 	select DVB_CX22700
 	select DVB_TDA1004X
+	select DVB_TDA8083
+	select DVB_STV0299
 	help
 	  Support for external USB adapters designed by Technotrend and
 	  produced by Hauppauge, shipped under the brand name 'Nova-USB'.
diff -uraNwB linux-2.6.10-rc3-bk3/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c linux-2.6.10-rc3-bk3-p/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c
--- linux-2.6.10-rc3-bk3/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2004-12-08 14:31:34.000000000 +0100
+++ linux-2.6.10-rc3-bk3-p/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2004-11-30 15:26:47.000000000 +0100
@@ -26,6 +26,8 @@
 #include "dvb_net.h"
 #include "cx22700.h"
 #include "tda1004x.h"
+#include "stv0299.h"
+#include "tda8083.h"
 
 #include <linux/dvb/frontend.h>
 #include <linux/dvb/dmx.h>
@@ -489,7 +492,6 @@
 }
 #endif
 
-#if 0
 static int ttusb_update_lnb(struct ttusb *ttusb)
 {
 	u8 b[] = { 0xaa, ++ttusb->c, 0x16, 5, /*power: */ 1,
@@ -524,7 +526,6 @@
 	return ttusb_update_lnb(ttusb);
 }
 #endif
-#endif
 
 
 #if 0
@@ -1177,7 +1178,8 @@
 	tuner_buf[2] = 0xca;
 	tuner_buf[3] = (cp << 5) | (filter << 3) | band;
 
-	if (i2c_transfer(&ttusb->i2c_adap, &tuner_msg, 1) != 1) return -EIO;
+	if (i2c_transfer(&ttusb->i2c_adap, &tuner_msg, 1) != 1)
+		return -EIO;
 
 	msleep(1);
 	return 0;
@@ -1194,24 +1196,187 @@
 
 	.demod_address = 0x8,
 	.invert = 1,
+	.invert_oclk = 0,
 	.pll_init = philips_tdm1316l_pll_init,
 	.pll_set = philips_tdm1316l_pll_set,
 	.request_firmware = philips_tdm1316l_request_firmware,
 };
 
 
+static u8 alps_bsru6_inittab[] = {
+	0x01, 0x15,
+	0x02, 0x00,
+	0x03, 0x00,
+	0x04, 0x7d,		/* F22FR = 0x7d, F22 = f_VCO / 128 / 0x7d = 22 kHz */
+	0x05, 0x35,		/* I2CT = 0, SCLT = 1, SDAT = 1 */
+	0x06, 0x40,		/* DAC not used, set to high impendance mode */
+	0x07, 0x00,		/* DAC LSB */
+	0x08, 0x40,		/* DiSEqC off, LNB power on OP2/LOCK pin on */
+	0x09, 0x00,		/* FIFO */
+	0x0c, 0x51,		/* OP1 ctl = Normal, OP1 val = 1 (LNB Power ON) */
+	0x0d, 0x82,		/* DC offset compensation = ON, beta_agc1 = 2 */
+	0x0e, 0x23,		/* alpha_tmg = 2, beta_tmg = 3 */
+	0x10, 0x3f,		// AGC2  0x3d
+	0x11, 0x84,
+	0x12, 0xb5,		// Lock detect: -64  Carrier freq detect:on
+	0x15, 0xc9,		// lock detector threshold
+	0x16, 0x00,
+	0x17, 0x00,
+	0x18, 0x00,
+	0x19, 0x00,
+	0x1a, 0x00,
+	0x1f, 0x50,
+	0x20, 0x00,
+	0x21, 0x00,
+	0x22, 0x00,
+	0x23, 0x00,
+	0x28, 0x00,		// out imp: normal  out type: parallel FEC mode:0
+	0x29, 0x1e,		// 1/2 threshold
+	0x2a, 0x14,		// 2/3 threshold
+	0x2b, 0x0f,		// 3/4 threshold
+	0x2c, 0x09,		// 5/6 threshold
+	0x2d, 0x05,		// 7/8 threshold
+	0x2e, 0x01,
+	0x31, 0x1f,		// test all FECs
+	0x32, 0x19,		// viterbi and synchro search
+	0x33, 0xfc,		// rs control
+	0x34, 0x93,		// error control
+	0x0f, 0x52,
+	0xff, 0xff
+};
+
+static int alps_bsru6_set_symbol_rate(struct dvb_frontend *fe, u32 srate, u32 ratio)
+{
+	u8 aclk = 0;
+	u8 bclk = 0;
+
+	if (srate < 1500000) {
+		aclk = 0xb7;
+		bclk = 0x47;
+	} else if (srate < 3000000) {
+		aclk = 0xb7;
+		bclk = 0x4b;
+	} else if (srate < 7000000) {
+		aclk = 0xb7;
+		bclk = 0x4f;
+	} else if (srate < 14000000) {
+		aclk = 0xb7;
+		bclk = 0x53;
+	} else if (srate < 30000000) {
+		aclk = 0xb6;
+		bclk = 0x53;
+	} else if (srate < 45000000) {
+		aclk = 0xb4;
+		bclk = 0x51;
+	}
+
+	stv0299_writereg(fe, 0x13, aclk);
+	stv0299_writereg(fe, 0x14, bclk);
+	stv0299_writereg(fe, 0x1f, (ratio >> 16) & 0xff);
+	stv0299_writereg(fe, 0x20, (ratio >> 8) & 0xff);
+	stv0299_writereg(fe, 0x21, (ratio) & 0xf0);
+
+	return 0;
+}
+
+static int alps_bsru6_pll_set(struct dvb_frontend *fe, struct dvb_frontend_parameters *params)
+{
+	struct ttusb* ttusb = (struct ttusb*) fe->dvb->priv;
+	u8 buf[4];
+	u32 div;
+	struct i2c_msg msg = {.addr = 0x61,.flags = 0,.buf = buf,.len = sizeof(buf) };
+
+	if ((params->frequency < 950000) || (params->frequency > 2150000))
+		return -EINVAL;
+
+	div = (params->frequency + (125 - 1)) / 125;	// round correctly
+	buf[0] = (div >> 8) & 0x7f;
+	buf[1] = div & 0xff;
+	buf[2] = 0x80 | ((div & 0x18000) >> 10) | 4;
+	buf[3] = 0xC4;
+
+	if (params->frequency > 1530000)
+		buf[3] = 0xc0;
+
+	if (i2c_transfer(&ttusb->i2c_adap, &msg, 1) != 1)
+		return -EIO;
+
+	return 0;
+}
+
+static struct stv0299_config alps_bsru6_config = {
+
+	.demod_address = 0x68,
+	.inittab = alps_bsru6_inittab,
+	.mclk = 88000000UL,
+	.invert = 1,
+	.enhanced_tuning = 0,
+	.skip_reinit = 0,
+	.lock_output = STV0229_LOCKOUTPUT_1,
+	.volt13_op0_op1 = STV0299_VOLT13_OP1,
+	.min_delay_ms = 100,
+	.set_symbol_rate = alps_bsru6_set_symbol_rate,
+	.pll_set = alps_bsru6_pll_set,
+};
+
+static int ttusb_novas_grundig_29504_491_pll_set(struct dvb_frontend *fe, struct dvb_frontend_parameters *params)
+{
+	struct ttusb* ttusb = (struct ttusb*) fe->dvb->priv;
+	u8 buf[4];
+	u32 div;
+	struct i2c_msg msg = {.addr = 0x61,.flags = 0,.buf = buf,.len = sizeof(buf) };
+
+        div = params->frequency / 125;
+
+	buf[0] = (div >> 8) & 0x7f;
+	buf[1] = div & 0xff;
+	buf[2] = 0x8e;
+	buf[3] = 0x00;
+
+	if (i2c_transfer(&ttusb->i2c_adap, &msg, 1) != 1)
+		return -EIO;
+
+	return 0;
+}
+
+static struct tda8083_config ttusb_novas_grundig_29504_491_config = {
+
+	.demod_address = 0x68,
+	.pll_set = ttusb_novas_grundig_29504_491_pll_set,
+};
+
+
 
 static void frontend_init(struct ttusb* ttusb)
 {
 	switch(ttusb->dev->descriptor.idProduct) {
+	case 0x1003: // Hauppauge/TT Nova-USB-S budget (stv0299/ALPS BSRU6(tsa5059)
+		// try the ALPS BSRU6 first
+		ttusb->fe = stv0299_attach(&alps_bsru6_config, &ttusb->i2c_adap);
+		if (ttusb->fe != NULL) {
+			ttusb->fe->ops->set_voltage = ttusb_set_voltage;
+			break;
+		}
+
+		// Grundig 29504-491
+		ttusb->fe = tda8083_attach(&ttusb_novas_grundig_29504_491_config, &ttusb->i2c_adap);
+		if (ttusb->fe != NULL) {
+			ttusb->fe->ops->set_voltage = ttusb_set_voltage;
+			break;
+		}
+
+		break;
+
 	case 0x1005: // Hauppauge/TT Nova-USB-t budget (tda10046/Philips td1316(tda6651tt) OR cx22700/ALPS TDMB7(??))
 		// try the ALPS TDMB7 first
 		ttusb->fe = cx22700_attach(&alps_tdmb7_config, &ttusb->i2c_adap);
-		if (ttusb->fe != NULL) break;
+		if (ttusb->fe != NULL)
+			break;
 
 		// Philips td1316
 		ttusb->fe = tda10046_attach(&philips_tdm1316l_config, &ttusb->i2c_adap);
-		if (ttusb->fe != NULL) break;
+		if (ttusb->fe != NULL)
+			break;
 		break;
 	}
 
@@ -1382,7 +1547,7 @@
 }
 
 static struct usb_device_id ttusb_table[] = {
-/*	{USB_DEVICE(0xb48, 0x1003)},UNDEFINED HARDWARE - mail linuxtv.org list */
+	{USB_DEVICE(0xb48, 0x1003)},
 /*	{USB_DEVICE(0xb48, 0x1004)},UNDEFINED HARDWARE - mail linuxtv.org list*/	/* to be confirmed ????  */
 	{USB_DEVICE(0xb48, 0x1005)},
 	{}
diff -uraNwB linux-2.6.10-rc3-bk3/include/linux/dvb/frontend.h linux-2.6.10-rc3-bk3-p/include/linux/dvb/frontend.h
--- linux-2.6.10-rc3-bk3/include/linux/dvb/frontend.h	2004-12-08 14:31:00.000000000 +0100
+++ linux-2.6.10-rc3-bk3-p/include/linux/dvb/frontend.h	2004-11-30 16:21:13.000000000 +0100
@@ -62,7 +62,7 @@
 	FE_CAN_HIERARCHY_AUTO         = 0x100000,
 	FE_CAN_8VSB			= 0x200000,
 	FE_CAN_16VSB			= 0x400000,
-	FE_NEEDS_BENDING              = 0x20000000, // frontend requires frequency bending
+	FE_NEEDS_BENDING		= 0x20000000, // not supported anymore, don't use (frontend requires frequency bending)
 	FE_CAN_RECOVER                = 0x40000000, // frontend can recover from a cable unplug automatically
 	FE_CAN_MUTE_TS                = 0x80000000  // frontend can stop spurious TS data output
 } fe_caps_t;

--------------050300020109090606010002--
