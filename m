Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932389AbWDUUEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbWDUUEH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 16:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWDUUEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 16:04:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42403 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932378AbWDUUED (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 16:04:03 -0400
Date: Fri, 21 Apr 2006 12:54:38 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Greg KH <greg@kroah.com>, "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] netdev: create attribute_groups with class_device_add
Message-ID: <20060421125438.50f93a34@localhost.localdomain>
In-Reply-To: <20060421125255.3451959f@localhost.localdomain>
References: <20060421125255.3451959f@localhost.localdomain>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Atomically create attributes when class device is added. This avoids the
race between registering class_device (which generates hotplug event),
and the creation of attribute groups.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>


--- sky2-2.6.17.orig/net/core/dev.c	2006-04-21 12:20:58.000000000 -0700
+++ sky2-2.6.17/net/core/dev.c	2006-04-21 12:21:45.000000000 -0700
@@ -3043,11 +3043,11 @@
 
 		switch(dev->reg_state) {
 		case NETREG_REGISTERING:
-			dev->reg_state = NETREG_REGISTERED;
 			err = netdev_register_sysfs(dev);
 			if (err)
 				printk(KERN_ERR "%s: failed sysfs registration (%d)\n",
 				       dev->name, err);
+			dev->reg_state = NETREG_REGISTERED;
 			break;
 
 		case NETREG_UNREGISTERING:
--- sky2-2.6.17.orig/net/core/net-sysfs.c	2006-04-21 12:20:58.000000000 -0700
+++ sky2-2.6.17/net/core/net-sysfs.c	2006-04-21 12:21:45.000000000 -0700
@@ -29,7 +29,7 @@
 
 static inline int dev_isalive(const struct net_device *dev) 
 {
-	return dev->reg_state == NETREG_REGISTERED;
+	return dev->reg_state <= NETREG_REGISTERED;
 }
 
 /* use same locking rules as GIF* ioctl's */
@@ -445,58 +445,33 @@
 
 void netdev_unregister_sysfs(struct net_device * net)
 {
-	struct class_device * class_dev = &(net->class_dev);
-
-	if (net->get_stats)
-		sysfs_remove_group(&class_dev->kobj, &netstat_group);
-
-#ifdef WIRELESS_EXT
-	if (net->get_wireless_stats || (net->wireless_handlers &&
-			net->wireless_handlers->get_wireless_stats))
-		sysfs_remove_group(&class_dev->kobj, &wireless_group);
-#endif
-	class_device_del(class_dev);
-
+	class_device_del(&(net->class_dev));
 }
 
 /* Create sysfs entries for network device. */
 int netdev_register_sysfs(struct net_device *net)
 {
 	struct class_device *class_dev = &(net->class_dev);
-	int ret;
+	struct attribute_group **groups = net->sysfs_groups;
 
+	class_device_initialize(class_dev);
 	class_dev->class = &net_class;
 	class_dev->class_data = net;
+	class_dev->groups = groups;
 
+	BUILD_BUG_ON(BUS_ID_SIZE < IFNAMSIZ);
 	strlcpy(class_dev->class_id, net->name, BUS_ID_SIZE);
-	if ((ret = class_device_register(class_dev)))
-		goto out;
 
-	if (net->get_stats &&
-	    (ret = sysfs_create_group(&class_dev->kobj, &netstat_group)))
-		goto out_unreg; 
+	if (net->get_stats)
+		*groups++ = &netstat_group;
 
 #ifdef WIRELESS_EXT
-	if (net->get_wireless_stats || (net->wireless_handlers &&
-			net->wireless_handlers->get_wireless_stats)) {
-		ret = sysfs_create_group(&class_dev->kobj, &wireless_group);
-		if (ret)
-			goto out_cleanup;
-	}
-	return 0;
-out_cleanup:
-	if (net->get_stats)
-		sysfs_remove_group(&class_dev->kobj, &netstat_group);
-#else
-	return 0;
+	if (net->get_wireless_stats
+	    || (net->wireless_handlers && net->wireless_handlers->get_wireless_stats))
+		*groups++ = &wireless_group;
 #endif
 
-out_unreg:
-	printk(KERN_WARNING "%s: sysfs attribute registration failed %d\n",
-	       net->name, ret);
-	class_device_unregister(class_dev);
-out:
-	return ret;
+	return class_device_add(class_dev);
 }
 
 int netdev_sysfs_init(void)
--- sky2-2.6.17.orig/include/linux/netdevice.h	2006-04-21 12:20:58.000000000 -0700
+++ sky2-2.6.17/include/linux/netdevice.h	2006-04-21 12:21:45.000000000 -0700
@@ -506,6 +506,8 @@
 
 	/* class/net/name entry */
 	struct class_device	class_dev;
+	/* space for optional statistics and wireless sysfs groups */
+	struct attribute_group  *sysfs_groups[3];
 };
 
 #define	NETDEV_ALIGN		32
