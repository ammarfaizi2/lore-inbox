Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263024AbVHEN7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbVHEN7J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 09:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263028AbVHEN7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 09:59:04 -0400
Received: from adsl-266.mirage.euroweb.hu ([193.226.239.10]:50697 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S263024AbVHEN5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 09:57:46 -0400
To: jirislaby@gmail.com
CC: linux-kernel@vger.kernel.org
In-reply-to: <42F3617E.9040808@gmail.com> (message from Jiri Slaby on Fri, 05
	Aug 2005 14:54:22 +0200)
Subject: Re: [BUG] sunrpc as module and bad proc/sys link count
References: <42F3617E.9040808@gmail.com>
Message-Id: <E1E12hX-0003Cd-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 05 Aug 2005 15:57:31 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When sunrpc is as module, sysctl adds to proc fs proc/sys/sunrpc, adds 1 
> to number of proc/sys link (see later), but when it's ls-ed, there is 
> still old count.

Does this patch solve it?

Index: linux/fs/proc/generic.c
===================================================================
--- linux.orig/fs/proc/generic.c	2005-07-27 12:29:23.000000000 +0200
+++ linux/fs/proc/generic.c	2005-08-05 15:54:35.000000000 +0200
@@ -249,6 +249,18 @@ out:
 	return error;
 }
 
+static int proc_getattr(struct vfsmount *mnt, struct dentry *dentry,
+			struct kstat *stat)
+{
+	struct inode *inode = dentry->d_inode;
+	struct proc_dir_entry *de = PROC_I(inode)->pde;
+	if (de && de->nlink)
+		inode->i_nlink = de->nlink;
+	
+	generic_fillattr(inode, stat);
+	return 0;
+}
+
 static struct inode_operations proc_file_inode_operations = {
 	.setattr	= proc_notify_change,
 };
@@ -475,6 +487,7 @@ static struct file_operations proc_dir_o
  */
 static struct inode_operations proc_dir_inode_operations = {
 	.lookup		= proc_lookup,
+	.getattr	= proc_getattr,
 	.setattr	= proc_notify_change,
 };
 
