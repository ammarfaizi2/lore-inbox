Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129987AbRCAVF2>; Thu, 1 Mar 2001 16:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130008AbRCAVFT>; Thu, 1 Mar 2001 16:05:19 -0500
Received: from sun.permonline.ru ([212.120.160.132]:19177 "EHLO
	sun.permonline.ru") by vger.kernel.org with ESMTP
	id <S129987AbRCAVFC>; Thu, 1 Mar 2001 16:05:02 -0500
Message-Id: <200103012103.CAA22522@sun.permonline.ru>
From: "Alexey Guzeev" <aga@permonline.ru>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Fri, 02 Mar 01 00:11:21 +0500
Reply-To: "Alexey Guzeev" <aga@permonline.ru>
X-Mailer: PMMail 1.91 For OS/2
MIME-Version: 1.0
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: 7bit
Subject: NBD blocksizes!=1024
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is simple fix (against 2.4.2, but can be easily applied to 2.2.18 too) for NBD, OKed by Pavel. It allows to use blocksizes other than 1024 
bytes. Without this fix, device with 4096-byte blocks has only 1/8 part accessible (and thus mke2fs fails, etc.).

To use NBD with variable blocksizes, you'll need updated nbd-client.c - Pavel should already have it in CVS, if not, take that from archive linked 
at http://fortunedirectory.com/aga/NBDServer.html (there is also my NBD server that stores and uses NBD device content compressed with 
ZLIB - on my current /usr/src, disk space usage is about fourfold smaller).

BTW, I've noticed quite a bit of speedup while using blocks 4096 bytes long, instead of 1024. I'd like to hear if you notice/measure the same 
thing.

=======
--- linux/drivers/block/nbd.c.OLD	Mon Feb 26 22:27:52 2001
+++ linux/drivers/block/nbd.c	Tue Feb 27 09:45:57 2001
@@ -18,6 +18,8 @@
  * 97-9-13 Cosmetic changes
  * 98-5-13 Attempt to make 64-bit-clean on 64-bit machines
  * 99-1-11 Attempt to make 64-bit-clean on 32-bit machines <ankry@mif.pg.gda.pl>
+ * 01-2-27 Fix to store proper blockcount for kernel (calculated using
+ *   BLOCK_SIZE_BITS, not device blocksize) <aga@permonline.ru>
  *
  * possible FIXME: make set_sock / set_blksize / set_size / do_it one syscall
  * why not: would need verify_area and friends, would share yet another 
@@ -413,16 +415,16 @@
 			nbd_blksize_bits[dev]++;
 			temp >>= 1;
 		}
-		nbd_sizes[dev] = nbd_bytesizes[dev] >> nbd_blksize_bits[dev];
-		nbd_bytesizes[dev] = nbd_sizes[dev] << nbd_blksize_bits[dev];
+		nbd_bytesizes[dev] &= ~(nbd_blksizes[dev]-1); 
+		nbd_sizes[dev] = nbd_bytesizes[dev] >> BLOCK_SIZE_BITS;
 		return 0;
 	case NBD_SET_SIZE:
-		nbd_sizes[dev] = arg >> nbd_blksize_bits[dev];
-		nbd_bytesizes[dev] = nbd_sizes[dev] << nbd_blksize_bits[dev];
+		nbd_bytesizes[dev] = arg & ~(nbd_blksizes[dev]-1); 
+		nbd_sizes[dev] = nbd_bytesizes[dev] >> BLOCK_SIZE_BITS;
 		return 0;
 	case NBD_SET_SIZE_BLOCKS:
-		nbd_sizes[dev] = arg;
-		nbd_bytesizes[dev] = ((u64) arg) << nbd_blksize_bits[dev];
+		nbd_bytesizes[dev] = ((u64) arg) << nbd_blksize_bits[dev]; 
+		nbd_sizes[dev] = nbd_bytesizes[dev] >> BLOCK_SIZE_BITS;
 		return 0;
 	case NBD_DO_IT:
 		if (!lo->file)
@@ -513,7 +515,7 @@
 		nbd_blksizes[i] = 1024;
 		nbd_blksize_bits[i] = 10;
 		nbd_bytesizes[i] = 0x7ffffc00; /* 2GB */
-		nbd_sizes[i] = nbd_bytesizes[i] >> nbd_blksize_bits[i];
+		nbd_sizes[i] = nbd_bytesizes[i] >> BLOCK_SIZE_BITS;
 		register_disk(NULL, MKDEV(MAJOR_NR,i), 1, &nbd_fops,
 				nbd_bytesizes[i]>>9);
 	}

Alexey                                            [Team OS/2]

