Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268800AbUIQPZw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268800AbUIQPZw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 11:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268878AbUIQPZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 11:25:52 -0400
Received: from mail.convergence.de ([212.227.36.84]:17316 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S268800AbUIQOkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 10:40:20 -0400
Message-ID: <414AF71B.5070702@linuxtv.org>
Date: Fri, 17 Sep 2004 16:39:23 +0200
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][2.6][12/14] misc. driver updates
References: <414AF2CA.3000502@linuxtv.org> <414AF31B.1090103@linuxtv.org> <414AF399.3030708@linuxtv.org> <414AF41A.6060009@linuxtv.org> <414AF461.4050707@linuxtv.org> <414AF4CE.7000000@linuxtv.org> <414AF51D.4060308@linuxtv.org> <414AF569.2020803@linuxtv.org> <414AF5BF.4020401@linuxtv.org> <414AF605.5040605@linuxtv.org> <414AF65F.2010200@linuxtv.org> <414AF6B1.9040706@linuxtv.org>
In-Reply-To: <414AF6B1.9040706@linuxtv.org>
Content-Type: multipart/mixed;
 boundary="------------020300010707090107020003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020300010707090107020003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------020300010707090107020003
Content-Type: text/plain;
 name="12-DVB-misc-driver-updates.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="12-DVB-misc-driver-updates.diff"

- [DVB] av7110: convert MODULE_PARM() to module_param(), replace home-brewn waiting stuff in osd code with wait_event_interruptible_timeout()
- [DVB] av7110: put a semaphore around osd calls to make sure they're properly serialized, timeout variable in arm_thread() must be int, not unsigned long
- [DVB] av7110: add additional OSD window types (patch by Jeremy Jones), new ioctl OSD_GET_CAPABILITY/OSD_CAP_MEMSIZE; returns size of OSD memory
- [DVB] av7110: put audio/video initialization into separate function init_av7110_av(); call this function after system initialization and after arm crash to restore the previous state; thanks to Soeren Sonnenburg <bugreports@nn7.de> for this patch.
- [DVB] av7110, budget, ttusb-budget: remove dvb i2c remains, support kernel i2c
- [DVB] av7110, budget: use msleep() instead of my_wait(), thanks to Kernel Janitors/Nishanth Aravamudan <nacc@us.ibm.com>
- [DVB] av7110, budget: fix videodev has no release callback
- [DVB] av7110: more sparse annotiations
- [DVB] budget: add support for TerraTec Cinergy 1200 DVB-S
- [DVB] budget: fix race condition in irq handler
- [DVB] skystar2, av7110, ttusb-budget, budget: make i2c client_(un)register() functions static

Signed-off-by: Michael Hunold <hunold@linuxtv.org>

diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/ttpci/av7110_av.c linux-2.6.8.1-patched/drivers/media/dvb/ttpci/av7110_av.c
--- xx-linux-2.6.8.1/drivers/media/dvb/ttpci/av7110_av.c	2004-08-23 09:34:58.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/ttpci/av7110_av.c	2004-08-18 19:52:18.000000000 +0200
@@ -37,14 +37,10 @@
 #include <linux/smp_lock.h>
 #include <linux/fs.h>
 
-#define DEBUG_VARIABLE av7110_debug
-extern int av7110_debug;
-
 #include "av7110.h"
 #include "av7110_hw.h"
 #include "av7110_av.h"
 #include "av7110_ipack.h"
-#include "dvb_functions.h"
 
 /* MPEG-2 (ISO 13818 / H.222.0) stream types */
 #define PROG_STREAM_MAP  0xBC
@@ -292,6 +286,9 @@
 
 	DEB_EE(("av7110: %p\n", av7110));
 
