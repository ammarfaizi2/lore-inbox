Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267909AbUGWTKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267909AbUGWTKj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 15:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267910AbUGWTKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 15:10:39 -0400
Received: from main.gmane.org ([80.91.224.249]:48032 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S267909AbUGWTKT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 15:10:19 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Domen Puncer <domen@coderock.org>
Subject: Re: [patch-kj] use list_for_each() in fs/jffs/intrep.c
Date: Fri, 23 Jul 2004 21:02:00 +0200
Message-ID: <pan.2004.07.23.19.02.00.666530@coderock.org>
References: <20040723155528.GQ1795@stro.at> <20040723161724.GA31884@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: coderock.org
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
Cc: jffs-dev@axis.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 23 Jul 2004 17:17:24 +0100, Christoph Hellwig wrote:

> On Fri, Jul 23, 2004 at 05:55:28PM +0200, maximilian attems wrote:
>> 
>> Use list_for_each() where applicable
>> - for (list = ymf_devs.next; list != &ymf_devs; list = list->next) {
>> + list_for_each(list, &ymf_devs) {
>> pure cosmetic change, defined as a preprocessor macro in:
>> include/linux/list.h
>> 
>> applies cleanly to 2.6.8-rc2
>> 
>> From: Domen Puncer <domen@coderock.org>
>> Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
> 
> Please switch to list_for_each_entry while you're at it.

Jup, list_for_each_entry is nicer.
(first time posting trough gmane, hope it works)

Compile tested


Signed-off-by: Domen Puncer <domen@coderock.org>

--- c/fs/jffs/intrep.c	Wed Jul 14 19:15:11 2004
+++ a/fs/jffs/intrep.c	Fri Jul 23 20:08:55 2004
@@ -1619,12 +1619,10 @@
 {
 	struct jffs_file *f;
 	int i = ino % c->hash_len;
-	struct list_head *tmp;
 
 	D3(printk("jffs_find_file(): ino: %u\n", ino));
 
-	for (tmp = c->hash[i].next; tmp != &c->hash[i]; tmp = tmp->next) {
-		f = list_entry(tmp, struct jffs_file, hash);
+	list_for_each_entry(f, c->hash[i].next, hash) {
 		if (ino != f->ino)
 			continue;
 		D3(printk("jffs_find_file(): Found file with ino "
@@ -2020,13 +2018,12 @@
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
@@ -2589,9 +2586,8 @@
 
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


