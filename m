Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbWITHfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWITHfr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 03:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbWITHfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 03:35:47 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:52411 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751262AbWITHfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 03:35:46 -0400
Message-ID: <4510EFD8.2050608@jp.fujitsu.com>
Date: Wed, 20 Sep 2006 16:38:00 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.18] sysfs: remove duplicated dput in sysfs_update_file
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

---
 fs/sysfs/file.c |    5 -----
 1 files changed, 5 deletions(-)

Index: linux-2.6.18/fs/sysfs/file.c
===================================================================
--- linux-2.6.18.orig/fs/sysfs/file.c
+++ linux-2.6.18/fs/sysfs/file.c
@@ -483,11 +483,6 @@
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

