Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030513AbWCTWBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030513AbWCTWBc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 17:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030509AbWCTWBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 17:01:06 -0500
Received: from mail.kroah.org ([69.55.234.183]:48569 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964997AbWCTWBF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 17:01:05 -0500
Cc: Maneesh Soni <maneesh@in.ibm.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 18/23] sysfs: fix problem with duplicate sysfs directories and files
In-Reply-To: <11428920381762-git-send-email-gregkh@suse.de>
X-Mailer: git-send-email
Date: Mon, 20 Mar 2006 14:00:39 -0800
Message-Id: <11428920391787-git-send-email-gregkh@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg Kroah-Hartman <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg Kroah-Hartman <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch checks for existing sysfs_dirent before
preparing new one while creating sysfs directories and files.

Signed-off-by: Maneesh Soni <maneesh@in.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 fs/sysfs/dir.c     |   32 +++++++++++++++++++++++++++++++-
 fs/sysfs/file.c    |    6 ++++--
 fs/sysfs/symlink.c |    5 +++--
 fs/sysfs/sysfs.h   |    1 +
 4 files changed, 39 insertions(+), 5 deletions(-)

c516865cfbac0d862d4888df91793ad1e74ffd58
diff --git a/fs/sysfs/dir.c b/fs/sysfs/dir.c
index cfd290d..bea1f4c 100644
--- a/fs/sysfs/dir.c
+++ b/fs/sysfs/dir.c
@@ -50,6 +50,32 @@ static struct sysfs_dirent * sysfs_new_d
 	return sd;
 }
 
+/**
+ *
+ * Return -EEXIST if there is already a sysfs element with the same name for
+ * the same parent.
+ *
+ * called with parent inode's i_mutex held
+ */
+int sysfs_dirent_exist(struct sysfs_dirent *parent_sd,
+			  const unsigned char *new)
+{
+	struct sysfs_dirent * sd;
+
+	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
+		if (sd->s_element) {
+			const unsigned char *existing = sysfs_get_name(sd);
+			if (strcmp(existing, new))
+				continue;
+			else
+				return -EEXIST;
+		}
+	}
+
+	return 0;
+}
+
+
 int sysfs_make_dirent(struct sysfs_dirent * parent_sd, struct dentry * dentry,
 			void * element, umode_t mode, int type)
 {
@@ -102,7 +128,11 @@ static int create_dir(struct kobject * k
 	mutex_lock(&p->d_inode->i_mutex);
 	*d = lookup_one_len(n, p, strlen(n));
 	if (!IS_ERR(*d)) {
-		error = sysfs_make_dirent(p->d_fsdata, *d, k, mode, SYSFS_DIR);
+ 		if (sysfs_dirent_exist(p->d_fsdata, n))
+  			error = -EEXIST;
+  		else
+			error = sysfs_make_dirent(p->d_fsdata, *d, k, mode,
+								SYSFS_DIR);
 		if (!error) {
 			error = sysfs_create(*d, mode, init_dir);
 			if (!error) {
diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index e21f402..5e83e72 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -361,10 +361,12 @@ int sysfs_add_file(struct dentry * dir, 
 {
 	struct sysfs_dirent * parent_sd = dir->d_fsdata;
 	umode_t mode = (attr->mode & S_IALLUGO) | S_IFREG;
-	int error = 0;
+	int error = -EEXIST;
 
 	mutex_lock(&dir->d_inode->i_mutex);
-	error = sysfs_make_dirent(parent_sd, NULL, (void *) attr, mode, type);
+	if (!sysfs_dirent_exist(parent_sd, attr->name))
+		error = sysfs_make_dirent(parent_sd, NULL, (void *)attr,
+					  mode, type);
 	mutex_unlock(&dir->d_inode->i_mutex);
 
 	return error;
diff --git a/fs/sysfs/symlink.c b/fs/sysfs/symlink.c
index e38d633..fe23f47 100644
--- a/fs/sysfs/symlink.c
+++ b/fs/sysfs/symlink.c
@@ -82,12 +82,13 @@ exit1:
 int sysfs_create_link(struct kobject * kobj, struct kobject * target, const char * name)
 {
 	struct dentry * dentry = kobj->dentry;
-	int error = 0;
+	int error = -EEXIST;
 
 	BUG_ON(!kobj || !kobj->dentry || !name);
 
 	mutex_lock(&dentry->d_inode->i_mutex);
-	error = sysfs_add_link(dentry, name, target);
+	if (!sysfs_dirent_exist(dentry->d_fsdata, name))
+		error = sysfs_add_link(dentry, name, target);
 	mutex_unlock(&dentry->d_inode->i_mutex);
 	return error;
 }
diff --git a/fs/sysfs/sysfs.h b/fs/sysfs/sysfs.h
index 3f8953e..cf11d5b 100644
--- a/fs/sysfs/sysfs.h
+++ b/fs/sysfs/sysfs.h
@@ -5,6 +5,7 @@ extern kmem_cache_t *sysfs_dir_cachep;
 extern struct inode * sysfs_new_inode(mode_t mode, struct sysfs_dirent *);
 extern int sysfs_create(struct dentry *, int mode, int (*init)(struct inode *));
 
+extern int sysfs_dirent_exist(struct sysfs_dirent *, const unsigned char *);
 extern int sysfs_make_dirent(struct sysfs_dirent *, struct dentry *, void *,
 				umode_t, int);
 
-- 
1.2.4


