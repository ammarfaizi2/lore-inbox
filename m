Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262155AbVCVB4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262155AbVCVB4c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 20:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262210AbVCVBy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 20:54:58 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:42635 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262346AbVCVBgN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:36:13 -0500
Message-Id: <20050322013457.851468000@abc>
References: <20050322013427.919515000@abc>
Date: Tue, 22 Mar 2005 02:23:59 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Francois Romieu <romieu@fr.zoreil.com>
Content-Disposition: inline; filename=dvb-av7110-janitor.patch
X-SA-Exim-Connect-IP: 217.231.55.169
Subject: [DVB patch 26/48] av7110: error handling during attach
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Janitoring - error handling during attach
o av7110_arm_sync(): small helper to factor out some code;
o av7110_attach() does not check the status code returned by all the
  functions is uses;
o balance the error path in av7110_attach and have it easy to check.
  Please check it;
o if everything is correctly balanced, device_initialized is not needed
  anymore in struct av7110;
o av7110_detach(): no need to cast a void * pointer;
o av7110_detach(): die #ifdef, die !
o change the returned value of av7110_av_exit() as it can't fail;
o change the returned value of av7110_ca_init() as it can fail. Removed
  extraneous casts while are it;
o check for failure of vmalloc() in ci_ll_init().
o vfree(NULL) is safe.

Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 av7110.c       |  194 ++++++++++++++++++++++++++++++++-------------------------
 av7110.h       |    2 
 av7110_av.c    |   25 ++++---
 av7110_av.h    |    2 
 av7110_ca.c    |   20 ++++-
 av7110_ca.h    |    2 
 av7110_ipack.c |    1 
 7 files changed, 147 insertions(+), 99 deletions(-)

Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/ttpci/av7110.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/ttpci/av7110.c	2005-03-22 00:17:56.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/ttpci/av7110.c	2005-03-22 00:18:08.000000000 +0100
@@ -188,6 +188,15 @@ static void arm_error(struct av7110 *av7
 	recover_arm(av7110);
 }
 
