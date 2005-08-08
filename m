Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbVHHWgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbVHHWgb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 18:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbVHHWbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 18:31:01 -0400
Received: from coderock.org ([193.77.147.115]:36227 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S932306AbVHHWay (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 18:30:54 -0400
Message-Id: <20050808223027.564769000@homer>
References: <20050808222936.090422000@homer>
Date: Tue, 09 Aug 2005 00:29:41 +0200
From: domen@coderock.org
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Maximilian Attems <janitor@sternwelten.at>,
       domen@coderock.org
Subject: [patch 05/16] fs/dcache.c: list_for_each*
Content-Disposition: inline; filename=list-for-each-fs_dcache.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Domen Puncer <domen@coderock.org>



First one is list_for_each_entry (thanks maks), second 2 list_for_each_safe.

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 dcache.c |   16 ++++------------
 1 files changed, 4 insertions(+), 12 deletions(-)

Index: quilt/fs/dcache.c
===================================================================
--- quilt.orig/fs/dcache.c
+++ quilt/fs/dcache.c
@@ -335,12 +335,10 @@ struct dentry * d_find_alias(struct inod
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
 		spin_lock(&dentry->d_lock);
 		if (!atomic_read(&dentry->d_count)) {
 			__dget_locked(dentry);
@@ -461,10 +459,7 @@ void shrink_dcache_sb(struct super_block
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
@@ -476,10 +471,7 @@ void shrink_dcache_sb(struct super_block
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

--
