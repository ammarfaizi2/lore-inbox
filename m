Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267804AbUGWQHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267804AbUGWQHk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 12:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267831AbUGWQH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 12:07:28 -0400
Received: from baikonur.stro.at ([213.239.196.228]:2256 "EHLO baikonur.stro.at")
	by vger.kernel.org with ESMTP id S267481AbUGWPza (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 11:55:30 -0400
Date: Fri, 23 Jul 2004 17:55:28 +0200
From: maximilian attems <janitor@sternwelten.at>
To: jffs-dev@axis.com
Cc: linux-kernel@vger.kernel.org
Subject: [patch-kj] use list_for_each() in fs/jffs/intrep.c
Message-ID: <20040723155528.GQ1795@stro.at>
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

 linux-2.6.7-bk20-max/fs/jffs/intrep.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff -puN fs/jffs/intrep.c~list_for_each-fs-jffs fs/jffs/intrep.c
--- linux-2.6.7-bk20/fs/jffs/intrep.c~list_for_each-fs-jffs	2004-07-11 14:41:04.000000000 +0200
+++ linux-2.6.7-bk20-max/fs/jffs/intrep.c	2004-07-11 14:41:04.000000000 +0200
@@ -1623,7 +1623,7 @@ jffs_find_file(struct jffs_control *c, _
 
 	D3(printk("jffs_find_file(): ino: %u\n", ino));
 
-	for (tmp = c->hash[i].next; tmp != &c->hash[i]; tmp = tmp->next) {
+	list_for_each(tmp, &c->hash[i]) {
 		f = list_entry(tmp, struct jffs_file, hash);
 		if (ino != f->ino)
 			continue;
@@ -2021,11 +2021,10 @@ jffs_foreach_file(struct jffs_control *c
 
 	for (pos = 0; pos < c->hash_len; pos++) {
 		struct list_head *p, *next;
-		for (p = c->hash[pos].next; p != &c->hash[pos]; p = next) {
-			/* We need a reference to the next file in the
-			   list because `func' might remove the current
-			   file `f'.  */
-			next = p->next;
+
+		/* We must do _safe, because 'func' might remove the
+		   current file 'f' from the list.  */
+		list_for_each_safe(p, next, &c->hash[pos]) {
 			r = func(list_entry(p, struct jffs_file, hash));
 			if (r < 0)
 				return r;
@@ -2590,7 +2589,7 @@ jffs_print_hash_table(struct jffs_contro
 	printk("JFFS: Dumping the file system's hash table...\n");
 	for (i = 0; i < c->hash_len; i++) {
 		struct list_head *p;
-		for (p = c->hash[i].next; p != &c->hash[i]; p = p->next) {
+		list_for_each(p, &c->hash[i]) {
 			struct jffs_file *f=list_entry(p,struct jffs_file,hash);
 			printk("*** c->hash[%u]: \"%s\" "
 			       "(ino: %u, pino: %u)\n",

