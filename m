Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293461AbSBZB4e>; Mon, 25 Feb 2002 20:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293439AbSBZB4V>; Mon, 25 Feb 2002 20:56:21 -0500
Received: from dsl-65-185-109-125.telocity.com ([65.185.109.125]:38274 "EHLO
	ohdarn.net") by vger.kernel.org with ESMTP id <S293447AbSBZB4C>;
	Mon, 25 Feb 2002 20:56:02 -0500
Date: Mon, 25 Feb 2002 20:56:04 -0500
From: Michael Cohen <me@ohdarn.net>
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Submssions for 2.4.19-pre [Fibonacci Hashing (William Lee Irwin)] [Discuss :) ]
Message-Id: <20020225205604.0583595e.me@ohdarn.net>
Organization: OhDarn.net
X-Mailer: Sylpheed version 0.7.2 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the second of several mails containing patches to be included in 2.4.19.  Some are worthy of dicussion prior to inclusion and have been marked as such.  The majority of these patches were found on lkml; the remaining ones have URLs listed.

This one was given to me by WLI himself; I have a feeling that ftp://ftp.XX.kernel.org/pub/linux/kernel/people/wli might have it in pieces, or /pub/linux/kernel/people/mjc/testing/mjc4p2.tar.bz2 also has it.

This version at least will compile on all arches that 2.4.19-pre1 will, and a note is given for arches where the sparse golden ratio prime given is definately not the optimal (non-32bit arches).  I will try to help wli find a better prime for 64bit soon.  Testing on other arches is, of course, appreciated.

------
Michael Cohen
OhDarn.net

diff -Nru linux-2.4.19-pre1/fs/inode.c linux-patched/fs/inode.c
--- linux-2.4.19-pre1/fs/inode.c	Fri Dec 21 12:41:55 2001
+++ linux-patched/fs/inode.c	Mon Feb 25 20:28:27 2002
@@ -901,12 +901,13 @@
 
 static inline unsigned long hash(struct super_block *sb, unsigned long i_ino)
 {
-	unsigned long tmp = i_ino + ((unsigned long) sb / L1_CACHE_BYTES);
-	tmp = tmp + (tmp >> I_HASHBITS);
-	return tmp & I_HASHMASK;
+	unsigned long hash;
+	hash   = i_ino + (unsigned long) sb;
+	hash  *= SPARSE_GOLDEN_RATIO_PRIME;
+	hash >>= BITS_PER_LONG - I_HASHBITS;
+	hash  &= I_HASHMASK;
+	return hash;
 }
-
-/* Yeah, I know about quadratic hash. Maybe, later. */
 
 /**
  *	iunique - get a unique inode number
diff -Nru linux-2.4.19-pre1/include/asm-alpha/param.h linux-patched/include/asm-alpha/param.h
--- linux-2.4.19-pre1/include/asm-alpha/param.h	Wed Nov  8 02:37:31 2000
+++ linux-patched/include/asm-alpha/param.h	Mon Feb 25 20:44:35 2002
@@ -15,6 +15,13 @@
 # endif
 #endif
 
+/* SPARSE_GOLDEN_RATIO_PRIME ought to be different for non-32bit arches. */
+
+#ifndef SPARSE_GOLDEN_RATIO_PRIME
+#define SPARSE_GOLDEN_RATIO_PRIME 0x9e004001UL
+#endif
+
+
 #define EXEC_PAGESIZE	8192
 
 #ifndef NGROUPS
diff -Nru linux-2.4.19-pre1/include/asm-arm/param.h linux-patched/include/asm-arm/param.h
--- linux-2.4.19-pre1/include/asm-arm/param.h	Thu Oct 11 12:04:57 2001
+++ linux-patched/include/asm-arm/param.h	Mon Feb 25 20:43:13 2002
@@ -20,6 +20,10 @@
 #define hz_to_std(a) (a)
 #endif
 
+#ifndef SPARSE_GOLDEN_RATIO_PRIME
+#define SPARSE_GOLDEN_RATIO_PRIME 0x9e004001UL
+#endif
+
 #ifndef NGROUPS
 #define NGROUPS         32
 #endif
diff -Nru linux-2.4.19-pre1/include/asm-cris/param.h linux-patched/include/asm-cris/param.h
--- linux-2.4.19-pre1/include/asm-cris/param.h	Thu Feb  8 19:32:44 2001
+++ linux-patched/include/asm-cris/param.h	Mon Feb 25 20:43:27 2002
@@ -5,6 +5,11 @@
 #define HZ 100
 #endif
 
