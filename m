Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263429AbUFCMRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbUFCMRP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 08:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263585AbUFCMRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 08:17:15 -0400
Received: from ozlabs.org ([203.10.76.45]:51351 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263640AbUFCMQY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 08:16:24 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16575.5888.948512.836469@cargo.ozlabs.ibm.com>
Date: Thu, 3 Jun 2004 22:18:08 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
       trini@kernel.crashing.org
Subject: [PATCH][PPC32] Reduce WARN_ON(0) to nothing
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The last patch I sent means that we have WARN_ON(0) in a couple of
places when CONFIG_PREEMPT=n.  This patch makes that reduce to
nothing (rather than a conditional trap on a 0 value), and also makes
BUG_ON(0) reduce to nothing for completeness.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/include/asm-ppc/bug.h pmac-2.5/include/asm-ppc/bug.h
--- linux-2.5/include/asm-ppc/bug.h	2003-06-08 08:08:29.000000000 +1000
+++ pmac-2.5/include/asm-ppc/bug.h	2004-06-03 21:35:42.385963144 +1000
@@ -23,26 +23,30 @@
 		: : "i" (__LINE__), "i" (__FILE__), "i" (__FUNCTION__)); \
 } while (0)
 
-#define BUG_ON(x) do {						\
-	__asm__ __volatile__(					\
-		"1:	twnei %0,0\n"				\
-		".section __bug_table,\"a\"\n\t"		\
-		"	.long 1b,%1,%2,%3\n"			\
-		".previous"					\
-		: : "r" (x), "i" (__LINE__), "i" (__FILE__),	\
-		    "i" (__FUNCTION__));			\
+#define BUG_ON(x) do {							\
+	if (!__builtin_constant_p(x) || (x)) {				\
+		__asm__ __volatile__(					\
+			"1:	twnei %0,0\n"				\
+			".section __bug_table,\"a\"\n\t"		\
+			"	.long 1b,%1,%2,%3\n"			\
+			".previous"					\
+			: : "r" (x), "i" (__LINE__), "i" (__FILE__),	\
+			    "i" (__FUNCTION__));			\
+	}								\
 } while (0)
 
-#define PAGE_BUG(page) do { BUG(); } while (0)
+#define PAGE_BUG(page)	BUG()
 
-#define WARN_ON(x) do {						\
-	__asm__ __volatile__(					\
-		"1:	twnei %0,0\n"				\
-		".section __bug_table,\"a\"\n\t"		\
-		"	.long 1b,%1,%2,%3\n"			\
-		".previous"					\
-		: : "r" (x), "i" (__LINE__ + BUG_WARNING_TRAP),	\
-		    "i" (__FILE__), "i" (__FUNCTION__));	\
+#define WARN_ON(x) do {							\
+	if (!__builtin_constant_p(x) || (x)) {				\
+		__asm__ __volatile__(					\
+			"1:	twnei %0,0\n"				\
+			".section __bug_table,\"a\"\n\t"		\
+			"	.long 1b,%1,%2,%3\n"			\
+			".previous"					\
+			: : "r" (x), "i" (__LINE__ + BUG_WARNING_TRAP),	\
+			    "i" (__FILE__), "i" (__FUNCTION__));	\
+	}								\
 } while (0)
 
 #endif
