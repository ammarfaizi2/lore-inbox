Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261908AbVAHIin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261908AbVAHIin (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 03:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbVAHIg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 03:36:26 -0500
Received: from mail.kroah.org ([69.55.234.183]:3974 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261907AbVAHFsi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:38 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632652829@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:45 -0800
Message-Id: <1105163265230@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.446.13, 2004/12/15 16:31:49-08:00, david-b@pacbell.net

[PATCH] USB: usb_dev->ep[] not usb_dev->epmaxpacket (1/15)

This starts updating the usbcore interface to use endpoints in places it
previously used pipes or other representations of the endpoint.

    - add new arrays of "struct usb_host_endpoint" pointers, matching
      current config and altsetting

    - get rid of the two epmaxpacket[] arrays; they duplicate information
      that's now readily accessible from the usb_host_endpoint.

    - resolve a FIXME by removing a function that only existed because
      the usb_host_endpoint wasn't readily accessible.

It also removes most of an old rant about pipes, trimming it down so
only the important bits remain.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 include/linux/usb.h |   73 ++++++++++++++++++++++++++--------------------------
 1 files changed, 37 insertions(+), 36 deletions(-)


diff -Nru a/include/linux/usb.h b/include/linux/usb.h
--- a/include/linux/usb.h	2005-01-07 15:49:52 -08:00
+++ b/include/linux/usb.h	2005-01-07 15:49:52 -08:00
@@ -224,11 +224,6 @@
 	int extralen;
 };
 
-// FIXME remove; exported only for drivers/usb/misc/auserwald.c
-// prefer usb_device->epnum[0..31]
-extern struct usb_endpoint_descriptor *
-	usb_epnum_to_ep_desc(struct usb_device *dev, unsigned epnum);
-
 int __usb_get_extra_descriptor(char *buffer, unsigned size,
 	unsigned char type, void **ptr);
 #define usb_get_extra_descriptor(ifpoint,type,ptr)\
@@ -311,17 +306,19 @@
 	struct semaphore serialize;
 
 	unsigned int toggle[2];		/* one bit for each endpoint ([0] = IN, [1] = OUT) */
-	int epmaxpacketin[16];		/* INput endpoint specific maximums */
-	int epmaxpacketout[16];		/* OUTput endpoint specific maximums */
 
 	struct usb_device *parent;	/* our hub, unless we're the root */
 	struct usb_bus *bus;		/* Bus we're part of */
+	struct usb_host_endpoint ep0;
 
 	struct device dev;		/* Generic device interface */
 
 	struct usb_device_descriptor descriptor;/* Descriptor */
 	struct usb_host_config *config;	/* All of the configs */
+
 	struct usb_host_config *actconfig;/* the active configuration */
+	struct usb_host_endpoint *ep_in[16];
+	struct usb_host_endpoint *ep_out[16];
 
 	char **rawdescriptors;		/* Raw descriptors for each config */
 
@@ -360,6 +357,8 @@
 
 extern struct usb_device *usb_find_device(u16 vendor_id, u16 product_id);
 
+/*-------------------------------------------------------------------------*/
+
 /* for drivers using iso endpoints */
 extern int usb_get_current_frame_number (struct usb_device *usb_dev);
 
@@ -1040,55 +1039,35 @@
 /* -------------------------------------------------------------------------- */
 
 /*
- * Calling this entity a "pipe" is glorifying it. A USB pipe
- * is something embarrassingly simple: it basically consists
- * of the following information:
- *  - device number (7 bits)
- *  - endpoint number (4 bits)
- *  - current Data0/1 state (1 bit) [Historical; now gone]
- *  - direction (1 bit)
- *  - speed (1 bit) [Historical and specific to USB 1.1; now gone.]
- *  - max packet size (2 bits: 8, 16, 32 or 64) [Historical; now gone.]
- *  - pipe type (2 bits: control, interrupt, bulk, isochronous)
- *
- * That's 18 bits. Really. Nothing more. And the USB people have
- * documented these eighteen bits as some kind of glorious
- * virtual data structure.
+ * For various legacy reasons, Linux has a small cookie that's paired with
+ * a struct usb_device to identify an endpoint queue.  Queue characteristics
+ * are defined by the endpoint's descriptor.  This cookie is called a "pipe",
+ * an unsigned int encoded as:
  *
- * Let's not fall in that trap. We'll just encode it as a simple
- * unsigned int. The encoding is:
- *
- *  - max size:		bits 0-1	[Historical; now gone.]
  *  - direction:	bit 7		(0 = Host-to-Device [Out],
  *					 1 = Device-to-Host [In] ...
  *					like endpoint bEndpointAddress)
- *  - device:		bits 8-14       ... bit positions known to uhci-hcd
+ *  - device address:	bits 8-14       ... bit positions known to uhci-hcd
  *  - endpoint:		bits 15-18      ... bit positions known to uhci-hcd
- *  - Data0/1:		bit 19		[Historical; now gone. ]
- *  - lowspeed:		bit 26		[Historical; now gone. ]
  *  - pipe type:	bits 30-31	(00 = isochronous, 01 = interrupt,
  *					 10 = control, 11 = bulk)
  *
- * Why? Because it's arbitrary, and whatever encoding we select is really
- * up to us. This one happens to share a lot of bit positions with the UHCI
- * specification, so that much of the uhci driver can just mask the bits
- * appropriately.
+ * Given the device address and endpoint descriptor, pipes are redundant.
  */
 
 /* NOTE:  these are not the standard USB_ENDPOINT_XFER_* values!! */
+/* (yet ... they're the values used by usbfs) */
 #define PIPE_ISOCHRONOUS		0
 #define PIPE_INTERRUPT			1
 #define PIPE_CONTROL			2
 #define PIPE_BULK			3
 
-#define usb_maxpacket(dev, pipe, out)	(out \
-				? (dev)->epmaxpacketout[usb_pipeendpoint(pipe)] \
-				: (dev)->epmaxpacketin [usb_pipeendpoint(pipe)] )
-
 #define usb_pipein(pipe)	((pipe) & USB_DIR_IN)
 #define usb_pipeout(pipe)	(!usb_pipein(pipe))
