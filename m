Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbWBVOwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWBVOwZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 09:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbWBVOwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 09:52:25 -0500
Received: from mail3.sea5.speakeasy.net ([69.17.117.5]:63191 "EHLO
	mail3.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751302AbWBVOwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 09:52:24 -0500
Date: Wed, 22 Feb 2006 09:52:21 -0500 (EST)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: Andrew Morton <akpm@osdl.org>
cc: Stephen Smalley <sds@tycho.nsa.gov>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] selinuxfs cleanups - use sel_make_dir()
In-Reply-To: <Pine.LNX.4.64.0602220948530.30349@excalibur.intercode>
Message-ID: <Pine.LNX.4.64.0602220951260.30349@excalibur.intercode>
References: <Pine.LNX.4.64.0602220948530.30349@excalibur.intercode>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use existing sel_make_dir() helper to create booleans directory rather 
than duplicating the logic.

Please apply.


Signed-off-by: James Morris <jmorris@namei.org>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

---

security/selinux/selinuxfs.c |   12 ++++--------
  1 file changed, 4 insertions(+), 8 deletions(-)
  

diff -purN -X dontdiff linux-2.6.16-rc4.p/security/selinux/selinuxfs.c linux-2.6.16-rc4.w/security/selinux/selinuxfs.c
--- linux-2.6.16-rc4.p/security/selinux/selinuxfs.c	2006-02-19 20:00:31.000000000 -0500
+++ linux-2.6.16-rc4.w/security/selinux/selinuxfs.c	2006-02-21 02:24:08.000000000 -0500
@@ -1235,15 +1235,11 @@ static int sel_fill_super(struct super_b
 	dentry = d_alloc_name(sb->s_root, BOOL_DIR_NAME);
 	if (!dentry)
 		return -ENOMEM;
+	
+	ret = sel_make_dir(sb, dentry);
+	if (ret)
+		return ret;
 
-	inode = sel_make_inode(sb, S_IFDIR | S_IRUGO | S_IXUGO);
-	if (!inode)
-		goto out;
-	inode->i_op = &simple_dir_inode_operations;
-	inode->i_fop = &simple_dir_operations;
-	/* directory inodes start off with i_nlink == 2 (for "." entry) */
-	inode->i_nlink++;
-	d_add(dentry, inode);
 	bool_dir = dentry;
 	ret = sel_make_bools();
 	if (ret)
