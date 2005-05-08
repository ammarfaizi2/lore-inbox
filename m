Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262945AbVEHTwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262945AbVEHTwV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 15:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262879AbVEHTwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 15:52:21 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:7575 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262945AbVEHTKb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 15:10:31 -0400
Message-Id: <20050508184348.617142000@abc>
References: <20050508184229.957247000@abc>
Date: Sun, 08 May 2005 20:42:55 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-core-registeradap-cleanup.patch
X-SA-Exim-Connect-IP: 217.231.45.168
Subject: [DVB patch 26/37] modified dvb_register_adapter() to avoid kmalloc/kfree
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Modified dvb_register_adapter() to avoid kmalloc/kfree. Drivers have to
embed struct dvb_adapter into their private data struct from now on.
(Andreas Oberritter)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
---

 drivers/media/dvb/b2c2/skystar2.c                 |   20 +++++++--------
 drivers/media/dvb/bt8xx/dvb-bt8xx.c               |   20 +++++++--------
 drivers/media/dvb/bt8xx/dvb-bt8xx.h               |    2 -
 drivers/media/dvb/cinergyT2/cinergyT2.c           |   12 ++++-----
 drivers/media/dvb/dibusb/dvb-dibusb-dvb.c         |   10 +++----
 drivers/media/dvb/dibusb/dvb-dibusb-fe-i2c.c      |    4 +--
 drivers/media/dvb/dibusb/dvb-dibusb.h             |    2 -
 drivers/media/dvb/dvb-core/dvbdev.c               |    9 -------
 drivers/media/dvb/dvb-core/dvbdev.h               |    2 -
 drivers/media/dvb/ttpci/av7110.c                  |   28 +++++++++++-----------
 drivers/media/dvb/ttpci/av7110.h                  |    2 -
 drivers/media/dvb/ttpci/av7110_av.c               |    4 +--
 drivers/media/dvb/ttpci/av7110_ca.c               |    2 -
 drivers/media/dvb/ttpci/av7110_hw.c               |    8 +++---
 drivers/media/dvb/ttpci/av7110_v4l.c              |   10 +++----
 drivers/media/dvb/ttpci/budget-av.c               |   12 ++++-----
 drivers/media/dvb/ttpci/budget-ci.c               |    6 ++--
 drivers/media/dvb/ttpci/budget-core.c             |   12 ++++-----
 drivers/media/dvb/ttpci/budget-patch.c            |    4 +--
 drivers/media/dvb/ttpci/budget.c                  |    4 +--
 drivers/media/dvb/ttpci/budget.h                  |    2 -
 drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c |   20 +++++++--------
 drivers/media/dvb/ttusb-dec/ttusb_dec.c           |   20 +++++++--------
 drivers/media/video/video-buf-dvb.c               |   12 ++++-----
 include/media/video-buf-dvb.h                     |    2 -
 25 files changed, 111 insertions(+), 118 deletions(-)

Index: linux-2.6.12-rc4/drivers/media/dvb/dvb-core/dvbdev.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/dvb-core/dvbdev.c	2005-05-08 18:09:01.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/dvb-core/dvbdev.c	2005-05-08 18:12:25.000000000 +0200
@@ -285,9 +285,8 @@ skip:
 }
 
 
