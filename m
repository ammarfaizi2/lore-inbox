Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262740AbVCJQuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262740AbVCJQuL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 11:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262747AbVCJQtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 11:49:19 -0500
Received: from styx.suse.cz ([82.119.242.94]:25048 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S262711AbVCJQq2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 11:46:28 -0500
Date: Thu, 10 Mar 2005 17:46:25 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Hans-Christian Egtvedt <hc@mivu.no>
Cc: linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] new driver for ITM Touch touchscreen
Message-ID: <20050310164625.GA30439@ucw.cz>
References: <1109932223.5453.16.camel@charlie.itk.ntnu.no> <200503041403.37137.adobriyan@mail.ru> <d120d50005030406525896b6cb@mail.gmail.com> <1109953224.3069.39.camel@charlie.itk.ntnu.no> <d120d50005030408544462c9ea@mail.gmail.com> <1110297660.3198.15.camel@server.customer.mivu.no> <20050310161825.GA28643@ucw.cz> <1110472902.3284.17.camel@server.customer.mivu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110472902.3284.17.camel@server.customer.mivu.no>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2005 at 05:41:42PM +0100, Hans-Christian Egtvedt wrote:
> On Thu, 2005-03-10 at 17:18 +0100, Vojtech Pavlik wrote:
> > On Tue, Mar 08, 2005 at 05:01:00PM +0100, Hans-Christian Egtvedt wrote:
> >  
> > > I really don't think the controller can now anything about the size of
> > > the screen.
> > > 
> > > I've attached version 1.2.1 of the driver, fixed some typo, code cleanup
> > > and discovered I used depricated functions so I moved to the new correct
> > > way of doing killing of the urb.
> > 
> > Pacth applied, with minor cleanups.
> 
> Could you send me your changes?
 
Here is the final patch:


ChangeSet@1.2017, 2005-03-10 17:17:56+01:00, hc@mivu.no
  input: Add driver for ITM Touch USB touchscreens.
  
  From: Hans-Christian Egtvedt <hc@mivu.no>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 Kconfig    |   12 ++
 Makefile   |    1 
 itmtouch.c |  281 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 294 insertions(+)


diff -Nru a/drivers/usb/input/Kconfig b/drivers/usb/input/Kconfig
--- a/drivers/usb/input/Kconfig	2005-03-10 17:45:56 +01:00
+++ b/drivers/usb/input/Kconfig	2005-03-10 17:45:56 +01:00
@@ -190,6 +190,18 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called mtouchusb.
 
+config USB_ITMTOUCH
+	tristate "ITM Touch USB Touchscreen Driver"
+	depends on USB && INPUT
+	---help---
+	  Say Y here if you want to use a ITM Touch USB
+	  Touchscreen controller.
+
+	  This touchscreen is used in LG 1510SF monitors.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called itmtouch.
+
 config USB_EGALAX
 	tristate "eGalax TouchKit USB Touchscreen Driver"
 	depends on USB && INPUT
diff -Nru a/drivers/usb/input/Makefile b/drivers/usb/input/Makefile
--- a/drivers/usb/input/Makefile	2005-03-10 17:45:56 +01:00
+++ b/drivers/usb/input/Makefile	2005-03-10 17:45:56 +01:00
@@ -33,6 +33,7 @@
 obj-$(CONFIG_USB_KBTAB)		+= kbtab.o
 obj-$(CONFIG_USB_MOUSE)		+= usbmouse.o
 obj-$(CONFIG_USB_MTOUCH)	+= mtouchusb.o
+obj-$(CONFIG_USB_ITMTOUCH)	+= itmtouch.o
 obj-$(CONFIG_USB_EGALAX)	+= touchkitusb.o
 obj-$(CONFIG_USB_POWERMATE)	+= powermate.o
 obj-$(CONFIG_USB_WACOM)		+= wacom.o
