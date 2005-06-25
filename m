Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbVFYURO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbVFYURO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 16:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVFYURN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 16:17:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58592 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261327AbVFYURE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 16:17:04 -0400
Date: Sat, 25 Jun 2005 13:15:20 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: rostedt@goodmis.org, gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, zaitcev@redhat.com
Subject: Re: [2.6 patch] better USB_MON dependencies
Message-Id: <20050625131520.2cd9eda4.zaitcev@redhat.com>
In-Reply-To: <20050623093656.GC3749@stusta.de>
References: <Pine.LNX.4.58.0506172156220.7916@ppc970.osdl.org>
	<1119119175.6786.4.camel@localhost.localdomain>
	<20050621143227.GO3666@stusta.de>
	<20050621123507.6b83ddf0.zaitcev@redhat.com>
	<20050621210410.GA3705@stusta.de>
	<20050623093656.GC3749@stusta.de>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 1.9.9 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jun 2005 11:36:56 +0200, Adrian Bunk <bunk@stusta.de> wrote:

> I forgot to attach the updated patch...
> Here it is.

I have tested this for all 6 build positions (CONFIG_USB = n, m, y  and
CONFIG_USB_MON = n y) with a positive result. But I thought the help
wordage was not quite what we needed, and the reference to USBMon was
incorrect. So, the attached is just a little different.
Adrian, how about this?

--------------------------------
This makes the configuration of USB_MON less confusing.

Signed-off-by: Pete Zaitcev <zaitcev@redhat.com>

diff -urp -X dontdiff linux-2.6.12/drivers/usb/core/hcd.c linux-2.6.12-lem/drivers/usb/core/hcd.c
--- linux-2.6.12/drivers/usb/core/hcd.c	2005-06-21 12:58:46.000000000 -0700
+++ linux-2.6.12-lem/drivers/usb/core/hcd.c	2005-06-25 12:31:08.000000000 -0700
@@ -1801,7 +1801,7 @@ EXPORT_SYMBOL (usb_remove_hcd);
 
 /*-------------------------------------------------------------------------*/
 
-#if defined(CONFIG_USB_MON) || defined(CONFIG_USB_MON_MODULE)
+#if defined(CONFIG_USB_MON)
 
 struct usb_mon_operations *mon_ops;
 
diff -urp -X dontdiff linux-2.6.12/drivers/usb/core/hcd.h linux-2.6.12-lem/drivers/usb/core/hcd.h
--- linux-2.6.12/drivers/usb/core/hcd.h	2005-06-21 12:58:46.000000000 -0700
+++ linux-2.6.12-lem/drivers/usb/core/hcd.h	2005-06-25 12:31:08.000000000 -0700
@@ -399,7 +399,7 @@ static inline void usbfs_cleanup(void) {
 
 /*-------------------------------------------------------------------------*/
 
-#if defined(CONFIG_USB_MON) || defined(CONFIG_USB_MON_MODULE)
+#if defined(CONFIG_USB_MON)
 
 struct usb_mon_operations {
 	void (*urb_submit)(struct usb_bus *bus, struct urb *urb);
diff -urp -X dontdiff linux-2.6.12/drivers/usb/mon/Kconfig linux-2.6.12-lem/drivers/usb/mon/Kconfig
--- linux-2.6.12/drivers/usb/mon/Kconfig	2005-06-21 12:58:47.000000000 -0700
+++ linux-2.6.12-lem/drivers/usb/mon/Kconfig	2005-06-25 12:35:46.000000000 -0700
@@ -2,21 +2,15 @@
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
 	  between peripheral-specific drivers and HC drivers will be built.
-	  The USB_MON is similar in spirit and may be compatible with Dave
-	  Harding's USBMon.
+	  For more information, see <file:Documentation/usb/usbmon.txt>.
 
-	  This is somewhat experimental at this time, but it should be safe,
-	  as long as you aren't building this as a module and then removing it.
+	  This is somewhat experimental at this time, but it should be safe.
 
-	  If unsure, say Y. Do not say M.
+	  If unsure, say Y.
diff -urp -X dontdiff linux-2.6.12/drivers/usb/mon/Makefile linux-2.6.12-lem/drivers/usb/mon/Makefile
--- linux-2.6.12/drivers/usb/mon/Makefile	2005-06-21 12:58:47.000000000 -0700
+++ linux-2.6.12-lem/drivers/usb/mon/Makefile	2005-06-25 12:39:32.000000000 -0700
@@ -4,4 +4,5 @@
 
 usbmon-objs	:= mon_main.o mon_stat.o mon_text.o
 
-obj-$(CONFIG_USB_MON)	+= usbmon.o
+# This does not use CONFIG_USB_MON because we want this to use a tristate.
+obj-$(CONFIG_USB)	+= usbmon.o
diff -urp -X dontdiff linux-2.6.12/include/linux/usb.h linux-2.6.12-lem/include/linux/usb.h
--- linux-2.6.12/include/linux/usb.h	2005-06-21 12:59:17.000000000 -0700
+++ linux-2.6.12-lem/include/linux/usb.h	2005-06-25 12:31:08.000000000 -0700
@@ -289,7 +289,7 @@ struct usb_bus {
 
 	struct class_device class_dev;	/* class device for this bus */
 	void (*release)(struct usb_bus *bus);	/* function to destroy this bus's memory */
-#if defined(CONFIG_USB_MON) || defined(CONFIG_USB_MON_MODULE)
+#if defined(CONFIG_USB_MON)
 	struct mon_bus *mon_bus;	/* non-null when associated */
 	int monitored;			/* non-zero when monitored */
 #endif
