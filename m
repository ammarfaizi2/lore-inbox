Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751449AbWCZDBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbWCZDBV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 22:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbWCZDBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 22:01:21 -0500
Received: from thunk.org ([69.25.196.29]:50584 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751449AbWCZDBV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 22:01:21 -0500
Date: Sat, 25 Mar 2006 22:01:15 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Takashi Sato <sho@bsd.tnes.nec.co.jp>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] [PATCH 1/2] ext2/3: Support 2^32-1 blocks(Kernel)
Message-ID: <20060326030114.GA2241@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Takashi Sato <sho@bsd.tnes.nec.co.jp>, linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net
References: <000301c6482d$7e5b5200$4168010a@bsd.tnes.nec.co.jp> <20060319022002.GA19607@thunk.org> <06f301c64c06$b820f440$4168010a@bsd.tnes.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06f301c64c06$b820f440$4168010a@bsd.tnes.nec.co.jp>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2006 at 07:11:51PM +0900, Takashi Sato wrote:
> >I've just checked my i386 assembly language reference, and I don't see
> >any indication that the btsl, btrl, and btl instructions don't work if
> >the high bit is set on the bit number.  Have you done tests showing
> >that these instructions do not work correctly for filesystem sizes >
> >2**31 blocks, 
> 
> Of course I did and confirmed to get the segmentation fault
> at those instructions.

Thanks for the clarification.  FYI, this is what I checked into the
e2fsprogs mercurial repository.  Note the comments about potential
issues with using a filesystem just under 2**32 blocks on a 32-bit
system.  

						- Ted

# HG changeset patch
# User tytso@mit.edu
# Node ID de831ae49d51575d0f59f4ee2e198fa4d6a75c23
# Parent  dd0dd259cf22059412ae4e6f3e7a9e8756d02b1e
Fix the i386 bitmap operations so they are 32-bit clean

The x86 assembly instructures for bit test-and-set, test-and-clear,
etc., interpret the bit number as a 32-bit signed number, which is
problematic in order to support filesystems > 8TB.  

Added new inline functions (in C) to implement a
ext2fs_fast_set/clear_bit() that does not return the old value of the
bit, and use it for the fast block/bitmap functions.

Added a regression test suite to test the low-level bit operations
functions to make sure they work correctly.

Note that a bitmap can address 2**32 blocks requires 2**29 bytes, or
512 megabytes.  E2fsck requires 3 (and possibly 4 block bitmaps),
which means that the block bitmaps can require 2GB all by themselves,
and this doesn't include the 4 or 5 inode bitmaps (which assuming an
8k inode ratio, will take 256 megabytes each).  This means that it's
more likely that a filesystem check of a filesystem greater than 2**31
blocks will fail if the e2fsck is dynamically linked (since the shared
libraries can consume a substantial portion of the 3GB address space
available to x86 userspace applications).  Even if e2fsck is
statically linked, for a badly damaged filesystem, which may require
additional block and/or inode bitmaps, I am not sure e2fsck will
succeed in all cases.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>

diff -r dd0dd259cf22 -r de831ae49d51 lib/ext2fs/ChangeLog
--- a/lib/ext2fs/ChangeLog	Sat Mar 25 01:42:02 2006 -0500
+++ b/lib/ext2fs/ChangeLog	Sat Mar 25 13:42:45 2006 -0500
@@ -1,3 +1,16 @@
+2006-03-25  Theodore Ts'o  <tytso@mit.edu>
+
+	* Makefile.in: Check the bitfield operations much more carefully,
+		and arrange to have tst_bitops run from "make check"
+
+	* tst_bitops.c: Enahce tst_bitops program so that it is much more
+		thorough in testing bit optations.
+	
+	* bitops.h: Add new functions ext2fs_fast_set_bit() and
+		ext2fs_fast_clear_bit() and make the x86 functions 32-bit
+		clear.  Change the fast inode and block mark/unmark
+		functions to use ext2fs_fast_set/get_bit()
+
 2006-03-18  Theodore Ts'o  <tytso@mit.edu>
 
 	* ext2fs.h (EXT2_FLAG_EXCLUSIVE): Define new flag which requests
diff -r dd0dd259cf22 -r de831ae49d51 lib/ext2fs/Makefile.in
--- a/lib/ext2fs/Makefile.in	Sat Mar 25 01:42:02 2006 -0500
+++ b/lib/ext2fs/Makefile.in	Sat Mar 25 13:42:45 2006 -0500
@@ -212,7 +212,7 @@
 
 tst_bitops: tst_bitops.o inline.o $(STATIC_LIBEXT2FS)
 	@echo "	LD $@"
