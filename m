Return-Path: <linux-kernel-owner+w=401wt.eu-S965110AbWL2TLO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965110AbWL2TLO (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 14:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965113AbWL2TLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 14:11:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55405 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965110AbWL2TLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 14:11:11 -0500
Date: Fri, 29 Dec 2006 14:11:05 -0500
Message-Id: <200612291911.kBTJB5dO019099@dantu.rdu.redhat.com>
From: Jeff Layton <jlayton@redhat.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
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
