Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbULWCkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbULWCkt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 21:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbULWCks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 21:40:48 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:27411 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261152AbULWCke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 21:40:34 -0500
Date: Thu, 23 Dec 2004 03:40:31 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Greg KH <greg@kroah.com>
Cc: mdharm-usb@one-eyed-alien.net, zaitcev@yahoo.com,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: RFC: [2.6 patch] let BLK_DEV_UB depend on USB_STORAGE=n
Message-ID: <20041223024031.GO5217@stusta.de>
References: <20041220001644.GI21288@stusta.de> <20041220003146.GB11358@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041220003146.GB11358@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 19, 2004 at 04:31:46PM -0800, Greg KH wrote:
> On Mon, Dec 20, 2004 at 01:16:44AM +0100, Adrian Bunk wrote:
> > I've already seen people crippling their usb-storage driver with 
> > enabling BLK_DEV_UB - and I doubt the warning in the help text added 
> > after 2.6.9 will fix all such problems.
> > 
> > Is there except for kernel size any good reason for using BLK_DEV_UB 
> > instead of USB_STORAGE?
> 
> You don't want to use the scsi layer?  You like the stability of it at
> times?  :)
> 
> > If not, I'd suggest the patch below to let BLK_DEV_UB depend
> > on EMBEDDED.
> 
> No, it's good for non-embedded boxes too.


My current understanding is:
- BLK_DEV_UB supports a subset of what USB_STORAGE can support
- for an average user, there's no reason to enable BLK_DEV_UB
- if you really know what you are doing, there might be several reasons
  why you might want to use BLK_DEV_UB


What about the patch below to let BLK_DEV_UB depend on USB_STORAGE=n?

If you really know what you are doing, you'll also know that you have to
set USB_STORAGE=n before you can enable BLK_DEV_UB.


diffstat output:
 drivers/block/Kconfig              |    2 +-
 drivers/usb/storage/unusual_devs.h |    2 --
 drivers/usb/storage/usb.c          |    4 ----
 3 files changed, 1 insertion(+), 7 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc3-mm1-full/drivers/block/Kconfig.old	2004-12-20 00:52:22.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/drivers/block/Kconfig	2004-12-23 03:09:14.000000000 +0100
@@ -303,7 +303,7 @@
 
 config BLK_DEV_UB
 	tristate "Low Performance USB Block driver"
-	depends on USB
+	depends on USB && USB_STORAGE=n
 	help
 	  This driver supports certain USB attached storage devices
 	  such as flash keys.
--- linux-2.6.10-rc3-mm1-full/drivers/usb/storage/unusual_devs.h.old	2004-12-23 03:09:42.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/drivers/usb/storage/unusual_devs.h	2004-12-23 03:09:53.000000000 +0100
@@ -549,13 +549,11 @@
 		US_SC_SCSI, US_PR_CB, NULL,
 		US_FL_SINGLE_LUN ),
 
-#if !defined(CONFIG_BLK_DEV_UB) && !defined(CONFIG_BLK_DEV_UB_MODULE)
 UNUSUAL_DEV(  0x0781, 0x0002, 0x0009, 0x0009, 
 		"Sandisk",
 		"ImageMate SDDR-31",
 		US_SC_DEVICE, US_PR_DEVICE, NULL,
 		US_FL_IGNORE_SER ),
-#endif
 
 UNUSUAL_DEV(  0x0781, 0x0100, 0x0100, 0x0100,
 		"Sandisk",
--- linux-2.6.10-rc3-mm1-full/drivers/usb/storage/usb.c.old	2004-12-23 03:10:00.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/drivers/usb/storage/usb.c	2004-12-23 03:10:13.000000000 +0100
@@ -144,9 +144,7 @@
 	{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_QIC, US_PR_BULK) },
 	{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_UFI, US_PR_BULK) },
 	{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_8070, US_PR_BULK) },
-#if !defined(CONFIG_BLK_DEV_UB) && !defined(CONFIG_BLK_DEV_UB_MODULE)
 	{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_SCSI, US_PR_BULK) },
-#endif
 
 	/* Terminating entry */
 	{ }
@@ -220,10 +218,8 @@
 	  .useTransport = US_PR_BULK},
 	{ .useProtocol = US_SC_8070,
 	  .useTransport = US_PR_BULK},
-#if !defined(CONFIG_BLK_DEV_UB) && !defined(CONFIG_BLK_DEV_UB_MODULE)
 	{ .useProtocol = US_SC_SCSI,
 	  .useTransport = US_PR_BULK},
-#endif
 
 	/* Terminating entry */
 	{ NULL }
