Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262100AbVDEUaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbVDEUaR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 16:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262103AbVDEUaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 16:30:15 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:38825 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S261983AbVDEUGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 16:06:12 -0400
Message-Id: <20050405194446.176074000@delft.aura.cs.cmu.edu>
References: <20050405193859.506836000@delft.aura.cs.cmu.edu>
Date: Tue, 05 Apr 2005 15:39:01 -0400
From: Jan Harkes <jaharkes@cs.cmu.edu>
To: Greg KH <greg@kroah.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: jaharkes@cs.cmu.edu, Dmitry Torokhov <dtor_core@ameritech.net>,
       Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Subject: [patch 2/5] Hotplug firmware loader for Keyspan usb-serial driver
Content-Disposition: inline; filename=keyspan-request_firmware
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Convert the keyspan USB serial driver to use request_firmware and
firmware_load_ihex.

Signed-off-by: Jan Harkes <jaharkes@cs.cmu.edu>


 Kconfig   |   90 ++++--------------------------------------
 keyspan.c |  132 +++++++++++++++++++++++---------------------------------------
 keyspan.h |   84 ---------------------------------------
 3 files changed, 59 insertions(+), 247 deletions(-)

Index: linux/drivers/usb/serial/keyspan.c
===================================================================
--- linux.orig/drivers/usb/serial/keyspan.c	2005-04-05 15:08:37.000000000 -0400
+++ linux/drivers/usb/serial/keyspan.c	2005-04-05 15:23:47.000000000 -0400
@@ -28,6 +28,9 @@
 
   Change History
 
+    2005mar10	Jan Harkes
+      Use generic request_firmware/load_ihex functions.
+
     2003sep04	LPM (Keyspan) add support for new single port product USA19HS.
 				Improve setup message handling for all devices.
 
@@ -106,6 +109,8 @@
 #include <linux/tty_flip.h>
 #include <linux/module.h>
 #include <linux/spinlock.h>
+#include <linux/firmware.h>
+#include <linux/ihex_parser.h>
 #include <asm/uaccess.h>
 #include <linux/usb.h>
 #include "usb-serial.h"
@@ -1165,13 +1170,28 @@ static void keyspan_close(struct usb_ser
 	port->tty = NULL;
 }
 
