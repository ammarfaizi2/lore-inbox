Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030529AbWHJBVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030529AbWHJBVy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 21:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030540AbWHJBVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 21:21:54 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:7840 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030529AbWHJBVl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 21:21:41 -0400
Subject: [PATCH 6/9] 64bit jbd2 core changes
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Content-Type: text/plain
Organization: IBM LTC
Date: Wed, 09 Aug 2006 18:21:43 -0700
Message-Id: <1155172903.3161.85.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is the  patch to JBD to handle 64 bit block numbers, originally 
from Zach Brown. This patch is useful only after adding support for
64-bit block numbers in the filesystem.

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
Signed-off-by: Zach Brown <zach.brown@oracle.com>
Acked-by: Stephen Tweedie <sct@redhat.com>


---

 linux-2.6.18-rc4-ming/fs/jbd2/commit.c     |   17 ++++++++---
 linux-2.6.18-rc4-ming/fs/jbd2/journal.c    |   11 +++++++
 linux-2.6.18-rc4-ming/fs/jbd2/recovery.c   |   43 ++++++++++++++++++++---------
 linux-2.6.18-rc4-ming/fs/jbd2/revoke.c     |   14 +++++++--
 linux-2.6.18-rc4-ming/include/linux/jbd2.h |   14 ++++++++-
 5 files changed, 77 insertions(+), 22 deletions(-)

diff -puN fs/jbd2/commit.c~64bit_jbd2_core fs/jbd2/commit.c
--- linux-2.6.18-rc4/fs/jbd2/commit.c~64bit_jbd2_core	2006-08-09 15:41:59.946354050 -0700
+++ linux-2.6.18-rc4-ming/fs/jbd2/commit.c	2006-08-09 15:41:59.965354204 -0700
@@ -160,6 +160,14 @@ static int journal_write_commit_record(j
 	return (ret == -EIO);
 }
 
+static inline void write_tag_block(int tag_bytes, journal_block_tag_t *tag,
+				   sector_t block)
+{
+	tag->t_blocknr = cpu_to_be32(block & (u32)~0);
+	if (tag_bytes > JBD_TAG_SIZE32)
+		tag->t_blocknr_high = cpu_to_be32((block >> 31) >> 1);
+}
+
 /*
  * jbd2_journal_commit_transaction
  *
@@ -182,6 +190,7 @@ void jbd2_journal_commit_transaction(jou
 	int first_tag = 0;
 	int tag_flag;
 	int i;
+	int tag_bytes = journal_tag_bytes(journal);
 
 	/*
 	 * First job: lock down the current transaction and wait for
@@ -553,10 +562,10 @@ write_out_data:
 			tag_flag |= JBD2_FLAG_SAME_UUID;
 
 		tag = (journal_block_tag_t *) tagp;
-		tag->t_blocknr = cpu_to_be32(jh2bh(jh)->b_blocknr);
+		write_tag_block(tag_bytes, tag, jh2bh(jh)->b_blocknr);
 		tag->t_flags = cpu_to_be32(tag_flag);
-		tagp += sizeof(journal_block_tag_t);
-		space_left -= sizeof(journal_block_tag_t);
+		tagp += tag_bytes;
+		space_left -= tag_bytes;
 
 		if (first_tag) {
 			memcpy (tagp, journal->j_uuid, 16);
@@ -570,7 +579,7 @@ write_out_data:
 
 		if (bufs == journal->j_wbufsize ||
 		    commit_transaction->t_buffers == NULL ||
-		    space_left < sizeof(journal_block_tag_t) + 16) {
+		    space_left < tag_bytes + 16) {
 
 			jbd_debug(4, "JBD: Submit %d IOs\n", bufs);
 
diff -puN fs/jbd2/journal.c~64bit_jbd2_core fs/jbd2/journal.c
--- linux-2.6.18-rc4/fs/jbd2/journal.c~64bit_jbd2_core	2006-08-09 15:41:59.950354082 -0700
+++ linux-2.6.18-rc4-ming/fs/jbd2/journal.c	2006-08-09 15:41:59.968354228 -0700
@@ -1603,6 +1603,17 @@ int jbd2_journal_blocks_per_page(struct 
 }
 
 /*
+ * helper functions to deal with 32 or 64bit block numbers.
+ */
+size_t journal_tag_bytes(journal_t *journal)
+{
+	if (JBD2_HAS_INCOMPAT_FEATURE(journal, JBD2_FEATURE_INCOMPAT_64BIT))
+		return JBD_TAG_SIZE64;
+	else
+		return JBD_TAG_SIZE32;
+}
+
+/*
  * Simple support for retrying memory allocations.  Introduced to help to
  * debug different VM deadlock avoidance strategies.
  */
