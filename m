Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbVHHWfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbVHHWfY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 18:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbVHHWbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 18:31:07 -0400
Received: from coderock.org ([193.77.147.115]:35459 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S932308AbVHHWau (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 18:30:50 -0400
Message-Id: <20050808223022.129463000@homer>
References: <20050808222936.090422000@homer>
Date: Tue, 09 Aug 2005 00:29:39 +0200
From: domen@coderock.org
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Maximilian Attems <janitor@sternwelten.at>,
       domen@coderock.org
Subject: [patch 03/16] jffs/intrep: list_for_each_entry
Content-Disposition: inline; filename=list-for-each-entry-fs_jffs_intrep.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Domen Puncer <domen@coderock.org>



Use list_for_each_entry to make code more readable.

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 intrep.c |   22 +++++++++-------------
 1 files changed, 9 insertions(+), 13 deletions(-)

Index: quilt/fs/jffs/intrep.c
===================================================================
--- quilt.orig/fs/jffs/intrep.c
+++ quilt/fs/jffs/intrep.c
@@ -1701,12 +1701,10 @@ jffs_find_file(struct jffs_control *c, _
 {
 	struct jffs_file *f;
 	int i = ino % c->hash_len;
-	struct list_head *tmp;
 
 	D3(printk("jffs_find_file(): ino: %u\n", ino));
 
-	for (tmp = c->hash[i].next; tmp != &c->hash[i]; tmp = tmp->next) {
-		f = list_entry(tmp, struct jffs_file, hash);
+	list_for_each_entry(f, &c->hash[i], hash) {
 		if (ino != f->ino)
 			continue;
 		D3(printk("jffs_find_file(): Found file with ino "
@@ -2102,13 +2100,12 @@ jffs_foreach_file(struct jffs_control *c
 	int result = 0;
 
 	for (pos = 0; pos < c->hash_len; pos++) {
-		struct list_head *p, *next;
-		for (p = c->hash[pos].next; p != &c->hash[pos]; p = next) {
-			/* We need a reference to the next file in the
-			   list because `func' might remove the current
-			   file `f'.  */
-			next = p->next;
-			r = func(list_entry(p, struct jffs_file, hash));
+		struct jffs_file *f, *next;
+
+		/* We must do _safe, because 'func' might remove the
+		   current file 'f' from the list.  */
+		list_for_each_entry_safe(f, next, &c->hash[pos], hash) {
+			r = func(f);
 			if (r < 0)
 				return r;
 			result += r;
@@ -2613,9 +2610,8 @@ jffs_print_hash_table(struct jffs_contro
 
 	printk("JFFS: Dumping the file system's hash table...\n");
 	for (i = 0; i < c->hash_len; i++) {
-		struct list_head *p;
-		for (p = c->hash[i].next; p != &c->hash[i]; p = p->next) {
-			struct jffs_file *f=list_entry(p,struct jffs_file,hash);
+		struct jffs_file *f;
+		list_for_each_entry(f, &c->hash[i], hash) {
 			printk("*** c->hash[%u]: \"%s\" "
 			       "(ino: %u, pino: %u)\n",
 			       i, (f->name ? f->name : ""),

--
