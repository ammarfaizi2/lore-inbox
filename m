Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbWJCToP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbWJCToP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 15:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbWJCToP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 15:44:15 -0400
Received: from smtp4-g19.free.fr ([212.27.42.30]:58270 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750893AbWJCToO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 15:44:14 -0400
Message-ID: <4522BD8B.5070101@free.fr>
Date: Tue, 03 Oct 2006 21:44:11 +0200
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060809 Debian/1.7.13-0.3
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: greg@kroah.com
CC: linux-kernel@vger.kernel.org, usbatm@lists.infradead.org,
       linux-usb-devel@lists.sourceforge.net, ueagle <ueagleatm-dev@gna.org>
Subject: [PATCH 1/3] UEAGLE : comestic 
Content-Type: multipart/mixed;
 boundary="------------010808040602090101090703"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010808040602090101090703
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

this patch do some ommestic changes :
- dump firwmare version as soon as possible and export it on sysfs
- hint about wrong cmv/dsp
- Display a message to warn user when the modem is ready : it can help 
people to detect problems on the line without debug trace
- Fix wrong indent
- display modem type (pots/isdn)
- increase version number


Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>



--------------010808040602090101090703
Content-Type: text/plain;
 name="eagle-comestic"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="eagle-comestic"

Commestic change :
- dump firwmare version as soon as possible and export it on sysfs
- hint about wrong cmv/dsp
- Display a message to warn user when the modem is ready : it can help people to
 detect problems on the line without debug trace
- Fix wrong indent
- display modem type (pots/isdn)
- increase version number

Signed-off-by: matthieu castet <castet.matthieu@free.fr>
Index: linux/drivers/usb/atm/ueagle-atm.c
===================================================================
--- linux.orig/drivers/usb/atm/ueagle-atm.c	2006-09-22 22:03:49.000000000 +0200
+++ linux/drivers/usb/atm/ueagle-atm.c	2006-09-26 19:52:54.000000000 +0200
@@ -68,7 +68,7 @@
 
 #include "usbatm.h"
 
-#define EAGLEUSBVERSION "ueagle 1.3"
+#define EAGLEUSBVERSION "ueagle 1.4"
 
 
 /*
@@ -80,14 +80,14 @@
 			dev_dbg(&(usb_dev)->dev, \
 				"[ueagle-atm dbg] %s: " format, \
 					__FUNCTION__, ##args); \
-       } while (0)
+	} while (0)
 
 #define uea_vdbg(usb_dev, format, args...)	\
 	do { \
 		if (debug >= 2) \
 			dev_dbg(&(usb_dev)->dev, \
 				"[ueagle-atm vdbg]  " format, ##args); \
-       } while (0)
+	} while (0)
 
 #define uea_enters(usb_dev) \
 	uea_vdbg(usb_dev, "entering %s\n", __FUNCTION__)
@@ -218,8 +218,8 @@
 #define UEA_CHIP_VERSION(x) \
 	((x)->driver_info & 0xf)
 
-#define IS_ISDN(sc) \
-	(le16_to_cpu(sc->usb_dev->descriptor.bcdDevice) & 0x80)
+#define IS_ISDN(usb_dev) \
+	(le16_to_cpu((usb_dev)->descriptor.bcdDevice) & 0x80)
 
 #define INS_TO_USBDEV(ins) ins->usb_dev
 
@@ -625,12 +625,12 @@
 	char *dsp_name;
 
 	if (UEA_CHIP_VERSION(sc) == ADI930) {
-		if (IS_ISDN(sc))
+		if (IS_ISDN(sc->usb_dev))
 			dsp_name = FW_DIR "DSP9i.bin";
 		else
 			dsp_name = FW_DIR "DSP9p.bin";
 	} else {
-		if (IS_ISDN(sc))
+		if (IS_ISDN(sc->usb_dev))
 			dsp_name = FW_DIR "DSPei.bin";
 		else
 			dsp_name = FW_DIR "DSPep.bin";
@@ -885,7 +885,8 @@
 		break;
 
 	case 3:		/* fail ... */
-		uea_info(INS_TO_USBDEV(sc), "modem synchronization failed\n");
+		uea_info(INS_TO_USBDEV(sc), "modem synchronization failed"
+				" (may be try other cmv/dsp)\n");
 		return -EAGAIN;
 
 	case 4 ... 6:	/* test state */
@@ -913,12 +914,6 @@
 			release_firmware(sc->dsp_firm);
 			sc->dsp_firm = NULL;
 		}
