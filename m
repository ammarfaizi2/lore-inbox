Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261934AbVAHGki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261934AbVAHGki (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 01:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbVAHGiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 01:38:54 -0500
Received: from mail.kroah.org ([69.55.234.183]:23174 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261934AbVAHFst convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:49 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632573855@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:38 -0800
Message-Id: <110516325823@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.439.51, 2005/01/06 17:29:21-08:00, oliver@neukum.org

[PATCH] USB: another workaround for cdc-acm

there are a lot of buggy modems.


Signed-Off-By: Oliver Neukum <oliver@neukum.name>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/class/cdc-acm.c |   15 +++++++++++++++
 drivers/usb/class/cdc-acm.h |    3 ++-
 2 files changed, 17 insertions(+), 1 deletion(-)


diff -Nru a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
--- a/drivers/usb/class/cdc-acm.c	2005-01-07 15:37:12 -08:00
+++ b/drivers/usb/class/cdc-acm.c	2005-01-07 15:37:12 -08:00
@@ -532,7 +532,17 @@
 	u8 call_management_function = 0;
 	int call_interface_num = -1;
 	int data_interface_num;
+	unsigned long quirks;
 
+	/* handle quirks deadly to normal probing*/
+	quirks = (unsigned long)id->driver_info;
+	if (quirks == NO_UNION_NORMAL) {
+		data_interface = usb_ifnum_to_if(usb_dev, 1);
+		control_interface = usb_ifnum_to_if(usb_dev, 0);
+		goto skip_normal_probe;
+	}
+	
+	/* normal probing*/
 	if (!buffer) {
 		err("Wierd descriptor references");
 		return -EINVAL;
@@ -607,6 +617,7 @@
 		if (data_interface_num != call_interface_num)
 			dev_dbg(&intf->dev,"Seperate call control interface. That is not fully supported.");
 
+skip_normal_probe:
 	if (usb_interface_claimed(data_interface)) { /* valid in this context */
 		dev_dbg(&intf->dev,"The data interface isn't available\n");
 		return -EBUSY;
@@ -805,6 +816,10 @@
  */
 
 static struct usb_device_id acm_ids[] = {
+	/* quirky and broken devices */
+	{ USB_DEVICE(0x0870, 0x0001), /* Metricom GS Modem */
+	.driver_info = NO_UNION_NORMAL, /* has no union descriptor */
+	},
 	/* control interfaces with various AT-command sets */
 	{ USB_INTERFACE_INFO(USB_CLASS_COMM, 2, 1) },
 	{ USB_INTERFACE_INFO(USB_CLASS_COMM, 2, 2) },
diff -Nru a/drivers/usb/class/cdc-acm.h b/drivers/usb/class/cdc-acm.h
--- a/drivers/usb/class/cdc-acm.h	2005-01-07 15:37:12 -08:00
+++ b/drivers/usb/class/cdc-acm.h	2005-01-07 15:37:12 -08:00
@@ -125,4 +125,5 @@
 
 #define CDC_DATA_INTERFACE_TYPE	0x0a
 
-
+/* constants describing various quirks and errors */
+#define NO_UNION_NORMAL			1

