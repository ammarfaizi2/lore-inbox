Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965648AbVKHArS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965648AbVKHArS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 19:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965650AbVKHArS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 19:47:18 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:18439 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965648AbVKHArR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 19:47:17 -0500
Date: Tue, 8 Nov 2005 01:47:16 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Greg KH <greg@kroah.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@osdl.org>,
       Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, mdharm-usb@one-eyed-alien.net
Subject: [-mm patch] USB_LIBUSUAL shouldn't be user-visible
Message-ID: <20051108004716.GJ3847@stusta.de>
References: <20051107215226.GA25104@kroah.com> <Pine.LNX.4.44L0.0511071725220.5165-100000@iolanthe.rowland.org> <20051107222840.GB26417@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051107222840.GB26417@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 02:28:40PM -0800, Greg KH wrote:
> On Mon, Nov 07, 2005 at 05:26:10PM -0500, Alan Stern wrote:
> > On Mon, 7 Nov 2005, Greg KH wrote:
> > 
> > > On Mon, Nov 07, 2005 at 10:10:28PM +0100, Adrian Bunk wrote:
> > > > On Sun, Nov 06, 2005 at 06:24:47PM -0800, Andrew Morton wrote:
> > > > >...
> > > > > Changes since 2.6.14-rc5-mm1:
> > > > >...
> > > > > +gregkh-usb-usb-libusual.patch
> > > > > 
> > > > >  USB tree updates
> > > > >...
> > > > 
> > > > IMHO, CONFIG_USB_LIBUSUAL shouldn't be a user-visible variable but 
> > > > should be automatically enabled when it makes sense.
> > > 
> > > The trick is, when does it "make sense"?
> > > 
> > > Anyone have any ideas?
> > 
> > The simplest answer is to configure it whenever usb-storage and ub are 
> > both configured.  libusual has no purpose otherwise.
> 
> Ok, care to write up the Kconfig for that?


Patch below.


The more I think about it, the more I think that this might be a bit too 
complicated.

What about letting the two drivers always use libusual?



> thanks,
> 
> greg k-h


cu
Adrian


<--  snip  -->


This patch changes CONFIG_USB_LIBUSUAL to be no longer user-visible.

If both drivers are built and at least one of them is built statically 
into the kernel, libusual is built statically into the kernel.

If both drivers are built modular, libusual is built modular.

If one or zero of the two drivers are built, libusual is not built.


The additional CONFIG_USB_LIBUSUAL_BUILT is only present because I do 
really dislike writing

  #if defined(CONFIG_USB_LIBUSUAL) || defined(CONFIG_USB_LIBUSUAL_MODULE)

and I've already seen several places where people have gotten this 
wrong.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/block/Kconfig        |    3 ---
 drivers/block/ub.c           |    4 ++--
 drivers/usb/Makefile         |    1 +
 drivers/usb/storage/Kconfig  |   17 ++++++-----------
 drivers/usb/storage/Makefile |    4 +---
 drivers/usb/storage/usb.c    |    4 ++--
 include/linux/usb_usual.h    |    4 ++--

--- linux-2.6.14-mm1-full/drivers/usb/storage/Kconfig.old	2005-11-08 00:52:18.000000000 +0100
+++ linux-2.6.14-mm1-full/drivers/usb/storage/Kconfig	2005-11-08 01:23:55.000000000 +0100
@@ -126,15 +126,10 @@
 	  cuts)
 
 config USB_LIBUSUAL
-	bool "The shared table of common (or usual) storage devices"
-	depends on USB
-	help
-	  This module contains a table of common (or usual) devices
-	  for usb-storage and ub drivers, and allows to switch binding
-	  of these devices without rebuilding modules.
+	tristate
+	default y if ((USB_STORAGE=y && BLK_DEV_UB) || (BLK_DEV_UB=y && USB_STORAGE))
+	default m if (USB_STORAGE && BLK_DEV_UB)
+	select USB_LIBUSUAL_BUILT
 
-	  Typical syntax of /etc/modprobe.conf is:
-
-		options libusual bias="ub"
-
-	  If unsure, say N.
+config USB_LIBUSUAL_BUILT
+	bool
--- linux-2.6.14-mm1-full/drivers/usb/storage/Makefile.old	2005-11-08 00:53:46.000000000 +0100
+++ linux-2.6.14-mm1-full/drivers/usb/storage/Makefile	2005-11-08 01:23:55.000000000 +0100
@@ -23,6 +23,4 @@
 usb-storage-objs :=	scsiglue.o protocol.o transport.o usb.o \
 			initializers.o $(usb-storage-obj-y)
 
