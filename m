Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030539AbWHJBWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030539AbWHJBWK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 21:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030540AbWHJBV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 21:21:57 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:25729 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030543AbWHJBVy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 21:21:54 -0400
Subject: [PATCH 7/9] convert in-kernel JBD2 blk type to sector_t
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Content-Type: text/plain
Organization: IBM LTC
Date: Wed, 09 Aug 2006 18:21:55 -0700
Message-Id: <1155172915.3161.86.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


JBD2 layer in-kernel block variables type fixes to support >32 bit block number
and convert to sector_t type.

Signed-Off-By: Mingming Cao <cmm@us.ibm.com>


---

 linux-2.6.18-rc4-ming/fs/jbd2/commit.c          |    2 +-
 linux-2.6.18-rc4-ming/fs/jbd2/journal.c         |   16 ++++++++--------
 linux-2.6.18-rc4-ming/fs/jbd2/recovery.c        |    8 ++++----
 linux-2.6.18-rc4-ming/fs/jbd2/revoke.c          |   23 ++++++++++++-----------
 linux-2.6.18-rc4-ming/include/linux/ext4_jbd2.h |    2 +-
 linux-2.6.18-rc4-ming/include/linux/jbd2.h      |   17 ++++++++---------
 6 files changed, 34 insertions(+), 34 deletions(-)

