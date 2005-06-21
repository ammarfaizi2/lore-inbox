Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261472AbVFUOe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbVFUOe1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 10:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbVFUOe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 10:34:27 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:53256 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262118AbVFUOce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 10:32:34 -0400
Date: Tue, 21 Jun 2005 16:32:27 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Steven Rostedt <rostedt@goodmis.org>, gregkh@suse.de
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: [RFC: 2.6 patch] better USB_MON dependencies
Message-ID: <20050621143227.GO3666@stusta.de>
References: <Pine.LNX.4.58.0506172156220.7916@ppc970.osdl.org> <1119119175.6786.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119119175.6786.4.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 18, 2005 at 02:26:15PM -0400, Steven Rostedt wrote:
> On Fri, 2005-06-17 at 22:13 -0700, Linus Torvalds wrote:
> > As some people may have noticed already, 2.6.12 is out there now.
> 
> I just downloaded it, copied my 2.6.11.2 config over and did a make
> oldconfig.  On USB Mon I got the following in the help.
> 
> -------------
> If you say Y here, a component which captures the USB traffic
> between peripheral-specific drivers and HC drivers will be built.
> The USB_MON is similar in spirit and may be compatible with Dave
> Harding's USBMon.
> 
> This is somewhat experimental at this time, but it should be safe,
> as long as you aren't building this as a module and then removing it.
> 
> If unsure, say Y. Do not say M.
> 
>   USB Monitor (USB_MON) [M/n/?] (NEW)
> --------------
> 
> I really like my options. :-)
> 
> OK, I have CONFIG_USB as a module, but I really thought that this was
> pretty amusing.

The patch below tries to solve this in a better way.

> -- Steve

cu
Adrian


<--  snip  -->


This patch makes the USB_MON less confusing.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/usb/Makefile     |    4 +++-
 drivers/usb/core/hcd.c   |    2 +-
 drivers/usb/core/hcd.h   |    2 +-
 drivers/usb/mon/Kconfig  |   13 ++++---------
 drivers/usb/mon/Makefile |    2 +-
 include/linux/usb.h      |    2 +-
 6 files changed, 11 insertions(+), 14 deletions(-)

--- linux-2.6.12-mm1-full/drivers/usb/mon/Kconfig.old	2005-06-21 16:01:03.000000000 +0200
+++ linux-2.6.12-mm1-full/drivers/usb/mon/Kconfig	2005-06-21 16:02:13.000000000 +0200
@@ -2,13 +2,9 @@
 # USB Monitor configuration
 #
 
-# In normal life, it makes little sense to have usbmon as a module, and in fact
-# it is harmful, because there is no way to autoload the module.
-# The 'm' option is allowed for hackers who debug the usbmon itself,
-# and for those who have usbcore as a module.
 config USB_MON
-	tristate "USB Monitor"
-	depends on USB
+	bool "USB Monitor"
+	depends on USB!=n
 	default y
 	help
 	  If you say Y here, a component which captures the USB traffic
@@ -17,6 +13,5 @@
 	  Harding's USBMon.
 
 	  This is somewhat experimental at this time, but it should be safe,
-	  as long as you aren't building this as a module and then removing it.
-
-	  If unsure, say Y. Do not say M.
+	  as long as you aren't using modular USB and try to remove this
+	  module.
--- linux-2.6.12-mm1-full/drivers/usb/Makefile.old	2005-06-21 16:03:35.000000000 +0200
+++ linux-2.6.12-mm1-full/drivers/usb/Makefile	2005-06-21 16:04:27.000000000 +0200
@@ -6,7 +6,9 @@
 
 obj-$(CONFIG_USB)		+= core/
 
-obj-$(CONFIG_USB_MON)		+= mon/
+ifdef CONFIG_USB_MON
+  obj-$(CONFIG_USB)		+= mon/
+endif
 
 obj-$(CONFIG_USB_EHCI_HCD)	+= host/
 obj-$(CONFIG_USB_ISP116X_HCD)	+= host/
--- linux-2.6.12-mm1-full/drivers/usb/mon/Makefile.old	2005-06-21 16:02:29.000000000 +0200
+++ linux-2.6.12-mm1-full/drivers/usb/mon/Makefile	2005-06-21 16:03:09.000000000 +0200
@@ -4,4 +4,4 @@
 
 usbmon-objs	:= mon_main.o mon_stat.o mon_text.o
 
-obj-$(CONFIG_USB_MON)	+= usbmon.o
+obj-$(CONFIG_USB)	+= usbmon.o
--- linux-2.6.12-mm1-full/include/linux/usb.h.old	2005-06-21 16:04:38.000000000 +0200
+++ linux-2.6.12-mm1-full/include/linux/usb.h	2005-06-21 16:04:44.000000000 +0200
@@ -290,7 +290,7 @@
 	struct class_device *class_dev;	/* class device for this bus */
 	struct kref kref;		/* handles reference counting this bus */
 	void (*release)(struct usb_bus *bus);	/* function to destroy this bus's memory */
-#if defined(CONFIG_USB_MON) || defined(CONFIG_USB_MON_MODULE)
+#if defined(CONFIG_USB_MON)
 	struct mon_bus *mon_bus;	/* non-null when associated */
 	int monitored;			/* non-zero when monitored */
 #endif
--- linux-2.6.12-mm1-full/drivers/usb/core/hcd.h.old	2005-06-21 16:05:02.000000000 +0200
+++ linux-2.6.12-mm1-full/drivers/usb/core/hcd.h	2005-06-21 16:05:08.000000000 +0200
@@ -410,7 +410,7 @@
 
 /*-------------------------------------------------------------------------*/
 
-#if defined(CONFIG_USB_MON) || defined(CONFIG_USB_MON_MODULE)
+#if defined(CONFIG_USB_MON)
 
 struct usb_mon_operations {
 	void (*urb_submit)(struct usb_bus *bus, struct urb *urb);
--- linux-2.6.12-mm1-full/drivers/usb/core/hcd.c.old	2005-06-21 16:05:21.000000000 +0200
+++ linux-2.6.12-mm1-full/drivers/usb/core/hcd.c	2005-06-21 16:05:27.000000000 +0200
@@ -1855,7 +1855,7 @@
 
 /*-------------------------------------------------------------------------*/
 
-#if defined(CONFIG_USB_MON) || defined(CONFIG_USB_MON_MODULE)
+#if defined(CONFIG_USB_MON)
 
 struct usb_mon_operations *mon_ops;
 

