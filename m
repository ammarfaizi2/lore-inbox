Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964835AbVIMQKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbVIMQKV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 12:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964837AbVIMQKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 12:10:21 -0400
Received: from serv01.siteground.net ([70.85.91.68]:31370 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S964835AbVIMQKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 12:10:20 -0400
Date: Tue, 13 Sep 2005 09:10:12 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, dipankar@in.ibm.com, bharata@in.ibm.com,
       shai@scalex86.org, Rusty Russell <rusty@rustcorp.com.au>,
       netdev@vger.kernel.org, davem@davemloft.net
Subject: [patch 7/11] net: Use bigrefs for net_device.refcount
Message-ID: <20050913161012.GI3570@localhost.localdomain>
References: <20050913155112.GB3570@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050913155112.GB3570@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The net_device has a refcnt used to keep track of it's uses.
This is used at the time of unregistering the network device
(module unloading ..) (see netdev_wait_allrefs) .
For loopback_dev , this refcnt increment/decrement  is causing
unnecessary traffic on the interlink for NUMA system
affecting it's performance.  This patch improves tbench numbers by 6% on a
8way x86 Xeon (x445).

This patch is dependent on the bigref patch 

Signed-off-by : Niraj Kumar <nirajk@calsoftinc.com>
Signed-off-by : Shai Fultheim <shai@scalex86.org>
Signed-off-by : Ravikiran Thirumalai <kiran@scalex86.org>

Index: alloc_percpu-2.6.13/drivers/net/loopback.c
===================================================================
--- alloc_percpu-2.6.13.orig/drivers/net/loopback.c	2005-08-28 16:41:01.000000000 -0700
+++ alloc_percpu-2.6.13/drivers/net/loopback.c	2005-09-12 12:04:25.000000000 -0700
@@ -226,6 +226,12 @@
 		loopback_dev.priv = stats;
 		loopback_dev.get_stats = &get_stats;
 	}
+
+	/* 
+	 * This is the only struct net_device not allocated by alloc_netdev
+	 * So explicitly init the bigref hanging off loopback_dev
+	 */
+	bigref_init(&loopback_dev.netdev_refcnt);
 	
 	return register_netdev(&loopback_dev);
 };
Index: alloc_percpu-2.6.13/include/linux/netdevice.h
===================================================================
--- alloc_percpu-2.6.13.orig/include/linux/netdevice.h	2005-08-28 16:41:01.000000000 -0700
+++ alloc_percpu-2.6.13/include/linux/netdevice.h	2005-09-12 11:54:21.000000000 -0700
@@ -37,6 +37,7 @@
 #include <linux/config.h>
 #include <linux/device.h>
 #include <linux/percpu.h>
+#include <linux/bigref.h>
 
 struct divert_blk;
 struct vlan_group;
@@ -377,7 +378,7 @@
 	/* device queue lock */
 	spinlock_t		queue_lock;
 	/* Number of references to this device */
-	atomic_t		refcnt;
+	struct bigref	        netdev_refcnt;	
 	/* delayed register/unregister */
 	struct list_head	todo_list;
 	/* device name hash chain */
@@ -677,11 +678,11 @@
 
 static inline void dev_put(struct net_device *dev)
 {
-	atomic_dec(&dev->refcnt);
+	bigref_put(&dev->netdev_refcnt, NULL);
 }
 
