Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267806AbTB1MVm>; Fri, 28 Feb 2003 07:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267807AbTB1MVm>; Fri, 28 Feb 2003 07:21:42 -0500
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:13185 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S267806AbTB1MVl>; Fri, 28 Feb 2003 07:21:41 -0500
From: Duncan Sands <baldrick@wanadoo.fr>
To: linux-usb-users@lists.sourceforge.net
Subject: [PATCH] USB speedtouch: handle usb_string failure
Date: Fri, 28 Feb 2003 13:31:31 +0100
User-Agent: KMail/1.5
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302281331.31161.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 speedtouch.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)


diff -Nru a/drivers/usb/misc/speedtouch.c b/drivers/usb/misc/speedtouch.c
--- a/drivers/usb/misc/speedtouch.c	Fri Feb 28 13:23:18 2003
+++ b/drivers/usb/misc/speedtouch.c	Fri Feb 28 13:23:18 2003
@@ -892,7 +892,6 @@
 	int ifnum = intf->altsetting->desc.bInterfaceNumber;
 	struct udsl_instance_data *instance;
 	unsigned char mac_str [13];
-	unsigned char mac [6];
 	int i, length;
 	char *buf;
 
@@ -995,13 +994,10 @@
 	instance->atm_dev->link_rate = 128 * 1000 / 424;
 
 	/* set MAC address, it is stored in the serial number */
-	usb_string (instance->usb_dev, instance->usb_dev->descriptor.iSerialNumber, mac_str, 13);
-	for (i = 0; i < 6; i++)
-		mac[i] = (hex2int (mac_str[i * 2]) * 16) + (hex2int (mac_str[i * 2 + 1]));
-
-	dbg ("MAC is %02x:%02x:%02x:%02x:%02x:%02x", mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
-
-	memcpy (instance->atm_dev->esi, mac, 6);
+	memset (instance->atm_dev->esi, 0, sizeof (instance->atm_dev->esi));
+	if (usb_string (dev, dev->descriptor.iSerialNumber, mac_str, sizeof (mac_str)) == 12)
+		for (i = 0; i < 6; i++)
+			instance->atm_dev->esi[i] = (hex2int (mac_str[i * 2]) * 16) + (hex2int (mac_str[i * 2 + 1]));
 
 	/* device description */
 	buf = instance->description;

