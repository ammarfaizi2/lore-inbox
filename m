Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbWAYLac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWAYLac (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 06:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWAYLac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 06:30:32 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:22170 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1751132AbWAYLa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 06:30:29 -0500
Date: Wed, 25 Jan 2006 20:30:33 +0900
To: linux-kernel@vger.kernel.org
Cc: Richard Henderson <rth@twiddle.net>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Russell King <rmk@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>,
       dev-etrax@axis.com, David Howells <dhowells@redhat.com>,
       Yoshinori Sato <ysato@users.sourceforge.jp>,
       Linus Torvalds <torvalds@osdl.org>, linux-ia64@vger.kernel.org,
       Hirokazu Takata <takata@linux-m32r.org>, linux-m68k@vger.kernel.org,
       Greg Ungerer <gerg@uclinux.org>, linux-mips@linux-mips.org,
       parisc-linux@parisc-linux.org, linuxppc-dev@ozlabs.org,
       linux390@de.ibm.com, linuxsh-dev@lists.sourceforge.net,
       linuxsh-shmedia-dev@lists.sourceforge.net, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, Miles Bader <uclinux-v850@lsi.nec.co.jp>,
       Andi Kleen <ak@suse.de>, Chris Zankel <chris@zankel.net>
Subject: [PATCH 2/6] use non atomic operations for minix_*_bit() and ext2_*_bit()
Message-ID: <20060125113033.GC18584@miraclelinux.com>
References: <20060125112625.GA18584@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060125112625.GA18584@miraclelinux.com>
User-Agent: Mutt/1.5.9i
From: mita@miraclelinux.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bitmap functions for the minix filesystem and the ext2 filesystem do not
require the atomic guarantees except ext2_set_bit_atomic() and
ext2_clear_bit_atomic().

But they are defined by using atomic bit operations on several architectures.
(h8300, ia64, mips, s390, sh, sh64, sparc, v850, and xtensa)
This patch switches to non atomic bit operation.

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
---
 asm-h8300/bitops.h   |    6 +++---
 asm-ia64/bitops.h    |   10 +++++-----
 asm-mips/bitops.h    |    6 +++---
 asm-s390/bitops.h    |   10 +++++-----
 asm-sh/bitops.h      |   16 +++++-----------
 asm-sh64/bitops.h    |   16 +++++-----------
 asm-sparc/bitops.h   |    6 +++---
 asm-sparc64/bitops.h |    6 +++---
 asm-v850/bitops.h    |   10 +++++-----
 asm-xtensa/bitops.h  |    6 +++---
 10 files changed, 40 insertions(+), 52 deletions(-)

Index: 2.6-git/include/asm-h8300/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-h8300/bitops.h	2006-01-25 19:07:14.000000000 +0900
+++ 2.6-git/include/asm-h8300/bitops.h	2006-01-25 19:14:01.000000000 +0900
@@ -397,9 +397,9 @@
 }
 
 /* Bitmap functions for the minix filesystem.  */
-#define minix_test_and_set_bit(nr,addr) test_and_set_bit(nr,addr)
-#define minix_set_bit(nr,addr) set_bit(nr,addr)
-#define minix_test_and_clear_bit(nr,addr) test_and_clear_bit(nr,addr)
+#define minix_test_and_set_bit(nr,addr) __test_and_set_bit(nr,addr)
+#define minix_set_bit(nr,addr) __set_bit(nr,addr)
+#define minix_test_and_clear_bit(nr,addr) __test_and_clear_bit(nr,addr)
 #define minix_test_bit(nr,addr) test_bit(nr,addr)
 #define minix_find_first_zero_bit(addr,size) find_first_zero_bit(addr,size)
 
Index: 2.6-git/include/asm-ia64/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-ia64/bitops.h	2006-01-25 19:07:14.000000000 +0900
+++ 2.6-git/include/asm-ia64/bitops.h	2006-01-25 19:14:02.000000000 +0900
@@ -394,18 +394,18 @@
 
 #define __clear_bit(nr, addr)		clear_bit(nr, addr)
 
-#define ext2_set_bit			test_and_set_bit
+#define ext2_set_bit			__test_and_set_bit
 #define ext2_set_bit_atomic(l,n,a)	test_and_set_bit(n,a)
-#define ext2_clear_bit			test_and_clear_bit
+#define ext2_clear_bit			__test_and_clear_bit
 #define ext2_clear_bit_atomic(l,n,a)	test_and_clear_bit(n,a)
 #define ext2_test_bit			test_bit
 #define ext2_find_first_zero_bit	find_first_zero_bit
 #define ext2_find_next_zero_bit		find_next_zero_bit
 
 /* Bitmap functions for the minix filesystem.  */
