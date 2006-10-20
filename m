Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946120AbWJTDeD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946120AbWJTDeD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 23:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946149AbWJTDeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 23:34:03 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:64992 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1946120AbWJTDeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 23:34:01 -0400
Date: Thu, 19 Oct 2006 21:34:00 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Minor fixes to generic do_div
Message-ID: <20061020033359.GR2602@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


While tracking down a problem recently, I noticed the description of
do_div() is not quite right.  We also don't check that 'n' is 64-bit
when running on a 64-bit machine (this would have caused warnings to
appear on more configurations if we had).  And finally, the indentation
of the \ characters in the 64-bit case don't match those in the 32-bit case,
so change those to match.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>

diff --git a/include/asm-generic/div64.h b/include/asm-generic/div64.h
index 8f4e319..0edfb96 100644
--- a/include/asm-generic/div64.h
+++ b/include/asm-generic/div64.h
@@ -6,10 +6,10 @@ #define _ASM_GENERIC_DIV64_H
  *
  * The semantics of do_div() are:
  *
- * uint32_t do_div(uint64_t *n, uint32_t base)
+ * uint32_t do_div(uint64_t n, uint32_t base)
  * {
- * 	uint32_t remainder = *n % base;
- * 	*n = *n / base;
+ * 	uint32_t remainder = n % base;
+ * 	n = n / base;
  * 	return remainder;
  * }
  *
@@ -22,12 +22,16 @@ #include <linux/compiler.h>
 
 #if BITS_PER_LONG == 64
 
-# define do_div(n,base) ({					\
-	uint32_t __base = (base);				\
-	uint32_t __rem;						\
-	__rem = ((uint64_t)(n)) % __base;			\
-	(n) = ((uint64_t)(n)) / __base;				\
-	__rem;							\
+/* The unnecessary pointer compare is there
+ * to check for type safety (n must be 64bit)
+ */
+# define do_div(n,base) ({				\
+	uint32_t __base = (base);			\
+	uint32_t __rem;					\
+	(void)(((typeof((n)) *)0) == ((uint64_t *)0));	\
+	__rem = ((uint64_t)(n)) % __base;		\
+	(n) = ((uint64_t)(n)) / __base;			\
+	__rem;						\
  })
 
 #elif BITS_PER_LONG == 32
