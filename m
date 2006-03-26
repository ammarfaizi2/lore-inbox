Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbWCZLzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbWCZLzj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 06:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbWCZLzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 06:55:39 -0500
Received: from smtpout.mac.com ([17.250.248.88]:29663 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751274AbWCZLzh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 06:55:37 -0500
Date: Sun, 26 Mar 2006 06:55:22 -0500
From: Kyle Moffett <mrmacman_g4@mac.com>
To: linux-kernel@vger.kernel.org
Cc: nix@esperi.org.uk, rob@landley.net, mmazur@kernel.pl,
       llh-discuss@lists.pld-linux.org
Subject: [RFC][PATCH 2/2] Generalize fd_set handling across architectures
Message-Id: <20060326065522.a836f6c8.mrmacman_g4@mac.com>
In-Reply-To: <20060326065205.d691539c.mrmacman_g4@mac.com>
References: <200603141619.36609.mmazur@kernel.pl>
	<200603231811.26546.mmazur@kernel.pl>
	<DE01BAD3-692D-4171-B386-5A5F92B0C09E@mac.com>
	<200603241623.49861.rob@landley.net>
	<878xqzpl8g.fsf@hades.wkstn.nix>
	<D903C0E1-4F7B-4059-A25D-DD5AB5362981@mac.com>
	<20060326065205.d691539c.mrmacman_g4@mac.com>
X-Mailer: Sylpheed version 2.2.1 (GTK+ 2.8.13; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Generalize fd_set handling across architectures

The fd_set handling is identical across all architectures, but each has its
own unique set of ugly functions or macros to do it.  This cleans up all of
the ugliness and merges the duplicated code into a single KABI header,
include/kabi/fdset.h, which is then included in the old places to preserve
existing semantics.

Appears to compile correctly with allmodconfig on powerpc (32-bit)

Signed-off-by: Kyle Moffett <mrmacman_g4@mac.com>

---
commit c00dc3cc75d218b5c23cefcb5324197f34d93de3
tree b4baa9126e0f7490c782279eb069ff184e59a73f
parent affadc51c2b4c96785809a352973a9f6a51a4c37
author Kyle Moffett <mrmacman_g4@mac.com> Sun, 26 Mar 2006 06:25:07 -0500
committer Kyle Moffett <mrmacman_g4@mac.com> Sun, 26 Mar 2006 06:25:07 -0500

 include/asm-alpha/posix_types.h   |   81 +------------------------------------
 include/asm-arm/posix_types.h     |   22 +---------
 include/asm-arm26/posix_types.h   |   22 +---------
 include/asm-cris/posix_types.h    |   23 -----------
 include/asm-frv/posix_types.h     |   18 +-------
 include/asm-h8300/posix_types.h   |   18 +-------
 include/asm-i386/posix_types.h    |   35 +---------------
 include/asm-ia64/posix_types.h    |   79 +-----------------------------------
 include/asm-m32r/posix_types.h    |   75 +---------------------------------
 include/asm-m68k/posix_types.h    |   18 +-------
 include/asm-mips/posix_types.h    |   73 ---------------------------------
 include/asm-parisc/posix_types.h  |   74 +---------------------------------
 include/asm-powerpc/posix_types.h |   74 +---------------------------------
 include/asm-s390/posix_types.h    |   23 +----------
 include/asm-sh/posix_types.h      |   75 +---------------------------------
 include/asm-sh64/posix_types.h    |   75 +---------------------------------
 include/asm-sparc/posix_types.h   |   75 +---------------------------------
 include/asm-sparc64/posix_types.h |   75 +---------------------------------
 include/asm-v850/posix_types.h    |   23 +----------
 include/asm-x86_64/posix_types.h  |   75 +---------------------------------
 include/asm-xtensa/posix_types.h  |   68 +------------------------------
 include/kabi/fdset.h              |   49 ++++++++++++++++++++++
 include/linux/fdset.h             |   15 +++++++
 include/linux/posix_types.h       |   35 ----------------
 include/linux/time.h              |   14 +++---
 25 files changed, 112 insertions(+), 1102 deletions(-)

diff --git a/include/asm-alpha/posix_types.h b/include/asm-alpha/posix_types.h
index c78c04a..c303ade 100644
--- a/include/asm-alpha/posix_types.h
+++ b/include/asm-alpha/posix_types.h
@@ -1,6 +1,8 @@
 #ifndef _ALPHA_POSIX_TYPES_H
 #define _ALPHA_POSIX_TYPES_H
 
+#include <linux/fdset.h>
+
 /*
  * This file is generally used by user-level software, so you need to
  * be a little careful about namespace pollution etc.  Also, we cannot
@@ -41,83 +43,4 @@ typedef __kernel_gid_t __kernel_gid32_t;
 
 typedef unsigned int	__kernel_old_dev_t;
 
-#ifdef __KERNEL__
-
-#ifndef __GNUC__
-
-#define	__FD_SET(d, set)	((set)->fds_bits[__FDELT(d)] |= __FDMASK(d))
-#define	__FD_CLR(d, set)	((set)->fds_bits[__FDELT(d)] &= ~__FDMASK(d))
-#define	__FD_ISSET(d, set)	(((set)->fds_bits[__FDELT(d)] & __FDMASK(d)) != 0)
-#define	__FD_ZERO(set)	\
-  ((void) memset ((__ptr_t) (set), 0, sizeof (__kernel_fd_set)))
-
-#else /* __GNUC__ */
-
-/* With GNU C, use inline functions instead so args are evaluated only once: */
-
-#undef __FD_SET
-static __inline__ void __FD_SET(unsigned long fd, __kernel_fd_set *fdsetp)
-{
-	unsigned long _tmp = fd / __NFDBITS;
-	unsigned long _rem = fd % __NFDBITS;
-	fdsetp->fds_bits[_tmp] |= (1UL<<_rem);
-}
-
-#undef __FD_CLR
-static __inline__ void __FD_CLR(unsigned long fd, __kernel_fd_set *fdsetp)
-{
-	unsigned long _tmp = fd / __NFDBITS;
-	unsigned long _rem = fd % __NFDBITS;
-	fdsetp->fds_bits[_tmp] &= ~(1UL<<_rem);
-}
-
-#undef __FD_ISSET
-static __inline__ int __FD_ISSET(unsigned long fd, const __kernel_fd_set *p)
-{ 
-	unsigned long _tmp = fd / __NFDBITS;
-	unsigned long _rem = fd % __NFDBITS;
-	return (p->fds_bits[_tmp] & (1UL<<_rem)) != 0;
-}
-
-/*
- * This will unroll the loop for the normal constant case (8 ints,
- * for a 256-bit fd_set)
- */
-#undef __FD_ZERO
-static __inline__ void __FD_ZERO(__kernel_fd_set *p)
-{
-	unsigned long *tmp = p->fds_bits;
-	int i;
-
-	if (__builtin_constant_p(__FDSET_LONGS)) {
-		switch (__FDSET_LONGS) {
-		      case 16:
-			tmp[ 0] = 0; tmp[ 1] = 0; tmp[ 2] = 0; tmp[ 3] = 0;
-			tmp[ 4] = 0; tmp[ 5] = 0; tmp[ 6] = 0; tmp[ 7] = 0;
-			tmp[ 8] = 0; tmp[ 9] = 0; tmp[10] = 0; tmp[11] = 0;
-			tmp[12] = 0; tmp[13] = 0; tmp[14] = 0; tmp[15] = 0;
-			return;
-
-		      case 8:
-			tmp[ 0] = 0; tmp[ 1] = 0; tmp[ 2] = 0; tmp[ 3] = 0;
-			tmp[ 4] = 0; tmp[ 5] = 0; tmp[ 6] = 0; tmp[ 7] = 0;
-			return;
-
-		      case 4:
-			tmp[ 0] = 0; tmp[ 1] = 0; tmp[ 2] = 0; tmp[ 3] = 0;
-			return;
-		}
-	}
-	i = __FDSET_LONGS;
-	while (i) {
-		i--;
-		*tmp = 0;
-		tmp++;
-	}
-}
-
-#endif /* __GNUC__ */
-
-#endif /* __KERNEL__ */
-
 #endif /* _ALPHA_POSIX_TYPES_H */
diff --git a/include/asm-arm/posix_types.h b/include/asm-arm/posix_types.h
index e142a2a..918508b 100644
--- a/include/asm-arm/posix_types.h
+++ b/include/asm-arm/posix_types.h
@@ -13,6 +13,8 @@
 #ifndef __ARCH_ARM_POSIX_TYPES_H
 #define __ARCH_ARM_POSIX_TYPES_H
 
+#include <linux/fdset.h>
+
 /*
  * This file is generally used by user-level software, so you need to
  * be a little careful about namespace pollution etc.  Also, we cannot
@@ -58,24 +60,4 @@ typedef struct {
 #endif /* !defined(__KERNEL__) && !defined(__USE_ALL) */
 } __kernel_fsid_t;
 
-#if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)
-
-#undef	__FD_SET
-#define __FD_SET(fd, fdsetp) \
-		(((fd_set *)(fdsetp))->fds_bits[(fd) >> 5] |= (1<<((fd) & 31)))
-
-#undef	__FD_CLR
-#define __FD_CLR(fd, fdsetp) \
-		(((fd_set *)(fdsetp))->fds_bits[(fd) >> 5] &= ~(1<<((fd) & 31)))
-
-#undef	__FD_ISSET
-#define __FD_ISSET(fd, fdsetp) \
-		((((fd_set *)(fdsetp))->fds_bits[(fd) >> 5] & (1<<((fd) & 31))) != 0)
-
-#undef	__FD_ZERO
-#define __FD_ZERO(fdsetp) \
-		(memset (fdsetp, 0, sizeof (*(fd_set *)(fdsetp))))
-
-#endif
-
 #endif
diff --git a/include/asm-arm26/posix_types.h b/include/asm-arm26/posix_types.h
index f8d1eb4..918508b 100644
--- a/include/asm-arm26/posix_types.h
+++ b/include/asm-arm26/posix_types.h
@@ -13,6 +13,8 @@
 #ifndef __ARCH_ARM_POSIX_TYPES_H
 #define __ARCH_ARM_POSIX_TYPES_H
 
+#include <linux/fdset.h>
+
 /*
  * This file is generally used by user-level software, so you need to
  * be a little careful about namespace pollution etc.  Also, we cannot
@@ -58,24 +60,4 @@ typedef struct {
 #endif /* !defined(__KERNEL__) && !defined(__USE_ALL) */
 } __kernel_fsid_t;
 
