Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264052AbUDNLkd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 07:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264058AbUDNLkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 07:40:33 -0400
Received: from mail.shareable.org ([81.29.64.88]:17825 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S264052AbUDNLkG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 07:40:06 -0400
Date: Wed, 14 Apr 2004 12:37:53 +0100
From: Jamie Lokier <jamie@shareable.org>
To: David Mosberger-Tang <davidm@hpl.hp.com>, linux-ia64@linuxia64.org
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>, Kurt Garloff <garloff@suse.de>,
       linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: [PATCH] (IA64) Fix ugly __[PS]* macros in <asm-ia64/pgtable.h>
Message-ID: <20040414113753.GA9413@mail.shareable.org>
References: <9AB83E4717F13F419BD880F5254709E5011EBABA@scsmsx402.sc.intel.com> <20040414082355.GA8303@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040414082355.GA8303@mail.shareable.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch: ia64-pgtable-2.6.5.patch

That mixture of PAGE_* and __pgprot() definitions for the __[PS]*
macros in asm-ia64/pgtable.h is really ugly and just makes the code
unnecessarily confusing:

	#define __P000  PAGE_NONE
	#define __P001  PAGE_READONLY
	#define __P010  PAGE_READONLY
	#define __P011  PAGE_READONLY
	#define __P100  __pgprot(__ACCESS_BITS | _PAGE_PL_3 | _PAGE_AR_X_RX)
	#define __P101  __pgprot(__ACCESS_BITS | _PAGE_PL_3 | _PAGE_AR_RX)
	#define __P110  PAGE_COPY
	#define __P111  PAGE_COPY

The PAGE_* macros which are used in __[PS]* aren't used anywhere else:
their entire reason for existing is to make the __[PS]* macros
clearer.  It looks as though the people who implemented the IA-64 port
didn't realise that.

Here is a page (untested) which cleans up those definitions.  It was
made from 2.6.5.

Enjoy,
-- Jamie

diff -ur orig-2.6.5/include/asm-ia64/pgtable.h ia64-2.6.5/include/asm-ia64/pgtable.h
--- orig-2.6.5/include/asm-ia64/pgtable.h	2004-04-12 21:45:39.000000000 +0100
+++ ia64-2.6.5/include/asm-ia64/pgtable.h	2004-04-14 12:29:01.000000000 +0100
@@ -116,13 +116,17 @@
  * they are used, the page is accessed. They are cleared only by the
  * page-out routines.
  */
-#define PAGE_NONE	__pgprot(_PAGE_PROTNONE | _PAGE_A)
-#define PAGE_SHARED	__pgprot(__ACCESS_BITS | _PAGE_PL_3 | _PAGE_AR_RW)
-#define PAGE_READONLY	__pgprot(__ACCESS_BITS | _PAGE_PL_3 | _PAGE_AR_R)
-#define PAGE_COPY	__pgprot(__ACCESS_BITS | _PAGE_PL_3 | _PAGE_AR_RX)
-#define PAGE_GATE	__pgprot(__ACCESS_BITS | _PAGE_PL_0 | _PAGE_AR_X_RX)
-#define PAGE_KERNEL	__pgprot(__DIRTY_BITS  | _PAGE_PL_0 | _PAGE_AR_RWX)
-#define PAGE_KERNELRX	__pgprot(__ACCESS_BITS | _PAGE_PL_0 | _PAGE_AR_RX)
+#define PAGE_NONE	   __pgprot(_PAGE_PROTNONE | _PAGE_A)
+#define PAGE_SHARED	   __pgprot(__ACCESS_BITS | _PAGE_PL_3 | _PAGE_AR_RW)
+#define PAGE_SHARED_EXEC   __pgprot(__ACCESS_BITS | _PAGE_PL_3 | _PAGE_AR_RWX)
+#define PAGE_READONLY	   __pgprot(__ACCESS_BITS | _PAGE_PL_3 | _PAGE_AR_R)
+#define PAGE_READONLY_EXEC __pgprot(__ACCESS_BITS | _PAGE_PL_3 | _PAGE_AR_RX)
+#define PAGE_COPY	   __pgprot(__ACCESS_BITS | _PAGE_PL_3 | _PAGE_AR_R)
+#define PAGE_COPY_EXEC	   __pgprot(__ACCESS_BITS | _PAGE_PL_3 | _PAGE_AR_RX)
+#define PAGE_EXEC	   __pgprot(__ACCESS_BITS | _PAGE_PL_3 | _PAGE_AR_X_RX)
+#define PAGE_GATE	   __pgprot(__ACCESS_BITS | _PAGE_PL_0 | _PAGE_AR_X_RX)
+#define PAGE_KERNEL	   __pgprot(__DIRTY_BITS  | _PAGE_PL_0 | _PAGE_AR_RWX)
+#define PAGE_KERNELRX	   __pgprot(__ACCESS_BITS | _PAGE_PL_0 | _PAGE_AR_RX)
 
 # ifndef __ASSEMBLY__
 
@@ -142,21 +146,21 @@
 	/* xwr */
 #define __P000	PAGE_NONE
 #define __P001	PAGE_READONLY
-#define __P010	PAGE_READONLY	/* write to priv pg -> copy & make writable */
-#define __P011	PAGE_READONLY	/* ditto */
-#define __P100	__pgprot(__ACCESS_BITS | _PAGE_PL_3 | _PAGE_AR_X_RX)
-#define __P101	__pgprot(__ACCESS_BITS | _PAGE_PL_3 | _PAGE_AR_RX)
-#define __P110	PAGE_COPY
-#define __P111	PAGE_COPY
+#define __P010	PAGE_COPY
+#define __P011	PAGE_COPY
+#define __P100	PAGE_EXEC
+#define __P101	PAGE_READONLY_EXEC
+#define __P110	PAGE_COPY_EXEC
+#define __P111	PAGE_COPY_EXEC
 
 #define __S000	PAGE_NONE
 #define __S001	PAGE_READONLY
 #define __S010	PAGE_SHARED	/* we don't have (and don't need) write-only */
 #define __S011	PAGE_SHARED
-#define __S100	__pgprot(__ACCESS_BITS | _PAGE_PL_3 | _PAGE_AR_X_RX)
-#define __S101	__pgprot(__ACCESS_BITS | _PAGE_PL_3 | _PAGE_AR_RX)
-#define __S110	__pgprot(__ACCESS_BITS | _PAGE_PL_3 | _PAGE_AR_RWX)
-#define __S111	__pgprot(__ACCESS_BITS | _PAGE_PL_3 | _PAGE_AR_RWX)
+#define __S100	PAGE_EXEC
+#define __S101	PAGE_READONLY_EXEC
+#define __S110	PAGE_SHARED_EXEC
+#define __S111	PAGE_SHARED_EXEC
 
 #define pgd_ERROR(e)	printk("%s:%d: bad pgd %016lx.\n", __FILE__, __LINE__, pgd_val(e))
 #define pmd_ERROR(e)	printk("%s:%d: bad pmd %016lx.\n", __FILE__, __LINE__, pmd_val(e))
