Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbVLMJDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbVLMJDU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 04:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbVLMJDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 04:03:19 -0500
Received: from smtp.osdl.org ([65.172.181.4]:12251 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964791AbVLMJDO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 04:03:14 -0500
Date: Tue, 13 Dec 2005 01:02:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: ak@suse.de, mingo@elte.hu, dhowells@redhat.com, torvalds@osdl.org,
       hch@infradead.org, arjan@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-Id: <20051213010233.50fce969.akpm@osdl.org>
In-Reply-To: <20051213010126.0832356d.akpm@osdl.org>
References: <dhowells1134431145@warthog.cambridge.redhat.com>
	<20051212161944.3185a3f9.akpm@osdl.org>
	<20051213075441.GB6765@elte.hu>
	<20051213075835.GZ15804@wotan.suse.de>
	<20051213004257.0f87d814.akpm@osdl.org>
	<20051213084926.GN23384@wotan.suse.de>
	<20051213010126.0832356d.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> Thus far I have this:
>

And this:


From: Andrew Morton <akpm@osdl.org>

Remove various things which were checking for gcc-1.x and gcc-2.x compilers.


Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/arm/kernel/asm-offsets.c     |    7 +------
 arch/arm26/kernel/asm-offsets.c   |    7 -------
 arch/ia64/kernel/head.S           |    2 +-
 arch/ia64/kernel/ia64_ksyms.c     |    2 +-
 arch/ia64/oprofile/backtrace.c    |    2 +-
 drivers/md/raid0.c                |    6 ------
 fs/xfs/xfs_log.h                  |    8 +-------
 include/asm-um/rwsem.h            |    4 ----
 include/asm-v850/unistd.h         |   18 ------------------
 include/linux/seccomp.h           |    6 +-----
 include/linux/spinlock_types_up.h |   14 --------------
 11 files changed, 6 insertions(+), 70 deletions(-)

diff -puN drivers/md/raid0.c~remove-gcc2-checks drivers/md/raid0.c
--- devel/drivers/md/raid0.c~remove-gcc2-checks	2005-12-13 00:51:14.000000000 -0800
+++ devel-akpm/drivers/md/raid0.c	2005-12-13 00:51:35.000000000 -0800
@@ -307,9 +307,6 @@ static int raid0_run (mddev_t *mddev)
 	printk("raid0 : conf->hash_spacing is %llu blocks.\n",
 		(unsigned long long)conf->hash_spacing);
 	{
-#if __GNUC__ < 3
-		volatile
-#endif
 		sector_t s = mddev->array_size;
 		sector_t space = conf->hash_spacing;
 		int round;
@@ -440,9 +437,6 @@ static int raid0_make_request (request_q
  
 
 	{
-#if __GNUC__ < 3
-		volatile
-#endif
 		sector_t x = block >> conf->preshift;
 		sector_div(x, (u32)conf->hash_spacing);
 		zone = conf->hash_table[x];
diff -puN fs/xfs/xfs_log.h~remove-gcc2-checks fs/xfs/xfs_log.h
--- devel/fs/xfs/xfs_log.h~remove-gcc2-checks	2005-12-13 00:51:14.000000000 -0800
+++ devel-akpm/fs/xfs/xfs_log.h	2005-12-13 00:52:10.000000000 -0800
@@ -30,13 +30,7 @@
  * By comparing each compnent, we don't have to worry about extra
  * endian issues in treating two 32 bit numbers as one 64 bit number
  */
-static
-#if defined(__GNUC__) && (__GNUC__ == 2) && ( (__GNUC_MINOR__ == 95) || (__GNUC_MINOR__ == 96))
-__attribute__((unused))	/* gcc 2.95, 2.96 miscompile this when inlined */
-#else
-__inline__
-#endif
-xfs_lsn_t	_lsn_cmp(xfs_lsn_t lsn1, xfs_lsn_t lsn2)
+static inline xfs_lsn_t	_lsn_cmp(xfs_lsn_t lsn1, xfs_lsn_t lsn2)
 {
 	if (CYCLE_LSN(lsn1) != CYCLE_LSN(lsn2))
 		return (CYCLE_LSN(lsn1)<CYCLE_LSN(lsn2))? -999 : 999;
diff -puN arch/arm/kernel/asm-offsets.c~remove-gcc2-checks arch/arm/kernel/asm-offsets.c
--- devel/arch/arm/kernel/asm-offsets.c~remove-gcc2-checks	2005-12-13 00:51:14.000000000 -0800
+++ devel-akpm/arch/arm/kernel/asm-offsets.c	2005-12-13 00:53:27.000000000 -0800
@@ -23,18 +23,13 @@
 #error Sorry, your compiler targets APCS-26 but this kernel requires APCS-32
 #endif
 /*
- * GCC 2.95.1, 2.95.2: ignores register clobber list in asm().
  * GCC 3.0, 3.1: general bad code generation.
  * GCC 3.2.0: incorrect function argument offset calculation.
  * GCC 3.2.x: miscompiles NEW_AUX_ENT in fs/binfmt_elf.c
  *            (http://gcc.gnu.org/PR8896) and incorrect structure
  *	      initialisation in fs/jffs2/erase.c
  */
-#if __GNUC__ < 2 || \
-   (__GNUC__ == 2 && __GNUC_MINOR__ < 95) || \
-   (__GNUC__ == 2 && __GNUC_MINOR__ == 95 && __GNUC_PATCHLEVEL__ != 0 && \
-					     __GNUC_PATCHLEVEL__ < 3) || \
-   (__GNUC__ == 3 && __GNUC_MINOR__ < 3)
+#if __GNUC__ < 2 || (__GNUC__ == 3 && __GNUC_MINOR__ < 3)
 #error Your compiler is too buggy; it is known to miscompile kernels.
 #error    Known good compilers: 2.95.3, 2.95.4, 2.96, 3.3
 #endif
diff -puN arch/arm26/kernel/asm-offsets.c~remove-gcc2-checks arch/arm26/kernel/asm-offsets.c
--- devel/arch/arm26/kernel/asm-offsets.c~remove-gcc2-checks	2005-12-13 00:51:14.000000000 -0800
+++ devel-akpm/arch/arm26/kernel/asm-offsets.c	2005-12-13 00:53:47.000000000 -0800
@@ -25,13 +25,6 @@
 #if defined(__APCS_32__) && defined(CONFIG_CPU_26)
 #error Sorry, your compiler targets APCS-32 but this kernel requires APCS-26
 #endif
-#if __GNUC__ < 2 || (__GNUC__ == 2 && __GNUC_MINOR__ < 95)
-#error Sorry, your compiler is known to miscompile kernels.  Only use gcc 2.95.3 and later.
-#endif
-#if __GNUC__ == 2 && __GNUC_MINOR__ == 95
-/* shame we can't detect the .1 or .2 releases */
-#warning GCC 2.95.2 and earlier miscompiles kernels.
-#endif
 
 /* Use marker if you need to separate the values later */
 
diff -puN arch/ia64/kernel/ia64_ksyms.c~remove-gcc2-checks arch/ia64/kernel/ia64_ksyms.c
--- devel/arch/ia64/kernel/ia64_ksyms.c~remove-gcc2-checks	2005-12-13 00:51:14.000000000 -0800
+++ devel-akpm/arch/ia64/kernel/ia64_ksyms.c	2005-12-13 00:54:02.000000000 -0800
@@ -103,7 +103,7 @@ EXPORT_SYMBOL(unw_init_running);
 
 #ifdef ASM_SUPPORTED
 # ifdef CONFIG_SMP
-#  if __GNUC__ < 3 || (__GNUC__ == 3 && __GNUC_MINOR__ < 3)
+#  if (__GNUC__ == 3 && __GNUC_MINOR__ < 3)
 /*
  * This is not a normal routine and we don't want a function descriptor for it, so we use
  * a fake declaration here.
diff -puN arch/ia64/kernel/head.S~remove-gcc2-checks arch/ia64/kernel/head.S
--- devel/arch/ia64/kernel/head.S~remove-gcc2-checks	2005-12-13 00:51:15.000000000 -0800
+++ devel-akpm/arch/ia64/kernel/head.S	2005-12-13 00:54:10.000000000 -0800
@@ -1060,7 +1060,7 @@ SET_REG(b5);
 	 * the clobber lists for spin_lock() in include/asm-ia64/spinlock.h.
 	 */
 
-#if __GNUC__ < 3 || (__GNUC__ == 3 && __GNUC_MINOR__ < 3)
+#if (__GNUC__ == 3 && __GNUC_MINOR__ < 3)
 
 GLOBAL_ENTRY(ia64_spinlock_contention_pre3_4)
 	.prologue
diff -puN arch/ia64/oprofile/backtrace.c~remove-gcc2-checks arch/ia64/oprofile/backtrace.c
--- devel/arch/ia64/oprofile/backtrace.c~remove-gcc2-checks	2005-12-13 00:51:15.000000000 -0800
+++ devel-akpm/arch/ia64/oprofile/backtrace.c	2005-12-13 00:54:16.000000000 -0800
@@ -32,7 +32,7 @@ typedef struct
 	u64 *prev_pfs_loc;	/* state for WAR for old spinlock ool code */
 } ia64_backtrace_t;
 
-#if __GNUC__ < 3 || (__GNUC__ == 3 && __GNUC_MINOR__ < 3)
+#if (__GNUC__ == 3 && __GNUC_MINOR__ < 3)
 /*
  * Returns non-zero if the PC is in the spinlock contention out-of-line code
  * with non-standard calling sequence (on older compilers).
diff -puN include/linux/spinlock_types_up.h~remove-gcc2-checks include/linux/spinlock_types_up.h
--- devel/include/linux/spinlock_types_up.h~remove-gcc2-checks	2005-12-13 00:51:15.000000000 -0800
+++ devel-akpm/include/linux/spinlock_types_up.h	2005-12-13 00:55:14.000000000 -0800
@@ -22,30 +22,16 @@ typedef struct {
 
 #else
 
-/*
- * All gcc 2.95 versions and early versions of 2.96 have a nasty bug
- * with empty initializers.
- */
-#if (__GNUC__ > 2)
 typedef struct { } raw_spinlock_t;
 
 #define __RAW_SPIN_LOCK_UNLOCKED { }
-#else
-typedef struct { int gcc_is_buggy; } raw_spinlock_t;
-#define __RAW_SPIN_LOCK_UNLOCKED (raw_spinlock_t) { 0 }
-#endif
 
 #endif
 
-#if (__GNUC__ > 2)
 typedef struct {
 	/* no debug version on UP */
 } raw_rwlock_t;
 
 #define __RAW_RW_LOCK_UNLOCKED { }
-#else
-typedef struct { int gcc_is_buggy; } raw_rwlock_t;
-#define __RAW_RW_LOCK_UNLOCKED (raw_rwlock_t) { 0 }
-#endif
 
 #endif /* __LINUX_SPINLOCK_TYPES_UP_H */
diff -puN include/linux/seccomp.h~remove-gcc2-checks include/linux/seccomp.h
--- devel/include/linux/seccomp.h~remove-gcc2-checks	2005-12-13 00:51:15.000000000 -0800
+++ devel-akpm/include/linux/seccomp.h	2005-12-13 00:55:25.000000000 -0800
@@ -26,11 +26,7 @@ static inline int has_secure_computing(s
 
 #else /* CONFIG_SECCOMP */
 
-#if (__GNUC__ > 2)
-  typedef struct { } seccomp_t;
-#else
-  typedef struct { int gcc_is_buggy; } seccomp_t;
-#endif
+typedef struct { } seccomp_t;
 
 #define secure_computing(x) do { } while (0)
 /* static inline to preserve typechecking */
diff -puN include/asm-um/rwsem.h~remove-gcc2-checks include/asm-um/rwsem.h
--- devel/include/asm-um/rwsem.h~remove-gcc2-checks	2005-12-13 00:51:15.000000000 -0800
+++ devel-akpm/include/asm-um/rwsem.h	2005-12-13 00:55:41.000000000 -0800
@@ -1,10 +1,6 @@
 #ifndef __UM_RWSEM_H__
 #define __UM_RWSEM_H__
 
-#if __GNUC__ < 2 || (__GNUC__ == 2 && __GNUC_MINOR__ < 96)
-#define __builtin_expect(exp,c) (exp)
-#endif
-
 #include "asm/arch/rwsem.h"
 
 #endif
diff -puN include/asm-v850/unistd.h~remove-gcc2-checks include/asm-v850/unistd.h
--- devel/include/asm-v850/unistd.h~remove-gcc2-checks	2005-12-13 00:51:15.000000000 -0800
+++ devel-akpm/include/asm-v850/unistd.h	2005-12-13 00:56:07.000000000 -0800
@@ -241,9 +241,6 @@
 /* User programs sometimes end up including this header file
    (indirectly, via uClibc header files), so I'm a bit nervous just
    including <linux/compiler.h>.  */
-#if !defined(__builtin_expect) && __GNUC__ == 2 && __GNUC_MINOR__ < 96
-#define __builtin_expect(x, expected_value) (x)
-#endif
 
 #define __syscall_return(type, res)					      \
   do {									      \
@@ -346,20 +343,6 @@ type name (atype a, btype b, ctype c, dt
   __syscall_return (type, __ret);					      \
 }
 
-#if __GNUC__ < 3
-/* In older versions of gcc, `asm' statements with more than 10
-   input/output arguments produce a fatal error.  To work around this
-   problem, we use two versions, one for gcc-3.x and one for earlier
-   versions of gcc (the `earlier gcc' version doesn't work with gcc-3.x
-   because gcc-3.x doesn't allow clobbers to also be input arguments).  */
-#define __SYSCALL6_TRAP(syscall, ret, a, b, c, d, e, f)			      \
-  __asm__ __volatile__ ("trap " SYSCALL_LONG_TRAP			      \
-			: "=r" (ret), "=r" (syscall)			      \
-			: "1" (syscall),				      \
-			"r" (a), "r" (b), "r" (c), "r" (d),		      \
- 			"r" (e), "r" (f)				      \
-			: SYSCALL_CLOBBERS, SYSCALL_ARG4, SYSCALL_ARG5);
-#else /* __GNUC__ >= 3 */
 #define __SYSCALL6_TRAP(syscall, ret, a, b, c, d, e, f)			      \
   __asm__ __volatile__ ("trap " SYSCALL_LONG_TRAP			      \
 			: "=r" (ret), "=r" (syscall),			      \
@@ -368,7 +351,6 @@ type name (atype a, btype b, ctype c, dt
 			"r" (a), "r" (b), "r" (c), "r" (d),		      \
 			"2" (e), "3" (f)				      \
 			: SYSCALL_CLOBBERS);
-#endif
 
 #define _syscall6(type, name, atype, a, btype, b, ctype, c, dtype, d, etype, e, ftype, f) \
 type name (atype a, btype b, ctype c, dtype d, etype e, ftype f)	      \
_

