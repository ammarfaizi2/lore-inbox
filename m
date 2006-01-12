Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932512AbWALRsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512AbWALRsr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 12:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932518AbWALRsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 12:48:46 -0500
Received: from smtp6-g19.free.fr ([212.27.42.36]:28602 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S932512AbWALRsp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 12:48:45 -0500
From: Duncan Sands <baldrick@free.fr>
To: Greg KH <greg@kroah.com>
Subject: [PATCH 02/13] USBATM: add flags field
Date: Thu, 12 Jan 2006 18:48:37 +0100
User-Agent: KMail/1.9.1
Cc: usbatm@lists.infradead.org, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <200601121729.52596.baldrick@free.fr>
In-Reply-To: <200601121729.52596.baldrick@free.fr>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_2ZpxDkHwFgjW58g"
Message-Id: <200601121848.38217.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_2ZpxDkHwFgjW58g
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Have minidrivers and the core signal special requirements
using a flags field in struct usbatm_data.  For the moment
this is only used to replace the need_heavy_init bind
parameter, but there'll be new flags in later patches.

Signed-off-by:	Duncan Sands <baldrick@free.fr>

--Boundary-00=_2ZpxDkHwFgjW58g
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="flags"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="flags"

diff -x '*.orig' -x '*.base' -u -r Linux/drivers/usb/atm.orig/cxacru.c Linux/drivers/usb/atm/cxacru.c
--- Linux/drivers/usb/atm.orig/cxacru.c	2006-01-12 18:34:35.000000000 +0100
+++ Linux/drivers/usb/atm/cxacru.c	2006-01-12 18:34:40.000000000 +0100
@@ -666,8 +666,7 @@
 }
 
 static int cxacru_bind(struct usbatm_data *usbatm_instance,
-		       struct usb_interface *intf, const struct usb_device_id *id,
-		       int *need_heavy_init)
+		       struct usb_interface *intf, const struct usb_device_id *id)
 {
 	struct cxacru_data *instance;
 	struct usb_device *usb_dev = interface_to_usbdev(intf);
@@ -726,7 +725,7 @@
 
 	usbatm_instance->driver_data = instance;
 
-	*need_heavy_init = cxacru_card_status(instance);
+	usbatm_instance->flags = (cxacru_card_status(instance) ? 0 : UDSL_SKIP_HEAVY_INIT);
 
 	return 0;
 
Only in Linux/drivers/usb/atm: done
Only in Linux/drivers/usb/atm.orig/patches: messages
diff -x '*.orig' -x '*.base' -u -r Linux/drivers/usb/atm.orig/speedtch.c Linux/drivers/usb/atm/speedtch.c
--- Linux/drivers/usb/atm.orig/speedtch.c	2006-01-12 18:34:35.000000000 +0100
+++ Linux/drivers/usb/atm/speedtch.c	2006-01-12 18:34:40.000000000 +0100
@@ -681,8 +681,7 @@
 
 static int speedtch_bind(struct usbatm_data *usbatm,
 			 struct usb_interface *intf,
-			 const struct usb_device_id *id,
-			 int *need_heavy_init)
+			 const struct usb_device_id *id)
 {
 	struct usb_device *usb_dev = interface_to_usbdev(intf);
 	struct usb_interface *cur_intf;
@@ -754,11 +753,11 @@
 			      0x12, 0xc0, 0x07, 0x00,
 			      instance->scratch_buffer + OFFSET_7, SIZE_7, 500);
 
-	*need_heavy_init = (ret != SIZE_7);
+	usbatm->flags = (ret == SIZE_7 ? UDSL_SKIP_HEAVY_INIT : 0);
 
-	usb_dbg(usbatm, "%s: firmware %s loaded\n", __func__, need_heavy_init ? "not" : "already");
+	usb_dbg(usbatm, "%s: firmware %s loaded\n", __func__, usbatm->flags & UDSL_SKIP_HEAVY_INIT ? "already" : "not");
 