-#define __dev_put(dev) atomic_dec(&(dev)->refcnt)
-#define dev_hold(dev) atomic_inc(&(dev)->refcnt)
+#define __dev_put(dev) bigref_put(&(dev)->netdev_refcnt, NULL);
+#define dev_hold(dev) bigref_get(&(dev)->netdev_refcnt);
 
 /* Carrier loss detection, dial on demand. The functions netif_carrier_on
  * and _off may be called from IRQ context, but it is caller
Index: alloc_percpu-2.6.13/net/core/dev.c
===================================================================
--- alloc_percpu-2.6.13.orig/net/core/dev.c	2005-08-28 16:41:01.000000000 -0700
+++ alloc_percpu-2.6.13/net/core/dev.c	2005-09-12 11:54:21.000000000 -0700
@@ -2658,6 +2658,7 @@
 		goto out;
 
 	dev->iflink = -1;
+	bigref_set(&dev->netdev_refcnt, 0);
 
 	/* Init, if this function is available */
 	if (dev->init) {
@@ -2808,7 +2809,7 @@
 	unsigned long rebroadcast_time, warning_time;
 
 	rebroadcast_time = warning_time = jiffies;
-	while (atomic_read(&dev->refcnt) != 0) {
+	while ( bigref_val(&dev->netdev_refcnt) != 0) {
 		if (time_after(jiffies, rebroadcast_time + 1 * HZ)) {
 			rtnl_shlock();
 
@@ -2838,7 +2839,7 @@
 			printk(KERN_EMERG "unregister_netdevice: "
 			       "waiting for %s to become free. Usage "
 			       "count = %d\n",
-			       dev->name, atomic_read(&dev->refcnt));
+			       dev->name, bigref_val(&dev->netdev_refcnt));
 			warning_time = jiffies;
 		}
 	}
@@ -2909,7 +2910,7 @@
 			netdev_wait_allrefs(dev);
 
 			/* paranoia */
-			BUG_ON(atomic_read(&dev->refcnt));
+			BUG_ON(bigref_val(&dev->netdev_refcnt));
 			BUG_TRAP(!dev->ip_ptr);
 			BUG_TRAP(!dev->ip6_ptr);
 			BUG_TRAP(!dev->dn_ptr);
@@ -2969,6 +2970,7 @@
 
 	setup(dev);
 	strcpy(dev->name, name);
+	bigref_init(&dev->netdev_refcnt);
 	return dev;
 }
 EXPORT_SYMBOL(alloc_netdev);
@@ -2986,6 +2988,7 @@
 #ifdef CONFIG_SYSFS
 	/*  Compatiablity with error handling in drivers */
 	if (dev->reg_state == NETREG_UNINITIALIZED) {
+		bigref_destroy(&dev->netdev_refcnt);
 		kfree((char *)dev - dev->padded);
 		return;
 	}
@@ -2996,6 +2999,7 @@
 	/* will free via class release */
 	class_device_put(&dev->class_dev);
 #else
+	bigref_destroy(&dev->netdev_refcnt);
 	kfree((char *)dev - dev->padded);
 #endif
 }
@@ -3210,7 +3214,7 @@
 		set_bit(__LINK_STATE_START, &queue->backlog_dev.state);
 		queue->backlog_dev.weight = weight_p;
 		queue->backlog_dev.poll = process_backlog;
-		atomic_set(&queue->backlog_dev.refcnt, 1);
+		bigref_init(&queue->backlog_dev.netdev_refcnt);
 	}
 
 	dev_boot_phase = 0;
Index: alloc_percpu-2.6.13/net/core/net-sysfs.c
===================================================================
--- alloc_percpu-2.6.13.orig/net/core/net-sysfs.c	2005-08-28 16:41:01.000000000 -0700
+++ alloc_percpu-2.6.13/net/core/net-sysfs.c	2005-09-12 11:54:21.000000000 -0700
@@ -16,6 +16,7 @@
 #include <net/sock.h>
 #include <linux/rtnetlink.h>
 #include <linux/wireless.h>
+#include <linux/bigref.h>
 
 #define to_class_dev(obj) container_of(obj,struct class_device,kobj)
 #define to_net_dev(class) container_of(class, struct net_device, class_dev)
@@ -400,6 +401,8 @@
 		= container_of(cd, struct net_device, class_dev);
 
 	BUG_ON(dev->reg_state != NETREG_RELEASED);
+	
+	bigref_destroy(&dev->netdev_refcnt);
 
 	kfree((char *)dev - dev->padded);
 }