-ifneq ($(CONFIG_USB_LIBUSUAL),)
-	obj-$(CONFIG_USB)	+= libusual.o
-endif
+obj-$(CONFIG_USB_LIBUSUAL)	+= libusual.o
--- linux-2.6.14-mm1-full/drivers/usb/Makefile.old	2005-11-08 01:31:00.000000000 +0100
+++ linux-2.6.14-mm1-full/drivers/usb/Makefile	2005-11-08 01:31:26.000000000 +0100
@@ -22,6 +22,7 @@
 obj-$(CONFIG_USB_PRINTER)	+= class/
 
 obj-$(CONFIG_USB_STORAGE)	+= storage/
+obj-$(CONFIG_USB_LIBUSUAL)	+= storage/
 
 obj-$(CONFIG_USB_AIPTEK)	+= input/
 obj-$(CONFIG_USB_ATI_REMOTE)	+= input/
--- linux-2.6.14-mm1-full/drivers/block/Kconfig.old	2005-11-08 00:54:56.000000000 +0100
+++ linux-2.6.14-mm1-full/drivers/block/Kconfig	2005-11-08 01:23:55.000000000 +0100
@@ -358,9 +358,6 @@
 	  This driver supports certain USB attached storage devices
 	  such as flash keys.
 
-	  If you enable this driver, it is recommended to avoid conflicts
-	  with usb-storage by enabling USB_LIBUSUAL.
-
 	  If unsure, say N.
 
 config BLK_DEV_RAM
--- linux-2.6.14-mm1-full/include/linux/usb_usual.h.old	2005-11-08 00:56:15.000000000 +0100
+++ linux-2.6.14-mm1-full/include/linux/usb_usual.h	2005-11-08 01:23:55.000000000 +0100
@@ -107,7 +107,7 @@
 
 /*
  */
-#ifdef CONFIG_USB_LIBUSUAL
+#ifdef CONFIG_USB_LIBUSUAL_BUILT
 
 extern struct usb_device_id storage_usb_ids[];
 extern void usb_usual_set_present(int type);
@@ -118,6 +118,6 @@
 #define usb_usual_set_present(t)	do { } while(0)
 #define usb_usual_clear_present(t)	do { } while(0)
 #define usb_usual_check_type(id, t)	(0)
-#endif /* CONFIG_USB_LIBUSUAL */
+#endif /* CONFIG_USB_LIBUSUAL_BUILT */
 
 #endif /* __LINUX_USB_USUAL_H */
--- linux-2.6.14-mm1-full/drivers/usb/storage/usb.c.old	2005-11-08 00:57:30.000000000 +0100
+++ linux-2.6.14-mm1-full/drivers/usb/storage/usb.c	2005-11-08 01:23:55.000000000 +0100
@@ -116,7 +116,7 @@
  * The entries in this table correspond, line for line,
  * with the entries of us_unusual_dev_list[].
  */
-#ifndef CONFIG_USB_LIBUSUAL
+#ifndef CONFIG_USB_LIBUSUAL_BUILT
 
 #define UNUSUAL_DEV(id_vendor, id_product, bcdDeviceMin, bcdDeviceMax, \
 		    vendorName, productName,useProtocol, useTransport, \
@@ -138,7 +138,7 @@
 };
 
 MODULE_DEVICE_TABLE (usb, storage_usb_ids);
-#endif /* CONFIG_USB_LIBUSUAL */
+#endif /* CONFIG_USB_LIBUSUAL_BUILT */
 
 /* This is the list of devices we recognize, along with their flag data */
 
--- linux-2.6.14-mm1-full/drivers/block/ub.c.old	2005-11-08 00:57:52.000000000 +0100
+++ linux-2.6.14-mm1-full/drivers/block/ub.c	2005-11-08 01:23:55.000000000 +0100
@@ -413,7 +413,7 @@
 
 /*
  */
-#ifdef CONFIG_USB_LIBUSUAL
+#ifdef CONFIG_USB_LIBUSUAL_BUILT
 
 #define ub_usb_ids  storage_usb_ids
 #else
@@ -424,7 +424,7 @@
 };
 
 MODULE_DEVICE_TABLE(usb, ub_usb_ids);
-#endif /* CONFIG_USB_LIBUSUAL */
+#endif /* CONFIG_USB_LIBUSUAL_BUILT */
 
 /*
  * Find me a way to identify "next free minor" for add_disk(),

