Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbVGLMdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbVGLMdf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 08:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVGLMbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 08:31:33 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:35759 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261399AbVGLM3y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 08:29:54 -0400
Date: Tue, 12 Jul 2005 17:58:13 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: gregkh@suse.de
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] sysfs: fix sysfs_chmod_file
Message-ID: <20050712122813.GB5971@in.ibm.com>
Reply-To: maneesh@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please include this patch and the following one for sysfs. This is needed
after the introduction of sysfs setattr functionality.


Thanks
Maneesh



o sysfs_chmod_file() must update the new iattr field in sysfs_dirent else
  the mode change will not be persistent in case of inode evacuation from
  cache.
  

Signed-off-by: Maneesh Soni <maneesh@in.ibm.com>
---

 linux-2.6.13-rc2-maneesh/fs/sysfs/file.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff -puN fs/sysfs/file.c~fix-sysfs_chmod_file fs/sysfs/file.c
--- linux-2.6.13-rc2/fs/sysfs/file.c~fix-sysfs_chmod_file	2005-07-12 11:43:26.799678624 +0530
+++ linux-2.6.13-rc2-maneesh/fs/sysfs/file.c	2005-07-12 11:44:09.213230784 +0530
@@ -440,8 +440,8 @@ int sysfs_chmod_file(struct kobject *kob
 {
 	struct dentry *dir = kobj->dentry;
 	struct dentry *victim;
-	struct sysfs_dirent *sd;
-	umode_t umode = (mode & S_IALLUGO) | S_IFREG;
+	struct inode * inode;
+	struct iattr newattrs;
 	int res = -ENOENT;
 
 	down(&dir->d_inode->i_sem);
@@ -449,13 +449,15 @@ int sysfs_chmod_file(struct kobject *kob
 	if (!IS_ERR(victim)) {
 		if (victim->d_inode &&
 		    (victim->d_parent->d_inode == dir->d_inode)) {
-			sd = victim->d_fsdata;
-			attr->mode = mode;
-			sd->s_mode = umode;
-			victim->d_inode->i_mode = umode;
-			dput(victim);
-			res = 0;
+			inode = victim->d_inode;
+			down(&inode->i_sem);
+			newattrs.ia_mode = (mode & S_IALLUGO) |
+						(inode->i_mode & ~S_IALLUGO);
+			newattrs.ia_valid = ATTR_MODE | ATTR_CTIME;
+			res = notify_change(victim, &newattrs);
+			up(&inode->i_sem);
 		}
+		dput(victim);
 	}
 	up(&dir->d_inode->i_sem);
 
_
-- 
Maneesh Soni
Linux Technology Center, 
IBM India Software Labs,
Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044990