diff -puN fs/jbd2/commit.c~sector_t-jbd2 fs/jbd2/commit.c
--- linux-2.6.18-rc4/fs/jbd2/commit.c~sector_t-jbd2	2006-08-09 15:42:03.125379791 -0700
+++ linux-2.6.18-rc4-ming/fs/jbd2/commit.c	2006-08-09 15:42:03.146379961 -0700
@@ -182,7 +182,7 @@ void jbd2_journal_commit_transaction(jou
 	int bufs;
 	int flags;
 	int err;
-	unsigned long blocknr;
+	sector_t blocknr;
 	char *tagp = NULL;
 	journal_header_t *header;
 	journal_block_tag_t *tag = NULL;
diff -puN fs/jbd2/journal.c~sector_t-jbd2 fs/jbd2/journal.c
--- linux-2.6.18-rc4/fs/jbd2/journal.c~sector_t-jbd2	2006-08-09 15:42:03.129379823 -0700
+++ linux-2.6.18-rc4-ming/fs/jbd2/journal.c	2006-08-09 15:42:03.149379985 -0700
@@ -270,7 +270,7 @@ static void journal_kill_thread(journal_
 int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 				  struct journal_head  *jh_in,
 				  struct journal_head **jh_out,
-				  int blocknr)
+				  sector_t blocknr)
 {
 	int need_copy_out = 0;
 	int done_copy_out = 0;
@@ -554,7 +554,7 @@ int jbd2_log_wait_commit(journal_t *jour
  * Log buffer allocation routines:
  */
 
-int jbd2_journal_next_log_block(journal_t *journal, unsigned long *retp)
+int jbd2_journal_next_log_block(journal_t *journal, sector_t *retp)
 {
 	unsigned long blocknr;
 
@@ -578,10 +578,10 @@ int jbd2_journal_next_log_block(journal_
  * ready.
  */
 int jbd2_journal_bmap(journal_t *journal, unsigned long blocknr,
-		 unsigned long *retp)
+		 sector_t *retp)
 {
 	int err = 0;
-	unsigned long ret;
+	sector_t ret;
 
 	if (journal->j_inode) {
 		ret = bmap(journal->j_inode, blocknr);
@@ -617,7 +617,7 @@ int jbd2_journal_bmap(journal_t *journal
 struct journal_head *jbd2_journal_get_descriptor_buffer(journal_t *journal)
 {
 	struct buffer_head *bh;
-	unsigned long blocknr;
+	sector_t blocknr;
 	int err;
 
 	err = jbd2_journal_next_log_block(journal, &blocknr);
@@ -705,7 +705,7 @@ fail:
  */
 journal_t * jbd2_journal_init_dev(struct block_device *bdev,
 			struct block_device *fs_dev,
-			int start, int len, int blocksize)
+			sector_t start, int len, int blocksize)
 {
 	journal_t *journal = journal_init_common();
 	struct buffer_head *bh;
@@ -753,7 +753,7 @@ journal_t * jbd2_journal_init_inode (str
 	journal_t *journal = journal_init_common();
 	int err;
 	int n;
-	unsigned long blocknr;
+	sector_t blocknr;
 
 	if (!journal)
 		return NULL;
@@ -853,7 +853,7 @@ static int journal_reset(journal_t *jour
  **/
 int jbd2_journal_create(journal_t *journal)
 {
-	unsigned long blocknr;
+	sector_t blocknr;
 	struct buffer_head *bh;
 	journal_superblock_t *sb;
 	int i, err;
diff -puN fs/jbd2/recovery.c~sector_t-jbd2 fs/jbd2/recovery.c
--- linux-2.6.18-rc4/fs/jbd2/recovery.c~sector_t-jbd2	2006-08-09 15:42:03.132379848 -0700
+++ linux-2.6.18-rc4-ming/fs/jbd2/recovery.c	2006-08-09 15:42:03.151380001 -0700
@@ -70,7 +70,7 @@ static int do_readahead(journal_t *journ
 {
 	int err;
 	unsigned int max, nbufs, next;
-	unsigned long blocknr;
+	sector_t blocknr;
 	struct buffer_head *bh;
 
 	struct buffer_head * bufs[MAXBUF];
@@ -132,7 +132,7 @@ static int jread(struct buffer_head **bh
 		 unsigned int offset)
 {
 	int err;
-	unsigned long blocknr;
+	sector_t blocknr;
 	struct buffer_head *bh;
 
 	*bhp = NULL;
@@ -452,7 +452,7 @@ static int do_one_pass(journal_t *journa
 						"block %ld in log\n",
 						err, io_block);
 				} else {
-					unsigned long blocknr;
+					sector_t blocknr;
 
 					J_ASSERT(obh != NULL);
 					blocknr = read_tag_block(tag_bytes,
@@ -592,7 +592,7 @@ static int scan_revoke_records(journal_t
 		record_len = 8;
 
 	while (offset + record_len < max) {
-		unsigned long blocknr;
+		sector_t blocknr;
 		int err;
 
 		if (record_len == 4)
diff -puN fs/jbd2/revoke.c~sector_t-jbd2 fs/jbd2/revoke.c
--- linux-2.6.18-rc4/fs/jbd2/revoke.c~sector_t-jbd2	2006-08-09 15:42:03.135379872 -0700
+++ linux-2.6.18-rc4-ming/fs/jbd2/revoke.c	2006-08-09 15:42:03.152380009 -0700
@@ -81,7 +81,7 @@ struct jbd2_revoke_record_s
 {
 	struct list_head  hash;
 	tid_t		  sequence;	/* Used for recovery only */
-	unsigned long	  blocknr;
+	sector_t	  blocknr;
 };
 

@@ -106,17 +106,18 @@ static void flush_descriptor(journal_t *
 /* Utility functions to maintain the revoke table */
 
 /* Borrowed from buffer.c: this is a tried and tested block hash function */
-static inline int hash(journal_t *journal, unsigned long block)
+static inline int hash(journal_t *journal, sector_t block)
 {
 	struct jbd2_revoke_table_s *table = journal->j_revoke;
 	int hash_shift = table->hash_shift;
+	int hash = (int)block ^ (int)((block >> 31) >> 1);
 
-	return ((block << (hash_shift - 6)) ^
-		(block >> 13) ^
-		(block << (hash_shift - 12))) & (table->hash_size - 1);
+	return ((hash << (hash_shift - 6)) ^
+		(hash >> 13) ^
+		(hash << (hash_shift - 12))) & (table->hash_size - 1);
 }
 
-static int insert_revoke_hash(journal_t *journal, unsigned long blocknr,
+static int insert_revoke_hash(journal_t *journal, sector_t blocknr,
 			      tid_t seq)
 {
 	struct list_head *hash_list;
@@ -146,7 +147,7 @@ oom:
 /* Find a revoke record in the journal's hash table. */
 
 static struct jbd2_revoke_record_s *find_revoke_record(journal_t *journal,
-						      unsigned long blocknr)
+						      sector_t blocknr)
 {
 	struct list_head *hash_list;
 	struct jbd2_revoke_record_s *record;
@@ -325,7 +326,7 @@ void jbd2_journal_destroy_revoke(journal
  * by one.
  */
 
-int jbd2_journal_revoke(handle_t *handle, unsigned long blocknr,
+int jbd2_journal_revoke(handle_t *handle, sector_t blocknr,
 		   struct buffer_head *bh_in)
 {
 	struct buffer_head *bh = NULL;
@@ -394,7 +395,7 @@ int jbd2_journal_revoke(handle_t *handle
 		}
 	}
 
-	jbd_debug(2, "insert revoke for block %lu, bh_in=%p\n", blocknr, bh_in);
+	jbd_debug(2, "insert revoke for block %llu, bh_in=%p\n",blocknr, bh_in);
 	err = insert_revoke_hash(journal, blocknr,
 				handle->h_transaction->t_tid);
 	BUFFER_TRACE(bh_in, "exit");
@@ -649,7 +650,7 @@ static void flush_descriptor(journal_t *
  */
 
 int jbd2_journal_set_revoke(journal_t *journal,
-		       unsigned long blocknr,
+		       sector_t blocknr,
 		       tid_t sequence)
 {
 	struct jbd2_revoke_record_s *record;
@@ -673,7 +674,7 @@ int jbd2_journal_set_revoke(journal_t *j
  */
 
 int jbd2_journal_test_revoke(journal_t *journal,
-			unsigned long blocknr,
+			sector_t blocknr,
 			tid_t sequence)
 {
 	struct jbd2_revoke_record_s *record;
diff -puN include/linux/ext4_jbd2.h~sector_t-jbd2 include/linux/ext4_jbd2.h
--- linux-2.6.18-rc4/include/linux/ext4_jbd2.h~sector_t-jbd2	2006-08-09 15:42:03.139379904 -0700
+++ linux-2.6.18-rc4-ming/include/linux/ext4_jbd2.h	2006-08-09 15:42:03.153380018 -0700
@@ -154,7 +154,7 @@ __ext4_journal_forget(const char *where,
 
 static inline int
 __ext4_journal_revoke(const char *where, handle_t *handle,
-		      unsigned long blocknr, struct buffer_head *bh)
+		      ext4_fsblk_t blocknr, struct buffer_head *bh)
 {
 	int err = jbd2_journal_revoke(handle, blocknr, bh);
 	if (err)
diff -puN include/linux/jbd2.h~sector_t-jbd2 include/linux/jbd2.h
--- linux-2.6.18-rc4/include/linux/jbd2.h~sector_t-jbd2	2006-08-09 15:42:03.142379928 -0700
+++ linux-2.6.18-rc4-ming/include/linux/jbd2.h	2006-08-09 15:42:03.155380034 -0700
@@ -738,7 +738,7 @@ struct journal_s
 	 */
 	struct block_device	*j_dev;
 	int			j_blocksize;
-	unsigned int		j_blk_offset;
+	sector_t		j_blk_offset;
 
 	/*
 	 * Device which holds the client fs.  For internal journal this will be
@@ -857,7 +857,7 @@ extern void __journal_clean_data_list(tr
 
 /* Log buffer allocation */
 extern struct journal_head * jbd2_journal_get_descriptor_buffer(journal_t *);
-int jbd2_journal_next_log_block(journal_t *, unsigned long *);
+int jbd2_journal_next_log_block(journal_t *, sector_t *);
 
 /* Commit management */
 extern void jbd2_journal_commit_transaction(journal_t *);
@@ -872,7 +872,7 @@ extern int
 jbd2_journal_write_metadata_buffer(transaction_t  *transaction,
 			      struct journal_head  *jh_in,
 			      struct journal_head **jh_out,
-			      int		   blocknr);
+			      sector_t   blocknr);
 
 /* Transaction locking */
 extern void		__wait_on_journal (journal_t *);
@@ -920,7 +920,7 @@ extern void	 jbd2_journal_unlock_updates
 
 extern journal_t * jbd2_journal_init_dev(struct block_device *bdev,
 				struct block_device *fs_dev,
-				int start, int len, int bsize);
+				sector_t start, int len, int bsize);
 extern journal_t * jbd2_journal_init_inode (struct inode *);
 extern int	   jbd2_journal_update_format (journal_t *);
 extern int	   jbd2_journal_check_used_features
@@ -941,7 +941,7 @@ extern void	   jbd2_journal_abort      (
 extern int	   jbd2_journal_errno      (journal_t *);
 extern void	   jbd2_journal_ack_err    (journal_t *);
 extern int	   jbd2_journal_clear_err  (journal_t *);
-extern int	   jbd2_journal_bmap(journal_t *, unsigned long, unsigned long *);
+extern int	   jbd2_journal_bmap(journal_t *, unsigned long, sector_t *);
 extern int	   jbd2_journal_force_commit(journal_t *);
 
 /*
@@ -974,14 +974,13 @@ extern void	   jbd2_journal_destroy_revo
 extern int	   jbd2_journal_init_revoke_caches(void);
 
 extern void	   jbd2_journal_destroy_revoke(journal_t *);
-extern int	   jbd2_journal_revoke (handle_t *,
-				unsigned long, struct buffer_head *);
+extern int	   jbd2_journal_revoke (handle_t *, sector_t, struct buffer_head *);
 extern int	   jbd2_journal_cancel_revoke(handle_t *, struct journal_head *);
 extern void	   jbd2_journal_write_revoke_records(journal_t *, transaction_t *);
 
 /* Recovery revoke support */
-extern int	jbd2_journal_set_revoke(journal_t *, unsigned long, tid_t);
-extern int	jbd2_journal_test_revoke(journal_t *, unsigned long, tid_t);
+extern int	jbd2_journal_set_revoke(journal_t *, sector_t, tid_t);
+extern int	jbd2_journal_test_revoke(journal_t *, sector_t, tid_t);
 extern void	jbd2_journal_clear_revoke(journal_t *);
 extern void	jbd2_journal_brelse_array(struct buffer_head *b[], int n);
 extern void	jbd2_journal_switch_revoke_table(journal_t *journal);

_


