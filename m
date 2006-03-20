Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030542AbWCTWCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030542AbWCTWCP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 17:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030543AbWCTWBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 17:01:54 -0500
Received: from mail.kroah.org ([69.55.234.183]:62905 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030545AbWCTWBS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 17:01:18 -0500
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 01/23] sysfs: sysfs_remove_dir() needs to invalidate the dentry
In-Reply-To: <20060320215009.GA19665@kroah.com>
X-Mailer: git-send-email
Date: Mon, 20 Mar 2006 14:00:37 -0800
Message-Id: <11428920371618-git-send-email-gregkh@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg Kroah-Hartman <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg Kroah-Hartman <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When calling sysfs_remove_dir() don't allow any further sysfs functions
to work for this kobject anymore.  This fixes a nasty USB cdc-acm oops
on disconnect.

Many thanks to Bob Copeland and Paul Fulghum for taking the time to
track this down.

Cc: Bob Copeland <email@bobcopeland.com>
Cc: Paul Fulghum <paulkf@microgate.com>
Cc: Maneesh Soni <maneesh@in.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 fs/sysfs/dir.c   |    1 +
 fs/sysfs/inode.c |    6 +++++-
 2 files changed, 6 insertions(+), 1 deletions(-)

641e6f30a095f3752ed84fd9d279382f5d3ef4c1
diff --git a/fs/sysfs/dir.c b/fs/sysfs/dir.c
index 49bd219..cfd290d 100644
--- a/fs/sysfs/dir.c
+++ b/fs/sysfs/dir.c
@@ -302,6 +302,7 @@ void sysfs_remove_dir(struct kobject * k
 	 * Drop reference from dget() on entrance.
 	 */
 	dput(dentry);
+	kobj->dentry = NULL;
 }
 
 int sysfs_rename_dir(struct kobject * kobj, const char *new_name)
diff --git a/fs/sysfs/inode.c b/fs/sysfs/inode.c
index 689f7bc..6beee6f 100644
--- a/fs/sysfs/inode.c
+++ b/fs/sysfs/inode.c
@@ -227,12 +227,16 @@ void sysfs_drop_dentry(struct sysfs_dire
 void sysfs_hash_and_remove(struct dentry * dir, const char * name)
 {
 	struct sysfs_dirent * sd;
-	struct sysfs_dirent * parent_sd = dir->d_fsdata;
+	struct sysfs_dirent * parent_sd;
+
+	if (!dir)
+		return;
 
 	if (dir->d_inode == NULL)
 		/* no inode means this hasn't been made visible yet */
 		return;
 
+	parent_sd = dir->d_fsdata;
 	mutex_lock(&dir->d_inode->i_mutex);
 	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
 		if (!sd->s_element)
-- 
1.2.4


