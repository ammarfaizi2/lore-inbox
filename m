Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbWERDbD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbWERDbD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 23:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWERDbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 23:31:01 -0400
Received: from mga02.intel.com ([134.134.136.20]:21398 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751130AbWERDbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 23:31:00 -0400
X-IronPort-AV: i="4.05,139,1146466800"; 
   d="scan'208"; a="37879238:sNHT417691946"
Subject: Re: [PATCH] don't use flush_tlb_all in suspend time
From: Shaohua Li <shaohua.li@intel.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060430120421.GA30024@elf.ucw.cz>
References: <1146367462.21486.10.camel@sli10-desk.sh.intel.com>
	 <20060430064505.GA5091@ucw.cz>
	 <1146379596.8456.4.camel@sli10-desk.sh.intel.com>
	 <20060429235721.1d081ea5.akpm@osdl.org> <20060430120421.GA30024@elf.ucw.cz>
Content-Type: text/plain
Date: Thu, 18 May 2006 11:29:33 +0800
Message-Id: <1147922973.32046.13.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-04-30 at 14:04 +0200, Pavel Machek wrote:
> On So 29-04-06 23:57:21, Andrew Morton wrote:
> > Shaohua Li <shaohua.li@intel.com> wrote:
> > >
> > > On Sun, 2006-04-30 at 06:45 +0000, Pavel Machek wrote:
> > > > Hi!
> > > > 
> > > > > flush_tlb_all uses on_each_cpu, which will disable/enable interrupt.
> > > > > In suspend/resume time, this will make interrupt wrongly enabled.
> > > > 
> > > > > diff -puN arch/i386/mm/init.c~flush_tlb_all_check arch/i386/mm/init.c
> > > > > --- linux-2.6.17-rc3/arch/i386/mm/init.c~flush_tlb_all_check	2006-04-29 08:47:05.000000000 +0800
> > > > > +++ linux-2.6.17-rc3-root/arch/i386/mm/init.c	2006-04-29 08:48:15.000000000 +0800
> > > > > @@ -420,7 +420,10 @@ void zap_low_mappings (void)
> > > > >  #else
> > > > >  		set_pgd(swapper_pg_dir+i, __pgd(0));
> > > > >  #endif
> > > > > -	flush_tlb_all();
> > > > > +	if (cpus_weight(cpu_online_map) == 1)
> > > > > +		local_flush_tlb();
> > > > > +	else
> > > > > +		flush_tlb_all();
> > > > >  }
> > > > >
> > > > 
> > > > Either it is okay to enable interrupts here -> unneccessary and ugly
> > > > test, or it is not, and then we are broken in SMP case.
> > > It's not broken in SMP case, APs are offlined here in suspend/resume.
> > > 
> > 
> > In which case, how's about this?
> 
> Certainly better, I'd say.
> 
> > @@ -420,7 +421,14 @@ void zap_low_mappings (void)
> >  #else
> >  		set_pgd(swapper_pg_dir+i, __pgd(0));
> >  #endif
> > -	if (cpus_weight(cpu_online_map) == 1)
> > +	/*
> > +	 * We can be called at suspend/resume time, with local interrupts
> > +	 * disabled.  But flush_tlb_all() requires that local interrupts be
> > +	 * enabled.
> > +	 *
> > +	 * Happily, the APs are not yet started, so we can use local_flush_tlb()	 * in that case
> > +	 */
> > +	if (num_online_cpus() == 1)
> >  		local_flush_tlb();
> >  	else
> >  		flush_tlb_all();
> 
> But this still scares. It means calling convention is "may enable
> interrupts with >1 cpu, may not with == 1 cpu". 
Below patch should make things clean. How do you think?

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---

 linux-2.6.17-rc4-mm1-root/arch/i386/kernel/acpi/sleep.c  |   10 +++-------
 linux-2.6.17-rc4-mm1-root/arch/i386/kernel/acpi/wakeup.S |    2 +-
 linux-2.6.17-rc4-mm1-root/arch/i386/mm/init.c            |   13 +------------
 3 files changed, 5 insertions(+), 20 deletions(-)

diff -puN arch/i386/kernel/acpi/wakeup.S~i386_direct_mapping arch/i386/kernel/acpi/wakeup.S
--- linux-2.6.17-rc4-mm1/arch/i386/kernel/acpi/wakeup.S~i386_direct_mapping	2006-05-16 14:52:37.000000000 +0800
+++ linux-2.6.17-rc4-mm1-root/arch/i386/kernel/acpi/wakeup.S	2006-05-16 15:10:57.000000000 +0800
@@ -56,7 +56,7 @@ wakeup_code:
 1:
 
 	# set up page table
-	movl	$swapper_pg_dir-__PAGE_OFFSET, %eax
+	movl	$sleep_pg_dir-__PAGE_OFFSET, %eax
 	movl	%eax, %cr3
 
 	testl	$1, real_efer_save_restore - wakeup_code
diff -puN arch/i386/kernel/acpi/sleep.c~i386_direct_mapping arch/i386/kernel/acpi/sleep.c
--- linux-2.6.17-rc4-mm1/arch/i386/kernel/acpi/sleep.c~i386_direct_mapping	2006-05-16 14:52:51.000000000 +0800
+++ linux-2.6.17-rc4-mm1-root/arch/i386/kernel/acpi/sleep.c	2006-05-17 09:30:26.000000000 +0800
@@ -11,16 +11,14 @@
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
+char sleep_pg_dir[PAGE_SIZE];
 
 static void init_low_mapping(pgd_t * pgd, int pgd_limit)
 {
@@ -31,8 +29,6 @@ static void init_low_mapping(pgd_t * pgd
 		set_pgd(pgd, *(pgd + USER_PTRS_PER_PGD));
 		pgd_ofs++, pgd++;
 	}
-	WARN_ON(num_online_cpus() != 1);
-	local_flush_tlb();
 }
 
 /**
@@ -45,7 +41,8 @@ int acpi_save_state_mem(void)
 {
 	if (!acpi_wakeup_address)
 		return 1;
-	init_low_mapping(swapper_pg_dir, USER_PTRS_PER_PGD);
+	memcpy(sleep_pg_dir, swapper_pg_dir, PAGE_SIZE);
+	init_low_mapping((pgd_t *)sleep_pg_dir, USER_PTRS_PER_PGD);
 	memcpy((void *)acpi_wakeup_address, &wakeup_start,
 	       &wakeup_end - &wakeup_start);
 	acpi_copy_wakeup_routine(acpi_wakeup_address);
@@ -58,7 +55,6 @@ int acpi_save_state_mem(void)
  */
 void acpi_restore_state_mem(void)
 {
-	zap_low_mappings();
 }
 
 /**
diff -puN arch/i386/mm/init.c~i386_direct_mapping arch/i386/mm/init.c
--- linux-2.6.17-rc4-mm1/arch/i386/mm/init.c~i386_direct_mapping	2006-05-17 09:03:39.000000000 +0800
+++ linux-2.6.17-rc4-mm1-root/arch/i386/mm/init.c	2006-05-17 09:03:49.000000000 +0800
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
