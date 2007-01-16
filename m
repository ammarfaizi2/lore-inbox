Return-Path: <linux-kernel-owner+w=401wt.eu-S1750943AbXAPS5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbXAPS5v (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 13:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbXAPS5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 13:57:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34364 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750878AbXAPS5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 13:57:49 -0500
Date: Tue, 16 Jan 2007 13:57:45 -0500
Message-Id: <200701161857.l0GIvjkS016200@dantu.rdu.redhat.com>
From: Jeff Layton <jlayton@redhat.com>
To: akpm@osdl.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] make static counters in new_inode and iunique be 32 bits
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When a 32-bit program that was not compiled with large file offsets does a
stat and gets a st_ino value back that won't fit in the 32 bit field, glibc
(correctly) generates an EOVERFLOW error. We can't do anything about fs's
with larger permanent inode numbers, but when we generate them on the fly,
we ought to try and have them fit within a 32 bit field.

This patch takes the first step toward this by making the static counters in
these two functions be 32 bits.

Signed-off-by: Jeff Layton <jlayton@redhat.com>

diff --git a/fs/inode.c b/fs/inode.c
index bf21dc6..23fc1fd 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -524,7 +524,8 @@ repeat:
  */
 struct inode *new_inode(struct super_block *sb)
 {
-	static unsigned long last_ino;
+	/* 32 bits for compatability mode stat calls */
+	static unsigned int last_ino;
 	struct inode * inode;
 
 	spin_lock_prefetch(&inode_lock);
@@ -683,7 +684,8 @@ static unsigned long hash(struct super_block *sb, unsigned long hashval)
  */
 ino_t iunique(struct super_block *sb, ino_t max_reserved)
 {
-	static ino_t counter;
+	/* 32 bits for compatability mode stat calls */
+	static unsigned int counter;
 	struct inode *inode;
 	struct hlist_head * head;
 	ino_t res;
