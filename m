Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261832AbVAHJZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbVAHJZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 04:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261831AbVAHJYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 04:24:15 -0500
Received: from mail.kroah.org ([69.55.234.183]:31109 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261829AbVAHFsG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:06 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632663455@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:46 -0800
Message-Id: <11051632661756@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.446.21, 2004/12/15 16:35:03-08:00, david-b@pacbell.net

[PATCH] USB: HCD/usb_bus interface cleanup (9/15)

This changes the usbcore interfaces provided to HCDs:

  - Remove usb_device->hcpriv and it allocation/deallocation hooks

  - Replace struct hcd_dev with more appropriate per-endpoint state

  - Update HCD apis to use usb_host_endpoint in key places

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/core/hcd.h |   20 ++++++--------------
 include/linux/usb.h    |   17 ++++++++++++++---
 2 files changed, 20 insertions(+), 17 deletions(-)


diff -Nru a/drivers/usb/core/hcd.h b/drivers/usb/core/hcd.h
--- a/drivers/usb/core/hcd.h	2005-01-07 15:48:51 -08:00
+++ b/drivers/usb/core/hcd.h	2005-01-07 15:48:51 -08:00
@@ -66,7 +66,6 @@
 	const char		*description;	/* "ehci-hcd" etc */
 
 	struct timer_list	rh_timer;	/* drives root hub */
-	struct list_head	dev_list;	/* devices on this bus */
 
 	/*
 	 * hardware info/state
@@ -113,14 +112,6 @@
 }
 
 
-struct hcd_dev {	/* usb_device.hcpriv points to this */
-	struct list_head	dev_list;	/* on this hcd */
-	struct list_head	urb_list;	/* pending on this dev */
-
-	/* per-configuration HC/HCD state, such as QH or ED */
-	void			*ep[32];
-};
-
 // urb.hcpriv is really hardware-specific
 
 struct hcd_timeout {	/* timeouts we allocate */
@@ -136,8 +127,6 @@
  */
 
 struct usb_operations {
-	int (*allocate)(struct usb_device *);
-	int (*deallocate)(struct usb_device *);
 	int (*get_frame_number) (struct usb_device *usb_dev);
 	int (*submit_urb) (struct urb *urb, int mem_flags);
 	int (*unlink_urb) (struct urb *urb, int status);
@@ -149,7 +138,8 @@
 	void (*buffer_free)(struct usb_bus *bus, size_t size,
 			void *addr, dma_addr_t dma);
 
-	void (*disable)(struct usb_device *udev, int bEndpointAddress);
+	void (*disable)(struct usb_device *udev,
+			struct usb_host_endpoint *ep);
 
 	/* global suspend/resume of bus */
 	int (*hub_suspend)(struct usb_bus *);
@@ -200,13 +190,15 @@
 	struct usb_hcd	*(*hcd_alloc) (void);
 
 	/* manage i/o requests, device state */
-	int	(*urb_enqueue) (struct usb_hcd *hcd, struct urb *urb,
+	int	(*urb_enqueue) (struct usb_hcd *hcd,
+					struct usb_host_endpoint *ep,
+					struct urb *urb,
 					int mem_flags);
 	int	(*urb_dequeue) (struct usb_hcd *hcd, struct urb *urb);
 
 	/* hw synch, freeing endpoint resources that urb_dequeue can't */
 	void 	(*endpoint_disable)(struct usb_hcd *hcd,
-			struct hcd_dev *dev, int bEndpointAddress);
+			struct usb_host_endpoint *ep);
 
 	/* root hub support */
 	int		(*hub_status_data) (struct usb_hcd *hcd, char *buf);
diff -Nru a/include/linux/usb.h b/include/linux/usb.h
--- a/include/linux/usb.h	2005-01-07 15:48:51 -08:00
+++ b/include/linux/usb.h	2005-01-07 15:48:51 -08:00
@@ -40,9 +40,22 @@
  * Devices may also have class-specific or vendor-specific descriptors.
  */
 
-/* host-side wrapper for parsed endpoint descriptors */
+/**
+ * struct usb_host_endpoint - host-side endpoint descriptor and queue
+ * @desc: descriptor for this endpoint, wMaxPacketSize in native byteorder
+ * @urb_list: urbs queued to this endpoint; maintained by usbcore
+ * @hcpriv: for use by HCD; typically holds hardware dma queue head (QH)
+ *	with one or more transfer descriptors (TDs) per urb
+ * @extra: descriptors following this endpoint in the configuration
+ * @extralen: how many bytes of "extra" are valid
+ *
+ * USB requests are always queued to a given endpoint, identified by a
+ * descriptor within an active interface in a given USB configuration.
+ */
 struct usb_host_endpoint {
 	struct usb_endpoint_descriptor	desc;
+	struct list_head		urb_list;
+	void				*hcpriv;
 
 	unsigned char *extra;   /* Extra descriptors */
 	int extralen;
@@ -325,8 +338,6 @@
 	int have_langid;		/* whether string_langid is valid yet */
 	int string_langid;		/* language ID for strings */
 
-	void *hcpriv;			/* Host Controller private data */
-	
 	struct list_head filelist;
 	struct dentry *usbfs_dentry;	/* usbfs dentry entry for the device */
 

