Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266463AbUHYWw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266463AbUHYWw6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 18:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266287AbUHYWv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 18:51:28 -0400
Received: from mail.kroah.org ([69.55.234.183]:33947 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266242AbUHYWhA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 18:37:00 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.9-rc1
In-Reply-To: <1093473386452@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Wed, 25 Aug 2004 15:36:27 -0700
Message-Id: <10934733871723@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1803.60.2, 2004/08/02 17:08:20-07:00, greg@kroah.com

KREF: fix up the current kref users for the changed api.
        
Based on work from Kiran, but fixed up by me to actually build and
link properly.

Signed-off-by: Ravikiran Thirumalai <kiran@in.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>



 drivers/scsi/sd.c               |    8 +-
 drivers/scsi/sr.c               |    8 +-
 drivers/usb/core/config.c       |    7 +-
 drivers/usb/core/message.c      |    2 
 drivers/usb/core/urb.c          |    4 -
 drivers/usb/core/usb.h          |    1 
 drivers/usb/host/ehci-mem.c     |    4 -
 drivers/usb/serial/usb-serial.c |  130 +++++++++++++++++++---------------------
 8 files changed, 80 insertions(+), 84 deletions(-)


diff -Nru a/drivers/scsi/sd.c b/drivers/scsi/sd.c
--- a/drivers/scsi/sd.c	2004-08-25 14:57:52 -07:00
+++ b/drivers/scsi/sd.c	2004-08-25 14:57:52 -07:00
@@ -188,7 +188,7 @@
 	return sdkp;
 
  out_put:
-	kref_put(&sdkp->kref);
+	kref_put(&sdkp->kref, scsi_disk_release);
  out_sdkp:
 	sdkp = NULL;
  out:
@@ -200,7 +200,7 @@
 {
 	down(&sd_ref_sem);
 	scsi_device_put(sdkp->device);
-	kref_put(&sdkp->kref);
+	kref_put(&sdkp->kref, scsi_disk_release);
 	up(&sd_ref_sem);
 }
 
@@ -1362,7 +1362,7 @@
 		goto out;
 
 	memset (sdkp, 0, sizeof(*sdkp));
-	kref_init(&sdkp->kref, scsi_disk_release);
+	kref_init(&sdkp->kref);
 
 	/* Note: We can accomodate 64 partitions, but the genhd code
 	 * assumes partitions allocate consecutive minors, which they don't.
@@ -1464,7 +1464,7 @@
 	del_gendisk(sdkp->disk);
 	sd_shutdown(dev);
 	down(&sd_ref_sem);
-	kref_put(&sdkp->kref);
+	kref_put(&sdkp->kref, scsi_disk_release);
 	up(&sd_ref_sem);
 
 	return 0;
diff -Nru a/drivers/scsi/sr.c b/drivers/scsi/sr.c
--- a/drivers/scsi/sr.c	2004-08-25 14:57:52 -07:00
+++ b/drivers/scsi/sr.c	2004-08-25 14:57:52 -07:00
@@ -147,7 +147,7 @@
 	goto out;
 
  out_put:
-	kref_put(&cd->kref);
+	kref_put(&cd->kref, sr_kref_release);
  out_null:
 	cd = NULL;
  out:
@@ -159,7 +159,7 @@
 {
 	down(&sr_ref_sem);
 	scsi_device_put(cd->device);
-	kref_put(&cd->kref);
+	kref_put(&cd->kref, sr_kref_release);
 	up(&sr_ref_sem);
 }
 
@@ -576,7 +576,7 @@
 		goto fail;
 	memset(cd, 0, sizeof(*cd));
 
-	kref_init(&cd->kref, sr_kref_release);
+	kref_init(&cd->kref);
 
 	disk = alloc_disk(1);
 	if (!disk)
@@ -937,7 +937,7 @@
 	del_gendisk(cd->disk);
 
 	down(&sr_ref_sem);
-	kref_put(&cd->kref);
+	kref_put(&cd->kref, sr_kref_release);
 	up(&sr_ref_sem);
 
 	return 0;
diff -Nru a/drivers/usb/core/config.c b/drivers/usb/core/config.c
--- a/drivers/usb/core/config.c	2004-08-25 14:57:51 -07:00
+++ b/drivers/usb/core/config.c	2004-08-25 14:57:51 -07:00
@@ -106,7 +106,7 @@
 	return buffer - buffer0 + i;
 }
 
-static void usb_release_interface_cache(struct kref *ref)
+void usb_release_interface_cache(struct kref *ref)
 {
 	struct usb_interface_cache *intfc = ref_to_usb_interface_cache(ref);
 	int j;
@@ -356,7 +356,7 @@
 		if (!intfc)
 			return -ENOMEM;
 		memset(intfc, 0, len);
-		kref_init(&intfc->ref, usb_release_interface_cache);
+		kref_init(&intfc->ref);
 	}
 
 	/* Skip over any Class Specific or Vendor Specific descriptors;
@@ -422,7 +422,8 @@
 
 		for (i = 0; i < cf->desc.bNumInterfaces; i++) {
 			if (cf->intf_cache[i])
-				kref_put(&cf->intf_cache[i]->ref);
+				kref_put(&cf->intf_cache[i]->ref, 
+					  usb_release_interface_cache);
 		}
 	}
 	kfree(dev->config);
diff -Nru a/drivers/usb/core/message.c b/drivers/usb/core/message.c
--- a/drivers/usb/core/message.c	2004-08-25 14:57:51 -07:00
+++ b/drivers/usb/core/message.c	2004-08-25 14:57:51 -07:00
@@ -1195,7 +1195,7 @@
 	struct usb_interface_cache *intfc =
 			altsetting_to_usb_interface_cache(intf->altsetting);
 
-	kref_put(&intfc->ref);
+	kref_put(&intfc->ref, usb_release_interface_cache);
 	kfree(intf);
 }
 
diff -Nru a/drivers/usb/core/urb.c b/drivers/usb/core/urb.c
--- a/drivers/usb/core/urb.c	2004-08-25 14:57:51 -07:00
+++ b/drivers/usb/core/urb.c	2004-08-25 14:57:51 -07:00
@@ -39,7 +39,7 @@
 {
 	if (urb) {
 		memset(urb, 0, sizeof(*urb));
-		kref_init(&urb->kref, urb_destroy);
+		kref_init(&urb->kref);
 		spin_lock_init(&urb->lock);
 	}
 }
@@ -88,7 +88,7 @@
 void usb_free_urb(struct urb *urb)
 {
 	if (urb)
-		kref_put(&urb->kref);
+		kref_put(&urb->kref, urb_destroy);
 }
 
 /**
diff -Nru a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
--- a/drivers/usb/core/usb.h	2004-08-25 14:57:51 -07:00
+++ b/drivers/usb/core/usb.h	2004-08-25 14:57:51 -07:00
@@ -10,6 +10,7 @@
 extern void usb_disable_endpoint (struct usb_device *dev, unsigned int epaddr);
 extern void usb_disable_interface (struct usb_device *dev,
 		struct usb_interface *intf);
+extern void usb_release_interface_cache(struct kref *ref);
 extern void usb_disable_device (struct usb_device *dev, int skip_ep0);
 
 extern void usb_enable_endpoint (struct usb_device *dev,
diff -Nru a/drivers/usb/host/ehci-mem.c b/drivers/usb/host/ehci-mem.c
--- a/drivers/usb/host/ehci-mem.c	2004-08-25 14:57:52 -07:00
+++ b/drivers/usb/host/ehci-mem.c	2004-08-25 14:57:52 -07:00
@@ -114,7 +114,7 @@
 		return qh;
 
 	memset (qh, 0, sizeof *qh);
-	kref_init(&qh->kref, qh_destroy);
+	kref_init(&qh->kref);
 	qh->ehci = ehci;
 	qh->qh_dma = dma;
 	// INIT_LIST_HEAD (&qh->qh_list);
@@ -139,7 +139,7 @@
 
 static inline void qh_put (struct ehci_qh *qh)
 {
-	kref_put(&qh->kref);
+	kref_put(&qh->kref, qh_destroy);
 }
 
 /*-------------------------------------------------------------------------*/
diff -Nru a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
--- a/drivers/usb/serial/usb-serial.c	2004-08-25 14:57:52 -07:00
+++ b/drivers/usb/serial/usb-serial.c	2004-08-25 14:57:52 -07:00
@@ -421,6 +421,63 @@
 	return;
 }
 
