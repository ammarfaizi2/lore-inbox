Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266292AbUFRRtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266292AbUFRRtL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 13:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266305AbUFRRtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 13:49:11 -0400
Received: from mail.ccur.com ([208.248.32.212]:57355 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S266292AbUFRRsw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 13:48:52 -0400
Date: Fri, 18 Jun 2004 13:48:51 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] up unpinned mmap usable address space from 2 to 3 GB
Message-ID: <20040618174851.GA25142@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <20040617221444.21e17f0a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040617221444.21e17f0a.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2004 at 01:14:44AM -0400, Andrew Morton wrote:
> Joe Korty <joe.korty@ccur.com> wrote:
>> Make the full 3 GB of process address space available to unpinned mmaps.
>>  Previously only the 2 GB from 40000000-c0000000 was available.
>> 
>>  The process address space allocation behavior should remain unchanged
>>  for non-i386 architectures.
>> 
>>  For i386, the new algorithm first allocates from virtual address 40000000
>>  to the start of the stack area (as defined by ulimit -s), then from the
>>  start of the text area (08000000) down to 00400000, then from 40000000
>>  down to the sbrk area, then (as a last resort) starts allocating from
>>  the unused portion of the stack area.
>> 
>>  With this patch, a small java program, simulating a real application,
>>  can spin off 3,790 threads.  Previously, only 1,750 threads could be
>>  spun off.
>> 
>>  Due to the fragility of making changes to get_unmapped_area(), this patch
>>  is intended 'For Comment Only'.
> 
> Andi said:
> 
> It will break tons of software (worse than 4/4). Like Wine or all kinds
> of JITs and others. AFAIK Fedora already does a much weaker form of this
> and it isn't pretty.

1) The new algorithm keeps to the old address range and keeps to the same
pattern of address space allocations for as long as possible.  Only when
the point is reached where the old algorithm would have failed is other
address ranges looked at.  This intrinsically prevents the problems
mentioned above for all applications that would have run successfully
under the old algorithm.

2) RedHat allocates differently, starting at TASK_SIZE-stacksize and working
its way down to zero, yet Wine etc seem to work properly under RedHat.


> But it's a good thing longer term to squeeze some more live out of
> 32bit. The current layout is indeed quite inefficient.

Yep.

> I would do it not by default, but as a personality. This will be good
> enough for the people who really need the address space, and make it
> painless for others. And then maybe enable it unconditionally in 2.7
> and support the personality for the old way. But don't switch it over
> by default in the stable series - that would quite bad.

Done.  The attached patch adds a CONFIG option which by default will
be off.

> Also I'm not sure the vma last hit cache will still work with his
> approach. This probably needs some careful profiling.

While in the 'normal zone' the vma last hit cache will work the same
as always.  When out-of-zone I am pretty sure the cache will cease to
be effective.

Joe


diff -ura base/arch/i386/Kconfig new/arch/i386/Kconfig
--- base/arch/i386/Kconfig	2004-06-16 01:18:59.000000000 -0400
+++ new/arch/i386/Kconfig	2004-06-18 11:18:55.000000000 -0400
@@ -503,6 +503,24 @@
 	  Say Y here if you are building a kernel for a desktop, embedded
 	  or real-time system.  Say N if you are unsure.
 
+config LARGE_MMAP_SPACE
+       bool "All user space available to unpinned mmaps?"
+       help
+	 If you answer N, then unpinned mmaps (that is, mmaps where the
+	 system picks the virtual address the mmap will attach to) will
+	 be restricted to their traditional address range of 0x40000000
+	 -> 0xc0000000.
+
+	 If you answer Y, then unpinned mmaps can be allocated anywhere
+	 a hole of sufficient size can be found in the address space;
+	 however, preference will continue to be given to its traditional
+	 address range.
+
+	 Users should say Y here unless they encounter an application
+	 which does not work well with the new algorithm.
+
+	 If unsure, say Y.
+
 config X86_UP_APIC
 	bool "Local APIC support on uniprocessors" if !SMP
 	depends on !(X86_VISWS || X86_VOYAGER)
