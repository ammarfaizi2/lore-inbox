Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266010AbTBXJtP>; Mon, 24 Feb 2003 04:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266038AbTBXJtP>; Mon, 24 Feb 2003 04:49:15 -0500
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:46800 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S266010AbTBXJtM>; Mon, 24 Feb 2003 04:49:12 -0500
From: Duncan Sands <baldrick@wanadoo.fr>
To: linux-usb-devel@lists.sourceforge.net
Subject: [PATCH] USB speedtouch: better proc info
Date: Mon, 24 Feb 2003 10:58:51 +0100
User-Agent: KMail/1.5
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302241058.52073.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Output the correct device name, show the state of the device (for debugging) and of the
ADSL line (anyone want to write a graphical utility to show this, like under windows?).  We
no longer consult the usb_device struct in udsl_atm_proc_read, so don't take a reference
to it.  Against Greg's current 2.5 USB tree.


 speedtouch.c |   68 ++++++++++++++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 58 insertions(+), 10 deletions(-)


--- 1.62/drivers/usb/misc/speedtouch.c	Fri Feb 21 10:21:00 2003
+++ 1.64/drivers/usb/misc/speedtouch.c	Mon Feb 24 10:17:09 2003
@@ -156,6 +156,7 @@
 
 	/* usb device part */
 	struct usb_device *usb_dev;
+	char description [64];
 	int firmware_loaded;
 
 	/* atm device part */
@@ -698,8 +699,6 @@
 
 	dbg ("udsl_atm_dev_close: killing tasklet");
 	tasklet_kill (&instance->send_tasklet);
-	dbg ("udsl_atm_dev_close: freeing USB device");
-	usb_put_dev (instance->usb_dev);
 	dbg ("udsl_atm_dev_close: freeing instance");
 	kfree (instance);
 }
@@ -722,8 +721,10 @@
 	}
 
 	if (!left--)
-		return sprintf (page, "SpeedTouch USB %s-%s (%02x:%02x:%02x:%02x:%02x:%02x)\n",
-				instance->usb_dev->bus->bus_name, instance->usb_dev->devpath,
+		return sprintf (page, "%s\n", instance->description);
+
+	if (!left--)
+		return sprintf (page, "MAC: %02x:%02x:%02x:%02x:%02x:%02x\n",
 				atm_dev->esi[0], atm_dev->esi[1], atm_dev->esi[2],
 				atm_dev->esi[3], atm_dev->esi[4], atm_dev->esi[5]);
 
@@ -735,6 +736,30 @@
 				atomic_read (&atm_dev->stats.aal5.rx_err),
 				atomic_read (&atm_dev->stats.aal5.rx_drop));
 
+	if (!left--) {
+		switch (atm_dev->signal) {
+		case ATM_PHY_SIG_FOUND:
+			sprintf (page, "Line up");
+			break;
+		case ATM_PHY_SIG_LOST:
+			sprintf (page, "Line down");
+			break;
+		default:
+			sprintf (page, "Line state unknown");
+			break;
+		}
+
+		if (instance->usb_dev) {
+			if (!instance->firmware_loaded)
+				strcat (page, ", no firmware\n");
+			else
+				strcat (page, ", firmware loaded\n");
+		} else
+			strcat (page, ", disconnected\n");
+
+		return strlen (page);
+	}
+
 	return 0;
 }
 
@@ -867,7 +892,8 @@
 	struct udsl_instance_data *instance;
 	unsigned char mac_str [13];
 	unsigned char mac [6];
-	int i;
+	int i, length;
+	char *buf;
 
 	dbg ("Trying device with Vendor=0x%x, Product=0x%x, ifnum %d",
 		dev->descriptor.idVendor, dev->descriptor.idProduct, ifnum);
@@ -962,7 +988,7 @@
 
 	instance->atm_dev->ci_range.vpi_bits = ATM_CI_MAX;
 	instance->atm_dev->ci_range.vci_bits = ATM_CI_MAX;
-	instance->atm_dev->signal = ATM_PHY_SIG_LOST;
+	instance->atm_dev->signal = ATM_PHY_SIG_UNKNOWN;
 
 	/* tmp init atm device, set to 128kbit */
 	instance->atm_dev->link_rate = 128 * 1000 / 424;
@@ -976,14 +1002,34 @@
 
 	memcpy (instance->atm_dev->esi, mac, 6);
 
-	wmb ();
+	/* device description */
+	buf = instance->description;
+	length = sizeof (instance->description);
+
+	if ((i = usb_string (dev, dev->descriptor.iProduct, buf, length)) < 0)
+		goto finish;
+
+	buf += i;
+	length -= i;
+
+	i = snprintf (buf, length, " (");
+	buf += i;
+	length -= i;
+
+	if (length <= 0 || (i = usb_make_path (dev, buf, length)) < 0)
+		goto finish;
 
+	buf += i;
+	length -= i;
+
+	snprintf (buf, length, ")");
+
+finish:
+	/* ready for ATM callbacks */
 	instance->atm_dev->dev_data = instance;
 
 	usb_set_intfdata (intf, instance);
 
-	usb_get_dev (dev);
-
 	return 0;
 
 fail:
@@ -1116,8 +1162,10 @@
 	for (i = 0; i < UDSL_NUMBER_SND_BUFS; i++)
 		kfree (instance->all_buffers[i].base);
 
+	instance->usb_dev = NULL;
+
 	/* atm finalize */
-	shutdown_atm_dev (instance->atm_dev);
+	shutdown_atm_dev (instance->atm_dev); /* frees instance */
 }
 
 
