Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751548AbWH3G1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548AbWH3G1r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 02:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbWH3G1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 02:27:47 -0400
Received: from 1wt.eu ([62.212.114.60]:37905 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1750752AbWH3G1r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 02:27:47 -0400
Date: Wed, 30 Aug 2006 08:27:18 +0200
From: Willy Tarreau <w@1wt.eu>
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com, ralf@linux-mips.org, pageexec@freemail.hu
Subject: [PATCH][RFC] fix long long cast in pte macro
Message-ID: <20060830062718.GA289@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

PaX Team sent me this patch, which I think is valid. It fixes a long long
cast in the pte macro for i386 and mips. If nobody has any objections, I
will apply it to 2.4. I'd also like someone to check whether it's needed
for 2.6 and to forward port it if needed.

Thanks,
Willy

--

the current idiom used for initializing a structure of two unsigned longs
from unsigned long long is wrong, it effectively loses the upper 32 bits
which in this particular case could turn a non-executable PTE into an
executable one on NX capable i386 (i.e., it's a potential security bug).
fortunately the in-tree users in 2.4 (drivers/char/drm-4.0/ffb_drv.c
and arch/mips/baget/baget.c) are not affected.

diff -u linux-2.4.33-pax/include/asm-i386/page.h linux-2.4.33-pax/include/asm-i386/page.h
--- linux-2.4.33-pax/include/asm-i386/page.h	2006-08-16 15:18:16.000000000 +0200
+++ linux-2.4.33-pax/include/asm-i386/page.h	2006-08-20 13:48:17.000000000 +0200
@@ -41,11 +41,13 @@
 typedef struct { unsigned long long pmd; } pmd_t;
 typedef struct { unsigned long long pgd; } pgd_t;
 #define pte_val(x)	((x).pte_low | ((unsigned long long)(x).pte_high << 32))
+#define __pte(x) ({ pte_t __pte = {(x), (x) >> 32}; __pte; })
 #else
 typedef struct { unsigned long pte_low; } pte_t;
 typedef struct { unsigned long pmd; } pmd_t;
 typedef struct { unsigned long pgd; } pgd_t;
 #define pte_val(x)	((x).pte_low)
+#define __pte(x) ((pte_t) { (x) } )
 #endif
 #define PTE_MASK	PAGE_MASK
 
@@ -55,7 +57,6 @@
 #define pgd_val(x)	((x).pgd)
 #define pgprot_val(x)	((x).pgprot)
 
-#define __pte(x) ((pte_t) { (x) } )
 #define __pmd(x) ((pmd_t) { (x) } )
 #define __pgd(x) ((pgd_t) { (x) } )
 #define __pgprot(x)	((pgprot_t) { (x) } )
diff -u linux-2.4.33-pax/include/asm-mips/page.h linux-2.4.33-pax/include/asm-mips/page.h
--- linux-2.4.33-pax/include/asm-mips/page.h	2006-08-13 00:03:26.000000000 +0200
+++ linux-2.4.33-pax/include/asm-mips/page.h	2006-08-20 13:51:58.000000000 +0200
@@ -77,13 +77,16 @@
   #ifdef CONFIG_CPU_MIPS32
     typedef struct { unsigned long pte_low, pte_high; } pte_t;
     #define pte_val(x)    ((x).pte_low | ((unsigned long long)(x).pte_high << 32))
+    #define __pte(x)	({ pte_t __pte = {(x), (x) >> 32}; __pte; })
   #else
     typedef struct { unsigned long long pte_low; } pte_t;
     #define pte_val(x)    ((x).pte_low)
+    #define __pte(x)	((pte_t) { (x) } )
   #endif
 #else
 typedef struct { unsigned long pte_low; } pte_t;
 #define pte_val(x)    ((x).pte_low)
+#define __pte(x)	((pte_t) { (x) } )
 #endif
 
 typedef struct { unsigned long pmd; } pmd_t;
@@ -96,7 +99,6 @@
 
 #define ptep_buddy(x)	((pte_t *)((unsigned long)(x) ^ sizeof(pte_t)))
 
-#define __pte(x)	((pte_t) { (x) } )
 #define __pmd(x)	((pmd_t) { (x) } )
 #define __pgd(x)	((pgd_t) { (x) } )
 #define __pgprot(x)	((pgprot_t) { (x) } )