diff -Nru a/drivers/usb/input/itmtouch.c b/drivers/usb/input/itmtouch.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/usb/input/itmtouch.c	2005-03-10 17:45:56 +01:00
@@ -0,0 +1,281 @@
+/******************************************************************************
+ * itmtouch.c  --  Driver for ITM touchscreen panel
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Based upon original work by Chris Collins <xfire-itmtouch@xware.cx>.
+ *
+ * Kudos to ITM for providing me with the datasheet for the panel,
+ * even though it was a day later than I had finished writing this 
+ * driver.
+ * 
+ * It has meant that I've been able to correct my interpretation of the
+ * protocol packets however.
+ * 
+ * CC -- 2003/9/29
+ * 
+ * History
+ * 1.0 & 1.1  2003 (CC) vojtech@suse.cz
+ *   Original version for 2.4.x kernels
+ *
+ * 1.2  02/03/2005 (HCE) hc@mivu.no
+ *   Complete rewrite to support Linux 2.6.10, thanks to mtouchusb.c for hints.
+ *   Unfortunately no calibration support at this time.
+ * 
+ * 1.2.1  09/03/2005 (HCE) hc@mivu.no
+ *   Code cleanup and adjusting syntax to start matching kernel standards
+ * 
+ *****************************************************************************/
+
+#include <linux/config.h>
+
+#ifdef CONFIG_USB_DEBUG
+	#define DEBUG
+#else
+	#undef DEBUG
+#endif
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/input.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/usb.h>
+
+/* only an 8 byte buffer necessary for a single packet */
+#define ITM_BUFSIZE			8
+#define PATH_SIZE			64
+
+#define USB_VENDOR_ID_ITMINC		0x0403
+#define USB_PRODUCT_ID_TOUCHPANEL	0xf9e9
+
+#define DRIVER_AUTHOR "Hans-Christian Egtvedt <hc@mivu.no>"
+#define DRIVER_VERSION "v1.2.1"
+#define DRIVER_DESC "USB ITM Inc Touch Panel Driver"
+#define DRIVER_LICENSE "GPL"
+
+MODULE_AUTHOR( DRIVER_AUTHOR );
+MODULE_DESCRIPTION( DRIVER_DESC );
+MODULE_LICENSE( DRIVER_LICENSE );
+
+struct itmtouch_dev {
+	struct usb_device 	*usbdev; /* usb device */
+	struct input_dev	inputdev; /* input device */
+	struct urb		*readurb; /* urb */
+	char			rbuf[ITM_BUFSIZE]; /* data */
+	int			users;
+	char name[128];
+	char phys[64];
+};
+
+static struct usb_device_id itmtouch_ids [] = {
+	{ USB_DEVICE(USB_VENDOR_ID_ITMINC, USB_PRODUCT_ID_TOUCHPANEL) },
+	{ }
+};
+
+static void itmtouch_irq(struct urb *urb, struct pt_regs *regs)
+{
+	struct itmtouch_dev * itmtouch = urb->context;
+	unsigned char *data = urb->transfer_buffer;
+	struct input_dev *dev = &itmtouch->inputdev;
+	int retval;
+
+	switch (urb->status) {
+	case 0:
+		/* success */
+		break;
+	case -ETIMEDOUT:
+		/* this urb is timing out */
+		dbg("%s - urb timed out - was the device unplugged?",
+		    __FUNCTION__);
+		return;
+	case -ECONNRESET:
+	case -ENOENT:
+	case -ESHUTDOWN:
+		/* this urb is terminated, clean up */
+		dbg("%s - urb shutting down with status: %d",
+		    __FUNCTION__, urb->status);
+		return;
+	default:
+		dbg("%s - nonzero urb status received: %d",
+		    __FUNCTION__, urb->status);
+		goto exit;
+	}
+
+	input_regs(dev, regs);
+
+	/* if pressure has been released, then don't report X/Y */
+	if (data[7] & 0x20) {
+		input_report_abs(dev, ABS_X, (data[0] & 0x1F) << 7 | (data[3] & 0x7F));
+		input_report_abs(dev, ABS_Y, (data[1] & 0x1F) << 7 | (data[4] & 0x7F));
+	}
+	
+	input_report_abs(dev, ABS_PRESSURE, (data[2] & 1) << 7 | (data[5] & 0x7F));
+	input_report_key(dev, BTN_TOUCH, ~data[7] & 0x20);
+	input_sync(dev);
+
+exit:
+	retval = usb_submit_urb (urb, GFP_ATOMIC);
+	if (retval)
+		printk(KERN_ERR "%s - usb_submit_urb failed with result: %d",
+				__FUNCTION__, retval);
+}
+
+static int itmtouch_open(struct input_dev *input)
+{
+	struct itmtouch_dev *itmtouch = input->private;
+
+	if (itmtouch->users++)
+		return 0;
+
+	itmtouch->readurb->dev = itmtouch->usbdev;
+
+	if (usb_submit_urb(itmtouch->readurb, GFP_KERNEL))
+	{
+		itmtouch->users--;
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static void itmtouch_close(struct input_dev *input)
+{
+	struct itmtouch_dev *itmtouch = input->private;
+
+	if (!--itmtouch->users)
+		usb_kill_urb(itmtouch->readurb);
+}
+
+static int itmtouch_probe(struct usb_interface *intf, const struct usb_device_id *id)
+{
+	struct itmtouch_dev *itmtouch;
+	struct usb_host_interface *interface;
+	struct usb_endpoint_descriptor *endpoint;
+	struct usb_device *udev = interface_to_usbdev(intf);
+	unsigned int pipe;
+	unsigned int maxp;
+	char path[PATH_SIZE];
+
+	interface = intf->cur_altsetting;
+	endpoint = &interface->endpoint[0].desc;
+
+	if (!(itmtouch = kcalloc(1, sizeof(struct itmtouch_dev), GFP_KERNEL))) {
+		err("%s - Out of memory.", __FUNCTION__);
+		return -ENOMEM;
+	}
+
+	itmtouch->usbdev = udev;
+	
+	itmtouch->inputdev.private = itmtouch;
+	itmtouch->inputdev.open = itmtouch_open;
+	itmtouch->inputdev.close = itmtouch_close;
+
+	usb_make_path(udev, path, PATH_SIZE);
+	
+	itmtouch->inputdev.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
+	itmtouch->inputdev.absbit[0] = BIT(ABS_X) | BIT(ABS_Y) | BIT(ABS_PRESSURE);
+	itmtouch->inputdev.keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
+
+	itmtouch->inputdev.name = itmtouch->name;
+	itmtouch->inputdev.phys = itmtouch->phys;
+	itmtouch->inputdev.id.bustype = BUS_USB;
+	itmtouch->inputdev.id.vendor = udev->descriptor.idVendor;
+	itmtouch->inputdev.id.product = udev->descriptor.idProduct;
+	itmtouch->inputdev.id.version = udev->descriptor.bcdDevice;	
+	itmtouch->inputdev.dev = &intf->dev;
+
+	if (!strlen(itmtouch->name))
+		sprintf(itmtouch->name, "USB ITM touchscreen");
+	
+	/* device limits */
+	/* as specified by the ITM datasheet, X and Y are 12bit,
+	 * Z (pressure) is 8 bit. However, the fields are defined up
+	 * to 14 bits for future possible expansion.
+	 */
+	input_set_abs_params(&itmtouch->inputdev, ABS_X, 0, 0x0FFF, 2, 0);
+	input_set_abs_params(&itmtouch->inputdev, ABS_Y, 0, 0x0FFF, 2, 0);
+	input_set_abs_params(&itmtouch->inputdev, ABS_PRESSURE, 0, 0xFF, 2, 0);
+
+	/* initialise the URB so we can read from the transport stream */
+	pipe = usb_rcvintpipe(itmtouch->usbdev, endpoint->bEndpointAddress);
+	maxp = usb_maxpacket(udev, pipe, usb_pipeout(pipe));
+	
+	if (maxp > ITM_BUFSIZE)
+		maxp = ITM_BUFSIZE;
+
+	itmtouch->readurb = usb_alloc_urb(0, GFP_KERNEL);
+	
+	if (!itmtouch->readurb) {
+		dbg("%s - usb_alloc_urb failed: itmtouch->readurb", __FUNCTION__);
+		kfree(itmtouch);
+		return -ENOMEM;
+	}
+	
+	usb_fill_int_urb(itmtouch->readurb,
+			itmtouch->usbdev,
+			pipe,
+			itmtouch->rbuf, 
+			maxp,
+			itmtouch_irq,
+			itmtouch,
+			endpoint->bInterval);
+
+	input_register_device(&itmtouch->inputdev);
+
+	printk(KERN_INFO "itmtouch: %s registered on %s\n", itmtouch->name, path);
+	usb_set_intfdata(intf, itmtouch);
+
+	return 0;
+}
+
+static void itmtouch_disconnect(struct usb_interface *intf)
+{	
+	struct itmtouch_dev *itmtouch = usb_get_intfdata(intf);
+
+	usb_set_intfdata(intf, NULL);
+
+	if (itmtouch) {
+		input_unregister_device(&itmtouch->inputdev);
+		usb_kill_urb(itmtouch->readurb);
+		usb_free_urb(itmtouch->readurb);
+		kfree(itmtouch);
+	}
+}
+
+MODULE_DEVICE_TABLE(usb, itmtouch_ids);
+
+static struct usb_driver itmtouch_driver = {
+		.owner =        THIS_MODULE,
+		.name =         "itmtouch",
+		.probe =        itmtouch_probe,
+		.disconnect =   itmtouch_disconnect,
+		.id_table =     itmtouch_ids,
+};
+
+static int __init itmtouch_init(void)
+{
+	info(DRIVER_DESC " " DRIVER_VERSION);
+	info(DRIVER_AUTHOR);
+	return usb_register(&itmtouch_driver);
+}
+
+static void __exit itmtouch_exit(void)
+{
+	usb_deregister(&itmtouch_driver);
+}
+
+module_init(itmtouch_init);
+module_exit(itmtouch_exit);



-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
