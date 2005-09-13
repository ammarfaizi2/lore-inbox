Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932502AbVIMUy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502AbVIMUy7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 16:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932518AbVIMUy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 16:54:58 -0400
Received: from mx02.qsc.de ([213.148.130.14]:46820 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S932502AbVIMUy5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 16:54:57 -0400
From: =?utf-8?q?Ren=C3=A9_Rebe?= <rene@exactcode.de>
Organization: ExactCode
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Adaptec USBXchange and USB2Xchange support
Date: Tue, 13 Sep 2005 22:53:50 +0200
User-Agent: KMail/1.8.2
Cc: "Beier & Dauskardt IT" <sda@bdit.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3873805.bopC0PBA7F";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200509132253.53960.rene@exactcode.de>
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3873805.bopC0PBA7F
Content-Type: multipart/mixed;
  boundary="Boundary-01=_exzJD6Db0jaU9EX"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_exzJD6Db0jaU9EX
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,

attached is a patch adding support for Adaptec's USBXchange and USB2Xchange=
=20
USB to SCSI converter dongles.

In 2004 Beier & Dauskardt IT <sda@bdit.de> already posted a patch, that was=
=20
not accepted because it was for 2.4 and included the firmware.

This patch is based on that work, but ported to 2.6 as well as to the new=20
firmware loader. Support for the USBXchange was added as well as cleanups=20
done.

Compatible firmware dumps, obtained by USB I/O logging, are available here:

  http://dl.exactcode.de/adaptec-usbxchange/

Alternatively people can dump it out from the windows driver looking for th=
e=20
offset.

After the firmware upload the devices behave as normal usb-storage devices.

This version was only tested with the USB 1.x version - but I get a=20
USB2Xchange, hopefully tomorrow.

Signed-off-by: Ren=C3=A9 Rebe <rene@exactcode.de>

Please apply - suggestions welcome,

=2D-=20
Ren=C3=A9 Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
            http://www.exactcode.de | http://www.t2-project.org
            +49 (0)30  255 897 45

--Boundary-01=_exzJD6Db0jaU9EX
Content-Type: text/x-diff;
  charset="utf-8";
  name="usbxchange-v4.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="usbxchange-v4.patch"

diff -urN --exclude '*.ko' --exclude '*mod*' --exclude '*cmd' --exclude '*.=
o' --exclude '*.rej' --exclude '*~' linux-2.6.13/drivers/usb/storage/Kconfi=
g linux-2.6.13-usbxchg/drivers/usb/storage/Kconfig
=2D-- linux-2.6.13/drivers/usb/storage/Kconfig	2005-08-29 01:41:01.00000000=
0 +0200
+++ linux-2.6.13-usbxchg/drivers/usb/storage/Kconfig	2005-09-13 20:47:16.00=
0000000 +0200
@@ -111,3 +111,17 @@
 	  Say Y here to include additional code to support the Lexar Jumpshot
 	  USB CompactFlash reader.
=20
+config USB_STORAGE_USBXCHANGE
+	bool "Adaptec USBXchange and USB2Xchange support"
+	depends on USB_STORAGE
+	help
+	  Say Y here to include additional code to support the Adaptec
+	  USBXchange and USB2Xchange USB --> SCSI converter dongle.
+
+config USB_USBXCHANGE
+	tristate "Adaptec USBXchange and USB2Xchange firmware loader"
+	depends on USB_STORAGE_USBXCHANGE
+	help
+	  Say Y here to include additional code to load the firmware into
+	  Adaptec USBXchange and USB2Xchange USB --> SCSI converter dongle.
+
diff -urN --exclude '*.ko' --exclude '*mod*' --exclude '*cmd' --exclude '*.=
o' --exclude '*.rej' --exclude '*~' linux-2.6.13/drivers/usb/storage/Makefi=
le linux-2.6.13-usbxchg/drivers/usb/storage/Makefile
=2D-- linux-2.6.13/drivers/usb/storage/Makefile	2005-08-29 01:41:01.0000000=
00 +0200
+++ linux-2.6.13-usbxchg/drivers/usb/storage/Makefile	2005-09-13 20:41:19.0=
00000000 +0200
@@ -19,5 +19,10 @@
 usb-storage-obj-$(CONFIG_USB_STORAGE_DATAFAB)	+=3D datafab.o
 usb-storage-obj-$(CONFIG_USB_STORAGE_JUMPSHOT)	+=3D jumpshot.o
=20
+usb-storage-obj-$(CONFIG_USB_STORAGE_USBXCHANGE)	+=3D usbxchange.o
+
 usb-storage-objs :=3D	scsiglue.o protocol.o transport.o usb.o \
 			initializers.o $(usb-storage-obj-y)
+
+obj-$(CONFIG_USB_USBXCHANGE)			+=3D usbxchange_fw.o
+
diff -urN --exclude '*.ko' --exclude '*mod*' --exclude '*cmd' --exclude '*.=
o' --exclude '*.rej' --exclude '*~' linux-2.6.13/drivers/usb/storage/unusua=
l_devs.h linux-2.6.13-usbxchg/drivers/usb/storage/unusual_devs.h
=2D-- linux-2.6.13/drivers/usb/storage/unusual_devs.h	2005-08-29 01:41:01.0=
00000000 +0200
+++ linux-2.6.13-usbxchg/drivers/usb/storage/unusual_devs.h	2005-09-13 22:3=
4:30.000000000 +0200
@@ -1039,3 +1039,22 @@
 		US_SC_SCSI, US_PR_SDDR55, NULL,
 		US_FL_SINGLE_LUN),
 #endif
