Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264675AbTFLC1t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 22:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264676AbTFLC1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 22:27:49 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:36876 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S264675AbTFLC1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 22:27:47 -0400
Date: Thu, 12 Jun 2003 12:41:19 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove anon_hash_chain
Message-ID: <Mutt.LNX.4.44.0306121238450.19403-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against current bk removes anon_hash_chain from fs/inode.c, as 
all inodes in the 2.5 kernel must be associated with a superblock, and the 
anon hash is no longer needed.


- James
-- 
James Morris
<jmorris@intercode.com.au>

diff -purN -X dontdiff bk.pending/fs/inode.c bk.w1/fs/inode.c
--- bk.pending/fs/inode.c	2003-06-12 10:57:14.000000000 +1000
+++ bk.w1/fs/inode.c	2003-06-12 11:36:44.255403074 +1000
@@ -71,7 +71,6 @@ static unsigned int i_hash_shift;
 LIST_HEAD(inode_in_use);
 LIST_HEAD(inode_unused);
 static struct hlist_head *inode_hashtable;
-static HLIST_HEAD(anon_hash_chain); /* for inodes with NULL i_sb */
 
 /*
  * A simple spinlock to protect the list manipulations.
@@ -918,15 +917,12 @@ EXPORT_SYMBOL(iget_locked);
  *	@hashval: unsigned long value used to locate this object in the
  *		inode_hashtable.
  *
- *	Add an inode to the inode hash for this superblock. If the inode
- *	has no superblock it is added to a separate anonymous chain.
+ *	Add an inode to the inode hash for this superblock.
  */
  
 void __insert_inode_hash(struct inode *inode, unsigned long hashval)
 {
-	struct hlist_head *head = &anon_hash_chain;
-	if (inode->i_sb)
-		head = inode_hashtable + hash(inode->i_sb, hashval);
+	struct hlist_head *head = inode_hashtable + hash(inode->i_sb, hashval);
 	spin_lock(&inode_lock);
 	hlist_add_head(&inode->i_hash, head);
 	spin_unlock(&inode_lock);
@@ -936,7 +932,7 @@ void __insert_inode_hash(struct inode *i
  *	remove_inode_hash - remove an inode from the hash
  *	@inode: inode to unhash
  *
- *	Remove an inode from the superblock or anonymous hash.
+ *	Remove an inode from the superblock.
  */
  
 void remove_inode_hash(struct inode *inode)

