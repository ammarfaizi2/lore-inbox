Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262344AbVAJTfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbVAJTfm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 14:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262412AbVAJSsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 13:48:55 -0500
Received: from coderock.org ([193.77.147.115]:52412 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262344AbVAJSpe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 13:45:34 -0500
Subject: [patch 2/5] list_for_each_entry in fs/dcache.c
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, janitor@sternwelten.at
From: domen@coderock.org
Date: Mon, 10 Jan 2005 19:45:27 +0100
Message-Id: <20050110184528.350931F208@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Hi.

First 2 are list_for_each_entry (thanks maks), second 2 list_for_each_safe.
Boot tested.

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/fs/dcache.c |   16 ++++------------
 1 files changed, 4 insertions(+), 12 deletions(-)

diff -puN fs/dcache.c~list-for-each-fs_dcache fs/dcache.c
--- kj/fs/dcache.c~list-for-each-fs_dcache	2005-01-10 17:59:46.000000000 +0100
+++ kj-domen/fs/dcache.c	2005-01-10 17:59:46.000000000 +0100
@@ -334,12 +334,10 @@ struct dentry * d_find_alias(struct inod
  */
 void d_prune_aliases(struct inode *inode)
 {
-	struct list_head *tmp, *head = &inode->i_dentry;
+	struct dentry *dentry;
 restart:
 	spin_lock(&dcache_lock);
-	tmp = head;
-	while ((tmp = tmp->next) != head) {
-		struct dentry *dentry = list_entry(tmp, struct dentry, d_alias);
+	list_for_each_entry(dentry, &inode->i_dentry, d_alias) {
 		if (!atomic_read(&dentry->d_count)) {
 			__dget_locked(dentry);
 			__d_drop(dentry);
@@ -457,10 +455,7 @@ void shrink_dcache_sb(struct super_block
 	 * superblock to the most recent end of the unused list.
 	 */
 	spin_lock(&dcache_lock);
-	next = dentry_unused.next;
-	while (next != &dentry_unused) {
-		tmp = next;
-		next = tmp->next;
+	list_for_each_safe(tmp, next, &dentry_unused) {
 		dentry = list_entry(tmp, struct dentry, d_lru);
 		if (dentry->d_sb != sb)
 			continue;
@@ -472,10 +467,7 @@ void shrink_dcache_sb(struct super_block
 	 * Pass two ... free the dentries for this superblock.
 	 */
 repeat:
-	next = dentry_unused.next;
-	while (next != &dentry_unused) {
-		tmp = next;
-		next = tmp->next;
+	list_for_each_safe(tmp, next, &dentry_unused) {
 		dentry = list_entry(tmp, struct dentry, d_lru);
 		if (dentry->d_sb != sb)
 			continue;
_