+
+#ifdef CONFIG_USB_STORAGE_USBXCHANGE
+
+/* Adaptec USBXchange and USB2Xchange, after firmware download.
+ * Requires Ez-USB Style firmware loader.  -Ren=E9 Rebe <rene@exactcode.de=
> */
+
+UNUSUAL_DEV(  0x03f3, 0x2001, 0x0000, 0xffff,
+		"Adaptec",
+		"USBXchange",
+		US_SC_SCSI, US_PR_BULK, NULL,
+		0 ),
+
+UNUSUAL_DEV(  0x03f3, 0x2003, 0x0000, 0xffff,
+		"Adaptec",
+		"USB2Xchange",
+		US_SC_SCSI, US_PR_BULK, usb2xchange_init,
+		0 ),
+#endif
+
diff -urN --exclude '*.ko' --exclude '*mod*' --exclude '*cmd' --exclude '*.=
o' --exclude '*.rej' --exclude '*~' linux-2.6.13/drivers/usb/storage/usb.c =
linux-2.6.13-usbxchg/drivers/usb/storage/usb.c
=2D-- linux-2.6.13/drivers/usb/storage/usb.c	2005-08-29 01:41:01.000000000 =
+0200
+++ linux-2.6.13-usbxchg/drivers/usb/storage/usb.c	2005-09-13 21:23:03.0000=
00000 +0200
@@ -90,6 +90,9 @@
 #ifdef CONFIG_USB_STORAGE_JUMPSHOT
 #include "jumpshot.h"
 #endif
+#ifdef CONFIG_USB_STORAGE_USBXCHANGE
+#include "usbxchange.h"
+#endif
=20
=20
 /* Some informational data */
