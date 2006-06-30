Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964772AbWF3ASu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964772AbWF3ASu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 20:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933173AbWF3ASJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 20:18:09 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:39119 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S933170AbWF3AR6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 20:17:58 -0400
Subject: [RFC][Update][Patch 7/16]Core 64 bit JBD changes
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: linux-kernel@vger.kernel.org
Cc: ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
Content-Type: text/plain
Organization: IBM LTC
Date: Thu, 29 Jun 2006 17:17:55 -0700
Message-Id: <1151626676.6601.77.camel@dyn9047017069.beaverton.ibm.com>
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

---

 linux-2.6.17-ming/fs/jbd/commit.c     |   16 +++++++++---
 linux-2.6.17-ming/fs/jbd/journal.c    |   11 ++++++++
 linux-2.6.17-ming/fs/jbd/recovery.c   |   42 +++++++++++++++++++++++-----------
 linux-2.6.17-ming/fs/jbd/revoke.c     |   14 ++++++++---
 linux-2.6.17-ming/include/linux/jbd.h |   11 +++++++-
 5 files changed, 72 insertions(+), 22 deletions(-)

diff -puN fs/jbd/commit.c~64bit_jbd_core fs/jbd/commit.c
--- linux-2.6.17/fs/jbd/commit.c~64bit_jbd_core	2006-06-28 16:46:53.936267153 -0700
+++ linux-2.6.17-ming/fs/jbd/commit.c	2006-06-28 16:46:53.953265203 -0700
@@ -160,6 +160,12 @@ static int journal_write_commit_record(j
 	return (ret == -EIO);
 }
 
+static inline void write_split_be64(__be32 *high, __be32 *low, u64 val)
+{
+	*low = cpu_to_be32(val & (u32)~0);
+	*high = cpu_to_be32(val >> 32);
+}
+
 /*
  * journal_commit_transaction
  *
@@ -182,6 +188,7 @@ void journal_commit_transaction(journal_
 	int first_tag = 0;
 	int tag_flag;
 	int i;
+	int tag_bytes = journal_tag_bytes(journal);
 
 	/*
 	 * First job: lock down the current transaction and wait for
@@ -553,10 +560,11 @@ write_out_data:
 			tag_flag |= JFS_FLAG_SAME_UUID;
 
 		tag = (journal_block_tag_t *) tagp;
-		tag->t_blocknr = cpu_to_be32(jh2bh(jh)->b_blocknr);
+		write_split_be64(&tag->t_blocknr_high, &tag->t_blocknr,
+				jh2bh(jh)->b_blocknr);
 		tag->t_flags = cpu_to_be32(tag_flag);
-		tagp += sizeof(journal_block_tag_t);
-		space_left -= sizeof(journal_block_tag_t);
+		tagp += tag_bytes;
+		space_left -= tag_bytes;
 
 		if (first_tag) {
 			memcpy (tagp, journal->j_uuid, 16);
@@ -570,7 +578,7 @@ write_out_data:
 
 		if (bufs == journal->j_wbufsize ||
 		    commit_transaction->t_buffers == NULL ||
-		    space_left < sizeof(journal_block_tag_t) + 16) {
+		    space_left < tag_bytes + 16) {
 
 			jbd_debug(4, "JBD: Submit %d IOs\n", bufs);
 
diff -puN fs/jbd/journal.c~64bit_jbd_core fs/jbd/journal.c
--- linux-2.6.17/fs/jbd/journal.c~64bit_jbd_core	2006-06-28 16:46:53.939266809 -0700
+++ linux-2.6.17-ming/fs/jbd/journal.c	2006-06-28 16:46:53.956264859 -0700
@@ -1603,6 +1603,17 @@ int journal_blocks_per_page(struct inode
 }
 
 /*
+ * helper functions to deal with 32 or 64bit block numbers.
+ */
+size_t journal_tag_bytes(journal_t *journal)
+{
+	if (JFS_HAS_INCOMPAT_FEATURE(journal, JFS_FEATURE_INCOMPAT_64BIT))
+		return sizeof(journal_block_tag_t);
+	else
+		return offsetof(journal_block_tag_t, t_blocknr_high);
+}
+
+/*
  * Simple support for retrying memory allocations.  Introduced to help to
  * debug different VM deadlock avoidance strategies. 
  */
diff -puN fs/jbd/recovery.c~64bit_jbd_core fs/jbd/recovery.c
--- linux-2.6.17/fs/jbd/recovery.c~64bit_jbd_core	2006-06-28 16:46:53.942266465 -0700
+++ linux-2.6.17-ming/fs/jbd/recovery.c	2006-06-28 16:46:53.957264744 -0700
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
 		if (!(tag->t_flags & cpu_to_be32(JFS_FLAG_SAME_UUID)))
 			tagp += 16;
 
@@ -307,6 +308,13 @@ int journal_skip_recovery(journal_t *jou
 	return err;
 }
 
