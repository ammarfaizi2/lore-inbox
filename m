Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbWIZFij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbWIZFij (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbWIZFii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:38:38 -0400
Received: from cantor2.suse.de ([195.135.220.15]:28373 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751303AbWIZFi0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:38:26 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 8/47] SYSFS: allow sysfs_create_link to create symlinks in the root of sysfs
Date: Mon, 25 Sep 2006 22:37:28 -0700
Message-Id: <11592491082990-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.1
In-Reply-To: <1159249104512-git-send-email-greg@kroah.com>
References: <20060926053728.GA8970@kroah.com> <1159249087369-git-send-email-greg@kroah.com> <11592490903867-git-send-email-greg@kroah.com> <11592490933346-git-send-email-greg@kroah.com> <1159249096460-git-send-email-greg@kroah.com> <11592490993970-git-send-email-greg@kroah.com> <11592491023995-git-send-email-greg@kroah.com> <1159249104512-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

This is needed to make the compatible link for /sys/block in the future.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 fs/sysfs/symlink.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/sysfs/symlink.c b/fs/sysfs/symlink.c
index d2eac3c..f50e3cc 100644
--- a/fs/sysfs/symlink.c
+++ b/fs/sysfs/symlink.c
@@ -3,6 +3,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/mount.h>
 #include <linux/module.h>
 #include <linux/kobject.h>
 #include <linux/namei.h>
@@ -82,10 +83,19 @@ exit1:
  */
 int sysfs_create_link(struct kobject * kobj, struct kobject * target, const char * name)
 {
-	struct dentry * dentry = kobj->dentry;
+	struct dentry *dentry = NULL;
 	int error = -EEXIST;
 
-	BUG_ON(!kobj || !kobj->dentry || !name);
+	BUG_ON(!name);
+
+	if (!kobj) {
+		if (sysfs_mount && sysfs_mount->mnt_sb)
+			dentry = sysfs_mount->mnt_sb->s_root;
+	} else
+		dentry = kobj->dentry;
+
+	if (!dentry)
+		return -EFAULT;
 
 	mutex_lock(&dentry->d_inode->i_mutex);
 	if (!sysfs_dirent_exist(dentry->d_fsdata, name))
-- 
1.4.2.1