diff -urN --exclude '*.ko' --exclude '*mod*' --exclude '*cmd' --exclude '*.=
o' --exclude '*.rej' --exclude '*~' linux-2.6.13/drivers/usb/storage/usbxch=
ange.c linux-2.6.13-usbxchg/drivers/usb/storage/usbxchange.c
=2D-- linux-2.6.13/drivers/usb/storage/usbxchange.c	1970-01-01 01:00:00.000=
000000 +0100
+++ linux-2.6.13-usbxchg/drivers/usb/storage/usbxchange.c	2005-09-13 22:33:=
00.000000000 +0200
@@ -0,0 +1,60 @@
+/*=20
+ * Firmware Initialisation for the Adaptec USB2Xchange.
+ *
+ * Current development and maintenance by:
+ *   (c) 2005 Ren=E9 Rebe <rene@exactcode.de>
+ *
+ * Initial work by:
+ *   (c) 2004 Beier & Dauskardt IT <sda@bdit.de>
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, as published by
+ * the Free Software Foundation, version 2.
+ */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/usb.h>
+#include "usb.h"
+
+#include "usbxchange.h"
+
+int usb2xchange_init(struct us_data *us)
+{
+	int result;
+	struct usb_device *dev =3D us->pusb_dev;
+
+	/* This two-command 'reset' sequence is needed, otherwise
+	 * the UISB2Xchange won't recognise devices properly.
+	 */
+	printk(KERN_INFO
+	       "usb2xchange_init: initialising after reenumeration.\n");
+
+	result =3D usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
+				 0x5a, 0x40, 0x01,
+				 0, 0,	// buffer,
+				 0,	// length,
+				 300);
+
+	if (result < 0)
+		printk(KERN_ERR "usb2xchange_init: reset #1 (%d)\n", result);
+
+	result =3D usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
+				 0x5a, 0x40, 0x02,
+				 0, 0,	// buffer,
+				 0,	// length,
+				 300);
+
+	if (result < 0)
+		printk(KERN_ERR "usb2xchange_init: reset #2 (%d)\n", result);
+
+	return 1;
+}
diff -urN --exclude '*.ko' --exclude '*mod*' --exclude '*cmd' --exclude '*.=
o' --exclude '*.rej' --exclude '*~' linux-2.6.13/drivers/usb/storage/usbxch=
ange.h linux-2.6.13-usbxchg/drivers/usb/storage/usbxchange.h
=2D-- linux-2.6.13/drivers/usb/storage/usbxchange.h	1970-01-01 01:00:00.000=
000000 +0100
+++ linux-2.6.13-usbxchg/drivers/usb/storage/usbxchange.h	2005-09-13 22:33:=
00.000000000 +0200
@@ -0,0 +1,25 @@
+/*=20
+ * Firmware Initialisation for the Adaptec USB2Xchange.
+ *
+ * Current development and maintenance by:
+ *   (c) 2005 Ren=E9 Rebe <rene@exactcode.de>
+ *
+ * Initial work by:
+ *   (c) 2004 Beier & Dauskardt IT <sda@bdit.de>
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, as published by
+ * the Free Software Foundation, version 2.
+ */
+
+#ifndef _USB_USBXCHANGE_H_INCLUDED
+#define _USB_USBXCHANGE_H_INCLUDED
+
+extern int usb2xchange_init(struct us_data *us);
+
+#endif
diff -urN --exclude '*.ko' --exclude '*mod*' --exclude '*cmd' --exclude '*.=
o' --exclude '*.rej' --exclude '*~' linux-2.6.13/drivers/usb/storage/usbxch=
ange_fw.c linux-2.6.13-usbxchg/drivers/usb/storage/usbxchange_fw.c
=2D-- linux-2.6.13/drivers/usb/storage/usbxchange_fw.c	1970-01-01 01:00:00.=
000000000 +0100
+++ linux-2.6.13-usbxchg/drivers/usb/storage/usbxchange_fw.c	2005-09-13 22:=
33:30.000000000 +0200
@@ -0,0 +1,233 @@
+/*
+ * Firmware loader for Adaptec USB2Xchange.
+ *
+ * Downloads device firmware to the Adaptec USBXchange and USB2Xchange
+ * USB --> SCSI Converter dongle.
+ *
+ * Current development and maintenance by:
+ *   (c) 2005 Ren=E9 Rebe <rene@exactcode.de>
+ *
+ * Initial work by:
+ *   (c) 2004 Beier & Dauskardt IT <sda@bdit.de>
+ *
+ * Based on emi26.c:
+ *   (c) 2002 Tapio Laxstr=F6m <tapio.laxstrom@iptime.fi>
+ *
+ * To use this driver, you need to get the devices firmware from some
+ * windows driver:
+ *   usbxchg_win_v120.exe - for USBXchange
+ *
+ *   usb2xchg_win_drv_v200.exe - for USB2Xchange
+ *
+ * Hotplug firmware loader compatible files can be found at:
+ *   http://dl.exactcode.de/adaptec-usbxchange/
+ *
+ * Note:
+ * The USB2Xchange seems to have some internal Buffer < 64K.=20
+ * Sending 64K requests crashes the device. Possibly it needs a
+ * "max_sectors: 8" setting.
+ *
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, as published by
+ * the Free Software Foundation, version 2.
+ */
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/usb.h>
+
+#include <linux/firmware.h>
+
+#include "usbxchange_fw.h"
+
+static int usbxchange_writememory(struct usb_device *dev, int address,
+				  unsigned char *data, int length,
+				  __u8 bRequest);
+static int usbxchange_set_reset(struct usb_device *dev, int cpureg,
+				unsigned char reset_bit);
+static int usbxchange_load_firmware(struct usb_device *dev);
+
+static int usbxchange_probe(struct usb_interface *iface,
+			    const struct usb_device_id *id);
+static void usbxchange_disconnect(struct usb_interface *iface);
+static int __init usbxchange_init(void);
+static void __exit usbxchange_exit(void);
+
+#define usbxchange_VENDOR_ID 0x03f3
+#define usbxchange_PRODUCT_ID 0x2000
+#define usb2xchange_PRODUCT_ID 0x2002
+
+static struct usb_device_id usbxchange_usb_ids[] =3D {
+	{USB_DEVICE(usbxchange_VENDOR_ID, usbxchange_PRODUCT_ID)},
+	{USB_DEVICE(usbxchange_VENDOR_ID, usb2xchange_PRODUCT_ID)},
+	{}			/* terminating entry */
+};
+
+MODULE_DEVICE_TABLE(usb, usbxchange_usb_ids);
+
+/* thanks to drivers/usb/serial/keyspan_pda.c code */
+static int usbxchange_writememory(struct usb_device *dev, int address,
+				  unsigned char *data, int length, __u8 request)
+{
+	int result;
+	unsigned char *buffer =3D kmalloc(length, GFP_KERNEL);
+
+	if (!buffer) {
+		printk(KERN_ERR "usbxchange: kmalloc(%d) failed.\n", length);
+		return -ENOMEM;
+	}
+	memcpy(buffer, data, length);
+	/* Note: usb_control_msg returns negative value on error or length of the
+	 *               data that was written! */
+
+	/*printk("writing to %X, length %d\n", address, length);*/
+
+	result =3D usb_control_msg(dev, usb_sndctrlpipe(dev, 0), request, 0x40,
+				 address, 0, buffer, length, 300);
+	kfree(buffer);
+	return result;
+}
+
+/* thanks to drivers/usb/serial/keyspan_pda.c code */
+static int usbxchange_set_reset(struct usb_device *dev, int cpureg,
+				unsigned char reset_bit)
+{
+	int response;
+	printk(KERN_INFO "%s - %d\n", __FUNCTION__, reset_bit);
+	response =3D
+	    usbxchange_writememory(dev, cpureg, &reset_bit, 1,
+				   ANCHOR_LOAD_INTERNAL);
+	if (response < 0) {
+		printk(KERN_ERR "usbxchange: set_reset (%d) failed\n",
+		       reset_bit);
+	}
+	return response;
+}
+
+static int usbxchange_load_firmware(struct usb_device *dev)
+{
+	INTEL_HEX_RECORD *record;
+	int err, cpureg;
+
+	const struct firmware *firmware;
+
+	switch (le16_to_cpu(dev->descriptor.idProduct)) {
+	case usbxchange_PRODUCT_ID:
+		err =3D request_firmware(&firmware, "usbxchange.fw", &dev->dev);
+		cpureg =3D CPUCS_REG;
+		break;
+	case usb2xchange_PRODUCT_ID:
+		err =3D request_firmware(&firmware, "usb2xchange.fw", &dev->dev);
+		cpureg =3D CPUCS_REG_FX2;
+		break;
+	default:
+		printk(KERN_ERR "%s - device not recognized %x\n", __FUNCTION__,
+		       le16_to_cpu(dev->descriptor.idProduct));
+		return 1;
+	}
+
+	if (err !=3D 0) {
+		printk(KERN_ERR "Hotplug firmware request failed.\n");
+		return err;
+	}
+
+	/*printk(KERN_INFO "cpu register %X\n", cpureg);*/
+
+	/* Stop CPU
+	 */
+	err =3D usbxchange_set_reset(dev, cpureg, 1);
+	err =3D usbxchange_set_reset(dev, cpureg, 1);
+	if (err < 0) {
+		printk(KERN_ERR "%s - error loading firmware: error =3D %d\n",
+		       __FUNCTION__, err);
+		return err;
+	}
+
+	/* download Code.
+	 */
+
+	/*printk("Firmware size: %ld\n", firmware->size);*/
+	record =3D (INTEL_HEX_RECORD *) firmware->data;
+
+	for (; record->type =3D=3D 0; record++) {
+
+		err =3D
+		    usbxchange_writememory(dev, le32_to_cpu(record->address),
+					   record->data,
+					   le32_to_cpu(record->length),
+					   ANCHOR_LOAD_INTERNAL);
+		if (err < 0) {
+			printk(KERN_ERR
+			       "%s - error loading firmware: error =3D %d\n",
+			       __FUNCTION__, err);
+			return err;
+		}
+	}
+
+	/* De-assert reset (let the CPU run) */
+	err =3D usbxchange_set_reset(dev, cpureg, 1);
+	err =3D usbxchange_set_reset(dev, cpureg, 0);
+	if (err < 0) {
+		printk(KERN_ERR "%s - error loading firmware: error =3D %d\n",
+		       __FUNCTION__, err);
+		return err;
+	}
+
+	/* return 1 to fail the driver inialization
+	 * and give real driver change to load */
+	return 1;
+}
+
+static int usbxchange_probe(struct usb_interface *iface,
+			    const struct usb_device_id *id)
+{
+	struct usb_device *dev =3D interface_to_usbdev(iface);
+
+	printk(KERN_INFO "%s start\n", __FUNCTION__);
+
+	usbxchange_load_firmware(dev);
+
+	/* do not return the driver context, let real driver do that */
+	return 0;
+}
+
+static void usbxchange_disconnect(struct usb_interface *iface)
+{
+}
+
+static struct usb_driver usbxchange_driver =3D {
+	.owner =3D THIS_MODULE,
+	.name =3D "usbxchange_fw",
+	.probe =3D usbxchange_probe,
+	.disconnect =3D usbxchange_disconnect,
+	.id_table =3D usbxchange_usb_ids,
+};
+
+static int __init usbxchange_init(void)
+{
+	usb_register(&usbxchange_driver);
+	return 0;
+}
+
+static void __exit usbxchange_exit(void)
+{
+	usb_deregister(&usbxchange_driver);
+}
+
+module_init(usbxchange_init);
+module_exit(usbxchange_exit);
+
+MODULE_AUTHOR("Ren=E9 Rebe <rene@exactcode.de>, Sancho Dauskardt <sda@bdit=
=2Ede>");
+MODULE_DESCRIPTION("Adaptec USBXchange firmware loader.");
+MODULE_LICENSE("GPL");
+
+/* vi:ai:syntax=3Dc:sw=3D8:ts=3D8:tw=3D80
+ */
diff -urN --exclude '*.ko' --exclude '*mod*' --exclude '*cmd' --exclude '*.=
o' --exclude '*.rej' --exclude '*~' linux-2.6.13/drivers/usb/storage/usbxch=
ange_fw.h linux-2.6.13-usbxchg/drivers/usb/storage/usbxchange_fw.h
=2D-- linux-2.6.13/drivers/usb/storage/usbxchange_fw.h	1970-01-01 01:00:00.=
000000000 +0100
+++ linux-2.6.13-usbxchg/drivers/usb/storage/usbxchange_fw.h	2005-09-13 22:=
34:00.000000000 +0200
@@ -0,0 +1,60 @@
+/*=20
+ * Firmware loader for Adaptec USB2Xchange.
+ *
+ * Downloads device firmware to the Adaptec USBXchange and USB2Xchange
+ * USB --> SCSI Converter dongle.
+ *
+ * Current development and maintenance by:
+ *   (c) 2005 Ren=E9 Rebe <rene@exactcode.de>
+ *
+ * Initial work by:
+ *   (c) 2004 Beier & Dauskardt IT <sda@bdit.de>
+ *
+ * Based on emi26.c:
+ *   (c) 2002 Tapio Laxstr=F6m <tapio.laxstrom@iptime.fi>
+ *
+ * To use this driver, you need to get the devices firmware from some
+ * windows driver:
+ *   usbxchg_win_v120.exe - for USBXchange
+ *
+ *   usb2xchg_win_drv_v200.exe - for USB2Xchange
+ *
+ * Hotplug firmware loader compatible files can be found at:
+ *   http://dl.exactcode.de/adaptec-usbxchange/
+ *
+ * Note:
+ * The USB2Xchange seems to have some internal Buffer < 64K.=20
+ * Sending 64K requests crashes the device. Possibly it needs a
+ * "max_sectors: 8" setting.
+ *
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, as published by
+ * the Free Software Foundation, version 2.
+ */
+
+#ifndef _USB_USBXCHANGE_FW_H_INCLUDED
+#define _USB_USBXCHANGE_FW_H_INCLUDED
+
+#define MAX_INTEL_HEX_RECORD_LENGTH 16
+typedef struct _INTEL_HEX_RECORD {
+	__u32 length;
+	__u32 address;
+	__u32 type;
+	__u8 data[MAX_INTEL_HEX_RECORD_LENGTH];
+} INTEL_HEX_RECORD, *PINTEL_HEX_RECORD;
+
+/* Vendor specific request code for Anchor Upload/Download
+   (This one is implemented in the core). */
+#define ANCHOR_LOAD_INTERNAL	0xA0
+
+/* EZ-USB Control and Status Register. Bit 0 controls 8051 reset */
+#define CPUCS_REG		0x7F92	/* original / FX */
+#define CPUCS_REG_FX2		0xE600	/* FX2 */
+
+#endif

--Boundary-01=_exzJD6Db0jaU9EX--

--nextPart3873805.bopC0PBA7F
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDJzxhQuICExGFvYIRAtmxAJ0W0DqBTTJ70kghNE2tEf/5b3WFVACeKqSn
GKkQ+zefVzmGKtf6wRbEp0Y=
=TNrp
-----END PGP SIGNATURE-----

--nextPart3873805.bopC0PBA7F--
