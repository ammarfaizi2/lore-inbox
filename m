Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031759AbWLAUhZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031759AbWLAUhZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 15:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031765AbWLAUhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 15:37:25 -0500
Received: from wx-out-0506.google.com ([66.249.82.230]:3805 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1031759AbWLAUhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 15:37:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=s9U6wRkasDL6L5p3GQl8NmKDWskM/1hzni2s3OrStAjur0LltX4/EdNMQAl7S7EL2OurMgKsj5fhHnx7yrbWqZMD+ZLFz1CY8gcZpJ4fyKOdtauaknxE93YuZo7luySJRKbU6VjcKXVmDv+9v6rFV/Dv4YRy2TfqO6tBBqGUcJE=
Message-ID: <571a92f0612011237p35e00be5w832fafb3f824b97a@mail.gmail.com>
Date: Fri, 1 Dec 2006 13:37:22 -0700
From: "David Lopez" <dave.l.lopez@gmail.com>
To: greg@kroah.com
Subject: [PATCH] USB: add driver for LabJack USB DAQ devices
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Lopez <dave.l.lopez@gmail.com>

This driver adds support for LabJack U3 and UE9 USB DAQ devices.

Signed-off-by: David Lopez <dave.l.lopez@gmail.com>
---
Patch against stable 2.6.19 kernel.

 Kconfig  |   15 +
 Makefile |    1
 ljusb.c  |  584 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

diff -uprN -X linux-2.6.19-vanilla/Documentation/dontdiff
linux-2.6.19-vanilla/drivers/usb/misc/Kconfig
linux-2.6.19/drivers/usb/misc/Kconfig
--- linux-2.6.19-vanilla/drivers/usb/misc/Kconfig	2006-11-29
14:57:37.000000000 -0700
+++ linux-2.6.19/drivers/usb/misc/Kconfig	2006-11-30 16:13:05.000000000 -0700
@@ -233,6 +233,21 @@ config USB_TRANCEVIBRATOR
 	  To compile this driver as a module, choose M here: the
 	  module will be called trancevibrator.

+config USB_LJ
+	tristate "USB LabJack DAQ devices driver"
+	depends on USB
+	help
+	  USB driver for the following LabJack DAQ devices:
+	  - U3
+	  - UE9
+
+	  For a user-space API and usage examples, please visit the LabJack
+	  downloads web page at <http://www.labjack.com/downloads.php> and go
+	  to the specific device's downloads page.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ljusb.
+
 config USB_TEST
 	tristate "USB testing driver (DEVELOPMENT)"
 	depends on USB && USB_DEVICEFS && EXPERIMENTAL
diff -uprN -X linux-2.6.19-vanilla/Documentation/dontdiff
linux-2.6.19-vanilla/drivers/usb/misc/ljusb.c
linux-2.6.19/drivers/usb/misc/ljusb.c
--- linux-2.6.19-vanilla/drivers/usb/misc/ljusb.c	1969-12-31
17:00:00.000000000 -0700
+++ linux-2.6.19/drivers/usb/misc/ljusb.c	2006-12-01 13:14:33.000000000 -0700
@@ -0,0 +1,584 @@
+/*
+ * USB LabJack Data Acquisition Devices driver
+ *
+ * Copyright (C) 2006 LabJack Corporation
+ *
+ * Author: David Lopez <dave.l.lopez@gmail.com>
+ *
+ * Derived from the USB Skeleton driver 2.0.
+ *   Copyright (C) 2001-2004 Greg Kroah-Hartman (greg@kroah.com)
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License as
+ *	published by the Free Software Foundation, version 2.
+ *
+ * The following devices are currently supported:
+ *   - U3
+ *   - UE9
+ *
+ * For a user-space API and usage examples, please visit the
+ * LabJack downloads web page at
+ * <http://www.labjack.com/downloads.php> and go to the specific
+ * device's downloads page.
+ *
+ * History:
+ *   2006-12-01 - 0.10 dl
+ *     - Initial version with U3 and UE9 device support
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/kref.h>
+#include <asm/uaccess.h>
+#include <linux/usb.h>
+
+
+/* Version Information */
+#define DRIVER_VERSION "v0.10"
+#define DRIVER_DESC "USB LabJack DAQ Devices driver"
+
+#define USB_LJ_MINOR_BASE		192
+
+/* Vendor and Product IDs */
+#define USB_VENDOR_ID_LJ	0x0cd5
+#define USB_PRODUCT_ID_LJ_U3	0x0003
+#define USB_PRODUCT_ID_LJ_UE9	0x0009
+
+/* table of devices that work with this driver */
+static struct usb_device_id lj_usb_table [] = {
+	{ USB_DEVICE(USB_VENDOR_ID_LJ, USB_PRODUCT_ID_LJ_U3) },		/* U3 */
+	{ USB_DEVICE(USB_VENDOR_ID_LJ, USB_PRODUCT_ID_LJ_UE9) },	/* UE9 */
+	{ }					/* Terminating entry */
+};
+MODULE_DEVICE_TABLE (usb, lj_usb_table);
+
+/* IOCTL defines */
+#define IOCTL_LJ_SET_BULK_IN_TIMEOUT	0x1
+#define IOCTL_LJ_GET_PRODUCT_ID		0x2
+#define IOCTL_LJ_SET_BULK_IN_ENDPOINT	0x3
+
+/* Private defines */
+#define MAX_TRANSFER			( PAGE_SIZE - 512 )
+#define BULK_IN_TIMEOUT			1000	/* default bulk in read timeout */
+#define N_BULK_IN_ENDPOINTS		2	/* number of bulk in endpoints */
+#define N_BULK_OUT_ENDPOINTS		2	/* number of bulk out endpoints */
+#define DEFAULT_BULK_IN_ENDPOINT	0
+
+/* Structure to hold all of our device specific stuff */
+struct usb_ljusb {
+	struct usb_device *	udev;			/* the usb device for this device */
+	struct usb_interface *	interface;		/* the interface for this device */
+	struct semaphore	sem;			/* semaphore for this structure */
+	
+	/* the buffers to receive data */
+	unsigned char *		bulk_in_buffer[N_BULK_IN_ENDPOINTS];
+
+	/* the sizes of the receive buffers */
+	size_t			bulk_in_size[N_BULK_IN_ENDPOINTS];
+
+	/* the addresses of the bulk in endpoints */
+	__u8			bulk_in_endpointAddr[N_BULK_IN_ENDPOINTS];
+	int			bulk_in_timeout;	/* timeout for bulk in reads, in ms */
+	int			next_bulk_in_endpoint;  /* specifies the bulk endpoint to use on
+							 * the next read */
+	/* the addresses of the bulk out endpoints */
+	__u8			bulk_out_endpointAddr[N_BULK_OUT_ENDPOINTS];
+	struct kref		kref;
+};
+#define to_ljusb_dev(d) container_of(d, struct usb_ljusb, kref)
+
+static struct usb_driver ljusb_driver;
+
+/**
+ *	ljusb_delete
+ */
+static void ljusb_delete(struct kref *kref)
+{	
+	int i;
+	struct usb_ljusb *dev = to_ljusb_dev(kref);
+
+	usb_put_dev(dev->udev);
+	
+	for(i = 0; i < N_BULK_IN_ENDPOINTS; ++i)
+		kfree (dev->bulk_in_buffer[i]);
+	kfree (dev);
+}
+
+/**
+ *	ljusb_open
+ */
+static int ljusb_open(struct inode *inode, struct file *file)
+{
+	struct usb_ljusb *dev;
+	struct usb_interface *interface;
+	int subminor;
+	int retval = 0;
+
+	subminor = iminor(inode);
+
+	interface = usb_find_interface(&ljusb_driver, subminor);
+	if (!interface) {
+		err ("%s - error, can't find device for minor %d",
+		     __FUNCTION__, subminor);
+		retval = -ENODEV;
+		goto exit;
+	}
+
+	dev = usb_get_intfdata(interface);
+	if (!dev) {
+		retval = -ENODEV;
+		goto exit;
+	}
+
+	/* increment our usage count for the device */
+	kref_get(&dev->kref);
+
+	/* save our object in the file's private structure */
+	file->private_data = dev;
+exit:
+	return retval;
+}
+
+/**
+ *	ljusb_release
+ */
+static int ljusb_release(struct inode *inode, struct file *file)
+{
+	struct usb_ljusb *dev;
+
+	dev = (struct usb_ljusb *)file->private_data;
+	if (dev == NULL)
+		return -ENODEV;
+
+	/* decrement the count on our device */
+	kref_put(&dev->kref, ljusb_delete);
+	return 0;
+}
+
+/**
+ *	ljusb_read	
+ */
+static ssize_t ljusb_read(struct file *file, char *buffer, size_t
count, loff_t *ppos)
+{
+	struct usb_ljusb *dev;
+	int retval = 0;
+	int bytes_read;
+	int bytes_read_tot = 0;
+	int ep;
+
+	dev = (struct usb_ljusb *)file->private_data;
+
+	/* lock object */
+	if (down_interruptible(&dev->sem)) {
+		retval = -ERESTARTSYS;
+		goto exit;
+	}
+
+	ep = dev->next_bulk_in_endpoint;
+
+	/* Checking if bulk in endpoint to read from is valid */
+	if(ep > N_BULK_IN_ENDPOINTS || ep < 0) {
+		retval = -EPERM;
+		goto exit;
+	}		
+
+	/* bulk read for responses that can be larger than the bulk endpoint size */
+	while(count > 0) {
+		/* do a blocking bulk read to get data from the device */
+		retval = usb_bulk_msg(dev->udev,
+				usb_rcvbulkpipe(dev->udev,
+					dev->bulk_in_endpointAddr[ep]),
+				dev->bulk_in_buffer[ep],
+				min(dev->bulk_in_size[ep], count),
+				&bytes_read, dev->bulk_in_timeout);
+
+		/* if the read was successful, copy the data to userspace */
+		if (!retval || retval == -ETIMEDOUT) {
+			if (copy_to_user(buffer + bytes_read_tot,
+					dev->bulk_in_buffer[ep],
+					min((size_t)bytes_read, count)))
+				retval = -EFAULT;
+			else
+				bytes_read_tot += bytes_read;
+		}
+		else
+			goto exit;
+
+		/* No bytes were read from device, or bytes read were less than bulk
+		 * endpoint size, indicating that there is nothing left to read from
+		 * device. */
+		if(bytes_read <= 0 || dev->bulk_in_size[ep] > bytes_read)
+			goto set_retval;
+
+		count = count > bytes_read ? count-bytes_read : 0;
+	}
+
+set_retval:
+	retval = bytes_read_tot;
+exit:
+	/* setting the next bulk in endpoint back to the default endpoint */
+	dev->next_bulk_in_endpoint = DEFAULT_BULK_IN_ENDPOINT;
+	up(&dev->sem);
+	return retval;
+}
+
+/**
+ *	ljusb_write_bulk_callback
+ */
+static void ljusb_write_bulk_callback(struct urb *urb)
+{
+	struct usb_ljusb *dev;
+
+	dev = (struct usb_ljusb *)urb->context;
+
+	/* sync/async unlink faults aren't errors */
+	if (urb->status &&
+	    !(urb->status == -ENOENT ||
+	      urb->status == -ECONNRESET ||
+	      urb->status == -ESHUTDOWN)) {
+		dbg("%s - nonzero write bulk status received: %d",
+		    __FUNCTION__, urb->status);
+	}
+
+	/* free up our allocated buffer */
+	usb_buffer_free(urb->dev, urb->transfer_buffer_length,
+			urb->transfer_buffer, urb->transfer_dma);
+	up(&dev->sem);
+}
+
+/**
+ *	ljusb_write
+ */
+static ssize_t ljusb_write(struct file *file, const char
*user_buffer, size_t count, loff_t *ppos)
+{
+	struct usb_ljusb *dev;
+	int retval = 0;
+	struct urb *urb = NULL;
+	char *buf = NULL;
+	size_t writesize = min(count, (size_t)MAX_TRANSFER);
+	int ep;
+
+	dev = (struct usb_ljusb *)file->private_data;
+
+	/* verify that we actually have some data to write */
+	if (count == 0)
+		goto exit;
+
+	/* limits the number of URBs in flight to one */
+	if (down_interruptible(&dev->sem)) {
+		retval = -ERESTARTSYS;
+		goto exit;
+	}
+
+	/* writing through bulk out endpoint 0 by default */
+	ep = 0;
+
+	/* create a urb, and a buffer for it, and copy the data to the urb */
+	urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!urb) {
+		retval = -ENOMEM;
+		goto error;
+	}
+
+	buf = usb_buffer_alloc(dev->udev, writesize, GFP_KERNEL, &urb->transfer_dma);
+	if (!buf) {
+		retval = -ENOMEM;
+		goto error;
+	}
+
+	if (copy_from_user(buf, user_buffer, writesize)) {
+		retval = -EFAULT;
+		goto error;
+	}
+
+	/* initialize the urb properly */
+	usb_fill_bulk_urb(urb, dev->udev,
+			usb_sndbulkpipe(dev->udev, dev->bulk_out_endpointAddr[ep]),
+			buf, writesize, ljusb_write_bulk_callback, dev);
+	urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
+
+	/* send the data out the bulk port */
+	retval = usb_submit_urb(urb, GFP_KERNEL);
+	if (retval) {
+		err("%s - failed submitting write urb, error %d", __FUNCTION__, retval);
+		goto error;
+	}
+
+	/* release our reference to this urb, the USB core will eventually
free it entirely */
+	usb_free_urb(urb);
+exit:
+	return writesize;
+
+error:
+	usb_buffer_free(dev->udev, writesize, buf, urb->transfer_dma);
+	usb_free_urb(urb);
+	up(&dev->sem);
+	return retval;
+}
+
+/**
+ *	ljusb_ioctl
+ */
+static int ljusb_ioctl (struct inode *inode, struct file *file,
unsigned int cmd, unsigned long arg)
+{
+	struct usb_ljusb *dev;
+	void __user *data;
+	int retval = 0;
+	int timeout = 0;
+	int ep = 0;
+
+	dev = (struct usb_ljusb *)file->private_data;
+
+	/* lock this object */
+	if (down_interruptible(&dev->sem)) {
+		retval = -ERESTARTSYS;
+		return retval;
+	}
+
+	/* driver specific commands */
+	switch (cmd) {
+		/* Sets the timeout for usb_bulk_msg reads transfers in ms from an integer
+		 * argument.  If the timeout is set to zero, reads will wait forever */
+		case IOCTL_LJ_SET_BULK_IN_TIMEOUT:
+			data = (void __user *) arg;
+			if (data == NULL)
+				break;
+
+			if (copy_from_user(&timeout, data, sizeof(int))) {
+				retval = -EFAULT;
+				break;
+			}
+
+			if(timeout < 0)
+				retval = -EINVAL;
+			else
+				dev->bulk_in_timeout = timeout;
+				
+			break;
+		/* Gets the Product ID for the device */
+		case IOCTL_LJ_GET_PRODUCT_ID:
+			retval = put_user(dev->udev->descriptor.idProduct,
+						(unsigned int __user *)arg);
+			break;
+		/* Sets the bulk in endpoint for the next read from an integer argument.
+		 * There are two bulk endpoints, which are endpoints 0 and 1 when
+		 * setting the integer argument. */
+		case IOCTL_LJ_SET_BULK_IN_ENDPOINT:
+			data = (void __user *) arg;
+			if (data == NULL)
+				break;
+			
+			if (copy_from_user(&ep, data, sizeof(int))) {
+				retval = -EFAULT;
+				break;
+			}
+			
+			if(ep > N_BULK_IN_ENDPOINTS || ep < 0)
+				retval = -EINVAL;
+			else
+				dev->next_bulk_in_endpoint = ep;
+			break;
+		default:
+			retval = -ENOTTY;
+			break;
+	}
+
+	/* unlock the device */
+	up (&dev->sem);
+
+	return retval;
+}
+
+static struct file_operations ljusb_fops = {
+	.owner =	THIS_MODULE,
+	.read =		ljusb_read,
+	.write =	ljusb_write,
+	.open =		ljusb_open,
+	.release =	ljusb_release,
+	.ioctl =	ljusb_ioctl,
+};
+
+/**
+ * usb class driver info in order to get a minor number from the usb core,
+ * and to have the device registered with the driver core
+ */
+static struct usb_class_driver ljusb_class = {
+	.name =		"ljusb%d",
+	.fops =		&ljusb_fops,
+	.minor_base =	USB_LJ_MINOR_BASE,
+};
+
+/**
+ *	ljusb_probe
+ */
+static int ljusb_probe(struct usb_interface *interface, const struct
usb_device_id *id)
+{
+	struct usb_ljusb *dev = NULL;
+	struct usb_host_interface *iface_desc;
+	struct usb_endpoint_descriptor *endpoint;
+	size_t buffer_size;
+	int i, j, k;
+	int retval = -ENOMEM;
+
+	/* allocate memory for our device state and initialize it */
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (dev == NULL) {
+		err("Out of memory");
+		goto error;
+	}
+	kref_init(&dev->kref);
+	sema_init(&dev->sem, 1);
+
+	dev->udev = usb_get_dev(interface_to_usbdev(interface));
+	dev->interface = interface;
+	
+	/* set default bulk in read timeout */
+	dev->bulk_in_timeout = BULK_IN_TIMEOUT;
+	
+	/* set default bulk in endpoint */
+	dev->next_bulk_in_endpoint = DEFAULT_BULK_IN_ENDPOINT;
+
+	/* set up the endpoint information */
+	iface_desc = interface->cur_altsetting;
+	j = 0;
+	k = 0;
+	for (i = 0; i < iface_desc->desc.bNumEndpoints; ++i) {
+		endpoint = &iface_desc->endpoint[i].desc;
+
+		if(j < N_BULK_IN_ENDPOINTS)
+		{
+			if (!dev->bulk_in_endpointAddr[j] &&
+				((endpoint->bEndpointAddress & USB_ENDPOINT_DIR_MASK)
+						== USB_DIR_IN) &&
+			    	((endpoint->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK)
+						== USB_ENDPOINT_XFER_BULK)) {
+				/* we found a bulk in endpoint */
+				buffer_size = le16_to_cpu(endpoint->wMaxPacketSize);
+				dev->bulk_in_size[j] = buffer_size;
+				dev->bulk_in_endpointAddr[j] = endpoint->bEndpointAddress;
+				dev->bulk_in_buffer[j] = kmalloc(buffer_size, GFP_KERNEL);
+				if (!dev->bulk_in_buffer[j]) {
+					err("Could not allocate bulk_in_buffer");
+					goto error;
+				}
+				++j;
+			}
+		}
+
+		if(k < N_BULK_OUT_ENDPOINTS) {
+			if (!dev->bulk_out_endpointAddr[k] &&
+				((endpoint->bEndpointAddress & USB_ENDPOINT_DIR_MASK)
+						== USB_DIR_OUT) &&
+				((endpoint->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK)
+						== USB_ENDPOINT_XFER_BULK)) {
+				/* we found a bulk out endpoint */
+				dev->bulk_out_endpointAddr[k] = endpoint->bEndpointAddress;
+				++k;
+			}
+		}
+	}
+
+	/* Checking if valid bulk in endpoints were found */
+	for(j = 0; j < N_BULK_IN_ENDPOINTS; ++j) {
+		if (!dev->bulk_in_endpointAddr[j]) {
+			err("Could not find all valid bulk-in endpoints");
+			goto error;
+		}
+	}
+	
+	/* Checking if a valid bulk out endpoint was found.  There is a
second bulk out
+	 * endpoint, but we are not using it */
+	if (!dev->bulk_out_endpointAddr[0]) {
+		err("Could not find all valid bulk-out endpoints");
+		goto error;
+	}
+	
+	/* save our data pointer in this interface device */
+	usb_set_intfdata(interface, dev);
+	
+	/* we can register the device now, as it is ready */
+	retval = usb_register_dev(interface, &ljusb_class);
+	if (retval) {
+		/* something prevented us from registering this driver */
+		err("Not able to get a minor for this device.");
+		usb_set_intfdata(interface, NULL);
+		goto error;
+	}
+
+	/* let the user know what node this device is now attached to */
+	info("USB Labjack device with product id %d now attached to
ljusb-%d", dev->udev->descriptor.idProduct, interface->minor);
+	return 0;
+
+error:
+	if (dev)
+		kref_put(&dev->kref, ljusb_delete);
+	return retval;
+}
+
+/**
+ *	ljusb_disconnect
+ */
+static void ljusb_disconnect(struct usb_interface *interface)
+{
+	struct usb_ljusb *dev;
+	int minor = interface->minor;
+
+	/* prevent ljusb_open() from racing ljusb_disconnect() */
+	lock_kernel();
+
+	dev = usb_get_intfdata(interface);
+	usb_set_intfdata(interface, NULL);
+
+	/* give back our minor */
+	usb_deregister_dev(interface, &ljusb_class);
+
+	unlock_kernel();
+
+	/* decrement our usage count */
+	kref_put(&dev->kref, ljusb_delete);
+
+	info("USB LabJack #%d now disconnected", minor);
+}
+
+static struct usb_driver ljusb_driver = {
+	.name =		"ljusb",
+	.probe =	ljusb_probe,
+	.disconnect =	ljusb_disconnect,
+	.id_table =	lj_usb_table,
+};
+
+/**
+ *	usb_ljusb_delete
+ */
+static int __init usb_ljusb_init(void)
+{
+	int result;
+
+	/* register this driver with the USB subsystem */
+	result = usb_register(&ljusb_driver);
+	if (result)
+		err("usb_register failed. Error number %d", result);
+
+	return result;
+}
+
+/**
+ *	usb_ljusb_delete
+ */
+static void __exit usb_ljusb_exit(void)
+{
+	/* deregister this driver with the USB subsystem */
+	usb_deregister(&ljusb_driver);
+}
+
+module_init (usb_ljusb_init);
+module_exit (usb_ljusb_exit);
+
+MODULE_DESCRIPTION(DRIVER_DESC);
+#ifdef MODULE_LICENSE
+MODULE_LICENSE("GPL");
+#endif
diff -uprN -X linux-2.6.19-vanilla/Documentation/dontdiff
linux-2.6.19-vanilla/drivers/usb/misc/Makefile
linux-2.6.19/drivers/usb/misc/Makefile
--- linux-2.6.19-vanilla/drivers/usb/misc/Makefile	2006-11-29
14:57:37.000000000 -0700
+++ linux-2.6.19/drivers/usb/misc/Makefile	2006-11-30 17:52:11.000000000 -0700
@@ -15,6 +15,7 @@ obj-$(CONFIG_USB_LCD)		+= usblcd.o
 obj-$(CONFIG_USB_LD)		+= ldusb.o
 obj-$(CONFIG_USB_LED)		+= usbled.o
 obj-$(CONFIG_USB_LEGOTOWER)	+= legousbtower.o
+obj-$(CONFIG_USB_LJ)		+= ljusb.o
 obj-$(CONFIG_USB_PHIDGET)	+= phidget.o
 obj-$(CONFIG_USB_PHIDGETKIT)	+= phidgetkit.o
 obj-$(CONFIG_USB_PHIDGETMOTORCONTROL)	+= phidgetmotorcontrol.o
