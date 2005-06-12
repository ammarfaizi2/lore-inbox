Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbVFLVpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbVFLVpT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 17:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVFLVpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 17:45:19 -0400
Received: from mail4.worldserver.net ([217.13.200.24]:28628 "EHLO
	mail4.worldserver.net") by vger.kernel.org with ESMTP
	id S261230AbVFLVnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 17:43:06 -0400
Date: Sun, 12 Jun 2005 23:43:05 +0200
From: Christian Leber <christian@leber.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] lzma support: decompression lib, initrd support
Message-ID: <20050612214305.GA26732@core.home>
References: <20050607213204.GA2645@core.home> <20050607145903.4b2ac9bf.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050607145903.4b2ac9bf.akpm@osdl.org>
X-Accept-Language: de en
X-Location: Europe, Germany, Mannheim
X-Operating-System: Debian GNU/Linux (sid)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2005 at 02:59:03PM -0700, Andrew Morton wrote:

> > +} CBuffer; 
> Nuke the StudlyCaps.

etc. everything is fixed now

> > +#define RangeDecoderBitTreeDecode(probs, numLevels, res) \
> > +  { int i = numLevels; res = 1; \
> > +  do { CProb *p = probs + res; RC_GET_BIT(p, res) } while(--i != 0); \
> > +  res -= (1 << numLevels); }
> 
> Ugh.  Can we remove all this macro magic?

Not without completly rewriting it and this would lead code that is not
easily updateable to upstream, like the gzip implementation at the moment
(lib/inflate.c), it can't decompress everything that the userspace gzip is
able to decompress. (apart from that all the global variables aren't
such a nice style and inflate.c is no bit more intuitive)


So now refreshed:


This patch is against 2.6.12-rc6.

This patch adds the possibility to compress a initrd with lzma, you
need ths CONFIG_BLK_DEV_RAM_LZMA build option to make use of lzma
compressed initrds.
(Device Drivers -> Block devices)

For example the debian installer initrd:
-rw-r--r--  1 ijuz ijuz 2870355 Mar  5 20:00 initrd.gz
-rw-r--r--  1 ijuz ijuz 2158769 May  8 02:09 initrd.lzma


Signed-off-by: Christian Leber <christian@leber.de>



--- linux-2.6.12-rc6.orig/init/do_mounts.h	2005-06-06 17:22:29.000000000 +0200
+++ linux-2.6.12-rc6/init/do_mounts.h	2005-06-12 20:59:02.000000000 +0200
@@ -90,3 +90,20 @@
 static inline void md_run_setup(void) {}
 
 #endif
+
+
+/*
+ * The following lines define some constants to support different
+ * compressed ramdisk types.
+ * Each compressed ramdisk type is bound to a _negative_ value,
+ * since positive values give us the number of blocks.
+ */
+
+#define RD_ERROR       (-65535)
+#define CRAMDISK_LZMA   (-1)
+#define CRAMDISK_GZ    (-2)
+
+#if defined(CONFIG_BLK_DEV_RAM_GZ) || defined(CONFIG_BLK_DEV_RAM_LZMA)
+#      define BUILD_CRAMDISK
+#endif
+

--- linux-2.6.12-rc6.orig/drivers/block/Kconfig	2005-06-06 17:22:29.000000000 +0200
+++ linux-2.6.12-rc6/drivers/block/Kconfig	2005-06-07 21:33:34.000000000 +0200
@@ -398,6 +398,43 @@
 	  what are you doing. If you are using IBM S/390, then set this to
 	  8192.
 
+config BLK_DEV_RAM_GZ
+       bool "Gzip compressed ramdisk support"
+       depends on BLK_DEV_RAM=y || BLK_DEV_RAM=m
+       default y
+       help
+         This option enables support for gzip compressed ramdisk images.
+         An image can be loaded as initrd (see above) or as a normal
+         ramdisk at boot time.
+         Enabling this option is good for people who use an initrd or
+         a normal ramdisk and who are low on available disk space.
+         The decompression process at boot time needs about 2 MB additional
+         RAM to the space the unpacked ramdisk needs.
+
+         Due to the fact that this feature is normally included in the
+         original ramdisk, you should say Y to this option.
+
+config BLK_DEV_RAM_LZMA
+       bool "Lzma compressed ramdisk support (EXPERIMENTAL)"
+       depends on BLK_DEV_RAM=y || BLK_DEV_RAM=m && EXPERIMENTAL
+       default n
+       help
+         This option enables support for lzma compressed ramdisk images.
+         An image can be loaded as initrd (see above) or as a normal
+         ramdisk at boot time.
+         Enabling this option is good for people who use an initrd or
+         a normal ramdisk and who are very low on available disk space
+         (eg. for embedded systems with rom image and plenty of RAM).
+         This option was implemented, because lzma has better compression
+         than gzip. If you want to use this feature and disk space is a
+         matter, say N to gzip support and compress your ramdisk using
+         lzma.
+
+         This is an optional feature. Only enable this option if you need
+         lzma support for your ramdisk (e.g. for boot+root floppies). So
+         if you are unsure say N.
+
+
 config BLK_DEV_INITRD
 	bool "Initial RAM disk (initrd) support"
 	depends on BLK_DEV_RAM=y


--- linux-2.6.12-rc6.orig/init/do_mounts_rd.c	2005-06-06 17:22:29.000000000 +0200
+++ linux-2.6.12-rc6/init/do_mounts_rd.c	2005-06-12 23:29:38.000000000 +0200
@@ -10,8 +10,6 @@
 
 #include "do_mounts.h"
 