-#define minix_test_and_set_bit(nr,addr)		test_and_set_bit(nr,addr)
-#define minix_set_bit(nr,addr)			set_bit(nr,addr)
-#define minix_test_and_clear_bit(nr,addr)	test_and_clear_bit(nr,addr)
+#define minix_test_and_set_bit(nr,addr)		__test_and_set_bit(nr,addr)
+#define minix_set_bit(nr,addr)			__set_bit(nr,addr)
+#define minix_test_and_clear_bit(nr,addr)	__test_and_clear_bit(nr,addr)
 #define minix_test_bit(nr,addr)			test_bit(nr,addr)
 #define minix_find_first_zero_bit(addr,size)	find_first_zero_bit(addr,size)
 
Index: 2.6-git/include/asm-mips/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-mips/bitops.h	2006-01-25 19:07:14.000000000 +0900
+++ 2.6-git/include/asm-mips/bitops.h	2006-01-25 19:14:05.000000000 +0900
@@ -956,9 +956,9 @@
  * FIXME: These assume that Minix uses the native byte/bitorder.
  * This limits the Minix filesystem's value for data exchange very much.
  */
-#define minix_test_and_set_bit(nr,addr) test_and_set_bit(nr,addr)
-#define minix_set_bit(nr,addr) set_bit(nr,addr)
-#define minix_test_and_clear_bit(nr,addr) test_and_clear_bit(nr,addr)
+#define minix_test_and_set_bit(nr,addr) __test_and_set_bit(nr,addr)
+#define minix_set_bit(nr,addr) __set_bit(nr,addr)
+#define minix_test_and_clear_bit(nr,addr) __test_and_clear_bit(nr,addr)
 #define minix_test_bit(nr,addr) test_bit(nr,addr)
 #define minix_find_first_zero_bit(addr,size) find_first_zero_bit(addr,size)
 
Index: 2.6-git/include/asm-s390/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-s390/bitops.h	2006-01-25 19:07:14.000000000 +0900
+++ 2.6-git/include/asm-s390/bitops.h	2006-01-25 19:14:05.000000000 +0900
@@ -871,11 +871,11 @@
  */
 
 #define ext2_set_bit(nr, addr)       \
-	test_and_set_bit((nr)^(__BITOPS_WORDSIZE - 8), (unsigned long *)addr)
+	__test_and_set_bit((nr)^(__BITOPS_WORDSIZE - 8), (unsigned long *)addr)
 #define ext2_set_bit_atomic(lock, nr, addr)       \
 	test_and_set_bit((nr)^(__BITOPS_WORDSIZE - 8), (unsigned long *)addr)
 #define ext2_clear_bit(nr, addr)     \
-	test_and_clear_bit((nr)^(__BITOPS_WORDSIZE - 8), (unsigned long *)addr)
+	__test_and_clear_bit((nr)^(__BITOPS_WORDSIZE - 8), (unsigned long *)addr)
 #define ext2_clear_bit_atomic(lock, nr, addr)     \
 	test_and_clear_bit((nr)^(__BITOPS_WORDSIZE - 8), (unsigned long *)addr)
 #define ext2_test_bit(nr, addr)      \
@@ -1014,11 +1014,11 @@
 /* Bitmap functions for the minix filesystem.  */
 /* FIXME !!! */
 #define minix_test_and_set_bit(nr,addr) \
-	test_and_set_bit(nr,(unsigned long *)addr)
+	__test_and_set_bit(nr,(unsigned long *)addr)
 #define minix_set_bit(nr,addr) \
-	set_bit(nr,(unsigned long *)addr)
+	__set_bit(nr,(unsigned long *)addr)
 #define minix_test_and_clear_bit(nr,addr) \
-	test_and_clear_bit(nr,(unsigned long *)addr)
+	__test_and_clear_bit(nr,(unsigned long *)addr)
 #define minix_test_bit(nr,addr) \
 	test_bit(nr,(unsigned long *)addr)
 #define minix_find_first_zero_bit(addr,size) \
Index: 2.6-git/include/asm-sh/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-sh/bitops.h	2006-01-25 19:07:14.000000000 +0900
+++ 2.6-git/include/asm-sh/bitops.h	2006-01-25 19:14:06.000000000 +0900
@@ -339,8 +339,8 @@
 }
 
 #ifdef __LITTLE_ENDIAN__
-#define ext2_set_bit(nr, addr) test_and_set_bit((nr), (addr))
-#define ext2_clear_bit(nr, addr) test_and_clear_bit((nr), (addr))
+#define ext2_set_bit(nr, addr) __test_and_set_bit((nr), (addr))
+#define ext2_clear_bit(nr, addr) __test_and_clear_bit((nr), (addr))
 #define ext2_test_bit(nr, addr) test_bit((nr), (addr))
 #define ext2_find_first_zero_bit(addr, size) find_first_zero_bit((addr), (size))
 #define ext2_find_next_zero_bit(addr, size, offset) \
