Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262560AbTIVE6O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 00:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262775AbTIVE6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 00:58:13 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:31913 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262560AbTIVE6J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 00:58:09 -0400
Date: Mon, 22 Sep 2003 10:28:35 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>, Hanna Linder <hannal@us.ibm.com>
Subject: Re: [PATCH 2.6] sysfs_remove_dir
Message-ID: <20030922045835.GA18755@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20030915102127.GA1387@in.ibm.com> <Pine.LNX.4.44.0309191556281.950-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309191556281.950-100000@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 19, 2003 at 04:02:15PM -0700, Patrick Mochel wrote:
> 
> > sysfs_remove_dir() does not remove the contents of subdirs corresponding
> > to the attribute groups of a kobject. The following patch fixes this by first
> > removing the subdir contents and then removing thus emptied subdirs along
> > with the other attribute files of the kobject and plugs the memory
> > leakage resulting from orphan dentries.
> > 
> > I tested it by inserting and removing "dummy.o" network module and verifying
> > that dentires corresponding to "statistics" attribute group are removed.
> 
> Sorry it's taken a while to reply, but I even now haven't had a chance to 
> look that deep into this problem. I will say that this is the wrong 
> approach to the problem. 
> 
> Upon initial inspection, it looks like it will do the right thing in all 
> cases, except when a parent is removed before a child is (but we don't 
> technically support that now). 
> 
> However, I'd like to move away from the automatic cleanup that sysfs was 
> doing. attribute groups make it easier to clean up all the files that are 
> created for an object when the object is removed. I would like to see that 
> removal call inserted where necessary, instead of adding this complication 
> to the sysfs core.
> 
> I intend to remove the automatic cleanup in sysfs_remove_dir(), but 
> haven't gotten around to it.. 
> 

ok.. my intention was not to change callers for removing attribute group and 
keep the changes within sysfs. But if you prefer otherway (I too :-)), please 
see the patch below. As of now I can see only netdev not releasing attribute 
group. I guess power subsystem don't need to remove attribute groups created 
in pm_init() and pm_disk_init() as these don't unregister from sysfs.

Thanks
Maneesh

o attribute group should be removed while unregistering from sysfs. netdev
  does not do this and leaks dentries belonging to the attribute group. 
  The following patch removes the attribute group when netdev is unregistered.


 net/core/dev.c       |    3 ++-
 net/core/net-sysfs.c |   25 +++++++++++++++++++++++--
 2 files changed, 25 insertions(+), 3 deletions(-)

diff -puN net/core/net-sysfs.c~sysfs-dentry-leak-fix net/core/net-sysfs.c
--- linux-2.6.0-test5-mm3/net/core/net-sysfs.c~sysfs-dentry-leak-fix	2003-09-22 09:45:04.000000000 +0530
+++ linux-2.6.0-test5-mm3-maneesh/net/core/net-sysfs.c	2003-09-22 09:45:17.000000000 +0530
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
--- linux-2.6.0-test5-mm3/net/core/dev.c~sysfs-dentry-leak-fix	2003-09-22 09:45:08.000000000 +0530
+++ linux-2.6.0-test5-mm3-maneesh/net/core/dev.c	2003-09-22 09:45:17.000000000 +0530
@@ -183,6 +183,7 @@ int netdev_fastroute_obstacles;
 
 extern int netdev_sysfs_init(void);
 extern int netdev_register_sysfs(struct net_device *);
+extern int netdev_unregister_sysfs(struct net_device *);
 #ifdef CONFIG_KGDB
 extern int kgdb_net_interrupt(struct sk_buff *skb);
 #endif
@@ -2834,7 +2835,7 @@ void netdev_run_todo(void)
 			break;
 
 		case NETREG_UNREGISTERING:
-			class_device_del(&dev->class_dev);
+			netdev_unregister_sysfs(dev);
 			dev->reg_state = NETREG_UNREGISTERED;
 
 			netdev_wait_allrefs(dev);

_

