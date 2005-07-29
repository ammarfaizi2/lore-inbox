Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262707AbVG2TSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262707AbVG2TSV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 15:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262749AbVG2TPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 15:15:33 -0400
Received: from mail.kroah.org ([69.55.234.183]:38830 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262745AbVG2TPV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 15:15:21 -0400
Date: Fri, 29 Jul 2005 12:13:35 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, maneesh@in.ibm.com
Subject: [patch 02/29] sysfs: fix sysfs_chmod_file
Message-ID: <20050729191335.GC5095@kroah.com>
References: <20050729184950.014589000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050729191255.GA5095@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maneesh Soni <maneesh@in.ibm.com>

o sysfs_chmod_file() must update the new iattr field in sysfs_dirent else
  the mode change will not be persistent in case of inode evacuation from
  cache.


Signed-off-by: Maneesh Soni <maneesh@in.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 fs/sysfs/file.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

--- gregkh-2.6.orig/fs/sysfs/file.c	2005-07-29 11:30:03.000000000 -0700
+++ gregkh-2.6/fs/sysfs/file.c	2005-07-29 11:33:51.000000000 -0700
@@ -437,8 +437,8 @@
 {
 	struct dentry *dir = kobj->dentry;
 	struct dentry *victim;
-	struct sysfs_dirent *sd;
-	umode_t umode = (mode & S_IALLUGO) | S_IFREG;
+	struct inode * inode;
+	struct iattr newattrs;
 	int res = -ENOENT;
 
 	down(&dir->d_inode->i_sem);
@@ -446,13 +446,15 @@
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
 

--
