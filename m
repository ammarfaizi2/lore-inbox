Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264045AbUDNKrn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 06:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264042AbUDNKrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 06:47:42 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:46209 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S264047AbUDNKr0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 06:47:26 -0400
From: Duncan Sands <baldrick@free.fr>
To: Greg KH <greg@kroah.com>
Subject: [PATCH 8/9] USB usbfs: missing lock in proc_getdriver
Date: Wed, 14 Apr 2004 12:47:24 +0200
User-Agent: KMail/1.5.4
Cc: linux-usb-devel@lists.sf.net, linux-kernel@vger.kernel.org,
       Frederic Detienne <fd@cisco.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404141247.24227.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Protect against driver binding changes while reading the driver name.

 devio.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)


diff -Nru a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
--- a/drivers/usb/core/devio.c	Wed Apr 14 12:18:30 2004
+++ b/drivers/usb/core/devio.c	Wed Apr 14 12:18:30 2004
@@ -709,12 +709,14 @@
 	if ((ret = findintfif(ps->dev, gd.interface)) < 0)
 		return ret;
 	interface = ps->dev->actconfig->interface[ret];
-	if (!interface->dev.driver)
-		return -ENODATA;
-	strncpy(gd.driver, interface->dev.driver->name, sizeof(gd.driver));
-	if (copy_to_user(arg, &gd, sizeof(gd)))
-		return -EFAULT;
-	return 0;
+	ret = -ENODATA;
+	down_read(&usb_bus_type.subsys.rwsem);
+	if (interface && interface->dev.driver) {
+		strncpy(gd.driver, interface->dev.driver->name, sizeof(gd.driver));
+		ret = copy_to_user(arg, &gd, sizeof(gd)) ? -EFAULT : 0;
+	}
+	up_read(&usb_bus_type.subsys.rwsem);
+	return ret;
 }
 
 static int proc_connectinfo(struct dev_state *ps, void __user *arg)
