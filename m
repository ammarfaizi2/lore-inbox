Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbUC3P7i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 10:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbUC3P7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 10:59:38 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:50088 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261928AbUC3P71 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 10:59:27 -0500
Subject: Re: Migrate pages from a ccNUMA node to another - patch
From: Dave Hansen <haveblue@us.ibm.com>
To: Zoltan.Menyhart@bull.net
Cc: linux-ia64@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <40695C68.4A5F551E@nospam.org>
References: <4063F581.ACC5C511@nospam.org>
	 <1080321646.31638.105.camel@nighthawk>  <40695C68.4A5F551E@nospam.org>
Content-Type: text/plain
Message-Id: <1080662328.10037.48.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 30 Mar 2004 07:58:49 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-03-30 at 03:39, Zoltan Menyhart wrote: 
> Dave Hansen wrote:
> > Is your code something that you'd like to see go into the mainline 2.6
> > or 2.7 kernel?
> 
> Since someone is asking...

Before anything else, please take a long look at
Documentation/CodingStyle.  Pay particular attention to the column
width, indenting, and function sections.  

One of the best things about your code is that it uses a lot of
architecture-independent functions and data structures.  The page table
walks in your patch, for instance, would work on any Linux
architecture.  However, all of this code is in the ia64 arc.  Why?  Will
other NUMA architectures not need this page migration functionality?

It's great that you are commenting so many things, but normal Linux
style is to use C-style comments, not C++.  Also, although it's great
while you're developing a patch, it's best to try and refrain from
documenting things in comments things that are already a non-tricky part
of the way that things already work:
//
// "pte_page->mapping" points at the victim process'es "mm_struct"
//
These comments really just take up space and reduce readability.  

I find the comments inside of function and macro calls a bit hard to
read:
STORE_DELAY(/* in */ unlock_time, /* out */ new_page_unlock);


void
dump_mm(const struct mm_struct * const mm)
{
...

void
dump_vma(const struct vm_area_struct * const vma)
{


I think every VM hacker has a couple of these functions stashed around
in various patches for debugging, but they're not really something that
belongs in the kernel.  In general, you should try to remove debugging
code before posting a patch.  


+       case _SIZEOF_STATISTICS_:
+               rc =  *(long long *) &_statistics_sizes;
+               break;

I'm sure the statistics are very important, but they're a bit
intrusive.  Can you separate that code out into a file by itself?  Are
they even something that a user would want when they're running
normally, or is it another debugging feature?

+#if defined(CONFIG_NUMA)
+       data8 sys_page_migrate                  // 1276: Migrate pages
to another NUMA node
+#else
        data8 sys_ni_syscall
+#endif

See cond_syscall.  Basically you declare a weak symbol and override it
later if necessary.

+obj-$(CONFIG_NUMA)        += numa.o migrate.o

Can you separate this out under its own config option?


+asmlinkage long long
+sys_page_migrate(const int cmd, const caddr_t address, const size_t.
...
+       switch (cmd){
...
+       case _PHADDR_BATCH_MIGRATE_:
...
+       case _VA_RANGE_MIGRATE_:
...
+       case _STATISTICS_:
...
+       case _GIMME_AN_ADDRESS_:

This smells strongly of an ioctl.  If there really are 2 distinct kinds
of memory removal operations, then go ahead and make 2 different
syscalls.  As for the _STATISTICS_ and _GIMME_AN_ADDRESS_, they really
shouldn't be there at all.  They're just abusing the syscall. 

+migrate_virt_addr_range(
...
+       u.ll = syscall(__NR_page_migrate, _VA_RANGE_MIGRATE_,
+                      address, length, node, pid);
...
+}

Making syscalls from inside of the kernel is strongly discouraged.  I'm
not sure what you're trying to do there.  You might want to look at some
existing code like sys_mmap() vs do_mmap(). 

+#define        __VA(pgdi, pmdi, ptei)  (((pgdi) >> (PAGE_SHIFT - 6)) << 61 |                   \
+                               ((pgdi) & ((PTRS_PER_PGD >> 3) - 1)) << PGDIR_SHIFT |   \
+                               (pmdi) << PMD_SHIFT | (ptei) << PAGE_SHIFT)

There are magic numbers galore in this macro.  Would this work?

#define __VA(pgdi, pmdi, ptei)	((pgdi)*PGDIR_SIZE + \
				 (pmdi)*PMD_SIZE +   \
				 (ptei)*PAGE_SIZE)
If ia64 doesn't have the _SIZE macros, you can just copy them from
include/asm-i386/pgtable*.h 

-- 2.6.4.ref/mm/rmap.c Tue Mar 16 10:18:17 2004
+++ 2.6.4.mig4/mm/rmap.c        Thu Mar 25 09:00:13 2004
...
-struct pte_chain {
-       unsigned long next_and_idx;
-       pte_addr_t ptes[NRPTE];
-} ____cacheline_aligned;-- 2.6.4.ref/include/asm-ia64/rmap-locking.h


Exposing the VM internals like that probably isn't going to be
acceptable.  Why was this necessary?

--- 2.6.4.ref/test/vmig.c       Thu Jan  1 01:00:00 1970
+++ 2.6.4.mig4/test/vmig.c      Thu Mar 25 09:02:00 2004

If you need userspace code to demonstrate how to use your patch, it's
probably best to post it separately instead of including it in the
patch.  Someone might mistake it for kernel code.

I'm sure I missed some things, but I it's hard to look at the patch in
depth functionally before it is cleaned up a bit.

I look forward to seeing an updated version.

-- Dave