@@ -349,30 +349,24 @@
 static __inline__ int ext2_set_bit(int nr, volatile void * addr)
 {
 	int		mask, retval;
-	unsigned long	flags;
 	volatile unsigned char	*ADDR = (unsigned char *) addr;
 
 	ADDR += nr >> 3;
 	mask = 1 << (nr & 0x07);
-	local_irq_save(flags);
 	retval = (mask & *ADDR) != 0;
 	*ADDR |= mask;
-	local_irq_restore(flags);
 	return retval;
 }
 
 static __inline__ int ext2_clear_bit(int nr, volatile void * addr)
 {
 	int		mask, retval;
-	unsigned long	flags;
 	volatile unsigned char	*ADDR = (unsigned char *) addr;
 
 	ADDR += nr >> 3;
 	mask = 1 << (nr & 0x07);
-	local_irq_save(flags);
 	retval = (mask & *ADDR) != 0;
 	*ADDR &= ~mask;
-	local_irq_restore(flags);
 	return retval;
 }
 
@@ -459,9 +453,9 @@
 	})
 
 /* Bitmap functions for the minix filesystem.  */
-#define minix_test_and_set_bit(nr,addr) test_and_set_bit(nr,addr)
-#define minix_set_bit(nr,addr) set_bit(nr,addr)
-#define minix_test_and_clear_bit(nr,addr) test_and_clear_bit(nr,addr)
+#define minix_test_and_set_bit(nr,addr) __test_and_set_bit(nr,addr)
+#define minix_set_bit(nr,addr) __set_bit(nr,addr)
+#define minix_test_and_clear_bit(nr,addr) __test_and_clear_bit(nr,addr)
 #define minix_test_bit(nr,addr) test_bit(nr,addr)
 #define minix_find_first_zero_bit(addr,size) find_first_zero_bit(addr,size)
 
Index: 2.6-git/include/asm-sh64/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-sh64/bitops.h	2006-01-25 19:07:14.000000000 +0900
+++ 2.6-git/include/asm-sh64/bitops.h	2006-01-25 19:14:07.000000000 +0900
@@ -382,8 +382,8 @@
 #define hweight8(x) generic_hweight8(x)
 
 #ifdef __LITTLE_ENDIAN__
-#define ext2_set_bit(nr, addr) test_and_set_bit((nr), (addr))
-#define ext2_clear_bit(nr, addr) test_and_clear_bit((nr), (addr))
+#define ext2_set_bit(nr, addr) __test_and_set_bit((nr), (addr))
+#define ext2_clear_bit(nr, addr) __test_and_clear_bit((nr), (addr))
 #define ext2_test_bit(nr, addr) test_bit((nr), (addr))
 #define ext2_find_first_zero_bit(addr, size) find_first_zero_bit((addr), (size))
 #define ext2_find_next_zero_bit(addr, size, offset) \
@@ -392,30 +392,24 @@
 static __inline__ int ext2_set_bit(int nr, volatile void * addr)
 {
 	int		mask, retval;
-	unsigned long	flags;
 	volatile unsigned char	*ADDR = (unsigned char *) addr;
 
 	ADDR += nr >> 3;
 	mask = 1 << (nr & 0x07);
-	local_irq_save(flags);
 	retval = (mask & *ADDR) != 0;
 	*ADDR |= mask;
-	local_irq_restore(flags);
 	return retval;
 }
 
 static __inline__ int ext2_clear_bit(int nr, volatile void * addr)
 {
 	int		mask, retval;
-	unsigned long	flags;
 	volatile unsigned char	*ADDR = (unsigned char *) addr;
 
 	ADDR += nr >> 3;
 	mask = 1 << (nr & 0x07);
-	local_irq_save(flags);
 	retval = (mask & *ADDR) != 0;
 	*ADDR &= ~mask;
-	local_irq_restore(flags);
 	return retval;
 }
 
@@ -502,9 +496,9 @@
 	})
 
 /* Bitmap functions for the minix filesystem.  */
-#define minix_test_and_set_bit(nr,addr) test_and_set_bit(nr,addr)
-#define minix_set_bit(nr,addr) set_bit(nr,addr)
-#define minix_test_and_clear_bit(nr,addr) test_and_clear_bit(nr,addr)
+#define minix_test_and_set_bit(nr,addr) __test_and_set_bit(nr,addr)
+#define minix_set_bit(nr,addr) __set_bit(nr,addr)
+#define minix_test_and_clear_bit(nr,addr) __test_and_clear_bit(nr,addr)
 #define minix_test_bit(nr,addr) test_bit(nr,addr)
 #define minix_find_first_zero_bit(addr,size) find_first_zero_bit(addr,size)
 
