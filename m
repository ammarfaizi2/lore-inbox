Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264415AbTLQULi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 15:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264538AbTLQULi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 15:11:38 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:46504 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S264415AbTLQULg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 15:11:36 -0500
Subject: [PATCH] Problems with NFS while running SpecSFS with JFS
	filesystem and 2.6 kernel.
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: "Jose R. Santos" <jrsantos@austin.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, akpm@osdl.org
Cc: nfs@lists.sourceforge.net, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20031215142143.GA3981@dbz.austin.ibm.com>
References: <20031210144011.GE708@dbz.austin.ibm.com>
	 <20031215142143.GA3981@dbz.austin.ibm.com>
Content-Type: text/plain
Message-Id: <1071691866.31508.127.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 17 Dec 2003 14:11:06 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-12-15 at 08:21, Jose R. Santos wrote:
> 
> Can anybody provide me with some tips as to how to debug this a bit further?
> Really want to figure out if this is a NFS bug or a JFS one.

After Jose debugged the problem down to the routine jfs_get_parent, we
were able to find the problem.  I believe it only affects users of
NFS-exported JFS file systems on big-endian hardware.

The problem was a missing le32_to_cpu macro.  The patch also fixes a
return code to be more consistent other implementations of get_parent.

Linus, Andrew,
We're likely to see the problem on ppc running NFS.  Does this patch
meet the criteria for 2.6.0?

===== fs/jfs/namei.c 1.35 vs edited =====
--- 1.35/fs/jfs/namei.c	Thu Oct 30 09:31:08 2003
+++ edited/fs/jfs/namei.c	Wed Dec 17 12:34:10 2003
@@ -1439,14 +1439,18 @@
 struct dentry *jfs_get_parent(struct dentry *dentry)
 {
 	struct super_block *sb = dentry->d_inode->i_sb;
-	struct dentry *parent = ERR_PTR(-EACCES);
+	struct dentry *parent = ERR_PTR(-ENOENT);
 	struct inode *inode;
+	unsigned long parent_ino;
 
-	inode = iget(sb, JFS_IP(dentry->d_inode)->i_dtroot.header.idotdot);
+	parent_ino =
+		le32_to_cpu(JFS_IP(dentry->d_inode)->i_dtroot.header.idotdot);
+	inode = iget(sb, parent_ino);
 	if (inode) {
-		if (is_bad_inode(inode))
+		if (is_bad_inode(inode)) {
 			iput(inode);
-		else {
+			parent = ERR_PTR(-EACCES);
+		} else {
 			parent = d_alloc_anon(inode);
 			if (!parent) {
 				parent = ERR_PTR(-ENOMEM);

-- 
David Kleikamp
IBM Linux Technology Center

