Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbWG3Ky6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbWG3Ky6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 06:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbWG3Ky5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 06:54:57 -0400
Received: from mail.aknet.ru ([82.179.72.26]:10764 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1751387AbWG3Ky5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 06:54:57 -0400
Message-ID: <44CC90A3.9000603@aknet.ru>
Date: Sun, 30 Jul 2006 14:57:39 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: akpm@osdl.org
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [patch] espfix code cleanup more
References: <200607300016.k6U0GYu4023664@shell0.pdx.osdl.net>
In-Reply-To: <200607300016.k6U0GYu4023664@shell0.pdx.osdl.net>
Content-Type: multipart/mixed;
 boundary="------------020808030408020009060807"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020808030408020009060807
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew.

Attached is a micro-optimization on top of the
previous cleanup patch. It removes the redundant
arguments from the C functions. No functionality changes.

Signed-off-by: <stsp@aknet.ru>


--------------020808030408020009060807
Content-Type: text/x-patch;
 name="espfcln_a.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="espfcln_a.diff"

--- linux-2.6.18-rc2-mm1/arch/i386/kernel/traps.c	2006-07-29 15:32:14.000000000 +0400
+++ linux-2.6.18-rc2-mm1/arch/i386/kernel/traps.c	2006-07-30 02:19:59.000000000 +0400
@@ -1018,13 +1018,13 @@
 #endif
 }
 
-fastcall unsigned long patch_espfix_gdt(struct pt_regs *regs,
+fastcall unsigned long patch_espfix_base(unsigned long uesp,
 					  unsigned long kesp)
 {
 	int cpu = smp_processor_id();
 	struct Xgt_desc_struct *cpu_gdt_descr = &per_cpu(cpu_gdt_descr, cpu);
 	struct desc_struct *gdt = (struct desc_struct *)cpu_gdt_descr->address;
-	unsigned long base = (kesp - regs->esp) & -THREAD_SIZE;
+	unsigned long base = (kesp - uesp) & -THREAD_SIZE;
 	__u64 desc = *(__u64 *)&gdt[GDT_ENTRY_ESPFIX_SS];
 	/* Set up base for espfix segment */
  	desc &= 0x00ffff000000ffffULL;
@@ -1034,14 +1034,13 @@
 	return kesp - base;
 }
 
-fastcall unsigned long get_orig_kesp(unsigned long kesp, unsigned long cpu)
+fastcall unsigned long get_espfix_base(unsigned long cpu)
 {
 	/* Since we are on a wrong stack, the smp_processor_id() cannot
 	 * be used. So the cpu number is passed from an assembly. */
 	struct Xgt_desc_struct *cpu_gdt_descr = &per_cpu(cpu_gdt_descr, cpu);
 	struct desc_struct *gdt = (struct desc_struct *)cpu_gdt_descr->address;
-	unsigned long base = get_desc_base(&gdt[GDT_ENTRY_ESPFIX_SS].a);
-	return base + kesp;
+	return get_desc_base(&gdt[GDT_ENTRY_ESPFIX_SS].a);
 }
 
 /*
--- linux-2.6.18-rc2-mm1/arch/i386/kernel/entry.S	2006-07-29 15:29:00.000000000 +0400
+++ linux-2.6.18-rc2-mm1/arch/i386/kernel/entry.S	2006-07-30 02:19:47.000000000 +0400
@@ -401,9 +401,9 @@
 	 * This is an "official" bug of all the x86-compatible
 	 * CPUs, which we can try to work around to make
 	 * dosemu and wine happy. */
-	movl %esp, %eax		# pt_regs pointer
+	movl OLDESP(%esp), %eax
 	movl %esp, %edx
-	call patch_espfix_gdt
+	call patch_espfix_base
 	pushl $__ESPFIX_SS
 	CFI_ADJUST_CFA_OFFSET 4
 	pushl %eax
@@ -502,10 +502,10 @@
 	CFI_ENDPROC
 
 #define FIXUP_ESPFIX_STACK \
-	movl %esp, %eax; \
 	GET_THREAD_INFO(%ebp); \
-	movl TI_cpu(%ebp), %edx; \
-	call get_orig_kesp; \
+	movl TI_cpu(%ebp), %eax; \
+	call get_espfix_base; \
+	addl %esp, %eax; \
 	pushl $__KERNEL_DS; \
 	pushl %eax; \
 	lss (%esp), %esp;

--------------020808030408020009060807--
