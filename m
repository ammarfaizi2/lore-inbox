Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbVHTVJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbVHTVJT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 17:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbVHTVJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 17:09:19 -0400
Received: from smtp.istop.com ([66.11.167.126]:30364 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S1751092AbVHTVJS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 17:09:18 -0400
From: Daniel Phillips <phillips@istop.com>
To: Greg KH <greg@kroah.com>
Subject: [PATCH] Permissions don't stick on ConfigFS attributes (revised)
Date: Sun, 21 Aug 2005 07:09:14 +1000
User-Agent: KMail/1.7.2
Cc: Joel Becker <Joel.Becker@oracle.com>, linux-kernel@vger.kernel.org
References: <200508201050.51982.phillips@istop.com> <20050820030117.GA775@kroah.com>
In-Reply-To: <20050820030117.GA775@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508210709.14969.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 August 2005 13:01, Greg KH wrote:
> On Sat, Aug 20, 2005 at 10:50:51AM +1000, Daniel Phillips wrote:
> > Permissions set on ConfigFS attributes (aka files) do not stick.
>
> The recent changes to sysfs should be ported to configfs to do this.

No, it should go the other way, my fix is better.  It would not require sysfs
to have its own version of setattr.  What I do like about Maneesh's fix is the
handling of other inode attributes besides mode flags, however that is a
detail, let's get the structural elements right first.

The revised patch fixes the vanishing permissions bug and kills the configfs
bogon that made my first attempt subtly wrong (changed permissions for all
attribute files instead of just the chmoded one).

diff -up --recursive 2.6.12-mm2.clean/fs/configfs/dir.c 2.6.12-mm2/fs/configfs/dir.c
--- 2.6.12-mm2.clean/fs/configfs/dir.c	2005-08-12 00:53:06.000000000 -0400
+++ 2.6.12-mm2/fs/configfs/dir.c	2005-08-20 16:16:34.000000000 -0400
@@ -64,6 +64,17 @@ static struct dentry_operations configfs
 	.d_delete	= configfs_d_delete,
 };
 
+static int configfs_d_delete_attr(struct dentry *dentry)
+{
+	((struct configfs_dirent *)dentry->d_fsdata)->s_mode = dentry->d_inode->i_mode;
+	return 1;
+}
+
+static struct dentry_operations configfs_attr_dentry_ops = {
+	.d_delete = configfs_d_delete_attr,
+	.d_iput = configfs_d_iput,
+};
+
 /*
  * Allocates a new configfs_dirent and links it to the parent configfs_dirent
  */
@@ -238,14 +249,11 @@ static void configfs_remove_dir(struct c
  */
 static int configfs_attach_attr(struct configfs_dirent * sd, struct dentry * dentry)
 {
-	struct configfs_attribute * attr = sd->s_element;
-	int error;
-
-	error = configfs_create(dentry, (attr->ca_mode & S_IALLUGO) | S_IFREG, init_file);
+	int error = configfs_create(dentry, sd->s_mode, init_file);
 	if (error)
 		return error;
 
-	dentry->d_op = &configfs_dentry_ops;
+	dentry->d_op = &configfs_attr_dentry_ops;
 	dentry->d_fsdata = configfs_get(sd);
 	sd->s_dentry = dentry;
 	d_rehash(dentry);