+#ifndef SPARSE_GOLDEN_RATIO_PRIME
+#define SPARSE_GOLDEN_RATIO_PRIME 0x9e004001UL
+#endif
+
+
 #define EXEC_PAGESIZE	8192
 
 #ifndef NGROUPS
diff -Nru linux-2.4.19-pre1/include/asm-i386/param.h linux-patched/include/asm-i386/param.h
--- linux-2.4.19-pre1/include/asm-i386/param.h	Fri Oct 27 14:04:43 2000
+++ linux-patched/include/asm-i386/param.h	Mon Feb 25 20:28:27 2002
@@ -5,6 +5,10 @@
 #define HZ 100
 #endif
 
+#ifndef SPARSE_GOLDEN_RATIO_PRIME
+#define SPARSE_GOLDEN_RATIO_PRIME 0x9e004001UL
+#endif
+
 #define EXEC_PAGESIZE	4096
 
 #ifndef NGROUPS
diff -Nru linux-2.4.19-pre1/include/asm-ia64/param.h linux-patched/include/asm-ia64/param.h
--- linux-2.4.19-pre1/include/asm-ia64/param.h	Thu Apr  5 15:51:47 2001
+++ linux-patched/include/asm-ia64/param.h	Mon Feb 25 20:45:09 2002
@@ -20,6 +20,12 @@
 # define HZ	1024
 #endif
 
+/* SPARSE_GOLDEN_RATIO_PRIME ought to be different for non-32bit arches. */
+
+#ifndef SPARSE_GOLDEN_RATIO_PRIME
+#define SPARSE_GOLDEN_RATIO_PRIME 0x9e004001UL
+#endif
+
 #define EXEC_PAGESIZE	65536
 
 #ifndef NGROUPS
diff -Nru linux-2.4.19-pre1/include/asm-m68k/param.h linux-patched/include/asm-m68k/param.h
--- linux-2.4.19-pre1/include/asm-m68k/param.h	Thu Jan  4 16:00:55 2001
+++ linux-patched/include/asm-m68k/param.h	Mon Feb 25 20:43:45 2002
@@ -5,6 +5,11 @@
 #define HZ 100
 #endif
 
+#ifndef SPARSE_GOLDEN_RATIO_PRIME
+#define SPARSE_GOLDEN_RATIO_PRIME 0x9e004001UL
+#endif
+
+
 #define EXEC_PAGESIZE	8192
 
 #ifndef NGROUPS
diff -Nru linux-2.4.19-pre1/include/asm-mips/param.h linux-patched/include/asm-mips/param.h
--- linux-2.4.19-pre1/include/asm-mips/param.h	Mon Jul  2 16:56:40 2001
+++ linux-patched/include/asm-mips/param.h	Mon Feb 25 20:45:35 2002
@@ -52,6 +52,11 @@
 #endif /* defined(__KERNEL__)  */
 #endif /* defined(HZ)  */
 
+#ifndef SPARSE_GOLDEN_RATIO_PRIME
+#define SPARSE_GOLDEN_RATIO_PRIME 0x9e004001UL
+#endif
+
+
 #define EXEC_PAGESIZE	4096
 
 #ifndef NGROUPS
diff -Nru linux-2.4.19-pre1/include/asm-mips64/param.h linux-patched/include/asm-mips64/param.h
--- linux-2.4.19-pre1/include/asm-mips64/param.h	Wed Nov 29 00:42:04 2000
+++ linux-patched/include/asm-mips64/param.h	Mon Feb 25 20:46:10 2002
@@ -17,6 +17,13 @@
 #endif
 #endif
 
+/* SPARSE_GOLDEN_RATIO_PRIME ought to be different for non-32bit arches. 
+*/
+
+#ifndef SPARSE_GOLDEN_RATIO_PRIME
+#define SPARSE_GOLDEN_RATIO_PRIME 0x9e004001UL
+#endif
+
 #define EXEC_PAGESIZE	4096
 
 #ifndef NGROUPS
diff -Nru linux-2.4.19-pre1/include/asm-parisc/param.h linux-patched/include/asm-parisc/param.h
--- linux-2.4.19-pre1/include/asm-parisc/param.h	Tue Dec  5 15:29:39 2000
+++ linux-patched/include/asm-parisc/param.h	Mon Feb 25 20:49:01 2002
@@ -5,6 +5,13 @@
 #define HZ 100
 #endif
 
