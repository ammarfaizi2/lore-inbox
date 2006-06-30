Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933181AbWF3ASt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933181AbWF3ASt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 20:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933165AbWF3ASR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 20:18:17 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:29391 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S933175AbWF3ASG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 20:18:06 -0400
Subject: [RFC][Update][Patch 8/16]Avoid potential block overflow when
	writing journal metadata tags
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: linux-kernel@vger.kernel.org
Cc: ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
Content-Type: text/plain
Organization: IBM LTC
Date: Thu, 29 Jun 2006 17:18:04 -0700
Message-Id: <1151626685.6601.78.camel@dyn9047017069.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When writing block numbers into a journal descriptor block, don't write
the top 32 bits of a tag unless we're using a 64-bit journal.  That
avoids any possibility of overflowing off the end of the descriptor
block in the case where the last 32-bit tag only just fits into the
descriptor block.

Also cleans up the tag handling slightly by introducing new macros for
the size of 32- and 64-bit descriptor tags.

Signed-off-by: Stephen Tweedie <sct@redhat.com>
Acked-by: Badari Pulavarty <pbadari@us.ibm.com>


---

 linux-2.6.17-ming/fs/jbd/commit.c     |   11 ++++++-----
 linux-2.6.17-ming/include/linux/jbd.h |    3 +++
 2 files changed, 9 insertions(+), 5 deletions(-)

diff -puN fs/jbd/commit.c~jbd-avoid-blk-overflow-write-journal-metadata-tag fs/jbd/commit.c
--- linux-2.6.17/fs/jbd/commit.c~jbd-avoid-blk-overflow-write-journal-metadata-tag	2006-06-28 16:46:58.783710948 -0700
+++ linux-2.6.17-ming/fs/jbd/commit.c	2006-06-28 16:46:58.791710030 -0700
@@ -160,10 +160,12 @@ static int journal_write_commit_record(j
 	return (ret == -EIO);
 }
 
-static inline void write_split_be64(__be32 *high, __be32 *low, u64 val)
+static inline void write_tag_block(int tag_bytes, journal_block_tag_t *tag,
+				   sector_t block)
 {
-	*low = cpu_to_be32(val & (u32)~0);
-	*high = cpu_to_be32(val >> 32);
+	tag->t_blocknr = cpu_to_be32(block & (u32)~0);
+	if (tag_bytes > JBD_TAG_SIZE32)
+		tag->t_blocknr_high = cpu_to_be32((block >> 31) >> 1);
 }
 
 /*
@@ -560,8 +562,7 @@ write_out_data:
 			tag_flag |= JFS_FLAG_SAME_UUID;
 
 		tag = (journal_block_tag_t *) tagp;
-		write_split_be64(&tag->t_blocknr_high, &tag->t_blocknr,
-				jh2bh(jh)->b_blocknr);
+		write_tag_block(tag_bytes, tag, jh2bh(jh)->b_blocknr);
 		tag->t_flags = cpu_to_be32(tag_flag);
 		tagp += tag_bytes;
 		space_left -= tag_bytes;
diff -puN include/linux/jbd.h~jbd-avoid-blk-overflow-write-journal-metadata-tag include/linux/jbd.h
--- linux-2.6.17/include/linux/jbd.h~jbd-avoid-blk-overflow-write-journal-metadata-tag	2006-06-28 16:46:58.787710489 -0700
+++ linux-2.6.17-ming/include/linux/jbd.h	2006-06-28 16:46:58.793709801 -0700
@@ -159,6 +159,9 @@ typedef struct journal_block_tag_s
 	__be32		t_blocknr_high; /* most-significant high 32bits. */
 } journal_block_tag_t;
 
+#define JBD_TAG_SIZE32 (offsetof(journal_block_tag_t, t_blocknr_high))
+#define JBD_TAG_SIZE64 (sizeof(journal_block_tag_t))
+
 /* 
  * The revoke descriptor: used on disk to describe a series of blocks to
  * be revoked from the log 

_


