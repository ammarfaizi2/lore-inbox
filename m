Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316474AbSEOTfg>; Wed, 15 May 2002 15:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316477AbSEOTff>; Wed, 15 May 2002 15:35:35 -0400
Received: from host194.steeleye.com ([216.33.1.194]:62738 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S316474AbSEOTfe>; Wed, 15 May 2002 15:35:34 -0400
Message-Id: <200205151935.g4FJZSL04191@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Russell King <rmk@arm.linux.org.uk>
cc: James Bottomley <James.Bottomley@SteelEye.com>, viro@math.psu.edu,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] fix for initrd breakage in 2.5.13+ 
In-Reply-To: Message from Russell King <rmk@arm.linux.org.uk> 
   of "Wed, 15 May 2002 19:54:22 BST." <20020515195421.C28997@flint.arm.linux.org.uk> 
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_19067810270"
Date: Wed, 15 May 2002 15:35:28 -0400
From: James Bottomley <James.Bottomley@SteelEye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_19067810270
Content-Type: text/plain; charset=us-ascii

rmk@arm.linux.org.uk said:
> --- drivers/block/rd.c	Fri May  3 03:26:05 2002 +++ /tmp/rd.c	Mon May
> 6 03:00:00 2002 @@ -376,6 +376,7 @@
>  		rd_bdev[unit] = bdget(kdev_t_to_nr(inode->i_rdev));
>  		rd_bdev[unit]->bd_openers++;
>  		rd_bdev[unit]->bd_inode->i_mapping->a_ops = &ramdisk_aops;
> +		rd_bdev[unit]->bd_block_size = rd_blocksize;
>  	}
>    	return 0; 

Ah Thanks!.  Yes, that's the bit I was looking for.  It also explains why 
bd_openers was already incremented.

I think you still need to set the block queue hardsect size correctly as well, 
so the final fix for the initrd problems should be the attached (which works 
for me).

James


--==_Exmh_19067810270
Content-Type: text/plain ; name="tmp.diff"; charset=us-ascii
Content-Description: tmp.diff
Content-Disposition: attachment; filename="tmp.diff"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.513   -> 1.514  
#	  drivers/block/rd.c	1.35    -> 1.36   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/15	jejb@mulgrave.(none)	1.514
# rd.c blocksize fix
# --------------------------------------------
#
diff -Nru a/drivers/block/rd.c b/drivers/block/rd.c
--- a/drivers/block/rd.c	Wed May 15 15:21:55 2002
+++ b/drivers/block/rd.c	Wed May 15 15:21:55 2002
@@ -376,6 +376,7 @@
 		rd_bdev[unit] = bdget(kdev_t_to_nr(inode->i_rdev));
 		rd_bdev[unit]->bd_openers++;
 		rd_bdev[unit]->bd_inode->i_mapping->a_ops = &ramdisk_aops;
+		rd_bdev[unit]->bd_block_size = rd_blocksize;
 	}
 
 	return 0;
@@ -424,6 +425,7 @@
 	}
 
 	blk_queue_make_request(BLK_DEFAULT_QUEUE(MAJOR_NR), &rd_make_request);
+	blk_queue_hardsect_size(BLK_DEFAULT_QUEUE(MAJOR_NR), rd_blocksize);
 
 	for (i = 0; i < NUM_RAMDISKS; i++) {
 		/* rd_size is given in kB */

--==_Exmh_19067810270--


