Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264378AbUDOSRb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 14:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263017AbUDORmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 13:42:52 -0400
Received: from mail.kroah.org ([65.200.24.183]:32438 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263225AbUDORmW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 13:42:22 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core update for 2.6.6-rc1
In-Reply-To: <10820509132751@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Thu, 15 Apr 2004 10:41:53 -0700
Message-Id: <10820509131104@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1643.36.18, 2004/04/12 16:46:07-07:00, marcel@holtmann.org

[PATCH] Fix sysfs class support for CAPI

this patch fixes a bug in the CAPI TTY support, because the ->name value
of the TTY driver shouldn't contain a "/". After changing this there are
now a "capi20" TTY device and a "capi20" control device and so I renamed
the control device to "capi". The userspace visible part must be done by
udev and I added these two rules to restore the old namespace:

	# CAPI devices
	KERNEL="capi",          NAME="capi20", SYMLINK="isdn/capi20"
	KERNEL="capi*",         NAME="capi/%n"


 drivers/isdn/capi/capi.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)


diff -Nru a/drivers/isdn/capi/capi.c b/drivers/isdn/capi/capi.c
--- a/drivers/isdn/capi/capi.c	Thu Apr 15 10:20:08 2004
+++ b/drivers/isdn/capi/capi.c	Thu Apr 15 10:20:08 2004
@@ -1312,7 +1312,8 @@
 
 	drv->owner = THIS_MODULE;
 	drv->driver_name = "capi_nc";
-	drv->name = "capi/";
+	drv->devfs_name = "capi/";
+	drv->name = "capi";
 	drv->major = capi_ttymajor;
 	drv->minor_start = 0;
 	drv->type = TTY_DRIVER_TYPE_SERIAL;
@@ -1488,7 +1489,7 @@
 		return PTR_ERR(capi_class);
 	}
 
-	class_simple_device_add(capi_class, MKDEV(capi_major, 0), NULL, "capi20");
+	class_simple_device_add(capi_class, MKDEV(capi_major, 0), NULL, "capi");
 	devfs_mk_cdev(MKDEV(capi_major, 0), S_IFCHR | S_IRUSR | S_IWUSR,
 			"isdn/capi20");
 

