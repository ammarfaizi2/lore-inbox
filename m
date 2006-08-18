Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751367AbWHRLBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbWHRLBe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 07:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbWHRLBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 07:01:34 -0400
Received: from gw.goop.org ([64.81.55.164]:29574 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751367AbWHRLBd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 07:01:33 -0400
Message-ID: <44E59E05.4070804@goop.org>
Date: Fri, 18 Aug 2006 12:01:25 +0100
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] kill default_ldt
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The default LDT is completely unused now that iBCS is no longer
supported, so get rid of it.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

===================================================================

diff -r 121e0e54cca8 arch/i386/kernel/ldt.c
--- a/arch/i386/kernel/ldt.c	Fri Aug 18 11:36:24 2006 +0100
+++ b/arch/i386/kernel/ldt.c	Fri Aug 18 11:57:04 2006 +0100
@@ -160,16 +160,14 @@ static int read_default_ldt(void __user 
 {
 	int err;
 	unsigned long size;
-	void *address;
 
 	err = 0;
-	address = &default_ldt[0];
 	size = 5*sizeof(struct desc_struct);
 	if (size > bytecount)
 		size = bytecount;
 
 	err = size;
-	if (copy_to_user(ptr, address, size))
+	if (clear_user(ptr, size))
 		err = -EFAULT;
 
 	return err;
diff -r 121e0e54cca8 arch/i386/kernel/traps.c
--- a/arch/i386/kernel/traps.c	Fri Aug 18 11:36:24 2006 +0100
+++ b/arch/i386/kernel/traps.c	Fri Aug 18 11:36:24 2006 +0100
@@ -58,9 +58,6 @@
 #include "mach_traps.h"
 
 asmlinkage int system_call(void);
-
-struct desc_struct default_ldt[] = { { 0, 0 }, { 0, 0 }, { 0, 0 },
-		{ 0, 0 }, { 0, 0 } };
 
 /* Do we ignore FPU interrupts ? */
 char ignore_fpu_irq = 0;
diff -r 121e0e54cca8 include/asm-i386/desc.h
--- a/include/asm-i386/desc.h	Fri Aug 18 11:36:24 2006 +0100
+++ b/include/asm-i386/desc.h	Fri Aug 18 11:56:31 2006 +0100
@@ -33,11 +33,6 @@ static inline struct desc_struct *get_cp
 	return (struct desc_struct *)per_cpu(cpu_gdt_descr, cpu).address;
 }
 
-/*
- * This is the ldt that every process will get unless we need
- * something other than this.
- */
-extern struct desc_struct default_ldt[];
 extern struct desc_struct idt_table[];
 extern void set_intr_gate(unsigned int irq, void * addr);
 
@@ -159,7 +154,7 @@ static inline void clear_LDT(void)
 {
 	int cpu = get_cpu();
 
-	set_ldt_desc(cpu, &default_ldt[0], 5);
+	set_ldt_desc(cpu, NULL, 0);
 	load_LDT_desc();
 	put_cpu();
 }
@@ -172,10 +167,8 @@ static inline void load_LDT_nolock(mm_co
 	void *segments = pc->ldt;
 	int count = pc->size;
 
-	if (likely(!count)) {
-		segments = &default_ldt[0];
-		count = 5;
-	}
+	if (likely(!count))
+		segments = NULL;
 		
 	set_ldt_desc(cpu, segments, count);
 	load_LDT_desc();

