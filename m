Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262939AbTDFMUU (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 08:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262941AbTDFMUU (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 08:20:20 -0400
Received: from siaab1ab.compuserve.com ([149.174.40.2]:45199 "EHLO
	siaab1ab.compuserve.com") by vger.kernel.org with ESMTP
	id S262939AbTDFMUS (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 08:20:18 -0400
Date: Sun, 6 Apr 2003 08:28:16 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [PATCH] i386 descriptor cleanup and question
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304060831_MC3-1-333C-1546@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 There is no need to clear the busy bit when setting up TSS entries
in the GDT -- __set_tss_desc() creates them that way.  This patch
documents that and removes the unnecessary code.  It also documents
the fixed bits in LDT entries.  Tested on uniprocessor only -- I
dumped the GDT and it looks right, with entry 31 having flags 89
while #16 has flags 8b (busy bit set by "ltr" instruction.)

 Why is there only one TSS for doublefault handling on SMP?  Is the
chance of multiple concurrent faults too small to be worth handling?



 arch/i386/kernel/cpu/common.c |    5 ++---
 include/asm-i386/desc.h       |   10 ++++++----
 2 files changed, 8 insertions(+), 7 deletions(-)


diff -u --exclude-from=/home/me/.exclude -r linux-2.5.66-ref/arch/i386/kernel/cpu/common.c linux-2.5.66-uni/arch/i386/kernel/cpu/common.c
--- linux-2.5.66-ref/arch/i386/kernel/cpu/common.c	Sat Mar 29 09:16:21 2003
+++ linux-2.5.66-uni/arch/i386/kernel/cpu/common.c	Sun Apr  6 07:13:50 2003
@ -487,13 +487,12 @
 
 	load_esp0(t, thread->esp0);
 	set_tss_desc(cpu,t);
-	cpu_gdt_table[cpu][GDT_ENTRY_TSS].b &= 0xfffffdff;
 	load_TR_desc();
 	load_LDT(&init_mm.context);
 
-	/* Set up doublefault TSS pointer in the GDT */
+	/* Set up doublefault TSS descriptor in the GDT
+	 */
 	__set_tss_desc(cpu, GDT_ENTRY_DOUBLEFAULT_TSS, &doublefault_tss);
-	cpu_gdt_table[cpu][GDT_ENTRY_DOUBLEFAULT_TSS].b &= 0xfffffdff;
 
 	/* Clear %fs and %gs. */
 	asm volatile ("xorl %eax, %eax; movl %eax, %fs; movl %eax, %gs");
diff -u --exclude-from=/home/me/.exclude -r linux-2.5.66-ref/include/asm-i386/desc.h linux-2.5.66-uni/include/asm-i386/desc.h
--- linux-2.5.66-ref/include/asm-i386/desc.h	Tue Mar  4 22:28:52 2003
+++ linux-2.5.66-uni/include/asm-i386/desc.h	Sun Apr  6 07:15:21 2003
@ -44,6 +44,7 @
 
 static inline void __set_tss_desc(unsigned int cpu, unsigned int entry, void *addr)
 {
+	/* type 0x89: present, not-busy TSS, DPL=0 */
 	_set_tssldt_desc(&cpu_gdt_table[cpu][entry], (int)addr, 235, 0x89);
 }
 
@ -57,8 +58,9 @
 #define LDT_entry_a(info) \
 	((((info)->base_addr & 0x0000ffff) << 16) | ((info)->limit & 0x0ffff))
 
-#define LDT_entry_b(info) \
-	(((info)->base_addr & 0xff000000) | \
+/* const 0x7000: DPL = 3, type = code or data */
+#define LDT_entry_b(info) ( \
+	((info)->base_addr & 0xff000000) | \
 	(((info)->base_addr & 0x00ff0000) >> 16) | \
 	((info)->limit & 0xf0000) | \
 	(((info)->read_exec_only ^ 1) << 9) | \
@ -67,9 +69,9 @
 	((info)->seg_32bit << 22) | \
 	((info)->limit_in_pages << 23) | \
 	((info)->useable << 20) | \
-	0x7000)
+	0x7000 )
 
-#define LDT_empty(info) (\
+#define LDT_empty(info) ( \
 	(info)->base_addr	== 0	&& \
 	(info)->limit		== 0	&& \
 	(info)->contents	== 0	&& \

--
 Chuck
 I am not a number!