+	av7110->mixer.volume_left = volleft;
+	av7110->mixer.volume_right = volright;
+
 	switch (av7110->adac_type) {
 	case DVB_ADAC_TI:
 		volleft = (volleft * 256) / 1036;
diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/ttpci/av7110.c linux-2.6.8.1-patched/drivers/media/dvb/ttpci/av7110.c
--- xx-linux-2.6.8.1/drivers/media/dvb/ttpci/av7110.c	2004-08-23 09:34:58.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/ttpci/av7110.c	2004-08-18 19:52:18.000000000 +0200
@@ -41,6 +41,7 @@
 #include <linux/smp_lock.h>
 
 #include <linux/kernel.h>
+#include <linux/moduleparam.h>
 #include <linux/sched.h>
 #include <linux/types.h>
 #include <linux/fcntl.h>
@@ -50,18 +51,14 @@
 #include <linux/vmalloc.h>
 #include <linux/firmware.h>
 #include <linux/crc32.h>
+#include <linux/i2c.h>
 
 #include <asm/system.h>
 #include <asm/semaphore.h>
 
 #include <linux/dvb/frontend.h>
 
-#include "dvb_i2c.h"
 #include "dvb_frontend.h"
-#include "dvb_functions.h"
-
-
-	#define DEBUG_VARIABLE av7110_debug
 
 #include "ttpci-eeprom.h"
 #include "av7110.h"
@@ -70,26 +67,93 @@
 #include "av7110_ca.h"
 #include "av7110_ipack.h"
 
-
-static void restart_feeds(struct av7110 *av7110);
-
-int av7110_debug = 0;
-
+static int av7110_debug;
 static int vidmode=CVBS_RGB_OUT;
 static int pids_off;
 static int adac=DVB_ADAC_TI;
-static int hw_sections = 0;
-static int rgb_on = 0;
+static int hw_sections;
+static int rgb_on;
+static int volume = 255;
+
+module_param_named(debug, av7110_debug, int, 0644);
+MODULE_PARM_DESC(av7110_debug, "Turn on/off debugging (default:off).");
+module_param(vidmode, int, 0444);
+MODULE_PARM_DESC(vidmode,"analog video out: 0 off, 1 CVBS+RGB (default), 2 CVBS+YC, 3 YC");
+module_param(pids_off, int, 0444);
+MODULE_PARM_DESC(pids_off,"clear video/audio/PCR PID filters when demux is closed");
+module_param(adac, int, 0444);
+MODULE_PARM_DESC(adac,"audio DAC type: 0 TI, 1 CRYSTAL, 2 MSP (use if autodetection fails)");
+module_param(hw_sections, int, 0444);
+MODULE_PARM_DESC(hw_sections, "0 use software section filter, 1 use hardware");
+module_param(rgb_on, int, 0444);
+MODULE_PARM_DESC(rgb_on, "For Siemens DVB-C cards only: Enable RGB control"
+		" signal on SCART pin 16 to switch SCART video mode from CVBS to RGB");
+module_param(volume, int, 0444);
+MODULE_PARM_DESC(volume, "initial volume: default 255 (range 0-255)");
+
+static void restart_feeds(struct av7110 *av7110);
 
 int av7110_num = 0;
 
+static void init_av7110_av(struct av7110 *av7110)
+{
+	struct saa7146_dev *dev=av7110->dev;
+
+	/* set internal volume control to maximum */
+	av7110->adac_type = DVB_ADAC_TI;
+	av7110_set_volume(av7110, av7110->mixer.volume_left, av7110->mixer.volume_right);
+
+	av7710_set_video_mode(av7110, vidmode);
+
+	/* handle different card types */
+	/* remaining inits according to card and frontend type */
+	av7110->has_analog_tuner = 0;
+	av7110->current_input = 0;
+	if (i2c_writereg(av7110, 0x20, 0x00, 0x00) == 1) {
+		printk ("av7110(%d): Crystal audio DAC detected\n",
+			av7110->dvb_adapter->num);
+		av7110->adac_type = DVB_ADAC_CRYSTAL;
+		i2c_writereg(av7110, 0x20, 0x01, 0xd2);
+		i2c_writereg(av7110, 0x20, 0x02, 0x49);
+		i2c_writereg(av7110, 0x20, 0x03, 0x00);
+		i2c_writereg(av7110, 0x20, 0x04, 0x00);
+
+	/**
+	 * some special handling for the Siemens DVB-C cards...
+	 */
+	} else if (0 == av7110_init_analog_module(av7110)) {
+		/* done. */
+	}
+	else if (dev->pci->subsystem_vendor == 0x110a) {
+		printk("av7110(%d): DVB-C w/o analog module detected\n",
+			av7110->dvb_adapter->num);
+		av7110->adac_type = DVB_ADAC_NONE;
+	}
+	else {
+		av7110->adac_type = adac;
+		printk("av7110(%d): adac type set to %d\n",
+			av7110->dvb_adapter->num, av7110->adac_type);
+	}
+
+	if (av7110->adac_type == DVB_ADAC_NONE || av7110->adac_type == DVB_ADAC_MSP) {
+		// switch DVB SCART on
+		av7110_fw_cmd(av7110, COMTYPE_AUDIODAC, MainSwitch, 1, 0);
+		av7110_fw_cmd(av7110, COMTYPE_AUDIODAC, ADSwitch, 1, 1);
+		if (rgb_on)
+			saa7146_setgpio(dev, 1, SAA7146_GPIO_OUTHI); // RGB on, SCART pin 16
+		//saa7146_setgpio(dev, 3, SAA7146_GPIO_OUTLO); // SCARTpin 8
+	}
+
+	av7110_set_volume(av7110, av7110->mixer.volume_left, av7110->mixer.volume_right);
+	av7110_setup_irc_config(av7110, 0);
+}
 
 static void recover_arm(struct av7110 *av7110)
 {
 	DEB_EE(("av7110: %p\n",av7110));
 
 	av7110_bootarm(av7110);
-        dvb_delay(100); 
+	msleep(100);
         restart_feeds(av7110);
 	av7110_fw_cmd(av7110, COMTYPE_PIDFILTER, SetIR, 1, av7110->ir_config);
 }
@@ -106,12 +170,16 @@
 static int arm_thread(void *data)
 {
 	struct av7110 *av7110 = data;
-	unsigned long timeout;
         u16 newloops = 0;
+	int timeout;
 
 	DEB_EE(("av7110: %p\n",av7110));
 	
-	dvb_kernel_thread_setup ("arm_mon");
+        lock_kernel ();
+        daemonize ("arm_mon");
+        sigfillset (&current->blocked);
+        unlock_kernel ();
+
 	av7110->arm_thread = current;
 
 	while (1) {
@@ -135,6 +203,9 @@
 				av7110->dvb_adapter->num);
 
 			arm_error(av7110);
+			av7710_set_video_mode(av7110, vidmode);
+
+			init_av7110_av(av7110);
 
                         if (down_interruptible(&av7110->dcomlock))
                                 break;
@@ -638,6 +709,8 @@
 
 	if (cmd == OSD_SEND_CMD)
 		return av7110_osd_cmd(av7110, (osd_cmd_t *) parg);
+	if (cmd == OSD_GET_CAPABILITY)
+		return av7110_osd_capability(av7110, (osd_cap_t *) parg);
 
 	return -EINVAL;
         }
@@ -1203,19 +1275,17 @@
 int i2c_writereg(struct av7110 *av7110, u8 id, u8 reg, u8 val)
 {
 	u8 msg[2] = { reg, val };
-	struct dvb_i2c_bus *i2c = av7110->i2c_bus;
 	struct i2c_msg msgs;
 	
 	msgs.flags = 0;
 	msgs.addr = id / 2;
 	msgs.len = 2;
 	msgs.buf = msg;
-	return i2c->xfer(i2c, &msgs, 1);
+	return i2c_transfer(&av7110->i2c_adap, &msgs, 1);
 }
 
 u8 i2c_readreg(struct av7110 *av7110, u8 id, u8 reg)
 {
-	struct dvb_i2c_bus *i2c = av7110->i2c_bus;
 	u8 mm1[] = {0x00};
 	u8 mm2[] = {0x00};
 	struct i2c_msg msgs[2];
@@ -1226,17 +1296,11 @@
 	mm1[0] = reg;
 	msgs[0].len = 1; msgs[1].len = 1;
 	msgs[0].buf = mm1; msgs[1].buf = mm2;
-	i2c->xfer(i2c, msgs, 2);
+	i2c_transfer(&av7110->i2c_adap, msgs, 2);
 
 	return mm2[0];
 }
 
-static int master_xfer(struct dvb_i2c_bus *i2c, const struct i2c_msg msgs[], int num)
-{
-	struct saa7146_dev *dev = i2c->data;
-	return saa7146_i2c_transfer(dev, msgs, num, 6);
-}
-
 /****************************************************************************
  * INITIALIZATION
  ****************************************************************************/
@@ -1310,13 +1374,25 @@
 	/* request the av7110 firmware, this will block until someone uploads it */
 	ret = request_firmware(&fw, "dvb-ttpci-01.fw", &av7110->dev->pci->dev);
 	if (ret) {
-		printk("dvb-ttpci: cannot request firmware!\n");
+		if (ret == -ENOENT) {
+			printk(KERN_ERR "dvb-ttpci: could not load firmware,"
+			       " file not found: dvb-ttpci-01.fw\n");
+			printk(KERN_ERR "dvb-ttpci: usually this should be in"
+			       " /usr/lib/hotplug/firmware\n");
+			printk(KERN_ERR "dvb-ttpci: and can be downloaded here"
+			       " http://www.linuxtv.org/download/dvb/firmware/\n");
+		} else
+			printk(KERN_ERR "dvb-ttpci: cannot request firmware"
+			       " (error %i)\n", ret);
 		return -EINVAL;
 	}
+
 	if (fw->size <= 200000) {
 		printk("dvb-ttpci: this firmware is way too small.\n");
+		release_firmware(fw);
 		return -EINVAL;
 	}
+
 	/* check if the firmware is available */
 	av7110->bin_fw = (unsigned char*) vmalloc(fw->size);
 	if (NULL == av7110->bin_fw) {
@@ -1321,8 +1397,10 @@
 	av7110->bin_fw = (unsigned char*) vmalloc(fw->size);
 	if (NULL == av7110->bin_fw) {
 		DEB_D(("out of memory\n"));
+		release_firmware(fw);
 		return -ENOMEM;
 	}
+
 	memcpy(av7110->bin_fw, fw->data, fw->size);
 	av7110->size_fw = fw->size;
 	if ((ret = check_firmware(av7110)))
@@ -1327,10 +1405,34 @@
 	av7110->size_fw = fw->size;
 	if ((ret = check_firmware(av7110)))
 		vfree(av7110->bin_fw);
+
+	release_firmware(fw);
 	return ret;
 }
 #endif
 
+int client_register(struct i2c_client *client)
+{
+	struct saa7146_dev *dev = (struct saa7146_dev*)i2c_get_adapdata(client->adapter);
+	struct av7110 *av7110 = (struct av7110*)dev->ext_priv;
+
+	/* fixme: check for "type" (ie. frontend type) */
+	if (client->driver->command)
+		return client->driver->command(client, FE_REGISTER, av7110->dvb_adapter);
+	return 0;
+}
+
+int client_unregister(struct i2c_client *client)
+{
+	struct saa7146_dev *dev = (struct saa7146_dev*)i2c_get_adapdata(client->adapter);
+	struct av7110 *av7110 = (struct av7110*)dev->ext_priv;
+
+	/* fixme: check for "type" (ie. frontend type) */
+	if (client->driver->command)
+		return client->driver->command(client, FE_UNREGISTER, av7110->dvb_adapter);
+	return 0;
+}
+
 static int av7110_attach(struct saa7146_dev* dev, struct saa7146_pci_extension_data *pci_ext)
 {
 	struct av7110 *av7110 = NULL;
@@ -1361,18 +1463,26 @@
 	   get recognized before the main driver is fully loaded */
 	saa7146_write(dev, GPIO_CTRL, 0x500000);
 
-	saa7146_i2c_adapter_prepare(dev, NULL, 0, SAA7146_I2C_BUS_BIT_RATE_120); /* 275 kHz */
+	av7110->i2c_adap = (struct i2c_adapter) {
+		.client_register = client_register,
+		.client_unregister = client_unregister,
+#ifdef I2C_ADAP_CLASS_TV_DIGITAL
+		.class = I2C_ADAP_CLASS_TV_DIGITAL,
+#else
+		.class = I2C_CLASS_TV_DIGITAL,
+#endif
+	};
+	strlcpy(av7110->i2c_adap.name, pci_ext->ext_priv, sizeof(av7110->i2c_adap.name));
 
-	av7110->i2c_bus = dvb_register_i2c_bus (master_xfer, dev,
-						av7110->dvb_adapter, 0);
+	saa7146_i2c_adapter_prepare(dev, &av7110->i2c_adap, SAA7146_I2C_BUS_BIT_RATE_120); /* 275 kHz */
 
-	if (!av7110->i2c_bus) {
+	if (i2c_add_adapter(&av7110->i2c_adap) < 0) {
 		dvb_unregister_adapter (av7110->dvb_adapter);
 		kfree(av7110);
 		return -ENOMEM;
 	}
 
-	ttpci_eeprom_parse_mac(av7110->i2c_bus);
+	ttpci_eeprom_parse_mac(&av7110->i2c_adap, av7110->dvb_adapter->proposed_mac);
 
 	saa7146_write(dev, PCI_BT_V1, 0x1c00101f);
 	saa7146_write(dev, BCS_CTRL, 0x80400040);
@@ -1399,6 +1509,7 @@
 
         /* default OSD window */
         av7110->osdwin=1;
+	sema_init(&av7110->osd_sema, 1);
 
         /* ARM "watchdog" */
 	init_waitqueue_head(&av7110->arm_wait);
@@ -1443,54 +1554,12 @@
 		goto err2;
 	}
 
-	/* set internal volume control to maximum */
-	av7110->adac_type = DVB_ADAC_TI;
-	av7110_set_volume(av7110, 0xff, 0xff);
-
-	av7710_set_video_mode(av7110, vidmode);
-
-	/* handle different card types */
-	/* remaining inits according to card and frontend type */
-	av7110->has_analog_tuner = 0;
-	av7110->current_input = 0;
-	if (i2c_writereg(av7110, 0x20, 0x00, 0x00)==1) {
-		printk ("av7110(%d): Crystal audio DAC detected\n",
-			av7110->dvb_adapter->num);
-		av7110->adac_type = DVB_ADAC_CRYSTAL;
-		i2c_writereg(av7110, 0x20, 0x01, 0xd2);
-		i2c_writereg(av7110, 0x20, 0x02, 0x49);
-		i2c_writereg(av7110, 0x20, 0x03, 0x00);
-		i2c_writereg(av7110, 0x20, 0x04, 0x00);
-	
-	/**
-	 * some special handling for the Siemens DVB-C cards...
-	 */
-	} else if (0 == av7110_init_analog_module(av7110)) {
-		/* done. */
-	}
-	else if (dev->pci->subsystem_vendor == 0x110a) {
-		printk("av7110(%d): DVB-C w/o analog module detected\n",
-			av7110->dvb_adapter->num);
-		av7110->adac_type = DVB_ADAC_NONE;
-	}
-	else {
-		av7110->adac_type = adac;
-		printk("av7110(%d): adac type set to %d\n",
-			av7110->dvb_adapter->num, av7110->adac_type);
-		}
-
-	if (av7110->adac_type == DVB_ADAC_NONE || av7110->adac_type == DVB_ADAC_MSP) {
-		// switch DVB SCART on
-		av7110_fw_cmd(av7110, COMTYPE_AUDIODAC, MainSwitch, 1, 0);
-		av7110_fw_cmd(av7110, COMTYPE_AUDIODAC, ADSwitch, 1, 1);
-		if (rgb_on)
-			saa7146_setgpio(dev, 1, SAA7146_GPIO_OUTHI); // RGB on, SCART pin 16
-		//saa7146_setgpio(dev, 3, SAA7146_GPIO_OUTLO); // SCARTpin 8
-	}
+	/* set initial volume in mixer struct */
+	av7110->mixer.volume_left  = volume;
+	av7110->mixer.volume_right = volume;
 	
-	av7110_set_volume(av7110, 0xff, 0xff);
+	init_av7110_av(av7110);
 
-	av7110_setup_irc_config (av7110, 0);
 	av7110_register(av7110);
 	
 	/* special case DVB-C: these cards have an analog tuner
@@ -1510,13 +1579,12 @@
 	av7110->arm_rmmod = 1;
 	wake_up_interruptible(&av7110->arm_wait);
 	while (av7110->arm_thread)
-		dvb_delay(1);
+		msleep(1);
 err2:
 	av7110_ca_exit(av7110);
 	av7110_av_exit(av7110);
 err:
-	dvb_unregister_i2c_bus (master_xfer,av7110->i2c_bus->adapter,
-				av7110->i2c_bus->id);
+	i2c_del_adapter(&av7110->i2c_adap);
 
 	dvb_unregister_adapter (av7110->dvb_adapter);
 
@@ -1546,7 +1614,7 @@
 	wake_up_interruptible(&av7110->arm_wait);
 
 	while (av7110->arm_thread)
-		dvb_delay(1);
+		msleep(1);
 
 	dvb_unregister(av7110);
 	
@@ -1563,7 +1631,8 @@
 	pci_free_consistent(saa->pci, 8192, av7110->debi_virt,
 			    av7110->debi_bus);
 
-	dvb_unregister_i2c_bus (master_xfer,av7110->i2c_bus->adapter, av7110->i2c_bus->id);
+	i2c_del_adapter(&av7110->i2c_adap);
+
 	dvb_unregister_adapter (av7110->dvb_adapter);
 
 	av7110_num--;
@@ -1602,7 +1671,7 @@
 MAKE_AV7110_INFO(fs_1_5, "Siemens cable card PCI rev1.5");
 MAKE_AV7110_INFO(fs_1_3, "Siemens/Technotrend/Hauppauge PCI rev1.3");
 MAKE_AV7110_INFO(tt_1_6, "Technotrend/Hauppauge PCI rev1.3 or 1.6");
-MAKE_AV7110_INFO(tt_2_1, "Technotrend/Hauppauge PCI rev2.1");
+MAKE_AV7110_INFO(tt_2_1, "Technotrend/Hauppauge PCI rev2.1 or 2.2");
 MAKE_AV7110_INFO(tt_t,	 "Technotrend/Hauppauge PCI DVB-T");
 MAKE_AV7110_INFO(unkwn0, "Technotrend/Hauppauge PCI rev?(unknown0)?");
 MAKE_AV7110_INFO(unkwn1, "Technotrend/Hauppauge PCI rev?(unknown1)?");
@@ -1684,15 +1753,3 @@
 MODULE_AUTHOR("Ralph Metzler, Marcus Metzler, others");
 MODULE_LICENSE("GPL");
 
-MODULE_PARM(av7110_debug,"i");
-MODULE_PARM(vidmode,"i");
-MODULE_PARM_DESC(vidmode,"analog video out: 0 off, 1 CVBS+RGB (default), 2 CVBS+YC, 3 YC");
-MODULE_PARM(pids_off,"i");
-MODULE_PARM_DESC(pids_off,"clear video/audio/PCR PID filters when demux is closed");
-MODULE_PARM(adac,"i");
-MODULE_PARM_DESC(adac,"audio DAC type: 0 TI, 1 CRYSTAL, 2 MSP (use if autodetection fails)");
-MODULE_PARM(hw_sections, "i");
-MODULE_PARM_DESC(hw_sections, "0 use software section filter, 1 use hardware");
-MODULE_PARM(rgb_on, "i");
-MODULE_PARM_DESC(rgb_on, "For Siemens DVB-C cards only: Enable RGB control"
-		" signal on SCART pin 16 to switch SCART video mode from CVBS to RGB");
diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/ttpci/av7110_ca.c linux-2.6.8.1-patched/drivers/media/dvb/ttpci/av7110_ca.c
--- xx-linux-2.6.8.1/drivers/media/dvb/ttpci/av7110_ca.c	2004-08-23 09:34:58.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/ttpci/av7110_ca.c	2004-08-18 19:52:18.000000000 +0200
@@ -38,13 +38,8 @@
 #include <linux/byteorder/swabb.h>
 #include <linux/smp_lock.h>
 
-#define DEBUG_VARIABLE av7110_debug
-extern int av7110_debug;
-
-#include "dvb_i2c.h"
 #include "av7110.h"
 #include "av7110_hw.h"
-#include "dvb_functions.h"
 
 
 void CI_handle(struct av7110 *av7110, u8 *data, u16 len)
diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/ttpci/av7110.h linux-2.6.8.1-patched/drivers/media/dvb/ttpci/av7110.h
--- xx-linux-2.6.8.1/drivers/media/dvb/ttpci/av7110.h	2004-07-19 19:40:04.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/ttpci/av7110.h	2004-08-18 19:52:18.000000000 +0200
@@ -4,13 +4,12 @@
 #include <linux/interrupt.h>
 #include <linux/socket.h>
 #include <linux/netdevice.h>
+#include <linux/i2c.h>
 
 #ifdef CONFIG_DEVFS_FS
 #include <linux/devfs_fs_kernel.h>
 #endif
 
-#include <media/saa7146_vv.h>
-
 #include <linux/dvb/video.h>
 #include <linux/dvb/audio.h>
 #include <linux/dvb/dmx.h>
@@ -26,6 +25,7 @@
 #include "dvb_net.h"
 #include "dvb_ringbuffer.h"
 
+#include <media/saa7146_vv.h>
 
 #define MAXFILT 32
 
@@ -60,12 +60,13 @@
         struct dvb_device       dvb_dev;
         struct dvb_net               dvb_net;
 
-	struct video_device	v4l_dev;
-	struct video_device	vbi_dev;
+	struct video_device	*v4l_dev;
+	struct video_device	*vbi_dev;
 
         struct saa7146_dev	*dev;
 
-	struct dvb_i2c_bus	*i2c_bus;	
+	struct i2c_adapter	i2c_adap;
+
 	char			*card_name;
 
 	/* support for analog module of dvb-c */
@@ -127,7 +128,7 @@
 
         int                     osdwin;      /* currently active window */
         u16                     osdbpp[8];
-
+	struct semaphore	osd_sema;
 
         /* CA */
 
@@ -187,6 +188,7 @@
         struct dvb_ringbuffer    ci_rbuffer;
         struct dvb_ringbuffer    ci_wbuffer;
 
+	struct audio_mixer	mixer;
 
         struct dvb_adapter       *dvb_adapter;
         struct dvb_device        *video_dev;
diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/ttpci/av7110_hw.c linux-2.6.8.1-patched/drivers/media/dvb/ttpci/av7110_hw.c
--- xx-linux-2.6.8.1/drivers/media/dvb/ttpci/av7110_hw.c	2004-08-23 09:34:58.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/ttpci/av7110_hw.c	2004-08-18 19:44:05.000000000 +0200
@@ -38,12 +38,8 @@
 #include <linux/smp_lock.h>
 #include <linux/fs.h>
 
-#define DEBUG_VARIABLE av7110_debug
-extern int av7110_debug;
-
 #include "av7110.h"
 #include "av7110_hw.h"
-#include "dvb_functions.h"
 
 /****************************************************************************
  * DEBI functions
@@ -106,7 +102,7 @@
 	saa7146_write(av7110->dev, ISR, (MASK_19 | MASK_03));
 
 	saa7146_setgpio(av7110->dev, RESET_LINE, SAA7146_GPIO_OUTHI);
-	dvb_delay(30);	/* the firmware needs some time to initialize */
+	msleep(30);	/* the firmware needs some time to initialize */
 
 	ARM_ResetMailBox(av7110);
 
@@ -268,7 +264,7 @@
 		return -1;
 	}
 	saa7146_setgpio(dev, RESET_LINE, SAA7146_GPIO_OUTHI);
-	dvb_delay(30);	/* the firmware needs some time to initialize */
+	msleep(30);	/* the firmware needs some time to initialize */
 
 	//ARM_ClearIrq(av7110);
 	ARM_ResetMailBox(av7110);
@@ -302,7 +298,7 @@
 
 	start = jiffies;
 	while (rdebi(av7110, DEBINOSWAP, COMMAND, 0, 2 )) {
-		dvb_delay(1);
+		msleep(1);
 		if (time_after(jiffies, start + ARM_WAIT_FREE)) {
 			printk(KERN_ERR "%s: timeout waiting for COMMAND idle\n", __FUNCTION__);
 			return -1;
@@ -312,7 +308,7 @@
 #ifndef _NOHANDSHAKE
 	start = jiffies;
 	while (rdebi(av7110, DEBINOSWAP, HANDSHAKE_REG, 0, 2 )) {
-		dvb_delay(1);
+		msleep(1);
 		if (time_after(jiffies, start + ARM_WAIT_SHAKE)) {
 			printk(KERN_ERR "%s: timeout waiting for HANDSHAKE_REG\n", __FUNCTION__);
 			return -1;
@@ -322,7 +318,7 @@
 
 	start = jiffies;
 	while (rdebi(av7110, DEBINOSWAP, MSGSTATE, 0, 2) & OSDQFull) {
-		dvb_delay(1);
+		msleep(1);
 		if (time_after(jiffies, start + ARM_WAIT_OSD)) {
 			printk(KERN_ERR "%s: timeout waiting for !OSDQFull\n", __FUNCTION__);
 			return -1;
@@ -341,7 +337,7 @@
 #ifdef COM_DEBUG
 	start = jiffies;
 	while (rdebi(av7110, DEBINOSWAP, COMMAND, 0, 2 )) {
-		dvb_delay(1);
+		msleep(1);
 		if (time_after(jiffies, start + ARM_WAIT_FREE)) {
 			printk(KERN_ERR "%s: timeout waiting for COMMAND to complete\n",
 			       __FUNCTION__);
@@ -458,7 +454,7 @@
 	start = jiffies;
 	while (rdebi(av7110, DEBINOSWAP, COMMAND, 0, 2)) {
 #ifdef _NOHANDSHAKE
-		dvb_delay(1);
+		msleep(1);
 #endif
 		if (time_after(jiffies, start + ARM_WAIT_FREE)) {
 			printk("%s: timeout waiting for COMMAND to complete\n", __FUNCTION__);
@@ -470,7 +466,7 @@
 #ifndef _NOHANDSHAKE
 	start = jiffies;
 	while (rdebi(av7110, DEBINOSWAP, HANDSHAKE_REG, 0, 2 )) {
-		dvb_delay(1);
+		msleep(1);
 		if (time_after(jiffies, start + ARM_WAIT_SHAKE)) {
 			printk(KERN_ERR "%s: timeout waiting for HANDSHAKE_REG\n", __FUNCTION__);
 			up(&av7110->dcomlock);
@@ -630,7 +626,7 @@
 		return -ERESTARTSYS;
 	start = jiffies;
 	while (rdebi(av7110, DEBINOSWAP, BUFF1_BASE, 0, 2)) {
-		dvb_delay(1);
+		msleep(1);
 		if (time_after(jiffies, start + ARM_WAIT_OSD)) {
 			printk(KERN_ERR "%s: timeout waiting for BUFF1_BASE == 0\n",
 			       __FUNCTION__);
@@ -654,7 +650,7 @@
 
 	start = jiffies;
 	while (rdebi(av7110, DEBINOSWAP, BUFF1_BASE, 0, 2)) {
-		dvb_delay(1);
+		msleep(1);
 		if (time_after(jiffies, start + ARM_WAIT_OSD)) {
 			printk(KERN_ERR "%s: timeout waiting for BUFF1_BASE == 0\n",
 			       __FUNCTION__);
@@ -665,7 +661,7 @@
 #ifndef _NOHANDSHAKE
 	start = jiffies;
 	while (rdebi(av7110, DEBINOSWAP, HANDSHAKE_REG, 0, 2)) {
-		dvb_delay(1);
+		msleep(1);
 		if (time_after(jiffies, start + ARM_WAIT_SHAKE)) {
 			printk(KERN_ERR "%s: timeout waiting for HANDSHAKE_REG\n",
 			       __FUNCTION__);
@@ -721,7 +717,7 @@
 }
 
 static inline int CreateOSDWindow(struct av7110 *av7110, u8 windownr,
-				  enum av7110_window_display_type disptype,
+				  osd_raw_window_t disptype,
 				  u16 width, u16 height)
 {
 	return av7110_fw_cmd(av7110, COMTYPE_OSD, WCreate, 4,
@@ -732,8 +728,8 @@
 static enum av7110_osd_palette_type bpp2pal[8] = {
 	Pal1Bit, Pal2Bit, 0, Pal4Bit, 0, 0, 0, Pal8Bit
 };
-static enum av7110_window_display_type bpp2bit[8] = {
-	BITMAP1, BITMAP2, 0, BITMAP4, 0, 0, 0, BITMAP8
+static osd_raw_window_t bpp2bit[8] = {
+	OSD_BITMAP1, OSD_BITMAP2, 0, OSD_BITMAP4, 0, 0, 0, OSD_BITMAP8
 };
 
 static inline int LoadBitmap(struct av7110 *av7110, u16 format,
@@ -743,32 +739,26 @@
 	int i;
 	int d, delta;
 	u8 c;
-	DECLARE_WAITQUEUE(wait, current);
+	int ret;
 
 	DEB_EE(("av7110: %p\n", av7110));
 
-	if (av7110->bmp_state == BMP_LOADING) {
-		add_wait_queue(&av7110->bmpq, &wait);
-		while (1) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			if (av7110->bmp_state != BMP_LOADING
-			    || signal_pending(current))
-				break;
-			schedule();
-		}
-		set_current_state(TASK_RUNNING);
-		remove_wait_queue(&av7110->bmpq, &wait);
-	}
-	if (av7110->bmp_state == BMP_LOADING)
+	ret = wait_event_interruptible_timeout(av7110->bmpq, av7110->bmp_state != BMP_LOADING, HZ);
+	if (ret == -ERESTARTSYS || ret == 0) {
+		printk("dvb-ttpci: warning: timeout waiting in %s()\n", __FUNCTION__);
+		av7110->bmp_state = BMP_NONE;
 		return -1;
+	}
+	BUG_ON (av7110->bmp_state == BMP_LOADING);
+
 	av7110->bmp_state = BMP_LOADING;
-	if	(format == BITMAP8) {
+	if	(format == OSD_BITMAP8) {
 		bpp=8; delta = 1;
-	} else if (format == BITMAP4) {
+	} else if (format == OSD_BITMAP4) {
 		bpp=4; delta = 2;
-	} else if (format == BITMAP2) {
+	} else if (format == OSD_BITMAP2) {
 		bpp=2; delta = 4;
-	} else if (format == BITMAP1) {
+	} else if (format == OSD_BITMAP1) {
 		bpp=1; delta = 8;
 	} else {
 		av7110->bmp_state = BMP_NONE;
@@ -786,7 +776,7 @@
 			return -1;
 		}
 	}
-	if (format != BITMAP8) {
+	if (format != OSD_BITMAP8) {
 		for (i = 0; i < dx * dy / delta; i++) {
 			c = ((u8 *)av7110->bmpbuf)[1024 + i * delta + delta - 1];
 			for (d = delta - 2; d >= 0; d--) {
@@ -802,27 +792,22 @@
 
 static int BlitBitmap(struct av7110 *av7110, u16 win, u16 x, u16 y, u16 trans)
 {
-	DECLARE_WAITQUEUE(wait, current);
+	int ret;
 
 	DEB_EE(("av7110: %p\n", av7110));
 
-       if (av7110->bmp_state == BMP_NONE)
+	BUG_ON (av7110->bmp_state == BMP_NONE);
+
+	ret = wait_event_interruptible_timeout(av7110->bmpq, av7110->bmp_state != BMP_LOADING, HZ);
+	if (ret == -ERESTARTSYS || ret == 0) {
+		printk("dvb-ttpci: warning: timeout waiting in %s()\n", __FUNCTION__);
+		av7110->bmp_state = BMP_NONE;
 		return -1;
-	if (av7110->bmp_state == BMP_LOADING) {
-		add_wait_queue(&av7110->bmpq, &wait);
-		while (1) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			if (av7110->bmp_state != BMP_LOADING
-			    || signal_pending(current))
-				break;
-			schedule();
 		}
-		set_current_state(TASK_RUNNING);
-		remove_wait_queue(&av7110->bmpq, &wait);
-	}
-	if (av7110->bmp_state == BMP_LOADED)
+
+	BUG_ON (av7110->bmp_state != BMP_LOADED);
+
 		return av7110_fw_cmd(av7110, COMTYPE_OSD, BlitBmp, 4, win, x, y, trans);
-	return -1;
 }
 
 static inline int ReleaseBitmap(struct av7110 *av7110)
@@ -865,18 +850,22 @@
 		  color, ((blend >> 4) & 0x0f));
 }
 
-static int OSDSetPalette(struct av7110 *av7110, u32 *colors, u8 first, u8 last)
+static int OSDSetPalette(struct av7110 *av7110, u32 __user * colors, u8 first, u8 last)
 {
        int i;
        int length = last - first + 1;
 
        if (length * 4 > DATA_BUFF3_SIZE)
-	       return -1;
+	       return -EINVAL;
 
        for (i = 0; i < length; i++) {
-	       u32 blend = (colors[i] & 0xF0000000) >> 4;
-	       u32 yuv = blend ? RGB2YUV(colors[i] & 0xFF, (colors[i] >> 8) & 0xFF,
-					 (colors[i] >> 16) & 0xFF) | blend : 0;
+	       u32 color, blend, yuv;
+
+	       if (get_user(color, colors + i))
+		       return -EFAULT;
+	       blend = (color & 0xF0000000) >> 4;
+	       yuv = blend ? RGB2YUV(color & 0xFF, (color >> 8) & 0xFF,
+				     (color >> 16) & 0xFF) | blend : 0;
 	       yuv = ((yuv & 0xFFFF0000) >> 16) | ((yuv & 0x0000FFFF) << 16);
 	       wdebi(av7110, DEBINOSWAP, DATA_BUFF3_BASE + i * 4, yuv, 4);
        }
@@ -922,10 +911,19 @@
 
 int av7110_osd_cmd(struct av7110 *av7110, osd_cmd_t *dc)
 {
+	int ret;
+	
+	ret = down_interruptible(&av7110->osd_sema);
+	if (ret)
+		return -ERESTARTSYS;
+
+	/* stupid, but OSD functions don't provide a return code anyway */
+	ret = 0;
+	
 	switch (dc->cmd) {
 	case OSD_Close:
 		DestroyOSDWindow(av7110, av7110->osdwin);
-		return 0;
+		goto out;
 	case OSD_Open:
 		av7110->osdbpp[av7110->osdwin] = (dc->color - 1) & 7;
 		CreateOSDWindow(av7110, av7110->osdwin,
@@ -935,90 +933,84 @@
 			MoveWindowAbs(av7110, av7110->osdwin, dc->x0, dc->y0);
 			SetColorBlend(av7110, av7110->osdwin);
 		}
-		return 0;
+		goto out;
 	case OSD_Show:
 		MoveWindowRel(av7110, av7110->osdwin, 0, 0);
-		return 0;
+		goto out;
 	case OSD_Hide:
 		HideWindow(av7110, av7110->osdwin);
-		return 0;
+		goto out;
 	case OSD_Clear:
 		DrawBlock(av7110, av7110->osdwin, 0, 0, 720, 576, 0);
-		return 0;
+		goto out;
 	case OSD_Fill:
 		DrawBlock(av7110, av7110->osdwin, 0, 0, 720, 576, dc->color);
-		return 0;
+		goto out;
 	case OSD_SetColor:
 		OSDSetColor(av7110, dc->color, dc->x0, dc->y0, dc->x1, dc->y1);
-		return 0;
+		goto out;
 	case OSD_SetPalette:
 	{
-		int len = dc->x0-dc->color+1;
-		void *buf;
-		if (len <= 0)
-			return 0;
-
-		buf = kmalloc(len * 4, GFP_KERNEL);
-		if (!buf)
-			return -ENOMEM;
-
-		if (copy_from_user(buf, dc->data, len * 4)) {
-			kfree(buf);
-			return -EFAULT;
+		if (FW_VERSION(av7110->arm_app) >= 0x2618) {
+			ret = OSDSetPalette(av7110, (u32 *)dc->data, dc->color, dc->x0);
+			goto out;
+		} else {
+			int i, len = dc->x0-dc->color+1;
+			u8 *colors = (u8 *)dc->data;
+			u8 r, g, b, blend;
+
+			for (i = 0; i<len; i++) {
+				if (get_user(r, colors + i * 4) ||
+				    get_user(g, colors + i * 4 + 1) ||
+				    get_user(b, colors + i * 4 + 2) ||
+				    get_user(blend, colors + i * 4 + 3)) {
+					ret = -EFAULT;
+					goto out;
 		}
-
-		if (FW_VERSION(av7110->arm_app) >= 0x2618)
-			OSDSetPalette(av7110, buf, dc->color, dc->x0);
-		else {
-			int i;
-			u8 *colors = buf;
-
-			for (i = 0; i<len; i++)
-				OSDSetColor(av7110, dc->color + i,
-					colors[i * 4], colors[i * 4 + 1],
-					colors[i * 4 + 2], colors[i * 4 + 3]);
+				OSDSetColor(av7110, dc->color + i, r, g, b, blend);
 		}
-		kfree(buf);
-		return 0;
+		}
+		ret = 0;
+		goto out;
 	}
 	case OSD_SetTrans:
-		return 0;
+		goto out;
 	case OSD_SetPixel:
 		DrawLine(av7110, av7110->osdwin,
 			 dc->x0, dc->y0, 0, 0, dc->color);
-		return 0;
+		goto out;
 	case OSD_GetPixel:
-		return 0;
-
+		goto out;
 	case OSD_SetRow:
 		dc->y1 = dc->y0;
 		/* fall through */
 	case OSD_SetBlock:
 		OSDSetBlock(av7110, dc->x0, dc->y0, dc->x1, dc->y1, dc->color, dc->data);
-		return 0;
-
+		goto out;
 	case OSD_FillRow:
 		DrawBlock(av7110, av7110->osdwin, dc->x0, dc->y0,
 			  dc->x1-dc->x0+1, dc->y1, dc->color);
-		return 0;
+		goto out;
 	case OSD_FillBlock:
 		DrawBlock(av7110, av7110->osdwin, dc->x0, dc->y0,
 			  dc->x1 - dc->x0 + 1, dc->y1 - dc->y0 + 1, dc->color);
-		return 0;
+		goto out;
 	case OSD_Line:
 		DrawLine(av7110, av7110->osdwin,
 			 dc->x0, dc->y0, dc->x1 - dc->x0, dc->y1 - dc->y0, dc->color);
-		return 0;
+		goto out;
 	case OSD_Query:
-		return 0;
+		goto out;
 	case OSD_Test:
-		return 0;
+		goto out;
 	case OSD_Text:
 	{
 		char textbuf[240];
 
-		if (strncpy_from_user(textbuf, dc->data, 240) < 0)
-			return -EFAULT;
+		if (strncpy_from_user(textbuf, dc->data, 240) < 0) {
+			ret = -EFAULT;
+			goto out;
+		}
 		textbuf[239] = 0;
 		if (dc->x1 > 3)
 			dc->x1 = 3;
@@ -1026,16 +1018,55 @@
 			(u16) (dc->color & 0xffff), (u16) (dc->color >> 16));
 		FlushText(av7110);
 		WriteText(av7110, av7110->osdwin, dc->x0, dc->y0, textbuf);
-		return 0;
+		goto out;
 	}
 	case OSD_SetWindow:
-		if (dc->x0 < 1 || dc->x0 > 7)
-			return -EINVAL;
+		if (dc->x0 < 1 || dc->x0 > 7) {
+			ret = -EINVAL;
+			goto out;
+		}
 		av7110->osdwin = dc->x0;
-		return 0;
+		goto out;
 	case OSD_MoveWindow:
 		MoveWindowAbs(av7110, av7110->osdwin, dc->x0, dc->y0);
 		SetColorBlend(av7110, av7110->osdwin);
+		goto out;
+	case OSD_OpenRaw:
+		if (dc->color < OSD_BITMAP1 || dc->color > OSD_CURSOR) {
+			ret = -EINVAL;
+			goto out;
+		}
+		if (dc->color >= OSD_BITMAP1 && dc->color <= OSD_BITMAP8HR) {
+			av7110->osdbpp[av7110->osdwin] = (1 << (dc->color & 3)) - 1;
+		}
+		else {
+			av7110->osdbpp[av7110->osdwin] = 0;
+		}
+		CreateOSDWindow(av7110, av7110->osdwin, (osd_raw_window_t)dc->color,
+				dc->x1 - dc->x0 + 1, dc->y1 - dc->y0 + 1);
+		if (!dc->data) {
+			MoveWindowAbs(av7110, av7110->osdwin, dc->x0, dc->y0);
+			SetColorBlend(av7110, av7110->osdwin);
+		}
+		goto out;
+	default:
+		ret = -EINVAL;
+		goto out;
+	}
+
+out:
+	up(&av7110->osd_sema);
+	return ret;
+}
+
+int av7110_osd_capability(struct av7110 *av7110, osd_cap_t *cap)
+{
+        switch (cap->cmd) {
+        case OSD_CAP_MEMSIZE:
+                if (FW_4M_SDRAM(av7110->arm_app))
+                        cap->val = 1000000;
+                else
+                        cap->val = 92000;
 		return 0;
 	default:
 		return -EINVAL;
diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/ttpci/av7110_hw.h linux-2.6.8.1-patched/drivers/media/dvb/ttpci/av7110_hw.h
--- xx-linux-2.6.8.1/drivers/media/dvb/ttpci/av7110_hw.h	2004-07-19 19:40:04.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/ttpci/av7110_hw.h	2004-07-27 14:36:01.000000000 +0200
@@ -39,29 +39,6 @@
 	Pal8Bit =  256	   /* 256 colors for 16 bit palette */
 };
 
-enum av7110_window_display_type {
-	BITMAP1,	   /* 1 bit bitmap */
-	BITMAP2,	   /* 2 bit bitmap */
-	BITMAP4,	   /* 4 bit bitmap */
-	BITMAP8,	   /* 8 bit bitmap */
-	BITMAP1HR,	   /* 1 Bit bitmap half resolution */
-	BITMAP2HR,	   /* 2 bit bitmap half resolution */
-	BITMAP4HR,	   /* 4 bit bitmap half resolution */
-	BITMAP8HR,	   /* 8 bit bitmap half resolution */
-	YCRCB422,	   /* 4:2:2 YCRCB Graphic Display */
-	YCRCB444,	   /* 4:4:4 YCRCB Graphic Display */
-	YCRCB444HR,	   /* 4:4:4 YCRCB graphic half resolution */
-	VIDEOTSIZE,	   /* True Size Normal MPEG Video Display */
-	VIDEOHSIZE,	   /* MPEG Video Display Half Resolution */
-	VIDEOQSIZE,	   /* MPEG Video Display Quarter Resolution */
-	VIDEODSIZE,	   /* MPEG Video Display Double Resolution */
-	VIDEOTHSIZE,	   /* True Size MPEG Video Display Half Resolution */
-	VIDEOTQSIZE,	   /* True Size MPEG Video Display Quarter Resolution*/
-	VIDEOTDSIZE,	   /* True Size MPEG Video Display Double Resolution */
-	VIDEONSIZE,	   /* Full Size MPEG Video Display */
-	CURSOR		   /* Cursor */
-};
-
 /* switch defines */
 #define SB_GPIO 3
 #define SB_OFF	SAA7146_GPIO_OUTLO  /* SlowBlank off (TV-Mode) */
@@ -388,6 +365,7 @@
 extern int av7110_bootarm(struct av7110 *av7110);
 extern int av7110_firmversion(struct av7110 *av7110);
 #define FW_CI_LL_SUPPORT(arm_app) ((arm_app) & 0x80000000)
+#define FW_4M_SDRAM(arm_app)      ((arm_app) & 0x40000000)
 #define FW_VERSION(arm_app)	  ((arm_app) & 0x0000FFFF)
 
 extern int av7110_fw_cmd(struct av7110 *av7110, int type, int com, int num, ...);
@@ -495,7 +473,7 @@
 
 static int inline audcom(struct av7110 *av7110, u32 com)
 {
-	return av7110_fw_cmd(av7110, COMTYPE_MISC, AV7110_FW_AUDIO_COMMAND, 4,
+	return av7110_fw_cmd(av7110, COMTYPE_MISC, AV7110_FW_AUDIO_COMMAND, 2,
 			     (com>>16), (com&0xffff));
 }
 
@@ -510,6 +488,7 @@
 
 #ifdef CONFIG_DVB_AV7110_OSD
 extern int av7110_osd_cmd(struct av7110 *av7110, osd_cmd_t *dc);
+extern int av7110_osd_capability(struct av7110 *av7110, osd_cap_t *cap);
 #endif /* CONFIG_DVB_AV7110_OSD */
 
 
diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/ttpci/av7110_ir.c linux-2.6.8.1-patched/drivers/media/dvb/ttpci/av7110_ir.c
--- xx-linux-2.6.8.1/drivers/media/dvb/ttpci/av7110_ir.c	2004-08-23 09:34:58.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/ttpci/av7110_ir.c	2004-07-31 02:05:46.000000000 +0200
@@ -1,23 +1,21 @@
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/input.h>
 #include <linux/proc_fs.h>
 #include <asm/bitops.h>
 
 #include "av7110.h"
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0))
-#include "input_fake.h"
-#endif
-
-
 #define UP_TIMEOUT (HZ/4)
 
-static int av7110_ir_debug = 0;
+static int av7110_ir_debug;
 
-#define dprintk(x...)  do { if (av7110_ir_debug) printk (x); } while (0)
+module_param_named(debug_ir, av7110_ir_debug, int, 0644);
+MODULE_PARM_DESC(av7110_ir_debug, "Turn on/off IR debugging (default:off).");
 
+#define dprintk(x...)  do { if (av7110_ir_debug) printk (x); } while (0)
 
 static struct input_dev input_dev;
 
@@ -205,6 +198,7 @@
 
 void __exit av7110_ir_exit (void)
 {
+	del_timer_sync(&keyup_timer);
 	remove_proc_entry ("av7110_ir", NULL);
 	av7110_unregister_irc_handler (av7110_emit_key);
 	input_unregister_device(&input_dev);
@@ -213,6 +207,3 @@
 //MODULE_AUTHOR("Holger Waechtler <holger@convergence.de>");
 //MODULE_LICENSE("GPL");
 
-MODULE_PARM(av7110_ir_debug,"i");
-MODULE_PARM_DESC(av7110_ir_debug, "enable AV7110 IR receiver debug messages");
-
diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/ttpci/av7110_v4l.c linux-2.6.8.1-patched/drivers/media/dvb/ttpci/av7110_v4l.c
--- xx-linux-2.6.8.1/drivers/media/dvb/ttpci/av7110_v4l.c	2004-07-19 19:40:04.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/ttpci/av7110_v4l.c	2004-08-18 19:52:18.000000000 +0200
@@ -35,23 +35,16 @@
 #include <linux/byteorder/swabb.h>
 #include <linux/smp_lock.h>
 
-#define DEBUG_VARIABLE av7110_debug
-extern int av7110_debug;
-
-#include "dvb_i2c.h"
 #include "av7110.h"
 #include "av7110_hw.h"
 #include "av7110_av.h"
-#include "dvb_functions.h"
-
 
 int msp_writereg(struct av7110 *av7110, u8 dev, u16 reg, u16 val)
 {
 	u8 msg[5] = { dev, reg >> 8, reg & 0xff, val >> 8 , val & 0xff };
-	struct dvb_i2c_bus *i2c = av7110->i2c_bus;
 	struct i2c_msg msgs = { .flags = 0, .addr = 0x40, .len = 5, .buf = msg };
 
-	if (i2c->xfer(i2c, &msgs, 1) != 1) {
+	if (i2c_transfer(&av7110->i2c_adap, &msgs, 1) != 1) {
 		printk("av7110(%d): %s(%u = %u) failed\n",
 		       av7110->dvb_adapter->num, __FUNCTION__, reg, val);
 		return -EIO;
@@ -63,13 +56,12 @@
 {
 	u8 msg1[3] = { dev, reg >> 8, reg & 0xff };
 	u8 msg2[2];
-	struct dvb_i2c_bus *i2c = av7110->i2c_bus;
 	struct i2c_msg msgs[2] = {
 		{ .flags = 0,	     .addr = 0x40, .len = 3, .buf = msg1 },
 		{ .flags = I2C_M_RD, .addr = 0x40, .len = 2, .buf = msg2 }
 	};
 
-	if (i2c->xfer(i2c, msgs, 2) != 2) {
+	if (i2c_transfer(&av7110->i2c_adap, &msgs[0], 2) != 2) {
 		printk("av7110(%d): %s(%u) failed\n",
 		       av7110->dvb_adapter->num, __FUNCTION__, reg);
 		return -EIO;
@@ -517,7 +507,7 @@
 	printk("av7110(%d): DVB-C analog module detected, initializing MSP3400\n",
 		av7110->dvb_adapter->num);
 	av7110->adac_type = DVB_ADAC_MSP;
-	dvb_delay(100); // the probing above resets the msp...
+	msleep(100); // the probing above resets the msp...
 	msp_readreg(av7110, MSP_RD_DSP, 0x001e, &version1);
 	msp_readreg(av7110, MSP_RD_DSP, 0x001f, &version2);
 	printk("av7110(%d): MSP3400 version 0x%04x 0x%04x\n",
diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/ttpci/budget-av.c linux-2.6.8.1-patched/drivers/media/dvb/ttpci/budget-av.c
--- xx-linux-2.6.8.1/drivers/media/dvb/ttpci/budget-av.c	2004-07-19 19:40:04.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/ttpci/budget-av.c	2004-08-18 19:44:05.000000000 +0200
@@ -30,14 +30,12 @@
  * the project's page is at http://www.linuxtv.org/dvb/
  */
 
-#include <media/saa7146_vv.h>
-
 #include "budget.h"
-#include "dvb_functions.h"
+#include <media/saa7146_vv.h>
 
 struct budget_av {
 	struct budget budget;
-	struct video_device vd;
+	struct video_device *vd;
 	int cur_input;
 	int has_saa7113;
 };
@@ -47,7 +45,7 @@
  ****************************************************************************/
 
 
-static u8 i2c_readreg (struct dvb_i2c_bus *i2c, u8 id, u8 reg)
+static u8 i2c_readreg (struct i2c_adapter *i2c, u8 id, u8 reg)
 {
 	u8 mm1[] = {0x00};
 	u8 mm2[] = {0x00};
@@ -60,12 +58,12 @@
 	msgs[0].len = 1; msgs[1].len = 1;
 	msgs[0].buf = mm1; msgs[1].buf = mm2;
 
-	i2c->xfer(i2c, msgs, 2);
+	i2c_transfer(i2c, msgs, 2);
 
 	return mm2[0];
 }
 
-static int i2c_readregs(struct dvb_i2c_bus *i2c, u8 id, u8 reg, u8 *buf, u8 len)
+static int i2c_readregs(struct i2c_adapter *i2c, u8 id, u8 reg, u8 *buf, u8 len)
 {
         u8 mm1[] = { reg };
         struct i2c_msg msgs[2] = {
@@ -73,8 +71,9 @@
 		{ .addr = id/2, .flags = I2C_M_RD, .buf = buf, .len = len }
 	};
 
-        if (i2c->xfer(i2c, msgs, 2) != 2)
+        if (i2c_transfer(i2c, msgs, 2) != 2)
 		return -EIO;
+
 	return 0;
 }
 
@@ -79,7 +78,7 @@
 }
 
 
-static int i2c_writereg (struct dvb_i2c_bus *i2c, u8 id, u8 reg, u8 val)
+static int i2c_writereg (struct i2c_adapter *i2c, u8 id, u8 reg, u8 val)
 {
         u8 msg[2]={ reg, val }; 
         struct i2c_msg msgs;
@@ -88,7 +87,7 @@
         msgs.addr=id/2;
         msgs.len=2;
         msgs.buf=msg;
-        return i2c->xfer (i2c, &msgs, 1);
+        return i2c_transfer(i2c, &msgs, 1);
 }
 
 
@@ -127,7 +126,7 @@
 	struct budget *budget = &budget_av->budget;
 	const u8 *data = saa7113_tab;
 
-        if (i2c_writereg (budget->i2c_bus, 0x4a, 0x01, 0x08) != 1) {
+        if (i2c_writereg (&budget->i2c_adap, 0x4a, 0x01, 0x08) != 1) {
                 DEB_D(("saa7113: not found on KNC card\n"));
                 return -ENODEV;
         }
@@ -135,12 +134,12 @@
         INFO(("saa7113: detected and initializing\n"));
 
 	while (*data != 0xff) {
-                i2c_writereg(budget->i2c_bus, 0x4a, *data, *(data+1));
+                i2c_writereg(&budget->i2c_adap, 0x4a, *data, *(data+1));
                 data += 2;
         }
 
 	DEB_D(("saa7113: status=%02x\n",
-	      i2c_readreg(budget->i2c_bus, 0x4a, 0x1f)));
+	      i2c_readreg(&budget->i2c_adap, 0x4a, 0x1f)));
 
 	return 0;
 }
@@ -154,11 +153,11 @@
 		return -ENODEV;
 
 	if (input == 1) {
-		i2c_writereg(budget->i2c_bus, 0x4a, 0x02, 0xc7);
-		i2c_writereg(budget->i2c_bus, 0x4a, 0x09, 0x80);
+		i2c_writereg(&budget->i2c_adap, 0x4a, 0x02, 0xc7);
+		i2c_writereg(&budget->i2c_adap, 0x4a, 0x09, 0x80);
 	} else if (input == 0) {
-		i2c_writereg(budget->i2c_bus, 0x4a, 0x02, 0xc0);
-		i2c_writereg(budget->i2c_bus, 0x4a, 0x09, 0x00);
+		i2c_writereg(&budget->i2c_adap, 0x4a, 0x02, 0xc0);
+		i2c_writereg(&budget->i2c_adap, 0x4a, 0x09, 0x00);
 	} else
 		return -EINVAL;
 
@@ -177,7 +176,7 @@
 	if ( 1 == budget_av->has_saa7113 ) {
 	saa7146_setgpio(dev, 0, SAA7146_GPIO_OUTLO);
 
-	dvb_delay(200);
+		msleep(200);
 
 	saa7146_unregister_device (&budget_av->vd, dev);
 	}
@@ -201,7 +200,7 @@
 
 	DEB_EE(("dev: %p\n",dev));
 
-	if (bi->type != BUDGET_KNC1) {
+	if (bi->type != BUDGET_KNC1 && bi->type != BUDGET_CIN1200) {
 		return -ENODEV;
 	}
 
@@ -210,13 +209,13 @@
 
 	memset(budget_av, 0, sizeof(struct budget_av));
 
+	dev->ext_priv = budget_av;
+
 	if ((err = ttpci_budget_init(&budget_av->budget, dev, info))) {
 		kfree(budget_av);
 		return err;
 	}
 
-	dev->ext_priv = budget_av;
-
 	/* knc1 initialization */
 	saa7146_write(dev, DD1_STREAM_B, 0x04000000);
 	saa7146_write(dev, DD1_INIT, 0x07000600);
@@ -225,7 +224,7 @@
 	//test_knc_ci(av7110);
 
 	saa7146_setgpio(dev, 0, SAA7146_GPIO_OUTHI);
-	dvb_delay(500);
+	msleep(500);
 
 	if ( 0 == saa7113_init(budget_av) ) {
 		budget_av->has_saa7113 = 1;
@@ -259,7 +258,7 @@
 	saa7146_write(dev, PCI_BT_V1, 0x1c00101f);
 
 	mac = budget_av->budget.dvb_adapter->proposed_mac;
-	if (i2c_readregs(budget_av->budget.i2c_bus, 0xa0, 0x30, mac, 6)) {
+	if (i2c_readregs(&budget_av->budget.i2c_adap, 0xa0, 0x30, mac, 6)) {
 		printk("KNC1-%d: Could not read MAC from KNC1 card\n",
 				budget_av->budget.dvb_adapter->num);
 		memset(mac, 0, 6);
@@ -361,9 +360,11 @@
 
 
 MAKE_BUDGET_INFO(knc1, "KNC1 DVB-S", BUDGET_KNC1);
+MAKE_BUDGET_INFO(cin1200, "TerraTec Cinergy 1200 DVB-S", BUDGET_CIN1200);
 
 static struct pci_device_id pci_tbl [] = {
 	MAKE_EXTENSION_PCI(knc1, 0x1131, 0x4f56),
+	MAKE_EXTENSION_PCI(cin1200, 0x153b, 0x1154),
 	{
 		.vendor    = 0,
 	}
diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/ttpci/budget.c linux-2.6.8.1-patched/drivers/media/dvb/ttpci/budget.c
--- xx-linux-2.6.8.1/drivers/media/dvb/ttpci/budget.c	2004-07-19 19:40:04.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/ttpci/budget.c	2004-08-18 19:52:18.000000000 +0200
@@ -35,7 +35,6 @@
  */
 
 #include "budget.h"
-#include "dvb_functions.h"
 
 static void Set22K (struct budget *budget, int state)
 {
@@ -100,7 +99,7 @@
 			udelay(12500);
 			saa7146_setgpio(dev, 3, SAA7146_GPIO_OUTLO);
 		}
-		dvb_delay(20);
+		msleep(20);
 	}
 
 	return 0;
@@ -202,6 +201,8 @@
 
 	DEB_EE(("dev:%p, info:%p, budget:%p\n",dev,info,budget));
 
+	dev->ext_priv = budget;
+
 	if ((err = ttpci_budget_init (budget, dev, info))) {
 		printk("==> failed\n");
 		kfree (budget);
@@ -215,8 +216,6 @@
 	dvb_add_frontend_ioctls (budget->dvb_adapter,
 				 budget_diseqc_ioctl, NULL, budget);
 
-	dev->ext_priv = budget;
-
 	return 0;
 }
 
diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/ttpci/budget-ci.c linux-2.6.8.1-patched/drivers/media/dvb/ttpci/budget-ci.c
--- xx-linux-2.6.8.1/drivers/media/dvb/ttpci/budget-ci.c	2004-07-19 19:40:04.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/ttpci/budget-ci.c	2004-08-18 19:52:18.000000000 +0200
@@ -38,13 +38,8 @@
 #include <linux/input.h>
 #include <linux/spinlock.h>
 
-#include "dvb_functions.h"
 #include "dvb_ca_en50221.h"
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0))
-#include "input_fake.h"
-#endif
-
 #define DEBIADDR_IR		0x1234
 #define DEBIADDR_CICONTROL	0x0000
 #define DEBIADDR_CIVERSION	0x4000
@@ -326,7 +321,7 @@
 	saa7146_setgpio(saa, 0, SAA7146_GPIO_IRQHI);
 	budget_ci->slot_status = SLOTSTATUS_RESET;
 	budget_debiwrite(budget_ci, DEBICICTL, DEBIADDR_CICONTROL, 1, 0);
-	dvb_delay(1);
+	msleep(1);
 	budget_debiwrite(budget_ci, DEBICICTL, DEBIADDR_CICONTROL, 1, CICONTROL_RESET);
 
 	saa7146_setgpio(saa, 1, SAA7146_GPIO_OUTHI);
@@ -372,14 +367,13 @@
 	// ensure we don't get spurious IRQs during initialisation
 	if (!budget_ci->budget.ci_present) return;
 
+	// read the CAM status
 	flags = budget_debiread(budget_ci, DEBICICTL, DEBIADDR_CICONTROL, 1);
+	if (flags & CICONTROL_CAMDETECT) {
 
-	// always set the GPIO mode back to "normal", in case the card is
-	// yanked at an inopportune moment
+		// GPIO should be set to trigger on falling edge if a CAM is present
 	saa7146_setgpio(saa, 0, SAA7146_GPIO_IRQLO);
 
-	if (flags & CICONTROL_CAMDETECT) {
-
 		if (budget_ci->slot_status & SLOTSTATUS_NONE) {
 			// CAM insertion IRQ
 			budget_ci->slot_status = SLOTSTATUS_PRESENT;
@@ -395,7 +389,15 @@
 			dvb_ca_en50221_frda_irq(&budget_ci->ca, 0);
 		}
 	} else {
+
+		// trigger on rising edge if a CAM is not present - when a CAM is inserted, we
+		// only want to get the IRQ when it sets READY. If we trigger on the falling edge,
+		// the CAM might not actually be ready yet.
+		saa7146_setgpio(saa, 0, SAA7146_GPIO_IRQHI);
+
+	   	// generate a CAM removal IRQ if we haven't already
 		if (budget_ci->slot_status & SLOTSTATUS_OCCUPIED) {
+			// CAM removal IRQ
 			budget_ci->slot_status = SLOTSTATUS_NONE;
 			dvb_ca_en50221_camchange_irq(&budget_ci->ca, 0, DVB_CA_EN50221_CAMCHANGE_REMOVED);
 		}
@@ -446,7 +448,11 @@
 
 	// Setup CI slot IRQ
 	tasklet_init (&budget_ci->ciintf_irq_tasklet, ciintf_interrupt, (unsigned long) budget_ci);
+	if (budget_ci->slot_status != SLOTSTATUS_NONE) {
 	saa7146_setgpio(saa, 0, SAA7146_GPIO_IRQLO);
+	} else {
+		saa7146_setgpio(saa, 0, SAA7146_GPIO_IRQHI);
+	}
 	saa7146_write(saa, IER, saa7146_read(saa, IER) | MASK_03);
 	budget_debiwrite(budget_ci, DEBICICTL, DEBIADDR_CICONTROL, 1, CICONTROL_RESET);
 
@@ -475,7 +481,7 @@
 	saa7146_setgpio(saa, 0, SAA7146_GPIO_INPUT);
 	tasklet_kill(&budget_ci->ciintf_irq_tasklet);
 	budget_debiwrite(budget_ci, DEBICICTL, DEBIADDR_CICONTROL, 1, 0);
-	dvb_delay(1);
+	msleep(1);
 	budget_debiwrite(budget_ci, DEBICICTL, DEBIADDR_CICONTROL, 1, CICONTROL_RESET);
 
 	// disable TS data stream to CI interface
@@ -520,20 +526,19 @@
 	spin_lock_init(&budget_ci->debilock);
 	budget_ci->budget.ci_present = 0;
 
+	dev->ext_priv = budget_ci;
+
 	if ((err = ttpci_budget_init (&budget_ci->budget, dev, info))) {
 		kfree (budget_ci);
 		return err;
 	}
 
-	dev->ext_priv = budget_ci;
-
 	tasklet_init (&budget_ci->msp430_irq_tasklet, msp430_ir_interrupt,
 		      (unsigned long) budget_ci);
 
 	msp430_ir_init (budget_ci);
 
-	// UNCOMMENT TO TEST CI INTERFACE
-//	ciintf_init(budget_ci);
+	ciintf_init(budget_ci);
 
 	return 0;
 }
diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/ttpci/budget-core.c linux-2.6.8.1-patched/drivers/media/dvb/ttpci/budget-core.c
--- xx-linux-2.6.8.1/drivers/media/dvb/ttpci/budget-core.c	2004-07-19 19:40:04.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/ttpci/budget-core.c	2004-08-18 18:01:48.000000000 +0200
@@ -34,10 +34,15 @@
  * the project's page is at http://www.linuxtv.org/dvb/
  */
 
+#include <linux/moduleparam.h>
+
 #include "budget.h"
 #include "ttpci-eeprom.h"
 
-int budget_debug = 0;
+static int budget_debug;
+
+module_param_named(debug, budget_debug, int, 0644);
+MODULE_PARM_DESC(budget_debug, "Turn on/off budget debugging (default:off).");
 
 /****************************************************************************
  * TT budget / WinTV Nova
@@ -258,13 +263,26 @@
         dvb_dmx_release(&budget->demux);
 }
 
-
-static int master_xfer (struct dvb_i2c_bus *i2c, const struct i2c_msg msgs[], int num)
+/* fixme: can this be unified among all saa7146 based dvb cards? */
+int client_register(struct i2c_client *client)
 {
-	struct saa7146_dev *dev = i2c->data;
-	return saa7146_i2c_transfer(dev, msgs, num, 6);
+	struct saa7146_dev *dev = (struct saa7146_dev*)i2c_get_adapdata(client->adapter);
+	struct budget *budget = (struct budget*)dev->ext_priv;
+
+	if (client->driver->command)
+		return client->driver->command(client, FE_REGISTER, budget->dvb_adapter);
+	return 0;
 }
 
+int client_unregister(struct i2c_client *client)
+{
+	struct saa7146_dev *dev = (struct saa7146_dev*)i2c_get_adapdata(client->adapter);
+	struct budget *budget = (struct budget*)dev->ext_priv;
+
+	if (client->driver->command)
+		return client->driver->command(client, FE_UNREGISTER, budget->dvb_adapter);
+	return 0;
+}
 
 int ttpci_budget_init (struct budget *budget,
 		       struct saa7146_dev* dev,
@@ -301,17 +319,27 @@
 	if (bi->type != BUDGET_FS_ACTIVY)
 		saa7146_write(dev, GPIO_CTRL, 0x500000); /* GPIO 3 = 1 */
 	
-	saa7146_i2c_adapter_prepare(dev, NULL, 0, SAA7146_I2C_BUS_BIT_RATE_120);
+	budget->i2c_adap = (struct i2c_adapter) {
+		.client_register = client_register,
+		.client_unregister = client_unregister,
+#ifdef I2C_ADAP_CLASS_TV_DIGITAL
+		.class = I2C_ADAP_CLASS_TV_DIGITAL,
+#else
+		.class = I2C_CLASS_TV_DIGITAL,
+#endif
+	};
+	
+	strlcpy(budget->i2c_adap.name, budget->card->name, sizeof(budget->i2c_adap.name));
 
-	budget->i2c_bus = dvb_register_i2c_bus (master_xfer, dev,
-						budget->dvb_adapter, 0);
+	saa7146_i2c_adapter_prepare(dev, &budget->i2c_adap, SAA7146_I2C_BUS_BIT_RATE_120);
+	strcpy(budget->i2c_adap.name, budget->card->name);
 
-	if (!budget->i2c_bus) {
+	if (i2c_add_adapter(&budget->i2c_adap) < 0) {
 		dvb_unregister_adapter (budget->dvb_adapter);
 		return -ENOMEM;
 	}
 
-	ttpci_eeprom_parse_mac(budget->i2c_bus);
+	ttpci_eeprom_parse_mac(&budget->i2c_adap, budget->dvb_adapter->proposed_mac);
 
 	if( NULL == (budget->grabbing = saa7146_vmalloc_build_pgtable(dev->pci,length,&budget->pt))) {
 		ret = -ENOMEM;
@@ -334,12 +362,11 @@
 		return 0;
 	}
 err:
+	i2c_del_adapter(&budget->i2c_adap);
+
 	if (budget->grabbing)
 		vfree(budget->grabbing);
 
-	dvb_unregister_i2c_bus (master_xfer,budget->i2c_bus->adapter,
-				budget->i2c_bus->id);
-
 	dvb_unregister_adapter (budget->dvb_adapter);
 
 	return ret;
@@ -354,8 +381,7 @@
 
 	budget_unregister (budget);
 
-	dvb_unregister_i2c_bus (master_xfer, budget->i2c_bus->adapter,
-				budget->i2c_bus->id);
+	i2c_del_adapter(&budget->i2c_adap);
 
 	dvb_unregister_adapter (budget->dvb_adapter);
 
@@ -402,7 +428,5 @@
 EXPORT_SYMBOL_GPL(ttpci_budget_set_video_port);
 EXPORT_SYMBOL_GPL(budget_debug);
 
-MODULE_PARM(budget_debug,"i");
 MODULE_LICENSE("GPL");
 
-
diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/ttpci/budget.h linux-2.6.8.1-patched/drivers/media/dvb/ttpci/budget.h
--- xx-linux-2.6.8.1/drivers/media/dvb/ttpci/budget.h	2004-07-19 19:40:04.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/ttpci/budget.h	2004-08-18 19:52:18.000000000 +0200
@@ -1,9 +1,6 @@
 #ifndef __BUDGET_DVB__
 #define __BUDGET_DVB__
 
-#include <media/saa7146.h>
-
-#include "dvb_i2c.h"
 #include "dvb_frontend.h"
 #include "dvbdev.h"
 #include "demux.h"
@@ -12,6 +9,8 @@
 #include "dvb_filter.h"
 #include "dvb_net.h"
 
+#include <media/saa7146.h>
+
 extern int budget_debug;
 
 struct budget_info {
@@ -28,7 +27,7 @@
 
         struct saa7146_dev	*dev;
 
-	struct dvb_i2c_bus	*i2c_bus;	
+	struct i2c_adapter	i2c_adap;	
 	struct budget_info	*card;
 
 	unsigned char		*grabbing;
@@ -79,6 +78,7 @@
 #define BUDGET_KNC1		   2
 #define BUDGET_PATCH		   3
 #define BUDGET_FS_ACTIVY	   4
+#define BUDGET_CIN1200		   5
 
 #define BUDGET_VIDEO_PORTA         0
 #define BUDGET_VIDEO_PORTB         1
diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/ttpci/ttpci-eeprom.c linux-2.6.8.1-patched/drivers/media/dvb/ttpci/ttpci-eeprom.c
--- xx-linux-2.6.8.1/drivers/media/dvb/ttpci/ttpci-eeprom.c	2004-07-19 19:40:04.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/ttpci/ttpci-eeprom.c	2004-08-18 19:52:18.000000000 +0200
@@ -35,9 +35,8 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/string.h>
+#include <linux/i2c.h>
 
-#include "dvb_i2c.h"
-#include "dvb_functions.h"
 
 #if 1
 #define dprintk(x...) do { printk(x); } while (0)
@@ -85,7 +84,7 @@
         return 0;
 }
 
-static int ttpci_eeprom_read_encodedMAC(struct dvb_i2c_bus *i2c, u8 * encodedMAC)
+static int ttpci_eeprom_read_encodedMAC(struct i2c_adapter *adapter, u8 * encodedMAC)
 {
 	int ret;
 	u8 b0[] = { 0xcc };
@@ -97,7 +96,7 @@
 
 	/* dprintk("%s\n", __FUNCTION__); */
 
-	ret = i2c->xfer(i2c, msg, 2);
+	ret = i2c_transfer(adapter, msg, 2);
 
 	if (ret != 2)		/* Assume EEPROM isn't there */
 		return (-ENODEV);
@@ -106,36 +105,34 @@
 }
 
 
-int ttpci_eeprom_parse_mac(struct dvb_i2c_bus *i2c)
+int ttpci_eeprom_parse_mac(struct i2c_adapter *adapter, u8 *proposed_mac)
 {
 	int ret, i;
 	u8 encodedMAC[20];
 	u8 decodedMAC[6];
 
-	ret = ttpci_eeprom_read_encodedMAC(i2c, encodedMAC);
+	ret = ttpci_eeprom_read_encodedMAC(adapter, encodedMAC);
 
 	if (ret != 0) {		/* Will only be -ENODEV */
 		dprintk("Couldn't read from EEPROM: not there?\n");
-		memset(i2c->adapter->proposed_mac, 0, 6);
+		memset(proposed_mac, 0, 6);
 		return ret;
 	}
 
 	ret = getmac_tt(decodedMAC, encodedMAC);
 	if( ret != 0 ) {
-		dprintk("%s adapter %i failed MAC signature check\n",
-			i2c->adapter->name, i2c->adapter->num);
+		dprintk("adapter failed MAC signature check\n");
 		dprintk("encoded MAC from EEPROM was " );
 		for(i=0; i<19; i++) {
 			dprintk( "%.2x:", encodedMAC[i]);
 		}
 		dprintk("%.2x\n", encodedMAC[19]);
-		memset(i2c->adapter->proposed_mac, 0, 6);
+		memset(proposed_mac, 0, 6);
 		return ret;
 	}
 
-	memcpy(i2c->adapter->proposed_mac, decodedMAC, 6);
-	dprintk("%s adapter %i has MAC addr = %.2x:%.2x:%.2x:%.2x:%.2x:%.2x\n",
-		i2c->adapter->name, i2c->adapter->num,
+	memcpy(proposed_mac, decodedMAC, 6);
+	dprintk("adapter has MAC addr = %.2x:%.2x:%.2x:%.2x:%.2x:%.2x\n",
 		decodedMAC[0], decodedMAC[1], decodedMAC[2],
 		decodedMAC[3], decodedMAC[4], decodedMAC[5]);
 	return 0;
diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/ttpci/ttpci-eeprom.h linux-2.6.8.1-patched/drivers/media/dvb/ttpci/ttpci-eeprom.h
--- xx-linux-2.6.8.1/drivers/media/dvb/ttpci/ttpci-eeprom.h	2004-07-19 19:40:04.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/ttpci/ttpci-eeprom.h	2004-05-03 13:15:31.000000000 +0200
@@ -25,8 +25,9 @@
 #ifndef __TTPCI_EEPROM_H__
 #define __TTPCI_EEPROM_H__
 
-#include "dvb_i2c.h"
+#include <linux/types.h>
+#include <linux/i2c.h>
 
-extern int ttpci_eeprom_parse_mac(struct dvb_i2c_bus *i2c);
+extern int ttpci_eeprom_parse_mac(struct i2c_adapter *adapter, u8 *propsed_mac);
 
 #endif
diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c linux-2.6.8.1-patched/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c
--- xx-linux-2.6.8.1/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2004-08-23 09:34:58.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2004-08-24 16:05:26.000000000 +0200
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/wait.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/usb.h>
 #include <linux/delay.h>
 #include <linux/time.h>
@@ -28,8 +29,6 @@
 #include <linux/dvb/dmx.h>
 #include <linux/pci.h>
 
-#include "dvb_functions.h"
-
 /*
   TTUSB_HWSECTIONS:
     the DSP supports filtering in hardware, however, since the "muxstream"
@@ -49,7 +48,10 @@
     this unless the device doesn't load at all. > 2 for bandwidth statistics.
 */
 
-static int debug = 0;
+static int debug;
+
+module_param(debug, int, 0644);
+MODULE_PARM_DESC(debug, "Turn on/off debugging (default:off).");
 
 #define dprintk(x...) do { if (debug) printk(KERN_DEBUG x); } while (0)
 
@@ -80,6 +82,8 @@
 	struct dvb_adapter *adapter;
 	struct usb_device *dev;
 
+	struct i2c_adapter i2c_adap;	
+
 	int disconnecting;
 	int iso_streaming;
 
@@ -242,10 +246,9 @@
 	return rcv_len;
 }
 
-static int ttusb_i2c_xfer(struct dvb_i2c_bus *i2c, const struct i2c_msg msg[],
-		   int num)
+static int master_xfer(struct i2c_adapter* adapter, struct i2c_msg msg[], int num)
 {
-	struct ttusb *ttusb = i2c->data;
+	struct ttusb *ttusb = i2c_get_adapdata(adapter);
 	int i = 0;
 	int inc;
 
@@ -514,7 +517,7 @@
 
 static int ttusb_lnb_ioctl(struct dvb_frontend *fe, unsigned int cmd, void *arg)
 {
-	struct ttusb *ttusb = fe->i2c->data;
+	struct ttusb *ttusb = fe->before_after_data;
 
 	switch (cmd) {
 	case FE_SET_VOLTAGE:
@@ -787,7 +790,7 @@
 			ttusb_process_frame(ttusb, data, len);
 		}
 	}
-	usb_submit_urb(urb, GFP_KERNEL);
+	usb_submit_urb(urb, GFP_ATOMIC);
 }
 
 static void ttusb_free_iso_urbs(struct ttusb *ttusb)
@@ -822,7 +825,7 @@
 
 		if (!
 		    (urb =
-		     usb_alloc_urb(FRAMES_PER_ISO_BUF, GFP_KERNEL))) {
+		     usb_alloc_urb(FRAMES_PER_ISO_BUF, GFP_ATOMIC))) {
 			ttusb_free_iso_urbs(ttusb);
 			return -ENOMEM;
 		}
@@ -880,7 +883,7 @@
 	}
 
 	for (i = 0; i < ISO_BUF_COUNT; i++) {
-		if ((err = usb_submit_urb(ttusb->iso_urb[i], GFP_KERNEL))) {
+		if ((err = usb_submit_urb(ttusb->iso_urb[i], GFP_ATOMIC))) {
 			ttusb_stop_iso_xfer(ttusb);
 			printk
 			    ("%s: failed urb submission (%i: err = %i)!\n",
@@ -1068,6 +1071,38 @@
 };
 #endif
 
+u32 functionality(struct i2c_adapter *adapter)
+{
+	return I2C_FUNC_I2C;
+}
+
+static struct i2c_algorithm ttusb_dec_algo = {
+	.name		= "ttusb dec i2c algorithm",
+	.id		= I2C_ALGO_BIT,
+	.master_xfer	= master_xfer,
+	.functionality	= functionality,
+};
+
+int client_register(struct i2c_client *client)
+{
+	struct ttusb *ttusb = (struct ttusb*)i2c_get_adapdata(client->adapter);
+
+	if (client->driver->command)
+		return client->driver->command(client, FE_REGISTER, ttusb->adapter);
+
+	return 0;
+}
+
+int client_unregister(struct i2c_client *client)
+{
+	struct ttusb *ttusb = (struct ttusb*)i2c_get_adapdata(client->adapter);
+
+	if (client->driver->command)
+		return client->driver->command(client, FE_UNREGISTER, ttusb->adapter);
+
+	return 0;
+}
+
 static int ttusb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 {
 	struct usb_device *udev;
@@ -1078,17 +1113,6 @@
 
 	udev = interface_to_usbdev(intf);
 
-	/* Device has already been reset; its configuration was chosen.
-	 * If this fault happens, use a hotplug script to choose the
-	 * right configuration (write bConfigurationValue in sysfs).
-	 */
-	if (udev->actconfig->desc.bConfigurationValue != 1) {
-		dev_err(&intf->dev, "device config is #%d, need #1\n",
-			udev->actconfig->desc.bConfigurationValue);
-		return -ENODEV;
-	}
-
-
         if (intf->altsetting->desc.bInterfaceNumber != 1) return -ENODEV;
 
 	if (!(ttusb = kmalloc(sizeof(struct ttusb), GFP_KERNEL)))
@@ -1117,7 +1141,29 @@
 
 	dvb_register_adapter(&ttusb->adapter, "Technotrend/Hauppauge Nova-USB", THIS_MODULE);
 
-	dvb_register_i2c_bus(ttusb_i2c_xfer, ttusb, ttusb->adapter, 0);
+	/* i2c */
+	memset(&ttusb->i2c_adap, 0, sizeof(struct i2c_adapter));
+	strcpy(ttusb->i2c_adap.name, "TTUSB DEC");
+
+	i2c_set_adapdata(&ttusb->i2c_adap, ttusb);
+
+#ifdef I2C_ADAP_CLASS_TV_DIGITAL
+	ttusb->i2c_adap.class 	    	  = I2C_ADAP_CLASS_TV_DIGITAL;
+#else
+	ttusb->i2c_adap.class 	    	  = I2C_CLASS_TV_DIGITAL;
+#endif
+	ttusb->i2c_adap.algo              = &ttusb_dec_algo;
+	ttusb->i2c_adap.algo_data         = NULL;
+	ttusb->i2c_adap.id                = I2C_ALGO_BIT;
+	ttusb->i2c_adap.client_register   = client_register;
+	ttusb->i2c_adap.client_unregister = client_unregister;
+	
+	result = i2c_add_adapter(&ttusb->i2c_adap);
+	if (result) {
+		dvb_unregister_adapter (ttusb->adapter);
+		return result;
+	}
+
 	dvb_add_frontend_ioctls(ttusb->adapter, ttusb_lnb_ioctl, NULL,
 				ttusb);
 
@@ -1137,9 +1183,10 @@
 	ttusb->dvb_demux.write_to_decoder = NULL;
 
 	if ((result = dvb_dmx_init(&ttusb->dvb_demux)) < 0) {
-		printk("ttusb_dvb: dvb_dmx_init failed (errno = %d)\n",
-		       result);
-		goto err;
+		printk("ttusb_dvb: dvb_dmx_init failed (errno = %d)\n", result);
+		i2c_del_adapter(&ttusb->i2c_adap);
+		dvb_unregister_adapter (ttusb->adapter);
+		return -ENODEV;
 	}
 //FIXME dmxdev (nur WAS?)
 	ttusb->dmxdev.filternum = ttusb->dvb_demux.filternum;
@@ -1150,15 +1197,20 @@
 		printk("ttusb_dvb: dvb_dmxdev_init failed (errno = %d)\n",
 		       result);
 		dvb_dmx_release(&ttusb->dvb_demux);
-		goto err;
+		i2c_del_adapter(&ttusb->i2c_adap);
+		dvb_unregister_adapter (ttusb->adapter);
+		return -ENODEV;
 	}
 
-	if (dvb_net_init
-	    (ttusb->adapter, &ttusb->dvbnet, &ttusb->dvb_demux.dmx)) {
+	if (dvb_net_init(ttusb->adapter, &ttusb->dvbnet, &ttusb->dvb_demux.dmx)) {
 		printk("ttusb_dvb: dvb_net_init failed!\n");
+		dvb_dmxdev_release(&ttusb->dmxdev);
+		dvb_dmx_release(&ttusb->dvb_demux);
+		i2c_del_adapter(&ttusb->i2c_adap);
+		dvb_unregister_adapter (ttusb->adapter);
+		return -ENODEV;
 	}
 
-      err:
 #if 0
 	ttusb->stc_devfs_handle =
 	    devfs_register(ttusb->adapter->devfs_handle, TTUSB_BUDGET_NAME,
@@ -1187,7 +1238,7 @@
 	dvb_dmxdev_release(&ttusb->dmxdev);
 	dvb_dmx_release(&ttusb->dvb_demux);
 
-	dvb_unregister_i2c_bus(ttusb_i2c_xfer, ttusb->adapter, 0);
+	i2c_del_adapter(&ttusb->i2c_adap);
 	dvb_unregister_adapter(ttusb->adapter);
 
 	ttusb_free_iso_urbs(ttusb);
@@ -1234,9 +1285,6 @@
 module_init(ttusb_init);
 module_exit(ttusb_exit);
 
-MODULE_PARM(debug, "i");
-MODULE_PARM_DESC(debug, "Debug or not");
-
 MODULE_AUTHOR("Holger Waechtler <holger@convergence.de>");
 MODULE_DESCRIPTION("TTUSB DVB Driver");
 MODULE_LICENSE("GPL");
diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/ttusb-dec/ttusb_dec.c linux-2.6.8.1-patched/drivers/media/dvb/ttusb-dec/ttusb_dec.c
--- xx-linux-2.6.8.1/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2004-08-23 09:34:58.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2004-08-18 19:52:18.000000000 +0200
@@ -22,10 +22,12 @@
 #include <asm/semaphore.h>
 #include <linux/list.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/usb.h>
+#include <linux/version.h>
 #include <linux/interrupt.h>
 #include <linux/firmware.h>
 #if defined(CONFIG_CRC32) || defined(CONFIG_CRC32_MODULE)
@@ -37,13 +39,17 @@
 
 #include "dmxdev.h"
 #include "dvb_demux.h"
-#include "dvb_i2c.h"
 #include "dvb_filter.h"
 #include "dvb_frontend.h"
 #include "dvb_net.h"
 
-static int debug = 0;
-static int output_pva = 0;
+static int debug;
+static int output_pva;
+
+module_param(debug, int, 0644);
+MODULE_PARM_DESC(debug, "Turn on/off debugging (default:off).");
+module_param(output_pva, int, 0444);
+MODULE_PARM_DESC(output_pva, "Output PVA from dvr device (default:off)");
 
 #define dprintk	if (debug) printk
 
@@ -95,7 +101,6 @@
 	struct dmxdev			dmxdev;
 	struct dvb_demux		demux;
 	struct dmx_frontend		frontend;
-	struct dvb_i2c_bus		i2c_bus;
 	struct dvb_net			dvb_net;
 	struct dvb_frontend_info	*frontend_info;
 	int (*frontend_ioctl) (struct dvb_frontend *, unsigned int, void *);
@@ -1100,7 +1104,7 @@
 				 	       &dec->iso_dma_handle);
 
 	memset(dec->iso_buffer, 0,
-	       sizeof(ISO_FRAME_SIZE * (FRAMES_PER_ISO_BUF * ISO_BUF_COUNT)));
+	       ISO_FRAME_SIZE * (FRAMES_PER_ISO_BUF * ISO_BUF_COUNT));
 
 	for (i = 0; i < ISO_BUF_COUNT; i++) {
 		struct urb *urb;
@@ -1600,7 +1603,7 @@
 				p->u.qam.symbol_rate);
 			dprintk("            inversion->%d\n", p->inversion);
 
-		freq = htonl(p->frequency * 1000 +
+		freq = htonl(p->frequency +
 		       (dec->hi_band ? LOF_HI : LOF_LO));
 			memcpy(&b[4], &freq, sizeof(u32));
 			sym_rate = htonl(p->u.qam.symbol_rate);
@@ -1628,9 +1631,18 @@
 		dprintk("%s: FE_INIT\n", __FUNCTION__);
 		break;
 
-	case FE_DISEQC_SEND_MASTER_CMD:
+	case FE_DISEQC_SEND_MASTER_CMD: {
+		u8 b[] = { 0x00, 0xff, 0x00, 0x00,
+			   0x00, 0x00, 0x00, 0x00,
+			   0x00, 0x00 };
+		struct dvb_diseqc_master_cmd *cmd = arg;
+		memcpy(&b[4], cmd->msg, cmd->msg_len);
 		dprintk("%s: FE_DISEQC_SEND_MASTER_CMD\n", __FUNCTION__);
+		ttusb_dec_send_command(dec, 0x72,
+				       sizeof(b) - (6 - cmd->msg_len), b,
+				       NULL, NULL);
 		break;
+	}
 
 	case FE_DISEQC_SEND_BURST:
 		dprintk("%s: FE_DISEQC_SEND_BURST\n", __FUNCTION__);
@@ -1669,15 +1680,13 @@
 
 static void ttusb_dec_init_frontend(struct ttusb_dec *dec)
 {
-	dec->i2c_bus.adapter = dec->adapter;
-
-	dvb_register_frontend(dec->frontend_ioctl, &dec->i2c_bus, (void *)dec,
-			      dec->frontend_info);
+	int ret;
+	ret = dvb_register_frontend(dec->frontend_ioctl, dec->adapter, dec, dec->frontend_info, THIS_MODULE);
 }
 
 static void ttusb_dec_exit_frontend(struct ttusb_dec *dec)
 {
-	dvb_unregister_frontend(dec->frontend_ioctl, &dec->i2c_bus);
+	dvb_unregister_frontend_new(dec->frontend_ioctl, dec->adapter);
 }
 
 static void ttusb_dec_init_filters(struct ttusb_dec *dec)
@@ -1840,7 +1849,3 @@
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(usb, ttusb_dec_table);
 
-MODULE_PARM(debug, "i");
-MODULE_PARM_DESC(debug, "Debug level");
-MODULE_PARM(output_pva, "i");
-MODULE_PARM_DESC(output_pva, "Output PVA from dvr device");
diff -uraNwB xx-linux-2.6.8.1/include/linux/dvb/osd.h linux-2.6.8.1-patched/include/linux/dvb/osd.h
--- xx-linux-2.6.8.1/include/linux/dvb/osd.h	2004-08-23 09:35:38.000000000 +0200
+++ linux-2.6.8.1-patched/include/linux/dvb/osd.h	2004-08-09 13:26:27.000000000 +0200
@@ -94,6 +94,7 @@
   OSD_Text,       // (x0,y0,size,color,text)
   OSD_SetWindow, //  (x0) set window with number 0<x0<8 as current
   OSD_MoveWindow, //  move current window to (x0, y0)  
+  OSD_OpenRaw,	// Open other types of OSD windows
 } OSD_Command;
 
 typedef struct osd_cmd_s {
@@ -106,8 +107,39 @@
         void __user *data;
 } osd_cmd_t;
 
+/* OSD_OpenRaw: set 'color' to desired window type */
+typedef enum {
+        OSD_BITMAP1,           /* 1 bit bitmap */
+        OSD_BITMAP2,           /* 2 bit bitmap */
+        OSD_BITMAP4,           /* 4 bit bitmap */
+        OSD_BITMAP8,           /* 8 bit bitmap */
+        OSD_BITMAP1HR,         /* 1 Bit bitmap half resolution */
+        OSD_BITMAP2HR,         /* 2 bit bitmap half resolution */
+        OSD_BITMAP4HR,         /* 4 bit bitmap half resolution */
+        OSD_BITMAP8HR,         /* 8 bit bitmap half resolution */
+        OSD_YCRCB422,          /* 4:2:2 YCRCB Graphic Display */
+        OSD_YCRCB444,          /* 4:4:4 YCRCB Graphic Display */
+        OSD_YCRCB444HR,        /* 4:4:4 YCRCB graphic half resolution */
+        OSD_VIDEOTSIZE,        /* True Size Normal MPEG Video Display */
+        OSD_VIDEOHSIZE,        /* MPEG Video Display Half Resolution */
+        OSD_VIDEOQSIZE,        /* MPEG Video Display Quarter Resolution */
+        OSD_VIDEODSIZE,        /* MPEG Video Display Double Resolution */
+        OSD_VIDEOTHSIZE,       /* True Size MPEG Video Display Half Resolution */
+        OSD_VIDEOTQSIZE,       /* True Size MPEG Video Display Quarter Resolution*/
+        OSD_VIDEOTDSIZE,       /* True Size MPEG Video Display Double Resolution */
+        OSD_VIDEONSIZE,        /* Full Size MPEG Video Display */
+        OSD_CURSOR             /* Cursor */
+} osd_raw_window_t;
+
+typedef struct osd_cap_s {
+        int  cmd;
+#define OSD_CAP_MEMSIZE         1  /* memory size */
+        long val;
+} osd_cap_t;
+
 
 #define OSD_SEND_CMD       _IOW('o', 160, osd_cmd_t)
+#define OSD_GET_CAPABILITY      _IOR('o', 161, osd_cap_t)
 
 #endif
 
diff -uraNwB linux-2.6.8.1-dvb1/drivers/media/dvb/b2c2/skystar2.c linux-2.6.8.1-patched/drivers/media/dvb/b2c2/skystar2.c
--- linux-2.6.8.1-dvb1/drivers/media/dvb/b2c2/skystar2.c	2004-09-17 12:26:13.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/b2c2/skystar2.c	2004-09-01 12:19:01.000000000 +0200
@@ -2236,7 +2236,7 @@
 }
 
 
-int client_register(struct i2c_client *client)
+static int client_register(struct i2c_client *client)
 {
 	struct adapter *adapter = (struct adapter*)i2c_get_adapdata(client->adapter);
 
@@ -2247,7 +2247,7 @@
 	return 0;
 }
 
-int client_unregister(struct i2c_client *client)
+static int client_unregister(struct i2c_client *client)
 {
 	struct adapter *adapter = (struct adapter*)i2c_get_adapdata(client->adapter);
 
diff -uraNwB linux-2.6.8.1-dvb1/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c linux-2.6.8.1-patched/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c
--- linux-2.6.8.1-dvb1/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2004-09-17 12:26:39.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2004-09-01 12:19:01.000000000 +0200
@@ -1083,7 +1083,7 @@
 	.functionality	= functionality,
 };
 
-int client_register(struct i2c_client *client)
+static int client_register(struct i2c_client *client)
 {
 	struct ttusb *ttusb = (struct ttusb*)i2c_get_adapdata(client->adapter);
 
@@ -1093,7 +1093,7 @@
 	return 0;
 }
 
-int client_unregister(struct i2c_client *client)
+static int client_unregister(struct i2c_client *client)
 {
 	struct ttusb *ttusb = (struct ttusb*)i2c_get_adapdata(client->adapter);
 
diff -uraNwB linux-2.6.8.1-dvb1/drivers/media/dvb/ttpci/budget-core.c linux-2.6.8.1-patched/drivers/media/dvb/ttpci/budget-core.c
--- linux-2.6.8.1-dvb1/drivers/media/dvb/ttpci/budget-core.c	2004-09-17 12:26:39.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/ttpci/budget-core.c	2004-09-01 12:19:01.000000000 +0200
@@ -264,7 +264,7 @@
 }
 
 /* fixme: can this be unified among all saa7146 based dvb cards? */
-int client_register(struct i2c_client *client)
+static int client_register(struct i2c_client *client)
 {
 	struct saa7146_dev *dev = (struct saa7146_dev*)i2c_get_adapdata(client->adapter);
 	struct budget *budget = (struct budget*)dev->ext_priv;
@@ -274,7 +274,7 @@
 	return 0;
 }
 
-int client_unregister(struct i2c_client *client)
+static int client_unregister(struct i2c_client *client)
 {
 	struct saa7146_dev *dev = (struct saa7146_dev*)i2c_get_adapdata(client->adapter);
 	struct budget *budget = (struct budget*)dev->ext_priv;
diff -uraNwB linux-2.6.8.1-dvb1/drivers/media/dvb/ttpci/av7110.c linux-2.6.8.1-patched/drivers/media/dvb/ttpci/av7110.c
--- linux-2.6.8.1-dvb1/drivers/media/dvb/ttpci/av7110.c	2004-09-17 12:26:39.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/ttpci/av7110.c	2004-09-17 12:35:37.000000000 +0200
@@ -1412,7 +1411,8 @@
 }
 #endif
 
-int client_register(struct i2c_client *client)
+
+static int client_register(struct i2c_client *client)
 {
 	struct saa7146_dev *dev = (struct saa7146_dev*)i2c_get_adapdata(client->adapter);
 	struct av7110 *av7110 = (struct av7110*)dev->ext_priv;
@@ -1423,7 +1423,7 @@
 	return 0;
 }
 
-int client_unregister(struct i2c_client *client)
+static int client_unregister(struct i2c_client *client)
 {
 	struct saa7146_dev *dev = (struct saa7146_dev*)i2c_get_adapdata(client->adapter);
 	struct av7110 *av7110 = (struct av7110*)dev->ext_priv;
diff -uraNwB linux-2.6.8.1-dvb1/drivers/media/dvb/ttpci/budget-ci.c linux-2.6.8.1-patched/drivers/media/dvb/ttpci/budget-ci.c
--- linux-2.6.8.1-dvb1/drivers/media/dvb/ttpci/budget-ci.c	2004-09-17 12:26:39.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/ttpci/budget-ci.c	2004-09-01 12:19:01.000000000 +0200
@@ -74,14 +74,15 @@
 {
 	struct saa7146_dev *saa = budget_ci->budget.dev;
 	u32 result = 0;
+        unsigned long flags;
 
 	if (count > 4 || count <= 0)
 		return 0;
 
-	spin_lock(&budget_ci->debilock);
+	spin_lock_irqsave(&budget_ci->debilock, flags);
 
 	if (saa7146_wait_for_debi_done(saa) < 0) {
-		spin_unlock(&budget_ci->debilock);
+		spin_unlock_irqrestore(&budget_ci->debilock, flags);
 		return 0;
 	}
 
@@ -96,21 +97,22 @@
 	result = saa7146_read(saa, 0x88);
 	result &= (0xffffffffUL >> ((4 - count) * 8));
 
-	spin_unlock(&budget_ci->debilock);
+	spin_unlock_irqrestore(&budget_ci->debilock, flags);
 	return result;
 }
 
 static u8 budget_debiwrite (struct budget_ci* budget_ci, u32 config, int addr, int count, u32 value)
 {
 	struct saa7146_dev *saa = budget_ci->budget.dev;
+        unsigned long flags;
 
 	if (count > 4 || count <= 0)
 		return 0;
 
-	spin_lock(&budget_ci->debilock);
+	spin_lock_irqsave(&budget_ci->debilock, flags);
 
 	if (saa7146_wait_for_debi_done(saa) < 0) {
-		spin_unlock(&budget_ci->debilock);
+		spin_unlock_irqrestore(&budget_ci->debilock, flags);
 		return 0;
 	}
 
@@ -123,7 +125,7 @@
 
 	saa7146_wait_for_debi_done(saa);
 
-	spin_unlock(&budget_ci->debilock);
+	spin_unlock_irqrestore(&budget_ci->debilock, flags);
 	return 0;
 }
 

--------------020300010707090107020003--