-#if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)
-
-#undef	__FD_SET
-#define __FD_SET(fd, fdsetp) \
-		(((fd_set *)(fdsetp))->fds_bits[(fd) >> 5] |= (1<<((fd) & 31)))
-
-#undef	__FD_CLR
-#define __FD_CLR(fd, fdsetp) \
-		(((fd_set *)(fdsetp))->fds_bits[(fd) >> 5] &= ~(1<<((fd) & 31)))
-
-#undef	__FD_ISSET
-#define __FD_ISSET(fd, fdsetp) \
-		((((fd_set *)(fdsetp))->fds_bits[(fd) >> 5] & (1<<((fd) & 31))) != 0)
-
-#undef	__FD_ZERO
-#define __FD_ZERO(fdsetp) \
-		(memset ((fdsetp), 0, sizeof (*(fd_set *)(fdsetp))))
-
-#endif
-
 #endif
diff --git a/include/asm-cris/posix_types.h b/include/asm-cris/posix_types.h
index 6d26fee..fdf1e26 100644
--- a/include/asm-cris/posix_types.h
+++ b/include/asm-cris/posix_types.h
@@ -1,12 +1,9 @@
 /* $Id: posix_types.h,v 1.1 2000/07/10 16:32:31 bjornw Exp $ */
 
-/* We cheat a bit and use our C-coded bitops functions from asm/bitops.h */
-/* I guess we should write these in assembler because they are used often. */
-
 #ifndef __ARCH_CRIS_POSIX_TYPES_H
 #define __ARCH_CRIS_POSIX_TYPES_H
 
-#include <asm/bitops.h>
+#include <linux/fdset.h>
 
 /*
  * This file is generally used by user-level software, so you need to
@@ -53,22 +50,4 @@ typedef struct {
 #endif /* !defined(__KERNEL__) && !defined(__USE_ALL) */
 } __kernel_fsid_t;
 
-/* should this ifdef be here ?  */
-
-#if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)
-
-#undef	__FD_SET
-#define __FD_SET(fd,fdsetp) set_bit(fd, (void *)(fdsetp))
-
-#undef	__FD_CLR
-#define __FD_CLR(fd,fdsetp) clear_bit(fd, (void *)(fdsetp))
-
-#undef	__FD_ISSET
-#define __FD_ISSET(fd,fdsetp) test_bit(fd, (void *)(fdsetp))
-
-#undef	__FD_ZERO
-#define __FD_ZERO(fdsetp) memset((void *)(fdsetp), 0, __FDSET_LONGS << 2)
-
-#endif /* defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2) */
-
 #endif /* __ARCH_CRIS_POSIX_TYPES_H */
diff --git a/include/asm-frv/posix_types.h b/include/asm-frv/posix_types.h
index 73c2ba8..5b241f7 100644
--- a/include/asm-frv/posix_types.h
+++ b/include/asm-frv/posix_types.h
@@ -1,6 +1,8 @@
 #ifndef _ASM_POSIX_TYPES_H
 #define _ASM_POSIX_TYPES_H
 
+#include <linux/fdset.h>
+
 /*
  * This file is generally used by user-level software, so you need to
  * be a little careful about namespace pollution etc.  Also, we cannot
@@ -46,21 +48,5 @@ typedef struct {
 #endif /* !defined(__KERNEL__) && !defined(__USE_ALL) */
 } __kernel_fsid_t;
 
-#if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)
-
-#undef	__FD_SET
-#define	__FD_SET(d, set)	((set)->fds_bits[__FDELT(d)] |= __FDMASK(d))
-
-#undef	__FD_CLR
-#define	__FD_CLR(d, set)	((set)->fds_bits[__FDELT(d)] &= ~__FDMASK(d))
-
-#undef	__FD_ISSET
-#define	__FD_ISSET(d, set)	(!!((set)->fds_bits[__FDELT(d)] & __FDMASK(d)))
-
-#undef	__FD_ZERO
-#define __FD_ZERO(fdsetp) (memset (fdsetp, 0, sizeof(*(fd_set *)fdsetp)))
-
-#endif /* defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2) */
-
 #endif
 
diff --git a/include/asm-h8300/posix_types.h b/include/asm-h8300/posix_types.h
index 7de94b1..c65fbc9 100644
--- a/include/asm-h8300/posix_types.h
+++ b/include/asm-h8300/posix_types.h
@@ -1,6 +1,8 @@
 #ifndef __ARCH_H8300_POSIX_TYPES_H
 #define __ARCH_H8300_POSIX_TYPES_H
 
+#include <linux/fdset.h>
+
 /*
  * This file is generally used by user-level software, so you need to
  * be a little careful about namespace pollution etc.  Also, we cannot
@@ -45,20 +47,4 @@ typedef struct {
 #endif /* !defined(__KERNEL__) && !defined(__USE_ALL) */
 } __kernel_fsid_t;
 
-#if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)
-
-#undef	__FD_SET
-#define	__FD_SET(d, set)	((set)->fds_bits[__FDELT(d)] |= __FDMASK(d))
-
-#undef	__FD_CLR
-#define	__FD_CLR(d, set)	((set)->fds_bits[__FDELT(d)] &= ~__FDMASK(d))
-
-#undef	__FD_ISSET
-#define	__FD_ISSET(d, set)	((set)->fds_bits[__FDELT(d)] & __FDMASK(d))
-
-#undef	__FD_ZERO
-#define __FD_ZERO(fdsetp) (memset (fdsetp, 0, sizeof(*(fd_set *)fdsetp)))
-
-#endif /* defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2) */
-
 #endif
diff --git a/include/asm-i386/posix_types.h b/include/asm-i386/posix_types.h
index 4e47ed0..7148932 100644
--- a/include/asm-i386/posix_types.h
+++ b/include/asm-i386/posix_types.h
@@ -1,6 +1,8 @@
 #ifndef __ARCH_I386_POSIX_TYPES_H
 #define __ARCH_I386_POSIX_TYPES_H
 
+#include <linux/fdset.h>
+
 /*
  * This file is generally used by user-level software, so you need to
  * be a little careful about namespace pollution etc.  Also, we cannot
@@ -46,37 +48,4 @@ typedef struct {
 #endif /* !defined(__KERNEL__) && !defined(__USE_ALL) */
 } __kernel_fsid_t;
 
-#if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)
-
-#undef	__FD_SET
-#define __FD_SET(fd,fdsetp) \
-		__asm__ __volatile__("btsl %1,%0": \
-			"=m" (*(__kernel_fd_set *) (fdsetp)):"r" ((int) (fd)))
-
-#undef	__FD_CLR
-#define __FD_CLR(fd,fdsetp) \
-		__asm__ __volatile__("btrl %1,%0": \
-			"=m" (*(__kernel_fd_set *) (fdsetp)):"r" ((int) (fd)))
-
-#undef	__FD_ISSET
-#define __FD_ISSET(fd,fdsetp) (__extension__ ({ \
-		unsigned char __result; \
-		__asm__ __volatile__("btl %1,%2 ; setb %0" \
-			:"=q" (__result) :"r" ((int) (fd)), \
-			"m" (*(__kernel_fd_set *) (fdsetp))); \
-		__result; }))
-
-#undef	__FD_ZERO
-#define __FD_ZERO(fdsetp) \
-do { \
-	int __d0, __d1; \
-	__asm__ __volatile__("cld ; rep ; stosl" \
-			:"=m" (*(__kernel_fd_set *) (fdsetp)), \
-			  "=&c" (__d0), "=&D" (__d1) \
-			:"a" (0), "1" (__FDSET_LONGS), \
-			"2" ((__kernel_fd_set *) (fdsetp)) : "memory"); \
-} while (0)
-
-#endif /* defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2) */
-
 #endif