+static void av7110_arm_sync(struct av7110 *av7110)
+{
+	av7110->arm_rmmod = 1;
+	wake_up_interruptible(&av7110->arm_wait);
+
+	while (av7110->arm_thread)
+		msleep(1);
+}
+
 static int arm_thread(void *data)
 {
 	struct av7110 *av7110 = data;
@@ -1461,6 +1470,11 @@ static int check_firmware(struct av7110*
 
 #ifdef CONFIG_DVB_AV7110_FIRMWARE_FILE
 #include "av7110_firm.h"
+static void put_firmware(struct av7110* av7110)
+{
+	av7110->bin_fw = NULL;
+}
+
 static inline int get_firmware(struct av7110* av7110)
 {
 	av7110->bin_fw = dvb_ttpci_fw;
@@ -1468,6 +1482,11 @@ static inline int get_firmware(struct av
 	return check_firmware(av7110);
 }
 #else
+static void put_firmware(struct av7110* av7110)
+{
+	vfree(av7110->bin_fw);
+}
+
 static int get_firmware(struct av7110* av7110)
 {
 	int ret;
@@ -1960,8 +1979,10 @@ static u8 read_pwm(struct av7110* av7110
 	return pwm;
 }
 
-static void frontend_init(struct av7110 *av7110)
+static int frontend_init(struct av7110 *av7110)
 {
+	int ret;
+
 	if (av7110->dev->pci->subsystem_vendor == 0x110a) {
 		switch(av7110->dev->pci->subsystem_device) {
 		case 0x0000: // Fujitsu/Siemens DVB-Cable (ves1820/Philips CD1516(??))
@@ -2054,7 +2075,9 @@ static void frontend_init(struct av7110 
 		}
 	}
 
-	if (av7110->fe == NULL) {
+	if (!av7110->fe) {
+		/* FIXME: propagate the failure code from the lower layers */
+		ret = -ENOMEM;
 		printk("dvb-ttpci: A frontend driver was not found for device %04x/%04x subsystem %04x/%04x\n",
 		       av7110->dev->pci->vendor,
 		       av7110->dev->pci->device,
@@ -2071,13 +2094,15 @@ static void frontend_init(struct av7110 
 		FE_FUNC_OVERRIDE(av7110->fe->ops->dishnetwork_send_legacy_command, av7110->fe_dishnetwork_send_legacy_command, av7110_fe_dishnetwork_send_legacy_command);
 		FE_FUNC_OVERRIDE(av7110->fe->ops->set_frontend, av7110->fe_set_frontend, av7110_fe_set_frontend);
 
-		if (dvb_register_frontend(av7110->dvb_adapter, av7110->fe)) {
+		ret = dvb_register_frontend(av7110->dvb_adapter, av7110->fe);
+		if (ret < 0) {
 			printk("av7110: Frontend registration failed!\n");
 			if (av7110->fe->ops->release)
 				av7110->fe->ops->release(av7110->fe);
 			av7110->fe = NULL;
 		}
 	}
+	return ret;
 }
 
 /* Budgetpatch note:
@@ -2147,10 +2172,10 @@ static void frontend_init(struct av7110 
  */
 static int av7110_attach(struct saa7146_dev* dev, struct saa7146_pci_extension_data *pci_ext)
 {
-	struct av7110 *av7110 = NULL;
-	int length = TS_WIDTH * TS_HEIGHT;
-	int ret = 0;
-	int count = 0;
+	const int length = TS_WIDTH * TS_HEIGHT;
+	struct pci_dev *pdev = dev->pci;
+	struct av7110 *av7110;
+	int ret, count = 0;
 
 	dprintk(4, "dev: %p\n", dev);
 
@@ -2244,7 +2269,8 @@ static int av7110_attach(struct saa7146_
 	}
 
 	/* prepare the av7110 device struct */
-	if (!(av7110 = kmalloc (sizeof (struct av7110), GFP_KERNEL))) {
+	av7110 = kmalloc(sizeof(struct av7110), GFP_KERNEL);
+	if (!av7110) {
 		dprintk(1, "out of memory\n");
 		return -ENOMEM;
 	}
@@ -2255,12 +2281,14 @@ static int av7110_attach(struct saa7146_
 	av7110->dev = dev;
 	dev->ext_priv = av7110;
 
-	if ((ret = get_firmware(av7110))) {
-		kfree(av7110);
-		return ret;
-	}
+	ret = get_firmware(av7110);
+	if (ret < 0)
+		goto err_kfree_0;
 
-	dvb_register_adapter(&av7110->dvb_adapter, av7110->card_name, THIS_MODULE);
+	ret = dvb_register_adapter(&av7110->dvb_adapter, av7110->card_name,
+				   THIS_MODULE);
+	if (ret < 0)
+		goto err_put_firmware_1;
 
 	/* the Siemens DVB needs this if you want to have the i2c chips
 	   get recognized before the main driver is fully loaded */
@@ -2275,21 +2303,21 @@ static int av7110_attach(struct saa7146_
 
 	saa7146_i2c_adapter_prepare(dev, &av7110->i2c_adap, SAA7146_I2C_BUS_BIT_RATE_120); /* 275 kHz */
 
-	if (i2c_add_adapter(&av7110->i2c_adap) < 0) {
-err_no_mem:
-		dvb_unregister_adapter (av7110->dvb_adapter);
-		kfree(av7110);
-		return -ENOMEM;
-	}
+	ret = i2c_add_adapter(&av7110->i2c_adap);
+	if (ret < 0)
+		goto err_dvb_unregister_adapter_2;
 
-	ttpci_eeprom_parse_mac(&av7110->i2c_adap, av7110->dvb_adapter->proposed_mac);
+	ttpci_eeprom_parse_mac(&av7110->i2c_adap,
+			       av7110->dvb_adapter->proposed_mac);
+	ret = -ENOMEM;
 
 	if (budgetpatch) {
 		spin_lock_init(&av7110->feedlock1);
-		av7110->grabbing = saa7146_vmalloc_build_pgtable(
-					 dev->pci, length, &av7110->pt);
+		av7110->grabbing = saa7146_vmalloc_build_pgtable(pdev, length,
+								 &av7110->pt);
 		if (!av7110->grabbing)
-			goto err_no_mem;
+			goto err_i2c_del_3;
+
 		saa7146_write(dev, PCI_BT_V1, 0x1c1f101f);
 		saa7146_write(dev, BCS_CTRL, 0x80400040);
 		/* set dd1 stream a & b */
@@ -2396,43 +2424,43 @@ err_no_mem:
 	av7110->arm_thread = NULL;
 
 	/* allocate and init buffers */
-        av7110->debi_virt = pci_alloc_consistent(dev->pci, 8192,
-						 &av7110->debi_bus);
-	if (!av7110->debi_virt) {
-		ret = -ENOMEM;
-                goto err;
-	}
+	av7110->debi_virt = pci_alloc_consistent(pdev, 8192, &av7110->debi_bus);
+	if (!av7110->debi_virt)
+		goto err_saa71466_vfree_4;
+
 
 	av7110->iobuf = vmalloc(AVOUTLEN+AOUTLEN+BMPLEN+4*IPACKS);
-	if (!av7110->iobuf) {
-		ret = -ENOMEM;
-                goto err;
-	}
+	if (!av7110->iobuf)
+		goto err_pci_free_5;
 
-	av7110_av_init(av7110);
+	ret = av7110_av_init(av7110);
+	if (ret < 0)
+		goto err_iobuf_vfree_6;
 
 	/* init BMP buffer */
 	av7110->bmpbuf = av7110->iobuf+AVOUTLEN+AOUTLEN;
 	init_waitqueue_head(&av7110->bmpq);
 
-	av7110_ca_init(av7110);
+	ret = av7110_ca_init(av7110);
+	if (ret < 0)
+		goto err_av7110_av_exit_7;
 
 	/* load firmware into AV7110 cards */
-	av7110_bootarm(av7110);
-	if (av7110_firmversion(av7110)) {
-		ret = -EIO;
-		goto err2;
-	}
+	ret = av7110_bootarm(av7110);
+	if (ret < 0)
+		goto err_av7110_ca_exit_8;
+
+	ret = av7110_firmversion(av7110);
+	if (ret < 0)
+		goto err_stop_arm_9;
 
 	if (FW_VERSION(av7110->arm_app)<0x2501)
 		printk ("dvb-ttpci: Warning, firmware version 0x%04x is too old. "
 			"System might be unstable!\n", FW_VERSION(av7110->arm_app));
 
-	if (kernel_thread(arm_thread, (void *) av7110, 0) < 0) {
-		printk("dvb-ttpci: failed to start arm_mon kernel thread @ card %d\n",
-		       av7110->dvb_adapter->num);
-		goto err2;
-	}
+	ret = kernel_thread(arm_thread, (void *) av7110, 0);
+	if (ret < 0)
+		goto err_stop_arm_9;
 
 	/* set initial volume in mixer struct */
 	av7110->mixer.volume_left  = volume;
@@ -2440,59 +2468,65 @@ err_no_mem:
 
 	init_av7110_av(av7110);
 
-	av7110_register(av7110);
+	ret = av7110_register(av7110);
+	if (ret < 0)
+		goto err_arm_thread_stop_10;
 
 	/* special case DVB-C: these cards have an analog tuner
 	   plus need some special handling, so we have separate
 	   saa7146_ext_vv data for these... */
 	ret = av7110_init_v4l(av7110);
-
-	if (ret)
-		goto err3;
+	if (ret < 0)
+		goto err_av7110_unregister_11;
 
 	av7110->dvb_adapter->priv = av7110;
-	frontend_init(av7110);
+	ret = frontend_init(av7110);
+	if (ret < 0)
+		goto err_av7110_exit_v4l_12;
 
 #if defined(CONFIG_INPUT_EVDEV) || defined(CONFIG_INPUT_EVDEV_MODULE)
 	av7110_ir_init();
 #endif
 	printk(KERN_INFO "dvb-ttpci: found av7110-%d.\n", av7110_num);
-	av7110->device_initialized = 1;
 	av7110_num++;
-        return 0;
+out:
+	return ret;
 
-err3:
-	av7110->arm_rmmod = 1;
-	wake_up_interruptible(&av7110->arm_wait);
-	while (av7110->arm_thread)
-		msleep(1);
-err2:
+err_av7110_exit_v4l_12:
+	av7110_exit_v4l(av7110);
+err_av7110_unregister_11:
+	dvb_unregister(av7110);
+err_arm_thread_stop_10:
+	av7110_arm_sync(av7110);
+err_stop_arm_9:
+	/* Nothing to do. Rejoice. */
+err_av7110_ca_exit_8:
 	av7110_ca_exit(av7110);
+err_av7110_av_exit_7:
 	av7110_av_exit(av7110);
-err:
+err_iobuf_vfree_6:
+	vfree(av7110->iobuf);
+err_pci_free_5:
+	pci_free_consistent(pdev, 8192, av7110->debi_virt, av7110->debi_bus);
+err_saa71466_vfree_4:
+	if (!av7110->grabbing)
+		saa7146_pgtable_free(pdev, &av7110->pt);
+err_i2c_del_3:
 	i2c_del_adapter(&av7110->i2c_adap);
-
+err_dvb_unregister_adapter_2:
 	dvb_unregister_adapter(av7110->dvb_adapter);
-
-	if (NULL != av7110->debi_virt)
-		pci_free_consistent(dev->pci, 8192, av7110->debi_virt, av7110->debi_bus);
-	if (NULL != av7110->iobuf)
-		vfree(av7110->iobuf);
-	if (NULL != av7110 ) {
+err_put_firmware_1:
+	put_firmware(av7110);
+err_kfree_0:
 	kfree(av7110);
-	}
-
-	return ret;
+	goto out;
 }
 
 static int av7110_detach(struct saa7146_dev* saa)
 {
-	struct av7110 *av7110 = (struct av7110*)saa->ext_priv;
+	struct av7110 *av7110 = saa->ext_priv;
 	dprintk(4, "%p\n", av7110);
 
-	if (!av7110->device_initialized )
-		return 0;
-
 	if (budgetpatch) {
 		/* Disable RPS1 */
 		saa7146_write(saa, MC1, MASK_29);
@@ -2507,11 +2541,7 @@ static int av7110_detach(struct saa7146_
 	}
 	av7110_exit_v4l(av7110);
 
-	av7110->arm_rmmod=1;
-	wake_up_interruptible(&av7110->arm_wait);
-
-	while (av7110->arm_thread)
-		msleep(1);
+	av7110_arm_sync(av7110);
 
 	tasklet_kill(&av7110->debi_tasklet);
 	tasklet_kill(&av7110->gpio_tasklet);
@@ -2533,11 +2563,11 @@ static int av7110_detach(struct saa7146_
 	dvb_unregister_adapter (av7110->dvb_adapter);
 
 	av7110_num--;
-#ifndef CONFIG_DVB_AV7110_FIRMWARE_FILE
-	if (av7110->bin_fw)
-		vfree(av7110->bin_fw);
-#endif
+
+	put_firmware(av7110);
+
 	kfree(av7110);
+
 	saa->ext_priv = NULL;
 
 	return 0;
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/ttpci/av7110.h
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/ttpci/av7110.h	2005-03-21 23:27:57.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/ttpci/av7110.h	2005-03-22 00:18:08.000000000 +0100
@@ -231,8 +231,6 @@ struct av7110 {
 	u32		    ir_config;
 
 	/* firmware stuff */
-	unsigned int device_initialized;
-
 	unsigned char *bin_fw;
 	unsigned long size_fw;
 
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/ttpci/av7110_av.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/ttpci/av7110_av.c	2005-03-21 23:27:57.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/ttpci/av7110_av.c	2005-03-22 00:18:08.000000000 +0100
@@ -1426,25 +1426,34 @@ void av7110_av_unregister(struct av7110 
 
 int av7110_av_init(struct av7110 *av7110)
 {
+	void (*play[])(u8 *, int, void *) = { play_audio_cb, play_video_cb };
+	int i, ret;
+
 	av7110->vidmode = VIDEO_MODE_PAL;
 
-	av7110_ipack_init(&av7110->ipack[0], IPACKS, play_audio_cb);
-	av7110->ipack[0].data = (void *) av7110;
-	av7110_ipack_init(&av7110->ipack[1], IPACKS, play_video_cb);
-	av7110->ipack[1].data = (void *) av7110;
+	for (i = 0; i < 2; i++) {
+		struct ipack *ipack = av7110->ipack + i;
+
+		ret = av7110_ipack_init(ipack, IPACKS, play[i]);
+		if (ret < 0) {
+			if (i)
+				av7110_ipack_free(--ipack);
+			goto out;
+		}
+		ipack->data = av7110;
+	}
 
 	dvb_ringbuffer_init(&av7110->avout, av7110->iobuf, AVOUTLEN);
 	dvb_ringbuffer_init(&av7110->aout, av7110->iobuf + AVOUTLEN, AOUTLEN);
 
 	av7110->kbuf[0] = (u8 *)(av7110->iobuf + AVOUTLEN + AOUTLEN + BMPLEN);
 	av7110->kbuf[1] = av7110->kbuf[0] + 2 * IPACKS;
-
-	return 0;
+out:
+	return ret;
 }
 
-int av7110_av_exit(struct av7110 *av7110)
+void av7110_av_exit(struct av7110 *av7110)
 {
 	av7110_ipack_free(&av7110->ipack[0]);
 	av7110_ipack_free(&av7110->ipack[1]);
-	return 0;
 }
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/ttpci/av7110_av.h
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/ttpci/av7110_av.h	2005-03-21 23:27:57.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/ttpci/av7110_av.h	2005-03-22 00:18:08.000000000 +0100
@@ -23,7 +23,7 @@ extern void av7110_p2t_write(u8 const *b
 extern int av7110_av_register(struct av7110 *av7110);
 extern void av7110_av_unregister(struct av7110 *av7110);
 extern int av7110_av_init(struct av7110 *av7110);
-extern int av7110_av_exit(struct av7110 *av7110);
+extern void av7110_av_exit(struct av7110 *av7110);
 
 
 #endif /* _AV7110_AV_H_ */
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/ttpci/av7110_ca.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/ttpci/av7110_ca.c	2005-03-21 23:27:57.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/ttpci/av7110_ca.c	2005-03-22 00:18:08.000000000 +0100
@@ -91,8 +91,20 @@ void ci_get_data(struct dvb_ringbuffer *
 
 static int ci_ll_init(struct dvb_ringbuffer *cirbuf, struct dvb_ringbuffer *ciwbuf, int size)
 {
-	dvb_ringbuffer_init(cirbuf, vmalloc(size), size);
-	dvb_ringbuffer_init(ciwbuf, vmalloc(size), size);
+	struct dvb_ringbuffer *tab[] = { cirbuf, ciwbuf, NULL }, **p;
+	void *data;
+
+	for (p = tab; *p; p++) {
+		data = vmalloc(size);
+		if (!data) {
+			while (p-- != tab) {
+				vfree(p[0]->data);
+				p[0]->data = NULL;
+			}
+			return -ENOMEM;
+		}
+		dvb_ringbuffer_init(*p, data, size);
+	}
 	return 0;
 }
 
@@ -367,9 +379,9 @@ void av7110_ca_unregister(struct av7110 
 	dvb_unregister_device(av7110->ca_dev);
 }
 
-void av7110_ca_init(struct av7110* av7110)
+int av7110_ca_init(struct av7110* av7110)
 {
-	ci_ll_init(&av7110->ci_rbuffer, &av7110->ci_wbuffer, 8192);
+	return ci_ll_init(&av7110->ci_rbuffer, &av7110->ci_wbuffer, 8192);
 }
 
 void av7110_ca_exit(struct av7110* av7110)
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/ttpci/av7110_ca.h
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/ttpci/av7110_ca.h	2005-03-21 23:27:57.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/ttpci/av7110_ca.h	2005-03-22 00:18:08.000000000 +0100
@@ -8,7 +8,7 @@ extern void ci_get_data(struct dvb_ringb
 
 extern int av7110_ca_register(struct av7110 *av7110);
 extern void av7110_ca_unregister(struct av7110 *av7110);
-extern void av7110_ca_init(struct av7110* av7110);
+extern int av7110_ca_init(struct av7110* av7110);
 extern void av7110_ca_exit(struct av7110* av7110);
 
 #endif /* _AV7110_CA_H_ */
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/ttpci/av7110_ipack.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/ttpci/av7110_ipack.c	2005-03-21 23:27:57.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/ttpci/av7110_ipack.c	2005-03-22 00:18:08.000000000 +0100
@@ -37,7 +37,6 @@ int av7110_ipack_init(struct ipack *p, i
 
 void av7110_ipack_free(struct ipack *p)
 {
-	if (p->buf)
 	vfree(p->buf);
 }
 

--

