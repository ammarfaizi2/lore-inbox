Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264359AbTDOHW6 (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 03:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264382AbTDOHW6 (for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 03:22:58 -0400
Received: from granite.he.net ([216.218.226.66]:32261 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S264359AbTDOHW4 (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 03:22:56 -0400
Date: Tue, 15 Apr 2003 00:37:07 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [PATCH] add CONFIG_DEBUG_DEV_PRINTK
Message-ID: <20030415073707.GA9416@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I don't want to remember how many times I've gotten burned by the
dev_printk() function while developing drivers, as it doesn't check for
valid pointers before dereferencing them.  So here's a patch I've
started using that might help out any kernel driver developers in the
same situation.  For device busses that support hotplug, this patch is a
lifesaver (the dev->driver pointer has a fun habit of going away pretty
early during disconnect...)

I'm not pushing for submission to the main kernel tree, unless others
really feel it's useful.

greg k-h


# added CONFIG_DEBUG_DEV_PRINTK option to keep my sanity during development.

diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	Mon Apr 14 11:46:36 2003
+++ b/arch/i386/Kconfig	Mon Apr 14 11:46:36 2003
@@ -1504,6 +1504,13 @@
 	  This options enables addition error checking for high memory systems.
 	  Disable for production systems.
 
+config DEBUG_DEV_PRINTK
+	bool "Debug dev_printk"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here, all dev_printk() parameters will be checked before
+	  dev_printk() is called.  This is useful when debugging new drivers.
+
 config KALLSYMS
 	bool "Load all symbols for debugging/kksymoops"
 	help
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	Mon Apr 14 11:46:36 2003
+++ b/include/linux/device.h	Mon Apr 14 11:46:36 2003
@@ -379,8 +379,20 @@
 extern void firmware_unregister(struct subsystem *);
 
 /* debugging and troubleshooting/diagnostic helpers. */
+#ifdef CONFIG_DEBUG_DEV_PRINTK
+#define dev_printk(level, dev, format, arg...)			\
+	do {							\
+		if (!(dev) || !(dev)->driver)			\
+			WARN_ON(1);				\
+		else						\
+			printk(level "%s %s: " format , 	\
+				(dev)->driver->name , 		\
+				(dev)->bus_id , ## arg);	\
+	} while (0)
+#else
 #define dev_printk(level, dev, format, arg...)	\
 	printk(level "%s %s: " format , (dev)->driver->name , (dev)->bus_id , ## arg)
+#endif
 
 #ifdef DEBUG
 #define dev_dbg(dev, format, arg...)		\
