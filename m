Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265825AbUGTM2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265825AbUGTM2L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 08:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265847AbUGTM2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 08:28:11 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:2765 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265825AbUGTM1v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 08:27:51 -0400
Date: Tue, 20 Jul 2004 17:57:01 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] kref shrinkage patches -- 2 of 2 -- kref shrinkage
Message-ID: <20040720122659.GB1235@obelix.in.ibm.com>
References: <20040720122307.GA1235@obelix.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040720122307.GA1235@obelix.in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the patch to change current kref users to use the modified 
kref_init and kref_put api (result of kref object shrinkage).

Thanks,
Kiran


 scsi/sd.c               |    8 +-
 scsi/sr.c               |    8 +-
 usb/core/config.c       |    5 +
 usb/core/message.c      |    3 -
 usb/core/urb.c          |    4 -
 usb/host/ehci-mem.c     |    4 -
 usb/serial/usb-serial.c |  136 ++++++++++++++++++++++++------------------------
 7 files changed, 85 insertions(+), 83 deletions(-)

Signed-off-by: Ravikiran Thirumalai <kiran@in.ibm.com>

diff -ruN -X dontdiff2 linux-2.6.7/drivers/scsi/sd.c kref-2.6.7/drivers/scsi/sd.c
--- linux-2.6.7/drivers/scsi/sd.c	2004-06-16 10:49:44.000000000 +0530
+++ kref-2.6.7/drivers/scsi/sd.c	2004-07-20 13:03:49.000000000 +0530
@@ -186,7 +186,7 @@
 	return sdkp;
 
  out_put:
-	kref_put(&sdkp->kref);
+	kref_put(&sdkp->kref, scsi_disk_release);
  out_sdkp:
 	sdkp = NULL;
  out:
@@ -198,7 +198,7 @@
 {
 	down(&sd_ref_sem);
 	scsi_device_put(sdkp->device);
-	kref_put(&sdkp->kref);
+	kref_put(&sdkp->kref, scsi_disk_release);
 	up(&sd_ref_sem);
 }
 
@@ -1360,7 +1360,7 @@
 		goto out;
 
 	memset (sdkp, 0, sizeof(*sdkp));
