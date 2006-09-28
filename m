Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751636AbWI1HCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636AbWI1HCm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 03:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751641AbWI1HCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 03:02:42 -0400
Received: from ns1.suse.de ([195.135.220.2]:32188 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751622AbWI1HCm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 03:02:42 -0400
Subject: patch sysfs-remove-duplicated-dput-in-sysfs_update_file.patch added to gregkh-2.6 tree
To: seto.hidetoshi@jp.fujitsu.com, gregkh@suse.de,
       linux-kernel@vger.kernel.org, maneesh@in.ibm.com
From: <gregkh@suse.de>
Date: Thu, 28 Sep 2006 00:02:42 -0700
In-Reply-To: <4510EFD8.2050608@jp.fujitsu.com>
Message-Id: <20060928070239.18FE19017C4@imap.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: sysfs: remove duplicated dput in sysfs_update_file

to my gregkh-2.6 tree.  Its filename is

     sysfs-remove-duplicated-dput-in-sysfs_update_file.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


>From seto.hidetoshi@jp.fujitsu.com Wed Sep 20 00:35:46 2006
Message-ID: <4510EFD8.2050608@jp.fujitsu.com>
Date: Wed, 20 Sep 2006 16:38:00 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
To: Greg KH <gregkh@suse.de>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: sysfs: remove duplicated dput in sysfs_update_file

Following function can drops d_count twice against one reference
by lookup_one_len.

<SOURCE>
/**
 * sysfs_update_file - update the modified timestamp on an object attribute.
 * @kobj: object we're acting for.
 * @attr: attribute descriptor.
 */
int sysfs_update_file(struct kobject * kobj, const struct attribute * attr)
{
        struct dentry * dir = kobj->dentry;
        struct dentry * victim;
        int res = -ENOENT;

        mutex_lock(&dir->d_inode->i_mutex);
        victim = lookup_one_len(attr->name, dir, strlen(attr->name));
        if (!IS_ERR(victim)) {
                /* make sure dentry is really there */
                if (victim->d_inode &&
                    (victim->d_parent->d_inode == dir->d_inode)) {
                        victim->d_inode->i_mtime = CURRENT_TIME;
                        fsnotify_modify(victim);

                        /**
                         * Drop reference from initial sysfs_get_dentry().
                         */
                        dput(victim);
                        res = 0;
                } else
                        d_drop(victim);

                /**
                 * Drop the reference acquired from sysfs_get_dentry() above.
                 */
                dput(victim);
        }
        mutex_unlock(&dir->d_inode->i_mutex);

        return res;
}
</SOURCE>

PCI-hotplug (drivers/pci/hotplug/pci_hotplug_core.c) is only user of
this function. I confirmed that dentry of /sys/bus/pci/slots/XXX/*
have negative d_count value.

This patch removes unnecessary dput().

Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Acked-by: Maneesh Soni <maneesh@in.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 fs/sysfs/file.c |    5 -----
 1 file changed, 5 deletions(-)

--- gregkh-2.6.orig/fs/sysfs/file.c
+++ gregkh-2.6/fs/sysfs/file.c
@@ -497,11 +497,6 @@ int sysfs_update_file(struct kobject * k
 		    (victim->d_parent->d_inode == dir->d_inode)) {
 			victim->d_inode->i_mtime = CURRENT_TIME;
 			fsnotify_modify(victim);
-
-			/**
-			 * Drop reference from initial sysfs_get_dentry().
-			 */
-			dput(victim);
 			res = 0;
 		} else
 			d_drop(victim);


Patches currently in gregkh-2.6 which might be from seto.hidetoshi@jp.fujitsu.com are

driver/sysfs-remove-duplicated-dput-in-sysfs_update_file.patch
driver/sysfs-update-obsolete-comment-in-sysfs_update_file.patch