+static inline u64 read_split_be64(__be32 *high, __be32 *low)
+{
+	u64 ret = be32_to_cpu(*low);
+	ret |= (u64)be32_to_cpu(*high) << 32;
+	return ret;
+}
+
 static int do_one_pass(journal_t *journal,
 			struct recovery_info *info, enum passtype pass)
 {
@@ -318,11 +326,12 @@ static int do_one_pass(journal_t *journa
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
@@ -412,8 +421,7 @@ static int do_one_pass(journal_t *journa
 			 * in pass REPLAY; otherwise, just skip over the
 			 * blocks it describes. */
 			if (pass != PASS_REPLAY) {
-				next_log_block +=
-					count_tags(bh, journal->j_blocksize);
+				next_log_block += count_tags(journal, bh);
 				wrap(journal, next_log_block);
 				brelse(bh);
 				continue;
@@ -424,7 +432,7 @@ static int do_one_pass(journal_t *journa
 			 * getting done here! */
 
 			tagp = &bh->b_data[sizeof(journal_header_t)];
-			while ((tagp - bh->b_data +sizeof(journal_block_tag_t))
+			while ((tagp - bh->b_data + tag_bytes)
 			       <= journal->j_blocksize) {
 				unsigned long io_block;
 
@@ -446,7 +454,8 @@ static int do_one_pass(journal_t *journa
 					unsigned long blocknr;
 
 					J_ASSERT(obh != NULL);
-					blocknr = be32_to_cpu(tag->t_blocknr);
+					blocknr = read_split_be64(&tag->t_blocknr_high,
+							&tag->t_blocknr);
 
 					/* If the block has been
 					 * revoked, then we're all done
@@ -494,7 +503,7 @@ static int do_one_pass(journal_t *journa
 				}
 
 			skip_write:
-				tagp += sizeof(journal_block_tag_t);
+				tagp += tag_bytes;
 				if (!(flags & JFS_FLAG_SAME_UUID))
 					tagp += 16;
 
@@ -572,17 +581,24 @@ static int scan_revoke_records(journal_t
 {
 	journal_revoke_header_t *header;
 	int offset, max;
+	int record_len = 4;
 
 	header = (journal_revoke_header_t *) bh->b_data;
 	offset = sizeof(journal_revoke_header_t);
 	max = be32_to_cpu(header->r_count);
 
-	while (offset < max) {
+	if (JFS_HAS_INCOMPAT_FEATURE(journal, JFS_FEATURE_INCOMPAT_64BIT))
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
 		err = journal_set_revoke(journal, blocknr, sequence);
 		if (err)
 			return err;
diff -puN fs/jbd/revoke.c~64bit_jbd_core fs/jbd/revoke.c
--- linux-2.6.17/fs/jbd/revoke.c~64bit_jbd_core	2006-06-28 16:46:53.945266121 -0700
+++ linux-2.6.17-ming/fs/jbd/revoke.c	2006-06-28 16:46:53.959264514 -0700
@@ -584,9 +584,17 @@ static void write_one_revoke_record(jour
 		*descriptorp = descriptor;
 	}
 
-	* ((__be32 *)(&jh2bh(descriptor)->b_data[offset])) = 
-		cpu_to_be32(record->blocknr);
-	offset += 4;
+	if (JFS_HAS_INCOMPAT_FEATURE(journal, JFS_FEATURE_INCOMPAT_64BIT)) {
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
 
diff -puN include/linux/jbd.h~64bit_jbd_core include/linux/jbd.h
--- linux-2.6.17/include/linux/jbd.h~64bit_jbd_core	2006-06-28 16:46:53.949265662 -0700
+++ linux-2.6.17-ming/include/linux/jbd.h	2006-06-28 16:46:53.961264285 -0700
@@ -147,12 +147,16 @@ typedef struct journal_header_s
 
 
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
 
 /* 
@@ -232,11 +236,13 @@ typedef struct journal_superblock_s
 	 ((j)->j_superblock->s_feature_incompat & cpu_to_be32((mask))))
 
 #define JFS_FEATURE_INCOMPAT_REVOKE	0x00000001
+#define JFS_FEATURE_INCOMPAT_64BIT	0x00000002
 
 /* Features known to this kernel version: */
 #define JFS_KNOWN_COMPAT_FEATURES	0
 #define JFS_KNOWN_ROCOMPAT_FEATURES	0
-#define JFS_KNOWN_INCOMPAT_FEATURES	JFS_FEATURE_INCOMPAT_REVOKE
+#define JFS_KNOWN_INCOMPAT_FEATURES	(JFS_FEATURE_INCOMPAT_REVOKE | \
+					 JFS_FEATURE_INCOMPAT_64BIT)
 
 #ifdef __KERNEL__
 
@@ -1050,6 +1056,7 @@ static inline int tid_geq(tid_t x, tid_t
 }
 
 extern int journal_blocks_per_page(struct inode *inode);
+extern size_t journal_tag_bytes(journal_t *journal);
 
 /*
  * Return the minimum number of blocks which must be free in the journal

_


