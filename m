Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261416AbSJAAeM>; Mon, 30 Sep 2002 20:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261425AbSJAAdj>; Mon, 30 Sep 2002 20:33:39 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:5894 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261416AbSJAAcd>;
	Mon, 30 Sep 2002 20:32:33 -0400
Date: Mon, 30 Sep 2002 17:35:41 -0700
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] USB changes for 2.5.39
Message-ID: <20021001003541.GH3994@kroah.com>
References: <20021001003104.GA3994@kroah.com> <20021001003240.GB3994@kroah.com> <20021001003304.GC3994@kroah.com> <20021001003401.GD3994@kroah.com> <20021001003440.GE3994@kroah.com> <20021001003456.GF3994@kroah.com> <20021001003512.GG3994@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021001003512.GG3994@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.660.1.6 -> 1.660.1.7
#	drivers/usb/host/ohci-hcd.c	1.27    -> 1.28   
#	include/linux/usbdevice_fs.h	1.6     -> 1.7    
#	drivers/usb/core/message.c	1.7     -> 1.8    
#	 include/linux/usb.h	1.49    -> 1.50   
#	drivers/usb/core/hub.c	1.36    -> 1.37   
#	drivers/usb/core/devio.c	1.34    -> 1.35   
#	drivers/usb/core/usb.c	1.90    -> 1.91   
#	drivers/usb/core/hcd.c	1.34    -> 1.35   
#	drivers/usb/core/urb.c	1.6     -> 1.7    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/30	david-b@pacbell.net	1.660.1.7
# [PATCH] usbcore misc cleanup
# 
# This has minor usbcore cleanups:
# 
# DOC:
#     - the changes passing a usb_interface to driver probe() and disconnect()
#       weren't reflected in their adjacent docs.  likewise they still said
#       it was possible to get a null usb_device_id (no more).
# 
#     - the (root) hub API restrictions from rmk's ARM patch weren't
#       flagged
# 
#     - mention the non-dma-coherent cache issue for usb_buffer_alloc()
# 
#     - mention disconnect() cleanup issue with usb_{control,bulk}_msg()
#       [ you can't cancel those urbs from disconnect() ]
# 
# CODE
#     - make driver ioctl() use 'usb_interface' too ... this update
#       also resolves an old 'one instance per device' bad assumption
# 
#     - module locking on driver->ioctl() was goofy, kept BKL way too
#       long and didn't try_inc_mod_count() like the rest of usbcore
# 
#     - hcd unlink code treated iso inappropriately like interrupt;
#       only interrupt still wants that automagic mode
# 
#     - move iso init out of ohci into shared submit_urb logic
# 
#     - remove interrupt transfer length restriction; hcds that don't
#       handle packetization (just like bulk :) should be updated,
#       but device drivers won't care for now.
# --------------------------------------------
#
diff -Nru a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
--- a/drivers/usb/core/devio.c	Mon Sep 30 17:25:04 2002
+++ b/drivers/usb/core/devio.c	Mon Sep 30 17:25:04 2002
@@ -1067,6 +1067,10 @@
        /* disconnect kernel driver from interface, leaving it unbound.  */
        case USBDEVFS_DISCONNECT:
 		/* this function is voodoo. */
