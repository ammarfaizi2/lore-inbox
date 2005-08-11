Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932256AbVHKE41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbVHKE41 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 00:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbVHKE41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 00:56:27 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:40966 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932256AbVHKE40
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 00:56:26 -0400
Date: Wed, 10 Aug 2005 21:56:20 -0700
From: zach@vmware.com
Message-Id: <200508110456.j7B4uKNb019579@zach-dev.vmware.com>
To: akpm@osdl.org, chrisl@vmware.com, chrisw@osdl.org, hpa@zytor.com,
       Keir.Fraser@cl.cam.ac.uk, linux-kernel@vger.kernel.org,
       m+Ian.Pratt@cl.cam.ac.uk, mbligh@mbligh.org, pratap@vmware.com,
       virtualization@lists.osdl.org, zach@vmware.com, zwane@arm.linux.org.uk
Subject: [PATCH 7/14] i386 / Add some descriptor convenience functions
X-OriginalArrivalTime: 11 Aug 2005 04:56:37.0514 (UTC) FILETIME=[0DFC1EA0:01C59E31]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add some convenient descriptor access functions and move them all into desc.h

Patch-base: 2.6.13-rc5-mm1
Patch-keys: i386 desc cleanup
Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.13/include/asm-i386/desc.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/desc.h	2005-08-09 19:43:38.000000000 -0700
+++ linux-2.6.13/include/asm-i386/desc.h	2005-08-10 20:42:03.000000000 -0700
@@ -14,6 +14,28 @@
 
 #include <asm/mmu.h>
 
+#define desc_empty(desc) \
+		(!((desc)->a + (desc)->b))
+
+#define desc_equal(desc1, desc2) \
+		(((desc1)->a == (desc2)->a) && ((desc1)->b == (desc2)->b))
+
+static inline unsigned long get_desc_base(struct desc_struct *desc)
+{
+	unsigned long base;
+	base = ((desc->a >> 16)  & 0x0000ffff) |
+		((desc->b << 16) & 0x00ff0000) |
+		(desc->b & 0xff000000);
+	return base;
+}
+
+static inline unsigned long get_desc_limit(struct desc_struct *desc)
+{
+	unsigned long limit;
+	limit = (desc->a & 0x0ffff) | (desc->b & 0xf0000);
+	return limit;
+}
+
 extern struct desc_struct cpu_gdt_table[GDT_ENTRIES];
 DECLARE_PER_CPU(struct desc_struct, cpu_gdt_table[GDT_ENTRIES]);
 
@@ -111,15 +133,5 @@
 	put_cpu();
 }
 
-static inline unsigned long get_desc_base(unsigned long *desc)
-{
-	unsigned long base;
-	base = ((desc[0] >> 16)  & 0x0000ffff) |
-		((desc[1] << 16) & 0x00ff0000) |
-		(desc[1] & 0xff000000);
-	return base;
-}
-
 #endif /* !__ASSEMBLY__ */
-
 #endif
Index: linux-2.6.13/include/asm-i386/processor.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/processor.h	2005-08-09 19:43:38.000000000 -0700
+++ linux-2.6.13/include/asm-i386/processor.h	2005-08-09 19:43:59.000000000 -0700
@@ -28,11 +28,6 @@
 	unsigned long a,b;
 };
 
-#define desc_empty(desc) \
-		(!((desc)->a + (desc)->b))
-
-#define desc_equal(desc1, desc2) \
-		(((desc1)->a == (desc2)->a) && ((desc1)->b == (desc2)->b))
 /*
  * Default implementation of macro that returns current
  * instruction pointer ("program counter").
Index: linux-2.6.13/arch/i386/mm/fault.c
===================================================================
--- linux-2.6.13.orig/arch/i386/mm/fault.c	2005-08-09 19:43:47.000000000 -0700
+++ linux-2.6.13/arch/i386/mm/fault.c	2005-08-10 20:42:04.000000000 -0700
@@ -75,7 +75,8 @@
 {
 	unsigned long eip = regs->eip;
 	unsigned seg = regs->xcs & 0xffff;
-	u32 seg_ar, seg_limit, base, *desc;
+	u32 seg_ar, seg_limit, base;
+	struct desc_struct *desc;
 
 	/* The standard kernel/user address space limit. */
 	*eip_limit = (seg & 3) ? USER_DS.seg : KERNEL_DS.seg;
@@ -108,12 +109,12 @@
 		desc = (void *)desc + (seg & ~7);
 	} else {
 		/* Must disable preemption while reading the GDT. */
-		desc = (u32 *)&per_cpu(cpu_gdt_table, get_cpu());
+		desc = per_cpu(cpu_gdt_table, get_cpu());
 		desc = (void *)desc + (seg & ~7);
 	}
 
 	/* Decode the code segment base from the descriptor */
-	base = get_desc_base((unsigned long *)desc);
+	base = get_desc_base(desc);
 
 	if (segment_from_ldt(seg)) { 
 		up(&current->mm->context.sem);
Index: linux-2.6.13/arch/i386/kernel/kprobes.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/kprobes.c	2005-08-09 19:43:47.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/kprobes.c	2005-08-09 19:54:16.000000000 -0700
@@ -156,7 +156,6 @@
 	struct kprobe *p;
 	int ret = 0;
 	kprobe_opcode_t *addr = NULL;
-	unsigned long *lp;
 
 	/* We're in an interrupt, but this is clear and BUG()-safe. */
 	preempt_disable();
@@ -164,9 +163,10 @@
 	 * calculate the address by reading the base address from the LDT entry.
 	 */
 	if (segment_from_ldt(regs->xcs) && (current->mm)) {
-		lp = (unsigned long *) ((unsigned long)(segment_index(regs->xcs) * 8)
-					+ (char *) current->mm->context.ldt);
-		addr = (kprobe_opcode_t *) (get_desc_base(lp) + regs->eip -
+		struct desc_struct *desc;
+		desc = (struct desc_struct *) ((char *) current->mm->context.ldt +
+						 (segment_index(regs->xcs) * 8));
+		addr = (kprobe_opcode_t *) (get_desc_base(desc) + regs->eip -
 						sizeof(kprobe_opcode_t));
 	} else {
 		addr = (kprobe_opcode_t *)(regs->eip - sizeof(kprobe_opcode_t));