-#define BUILD_CRAMDISK
-
 int __initdata rd_prompt = 1;/* 1 = prompt for RAM disk, 0 = don't prompt */
 
 static int __init prompt_ramdisk(char *str)
@@ -30,20 +28,27 @@
 }
 __setup("ramdisk_start=", ramdisk_start_setup);
 
-static int __init crd_load(int in_fd, int out_fd);
+
+#ifdef CONFIG_BLK_DEV_RAM_GZ
+static int __init gz_load(int in_fd, int out_fd);
+#endif /* CONFIG_BLK_DEV_RAM_GZ */
+
+#ifdef CONFIG_BLK_DEV_RAM_LZMA
+static int __init lzma_load(int in_fd, int out_fd);
+#endif /* CONFIG_BLK_DEV_RAM_LZMA */
 
 /*
  * This routine tries to find a RAM disk image to load, and returns the
- * number of blocks to read for a non-compressed image, 0 if the image
- * is a compressed image, and -1 if an image with the right magic
- * numbers could not be found.
+ * number of blocks to read for a non-compressed image, a negative value
+ * if the image is a compressed image, and RD_ERROR if an image with
+ * the right magic numbers (see below) could not be found.
  *
  * We currently check for the following magic numbers:
  * 	minix
  * 	ext2
  *	romfs
  *	cramfs
- * 	gzip
+ * 	compressed image formats (gzip, lzma)
  */
 static int __init 
 identify_ramdisk_image(int fd, int start_block)
@@ -53,12 +58,12 @@
 	struct ext2_super_block *ext2sb;
 	struct romfs_super_block *romfsb;
 	struct cramfs_super *cramfsb;
-	int nblocks = -1;
+	int nblocks = RD_ERROR;
 	unsigned char *buf;
 
 	buf = kmalloc(size, GFP_KERNEL);
 	if (buf == 0)
-		return -1;
+		return RD_ERROR;
 
 	minixsb = (struct minix_super_block *) buf;
 	ext2sb = (struct ext2_super_block *) buf;
@@ -73,16 +78,28 @@
 	sys_read(fd, buf, size);
 
 	/*
-	 * If it matches the gzip magic numbers, return -1
+	 * If it matches the gzip magic numbers, return CRAMDISK_GZ
 	 */
 	if (buf[0] == 037 && ((buf[1] == 0213) || (buf[1] == 0236))) {
 		printk(KERN_NOTICE
-		       "RAMDISK: Compressed image found at block %d\n",
+		       "RAMDISK: Gzip compressed image found at block %d\n",
 		       start_block);
-		nblocks = 0;
+		nblocks = CRAMDISK_GZ;
 		goto done;
 	}
 
