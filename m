Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbVDWSpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbVDWSpy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 14:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbVDWSpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 14:45:54 -0400
Received: from mail.dif.dk ([193.138.115.101]:39050 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261668AbVDWSpk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 14:45:40 -0400
Date: Sat, 23 Apr 2005 20:48:51 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Ben Fennema <bfennema@falcon.csc.calpoly.edu>
Cc: linux_udf@hpesjro.fc.hp.com, linux-kernel@vger.kernel.org
Subject: [PATCH] udf: uint32_t can't be less than zero
Message-ID: <Pine.LNX.4.62.0504232037060.2474@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a patch that removes a few bits from fs/udf/balloc.c that 
test uint32_t values for being less than zero, which is impossible.

I know not everyone agree with this sort of cleanup, but I figured I'd do 
the patch in any case, then leave it up to the maintainer to apply it or 
drop it.

Please keep me on CC: when replying.



Signed-Off-by: Jesper Juhl <juhl-lkml@dif.dk>


--- linux-2.6.12-rc2-mm3-orig/fs/udf/balloc.c	2005-03-02 08:37:52.000000000 +0100
+++ linux-2.6.12-rc2-mm3/fs/udf/balloc.c	2005-04-23 20:38:31.000000000 +0200
@@ -158,8 +158,7 @@ static void udf_bitmap_free_blocks(struc
 	unsigned long overflow;
 
 	down(&sbi->s_alloc_sem);
-	if (bloc.logicalBlockNum < 0 ||
-		(bloc.logicalBlockNum + count) > UDF_SB_PARTLEN(sb, bloc.partitionReferenceNum))
+	if ((bloc.logicalBlockNum + count) > UDF_SB_PARTLEN(sb, bloc.partitionReferenceNum))
 	{
 		udf_debug("%d < %d || %d + %d > %d\n",
 			bloc.logicalBlockNum, 0, bloc.logicalBlockNum, count,
@@ -232,7 +231,7 @@ static int udf_bitmap_prealloc_blocks(st
 	struct buffer_head *bh;
 
 	down(&sbi->s_alloc_sem);
-	if (first_block < 0 || first_block >= UDF_SB_PARTLEN(sb, partition))
+	if (first_block >= UDF_SB_PARTLEN(sb, partition))
 		goto out;
 
 	if (first_block + block_count > UDF_SB_PARTLEN(sb, partition))
@@ -299,7 +298,7 @@ static int udf_bitmap_new_block(struct s
 	down(&sbi->s_alloc_sem);
 
 repeat:
-	if (goal < 0 || goal >= UDF_SB_PARTLEN(sb, partition))
+	if (goal >= UDF_SB_PARTLEN(sb, partition))
 		goal = 0;
 
 	nr_groups = bitmap->s_nr_groups;
@@ -439,8 +438,7 @@ static void udf_table_free_blocks(struct
 	int i;
 
 	down(&sbi->s_alloc_sem);
-	if (bloc.logicalBlockNum < 0 ||
-		(bloc.logicalBlockNum + count) > UDF_SB_PARTLEN(sb, bloc.partitionReferenceNum))
+	if ((bloc.logicalBlockNum + count) > UDF_SB_PARTLEN(sb, bloc.partitionReferenceNum))
 	{
 		udf_debug("%d < %d || %d + %d > %d\n",
 			bloc.logicalBlockNum, 0, bloc.logicalBlockNum, count,
@@ -688,7 +686,7 @@ static int udf_table_prealloc_blocks(str
 	struct buffer_head *bh;
 	int8_t etype = -1;
 
-	if (first_block < 0 || first_block >= UDF_SB_PARTLEN(sb, partition))
+	if (first_block >= UDF_SB_PARTLEN(sb, partition))
 		return 0;
 
 	if (UDF_I_ALLOCTYPE(table) == ICBTAG_FLAG_AD_SHORT)
@@ -768,7 +766,7 @@ static int udf_table_new_block(struct su
 		return newblock;
 
 	down(&sbi->s_alloc_sem);
-	if (goal < 0 || goal >= UDF_SB_PARTLEN(sb, partition))
+	if (goal >= UDF_SB_PARTLEN(sb, partition))
 		goal = 0;
 
 	/* We search for the closest matching block to goal. If we find a exact hit,




