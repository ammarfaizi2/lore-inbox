Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314529AbSEBOcw>; Thu, 2 May 2002 10:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314545AbSEBOcv>; Thu, 2 May 2002 10:32:51 -0400
Received: from revdns.flarg.info ([213.152.47.19]:396 "EHLO noodles.internal")
	by vger.kernel.org with ESMTP id <S314529AbSEBOcs>;
	Thu, 2 May 2002 10:32:48 -0400
Date: Thu, 2 May 2002 15:32:50 +0100
From: Dave Jones <davej@suse.de>
To: Andreas Dilger <adilger@turbolabs.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: ext2 errors under fsx with 2.5.12-dj1.
Message-ID: <20020502143250.GA19533@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Andreas Dilger <adilger@turbolabs.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,
 Under a stress test of multiple fsx's, the following messages
appeared..

EXT2-fs error (device ide0(3,65)): ext2_free_blocks: Freeing blocks not
in datazone - block = 2553887680, count = 1
EXT2-fs error (device ide0(3,65)): ext2_free_blocks: Freeing blocks not
in datazone - block = 67108864, count = 1
EXT2-fs error (device ide0(3,65)): ext2_free_blocks: Freeing blocks not
in datazone - block = 1048576, count = 1
EXT2-fs error (device ide0(3,65)): ext2_free_blocks: Freeing blocks not
in datazone - block = 1048576, count = 1
EXT2-fs error (device ide0(3,65)): ext2_free_blocks: Freeing blocks not
in datazone - block = 16777216, count = 1
EXT2-fs error (device ide0(3,65)): ext2_free_blocks: Freeing blocks not
in datazone - block = 16777216, count = 1
EXT2-fs error (device ide0(3,65)): ext2_free_blocks: Freeing blocks not
in datazone - block = 2375129740, count = 1
EXT2-fs error (device ide0(3,65)): ext2_free_blocks: Freeing blocks not
in datazone - block = 1598358905, count = 1
EXT2-fs error (device ide0(3,65)): ext2_free_blocks: Freeing blocks not
in datazone - block = 15730344, count = 1
EXT2-fs error (device ide0(3,65)): ext2_free_blocks: Freeing blocks not
in datazone - block = 4125625412, count = 1
EXT2-fs error (device ide0(3,65)): ext2_free_blocks: Freeing blocks not
in datazone - block = 16777216, count = 1


My tree has the following patch, which I believe you authored, or were
at least involved in..

--- linux-2.5.12/fs/ext2/balloc.c   Wed May  1 01:08:55 2002
+++ linux-2.5/fs/ext2/balloc.c  Sat Mar 23 22:56:32 2002
@@ -250,8 +250,9 @@
 
    lock_super (sb);
    es = EXT2_SB(sb)->s_es;
-   if (block < le32_to_cpu(es->s_first_data_block) || 
-       (block + count) > le32_to_cpu(es->s_blocks_count)) {
+   if (block < le32_to_cpu(es->s_first_data_block) ||
+       block + count < block ||
+       block + count > le32_to_cpu(es->s_blocks_count)) {
        ext2_error (sb, "ext2_free_blocks",
                "Freeing blocks not in datazone - "
                "block = %lu, count = %lu", block, count);


Any thoughts ?

	Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