+static void destroy_serial(struct kref *kref)
+{
+	struct usb_serial *serial;
+	struct usb_serial_port *port;
+	int i;
+
+	serial = to_usb_serial(kref);
+
+	dbg ("%s - %s", __FUNCTION__, serial->type->name);
+
+	serial->type->shutdown(serial);
+
+	/* return the minor range that this device had */
+	return_serial(serial);
+
+	for (i = 0; i < serial->num_ports; ++i)
+		serial->port[i]->open_count = 0;
+
+	/* the ports are cleaned up and released in port_release() */
+	for (i = 0; i < serial->num_ports; ++i)
+		if (serial->port[i]->dev.parent != NULL) {
+			device_unregister(&serial->port[i]->dev);
+			serial->port[i] = NULL;
+		}
+
+	/* If this is a "fake" port, we have to clean it up here, as it will
+	 * not get cleaned up in port_release() as it was never registered with
+	 * the driver core */
+	if (serial->num_ports < serial->num_port_pointers) {
+		for (i = serial->num_ports; i < serial->num_port_pointers; ++i) {
+			port = serial->port[i];
+			if (!port)
+				continue;
+			if (port->read_urb) {
+				usb_unlink_urb(port->read_urb);
+				usb_free_urb(port->read_urb);
+			}
+			if (port->write_urb) {
+				usb_unlink_urb(port->write_urb);
+				usb_free_urb(port->write_urb);
+			}
+			if (port->interrupt_in_urb) {
+				usb_unlink_urb(port->interrupt_in_urb);
+				usb_free_urb(port->interrupt_in_urb);
+			}
+			kfree(port->bulk_in_buffer);
+			kfree(port->bulk_out_buffer);
+			kfree(port->interrupt_in_buffer);
+		}
+	}
+
+	usb_put_dev(serial->dev);
+
+	/* free up any memory that we allocated */
+	kfree (serial);
+}
+
 /*****************************************************************************
  * Driver tty interface functions
  *****************************************************************************/
