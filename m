Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932422AbVKURtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbVKURtP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 12:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbVKURtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 12:49:14 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:22198 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S932419AbVKURtC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 12:49:02 -0500
Date: Mon, 21 Nov 2005 18:48:20 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 3/5] s390: uaccess warnings.
Message-ID: <20051121174820.GC9638@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[patch 3/5] s390: uaccess warnings.

Convert __access_ok to an inline C function and change __get_user
primitive to avoid uaccess compiler warnings.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

---

 arch/s390/kernel/compat_linux.c |    2 +-
 include/asm-s390/uaccess.h      |   14 ++++++++------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/compat_linux.c linux-2.6-patched/arch/s390/kernel/compat_linux.c
--- linux-2.6/arch/s390/kernel/compat_linux.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/compat_linux.c	2005-11-21 18:40:05.000000000 +0100
@@ -279,7 +279,7 @@ asmlinkage long sys32_getegid16(void)
 
 static inline long get_tv32(struct timeval *o, struct compat_timeval *i)
 {
-	return (!access_ok(VERIFY_READ, tv32, sizeof(*tv32)) ||
+	return (!access_ok(VERIFY_READ, o, sizeof(*o)) ||
 		(__get_user(o->tv_sec, &i->tv_sec) ||
 		 __get_user(o->tv_usec, &i->tv_usec)));
 }
diff -urpN linux-2.6/include/asm-s390/uaccess.h linux-2.6-patched/include/asm-s390/uaccess.h
--- linux-2.6/include/asm-s390/uaccess.h	2005-11-21 18:39:53.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/uaccess.h	2005-11-21 18:40:05.000000000 +0100
@@ -61,8 +61,10 @@
 #define segment_eq(a,b) ((a).ar4 == (b).ar4)
 
 
-#define __access_ok(addr,size) (1)
-
+static inline int __access_ok(const void *addr, unsigned long size)
+{
+	return 1;
+}
 #define access_ok(type,addr,size) __access_ok(addr,size)
 
 /*
@@ -206,25 +208,25 @@ extern int __put_user_bad(void) __attrib
 	case 1: {						\
 		unsigned char __x;				\
 		__get_user_asm(__x, ptr, __gu_err);		\
-		(x) = (__typeof__(*(ptr))) __x;			\
+		(x) = *(__typeof__(*(ptr)) *) &__x;		\
 		break;						\
 	};							\
 	case 2: {						\
 		unsigned short __x;				\
 		__get_user_asm(__x, ptr, __gu_err);		\
-		(x) = (__typeof__(*(ptr))) __x;			\
+		(x) = *(__typeof__(*(ptr)) *) &__x;		\
 		break;						\
 	};							\
 	case 4: {						\
 		unsigned int __x;				\
 		__get_user_asm(__x, ptr, __gu_err);		\
-		(x) = (__typeof__(*(ptr))) __x;			\
+		(x) = *(__typeof__(*(ptr)) *) &__x;		\
 		break;						\
 	};							\
 	case 8: {						\
 		unsigned long long __x;				\
 		__get_user_asm(__x, ptr, __gu_err);		\
-		(x) = (__typeof__(*(ptr))) __x;			\
+		(x) = *(__typeof__(*(ptr)) *) &__x;		\
 		break;						\
 	};							\
 	default:						\
