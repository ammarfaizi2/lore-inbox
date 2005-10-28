Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030192AbVJ1OLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030192AbVJ1OLS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 10:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030187AbVJ1OLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 10:11:18 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:25026 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030194AbVJ1OLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 10:11:17 -0400
Date: Fri, 28 Oct 2005 16:11:24 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 13/14] s390: const pointer uaccess.
Message-ID: <20051028141123.GM7300@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[patch 13/14] s390: const pointer uaccess.

Using __typeof__(*ptr) on a pointer to const makes the __x
variable in __get_user const as well. The latest gcc will
refuse to write to it.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/asm-s390/uaccess.h |   28 ++++++++++++++++++++++------
 1 files changed, 22 insertions(+), 6 deletions(-)

diff -urpN linux-2.6/include/asm-s390/uaccess.h linux-2.6-patched/include/asm-s390/uaccess.h
--- linux-2.6/include/asm-s390/uaccess.h	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/uaccess.h	2005-10-28 14:04:55.000000000 +0200
@@ -200,21 +200,37 @@ extern int __put_user_bad(void) __attrib
 
 #define __get_user(x, ptr)					\
 ({								\
-	__typeof__(*(ptr)) __x;					\
 	int __gu_err;						\
         __chk_user_ptr(ptr);                                    \
 	switch (sizeof(*(ptr))) {				\
-	case 1:							\
-	case 2:							\
-	case 4:							\
-	case 8:							\
+	case 1: {						\
+		unsigned char __x;				\
 		__get_user_asm(__x, ptr, __gu_err);		\
+		(x) = (__typeof__(*(ptr))) __x;			\
 		break;						\
+	};							\
+	case 2: {						\
+		unsigned short __x;				\
+		__get_user_asm(__x, ptr, __gu_err);		\
+		(x) = (__typeof__(*(ptr))) __x;			\
+		break;						\
+	};							\
+	case 4: {						\
+		unsigned int __x;				\
+		__get_user_asm(__x, ptr, __gu_err);		\
+		(x) = (__typeof__(*(ptr))) __x;			\
+		break;						\
+	};							\
+	case 8: {						\
+		unsigned long long __x;				\
+		__get_user_asm(__x, ptr, __gu_err);		\
+		(x) = (__typeof__(*(ptr))) __x;			\
+		break;						\
+	};							\
 	default:						\
 		__get_user_bad();				\
 		break;						\
 	}							\
-	(x) = __x;						\
 	__gu_err;						\
 })
 
