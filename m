Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266867AbUI0Rtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266867AbUI0Rtu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 13:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266870AbUI0Rtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 13:49:50 -0400
Received: from itapoa.terra.com.br ([200.154.55.227]:26021 "EHLO
	itapoa.terra.com.br") by vger.kernel.org with ESMTP id S266867AbUI0Rtk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 13:49:40 -0400
Date: Mon, 27 Sep 2004 13:53:41 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@conectiva.com.br>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/5]: usb-serial: Moves the search in device list out of
 usb_serial_probe().
Message-Id: <20040927135341.3993b22f.lcapitulino@conectiva.com.br>
Organization: Conectiva S/A.
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-conectiva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Move the search in `usb_serial_driver_list' out of usb_serial_probe().

 Note that:

1) The `found' variable is not necessary;
2) If the device does have a probe function, I'm calling usb_match_id()
again. I'm uncertain if this is the better thing to do.


(against 2.6.9-rc2-mm4)


Signed-off-by: Luiz Capitulino <lcapitulino@conectiva.com.br>

 drivers/usb/serial/usb-serial.c |   44 +++++++++++++++++++++++-----------------
 1 files changed, 26 insertions(+), 18 deletions(-)


diff -X /home/lcapitulino/kernels/2.6/dontdiff -Nparu a/drivers/usb/serial/usb-serial.c a~/drivers/usb/serial/usb-serial.c
--- a/drivers/usb/serial/usb-serial.c	2004-09-25 16:17:20.000000000 -0300
+++ a~/drivers/usb/serial/usb-serial.c	2004-09-26 14:20:16.000000000 -0300
@@ -846,6 +846,25 @@ static struct usb_serial * create_serial
 	return serial;
 }
 
+static struct usb_serial_device_type *search_serial_device(struct usb_interface *iface)
+{
+	struct list_head *p;
+	const struct usb_device_id *id;
+	struct usb_serial_device_type *t;
+
+	/* List trough know devices and see if the usb id matches */
+	list_for_each(p, &usb_serial_driver_list) {
+		t = list_entry(p, struct usb_serial_device_type, driver_list);
+		id = usb_match_id(iface, t->id_table);
+		if (id != NULL) {
+			dbg("descriptor matches");
+			return t;
+		}
+	}
+
+	return NULL;
+}
+
 int usb_serial_probe(struct usb_interface *interface,
 			       const struct usb_device_id *id)
 {
@@ -858,9 +877,7 @@ int usb_serial_probe(struct usb_interfac
 	struct usb_endpoint_descriptor *bulk_in_endpoint[MAX_NUM_PORTS];
 	struct usb_endpoint_descriptor *bulk_out_endpoint[MAX_NUM_PORTS];
 	struct usb_serial_device_type *type = NULL;
-	struct list_head *tmp;
 	int retval;
-	int found;
 	int minor;
 	int buffer_size;
 	int i;
@@ -869,22 +886,9 @@ int usb_serial_probe(struct usb_interfac
 	int num_bulk_out = 0;
 	int num_ports = 0;
 	int max_endpoints;
-	const struct usb_device_id *id_pattern = NULL;
 
-	/* loop through our list of known serial converters, and see if this
-	   device matches. */
-	found = 0;
-	list_for_each (tmp, &usb_serial_driver_list) {
-		type = list_entry(tmp, struct usb_serial_device_type, driver_list);
-		id_pattern = usb_match_id(interface, type->id_table);
-		if (id_pattern != NULL) {
-			dbg("descriptor matches");
-			found = 1;
-			break;
-		}
-	}
-	if (!found) {
-		/* no match */
+	type = search_serial_device(interface);
+	if (!type) {
 		dbg("none matched");
 		return -ENODEV;
 	}
@@ -897,12 +901,16 @@ int usb_serial_probe(struct usb_interfac
 
 	/* if this device type has a probe function, call it */
 	if (type->probe) {
+		const struct usb_device_id *id;
+
 		if (!try_module_get(type->owner)) {
 			dev_err(&interface->dev, "module get failed, exiting\n");
 			kfree (serial);
 			return -EIO;
 		}
-		retval = type->probe (serial, id_pattern);
+
+		id = usb_match_id(interface, type->id_table);
+		retval = type->probe(serial, id);
 		module_put(type->owner);
 
 		if (retval) {