diff --git a/include/asm-ia64/posix_types.h b/include/asm-ia64/posix_types.h
index adb6227..15a0ad7 100644
--- a/include/asm-ia64/posix_types.h
+++ b/include/asm-ia64/posix_types.h
@@ -1,6 +1,8 @@
 #ifndef _ASM_IA64_POSIX_TYPES_H
 #define _ASM_IA64_POSIX_TYPES_H
 
+#include <linux/fdset.h>
+
 /*
  * This file is generally used by user-level software, so you need to
  * be a little careful about namespace pollution etc.  Also, we cannot
@@ -46,81 +48,4 @@ typedef __kernel_gid_t __kernel_gid32_t;
 
 typedef unsigned int	__kernel_old_dev_t;
 
-# ifdef __KERNEL__
-
-#  ifndef __GNUC__
-
-#define	__FD_SET(d, set)	((set)->fds_bits[__FDELT(d)] |= __FDMASK(d))
-#define	__FD_CLR(d, set)	((set)->fds_bits[__FDELT(d)] &= ~__FDMASK(d))
-#define	__FD_ISSET(d, set)	(((set)->fds_bits[__FDELT(d)] & __FDMASK(d)) != 0)
-#define	__FD_ZERO(set)	\
-  ((void) memset ((__ptr_t) (set), 0, sizeof (__kernel_fd_set)))
-
-#  else /* !__GNUC__ */
-
-/* With GNU C, use inline functions instead so args are evaluated only once: */
-
-#undef __FD_SET
-static __inline__ void __FD_SET(unsigned long fd, __kernel_fd_set *fdsetp)
-{
-	unsigned long _tmp = fd / __NFDBITS;
-	unsigned long _rem = fd % __NFDBITS;
-	fdsetp->fds_bits[_tmp] |= (1UL<<_rem);
-}
-
-#undef __FD_CLR
-static __inline__ void __FD_CLR(unsigned long fd, __kernel_fd_set *fdsetp)
-{
-	unsigned long _tmp = fd / __NFDBITS;
-	unsigned long _rem = fd % __NFDBITS;
-	fdsetp->fds_bits[_tmp] &= ~(1UL<<_rem);
-}
-
-#undef __FD_ISSET
-static __inline__ int __FD_ISSET(unsigned long fd, const __kernel_fd_set *p)
-{ 
-	unsigned long _tmp = fd / __NFDBITS;
-	unsigned long _rem = fd % __NFDBITS;
-	return (p->fds_bits[_tmp] & (1UL<<_rem)) != 0;
-}
-
-/*
- * This will unroll the loop for the normal constant case (8 ints,
- * for a 256-bit fd_set)
- */
-#undef __FD_ZERO
-static __inline__ void __FD_ZERO(__kernel_fd_set *p)
-{
-	unsigned long *tmp = p->fds_bits;
-	int i;
-
-	if (__builtin_constant_p(__FDSET_LONGS)) {
-		switch (__FDSET_LONGS) {
-		      case 16:
-			tmp[ 0] = 0; tmp[ 1] = 0; tmp[ 2] = 0; tmp[ 3] = 0;
-			tmp[ 4] = 0; tmp[ 5] = 0; tmp[ 6] = 0; tmp[ 7] = 0;
-			tmp[ 8] = 0; tmp[ 9] = 0; tmp[10] = 0; tmp[11] = 0;
-			tmp[12] = 0; tmp[13] = 0; tmp[14] = 0; tmp[15] = 0;
-			return;
-
-		      case 8:
-			tmp[ 0] = 0; tmp[ 1] = 0; tmp[ 2] = 0; tmp[ 3] = 0;
-			tmp[ 4] = 0; tmp[ 5] = 0; tmp[ 6] = 0; tmp[ 7] = 0;
-			return;
-
-		      case 4:
-			tmp[ 0] = 0; tmp[ 1] = 0; tmp[ 2] = 0; tmp[ 3] = 0;
-			return;
-		}
-	}
-	i = __FDSET_LONGS;
-	while (i) {
-		i--;
-		*tmp = 0;
-		tmp++;
-	}
-}
-
-#  endif /* !__GNUC__ */
-# endif /* __KERNEL__ */
 #endif /* _ASM_IA64_POSIX_TYPES_H */
diff --git a/include/asm-m32r/posix_types.h b/include/asm-m32r/posix_types.h
index 47e7e85..e79af7d 100644
--- a/include/asm-m32r/posix_types.h
+++ b/include/asm-m32r/posix_types.h
@@ -1,6 +1,8 @@
 #ifndef _ASM_M32R_POSIX_TYPES_H
 #define _ASM_M32R_POSIX_TYPES_H
 
+#include <linux/fdset.h>
+
 /* $Id$ */
 
 /* orig : i386, sh 2.4.18 */
@@ -50,77 +52,4 @@ typedef struct {
 #endif /* !defined(__KERNEL__) && !defined(__USE_ALL) */
 } __kernel_fsid_t;
 
-#if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)
-
-#undef	__FD_SET
-static __inline__ void __FD_SET(unsigned long __fd, __kernel_fd_set *__fdsetp)
-{
-	unsigned long __tmp = __fd / __NFDBITS;
-	unsigned long __rem = __fd % __NFDBITS;
-	__fdsetp->fds_bits[__tmp] |= (1UL<<__rem);
-}
-
-#undef	__FD_CLR
-static __inline__ void __FD_CLR(unsigned long __fd, __kernel_fd_set *__fdsetp)
-{
-	unsigned long __tmp = __fd / __NFDBITS;
-	unsigned long __rem = __fd % __NFDBITS;
-	__fdsetp->fds_bits[__tmp] &= ~(1UL<<__rem);
-}
-
-
-#undef	__FD_ISSET
-static __inline__ int __FD_ISSET(unsigned long __fd, const __kernel_fd_set *__p)
-{
-	unsigned long __tmp = __fd / __NFDBITS;
-	unsigned long __rem = __fd % __NFDBITS;
-	return (__p->fds_bits[__tmp] & (1UL<<__rem)) != 0;
-}
-
-/*
- * This will unroll the loop for the normal constant case (8 ints,
- * for a 256-bit fd_set)
- */
-#undef	__FD_ZERO
-static __inline__ void __FD_ZERO(__kernel_fd_set *__p)
-{
-	unsigned long *__tmp = __p->fds_bits;
-	int __i;
-
-	if (__builtin_constant_p(__FDSET_LONGS)) {
-		switch (__FDSET_LONGS) {
-		case 16:
-			__tmp[ 0] = 0; __tmp[ 1] = 0;
-			__tmp[ 2] = 0; __tmp[ 3] = 0;
-			__tmp[ 4] = 0; __tmp[ 5] = 0;
-			__tmp[ 6] = 0; __tmp[ 7] = 0;
-			__tmp[ 8] = 0; __tmp[ 9] = 0;
-			__tmp[10] = 0; __tmp[11] = 0;
-			__tmp[12] = 0; __tmp[13] = 0;
-			__tmp[14] = 0; __tmp[15] = 0;
-			return;
-
-		case 8:
-			__tmp[ 0] = 0; __tmp[ 1] = 0;
-			__tmp[ 2] = 0; __tmp[ 3] = 0;
-			__tmp[ 4] = 0; __tmp[ 5] = 0;
-			__tmp[ 6] = 0; __tmp[ 7] = 0;
-			return;
-
-		case 4:
-			__tmp[ 0] = 0; __tmp[ 1] = 0;
-			__tmp[ 2] = 0; __tmp[ 3] = 0;
-			return;
-		}
-	}
-	__i = __FDSET_LONGS;
-	while (__i) {
-		__i--;
-		*__tmp = 0;
-		__tmp++;
-	}
-}
-
-#endif /* defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2) */
-
 #endif  /* _ASM_M32R_POSIX_TYPES_H */
diff --git a/include/asm-m68k/posix_types.h b/include/asm-m68k/posix_types.h
index fa166ee..39b1b77 100644
--- a/include/asm-m68k/posix_types.h
+++ b/include/asm-m68k/posix_types.h
@@ -1,6 +1,8 @@
 #ifndef __ARCH_M68K_POSIX_TYPES_H
 #define __ARCH_M68K_POSIX_TYPES_H
 
+#include <linux/fdset.h>
+
 /*
  * This file is generally used by user-level software, so you need to
  * be a little careful about namespace pollution etc.  Also, we cannot
@@ -46,20 +48,4 @@ typedef struct {
 #endif /* !defined(__KERNEL__) && !defined(__USE_ALL) */
 } __kernel_fsid_t;
 
