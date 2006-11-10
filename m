Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424169AbWKJBS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424169AbWKJBS0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 20:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424323AbWKJBS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 20:18:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:15052 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1424169AbWKJBSZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 20:18:25 -0500
Message-Id: <200611100121.kAA1L0UN031589@pasta.boston.redhat.com>
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] x86_64: fix perms/range of vsyscall vma in /proc/*/maps
Date: Thu, 09 Nov 2006 20:20:59 -0500
From: Ernie Petrides <petrides@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andy.  The final line of /proc/<pid>/maps on x86_64 for native 64-bit
tasks shows an incorrect ending address and incorrect permissions.  There
is only a single page mapped in this vsyscall region, and it is accessible
for both read and execute.

The patch below fixes this.  (Since 32-bit-compat tasks have a real vma
with correct perms/range, no change is necessary for that scenario.)

Before the patch, a "cat /proc/self/maps | tail -1" shows this:

	ffffffffff600000-ffffffffffe00000 ---p 00000000 [...]

After the patch, this is the output:

	ffffffffff600000-ffffffffff601000 r-xp 00000000 [...]

Cheers.  -ernie



Signed-off-by: Ernie Petrides <petrides@redhat.com>

--- linux-2.6.18/arch/x86_64/mm/init.c.orig
+++ linux-2.6.18/arch/x86_64/mm/init.c
@@ -774,14 +774,15 @@ static __init int x8664_sysctl_init(void
 __initcall(x8664_sysctl_init);
 #endif
 
-/* A pseudo VMAs to allow ptrace access for the vsyscall page.   This only
+/* A pseudo VMA to allow ptrace access for the vsyscall page.   This only
    covers the 64bit vsyscall page now. 32bit has a real VMA now and does
    not need special handling anymore. */
 
 static struct vm_area_struct gate_vma = {
 	.vm_start = VSYSCALL_START,
-	.vm_end = VSYSCALL_END,
-	.vm_page_prot = PAGE_READONLY
+	.vm_end = VSYSCALL_START + PAGE_SIZE,
+	.vm_page_prot = PAGE_READONLY_EXEC,
+	.vm_flags = VM_READ | VM_EXEC
 };
 
 struct vm_area_struct *get_gate_vma(struct task_struct *tsk)
