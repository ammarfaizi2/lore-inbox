Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161674AbWAMDVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161674AbWAMDVx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 22:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161667AbWAMDVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 22:21:18 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:39552 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1161663AbWAMDVB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 22:21:01 -0500
Message-Id: <20060113032248.766735000@sorel.sous-sol.org>
References: <20060113032102.154909000@sorel.sous-sol.org>
Date: Thu, 12 Jan 2006 18:37:54 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, arvidjaar@mail.ru,
       jgarzik@pobox.com, davem@davemloft.net
Subject: [PATCH 16/17] " [PATCH] fix /sys/class/net/" <if>/wireless without dev->get_wireless_stats
Content-Disposition: inline; filename=fix-sys-class-net-if-wireless-without-dev-get_wireless_stats.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

dev->get_wireless_stats is deprecated but removing it also removes wireless
subdirectory in sysfs. This patch puts it back.

akpm: I don't know what's happening here.  This might be appropriate as a
2.6.15.x compatibility backport.  Waiting to hear from Jeff.

Signed-off-by: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jeff Garzik <jgarzik@pobox.com>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 net/core/net-sysfs.c |   28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

--- linux-2.6.15.y.orig/net/core/net-sysfs.c
+++ linux-2.6.15.y/net/core/net-sysfs.c
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
-	const struct iw_statistics *iw;
+	const struct iw_statistics *iw = NULL;
 	ssize_t ret = -EINVAL;
 	
 	read_lock(&dev_base_lock);
-	if (dev_isalive(dev) && dev->get_wireless_stats 
-	    && (iw = dev->get_wireless_stats(dev)) != NULL) 
-		ret = (*format)(iw, buf);
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
-	if (net->get_wireless_stats)
+	if (net->get_wireless_stats || (net->wireless_handlers &&
+			net->wireless_handlers->get_wireless_stats))
 		sysfs_remove_group(&class_dev->kobj, &wireless_group);
 #endif
 	class_device_del(class_dev);
@@ -453,10 +461,12 @@ int netdev_register_sysfs(struct net_dev
 		goto out_unreg; 
 
 #ifdef WIRELESS_EXT
-	if (net->get_wireless_stats &&
-	    (ret = sysfs_create_group(&class_dev->kobj, &wireless_group)))
-		goto out_cleanup; 
-
+	if (net->get_wireless_stats || (net->wireless_handlers &&
+			net->wireless_handlers->get_wireless_stats)) {
+		ret = sysfs_create_group(&class_dev->kobj, &wireless_group);
+		if (ret)
+			goto out_cleanup;
+	}
 	return 0;
 out_cleanup:
 	if (net->get_stats)

--
