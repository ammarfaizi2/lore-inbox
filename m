Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264228AbUDNOFE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 10:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264235AbUDNOFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 10:05:04 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:61607 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S264228AbUDNOE7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 10:04:59 -0400
From: Duncan Sands <baldrick@free.fr>
To: Oliver Neukum <oliver@neukum.org>, Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] [PATCH 8/9] USB usbfs: missing lock in proc_getdriver
Date: Wed, 14 Apr 2004 16:04:57 +0200
User-Agent: KMail/1.5.4
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Frederic Detienne <fd@cisco.com>
References: <200404141247.24227.baldrick@free.fr> <200404141337.28631.baldrick@free.fr> <200404141529.06710.oliver@neukum.org>
In-Reply-To: <200404141529.06710.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404141604.57716.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

> I expect it to rarely matter, but it might matter now and then. It's
> just a question of hygiene. If you are using a temporary buffer I'd
> like to see it used to full advantage. So either drop the lock or do
> a direct copy. I'd prefer the first option your patch implemented.

I agree.  Greg, please consider applying the updated patch:

--- gregkh-2.6/drivers/usb/core/devio.c.orig	2004-04-14 16:02:44.000000000 +0200
+++ gregkh-2.6/drivers/usb/core/devio.c	2004-04-14 16:03:12.000000000 +0200
@@ -702,13 +708,15 @@
 		return -EFAULT;
 	if ((ret = findintfif(ps->dev, gd.interface)) < 0)
 		return ret;
+	down_read(&usb_bus_type.subsys.rwsem);
 	interface = ps->dev->actconfig->interface[ret];
-	if (!interface->dev.driver)
+	if (!interface || !interface->dev.driver) {
+		up_read(&usb_bus_type.subsys.rwsem);
 		return -ENODATA;
+	}
 	strncpy(gd.driver, interface->dev.driver->name, sizeof(gd.driver));
-	if (copy_to_user(arg, &gd, sizeof(gd)))
-		return -EFAULT;
-	return 0;
+	up_read(&usb_bus_type.subsys.rwsem);
+	return copy_to_user(arg, &gd, sizeof(gd)) ? -EFAULT : 0;
 }
 
 static int proc_connectinfo(struct dev_state *ps, void __user *arg)

