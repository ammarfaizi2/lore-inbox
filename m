Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbVHKEyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbVHKEyc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 00:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbVHKEyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 00:54:31 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:34822 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932258AbVHKEyP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 00:54:15 -0400
Date: Wed, 10 Aug 2005 21:54:11 -0700
From: zach@vmware.com
Message-Id: <200508110454.j7B4sBDK019538@zach-dev.vmware.com>
To: akpm@osdl.org, chrisl@vmware.com, chrisw@osdl.org, hpa@zytor.com,
       Keir.Fraser@cl.cam.ac.uk, linux-kernel@vger.kernel.org,
       m+Ian.Pratt@cl.cam.ac.uk, mbligh@mbligh.org, pratap@vmware.com,
       virtualization@lists.osdl.org, zach@vmware.com, zwame@arm.linux.org.uk
Subject: [PATCH 5/14] i386 / Use early clobber to eliminate rotate in desc
X-OriginalArrivalTime: 11 Aug 2005 04:54:28.0139 (UTC) FILETIME=[C0DF0FB0:01C59E30]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use an early clobber on addr to avoid the extra rorl instruction at the
end of _set_tssldt_desc.

Also, get some C type checking on the descriptor struct here.

Patch-base: 2.6.13-rc5-mm1
Patch-keys: i386 desc cleanup optimize
Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.13/include/asm-i386/desc.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/desc.h	2005-08-09 18:59:10.000000000 -0700
+++ linux-2.6.13/include/asm-i386/desc.h	2005-08-10 20:42:20.000000000 -0700
@@ -34,17 +34,21 @@
 extern struct desc_struct default_ldt[];
 extern void set_intr_gate(unsigned int irq, void * addr);
 
-#define _set_tssldt_desc(n,addr,limit,type) \
-__asm__ __volatile__ ("movw %w3,0(%2)\n\t" \
-	"movw %w1,2(%2)\n\t" \
-	"rorl $16,%1\n\t" \
-	"movb %b1,4(%2)\n\t" \
-	"movb %4,5(%2)\n\t" \
-	"movb $0,6(%2)\n\t" \
-	"movb %h1,7(%2)\n\t" \
-	"rorl $16,%1" \
-	: "=m"(*(n)) : "q" (addr), "r"(n), "ir"(limit), "i"(type))
-
+#define _set_tssldt_desc(desc,addr,limit,type) \
+do { \
+	unsigned long __tmp; \
+	typecheck(struct desc_struct *, desc); \
+	asm volatile ("movw %w4,0(%3)\n\t" \
+		      "movw %w2,2(%3)\n\t" \
+		      "rorl $16,%2\n\t" \
+		      "movb %b2,4(%3)\n\t" \
+		      "movb %5,5(%3)\n\t" \
+		      "movb $0,6(%3)\n\t" \
+		      "movb %h2,7(%3)\n\t" \
+		      : "=m"(*(desc)), "=&q" (__tmp) \
+		      : "1" (addr), "r"(desc), "ir"(limit), "i"(type)); \
+} while (0)
+  
 #include <mach_desc.h>
 
 #define set_tss_desc(cpu,addr) __set_tss_desc(cpu, GDT_ENTRY_TSS, addr)
