Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272249AbRH3Oa7>; Thu, 30 Aug 2001 10:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272246AbRH3Oax>; Thu, 30 Aug 2001 10:30:53 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:32267 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S272247AbRH3Oam>; Thu, 30 Aug 2001 10:30:42 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15246.19931.916062.854564@gargle.gargle.HOWL>
Date: Thu, 30 Aug 2001 18:29:47 +0400
To: Linus Torvalds <Torvalds@Transmeta.COM>
Cc: Reiserfs developers mail-list <Reiserfs-Dev@Namesys.COM>,
        "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: [PATCH]: reiserfs: G-blockalloc-for-disk-90%full.patch
X-Mailer: VM 6.89 under 21.4 (patch 3) "Academic Rigor" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

   This patch improves behavior of reiserfs block allocator when free
   space is low. By default reiserfs uses so called "border algorithm"
   that reserves first 10% of disk for "formatted nodes" that is,
   nodes of reiserfs tree. With this patch this distinction is dropped
   when free space goes below 10% of total disk space. This has been
   found to improve performance.

This patch is against 2.4.10-pre2.
Please apply.

Nikita.
diff -rup linux/fs/reiserfs/bitmap.c linux.patched/fs/reiserfs/bitmap.c
--- linux/fs/reiserfs/bitmap.c	Wed May  2 14:04:15 2001
+++ linux.patched/fs/reiserfs/bitmap.c	Thu Aug 30 17:19:09 2001
@@ -499,6 +499,7 @@ int reiserfs_new_unf_blocknrs2 (struct r
   unsigned long border = 0;
   unsigned long bstart = 0;
   unsigned long hash_in, hash_out;
+  unsigned long saved_search_start=search_start;
   int allocated[PREALLOCATION_SIZE];
   int blks;
 
@@ -604,7 +605,15 @@ int reiserfs_new_unf_blocknrs2 (struct r
   ** and should probably be removed
   */
   if ( search_start < border ) search_start=border; 
-  
+
+  /* If the disk free space is already below 10% we should 
+  ** start looking for the free blocks from the beginning 
+  ** of the partition, before the border line.
+  */
+  if ( SB_FREE_BLOCKS(th->t_super) <= (SB_BLOCK_COUNT(th->t_super) / 10) ) {
+    search_start=saved_search_start;
+  }
+
   *free_blocknrs = 0;
   blks = PREALLOCATION_SIZE-1;
   for (blks_gotten=0; blks_gotten<PREALLOCATION_SIZE; blks_gotten++) {
