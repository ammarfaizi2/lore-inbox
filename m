Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277803AbRJLTLO>; Fri, 12 Oct 2001 15:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277807AbRJLTLE>; Fri, 12 Oct 2001 15:11:04 -0400
Received: from lists.us.dell.com ([143.166.224.162]:63919 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP
	id <S277803AbRJLTK5>; Fri, 12 Oct 2001 15:10:57 -0400
Date: Fri, 12 Oct 2001 14:11:23 -0500 (CDT)
From: Matt Domsch <Matt_Domsch@dell.com>
X-X-Sender: <mdomsch@lists.us.dell.com>
Reply-To: Matt Domsch <Matt_Domsch@dell.com>
To: <linux-kernel@vger.kernel.org>
Subject: crc32 cleanups
Message-ID: <Pine.LNX.4.33.0110121340140.17295-100000@lists.us.dell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In trying to get my EFI GUID Partition Table patch included into the stock
kernel, Andreas Dilger suggested it was time for some crc32 cleanup, as
the GPT patch added yet another copy of the common crc32 function.  So,
here's my first pass at it.  Comments welcome.

First patch:
http://domsch.com/linux/patches/linux-2.4.13-pre1-crc32-20011012.patch
 linux-2.4.13-pre1.crc/include/linux/crc32.h |   62 +++++++++++
 linux-2.4.13-pre1.crc/lib/Makefile          |    4
 linux-2.4.13-pre1.crc/lib/crc32.c           |  151 ++++++++++++++++++++++++++++
 linux-2.4.13-pre1.gpt/init/main.c           |    2
 4 files changed, 217 insertions(+), 2 deletions(-)

This patch (appended below), makes include/linux/crc32.h and
lib/crc32.c.  It generates a table based on the commonly used polynomial
at init time provided a driver needs it.  It changes ether_crc_le() to use
this table.  It renames the commonly seen ether_crc() to be
ether_crc_be(), and puts it in crc32.h (allowing lots of copies to be
deleted).

ether_crc_be() continues to use the calculated method, rather than a table
lookup method, for computing CRC.  Since I don't understand the
differences between big-endian and little-endian CRC32 functions in this
case, and I don't have access to BE systems, I tried to do the safest
thing here.  If someone wishes to make this use a table lookup, please do
so.

Exactly how init_crc32() is called is subject to debate.  The method
presented below avoids allocating and filling the table unless something
that uses it puts a line in lib/crc32.c.  A second method would be to
have each  user call init_crc32() itself, but if a driver neglects to do
such, the kernel would Oops.  I'm sure there's yet a better method I
haven't thought of.


Assuming the above patch is somewhat close to correct, then a
corresponding patch to various network drivers and jffs2 can be applied
(not appended)
http://domsch.com/linux/patches/linux-2.4.13-pre1-crc32-drivers-20011012.patch
 drivers/net/8139too.c                |   24 --------
 drivers/net/at1700.c                 |   22 -------
 drivers/net/atp.c                    |   21 -------
 drivers/net/au1000_eth.c             |   19 ------
 drivers/net/dl2k.c                   |   15 -----
 drivers/net/dl2k.h                   |    1
 drivers/net/dmfe.c                   |   84 ++----------------------------
 drivers/net/epic100.c                |   22 -------
 drivers/net/fealnx.c                 |   24 --------
 drivers/net/pci-skeleton.c           |   25 ---------
 drivers/net/pcmcia/smc91c92_cs.c     |   28 ----------
 drivers/net/pcmcia/xircom_tulip_cb.c |   40 --------------
 drivers/net/smc9194.c                |   35 +-----------
 drivers/net/starfire.c               |   26 ---------
 drivers/net/sundance.c               |   27 ---------
 drivers/net/tulip/tulip_core.c       |   40 +-------------
 drivers/net/via-rhine.c              |   23 --------
 drivers/net/winbond-840.c            |   19 ------
 drivers/net/yellowfin.c              |   24 --------
 fs/jffs2/crc32.c                     |   97 -----------------------------------
 fs/jffs2/crc32.h                     |   21 -------
 fs/jffs2/dir.c                       |    2
 fs/jffs2/erase.c                     |    2
 fs/jffs2/file.c                      |    2
 fs/jffs2/gc.c                        |    2
 fs/jffs2/read.c                      |    2
 fs/jffs2/readinode.c                 |    2
 fs/jffs2/scan.c                      |    2
 fs/jffs2/write.c                     |    2
 29 files changed, 46 insertions(+), 607 deletions(-)



I've got GPT and common uuid patches also at
http://domsch.com/linux/patches/ (see linux-2.4.13-*) to submit pending the
inclusion of the crc32 patches.


Feedback welcomed.

Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer
Dell Linux Solutions
www.dell.com/linux
#2 Linux Server provider with 17% in the US and 14% Worldwide (IDC)!
#3 Unix provider with 18% in the US (Dataquest)!




diff -burNp --exclude='*~' --exclude='*.orig' linux-2.4.13-pre1/include/linux/crc32.h linux-2.4.13-pre1.gpt/include/linux/crc32.h
--- linux-2.4.13-pre1/include/linux/crc32.h	Wed Dec 31 18:00:00 1969
+++ linux-2.4.13-pre1.crc/include/linux/crc32.h	Fri Oct 12 12:20:47 2001
@@ -0,0 +1,62 @@
+/*
+ * crc32.h
+ * See linux/lib/crc32.c for license and changes
+ */
+#ifndef _LINUX_CRC32_H
+#define _LINUX_CRC32_H
+
+#include <linux/types.h>
+#include <linux/init.h>
+
+/* This is used only by init/main.c */
+extern void crc32_init(void) __init;
+
+/*
+ * This computes a 32 bit CRC of the data in the buffer, and returns the CRC.
+ * The polynomial used is 0xedb88320.
+ */
+
+extern u32 crc32 (u32 seed, const void *buf, unsigned long len);
+
+/**
+ * ether_crc_le(int length, unsigned char *data)
+ * @length - length of buffer @data
+ * @data   - buffer to generate CRC32 value for
+ *
+ * The little-endian AUTODIN32 ethernet CRC calculation.
+ * ethernet_polynomial_le = 0xedb88320U;
+ * Seed of ~0, no final xor of ~0.
+ */
+static inline unsigned ether_crc_le(int length, unsigned char *data)
+{
+	return crc32(~0, data, length);
+}
+
+/**
+ * ether_crc_be(int length, unsigned char *data)
+ * @length - length of buffer @data
+ * @data   - buffer to generate CRC32 value for
+ *
+ * The big-endian AUTODIN II ethernet CRC calculation.
+ * N.B. Do not use for bulk data, use a table-based routine instead.
+ */
+static inline u32 ether_crc_be(int length, unsigned char *data)
+{
+	int crc = ~0;
+	unsigned const ethernet_polynomial_be = 0x04c11db7U;
+
+	while(--length >= 0) {
+		unsigned char current_octet = *data++;
+		int bit;
+		for (bit = 0; bit < 8; bit++, current_octet >>= 1) {
+			crc = (crc << 1) ^
+				((crc < 0) ^ (current_octet & 1) ?
+				 ethernet_polynomial_be : 0);
+		}
+	}
+	return crc;
+}
+
+
+
+#endif /* _LINUX_CRC32_H */
diff -burNp --exclude='*~' --exclude='*.orig' linux-2.4.13-pre1/lib/Makefile linux-2.4.13-pre1.crc/lib/Makefile
--- linux-2.4.13-pre1/lib/Makefile	Mon Sep 17 17:31:15 2001
+++ linux-2.4.13-pre1.crc/lib/Makefile	Thu Oct 11 15:45:06 2001
@@ -8,9 +8,9 @@

 L_TARGET := lib.a

-export-objs := cmdline.o dec_and_lock.o rwsem-spinlock.o rwsem.o
+export-objs := cmdline.o dec_and_lock.o rwsem-spinlock.o rwsem.o crc32.o

-obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o bust_spinlocks.o rbtree.o
+obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o bust_spinlocks.o rbtree.o crc32.o

 obj-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
 obj-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
diff -burNp --exclude='*~' --exclude='*.orig' linux-2.4.13-pre1/lib/crc32.c linux-2.4.13-pre1.crc/lib/crc32.c
--- linux-2.4.13-pre1/lib/crc32.c	Wed Dec 31 18:00:00 1969
+++ linux-2.4.13-pre1.crc/lib/crc32.c	Fri Oct 12 11:48:03 2001
@@ -0,0 +1,151 @@
+/*
+ * Oct 12, 2000 Matt Domsch <Matt_Domsch@dell.com>
+ * Same crc32 function was used in 5 other places in the kernel.
+ * I made one version, and deleted the others.
+ * There are various incantations of crc32().  Some use a seed of 0 or ~0.
+ * Some xor at the end with ~0.  The generic crc32() function takes
+ * seed as an argument, and doesn't xor at the end.  Then individual
+ * users can do whatever they need.
+ *   drivers/net/smc9194.c uses seed ~0, doesn't xor with ~0.
+ *   fs/jffs2 uses seed 0, doesn't xor with ~0.
+ *   fs/partitions/efi.c uses seed ~0, xor's with ~0.
+ *
+ * Dec 5, 2000 Matt Domsch <Matt_Domsch@dell.com>
+ * - Copied crc32.c from the linux/drivers/net/cipe directory.
+ * - Now pass seed as an arg
+ * - changed unsigned long to u32, added #include<linux/types.h>
+ * - changed len to be an unsigned long
+ * - changed crc32val to be a register
+ * - License remains unchanged!  It's still GPL-compatable!
+ */
+
+  /* ============================================================= */
+  /*  COPYRIGHT (C) 1986 Gary S. Brown.  You may use this program, or       */
+  /*  code or tables extracted from it, as desired without restriction.     */
+  /*                                                                        */
+  /*  First, the polynomial itself and its table of feedback terms.  The    */
+  /*  polynomial is                                                         */
+  /*  X^32+X^26+X^23+X^22+X^16+X^12+X^11+X^10+X^8+X^7+X^5+X^4+X^2+X^1+X^0   */
+  /*                                                                        */
+  /*  Note that we take it "backwards" and put the highest-order term in    */
+  /*  the lowest-order bit.  The X^32 term is "implied"; the LSB is the     */
+  /*  X^31 term, etc.  The X^0 term (usually shown as "+1") results in      */
+  /*  the MSB being 1.                                                      */
+  /*                                                                        */
+  /*  Note that the usual hardware shift register implementation, which     */
+  /*  is what we're using (we're merely optimizing it by doing eight-bit    */
+  /*  chunks at a time) shifts bits into the lowest-order term.  In our     */
+  /*  implementation, that means shifting towards the right.  Why do we     */
+  /*  do it this way?  Because the calculated CRC must be transmitted in    */
+  /*  order from highest-order term to lowest-order term.  UARTs transmit   */
+  /*  characters in order from LSB to MSB.  By storing the CRC this way,    */
+  /*  we hand it to the UART in the order low-byte to high-byte; the UART   */
+  /*  sends each low-bit to hight-bit; and the result is transmission bit   */
+  /*  by bit from highest- to lowest-order term without requiring any bit   */
+  /*  shuffling on our part.  Reception works similarly.                    */
+  /*                                                                        */
+  /*  The feedback terms table consists of 256, 32-bit entries.  Notes:     */
+  /*                                                                        */
+  /*      The table can be generated at runtime if desired; code to do so   */
+  /*      is shown later.  It might not be obvious, but the feedback        */
+  /*      terms simply represent the results of eight shift/xor opera-      */
+  /*      tions for all combinations of data and CRC register values.       */
+  /*                                                                        */
+  /*      The values must be right-shifted by eight bits by the "updcrc"    */
+  /*      logic; the shift must be unsigned (bring in zeroes).  On some     */
+  /*      hardware you could probably optimize the shift in assembler by    */
+  /*      using byte-swap instructions.                                     */
+  /*      polynomial $edb88320                                              */
+  /*                                                                        */
+  /*  --------------------------------------------------------------------  */
+
+#include <linux/crc32.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+
+static u32 *crc_32_tab;
+
+/**
+ * crc32_init(): generates CRC32 table for polynomial $edb88320
+ *
+ * Description: Code to compute the CRC-32 table. Borrowed from
+ * gzip-1.0.3/makecrc.c.
+ */
+#if defined(CONFIG_AT1700)        || \
+    defined(CONFIG_ATP)           || \
+    defined(CONFIG_DL2K)          || \
+    defined(CONFIG_DM9102)        || \
+    defined(CONFIG_EPIC100)       || \
+    defined(CONFIG_SMC9194)       || \
+    defined(CONFIG_STARFIRE)      || \
+    defined(CONFIG_SUNDANCE)      || \
+    defined(CONFIG_TULIP)         || \
+    defined(CONFIG_YELLOWFIN)     || \
+    defined(CONFIG_FS_JFFS2)      || \
+    defined(CONFIG_EFI_PARTITION)
+void __init crc32_init(void)
+{
+/* Not copyrighted 1990 Mark Adler	*/
+
+	u32 c;      /* crc shift register */
+	u32 e;      /* polynomial exclusive-or pattern */
+	int i;      /* counter for all possible eight bit values */
+	int k;      /* byte being shifted into crc apparatus */
+	/* terms of polynomial defining this crc (except x^32): */
+	const int p[] = {0,1,2,4,5,7,8,10,11,12,16,22,23,26};
+
+	if (crc_32_tab) return;
+	else crc_32_tab = kmalloc(256*sizeof(u32), GFP_KERNEL);
+
+	/* Make exclusive-or pattern from polynomial */
+	e = 0;
+	for (i = 0; i < sizeof(p)/sizeof(int); i++)
+		e |= 1L << (31 - p[i]);
+
+	crc_32_tab[0] = 0;
+
+	for (i = 1; i < 256; i++) {
+		c = 0;
+		for (k = i | 256; k != 1; k >>= 1) {
+			c = c & 1 ? (c >> 1) ^ e : c >> 1;
+			if (k & 1)
+				c ^= e;
+		}
+		crc_32_tab[i] = c;
+	}
+}
+#else
+#define init_crc32()
+#define NEED_INIT_CRC32
+#endif
+
+/**
+ * crc32(): Generates CRC32 checksum of buffer
+ * @seed: initial value, often 0 or ~0, or the
+ *        running crc if checksumming multiple buffers.
+ * @buf:  buffer to be checksummed
+ * @len:  length of @buf
+ *
+ */
+
+
+u32
+crc32(u32 seed, const void *buf, unsigned long len)
+{
+	unsigned long i;
+	register u32 crc32val;
+	const u8 *s = buf;
+
+#ifdef NEED_INIT_CRC32
+#error You must add the CONFIG variable for this module to lib/crc32.c:init_crc32().
+#endif
+	crc32val = seed;
+	for (i = 0;  i < len;  i++) {
+		crc32val = crc_32_tab[(crc32val ^ s[i]) & 0xff] ^
+			(crc32val >> 8);
+	}
+	return crc32val;
+}
+
+EXPORT_SYMBOL(crc32);
diff -burNp --exclude='*~' --exclude='*.orig' linux-2.4.13-pre1/init/main.c linux-2.4.13-pre1.gpt/init/main.c
--- linux-2.4.13-pre1/init/main.c	Sat Oct  6 10:49:16 2001
+++ linux-2.4.13-pre1.gpt/init/main.c	Fri Oct 12 10:40:02 2001
@@ -27,6 +27,7 @@
 #include <linux/iobuf.h>
 #include <linux/bootmem.h>
 #include <linux/tty.h>
+#include <linux/crc32.h>

 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -608,6 +609,7 @@ asmlinkage void __init start_kernel(void
 #if defined(CONFIG_SYSVIPC)
 	ipc_init();
 #endif
+	crc32_init();
 	check_bugs();
 	printk("POSIX conformance testing by UNIFIX\n");