-	@$(CC) -o tst_bitops tst_bitops.o inline.o \
+	@$(CC) -o tst_bitops tst_bitops.o inline.o $(ALL_CFLAGS) \
 		$(STATIC_LIBEXT2FS) $(LIBCOM_ERR)
 
 tst_getsectsize: tst_getsectsize.o getsectsize.o $(STATIC_LIBEXT2FS)
@@ -224,7 +224,8 @@
 	@echo "	LD $@"
 	@$(CC) -o mkjournal $(srcdir)/mkjournal.c -DDEBUG $(STATIC_LIBEXT2FS) $(LIBCOM_ERR) $(ALL_CFLAGS)
 
-check:: tst_badblocks tst_iscan @SWAPFS_CMT@ tst_byteswap
+check:: tst_bitops tst_badblocks tst_iscan @SWAPFS_CMT@ tst_byteswap
+	LD_LIBRARY_PATH=$(LIB) DYLD_LIBRARY_PATH=$(LIB) ./tst_bitops
 	LD_LIBRARY_PATH=$(LIB) DYLD_LIBRARY_PATH=$(LIB) ./tst_badblocks
 	LD_LIBRARY_PATH=$(LIB) DYLD_LIBRARY_PATH=$(LIB) ./tst_iscan
 @SWAPFS_CMT@	LD_LIBRARY_PATH=$(LIB) DYLD_LIBRARY_PATH=$(LIB) ./tst_byteswap
diff -r dd0dd259cf22 -r de831ae49d51 lib/ext2fs/bitops.h
--- a/lib/ext2fs/bitops.h	Sat Mar 25 01:42:02 2006 -0500
+++ b/lib/ext2fs/bitops.h	Sat Mar 25 13:42:45 2006 -0500
@@ -17,6 +17,8 @@
 extern int ext2fs_set_bit(unsigned int nr,void * addr);
 extern int ext2fs_clear_bit(unsigned int nr, void * addr);
 extern int ext2fs_test_bit(unsigned int nr, const void * addr);
+extern void ext2fs_fast_set_bit(unsigned int nr,void * addr);
+extern void ext2fs_fast_clear_bit(unsigned int nr, void * addr);
 extern __u16 ext2fs_swab16(__u16 val);
 extern __u32 ext2fs_swab32(__u32 val);
 
@@ -129,6 +131,28 @@
 #endif
 #endif
 
+/*
+ * Fast bit set/clear functions that doesn't need to return the
+ * previous bit value.
+ */
+
+_INLINE_ void ext2fs_fast_set_bit(unsigned int nr,void * addr)
+{
+	unsigned char	*ADDR = (unsigned char *) addr;
+
+	ADDR += nr >> 3;
+	*ADDR |= (1 << (nr & 0x07));
+}
+
+_INLINE_ void ext2fs_fast_clear_bit(unsigned int nr, void * addr)
+{
+	unsigned char	*ADDR = (unsigned char *) addr;
+
+	ADDR += nr >> 3;
+	*ADDR &= ~(1 << (nr & 0x07));
+}
+
+
 #if ((defined __GNUC__) && !defined(_EXT2_USE_C_VERSIONS_) && \
      (defined(__i386__) || defined(__i486__) || defined(__i586__)))
 
@@ -155,9 +179,10 @@
 {
 	int oldbit;
 
+	addr = (void *) (((unsigned char *) addr) + (nr >> 3));
 	__asm__ __volatile__("btsl %2,%1\n\tsbbl %0,%0"
 		:"=r" (oldbit),"=m" (EXT2FS_ADDR)
-		:"r" (nr));
+		:"r" (nr & 7));
 	return oldbit;
 }
 
@@ -165,9 +190,10 @@
 {
 	int oldbit;
 
+	addr = (void *) (((unsigned char *) addr) + (nr >> 3));
 	__asm__ __volatile__("btrl %2,%1\n\tsbbl %0,%0"
 		:"=r" (oldbit),"=m" (EXT2FS_ADDR)
-		:"r" (nr));
+		:"r" (nr & 7));
 	return oldbit;
 }
 
@@ -175,9 +201,10 @@
 {
 	int oldbit;
 
+	addr = (void *) (((unsigned char *) addr) + (nr >> 3));
 	__asm__ __volatile__("btl %2,%1\n\tsbbl %0,%0"
 		:"=r" (oldbit)
-		:"m" (EXT2FS_CONST_ADDR),"r" (nr));
+		:"m" (EXT2FS_CONST_ADDR),"r" (nr & 7));
 	return oldbit;
 }
 
@@ -263,7 +290,8 @@
 
 #endif	/* i386 */
 
-#ifdef __mc68000__
+#if ((defined __GNUC__) && !defined(_EXT2_USE_C_VERSIONS_) && \
+     (defined(__mc68000__)))
 
 #define _EXT2_HAVE_ASM_BITOPS_
 
@@ -428,7 +456,7 @@
 		return;
 	}
 #endif	
