Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267481AbUGWQHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267481AbUGWQHk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 12:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267829AbUGWQHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 12:07:18 -0400
Received: from baikonur.stro.at ([213.239.196.228]:15769 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267825AbUGWPwX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 11:52:23 -0400
Date: Fri, 23 Jul 2004 17:52:18 +0200
From: maximilian attems <janitor@sternwelten.at>
To: viro@math.psu.edu
Cc: linux-kernel@vger.kernel.org
Subject: [patch-kj] use list_for_each()/list_for_each_save() in fs/dcache.c
Message-ID: <20040723155218.GP1795@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use list_for_each() where applicable
- for (list = ymf_devs.next; list != &ymf_devs; list = list->next) {
+ list_for_each(list, &ymf_devs) {
pure cosmetic change, defined as a preprocessor macro in:
include/linux/list.h

applies cleanly to 2.6.8-rc2

From: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.7-bk20-max/fs/dcache.c |   21 +++++----------------
 1 files changed, 5 insertions(+), 16 deletions(-)

diff -puN fs/dcache.c~list_for_each-fs-dcache fs/dcache.c
--- linux-2.6.7-bk20/fs/dcache.c~list_for_each-fs-dcache	2004-07-11 14:40:57.000000000 +0200
+++ linux-2.6.7-bk20-max/fs/dcache.c	2004-07-11 14:40:57.000000000 +0200
@@ -288,15 +288,11 @@ struct dentry * dget_locked(struct dentr
 
 struct dentry * d_find_alias(struct inode *inode)
 {
-	struct list_head *head, *next, *tmp;
+	struct list_head *tmp, *next;
 	struct dentry *alias, *discon_alias=NULL;
 
 	spin_lock(&dcache_lock);
-	head = &inode->i_dentry;
-	next = inode->i_dentry.next;
-	while (next != head) {
-		tmp = next;
-		next = tmp->next;
+	list_for_each_safe(tmp, next, &inode->i_dentry) {
 		prefetch(next);
 		alias = list_entry(tmp, struct dentry, d_alias);
  		if (!d_unhashed(alias)) {
@@ -324,8 +320,7 @@ void d_prune_aliases(struct inode *inode
 	struct list_head *tmp, *head = &inode->i_dentry;
 restart:
 	spin_lock(&dcache_lock);
-	tmp = head;
-	while ((tmp = tmp->next) != head) {
+	list_for_each(tmp, head) {
 		struct dentry *dentry = list_entry(tmp, struct dentry, d_alias);
 		if (!atomic_read(&dentry->d_count)) {
 			__dget_locked(dentry);
@@ -442,10 +437,7 @@ void shrink_dcache_sb(struct super_block
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
@@ -457,10 +449,7 @@ void shrink_dcache_sb(struct super_block
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


