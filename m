Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750916AbWGCLRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbWGCLRv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 07:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750923AbWGCLRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 07:17:51 -0400
Received: from aun.it.uu.se ([130.238.12.36]:46765 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1750905AbWGCLRu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 07:17:50 -0400
Date: Mon, 3 Jul 2006 13:17:44 +0200 (MEST)
Message-Id: <200607031117.k63BHiDa007719@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: davem@davemloft.net
Subject: [BUG sparc64] 2.6.16-git6 broke X11 on Ultra5 with ATI Mach64
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.6.17 sparc64 kernels, X11 runs _extremely_ slowly with
frequent lock-up like behaviour on my Ultra5 (ATI Mach64).

I finally managed to trace the cause to this change in 2.6.16-git6:

diff --git a/arch/sparc64/mm/generic.c b/arch/sparc64/mm/generic.c
index 580b63d..8cb0620 100644
--- a/arch/sparc64/mm/generic.c
+++ b/arch/sparc64/mm/generic.c
@@ -144,7 +140,6 @@ int io_remap_pfn_range(struct vm_area_st
 	vma->vm_flags |= VM_IO | VM_RESERVED | VM_PFNMAP;
 	vma->vm_pgoff = phys_base >> PAGE_SHIFT;
 
-	prot = __pgprot(pg_iobits);
 	offset -= from;
 	dir = pgd_offset(mm, from);
 	flush_cache_range(vma, beg, end);

Reverting this patch fixes my X11 problems.

Adding a debug printk and a dump_stack there, plus a hack to
sys_mmap() to store away its parameters, shows:

io_remap_pfn_range: prot 0x8000000000000788, pg_iobits 0x8000000000000f8a, mmap() in 1961(X), prot 0x3, flags 0x1
Call Trace:
 [00000000004eb9a0] proc_bus_pci_mmap+0x38/0x54
 [000000000047122c] do_mmap_pgoff+0x474/0x674
 [000000000041f02c] sys_mmap+0x178/0x1b0
 [00000000004069d4] linux_sparc_syscall32+0x34/0x40
 [0000000000072b78] 0x72b78

I.e., X did a simple PROT_READ|PROT_WRITE MAP_SHARED mmap() of
something PCI-related, presumably the ATI card. The protection
bits passed into io_remap_pfn_range() are 0x80...0788, while
pg_iobits are 0x80...0f8a. Current kernels obey the prot bits,
which, if I read things correctly, means that _PAGE_W_4U and
_PAGE_MODIFIED_4U don't get set any more.

I guess something else in the kernel should have set those
bits before they got to io_remap_pfn_range()?

/Mikael
