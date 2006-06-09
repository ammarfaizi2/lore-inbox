Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965089AbWFIBXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965089AbWFIBXI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 21:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965094AbWFIBXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 21:23:06 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:57825 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S965089AbWFIBXC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 21:23:02 -0400
Subject: [RFC 8/13] extents and 48bit ext3: JBD layer in-kernel block
	variables type fixes
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Content-Type: text/plain
Organization: IBM LTC
Date: Thu, 08 Jun 2006 18:23:00 -0700
Message-Id: <1149816180.4066.70.camel@dyn9047017069.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


JBD layer in-kernel block varibles type fixes to support >32 bit block number
and convert to sector_t type.

Signed-Off-By: Mingming Cao <cmm@us.ibm.com>


---

 linux-2.6.16-ming/fs/jbd/commit.c          |    2 +-
 linux-2.6.16-ming/fs/jbd/journal.c         |   16 ++++++++--------
 linux-2.6.16-ming/fs/jbd/recovery.c        |    8 ++++----
 linux-2.6.16-ming/fs/jbd/revoke.c          |   24 +++++++++++++-----------
 linux-2.6.16-ming/include/linux/ext3_jbd.h |    2 +-
 linux-2.6.16-ming/include/linux/jbd.h      |   17 ++++++++---------
 6 files changed, 35 insertions(+), 34 deletions(-)

