Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274200AbSITAti>; Thu, 19 Sep 2002 20:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274203AbSITAti>; Thu, 19 Sep 2002 20:49:38 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:37898 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S274200AbSITAtg>;
	Thu, 19 Sep 2002 20:49:36 -0400
Date: Thu, 19 Sep 2002 17:54:28 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [BK PATCH] PCI hotplug changes for 2.5.36
Message-ID: <20020920005428.GB18583@kroah.com>
References: <20020920005408.GA18583@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020920005408.GA18583@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.557   -> 1.558  
#	drivers/hotplug/pci_hotplug_core.c	1.20    -> 1.21   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/19	scottm@somanetworks.com	1.558
# [PATCH] Small pcihpfs dnotify fix
# 
# I've been working on a userspace daemon to go with my CompactPCI driver,
# and yesterday I discovered an oversight in pci_hp_change_slot_info - it
# doesn't call dnotify_parent, so dnotify based clients basically don't
# work against pcihpfs.  The following patch (against 2.5 BK) reworks
# things to just update the mtime (since we're modifying the file after
# all), and then call dnotify_parent.
# --------------------------------------------
#
diff -Nru a/drivers/hotplug/pci_hotplug_core.c b/drivers/hotplug/pci_hotplug_core.c
--- a/drivers/hotplug/pci_hotplug_core.c	Thu Sep 19 17:50:53 2002
+++ b/drivers/hotplug/pci_hotplug_core.c	Thu Sep 19 17:50:53 2002
@@ -38,6 +38,7 @@
 #include <linux/init.h>
 #include <linux/namei.h>
 #include <linux/pci.h>
+#include <linux/dnotify.h>
 #include <asm/uaccess.h>
 #include "pci_hotplug.h"
 
@@ -1012,10 +1013,13 @@
 	return 0;
 }
 
-static inline void update_inode_time (struct inode *inode)
+static inline void update_dentry_inode_time (struct dentry *dentry)
 {
-	if (inode)
-		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+	struct inode *inode = dentry->d_inode;
+	if (inode) {
+		inode->i_mtime = CURRENT_TIME;
+		dnotify_parent(dentry, DN_MODIFY);
+	}
 }
 
 /**
@@ -1050,16 +1054,16 @@
 	core = temp->core_priv;
 	if ((core->power_dentry) &&
 	    (temp->info->power_status != info->power_status))
-		update_inode_time (core->power_dentry->d_inode);
+		update_dentry_inode_time (core->power_dentry);
 	if ((core->attention_dentry) &&
 	    (temp->info->attention_status != info->attention_status))
-		update_inode_time (core->attention_dentry->d_inode);
+		update_dentry_inode_time (core->attention_dentry);
 	if ((core->latch_dentry) &&
 	    (temp->info->latch_status != info->latch_status))
-		update_inode_time (core->latch_dentry->d_inode);
+		update_dentry_inode_time (core->latch_dentry);
 	if ((core->adapter_dentry) &&
 	    (temp->info->adapter_status != info->adapter_status))
-		update_inode_time (core->adapter_dentry->d_inode);
+		update_dentry_inode_time (core->adapter_dentry);
 
 	memcpy (temp->info, info, sizeof (struct hotplug_slot_info));
 	spin_unlock (&list_lock);
