Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750917AbWABRPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbWABRPV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 12:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbWABRPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 12:15:21 -0500
Received: from mx3.mail.ru ([194.67.23.149]:47428 "EHLO mx3.mail.ru")
	by vger.kernel.org with ESMTP id S1750905AbWABRPU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 12:15:20 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: netdev@vger.kernel.org
Subject: Re: [PATCH][2.6.14.5] fix /sys/class/net/<if>/wireless without dev->get_wireless_stats
Date: Mon, 2 Jan 2006 20:15:12 +0300
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org
References: <200601021349.32823.arvidjaar@mail.ru> <200601021545.59097.ismail@uludag.org.tr>
In-Reply-To: <200601021545.59097.ismail@uludag.org.tr>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601022015.16580.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I accidentally used wrong lkml address, so I resend it now with proper format.

dev->get_wireless_stats is deprecated but removing it also removes wireless
subdirectory in sysfs. This patch puts it back.

Signed-off-by: Andrey Borzenkov <arvidjaar@mail.ru>

- ---

- --- linux-2.6.14.5/net/core/net-sysfs.c.orig	2005-12-27 03:26:33.000000000 +0300
+++ linux-2.6.14.5/net/core/net-sysfs.c	2006-01-02 13:33:34.000000000 +0300
@@ -16,6 +16,7 @@
 #include <net/sock.h>
 #include <linux/rtnetlink.h>
 #include <linux/wireless.h>
+#include <net/iw_handler.h>
 
 #define to_class_dev(obj) container_of(obj,struct class_device,kobj)
 #define to_net_dev(class) container_of(class, struct net_device, class_dev)
@@ -313,13 +314,19 @@ static ssize_t wireless_show(struct clas
 					       char *))
 {
 	struct net_device *dev = to_net_dev(cd);
- -	const struct iw_statistics *iw;
+	const struct iw_statistics *iw = NULL;
 	ssize_t ret = -EINVAL;
 	
 	read_lock(&dev_base_lock);
- -	if (dev_isalive(dev) && dev->get_wireless_stats 
- -	    && (iw = dev->get_wireless_stats(dev)) != NULL) 
- -		ret = (*format)(iw, buf);
+	if (dev_isalive(dev)) {
+		if(dev->wireless_handlers &&
+		   dev->wireless_handlers->get_wireless_stats)
+			iw = dev->wireless_handlers->get_wireless_stats(dev);
+		else if (dev->get_wireless_stats)
+			iw = dev->get_wireless_stats(dev);
+		if (iw != NULL)
+			ret = (*format)(iw, buf);
+	}
 	read_unlock(&dev_base_lock);
 
 	return ret;
@@ -420,7 +427,8 @@ void netdev_unregister_sysfs(struct net_
 		sysfs_remove_group(&class_dev->kobj, &netstat_group);
 
 #ifdef WIRELESS_EXT
- -	if (net->get_wireless_stats)
+	if ((net->get_wireless_stats ||
+	    net->wireless_handlers && net->wireless_handlers->get_wireless_stats))
 		sysfs_remove_group(&class_dev->kobj, &wireless_group);
 #endif
 	class_device_del(class_dev);
@@ -453,7 +461,8 @@ int netdev_register_sysfs(struct net_dev
 		goto out_unreg; 
 
 #ifdef WIRELESS_EXT
- -	if (net->get_wireless_stats &&
+	if ((net->get_wireless_stats ||
+	    net->wireless_handlers && net->wireless_handlers->get_wireless_stats) &&
 	    (ret = sysfs_create_group(&class_dev->kobj, &wireless_group)))
 		goto out_cleanup; 
 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDuV+kR6LMutpd94wRAugpAKChYCaH91dykwqMPGb6Xm5kXmIa0ACePENS
QwHqJFgsCyblXHkUKdZM9j0=
=37cH
-----END PGP SIGNATURE-----
