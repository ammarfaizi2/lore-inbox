Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261620AbUKSVxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbUKSVxQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 16:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261600AbUKSVvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 16:51:25 -0500
Received: from mail.kroah.org ([69.55.234.183]:45458 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261605AbUKSVts (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 16:49:48 -0500
Date: Fri, 19 Nov 2004 13:49:13 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Driver Core fixes for 2.6.10-rc2
Message-ID: <20041119214913.GC15517@kroah.com>
References: <20041119214710.GA15517@kroah.com> <20041119214840.GB15517@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041119214840.GB15517@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet 1.2165, 2004/11/19 08:47:38-08:00, maneesh@in.ibm.com

[PATCH] fix oops in sysfs_remove_dir()

The following patch should avoid the sysfs_remove_dir() oops you are
seeing while device removal. It anyway fixes the obvious error and is
needed. But it will not make any change to the first error you are
seeing while connecting the device.


o Following patch avoids the sysfs_remove_dir() oops when it is passed
  a kobject with NULL dentry.

Signed-off-by: Maneesh Soni <maneesh@in.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 fs/sysfs/dir.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)


diff -Nru a/fs/sysfs/dir.c b/fs/sysfs/dir.c
--- a/fs/sysfs/dir.c	2004-11-19 11:36:39 -08:00
+++ b/fs/sysfs/dir.c	2004-11-19 11:36:39 -08:00
@@ -268,7 +268,7 @@
 void sysfs_remove_dir(struct kobject * kobj)
 {
 	struct dentry * dentry = dget(kobj->dentry);
-	struct sysfs_dirent * parent_sd = dentry->d_fsdata;
+	struct sysfs_dirent * parent_sd;
 	struct sysfs_dirent * sd, * tmp;
 
 	if (!dentry)
@@ -276,6 +276,7 @@
 
 	pr_debug("sysfs %s: removing dir\n",dentry->d_name.name);
 	down(&dentry->d_inode->i_sem);
+	parent_sd = dentry->d_fsdata;
 	list_for_each_entry_safe(sd, tmp, &parent_sd->s_children, s_sibling) {
 		if (!sd->s_element || !(sd->s_type & SYSFS_NOT_PINNED))
 			continue;