-#if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)
-
-#undef	__FD_SET
-#define	__FD_SET(d, set)	((set)->fds_bits[__FDELT(d)] |= __FDMASK(d))
-
-#undef	__FD_CLR
-#define	__FD_CLR(d, set)	((set)->fds_bits[__FDELT(d)] &= ~__FDMASK(d))
-
-#undef	__FD_ISSET
-#define	__FD_ISSET(d, set)	((set)->fds_bits[__FDELT(d)] & __FDMASK(d))
-
-#undef	__FD_ZERO
-#define __FD_ZERO(fdsetp) (memset (fdsetp, 0, sizeof(*(fd_set *)fdsetp)))
-
-#endif /* defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2) */
-
 #endif
diff --git a/include/asm-mips/posix_types.h b/include/asm-mips/posix_types.h
index c2e8a00..01ad0d7 100644
--- a/include/asm-mips/posix_types.h
+++ b/include/asm-mips/posix_types.h
@@ -10,6 +10,7 @@
 #define _ASM_POSIX_TYPES_H
 
 #include <asm/sgidefs.h>
+#include <linux/fdset.h>
 
 /*
  * This file is generally used by user-level software, so you need to
@@ -69,76 +70,4 @@ typedef struct {
 #endif
 } __kernel_fsid_t;
 
-#if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)
-
-#undef __FD_SET
-static __inline__ void __FD_SET(unsigned long __fd, __kernel_fd_set *__fdsetp)
-{
-	unsigned long __tmp = __fd / __NFDBITS;
-	unsigned long __rem = __fd % __NFDBITS;
-	__fdsetp->fds_bits[__tmp] |= (1UL<<__rem);
-}
-
-#undef __FD_CLR
-static __inline__ void __FD_CLR(unsigned long __fd, __kernel_fd_set *__fdsetp)
-{
-	unsigned long __tmp = __fd / __NFDBITS;
-	unsigned long __rem = __fd % __NFDBITS;
-	__fdsetp->fds_bits[__tmp] &= ~(1UL<<__rem);
-}
-
-#undef __FD_ISSET
-static __inline__ int __FD_ISSET(unsigned long __fd, const __kernel_fd_set *__p)
-{
-	unsigned long __tmp = __fd / __NFDBITS;
-	unsigned long __rem = __fd % __NFDBITS;
-	return (__p->fds_bits[__tmp] & (1UL<<__rem)) != 0;
-}
-
-/*
- * This will unroll the loop for the normal constant case (8 ints,
- * for a 256-bit fd_set)
- */
-#undef __FD_ZERO
-static __inline__ void __FD_ZERO(__kernel_fd_set *__p)
-{
-	unsigned long *__tmp = __p->fds_bits;
-	int __i;
-
-	if (__builtin_constant_p(__FDSET_LONGS)) {
-		switch (__FDSET_LONGS) {
-		case 16:
-			__tmp[ 0] = 0; __tmp[ 1] = 0;
-			__tmp[ 2] = 0; __tmp[ 3] = 0;
-			__tmp[ 4] = 0; __tmp[ 5] = 0;
-			__tmp[ 6] = 0; __tmp[ 7] = 0;
-			__tmp[ 8] = 0; __tmp[ 9] = 0;
-			__tmp[10] = 0; __tmp[11] = 0;
-			__tmp[12] = 0; __tmp[13] = 0;
-			__tmp[14] = 0; __tmp[15] = 0;
-			return;
-
-		case 8:
-			__tmp[ 0] = 0; __tmp[ 1] = 0;
-			__tmp[ 2] = 0; __tmp[ 3] = 0;
-			__tmp[ 4] = 0; __tmp[ 5] = 0;
-			__tmp[ 6] = 0; __tmp[ 7] = 0;
-			return;
-
-		case 4:
-			__tmp[ 0] = 0; __tmp[ 1] = 0;
-			__tmp[ 2] = 0; __tmp[ 3] = 0;
-			return;
-		}
-	}
-	__i = __FDSET_LONGS;
-	while (__i) {
-		__i--;
-		*__tmp = 0;
-		__tmp++;
-	}
-}
-
-#endif /* defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2) */
-
 #endif /* _ASM_POSIX_TYPES_H */
diff --git a/include/asm-parisc/posix_types.h b/include/asm-parisc/posix_types.h
index 9b19970..c58df37 100644
--- a/include/asm-parisc/posix_types.h
+++ b/include/asm-parisc/posix_types.h
@@ -1,6 +1,8 @@
 #ifndef __ARCH_PARISC_POSIX_TYPES_H
 #define __ARCH_PARISC_POSIX_TYPES_H
 
+#include <linux/fdset.h>
+
 /*
  * This file is generally used by user-level software, so you need to
  * be a little careful about namespace pollution etc.  Also, we cannot
@@ -58,76 +60,4 @@ typedef struct {
 typedef __kernel_uid_t __kernel_old_uid_t;
 typedef __kernel_gid_t __kernel_old_gid_t;
 
-#if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)
-
-#undef __FD_SET
-static __inline__ void __FD_SET(unsigned long __fd, __kernel_fd_set *__fdsetp)
-{
-	unsigned long __tmp = __fd / __NFDBITS;
-	unsigned long __rem = __fd % __NFDBITS;
-	__fdsetp->fds_bits[__tmp] |= (1UL<<__rem);
-}
-
-#undef __FD_CLR
-static __inline__ void __FD_CLR(unsigned long __fd, __kernel_fd_set *__fdsetp)
-{
-	unsigned long __tmp = __fd / __NFDBITS;
-	unsigned long __rem = __fd % __NFDBITS;
-	__fdsetp->fds_bits[__tmp] &= ~(1UL<<__rem);
-}
-
-#undef __FD_ISSET
-static __inline__ int __FD_ISSET(unsigned long __fd, const __kernel_fd_set *__p)
-{ 
-	unsigned long __tmp = __fd / __NFDBITS;
-	unsigned long __rem = __fd % __NFDBITS;
-	return (__p->fds_bits[__tmp] & (1UL<<__rem)) != 0;
-}
-
-/*
- * This will unroll the loop for the normal constant case (8 ints,
- * for a 256-bit fd_set)
- */
-#undef __FD_ZERO
-static __inline__ void __FD_ZERO(__kernel_fd_set *__p)
-{
-	unsigned long *__tmp = __p->fds_bits;
-	int __i;
-
-	if (__builtin_constant_p(__FDSET_LONGS)) {
-		switch (__FDSET_LONGS) {
-		case 16:
-			__tmp[ 0] = 0; __tmp[ 1] = 0;
-			__tmp[ 2] = 0; __tmp[ 3] = 0;
-			__tmp[ 4] = 0; __tmp[ 5] = 0;
-			__tmp[ 6] = 0; __tmp[ 7] = 0;
-			__tmp[ 8] = 0; __tmp[ 9] = 0;
-			__tmp[10] = 0; __tmp[11] = 0;
-			__tmp[12] = 0; __tmp[13] = 0;
-			__tmp[14] = 0; __tmp[15] = 0;
-			return;
-
-		case 8:
-			__tmp[ 0] = 0; __tmp[ 1] = 0;
-			__tmp[ 2] = 0; __tmp[ 3] = 0;
-			__tmp[ 4] = 0; __tmp[ 5] = 0;
-			__tmp[ 6] = 0; __tmp[ 7] = 0;
-			return;
-
-		case 4:
-			__tmp[ 0] = 0; __tmp[ 1] = 0;
-			__tmp[ 2] = 0; __tmp[ 3] = 0;
-			return;
-		}
-	}
-	__i = __FDSET_LONGS;
-	while (__i) {
-		__i--;
-		*__tmp = 0;
-		__tmp++;
-	}
-}
-
-#endif /* defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2) */
-
 #endif
diff --git a/include/asm-powerpc/posix_types.h b/include/asm-powerpc/posix_types.h
index c639107..7de6c18 100644
--- a/include/asm-powerpc/posix_types.h
+++ b/include/asm-powerpc/posix_types.h
@@ -1,6 +1,8 @@
 #ifndef _ASM_POWERPC_POSIX_TYPES_H
 #define _ASM_POWERPC_POSIX_TYPES_H
 
