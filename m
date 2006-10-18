Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422824AbWJRUKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422824AbWJRUKU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 16:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422814AbWJRUKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 16:10:06 -0400
Received: from cantor.suse.de ([195.135.220.2]:11442 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422808AbWJRUJT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 16:09:19 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 5/16] sysfs: remove duplicated dput in sysfs_update_file
Date: Wed, 18 Oct 2006 13:08:56 -0700
Message-Id: <11612021603361-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.4
In-Reply-To: <11612021563449-git-send-email-greg@kroah.com>
References: <20061018195833.GA21808@kroah.com> <1161202147758-git-send-email-greg@kroah.com> <11612021503109-git-send-email-greg@kroah.com> <1161202153578-git-send-email-greg@kroah.com> <11612021563449-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>

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
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index 146f1de..93218cc 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -483,11 +483,6 @@ int sysfs_update_file(struct kobject * k
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
-- 
1.4.2.4

