Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbUDJUQu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 16:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbUDJUQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 16:16:50 -0400
Received: from linux-bt.org ([217.160.111.169]:33238 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S261931AbUDJUQr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 16:16:47 -0400
Subject: Re: [PATCH] Add sysfs class support for CAPI
From: Marcel Holtmann <marcel@holtmann.org>
To: Greg KH <greg@kroah.com>
Cc: Karsten Keil <kkeil@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux ISDN Mailing List <isdn4linux@listserv.isdn4linux.de>
In-Reply-To: <20040409183220.GA16842@kroah.com>
References: <1081516925.13202.8.camel@pegasus>
	 <20040409183220.GA16842@kroah.com>
Content-Type: multipart/mixed; boundary="=-etQveUa5PgIBvcPXa/Zo"
Message-Id: <1081628187.5398.36.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 10 Apr 2004 22:16:27 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-etQveUa5PgIBvcPXa/Zo
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Greg,

this patch fixes a bug in the CAPI TTY support, because the ->name value
of the TTY driver shouldn't contain a "/". After changing this there are
now a "capi20" TTY device and a "capi20" control device and so I renamed
the control device to "capi". The userspace visible part must be done by
udev and I added these two rules to restore the old namespace:

	# CAPI devices
	KERNEL="capi",          NAME="capi20", SYMLINK="isdn/capi20"
	KERNEL="capi*",         NAME="capi/%n"

Regards

Marcel


--=-etQveUa5PgIBvcPXa/Zo
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

===== drivers/isdn/capi/capi.c 1.52 vs edited =====
--- 1.52/drivers/isdn/capi/capi.c	Sat Apr 10 22:04:37 2004
+++ edited/drivers/isdn/capi/capi.c	Sat Apr 10 22:06:20 2004
@@ -1316,7 +1316,8 @@
 
 	drv->owner = THIS_MODULE;
 	drv->driver_name = "capi_nc";
-	drv->name = "capi/";
+	drv->devfs_name = "capi/";
+	drv->name = "capi";
 	drv->major = capi_ttymajor;
 	drv->minor_start = 0;
 	drv->type = TTY_DRIVER_TYPE_SERIAL;
@@ -1492,7 +1493,7 @@
 		return PTR_ERR(capi_class);
 	}
 
-	class_simple_device_add(capi_class, MKDEV(capi_major, 0), NULL, "capi20");
+	class_simple_device_add(capi_class, MKDEV(capi_major, 0), NULL, "capi");
 	devfs_mk_cdev(MKDEV(capi_major, 0), S_IFCHR | S_IRUSR | S_IWUSR,
 			"isdn/capi20");
 

--=-etQveUa5PgIBvcPXa/Zo--

