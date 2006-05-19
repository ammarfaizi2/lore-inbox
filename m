Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbWESBRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbWESBRE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 21:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWESBRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 21:17:04 -0400
Received: from mga02.intel.com ([134.134.136.20]:53066 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932169AbWESBRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 21:17:03 -0400
X-IronPort-AV: i="4.05,143,1146466800"; 
   d="scan'208"; a="38398414:sNHT15926309"
Subject: Re: [PATCH] don't use flush_tlb_all in suspend time
From: Shaohua Li <shaohua.li@intel.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060518083146.GA12724@elf.ucw.cz>
References: <1146367462.21486.10.camel@sli10-desk.sh.intel.com>
	 <20060430064505.GA5091@ucw.cz>
	 <1146379596.8456.4.camel@sli10-desk.sh.intel.com>
	 <20060429235721.1d081ea5.akpm@osdl.org> <20060430120421.GA30024@elf.ucw.cz>
	 <1147922973.32046.13.camel@sli10-desk.sh.intel.com>
	 <20060518083146.GA12724@elf.ucw.cz>
Content-Type: text/plain
Date: Fri, 19 May 2006 09:15:35 +0800
Message-Id: <1148001335.32046.25.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-05-18 at 10:31 +0200, Pavel Machek wrote:
> Hi!
> 
> > > > In which case, how's about this?
> > > 
> > > Certainly better, I'd say.
> > > 
> > > > @@ -420,7 +421,14 @@ void zap_low_mappings (void)
> > > >  #else
> > > >  		set_pgd(swapper_pg_dir+i, __pgd(0));
> > > >  #endif
> > > > -	if (cpus_weight(cpu_online_map) == 1)
> > > > +	/*
> > > > +	 * We can be called at suspend/resume time, with local interrupts
> > > > +	 * disabled.  But flush_tlb_all() requires that local interrupts be
> > > > +	 * enabled.
> > > > +	 *
> > > > +	 * Happily, the APs are not yet started, so we can use local_flush_tlb()	 * in that case
> > > > +	 */
> > > > +	if (num_online_cpus() == 1)
> > > >  		local_flush_tlb();
> > > >  	else
> > > >  		flush_tlb_all();
> > > 
> > > But this still scares. It means calling convention is "may enable
> > > interrupts with >1 cpu, may not with == 1 cpu". 
> > Below patch should make things clean. How do you think?
> 
> Nice...
> 
> Could we perhaps reuse swsusp_pg_dir (just make it used for swsusp &
> suspend-to-ram) to save a bit more code? It is in arch/i386/mm/init.c
Ok, I guess this is what you want.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---

 linux-2.6.17-rc4-mm1-root/arch/i386/kernel/acpi/sleep.c  |   18 ---------------
 linux-2.6.17-rc4-mm1-root/arch/i386/kernel/acpi/wakeup.S |    2 -
 linux-2.6.17-rc4-mm1-root/arch/i386/mm/init.c            |   15 +-----------
 3 files changed, 3 insertions(+), 32 deletions(-)

diff -puN arch/i386/kernel/acpi/wakeup.S~i386_direct_mapping arch/i386/kernel/acpi/wakeup.S
--- linux-2.6.17-rc4-mm1/arch/i386/kernel/acpi/wakeup.S~i386_direct_mapping	2006-05-16 14:52:37.000000000 +0800
+++ linux-2.6.17-rc4-mm1-root/arch/i386/kernel/acpi/wakeup.S	2006-05-18 07:12:40.000000000 +0800
@@ -56,7 +56,7 @@ wakeup_code:
 1:
 
 	# set up page table
-	movl	$swapper_pg_dir-__PAGE_OFFSET, %eax
+	movl	$swsusp_pg_dir-__PAGE_OFFSET, %eax
 	movl	%eax, %cr3
 
 	testl	$1, real_efer_save_restore - wakeup_code
diff -puN arch/i386/kernel/acpi/sleep.c~i386_direct_mapping arch/i386/kernel/acpi/sleep.c
--- linux-2.6.17-rc4-mm1/arch/i386/kernel/acpi/sleep.c~i386_direct_mapping	2006-05-16 14:52:51.000000000 +0800
+++ linux-2.6.17-rc4-mm1-root/arch/i386/kernel/acpi/sleep.c	2006-05-18 07:11:38.000000000 +0800
@@ -11,30 +11,14 @@
 #include <linux/cpumask.h>
 
 #include <asm/smp.h>
-#include <asm/tlbflush.h>
 
 /* address in low memory of the wakeup routine. */
 unsigned long acpi_wakeup_address = 0;
 unsigned long acpi_video_flags;
 extern char wakeup_start, wakeup_end;
 
-extern void zap_low_mappings(void);
-
 extern unsigned long FASTCALL(acpi_copy_wakeup_routine(unsigned long));
 
-static void init_low_mapping(pgd_t * pgd, int pgd_limit)
-{
-	int pgd_ofs = 0;
-
-	while ((pgd_ofs < pgd_limit)
-	       && (pgd_ofs + USER_PTRS_PER_PGD < PTRS_PER_PGD)) {
-		set_pgd(pgd, *(pgd + USER_PTRS_PER_PGD));
-		pgd_ofs++, pgd++;
-	}
-	WARN_ON(num_online_cpus() != 1);
-	local_flush_tlb();
-}
-
 /**
  * acpi_save_state_mem - save kernel state
  *
@@ -45,7 +29,6 @@ int acpi_save_state_mem(void)
 {
 	if (!acpi_wakeup_address)
 		return 1;
-	init_low_mapping(swapper_pg_dir, USER_PTRS_PER_PGD);
 	memcpy((void *)acpi_wakeup_address, &wakeup_start,
 	       &wakeup_end - &wakeup_start);
 	acpi_copy_wakeup_routine(acpi_wakeup_address);
@@ -58,7 +41,6 @@ int acpi_save_state_mem(void)
  */
 void acpi_restore_state_mem(void)
 {
-	zap_low_mappings();
 }
 
 /**
diff -puN arch/i386/mm/init.c~i386_direct_mapping arch/i386/mm/init.c
--- linux-2.6.17-rc4-mm1/arch/i386/mm/init.c~i386_direct_mapping	2006-05-17 09:03:39.000000000 +0800
+++ linux-2.6.17-rc4-mm1-root/arch/i386/mm/init.c	2006-05-18 07:11:10.000000000 +0800
@@ -386,7 +386,7 @@ static void __init pagetable_init (void)
 #endif
 }
 
-#ifdef CONFIG_SOFTWARE_SUSPEND
+#if defined(CONFIG_SOFTWARE_SUSPEND) || defined(CONFIG_ACPI_SLEEP)
 /*
  * Swap suspend & friends need this for resume because things like the intel-agp
  * driver might have split up a kernel 4MB mapping.
@@ -422,18 +422,7 @@ void zap_low_mappings (void)
 #else
 		set_pgd(swapper_pg_dir+i, __pgd(0));
 #endif
-	/*
-	 * We can be called at suspend/resume time, with local interrupts
-	 * disabled.  But flush_tlb_all() requires that local interrupts be
-	 * enabled.
-	 *
-	 * Happily, the APs are not yet started, so we can use local_flush_tlb()
-	 * in that case
-	 */
-	if (num_online_cpus() == 1)
-		local_flush_tlb();
-	else
-		flush_tlb_all();
+	flush_tlb_all();
 }
 
 static int disable_nx __initdata = 0;
_