-int dvb_register_adapter(struct dvb_adapter **padap, const char *name, struct module *module)
+int dvb_register_adapter(struct dvb_adapter *adap, const char *name, struct module *module)
 {
-	struct dvb_adapter *adap;
 	int num;
 
 	if (down_interruptible (&dvbdev_register_lock))
@@ -298,11 +297,6 @@ int dvb_register_adapter(struct dvb_adap
 		return -ENFILE;
 	}
 
-	if (!(*padap = adap = kmalloc(sizeof(struct dvb_adapter), GFP_KERNEL))) {
-		up(&dvbdev_register_lock);
-		return -ENOMEM;
-	}
-
 	memset (adap, 0, sizeof(struct dvb_adapter));
 	INIT_LIST_HEAD (&adap->device_list);
 
@@ -330,7 +324,6 @@ int dvb_unregister_adapter(struct dvb_ad
 		return -ERESTARTSYS;
 	list_del (&adap->list_head);
 	up (&dvbdev_register_lock);
-	kfree (adap);
 	return 0;
 }
 EXPORT_SYMBOL(dvb_unregister_adapter);
Index: linux-2.6.12-rc4/drivers/media/dvb/dvb-core/dvbdev.h
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/dvb-core/dvbdev.h	2005-05-08 18:09:01.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/dvb-core/dvbdev.h	2005-05-08 18:12:25.000000000 +0200
@@ -76,7 +76,7 @@ struct dvb_device {
 };
 
 
-extern int dvb_register_adapter (struct dvb_adapter **padap, const char *name, struct module *module);
+extern int dvb_register_adapter (struct dvb_adapter *adap, const char *name, struct module *module);
 extern int dvb_unregister_adapter (struct dvb_adapter *adap);
 
 extern int dvb_register_device (struct dvb_adapter *adap,
Index: linux-2.6.12-rc4/drivers/media/dvb/b2c2/skystar2.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/b2c2/skystar2.c	2005-05-08 18:09:01.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/b2c2/skystar2.c	2005-05-08 18:12:25.000000000 +0200
@@ -97,7 +97,7 @@ struct adapter {
 	u8 mac_addr[8];
 	u32 dw_sram_type;
 
-	struct dvb_adapter *dvb_adapter;
+	struct dvb_adapter dvb_adapter;
 	struct dvb_demux demux;
 	struct dmxdev dmxdev;
 	struct dmx_frontend hw_frontend;
@@ -2461,7 +2461,7 @@ static void frontend_init(struct adapter
 		       skystar2->pdev->subsystem_vendor,
 		       skystar2->pdev->subsystem_device);
 	} else {
-		if (dvb_register_frontend(skystar2->dvb_adapter, skystar2->fe)) {
+		if (dvb_register_frontend(&skystar2->dvb_adapter, skystar2->fe)) {
 			printk("skystar2: Frontend registration failed!\n");
 			if (skystar2->fe->ops->release)
 				skystar2->fe->ops->release(skystar2->fe);
@@ -2486,17 +2486,17 @@ static int skystar2_probe(struct pci_dev
 	if (ret < 0)
 		goto out;
 
-	ret = dvb_register_adapter(&dvb_adapter, skystar2_pci_driver.name,
+	adapter = pci_get_drvdata(pdev);
+	dvb_adapter = &adapter->dvb_adapter;
+
+	ret = dvb_register_adapter(dvb_adapter, skystar2_pci_driver.name,
 				   THIS_MODULE);
 	if (ret < 0) {
 		printk("%s: Error registering DVB adapter\n", __FUNCTION__);
 		goto err_halt;
 	}
 
-	adapter = pci_get_drvdata(pdev);
-
 	dvb_adapter->priv = adapter;
-	adapter->dvb_adapter = dvb_adapter;
 
 
 	init_MUTEX(&adapter->i2c_sem);
@@ -2541,7 +2541,7 @@ static int skystar2_probe(struct pci_dev
 	adapter->dmxdev.demux = dmx;
 	adapter->dmxdev.capabilities = 0;
 
-	ret = dvb_dmxdev_init(&adapter->dmxdev, adapter->dvb_adapter);
+	ret = dvb_dmxdev_init(&adapter->dmxdev, &adapter->dvb_adapter);
 	if (ret < 0)
 		goto err_dmx_release;
 
@@ -2559,7 +2559,7 @@ static int skystar2_probe(struct pci_dev
 	if (ret < 0)
 		goto err_remove_mem_frontend;
 
-	dvb_net_init(adapter->dvb_adapter, &adapter->dvbnet, &dvbdemux->dmx);
+	dvb_net_init(&adapter->dvb_adapter, &adapter->dvbnet, &dvbdemux->dmx);
 
 	frontend_init(adapter);
 out:
@@ -2576,7 +2576,7 @@ err_dmx_release:
 err_i2c_del:
 	i2c_del_adapter(&adapter->i2c_adap);
 err_dvb_unregister:
-	dvb_unregister_adapter(adapter->dvb_adapter);
+	dvb_unregister_adapter(&adapter->dvb_adapter);
 err_halt:
 	driver_halt(pdev);
 	goto out;
@@ -2605,7 +2605,7 @@ static void skystar2_remove(struct pci_d
 	if (adapter->fe != NULL)
 		dvb_unregister_frontend(adapter->fe);
 
-	dvb_unregister_adapter(adapter->dvb_adapter);
+	dvb_unregister_adapter(&adapter->dvb_adapter);
 
 			i2c_del_adapter(&adapter->i2c_adap);
 
Index: linux-2.6.12-rc4/drivers/media/dvb/cinergyT2/cinergyT2.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/cinergyT2/cinergyT2.c	2005-05-08 18:09:01.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/cinergyT2/cinergyT2.c	2005-05-08 18:12:25.000000000 +0200
@@ -119,7 +119,7 @@ struct cinergyt2 {
 	struct dvb_demux demux;
 	struct usb_device *udev;
 	struct semaphore sem;
-	struct dvb_adapter *adapter;
+	struct dvb_adapter adapter;
 	struct dvb_device *fedev;
 	struct dmxdev dmxdev;
 	struct dvb_net dvbnet;
@@ -813,15 +813,15 @@ static int cinergyt2_probe (struct usb_i
 	cinergyt2->dmxdev.demux = &cinergyt2->demux.dmx;
 	cinergyt2->dmxdev.capabilities = 0;
 
-	if ((err = dvb_dmxdev_init(&cinergyt2->dmxdev, cinergyt2->adapter)) < 0) {
+	if ((err = dvb_dmxdev_init(&cinergyt2->dmxdev, &cinergyt2->adapter)) < 0) {
 		dprintk(1, "dvb_dmxdev_init() failed (err = %d)\n", err);
 		goto bailout;
 	}
 
-	if (dvb_net_init(cinergyt2->adapter, &cinergyt2->dvbnet, &cinergyt2->demux.dmx))
+	if (dvb_net_init(&cinergyt2->adapter, &cinergyt2->dvbnet, &cinergyt2->demux.dmx))
 		dprintk(1, "dvb_net_init() failed!\n");
 
-	dvb_register_device(cinergyt2->adapter, &cinergyt2->fedev,
+	dvb_register_device(&cinergyt2->adapter, &cinergyt2->fedev,
 			    &cinergyt2_fe_template, cinergyt2,
 			    DVB_DEVICE_FRONTEND);
 
@@ -848,7 +848,7 @@ static int cinergyt2_probe (struct usb_i
 bailout:
 	dvb_dmxdev_release(&cinergyt2->dmxdev);
 	dvb_dmx_release(&cinergyt2->demux);
-	dvb_unregister_adapter (cinergyt2->adapter);
+	dvb_unregister_adapter (&cinergyt2->adapter);
 	cinergyt2_free_stream_urbs (cinergyt2);
 	kfree(cinergyt2);
 	return -ENOMEM;
@@ -872,7 +872,7 @@ static void cinergyt2_disconnect (struct
 	dvb_dmxdev_release(&cinergyt2->dmxdev);
 	dvb_dmx_release(&cinergyt2->demux);
 	dvb_unregister_device(cinergyt2->fedev);
-	dvb_unregister_adapter(cinergyt2->adapter);
+	dvb_unregister_adapter(&cinergyt2->adapter);
 
 	cinergyt2_free_stream_urbs(cinergyt2);
 	up(&cinergyt2->sem);
Index: linux-2.6.12-rc4/drivers/media/dvb/dibusb/dvb-dibusb-fe-i2c.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/dibusb/dvb-dibusb-fe-i2c.c	2005-05-08 18:09:01.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/dibusb/dvb-dibusb-fe-i2c.c	2005-05-08 18:12:25.000000000 +0200
@@ -183,7 +183,7 @@ int dibusb_fe_init(struct usb_dibusb* di
 		       dib->dibdev->name);
 		return -ENODEV;
 	} else {
-		if (dvb_register_frontend(dib->adapter, dib->fe)) {
+		if (dvb_register_frontend(&dib->adapter, dib->fe)) {
 			err("Frontend registration failed.");
 			if (dib->fe->ops->release)
 				dib->fe->ops->release(dib->fe);
@@ -206,7 +206,7 @@ int dibusb_i2c_init(struct usb_dibusb *d
 {
 	int ret = 0;
 
-	dib->adapter->priv = dib;
+	dib->adapter.priv = dib;
 
 	strncpy(dib->i2c_adap.name,dib->dibdev->name,I2C_NAME_SIZE);
 #ifdef I2C_ADAP_CLASS_TV_DIGITAL
Index: linux-2.6.12-rc4/drivers/media/dvb/dibusb/dvb-dibusb.h
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/dibusb/dvb-dibusb.h	2005-05-08 18:09:01.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/dibusb/dvb-dibusb.h	2005-05-08 18:12:25.000000000 +0200
@@ -181,7 +181,7 @@ struct usb_dibusb {
 	struct semaphore i2c_sem;
 
 	/* dvb */
-	struct dvb_adapter *adapter;
+	struct dvb_adapter adapter;
 	struct dmxdev dmxdev;
 	struct dvb_demux demux;
 	struct dvb_net dvb_net;
Index: linux-2.6.12-rc4/drivers/media/dvb/dibusb/dvb-dibusb-dvb.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/dibusb/dvb-dibusb-dvb.c	2005-05-08 18:09:01.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/dibusb/dvb-dibusb-dvb.c	2005-05-08 18:12:25.000000000 +0200
@@ -131,7 +131,7 @@ int dibusb_dvb_init(struct usb_dibusb *d
 		deb_info("dvb_register_adapter failed: error %d", ret);
 		goto err;
 	}
-	dib->adapter->priv = dib;
+	dib->adapter.priv = dib;
 	
 /* i2c is done in dibusb_i2c_init */
 	
@@ -151,18 +151,18 @@ int dibusb_dvb_init(struct usb_dibusb *d
 	dib->dmxdev.filternum = dib->demux.filternum;
 	dib->dmxdev.demux = &dib->demux.dmx;
 	dib->dmxdev.capabilities = 0;
-	if ((ret = dvb_dmxdev_init(&dib->dmxdev, dib->adapter)) < 0) {
+	if ((ret = dvb_dmxdev_init(&dib->dmxdev, &dib->adapter)) < 0) {
 		err("dvb_dmxdev_init failed: error %d",ret);
 		goto err_dmx_dev;
 	}
 
-	dvb_net_init(dib->adapter, &dib->dvb_net, &dib->demux.dmx);
+	dvb_net_init(&dib->adapter, &dib->dvb_net, &dib->demux.dmx);
 
 	goto success;
 err_dmx_dev:
 	dvb_dmx_release(&dib->demux);
 err_dmx:
-	dvb_unregister_adapter(dib->adapter);
+	dvb_unregister_adapter(&dib->adapter);
 err:
 	return ret;
 success:
@@ -179,7 +179,7 @@ int dibusb_dvb_exit(struct usb_dibusb *d
 		dib->demux.dmx.close(&dib->demux.dmx);
 		dvb_dmxdev_release(&dib->dmxdev);
 		dvb_dmx_release(&dib->demux);
-		dvb_unregister_adapter(dib->adapter);
+		dvb_unregister_adapter(&dib->adapter);
 	}
 	return 0;
 }
Index: linux-2.6.12-rc4/drivers/media/dvb/ttpci/budget.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/ttpci/budget.c	2005-05-08 18:09:01.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/ttpci/budget.c	2005-05-08 18:12:25.000000000 +0200
@@ -468,7 +468,7 @@ static void frontend_init(struct budget 
 		       budget->dev->pci->subsystem_vendor,
 		       budget->dev->pci->subsystem_device);
 	} else {
-		if (dvb_register_frontend(budget->dvb_adapter, budget->dvb_frontend)) {
+		if (dvb_register_frontend(&budget->dvb_adapter, budget->dvb_frontend)) {
 			printk("budget: Frontend registration failed!\n");
 			if (budget->dvb_frontend->ops->release)
 				budget->dvb_frontend->ops->release(budget->dvb_frontend);
@@ -497,7 +497,7 @@ static int budget_attach (struct saa7146
 		return err;
 	}
 
-	budget->dvb_adapter->priv = budget;
+	budget->dvb_adapter.priv = budget;
 	frontend_init(budget);
 
 	return 0;
Index: linux-2.6.12-rc4/drivers/media/dvb/ttpci/av7110_v4l.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/ttpci/av7110_v4l.c	2005-05-08 18:09:01.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/ttpci/av7110_v4l.c	2005-05-08 18:12:25.000000000 +0200
@@ -46,7 +46,7 @@ int msp_writereg(struct av7110 *av7110, 
 
 	if (i2c_transfer(&av7110->i2c_adap, &msgs, 1) != 1) {
 		dprintk(1, "dvb-ttpci: failed @ card %d, %u = %u\n",
-		       av7110->dvb_adapter->num, reg, val);
+		       av7110->dvb_adapter.num, reg, val);
 		return -EIO;
 	}
 	return 0;
@@ -63,7 +63,7 @@ static int msp_readreg(struct av7110 *av
 
 	if (i2c_transfer(&av7110->i2c_adap, &msgs[0], 2) != 2) {
 		dprintk(1, "dvb-ttpci: failed @ card %d, %u\n",
-		       av7110->dvb_adapter->num, reg);
+		       av7110->dvb_adapter.num, reg);
 		return -EIO;
 	}
 	*val = (msg2[0] << 8) | msg2[1];
@@ -552,13 +552,13 @@ int av7110_init_analog_module(struct av7
 		return -ENODEV;
 
 	printk("dvb-ttpci: DVB-C analog module @ card %d detected, initializing MSP3400\n",
-		av7110->dvb_adapter->num);
+		av7110->dvb_adapter.num);
 	av7110->adac_type = DVB_ADAC_MSP;
 	msleep(100); // the probing above resets the msp...
 	msp_readreg(av7110, MSP_RD_DSP, 0x001e, &version1);
 	msp_readreg(av7110, MSP_RD_DSP, 0x001f, &version2);
 	dprintk(1, "dvb-ttpci: @ card %d MSP3400 version 0x%04x 0x%04x\n",
-		av7110->dvb_adapter->num, version1, version2);
+		av7110->dvb_adapter.num, version1, version2);
 	msp_writereg(av7110, MSP_WR_DSP, 0x0013, 0x0c00);
 	msp_writereg(av7110, MSP_WR_DSP, 0x0000, 0x7f00); // loudspeaker + headphone
 	msp_writereg(av7110, MSP_WR_DSP, 0x0008, 0x0220); // loudspeaker source
@@ -596,7 +596,7 @@ int av7110_init_analog_module(struct av7
 		/* init the saa7113 */
 		while (*i != 0xff) {
 			if (i2c_writereg(av7110, 0x48, i[0], i[1]) != 1) {
-				dprintk(1, "saa7113 initialization failed @ card %d", av7110->dvb_adapter->num);
+				dprintk(1, "saa7113 initialization failed @ card %d", av7110->dvb_adapter.num);
 				break;
 			}
 			i += 2;
Index: linux-2.6.12-rc4/drivers/media/dvb/ttpci/budget-av.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/ttpci/budget-av.c	2005-05-08 18:09:01.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/ttpci/budget-av.c	2005-05-08 18:12:25.000000000 +0200
@@ -297,7 +297,7 @@ static int ciintf_init(struct budget_av 
 	budget_av->ca.slot_ts_enable = ciintf_slot_ts_enable;
 	budget_av->ca.poll_slot_status = ciintf_poll_slot_status;
 	budget_av->ca.data = budget_av;
-	if ((result = dvb_ca_en50221_init(budget_av->budget.dvb_adapter,
+	if ((result = dvb_ca_en50221_init(&budget_av->budget.dvb_adapter,
 					  &budget_av->ca, 0, 1)) != 0) {
 		printk("budget_av: CI interface detected, but initialisation failed.\n");
 		goto error;
@@ -767,7 +767,7 @@ static void frontend_init(struct budget_
 		       budget_av->budget.dev->pci->subsystem_device);
 	} else {
 		if (dvb_register_frontend
-		    (budget_av->budget.dvb_adapter, budget_av->budget.dvb_frontend)) {
+		    (&budget_av->budget.dvb_adapter, budget_av->budget.dvb_frontend)) {
 			printk("budget-av: Frontend registration failed!\n");
 			if (budget_av->budget.dvb_frontend->ops->release)
 				budget_av->budget.dvb_frontend->ops->release(budget_av->budget.dvb_frontend);
@@ -875,18 +875,18 @@ static int budget_av_attach(struct saa71
 	/* fixme: find some sane values here... */
 	saa7146_write(dev, PCI_BT_V1, 0x1c00101f);
 
-	mac = budget_av->budget.dvb_adapter->proposed_mac;
+	mac = budget_av->budget.dvb_adapter.proposed_mac;
 	if (i2c_readregs(&budget_av->budget.i2c_adap, 0xa0, 0x30, mac, 6)) {
 		printk("KNC1-%d: Could not read MAC from KNC1 card\n",
-		       budget_av->budget.dvb_adapter->num);
+		       budget_av->budget.dvb_adapter.num);
 		memset(mac, 0, 6);
 	} else {
 		printk("KNC1-%d: MAC addr = %.2x:%.2x:%.2x:%.2x:%.2x:%.2x\n",
-		       budget_av->budget.dvb_adapter->num,
+		       budget_av->budget.dvb_adapter.num,
 		       mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
 	}
 
-	budget_av->budget.dvb_adapter->priv = budget_av;
+	budget_av->budget.dvb_adapter.priv = budget_av;
 	frontend_init(budget_av);
 
 	if (enable_ci)
Index: linux-2.6.12-rc4/drivers/media/dvb/ttpci/budget.h
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/ttpci/budget.h	2005-05-08 18:09:01.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/ttpci/budget.h	2005-05-08 18:12:25.000000000 +0200
@@ -64,7 +64,7 @@ struct budget {
 
 	spinlock_t debilock;
 
-	struct dvb_adapter *dvb_adapter;
+	struct dvb_adapter dvb_adapter;
 	struct dvb_frontend *dvb_frontend;
 	void *priv;
 };
Index: linux-2.6.12-rc4/drivers/media/dvb/ttpci/budget-patch.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/ttpci/budget-patch.c	2005-05-08 18:09:01.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/ttpci/budget-patch.c	2005-05-08 18:12:25.000000000 +0200
@@ -453,7 +453,7 @@ static void frontend_init(struct budget_
 		       budget->dev->pci->subsystem_vendor,
 		       budget->dev->pci->subsystem_device);
 	} else {
-		if (dvb_register_frontend(budget->dvb_adapter, budget->dvb_frontend)) {
+		if (dvb_register_frontend(&budget->dvb_adapter, budget->dvb_frontend)) {
 			printk("budget-av: Frontend registration failed!\n");
 			if (budget->dvb_frontend->ops->release)
 				budget->dvb_frontend->ops->release(budget->dvb_frontend);
@@ -702,7 +702,7 @@ static int budget_patch_attach (struct s
 
         dev->ext_priv = budget;
 
-	budget->dvb_adapter->priv = budget;
+	budget->dvb_adapter.priv = budget;
 	frontend_init(budget);
 
         return 0;
Index: linux-2.6.12-rc4/drivers/media/dvb/ttpci/av7110.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/ttpci/av7110.c	2005-05-08 18:09:01.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/ttpci/av7110.c	2005-05-08 18:12:25.000000000 +0200
@@ -130,7 +130,7 @@ static void init_av7110_av(struct av7110
 	av7110->current_input = 0;
 	if (i2c_writereg(av7110, 0x20, 0x00, 0x00) == 1) {
 		printk ("dvb-ttpci: Crystal audio DAC @ card %d detected\n",
-			av7110->dvb_adapter->num);
+			av7110->dvb_adapter.num);
 		av7110->adac_type = DVB_ADAC_CRYSTAL;
 		i2c_writereg(av7110, 0x20, 0x01, 0xd2);
 		i2c_writereg(av7110, 0x20, 0x02, 0x49);
@@ -145,13 +145,13 @@ static void init_av7110_av(struct av7110
 	}
 	else if (dev->pci->subsystem_vendor == 0x110a) {
 		printk("dvb-ttpci: DVB-C w/o analog module @ card %d detected\n",
-			av7110->dvb_adapter->num);
+			av7110->dvb_adapter.num);
 		av7110->adac_type = DVB_ADAC_NONE;
 	}
 	else {
 		av7110->adac_type = adac;
 		printk("dvb-ttpci: adac type set to %d @ card %d\n",
-			av7110->dvb_adapter->num, av7110->adac_type);
+			av7110->dvb_adapter.num, av7110->adac_type);
 	}
 
 	if (av7110->adac_type == DVB_ADAC_NONE || av7110->adac_type == DVB_ADAC_MSP) {
@@ -231,7 +231,7 @@ static int arm_thread(void *data)
 
 		if (newloops == av7110->arm_loops) {
 			printk(KERN_ERR "dvb-ttpci: ARM crashed @ card %d\n",
-			       av7110->dvb_adapter->num);
+			       av7110->dvb_adapter.num);
 
 			arm_error(av7110);
 			av7710_set_video_mode(av7110, vidmode);
@@ -1282,7 +1282,7 @@ static int av7110_register(struct av7110
 	av7110->dmxdev.demux = &dvbdemux->dmx;
 	av7110->dmxdev.capabilities = 0;
 
-	dvb_dmxdev_init(&av7110->dmxdev, av7110->dvb_adapter);
+	dvb_dmxdev_init(&av7110->dmxdev, &av7110->dvb_adapter);
 
 	av7110->hw_frontend.source = DMX_FRONTEND_0;
 
@@ -1307,11 +1307,11 @@ static int av7110_register(struct av7110
 	av7110_ca_register(av7110);
 
 #ifdef CONFIG_DVB_AV7110_OSD
-	dvb_register_device(av7110->dvb_adapter, &av7110->osd_dev,
+	dvb_register_device(&av7110->dvb_adapter, &av7110->osd_dev,
 			    &dvbdev_osd, av7110, DVB_DEVICE_OSD);
 #endif
 
-	dvb_net_init(av7110->dvb_adapter, &av7110->dvb_net, &dvbdemux->dmx);
+	dvb_net_init(&av7110->dvb_adapter, &av7110->dvb_net, &dvbdemux->dmx);
 
 	if (budgetpatch) {
 		/* initialize software demux1 without its own frontend
@@ -1334,9 +1334,9 @@ static int av7110_register(struct av7110
 		av7110->dmxdev1.demux = &dvbdemux1->dmx;
 		av7110->dmxdev1.capabilities = 0;
 
-		dvb_dmxdev_init(&av7110->dmxdev1, av7110->dvb_adapter);
+		dvb_dmxdev_init(&av7110->dmxdev1, &av7110->dvb_adapter);
 
-		dvb_net_init(av7110->dvb_adapter, &av7110->dvb_net1, &dvbdemux1->dmx);
+		dvb_net_init(&av7110->dvb_adapter, &av7110->dvb_net1, &dvbdemux1->dmx);
 		printk("dvb-ttpci: additional demux1 for budget-patch registered\n");
 	}
 	return 0;
@@ -2246,7 +2246,7 @@ static int frontend_init(struct av7110 *
 		FE_FUNC_OVERRIDE(av7110->fe->ops->dishnetwork_send_legacy_command, av7110->fe_dishnetwork_send_legacy_command, av7110_fe_dishnetwork_send_legacy_command);
 		FE_FUNC_OVERRIDE(av7110->fe->ops->set_frontend, av7110->fe_set_frontend, av7110_fe_set_frontend);
 
-		ret = dvb_register_frontend(av7110->dvb_adapter, av7110->fe);
+		ret = dvb_register_frontend(&av7110->dvb_adapter, av7110->fe);
 		if (ret < 0) {
 			printk("av7110: Frontend registration failed!\n");
 			if (av7110->fe->ops->release)
@@ -2460,7 +2460,7 @@ static int av7110_attach(struct saa7146_
 		goto err_dvb_unregister_adapter_2;
 
 	ttpci_eeprom_parse_mac(&av7110->i2c_adap,
-			       av7110->dvb_adapter->proposed_mac);
+			       av7110->dvb_adapter.proposed_mac);
 	ret = -ENOMEM;
 
 	if (budgetpatch) {
@@ -2631,7 +2631,7 @@ static int av7110_attach(struct saa7146_
 	if (ret < 0)
 		goto err_av7110_unregister_11;
 
-	av7110->dvb_adapter->priv = av7110;
+	av7110->dvb_adapter.priv = av7110;
 	ret = frontend_init(av7110);
 	if (ret < 0)
 		goto err_av7110_exit_v4l_12;
@@ -2666,7 +2666,7 @@ err_saa71466_vfree_4:
 err_i2c_del_3:
 	i2c_del_adapter(&av7110->i2c_adap);
 err_dvb_unregister_adapter_2:
-	dvb_unregister_adapter(av7110->dvb_adapter);
+	dvb_unregister_adapter(&av7110->dvb_adapter);
 err_put_firmware_1:
 	put_firmware(av7110);
 err_kfree_0:
@@ -2712,7 +2712,7 @@ static int av7110_detach(struct saa7146_
 
 	i2c_del_adapter(&av7110->i2c_adap);
 
-	dvb_unregister_adapter (av7110->dvb_adapter);
+	dvb_unregister_adapter (&av7110->dvb_adapter);
 
 	av7110_num--;
 
Index: linux-2.6.12-rc4/drivers/media/dvb/ttpci/av7110_hw.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/ttpci/av7110_hw.c	2005-05-08 18:09:01.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/ttpci/av7110_hw.c	2005-05-08 18:12:25.000000000 +0200
@@ -619,7 +619,7 @@ int av7110_firmversion(struct av7110 *av
 
 	if (av7110_fw_query(av7110, tag, buf, 16)) {
 		printk("dvb-ttpci: failed to boot firmware @ card %d\n",
-		       av7110->dvb_adapter->num);
+		       av7110->dvb_adapter.num);
 		return -EIO;
 	}
 
@@ -630,16 +630,16 @@ int av7110_firmversion(struct av7110 *av
 	av7110->avtype = (buf[8] << 16) + buf[9];
 
 	printk("dvb-ttpci: info @ card %d: firm %08x, rtsl %08x, vid %08x, app %08x\n",
-	       av7110->dvb_adapter->num, av7110->arm_fw,
+	       av7110->dvb_adapter.num, av7110->arm_fw,
 	       av7110->arm_rtsl, av7110->arm_vid, av7110->arm_app);
 
 	/* print firmware capabilities */
 	if (FW_CI_LL_SUPPORT(av7110->arm_app))
 		printk("dvb-ttpci: firmware @ card %d supports CI link layer interface\n",
-		       av7110->dvb_adapter->num);
+		       av7110->dvb_adapter.num);
 	else
 		printk("dvb-ttpci: no firmware support for CI link layer interface @ card %d\n",
-		       av7110->dvb_adapter->num);
+		       av7110->dvb_adapter.num);
 
 	return 0;
 }
Index: linux-2.6.12-rc4/drivers/media/dvb/ttpci/budget-core.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/ttpci/budget-core.c	2005-05-08 18:09:01.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/ttpci/budget-core.c	2005-05-08 18:12:25.000000000 +0200
@@ -298,7 +298,7 @@ static int budget_register(struct budget
 	budget->dmxdev.demux = &dvbdemux->dmx;
 	budget->dmxdev.capabilities = 0;
 
-	dvb_dmxdev_init(&budget->dmxdev, budget->dvb_adapter);
+	dvb_dmxdev_init(&budget->dmxdev, &budget->dvb_adapter);
 
 	budget->hw_frontend.source = DMX_FRONTEND_0;
 
@@ -316,7 +316,7 @@ static int budget_register(struct budget
 	if (ret < 0)
 		return ret;
 
-	dvb_net_init(budget->dvb_adapter, &budget->dvb_net, &dvbdemux->dmx);
+	dvb_net_init(&budget->dvb_adapter, &budget->dvb_net, &dvbdemux->dmx);
 
 	return 0;
 }
@@ -385,11 +385,11 @@ int ttpci_budget_init(struct budget *bud
 	strcpy(budget->i2c_adap.name, budget->card->name);
 
 	if (i2c_add_adapter(&budget->i2c_adap) < 0) {
-		dvb_unregister_adapter(budget->dvb_adapter);
+		dvb_unregister_adapter(&budget->dvb_adapter);
 		return -ENOMEM;
 	}
 
-	ttpci_eeprom_parse_mac(&budget->i2c_adap, budget->dvb_adapter->proposed_mac);
+	ttpci_eeprom_parse_mac(&budget->i2c_adap, budget->dvb_adapter.proposed_mac);
 
 	if (NULL ==
 	    (budget->grabbing = saa7146_vmalloc_build_pgtable(dev->pci, length, &budget->pt))) {
@@ -417,7 +417,7 @@ err:
 
 	vfree(budget->grabbing);
 
-	dvb_unregister_adapter(budget->dvb_adapter);
+	dvb_unregister_adapter(&budget->dvb_adapter);
 
 	return ret;
 }
@@ -432,7 +432,7 @@ int ttpci_budget_deinit(struct budget *b
 
 	i2c_del_adapter(&budget->i2c_adap);
 
-	dvb_unregister_adapter(budget->dvb_adapter);
+	dvb_unregister_adapter(&budget->dvb_adapter);
 
 	tasklet_kill(&budget->vpe_tasklet);
 
Index: linux-2.6.12-rc4/drivers/media/dvb/ttpci/budget-ci.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/ttpci/budget-ci.c	2005-05-08 18:09:01.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/ttpci/budget-ci.c	2005-05-08 18:12:25.000000000 +0200
@@ -395,7 +395,7 @@ static int ciintf_init(struct budget_ci 
 	budget_ci->ca.slot_shutdown = ciintf_slot_shutdown;
 	budget_ci->ca.slot_ts_enable = ciintf_slot_ts_enable;
 	budget_ci->ca.data = budget_ci;
-	if ((result = dvb_ca_en50221_init(budget_ci->budget.dvb_adapter,
+	if ((result = dvb_ca_en50221_init(&budget_ci->budget.dvb_adapter,
 					  &budget_ci->ca,
 					  DVB_CA_EN50221_FLAG_IRQ_CAMCHANGE |
 					  DVB_CA_EN50221_FLAG_IRQ_FR |
@@ -881,7 +881,7 @@ static void frontend_init(struct budget_
 		       budget_ci->budget.dev->pci->subsystem_device);
 	} else {
 		if (dvb_register_frontend
-		    (budget_ci->budget.dvb_adapter, budget_ci->budget.dvb_frontend)) {
+		    (&budget_ci->budget.dvb_adapter, budget_ci->budget.dvb_frontend)) {
 			printk("budget-ci: Frontend registration failed!\n");
 			if (budget_ci->budget.dvb_frontend->ops->release)
 				budget_ci->budget.dvb_frontend->ops->release(budget_ci->budget.dvb_frontend);
@@ -916,7 +916,7 @@ static int budget_ci_attach(struct saa71
 
 	ciintf_init(budget_ci);
 
-	budget_ci->budget.dvb_adapter->priv = budget_ci;
+	budget_ci->budget.dvb_adapter.priv = budget_ci;
 	frontend_init(budget_ci);
 
 	return 0;
Index: linux-2.6.12-rc4/drivers/media/dvb/ttpci/av7110_av.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/ttpci/av7110_av.c	2005-05-08 18:09:01.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/ttpci/av7110_av.c	2005-05-08 18:12:25.000000000 +0200
@@ -1415,10 +1415,10 @@ int av7110_av_register(struct av7110 *av
 	av7110->video_events.overflow = 0;
 	memset(&av7110->video_size, 0, sizeof (video_size_t));
 
-	dvb_register_device(av7110->dvb_adapter, &av7110->video_dev,
+	dvb_register_device(&av7110->dvb_adapter, &av7110->video_dev,
 			    &dvbdev_video, av7110, DVB_DEVICE_VIDEO);
 
-	dvb_register_device(av7110->dvb_adapter, &av7110->audio_dev,
+	dvb_register_device(&av7110->dvb_adapter, &av7110->audio_dev,
 			    &dvbdev_audio, av7110, DVB_DEVICE_AUDIO);
 
 	return 0;
Index: linux-2.6.12-rc4/drivers/media/dvb/ttpci/av7110.h
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/ttpci/av7110.h	2005-05-08 18:09:01.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/ttpci/av7110.h	2005-05-08 18:12:25.000000000 +0200
@@ -220,7 +220,7 @@ struct av7110 {
 
 	struct audio_mixer	mixer;
 
-	struct dvb_adapter	 *dvb_adapter;
+	struct dvb_adapter	 dvb_adapter;
 	struct dvb_device	 *video_dev;
 	struct dvb_device	 *audio_dev;
 	struct dvb_device	 *ca_dev;
Index: linux-2.6.12-rc4/drivers/media/dvb/ttpci/av7110_ca.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/ttpci/av7110_ca.c	2005-05-08 18:09:01.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/ttpci/av7110_ca.c	2005-05-08 18:12:25.000000000 +0200
@@ -370,7 +370,7 @@ static struct dvb_device dvbdev_ca = {
 
 int av7110_ca_register(struct av7110 *av7110)
 {
-	return dvb_register_device(av7110->dvb_adapter, &av7110->ca_dev,
+	return dvb_register_device(&av7110->dvb_adapter, &av7110->ca_dev,
 				   &dvbdev_ca, av7110, DVB_DEVICE_CA);
 }
 
Index: linux-2.6.12-rc4/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2005-05-08 18:09:01.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2005-05-08 18:12:25.000000000 +0200
@@ -84,7 +84,7 @@ struct ttusb {
 	struct semaphore semi2c;
 	struct semaphore semusb;
 
-	struct dvb_adapter *adapter;
+	struct dvb_adapter adapter;
 	struct usb_device *dev;
 
 	struct i2c_adapter i2c_adap;
@@ -1412,7 +1412,7 @@ static void frontend_init(struct ttusb* 
 		       le16_to_cpu(ttusb->dev->descriptor.idVendor),
 		       le16_to_cpu(ttusb->dev->descriptor.idProduct));
 	} else {
-		if (dvb_register_frontend(ttusb->adapter, ttusb->fe)) {
+		if (dvb_register_frontend(&ttusb->adapter, ttusb->fe)) {
 			printk("dvb-ttusb-budget: Frontend registration failed!\n");
 			if (ttusb->fe->ops->release)
 				ttusb->fe->ops->release(ttusb->fe);
@@ -1462,7 +1462,7 @@ static int ttusb_probe(struct usb_interf
 	up(&ttusb->semi2c);
 
 	dvb_register_adapter(&ttusb->adapter, "Technotrend/Hauppauge Nova-USB", THIS_MODULE);
-	ttusb->adapter->priv = ttusb;
+	ttusb->adapter.priv = ttusb;
 
 	/* i2c */
 	memset(&ttusb->i2c_adap, 0, sizeof(struct i2c_adapter));
@@ -1481,7 +1481,7 @@ static int ttusb_probe(struct usb_interf
 
 	result = i2c_add_adapter(&ttusb->i2c_adap);
 	if (result) {
-		dvb_unregister_adapter (ttusb->adapter);
+		dvb_unregister_adapter (&ttusb->adapter);
 		return result;
 	}
 
@@ -1503,7 +1503,7 @@ static int ttusb_probe(struct usb_interf
 	if ((result = dvb_dmx_init(&ttusb->dvb_demux)) < 0) {
 		printk("ttusb_dvb: dvb_dmx_init failed (errno = %d)\n", result);
 		i2c_del_adapter(&ttusb->i2c_adap);
-		dvb_unregister_adapter (ttusb->adapter);
+		dvb_unregister_adapter (&ttusb->adapter);
 		return -ENODEV;
 	}
 //FIXME dmxdev (nur WAS?)
@@ -1511,21 +1511,21 @@ static int ttusb_probe(struct usb_interf
 	ttusb->dmxdev.demux = &ttusb->dvb_demux.dmx;
 	ttusb->dmxdev.capabilities = 0;
 
-	if ((result = dvb_dmxdev_init(&ttusb->dmxdev, ttusb->adapter)) < 0) {
+	if ((result = dvb_dmxdev_init(&ttusb->dmxdev, &ttusb->adapter)) < 0) {
 		printk("ttusb_dvb: dvb_dmxdev_init failed (errno = %d)\n",
 		       result);
 		dvb_dmx_release(&ttusb->dvb_demux);
 		i2c_del_adapter(&ttusb->i2c_adap);
-		dvb_unregister_adapter (ttusb->adapter);
+		dvb_unregister_adapter (&ttusb->adapter);
 		return -ENODEV;
 	}
 
-	if (dvb_net_init(ttusb->adapter, &ttusb->dvbnet, &ttusb->dvb_demux.dmx)) {
+	if (dvb_net_init(&ttusb->adapter, &ttusb->dvbnet, &ttusb->dvb_demux.dmx)) {
 		printk("ttusb_dvb: dvb_net_init failed!\n");
 		dvb_dmxdev_release(&ttusb->dmxdev);
 		dvb_dmx_release(&ttusb->dvb_demux);
 		i2c_del_adapter(&ttusb->i2c_adap);
-		dvb_unregister_adapter (ttusb->adapter);
+		dvb_unregister_adapter (&ttusb->adapter);
 		return -ENODEV;
 	}
 
@@ -1559,7 +1559,7 @@ static void ttusb_disconnect(struct usb_
 	dvb_dmx_release(&ttusb->dvb_demux);
 	if (ttusb->fe != NULL) dvb_unregister_frontend(ttusb->fe);
 	i2c_del_adapter(&ttusb->i2c_adap);
-	dvb_unregister_adapter(ttusb->adapter);
+	dvb_unregister_adapter(&ttusb->adapter);
 
 	ttusb_free_iso_urbs(ttusb);
 
Index: linux-2.6.12-rc4/drivers/media/dvb/ttusb-dec/ttusb_dec.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2005-05-08 18:09:01.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2005-05-08 18:12:25.000000000 +0200
@@ -98,7 +98,7 @@ struct ttusb_dec {
 	int				can_playback;
 
 	/* DVB bits */
-	struct dvb_adapter		*adapter;
+	struct dvb_adapter		adapter;
 	struct dmxdev			dmxdev;
 	struct dvb_demux		demux;
 	struct dmx_frontend		frontend;
@@ -1435,7 +1435,7 @@ static int ttusb_dec_init_dvb(struct ttu
 		printk("%s: dvb_dmx_init failed: error %d\n", __FUNCTION__,
 		       result);
 
-		dvb_unregister_adapter(dec->adapter);
+		dvb_unregister_adapter(&dec->adapter);
 
 		return result;
 	}
@@ -1444,12 +1444,12 @@ static int ttusb_dec_init_dvb(struct ttu
 	dec->dmxdev.demux = &dec->demux.dmx;
 	dec->dmxdev.capabilities = 0;
 
-	if ((result = dvb_dmxdev_init(&dec->dmxdev, dec->adapter)) < 0) {
+	if ((result = dvb_dmxdev_init(&dec->dmxdev, &dec->adapter)) < 0) {
 		printk("%s: dvb_dmxdev_init failed: error %d\n",
 		       __FUNCTION__, result);
 
 		dvb_dmx_release(&dec->demux);
-		dvb_unregister_adapter(dec->adapter);
+		dvb_unregister_adapter(&dec->adapter);
 
 		return result;
 	}
@@ -1463,7 +1463,7 @@ static int ttusb_dec_init_dvb(struct ttu
 
 		dvb_dmxdev_release(&dec->dmxdev);
 		dvb_dmx_release(&dec->demux);
-		dvb_unregister_adapter(dec->adapter);
+		dvb_unregister_adapter(&dec->adapter);
 
 		return result;
 	}
@@ -1476,12 +1476,12 @@ static int ttusb_dec_init_dvb(struct ttu
 		dec->demux.dmx.remove_frontend(&dec->demux.dmx, &dec->frontend);
 		dvb_dmxdev_release(&dec->dmxdev);
 		dvb_dmx_release(&dec->demux);
-		dvb_unregister_adapter(dec->adapter);
+		dvb_unregister_adapter(&dec->adapter);
 
 		return result;
 	}
 
-	dvb_net_init(dec->adapter, &dec->dvb_net, &dec->demux.dmx);
+	dvb_net_init(&dec->adapter, &dec->dvb_net, &dec->demux.dmx);
 
 	return 0;
 }
@@ -1496,7 +1496,7 @@ static void ttusb_dec_exit_dvb(struct tt
 	dvb_dmxdev_release(&dec->dmxdev);
 	dvb_dmx_release(&dec->demux);
 	if (dec->fe) dvb_unregister_frontend(dec->fe);
-	dvb_unregister_adapter(dec->adapter);
+	dvb_unregister_adapter(&dec->adapter);
 }
 
 static void ttusb_dec_exit_rc(struct ttusb_dec *dec)
@@ -1620,7 +1620,7 @@ static int ttusb_dec_probe(struct usb_in
 	}
 	ttusb_dec_init_dvb(dec);
 
-	dec->adapter->priv = dec;
+	dec->adapter.priv = dec;
 	switch (le16_to_cpu(id->idProduct)) {
 	case 0x1006:
 		dec->fe = ttusbdecfe_dvbs_attach(&fe_config);
@@ -1637,7 +1637,7 @@ static int ttusb_dec_probe(struct usb_in
 		       le16_to_cpu(dec->udev->descriptor.idVendor),
 		       le16_to_cpu(dec->udev->descriptor.idProduct));
 	} else {
-		if (dvb_register_frontend(dec->adapter, dec->fe)) {
+		if (dvb_register_frontend(&dec->adapter, dec->fe)) {
 			printk("budget-ci: Frontend registration failed!\n");
 			if (dec->fe->ops->release)
 				dec->fe->ops->release(dec->fe);
Index: linux-2.6.12-rc4/drivers/media/dvb/bt8xx/dvb-bt8xx.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/bt8xx/dvb-bt8xx.c	2005-05-08 18:09:01.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/bt8xx/dvb-bt8xx.c	2005-05-08 18:12:25.000000000 +0200
@@ -531,7 +531,7 @@ static void frontend_init(struct dvb_bt8
 		       card->bt->dev->subsystem_vendor,
 		       card->bt->dev->subsystem_device);
 	} else {
-		if (dvb_register_frontend(card->dvb_adapter, card->fe)) {
+		if (dvb_register_frontend(&card->dvb_adapter, card->fe)) {
 			printk("dvb-bt8xx: Frontend registration failed!\n");
 			if (card->fe->ops->release)
 				card->fe->ops->release(card->fe);
@@ -550,7 +550,7 @@ static int __init dvb_bt8xx_load_card(st
 		return result;
 
 	}
-	card->dvb_adapter->priv = card;
+	card->dvb_adapter.priv = card;
 
 	card->bt->adapter = card->i2c_adapter;
 
@@ -568,7 +568,7 @@ static int __init dvb_bt8xx_load_card(st
 	if ((result = dvb_dmx_init(&card->demux)) < 0) {
 		printk("dvb_bt8xx: dvb_dmx_init failed (errno = %d)\n", result);
 
-		dvb_unregister_adapter(card->dvb_adapter);
+		dvb_unregister_adapter(&card->dvb_adapter);
 		return result;
 	}
 
@@ -576,11 +576,11 @@ static int __init dvb_bt8xx_load_card(st
 	card->dmxdev.demux = &card->demux.dmx;
 	card->dmxdev.capabilities = 0;
 
-	if ((result = dvb_dmxdev_init(&card->dmxdev, card->dvb_adapter)) < 0) {
+	if ((result = dvb_dmxdev_init(&card->dmxdev, &card->dvb_adapter)) < 0) {
 		printk("dvb_bt8xx: dvb_dmxdev_init failed (errno = %d)\n", result);
 
 		dvb_dmx_release(&card->demux);
-		dvb_unregister_adapter(card->dvb_adapter);
+		dvb_unregister_adapter(&card->dvb_adapter);
 		return result;
 	}
 
@@ -591,7 +591,7 @@ static int __init dvb_bt8xx_load_card(st
 
 		dvb_dmxdev_release(&card->dmxdev);
 		dvb_dmx_release(&card->demux);
-		dvb_unregister_adapter(card->dvb_adapter);
+		dvb_unregister_adapter(&card->dvb_adapter);
 		return result;
 	}
 
@@ -603,7 +603,7 @@ static int __init dvb_bt8xx_load_card(st
 		card->demux.dmx.remove_frontend(&card->demux.dmx, &card->fe_hw);
 		dvb_dmxdev_release(&card->dmxdev);
 		dvb_dmx_release(&card->demux);
-		dvb_unregister_adapter(card->dvb_adapter);
+		dvb_unregister_adapter(&card->dvb_adapter);
 		return result;
 	}
 
@@ -614,11 +614,11 @@ static int __init dvb_bt8xx_load_card(st
 		card->demux.dmx.remove_frontend(&card->demux.dmx, &card->fe_hw);
 		dvb_dmxdev_release(&card->dmxdev);
 		dvb_dmx_release(&card->demux);
-		dvb_unregister_adapter(card->dvb_adapter);
+		dvb_unregister_adapter(&card->dvb_adapter);
 		return result;
 	}
 
-	dvb_net_init(card->dvb_adapter, &card->dvbnet, &card->demux.dmx);
+	dvb_net_init(&card->dvb_adapter, &card->dvbnet, &card->demux.dmx);
 
 	tasklet_init(&card->bt->tasklet, dvb_bt8xx_task, (unsigned long) card);
 
@@ -759,7 +759,7 @@ static int dvb_bt8xx_remove(struct devic
 	dvb_dmxdev_release(&card->dmxdev);
 	dvb_dmx_release(&card->demux);
 	if (card->fe) dvb_unregister_frontend(card->fe);
-	dvb_unregister_adapter(card->dvb_adapter);
+	dvb_unregister_adapter(&card->dvb_adapter);
 
 	kfree(card);
 
Index: linux-2.6.12-rc4/drivers/media/dvb/bt8xx/dvb-bt8xx.h
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/bt8xx/dvb-bt8xx.h	2005-05-08 18:09:01.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/bt8xx/dvb-bt8xx.h	2005-05-08 18:12:25.000000000 +0200
@@ -40,7 +40,7 @@ struct dvb_bt8xx_card {
 	struct semaphore lock;
 	int nfeeds;
 	char card_name[32];
-	struct dvb_adapter *dvb_adapter;
+	struct dvb_adapter dvb_adapter;
 	struct bt878 *bt;
 	unsigned int bttv_nr;
 	struct dvb_demux demux;
Index: linux-2.6.12-rc4/drivers/media/video/video-buf-dvb.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/video/video-buf-dvb.c	2005-05-08 18:09:01.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/video/video-buf-dvb.c	2005-05-08 18:12:25.000000000 +0200
@@ -149,10 +149,10 @@ int videobuf_dvb_register(struct videobu
 		       dvb->name, result);
 		goto fail_adapter;
 	}
-	dvb->adapter->priv = adapter_priv;
+	dvb->adapter.priv = adapter_priv;
 
 	/* register frontend */
-	result = dvb_register_frontend(dvb->adapter, dvb->frontend);
+	result = dvb_register_frontend(&dvb->adapter, dvb->frontend);
 	if (result < 0) {
 		printk(KERN_WARNING "%s: dvb_register_frontend failed (errno = %d)\n",
 		       dvb->name, result);
@@ -178,7 +178,7 @@ int videobuf_dvb_register(struct videobu
 	dvb->dmxdev.filternum    = 256;
 	dvb->dmxdev.demux        = &dvb->demux.dmx;
 	dvb->dmxdev.capabilities = 0;
-	result = dvb_dmxdev_init(&dvb->dmxdev, dvb->adapter);
+	result = dvb_dmxdev_init(&dvb->dmxdev, &dvb->adapter);
 	if (result < 0) {
 		printk(KERN_WARNING "%s: dvb_dmxdev_init failed (errno = %d)\n",
 		       dvb->name, result);
@@ -209,7 +209,7 @@ int videobuf_dvb_register(struct videobu
 	}
 
 	/* register network adapter */
-	dvb_net_init(dvb->adapter, &dvb->net, &dvb->demux.dmx);
+	dvb_net_init(&dvb->adapter, &dvb->net, &dvb->demux.dmx);
 	return 0;
 
 fail_fe_conn:
@@ -223,7 +223,7 @@ fail_dmxdev:
 fail_dmx:
 	dvb_unregister_frontend(dvb->frontend);
 fail_frontend:
-	dvb_unregister_adapter(dvb->adapter);
+	dvb_unregister_adapter(&dvb->adapter);
 fail_adapter:
 	return result;
 }
@@ -236,7 +236,7 @@ void videobuf_dvb_unregister(struct vide
 	dvb_dmxdev_release(&dvb->dmxdev);
 	dvb_dmx_release(&dvb->demux);
 	dvb_unregister_frontend(dvb->frontend);
-	dvb_unregister_adapter(dvb->adapter);
+	dvb_unregister_adapter(&dvb->adapter);
 }
 
 EXPORT_SYMBOL(videobuf_dvb_register);
Index: linux-2.6.12-rc4/include/media/video-buf-dvb.h
===================================================================
--- linux-2.6.12-rc4.orig/include/media/video-buf-dvb.h	2005-05-08 18:09:01.000000000 +0200
+++ linux-2.6.12-rc4/include/media/video-buf-dvb.h	2005-05-08 18:12:25.000000000 +0200
@@ -16,7 +16,7 @@ struct videobuf_dvb {
 	int                        nfeeds;
 
 	/* videobuf_dvb_(un)register manges this */
-	struct dvb_adapter         *adapter;
+	struct dvb_adapter         adapter;
 	struct dvb_demux           demux;
 	struct dmxdev              dmxdev;
 	struct dmx_frontend        fe_hw;

--

