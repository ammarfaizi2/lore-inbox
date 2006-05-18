Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbWERU5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbWERU5f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 16:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWERU5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 16:57:35 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:24803 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751291AbWERU5e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 16:57:34 -0400
Date: Thu, 18 May 2006 16:57:26 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, fastboot@lists.osdl.org
Subject: Re: [PATCH] i386 kdump boot cpu physical apicid fix
Message-ID: <20060518205726.GC20121@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060518163542.GA20121@in.ibm.com> <20060518123655.7057e20e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060518123655.7057e20e.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2006 at 12:36:55PM -0700, Andrew Morton wrote:
> > 
> > diff -puN arch/i386/kernel/apic.c~kdump-i386-boot-cpu-physical-apicid-fix arch/i386/kernel/apic.c
> > --- linux-2.6.17-rc4-16M/arch/i386/kernel/apic.c~kdump-i386-boot-cpu-physical-apicid-fix	2006-05-17 13:27:44.000000000 -0400
> > +++ linux-2.6.17-rc4-16M-root/arch/i386/kernel/apic.c	2006-05-18 05:11:44.000000000 -0400
> > @@ -860,12 +860,7 @@ void __init init_apic_mappings(void)
> >  	printk(KERN_DEBUG "mapped APIC to %08lx (%08lx)\n", APIC_BASE,
> >  	       apic_phys);
> >  
> > -	/*
> > -	 * Fetch the APIC ID of the BSP in case we have a
> > -	 * default configuration (or the MP table is broken).
> > -	 */
> > -	if (boot_cpu_physical_apicid == -1U)
> > -		boot_cpu_physical_apicid = GET_APIC_ID(apic_read(APIC_ID));
> > +	boot_cpu_physical_apicid = GET_APIC_ID(apic_read(APIC_ID));
> >  
> 
> I just don't think we can do this sort of thing.  The workaround for broken
> MP tables is one of those nasty things we've gained through many years of
> hard-won real-world experience.
> 
> If we just go and toss it away like this, all those machines which used to
> work will break and there'll be a sad little dribble of regression reports
> which everyone cheerily ignores as usual.
> 
> So, sorry, nope.  Please find a way to fix kdump while retaining the
> broken-MP-table workaround.

Ok. I thought if overriding MP tables works in SMP case then it should work
in UP case too. But anyway, here is the take2. This one is little ugly and
hackish but limits the impact to only UP kernels and that too if CRASH_DUMP
is enabled. 




o Kdump second kernel boot fails after a system crash if second kernel
  is UP and acpi=off and if crash occurred on a non-boot cpu. 

o Issue here is that MP tables report boot cpu lapic id as 0 but second
  kernel is booting on a different processor and MP table data is stale
  in this context. Hence apic_id_registered() check fails in setup_local_APIC()
  when called from APIC_init_uniprocessor(). 

o Problem is not seen if ACPI is enabled as in that case
  boot_cpu_physical_apicid is read from the LAPIC.

o Problem is not seen with SMP kernels as well because in this case also
  boot_cpu_physical_apicid is read from LAPIC. (smp_boot_cpus()).

o The problem is fixed by reading boot_cpu_physical_apicid from LAPIC 
  if it is a UP kernel and CRASH_DUMP is enabled.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/i386/kernel/apic.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff -puN arch/i386/kernel/apic.c~kdump-i386-boot-cpu-physical-apicid-fix-take2 arch/i386/kernel/apic.c
--- linux-2.6.17-rc4-16M/arch/i386/kernel/apic.c~kdump-i386-boot-cpu-physical-apicid-fix-take2	2006-05-18 11:26:45.000000000 -0400
+++ linux-2.6.17-rc4-16M-root/arch/i386/kernel/apic.c	2006-05-18 11:26:45.000000000 -0400
@@ -1341,6 +1341,14 @@ int __init APIC_init_uniprocessor (void)
 
 	connect_bsp_APIC();
 
+	/*
+	 * Hack: In case of kdump, after a crash, kernel might be booting
+	 * on a cpu with non-zero lapic id. But boot_cpu_physical_apicid
+	 * might be zero if read from MP tables. Get it from LAPIC.
+	 */
+#ifdef CONFIG_CRASH_DUMP
+	boot_cpu_physical_apicid = GET_APIC_ID(apic_read(APIC_ID));
+#endif
 	phys_cpu_present_map = physid_mask_of_physid(boot_cpu_physical_apicid);
 
 	setup_local_APIC();
_
