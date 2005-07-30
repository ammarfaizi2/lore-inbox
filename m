Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262823AbVG3EIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262823AbVG3EIi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 00:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbVG3EGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 00:06:53 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:44813 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S262866AbVG3EGo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 00:06:44 -0400
Date: Fri, 29 Jul 2005 21:04:16 -0700
From: zach@vmware.com
Message-Id: <200507300404.j6U44GGI005930@zach-dev.vmware.com>
To: akpm@osdl.org, chrisl@vmware.com, davej@codemonkey.org.uk, hpa@zytor.com,
       linux-kernel@vger.kernel.org, pratap@vmware.com, Riley@Williams.Name,
       zach@vmware.com
Subject: [PATCH] 4/6 i386 better-descriptor-asm
X-OriginalArrivalTime: 30 Jul 2005 04:05:16.0484 (UTC) FILETIME=[E4974040:01C594BB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

GCC can generate better code around descriptor update and access functions when
there is not an explicit "eax" register constraint.

Testing: You won't boot if this is messed up, since the TSS descriptor will be
corrupted.  Verified the assembler and booted.

Diffs-against: patch-2.6.13-rc4 + cpu-inline-cleanup + dt-inline-cleanup

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.13/include/asm-i386/desc.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/desc.h	2005-07-29 11:46:56.000000000 -0700
+++ linux-2.6.13/include/asm-i386/desc.h	2005-07-29 11:47:01.000000000 -0700
@@ -27,8 +27,8 @@
 
 extern struct Xgt_desc_struct idt_descr, cpu_gdt_descr[NR_CPUS];
 
-#define load_TR_desc() __asm__ __volatile__("ltr %%ax"::"a" (GDT_ENTRY_TSS*8))
-#define load_LDT_desc() __asm__ __volatile__("lldt %%ax"::"a" (GDT_ENTRY_LDT*8))
+#define load_TR_desc() __asm__ __volatile__("ltr %w0"::"q" (GDT_ENTRY_TSS*8))
+#define load_LDT_desc() __asm__ __volatile__("lldt %w0"::"q" (GDT_ENTRY_LDT*8))
 
 #define load_gdt(dtr) __asm__ __volatile("lgdt %0"::"m" (*dtr))
 #define load_idt(dtr) __asm__ __volatile("lidt %0"::"m" (*dtr))
@@ -49,14 +49,14 @@
 
 #define _set_tssldt_desc(n,addr,limit,type) \
 __asm__ __volatile__ ("movw %w3,0(%2)\n\t" \
-	"movw %%ax,2(%2)\n\t" \
-	"rorl $16,%%eax\n\t" \
-	"movb %%al,4(%2)\n\t" \
+	"movw %w1,2(%2)\n\t" \
+	"rorl $16,%1\n\t" \
+	"movb %b1,4(%2)\n\t" \
 	"movb %4,5(%2)\n\t" \
 	"movb $0,6(%2)\n\t" \
-	"movb %%ah,7(%2)\n\t" \
-	"rorl $16,%%eax" \
-	: "=m"(*(n)) : "a" (addr), "r"(n), "ir"(limit), "i"(type))
+	"movb %h1,7(%2)\n\t" \
+	"rorl $16,%1" \
+	: "=m"(*(n)) : "q" (addr), "r"(n), "ir"(limit), "i"(type))
 
 static inline void __set_tss_desc(unsigned int cpu, unsigned int entry, void *addr)
 {
