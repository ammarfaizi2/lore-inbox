Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267344AbTACAZN>; Thu, 2 Jan 2003 19:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267351AbTACAZN>; Thu, 2 Jan 2003 19:25:13 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:50373 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S267344AbTACAZJ>; Thu, 2 Jan 2003 19:25:09 -0500
Date: Thu, 02 Jan 2003 16:39:57 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: 2.5.54 -- ohci-dbg.c: 358: In function `show_list': `data1'
 undeclared (first use in this function)
To: Miles Lane <miles.lane@attbi.com>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       usb devel <linux-usb-devel@lists.sourceforge.net>
Message-id: <3E14DBDD.4080907@pacbell.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_GdTic//VLmsx1OesE4Dyvg)"
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <1041487926.11532.83.camel@bellybutton.attbi.com>
 <3E145998.6020607@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_GdTic//VLmsx1OesE4Dyvg)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT

The attached patch just reverts the "always provide sysfs debug files"
part of Greg's patch.  Gets rid of that compile error as well as
keeping the driver object size smaller.

If we want to have debug files without CONFIG_USB_DEBUG, I'd rather
have them controlled by some other Kconfig option.

- Dave


--Boundary_(ID_GdTic//VLmsx1OesE4Dyvg)
Content-type: text/plain; name=ohci-0102.patch
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=ohci-0102.patch

--- ./drivers/usb-dist/host/ohci-dbg.c	Thu Jan  2 13:18:42 2003
+++ ./drivers/usb/host/ohci-dbg.c	Thu Jan  2 15:04:38 2003
@@ -318,6 +318,10 @@
 	}
 }
 
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2,5,32)
+#	define DRIVERFS_DEBUG_FILES
+#endif
+
 #else
 static inline void ohci_dump (struct ohci_hcd *controller, int verbose) {}
 
@@ -325,6 +329,8 @@
 
 /*-------------------------------------------------------------------------*/
 
+#ifdef DRIVERFS_DEBUG_FILES
+
 static ssize_t
 show_list (struct ohci_hcd *ohci, char *buf, size_t count, struct ed *ed)
 {
@@ -522,5 +528,12 @@
 	device_remove_file (bus->hcd.controller, &dev_attr_periodic);
 }
 
+#else /* empty stubs for creating those files */
+
+static inline void create_debug_files (struct ohci_hcd *bus) { }
+static inline void remove_debug_files (struct ohci_hcd *bus) { }
+
+#endif /* DRIVERFS_DEBUG_FILES */
+
 /*-------------------------------------------------------------------------*/
 

--Boundary_(ID_GdTic//VLmsx1OesE4Dyvg)--
