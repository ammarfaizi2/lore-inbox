Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262917AbUBZSyl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 13:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262885AbUBZSyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 13:54:33 -0500
Received: from mail.kroah.org ([65.200.24.183]:49092 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262917AbUBZSxj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 13:53:39 -0500
Date: Thu, 26 Feb 2004 10:53:24 -0800
From: Greg KH <greg@kroah.com>
To: Deepak Saxena <dsaxena@plexity.net>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Fix dev_printk to work with unclaimed devices
Message-ID: <20040226185324.GA11980@kroah.com>
References: <20040226183439.GA17722@plexity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040226183439.GA17722@plexity.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 26, 2004 at 11:34:39AM -0700, Deepak Saxena wrote:
> 
> I need to do some fixup in platform_notify() and when trying to 
> use the dev_* print functions for informational messages, they OOPs 
> b/c the current code assumes that dev->driver exists. This is not the 
> case since platform_notify() is called before a device has been attached
> to any driver. 

Yeah, this "limitation" of the dev_* printks have been known for a
while, and it was determined that for situations like this, it's not
worth using those calls.

I have a patch somewhere in my tree that will give you a nice WARN()
output if this ever happens, so as to help when trying to port a new bus
to the driver model, but it's too ugly for mainline.  Ah, found it, it's
below...

thanks,

greg k-h


diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	Thu Feb 26 10:48:37 2004
+++ b/include/linux/device.h	Thu Feb 26 10:48:37 2004
@@ -394,8 +394,20 @@
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