+		/* which function ... usb_device_remove()?
+		 * FIXME either the module lock (BKL) should be involved
+		 * here too, or the 'default' case below is broken
+		 */
 		driver = ifp->driver;
 		if (driver) {
 			dbg ("disconnect '%s' from dev %d interface %d",
@@ -1081,26 +1085,28 @@
 		retval = usb_device_probe (&ifp->dev);
 		break;
 
-       /* talk directly to the interface's driver */
-       default:
-		lock_kernel(); /* against module unload */
-               driver = ifp->driver;
-               if (driver == 0 || driver->ioctl == 0) {
+	/* talk directly to the interface's driver */
+	default:
+		/* BKL used here to protect against changing the binding
+		 * of this driver to this device, as well as unloading its
+		 * driver module.
+		 */
+		lock_kernel ();
+		driver = ifp->driver;
+		if (driver == 0 || driver->ioctl == 0) {
 			unlock_kernel();
 			retval = -ENOSYS;
 		} else {
-			if (ifp->driver->owner) {
-				__MOD_INC_USE_COUNT(ifp->driver->owner);
-				unlock_kernel();
-			}
-			/* ifno might usefully be passed ... */
-                       retval = driver->ioctl (ps->dev, ctrl.ioctl_code, buf);
-			/* size = min_t(int, size, retval)? */
-			if (ifp->driver->owner) {
-				__MOD_DEC_USE_COUNT(ifp->driver->owner);
-			} else {
+			if (driver->owner
+					&& !try_inc_mod_count (driver->owner)) {
 				unlock_kernel();
+				retval = -ENOSYS;
+				break;
 			}
+			unlock_kernel ();
+			retval = driver->ioctl (ifp, ctrl.ioctl_code, buf);
+			if (driver->owner)
+				__MOD_DEC_USE_COUNT (driver->owner);
 		}
 		
 		if (retval == -ENOIOCTLCMD)
diff -Nru a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
--- a/drivers/usb/core/hcd.c	Mon Sep 30 17:25:04 2002
+++ b/drivers/usb/core/hcd.c	Mon Sep 30 17:25:04 2002
@@ -1024,6 +1024,11 @@
 	 */
 	urb = usb_get_urb (urb);
 	if (urb->dev == hcd->self.root_hub) {
+		/* NOTE:  requirement on hub callers (usbfs and the hub
+		 * driver, for now) that URBs' urb->transfer_buffer be
+		 * valid and usb_buffer_{sync,unmap}() not be needed, since
+		 * they could clobber root hub response data.
+		 */
 		urb->transfer_flags |= URB_NO_DMA_MAP;
 		return rh_urb_enqueue (hcd, urb);
 	}
@@ -1132,11 +1137,11 @@
 		goto done;
 	}
 
-	/* For non-periodic transfers, any status except -EINPROGRESS means
-	 * the HCD has already started to unlink this URB from the hardware.
-	 * In that case, there's no more work to do.
+	/* Except for interrupt transfers, any status except -EINPROGRESS
+	 * means the HCD already started to unlink this URB from the hardware.
+	 * So there's no more work to do.
 	 *
-	 * For periodic transfers, this is the only way to trigger unlinking
+	 * For interrupt transfers, this is the only way to trigger unlinking
 	 * from the hardware.  Since we (currently) overload urb->status to
 	 * tell the driver to unlink, error status might get clobbered ...
 	 * unless that transfer hasn't yet restarted.  One such case is when
@@ -1144,13 +1149,10 @@
 	 *
 	 * FIXME use an URB_UNLINKED flag to match URB_TIMEOUT_KILLED
 	 */
-	switch (usb_pipetype (urb->pipe)) {
-	case PIPE_CONTROL:
-	case PIPE_BULK:
-		if (urb->status != -EINPROGRESS) {
-			retval = -EINVAL;
-			goto done;
-		}
+	if (urb->status != -EINPROGRESS
+			&& usb_pipetype (urb->pipe) != PIPE_INTERRUPT) {
+		retval = -EINVAL;
+		goto done;
 	}
 
 	/* maybe set up to block on completion notification */
diff -Nru a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
--- a/drivers/usb/core/hub.c	Mon Sep 30 17:25:04 2002
+++ b/drivers/usb/core/hub.c	Mon Sep 30 17:25:04 2002
@@ -547,8 +547,11 @@
 	return -ENODEV;
 }
 
-static int hub_ioctl(struct usb_device *hub, unsigned int code, void *user_data)
+static int
+hub_ioctl(struct usb_interface *intf, unsigned int code, void *user_data)
 {
+	struct usb_device *hub = interface_to_usbdev (intf);
+
 	/* assert ifno == 0 (part of hub spec) */
 	switch (code) {
 	case USBDEVFS_HUB_PORTINFO: {
diff -Nru a/drivers/usb/core/message.c b/drivers/usb/core/message.c
--- a/drivers/usb/core/message.c	Mon Sep 30 17:25:04 2002
+++ b/drivers/usb/core/message.c	Mon Sep 30 17:25:04 2002
@@ -123,6 +123,9 @@
  *	Don't use this function from within an interrupt context, like a
  *	bottom half handler.  If you need an asynchronous message, or need to send
  *	a message from within interrupt context, use usb_submit_urb()
+ *      If a thread in your driver uses this call, make sure your disconnect()
+ *      method can wait for it to complete.  Since you don't have a handle on
+ *      the URB used, you can't cancel the request.
  */
 int usb_control_msg(struct usb_device *dev, unsigned int pipe, __u8 request, __u8 requesttype,
 			 __u16 value, __u16 index, void *data, __u16 size, int timeout)
@@ -170,6 +173,9 @@
  *	Don't use this function from within an interrupt context, like a
  *	bottom half handler.  If you need an asynchronous message, or need to
  *	send a message from within interrupt context, use usb_submit_urb()
+ *      If a thread in your driver uses this call, make sure your disconnect()
+ *      method can wait for it to complete.  Since you don't have a handle on
+ *      the URB used, you can't cancel the request.
  */
 int usb_bulk_msg(struct usb_device *usb_dev, unsigned int pipe, 
 			void *data, int len, int *actual_length, int timeout)
diff -Nru a/drivers/usb/core/urb.c b/drivers/usb/core/urb.c
--- a/drivers/usb/core/urb.c	Mon Sep 30 17:25:04 2002
+++ b/drivers/usb/core/urb.c	Mon Sep 30 17:25:04 2002
@@ -232,22 +232,19 @@
 		return -EMSGSIZE;
 	}
 
-	/* "high bandwidth" mode, 1-3 packets/uframe? */
-	if (dev->speed == USB_SPEED_HIGH) {
-		int	mult;
-		switch (temp) {
-		case PIPE_ISOCHRONOUS:
-		case PIPE_INTERRUPT:
-			mult = 1 + ((max >> 11) & 0x03);
+	/* periodic transfers limit size per frame/uframe,
+	 * but drivers only control those sizes for ISO.
+	 * while we're checking, initialize return status.
+	 */
+	if (temp == PIPE_ISOCHRONOUS) {
+		int	n, len;
+
+		/* "high bandwidth" mode, 1-3 packets/uframe? */
+		if (dev->speed == USB_SPEED_HIGH) {
+			int	mult = 1 + ((max >> 11) & 0x03);
 			max &= 0x03ff;
 			max *= mult;
 		}
-	}
-
-	/* periodic transfers limit size per frame/uframe */
-	switch (temp) {
-	case PIPE_ISOCHRONOUS: {
-		int	n, len;
 
 		if (urb->number_of_packets <= 0)		    
 			return -EINVAL;
@@ -255,13 +252,9 @@
 			len = urb->iso_frame_desc [n].length;
 			if (len < 0 || len > max) 
 				return -EMSGSIZE;
+			urb->iso_frame_desc [n].status = -EXDEV;
+			urb->iso_frame_desc [n].actual_length = 0;
 		}
-
-		}
-		break;
-	case PIPE_INTERRUPT:
-		if (urb->transfer_buffer_length > max)
-			return -EMSGSIZE;
 	}
 
 	/* the I/O buffer must be mapped/unmapped, except when length=0 */
diff -Nru a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
--- a/drivers/usb/core/usb.c	Mon Sep 30 17:25:04 2002
+++ b/drivers/usb/core/usb.c	Mon Sep 30 17:25:04 2002
@@ -124,6 +124,8 @@
 	if (driver->owner) {
 		m = try_inc_mod_count(driver->owner);
 		if (m == 0) {
+			// FIXME this happens even when we just rmmod
+			// drivers that aren't in active use... 
 			err("Dieing driver still bound to device.\n");
 			return -EIO;
 		}
@@ -1096,6 +1098,8 @@
  * avoid behaviors like using "DMA bounce buffers", or tying down I/O mapping
  * hardware for long idle periods.  The implementation varies between
  * platforms, depending on details of how DMA will work to this device.
+ * Using these buffers also helps prevent cacheline sharing problems on
+ * architectures where CPU caches are not DMA-coherent.
  *
  * When the buffer is no longer used, free it with usb_buffer_free().
  */
diff -Nru a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
--- a/drivers/usb/host/ohci-hcd.c	Mon Sep 30 17:25:04 2002
+++ b/drivers/usb/host/ohci-hcd.c	Mon Sep 30 17:25:04 2002
@@ -193,12 +193,6 @@
 			break;
 		case PIPE_ISOCHRONOUS: /* number of packets from URB */
 			size = urb->number_of_packets;
-			if (size <= 0)
-				return -EINVAL;
-			for (i = 0; i < urb->number_of_packets; i++) {
-  				urb->iso_frame_desc [i].actual_length = 0;
-  				urb->iso_frame_desc [i].status = -EXDEV;
-  			}
 			break;
 	}
 
diff -Nru a/include/linux/usb.h b/include/linux/usb.h
--- a/include/linux/usb.h	Mon Sep 30 17:25:04 2002
+++ b/include/linux/usb.h	Mon Sep 30 17:25:04 2002
@@ -452,9 +452,9 @@
  * User mode code can read these tables to choose which modules to load.
  * Declare the table as a MODULE_DEVICE_TABLE.
  *
- * The third probe() parameter will point to a matching entry from this
- * table.  (Null value reserved.)  Use the driver_data field for each
- * match to hold information tied to that match:  device quirks, etc.
+ * A probe() parameter will point to a matching entry from this table.
+ * Use the driver_info field for each match to hold information tied
+ * to that match:  device quirks, etc.
  *
  * Terminate the driver's table with an all-zeroes entry.
  * Use the flag values to control which fields are compared.
@@ -604,17 +604,14 @@
  * @name: The driver name should be unique among USB drivers,
  *	and should normally be the same as the module name.
  * @probe: Called to see if the driver is willing to manage a particular
- *	interface on a device.  The probe routine returns a handle that 
- *	will later be provided to disconnect(), or a null pointer to
- *	indicate that the driver will not handle the interface.
- *	The handle is normally a pointer to driver-specific data.
- *	If the probe() routine needs to access the interface
- *	structure itself, use usb_ifnum_to_if() to make sure it's using
- *	the right one.
+ *	interface on a device.  If it is, probe returns zero and uses
+ *	dev_set_drvdata() to associate driver-specific data with the
+ *	interface.  It may also use usb_set_interface() to specify the
+ *	appropriate altsetting.  If unwilling to manage the interface,
+ *	return a negative errno value.
  * @disconnect: Called when the interface is no longer accessible, usually
- *	because its device has been (or is being) disconnected.  The
- *	handle passed is what was returned by probe(), or was provided
- *	to usb_driver_claim_interface().
+ *	because its device has been (or is being) disconnected or the
+ *	driver module is being unloaded.
  * @ioctl: Used for drivers that want to talk to userspace through
  *	the "usbfs" filesystem.  This lets devices provide ways to
  *	expose information to user space regardless of where they
@@ -648,7 +645,7 @@
 
 	void (*disconnect) (struct usb_interface *intf);
 
-	int (*ioctl) (struct usb_device *dev, unsigned int code, void *buf);
+	int (*ioctl) (struct usb_interface *intf, unsigned int code, void *buf);
 
 	const struct usb_device_id *id_table;
 
diff -Nru a/include/linux/usbdevice_fs.h b/include/linux/usbdevice_fs.h
--- a/include/linux/usbdevice_fs.h	Mon Sep 30 17:25:04 2002
+++ b/include/linux/usbdevice_fs.h	Mon Sep 30 17:25:04 2002
@@ -108,7 +108,7 @@
 	struct usbdevfs_iso_packet_desc iso_frame_desc[0];
 };
 
-/* ioctls for talking to drivers in the usbcore module: */
+/* ioctls for talking directly to drivers */
 struct usbdevfs_ioctl {
 	int	ifno;		/* interface 0..N ; negative numbers reserved */
 	int	ioctl_code;	/* MUST encode size + direction of data so the
