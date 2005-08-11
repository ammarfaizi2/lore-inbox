Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbVHKEyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbVHKEyo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 00:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbVHKEyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 00:54:44 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:37382 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932255AbVHKEyd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 00:54:33 -0400
Date: Wed, 10 Aug 2005 21:54:31 -0700
From: zach@vmware.com
Message-Id: <200508110454.j7B4sVsL019549@zach-dev.vmware.com>
To: akpm@osdl.org, chrisl@vmware.com, chrisw@osdl.org, hpa@zytor.com,
       Keir.Fraser@cl.cam.ac.uk, linux-kernel@vger.kernel.org,
       m+Ian.Pratt@cl.cam.ac.uk, mbligh@mbligh.org, pratap@vmware.com,
       virtualization@lists.osdl.org, zach@vmware.com, zwame@arm.linux.org.uk
Subject: [PATCH 6/14] i386 / Add some segment convenience functions
X-OriginalArrivalTime: 11 Aug 2005 04:54:45.0171 (UTC) FILETIME=[CB05F030:01C59E30]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add some convenient segment macros to the kernel.  This makes the
rather obfuscated 'seg & 4' go away.

Patch-keys: i386 segment cleanup
Patch-base: 2.6.13-rc5-mm1
Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.13/include/asm-i386/segment.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/segment.h	2005-08-09 19:36:36.000000000 -0700
+++ linux-2.6.13/include/asm-i386/segment.h	2005-08-09 19:43:47.000000000 -0700
@@ -98,4 +98,14 @@
  */
 #define IDT_ENTRIES 256
 
+/*
+ * This bit is set to indicate segment selectors are in the LDT
+ */
+#define LDT_SEGMENT 4
+
+#ifndef __ASSEMBLY__
+#define segment_index(seg) ((seg) >> 3)
+#define segment_from_ldt(seg) ((seg) & LDT_SEGMENT)
+#endif
+
 #endif
Index: linux-2.6.13/arch/i386/kernel/ptrace.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/ptrace.c	2005-08-09 19:36:36.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/ptrace.c	2005-08-10 20:40:51.000000000 -0700
@@ -146,8 +146,6 @@
 	return retval;
 }
 
-#define LDT_SEGMENT 4
-
 static unsigned long convert_eip_to_linear(struct task_struct *child, struct pt_regs *regs)
 {
 	unsigned long addr, seg;
@@ -165,7 +163,7 @@
 	 * TLS segments are used for data, and the PNPBIOS
 	 * and APM bios ones we just ignore here.
 	 */
-	if (seg & LDT_SEGMENT) {
+	if (segment_from_ldt(seg)) {
 		u32 *desc;
 		unsigned long base;
 
Index: linux-2.6.13/arch/i386/kernel/kprobes.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/kprobes.c	2005-08-09 19:36:36.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/kprobes.c	2005-08-10 20:42:20.000000000 -0700
@@ -163,8 +163,8 @@
 	/* Check if the application is using LDT entry for its code segment and
 	 * calculate the address by reading the base address from the LDT entry.
 	 */
-	if ((regs->xcs & 4) && (current->mm)) {
-		lp = (unsigned long *) ((unsigned long)((regs->xcs >> 3) * 8)
+	if (segment_from_ldt(regs->xcs) && (current->mm)) {
+		lp = (unsigned long *) ((unsigned long)(segment_index(regs->xcs) * 8)
 					+ (char *) current->mm->context.ldt);
 		addr = (kprobe_opcode_t *) (get_desc_base(lp) + regs->eip -
 						sizeof(kprobe_opcode_t));
Index: linux-2.6.13/arch/i386/kernel/entry.S
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/entry.S	2005-08-09 19:36:36.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/entry.S	2005-08-09 19:43:47.000000000 -0700
@@ -268,8 +268,8 @@
 	# See comments in process.c:copy_thread() for details.
 	movb OLDSS(%esp), %ah
 	movb CS(%esp), %al
-	andl $(VM_MASK | (4 << 8) | 3), %eax
-	cmpl $((4 << 8) | 3), %eax
+	andl $(VM_MASK | (LDT_SEGMENT << 8) | 3), %eax
+	cmpl $((LDT_SEGMENT << 8) | 3), %eax
 	je ldt_ss			# returning to user-space with LDT SS
 restore_nocheck:
 	RESTORE_REGS
Index: linux-2.6.13/arch/i386/mm/fault.c
===================================================================
--- linux-2.6.13.orig/arch/i386/mm/fault.c	2005-08-09 19:43:38.000000000 -0700
+++ linux-2.6.13/arch/i386/mm/fault.c	2005-08-10 20:42:20.000000000 -0700
@@ -101,7 +101,7 @@
 	/* Get the GDT/LDT descriptor base. 
 	   When you look for races in this code remember that
 	   LDT and other horrors are only used in user space. */
-	if (seg & (1<<2)) {
+	if (segment_from_ldt(seg)) {
 		/* Must lock the LDT while reading it. */
 		down(&current->mm->context.sem);
 		desc = current->mm->context.ldt;
@@ -115,7 +115,7 @@
 	/* Decode the code segment base from the descriptor */
 	base = get_desc_base((unsigned long *)desc);
 
-	if (seg & (1<<2)) { 
+	if (segment_from_ldt(seg)) { 
 		up(&current->mm->context.sem);
 	} else
 		put_cpu();
