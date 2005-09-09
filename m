Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932552AbVIIIta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932552AbVIIIta (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 04:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932557AbVIIIt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 04:49:29 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:19117 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932552AbVIIIt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 04:49:28 -0400
Date: Fri, 9 Sep 2005 17:46:00 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: sct@redhat.com, akpm@osdl.org, adilger@clusterfs.com,
       ext3-users@redhat.com
Subject: [PATCH 3/6] jbd: cleanup for initializing/destroying the revoke tables
Message-ID: <20050909084600.GE14205@miraclelinux.com>
References: <20050909084214.GB14205@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050909084214.GB14205@miraclelinux.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

use loop counter for initializing/destroying a pair of the revoke tables.

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

---

 revoke.c |  116 ++++++++++++++++++++++-----------------------------------------
 1 files changed, 42 insertions(+), 74 deletions(-)

diff -X 2.6.13-mm1/Documentation/dontdiff -Nurp 2.6.13-mm1.old/fs/jbd/revoke.c 2.6.13-mm1/fs/jbd/revoke.c
--- 2.6.13-mm1.old/fs/jbd/revoke.c	2005-09-05 03:21:00.000000000 +0900
+++ 2.6.13-mm1/fs/jbd/revoke.c	2005-09-05 11:16:04.000000000 +0900
@@ -193,108 +193,76 @@ void journal_destroy_revoke_caches(void)
 
 int journal_init_revoke(journal_t *journal, int hash_size)
 {
-	int shift, tmp;
+	int shift = 0;
+	int tmp = hash_size;
+	int i;
 
+	/* Check that the hash_size is a power of two */
+	J_ASSERT ((hash_size & (hash_size-1)) == 0);
 	J_ASSERT (journal->j_revoke_table[0] == NULL);
 
-	shift = 0;
-	tmp = hash_size;
-	while((tmp >>= 1UL) != 0UL)
+	while ((tmp >>= 1UL) != 0UL)
 		shift++;
 
-	journal->j_revoke_table[0] = kmem_cache_alloc(revoke_table_cache, GFP_KERNEL);
-	if (!journal->j_revoke_table[0])
-		return -ENOMEM;
-	journal->j_revoke = journal->j_revoke_table[0];
-
-	/* Check that the hash_size is a power of two */
-	J_ASSERT ((hash_size & (hash_size-1)) == 0);
+	for (i = 0; i < 2; i++) {
+		struct jbd_revoke_table_s *table;
 
-	journal->j_revoke->hash_size = hash_size;
+		table = kmem_cache_alloc(revoke_table_cache, GFP_KERNEL);
+		if (!table)
+			goto nomem;
+
+		table->hash_size = hash_size;
+		table->hash_shift = shift;
+		table->hash_table = kmalloc(hash_size * sizeof(struct hlist_head), GFP_KERNEL);
+		if (!table->hash_table) {
+			kmem_cache_free(revoke_table_cache, table);
+			goto nomem;
+		}
 
-	journal->j_revoke->hash_shift = shift;
+		for (tmp = 0; tmp < hash_size; tmp++)
+			INIT_HLIST_HEAD(&table->hash_table[tmp]);
 
-	journal->j_revoke->hash_table =
-		kmalloc(hash_size * sizeof(struct hlist_head), GFP_KERNEL);
-	if (!journal->j_revoke->hash_table) {
-		kmem_cache_free(revoke_table_cache, journal->j_revoke_table[0]);
-		journal->j_revoke = NULL;
-		return -ENOMEM;
-	}
-
-	for (tmp = 0; tmp < hash_size; tmp++)
-		INIT_HLIST_HEAD(&journal->j_revoke->hash_table[tmp]);
-
-	journal->j_revoke_table[1] = kmem_cache_alloc(revoke_table_cache, GFP_KERNEL);
-	if (!journal->j_revoke_table[1]) {
-		kfree(journal->j_revoke_table[0]->hash_table);
-		kmem_cache_free(revoke_table_cache, journal->j_revoke_table[0]);
-		return -ENOMEM;
+		journal->j_revoke_table[i] = table;
 	}
-
 	journal->j_revoke = journal->j_revoke_table[1];
+	spin_lock_init(&journal->j_revoke_lock);
 
-	/* Check that the hash_size is a power of two */
-	J_ASSERT ((hash_size & (hash_size-1)) == 0);
-
-	journal->j_revoke->hash_size = hash_size;
-
-	journal->j_revoke->hash_shift = shift;
+	return 0;
 
-	journal->j_revoke->hash_table =
-		kmalloc(hash_size * sizeof(struct hlist_head), GFP_KERNEL);
-	if (!journal->j_revoke->hash_table) {
-		kfree(journal->j_revoke_table[0]->hash_table);
-		kmem_cache_free(revoke_table_cache, journal->j_revoke_table[0]);
-		kmem_cache_free(revoke_table_cache, journal->j_revoke_table[1]);
-		journal->j_revoke = NULL;
-		return -ENOMEM;
+nomem:
+	while (i--) {
+		kfree(journal->j_revoke_table[i]->hash_table);
+		kmem_cache_free(revoke_table_cache, journal->j_revoke_table[i]);
 	}
 
-	for (tmp = 0; tmp < hash_size; tmp++)
-		INIT_HLIST_HEAD(&journal->j_revoke->hash_table[tmp]);
-
-	spin_lock_init(&journal->j_revoke_lock);
-
-	return 0;
+	return -ENOMEM;
 }
 
 /* Destoy a journal's revoke table.  The table must already be empty! */
 
 void journal_destroy_revoke(journal_t *journal)
 {
-	struct jbd_revoke_table_s *table;
-	struct hlist_head *hash_list;
-	int i;
+	int j;
 
-	table = journal->j_revoke_table[0];
-	if (!table)
-		return;
+	journal->j_revoke = NULL;
 
-	for (i=0; i<table->hash_size; i++) {
-		hash_list = &table->hash_table[i];
-		J_ASSERT (hlist_empty(hash_list));
-	}
+	for (j = 0; j < 2; j++) {
+		int i;
+		struct jbd_revoke_table_s *table = journal->j_revoke_table[j];
 
-	kfree(table->hash_table);
-	kmem_cache_free(revoke_table_cache, table);
-	journal->j_revoke = NULL;
+		if (!table)
+			return;
 
-	table = journal->j_revoke_table[1];
-	if (!table)
-		return;
+		for (i = 0; i < table->hash_size; i++) {
+			struct hlist_head *hash_list = &table->hash_table[i];
+			J_ASSERT (hlist_empty(hash_list));
+		}
 
-	for (i=0; i<table->hash_size; i++) {
-		hash_list = &table->hash_table[i];
-		J_ASSERT (hlist_empty(hash_list));
+		kfree(table->hash_table);
+		kmem_cache_free(revoke_table_cache, table);
 	}
-
-	kfree(table->hash_table);
-	kmem_cache_free(revoke_table_cache, table);
-	journal->j_revoke = NULL;
 }
 
-
 #ifdef __KERNEL__
 
 /* 
