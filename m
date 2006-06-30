Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbWF3ATA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbWF3ATA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 20:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964780AbWF3AS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 20:18:57 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:4048 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S933174AbWF3ASS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 20:18:18 -0400
Subject: [RFC][Update][Patch 9/16]Fix reading of 32-bit tag descriptors
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: linux-kernel@vger.kernel.org
Cc: ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
Content-Type: text/plain
Organization: IBM LTC
Date: Thu, 29 Jun 2006 17:18:16 -0700
Message-Id: <1151626696.6601.79.camel@dyn9047017069.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We must never attempt to read the high 32-bits of a descriptor tag on
a 32-bit journal, even when CONFIG_LBD is set, as we'll end up reading
garbage from the subsequent tag.

Signed-off-by: Stephen Tweedie <sct@redhat.com>
Acked-by: Badari Pulavarty <pbadari@us.ibm.com>


---

 linux-2.6.17-ming/fs/jbd/recovery.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff -puN fs/jbd/recovery.c~jbd-read-32bit-tag-fix fs/jbd/recovery.c
--- linux-2.6.17/fs/jbd/recovery.c~jbd-read-32bit-tag-fix	2006-06-28 16:47:02.555278191 -0700
+++ linux-2.6.17-ming/fs/jbd/recovery.c	2006-06-28 16:47:02.558277847 -0700
@@ -308,11 +308,12 @@ int journal_skip_recovery(journal_t *jou
 	return err;
 }
 
-static inline u64 read_split_be64(__be32 *high, __be32 *low)
+static inline sector_t read_tag_block(int tag_bytes, journal_block_tag_t *tag)
 {
-	u64 ret = be32_to_cpu(*low);
-	ret |= (u64)be32_to_cpu(*high) << 32;
-	return ret;
+	sector_t block = be32_to_cpu(tag->t_blocknr);
+	if (tag_bytes > JBD_TAG_SIZE32)
+		block |= (u64)be32_to_cpu(tag->t_blocknr_high) << 32;
+	return block;
 }
 
 static int do_one_pass(journal_t *journal,
@@ -454,8 +455,8 @@ static int do_one_pass(journal_t *journa
 					unsigned long blocknr;
 
 					J_ASSERT(obh != NULL);
-					blocknr = read_split_be64(&tag->t_blocknr_high,
-							&tag->t_blocknr);
+					blocknr = read_tag_block(tag_bytes,
+								 tag);
 
 					/* If the block has been
 					 * revoked, then we're all done

_