Index: 2.6-git/include/asm-sparc/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-sparc/bitops.h	2006-01-25 19:07:14.000000000 +0900
+++ 2.6-git/include/asm-sparc/bitops.h	2006-01-25 19:14:08.000000000 +0900
@@ -523,11 +523,11 @@
 
 /* Bitmap functions for the minix filesystem.  */
 #define minix_test_and_set_bit(nr,addr)	\
-	test_and_set_bit((nr),(unsigned long *)(addr))
+	__test_and_set_bit((nr),(unsigned long *)(addr))
 #define minix_set_bit(nr,addr)		\
-	set_bit((nr),(unsigned long *)(addr))
+	__set_bit((nr),(unsigned long *)(addr))
 #define minix_test_and_clear_bit(nr,addr) \
-	test_and_clear_bit((nr),(unsigned long *)(addr))
+	__test_and_clear_bit((nr),(unsigned long *)(addr))
 #define minix_test_bit(nr,addr)		\
 	test_bit((nr),(unsigned long *)(addr))
 #define minix_find_first_zero_bit(addr,size) \
Index: 2.6-git/include/asm-sparc64/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-sparc64/bitops.h	2006-01-25 19:07:14.000000000 +0900
+++ 2.6-git/include/asm-sparc64/bitops.h	2006-01-25 19:14:08.000000000 +0900
@@ -280,11 +280,11 @@
 
 /* Bitmap functions for the minix filesystem.  */
 #define minix_test_and_set_bit(nr,addr)	\
-	test_and_set_bit((nr),(unsigned long *)(addr))
+	__test_and_set_bit((nr),(unsigned long *)(addr))
 #define minix_set_bit(nr,addr)	\
-	set_bit((nr),(unsigned long *)(addr))
+	__set_bit((nr),(unsigned long *)(addr))
 #define minix_test_and_clear_bit(nr,addr) \
-	test_and_clear_bit((nr),(unsigned long *)(addr))
+	__test_and_clear_bit((nr),(unsigned long *)(addr))
 #define minix_test_bit(nr,addr)	\
 	test_bit((nr),(unsigned long *)(addr))
 #define minix_find_first_zero_bit(addr,size) \
Index: 2.6-git/include/asm-v850/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-v850/bitops.h	2006-01-25 19:07:14.000000000 +0900
+++ 2.6-git/include/asm-v850/bitops.h	2006-01-25 19:14:08.000000000 +0900
@@ -336,18 +336,18 @@
 #define hweight16(x) 			generic_hweight16 (x)
 #define hweight8(x) 			generic_hweight8 (x)
 
-#define ext2_set_bit			test_and_set_bit
+#define ext2_set_bit			__test_and_set_bit
 #define ext2_set_bit_atomic(l,n,a)      test_and_set_bit(n,a)
-#define ext2_clear_bit			test_and_clear_bit
+#define ext2_clear_bit			__test_and_clear_bit
 #define ext2_clear_bit_atomic(l,n,a)    test_and_clear_bit(n,a)
 #define ext2_test_bit			test_bit
 #define ext2_find_first_zero_bit	find_first_zero_bit
 #define ext2_find_next_zero_bit		find_next_zero_bit
 
 /* Bitmap functions for the minix filesystem.  */
-#define minix_test_and_set_bit		test_and_set_bit
-#define minix_set_bit			set_bit
-#define minix_test_and_clear_bit	test_and_clear_bit
+#define minix_test_and_set_bit		__test_and_set_bit
+#define minix_set_bit			__set_bit
+#define minix_test_and_clear_bit	__test_and_clear_bit
 #define minix_test_bit 			test_bit
 #define minix_find_first_zero_bit 	find_first_zero_bit
 
Index: 2.6-git/include/asm-xtensa/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-xtensa/bitops.h	2006-01-25 19:07:14.000000000 +0900
+++ 2.6-git/include/asm-xtensa/bitops.h	2006-01-25 19:14:08.000000000 +0900
@@ -436,9 +436,9 @@
 
 /* Bitmap functions for the minix filesystem.  */
 
-#define minix_test_and_set_bit(nr,addr) test_and_set_bit(nr,addr)
-#define minix_set_bit(nr,addr) set_bit(nr,addr)
-#define minix_test_and_clear_bit(nr,addr) test_and_clear_bit(nr,addr)
+#define minix_test_and_set_bit(nr,addr) __test_and_set_bit(nr,addr)
+#define minix_set_bit(nr,addr) __set_bit(nr,addr)
+#define minix_test_and_clear_bit(nr,addr) __test_and_clear_bit(nr,addr)
 #define minix_test_bit(nr,addr) test_bit(nr,addr)
 #define minix_find_first_zero_bit(addr,size) find_first_zero_bit(addr,size)
 
