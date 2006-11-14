Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755400AbWKNCsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755400AbWKNCsX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 21:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755404AbWKNCsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 21:48:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:15756 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1755400AbWKNCsX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 21:48:23 -0500
Message-Id: <200611140251.kAE2pm0Z015391@pasta.boston.redhat.com>
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86_64: fix perms/range of vsyscall vma in /proc/*/maps
In-Reply-To: Your message of "Fri, 10 Nov 2006 06:07:45 +0100."
             <200611100607.45391.ak@suse.de>
Date: Mon, 13 Nov 2006 21:51:48 -0500
From: Ernie Petrides <petrides@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 10-Nov-2006 at 6:07 +0100, Andi Kleen wrote:

> On Friday 10 November 2006 02:20, Ernie Petrides wrote:
>
> > Hi, Andi.  The final line of /proc/<pid>/maps on x86_64 for native 64-bit
> > tasks shows an incorrect ending address and incorrect permissions.  There
> > is only a single page mapped in this vsyscall region, and it is accessible
> > for both read and execute.
> 
> The range reported is how much address space is reserved, but you're
> right it is less.
> 
> But I don't like hardcoding a page here -- this will likely be extended
> soon. Can you please create a new define VSYSCALL_REAL_LENGTH or similar 
> in vsyscall.h and use that?

Good idea -- how about the patch below?

Cheers.  -ernie



Signed-off-by: Ernie Petrides <petrides@redhat.com>

--- linux-2.6.18/arch/x86_64/kernel/vsyscall.c.orig
+++ linux-2.6.18/arch/x86_64/kernel/vsyscall.c
@@ -205,6 +205,7 @@ static void __init map_vsyscall(void)
 	extern char __vsyscall_0;
 	unsigned long physaddr_page0 = __pa_symbol(&__vsyscall_0);
 
+	/* Note that VSYSCALL_MAPPED_PAGES must agree with the code below. */
 	__set_fixmap(VSYSCALL_FIRST_PAGE, physaddr_page0, PAGE_KERNEL_VSYSCALL);
 }
 
--- linux-2.6.18/arch/x86_64/mm/init.c.orig
+++ linux-2.6.18/arch/x86_64/mm/init.c
@@ -774,14 +774,15 @@ static __init int x8664_sysctl_init(void
 __initcall(x8664_sysctl_init);
 #endif
 
-/* A pseudo VMAs to allow ptrace access for the vsyscall page.   This only
+/* A pseudo VMA to allow ptrace access for the vsyscall page.  This only
    covers the 64bit vsyscall page now. 32bit has a real VMA now and does
    not need special handling anymore. */
 
 static struct vm_area_struct gate_vma = {
 	.vm_start = VSYSCALL_START,
-	.vm_end = VSYSCALL_END,
-	.vm_page_prot = PAGE_READONLY
+	.vm_end = VSYSCALL_START + (VSYSCALL_MAPPED_PAGES << PAGE_SHIFT),
+	.vm_page_prot = PAGE_READONLY_EXEC,
+	.vm_flags = VM_READ | VM_EXEC
 };
 
 struct vm_area_struct *get_gate_vma(struct task_struct *tsk)
--- linux-2.6.18/include/asm-x86_64/vsyscall.h.orig
+++ linux-2.6.18/include/asm-x86_64/vsyscall.h
@@ -9,6 +9,7 @@ enum vsyscall_num {
 #define VSYSCALL_START (-10UL << 20)
 #define VSYSCALL_SIZE 1024
 #define VSYSCALL_END (-2UL << 20)
+#define VSYSCALL_MAPPED_PAGES 1
 #define VSYSCALL_ADDR(vsyscall_nr) (VSYSCALL_START+VSYSCALL_SIZE*(vsyscall_nr))
 
 #ifdef __KERNEL__