+#include <linux/fdset.h>
+
 /*
  * This file is generally used by user-level software, so you need to
  * be a little careful about namespace pollution etc.  Also, we cannot
@@ -54,76 +56,4 @@ typedef struct {
 	int	val[2];
 } __kernel_fsid_t;
 
-#ifndef __GNUC__
-
-#define	__FD_SET(d, set)	((set)->fds_bits[__FDELT(d)] |= __FDMASK(d))
-#define	__FD_CLR(d, set)	((set)->fds_bits[__FDELT(d)] &= ~__FDMASK(d))
-#define	__FD_ISSET(d, set)	(((set)->fds_bits[__FDELT(d)] & __FDMASK(d)) != 0)
-#define	__FD_ZERO(set)	\
-  ((void) memset ((__ptr_t) (set), 0, sizeof (__kernel_fd_set)))
-
-#else /* __GNUC__ */
-
-#if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2) \
-    || (__GLIBC__ == 2 && __GLIBC_MINOR__ == 0)
-/* With GNU C, use inline functions instead so args are evaluated only once: */
-
-#undef __FD_SET
-static __inline__ void __FD_SET(unsigned long fd, __kernel_fd_set *fdsetp)
-{
-	unsigned long _tmp = fd / __NFDBITS;
-	unsigned long _rem = fd % __NFDBITS;
-	fdsetp->fds_bits[_tmp] |= (1UL<<_rem);
-}
-
-#undef __FD_CLR
-static __inline__ void __FD_CLR(unsigned long fd, __kernel_fd_set *fdsetp)
-{
-	unsigned long _tmp = fd / __NFDBITS;
-	unsigned long _rem = fd % __NFDBITS;
-	fdsetp->fds_bits[_tmp] &= ~(1UL<<_rem);
-}
-
-#undef __FD_ISSET
-static __inline__ int __FD_ISSET(unsigned long fd, __kernel_fd_set *p)
-{ 
-	unsigned long _tmp = fd / __NFDBITS;
-	unsigned long _rem = fd % __NFDBITS;
-	return (p->fds_bits[_tmp] & (1UL<<_rem)) != 0;
-}
-
-/*
- * This will unroll the loop for the normal constant case (8 ints,
- * for a 256-bit fd_set)
- */
-#undef __FD_ZERO
-static __inline__ void __FD_ZERO(__kernel_fd_set *p)
-{
-	unsigned long *tmp = (unsigned long *)p->fds_bits;
-	int i;
-
-	if (__builtin_constant_p(__FDSET_LONGS)) {
-		switch (__FDSET_LONGS) {
-		      case 16:
-			tmp[12] = 0; tmp[13] = 0; tmp[14] = 0; tmp[15] = 0;
-			tmp[ 8] = 0; tmp[ 9] = 0; tmp[10] = 0; tmp[11] = 0;
-
-		      case 8:
-			tmp[ 4] = 0; tmp[ 5] = 0; tmp[ 6] = 0; tmp[ 7] = 0;
-
-		      case 4:
-			tmp[ 0] = 0; tmp[ 1] = 0; tmp[ 2] = 0; tmp[ 3] = 0;
-			return;
-		}
-	}
-	i = __FDSET_LONGS;
-	while (i) {
-		i--;
-		*tmp = 0;
-		tmp++;
-	}
-}
-
-#endif /* defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2) */
-#endif /* __GNUC__ */
 #endif /* _ASM_POWERPC_POSIX_TYPES_H */
diff --git a/include/asm-s390/posix_types.h b/include/asm-s390/posix_types.h
index 61788de..6cf74f1 100644
--- a/include/asm-s390/posix_types.h
+++ b/include/asm-s390/posix_types.h
@@ -9,6 +9,8 @@
 #ifndef __ARCH_S390_POSIX_TYPES_H
 #define __ARCH_S390_POSIX_TYPES_H
 
+#include <linux/fdset.h>
+
 /*
  * This file is generally used by user-level software, so you need to
  * be a little careful about namespace pollution etc.  Also, we cannot
@@ -75,25 +77,4 @@ typedef struct {
 #endif                       /* !defined(__KERNEL__) && !defined(__USE_ALL)*/
 } __kernel_fsid_t;
 
-
-#if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)
-
-#ifndef _S390_BITOPS_H
-#include <asm/bitops.h>
-#endif
-
-#undef  __FD_SET
-#define __FD_SET(fd,fdsetp)  set_bit((fd),(fdsetp)->fds_bits)
-
-#undef  __FD_CLR
-#define __FD_CLR(fd,fdsetp)  clear_bit((fd),(fdsetp)->fds_bits)
-
-#undef  __FD_ISSET
-#define __FD_ISSET(fd,fdsetp)  test_bit((fd),(fdsetp)->fds_bits)
-
-#undef  __FD_ZERO
-#define __FD_ZERO(fdsetp) (memset ((fdsetp), 0, sizeof(*(fd_set *)(fdsetp))))
-
-#endif     /* defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)*/
-
 #endif
diff --git a/include/asm-sh/posix_types.h b/include/asm-sh/posix_types.h
index 0a3d2f5..4db22df 100644
--- a/include/asm-sh/posix_types.h
+++ b/include/asm-sh/posix_types.h
@@ -1,6 +1,8 @@
 #ifndef __ASM_SH_POSIX_TYPES_H
 #define __ASM_SH_POSIX_TYPES_H
 
+#include <linux/fdset.h>
+
 /*
  * This file is generally used by user-level software, so you need to
  * be a little careful about namespace pollution etc.  Also, we cannot
@@ -46,77 +48,4 @@ typedef struct {
 #endif /* !defined(__KERNEL__) && !defined(__USE_ALL) */
 } __kernel_fsid_t;
 
-#if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)
-
-#undef	__FD_SET
-static __inline__ void __FD_SET(unsigned long __fd, __kernel_fd_set *__fdsetp)
-{
-	unsigned long __tmp = __fd / __NFDBITS;
-	unsigned long __rem = __fd % __NFDBITS;
-	__fdsetp->fds_bits[__tmp] |= (1UL<<__rem);
-}
-
-#undef	__FD_CLR
-static __inline__ void __FD_CLR(unsigned long __fd, __kernel_fd_set *__fdsetp)
-{
-	unsigned long __tmp = __fd / __NFDBITS;
-	unsigned long __rem = __fd % __NFDBITS;
-	__fdsetp->fds_bits[__tmp] &= ~(1UL<<__rem);
-}
-
-
-#undef	__FD_ISSET
-static __inline__ int __FD_ISSET(unsigned long __fd, const __kernel_fd_set *__p)
-{ 
-	unsigned long __tmp = __fd / __NFDBITS;
-	unsigned long __rem = __fd % __NFDBITS;
-	return (__p->fds_bits[__tmp] & (1UL<<__rem)) != 0;
-}
-
-/*
- * This will unroll the loop for the normal constant case (8 ints,
- * for a 256-bit fd_set)
- */
-#undef	__FD_ZERO
-static __inline__ void __FD_ZERO(__kernel_fd_set *__p)
-{
-	unsigned long *__tmp = __p->fds_bits;
-	int __i;
-
-	if (__builtin_constant_p(__FDSET_LONGS)) {
-		switch (__FDSET_LONGS) {
-		case 16:
-			__tmp[ 0] = 0; __tmp[ 1] = 0;
-			__tmp[ 2] = 0; __tmp[ 3] = 0;
-			__tmp[ 4] = 0; __tmp[ 5] = 0;
-			__tmp[ 6] = 0; __tmp[ 7] = 0;
-			__tmp[ 8] = 0; __tmp[ 9] = 0;
-			__tmp[10] = 0; __tmp[11] = 0;
-			__tmp[12] = 0; __tmp[13] = 0;
-			__tmp[14] = 0; __tmp[15] = 0;
-			return;
-
-		case 8:
-			__tmp[ 0] = 0; __tmp[ 1] = 0;
-			__tmp[ 2] = 0; __tmp[ 3] = 0;
-			__tmp[ 4] = 0; __tmp[ 5] = 0;
-			__tmp[ 6] = 0; __tmp[ 7] = 0;
-			return;
-
-		case 4:
-			__tmp[ 0] = 0; __tmp[ 1] = 0;
-			__tmp[ 2] = 0; __tmp[ 3] = 0;
-			return;
-		}
-	}
-	__i = __FDSET_LONGS;
-	while (__i) {
-		__i--;
-		*__tmp = 0;
-		__tmp++;
-	}
-}
-
-#endif /* defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2) */
-
 #endif /* __ASM_SH_POSIX_TYPES_H */
diff --git a/include/asm-sh64/posix_types.h b/include/asm-sh64/posix_types.h
index 0620317..97448be 100644
--- a/include/asm-sh64/posix_types.h
+++ b/include/asm-sh64/posix_types.h
@@ -1,6 +1,8 @@
 #ifndef __ASM_SH64_POSIX_TYPES_H
 #define __ASM_SH64_POSIX_TYPES_H
 
+#include <linux/fdset.h>
+
 /*
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
@@ -55,77 +57,4 @@ typedef struct {
 #endif /* !defined(__KERNEL__) && !defined(__USE_ALL) */
 } __kernel_fsid_t;
 
