Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751026AbWBVOyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbWBVOyY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 09:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbWBVOyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 09:54:23 -0500
Received: from mail1.sea5.speakeasy.net ([69.17.117.3]:30918 "EHLO
	mail1.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751026AbWBVOyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 09:54:23 -0500
Date: Wed, 22 Feb 2006 09:54:21 -0500 (EST)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: Andrew Morton <akpm@osdl.org>
cc: Stephen Smalley <sds@tycho.nsa.gov>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] selinuxfs cleanups - sel_fill_super exit path
In-Reply-To: <Pine.LNX.4.64.0602220948530.30349@excalibur.intercode>
Message-ID: <Pine.LNX.4.64.0602220952500.30349@excalibur.intercode>
References: <Pine.LNX.4.64.0602220948530.30349@excalibur.intercode>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch unifies the error path of sel_fill_super() so that all errors 
pass through the same point and generate an error message.  Also, removes 
a spurious dput() in the error path which breaks the refcounting for the 
filesystem (litter_kill_super() will correctly clean things up itself on 
error).

Please apply.


Signed-off-by: James Morris <jmorris@namei.org>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

---

 selinuxfs.c |   41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)


diff -purN -X dontdiff linux-2.6.16-rc4.p/security/selinux/selinuxfs.c linux-2.6.16-rc4.w/security/selinux/selinuxfs.c
--- linux-2.6.16-rc4.p/security/selinux/selinuxfs.c	2006-02-21 16:32:54.000000000 -0500
+++ linux-2.6.16-rc4.w/security/selinux/selinuxfs.c	2006-02-21 19:56:04.000000000 -0500
@@ -1230,28 +1230,34 @@ static int sel_fill_super(struct super_b
 	};
 	ret = simple_fill_super(sb, SELINUX_MAGIC, selinux_files);
 	if (ret)
-		return ret;
+		goto err;
 
 	dentry = d_alloc_name(sb->s_root, BOOL_DIR_NAME);
-	if (!dentry)
-		return -ENOMEM;
+	if (!dentry) {
+		ret = -ENOMEM;
+		goto err;
+	}
 	
 	ret = sel_make_dir(sb, dentry);
 	if (ret)
-		return ret;
+		goto err;
 
 	bool_dir = dentry;
 	ret = sel_make_bools();
 	if (ret)
-		goto out;
+		goto err;
 
 	dentry = d_alloc_name(sb->s_root, NULL_FILE_NAME);
-	if (!dentry)
-		return -ENOMEM;
+	if (!dentry) {
+		ret = -ENOMEM;
+		goto err;
+	}
 
 	inode = sel_make_inode(sb, S_IFCHR | S_IRUGO | S_IWUGO);
-	if (!inode)
-		goto out;
+	if (!inode) {
+		ret = -ENOMEM;
+		goto err;
+	}
 	isec = (struct inode_security_struct*)inode->i_security;
 	isec->sid = SECINITSID_DEVNULL;
 	isec->sclass = SECCLASS_CHR_FILE;
@@ -1262,22 +1268,23 @@ static int sel_fill_super(struct super_b
 	selinux_null = dentry;
 
 	dentry = d_alloc_name(sb->s_root, "avc");
-	if (!dentry)
-		return -ENOMEM;
+	if (!dentry) {
+		ret = -ENOMEM;
+		goto err;
+	}
 
 	ret = sel_make_dir(sb, dentry);
 	if (ret)
-		goto out;
+		goto err;
 
 	ret = sel_make_avc_files(dentry);
 	if (ret)
-		goto out;
-
-	return 0;
+		goto err;
 out:
-	dput(dentry);
+	return ret;
+err:
 	printk(KERN_ERR "%s:  failed while creating inodes\n", __FUNCTION__);
-	return -ENOMEM;
+	goto out;
 }
 
 static struct super_block *sel_get_sb(struct file_system_type *fs_type,
