Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261501AbSJHXR1>; Tue, 8 Oct 2002 19:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261493AbSJHXQv>; Tue, 8 Oct 2002 19:16:51 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:51465 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261490AbSJHXOw>;
	Tue, 8 Oct 2002 19:14:52 -0400
Date: Tue, 8 Oct 2002 16:16:47 -0700
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB and driver core changes for 2.5.41
Message-ID: <20021008231646.GC11337@kroah.com>
References: <20021008231511.GA11337@kroah.com> <20021008231557.GB11337@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021008231557.GB11337@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.573.92.13 -> 1.573.92.14
#	drivers/usb/misc/usbtest.c	1.1     -> 1.2    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/07	david-b@pacbell.net	1.573.92.14
# [PATCH] usbtest: mo'betta devices, control tests
# 
# This updates the usbtest driver:
# 
# - Supports more devices for the basic i/o tests,
#    using full speed ez-usb firmware (and usbtest
#    tweaks!) provided by Martin Diehl.
# 
# - Adds another test case, which issues control
#    messages to devices.  There will be further
#    updates in this area (control queueing, and
#    likely improving usbcore api coverage).
# 
# - Adds a "generic device" mode where vendor
#    (and optionally product) ids can be given as
#    module parameters.  Those devices can be used
#    for testing control traffic.
# --------------------------------------------
#
diff -Nru a/drivers/usb/misc/usbtest.c b/drivers/usb/misc/usbtest.c
--- a/drivers/usb/misc/usbtest.c	Tue Oct  8 15:53:50 2002
+++ b/drivers/usb/misc/usbtest.c	Tue Oct  8 15:53:50 2002
@@ -5,7 +5,6 @@
 #include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/module.h>
-//#include <linux/time.h>
 #include <asm/scatterlist.h>
 
 #if !defined (DEBUG) && defined (CONFIG_USB_DEBUG)
@@ -33,21 +32,43 @@
 
 /*-------------------------------------------------------------------------*/
 
+#define	GENERIC		/* let probe() bind using module params */
+
+/* Some devices that can be used for testing will have "real" drivers.
+ * Entries for those need to be enabled here by hand, after disabling
+ * that "real" driver.
+ */
+//#define	IBOT2		/* grab iBOT2 webcams */
+//#define	KEYSPAN_19Qi	/* grab un-renumerated serial adapter */
+
+/*-------------------------------------------------------------------------*/
+
+struct usbtest_info {
+	const char		*name;
+	u8			ep_in;		/* bulk/intr source */
+	u8			ep_out;		/* bulk/intr sink */
+	int			alt;
+};
+
 /* this is accessed only through usbfs ioctl calls.
  * one ioctl to issue a test ... no locking needed!!!
  * tests create other threads if they need them.
  * urbs and buffers are allocated dynamically,
  * and data generated deterministically.
  *
- * there's a minor complication on disconnect(), since
+ * there's a minor complication on rmmod, since
  * usbfs.disconnect() waits till our ioctl completes.
+ * unplug works fine since we'll see real i/o errors.
  */
 struct usbtest_dev {
 	struct usb_interface	*intf;
-	struct testdev_info	*info;
+	struct usbtest_info	*info;
 	char			id [32];
 	int			in_pipe;
 	int			out_pipe;
+
+#define TBUF_SIZE	256
+	u8			*buf;
 };
 
 static struct usb_device *testdev_to_usbdev (struct usbtest_dev *test)
@@ -90,6 +111,8 @@
 			? (INTERRUPT_RATE << 3)
 			: INTERRUPT_RATE,
 	urb->transfer_flags = URB_NO_DMA_MAP;
