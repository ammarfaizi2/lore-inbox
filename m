Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750997AbWD3G7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbWD3G7L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 02:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbWD3G7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 02:59:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28054 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750996AbWD3G7K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 02:59:10 -0400
Date: Sat, 29 Apr 2006 23:57:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Shaohua Li <shaohua.li@intel.com>
Cc: pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] don't use flush_tlb_all in suspend time
Message-Id: <20060429235721.1d081ea5.akpm@osdl.org>
In-Reply-To: <1146379596.8456.4.camel@sli10-desk.sh.intel.com>
References: <1146367462.21486.10.camel@sli10-desk.sh.intel.com>
	<20060430064505.GA5091@ucw.cz>
	<1146379596.8456.4.camel@sli10-desk.sh.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shaohua Li <shaohua.li@intel.com> wrote:
>
> On Sun, 2006-04-30 at 06:45 +0000, Pavel Machek wrote:
> > Hi!
> > 
> > > flush_tlb_all uses on_each_cpu, which will disable/enable interrupt.
> > > In suspend/resume time, this will make interrupt wrongly enabled.
> > 
> > > diff -puN arch/i386/mm/init.c~flush_tlb_all_check arch/i386/mm/init.c
> > > --- linux-2.6.17-rc3/arch/i386/mm/init.c~flush_tlb_all_check	2006-04-29 08:47:05.000000000 +0800
> > > +++ linux-2.6.17-rc3-root/arch/i386/mm/init.c	2006-04-29 08:48:15.000000000 +0800
> > > @@ -420,7 +420,10 @@ void zap_low_mappings (void)
> > >  #else
> > >  		set_pgd(swapper_pg_dir+i, __pgd(0));
> > >  #endif
> > > -	flush_tlb_all();
> > > +	if (cpus_weight(cpu_online_map) == 1)
> > > +		local_flush_tlb();
> > > +	else
> > > +		flush_tlb_all();
> > >  }
> > >
> > 
> > Either it is okay to enable interrupts here -> unneccessary and ugly
> > test, or it is not, and then we are broken in SMP case.
> It's not broken in SMP case, APs are offlined here in suspend/resume.
> 

In which case, how's about this?


 arch/i386/kernel/acpi/sleep.c   |    3 +++
 arch/i386/mm/init.c             |   10 +++++++++-
 arch/x86_64/kernel/acpi/sleep.c |    3 +++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff -puN arch/i386/kernel/acpi/sleep.c~dont-use-flush_tlb_all-in-suspend-time-tidy arch/i386/kernel/acpi/sleep.c
--- devel/arch/i386/kernel/acpi/sleep.c~dont-use-flush_tlb_all-in-suspend-time-tidy	2006-04-29 23:53:33.000000000 -0700
+++ devel-akpm/arch/i386/kernel/acpi/sleep.c	2006-04-29 23:54:09.000000000 -0700
@@ -8,6 +8,8 @@
 #include <linux/acpi.h>
 #include <linux/bootmem.h>
 #include <linux/dmi.h>
+#include <linux/cpumask.h>
+
 #include <asm/smp.h>
 #include <asm/tlbflush.h>
 
@@ -29,6 +31,7 @@ static void init_low_mapping(pgd_t * pgd
 		set_pgd(pgd, *(pgd + USER_PTRS_PER_PGD));
 		pgd_ofs++, pgd++;
 	}
+	WARN_ON(num_online_cpus() != 1);
 	local_flush_tlb();
 }
 
diff -puN arch/i386/mm/init.c~dont-use-flush_tlb_all-in-suspend-time-tidy arch/i386/mm/init.c
--- devel/arch/i386/mm/init.c~dont-use-flush_tlb_all-in-suspend-time-tidy	2006-04-29 23:53:33.000000000 -0700
+++ devel-akpm/arch/i386/mm/init.c	2006-04-29 23:56:00.000000000 -0700
@@ -29,6 +29,7 @@
 #include <linux/efi.h>
 #include <linux/memory_hotplug.h>
 #include <linux/initrd.h>
+#include <linux/cpumask.h>
 
 #include <asm/processor.h>
 #include <asm/system.h>
@@ -420,7 +421,14 @@ void zap_low_mappings (void)
 #else
 		set_pgd(swapper_pg_dir+i, __pgd(0));
 #endif
-	if (cpus_weight(cpu_online_map) == 1)
+	/*
+	 * We can be called at suspend/resume time, with local interrupts
+	 * disabled.  But flush_tlb_all() requires that local interrupts be
+	 * enabled.
+	 *
+	 * Happily, the APs are not yet started, so we can use local_flush_tlb()	 * in that case
+	 */
+	if (num_online_cpus() == 1)
 		local_flush_tlb();
 	else
 		flush_tlb_all();
diff -puN arch/x86_64/kernel/acpi/sleep.c~dont-use-flush_tlb_all-in-suspend-time-tidy arch/x86_64/kernel/acpi/sleep.c
--- devel/arch/x86_64/kernel/acpi/sleep.c~dont-use-flush_tlb_all-in-suspend-time-tidy	2006-04-29 23:53:33.000000000 -0700
+++ devel-akpm/arch/x86_64/kernel/acpi/sleep.c	2006-04-29 23:56:24.000000000 -0700
@@ -35,6 +35,8 @@
 #include <linux/pci.h>
 #include <linux/bootmem.h>
 #include <linux/acpi.h>
+#include <linux/cpumask.h>
+
 #include <asm/mpspec.h>
 #include <asm/io.h>
 #include <asm/apic.h>
@@ -66,6 +68,7 @@ static void init_low_mapping(void)
 	pgd_t *slot0 = pgd_offset(current->mm, 0UL);
 	low_ptr = *slot0;
 	set_pgd(slot0, *pgd_offset(current->mm, PAGE_OFFSET));
+	WARN_ON(num_online_cpus() != 1);
 	local_flush_tlb();
 }
 
_