+static int keyspan_fw_load(struct ihex_record *record, void *arg)
+{
+	struct usb_serial *serial = (struct usb_serial *)arg;
+	int ret;
+
+	ret = ezusb_writememory(serial, record->address, record->data,
+				record->len, 0xa0);
+	if (ret < 0) {
+		dev_err(&serial->dev->dev,
+			"ezusb_writememory failed for Keyspan"
+			"firmware (%d %08X %p %d)\n",
+			ret, record->address, record->data, record->len);
+	}
+	return ret;
+}
 
 	/* download the firmware to a pre-renumeration device */
 static int keyspan_fake_startup (struct usb_serial *serial)
 {
 	int 				response;
-	const struct ezusb_hex_record 	*record;
-	char				*fw_name;
+	char				*model, fw_name[20];
+	const struct firmware		*fw;
 
 	dbg("Keyspan startup version %04x product %04x",
 	    le16_to_cpu(serial->dev->descriptor.bcdDevice),
@@ -1182,97 +1202,43 @@ static int keyspan_fake_startup (struct 
 		return(1);
 	}
 
-		/* Select firmware image on the basis of idProduct */
 	switch (le16_to_cpu(serial->dev->descriptor.idProduct)) {
-	case keyspan_usa28_pre_product_id:
-		record = &keyspan_usa28_firmware[0];
-		fw_name = "USA28";
-		break;
-
-	case keyspan_usa28x_pre_product_id:
-		record = &keyspan_usa28x_firmware[0];
-		fw_name = "USA28X";
-		break;
-
-	case keyspan_usa28xa_pre_product_id:
-		record = &keyspan_usa28xa_firmware[0];
-		fw_name = "USA28XA";
-		break;
-
-	case keyspan_usa28xb_pre_product_id:
-		record = &keyspan_usa28xb_firmware[0];
-		fw_name = "USA28XB";
-		break;
-
-	case keyspan_usa19_pre_product_id:
-		record = &keyspan_usa19_firmware[0];
-		fw_name = "USA19";
-		break;
-			     
-	case keyspan_usa19qi_pre_product_id:
-		record = &keyspan_usa19qi_firmware[0];
-		fw_name = "USA19QI";
-		break;
-			     
-	case keyspan_mpr_pre_product_id:
-		record = &keyspan_mpr_firmware[0];
-		fw_name = "MPR";
-		break;
-
-	case keyspan_usa19qw_pre_product_id:
-		record = &keyspan_usa19qw_firmware[0];
-		fw_name = "USA19QI";
-		break;
-			     
-	case keyspan_usa18x_pre_product_id:
-		record = &keyspan_usa18x_firmware[0];
-		fw_name = "USA18X";
-		break;
-			     
-	case keyspan_usa19w_pre_product_id:
-		record = &keyspan_usa19w_firmware[0];
-		fw_name = "USA19W";
-		break;
-		
-	case keyspan_usa49w_pre_product_id:
-		record = &keyspan_usa49w_firmware[0];
-		fw_name = "USA49W";
-		break;
-
-	case keyspan_usa49wlc_pre_product_id:
-		record = &keyspan_usa49wlc_firmware[0];
-		fw_name = "USA49WLC";
-		break;
-
+	case keyspan_usa18x_pre_product_id:   model = "usa18x";   break;
+	case keyspan_usa19_pre_product_id:    model = "usa19";    break;
+	case keyspan_usa19qi_pre_product_id:  model = "usa19qi";  break;
+	case keyspan_mpr_pre_product_id:      model = "mpr";      break;
+	case keyspan_usa19qw_pre_product_id:  model = "usa19qw";  break;
+	case keyspan_usa19w_pre_product_id:   model = "usa19w";   break;
+	case keyspan_usa28_pre_product_id:    model = "usa28";    break;
+	case keyspan_usa28x_pre_product_id:   model = "usa28x";   break;
+	case keyspan_usa28xa_pre_product_id:  model = "usa28xa";  break;
+	case keyspan_usa28xb_pre_product_id:  model = "usa28xb";  break;
+	case keyspan_usa49w_pre_product_id:   model = "usa49w";   break;
+	case keyspan_usa49wlc_pre_product_id: model = "usa49wlc"; break;
 	default:
-		record = NULL;
-		fw_name = "Unknown";
-		break;
+		dev_err(&serial->dev->dev, "Unknown keyspan device (%04x).\n",
+			le16_to_cpu(serial->dev->descriptor.idProduct));
+		return(1);
 	}
 
-	if (record == NULL) {
-		dev_err(&serial->dev->dev, "Required keyspan firmware image (%s) unavailable.\n", fw_name);
+	sprintf(fw_name, "keyspan-%s.fw", model);
+
+	if (request_firmware(&fw, fw_name, &serial->dev->dev) != 0) {
+		dev_err(&serial->dev->dev, "Required firmware image (%s) unavailable.\n", fw_name);
 		return(1);
 	}
 
-	dbg("Uploading Keyspan %s firmware.", fw_name);
+	dbg("Uploading Keyspan %s firmware.", model);
 
 		/* download the firmware image */
 	response = ezusb_set_reset(serial, 1);
 
-	while(record->address != 0xffff) {
-		response = ezusb_writememory(serial, record->address,
-					     (unsigned char *)record->data,
-					     record->data_size, 0xa0);
-		if (response < 0) {
-			dev_err(&serial->dev->dev, "ezusb_writememory failed for Keyspan"
-				"firmware (%d %04X %p %d)\n",
-				response, 
-				record->address, record->data, record->data_size);
-			break;
-		}
-		record++;
-	}
+	if (load_ihex(fw->data, fw->size, serial, keyspan_fw_load))
+		dev_err(&serial->dev->dev, "Firmware %s upload failed\n",
+			fw_name);
+
+	release_firmware(fw);
+
 		/* bring device out of reset. Renumeration will occur in a
 		   moment and the new device will bind to the real driver */
 	response = ezusb_set_reset(serial, 0);
@@ -1418,7 +1384,7 @@ static void keyspan_setup_urbs(struct us
 			(serial, d_details->outcont_endpoints[i], USB_DIR_OUT,
 			 port, p_priv->outcont_buffer, 64,
 			 cback->outcont_callback);
-	}	
+	}
 
 }
 
Index: linux/drivers/usb/serial/keyspan.h
===================================================================
--- linux.orig/drivers/usb/serial/keyspan.h	2005-04-05 15:08:37.000000000 -0400
+++ linux/drivers/usb/serial/keyspan.h	2005-04-05 15:21:45.000000000 -0400
@@ -99,90 +99,6 @@ static int  keyspan_usa90_send_setup	(st
 					 struct usb_serial_port *port,
 					 int reset_port);
 
-/* Struct used for firmware - increased size of data section
-   to allow Keyspan's 'C' firmware struct to be used unmodified */
-struct ezusb_hex_record {
-	__u16 address;
-	__u8 data_size;
-	__u8 data[64];
-};
-
-/* Conditionally include firmware images, if they aren't
-   included create a null pointer instead.  Current 
-   firmware images aren't optimised to remove duplicate
-   addresses in the image itself. */
-#ifdef CONFIG_USB_SERIAL_KEYSPAN_USA28
-	#include "keyspan_usa28_fw.h"
-#else
-	static const struct ezusb_hex_record *keyspan_usa28_firmware = NULL;
-#endif
-
-#ifdef CONFIG_USB_SERIAL_KEYSPAN_USA28X
-	#include "keyspan_usa28x_fw.h"
-#else
-	static const struct ezusb_hex_record *keyspan_usa28x_firmware = NULL;
-#endif
-
-#ifdef CONFIG_USB_SERIAL_KEYSPAN_USA28XA
-	#include "keyspan_usa28xa_fw.h"
-#else
-	static const struct ezusb_hex_record *keyspan_usa28xa_firmware = NULL;
-#endif
-
-#ifdef CONFIG_USB_SERIAL_KEYSPAN_USA28XB
-	#include "keyspan_usa28xb_fw.h"
-#else
-	static const struct ezusb_hex_record *keyspan_usa28xb_firmware = NULL;
-#endif
-
-#ifdef CONFIG_USB_SERIAL_KEYSPAN_USA19
-	#include "keyspan_usa19_fw.h"
-#else
-	static const struct ezusb_hex_record *keyspan_usa19_firmware = NULL;
-#endif
-
-#ifdef CONFIG_USB_SERIAL_KEYSPAN_USA19QI
-	#include "keyspan_usa19qi_fw.h"
-#else
-	static const struct ezusb_hex_record *keyspan_usa19qi_firmware = NULL;
-#endif
-
-#ifdef CONFIG_USB_SERIAL_KEYSPAN_MPR
-        #include "keyspan_mpr_fw.h"
-#else
-	static const struct ezusb_hex_record *keyspan_mpr_firmware = NULL;
-#endif
-
-#ifdef CONFIG_USB_SERIAL_KEYSPAN_USA19QW
-	#include "keyspan_usa19qw_fw.h"
-#else
-	static const struct ezusb_hex_record *keyspan_usa19qw_firmware = NULL;
-#endif
-
-#ifdef CONFIG_USB_SERIAL_KEYSPAN_USA18X
-	#include "keyspan_usa18x_fw.h"
-#else
-	static const struct ezusb_hex_record *keyspan_usa18x_firmware = NULL;
-#endif
-
-#ifdef CONFIG_USB_SERIAL_KEYSPAN_USA19W
-	#include "keyspan_usa19w_fw.h"
-#else
-	static const struct ezusb_hex_record *keyspan_usa19w_firmware = NULL;
-#endif
-
-#ifdef CONFIG_USB_SERIAL_KEYSPAN_USA49W
-	#include "keyspan_usa49w_fw.h"
-#else
-	static const struct ezusb_hex_record *keyspan_usa49w_firmware = NULL;
-#endif
-
-#ifdef CONFIG_USB_SERIAL_KEYSPAN_USA49WLC
-        #include "keyspan_usa49wlc_fw.h"
-#else
-	static const struct ezusb_hex_record *keyspan_usa49wlc_firmware = NULL;
-#endif
-
 /* Values used for baud rate calculation - device specific */
 #define	KEYSPAN_INVALID_BAUD_RATE		(-1)
 #define	KEYSPAN_BAUD_RATE_OK			(0)
Index: linux/drivers/usb/serial/Kconfig
===================================================================
--- linux.orig/drivers/usb/serial/Kconfig	2005-04-05 15:08:37.000000000 -0400
+++ linux/drivers/usb/serial/Kconfig	2005-04-05 15:21:45.000000000 -0400
@@ -239,95 +239,25 @@ config USB_SERIAL_KEYSPAN_PDA
 config USB_SERIAL_KEYSPAN
 	tristate "USB Keyspan USA-xxx Serial Driver"
 	depends on USB_SERIAL
+	select IHEX_PARSER
 	---help---
 	  Say Y here if you want to use Keyspan USB to serial converter
 	  devices.  This driver makes use of Keyspan's official firmware
-	  and was developed with their support.  You must also include
-	  firmware to support your particular device(s).
+	  and was developed with their support.  It uses hotplug to load
+	  the required firmware from /usr/lib/hotplug/firmware or
+	  /lib/firmware.
+	  
+	  However there really isn't a good way to get this firmware
+	  since the license only allows it to be distributed as part of
+	  a Linux or other Open Source operating system kernel.  So you
+	  will have to copy the firmware files from the kernel source
+	  tree (drivers/usb/serial/*.fw) to /lib/firmware yourself.
 
 	  See <http://misc.nu/hugh/keyspan.html> for more information.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called keyspan.
 
-config USB_SERIAL_KEYSPAN_MPR
-	bool "USB Keyspan MPR Firmware"
-	depends on USB_SERIAL_KEYSPAN
-	help
-	  Say Y here to include firmware for the Keyspan MPR converter.
-
-config USB_SERIAL_KEYSPAN_USA28
-	bool "USB Keyspan USA-28 Firmware"
-	depends on USB_SERIAL_KEYSPAN
-	help
-	  Say Y here to include firmware for the USA-28 converter.
-
-config USB_SERIAL_KEYSPAN_USA28X
-	bool "USB Keyspan USA-28X Firmware"
-	depends on USB_SERIAL_KEYSPAN
-	help
-	  Say Y here to include firmware for the USA-28X converter.
-	  Be sure you have a USA-28X, there are also 28XA and 28XB
-	  models, the label underneath has the actual part number.
-
-config USB_SERIAL_KEYSPAN_USA28XA
-	bool "USB Keyspan USA-28XA Firmware"
-	depends on USB_SERIAL_KEYSPAN
-	help
-	  Say Y here to include firmware for the USA-28XA converter.
-	  Be sure you have a USA-28XA, there are also 28X and 28XB
-	  models, the label underneath has the actual part number.
-
-config USB_SERIAL_KEYSPAN_USA28XB
-	bool "USB Keyspan USA-28XB Firmware"
-	depends on USB_SERIAL_KEYSPAN
-	help
-	  Say Y here to include firmware for the USA-28XB converter.
-	  Be sure you have a USA-28XB, there are also 28X and 28XA
-	  models, the label underneath has the actual part number.
-
-config USB_SERIAL_KEYSPAN_USA19
-	bool "USB Keyspan USA-19 Firmware"
-	depends on USB_SERIAL_KEYSPAN
-	help
-	  Say Y here to include firmware for the USA-19 converter.
-
-config USB_SERIAL_KEYSPAN_USA18X
-	bool "USB Keyspan USA-18X Firmware"
-	depends on USB_SERIAL_KEYSPAN
-	help
-	  Say Y here to include firmware for the USA-18X converter.
-
-config USB_SERIAL_KEYSPAN_USA19W
-	bool "USB Keyspan USA-19W Firmware"
-	depends on USB_SERIAL_KEYSPAN
-	help
-	  Say Y here to include firmware for the USA-19W converter.
-
-config USB_SERIAL_KEYSPAN_USA19QW
-	bool "USB Keyspan USA-19QW Firmware"
-	depends on USB_SERIAL_KEYSPAN
-	help
-	  Say Y here to include firmware for the USA-19QW converter.
-
-config USB_SERIAL_KEYSPAN_USA19QI
-	bool "USB Keyspan USA-19QI Firmware"
-	depends on USB_SERIAL_KEYSPAN
-	help
-	  Say Y here to include firmware for the USA-19QI converter.
-
-config USB_SERIAL_KEYSPAN_USA49W
-	bool "USB Keyspan USA-49W Firmware"
-	depends on USB_SERIAL_KEYSPAN
-	help
-	  Say Y here to include firmware for the USA-49W converter.
-
-config USB_SERIAL_KEYSPAN_USA49WLC
-	bool "USB Keyspan USA-49WLC Firmware"
-	depends on USB_SERIAL_KEYSPAN
-	help
-	  Say Y here to include firmware for the USA-49WLC converter.
-
 config USB_SERIAL_KLSI
 	tristate "USB KL5KUSB105 (Palmconnect) Driver (EXPERIMENTAL)"
 	depends on USB_SERIAL && EXPERIMENTAL

--

