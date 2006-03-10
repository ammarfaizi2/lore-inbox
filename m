Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbWCJANX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWCJANX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 19:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752063AbWCJANX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 19:13:23 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:4843 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1751144AbWCJANW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 19:13:22 -0500
Date: Thu, 9 Mar 2006 16:13:01 -0800
From: Greg KH <greg@kroah.com>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: problem with duplicate sysfs directories and files
Message-ID: <20060310001301.GA7304@kroah.com>
References: <20060308075342.GA17718@kroah.com> <20060309025824.GA4483@in.ibm.com> <20060309055816.GB9013@kroah.com> <20060309141014.GB10667@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060309141014.GB10667@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 07:40:14PM +0530, Maneesh Soni wrote:
> On Wed, Mar 08, 2006 at 09:58:16PM -0800, Greg KH wrote:
> 
> > 
> > I have a test module that shows this at:
> > 	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/gregkh/sysfs-test.patch
> > just load the 'gregkh' module and look in /sys/class/gregkh/ to see the
> > duplicate "gregkh1" directories.
> > 
> 
> Thnaks for the testcase, I could verify the following patch using this. I
> don't see the duplicate "gregkh1" directories. Please queue it for post 2.6.16
> if you are ok with it.

Looks good.  I tweaked it a bit (returned -EEXIST from functions if the
file already existed), and renamed the function to play nicer in the
global namespace.  Updated patch is below

Thanks a lot for doing this, I appreciate it.

greg k-h

-------------

>From maneesh@in.ibm.com Thu Mar  9 06:13:04 2006
Date: Thu, 9 Mar 2006 19:40:14 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Patrick Mochel <mochel@digitalimplant.org>
Subject: sysfs: fix problem with duplicate sysfs directories and files
Message-ID: <20060309141014.GB10667@in.ibm.com>
Content-Disposition: inline


The following patch checks for existing sysfs_dirent before
preparing new one while creating sysfs directories and files.

Signed-off-by: Maneesh Soni <maneesh@in.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 fs/sysfs/dir.c     |   30 +++++++++++++++++++++++++++++-
 fs/sysfs/file.c    |    6 ++++--
 fs/sysfs/symlink.c |    5 +++--
 fs/sysfs/sysfs.h   |    1 +
 4 files changed, 37 insertions(+), 5 deletions(-)

--- gregkh-2.6.orig/fs/sysfs/dir.c
+++ gregkh-2.6/fs/sysfs/dir.c
@@ -51,6 +51,30 @@ static struct sysfs_dirent * sysfs_new_d
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
@@ -117,7 +141,11 @@ static int create_dir(struct kobject * k
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
--- gregkh-2.6.orig/fs/sysfs/file.c
+++ gregkh-2.6/fs/sysfs/file.c
@@ -450,10 +450,12 @@ int sysfs_add_file(struct dentry * dir, 
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
--- gregkh-2.6.orig/fs/sysfs/symlink.c
+++ gregkh-2.6/fs/sysfs/symlink.c
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
--- gregkh-2.6.orig/fs/sysfs/sysfs.h
+++ gregkh-2.6/fs/sysfs/sysfs.h
@@ -5,6 +5,7 @@ extern kmem_cache_t *sysfs_dir_cachep;
 extern struct inode * sysfs_new_inode(mode_t mode, struct sysfs_dirent *);
 extern int sysfs_create(struct dentry *, int mode, int (*init)(struct inode *));
 
+extern int sysfs_dirent_exist(struct sysfs_dirent *, const unsigned char *);
 extern int sysfs_make_dirent(struct sysfs_dirent *, struct dentry *, void *,
 				umode_t, int);
 
