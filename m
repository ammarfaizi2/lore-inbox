Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263395AbVCJWqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263395AbVCJWqX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 17:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263369AbVCJWmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 17:42:55 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:24005 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263321AbVCJWfa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 17:35:30 -0500
Date: Thu, 10 Mar 2005 16:27:21 -0600
From: Jake Moilanen <moilanen@austin.ibm.com>
To: akpm@osdl.org
Cc: olof@austin.ibm.com, linuxppc64-dev@ozlabs.org, paulus@samba.org,
       linux-kernel@vger.kernel.org, anton@samba.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] No-exec support for ppc64
Message-Id: <20050310162721.19003dac.moilanen@austin.ibm.com>
In-Reply-To: <1110438934.32524.203.camel@gaston>
References: <20050308165904.0ce07112.moilanen@austin.ibm.com>
	<20050308171326.3d72363a.moilanen@austin.ibm.com>
	<20050310032507.GC20789@austin.ibm.com>
	<1110438934.32524.203.camel@gaston>
Organization: IBM
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2005 18:15:34 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Wed, 2005-03-09 at 21:25 -0600, Olof Johansson wrote:
> > Hi,
> > 
> > On Tue, Mar 08, 2005 at 05:13:26PM -0600, Jake Moilanen wrote:
> > > diff -puN arch/ppc64/mm/hash_utils.c~nx-kernel-ppc64 arch/ppc64/mm/hash_utils.c
> > > --- linux-2.6-bk/arch/ppc64/mm/hash_utils.c~nx-kernel-ppc64	2005-03-08 16:08:57 -06:00
> > > +++ linux-2.6-bk-moilanen/arch/ppc64/mm/hash_utils.c	2005-03-08 16:08:57 -06:00
> > > @@ -89,12 +90,23 @@ static inline void loop_forever(void)
> > >  		;
> > >  }
> > >  
> > > +int is_kernel_text(unsigned long addr)
> > > +{
> > > +	if (addr >= (unsigned long)_stext && addr < (unsigned long)__init_end)
> > > +		return 1;
> > > +
> > > +	return 0;
> > > +}
> > 
> > This is used in two files, but never declared extern in the second file
> > (iSeries_setup.c). Should it go in a header file as a static inline
> > instead?
> 
> Yes, I think it should.
> 

Here is the revised no-exec for the kernel on ppc64 w/ Olof and Ben's comments.

Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>

---

 linux-2.6-bk-moilanen/arch/ppc64/kernel/iSeries_setup.c |    4 +++
 linux-2.6-bk-moilanen/arch/ppc64/kernel/module.c        |    3 +-
 linux-2.6-bk-moilanen/arch/ppc64/mm/fault.c             |   19 ++++++++++++++
 linux-2.6-bk-moilanen/arch/ppc64/mm/hash_utils.c        |   21 ++++++++++------
 linux-2.6-bk-moilanen/include/asm-ppc64/pgtable.h       |    1 
 linux-2.6-bk-moilanen/include/asm-ppc64/sections.h      |    9 ++++++
 6 files changed, 49 insertions(+), 8 deletions(-)

