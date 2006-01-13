Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161496AbWAMIiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161496AbWAMIiV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 03:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161499AbWAMIiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 03:38:21 -0500
Received: from smtp4-g19.free.fr ([212.27.42.30]:31433 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S1161496AbWAMIiU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 03:38:20 -0500
From: Duncan Sands <baldrick@free.fr>
To: Greg KH <greg@kroah.com>
Subject: [PATCH 04/13] USBATM: kzalloc conversion
Date: Fri, 13 Jan 2006 09:38:22 +0100
User-Agent: KMail/1.9.1
Cc: usbatm@lists.infradead.org, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <200601121729.52596.baldrick@free.fr>
In-Reply-To: <200601121729.52596.baldrick@free.fr>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_+b2xDKri0xuKh96"
Message-Id: <200601130938.22715.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_+b2xDKri0xuKh96
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Convert kmalloc + memset to kzalloc.

Signed-off-by:	Duncan Sands <baldrick@free.fr>

--Boundary-00=_+b2xDKri0xuKh96
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="04-kzalloc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="04-kzalloc"

Index: Linux/drivers/usb/atm/cxacru.c
===================================================================
--- Linux.orig/drivers/usb/atm/cxacru.c	2006-01-13 08:48:09.000000000 +0100
+++ Linux/drivers/usb/atm/cxacru.c	2006-01-13 08:51:00.000000000 +0100
@@ -673,14 +673,12 @@
 	int ret;
 
 	/* instance init */
-	instance = kmalloc(sizeof(*instance), GFP_KERNEL);
+	instance = kzalloc(sizeof(*instance), GFP_KERNEL);
 	if (!instance) {
 		dbg("cxacru_bind: no memory for instance data");
 		return -ENOMEM;
 	}
 
-	memset(instance, 0, sizeof(*instance));
-
 	instance->usbatm = usbatm_instance;
 	instance->modem_type = (struct cxacru_modem_type *) id->driver_info;
 
Index: Linux/drivers/usb/atm/speedtch.c
===================================================================
--- Linux.orig/drivers/usb/atm/speedtch.c	2006-01-13 08:48:09.000000000 +0100
+++ Linux/drivers/usb/atm/speedtch.c	2006-01-13 08:51:00.000000000 +0100
@@ -715,7 +715,7 @@
 		}
 	}
 
-	instance = kmalloc(sizeof(*instance), GFP_KERNEL);
+	instance = kzalloc(sizeof(*instance), GFP_KERNEL);
 
 	if (!instance) {
 		usb_err(usbatm, "%s: no memory for instance data!\n", __func__);
@@ -723,8 +723,6 @@
 		goto fail_release;
 	}
 
-	memset(instance, 0, sizeof(struct speedtch_instance_data));
-
 	instance->usbatm = usbatm;
 
 	INIT_WORK(&instance->status_checker, (void *)speedtch_check_status, instance);
Index: Linux/drivers/usb/atm/usbatm.c
===================================================================
--- Linux.orig/drivers/usb/atm/usbatm.c	2006-01-13 08:46:17.000000000 +0100
+++ Linux/drivers/usb/atm/usbatm.c	2006-01-13 08:51:00.000000000 +0100
@@ -763,13 +763,12 @@
 		goto fail;
 	}
 
-	if (!(new = kmalloc(sizeof(struct usbatm_vcc_data), GFP_KERNEL))) {
+	if (!(new = kzalloc(sizeof(struct usbatm_vcc_data), GFP_KERNEL))) {
 		atm_err(instance, "%s: no memory for vcc_data!\n", __func__);
 		ret = -ENOMEM;
 		goto fail;
 	}
 
-	memset(new, 0, sizeof(struct usbatm_vcc_data));
 	new->vcc = vcc;
 	new->vpi = vpi;
 	new->vci = vci;
@@ -1066,13 +1065,12 @@
 
 		instance->urbs[i] = urb;
 
-		buffer = kmalloc(channel->buf_size, GFP_KERNEL);
+		/* zero the tx padding to avoid leaking information */
+		buffer = kzalloc(channel->buf_size, GFP_KERNEL);
 		if (!buffer) {
 			dev_err(dev, "%s: no memory for buffer %d!\n", __func__, i);
 			goto fail_unbind;
 		}
-		/* zero the tx padding to avoid leaking information */
-		memset(buffer, 0, channel->buf_size);
 
 		usb_fill_bulk_urb(urb, instance->usb_dev, channel->endpoint,
 				  buffer, channel->buf_size, usbatm_complete, channel);

--Boundary-00=_+b2xDKri0xuKh96--
