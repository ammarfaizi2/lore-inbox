Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbTKTKJH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 05:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbTKTKI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 05:08:57 -0500
Received: from hermes.iil.intel.com ([192.198.152.99]:58829 "EHLO
	hermes.iil.intel.com") by vger.kernel.org with ESMTP
	id S261598AbTKTKIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 05:08:46 -0500
From: Amir Noam <amir.noam@intel.com>
To: jgarzik@pobox.com, davem@redhat.com
Subject: [PATCH] [bonding] fix creation of /proc/net/bonding dir
Date: Thu, 20 Nov 2003 13:05:41 +0200
User-Agent: KMail/1.5
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311201305.53708.amir.noam@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff, David,

This fix is waiting for almost a month to be applied, and it should
be in 2.4.23. Can one of you, please, apply this and send it to
Marcelo before 2.4.23 is made final?

This fixes a bug that was introduced in 2.4.23-pre5, that causes
problems to users who use multiple bonding modes.

Amir


diff -Narup a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
--- a/drivers/net/bonding/bond_main.c	Thu Oct 23 14:47:31 2003
+++ b/drivers/net/bonding/bond_main.c	Thu Oct 23 17:04:52 2003
@@ -3574,6 +3574,62 @@ static void bond_destroy_proc_info(struc
 		bond->bond_proc_file = NULL;
 	}
 }
+
+/* Create the bonding directory under /proc/net, if doesn't exist yet.
+ * Caller must hold rtnl_lock.
+ */
+static void bond_create_proc_dir(void)
+{
+	int len = strlen(DRV_NAME);
+
+	for (bond_proc_dir = proc_net->subdir; bond_proc_dir;
+	     bond_proc_dir = bond_proc_dir->next) {
+		if ((bond_proc_dir->namelen == len) &&
+		    !memcmp(bond_proc_dir->name, DRV_NAME, len)) {
+			break;
+		}
+	}
+
+	if (!bond_proc_dir) {
+		bond_proc_dir = proc_mkdir(DRV_NAME, proc_net);
+		if (bond_proc_dir) {
+			bond_proc_dir->owner = THIS_MODULE;
+		} else {
+			printk(KERN_WARNING DRV_NAME
+				": Warning: cannot create /proc/net/%s\n",
+				DRV_NAME);
+		}
+	}
+}
+
+/* Destroy the bonding directory under /proc/net, if empty.
+ * Caller must hold rtnl_lock.
+ */
+static void bond_destroy_proc_dir(void)
+{
+	struct proc_dir_entry *de;
+
+	if (!bond_proc_dir) {
+		return;
+	}
+
+	/* verify that the /proc dir is empty */
+	for (de = bond_proc_dir->subdir; de; de = de->next) {
+		/* ignore . and .. */
+		if (*(de->name) != '.') {
+			break;
+		}
+	}
+
+	if (de) {
+		if (bond_proc_dir->owner == THIS_MODULE) {
+			bond_proc_dir->owner = NULL;
+		}
+	} else {
+		remove_proc_entry(DRV_NAME, proc_net);
+		bond_proc_dir = NULL;
+	}
+}
 #endif /* CONFIG_PROC_FS */
 
 /*
@@ -3829,6 +3885,9 @@ static struct notifier_block bond_netdev
 	.notifier_call = bond_netdev_event,
 };
 
+/* De-initialize device specific data.
+ * Caller must hold rtnl_lock.
+ */
 static inline void bond_deinit(struct net_device *dev)
 {
 	struct bonding *bond = dev->priv;
@@ -3840,6 +3899,9 @@ static inline void bond_deinit(struct ne
 #endif
 }
 
+/* Unregister and free all bond devices.
+ * Caller must hold rtnl_lock.
+ */
 static void bond_free_all(void)
 {
 	struct bonding *bond, *nxt;
@@ -3847,16 +3909,13 @@ static void bond_free_all(void)
 	list_for_each_entry_safe(bond, nxt, &bond_dev_list, bond_list) {
 		struct net_device *dev = bond->device;
 
-		unregister_netdev(dev);
+		unregister_netdevice(dev);
 		bond_deinit(dev);
 		free_netdev(dev);
 	}
 
 #ifdef CONFIG_PROC_FS
-	if (bond_proc_dir) {
-		remove_proc_entry(DRV_NAME, proc_net);
-		bond_proc_dir = NULL;
-	}
+	bond_destroy_proc_dir();
 #endif
 }
 
@@ -4234,18 +4293,12 @@ static int __init bonding_init(void)
 		primary = NULL;
 	}
 
+	rtnl_lock();
+
 #ifdef CONFIG_PROC_FS
-	bond_proc_dir = proc_mkdir(DRV_NAME, proc_net);
-	if (bond_proc_dir == NULL)  {
-		printk(KERN_WARNING
-		       "bonding_init(): can not create /proc/net/" DRV_NAME);
-	} else {
-		bond_proc_dir->owner = THIS_MODULE;
-	}
+	bond_create_proc_dir();
 #endif
 
-	rtnl_lock();
-
 	err = 0;
 	for (no = 0; no < max_bonds; no++) {
 		struct net_device *dev;
@@ -4288,18 +4341,21 @@ static int __init bonding_init(void)
 	return 0;
 
 out_err:
-	rtnl_unlock();
-
 	/* free and unregister all bonds that were successfully added */
 	bond_free_all();
 
+	rtnl_unlock();
+
 	return err;
 }
 
 static void __exit bonding_exit(void)
 {
 	unregister_netdevice_notifier(&bond_netdev_notifier);
+
+	rtnl_lock();
 	bond_free_all();
+	rtnl_unlock();
 }
 
 module_init(bonding_init);