diff -puN arch/ppc64/kernel/iSeries_setup.c~nx-kernel-ppc64 arch/ppc64/kernel/iSeries_setup.c
--- linux-2.6-bk/arch/ppc64/kernel/iSeries_setup.c~nx-kernel-ppc64	2005-03-10 13:54:14 -06:00
+++ linux-2.6-bk-moilanen/arch/ppc64/kernel/iSeries_setup.c	2005-03-10 13:59:12 -06:00
@@ -633,6 +633,10 @@ static void __init iSeries_bolt_kernel(u
 		unsigned long vpn = va >> PAGE_SHIFT;
 		unsigned long slot = HvCallHpt_findValid(&hpte, vpn);
 
+		/* Make non-kernel text non-executable */
+		if (!in_kernel_text(ea))
+			mode_rw |= HW_NO_EXEC;
+
 		if (hpte.dw0.dw0.v) {
 			/* HPTE exists, so just bolt it */
 			HvCallHpt_setSwBits(slot, 0x10, 0);
diff -puN arch/ppc64/kernel/module.c~nx-kernel-ppc64 arch/ppc64/kernel/module.c
--- linux-2.6-bk/arch/ppc64/kernel/module.c~nx-kernel-ppc64	2005-03-10 13:54:14 -06:00
+++ linux-2.6-bk-moilanen/arch/ppc64/kernel/module.c	2005-03-10 13:54:14 -06:00
@@ -102,7 +102,8 @@ void *module_alloc(unsigned long size)
 {
 	if (size == 0)
 		return NULL;
-	return vmalloc(size);
+
+	return vmalloc_exec(size);
 }
 
 /* Free memory returned from module_alloc */
diff -puN arch/ppc64/mm/fault.c~nx-kernel-ppc64 arch/ppc64/mm/fault.c
--- linux-2.6-bk/arch/ppc64/mm/fault.c~nx-kernel-ppc64	2005-03-10 13:54:14 -06:00
+++ linux-2.6-bk-moilanen/arch/ppc64/mm/fault.c	2005-03-10 13:54:14 -06:00
@@ -76,6 +76,13 @@ static int store_updates_sp(struct pt_re
 	return 0;
 }
 
+pte_t *lookup_address(unsigned long address) 
+{ 
+	pgd_t *pgd = pgd_offset_k(address); 
+
+	return find_linux_pte(pgd, address);
+} 
+
 /*
  * The error_code parameter is
  *  - DSISR for a non-SLB data access fault,
@@ -94,6 +101,7 @@ int do_page_fault(struct pt_regs *regs, 
 	unsigned long is_write = error_code & 0x02000000;
 	unsigned long trap = TRAP(regs);
  	unsigned long is_exec = trap == 0x400;	
+	pte_t *ptep;
 
 	BUG_ON((trap == 0x380) || (trap == 0x480));
 
@@ -253,6 +261,17 @@ bad_area_nosemaphore:
 		info.si_addr = (void __user *) address;
 		force_sig_info(SIGSEGV, &info, current);
 		return 0;
+	} 
+
+	ptep = lookup_address(address);
+
+	if (ptep && pte_present(*ptep) && !pte_exec(*ptep)) {
+		if (printk_ratelimit())
+			printk(KERN_CRIT "kernel tried to execute NX-protected "
+			       "page - exploit attempt? (uid: %d)\n",
+			       current->uid);
+		show_stack(current, (unsigned long *)__get_SP());
+		do_exit(SIGKILL);
 	}
 
 	return SIGSEGV;
diff -puN arch/ppc64/mm/hash_utils.c~nx-kernel-ppc64 arch/ppc64/mm/hash_utils.c
--- linux-2.6-bk/arch/ppc64/mm/hash_utils.c~nx-kernel-ppc64	2005-03-10 13:54:14 -06:00
+++ linux-2.6-bk-moilanen/arch/ppc64/mm/hash_utils.c	2005-03-10 13:58:37 -06:00
@@ -51,6 +51,7 @@
 #include <asm/cacheflush.h>
 #include <asm/cputable.h>
 #include <asm/abs_addr.h>
+#include <asm/sections.h>
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
@@ -95,6 +96,7 @@ static inline void create_pte_mapping(un
 {
 	unsigned long addr;
 	unsigned int step;
+	unsigned long tmp_mode;
 
 	if (large)
 		step = 16*MB;
@@ -112,6 +114,13 @@ static inline void create_pte_mapping(un
 		else
 			vpn = va >> PAGE_SHIFT;
 
+
+		tmp_mode = mode;
+		
+		/* Make non-kernel text non-executable */
+		if (!in_kernel_text(addr))
+			tmp_mode = mode | HW_NO_EXEC;
+
 		hash = hpt_hash(vpn, large);
 
 		hpteg = ((hash & htab_hash_mask) * HPTES_PER_GROUP);
@@ -120,12 +129,12 @@ static inline void create_pte_mapping(un
 		if (systemcfg->platform & PLATFORM_LPAR)
 			ret = pSeries_lpar_hpte_insert(hpteg, va,
 				virt_to_abs(addr) >> PAGE_SHIFT,
-				0, mode, 1, large);
+				0, tmp_mode, 1, large);
 		else
 #endif /* CONFIG_PPC_PSERIES */
 			ret = native_hpte_insert(hpteg, va,
 				virt_to_abs(addr) >> PAGE_SHIFT,
-				0, mode, 1, large);
+				0, tmp_mode, 1, large);
 
 		if (ret == -1) {
 			ppc64_terminate_msg(0x20, "create_pte_mapping");
@@ -238,8 +247,6 @@ unsigned int hash_page_do_lazy_icache(un
 {
 	struct page *page;
 
-#define PPC64_HWNOEXEC (1 << 2)
-
 	if (!pfn_valid(pte_pfn(pte)))
 		return pp;
 
@@ -250,8 +257,8 @@ unsigned int hash_page_do_lazy_icache(un
 		if (trap == 0x400) {
 			__flush_dcache_icache(page_address(page));
 			set_bit(PG_arch_1, &page->flags);
-		} else
-			pp |= PPC64_HWNOEXEC;
+		} else 
+			pp |= HW_NO_EXEC;
 	}
 	return pp;
 }
@@ -271,7 +278,7 @@ int hash_page(unsigned long ea, unsigned
 	int user_region = 0;
 	int local = 0;
 	cpumask_t tmp;
-
+	
  	switch (REGION_ID(ea)) {
 	case USER_REGION_ID:
 		user_region = 1;
diff -puN include/asm-ppc64/pgtable.h~nx-kernel-ppc64 include/asm-ppc64/pgtable.h
--- linux-2.6-bk/include/asm-ppc64/pgtable.h~nx-kernel-ppc64	2005-03-10 13:54:14 -06:00
+++ linux-2.6-bk-moilanen/include/asm-ppc64/pgtable.h	2005-03-10 13:54:14 -06:00
@@ -117,6 +117,7 @@
 #define PAGE_READONLY	__pgprot(_PAGE_BASE | _PAGE_USER)
 #define PAGE_READONLY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_EXEC)
 #define PAGE_KERNEL	__pgprot(_PAGE_BASE | _PAGE_WRENABLE)
+#define PAGE_KERNEL_EXEC __pgprot(_PAGE_BASE | _PAGE_WRENABLE | _PAGE_EXEC)
 
 #define HW_NO_EXEC	_PAGE_EXEC /* This is used when the bit is
 				    * inverted, even though it's the
diff -puN include/asm-ppc64/sections.h~nx-kernel-ppc64 include/asm-ppc64/sections.h
--- linux-2.6-bk/include/asm-ppc64/sections.h~nx-kernel-ppc64	2005-03-10 13:54:14 -06:00
+++ linux-2.6-bk-moilanen/include/asm-ppc64/sections.h	2005-03-10 13:58:12 -06:00
@@ -17,4 +17,13 @@ extern char _end[];
 #define __openfirmware
 #define __openfirmwaredata
 
+
+static inline int in_kernel_text(unsigned long addr)
+{
+	if (addr >= (unsigned long)_stext && addr < (unsigned long)__init_end)
+		return 1;
+
+	return 0;
+}
+
 #endif

_
