Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263111AbUKTFCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263111AbUKTFCI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 00:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262869AbUKTCj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 21:39:59 -0500
Received: from baikonur.stro.at ([213.239.196.228]:24272 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S263055AbUKTCby
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 21:31:54 -0500
Subject: [patch 4/9]  list_for_each_entry: 	fs-jffs-intrep.c
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, domen@coderock.org
From: janitor@sternwelten.at
Date: Sat, 20 Nov 2004 03:31:51 +0100
Message-ID: <E1CVL2W-0000pp-2r@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Use list_for_each_entry to make code more readable.
Compile tested.

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.10-rc2-bk4-max/fs/jffs/intrep.c |   22 +++++++++-------------
 1 files changed, 9 insertions(+), 13 deletions(-)

diff -puN fs/jffs/intrep.c~list-for-each-entry-fs_jffs_intrep fs/jffs/intrep.c
--- linux-2.6.10-rc2-bk4/fs/jffs/intrep.c~list-for-each-entry-fs_jffs_intrep	2004-11-19 17:14:55.000000000 +0100
+++ linux-2.6.10-rc2-bk4-max/fs/jffs/intrep.c	2004-11-19 17:14:55.000000000 +0100
@@ -1619,12 +1619,10 @@ jffs_find_file(struct jffs_control *c, _
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
@@ -2020,13 +2018,12 @@ jffs_foreach_file(struct jffs_control *c
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
@@ -2589,9 +2586,8 @@ jffs_print_hash_table(struct jffs_contro
 
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
_
