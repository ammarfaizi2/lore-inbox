Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932558AbVIIIsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932558AbVIIIsN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 04:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932552AbVIIIsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 04:48:12 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:7085 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932561AbVIIIsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 04:48:10 -0400
Date: Fri, 9 Sep 2005 17:44:41 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: sct@redhat.com, akpm@osdl.org, adilger@clusterfs.com,
       ext3-users@redhat.com
Subject: [PATCH 2/6] jbd: use hlist for the revoke tables
Message-ID: <20050909084441.GD14205@miraclelinux.com>
References: <20050909084214.GB14205@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050909084214.GB14205@miraclelinux.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

use struct hlist_head and hlist_node for the revoke tables.

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

---

 revoke.c |   56 ++++++++++++++++++++++++++------------------------------
 1 files changed, 26 insertions(+), 30 deletions(-)

diff -Nurp 2.6.13-mm1.old/fs/jbd/revoke.c 2.6.13-mm1/fs/jbd/revoke.c
--- 2.6.13-mm1.old/fs/jbd/revoke.c	2005-09-04 21:46:35.000000000 +0900
+++ 2.6.13-mm1/fs/jbd/revoke.c	2005-09-04 21:50:25.000000000 +0900
@@ -79,7 +79,7 @@ static kmem_cache_t *revoke_table_cache;
 
 struct jbd_revoke_record_s 
 {
-	struct list_head  hash;
+	struct hlist_node hash;
 	tid_t		  sequence;	/* Used for recovery only */
 	unsigned long	  blocknr;
 };
@@ -92,7 +92,7 @@ struct jbd_revoke_table_s
 	 * for recovery.  Must be a power of two. */
 	int		  hash_size; 
 	int		  hash_shift; 
-	struct list_head *hash_table;
+	struct hlist_head *hash_table;
 };
 
 