+
 #define usb_pipedevice(pipe)	(((pipe) >> 8) & 0x7f)
 #define usb_pipeendpoint(pipe)	(((pipe) >> 15) & 0xf)
+
 #define usb_pipetype(pipe)	(((pipe) >> 30) & 3)
 #define usb_pipeisoc(pipe)	(usb_pipetype((pipe)) == PIPE_ISOCHRONOUS)
 #define usb_pipeint(pipe)	(usb_pipetype((pipe)) == PIPE_INTERRUPT)
@@ -1115,6 +1094,28 @@
 #define usb_rcvbulkpipe(dev,endpoint)	((PIPE_BULK << 30) | __create_pipe(dev,endpoint) | USB_DIR_IN)
 #define usb_sndintpipe(dev,endpoint)	((PIPE_INTERRUPT << 30) | __create_pipe(dev,endpoint))
 #define usb_rcvintpipe(dev,endpoint)	((PIPE_INTERRUPT << 30) | __create_pipe(dev,endpoint) | USB_DIR_IN)
+
+/*-------------------------------------------------------------------------*/
+
+static inline __u16
+usb_maxpacket(struct usb_device *udev, int pipe, int is_out)
+{
+	struct usb_host_endpoint	*ep;
+	unsigned			epnum = usb_pipeendpoint(pipe);
+
+	if (is_out) {
+		WARN_ON(usb_pipein(pipe));
+		ep = udev->ep_out[epnum];
+	} else {
+		WARN_ON(usb_pipeout(pipe));
+		ep = udev->ep_in[epnum];
+	}
+	if (!ep)
+		return 0;
+
+	/* NOTE:  only 0x07ff bits are for packet size... */
+	return ep->desc.wMaxPacketSize;
+}
 
 /* -------------------------------------------------------------------------- */
 