-	if (*need_heavy_init)
+	if (!(usbatm->flags & UDSL_SKIP_HEAVY_INIT))
 		if ((ret = usb_reset_device(usb_dev)) < 0) {
 			usb_err(usbatm, "%s: device reset failed (%d)!\n", __func__, ret);
 			goto fail_free;
diff -x '*.orig' -x '*.base' -u -r Linux/drivers/usb/atm.orig/ueagle-atm.c Linux/drivers/usb/atm/ueagle-atm.c
--- Linux/drivers/usb/atm.orig/ueagle-atm.c	2006-01-12 18:34:35.000000000 +0100
+++ Linux/drivers/usb/atm/ueagle-atm.c	2006-01-12 18:34:40.000000000 +0100
@@ -1617,7 +1617,7 @@
 }
 
 static int uea_bind(struct usbatm_data *usbatm, struct usb_interface *intf,
-		   const struct usb_device_id *id, int *heavy)
+		   const struct usb_device_id *id)
 {
 	struct usb_device *usb = interface_to_usbdev(intf);
 	struct uea_softc *sc;
@@ -1629,7 +1629,7 @@
 	if (ifnum != UEA_INTR_IFACE_NO)
 		return -ENODEV;
 
-	*heavy = sync_wait[modem_index];
+	usbatm_instance->flags = (sync_wait[modem_index] ? 0 : UDSL_SKIP_HEAVY_INIT);
 
 	/* interface 1 is for outbound traffic */
 	ret = claim_interface(usb, usbatm, UEA_US_IFACE_NO);
diff -x '*.orig' -x '*.base' -u -r Linux/drivers/usb/atm.orig/usbatm.c Linux/drivers/usb/atm/usbatm.c
--- Linux/drivers/usb/atm.orig/usbatm.c	2006-01-12 18:34:35.000000000 +0100
+++ Linux/drivers/usb/atm/usbatm.c	2006-01-12 18:34:40.000000000 +0100
@@ -969,7 +969,6 @@
 	char *buf;
 	int error = -ENOMEM;
 	int i, length;
-	int need_heavy;
 
 	dev_dbg(dev, "%s: trying driver %s with vendor=%04x, product=%04x, ifnum %2d\n",
 			__func__, driver->driver_name,
@@ -1014,8 +1013,7 @@
 	snprintf(buf, length, ")");
 
  bind:
-	need_heavy = 1;
-	if (driver->bind && (error = driver->bind(instance, intf, id, &need_heavy)) < 0) {
+	if (driver->bind && (error = driver->bind(instance, intf, id)) < 0) {
 			dev_err(dev, "%s: bind failed: %d!\n", __func__, error);
 			goto fail_free;
 	}
@@ -1098,7 +1096,7 @@
 		     __func__, urb->transfer_buffer, urb->transfer_buffer_length, urb);
 	}
 
-	if (need_heavy && driver->heavy_init) {
+	if (!(instance->flags & UDSL_SKIP_HEAVY_INIT) && driver->heavy_init) {
 		error = usbatm_heavy_init(instance);
 	} else {
 		complete(&instance->thread_exited);	/* pretend that heavy_init was run */
diff -x '*.orig' -x '*.base' -u -r Linux/drivers/usb/atm.orig/usbatm.h Linux/drivers/usb/atm/usbatm.h
--- Linux/drivers/usb/atm.orig/usbatm.h	2006-01-12 18:34:35.000000000 +0100
+++ Linux/drivers/usb/atm/usbatm.h	2006-01-12 18:34:40.000000000 +0100
@@ -84,6 +84,11 @@
 #endif
 
 
+/* flags, set by mini-driver in bind() */
+
+#define UDSL_SKIP_HEAVY_INIT	(1<<0)
+
+
 /* mini driver */
 
 struct usbatm_data;
@@ -99,12 +104,9 @@
 
 	const char *driver_name;
 
-	/*
-	*  init device ... can sleep, or cause probe() failure.  Drivers with a heavy_init
-	*  method can avoid having it called by setting need_heavy_init to zero.
-	*/
+	/* init device ... can sleep, or cause probe() failure */
         int (*bind) (struct usbatm_data *, struct usb_interface *,
-		     const struct usb_device_id *id, int *need_heavy_init);
+		     const struct usb_device_id *id);
 
 	/* additional device initialization that is too slow to be done in probe() */
         int (*heavy_init) (struct usbatm_data *, struct usb_interface *);
@@ -152,6 +154,7 @@
 	struct usbatm_driver *driver;
 	void *driver_data;
 	char driver_name[16];
+	unsigned int flags; /* set by mini-driver in bind() */
 
 	/* USB device */
 	struct usb_device *usb_dev;
diff -x '*.orig' -x '*.base' -u -r Linux/drivers/usb/atm.orig/xusbatm.c Linux/drivers/usb/atm/xusbatm.c
--- Linux/drivers/usb/atm.orig/xusbatm.c	2006-01-12 18:34:35.000000000 +0100
+++ Linux/drivers/usb/atm/xusbatm.c	2006-01-12 18:34:40.000000000 +0100
@@ -62,8 +62,7 @@
 }
 
 static int xusbatm_bind(struct usbatm_data *usbatm,
-			struct usb_interface *intf, const struct usb_device_id *id,
-			int *need_heavy_init)
+			struct usb_interface *intf, const struct usb_device_id *id)
 {
 	struct usb_device *usb_dev = interface_to_usbdev(intf);
 	int drv_ix = id - xusbatm_usb_ids;

--Boundary-00=_2ZpxDkHwFgjW58g--