diff -puN fs/jbd/commit.c~sector_t-jbd fs/jbd/commit.c
--- linux-2.6.16/fs/jbd/commit.c~sector_t-jbd	2006-06-08 16:29:53.194280561 -0700
+++ linux-2.6.16-ming/fs/jbd/commit.c	2006-06-08 16:29:53.214278280 -0700
@@ -180,7 +180,7 @@ void journal_commit_transaction(journal_
 	int bufs;
 	int flags;
 	int err;
-	unsigned long blocknr;
+	sector_t blocknr;
 	char *tagp = NULL;
 	journal_header_t *header;
 	journal_block_tag_t *tag = NULL;
diff -puN fs/jbd/recovery.c~sector_t-jbd fs/jbd/recovery.c
--- linux-2.6.16/fs/jbd/recovery.c~sector_t-jbd	2006-06-08 16:29:53.197280218 -0700
+++ linux-2.6.16-ming/fs/jbd/recovery.c	2006-06-08 16:29:53.215278166 -0700
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
@@ -451,7 +451,7 @@ static int do_one_pass(journal_t *journa
 						"block %ld in log\n",
 						err, io_block);
 				} else {
-					unsigned long blocknr;
+					sector_t blocknr;
 
 					J_ASSERT(obh != NULL);
 					blocknr = read_split_be64(&tag->t_blocknr_high,
@@ -590,7 +590,7 @@ static int scan_revoke_records(journal_t
 		record_len = 8;
 
 	while (offset + record_len < max) {
-		unsigned long blocknr;
+		sector_t blocknr;
 		int err;
 
 		if (record_len == 4)
diff -puN fs/jbd/revoke.c~sector_t-jbd fs/jbd/revoke.c
--- linux-2.6.16/fs/jbd/revoke.c~sector_t-jbd	2006-06-08 16:29:53.200279876 -0700
+++ linux-2.6.16-ming/fs/jbd/revoke.c	2006-06-08 16:29:53.217277937 -0700
@@ -81,7 +81,7 @@ struct jbd_revoke_record_s 
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
 	struct jbd_revoke_table_s *table = journal->j_revoke;
 	int hash_shift = table->hash_shift;
+	int hash = (int)block ^ (int)(block >> 32);
 
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
 
 static struct jbd_revoke_record_s *find_revoke_record(journal_t *journal,
-						      unsigned long blocknr)
+						      sector_t blocknr)
 {
 	struct list_head *hash_list;
 	struct jbd_revoke_record_s *record;
@@ -325,7 +326,7 @@ void journal_destroy_revoke(journal_t *j
  * by one.
  */
 
-int journal_revoke(handle_t *handle, unsigned long blocknr, 
+int journal_revoke(handle_t *handle, sector_t blocknr,
 		   struct buffer_head *bh_in)
 {
 	struct buffer_head *bh = NULL;
@@ -394,7 +395,8 @@ int journal_revoke(handle_t *handle, uns
 		}
 	}
 
-	jbd_debug(2, "insert revoke for block %lu, bh_in=%p\n", blocknr, bh_in);
+	jbd_debug(2, "insert revoke for block %llu, bh_in=%p\n",
+		blocknr, bh_in);
 	err = insert_revoke_hash(journal, blocknr,
 				handle->h_transaction->t_tid);
 	BUFFER_TRACE(bh_in, "exit");
@@ -649,7 +651,7 @@ static void flush_descriptor(journal_t *
  */
 
 int journal_set_revoke(journal_t *journal, 
-		       unsigned long blocknr, 
+		       sector_t blocknr,
 		       tid_t sequence)
 {
 	struct jbd_revoke_record_s *record;
@@ -673,7 +675,7 @@ int journal_set_revoke(journal_t *journa
  */
 
 int journal_test_revoke(journal_t *journal, 
-			unsigned long blocknr,
+			sector_t blocknr,
 			tid_t sequence)
 {
 	struct jbd_revoke_record_s *record;
diff -puN include/linux/ext3_jbd.h~sector_t-jbd include/linux/ext3_jbd.h
--- linux-2.6.16/include/linux/ext3_jbd.h~sector_t-jbd	2006-06-08 16:29:53.203279534 -0700
+++ linux-2.6.16-ming/include/linux/ext3_jbd.h	2006-06-08 16:49:48.802939972 -0700
@@ -149,7 +149,7 @@ __ext3_journal_forget(const char *where,
 
 static inline int
 __ext3_journal_revoke(const char *where, handle_t *handle,
-		      unsigned long blocknr, struct buffer_head *bh)
+		      ext3_fsblk_t blocknr, struct buffer_head *bh)
 {
 	int err = journal_revoke(handle, blocknr, bh);
 	if (err)
diff -puN include/linux/jbd.h~sector_t-jbd include/linux/jbd.h
--- linux-2.6.16/include/linux/jbd.h~sector_t-jbd	2006-06-08 16:29:53.207279078 -0700
+++ linux-2.6.16-ming/include/linux/jbd.h	2006-06-08 16:29:53.220277595 -0700
@@ -729,7 +729,7 @@ struct journal_s
 	 */
 	struct block_device	*j_dev;
 	int			j_blocksize;
-	unsigned int		j_blk_offset;
+	sector_t		j_blk_offset;
 
 	/*
 	 * Device which holds the client fs.  For internal journal this will be
@@ -848,7 +848,7 @@ extern void __journal_clean_data_list(tr
 
 /* Log buffer allocation */
 extern struct journal_head * journal_get_descriptor_buffer(journal_t *);
-int journal_next_log_block(journal_t *, unsigned long *);
+int journal_next_log_block(journal_t *, sector_t *);
 
 /* Commit management */
 extern void journal_commit_transaction(journal_t *);
@@ -863,7 +863,7 @@ extern int 
 journal_write_metadata_buffer(transaction_t	  *transaction,
 			      struct journal_head  *jh_in,
 			      struct journal_head **jh_out,
-			      int		   blocknr);
+			      sector_t   blocknr);
 
 /* Transaction locking */
 extern void		__wait_on_journal (journal_t *);
@@ -911,7 +911,7 @@ extern void	 journal_unlock_updates (jou
 
 extern journal_t * journal_init_dev(struct block_device *bdev,
 				struct block_device *fs_dev,
-				int start, int len, int bsize);
+				sector_t start, int len, int bsize);
 extern journal_t * journal_init_inode (struct inode *);
 extern int	   journal_update_format (journal_t *);
 extern int	   journal_check_used_features 
@@ -932,7 +932,7 @@ extern void	   journal_abort      (journ
 extern int	   journal_errno      (journal_t *);
 extern void	   journal_ack_err    (journal_t *);
 extern int	   journal_clear_err  (journal_t *);
-extern int	   journal_bmap(journal_t *, unsigned long, unsigned long *);
+extern int	   journal_bmap(journal_t *, unsigned long, sector_t *);
 extern int	   journal_force_commit(journal_t *);
 
 /*
@@ -965,14 +965,13 @@ extern void	   journal_destroy_revoke_ca
 extern int	   journal_init_revoke_caches(void);
 
 extern void	   journal_destroy_revoke(journal_t *);
-extern int	   journal_revoke (handle_t *,
-				unsigned long, struct buffer_head *);
+extern int	   journal_revoke (handle_t *, sector_t, struct buffer_head *);
 extern int	   journal_cancel_revoke(handle_t *, struct journal_head *);
 extern void	   journal_write_revoke_records(journal_t *, transaction_t *);
 
 /* Recovery revoke support */
-extern int	journal_set_revoke(journal_t *, unsigned long, tid_t);
-extern int	journal_test_revoke(journal_t *, unsigned long, tid_t);
+extern int	journal_set_revoke(journal_t *, sector_t, tid_t);
+extern int	journal_test_revoke(journal_t *, sector_t, tid_t);
 extern void	journal_clear_revoke(journal_t *);
 extern void	journal_brelse_array(struct buffer_head *b[], int n);
 extern void	journal_switch_revoke_table(journal_t *journal);
diff -puN fs/jbd/journal.c~sector_t-jbd fs/jbd/journal.c
--- linux-2.6.16/fs/jbd/journal.c~sector_t-jbd	2006-06-08 16:29:53.210278736 -0700
+++ linux-2.6.16-ming/fs/jbd/journal.c	2006-06-08 16:29:53.223277253 -0700
@@ -269,7 +269,7 @@ static void journal_kill_thread(journal_
 int journal_write_metadata_buffer(transaction_t *transaction,
 				  struct journal_head  *jh_in,
 				  struct journal_head **jh_out,
-				  int blocknr)
+				  sector_t blocknr)
 {
 	int need_copy_out = 0;
 	int done_copy_out = 0;
@@ -553,7 +553,7 @@ int log_wait_commit(journal_t *journal, 
  * Log buffer allocation routines:
  */
 
-int journal_next_log_block(journal_t *journal, unsigned long *retp)
+int journal_next_log_block(journal_t *journal, sector_t *retp)
 {
 	unsigned long blocknr;
 
@@ -577,10 +577,10 @@ int journal_next_log_block(journal_t *jo
  * ready.
  */
 int journal_bmap(journal_t *journal, unsigned long blocknr, 
-		 unsigned long *retp)
+		 sector_t *retp)
 {
 	int err = 0;
-	unsigned long ret;
+	sector_t ret;
 
 	if (journal->j_inode) {
 		ret = bmap(journal->j_inode, blocknr);
@@ -616,7 +616,7 @@ int journal_bmap(journal_t *journal, uns
 struct journal_head *journal_get_descriptor_buffer(journal_t *journal)
 {
 	struct buffer_head *bh;
-	unsigned long blocknr;
+	sector_t blocknr;
 	int err;
 
 	err = journal_next_log_block(journal, &blocknr);
@@ -704,7 +704,7 @@ fail:
  */
 journal_t * journal_init_dev(struct block_device *bdev,
 			struct block_device *fs_dev,
-			int start, int len, int blocksize)
+			sector_t start, int len, int blocksize)
 {
 	journal_t *journal = journal_init_common();
 	struct buffer_head *bh;
@@ -752,7 +752,7 @@ journal_t * journal_init_inode (struct i
 	journal_t *journal = journal_init_common();
 	int err;
 	int n;
-	unsigned long blocknr;
+	sector_t blocknr;
 
 	if (!journal)
 		return NULL;
@@ -852,7 +852,7 @@ static int journal_reset(journal_t *jour
  **/
 int journal_create(journal_t *journal)
 {
-	unsigned long blocknr;
+	sector_t blocknr;
 	struct buffer_head *bh;
 	journal_superblock_t *sb;
 	int i, err;

_