-	ext2fs_set_bit(block - bitmap->start, bitmap->bitmap);
+	ext2fs_fast_set_bit(block - bitmap->start, bitmap->bitmap);
 }
 
 _INLINE_ void ext2fs_fast_unmark_block_bitmap(ext2fs_block_bitmap bitmap,
@@ -441,7 +469,7 @@
 		return;
 	}
 #endif
-	ext2fs_clear_bit(block - bitmap->start, bitmap->bitmap);
+	ext2fs_fast_clear_bit(block - bitmap->start, bitmap->bitmap);
 }
 
 _INLINE_ int ext2fs_fast_test_block_bitmap(ext2fs_block_bitmap bitmap,
@@ -467,7 +495,7 @@
 		return;
 	}
 #endif
-	ext2fs_set_bit(inode - bitmap->start, bitmap->bitmap);
+	ext2fs_fast_set_bit(inode - bitmap->start, bitmap->bitmap);
 }
 
 _INLINE_ void ext2fs_fast_unmark_inode_bitmap(ext2fs_inode_bitmap bitmap,
@@ -480,7 +508,7 @@
 		return;
 	}
 #endif
-	ext2fs_clear_bit(inode - bitmap->start, bitmap->bitmap);
+	ext2fs_fast_clear_bit(inode - bitmap->start, bitmap->bitmap);
 }
 
 _INLINE_ int ext2fs_fast_test_inode_bitmap(ext2fs_inode_bitmap bitmap,
@@ -563,7 +591,7 @@
 		return;
 	}
 	for (i=0; i < num; i++)
-		ext2fs_set_bit(block + i - bitmap->start, bitmap->bitmap);
+		ext2fs_fast_set_bit(block + i - bitmap->start, bitmap->bitmap);
 }
 
 _INLINE_ void ext2fs_fast_mark_block_bitmap_range(ext2fs_block_bitmap bitmap,
@@ -579,7 +607,7 @@
 	}
 #endif	
 	for (i=0; i < num; i++)
-		ext2fs_set_bit(block + i - bitmap->start, bitmap->bitmap);
+		ext2fs_fast_set_bit(block + i - bitmap->start, bitmap->bitmap);
 }
 
 _INLINE_ void ext2fs_unmark_block_bitmap_range(ext2fs_block_bitmap bitmap,
@@ -593,7 +621,8 @@
 		return;
 	}
 	for (i=0; i < num; i++)
-		ext2fs_clear_bit(block + i - bitmap->start, bitmap->bitmap);
+		ext2fs_fast_clear_bit(block + i - bitmap->start, 
+				      bitmap->bitmap);
 }
 
 _INLINE_ void ext2fs_fast_unmark_block_bitmap_range(ext2fs_block_bitmap bitmap,
@@ -609,7 +638,8 @@
 	}
 #endif	
 	for (i=0; i < num; i++)
-		ext2fs_clear_bit(block + i - bitmap->start, bitmap->bitmap);
+		ext2fs_fast_clear_bit(block + i - bitmap->start, 
+				      bitmap->bitmap);
 }
 #undef _INLINE_
 #endif
diff -r dd0dd259cf22 -r de831ae49d51 lib/ext2fs/tst_bitops.c
--- a/lib/ext2fs/tst_bitops.c	Sat Mar 25 01:42:02 2006 -0500
+++ b/lib/ext2fs/tst_bitops.c	Sat Mar 25 13:42:45 2006 -0500
@@ -8,8 +8,6 @@
  * License.
  * %End-Header%
  */
-
-/* #define _EXT2_USE_C_VERSIONS_ */
 
 #include <stdio.h>
 #include <string.h>
@@ -23,6 +21,8 @@
 #if HAVE_ERRNO_H
 #include <errno.h>
 #endif
+#include <sys/time.h>
+#include <sys/resource.h>
 
 #include "ext2_fs.h"
 #include "ext2fs.h"
@@ -31,14 +31,143 @@
 	0x80, 0xF0, 0x40, 0x40, 0x0, 0x0, 0x0, 0x0, 0x10, 0x20, 0x00, 0x00
 	};
 