-#if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)
-
-#undef	__FD_SET
-static __inline__ void __FD_SET(unsigned long __fd, __kernel_fd_set *__fdsetp)
-{
-	unsigned long __tmp = __fd / __NFDBITS;
-	unsigned long __rem = __fd % __NFDBITS;
-	__fdsetp->fds_bits[__tmp] |= (1UL<<__rem);
-}
-
-#undef	__FD_CLR
-static __inline__ void __FD_CLR(unsigned long __fd, __kernel_fd_set *__fdsetp)
-{
-	unsigned long __tmp = __fd / __NFDBITS;
-	unsigned long __rem = __fd % __NFDBITS;
-	__fdsetp->fds_bits[__tmp] &= ~(1UL<<__rem);
-}
-
-
-#undef	__FD_ISSET
-static __inline__ int __FD_ISSET(unsigned long __fd, const __kernel_fd_set *__p)
-{
-	unsigned long __tmp = __fd / __NFDBITS;
-	unsigned long __rem = __fd % __NFDBITS;
-	return (__p->fds_bits[__tmp] & (1UL<<__rem)) != 0;
-}
-
-/*
- * This will unroll the loop for the normal constant case (8 ints,
- * for a 256-bit fd_set)
- */
-#undef	__FD_ZERO
-static __inline__ void __FD_ZERO(__kernel_fd_set *__p)
-{
-	unsigned long *__tmp = __p->fds_bits;
-	int __i;
-
-	if (__builtin_constant_p(__FDSET_LONGS)) {
-		switch (__FDSET_LONGS) {
-		case 16:
-			__tmp[ 0] = 0; __tmp[ 1] = 0;
-			__tmp[ 2] = 0; __tmp[ 3] = 0;
-			__tmp[ 4] = 0; __tmp[ 5] = 0;
-			__tmp[ 6] = 0; __tmp[ 7] = 0;
-			__tmp[ 8] = 0; __tmp[ 9] = 0;
-			__tmp[10] = 0; __tmp[11] = 0;
-			__tmp[12] = 0; __tmp[13] = 0;
-			__tmp[14] = 0; __tmp[15] = 0;
-			return;
-
-		case 8:
-			__tmp[ 0] = 0; __tmp[ 1] = 0;
-			__tmp[ 2] = 0; __tmp[ 3] = 0;
-			__tmp[ 4] = 0; __tmp[ 5] = 0;
-			__tmp[ 6] = 0; __tmp[ 7] = 0;
-			return;
-
-		case 4:
-			__tmp[ 0] = 0; __tmp[ 1] = 0;
-			__tmp[ 2] = 0; __tmp[ 3] = 0;
-			return;
-		}
-	}
-	__i = __FDSET_LONGS;
-	while (__i) {
-		__i--;
-		*__tmp = 0;
-		__tmp++;
-	}
-}
-
-#endif /* defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2) */
-
 #endif /* __ASM_SH64_POSIX_TYPES_H */
diff --git a/include/asm-sparc/posix_types.h b/include/asm-sparc/posix_types.h
index 9ef1b3d..6e6b39e 100644
--- a/include/asm-sparc/posix_types.h
+++ b/include/asm-sparc/posix_types.h
@@ -1,6 +1,8 @@
 #ifndef __ARCH_SPARC_POSIX_TYPES_H
 #define __ARCH_SPARC_POSIX_TYPES_H
 
+#include <linux/fdset.h>
+
 /*
  * This file is generally used by user-level software, so you need to
  * be a little careful about namespace pollution etc.  Also, we cannot
@@ -46,77 +48,4 @@ typedef struct {
 #endif /* !defined(__KERNEL__) && !defined(__USE_ALL) */
 } __kernel_fsid_t;
 
-#if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)
-
-#undef __FD_SET
-static __inline__ void __FD_SET(unsigned long fd, __kernel_fd_set *fdsetp)
-{
-	unsigned long _tmp = fd / __NFDBITS;
-	unsigned long _rem = fd % __NFDBITS;
-	fdsetp->fds_bits[_tmp] |= (1UL<<_rem);
-}
-
-#undef __FD_CLR
-static __inline__ void __FD_CLR(unsigned long fd, __kernel_fd_set *fdsetp)
-{
-	unsigned long _tmp = fd / __NFDBITS;
-	unsigned long _rem = fd % __NFDBITS;
-	fdsetp->fds_bits[_tmp] &= ~(1UL<<_rem);
-}
-
-#undef __FD_ISSET
-static __inline__ int __FD_ISSET(unsigned long fd, __const__ __kernel_fd_set *p)
-{ 
-	unsigned long _tmp = fd / __NFDBITS;
-	unsigned long _rem = fd % __NFDBITS;
-	return (p->fds_bits[_tmp] & (1UL<<_rem)) != 0;
-}
-
-/*
- * This will unroll the loop for the normal constant cases (8 or 32 longs,
- * for 256 and 1024-bit fd_sets respectively)
- */
-#undef __FD_ZERO
-static __inline__ void __FD_ZERO(__kernel_fd_set *p)
-{
-	unsigned long *tmp = p->fds_bits;
-	int i;
-
-	if (__builtin_constant_p(__FDSET_LONGS)) {
-		switch (__FDSET_LONGS) {
-			case 32:
-			  tmp[ 0] = 0; tmp[ 1] = 0; tmp[ 2] = 0; tmp[ 3] = 0;
-			  tmp[ 4] = 0; tmp[ 5] = 0; tmp[ 6] = 0; tmp[ 7] = 0;
-			  tmp[ 8] = 0; tmp[ 9] = 0; tmp[10] = 0; tmp[11] = 0;
-			  tmp[12] = 0; tmp[13] = 0; tmp[14] = 0; tmp[15] = 0;
-			  tmp[16] = 0; tmp[17] = 0; tmp[18] = 0; tmp[19] = 0;
-			  tmp[20] = 0; tmp[21] = 0; tmp[22] = 0; tmp[23] = 0;
-			  tmp[24] = 0; tmp[25] = 0; tmp[26] = 0; tmp[27] = 0;
-			  tmp[28] = 0; tmp[29] = 0; tmp[30] = 0; tmp[31] = 0;
-			  return;
-			case 16:
-			  tmp[ 0] = 0; tmp[ 1] = 0; tmp[ 2] = 0; tmp[ 3] = 0;
-			  tmp[ 4] = 0; tmp[ 5] = 0; tmp[ 6] = 0; tmp[ 7] = 0;
-			  tmp[ 8] = 0; tmp[ 9] = 0; tmp[10] = 0; tmp[11] = 0;
-			  tmp[12] = 0; tmp[13] = 0; tmp[14] = 0; tmp[15] = 0;
-			  return;
-			case 8:
-			  tmp[ 0] = 0; tmp[ 1] = 0; tmp[ 2] = 0; tmp[ 3] = 0;
-			  tmp[ 4] = 0; tmp[ 5] = 0; tmp[ 6] = 0; tmp[ 7] = 0;
-			  return;
-			case 4:
-			  tmp[ 0] = 0; tmp[ 1] = 0; tmp[ 2] = 0; tmp[ 3] = 0;
-			  return;
-		}
-	}
-	i = __FDSET_LONGS;
-	while (i) {
-		i--;
-		*tmp = 0;
-		tmp++;
-	}
-}
-
-#endif /* defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2) */
-
 #endif /* !(__ARCH_SPARC_POSIX_TYPES_H) */
diff --git a/include/asm-sparc64/posix_types.h b/include/asm-sparc64/posix_types.h
index c86b945..3c99210 100644
--- a/include/asm-sparc64/posix_types.h
+++ b/include/asm-sparc64/posix_types.h
@@ -1,6 +1,8 @@
 #ifndef __ARCH_SPARC64_POSIX_TYPES_H
 #define __ARCH_SPARC64_POSIX_TYPES_H
 
+#include <linux/fdset.h>
+
 /*
  * This file is generally used by user-level software, so you need to
  * be a little careful about namespace pollution etc.  Also, we cannot
@@ -50,77 +52,4 @@ typedef struct {
 #endif /* !defined(__KERNEL__) && !defined(__USE_ALL) */
 } __kernel_fsid_t;
 
