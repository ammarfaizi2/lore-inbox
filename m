Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932523AbWIVPqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932523AbWIVPqz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 11:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932614AbWIVPqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 11:46:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62889 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932613AbWIVPqx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 11:46:53 -0400
Message-ID: <4514056B.4020807@redhat.com>
Date: Fri, 22 Sep 2006 10:46:51 -0500
From: Eric Sandeen <esandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 16T fixes for JBD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are a few places I've found in jbd that look like they
may not be 16T-safe, or consistent with the use of unsigned
longs for block containers.  Problems here would be somewhat
hard to hit, would require journal blocks past the 8T boundary,
which would not be terribly common.  Still, should fix.

(some of these have come from the ext4 work on jbd
as well).

I think there's one more possibility that the wrap()
function may not be safe IF your last block in the journal
butts right up against the 232 block boundary, but that seems
like a VERY remote possibility, and I'm not worrying about it
at this point.

This patch lived on ext4-devel for a few days without comment
so I assume it passes muster there ;-)

Thanks,

-Eric

Signed-off-by: Eric Sandeen <esandeen@redhat.com>

Index: linux-2.6.18/fs/jbd/journal.c
===================================================================
--- linux-2.6.18.orig/fs/jbd/journal.c
+++ linux-2.6.18/fs/jbd/journal.c
@@ -271,7 +271,7 @@ static void journal_kill_thread(journal_
 int journal_write_metadata_buffer(transaction_t *transaction,
 				  struct journal_head  *jh_in,
 				  struct journal_head **jh_out,
-				  int blocknr)
+				  unsigned long blocknr)
 {
 	int need_copy_out = 0;
 	int done_copy_out = 0;
@@ -696,7 +696,7 @@ fail:
  *  @bdev: Block device on which to create the journal
  *  @fs_dev: Device which hold journalled filesystem for this journal.
  *  @start: Block nr Start of journal.
- *  @len:  Lenght of the journal in blocks.
+ *  @len:  Length of the journal in blocks.
  *  @blocksize: blocksize of journalling device
  *  @returns: a newly created journal_t *
  *  
@@ -820,7 +820,7 @@ static void journal_fail_superblock (jou
 static int journal_reset(journal_t *journal)
 {
 	journal_superblock_t *sb = journal->j_superblock;
-	unsigned int first, last;
+	unsigned long first, last;
 
 	first = be32_to_cpu(sb->s_first);
 	last = be32_to_cpu(sb->s_maxlen);
Index: linux-2.6.18/include/linux/jbd.h
===================================================================
--- linux-2.6.18.orig/include/linux/jbd.h
+++ linux-2.6.18/include/linux/jbd.h
@@ -732,7 +732,7 @@ struct journal_s
 	 */
 	struct block_device	*j_dev;
 	int			j_blocksize;
-	unsigned int		j_blk_offset;
+	unsigned long		j_blk_offset;
 
 	/*
 	 * Device which holds the client fs.  For internal journal this will be
@@ -866,7 +866,7 @@ extern int 
 journal_write_metadata_buffer(transaction_t	  *transaction,
 			      struct journal_head  *jh_in,
 			      struct journal_head **jh_out,
-			      int		   blocknr);
+			      unsigned long	   blocknr);
 
 /* Transaction locking */
 extern void		__wait_on_journal (journal_t *);