diff -puN fs/jbd2/recovery.c~64bit_jbd2_core fs/jbd2/recovery.c
--- linux-2.6.18-rc4/fs/jbd2/recovery.c~64bit_jbd2_core	2006-08-09 15:41:59.954354115 -0700
+++ linux-2.6.18-rc4-ming/fs/jbd2/recovery.c	2006-08-09 15:41:59.970354244 -0700
@@ -178,19 +178,20 @@ static int jread(struct buffer_head **bh
  * Count the number of in-use tags in a journal descriptor block.
  */
 
-static int count_tags(struct buffer_head *bh, int size)
+static int count_tags(journal_t *journal, struct buffer_head *bh)
 {
 	char *			tagp;
 	journal_block_tag_t *	tag;
-	int			nr = 0;
+	int			nr = 0, size = journal->j_blocksize;
+	int 			tag_bytes = journal_tag_bytes(journal);
 
 	tagp = &bh->b_data[sizeof(journal_header_t)];
 
-	while ((tagp - bh->b_data + sizeof(journal_block_tag_t)) <= size) {
+	while ((tagp - bh->b_data + tag_bytes) <= size) {
 		tag = (journal_block_tag_t *) tagp;
 
 		nr++;
-		tagp += sizeof(journal_block_tag_t);
+		tagp += tag_bytes;
 		if (!(tag->t_flags & cpu_to_be32(JBD2_FLAG_SAME_UUID)))
 			tagp += 16;
 
@@ -307,6 +308,14 @@ int jbd2_journal_skip_recovery(journal_t
 	return err;
 }
 
+static inline sector_t read_tag_block(int tag_bytes, journal_block_tag_t *tag)
+{
+	sector_t block = be32_to_cpu(tag->t_blocknr);
+	if (tag_bytes > JBD_TAG_SIZE32)
+		block |= (u64)be32_to_cpu(tag->t_blocknr_high) << 32;
+	return block;
+}
+
 static int do_one_pass(journal_t *journal,
 			struct recovery_info *info, enum passtype pass)
 {
@@ -318,11 +327,12 @@ static int do_one_pass(journal_t *journa
 	struct buffer_head *	bh;
 	unsigned int		sequence;
 	int			blocktype;
+	int 			tag_bytes = journal_tag_bytes(journal);
 
 	/* Precompute the maximum metadata descriptors in a descriptor block */
 	int			MAX_BLOCKS_PER_DESC;
 	MAX_BLOCKS_PER_DESC = ((journal->j_blocksize-sizeof(journal_header_t))
-			       / sizeof(journal_block_tag_t));
+			       / tag_bytes);
 
 	/*
 	 * First thing is to establish what we expect to find in the log
@@ -412,8 +422,7 @@ static int do_one_pass(journal_t *journa
 			 * in pass REPLAY; otherwise, just skip over the
 			 * blocks it describes. */
 			if (pass != PASS_REPLAY) {
-				next_log_block +=
-					count_tags(bh, journal->j_blocksize);
+				next_log_block += count_tags(journal, bh);
 				wrap(journal, next_log_block);
 				brelse(bh);
 				continue;
@@ -424,7 +433,7 @@ static int do_one_pass(journal_t *journa
 			 * getting done here! */
 
 			tagp = &bh->b_data[sizeof(journal_header_t)];
-			while ((tagp - bh->b_data +sizeof(journal_block_tag_t))
+			while ((tagp - bh->b_data + tag_bytes)
 			       <= journal->j_blocksize) {
 				unsigned long io_block;
 
@@ -446,7 +455,8 @@ static int do_one_pass(journal_t *journa
 					unsigned long blocknr;
 
 					J_ASSERT(obh != NULL);
-					blocknr = be32_to_cpu(tag->t_blocknr);
+					blocknr = read_tag_block(tag_bytes,
+								 tag);
 
 					/* If the block has been
 					 * revoked, then we're all done
@@ -494,7 +504,7 @@ static int do_one_pass(journal_t *journa
 				}
 
 			skip_write:
-				tagp += sizeof(journal_block_tag_t);
+				tagp += tag_bytes;
 				if (!(flags & JBD2_FLAG_SAME_UUID))
 					tagp += 16;
 
@@ -572,17 +582,24 @@ static int scan_revoke_records(journal_t
 {
 	jbd2_journal_revoke_header_t *header;
 	int offset, max;
+	int record_len = 4;
 
 	header = (jbd2_journal_revoke_header_t *) bh->b_data;
 	offset = sizeof(jbd2_journal_revoke_header_t);
 	max = be32_to_cpu(header->r_count);
 
-	while (offset < max) {
+	if (JBD2_HAS_INCOMPAT_FEATURE(journal, JBD2_FEATURE_INCOMPAT_64BIT))
+		record_len = 8;
+
+	while (offset + record_len < max) {
 		unsigned long blocknr;
 		int err;
 
-		blocknr = be32_to_cpu(* ((__be32 *) (bh->b_data+offset)));
-		offset += 4;
+		if (record_len == 4)
+			blocknr = be32_to_cpu(* ((__be32 *) (bh->b_data+offset)));
+		else
+			blocknr = be64_to_cpu(* ((__be64 *) (bh->b_data+offset)));
+		offset += record_len;
 		err = jbd2_journal_set_revoke(journal, blocknr, sequence);
 		if (err)
 			return err;
diff -puN fs/jbd2/revoke.c~64bit_jbd2_core fs/jbd2/revoke.c
--- linux-2.6.18-rc4/fs/jbd2/revoke.c~64bit_jbd2_core	2006-08-09 15:41:59.957354139 -0700
+++ linux-2.6.18-rc4-ming/fs/jbd2/revoke.c	2006-08-09 15:41:59.972354260 -0700
@@ -584,9 +584,17 @@ static void write_one_revoke_record(jour
 		*descriptorp = descriptor;
 	}
 
-	* ((__be32 *)(&jh2bh(descriptor)->b_data[offset])) =
-		cpu_to_be32(record->blocknr);
-	offset += 4;
+	if (JBD2_HAS_INCOMPAT_FEATURE(journal, JBD2_FEATURE_INCOMPAT_64BIT)) {
+		* ((__be64 *)(&jh2bh(descriptor)->b_data[offset])) =
+			cpu_to_be64(record->blocknr);
+		offset += 8;
+
+	} else {
+		* ((__be32 *)(&jh2bh(descriptor)->b_data[offset])) =
+			cpu_to_be32(record->blocknr);
+		offset += 4;
+	}
+
 	*offsetp = offset;
 }
 
diff -puN include/linux/jbd2.h~64bit_jbd2_core include/linux/jbd2.h
--- linux-2.6.18-rc4/include/linux/jbd2.h~64bit_jbd2_core	2006-08-09 15:41:59.960354163 -0700
+++ linux-2.6.18-rc4-ming/include/linux/jbd2.h	2006-08-09 15:41:59.974354277 -0700
@@ -147,14 +147,21 @@ typedef struct journal_header_s
 

 /*
- * The block tag: used to describe a single buffer in the journal
+ * The block tag: used to describe a single buffer in the journal.
+ * t_blocknr_high is only used if INCOMPAT_64BIT is set, so this
+ * raw struct shouldn't be used for pointer math or sizeof() - use
+ * journal_tag_bytes(journal) instead to compute this.
  */
 typedef struct journal_block_tag_s
 {
 	__be32		t_blocknr;	/* The on-disk block number */
 	__be32		t_flags;	/* See below */
+	__be32		t_blocknr_high; /* most-significant high 32bits. */
 } journal_block_tag_t;
 
+#define JBD_TAG_SIZE32 (offsetof(journal_block_tag_t, t_blocknr_high))
+#define JBD_TAG_SIZE64 (sizeof(journal_block_tag_t))
+
 /*
  * The revoke descriptor: used on disk to describe a series of blocks to
  * be revoked from the log
@@ -232,11 +239,13 @@ typedef struct journal_superblock_s
 	 ((j)->j_superblock->s_feature_incompat & cpu_to_be32((mask))))
 
 #define JBD2_FEATURE_INCOMPAT_REVOKE	0x00000001
+#define JBD2_FEATURE_INCOMPAT_64BIT	0x00000002
 
 /* Features known to this kernel version: */
 #define JBD2_KNOWN_COMPAT_FEATURES	0
 #define JBD2_KNOWN_ROCOMPAT_FEATURES	0
-#define JBD2_KNOWN_INCOMPAT_FEATURES	JBD2_FEATURE_INCOMPAT_REVOKE
+#define JBD2_KNOWN_INCOMPAT_FEATURES	(JBD2_FEATURE_INCOMPAT_REVOKE | \
+					 JBD2_FEATURE_INCOMPAT_64BIT)
 
 #ifdef __KERNEL__
 
@@ -1050,6 +1059,7 @@ static inline int tid_geq(tid_t x, tid_t
 }
 
 extern int jbd2_journal_blocks_per_page(struct inode *inode);
+extern size_t journal_tag_bytes(journal_t *journal);
 
 /*
  * Return the minimum number of blocks which must be free in the journal

_