-#if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)
-
-#undef __FD_SET
-static __inline__ void __FD_SET(unsigned long fd, __kernel_fd_set *fdsetp)
-{
-	unsigned long _tmp = fd / __NFDBITS;
-	unsigned long _rem = fd % __NFDBITS;
-	fdsetp->fds_bits[_tmp] |= (1UL<<_rem);
-}
-
-#undef __FD_CLR
-static __inline__ void __FD_CLR(unsigned long fd, __kernel_fd_set *fdsetp)
-{
-	unsigned long _tmp = fd / __NFDBITS;
-	unsigned long _rem = fd % __NFDBITS;
-	fdsetp->fds_bits[_tmp] &= ~(1UL<<_rem);
-}
-
-#undef __FD_ISSET
-static __inline__ int __FD_ISSET(unsigned long fd, __const__ __kernel_fd_set *p)
-{ 
-	unsigned long _tmp = fd / __NFDBITS;
-	unsigned long _rem = fd % __NFDBITS;
-	return (p->fds_bits[_tmp] & (1UL<<_rem)) != 0;
-}
-
-/*
- * This will unroll the loop for the normal constant cases (8 or 32 longs,
- * for 256 and 1024-bit fd_sets respectively)
- */
-#undef __FD_ZERO
-static __inline__ void __FD_ZERO(__kernel_fd_set *p)
-{
-	unsigned long *tmp = p->fds_bits;
-	int i;
-
-	if (__builtin_constant_p(__FDSET_LONGS)) {
-		switch (__FDSET_LONGS) {
-			case 32:
-			  tmp[ 0] = 0; tmp[ 1] = 0; tmp[ 2] = 0; tmp[ 3] = 0;
-			  tmp[ 4] = 0; tmp[ 5] = 0; tmp[ 6] = 0; tmp[ 7] = 0;
-			  tmp[ 8] = 0; tmp[ 9] = 0; tmp[10] = 0; tmp[11] = 0;
-			  tmp[12] = 0; tmp[13] = 0; tmp[14] = 0; tmp[15] = 0;
-			  tmp[16] = 0; tmp[17] = 0; tmp[18] = 0; tmp[19] = 0;
-			  tmp[20] = 0; tmp[21] = 0; tmp[22] = 0; tmp[23] = 0;
-			  tmp[24] = 0; tmp[25] = 0; tmp[26] = 0; tmp[27] = 0;
-			  tmp[28] = 0; tmp[29] = 0; tmp[30] = 0; tmp[31] = 0;
-			  return;
-			case 16:
-			  tmp[ 0] = 0; tmp[ 1] = 0; tmp[ 2] = 0; tmp[ 3] = 0;
-			  tmp[ 4] = 0; tmp[ 5] = 0; tmp[ 6] = 0; tmp[ 7] = 0;
-			  tmp[ 8] = 0; tmp[ 9] = 0; tmp[10] = 0; tmp[11] = 0;
-			  tmp[12] = 0; tmp[13] = 0; tmp[14] = 0; tmp[15] = 0;
-			  return;
-			case 8:
-			  tmp[ 0] = 0; tmp[ 1] = 0; tmp[ 2] = 0; tmp[ 3] = 0;
-			  tmp[ 4] = 0; tmp[ 5] = 0; tmp[ 6] = 0; tmp[ 7] = 0;
-			  return;
-			case 4:
-			  tmp[ 0] = 0; tmp[ 1] = 0; tmp[ 2] = 0; tmp[ 3] = 0;
-			  return;
-		}
-	}
-	i = __FDSET_LONGS;
-	while (i) {
-		i--;
-		*tmp = 0;
-		tmp++;
-	}
-}
-
-#endif /* defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2) */
-
 #endif /* !(__ARCH_SPARC64_POSIX_TYPES_H) */
diff --git a/include/asm-v850/posix_types.h b/include/asm-v850/posix_types.h
index ccb7297..1c6e0bb 100644
--- a/include/asm-v850/posix_types.h
+++ b/include/asm-v850/posix_types.h
@@ -14,6 +14,8 @@
 #ifndef __V850_POSIX_TYPES_H__
 #define __V850_POSIX_TYPES_H__
 
+#include <linux/fdset.h>
+
 typedef unsigned long	__kernel_ino_t;
 typedef unsigned long long __kernel_ino64_t;
 typedef unsigned int	__kernel_mode_t;
@@ -52,25 +54,4 @@ typedef struct {
 } __kernel_fsid_t;
 
 
-#if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)
-
-/* We used to include <asm/bitops.h> here, which seems the right thing, but
-   it caused nasty include-file definition order problems.  Removing the
-   include seems to work, so fingers crossed...  */
-
-#undef	__FD_SET
-#define __FD_SET(fd, fd_set) \
-  __set_bit (fd, (void *)&((__kernel_fd_set *)fd_set)->fds_bits)
-#undef __FD_CLR
-#define __FD_CLR(fd, fd_set) \
-  __clear_bit (fd, (void *)&((__kernel_fd_set *)fd_set)->fds_bits)
-#undef	__FD_ISSET
-#define __FD_ISSET(fd, fd_set) \
-  __test_bit (fd, (void *)&((__kernel_fd_set *)fd_set)->fds_bits)
-#undef	__FD_ZERO
-#define __FD_ZERO(fd_set) \
-  memset (fd_set, 0, sizeof (*(fd_set *)fd_set))
-
-#endif /* defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2) */
-
 #endif /* __V850_POSIX_TYPES_H__ */
diff --git a/include/asm-x86_64/posix_types.h b/include/asm-x86_64/posix_types.h
index 9926aa4..ce54799 100644
--- a/include/asm-x86_64/posix_types.h
+++ b/include/asm-x86_64/posix_types.h
@@ -1,6 +1,8 @@
 #ifndef _ASM_X86_64_POSIX_TYPES_H
 #define _ASM_X86_64_POSIX_TYPES_H
 
+#include <linux/fdset.h>
+
 /*
  * This file is generally used by user-level software, so you need to
  * be a little careful about namespace pollution etc.  Also, we cannot
@@ -43,77 +45,4 @@ typedef __kernel_gid_t __kernel_gid32_t;
 
 typedef unsigned long	__kernel_old_dev_t;
 
-#ifdef __KERNEL__
-
-#undef __FD_SET
-static __inline__ void __FD_SET(unsigned long fd, __kernel_fd_set *fdsetp)
-{
-	unsigned long _tmp = fd / __NFDBITS;
-	unsigned long _rem = fd % __NFDBITS;
-	fdsetp->fds_bits[_tmp] |= (1UL<<_rem);
-}
-
-#undef __FD_CLR
-static __inline__ void __FD_CLR(unsigned long fd, __kernel_fd_set *fdsetp)
-{
-	unsigned long _tmp = fd / __NFDBITS;
-	unsigned long _rem = fd % __NFDBITS;
-	fdsetp->fds_bits[_tmp] &= ~(1UL<<_rem);
-}
-
-#undef __FD_ISSET
-static __inline__ int __FD_ISSET(unsigned long fd, __const__ __kernel_fd_set *p)
-{
-	unsigned long _tmp = fd / __NFDBITS;
-	unsigned long _rem = fd % __NFDBITS;
-	return (p->fds_bits[_tmp] & (1UL<<_rem)) != 0;
-}
-
-/*
- * This will unroll the loop for the normal constant cases (8 or 32 longs,
- * for 256 and 1024-bit fd_sets respectively)
- */
-#undef __FD_ZERO
-static __inline__ void __FD_ZERO(__kernel_fd_set *p)
-{
-	unsigned long *tmp = p->fds_bits;
-	int i;
-
-	if (__builtin_constant_p(__FDSET_LONGS)) {
-		switch (__FDSET_LONGS) {
-			case 32:
-			  tmp[ 0] = 0; tmp[ 1] = 0; tmp[ 2] = 0; tmp[ 3] = 0;
-			  tmp[ 4] = 0; tmp[ 5] = 0; tmp[ 6] = 0; tmp[ 7] = 0;
-			  tmp[ 8] = 0; tmp[ 9] = 0; tmp[10] = 0; tmp[11] = 0;
-			  tmp[12] = 0; tmp[13] = 0; tmp[14] = 0; tmp[15] = 0;
-			  tmp[16] = 0; tmp[17] = 0; tmp[18] = 0; tmp[19] = 0;
-			  tmp[20] = 0; tmp[21] = 0; tmp[22] = 0; tmp[23] = 0;
-			  tmp[24] = 0; tmp[25] = 0; tmp[26] = 0; tmp[27] = 0;
-			  tmp[28] = 0; tmp[29] = 0; tmp[30] = 0; tmp[31] = 0;
-			  return;
-			case 16:
-			  tmp[ 0] = 0; tmp[ 1] = 0; tmp[ 2] = 0; tmp[ 3] = 0;
-			  tmp[ 4] = 0; tmp[ 5] = 0; tmp[ 6] = 0; tmp[ 7] = 0;
-			  tmp[ 8] = 0; tmp[ 9] = 0; tmp[10] = 0; tmp[11] = 0;
-			  tmp[12] = 0; tmp[13] = 0; tmp[14] = 0; tmp[15] = 0;
-			  return;
-			case 8:
-			  tmp[ 0] = 0; tmp[ 1] = 0; tmp[ 2] = 0; tmp[ 3] = 0;
-			  tmp[ 4] = 0; tmp[ 5] = 0; tmp[ 6] = 0; tmp[ 7] = 0;
-			  return;
-			case 4:
-			  tmp[ 0] = 0; tmp[ 1] = 0; tmp[ 2] = 0; tmp[ 3] = 0;
-			  return;
-		}
-	}
-	i = __FDSET_LONGS;
-	while (i) {
-		i--;
-		*tmp = 0;
-		tmp++;
-	}
-}
-
-#endif /* defined(__KERNEL__) */
-
 #endif
diff --git a/include/asm-xtensa/posix_types.h b/include/asm-xtensa/posix_types.h
index 2c816b0..3d1309a 100644
--- a/include/asm-xtensa/posix_types.h
+++ b/include/asm-xtensa/posix_types.h
@@ -13,6 +13,8 @@
 #ifndef _XTENSA_POSIX_TYPES_H
 #define _XTENSA_POSIX_TYPES_H
 
