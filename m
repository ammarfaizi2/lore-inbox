Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbWCIONB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbWCIONB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 09:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751951AbWCIONA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 09:13:00 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:56210 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751138AbWCIONA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 09:13:00 -0500
Date: Thu, 9 Mar 2006 19:40:14 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: problem with duplicate sysfs directories and files
Message-ID: <20060309141014.GB10667@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20060308075342.GA17718@kroah.com> <20060309025824.GA4483@in.ibm.com> <20060309055816.GB9013@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060309055816.GB9013@kroah.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 09:58:16PM -0800, Greg KH wrote:

> 
> I have a test module that shows this at:
> 	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/gregkh/sysfs-test.patch
> just load the 'gregkh' module and look in /sys/class/gregkh/ to see the
> duplicate "gregkh1" directories.
> 

Thnaks for the testcase, I could verify the following patch using this. I
don't see the duplicate "gregkh1" directories. Please queue it for post 2.6.16
if you are ok with it.


Thanks
Maneesh


o The following patch checks for existing sysfs_dirent before 
  preparing new one while creating sysfs directories and files. 



Signed-off-by: Maneesh Soni <maneesh@in.ibm.com>
---

 linux-2.6.16-rc5-git12-maneesh/fs/sysfs/dir.c     |   30 +++++++++++++++++++++-
 linux-2.6.16-rc5-git12-maneesh/fs/sysfs/file.c    |    4 ++
 linux-2.6.16-rc5-git12-maneesh/fs/sysfs/symlink.c |    3 +-
 linux-2.6.16-rc5-git12-maneesh/fs/sysfs/sysfs.h   |    1 
 4 files changed, 35 insertions(+), 3 deletions(-)

diff -puN fs/sysfs/dir.c~sysfs-check-existing-sysfs_dirent fs/sysfs/dir.c
--- linux-2.6.16-rc5-git12/fs/sysfs/dir.c~sysfs-check-existing-sysfs_dirent	2006-03-09 19:19:22.655241008 +0530
+++ linux-2.6.16-rc5-git12-maneesh/fs/sysfs/dir.c	2006-03-09 19:38:52.735361792 +0530
@@ -50,6 +50,30 @@ static struct sysfs_dirent * sysfs_new_d
 	return sd;
 }
 
+/**
+ *
+ * Return -EEXIST if there is already a sysfs element with the same name for
+ * the same parent.
+ *
+ * called with parent inode's i_mutex held
+ */
+int is_sysfs_dirent_exist(struct sysfs_dirent * parent_sd,
+						const unsigned char * new)
+{
+	struct sysfs_dirent * sd;
+
+	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
+		const unsigned char * existing = sysfs_get_name(sd);
+		if (strcmp(existing, new))
+			continue;
+		else
+			return -EEXIST;
+	}
+
+	return 0;
+}
+
+
 int sysfs_make_dirent(struct sysfs_dirent * parent_sd, struct dentry * dentry,
 			void * element, umode_t mode, int type)
 {
@@ -102,7 +126,11 @@ static int create_dir(struct kobject * k
 	mutex_lock(&p->d_inode->i_mutex);
 	*d = lookup_one_len(n, p, strlen(n));
 	if (!IS_ERR(*d)) {
-		error = sysfs_make_dirent(p->d_fsdata, *d, k, mode, SYSFS_DIR);
+ 		if (is_sysfs_dirent_exist(p->d_fsdata, n))
+  			error = -EEXIST;
+  		else
+			error = sysfs_make_dirent(p->d_fsdata, *d, k, mode,
+								SYSFS_DIR);
 		if (!error) {
 			error = sysfs_create(*d, mode, init_dir);
 			if (!error) {
diff -puN fs/sysfs/file.c~sysfs-check-existing-sysfs_dirent fs/sysfs/file.c
--- linux-2.6.16-rc5-git12/fs/sysfs/file.c~sysfs-check-existing-sysfs_dirent	2006-03-09 19:19:22.659240400 +0530
+++ linux-2.6.16-rc5-git12-maneesh/fs/sysfs/file.c	2006-03-09 19:19:22.676237816 +0530
@@ -365,7 +365,9 @@ int sysfs_add_file(struct dentry * dir, 
 	int error = 0;
 
 	mutex_lock(&dir->d_inode->i_mutex);
-	error = sysfs_make_dirent(parent_sd, NULL, (void *) attr, mode, type);
+	if (!is_sysfs_dirent_exist(parent_sd, attr->name))
+		error = sysfs_make_dirent(parent_sd, NULL, (void *) attr,
+								mode, type);
 	mutex_unlock(&dir->d_inode->i_mutex);
 
 	return error;
diff -puN fs/sysfs/symlink.c~sysfs-check-existing-sysfs_dirent fs/sysfs/symlink.c
--- linux-2.6.16-rc5-git12/fs/sysfs/symlink.c~sysfs-check-existing-sysfs_dirent	2006-03-09 19:19:22.663239792 +0530
+++ linux-2.6.16-rc5-git12-maneesh/fs/sysfs/symlink.c	2006-03-09 19:19:22.677237664 +0530
@@ -87,7 +87,8 @@ int sysfs_create_link(struct kobject * k
 	BUG_ON(!kobj || !kobj->dentry || !name);
 
 	mutex_lock(&dentry->d_inode->i_mutex);
-	error = sysfs_add_link(dentry, name, target);
+	if (!is_sysfs_dirent_exist(dentry->d_fsdata, name))
+		error = sysfs_add_link(dentry, name, target);
 	mutex_unlock(&dentry->d_inode->i_mutex);
 	return error;
 }
diff -puN fs/sysfs/sysfs.h~sysfs-check-existing-sysfs_dirent fs/sysfs/sysfs.h
--- linux-2.6.16-rc5-git12/fs/sysfs/sysfs.h~sysfs-check-existing-sysfs_dirent	2006-03-09 19:19:22.666239336 +0530
+++ linux-2.6.16-rc5-git12-maneesh/fs/sysfs/sysfs.h	2006-03-09 19:28:52.404625936 +0530
@@ -5,6 +5,7 @@ extern kmem_cache_t *sysfs_dir_cachep;
 extern struct inode * sysfs_new_inode(mode_t mode, struct sysfs_dirent *);
 extern int sysfs_create(struct dentry *, int mode, int (*init)(struct inode *));
 
+extern int is_sysfs_dirent_exist(struct sysfs_dirent *, const unsigned char * );
 extern int sysfs_make_dirent(struct sysfs_dirent *, struct dentry *, void *,
 				umode_t, int);
 
_

-- 
Maneesh Soni
Linux Technology Center, 
IBM India Software Labs,
Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-51776416