+/* SPARSE_GOLDEN_RATIO_PRIME ought to be different for non-32bit arches. */
+
+#ifndef SPARSE_GOLDEN_RATIO_PRIME
+#define SPARSE_GOLDEN_RATIO_PRIME 0x9e004001UL
+#endif
+
+
 #define EXEC_PAGESIZE	4096
 
 #ifndef NGROUPS
diff -Nru linux-2.4.19-pre1/include/asm-ppc/param.h linux-patched/include/asm-ppc/param.h
--- linux-2.4.19-pre1/include/asm-ppc/param.h	Tue Aug 28 09:58:33 2001
+++ linux-patched/include/asm-ppc/param.h	Mon Feb 25 20:42:59 2002
@@ -8,6 +8,10 @@
 #define HZ 100
 #endif
 
+#ifndef SPARSE_GOLDEN_RATIO_PRIME
+#define SPARSE_GOLDEN_RATIO_PRIME 0x9e004001UL
+#endif
+
 #define EXEC_PAGESIZE	4096
 
 #ifndef NGROUPS
diff -Nru linux-2.4.19-pre1/include/asm-s390/param.h linux-patched/include/asm-s390/param.h
--- linux-2.4.19-pre1/include/asm-s390/param.h	Tue Feb 13 17:13:44 2001
+++ linux-patched/include/asm-s390/param.h	Mon Feb 25 20:47:06 2002
@@ -13,6 +13,11 @@
 #define HZ 100
 #endif
 
+#ifndef SPARSE_GOLDEN_RATIO_PRIME
+#define SPARSE_GOLDEN_RATIO_PRIME 0x9e004001UL
+#endif
+
+
 #define EXEC_PAGESIZE	4096
 
 #ifndef NGROUPS
diff -Nru linux-2.4.19-pre1/include/asm-s390x/param.h linux-patched/include/asm-s390x/param.h
--- linux-2.4.19-pre1/include/asm-s390x/param.h	Thu Oct 11 12:43:38 2001
+++ linux-patched/include/asm-s390x/param.h	Mon Feb 25 20:47:18 2002
@@ -16,6 +16,13 @@
 #endif
 #endif
 
+/* SPARSE_GOLDEN_RATIO_PRIME ought to be different for non-32bit arches. */
+
+#ifndef SPARSE_GOLDEN_RATIO_PRIME
+#define SPARSE_GOLDEN_RATIO_PRIME 0x9e004001UL
+#endif
+
+
 #define EXEC_PAGESIZE	4096
 
 #ifndef NGROUPS
diff -Nru linux-2.4.19-pre1/include/asm-sh/param.h linux-patched/include/asm-sh/param.h
--- linux-2.4.19-pre1/include/asm-sh/param.h	Thu Jan  4 16:19:13 2001
+++ linux-patched/include/asm-sh/param.h	Mon Feb 25 20:47:41 2002
@@ -5,6 +5,11 @@
 #define HZ 100
 #endif
 
+#ifndef SPARSE_GOLDEN_RATIO_PRIME
+#define SPARSE_GOLDEN_RATIO_PRIME 0x9e004001UL
+#endif
+
+
 #define EXEC_PAGESIZE	4096
 
 #ifndef NGROUPS
diff -Nru linux-2.4.19-pre1/include/asm-sparc/param.h linux-patched/include/asm-sparc/param.h
--- linux-2.4.19-pre1/include/asm-sparc/param.h	Mon Oct 30 17:34:12 2000
+++ linux-patched/include/asm-sparc/param.h	Mon Feb 25 20:48:26 2002
@@ -6,7 +6,11 @@
 #define HZ 100
 #endif
 
-#define EXEC_PAGESIZE	8192    /* Thanks for sun4's we carry baggage... */
+#ifndef SPARSE_GOLDEN_RATIO_PRIME
+#define SPARSE_GOLDEN_RATIO_PRIME 0x9e004001UL
+#endif
+
+#define EXEC_PAGESIZE	8192    /* Thanks to sun4's we carry baggage... */
 
 #ifndef NGROUPS
 #define NGROUPS		32
