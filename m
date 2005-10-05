Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965085AbVJEHgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965085AbVJEHgL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 03:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932566AbVJEHgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 03:36:11 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:25491 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932565AbVJEHgK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 03:36:10 -0400
Date: Wed, 5 Oct 2005 08:36:02 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: [PATCH] fix the breakage in sparc headers
Message-ID: <20051005073601.GT7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	If we switch extern inline to static inline, we'd better switch
the pre-declarations we use to say that these puppies have __attribute_const__
on them.  Otherwise we get extern declaration followed by static inline one.
Which makes gcc unhappy, and for a good reason...
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-rc3-git4-base/include/asm-sparc/btfixup.h current/include/asm-sparc/btfixup.h
--- RC14-rc3-git4-base/include/asm-sparc/btfixup.h	2005-10-05 01:50:32.000000000 -0400
+++ current/include/asm-sparc/btfixup.h	2005-10-05 01:58:50.000000000 -0400
@@ -49,7 +49,7 @@
 /* Put bottom 13bits into some register variable */
 
 #define BTFIXUPDEF_SIMM13(__name)							\
-	extern unsigned int ___sf_##__name(void) __attribute_const__;		\
+	static inline unsigned int ___sf_##__name(void) __attribute_const__;		\
 	extern unsigned ___ss_##__name[2];						\
 	static inline unsigned int ___sf_##__name(void) {				\
 		unsigned int ret;							\
@@ -57,7 +57,7 @@
 		return ret;								\
 	}
 #define BTFIXUPDEF_SIMM13_INIT(__name,__val)						\
-	extern unsigned int ___sf_##__name(void) __attribute_const__;		\
+	static inline unsigned int ___sf_##__name(void) __attribute_const__;		\
 	extern unsigned ___ss_##__name[2];						\
 	static inline unsigned int ___sf_##__name(void) {				\
 		unsigned int ret;							\
@@ -71,7 +71,7 @@
  */
 
 #define BTFIXUPDEF_HALF(__name)								\
-	extern unsigned int ___af_##__name(void) __attribute_const__;		\
+	static inline unsigned int ___af_##__name(void) __attribute_const__;		\
 	extern unsigned ___as_##__name[2];						\
 	static inline unsigned int ___af_##__name(void) {				\
 		unsigned int ret;							\
@@ -79,7 +79,7 @@
 		return ret;								\
 	}
 #define BTFIXUPDEF_HALF_INIT(__name,__val)						\
-	extern unsigned int ___af_##__name(void) __attribute_const__;		\
+	static inline unsigned int ___af_##__name(void) __attribute_const__;		\
 	extern unsigned ___as_##__name[2];						\
 	static inline unsigned int ___af_##__name(void) {				\
 		unsigned int ret;							\
@@ -90,7 +90,7 @@
 /* Put upper 22 bits into some register variable */
 
 #define BTFIXUPDEF_SETHI(__name)							\
-	extern unsigned int ___hf_##__name(void) __attribute_const__;		\
+	static inline unsigned int ___hf_##__name(void) __attribute_const__;		\
 	extern unsigned ___hs_##__name[2];						\
 	static inline unsigned int ___hf_##__name(void) {				\
 		unsigned int ret;							\
@@ -98,7 +98,7 @@
 		return ret;								\
 	}
 #define BTFIXUPDEF_SETHI_INIT(__name,__val)						\
-	extern unsigned int ___hf_##__name(void) __attribute_const__;		\
+	static inline unsigned int ___hf_##__name(void) __attribute_const__;		\
 	extern unsigned ___hs_##__name[2];						\
 	static inline unsigned int ___hf_##__name(void) {				\
 		unsigned int ret;							\
diff -urN RC14-rc3-git4-base/include/asm-sparc/pgtable.h current/include/asm-sparc/pgtable.h
--- RC14-rc3-git4-base/include/asm-sparc/pgtable.h	2005-10-05 01:50:32.000000000 -0400
+++ current/include/asm-sparc/pgtable.h	2005-10-05 02:00:06.000000000 -0400
@@ -194,19 +194,19 @@
 BTFIXUPDEF_HALF(pte_dirtyi)
 BTFIXUPDEF_HALF(pte_youngi)
 
-extern int pte_write(pte_t pte) __attribute_const__;
+static int pte_write(pte_t pte) __attribute_const__;
 static inline int pte_write(pte_t pte)
 {
 	return pte_val(pte) & BTFIXUP_HALF(pte_writei);
 }
 
-extern int pte_dirty(pte_t pte) __attribute_const__;
+static int pte_dirty(pte_t pte) __attribute_const__;
 static inline int pte_dirty(pte_t pte)
 {
 	return pte_val(pte) & BTFIXUP_HALF(pte_dirtyi);
 }
 
-extern int pte_young(pte_t pte) __attribute_const__;
+static int pte_young(pte_t pte) __attribute_const__;
 static inline int pte_young(pte_t pte)
 {
 	return pte_val(pte) & BTFIXUP_HALF(pte_youngi);
@@ -217,7 +217,7 @@
  */
 BTFIXUPDEF_HALF(pte_filei)
 
-extern int pte_file(pte_t pte) __attribute_const__;
+static int pte_file(pte_t pte) __attribute_const__;
 static inline int pte_file(pte_t pte)
 {
 	return pte_val(pte) & BTFIXUP_HALF(pte_filei);
@@ -229,19 +229,19 @@
 BTFIXUPDEF_HALF(pte_mkcleani)
 BTFIXUPDEF_HALF(pte_mkoldi)
 
-extern pte_t pte_wrprotect(pte_t pte) __attribute_const__;
+static pte_t pte_wrprotect(pte_t pte) __attribute_const__;
 static inline pte_t pte_wrprotect(pte_t pte)
 {
 	return __pte(pte_val(pte) & ~BTFIXUP_HALF(pte_wrprotecti));
 }
 
-extern pte_t pte_mkclean(pte_t pte) __attribute_const__;
+static pte_t pte_mkclean(pte_t pte) __attribute_const__;
 static inline pte_t pte_mkclean(pte_t pte)
 {
 	return __pte(pte_val(pte) & ~BTFIXUP_HALF(pte_mkcleani));
 }
 
-extern pte_t pte_mkold(pte_t pte) __attribute_const__;
+static pte_t pte_mkold(pte_t pte) __attribute_const__;
 static inline pte_t pte_mkold(pte_t pte)
 {
 	return __pte(pte_val(pte) & ~BTFIXUP_HALF(pte_mkoldi));
@@ -278,7 +278,7 @@
 
 BTFIXUPDEF_INT(pte_modify_mask)
 
-extern pte_t pte_modify(pte_t pte, pgprot_t newprot) __attribute_const__;
+static pte_t pte_modify(pte_t pte, pgprot_t newprot) __attribute_const__;
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	return __pte((pte_val(pte) & BTFIXUP_INT(pte_modify_mask)) |