-
-		ret = uea_read_cmv(sc, SA_INFO, 10, &sc->stats.phy.firmid);
-		if (ret < 0)
-			return ret;
-		uea_info(INS_TO_USBDEV(sc), "ATU-R firmware version : %x\n",
-				sc->stats.phy.firmid);
 	}
 
 	/* always update it as atm layer could not be init when we switch to
@@ -1033,9 +1028,9 @@
 
 	if (cmv_file[sc->modem_index] == NULL) {
 		if (UEA_CHIP_VERSION(sc) == ADI930)
-			file = (IS_ISDN(sc)) ? "CMV9i.bin" : "CMV9p.bin";
+			file = (IS_ISDN(sc->usb_dev)) ? "CMV9i.bin" : "CMV9p.bin";
 		else
-			file = (IS_ISDN(sc)) ? "CMVei.bin" : "CMVep.bin";
+			file = (IS_ISDN(sc->usb_dev)) ? "CMVei.bin" : "CMVep.bin";
 	} else
 		file = cmv_file[sc->modem_index];
 
@@ -1131,6 +1126,13 @@
 	if (ret < 0)
 		return ret;
 
+	/* Dump firmware version */
+	ret = uea_read_cmv(sc, SA_INFO, 10, &sc->stats.phy.firmid);
+	if (ret < 0)
+		return ret;
+	uea_info(INS_TO_USBDEV(sc), "ATU-R firmware version : %x\n",
+			sc->stats.phy.firmid);
+
 	/* get options */
  	ret = len = request_cmvs(sc, &cmvs, &cmvs_fw);
 	if (ret < 0)
@@ -1147,6 +1149,8 @@
 	/* Enter in R-ACT-REQ */
 	ret = uea_write_cmv(sc, SA_CNTL, 0, 2);
 	uea_vdbg(INS_TO_USBDEV(sc), "Entering in R-ACT-REQ state\n");
+	uea_info(INS_TO_USBDEV(sc), "Modem started, "
+		"waiting synchronization\n");
 out:
 	release_firmware(cmvs_fw);
 	sc->reset = 0;
@@ -1566,6 +1570,7 @@
 UEA_ATTR(dscorr, 0);
 UEA_ATTR(usunc, 0);
 UEA_ATTR(dsunc, 0);
+UEA_ATTR(firmid, 0);
 
 /* Retrieve the device End System Identifier (MAC) */
 
@@ -1641,6 +1646,7 @@
 	device_create_file(&intf->dev, &dev_attr_stat_dscorr);
 	device_create_file(&intf->dev, &dev_attr_stat_usunc);
 	device_create_file(&intf->dev, &dev_attr_stat_dsunc);
+	device_create_file(&intf->dev, &dev_attr_stat_firmid);
 }
 
 static int uea_bind(struct usbatm_data *usbatm, struct usb_interface *intf,
@@ -1732,6 +1738,7 @@
 	device_remove_file(&intf->dev, &dev_attr_stat_dscorr);
 	device_remove_file(&intf->dev, &dev_attr_stat_usunc);
 	device_remove_file(&intf->dev, &dev_attr_stat_dsunc);
+	device_remove_file(&intf->dev, &dev_attr_stat_firmid);
 }
 
 static void uea_unbind(struct usbatm_data *usbatm, struct usb_interface *intf)
@@ -1759,10 +1766,10 @@
 	struct usb_device *usb = interface_to_usbdev(intf);
 
 	uea_enters(usb);
-	uea_info(usb, "ADSL device founded vid (%#X) pid (%#X) : %s\n",
+	uea_info(usb, "ADSL device founded vid (%#X) pid (%#X) : %s %s\n",
 	       le16_to_cpu(usb->descriptor.idVendor),
 	       le16_to_cpu(usb->descriptor.idProduct),
-	       chip_name[UEA_CHIP_VERSION(id)]);
+	       chip_name[UEA_CHIP_VERSION(id)], IS_ISDN(usb)?"isdn":"pots");
 
 	usb_reset_device(usb);
 

--------------010808040602090101090703--
