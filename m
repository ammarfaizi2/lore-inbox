Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S156563AbPI1HqP>; Tue, 28 Sep 1999 03:46:15 -0400
Received: by vger.rutgers.edu id <S156411AbPI1Hm3>; Tue, 28 Sep 1999 03:42:29 -0400
Received: from mentolat-e0.core.genedata.com ([157.161.173.16]:2761 "EHLO mail.core.genedata.com") by vger.rutgers.edu with ESMTP id <S156578AbPI1Hjt>; Tue, 28 Sep 1999 03:39:49 -0400
Message-ID: <37F070AE.1A3E8B4D@gold.net>
Date: Tue, 28 Sep 1999 09:39:26 +0200
From: Al Smith <Al.Smith@aeschi.ch.eu.org>
Organization: http://aeschi.ch.eu.org/
X-Mailer: Mozilla 4.61C-SGI [en] (X11; I; IRIX 6.5 IP32)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.rutgers.edu
Subject: buffer cache problem
Content-Type: multipart/mixed; boundary="------------2CB036E11A5EBDB85A5ECEDB"
Sender: owner-linux-kernel@vger.rutgers.edu

This is a multi-part message in MIME format.
--------------2CB036E11A5EBDB85A5ECEDB
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

it has been reported that there is a problem with efs regarding files being
corrupt. the known example is with the IRIX 5.3 cd (sgi part number
812-0119-006) and the file dist/compiler_eoe.sw. md5sum should return
...ca10 for this file, however observe the following sequence of commands:

# mount -t efs -o ro /dev/sr0 /n/sr0
# md5sum /n/sr0/dist/compiler_eoe.sw
38c7655a29faac15052f506f5fbc2f16  /n/sr0/dist/compiler_eoe.sw
# umount /n/sr0
# eject /dev/sr0
(reinsert the CD)
# mount -t efs -o ro /dev/sr0 /n/sr0
# md5sum /n/sr0/dist/compiler_eoe.sw
cec7e08bc479ef6b2599ea1458ea94f2  /n/sr0/dist/compiler_eoe.sw
# umount /n/sr0
# eject /dev/sr0
(repeat ad infinitum, with a different md5sum each time).

fs/efs/inode.c:efs_map_block() _is_ returning the correct block number off
the CD (rationale: looking at lots of printk() output in the systlog). in
particular, it is irrelevant whether the file in question is composed of
direct or indirect extents.

comparing the known-good compiler_eoe.sw with a corrupted file read with
linux results in about 0.1% of single blocks throughout the file being
"wrong", spread more-or-less evenly through the whole file. i have observed
the "wrong" blocks to come from other blocks on the CD, however the "wrong"
blocks have also been observed to come from other open files (the
particular example reported was compiler_eoe.sw being interspersed with
blocks from an oracle database).

dd(1)ing the entire CD onto disk and mounting that image as /dev/loopN does
not result in any problem - the correct md5sum is consistently returned.

oddly enough, the following patch fixes the symptons, but points to a
problem elsewhere. btw, this problem has been noted on at least 2.2.12 and
2.2.13pre14, and probably most other 2.2 kernels. finally, i'm not
subscribed to linux-kernel; please Cc: replies.

-al.


--------------2CB036E11A5EBDB85A5ECEDB
Content-Type: text/plain; charset=us-ascii;
 name="efs-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="efs-patch"

--- file.c.orig	Tue Sep 28 09:31:18 1999
+++ file.c	Tue Sep 28 09:31:51 1999
@@ -47,6 +47,7 @@
 };
  
 int efs_bmap(struct inode *inode, efs_block_t block) {
+	int result;
 
 	if (block < 0) {
 		printk(KERN_WARNING "EFS: bmap(): block < 0\n");
@@ -68,6 +69,13 @@
 		return 0;
 	}
 
-	return(efs_map_block(inode, block));
+	result = efs_map_block(inode, block);
+
+	{ struct buffer_head * bh;
+		bh = bread(inode->i_dev, result, EFS_BLOCKSIZE);
+		if (bh) brelse(bh);
+	}
+
+	return(result);
 }
 

--------------2CB036E11A5EBDB85A5ECEDB--


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