@@ -465,7 +522,7 @@
 		if (retval) {
 			port->open_count = 0;
 			module_put(serial->type->owner);
-			kref_put(&serial->kref);
+			kref_put(&serial->kref, destroy_serial);
 		}
 	}
 bailout:
@@ -496,7 +553,7 @@
 	}
 
 	module_put(port->serial->type->owner);
-	kref_put(&port->serial->kref);
+	kref_put(&port->serial->kref, destroy_serial);
 }
 
 static int serial_write (struct tty_struct * tty, int from_user, const unsigned char *buf, int count)
@@ -654,13 +711,6 @@
 	;
 }
 
-static void serial_shutdown (struct usb_serial *serial)
-{
-	dbg ("%s", __FUNCTION__);
-
-	serial->type->shutdown(serial);
-}
-
 static int serial_read_proc (char *page, char **start, off_t off, int count, int *eof, void *data)
 {
 	struct usb_serial *serial;
@@ -694,7 +744,7 @@
 			begin += length;
 			length = 0;
 		}
-		kref_put(&serial->kref);
+		kref_put(&serial->kref, destroy_serial);
 	}
 	*eof = 1;
 done:
@@ -763,62 +813,6 @@
 	wake_up_interruptible(&tty->write_wait);
 }
 
-static void destroy_serial(struct kref *kref)
-{
-	struct usb_serial *serial;
-	struct usb_serial_port *port;
-	int i;
-
-	serial = to_usb_serial(kref);
-
-	dbg ("%s - %s", __FUNCTION__, serial->type->name);
-	serial_shutdown (serial);
-
-	/* return the minor range that this device had */
-	return_serial(serial);
-
-	for (i = 0; i < serial->num_ports; ++i)
-		serial->port[i]->open_count = 0;
-
-	/* the ports are cleaned up and released in port_release() */
-	for (i = 0; i < serial->num_ports; ++i)
-		if (serial->port[i]->dev.parent != NULL) {
-			device_unregister(&serial->port[i]->dev);
-			serial->port[i] = NULL;
-		}
-
-	/* If this is a "fake" port, we have to clean it up here, as it will
-	 * not get cleaned up in port_release() as it was never registered with
-	 * the driver core */
-	if (serial->num_ports < serial->num_port_pointers) {
-		for (i = serial->num_ports; i < serial->num_port_pointers; ++i) {
-			port = serial->port[i];
-			if (!port)
-				continue;
-			if (port->read_urb) {
-				usb_unlink_urb(port->read_urb);
-				usb_free_urb(port->read_urb);
-			}
-			if (port->write_urb) {
-				usb_unlink_urb(port->write_urb);
-				usb_free_urb(port->write_urb);
-			}
-			if (port->interrupt_in_urb) {
-				usb_unlink_urb(port->interrupt_in_urb);
-				usb_free_urb(port->interrupt_in_urb);
-			}
-			kfree(port->bulk_in_buffer);
-			kfree(port->bulk_out_buffer);
-			kfree(port->interrupt_in_buffer);
-		}
-	}
-
-	usb_put_dev(serial->dev);
-
-	/* free up any memory that we allocated */
-	kfree (serial);
-}
-
 static void port_release(struct device *dev)
 {
 	struct usb_serial_port *port = to_usb_serial_port(dev);
@@ -859,7 +853,7 @@
 	serial->interface = interface;
 	serial->vendor = dev->descriptor.idVendor;
 	serial->product = dev->descriptor.idProduct;
-	kref_init(&serial->kref, destroy_serial);
+	kref_init(&serial->kref);
 
 	return serial;
 }
@@ -1209,7 +1203,7 @@
 	if (serial) {
 		/* let the last holder of this object 
 		 * cause it to be cleaned up */
-		kref_put(&serial->kref);
+		kref_put(&serial->kref, destroy_serial);
 	}
 	dev_info(dev, "device disconnected\n");
 }