+#include <linux/fdset.h>
+
 /*
  * This file is generally used by user-level software, so you need to
  * be a little careful about namespace pollution etc.  Also, we cannot
@@ -54,70 +56,4 @@ typedef struct {
 	int	val[2];
 } __kernel_fsid_t;
 
-#ifndef __GNUC__
-
-#define	__FD_SET(d, set)	((set)->fds_bits[__FDELT(d)] |= __FDMASK(d))
-#define	__FD_CLR(d, set)	((set)->fds_bits[__FDELT(d)] &= ~__FDMASK(d))
-#define	__FD_ISSET(d, set)	((set)->fds_bits[__FDELT(d)] & __FDMASK(d))
-#define	__FD_ZERO(set)	\
-  ((void) memset ((__ptr_t) (set), 0, sizeof (__kernel_fd_set)))
-
-#else /* __GNUC__ */
-
-#if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2) \
-    || (__GLIBC__ == 2 && __GLIBC_MINOR__ == 0)
-/* With GNU C, use inline functions instead so args are evaluated only once: */
-
-#undef __FD_SET
-static __inline__ void __FD_SET(unsigned long fd, __kernel_fd_set *fdsetp)
-{
-	unsigned long _tmp = fd / __NFDBITS;
-	unsigned long _rem = fd % __NFDBITS;
-	fdsetp->fds_bits[_tmp] |= (1UL<<_rem);
-}
-
-#undef __FD_CLR
-static __inline__ void __FD_CLR(unsigned long fd, __kernel_fd_set *fdsetp)
-{
-	unsigned long _tmp = fd / __NFDBITS;
-	unsigned long _rem = fd % __NFDBITS;
-	fdsetp->fds_bits[_tmp] &= ~(1UL<<_rem);
-}
-
-#undef __FD_ISSET
-static __inline__ int __FD_ISSET(unsigned long fd, __kernel_fd_set *p)
-{
-	unsigned long _tmp = fd / __NFDBITS;
-	unsigned long _rem = fd % __NFDBITS;
-	return (p->fds_bits[_tmp] & (1UL<<_rem)) != 0;
-}
-
-/*
- * This will unroll the loop for the normal constant case (8 ints,
- * for a 256-bit fd_set)
- */
-#undef __FD_ZERO
-static __inline__ void __FD_ZERO(__kernel_fd_set *p)
-{
-	unsigned int *tmp = (unsigned int *)p->fds_bits;
-	int i;
-
-	if (__builtin_constant_p(__FDSET_LONGS)) {
-		switch (__FDSET_LONGS) {
-			case 8:
-				tmp[0] = 0; tmp[1] = 0; tmp[2] = 0; tmp[3] = 0;
-				tmp[4] = 0; tmp[5] = 0; tmp[6] = 0; tmp[7] = 0;
-				return;
-		}
-	}
-	i = __FDSET_LONGS;
-	while (i) {
-		i--;
-		*tmp = 0;
-		tmp++;
-	}
-}
-
-#endif /* defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2) */
-#endif /* __GNUC__ */
 #endif /* _XTENSA_POSIX_TYPES_H */
diff --git a/include/kabi/fdset.h b/include/kabi/fdset.h
new file mode 100644
index 0000000..57a9df9
--- /dev/null
+++ b/include/kabi/fdset.h
@@ -0,0 +1,49 @@
+#ifndef  __KABI_FDSET_H
+# define __KABI_FDSET_H 1
+
+# include <kabi/arch/stddef.h>
+
+/*
+ * This allows for 1024 file descriptors: if NR_OPEN is ever grown beyond 
+ * that you'll have to change this too. But 1024 fd's seem to be enough even 
+ * for such "real" unices like OSF/1, so hopefully this is one limit that 
+ * doesn't have to be changed [again].
+ *
+ * TODO: This should probably use the generic bitops in some form, since it's 
+ * using unsigned longs (as do the generic bitops), and has an identical 
+ * in-memory layout on all architectures.
+ */
+
+# define __KABI_NFDBITS     __KABI_BITS_PER_LONG
+# define __KABI_FD_SETSIZE  (1024UL)
+# define __KABI_FDSET_LONGS (__KABI_FD_SETSIZE/__KABI_NFDBITS)
+# define __KABI_FDELT(fd)   ((fd)/__KABI_NFDBITS)
+# define __KABI_FDMASK(fd)  (1UL << ((fd) % __KABI_NFDBITS))
+
+typedef struct {
+	unsigned long fds_bits [__KABI_FDSET_LONGS];
+} __kabi_fd_set;
+
+static __inline__ void __KABI_FD_SET(unsigned long fd, __kabi_fd_set *p)
+{
+	p->fds_bits[__KABI_FDELT(fd)] |= __KABI_FDMASK(fd);
+}
+
+static __inline__ void __KABI_FD_CLR(unsigned long fd, __kabi_fd_set *p)
+{
+	p->fds_bits[__KABI_FDELT(fd)] &= ~__KABI_FDMASK(fd);
+}
+
+static __inline__ int __KABI_FD_ISSET(unsigned long fd, __kabi_fd_set *p)
+{
+	return !!(p->fds_bits[__KABI_FDELT(fd)] & __KABI_FDMASK(fd));
+}
+
+static __inline__ void __KABI_FD_ZERO(__kabi_fd_set *p)
+{
+	unsigned long i;
+	for (i = 0; i < __KABI_FDSET_LONGS; i++)
+		p->fds_bits[i] = 0;
+}
+
+#endif /* not __KABI_FDSET_H */
diff --git a/include/linux/fdset.h b/include/linux/fdset.h
new file mode 100644
index 0000000..1e92ba4
--- /dev/null
+++ b/include/linux/fdset.h
@@ -0,0 +1,15 @@
+#ifndef  __LINUX_FDSET_H
+# define __LINUX_FDSET_H 1
+
+# include <kabi/fdset.h>
+
+# define __NFDBITS		__KABI_NFDBITS
+# define __FD_SETSIZE		__KABI_FD_SETSIZE
+# define __FD_SET(fd,set)	__KABI_FD_SET(fd,set)
+# define __FD_CLR(fd,set)	__KABI_FD_CLR(fd,set)
+# define __FD_ISSET(fd,set)	__KABI_FD_ISSET(fd,set)
+# define __FD_ZERO(set)		__KABI_FD_ZERO(set)
+
+typedef __kabi_fd_set __kernel_fd_set;
+
+#endif /* not __LINUX_FDSET_H */
diff --git a/include/linux/posix_types.h b/include/linux/posix_types.h
index f04c98c..1b571da 100644
--- a/include/linux/posix_types.h
+++ b/include/linux/posix_types.h
@@ -2,40 +2,7 @@
 #define _LINUX_POSIX_TYPES_H
 
 #include <linux/stddef.h>
-
-/*
- * This allows for 1024 file descriptors: if NR_OPEN is ever grown
- * beyond that you'll have to change this too. But 1024 fd's seem to be
- * enough even for such "real" unices like OSF/1, so hopefully this is
- * one limit that doesn't have to be changed [again].
- *
- * Note that POSIX wants the FD_CLEAR(fd,fdsetp) defines to be in
- * <sys/time.h> (and thus <linux/time.h>) - but this is a more logical
- * place for them. Solved by having dummy defines in <sys/time.h>.
- */
-
-/*
- * Those macros may have been defined in <gnu/types.h>. But we always
- * use the ones here. 
- */
-#undef __NFDBITS
-#define __NFDBITS	(8 * sizeof(unsigned long))
-
-#undef __FD_SETSIZE
-#define __FD_SETSIZE	1024
-
-#undef __FDSET_LONGS
-#define __FDSET_LONGS	(__FD_SETSIZE/__NFDBITS)
-
-#undef __FDELT
-#define	__FDELT(d)	((d) / __NFDBITS)
-
-#undef __FDMASK
-#define	__FDMASK(d)	(1UL << ((d) % __NFDBITS))
-
-typedef struct {
-	unsigned long fds_bits [__FDSET_LONGS];
-} __kernel_fd_set;
+#include <linux/fdset.h>
 
 /* Type of a signal handler.  */
 typedef void (*__kernel_sighandler_t)(int);
diff --git a/include/linux/time.h b/include/linux/time.h
index bf0e785..e2dbfa9 100644
--- a/include/linux/time.h
+++ b/include/linux/time.h
@@ -150,13 +150,13 @@ extern struct timeval ns_to_timeval(cons
 
 #endif /* __KERNEL__ */
 
-#define NFDBITS			__NFDBITS
-
-#define FD_SETSIZE		__FD_SETSIZE
-#define FD_SET(fd,fdsetp)	__FD_SET(fd,fdsetp)
-#define FD_CLR(fd,fdsetp)	__FD_CLR(fd,fdsetp)
-#define FD_ISSET(fd,fdsetp)	__FD_ISSET(fd,fdsetp)
-#define FD_ZERO(fdsetp)		__FD_ZERO(fdsetp)
+#include <kabi/fdset.h>
+#define NFDBITS			__KABI_NFDBITS
+#define FD_SETSIZE		__KABI_FD_SETSIZE
+#define FD_SET(fd,set)		__KABI_FD_SET(fd,set)
+#define FD_CLR(fd,set)		__KABI_FD_CLR(fd,set)
+#define FD_ISSET(fd,set)	__KABI_FD_ISSET(fd,set)
+#define FD_ZERO(set)		__KABI_FD_ZERO(set)
 
 /*
  * Names of the interval timers, and structure
