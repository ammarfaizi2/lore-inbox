Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262045AbVD1Frq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbVD1Frq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 01:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262145AbVD1Fp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 01:45:56 -0400
Received: from smtp809.mail.sc5.yahoo.com ([66.163.168.188]:63653 "HELO
	smtp809.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262127AbVD1For (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 01:44:47 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [RFC/PATCH 1/5] sysfs: if show/store is missing return -ENOSYS
Date: Thu, 28 Apr 2005 00:31:28 -0500
User-Agent: KMail/1.8
Cc: Greg KH <gregkh@suse.de>, Jean Delvare <khali@linux-fr.org>
References: <200504280030.10214.dtor_core@ameritech.net>
In-Reply-To: <200504280030.10214.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504280031.28816.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sysfs: if attribute does not implement show or store method
       read/write should return -ENOSYS instead of 0, EACCESS
       or EINVAL.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 bin.c  |    4 ++--
 file.c |   19 ++++++++++++-------
 2 files changed, 14 insertions(+), 9 deletions(-)

Index: dtor/fs/sysfs/file.c
===================================================================
--- dtor.orig/fs/sysfs/file.c
+++ dtor/fs/sysfs/file.c
@@ -23,7 +23,7 @@ subsys_attr_show(struct kobject * kobj, 
 {
 	struct subsystem * s = to_subsys(kobj);
 	struct subsys_attribute * sattr = to_sattr(attr);
-	ssize_t ret = 0;
+	ssize_t ret = -ENOSYS;
 
 	if (sattr->show)
 		ret = sattr->show(s,page);
@@ -36,7 +36,7 @@ subsys_attr_store(struct kobject * kobj,
 {
 	struct subsystem * s = to_subsys(kobj);
 	struct subsys_attribute * sattr = to_sattr(attr);
-	ssize_t ret = 0;
+	ssize_t ret = -ENOSYS;
 
 	if (sattr->store)
 		ret = sattr->store(s,page,count);
@@ -274,17 +274,17 @@ static int check_perm(struct inode * ino
 	 * or the subsystem have no operations.
 	 */
 	if (!ops)
-		goto Eaccess;
+		goto Enosys;
 
 	/* File needs write support.
 	 * The inode's perms must say it's ok, 
 	 * and we must have a store method.
 	 */
 	if (file->f_mode & FMODE_WRITE) {
-
-		if (!(inode->i_mode & S_IWUGO) || !ops->store)
+		if (!(inode->i_mode & S_IWUGO))
 			goto Eaccess;
-
+		if (!ops->store)
+			goto Enosys;
 	}
 
 	/* File needs read support.
@@ -292,8 +292,10 @@ static int check_perm(struct inode * ino
 	 * must be a show method for it.
 	 */
 	if (file->f_mode & FMODE_READ) {
-		if (!(inode->i_mode & S_IRUGO) || !ops->show)
+		if (!(inode->i_mode & S_IRUGO))
 			goto Eaccess;
+		if (!ops->show)
+			goto Enosys;
 	}
 
 	/* No error? Great, allocate a buffer for the file, and store it
@@ -313,6 +315,9 @@ static int check_perm(struct inode * ino
  Einval:
 	error = -EINVAL;
 	goto Done;
+ Enosys:
+	error = -ENOSYS;
+	goto Done;
  Eaccess:
 	error = -EACCES;
 	module_put(attr->owner);
Index: dtor/fs/sysfs/bin.c
===================================================================
--- dtor.orig/fs/sysfs/bin.c
+++ dtor/fs/sysfs/bin.c
@@ -25,7 +25,7 @@ fill_read(struct dentry *dentry, char *b
 	struct kobject * kobj = to_kobj(dentry->d_parent);
 
 	if (!attr->read)
-		return -EINVAL;
+		return -ENOSYS;
 
 	return attr->read(kobj, buffer, off, count);
 }
@@ -71,7 +71,7 @@ flush_write(struct dentry *dentry, char 
 	struct kobject *kobj = to_kobj(dentry->d_parent);
 
 	if (!attr->write)
-		return -EINVAL;
+		return -ENOSYS;
 
 	return attr->write(kobj, buffer, offset, count);
 }
