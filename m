Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbUDGWdB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 18:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbUDGWdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 18:33:01 -0400
Received: from fw.osdl.org ([65.172.181.6]:40838 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261221AbUDGWc5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 18:32:57 -0400
Date: Wed, 7 Apr 2004 15:34:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, mbligh@aracnet.com
Subject: Re: NUMA API for Linux
Message-Id: <20040407153457.43c9df5f.akpm@osdl.org>
In-Reply-To: <20040408001629.2ff39598.ak@suse.de>
References: <1081373058.9061.16.camel@arrakis>
	<20040407145130.4b1bdf3e.akpm@osdl.org>
	<20040408001629.2ff39598.ak@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> What was the problem in mmap.c ? I compiled in various combinations (with
> and without NUMA on i386 and x86-64) and it worked.



mm/mmap.c: In function `copy_vma':
mm/mmap.c:1531: structure has no member named `vm_policy'

--- 25/mm/mmap.c~numa-api-vma-policy-hooks-fix	Wed Apr  7 12:28:53 2004
+++ 25-akpm/mm/mmap.c	Wed Apr  7 12:29:09 2004
@@ -1528,7 +1528,7 @@ struct vm_area_struct *copy_vma(struct v
 
 	find_vma_prepare(mm, addr, &prev, &rb_link, &rb_parent);
 	new_vma = vma_merge(mm, prev, rb_parent, addr, addr + len,
-			vma->vm_flags, vma->vm_file, pgoff, vma->vm_policy);
+			vma->vm_flags, vma->vm_file, pgoff, vma_policy(vma));
 	if (!new_vma) {
 		new_vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
 		if (new_vma) {

_

> And why was arch_hugetlb_fault() unneeded?

Well we do:

	if (condition-which-evaluates-to-constant-zero-on-CONFIG_HUGETLB=n)
		arch_hugetlb_fault();

so the compiler will never emit a call to the stub function anyway.

But it turns out the stub is needed for now, because !X86 doesn't implement
arch_hugetlb_fault().  So I put it back.

> > It builds OK for NUMAQ, although NUMAQ does have a problem:
> > 
> > drivers/built-in.o: In function `acpi_pci_root_add':
> > drivers/built-in.o(.text+0x22015): undefined reference to `pci_acpi_scan_root'
> > 
> > ppc64+CONFIG_NUMA compiles OK.
> 
> ppc64 doesn't have the system calls hooked up, but I'm not sure how useful
> it would be for these boxes anyways (afaik they are pretty uniform) 

Well, it's best that the kernel actually compiles still..