+	if (usb_pipein (pipe))
+		urb->transfer_flags |= URB_SHORT_NOT_OK;
 	urb->transfer_buffer = usb_buffer_alloc (udev, bytes, SLAB_KERNEL,
 			&urb->transfer_dma);
 	if (!urb->transfer_buffer) {
@@ -247,6 +270,279 @@
 
 /*-------------------------------------------------------------------------*/
 
+/* unqueued control message testing
+ *
+ * there's a nice set of device functional requirements in chapter 9 of the
+ * usb 2.0 spec, which we can apply to ANY device, even ones that don't use
+ * special test firmware.
+ *
+ * we know the device is configured (or suspended) by the time it's visible
+ * through usbfs.  we can't change that, so we won't test enumeration (which
+ * worked 'well enough' to get here, this time), power management (ditto),
+ * or remote wakeup (which needs human interaction).
+ */
+
+static int get_altsetting (struct usbtest_dev *dev)
+{
+	struct usb_interface	*iface = dev->intf;
+	struct usb_device	*udev = interface_to_usbdev (iface);
+	int			retval;
+
+	retval = usb_control_msg (udev, usb_rcvctrlpipe (udev, 0),
+			USB_REQ_GET_INTERFACE, USB_DIR_IN|USB_RECIP_INTERFACE,
+			0, iface->altsetting [0].bInterfaceNumber,
+			dev->buf, 1, HZ * USB_CTRL_GET_TIMEOUT);
+	switch (retval) {
+	case 1:
+		return dev->buf [0];
+	case 0:
+		retval = -ERANGE;
+		// FALLTHROUGH
+	default:
+		return retval;
+	}
+}
+
+/* this is usb_set_interface(), with no 'only one altsetting' case */
+static int set_altsetting (struct usbtest_dev *dev, int alternate)
+{
+	struct usb_interface		*iface = dev->intf;
+	struct usb_device		*udev;
+	struct usb_interface_descriptor	*iface_as;
+	int				i, ret;
+
+	if (alternate < 0 || alternate >= iface->num_altsetting)
+		return -EINVAL;
+
+	udev = interface_to_usbdev (iface);
+	if ((ret = usb_control_msg (udev, usb_sndctrlpipe (udev, 0),
+			USB_REQ_SET_INTERFACE, USB_RECIP_INTERFACE,
+			iface->altsetting [alternate].bAlternateSetting,
+			iface->altsetting [alternate].bInterfaceNumber,
+			NULL, 0, HZ * USB_CTRL_SET_TIMEOUT)) < 0)
+		return ret;
+
+	// FIXME usbcore should be more like this:
+	// - remove that special casing in usbcore.
+	// - fix usbcore signature to take interface
+
+	/* prevent requests using previous endpoint settings */
+	iface_as = iface->altsetting + iface->act_altsetting;
+	for (i = 0; i < iface_as->bNumEndpoints; i++) {
+		u8	ep = iface_as->endpoint [i].bEndpointAddress;
+		int	out = !(ep & USB_DIR_IN);
+
+		ep &= USB_ENDPOINT_NUMBER_MASK;
+		(out ? udev->epmaxpacketout : udev->epmaxpacketin ) [ep] = 0;
+		// FIXME want hcd hook here, "forget this endpoint"
+	}
+	iface->act_altsetting = alternate;
+
+	/* reset toggles and maxpacket for all endpoints affected */
+	iface_as = iface->altsetting + iface->act_altsetting;
+	for (i = 0; i < iface_as->bNumEndpoints; i++) {
+		u8	ep = iface_as->endpoint [i].bEndpointAddress;
+		int	out = !(ep & USB_DIR_IN);
+
+		ep &= USB_ENDPOINT_NUMBER_MASK;
+		usb_settoggle (udev, ep, out, 0);
+		(out ? udev->epmaxpacketout : udev->epmaxpacketin ) [ep]
+			= iface_as->endpoint [ep].wMaxPacketSize;
+	}
+
+	return 0;
+}
+
+static int is_good_config (char *buf, int len)
+{
+	struct usb_config_descriptor	*config;
+	
+	if (len < sizeof *config)
+		return 0;
+	config = (struct usb_config_descriptor *) buf;
+
+	switch (config->bDescriptorType) {
+	case USB_DT_CONFIG:
+	case USB_DT_OTHER_SPEED_CONFIG:
+		if (config->bLength != 9)
+			return 0;
+#if 0
+		/* this bit 'must be 1' but often isn't */
+		if (!(config->bmAttributes & 0x80)) {
+			dbg ("high bit of config attributes not set");
+			return 0;
+		}
+#endif
+		if (config->bmAttributes & 0x1f)	/* reserved == 0 */
+			return 0;
+		break;
+	default:
+		return 0;
+	}
+
+	le32_to_cpus (&config->wTotalLength);
+	if (config->wTotalLength == len)		/* read it all */
+		return 1;
+	return config->wTotalLength >= TBUF_SIZE;	/* max partial read */
+}
+
+/* sanity test for standard requests working with usb_control_mesg() and some
+ * of the utility functions which use it.
+ *
+ * this doesn't test how endpoint halts behave or data toggles get set, since
+ * we won't do I/O to bulk/interrupt endpoints here (which is how to change
+ * halt or toggle).  toggle testing is impractical without support from hcds.
+ *
+ * this avoids failing devices linux would normally work with, by not testing
+ * config/altsetting operations for devices that only support their defaults.
+ * such devices rarely support those needless operations.
+ *
+ * NOTE that since this is a sanity test, it's not examining boundary cases
+ * to see if usbcore, hcd, and device all behave right.  such testing would
+ * involve varied read sizes and other operation sequences.
+ */
+static int ch9_postconfig (struct usbtest_dev *dev)
+{
+	struct usb_interface	*iface = dev->intf;
+	struct usb_device	*udev = interface_to_usbdev (iface);
+	int			i, retval;
+
+	/* [9.2.3] if there's more than one altsetting, we need to be able to
+	 * set and get each one.  mostly trusts the descriptors from usbcore.
+	 */
+	for (i = 0; i < iface->num_altsetting; i++) {
+
+		/* 9.2.3 constrains the range here, and Linux ensures
+		 * they're ordered meaningfully in this array
+		 */
+		if (iface->altsetting [i].bAlternateSetting != i) {
+			dbg ("%s, illegal alt [%d].bAltSetting = %d",
+					dev->id, i, 
+					iface->altsetting [i]
+						.bAlternateSetting);
+			return -EDOM;
+		}
+
+		/* [real world] get/set unimplemented if there's only one */
+		if (iface->num_altsetting == 1)
+			continue;
+
+		/* [9.4.10] set_interface */
+		retval = set_altsetting (dev, i);
+		if (retval) {
+			dbg ("%s can't set_interface = %d, %d",
+					dev->id, i, retval);
+			return retval;
+		}
+
+		/* [9.4.4] get_interface always works */
+		retval = get_altsetting (dev);
+		if (retval != i) {
+			dbg ("%s get alt should be %d, was %d",
+					dev->id, i, retval);
+			return (retval < 0) ? retval : -EDOM;
+		}
+
+	}
+
+	/* [real world] get_config unimplemented if there's only one */
+	if (udev->descriptor.bNumConfigurations != 1) {
+		int	expected = udev->actconfig->bConfigurationValue;
+
+		/* [9.4.2] get_configuration always works */
+		retval = usb_control_msg (udev, usb_rcvctrlpipe (udev, 0),
+				USB_REQ_GET_CONFIGURATION, USB_RECIP_DEVICE,
+				0, 0, dev->buf, 1, HZ * USB_CTRL_GET_TIMEOUT);
+		if (retval != 1 || dev->buf [0] != expected) {
+			dbg ("%s get config --> %d (%d)", dev->id, retval,
+				expected);
+			return (retval < 0) ? retval : -EDOM;
+		}
+	}
+
+	/* there's always [9.4.3] a device descriptor [9.6.1] */
+	retval = usb_get_descriptor (udev, USB_DT_DEVICE, 0,
+			dev->buf, sizeof udev->descriptor);
+	if (retval != sizeof udev->descriptor) {
+		dbg ("%s dev descriptor --> %d", dev->id, retval);
+		return (retval < 0) ? retval : -EDOM;
+	}
+
+	/* there's always [9.4.3] at least one config descriptor [9.6.3] */
+	for (i = 0; i < udev->descriptor.bNumConfigurations; i++) {
+		retval = usb_get_descriptor (udev, USB_DT_CONFIG, i,
+				dev->buf, TBUF_SIZE);
+		if (!is_good_config (dev->buf, retval)) {
+			dbg ("%s config [%d] descriptor --> %d",
+					dev->id, i, retval);
+			return (retval < 0) ? retval : -EDOM;
+		}
+
+		// FIXME cross-checking udev->config[i] to make sure usbcore
+		// parsed it right (etc) would be good testing paranoia
+	}
+
+	/* and sometimes [9.2.6.6] speed dependent descriptors */
+	if (udev->descriptor.bcdUSB == 0x0200) {	/* pre-swapped */
+		struct usb_qualifier_descriptor		*d = 0;
+
+		/* device qualifier [9.6.2] */
+		retval = usb_get_descriptor (udev,
+				USB_DT_DEVICE_QUALIFIER, 0, dev->buf,
+				sizeof (struct usb_qualifier_descriptor));
+		if (retval == -EPIPE) {
+			if (udev->speed == USB_SPEED_HIGH) {
+				dbg ("%s hs dev qualifier --> %d",
+						dev->id, retval);
+				return (retval < 0) ? retval : -EDOM;
+			}
+			/* usb2.0 but not high-speed capable; fine */
+		} else if (retval != sizeof (struct usb_qualifier_descriptor)) {
+			dbg ("%s dev qualifier --> %d", dev->id, retval);
+			return (retval < 0) ? retval : -EDOM;
+		} else
+			d = (struct usb_qualifier_descriptor *) dev->buf;
+
+		/* might not have [9.6.2] any other-speed configs [9.6.4] */
+		if (d) {
+			unsigned max = d->bNumConfigurations;
+			for (i = 0; i < max; i++) {
+				retval = usb_get_descriptor (udev,
+					USB_DT_OTHER_SPEED_CONFIG, i,
+					dev->buf, TBUF_SIZE);
+				if (!is_good_config (dev->buf, retval)) {
+					dbg ("%s other speed config --> %d",
+							dev->id, retval);
+					return (retval < 0) ? retval : -EDOM;
+				}
+			}
+		}
+	}
+	// FIXME fetch strings from at least the device descriptor
+
+	/* [9.4.5] get_status always works */
+	retval = usb_get_status (udev, USB_RECIP_DEVICE, 0, dev->buf);
+	if (retval != 2) {
+		dbg ("%s get dev status --> %d", dev->id, retval);
+		return (retval < 0) ? retval : -EDOM;
+	}
+
+	// FIXME configuration.bmAttributes says if we could try to set/clear
+	// the device's remote wakeup feature ... if we can, test that here
+
+	retval = usb_get_status (udev, USB_RECIP_INTERFACE,
+			iface->altsetting [0].bInterfaceNumber, dev->buf);
+	if (retval != 2) {
+		dbg ("%s get interface status --> %d", dev->id, retval);
+		return (retval < 0) ? retval : -EDOM;
+	}
+	// FIXME get status for each endpoint in the interface
+	
+	return 0;
+}
+
+/*-------------------------------------------------------------------------*/
+
 /* We only have this one interface to user space, through usbfs.
  * User mode code can scan usbfs to find N different devices (maybe on
  * different busses) to use when testing, and allocate one thread per
@@ -270,6 +566,7 @@
 	struct scatterlist	*sg;
 	struct usb_sg_request	req;
 	struct timeval		start;
+	unsigned		i;
 
 	// FIXME USBDEVFS_CONNECTINFO doesn't say how fast the device is.
 
@@ -280,6 +577,23 @@
 			|| param->sglen < 0 || param->vary < 0)
 		return -EINVAL;
 
+	/* some devices, like ez-usb default devices, need a non-default
+	 * altsetting to have any active endpoints.  some tests change
+	 * altsettings; force a default so most tests don't need to check.
+	 */
+	if (dev->info->alt >= 0) {
+	    	int	res;
+
+		if (intf->altsetting->bInterfaceNumber)
+			return -ENODEV;
+		res = set_altsetting (dev, dev->info->alt);
+		if (res) {
+			err ("%s: set altsetting to %d failed, %d",
+					dev->id, dev->info->alt, res);
+			return res;
+		}
+	}
+
 	/*
 	 * Just a bunch of test cases that every HCD is expected to handle.
 	 *
@@ -287,7 +601,7 @@
 	 * one firmware image to handle all the test cases.
 	 *
 	 * FIXME add more tests!  cancel requests, verify the data, control
-	 * requests, and so on.
+	 * queueing, concurrent read+write threads, and so on.
 	 */
 	do_gettimeofday (&start);
 	switch (param->test_num) {
@@ -343,7 +657,7 @@
 	case 4:
 		if (dev->in_pipe == 0 || param->vary == 0)
 			break;
-		dbg ("%s TEST 3:  read/%d 0..%d bytes %u times", dev->id,
+		dbg ("%s TEST 4:  read/%d 0..%d bytes %u times", dev->id,
 				param->vary, param->length, param->iterations);
 		urb = simple_alloc_urb (udev, dev->out_pipe, param->length);
 		if (!urb) {
@@ -422,6 +736,17 @@
 		free_sglist (sg, param->sglen);
 		break;
 
+	/* non-queued sanity tests for control (chapter 9 subset) */
+	case 9:
+		retval = 0;
+		dbg ("%s TEST 9:  ch9 (subset) control tests, %d times",
+				dev->id, param->iterations);
+		for (i = param->iterations; retval == 0 && i--; /* NOP */)
+			retval = ch9_postconfig (dev);
+		if (retval)
+			dbg ("ch9 subset failed, iterations left %d", i);
+		break;
+
 	/* test cases for the unlink/cancel codepaths need a thread to
 	 * usb_unlink_urb() or usg_sg_cancel(), and a way to check if
 	 * the urb/sg_request was properly canceled.
@@ -443,48 +768,77 @@
 
 /*-------------------------------------------------------------------------*/
 
-/* most programmable USB devices can be given firmware that will support the
- * test cases above.  one basic question is which endpoints to use for
- * testing; endpoint numbers are not always firmware-selectable.
- *
- * for now, the driver_info in the device_id table entry just encodes the
- * endpoint info for a pair of bulk-capable endpoints, which we can use
- * for some interrupt transfer tests too.  later this could get fancier.
- */
-#define EP_PAIR(in,out) (((in)<<4)|(out))
-
 static int force_interrupt = 0;
 MODULE_PARM (force_interrupt, "i");
 MODULE_PARM_DESC (force_interrupt, "0 = test bulk (default), else interrupt");
 
+#ifdef	GENERIC
+static int vendor;
+MODULE_PARM (vendor, "h");
+MODULE_PARM_DESC (vendor, "vendor code (from usb-if)");
+
+static int product;
+MODULE_PARM (product, "h");
+MODULE_PARM_DESC (product, "product code (from vendor)");
+#endif
+
 static int
 usbtest_probe (struct usb_interface *intf, const struct usb_device_id *id)
 {
 	struct usb_device	*udev;
 	struct usbtest_dev	*dev;
-	unsigned long		driver_info = id->driver_info;
+	struct usbtest_info	*info;
+	char			*rtest, *wtest;
 
 	udev = interface_to_usbdev (intf);
 
+#ifdef	GENERIC
+	/* specify devices by module parameters? */
+	if (id->match_flags == 0) {
+		/* vendor match required, product match optional */
+		if (!vendor || udev->descriptor.idVendor != (u16)vendor)
+			return -ENODEV;
+		if (product && udev->descriptor.idProduct != (u16)product)
+			return -ENODEV;
+		dbg ("matched module params, vend=0x%04x prod=0x%04x",
+				udev->descriptor.idVendor,
+				udev->descriptor.idProduct);
+	}
+#endif
+
 	dev = kmalloc (sizeof *dev, SLAB_KERNEL);
 	if (!dev)
 		return -ENOMEM;
 	memset (dev, 0, sizeof *dev);
-	snprintf (dev->id, sizeof dev->id, "%s-%s",
-			udev->bus->bus_name, udev->devpath);
+	info = (struct usbtest_info *) id->driver_info;
+	dev->info = info;
+
+	/* use the same kind of id the hid driver shows */
+	snprintf (dev->id, sizeof dev->id, "%s-%s:%d",
+			udev->bus->bus_name, udev->devpath,
+			intf->altsetting [0].bInterfaceNumber);
 	dev->intf = intf;
 
+	/* cacheline-aligned scratch for i/o */
+	if ((dev->buf = kmalloc (TBUF_SIZE, SLAB_KERNEL)) == 0) {
+		kfree (dev);
+		return -ENOMEM;
+	}
+
 	/* NOTE this doesn't yet test the handful of difference that are
-	 * visible with high speed devices:  bigger maxpacket (1K) and
+	 * visible with high speed interrupts:  bigger maxpacket (1K) and
 	 * "high bandwidth" modes (up to 3 packets/uframe).
 	 */
+	rtest = wtest = "";
 	if (force_interrupt || udev->speed == USB_SPEED_LOW) {
-		if (driver_info & 0xf0)
-			dev->in_pipe = usb_rcvintpipe (udev,
-				(driver_info >> 4) & 0x0f);
-		if (driver_info & 0x0f)
-			dev->out_pipe = usb_sndintpipe (udev,
-				driver_info & 0x0f);
+		if (info->ep_in) {
+			dev->in_pipe = usb_rcvintpipe (udev, info->ep_in);
+			rtest = " intr-in";
+		}
+		if (info->ep_out) {
+			dev->out_pipe = usb_sndintpipe (udev, info->ep_out);
+			wtest = " intr-out";
+		}
 
 #if 1
 		// FIXME disabling this until we finally get rid of
@@ -494,18 +848,26 @@
 		return -ENODEV;
 #endif
 	} else {
-		if (driver_info & 0xf0)
-			dev->in_pipe = usb_rcvbulkpipe (udev,
-				(driver_info >> 4) & 0x0f);
-		if (driver_info & 0x0f)
-			dev->out_pipe = usb_sndbulkpipe (udev,
-				driver_info & 0x0f);
+		if (info->ep_in) {
+			dev->in_pipe = usb_rcvbulkpipe (udev, info->ep_in);
+			rtest = " bulk-in";
+		}
+		if (info->ep_out) {
+			dev->out_pipe = usb_sndbulkpipe (udev, info->ep_out);
+			wtest = " bulk-out";
+		}
 	}
 
 	dev_set_drvdata (&intf->dev, dev);
-	info ("bound to %s ...%s%s", dev->id,
-			dev->out_pipe ? " writes" : "",
-			dev->in_pipe ? " reads" : "");
+	info ("%s at %s ... %s speed {control%s%s} tests",
+			info->name, dev->id,
+			({ char *tmp;
+			switch (udev->speed) {
+			case USB_SPEED_LOW: tmp = "low"; break;
+			case USB_SPEED_FULL: tmp = "full"; break;
+			case USB_SPEED_HIGH: tmp = "high"; break;
+			default: tmp = "unknown"; break;
+			}; tmp; }), rtest, wtest);
 	return 0;
 }
 
@@ -519,24 +881,113 @@
 }
 
 /* Basic testing only needs a device that can source or sink bulk traffic.
+ * Any device can test control transfers (default with GENERIC binding).
+ *
+ * Several entries work with the default EP0 implementation that's built
+ * into EZ-USB chips.  There's a default vendor ID which can be overridden
+ * by (very) small config EEPROMS, but otherwise all these devices act
+ * identically until firmware is loaded:  only EP0 works.  It turns out
+ * to be easy to make other endpoints work, without modifying that EP0
+ * behavior.  For now, we expect that kind of firmware.
  */
+
+/* an21xx or fx versions of ez-usb */
+static struct usbtest_info ez1_info = {
+	.name		= "EZ-USB device",
+	.ep_in		= 2,
+	.ep_out		= 2,
+	.alt		= 1,
+};
+
+/* fx2 version of ez-usb */
+static struct usbtest_info ez2_info = {
+	.name		= "FX2 device",
+	.ep_in		= 6,
+	.ep_out		= 2,
+	.alt		= 1,
+};
+
+#ifdef IBOT2
+/* this is a nice source of high speed bulk data;
+ * uses an FX2, with firmware provided in the device
+ */
+static struct usbtest_info ibot2_info = {
+	.name		= "iBOT2 webcam",
+	.ep_in		= 2,
+	.alt		= -1,
+};
+#endif
+
+#ifdef GENERIC
+/* we can use any device to test control traffic */
+static struct usbtest_info generic_info = {
+	.name		= "Generic USB device",
+	.alt		= -1,
+};
+#endif
+
+// FIXME remove this 
+static struct usbtest_info hact_info = {
+	.name		= "FX2/hact",
+	//.ep_in		= 6,
+	.ep_out		= 2,
+	.alt		= -1,
+};
+
+
 static struct usb_device_id id_table [] = {
 
-	/* EZ-USB FX2 "bulksrc" or "bulkloop" firmware from Cypress
-	 * reads disabled on this one, my version has some problem there
-	 */
 	{ USB_DEVICE (0x0547, 0x1002),
-		.driver_info = EP_PAIR (0, 2),
+		.driver_info = (unsigned long) &hact_info,
 		},
-#if 1
+
+	/*-------------------------------------------------------------*/
+
+	/* EZ-USB devices which download firmware to replace (or in our
+	 * case augment) the default device implementation.
+	 */
+
+	/* generic EZ-USB FX controller */
+	{ USB_DEVICE (0x0547, 0x2235),
+		.driver_info = (unsigned long) &ez1_info,
+		},
+
+	/* CY3671 development board with EZ-USB FX */
+	{ USB_DEVICE (0x0547, 0x0080),
+		.driver_info = (unsigned long) &ez1_info,
+		},
+
+	/* generic EZ-USB FX2 controller (or development board) */
+	{ USB_DEVICE (0x04b4, 0x8613),
+		.driver_info = (unsigned long) &ez2_info,
+		},
+
+#ifdef KEYSPAN_19Qi
+	/* Keyspan 19qi uses an21xx (original EZ-USB) */
+	// this does not coexist with the real Keyspan 19qi driver!
+	{ USB_DEVICE (0x06cd, 0x010b),
+		.driver_info = (unsigned long) &ez1_info,
+		},
+#endif
+
+	/*-------------------------------------------------------------*/
+
+#ifdef IBOT2
+	/* iBOT2 makes a nice source of high speed bulk-in data */
 	// this does not coexist with a real iBOT2 driver!
-	// it makes a nice source of high speed bulk-in data
 	{ USB_DEVICE (0x0b62, 0x0059),
-		.driver_info = EP_PAIR (2, 0),
+		.driver_info = (unsigned long) &ibot2_info,
 		},
 #endif
 
-	/* can that old "usbstress-0.3" firmware be used with this? */
+	/*-------------------------------------------------------------*/
+
+#ifdef GENERIC
+	/* module params can specify devices to use for control tests */
+	{ .driver_info = (unsigned long) &generic_info, },
+#endif
+
+	/*-------------------------------------------------------------*/
 
 	{ }
 };
@@ -555,6 +1006,10 @@
 
 static int __init usbtest_init (void)
 {
+#ifdef GENERIC
+	if (vendor)
+		dbg ("params: vend=0x%04x prod=0x%04x", vendor, product);
+#endif
 	return usb_register (&usbtest_driver);
 }
 module_init (usbtest_init);
@@ -565,6 +1020,6 @@
 }
 module_exit (usbtest_exit);
 
-MODULE_DESCRIPTION ("USB HCD Testing Driver");
+MODULE_DESCRIPTION ("USB Core/HCD Testing Driver");
 MODULE_LICENSE ("GPL");
 