-	kref_init(&sdkp->kref, scsi_disk_release);
+	kref_init(&sdkp->kref);
 
 	/* Note: We can accomodate 64 partitions, but the genhd code
 	 * assumes partitions allocate consecutive minors, which they don't.
@@ -1462,7 +1462,7 @@
 	del_gendisk(sdkp->disk);
 	sd_shutdown(dev);
 	down(&sd_ref_sem);
-	kref_put(&sdkp->kref);
+	kref_put(&sdkp->kref, scsi_disk_release);
 	up(&sd_ref_sem);
 
 	return 0;
diff -ruN -X dontdiff2 linux-2.6.7/drivers/scsi/sr.c kref-2.6.7/drivers/scsi/sr.c
--- linux-2.6.7/drivers/scsi/sr.c	2004-06-16 10:50:27.000000000 +0530
+++ kref-2.6.7/drivers/scsi/sr.c	2004-07-20 13:03:49.000000000 +0530
@@ -144,7 +144,7 @@
 	goto out;
 
  out_put:
-	kref_put(&cd->kref);
+	kref_put(&cd->kref, sr_kref_release);
  out_null:
 	cd = NULL;
  out:
@@ -156,7 +156,7 @@
 {
 	down(&sr_ref_sem);
 	scsi_device_put(cd->device);
-	kref_put(&cd->kref);
+	kref_put(&cd->kref, sr_kref_release);
 	up(&sr_ref_sem);
 }
 
@@ -573,7 +573,7 @@
 		goto fail;
 	memset(cd, 0, sizeof(*cd));
 
-	kref_init(&cd->kref, sr_kref_release);
+	kref_init(&cd->kref);
 
 	disk = alloc_disk(1);
 	if (!disk)
@@ -952,7 +952,7 @@
 	del_gendisk(cd->disk);
 
 	down(&sr_ref_sem);
-	kref_put(&cd->kref);
+	kref_put(&cd->kref, sr_kref_release);
 	up(&sr_ref_sem);
 
 	return 0;
diff -ruN -X dontdiff2 linux-2.6.7/drivers/usb/core/config.c kref-2.6.7/drivers/usb/core/config.c
--- linux-2.6.7/drivers/usb/core/config.c	2004-06-16 10:48:52.000000000 +0530
+++ kref-2.6.7/drivers/usb/core/config.c	2004-07-20 13:03:49.000000000 +0530
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
diff -ruN -X dontdiff2 linux-2.6.7/drivers/usb/core/message.c kref-2.6.7/drivers/usb/core/message.c
--- linux-2.6.7/drivers/usb/core/message.c	2004-06-16 10:49:02.000000000 +0530
+++ kref-2.6.7/drivers/usb/core/message.c	2004-07-20 15:07:24.000000000 +0530
@@ -1077,11 +1077,12 @@
 
 static void release_interface(struct device *dev)
 {
+	extern void destroy_serial(struct kref *kref);
 	struct usb_interface *intf = to_usb_interface(dev);
 	struct usb_interface_cache *intfc =
 			altsetting_to_usb_interface_cache(intf->altsetting);
 
-	kref_put(&intfc->ref);
+	kref_put(&intfc->ref, destroy_serial);
 	kfree(intf);
 }
 
diff -ruN -X dontdiff2 linux-2.6.7/drivers/usb/core/urb.c kref-2.6.7/drivers/usb/core/urb.c
--- linux-2.6.7/drivers/usb/core/urb.c	2004-06-16 10:49:36.000000000 +0530
+++ kref-2.6.7/drivers/usb/core/urb.c	2004-07-20 13:03:49.000000000 +0530
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
diff -ruN -X dontdiff2 linux-2.6.7/drivers/usb/host/ehci-mem.c kref-2.6.7/drivers/usb/host/ehci-mem.c
--- linux-2.6.7/drivers/usb/host/ehci-mem.c	2004-06-16 10:50:03.000000000 +0530
+++ kref-2.6.7/drivers/usb/host/ehci-mem.c	2004-07-20 13:03:49.000000000 +0530
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
diff -ruN -X dontdiff2 linux-2.6.7/drivers/usb/serial/usb-serial.c kref-2.6.7/drivers/usb/serial/usb-serial.c
--- linux-2.6.7/drivers/usb/serial/usb-serial.c	2004-06-16 10:49:17.000000000 +0530
+++ kref-2.6.7/drivers/usb/serial/usb-serial.c	2004-07-20 15:07:52.000000000 +0530
@@ -443,6 +443,69 @@
 	return;
 }
 
+static void serial_shutdown (struct usb_serial *serial)
+{
+	dbg ("%s", __FUNCTION__);
+
+	serial->type->shutdown(serial);
+}
+
+void destroy_serial(struct kref *kref)
+{
+	struct usb_serial *serial;
+	struct usb_serial_port *port;
+	int i;
+
+	serial = to_usb_serial(kref);
+
+	dbg ("%s - %s", __FUNCTION__, serial->type->name);
+	serial_shutdown (serial);
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
@@ -487,7 +550,7 @@
 		if (retval) {
 			port->open_count = 0;
 			module_put(serial->type->owner);
-			kref_put(&serial->kref);
+			kref_put(&serial->kref, destroy_serial);
 		}
 	}
 bailout:
@@ -518,7 +581,7 @@
 	}
 
 	module_put(port->serial->type->owner);
-	kref_put(&port->serial->kref);
+	kref_put(&port->serial->kref, destroy_serial);
 }
 
 static int serial_write (struct tty_struct * tty, int from_user, const unsigned char *buf, int count)
@@ -676,13 +739,6 @@
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
@@ -716,7 +772,7 @@
 			begin += length;
 			length = 0;
 		}
-		kref_put(&serial->kref);
+		kref_put(&serial->kref, destroy_serial);
 	}
 	*eof = 1;
 done:
@@ -785,62 +841,6 @@
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
@@ -881,7 +881,7 @@
 	serial->interface = interface;
 	serial->vendor = dev->descriptor.idVendor;
 	serial->product = dev->descriptor.idProduct;
-	kref_init(&serial->kref, destroy_serial);
+	kref_init(&serial->kref);
 
 	return serial;
 }
@@ -1231,7 +1231,7 @@
 	if (serial) {
 		/* let the last holder of this object 
 		 * cause it to be cleaned up */
-		kref_put(&serial->kref);
+		kref_put(&serial->kref, destroy_serial);
 	}
 	dev_info(dev, "device disconnected\n");
 }
