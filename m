Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267594AbSLSKE5>; Thu, 19 Dec 2002 05:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267595AbSLSKE4>; Thu, 19 Dec 2002 05:04:56 -0500
Received: from holomorphy.com ([66.224.33.161]:32704 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267594AbSLSKEw>;
	Thu, 19 Dec 2002 05:04:52 -0500
Date: Thu, 19 Dec 2002 02:12:19 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: 2.5.52-mm2
Message-ID: <20021219101219.GS31800@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
	linux-mm@kvack.org
References: <3E015ECE.9E3BD19@digeo.com> <20021219085426.GJ1922@holomorphy.com> <20021219092853.GK1922@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021219092853.GK1922@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2002 at 09:53:18PM -0800, Andrew Morton wrote:
>>> url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.52/2.5.52-mm2/

On Thu, Dec 19, 2002 at 12:54:26AM -0800, William Lee Irwin III wrote:
>> Kernel compile on ramfs, shpte off, overcommit on (probably more like a
>> stress test for shpte):

On Thu, Dec 19, 2002 at 01:28:53AM -0800, William Lee Irwin III wrote:
> With shpte on:

With the following patch:

c013d4d4 94944    0.310788    zap_pte_range
c01355d0 104773   0.342962    nr_free_pages
c014f65c 107566   0.352105    __fput
c01b1750 112055   0.366799    __copy_user_intel
c0115350 121040   0.39621     smp_apic_timer_interrupt
c0119814 126089   0.412738    kmap_atomic
c014b6cc 145095   0.474952    pte_unshare
c01fb11c 145992   0.477888    sync_buffer
c0122a78 148079   0.484719    current_kernel_time
c01168b8 193805   0.634398    x86_profile_hook
c013f140 205233   0.671806    do_no_page
c0164aac 235356   0.77041     d_lookup
c01b18f8 257358   0.842431    __copy_from_user
c0131f7c 275559   0.90201     find_get_page
c011a560 282341   0.92421     scheduler_tick
c0140090 300128   0.982434    vm_enough_memory
c013f4bc 310474   1.0163      handle_mm_fault
c014f3d0 312725   1.02367     get_empty_filp
c011a0a8 365066   1.195       load_balance
c014f9e9 502737   1.64565     .text.lock.file_table
c01b1890 719105   2.35391     __copy_to_user
c0135768 911894   2.98498     __get_page_state
c013ee50 952823   3.11895     do_anonymous_page
c01436d0 1079864  3.53481     page_add_rmap
c01438cc 1186938  3.8853      page_remove_rmap
c0106f38 17763755 58.1476     poll_idle


pfn_to_nid() got lots of icache misses. Try using a macro.

 arch/i386/kernel/i386_ksyms.c |    1 -
 arch/i386/kernel/numaq.c      |   15 ++-------------
 include/asm-i386/numaq.h      |    3 ++-
 3 files changed, 4 insertions(+), 15 deletions(-)


diff -urpN linux-2.5.52-mm1/arch/i386/kernel/i386_ksyms.c mm1-2.5.52-1/arch/i386/kernel/i386_ksyms.c
--- linux-2.5.52-mm1/arch/i386/kernel/i386_ksyms.c	2002-12-16 19:29:45.000000000 -0800
+++ mm1-2.5.52-1/arch/i386/kernel/i386_ksyms.c	2002-12-17 08:47:25.000000000 -0800
@@ -67,7 +67,6 @@ EXPORT_SYMBOL(EISA_bus);
 EXPORT_SYMBOL(MCA_bus);
 #ifdef CONFIG_DISCONTIGMEM
 EXPORT_SYMBOL(node_data);
-EXPORT_SYMBOL(pfn_to_nid);
 #endif
 #ifdef CONFIG_X86_NUMAQ
 EXPORT_SYMBOL(xquad_portio);
diff -urpN linux-2.5.52-mm1/arch/i386/kernel/numaq.c mm1-2.5.52-1/arch/i386/kernel/numaq.c
--- linux-2.5.52-mm1/arch/i386/kernel/numaq.c	2002-12-15 18:08:13.000000000 -0800
+++ mm1-2.5.52-1/arch/i386/kernel/numaq.c	2002-12-17 08:51:44.000000000 -0800
@@ -27,6 +27,7 @@
 #include <linux/mm.h>
 #include <linux/bootmem.h>
 #include <linux/mmzone.h>
+#include <linux/module.h>
 #include <asm/numaq.h>
 
 /* These are needed before the pgdat's are created */
@@ -82,19 +83,7 @@ static void __init smp_dump_qct(void)
  * physnode_map[8- ] = -1;
  */
 int physnode_map[MAX_ELEMENTS] = { [0 ... (MAX_ELEMENTS - 1)] = -1};
-
-#define PFN_TO_ELEMENT(pfn) (pfn / PAGES_PER_ELEMENT)
-#define PA_TO_ELEMENT(pa) (PFN_TO_ELEMENT(pa >> PAGE_SHIFT))
-
-int pfn_to_nid(unsigned long pfn)
-{
-	int nid = physnode_map[PFN_TO_ELEMENT(pfn)];
-
-	if (nid == -1)
-		BUG(); /* address is not present */
-
-	return nid;
-}
+EXPORT_SYMBOL(physnode_map);
 
 /*
  * for each node mark the regions
diff -urpN linux-2.5.52-mm1/include/asm-i386/numaq.h mm1-2.5.52-1/include/asm-i386/numaq.h
--- linux-2.5.52-mm1/include/asm-i386/numaq.h	2002-12-15 18:08:09.000000000 -0800
+++ mm1-2.5.52-1/include/asm-i386/numaq.h	2002-12-17 08:45:19.000000000 -0800
@@ -38,10 +38,11 @@
 #define MAX_ELEMENTS 256
 #define PAGES_PER_ELEMENT (16777216/256)
 
+extern int physnode_map[];
+#define pfn_to_nid(pfn)	({ physnode_map[(pfn) / PAGES_PER_ELEMENT]; })
 #define pfn_to_pgdat(pfn) NODE_DATA(pfn_to_nid(pfn))
 #define PHYSADDR_TO_NID(pa) pfn_to_nid(pa >> PAGE_SHIFT)
 #define MAX_NUMNODES		8
-extern int pfn_to_nid(unsigned long);
 extern void get_memcfg_numaq(void);
 #define get_memcfg_numa() get_memcfg_numaq()
 