diff -ura base/include/asm-i386/processor.h new/include/asm-i386/processor.h
--- base/include/asm-i386/processor.h	2004-06-16 01:18:56.000000000 -0400
+++ new/include/asm-i386/processor.h	2004-06-18 11:14:15.000000000 -0400
@@ -301,6 +301,11 @@
  * space during mmap's.
  */
 #define TASK_UNMAPPED_BASE	(PAGE_ALIGN(TASK_SIZE / 3))
+#ifdef CONFIG_LARGE_MMAP_SPACE
+#define TASK_UNMAPPED_BASE_2	(PAGE_ALIGN(16 * PAGE_SIZE))
+#define TASK_SLOP_FUNCTION	(current->rlim[RLIMIT_STACK].rlim_cur)
+#define MIN_TASK_SLOP		(64 * PAGE_SIZE)
+#endif
 
 /*
  * Size of io_bitmap, covering ports 0 to 0x3ff.
diff -ura base/mm/mmap.c new/mm/mmap.c
--- base/mm/mmap.c	2004-06-16 01:19:37.000000000 -0400
+++ new/mm/mmap.c	2004-06-18 10:43:21.000000000 -0400
@@ -1002,13 +1002,26 @@
  * This function "knows" that -ENOMEM has the bits set.
  */
 #ifndef HAVE_ARCH_UNMAPPED_AREA
+
+#ifndef TASK_UNMAPPED_BASE_2
+#define TASK_UNMAPPED_BASE_2 TASK_UNMAPPED_BASE
+#endif
+
+#ifndef MIN_TASK_SLOP
+#define MIN_TASK_SLOP 1		/* must be >0 */
+#endif
+
+#ifndef TASK_SLOP_FUNCTION
+#define TASK_SLOP_FUNCTION 0
+#endif
+
 static inline unsigned long
 arch_get_unmapped_area(struct file *filp, unsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
-	unsigned long start_addr;
+	unsigned long start_addr, end_addr, end_slop;
 
 	if (len > TASK_SIZE)
 		return -ENOMEM;
@@ -1020,27 +1033,45 @@
 		    (!vma || addr + len <= vma->vm_start))
 			return addr;
 	}
+	/* determine how close to TASK_SIZE we are willing to get */
+	end_slop = TASK_SLOP_FUNCTION;
+	if (end_slop < MIN_TASK_SLOP)
+		end_slop = MIN_TASK_SLOP;
+	end_slop = PAGE_ALIGN(end_slop);
+
+	end_addr = TASK_SIZE - end_slop;
 	start_addr = addr = mm->free_area_cache;
 
 full_search:
 	for (vma = find_vma(mm, addr); ; vma = vma->vm_next) {
 		/* At this point:  (!vma || addr < vma->vm_end). */
-		if (TASK_SIZE - len < addr) {
+		if (end_addr - len < addr) {
 			/*
 			 * Start a new search - just in case we missed
 			 * some holes.
 			 */
-			if (start_addr != TASK_UNMAPPED_BASE) {
+			if (end_addr == TASK_SIZE)
+				return -ENOMEM;
+			end_addr = start_addr;
+			if (start_addr > TASK_UNMAPPED_BASE) {
 				start_addr = addr = TASK_UNMAPPED_BASE;
-				goto full_search;
+			} else if (start_addr > TASK_UNMAPPED_BASE_2) {
+				/* dig a bit into the sbrk area if necessary */
+				start_addr = addr = TASK_UNMAPPED_BASE_2;
+			} else {
+				/* dig into the stack area as a last resort */
+				end_addr = TASK_SIZE;
+				addr = TASK_SIZE - end_slop;
 			}
-			return -ENOMEM;
+			goto full_search;
 		}
 		if (!vma || addr + len <= vma->vm_start) {
-			/*
-			 * Remember the place where we stopped the search:
-			 */
-			mm->free_area_cache = addr + len;
+			if (addr >= TASK_UNMAPPED_BASE) {
+				mm->free_area_cache = addr + len;
+			} else {
+				mm->free_area_cache = addr;
+				addr = (vma ? vma->vm_start : end_addr) - len;
+			}
 			return addr;
 		}
 		addr = vma->vm_end;