diff -Nru linux-2.4.19-pre1/include/asm-sparc64/param.h linux-patched/include/asm-sparc64/param.h
--- linux-2.4.19-pre1/include/asm-sparc64/param.h	Mon Oct 30 17:34:12 2000
+++ linux-patched/include/asm-sparc64/param.h	Mon Feb 25 20:48:47 2002
@@ -6,7 +6,14 @@
 #define HZ 100
 #endif
 
-#define EXEC_PAGESIZE	8192    /* Thanks for sun4's we carry baggage... */
+/* SPARSE_GOLDEN_RATIO_PRIME ought to be different for non-32bit arches. */
+
+#ifndef SPARSE_GOLDEN_RATIO_PRIME
+#define SPARSE_GOLDEN_RATIO_PRIME 0x9e004001UL
+#endif
+
+
+#define EXEC_PAGESIZE	8192    /* Thanks to sun4's we carry baggage... */
 
 #ifndef NGROUPS
 #define NGROUPS		32
diff -Nru linux-2.4.19-pre1/include/linux/pagemap.h linux-patched/include/linux/pagemap.h
--- linux-2.4.19-pre1/include/linux/pagemap.h	Mon Feb 25 14:38:13 2002
+++ linux-patched/include/linux/pagemap.h	Mon Feb 25 20:28:27 2002
@@ -61,11 +61,12 @@
  */
 static inline unsigned long _page_hashfn(struct address_space * mapping, unsigned long index)
 {
-#define i (((unsigned long) mapping)/(sizeof(struct inode) & ~ (sizeof(struct inode) - 1)))
-#define s(x) ((x)+((x)>>PAGE_HASH_BITS))
-	return s(i+index) & (PAGE_HASH_SIZE-1);
-#undef i
-#undef s
+	unsigned long hash;
+	hash   = (unsigned long) mapping + index;
+	hash  *= SPARSE_GOLDEN_RATIO_PRIME;
+	hash >>= BITS_PER_LONG - PAGE_HASH_BITS;
+	hash  &= PAGE_HASH_SIZE - 1;
+	return hash;
 }
 
 #define page_hash(mapping,index) (page_hash_table+_page_hashfn(mapping,index))
diff -Nru linux-2.4.19-pre1/include/linux/sched.h linux-patched/include/linux/sched.h
--- linux-2.4.19-pre1/include/linux/sched.h	Fri Dec 21 12:42:03 2001
+++ linux-patched/include/linux/sched.h	Mon Feb 25 20:30:42 2002
@@ -518,11 +518,22 @@
 extern struct   mm_struct init_mm;
 extern struct task_struct *init_tasks[NR_CPUS];
 
+/*
+ * A pid hash function using a prime near golden
+ * ratio to the machine word size (32 bits). The
+ * results of this are unknown.
+ *
+ * Added shift to extract high-order bits of computed
+ * hash function.
+ * -- wli
+ */
+
 /* PID hashing. (shouldnt this be dynamic?) */
 #define PIDHASH_SZ (4096 >> 2)
+#define PIDHASH_BITS 10
 extern struct task_struct *pidhash[PIDHASH_SZ];
-
-#define pid_hashfn(x)	((((x) >> 8) ^ (x)) & (PIDHASH_SZ - 1))
+#define pid_hashfn(x) \
+	(((2654435761UL*(x)) >> (BITS_PER_LONG-PIDHASH_BITS)) & (PIDHASH_SZ-1))
 
 static inline void hash_pid(struct task_struct *p)
 {
diff -Nru linux-2.4.19-pre1/kernel/user.c linux-patched/kernel/user.c
--- linux-2.4.19-pre1/kernel/user.c	Wed Nov 29 01:43:39 2000
+++ linux-patched/kernel/user.c	Mon Feb 25 20:28:27 2002
@@ -19,7 +19,14 @@
 #define UIDHASH_BITS		8
 #define UIDHASH_SZ		(1 << UIDHASH_BITS)
 #define UIDHASH_MASK		(UIDHASH_SZ - 1)
-#define __uidhashfn(uid)	(((uid >> UIDHASH_BITS) ^ uid) & UIDHASH_MASK)
+
+/*
+ * hash function borrowed from Chuck Lever's paper
+ * The effects of this replacement have not been measured.
+ * -- wli
+ */
+#define __uidhashfn(uid) \
+	(((2654435761UL*(uid)) >> (BITS_PER_LONG-UIDHASH_BITS)) & UIDHASH_MASK)
 #define uidhashentry(uid)	(uidhash_table + __uidhashfn(uid))
 
 static kmem_cache_t *uid_cachep;