+	/*
+	 * Unfortunally lzma has no magic number, return CRAMDISK_LZMA
+	 * but byte 9 to 12 has to be zero
+	 */
+	if (buf[9] == 0 && buf[10] == 0 && buf[11] == 0 && buf[12] == 0) {
+		printk(KERN_NOTICE
+			"RAMDISK: lzma compressed image found at block %d\n",
+			start_block);
+		nblocks = CRAMDISK_LZMA;
+		goto done;
+	}
+	
 	/* romfs is at block zero too */
 	if (romfsb->word0 == ROMSB_WORD0 &&
 	    romfsb->word1 == ROMSB_WORD1) {
@@ -158,19 +175,27 @@
 		goto noclose_input;
 
 	nblocks = identify_ramdisk_image(in_fd, rd_image_start);
-	if (nblocks < 0)
-		goto done;
-
-	if (nblocks == 0) {
-#ifdef BUILD_CRAMDISK
-		if (crd_load(in_fd, out_fd) == 0)
-			goto successful_load;
+	switch (nblocks) {
+		case CRAMDISK_LZMA :     /* lzma image found */
+#ifdef CONFIG_BLK_DEV_RAM_LZMA
+			if(lzma_load(in_fd, out_fd) == 0)
+				goto successful_load;
 #else
-		printk(KERN_NOTICE
-		       "RAMDISK: Kernel does not support compressed "
-		       "RAM disk images\n");
+			printk(KERN_ALERT "RAMDISK: you don't have "
+					"CONFIG_BLK_DEV_RAM_LZMA\n");
 #endif
-		goto done;
+			break;
+		case CRAMDISK_GZ :      /* gzip image found */
+#ifdef CONFIG_BLK_DEV_RAM_GZ
+			if(gz_load(in_fd, out_fd) == 0)
+				goto successful_load;
+#else
+			printk(KERN_ALERT "RAMDISK: you don't have "
+					"CONFIG_BLK_DEV_RAM_GZ\n");
+#endif
+			break;
+		default :
+			break;
 	}
 
 	/*
@@ -217,8 +242,9 @@
 		goto done;
 	}
 
-	printk(KERN_NOTICE "RAMDISK: Loading %dKiB [%ld disk%s] into ram disk... ",
-		nblocks, ((nblocks-1)/devblocks)+1, nblocks>devblocks ? "s" : "");
+	printk(KERN_NOTICE "RAMDISK: Loading %dKiB [%ld disk%s] into"
+		"ram disk... ",	nblocks, ((nblocks-1)/devblocks)+1,
+		nblocks>devblocks ? "s" : "");
 	for (i = 0, disk = 1; i < nblocks; i++) {
 		if (i && (i % devblocks == 0)) {
 			printk("done disk #%d.\n", disk++);
@@ -254,7 +280,6 @@
 	sys_close(out_fd);
 out:
 	kfree(buf);
-	sys_unlink("/dev/ram");
 	return res;
 }
 
@@ -267,7 +292,7 @@
 	return rd_load_image("/dev/root");
 }
 
-#ifdef BUILD_CRAMDISK
+#ifdef CONFIG_BLK_DEV_RAM_GZ
 
 /*
  * gzip declarations
@@ -393,13 +418,13 @@
 	unzip_error = 1;
 }
 
-static int __init crd_load(int in_fd, int out_fd)
+static int __init gz_load(int in_fd, int out_fd)
 {
 	int result;
 
-	insize = 0;		/* valid bytes in inbuf */
-	inptr = 0;		/* index of next byte to be processed in inbuf */
-	outcnt = 0;		/* bytes in output buffer */
+	insize = 0;	/* valid bytes in inbuf */
+	inptr = 0;	/* index of next byte to be processed in inbuf */
+	outcnt = 0;	/* bytes in output buffer */
 	exit_code = 0;
 	bytes_out = 0;
 	crc = (ulg)0xffffffffL; /* shift register contents */
@@ -426,4 +451,173 @@
 	return result;
 }
 
-#endif  /* BUILD_CRAMDISK */
+#endif  /* ONFIG_BLK_DEV_RAM_GZ */
+
+#ifdef CONFIG_BLK_DEV_RAM_LZMA
+#include <linux/vmalloc.h>
+/* the lzma decompression function will use a callback function to get
+ * it's input data */
+#define _LZMA_IN_CB
+/* the lzma decompression function will only write out small pieces instead
+ * of everything to a single address, the disadvantage of this is that we
+ * need extra memory for the dictionary, the default size is 8 MB */
+#define _LZMA_OUT_READ 
+#define _LZMA_READ_COMPRESSED_BUFFER_SIZE 0x10000
+#define _LZMA_WRITE_BUFFER_SIZE 0x10000
+
+#ifndef UInt32
+#define UInt32 u32
+#endif
+
+#include <../lib/lzmadecode.h>
+#include <../lib/lzmadecode.c>
+
+typedef struct _cbuffer
+{
+	ILzmaInCallback in_callback;
+	unsigned char *buffer;
+	int lzma_read_fd;
+} cbuffer; 
+  
+static int lzma_read_in(void *obj, unsigned char **buffer, unsigned int *size)
+{
+	cbuffer *bo = obj;
+	int read_size;
+	/* try to read _LZMA_READ_COMPRESSED_BUFFER_SIZE bytes */
+	read_size = sys_read(bo->lzma_read_fd, bo->buffer,
+		_LZMA_READ_COMPRESSED_BUFFER_SIZE);
+	*size = read_size;
+	*buffer = bo->buffer;
+	return LZMA_RESULT_OK;
+}
+
+static int __init lzma_load(int in_fd, int out_fd)
+{
+	unsigned char properties[5], prop0;
+	unsigned char *dictionary, *out_buffer = 0;
+	unsigned int out_size, lzma_internal_size, size_processed;
+	unsigned int now_pos, dictionary_size  = 0;
+	void *lzma_internal;
+	int lc, lp, pb;
+	int i, res, return_val;
+	cbuffer bo;
+	
+	if (sys_read(in_fd, (unsigned char *)&properties, 5) == 0) {
+		printk(KERN_ERR "RAMDISK: ran out of compressed data");
+		return -1;
+	}
+
+	out_size = 0;
+	for (i = 0; i < 4; i++) {
+		unsigned char b;
+		if (sys_read(in_fd, &b, 1) == 0) {
+			printk(KERN_ERR "RAMDISK: ran out of compressed data");
+			return -1;
+		}
+		out_size += (unsigned int)(b) << (i * 8);
+	}
+	
+	for (i = 0; i < 4; i++) {
+		unsigned char b;
+		if (sys_read(in_fd, &b, 1) == 0) {
+			printk(KERN_ERR "RAMDISK: ran out of compressed data");
+			return -1;
+		}
+		if (b!=0) {
+			printk(KERN_ERR "RAMDISK: either this is not a lzma"
+				"compressed ramdisk or it's bigger 4 GB");
+			return -1;
+		}
+	}
+	
+	prop0 = properties[0];
+	if (prop0 >= (9*5*5)) { 
+		printk(KERN_ERR "RAMDISK: lzma Properties error");
+		return -1;
+	}
+
+	pb = prop0 / 45;
+	prop0 = prop0 % 45;
+	lp = prop0 / 9;
+	lc = prop0 % 9;
+
+	lzma_internal_size = (LZMA_BASE_SIZE + (LZMA_LIT_SIZE << (lc + lp)))
+		* sizeof(CProb);
+	lzma_internal_size += 100; /* because we are using _LZMA_OUT_READ */
+	
+	lzma_internal = vmalloc(lzma_internal_size);
+	if(lzma_internal == 0) { 
+		printk(KERN_ERR "RAMDISK: failed to get memory "
+			"for lzma_internal");
+		return -1;
+	}
+
+	bo.in_callback.Read = lzma_read_in;
+	bo.lzma_read_fd = in_fd;
+	bo.buffer = vmalloc(_LZMA_READ_COMPRESSED_BUFFER_SIZE);
+	if (bo.buffer == 0) { 
+		printk(KERN_ERR "RAMDISK: failed to get memory for bo.Buffer");
+		return_val = -1;
+		goto free_lzma_internal;
+	}
+
+	for (i = 0; i < 4; i++) {
+		dictionary_size += (u32)(properties[1 + i]) << (i * 8);
+	}
+	if (dictionary_size == 0) {
+		/* LZMA decoder can not work with dictionary_size = 0 */
+		dictionary_size = 1;
+	}
+	dictionary = vmalloc(dictionary_size);
+	if (dictionary == 0) { 
+		printk(KERN_ERR "RAMDISK: failed to get memory for dictionary");
+		return_val = -1;
+		goto free_bo_buffer;
+	}
+	res = LzmaDecoderInit((unsigned char *)lzma_internal,
+		lzma_internal_size,
+		lc, lp, pb,
+		dictionary, dictionary_size,
+		&bo.in_callback);
+	if (res == 0) {
+		out_buffer = vmalloc(_LZMA_WRITE_BUFFER_SIZE);
+		if (out_buffer == 0) { 
+			printk(KERN_ERR "RAMDISK: failed to get memory"
+				"for out_buffer");
+			return_val = -1;
+			goto free_dictionary;
+		}
+		for (now_pos = 0; now_pos < out_size;) {
+			res = LzmaDecode((unsigned char *)lzma_internal,
+				out_buffer, _LZMA_WRITE_BUFFER_SIZE,
+				&size_processed);
+			if (res != 0)
+				break;
+			if (size_processed == 0) {
+				out_size = now_pos;
+				break;
+			}
+			now_pos += size_processed;
+			res = sys_write(out_fd, out_buffer, size_processed);
+			if (res!=size_processed) {
+				printk(KERN_ERR "can't write everything,"
+					"the ramdisk is too small");
+				return_val = -1;
+				goto free_out_buffer;
+			}
+		}
+	}
+	return_val = 0;
+
+free_out_buffer:
+	vfree(out_buffer);
+free_dictionary:
+	vfree(dictionary);
+free_bo_buffer:
+	vfree(bo.buffer);
+free_lzma_internal:
+	vfree(lzma_internal);
+	
+	return return_val;
+}
+#endif /* CONFIG_BLK_DEV_RAM_LZMA */


--- linux-2.6.12-rc6.orig/lib/lzmadecode.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.12-rc6/lib/lzmadecode.c	2005-06-08 23:45:32.000000000 +0200
@@ -0,0 +1,586 @@
+/*
+  LzmaDecode.c
+  LZMA Decoder (optimized for Speed version)
+  
+  LZMA SDK 4.17 Copyright (c) 1999-2005 Igor Pavlov (2005-04-05)
+  http://www.7-zip.org/
+
+  LZMA SDK is licensed under two licenses:
+  1) GNU Lesser General Public License (GNU LGPL)
+  2) Common Public License (CPL)
+  It means that you can select one of these two licenses and 
+  follow rules of that license.
+
+  SPECIAL EXCEPTION:
+  Igor Pavlov, as the author of this Code, expressly permits you to 
+  statically or dynamically link your Code (or bind by name) to the 
+  interfaces of this file without subjecting your linked Code to the 
+  terms of the CPL or GNU LGPL. Any modifications or additions 
+  to this file, however, are subject to the LGPL or CPL terms.
+*/
+
+#include "lzmadecode.h"
+
+#ifndef Byte
+#define Byte unsigned char
+#endif
+
+#define kNumTopBits 24
+#define kTopValue ((UInt32)1 << kNumTopBits)
+
+#define kNumBitModelTotalBits 11
+#define kBitModelTotal (1 << kNumBitModelTotalBits)
+#define kNumMoveBits 5
+
+#define RC_READ_BYTE (*Buffer++)
+
+#define RC_INIT2 Code = 0; Range = 0xFFFFFFFF; \
+  { int i; for(i = 0; i < 5; i++) { RC_TEST; Code = (Code << 8) | RC_READ_BYTE; }}
+
+#ifdef _LZMA_IN_CB
+
+#define RC_TEST { if (Buffer == BufferLim) \
+  { UInt32 size; int result = InCallback->Read(InCallback, &Buffer, &size); if (result != LZMA_RESULT_OK) return result; \
+  BufferLim = Buffer + size; if (size == 0) return LZMA_RESULT_DATA_ERROR; }}
+
+#define RC_INIT Buffer = BufferLim = 0; RC_INIT2
+
+#else
+
+#define RC_TEST { if (Buffer == BufferLim) return LZMA_RESULT_DATA_ERROR; }
+
+#define RC_INIT(buffer, bufferSize) Buffer = buffer; BufferLim = buffer + bufferSize; RC_INIT2
+ 
+#endif
+
+#define RC_NORMALIZE if (Range < kTopValue) { RC_TEST; Range <<= 8; Code = (Code << 8) | RC_READ_BYTE; }
+
+#define IfBit0(p) RC_NORMALIZE; bound = (Range >> kNumBitModelTotalBits) * *(p); if (Code < bound)
+#define UpdateBit0(p) Range = bound; *(p) += (kBitModelTotal - *(p)) >> kNumMoveBits;
+#define UpdateBit1(p) Range -= bound; Code -= bound; *(p) -= (*(p)) >> kNumMoveBits;
+
+#define RC_GET_BIT2(p, mi, A0, A1) IfBit0(p) \
+  { UpdateBit0(p); mi <<= 1; A0; } else \
+  { UpdateBit1(p); mi = (mi + mi) + 1; A1; } 
+  
+#define RC_GET_BIT(p, mi) RC_GET_BIT2(p, mi, ; , ;)               
+
+#define RangeDecoderBitTreeDecode(probs, numLevels, res) \
+  { int i = numLevels; res = 1; \
+  do { CProb *p = probs + res; RC_GET_BIT(p, res) } while(--i != 0); \
+  res -= (1 << numLevels); }
+
+
+#define kNumPosBitsMax 4
+#define kNumPosStatesMax (1 << kNumPosBitsMax)
+
+#define kLenNumLowBits 3
+#define kLenNumLowSymbols (1 << kLenNumLowBits)
+#define kLenNumMidBits 3
+#define kLenNumMidSymbols (1 << kLenNumMidBits)
+#define kLenNumHighBits 8
+#define kLenNumHighSymbols (1 << kLenNumHighBits)
+
+#define LenChoice 0
+#define LenChoice2 (LenChoice + 1)
+#define LenLow (LenChoice2 + 1)
+#define LenMid (LenLow + (kNumPosStatesMax << kLenNumLowBits))
+#define LenHigh (LenMid + (kNumPosStatesMax << kLenNumMidBits))
+#define kNumLenProbs (LenHigh + kLenNumHighSymbols) 
+
+
+#define kNumStates 12
+#define kNumLitStates 7
+
+#define kStartPosModelIndex 4
+#define kEndPosModelIndex 14
+#define kNumFullDistances (1 << (kEndPosModelIndex >> 1))
+
+#define kNumPosSlotBits 6
+#define kNumLenToPosStates 4
+
+#define kNumAlignBits 4
+#define kAlignTableSize (1 << kNumAlignBits)
+
+#define kMatchMinLen 2
+
+#define IsMatch 0
+#define IsRep (IsMatch + (kNumStates << kNumPosBitsMax))
+#define IsRepG0 (IsRep + kNumStates)
+#define IsRepG1 (IsRepG0 + kNumStates)
+#define IsRepG2 (IsRepG1 + kNumStates)
+#define IsRep0Long (IsRepG2 + kNumStates)
+#define PosSlot (IsRep0Long + (kNumStates << kNumPosBitsMax))
+#define SpecPos (PosSlot + (kNumLenToPosStates << kNumPosSlotBits))
+#define Align (SpecPos + kNumFullDistances - kEndPosModelIndex)
+#define LenCoder (Align + kAlignTableSize)
+#define RepLenCoder (LenCoder + kNumLenProbs)
+#define Literal (RepLenCoder + kNumLenProbs)
+
+#if Literal != LZMA_BASE_SIZE
+#error StopCompilingDueBUG
+#endif
+
+#ifdef _LZMA_OUT_READ
+
+typedef struct _LzmaVarState
+{
+  Byte *Buffer;
+  Byte *BufferLim;
+  UInt32 Range;
+  UInt32 Code;
+#ifdef _LZMA_IN_CB
+  ILzmaInCallback *InCallback;
+#endif
+  Byte *Dictionary;
+  UInt32 DictionarySize;
+  UInt32 DictionaryPos;
+  UInt32 GlobalPos;
+  UInt32 Reps[4];
+  int lc;
+  int lp;
+  int pb;
+  int State;
+  int RemainLen;
+  Byte TempDictionary[4];
+} LzmaVarState;
+
+int LzmaDecoderInit(
+    unsigned char *buffer, UInt32 bufferSize,
+    int lc, int lp, int pb,
+    unsigned char *dictionary, UInt32 dictionarySize,
+#ifdef _LZMA_IN_CB
+    ILzmaInCallback *InCallback
+#else
+    unsigned char *inStream, UInt32 inSize
+#endif
+    )
+{
+  Byte *Buffer;
+  Byte *BufferLim;
+  UInt32 Range;
+  UInt32 Code;
+  LzmaVarState *vs = (LzmaVarState *)buffer;
+  CProb *p = (CProb *)(buffer + sizeof(LzmaVarState));
+  UInt32 numProbs = Literal + ((UInt32)LZMA_LIT_SIZE << (lc + lp));
+  UInt32 i;
+  if (bufferSize < numProbs * sizeof(CProb) + sizeof(LzmaVarState))
+    return LZMA_RESULT_NOT_ENOUGH_MEM;
+  vs->Dictionary = dictionary;
+  vs->DictionarySize = dictionarySize;
+  vs->DictionaryPos = 0;
+  vs->GlobalPos = 0;
+  vs->Reps[0] = vs->Reps[1] = vs->Reps[2] = vs->Reps[3] = 1;
+  vs->lc = lc;
+  vs->lp = lp;
+  vs->pb = pb;
+  vs->State = 0;
+  vs->RemainLen = 0;
+  dictionary[dictionarySize - 1] = 0;
+  for (i = 0; i < numProbs; i++)
+    p[i] = kBitModelTotal >> 1; 
+
+#ifdef _LZMA_IN_CB
+  RC_INIT;
+#else
+  RC_INIT(inStream, inSize);
+#endif /* _LZMA_IN_CB */
+  vs->Buffer = Buffer;
+  vs->BufferLim = BufferLim;
+  vs->Range = Range;
+  vs->Code = Code;
+#ifdef _LZMA_IN_CB
+  vs->InCallback = InCallback;
+#endif
+
+  return LZMA_RESULT_OK;
+}
+
+int LzmaDecode(unsigned char *buffer, 
+    unsigned char *outStream, UInt32 outSize,
+    UInt32 *outSizeProcessed)
+{
+  LzmaVarState *vs = (LzmaVarState *)buffer;
+  Byte *Buffer = vs->Buffer;
+  Byte *BufferLim = vs->BufferLim;
+  UInt32 Range = vs->Range;
+  UInt32 Code = vs->Code;
+#ifdef _LZMA_IN_CB
+  ILzmaInCallback *InCallback = vs->InCallback;
+#endif
+  CProb *p = (CProb *)(buffer + sizeof(LzmaVarState));
+  int state = vs->State;
+  Byte previousByte;
+  UInt32 rep0 = vs->Reps[0], rep1 = vs->Reps[1], rep2 = vs->Reps[2], rep3 = vs->Reps[3];
+  UInt32 nowPos = 0;
+  UInt32 posStateMask = (1 << (vs->pb)) - 1;
+  UInt32 literalPosMask = (1 << (vs->lp)) - 1;
+  int lc = vs->lc;
+  int len = vs->RemainLen;
+  UInt32 globalPos = vs->GlobalPos;
+
+  Byte *dictionary = vs->Dictionary;
+  UInt32 dictionarySize = vs->DictionarySize;
+  UInt32 dictionaryPos = vs->DictionaryPos;
+
+  Byte tempDictionary[4];
+  if (dictionarySize == 0)
+  {
+    dictionary = tempDictionary;
+    dictionarySize = 1;
+    tempDictionary[0] = vs->TempDictionary[0];
+  }
+
+  if (len == -1)
+  {
+    *outSizeProcessed = 0;
+    return LZMA_RESULT_OK;
+  }
+
+  while(len != 0 && nowPos < outSize)
+  {
+    UInt32 pos = dictionaryPos - rep0;
+    if (pos >= dictionarySize)
+      pos += dictionarySize;
+    outStream[nowPos++] = dictionary[dictionaryPos] = dictionary[pos];
+    if (++dictionaryPos == dictionarySize)
+      dictionaryPos = 0;
+    len--;
+  }
+  if (dictionaryPos == 0)
+    previousByte = dictionary[dictionarySize - 1];
+  else
+    previousByte = dictionary[dictionaryPos - 1];
+#else /*_LZMA_OUT_READ */
+
+int LzmaDecode(
+    Byte *buffer, UInt32 bufferSize,
+    int lc, int lp, int pb,
+#ifdef _LZMA_IN_CB
+    ILzmaInCallback *InCallback,
+#else
+    unsigned char *inStream, UInt32 inSize,
+#endif
+    unsigned char *outStream, UInt32 outSize,
+    UInt32 *outSizeProcessed)
+{
+  UInt32 numProbs = Literal + ((UInt32)LZMA_LIT_SIZE << (lc + lp));
+  CProb *p = (CProb *)buffer;
+
+  UInt32 i;
+  int state = 0;
+  Byte previousByte = 0;
+  UInt32 rep0 = 1, rep1 = 1, rep2 = 1, rep3 = 1;
+  UInt32 nowPos = 0;
+  UInt32 posStateMask = (1 << pb) - 1;
+  UInt32 literalPosMask = (1 << lp) - 1;
+  int len = 0;
+  
+  Byte *Buffer;
+  Byte *BufferLim;
+  UInt32 Range;
+  UInt32 Code;
+  
+  if (bufferSize < numProbs * sizeof(CProb))
+    return LZMA_RESULT_NOT_ENOUGH_MEM;
+  for (i = 0; i < numProbs; i++)
+    p[i] = kBitModelTotal >> 1;
+  
+
+#ifdef _LZMA_IN_CB
+  RC_INIT;
+#else
+  RC_INIT(inStream, inSize);
+#endif
+#endif
+
+  *outSizeProcessed = 0;
+  while(nowPos < outSize)
+  {
+    CProb *prob;
+    UInt32 bound;
+    int posState = (int)(
+        (nowPos 
+        #ifdef _LZMA_OUT_READ
+        + globalPos
+        #endif
+        )
+        & posStateMask);
+
+    prob = p + IsMatch + (state << kNumPosBitsMax) + posState;
+    IfBit0(prob)
+    {
+      int symbol = 1;
+      UpdateBit0(prob)
+      prob = p + Literal + (LZMA_LIT_SIZE * 
+        (((
+        (nowPos 
+        #ifdef _LZMA_OUT_READ
+        + globalPos
+        #endif
+        )
+        & literalPosMask) << lc) + (previousByte >> (8 - lc))));
+
+      if (state >= kNumLitStates)
+      {
+        int matchByte;
+        #ifdef _LZMA_OUT_READ
+        UInt32 pos = dictionaryPos - rep0;
+        if (pos >= dictionarySize)
+          pos += dictionarySize;
+        matchByte = dictionary[pos];
+        #else
+        matchByte = outStream[nowPos - rep0];
+        #endif
+        do
+        {
+          int bit;
+          CProb *probLit;
+          matchByte <<= 1;
+          bit = (matchByte & 0x100);
+          probLit = prob + 0x100 + bit + symbol;
+          RC_GET_BIT2(probLit, symbol, if (bit != 0) break, if (bit == 0) break)
+        }
+        while (symbol < 0x100);
+      }
+      while (symbol < 0x100)
+      {
+        CProb *probLit = prob + symbol;
+        RC_GET_BIT(probLit, symbol)
+      }
+      previousByte = (Byte)symbol;
+
+      outStream[nowPos++] = previousByte;
+      #ifdef _LZMA_OUT_READ
+      dictionary[dictionaryPos] = previousByte;
+      if (++dictionaryPos == dictionarySize)
+        dictionaryPos = 0;
+      #endif
+      if (state < 4) state = 0;
+      else if (state < 10) state -= 3;
+      else state -= 6;
+    }
+    else             
+    {
+      UpdateBit1(prob);
+      prob = p + IsRep + state;
+      IfBit0(prob)
+      {
+        UpdateBit0(prob);
+        rep3 = rep2;
+        rep2 = rep1;
+        rep1 = rep0;
+        state = state < kNumLitStates ? 0 : 3;
+        prob = p + LenCoder;
+      }
+      else
+      {
+        UpdateBit1(prob);
+        prob = p + IsRepG0 + state;
+        IfBit0(prob)
+        {
+          UpdateBit0(prob);
+          prob = p + IsRep0Long + (state << kNumPosBitsMax) + posState;
+          IfBit0(prob)
+          {
+            #ifdef _LZMA_OUT_READ
+            UInt32 pos;
+            #endif
+            UpdateBit0(prob);
+            if (nowPos 
+                #ifdef _LZMA_OUT_READ
+                + globalPos
+                #endif
+                == 0)
+              return LZMA_RESULT_DATA_ERROR;
+            state = state < kNumLitStates ? 9 : 11;
+            #ifdef _LZMA_OUT_READ
+            pos = dictionaryPos - rep0;
+            if (pos >= dictionarySize)
+              pos += dictionarySize;
+            previousByte = dictionary[pos];
+            dictionary[dictionaryPos] = previousByte;
+            if (++dictionaryPos == dictionarySize)
+              dictionaryPos = 0;
+            #else
+            previousByte = outStream[nowPos - rep0];
+            #endif
+            outStream[nowPos++] = previousByte;
+            continue;
+          }
+          else
+          {
+            UpdateBit1(prob);
+          }
+        }
+        else
+        {
+          UInt32 distance;
+          UpdateBit1(prob);
+          prob = p + IsRepG1 + state;
+          IfBit0(prob)
+          {
+            UpdateBit0(prob);
+            distance = rep1;
+          }
+          else 
+          {
+            UpdateBit1(prob);
+            prob = p + IsRepG2 + state;
+            IfBit0(prob)
+            {
+              UpdateBit0(prob);
+              distance = rep2;
+            }
+            else
+            {
+              UpdateBit1(prob);
+              distance = rep3;
+              rep3 = rep2;
+            }
+            rep2 = rep1;
+          }
+          rep1 = rep0;
+          rep0 = distance;
+        }
+        state = state < kNumLitStates ? 8 : 11;
+        prob = p + RepLenCoder;
+      }
+      {
+        int numBits, offset;
+        CProb *probLen = prob + LenChoice;
+        IfBit0(probLen)
+        {
+          UpdateBit0(probLen);
+          probLen = prob + LenLow + (posState << kLenNumLowBits);
+          offset = 0;
+          numBits = kLenNumLowBits;
+        }
+        else
+        {
+          UpdateBit1(probLen);
+          probLen = prob + LenChoice2;
+          IfBit0(probLen)
+          {
+            UpdateBit0(probLen);
+            probLen = prob + LenMid + (posState << kLenNumMidBits);
+            offset = kLenNumLowSymbols;
+            numBits = kLenNumMidBits;
+          }
+          else
+          {
+            UpdateBit1(probLen);
+            probLen = prob + LenHigh;
+            offset = kLenNumLowSymbols + kLenNumMidSymbols;
+            numBits = kLenNumHighBits;
+          }
+        }
+        RangeDecoderBitTreeDecode(probLen, numBits, len);
+        len += offset;
+      }
+
+      if (state < 4)
+      {
+        int posSlot;
+        state += kNumLitStates;
+        prob = p + PosSlot +
+            ((len < kNumLenToPosStates ? len : kNumLenToPosStates - 1) << 
+            kNumPosSlotBits);
+        RangeDecoderBitTreeDecode(prob, kNumPosSlotBits, posSlot);
+        if (posSlot >= kStartPosModelIndex)
+        {
+          int numDirectBits = ((posSlot >> 1) - 1);
+          rep0 = (2 | ((UInt32)posSlot & 1));
+          if (posSlot < kEndPosModelIndex)
+          {
+            rep0 <<= numDirectBits;
+            prob = p + SpecPos + rep0 - posSlot - 1;
+          }
+          else
+          {
+            numDirectBits -= kNumAlignBits;
+            do
+            {
+              RC_NORMALIZE
+              Range >>= 1;
+              rep0 <<= 1;
+              if (Code >= Range)
+              {
+                Code -= Range;
+                rep0 |= 1;
+              }
+            }
+            while (--numDirectBits != 0);
+            prob = p + Align;
+            rep0 <<= kNumAlignBits;
+            numDirectBits = kNumAlignBits;
+          }
+          {
+            int i = 1;
+            int mi = 1;
+            do
+            {
+              CProb *prob3 = prob + mi;
+              RC_GET_BIT2(prob3, mi, ; , rep0 |= i);
+              i <<= 1;
+            }
+            while(--numDirectBits != 0);
+          }
+        }
+        else
+          rep0 = posSlot;
+        if (++rep0 == (UInt32)(0))
+        {
+          /* it's for stream version */
+          len = -1;
+          break;
+        }
+      }
+
+      len += kMatchMinLen;
+      if (rep0 > nowPos 
+        #ifdef _LZMA_OUT_READ
+        + globalPos || rep0 > dictionarySize
+        #endif
+        ) 
+        return LZMA_RESULT_DATA_ERROR;
+      do
+      {
+        #ifdef _LZMA_OUT_READ
+        UInt32 pos = dictionaryPos - rep0;
+        if (pos >= dictionarySize)
+          pos += dictionarySize;
+        previousByte = dictionary[pos];
+        dictionary[dictionaryPos] = previousByte;
+        if (++dictionaryPos == dictionarySize)
+          dictionaryPos = 0;
+        #else
+        previousByte = outStream[nowPos - rep0];
+        #endif
+        len--;
+        outStream[nowPos++] = previousByte;
+      }
+      while(len != 0 && nowPos < outSize);
+    }
+  }
+  RC_NORMALIZE;
+
+#ifdef _LZMA_OUT_READ
+  vs->Buffer = Buffer;
+  vs->BufferLim = BufferLim;
+  vs->Range = Range;
+  vs->Code = Code;
+  vs->DictionaryPos = dictionaryPos;
+  vs->GlobalPos = globalPos + nowPos;
+  vs->Reps[0] = rep0;
+  vs->Reps[1] = rep1;
+  vs->Reps[2] = rep2;
+  vs->Reps[3] = rep3;
+  vs->State = state;
+  vs->RemainLen = len;
+  vs->TempDictionary[0] = tempDictionary[0];
+#endif /* _LZMA_OUT_READ */
+
+  *outSizeProcessed = nowPos;
+  return LZMA_RESULT_OK;
+}
--- linux-2.6.12-rc6.orig/lib/lzmadecode.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.12-rc6/lib/lzmadecode.h	2005-06-07 21:33:34.000000000 +0200
@@ -0,0 +1,100 @@
+/* 
+  LzmaDecode.h
+  LZMA Decoder interface
+
+  LZMA SDK 4.16 Copyright (c) 1999-2005 Igor Pavlov (2005-03-18)
+  http://www.7-zip.org/
+
+  LZMA SDK is licensed under two licenses:
+  1) GNU Lesser General Public License (GNU LGPL)
+  2) Common Public License (CPL)
+  It means that you can select one of these two licenses and 
+  follow rules of that license.
+
+  SPECIAL EXCEPTION:
+  Igor Pavlov, as the author of this code, expressly permits you to 
+  statically or dynamically link your code (or bind by name) to the 
+  interfaces of this file without subjecting your linked code to the 
+  terms of the CPL or GNU LGPL. Any modifications or additions 
+  to this file, however, are subject to the LGPL or CPL terms.
+*/
+
+#ifndef __LZMADECODE_H
+#define __LZMADECODE_H
+
+/* #define _LZMA_IN_CB */
+/* Use callback for input data */
+
+/* #define _LZMA_OUT_READ */
+/* Use read function for output data */
+
+#define _LZMA_PROB32
+/* It can increase speed on some 32-bit CPUs, 
+   but memory usage will be doubled in that case */
+
+#define _LZMA_LOC_OPT 
+/* Enable local speed optimizations inside code */
+
+#ifndef UInt32
+#ifdef _LZMA_UINT32_IS_ULONG
+#define UInt32 unsigned long
+#else
+#define UInt32 unsigned int
+#endif
+#endif
+
+#ifdef _LZMA_PROB32
+#define CProb UInt32
+#else
+#define CProb unsigned short
+#endif
+
+#define LZMA_RESULT_OK 0
+#define LZMA_RESULT_DATA_ERROR 1
+#define LZMA_RESULT_NOT_ENOUGH_MEM 2
+
+#ifdef _LZMA_IN_CB
+typedef struct _ILzmaInCallback
+{
+  int (*Read)(void *object, unsigned char **buffer, UInt32 *bufferSize);
+} ILzmaInCallback;
+#endif
+
+#define LZMA_BASE_SIZE 1846
+#define LZMA_LIT_SIZE 768
+
+/* 
+bufferSize = (LZMA_BASE_SIZE + (LZMA_LIT_SIZE << (lc + lp)))* sizeof(CProb)
+bufferSize += 100 in case of _LZMA_OUT_READ
+by default CProb is unsigned short, 
+but if specify _LZMA_PROB_32, CProb will be UInt32(unsigned int)
+*/
+
+#ifdef _LZMA_OUT_READ
+int LzmaDecoderInit(
+    unsigned char *buffer, UInt32 bufferSize,
+    int lc, int lp, int pb,
+    unsigned char *dictionary, UInt32 dictionarySize,
+  #ifdef _LZMA_IN_CB
+    ILzmaInCallback *inCallback
+  #else
+    unsigned char *inStream, UInt32 inSize
+  #endif
+);
+#endif
+
+int LzmaDecode(
+    unsigned char *buffer, 
+  #ifndef _LZMA_OUT_READ
+    UInt32 bufferSize,
+    int lc, int lp, int pb,
+  #ifdef _LZMA_IN_CB
+    ILzmaInCallback *inCallback,
+  #else
+    unsigned char *inStream, UInt32 inSize,
+  #endif
+  #endif
+    unsigned char *outStream, UInt32 outSize,
+    UInt32 *outSizeProcessed);
+
+#endif



