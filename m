Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265052AbUFVUHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265052AbUFVUHU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 16:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265111AbUFVT3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 15:29:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14235 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265440AbUFVTX7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 15:23:59 -0400
To: torvalds@osdl.org
Subject: [PATCH] (5/9) symlink patchkit (against -bk current)
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1Bcqs8-0003xZ-OK@www.linux.org.uk>
From: viro@www.linux.org.uk
Date: Tue, 22 Jun 2004 20:23:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        smbfs - switched from on-stack allocation of buffer for link
body (!) to __getname()/putname(); switched to new scheme.

diff -urN RC7-bk5-page/fs/smbfs/proto.h RC7-bk5-smb/fs/smbfs/proto.h
--- RC7-bk5-page/fs/smbfs/proto.h	Sat Sep 27 22:04:57 2003
+++ RC7-bk5-smb/fs/smbfs/proto.h	Tue Jun 22 15:13:11 2004
@@ -87,7 +87,5 @@
 extern int smb_request_send_server(struct smb_sb_info *server);
 extern int smb_request_recv(struct smb_sb_info *server);
 /* symlink.c */
-extern int smb_read_link(struct dentry *dentry, char *buffer, int len);
 extern int smb_symlink(struct inode *inode, struct dentry *dentry, const char *oldname);
-extern int smb_follow_link(struct dentry *dentry, struct nameidata *nd);
 extern struct inode_operations smb_link_inode_operations;
diff -urN RC7-bk5-page/fs/smbfs/symlink.c RC7-bk5-smb/fs/smbfs/symlink.c
--- RC7-bk5-page/fs/smbfs/symlink.c	Mon Nov 18 00:16:24 2002
+++ RC7-bk5-smb/fs/smbfs/symlink.c	Tue Jun 22 15:13:11 2004
@@ -16,6 +16,7 @@
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
 #include <linux/net.h>
+#include <linux/namei.h>
 
 #include <asm/uaccess.h>
 #include <asm/system.h>
@@ -26,19 +27,6 @@
 #include "smb_debug.h"
 #include "proto.h"
 
-int smb_read_link(struct dentry *dentry, char *buffer, int len)
-{
-	char link[256];		/* FIXME: pain ... */
-	int r;
-	DEBUG1("read link buffer len = %d\n", len);
-
-	r = smb_proc_read_link(server_from_dentry(dentry), dentry, link,
-			       sizeof(link) - 1);
-	if (r < 0)
-		return -ENOENT;
-	return vfs_readlink(dentry, buffer, len, link);
-}
-
 int smb_symlink(struct inode *inode, struct dentry *dentry, const char *oldname)
 {
 	DEBUG1("create symlink %s -> %s/%s\n", oldname, DENTRY_PATH(dentry));
@@ -46,24 +34,37 @@
 	return smb_proc_symlink(server_from_dentry(dentry), dentry, oldname);
 }
 
-int smb_follow_link(struct dentry *dentry, struct nameidata *nd)
+static int smb_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
-	char link[256];		/* FIXME: pain ... */
-	int len;
+	char *link = __getname();
 	DEBUG1("followlink of %s/%s\n", DENTRY_PATH(dentry));
 
-	len = smb_proc_read_link(server_from_dentry(dentry), dentry, link,
-				 sizeof(link) - 1);
-	if(len < 0)
-		return -ENOENT;
-
-	link[len] = 0;
-	return vfs_follow_link(nd, link);
+	if (!link) {
+		link = ERR_PTR(-ENOMEM);
+	} else {
+		int len = smb_proc_read_link(server_from_dentry(dentry),
+						dentry, link, PATH_MAX - 1);
+		if (len < 0) {
+			putname(link);
+			link = ERR_PTR(len);
+		} else {
+			link[len] = 0;
+		}
+	}
+	nd_set_link(nd, link);
+	return 0;
 }
 
+static void smb_put_link(struct dentry *dentry, struct nameidata *nd)
+{
+	char *s = nd_get_link(nd);
+	if (!IS_ERR(s))
+		putname(s);
+}
 
 struct inode_operations smb_link_inode_operations =
 {
-	.readlink	= smb_read_link,
+	.readlink	= generic_readlink,
 	.follow_link	= smb_follow_link,
+	.put_link	= smb_put_link,
 };
