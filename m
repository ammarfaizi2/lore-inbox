Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263248AbTIWEJU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 00:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263254AbTIWEJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 00:09:20 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:26615 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263248AbTIWEJS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 00:09:18 -0400
Date: Tue, 23 Sep 2003 09:39:45 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Patrick Mochel <mochel@osdl.org>, Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH 2.6] sysfs_remove_dir
Message-ID: <20030923040945.GA1323@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20030915102127.GA1387@in.ibm.com> <Pine.LNX.4.44.0309191556281.950-100000@localhost.localdomain> <20030922045835.GA18755@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030922045835.GA18755@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Thanks Stephen for letting me know.

Maneesh

Rediffed for 2.6.0-test5.

o attribute group should be removed while unregistering from sysfs. netdev
  does not do this and leaks dentries belonging to the attribute group. 
  The following patch removes the attribute group when netdev is unregistered.


 net/core/dev.c       |    3 ++-
 net/core/net-sysfs.c |   25 +++++++++++++++++++++++--
 2 files changed, 25 insertions(+), 3 deletions(-)

diff -puN net/core/net-sysfs.c~sysfs-dentry-leak-fix net/core/net-sysfs.c
--- linux-2.6.0-test5/net/core/net-sysfs.c~sysfs-dentry-leak-fix	2003-09-23 09:32:01.000000000 +0530
+++ linux-2.6.0-test5-maneesh/net/core/net-sysfs.c	2003-09-23 09:32:23.000000000 +0530
@@ -383,6 +383,21 @@ static struct class net_class = {
 #endif
 };
 
+void netdev_unregister_sysfs(struct net_device * net)
+{
+	struct class_device * class_dev = &(net->class_dev);
+
+	if (net->get_stats)
+		sysfs_remove_group(&class_dev->kobj, &netstat_group);
+
+#ifdef WIRELESS_EXT
+	if (net->get_wireless_stats)
+		sysfs_remove_group(&class_dev->kobj, &wireless_group);
+#endif
+	class_device_del(class_dev);
+
+}
+
 /* Create sysfs entries for network device. */
 int netdev_register_sysfs(struct net_device *net)
 {
@@ -411,9 +426,15 @@ int netdev_register_sysfs(struct net_dev
 #ifdef WIRELESS_EXT
 	if (net->get_wireless_stats &&
 	    (ret = sysfs_create_group(&class_dev->kobj, &wireless_group)))
-		goto out_unreg; 
-#endif
+		goto out_cleanup; 
+
+	return 0;
+out_cleanup:
+	if (net->get_stats)
+		sysfs_remove_group(&class_dev->kobj, &netstat_group);
+#else
 	return 0;
+#endif
 
 out_unreg:
 	printk(KERN_WARNING "%s: sysfs attribute registration failed %d\n",
diff -puN net/core/dev.c~sysfs-dentry-leak-fix net/core/dev.c
--- linux-2.6.0-test5/net/core/dev.c~sysfs-dentry-leak-fix	2003-09-23 09:31:21.000000000 +0530
+++ linux-2.6.0-test5-maneesh/net/core/dev.c	2003-09-23 09:33:04.000000000 +0530
@@ -183,6 +183,7 @@ int netdev_fastroute_obstacles;
 
 extern int netdev_sysfs_init(void);
 extern int netdev_register_sysfs(struct net_device *);
+extern int netdev_unregister_sysfs(struct net_device *);
 
 
 /*******************************************************************************
@@ -2819,7 +2820,7 @@ void netdev_run_todo(void)
 			break;
 
 		case NETREG_UNREGISTERING:
-			class_device_del(&dev->class_dev);
+			netdev_unregister_sysfs(dev);
 			dev->reg_state = NETREG_UNREGISTERED;
 
 			netdev_wait_allrefs(dev);

_
-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-5044999 Fax: 91-80-5268553
T/L : 9243696
