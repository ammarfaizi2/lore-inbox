Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262861AbUKTEXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbUKTEXA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 23:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263082AbUKTClY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 21:41:24 -0500
Received: from baikonur.stro.at ([213.239.196.228]:45197 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S262861AbUKTCcI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 21:32:08 -0500
Subject: [patch 9/9]  list_for_each_entry in fs/dcache.c
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, domen@coderock.org
From: janitor@sternwelten.at
Date: Sat, 20 Nov 2004 03:32:07 +0100
Message-ID: <E1CVL2l-00011I-QJ@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Hi.

First 2 are list_for_each_entry (thanks maks), second 2 list_for_each_safe.
Boot tested.

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.10-rc2-bk4-max/fs/dcache.c |   16 ++++------------
 1 files changed, 4 insertions(+), 12 deletions(-)

diff -puN fs/dcache.c~list-for-each-fs_dcache fs/dcache.c
--- linux-2.6.10-rc2-bk4/fs/dcache.c~list-for-each-fs_dcache	2004-11-19 17:15:10.000000000 +0100
+++ linux-2.6.10-rc2-bk4-max/fs/dcache.c	2004-11-19 17:15:10.000000000 +0100
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
@@ -455,10 +453,7 @@ void shrink_dcache_sb(struct super_block
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
@@ -470,10 +465,7 @@ void shrink_dcache_sb(struct super_block
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
