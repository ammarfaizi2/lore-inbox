Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262639AbUKRGu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262639AbUKRGu2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 01:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262648AbUKRGu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 01:50:28 -0500
Received: from siaag2ac.compuserve.com ([149.174.40.133]:1270 "EHLO
	siaag2ac.compuserve.com") by vger.kernel.org with ESMTP
	id S262639AbUKRGsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 01:48:20 -0500
Date: Thu, 18 Nov 2004 01:44:20 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Linux 2.6.9-ac9
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <200411180148_MC3-1-8EE2-A85E@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> Time to check them all and the size of the diff already


I just merged these on top of the ones in 2.6.9-ac9:

================================================================================
# binfmt_elf_partial_read_2.patch
#       fs/binfmt_elf.c -2 +5
#
#       [PATCH] binfmt_elf: handle p_filesz == 0 on PT_INTERP section
#       Jakub Jelinek points out that current fix has an underflow problem
#       if elf_ppnt->p_filesz == 0.  Fix that up, and also stop overwriting
#       interpreter buffer, simply check that it's NULL-terminated.
#   
#       From: Jakub Jelinek <jakub@redhat.com>
#       Signed-off-by: Chris Wright <chrisw@osdl.org>
#       Signed-off-by: Linus Torvalds <torvalds@osdl.org>
#       Status: in 2.6.10
# 
--- 2.6.9/fs/binfmt_elf.c
+++ 2.6.9.1/fs/binfmt_elf.c
@@ -576,7 +576,8 @@
                         */
 
                        retval = -ENOMEM;
-                       if (elf_ppnt->p_filesz > PATH_MAX)
+                       if (elf_ppnt->p_filesz > PATH_MAX || 
+                           elf_ppnt->p_filesz == 0)
                                goto out_free_file;
                        elf_interpreter = (char *) kmalloc(elf_ppnt->p_filesz,
                                                           GFP_KERNEL);
@@ -592,7 +593,9 @@
                                goto out_free_interp;
                        }
                        /* make sure path is NULL terminated */
-                       elf_interpreter[elf_ppnt->p_filesz - 1] = '\0';
+                       retval = -EINVAL;
+                       if (elf_interpreter[elf_ppnt->p_filesz - 1] != '\0')
+                               goto out_free_interp;
 
                        /* If the program interpreter is one of these two,
                         * then assume an iBCS2 image. Otherwise assume
================================================================================
# md_linear_sector_t_2.patch
#       drivers/md/linear.c -10 +11
#
#       From: Neil Brown <neilb@cse.unsw.edu.au>
#
#       We replace 'size' by 'start'.  'start' means exactly the same as
#       'curr_offset - size', and the equivalence of the new code can be tested
#       based on this.  The difference is that 'start' will never be negative and
#       so can fit in a 'sector_t' while 'size' could be negative.
#
#       Also make curr_offset sector_t, as it should have been.
#
#       Signed-off-by: Neil Brown <neilb@cse.unsw.edu.au>
#       Signed-off-by: Andrew Morton <akpm@osdl.org>
#       Status: in 2.6.10-mm
#
--- 2.6.9/drivers/md/linear.c
+++ 2.6.9.1/drivers/md/linear.c
@@ -120,8 +120,8 @@ static int linear_run (mddev_t *mddev)
        struct linear_hash *table;
        mdk_rdev_t *rdev;
        int i, nb_zone, cnt;
-       sector_t size;
-       unsigned int curr_offset;
+       sector_t start;
+       sector_t curr_offset;
        struct list_head *tmp;
 
        conf = kmalloc (sizeof (*conf) + mddev->raid_disks*sizeof(dev_info_t),
@@ -196,23 +196,24 @@ static int linear_run (mddev_t *mddev)
         * Here we generate the linear hash table
         */
        table = conf->hash_table;
-       size = 0;
+       start = 0;
        curr_offset = 0;
        for (i = 0; i < cnt; i++) {
                dev_info_t *disk = conf->disks + i;
 
+               if (start > curr_offset)
+                       table[-1].dev1 = disk;
+
                disk->offset = curr_offset;
                curr_offset += disk->size;
 
-               if (size < 0) {
-                       table[-1].dev1 = disk;
-               }
-               size += disk->size;
-
-               while (size>0) {
+               /* 'curr_offset' is the end of this disk
+                * 'start' is the start of table
+                */
+               while (start < curr_offset) {
                        table->dev0 = disk;
                        table->dev1 = NULL;
-                       size -= conf->smallest->size;
+                       start += conf->smallest->size;
                        table++;
                }
        }
================================================================================

--Chuck Ebbert  18-Nov-04  01:41:54
