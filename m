Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261669AbVE3SRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbVE3SRH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 14:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbVE3SRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 14:17:07 -0400
Received: from kanga.kvack.org ([66.96.29.28]:11422 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S261676AbVE3SOF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 14:14:05 -0400
Date: Mon, 30 May 2005 14:16:26 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: ak@muc.de
Cc: linux-kernel@vger.kernel.org
Subject: [RFC] x86-64: Use SSE for copy_page and clear_page
Message-ID: <20050530181626.GA10212@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andi,

Below is a patch that uses 128 bit SSE instructions for copy_page and 
clear_page.  This is an improvement on P4 systems as can be seen by 
running the test program at http://www.kvack.org/~bcrl/xmm64.c to get 
results like:

SSE test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ buffer = 0x2aaaaaad6000
clear_page() tests 
clear_page function 'warm up run'        took 25444 cycles per page
clear_page function 'kernel clear'       took 6595 cycles per page
clear_page function '2.4 non MMX'        took 7827 cycles per page
clear_page function '2.4 MMX fallback'   took 7741 cycles per page
clear_page function '2.4 MMX version'    took 6454 cycles per page
clear_page function 'faster_clear_page'  took 4344 cycles per page
clear_page function 'even_faster_clear'  took 4151 cycles per page
clear_page function 'xmm_clear '         took 3204 cycles per page
clear_page function 'xmma_clear '        took 6080 cycles per page
clear_page function 'xmm2_clear '        took 3370 cycles per page
clear_page function 'xmma2_clear '       took 6115 cycles per page
clear_page function 'kernel clear'       took 6583 cycles per page

copy_page() tests 
copy_page function 'warm up run'         took 9770 cycles per page
copy_page function '2.4 non MMX'         took 9758 cycles per page
copy_page function '2.4 MMX fallback'    took 9572 cycles per page
copy_page function '2.4 MMX version'     took 9405 cycles per page
copy_page function 'faster_copy'         took 7407 cycles per page
copy_page function 'even_faster'         took 7158 cycles per page
copy_page function 'xmm_copy_page_no'    took 6110 cycles per page
copy_page function 'xmm_copy_page'       took 5914 cycles per page
copy_page function 'xmma_copy_page'      took 5913 cycles per page
copy_page function 'v26_copy_page'       took 9168 cycles per page

The SSE clear page fuction is almost twice as fast as the kernel's 
current clear_page, while the copy_page implementation is roughly a 
third faster.  This is likely due to the fact that SSE instructions 
can keep the 256 bit wide L2 cache bus at a higher utilisation than 
64 bit movs are able to.  Comments?

		-ben

Signed-off-by: Benjamin LaHaise <benjamin.c.lahaise@intel.com>
:r public_html/patches/v2.6.12-rc4-xmm-2.diff
diff -purN v2.6.12-rc4/arch/x86_64/lib/c_clear_page.c xmm-rc4/arch/x86_64/lib/c_clear_page.c
--- v2.6.12-rc4/arch/x86_64/lib/c_clear_page.c	1969-12-31 19:00:00.000000000 -0500
+++ xmm-rc4/arch/x86_64/lib/c_clear_page.c	2005-05-26 11:16:09.000000000 -0400
@@ -0,0 +1,45 @@
+#include <linux/config.h>
+#include <linux/preempt.h>
+#include <asm/page.h>
+#include <linux/kernel.h>
+#include <asm/string.h>
+
+typedef struct { unsigned long a,b; } __attribute__((aligned(16))) xmm_store_t;
+
+void c_clear_page_xmm(void *page)
+{
+	/* Note! gcc doesn't seem to align stack variables properly, so we 
+	 * need to make use of unaligned loads and stores.
+	 */
+	xmm_store_t xmm_save[1];
+	unsigned long cr0;
+	int i;
+
+	preempt_disable();
+	__asm__ __volatile__ (
+		" mov %%cr0,%0\n"
+		" clts\n"
+		" movdqu %%xmm0,(%1)\n"
+		" pxor %%xmm0, %%xmm0\n"
+		: "=&r" (cr0): "r" (xmm_save) : "memory"
+	);
+
+	for(i=0;i<PAGE_SIZE/64;i++)
+	{
+		__asm__ __volatile__ (
+		" movntdq %%xmm0, (%0)\n"
+		" movntdq %%xmm0, 16(%0)\n"
+		" movntdq %%xmm0, 32(%0)\n"
+		" movntdq %%xmm0, 48(%0)\n"
+		: : "r" (page) : "memory");
+		page+=64;
+	}
+
+	__asm__ __volatile__ (
+		" sfence \n "
+		" movdqu (%0),%%xmm0\n"
+		" mov %1,%%cr0\n"
+		:: "r" (xmm_save), "r" (cr0)
+	);
+	preempt_enable();
+}
diff -purN v2.6.12-rc4/arch/x86_64/lib/c_copy_page.c xmm-rc4/arch/x86_64/lib/c_copy_page.c
--- v2.6.12-rc4/arch/x86_64/lib/c_copy_page.c	1969-12-31 19:00:00.000000000 -0500
+++ xmm-rc4/arch/x86_64/lib/c_copy_page.c	2005-05-30 14:07:28.000000000 -0400
@@ -0,0 +1,52 @@
+#include <linux/config.h>
+#include <linux/preempt.h>
+#include <asm/page.h>
+#include <linux/kernel.h>
+#include <asm/string.h>
+
+typedef struct { unsigned long a,b; } __attribute__((aligned(16))) xmm_store_t;
+
+void c_copy_page_xmm(void *to, void *from)
+{
+	/* Note! gcc doesn't seem to align stack variables properly, so we 
+	 * need to make use of unaligned loads and stores.
+	 */
+	xmm_store_t xmm_save[2];
+	unsigned long cr0;
+	int i;
+
+	preempt_disable();
+	__asm__ __volatile__ (
+                " prefetchnta    (%1)\n"
+                " prefetchnta  64(%1)\n"
+                " prefetchnta 128(%1)\n"
+                " prefetchnta 192(%1)\n"
+                " prefetchnta 256(%1)\n"
+		" mov %%cr0,%0\n"
+		" clts\n"
+		" movdqu %%xmm0,  (%1)\n"
+		" movdqu %%xmm1,16(%1)\n"
+		: "=&r" (cr0): "r" (xmm_save) : "memory"
+	);
+
+	for(i=0;i<PAGE_SIZE/32;i++) {
+		__asm__ __volatile__ (
+		" prefetchnta 320(%0)\n"
+		" movdqa   (%0),%%xmm0\n"
+		" movdqa 16(%0),%%xmm1\n"
+		" movntdq %%xmm0,   (%1)\n"
+		" movntdq %%xmm1, 16(%1)\n"
+		: : "r" (from), "r" (to) : "memory");
+		to += 32;
+		from += 32;
+	}
+
+	__asm__ __volatile__ (
+		" sfence \n "
+		" movdqu   (%0),%%xmm0\n"
+		" movdqu 16(%0),%%xmm1\n"
+		" mov %1,%%cr0\n"
+		:: "r" (xmm_save), "r" (cr0)
+	);
+	preempt_enable();
+}
diff -purN v2.6.12-rc4/arch/x86_64/lib/clear_page.S xmm-rc4/arch/x86_64/lib/clear_page.S
--- v2.6.12-rc4/arch/x86_64/lib/clear_page.S	2004-12-24 16:34:33.000000000 -0500
+++ xmm-rc4/arch/x86_64/lib/clear_page.S	2005-05-26 11:27:26.000000000 -0400
@@ -1,3 +1,5 @@
+#include <asm/cpufeature.h>
+	    	
 /*
  * Zero a page. 	
  * rdi	page
@@ -24,12 +26,25 @@ clear_page:
 	nop
 	ret
 clear_page_end:	
-	
+
+	.section .altinstructions,"a"
+	.align 8
+	.quad  clear_page
+	.quad  clear_page_xmm
+	.byte  X86_FEATURE_XMM2
+	.byte  clear_page_end-clear_page	
+	.byte  clear_page_xmm_end-clear_page_xmm
+	.previous
+
+	.globl	c_clear_page_xmm
+	.p2align 4
+clear_page_xmm:
+	jmp	c_clear_page_xmm+(clear_page_xmm-clear_page)
+clear_page_xmm_end:
+
 	/* C stepping K8 run faster using the string instructions.
 	   It is also a lot simpler. Use this when possible */
 	
-#include <asm/cpufeature.h>
-	    	
 	.section .altinstructions,"a"
 	.align 8
 	.quad  clear_page
diff -purN v2.6.12-rc4/arch/x86_64/lib/copy_page.S xmm-rc4/arch/x86_64/lib/copy_page.S
--- v2.6.12-rc4/arch/x86_64/lib/copy_page.S	2004-12-24 16:34:32.000000000 -0500
+++ xmm-rc4/arch/x86_64/lib/copy_page.S	2005-05-26 11:29:55.000000000 -0400
@@ -76,18 +76,34 @@ copy_page:
 	movq	2*8(%rsp),%r13
 	addq	$3*8,%rsp
 	ret
+copy_page_end = .
 	
+#include <asm/cpufeature.h>		
+		
+	.section .altinstructions,"a"
+	.align 8
+	.quad  copy_page
+	.quad  copy_page_xmm
+	.byte  X86_FEATURE_XMM2
+	.byte  copy_page_end-copy_page	
+	.byte  copy_page_xmm_end-copy_page_xmm
+	.previous
+
+	.globl	c_copy_page_xmm
+	.p2align 4
+copy_page_xmm:
+	jmp	c_copy_page_xmm+(copy_page_xmm-copy_page)
+copy_page_xmm_end = .
+
 	/* C stepping K8 run faster using the string copy instructions.
 	   It is also a lot simpler. Use this when possible */
 
-#include <asm/cpufeature.h>		
-		
 	.section .altinstructions,"a"
 	.align 8
 	.quad  copy_page
 	.quad  copy_page_c
 	.byte  X86_FEATURE_K8_C
-	.byte  copy_page_c_end-copy_page_c
+	.byte  copy_page_end-copy_page
 	.byte  copy_page_c_end-copy_page_c
 	.previous
 
diff -purN v2.6.12-rc4/arch/x86_64/lib/Makefile xmm-rc4/arch/x86_64/lib/Makefile
--- v2.6.12-rc4/arch/x86_64/lib/Makefile	2004-12-24 16:34:01.000000000 -0500
+++ xmm-rc4/arch/x86_64/lib/Makefile	2005-05-26 11:26:50.000000000 -0400
@@ -10,5 +10,7 @@ lib-y := csum-partial.o csum-copy.o csum
 	usercopy.o getuser.o putuser.o  \
 	thunk.o clear_page.o copy_page.o bitstr.o bitops.o
 lib-y += memcpy.o memmove.o memset.o copy_user.o
+lib-y += c_clear_page.o
+lib-y += c_copy_page.o
 
 lib-$(CONFIG_HAVE_DEC_LOCK) += dec_and_lock.o
