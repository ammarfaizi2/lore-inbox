Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262888AbTLSMig (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 07:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263402AbTLSMhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 07:37:21 -0500
Received: from mail.linuxtv.org ([212.84.236.4]:31162 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S262796AbTLSM2o convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 07:28:44 -0500
Subject: [PATCH 8/12] Add firmware loading support to av7110 driver
In-Reply-To: <10718369223835@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Fri, 19 Dec 2003 13:28:42 +0100
Message-Id: <10718369223748@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold <hunold@linuxtv.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DVB: - use new firmware_class firmware loading facilities in dvb-ttpci/av7110 driver
--- linux-2.6.0-test11-bk8/drivers/media/dvb/ttpci/av7110.c.orig	2003-12-10 10:28:31.000000000 +0100
+++ linux-2.6.0-test11-bk8/drivers/media/dvb/ttpci/av7110.c	2003-12-11 12:06:18.000000000 +0100
@@ -60,6 +60,8 @@
 #include <linux/inetdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
+#include <linux/firmware.h>
+#include <linux/crc32.h>
 
 #include <asm/system.h>
 #include <asm/bitops.h>
@@ -1971,8 +1973,6 @@ static u8 bootcode[] = {
         0x2c, 0x00, 0x03, 0xf8, 0x2c, 0x00, 0x04, 0x00,
 };
 
-#include "av7110_firm.h"
-
 static int bootarm(struct av7110 *av7110)
 {
 	struct saa7146_dev *dev= av7110->dev;
@@ -2025,7 +2025,7 @@ static int bootarm(struct av7110 *av7110
         
         DEB_D(("bootarm: load dram code\n"));
 
-	if (load_dram(av7110, (u32 *)Root, sizeof(Root))<0)
+	if (load_dram(av7110, (u32 *)av7110->bin_root, av7110->size_root)<0)
 		return -1;
 
 	saa7146_setgpio(dev, RESET_LINE, SAA7146_GPIO_OUTLO);
@@ -2033,7 +2033,7 @@ static int bootarm(struct av7110 *av7110
         
         DEB_D(("bootarm: load dpram code\n"));
 
-	mwdebi(av7110, DEBISWAB, DPRAM_BASE, Dpram, sizeof(Dpram));
+	mwdebi(av7110, DEBISWAB, DPRAM_BASE, av7110->bin_dpram, av7110->size_dpram);
 
 	wait_for_debi_done(av7110);
 
@@ -4502,22 +4502,91 @@ static struct saa7146_ext_vv av7110_vv_d
 
 static int av7110_attach (struct saa7146_dev* dev, struct saa7146_pci_extension_data *pci_ext)
 {
+	const struct firmware *fw;
 	struct av7110 *av7110 = NULL;
 	int ret = 0;
-	
+	u32 crc = 0, len = 0;
+	unsigned char *ptr;
+		
+	DEB_EE(("dev: %p, av7110: %p\n",dev,av7110));
+
+	/* request the av7110 firmware, this will block until someone uploads it */
+	ret = request_firmware(&fw, "dvb-ttpci-01.fw", &dev->pci->dev);
+	if ( 0 != ret ) {
+		printk("dvb-ttpci: cannot request firmware!\n");
+		return -EINVAL;
+	}
+
+	if (fw->size <= 200000) {
+		printk("dvb-ttpci: this firmware is way too small.\n");
+		return -EINVAL;
+	}
+
+	/* prepare the av7110 device struct */
 	if (!(av7110 = kmalloc (sizeof (struct av7110), GFP_KERNEL))) {
 		printk ("%s: out of memory!\n", __FUNCTION__);
 		return -ENOMEM;
 	}
-
 	memset(av7110, 0, sizeof(struct av7110));
+	
+	/* check if the firmware is available */
+	av7110->bin_fw = (unsigned char*)vmalloc(fw->size);
+	if (NULL == av7110->bin_fw) {
+		DEB_D(("out of memory\n"));
+		kfree(av7110);
+		return -ENOMEM;
+	}
+	memcpy(av7110->bin_fw, fw->data, fw->size);
+	av7110->size_fw = fw->size;
 
+	/* check for firmware magic */
+	ptr = av7110->bin_fw;
+	if (ptr[0] != 'A' || ptr[1] != 'V' || 
+	    ptr[2] != 'F' || ptr[3] != 'W') {
+		printk("dvb-ttpci: this is not an av7110 firmware\n");
+		goto fw_error;
+	}
+	ptr += 4;
+
+	/* check dpram file */
+	crc = ntohl(*(u32*)ptr);
+	ptr += 4;
+	len = ntohl(*(u32*)ptr);
+	ptr += 4;
+	if (len >= 512) {
+		printk("dvb-ttpci: dpram file is way to big.\n");
+		goto fw_error;
+	}
+	if( crc != crc32_le(0,ptr,len)) {
+		printk("dvb-ttpci: crc32 of dpram file does not match.\n");
+		goto fw_error;
+	}
+	av7110->bin_dpram = ptr;
+	av7110->size_dpram = len;
+	ptr += len;
+	
+	/* check root file */
+	crc = ntohl(*(u32*)ptr);
+	ptr += 4;
+	len = ntohl(*(u32*)ptr);
+	ptr += 4;
+	
+	if (len <= 200000 || len >= 300000 || len > ((av7110->bin_fw+av7110->size_fw)-ptr) ) {
+		printk("dvb-ttpci: root file has strange size (%d). aborting.\n",len);
+		goto fw_error;
+	}
+	if( crc != crc32_le(0,ptr,len)) {
+		printk("dvb-ttpci: crc32 of dpram file does not match.\n");
+		goto fw_error;
+	}
+	av7110->bin_root = ptr;
+	av7110->size_root = len;
+	
+	/* go on with regular device initialization */
 	av7110->card_name = (char*)pci_ext->ext_priv;
+	av7110->dev=(struct saa7146_dev *)dev;
 	(struct av7110*)dev->ext_priv = av7110;
 
-	DEB_EE(("dev: %p, av7110: %p\n",dev,av7110));
-
-	av7110->dev=(struct saa7146_dev *)dev;
 	dvb_register_adapter(&av7110->dvb_adapter, av7110->card_name);
 
 	/* the Siemens DVB needs this if you want to have the i2c chips
@@ -4758,6 +4827,7 @@ static int av7110_attach (struct saa7146
 	}	
 
 	printk(KERN_INFO "av7110: found av7110-%d.\n",av7110_num);
+	av7110->device_initialized = 1;
 	av7110_num++;
         return 0;
 
@@ -4781,12 +4851,20 @@ err:
 	dvb_unregister_adapter (av7110->dvb_adapter);
 
 	return ret;
+fw_error:
+	vfree(av7110->bin_fw);
+	kfree(av7110);
+	return -EINVAL;
 }
 
 static int av7110_detach (struct saa7146_dev* saa)
 {
 	struct av7110 *av7110 = (struct av7110*)saa->ext_priv;
 	DEB_EE(("av7110: %p\n",av7110));
+	
+	if( 0 == av7110->device_initialized ) {
+		return 0;
+	}
 
 	saa7146_unregister_device(&av7110->v4l_dev, saa);
 	if (2 == av7110->has_analog_tuner) {
@@ -4817,11 +4895,13 @@ static int av7110_detach (struct saa7146
 	dvb_unregister_i2c_bus (master_xfer,av7110->i2c_bus->adapter, av7110->i2c_bus->id);
 	dvb_unregister_adapter (av7110->dvb_adapter);
 
+	av7110_num--;
+	if (NULL != av7110->bin_fw ) {
+		vfree(av7110->bin_fw);
+	}
 	kfree (av7110);
-
 	saa->ext_priv = NULL;
-	av7110_num--;
-	
+
 	return 0;
 }
 
--- linux-2.6.0-test11-bk8/drivers/media/dvb/ttpci/av7110.h.orig	2003-10-15 13:18:08.000000000 +0200
+++ linux-2.6.0-test11-bk8/drivers/media/dvb/ttpci/av7110.h	2003-12-11 12:05:05.000000000 +0100
@@ -1,8 +1,6 @@
 #ifndef _AV7110_H_
 #define _AV7110_H_
 
-#define DVB_FIRM_PATH "/lib/DVB/"
-
 #include <linux/interrupt.h>
 #include <linux/socket.h>
 #include <linux/netdevice.h>
@@ -545,6 +543,18 @@ struct av7110 {
         int                 dsp_dev;
 
         u32                 ir_config;
+	
+	/* firmware stuff */
+	unsigned int device_initialized;
+
+	unsigned char *bin_fw;
+	unsigned long size_fw;
+
+	unsigned char *bin_dpram;
+	unsigned long size_dpram;
+
+	unsigned char *bin_root;
+	unsigned long size_root;
 };
 
 

