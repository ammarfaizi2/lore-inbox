Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277618AbRJRJY5>; Thu, 18 Oct 2001 05:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277633AbRJRJYr>; Thu, 18 Oct 2001 05:24:47 -0400
Received: from sky.irisa.fr ([131.254.60.147]:36265 "EHLO sky.irisa.fr")
	by vger.kernel.org with ESMTP id <S277618AbRJRJYh>;
	Thu, 18 Oct 2001 05:24:37 -0400
Message-ID: <3BCE9FF5.97F7BD8D@irisa.fr>
Date: Thu, 18 Oct 2001 11:25:09 +0200
From: Romain Dolbeau <dolbeau@irisa.fr>
Organization: IRISA, Campus de Beaulieu, 35042 Rennes Cedex, FRANCE
X-Mailer: Mozilla 4.78 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Mounting of HFS CD-ROM broke between 2.4.9 and 2.4.10
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

HFS (Hierarchical File Sytem, from Apple) formatted CD-ROM used
to mount fine until 2.4.9, and file on them were accessible.
They won't mount anymore in 2.4.10 and 2.4.12. Error messages are:

#####
ll_rw_block: device 0b:00: only 2048-char blocks implemented (512)
hfs_fs: unable to read block 0x00000002 from dev 0b:00
hfs_fs: Unable to read superblock
ll_rw_block: device 0b:00: only 2048-char blocks implemented (512)
hfs_fs: unable to read block 0x00000000 from dev 0b:00
hfs_fs: Unable to read block 0.
#####

Between 2.4.9 and 2.4.10, changes were made to this function
including:

#####
--- linux-2.4.9/drivers/block/ll_rw_blk.c       Sat Aug  4 07:37:09 2001
+++ linux-2.4.10/drivers/block/ll_rw_blk.c      Fri Sep 21 06:02:01 2001
[SNIP some other changes]
@@ -990,12 +973,7 @@
        major = MAJOR(bhs[0]->b_dev);
 
        /* Determine correct block size for this device. */
-       correct_size = BLOCK_SIZE;
-       if (blksize_size[major]) {
-               i = blksize_size[major][MINOR(bhs[0]->b_dev)];
-               if (i)
-                       correct_size = i;
-       }
+       correct_size = get_hardsect_size(bhs[0]->b_dev);
 
        /* Verify requested block sizes. */
        for (i = 0; i < nr; i++) {
#####

A check then made on correct_size fails with the above error message.

-- 
DOLBEAU Romain               | Brothers of Metal will always be there     
ENS Cachan / Ker Lann        | Standing together with hands in the air    
Thesard IRISA / CAPS         |           -- Manowar,                      
dolbeaur@club-internet.fr    |                     'Brothers of Metal'
