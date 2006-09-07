Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751836AbWIGSmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836AbWIGSmK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 14:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751833AbWIGSmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 14:42:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30378 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751836AbWIGSmH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 14:42:07 -0400
From: David Howells <dhowells@redhat.com>
To: akpm@osdl.org, Michael Halcrow <mhalcrow@us.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] eCryptFS: Use container_of() rather than i_private
Date: Thu, 07 Sep 2006 19:41:59 +0100
Message-ID: <22352.1157654519@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use containter_of() rather than i_private to gain access to the eCryptFS
private data from the inode as this will result in the assembly code using
subtraction or addition to get the address rather than using a LOAD instruction
to read i_private.  This should result in slightly faster code and possibly the
use of one fewer registers in some functions.

Because of this, ecryptfs_set_inode_private() is no longer necessary, and the
same goes for any checks that the result of ecryptfs_get_inode_private() is
non-NULL (which can be assumed if inode is non-NULL).


Also move the embedded vfs_inode struct to the beginning of ecryptfs_inode_info
so that the VFS inode address and the private data address are coincident.
This permits the offset to be optimised away.

It is possible that moving vfs_node before wii_inode is not the best thing to
do, but if the address of wii_inode is always derived by offset from inode,
then it should make no difference as register+offset addressing modes will
always have to be used, one way or another.

Since because i_private is made available by the first part of the patch,
wii_inode could be dispensed with entirely and i_private used instead, thus
reducing the amount of memory used.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
 fs/ecryptfs/ecryptfs_kernel.h |   16 ++++------------
 fs/ecryptfs/inode.c           |    1 -
 fs/ecryptfs/super.c           |    7 -------
 3 files changed, 4 insertions(+), 20 deletions(-)

diff -uNrp linux-2.6.18-rc5-mm1-ecryptfs/fs/ecryptfs/ecryptfs_kernel.h linux-2.6.18-rc5-mm1-ecryptfs-ipriv/fs/ecryptfs/ecryptfs_kernel.h
--- linux-2.6.18-rc5-mm1-ecryptfs/fs/ecryptfs/ecryptfs_kernel.h	2006-09-07 11:21:43.000000000 +0100
+++ linux-2.6.18-rc5-mm1-ecryptfs-ipriv/fs/ecryptfs/ecryptfs_kernel.h	2006-09-07 11:27:32.000000000 +0100
@@ -211,8 +211,8 @@ struct ecryptfs_crypt_stat {
 
 /* inode private data. */
 struct ecryptfs_inode_info {
-	struct inode *wii_inode;
 	struct inode vfs_inode;
+	struct inode *wii_inode;
 	struct ecryptfs_crypt_stat crypt_stat;
 };
 
@@ -289,26 +289,18 @@ ecryptfs_set_file_lower(struct file *fil
 static inline struct ecryptfs_inode_info *
 ecryptfs_inode_to_private(struct inode *inode)
 {
-	return (struct ecryptfs_inode_info *)inode->i_private;
-}
-
-static inline void
-ecryptfs_set_inode_private(struct inode *inode,
-			   struct ecryptfs_inode_info *inode_info)
-{
-	inode->i_private = inode_info;
+	return container_of(inode, struct ecryptfs_inode_info, vfs_inode);
 }
 
 static inline struct inode *ecryptfs_inode_to_lower(struct inode *inode)
 {
-	return ((struct ecryptfs_inode_info *)inode->i_private)->wii_inode;
+	return ecryptfs_inode_to_private(inode)->wii_inode;
 }
 
 static inline void
 ecryptfs_set_inode_lower(struct inode *inode, struct inode *lower_inode)
 {
-	((struct ecryptfs_inode_info *)inode->i_private)->wii_inode =
-		lower_inode;
+	ecryptfs_inode_to_private(inode)->wii_inode = lower_inode;
 }
 
 static inline struct ecryptfs_sb_info *
diff -uNrp linux-2.6.18-rc5-mm1-ecryptfs/fs/ecryptfs/inode.c linux-2.6.18-rc5-mm1-ecryptfs-ipriv/fs/ecryptfs/inode.c
--- linux-2.6.18-rc5-mm1-ecryptfs/fs/ecryptfs/inode.c	2006-09-07 11:21:43.000000000 +0100
+++ linux-2.6.18-rc5-mm1-ecryptfs-ipriv/fs/ecryptfs/inode.c	2006-09-07 11:38:21.000000000 +0100
@@ -1026,7 +1026,6 @@ out:
 
 int ecryptfs_inode_test(struct inode *inode, void *candidate_lower_inode)
 {
-	BUG_ON(!ecryptfs_inode_to_private(inode));
 	if ((ecryptfs_inode_to_lower(inode)
 	     == (struct inode *)candidate_lower_inode))
 		return 1;
diff -uNrp linux-2.6.18-rc5-mm1-ecryptfs/fs/ecryptfs/super.c linux-2.6.18-rc5-mm1-ecryptfs-ipriv/fs/ecryptfs/super.c
--- linux-2.6.18-rc5-mm1-ecryptfs/fs/ecryptfs/super.c	2006-09-07 11:21:43.000000000 +0100
+++ linux-2.6.18-rc5-mm1-ecryptfs-ipriv/fs/ecryptfs/super.c	2006-09-07 11:26:56.000000000 +0100
@@ -85,13 +85,6 @@ static void ecryptfs_destroy_inode(struc
  */
 void ecryptfs_init_inode(struct inode *inode, struct inode *lower_inode)
 {
-	/* This is where we setup the self-reference in the
-	 * vfs_inode's i_private. That way we don't have to walk the
-	 * list again. */
-	ecryptfs_set_inode_private(inode,
-				   container_of(inode,
-						struct ecryptfs_inode_info,
-						vfs_inode));
 	ecryptfs_set_inode_lower(inode, lower_inode);
 	inode->i_ino = lower_inode->i_ino;
 	inode->i_version++;