@@ -119,7 +119,6 @@ static inline int hash(journal_t *journa
 static int insert_revoke_hash(journal_t *journal, unsigned long blocknr,
 			      tid_t seq)
 {
-	struct list_head *hash_list;
 	struct jbd_revoke_record_s *record;
 
 repeat:
@@ -129,9 +128,9 @@ repeat:
 
 	record->sequence = seq;
 	record->blocknr = blocknr;
-	hash_list = &journal->j_revoke->hash_table[hash(journal, blocknr)];
 	spin_lock(&journal->j_revoke_lock);
-	list_add(&record->hash, hash_list);
+	hlist_add_head(&record->hash,
+		       &journal->j_revoke->hash_table[hash(journal, blocknr)]);
 	spin_unlock(&journal->j_revoke_lock);
 	return 0;
 
@@ -148,19 +147,16 @@ oom:
 static struct jbd_revoke_record_s *find_revoke_record(journal_t *journal,
 						      unsigned long blocknr)
 {
-	struct list_head *hash_list;
+	struct hlist_node *node;
 	struct jbd_revoke_record_s *record;
 
-	hash_list = &journal->j_revoke->hash_table[hash(journal, blocknr)];
-
 	spin_lock(&journal->j_revoke_lock);
-	record = (struct jbd_revoke_record_s *) hash_list->next;
-	while (&(record->hash) != hash_list) {
+	hlist_for_each_entry(record, node,
+		&journal->j_revoke->hash_table[hash(journal, blocknr)], hash) {
 		if (record->blocknr == blocknr) {
 			spin_unlock(&journal->j_revoke_lock);
 			return record;
 		}
-		record = (struct jbd_revoke_record_s *) record->hash.next;
 	}
 	spin_unlock(&journal->j_revoke_lock);
 	return NULL;
@@ -219,7 +215,7 @@ int journal_init_revoke(journal_t *journ
 	journal->j_revoke->hash_shift = shift;
 
 	journal->j_revoke->hash_table =
-		kmalloc(hash_size * sizeof(struct list_head), GFP_KERNEL);
+		kmalloc(hash_size * sizeof(struct hlist_head), GFP_KERNEL);
 	if (!journal->j_revoke->hash_table) {
 		kmem_cache_free(revoke_table_cache, journal->j_revoke_table[0]);
 		journal->j_revoke = NULL;
@@ -227,7 +223,7 @@ int journal_init_revoke(journal_t *journ
 	}
 
 	for (tmp = 0; tmp < hash_size; tmp++)
-		INIT_LIST_HEAD(&journal->j_revoke->hash_table[tmp]);
+		INIT_HLIST_HEAD(&journal->j_revoke->hash_table[tmp]);
 
 	journal->j_revoke_table[1] = kmem_cache_alloc(revoke_table_cache, GFP_KERNEL);
 	if (!journal->j_revoke_table[1]) {
@@ -246,7 +242,7 @@ int journal_init_revoke(journal_t *journ
 	journal->j_revoke->hash_shift = shift;
 
 	journal->j_revoke->hash_table =
-		kmalloc(hash_size * sizeof(struct list_head), GFP_KERNEL);
+		kmalloc(hash_size * sizeof(struct hlist_head), GFP_KERNEL);
 	if (!journal->j_revoke->hash_table) {
 		kfree(journal->j_revoke_table[0]->hash_table);
 		kmem_cache_free(revoke_table_cache, journal->j_revoke_table[0]);
@@ -256,7 +252,7 @@ int journal_init_revoke(journal_t *journ
 	}
 
 	for (tmp = 0; tmp < hash_size; tmp++)
-		INIT_LIST_HEAD(&journal->j_revoke->hash_table[tmp]);
+		INIT_HLIST_HEAD(&journal->j_revoke->hash_table[tmp]);
 
 	spin_lock_init(&journal->j_revoke_lock);
 
@@ -268,7 +264,7 @@ int journal_init_revoke(journal_t *journ
 void journal_destroy_revoke(journal_t *journal)
 {
 	struct jbd_revoke_table_s *table;
-	struct list_head *hash_list;
+	struct hlist_head *hash_list;
 	int i;
 
 	table = journal->j_revoke_table[0];
@@ -277,7 +273,7 @@ void journal_destroy_revoke(journal_t *j
 
 	for (i=0; i<table->hash_size; i++) {
 		hash_list = &table->hash_table[i];
-		J_ASSERT (list_empty(hash_list));
+		J_ASSERT (hlist_empty(hash_list));
 	}
 
 	kfree(table->hash_table);
@@ -290,7 +286,7 @@ void journal_destroy_revoke(journal_t *j
 
 	for (i=0; i<table->hash_size; i++) {
 		hash_list = &table->hash_table[i];
-		J_ASSERT (list_empty(hash_list));
+		J_ASSERT (hlist_empty(hash_list));
 	}
 
 	kfree(table->hash_table);
@@ -445,7 +441,7 @@ int journal_cancel_revoke(handle_t *hand
 			jbd_debug(4, "cancelled existing revoke on "
 				  "blocknr %llu\n", (unsigned long long)bh->b_blocknr);
 			spin_lock(&journal->j_revoke_lock);
-			list_del(&record->hash);
+			hlist_del(&record->hash);
 			spin_unlock(&journal->j_revoke_lock);
 			kmem_cache_free(revoke_record_cache, record);
 			did_revoke = 1;
@@ -488,7 +484,7 @@ void journal_switch_revoke_table(journal
 		journal->j_revoke = journal->j_revoke_table[0];
 
 	for (i = 0; i < journal->j_revoke->hash_size; i++) 
-		INIT_LIST_HEAD(&journal->j_revoke->hash_table[i]);
+		INIT_HLIST_HEAD(&journal->j_revoke->hash_table[i]);
 }
 
 /*
@@ -504,7 +500,6 @@ void journal_write_revoke_records(journa
 	struct journal_head *descriptor;
 	struct jbd_revoke_record_s *record;
 	struct jbd_revoke_table_s *revoke;
-	struct list_head *hash_list;
 	int i, offset, count;
 
 	descriptor = NULL; 
@@ -516,16 +511,16 @@ void journal_write_revoke_records(journa
 		journal->j_revoke_table[1] : journal->j_revoke_table[0];
 
 	for (i = 0; i < revoke->hash_size; i++) {
-		hash_list = &revoke->hash_table[i];
+		struct hlist_head *hash_list = &revoke->hash_table[i];
 
-		while (!list_empty(hash_list)) {
-			record = (struct jbd_revoke_record_s *) 
-				hash_list->next;
+		while (!hlist_empty(hash_list)) {
+			record = hlist_entry(hash_list->first,
+					struct jbd_revoke_record_s, hash);
 			write_one_revoke_record(journal, transaction,
 						&descriptor, &offset, 
 						record);
 			count++;
-			list_del(&record->hash);
+			hlist_del(&record->hash);
 			kmem_cache_free(revoke_record_cache, record);
 		}
 	}
@@ -686,7 +681,7 @@ int journal_test_revoke(journal_t *journ
 void journal_clear_revoke(journal_t *journal)
 {
 	int i;
-	struct list_head *hash_list;
+	struct hlist_head *hash_list;
 	struct jbd_revoke_record_s *record;
 	struct jbd_revoke_table_s *revoke;
 
@@ -694,9 +689,10 @@ void journal_clear_revoke(journal_t *jou
 
 	for (i = 0; i < revoke->hash_size; i++) {
 		hash_list = &revoke->hash_table[i];
-		while (!list_empty(hash_list)) {
-			record = (struct jbd_revoke_record_s*) hash_list->next;
-			list_del(&record->hash);
+		while (!hlist_empty(hash_list)) {
+			record = hlist_entry(hash_list->first,
+					struct jbd_revoke_record_s, hash);
+			hlist_del(&record->hash);
 			kmem_cache_free(revoke_record_cache, record);
 		}
 	}
