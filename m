Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264337AbUFGHau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264337AbUFGHau (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 03:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264344AbUFGHat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 03:30:49 -0400
Received: from mailserv.intranet.GR ([146.124.14.106]:31206 "EHLO
	mailserv.intranet.gr") by vger.kernel.org with ESMTP
	id S264337AbUFGHan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 03:30:43 -0400
Message-ID: <40C4186C.8000700@intracom.gr>
Date: Mon, 07 Jun 2004 10:25:32 +0300
From: Pantelis Antoniou <panto@intracom.gr>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.6) Gecko/20040416
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Tom Rini <trini@kernel.crashing.org>
Subject: Re: [PATCH] (urgent) ppc32: Fix CPUs with soft loaded TLB
References: <1086556255.1859.14.camel@gaston>	 <Pine.LNX.4.58.0406061418450.1730@ppc970.osdl.org> <1086558161.10538.24.camel@gaston>
In-Reply-To: <1086558161.10538.24.camel@gaston>
Content-Type: multipart/mixed;
 boundary="------------000902040807040402080505"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000902040807040402080505
Content-Type: text/plain; charset=ISO-8859-7; format=flowed
Content-Transfer-Encoding: 7bit

Benjamin Herrenschmidt wrote:

>On Sun, 2004-06-06 at 16:20, Linus Torvalds wrote:
>
>>On Sun, 6 Jun 2004, Benjamin Herrenschmidt wrote:
>>
>>>The recent introduction of ptep_set_access_flags() with the optimisation
>>>of not flushing the TLB unfortunately broke ppc32 CPUs with no hash table.
>>>
>>Makes sense, applied.
>>
>
>ARGH. Missed one file. Here is an additional patch (missed tlbflush.h patch)
>
>Sorry.
>
>This adds the definiction of flush_tlb_page_nohash() that was missing
>from the previous patch fixing SW-TLB loaded PPCs
>
>Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
>===== include/asm-ppc/tlbflush.h 1.9 vs edited =====
>--- 1.9/include/asm-ppc/tlbflush.h	2003-09-15 15:59:05 -05:00
>+++ edited/include/asm-ppc/tlbflush.h	2004-06-06 16:01:50 -05:00
>@@ -29,6 +29,9 @@
> static inline void flush_tlb_page(struct vm_area_struct *vma,
> 				unsigned long vmaddr)
> 	{ _tlbie(vmaddr); }
>+static inline void flush_tlb_page_nohash(struct vm_area_struct *vma,
>+					 unsigned long vmaddr)
>+	{ _tlbie(vmaddr); }
> static inline void flush_tlb_range(struct vm_area_struct *vma,
> 				unsigned long start, unsigned long end)
> 	{ __tlbia(); }
>@@ -44,6 +47,9 @@
> static inline void flush_tlb_page(struct vm_area_struct *vma,
> 				unsigned long vmaddr)
> 	{ _tlbie(vmaddr); }
>+static inline void flush_tlb_page_nohash(struct vm_area_struct *vma,
>+					 unsigned long vmaddr)
>+	{ _tlbie(vmaddr); }
> static inline void flush_tlb_range(struct mm_struct *mm,
> 				unsigned long start, unsigned long end)
> 	{ __tlbia(); }
>@@ -56,6 +62,7 @@
> struct vm_area_struct;
> extern void flush_tlb_mm(struct mm_struct *mm);
> extern void flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
>+extern void flush_tlb_page_nohash(struct vm_area_struct *vma, unsigned long addr);
> extern void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
> 			    unsigned long end);
> extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
>
>
>
>
>
>
Hi

Unfortunately this is not enough for me on 8xx.

When starting init it bombs with

Freeing unused kernel memory: 60k init
Oops: kernel access of bad area, sig: 11 [#1]
NIP: C00070F0 LR: C000C580 SP: C0FD7E00 REGS: c0fd7d50 TRAP: 0300    Not 
tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 300009D4, DSISR: C2000000
TASK = c0fda870[1] 'init' THREAD: c0fd6000Last syscall: 11
GPR00: C01C4D60 C0FD7E00 C0FDA870 30000000 00000100 00000F3B 30000000 
00000040
GPR08: 00000000 C01C4D60 C0F3E4C0 0001E760 00016FCB 1001F0AC 00FD0100 
007FFE30
GPR16: FFFFFFFF 00F841E0 00000001 007FFEC0 007FFF00 00000000 00000000 
C01C4D60
GPR24: 00000000 C01C3300 00000000 C0F3FF14 300009D4 C0F3E4C0 00F3B889 
C0200760
NIP [c00070f0] __flush_dcache_icache+0x10/0x3c
LR [c000c580] update_mmu_cache+0x98/0x9c
Call trace:
 [c0044270] do_no_page+0x19c/0x35c
 [c00445ec] handle_mm_fault+0xf8/0x178
 [c000bbac] do_page_fault+0x1f0/0x3e8
 [c0004868] handle_page_fault+0xc/0x80


In order to fix this I now have to remove update_mmu_cache  by defining 
it empty.

Please see the following patch.

Regards

Pantelis


--------------000902040807040402080505
Content-Type: text/x-patch;
 name="8xx-tlb.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="8xx-tlb.patch"

===== include/asm-ppc/tlbflush.h 1.10 vs edited =====
--- 1.10/include/asm-ppc/tlbflush.h     Mon Jun  7 00:01:50 2004
+++ edited/include/asm-ppc/tlbflush.h   Mon Jun  7 10:20:49 2004
@@ -56,6 +56,9 @@
 static inline void flush_tlb_kernel_range(unsigned long start,
                                unsigned long end)
        { __tlbia(); }
+static inline void update_mmu_cache(struct vm_area_struct *vma,
+                               unsigned long addr, pte_t pte)
+       { /* nothing */ }
  
 #else  /* 6xx, 7xx, 7xxx cpus */
 struct mm_struct;
@@ -78,6 +81,7 @@
 {
 }
  
+#if !defined(CONFIG_8xx)
 /*
  * This gets called at the end of handling a page fault, when
  * the kernel has put a new PTE into the page table for the process.
@@ -88,6 +92,7 @@
  * waiting for the inevitable extra hash-table miss exception.
  */
 extern void update_mmu_cache(struct vm_area_struct *, unsigned long, pte_t);
+#endif
  
 #endif /* _PPC_TLBFLUSH_H */
 #endif /*__KERNEL__ */
===== arch/ppc/mm/init.c 1.36 vs edited =====
--- 1.36/arch/ppc/mm/init.c     Sat May 15 05:00:22 2004
+++ edited/arch/ppc/mm/init.c   Mon Jun  7 10:19:36 2004
@@ -605,6 +605,7 @@
        kunmap(page);
 }
  
+#if !defined(CONFIG_8xx)
 /*
  * This is called at the end of handling a user page fault, when the
  * fault has been handled by updating a PTE in the linux page tables.
@@ -642,3 +643,4 @@
        }
 #endif
 }
+#endif

--------------000902040807040402080505--