+int bits_list[] = {
+	7, 12, 13, 14,15, 22, 30, 68, 77, -1,
+};
+
+#define BIG_TEST_BIT   (((unsigned) 1 << 31) + 42)
+
+
 main(int argc, char **argv)
 {
-	int	i, size;
+	int	i, j, size;
+	unsigned char testarray[12];
+	unsigned char *bigarray;
 
 	size = sizeof(bitarray)*8;
+#if 0
 	i = ext2fs_find_first_bit_set(bitarray, size);
 	while (i < size) {
 		printf("Bit set: %d\n", i);
 		i = ext2fs_find_next_bit_set(bitarray, size, i+1);
 	}
+#endif
+
+	/* Test test_bit */
+	for (i=0,j=0; i < size; i++) {
+		if (ext2fs_test_bit(i, bitarray)) {
+			if (bits_list[j] == i) {
+				j++;
+			} else {
+				printf("Bit %d set, not expected\n", i);
+				exit(1);
+			}
+		} else {
+			if (bits_list[j] == i) {
+				printf("Expected bit %d to be clear.\n", i);
+				exit(1);
+			}
+		}
+	}
+	printf("ext2fs_test_bit appears to be correct\n");
+
+	/* Test ext2fs_set_bit */
+	memset(testarray, 0, sizeof(testarray));
+	for (i=0; bits_list[i] > 0; i++) {
+		ext2fs_set_bit(bits_list[i], testarray);
+	}
+	if (memcmp(testarray, bitarray, sizeof(testarray)) == 0) {
+		printf("ext2fs_set_bit test succeeded.\n");
+	} else {
+		printf("ext2fs_set_bit test failed.\n");
+		for (i=0; i < sizeof(testarray); i++) {
+			printf("%02x ", testarray[i]);
+		}
+		printf("\n");
+		exit(1);
+	}
+	for (i=0; bits_list[i] > 0; i++) {
+		ext2fs_clear_bit(bits_list[i], testarray);
+	}
+	for (i=0; i < sizeof(testarray); i++) {
+		if (testarray[i]) {
+			printf("ext2fs_clear_bit failed, "
+			       "testarray[%d] is %d\n", i, testarray[i]);
+			exit(1);
+		}
+	}
+	printf("ext2fs_clear_bit test succeed.\n");
+		
+
+	/* Do bigarray test */
+	bigarray = malloc(1 << 29);
+	if (!bigarray) {
+		fprintf(stderr, "Failed to allocate scratch memory!\n");
+		exit(1);
+	}
+
+        bigarray[BIG_TEST_BIT >> 3] = 0;
+
+	ext2fs_set_bit(BIG_TEST_BIT, bigarray);
+	printf("big bit number (%u) test: %d, expected %d\n", BIG_TEST_BIT,
+	       bigarray[BIG_TEST_BIT >> 3], (1 << (BIG_TEST_BIT & 7)));
+	if (bigarray[BIG_TEST_BIT >> 3] != (1 << (BIG_TEST_BIT & 7)))
+		exit(1);
+
+	ext2fs_clear_bit(BIG_TEST_BIT, bigarray);
+	
+	printf("big bit number (%u) test: %d, expected 0\n", BIG_TEST_BIT,
+	       bigarray[BIG_TEST_BIT >> 3], 0);
+	if (bigarray[BIG_TEST_BIT >> 3] != 0)
+		exit(1);
+
+	printf("ext2fs_set_bit big_test successful\n");
+
+
+	/* Now test ext2fs_fast_set_bit */
+	memset(testarray, 0, sizeof(testarray));
+	for (i=0; bits_list[i] > 0; i++) {
+		ext2fs_fast_set_bit(bits_list[i], testarray);
+	}
+	if (memcmp(testarray, bitarray, sizeof(testarray)) == 0) {
+		printf("ext2fs_fast_set_bit test succeeded.\n");
+	} else {
+		printf("ext2fs_fast_set_bit test failed.\n");
+		for (i=0; i < sizeof(testarray); i++) {
+			printf("%02x ", testarray[i]);
+		}
+		printf("\n");
+		exit(1);
+	}
+	for (i=0; bits_list[i] > 0; i++) {
+		ext2fs_clear_bit(bits_list[i], testarray);
+	}
+	for (i=0; i < sizeof(testarray); i++) {
+		if (testarray[i]) {
+			printf("ext2fs_clear_bit failed, "
+			       "testarray[%d] is %d\n", i, testarray[i]);
+			exit(1);
+		}
+	}
+	printf("ext2fs_clear_bit test succeed.\n");
+		
+
+        bigarray[BIG_TEST_BIT >> 3] = 0;
+
+	ext2fs_fast_set_bit(BIG_TEST_BIT, bigarray);
+	printf("big bit number (%u) test: %d, expected %d\n", BIG_TEST_BIT,
+	       bigarray[BIG_TEST_BIT >> 3], (1 << (BIG_TEST_BIT & 7)));
+	if (bigarray[BIG_TEST_BIT >> 3] != (1 << (BIG_TEST_BIT & 7)))
+		exit(1);
+
+	ext2fs_fast_clear_bit(BIG_TEST_BIT, bigarray);
+	
+	printf("big bit number (%u) test: %d, expected 0\n", BIG_TEST_BIT,
+	       bigarray[BIG_TEST_BIT >> 3], 0);
+	if (bigarray[BIG_TEST_BIT >> 3] != 0)
+		exit(1);
+
+	printf("ext2fs_fast_set_bit big_test successful\n");
+
+	exit(0);
 }
