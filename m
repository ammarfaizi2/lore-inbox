Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269511AbUJGAV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269511AbUJGAV4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 20:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269535AbUJGAV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 20:21:56 -0400
Received: from fmr03.intel.com ([143.183.121.5]:28843 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S269511AbUJGAUt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 20:20:49 -0400
Date: Wed, 6 Oct 2004 17:20:18 -0700
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Pavel Machek <pavel@suse.cz>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, akpm@osdl.org,
       "Brown, Len" <len.brown@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] S3 suspend/resume with noexec
Message-ID: <20041006172018.A10426@unix-os.sc.intel.com>
References: <88056F38E9E48644A0F562A38C64FB60030A4229@scsmsx403.amr.corp.intel.com> <20041006223203.GE2630@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041006223203.GE2630@elf.ucw.cz>; from pavel@suse.cz on Thu, Oct 07, 2004 at 12:32:03AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


How about this patch?

I verified that x86-64 already does right things to restore MSR_EFER during 
resume. So this issue is there only with i386.

Thanks,
Venki

This patch is required for S3 suspend-resume on noexec capable systems.
On these systems, we need to save and restore MSR_EFER during S3 suspend-resume.

Signed-off-by:: "Venkatesh Pallipadi" <venkatesh.pallipadi@intel.com>

--- linux-2.6.9-rc2/include/asm-i386/page.h.org	2004-09-03 21:13:03.275683336 -0700
+++ linux-2.6.9-rc2/include/asm-i386/page.h	2004-09-03 21:13:35.694754888 -0700
@@ -39,9 +39,9 @@
 /*
  * These are used to make use of C type-checking..
  */
+extern int nx_enabled;
 #ifdef CONFIG_X86_PAE
 extern unsigned long long __supported_pte_mask;
-extern int nx_enabled;
 typedef struct { unsigned long pte_low, pte_high; } pte_t;
 typedef struct { unsigned long long pmd; } pmd_t;
 typedef struct { unsigned long long pgd; } pgd_t;
@@ -49,7 +49,6 @@ typedef struct { unsigned long long pgpr
 #define pte_val(x)	((x).pte_low | ((unsigned long long)(x).pte_high << 32))
 #define HPAGE_SHIFT	21
 #else
-#define nx_enabled 0
 typedef struct { unsigned long pte_low; } pte_t;
 typedef struct { unsigned long pmd; } pmd_t;
 typedef struct { unsigned long pgd; } pgd_t;
--- linux-2.6.9-rc2/arch/i386/kernel/acpi/wakeup.S.org	2004-09-01 21:02:14.639883944 -0700
+++ linux-2.6.9-rc2/arch/i386/kernel/acpi/wakeup.S	2004-09-03 21:00:45.113900984 -0700
@@ -59,6 +59,14 @@ wakeup_code:
 	movl	$swapper_pg_dir-__PAGE_OFFSET, %eax
 	movl	%eax, %cr3
 
+	testl	$1, real_efer_save_restore - wakeup_code
+	jz	4f
+	# restore efer setting
+	movl	real_save_efer_edx - wakeup_code, %edx
+	movl	real_save_efer_eax - wakeup_code, %eax
+	mov     $0xc0000080, %ecx
+	wrmsr
+4:
 	# make sure %cr4 is set correctly (features, etc)
 	movl	real_save_cr4 - wakeup_code, %eax
 	movl	%eax, %cr4
@@ -89,6 +97,9 @@ real_save_cr4:	.long 0
 real_magic:	.long 0
 video_mode:	.long 0
 video_flags:	.long 0
+real_efer_save_restore:	.long 0
+real_save_efer_edx: 	.long 0
+real_save_efer_eax: 	.long 0
 
 bogus_real_magic:
 	movw	$0x0e00 + 'B', %fs:(0x12)
@@ -223,6 +234,20 @@ ENTRY(acpi_copy_wakeup_routine)
 	sldt	saved_ldt
 	str	saved_tss
 
+	movl	nx_enabled, %edx
+	movl	%edx, real_efer_save_restore - wakeup_start (%eax)
+	testl	$1, real_efer_save_restore - wakeup_start (%eax)
+	jz	2f
+	# save efer setting
+	pushl	%eax
+	movl	%eax, %ebx
+	mov     $0xc0000080, %ecx
+	rdmsr
+	movl	%edx, real_save_efer_edx - wakeup_start (%ebx)
+	movl	%eax, real_save_efer_eax - wakeup_start (%ebx)
+	popl	%eax
+2:
+
 	movl    %cr3, %edx
 	movl    %edx, real_save_cr3 - wakeup_start (%eax)
 	movl    %cr4, %edx
--- linux-2.6.9-rc2/arch/i386/mm/init.c.org	2004-09-03 21:13:50.803458016 -0700
+++ linux-2.6.9-rc2/arch/i386/mm/init.c	2004-09-03 21:14:19.401110512 -0700
@@ -436,8 +436,8 @@ static int __init noexec_setup(char *str
 
 __setup("noexec=", noexec_setup);
 
-#ifdef CONFIG_X86_PAE
 int nx_enabled = 0;
+#ifdef CONFIG_X86_PAE
 
 static void __init set_nx(void)
 {
--- linux-2.6.9-rc2//include/asm-i386/suspend.h.org	2004-09-01 19:20:01.842210904 -0700
+++ linux-2.6.9-rc2//include/asm-i386/suspend.h	2004-09-02 19:12:54.317408064 -0700
@@ -18,6 +18,7 @@ arch_prepare_suspend(void)
 struct saved_context {
   	u16 es, fs, gs, ss;
 	unsigned long cr0, cr2, cr3, cr4;
+	unsigned long efer_lo, efer_hi;
 	u16 gdt_pad;
 	u16 gdt_limit;
 	unsigned long gdt_base;
--- linux-2.6.9-rc2//arch/i386/power/cpu.c.org	2004-09-01 19:05:41.997927104 -0700
+++ linux-2.6.9-rc2//arch/i386/power/cpu.c	2004-09-03 18:58:07.934362280 -0700
@@ -62,6 +62,8 @@ void __save_processor_state(struct saved
 	asm volatile ("movl %%cr0, %0" : "=r" (ctxt->cr0));
 	asm volatile ("movl %%cr2, %0" : "=r" (ctxt->cr2));
 	asm volatile ("movl %%cr3, %0" : "=r" (ctxt->cr3));
+	if (nx_enabled)
+		rdmsr(MSR_EFER, ctxt->efer_lo, ctxt->efer_hi);
 	asm volatile ("movl %%cr4, %0" : "=r" (ctxt->cr4));
 }
 
@@ -113,6 +115,8 @@ void __restore_processor_state(struct sa
 	 * control registers
 	 */
 	asm volatile ("movl %0, %%cr4" :: "r" (ctxt->cr4));
+	if (nx_enabled)
+		wrmsr(MSR_EFER, ctxt->efer_lo, ctxt->efer_hi);
 	asm volatile ("movl %0, %%cr3" :: "r" (ctxt->cr3));
 	asm volatile ("movl %0, %%cr2" :: "r" (ctxt->cr2));
 	asm volatile ("movl %0, %%cr0" :: "r" (ctxt->cr0));
