Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030334AbVIAVJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030334AbVIAVJk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 17:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030374AbVIAVJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 17:09:39 -0400
Received: from usbb-lacimss1.unisys.com ([192.63.108.51]:6413 "EHLO
	usbb-lacimss1.unisys.com") by vger.kernel.org with ESMTP
	id S1030334AbVIAVJi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 17:09:38 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 1/1] Hot plug CPU to support physical add of new processors (i386)
Date: Thu, 1 Sep 2005 16:09:09 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04D14@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 1/1] Hot plug CPU to support physical add of new processors (i386)
Thread-Index: AcWvG9W4mPXfp/VrSaqNBJyNZuoe3wAFTuQg
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Ashok Raj" <ashok.raj@intel.com>
Cc: <shaohua.li@intel.com>, <zwane@arm.linux.org.uk>, <akpm@osdl.org>,
       <ak@suse.de>, <lhcs-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>, <hotplug_sig@lists.osdl.org>
X-OriginalArrivalTime: 01 Sep 2005 21:09:10.0207 (UTC) FILETIME=[659334F0:01C5AF39]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Natalie,
> 
> sorry for the late catchup... 
> 
> Just to make sure we use the cpu maps properly here is the 
> current definition iam not sure if you are breaking any of 
> these assumptions, cause if you do you will break existing 
> implementations... so pardon for the verbosity.
> 
> cpu_possible_map - must include all possible cpus that can 
> ever exist in this
>                    instance of boot. This map is static, i.e 
> you can grow
>                    or remove bits without causing confution 
> to the rest of the 
>                    subsystem. We attempted to change, but 
> there was not much
>                    in return for the savings, for the 
> complexity we would
>                    add to make this map dynamic.
> 
> cpu_present_map - indicates that these are present and operational. OS
>                   can decide if they should be brought up or not.
> 
> when CONFIG_HOTPLUG_CPU is *not* defined, then 
> cpu_possible_map and cpu_present_map are the same. When 
> CONFIG_HOTPLUG_CPU=y, then we extend cpu_possible_map to 
> cover the range of NR_CPUS, but cpu_present_map still shows 
> what is real. 
> 
> When a physical hotplug happens, cpu_present_map is updated 
> by who ever manages the physical hotplug. 
> > 
> > Current IA32 CPU hotplug code doesn't allow bringing up 
> processors that were not present in the boot configuration. 
> > To make existing hot plug facility more practical for physical hot 
> > plug, possible processors should be encountered during boot for 
> > potentual hot add/replace/remove. On ES7000, ACPI marks all the 
> > sockets that are empty or not assigned to the partitionas as 
> > "disabled". The patch allows arrays/masks with APIC info 
> for disabled 
> > processors to be
> 
> This sounds like a cluge to me. The correct implementation 
> would be you would need some sysmgmt deamon or something that 
> works with the kernel to notify of new cpus and populate 
> apicid and grow cpu_present_map. Making an assumption that 
> disabled APICID are valid for ES7000 sake is not a safe assumption.

Yes, this is a kludge, I realize that. The AML code was not there so far
(it will be in the next one). I have a point here though that if the
processor is there, but is unusable (what "disabled" means as the ACPI
spec says), meaning bad maybe, then with physical hot plug it can
certainly be made usable and I think it should be taken into
consideration (and into configuration). It should be counted as possible
at least, with hot plug, because it represent existing socket. 

> > initialized. Then the OS can bring up a processor that was 
> inserted in 
> > the socked and brought into configuration during runtime.
> > To test the code, one can boot the system with maxcpu=1 and 
> then bring 
> > the rest of the processors up, which was not possible so 
> far (only maxcpus number of nodes were created).
> > The patch also makes proc entry for interrupts dynamically 
> change to only show current onlined processors.
> > 
> > Signed-off-by: Natalie Protasevich  <Natalie.Protasevich@unisys.com>
> > ---
> > 
> >  arch/i386/kernel/acpi/boot.c      |    2 ++
> >  arch/i386/kernel/irq.c            |    8 ++++----
> >  arch/i386/kernel/mpparse.c        |    4 ++++
> >  arch/i386/kernel/smpboot.c        |    3 ++-
> >  arch/i386/mach-default/topology.c |    4 ++--
> >  kernel/cpu.c                      |    4 ++++
> >  6 files changed, 18 insertions(+), 7 deletions(-)
> > 
> > diff -puN arch/i386/kernel/acpi/boot.c~hotcpu-i386 
> arch/i386/kernel/acpi/boot.c
> > --- 
> linux-2.6.13-rc6-mm2/arch/i386/kernel/acpi/boot.c~hotcpu-i386	
> 2005-08-31 04:17:20.832038600 -0700
> > +++ linux-2.6.13-rc6-mm2-root/arch/i386/kernel/acpi/boot.c	
> 2005-08-31 04:19:35.259602504 -0700
> > @@ -255,9 +255,11 @@ acpi_parse_lapic(acpi_table_entry_header
> >  
> >  	acpi_table_print_madt_entry(header);
> >  
> > +#ifndef CONFIG_HOTPLUG_CPU
> >  	/* no utility in registering a disabled processor */
> >  	if (processor->flags.enabled == 0)
> >  		return 0;
> > +#endif
> 
> On same lines, the above config code seems not appropriate. 
> When your platform needs to hot-add a cpu, find a way to set 
> these flags, you cant break current behaviour as for a platform quirk!
> >  
> >  	x86_acpiid_to_apicid[processor->acpi_id] = processor->id;
> >  
> > diff -puN arch/i386/kernel/mpparse.c~hotcpu-i386 
> arch/i386/kernel/mpparse.c
> > --- 
> linux-2.6.13-rc6-mm2/arch/i386/kernel/mpparse.c~hotcpu-i386	
> 2005-08-31 04:17:20.877031760 -0700
> > +++ linux-2.6.13-rc6-mm2-root/arch/i386/kernel/mpparse.c	
> 2005-08-31 04:20:49.297347056 -0700
> > @@ -125,8 +125,10 @@ static void __init MP_processor_info (st
> >   	int ver, apicid, cpu, found_bsp = 0;
> >  	physid_mask_t tmp;
> >   	
> > +#ifndef CONFIG_HOTPLUG_CPU
> >  	if (!(m->mpc_cpuflag & CPU_ENABLED))
> >  		return;
> > +#endif
> 
> Same here... platform quirk!

Yes it is indeed :) because it is masking absent processors as disabled.
And again I believe (correct me if I'm wrong) the disabled processors
should be counted as possible with hot plug (physical) in any case. This
patch is not actually covering physical hot plug, all it does is making
room for say hot swap of failed processors. How about making platform
hooks here for non-conforming (but not prohibited!) hot plug methods. In
fact the one used now on ES7000 is very intuitive and based on
assumption that "disabled" case is handled properly.
 
> >  
> >  	apicid = mpc_apic_id(m, translation_table[mpc_record]);
> >  
> > @@ -190,11 +192,13 @@ static void __init MP_processor_info (st
> >  		return;
> >  	}
> >  
> > +#ifndef CONFIG_HOTPLUG_CPU
> >  	if (num_processors >= maxcpus) {
> >  		printk(KERN_WARNING "WARNING: maxcpus limit of 
> %i reached."
> >  			" Processor ignored.\n", maxcpus); 
> >  		return;
> >  	}
> > +#endif
> >  	num_processors++;
> >  	ver = m->mpc_apicver;
> >  
> > diff -puN arch/i386/kernel/smpboot.c~hotcpu-i386 
> arch/i386/kernel/smpboot.c
> > --- 
> linux-2.6.13-rc6-mm2/arch/i386/kernel/smpboot.c~hotcpu-i386	
> 2005-08-31 04:17:20.924024616 -0700
> > +++ linux-2.6.13-rc6-mm2-root/arch/i386/kernel/smpboot.c	
> 2005-08-31 04:21:49.474198784 -0700
> > @@ -1003,9 +1003,10 @@ int __devinit smp_prepare_cpu(int cpu)
> >  	struct warm_boot_cpu_info info;
> >  	struct work_struct task;
> >  	int	apicid, ret;
> > +	extern u8 bios_cpu_apicid[NR_CPUS];
> >  
> >  	lock_cpu_hotplug();
> > -	apicid = x86_cpu_to_apicid[cpu];
> > +	apicid = bios_cpu_apicid[cpu];
> >  	if (apicid == BAD_APICID) {
> >  		ret = -ENODEV;
> >  		goto exit;
> > diff -puN arch/i386/mach-default/topology.c~hotcpu-i386 
> arch/i386/mach-default/topology.c
> > --- 
> linux-2.6.13-rc6-mm2/arch/i386/mach-default/topology.c~hotc
> pu-i386	2005-08-31 04:17:20.957019600 -0700
> > +++ 
> linux-2.6.13-rc6-mm2-root/arch/i386/mach-default/topology.c	
> 2005-08-31 04:22:13.020619184 -0700
> > @@ -76,7 +76,7 @@ static int __init topology_init(void)
> >  	for_each_online_node(i)
> >  		arch_register_node(i);
> >  
> > -	for_each_present_cpu(i)
> > +	for_each_cpu(i)
> 
> Nope. Should still be for present_cpus. with NR_CPUS large we 
> would see way too many files in sysfs than what is really available. 

Actually, it will only create as many nodes as listed in ACPI (enabled
or disabled). If you run it on regular system with maxcpus=1, you'll
only see the actual processor nodes (offlined beyond maxcpus).

> >  		arch_register_cpu(i);
> >  	return 0;
> >  }
> > @@ -87,7 +87,7 @@ static int __init topology_init(void)  {
> >  	int i;
> >  
> > -	for_each_present_cpu(i)
> > +	for_each_cpu(i)
> >  		arch_register_cpu(i);
> >  	return 0;
> >  }
> > diff -puN kernel/cpu.c~hotcpu-i386 kernel/cpu.c
> > --- linux-2.6.13-rc6-mm2/kernel/cpu.c~hotcpu-i386	
> 2005-08-31 04:17:21.002012760 -0700
> > +++ linux-2.6.13-rc6-mm2-root/kernel/cpu.c	2005-08-31 
> 04:23:34.378250944 -0700
> > @@ -158,7 +158,11 @@ int __devinit cpu_up(unsigned int cpu)
> >  	if ((ret = down_interruptible(&cpucontrol)) != 0)
> >  		return ret;
> >  
> > +#ifdef CONFIG_HOTPLUG_CPU
> > +	if (cpu_online(cpu)) {
> > +#else
> >  	if (cpu_online(cpu) || !cpu_present(cpu)) {
> > +#endif
> 
> ditto.....

I'm quite agree with you on proper implementation of physical hot plug,
but "disabled" case has to be handled correctly, and it should be some
flexibility built in. I don't think there is enough right now even with
proper ACPI based implementation.

Thanks,
--Natalie

> >  		ret = -EINVAL;
> >  		goto out;
> >  	}
> > diff -puN arch/i386/kernel/irq.c~hotcpu-i386 arch/i386/kernel/irq.c
> > --- linux-2.6.13-rc6-mm2/arch/i386/kernel/irq.c~hotcpu-i386	
> 2005-08-31 04:17:21.047005920 -0700
> > +++ linux-2.6.13-rc6-mm2-root/arch/i386/kernel/irq.c	
> 2005-08-31 04:25:21.761926144 -0700
> > @@ -248,7 +248,7 @@ int show_interrupts(struct seq_file *p,
> >  
> >  	if (i == 0) {
> >  		seq_printf(p, "           ");
> > -		for_each_cpu(j)
> > +		for_each_online_cpu(j)
> >  			seq_printf(p, "CPU%d       ",j);
> >  		seq_putc(p, '\n');
> >  	}
> > @@ -262,7 +262,7 @@ int show_interrupts(struct seq_file *p, 
>  #ifndef 
> > CONFIG_SMP
> >  		seq_printf(p, "%10u ", kstat_irqs(i));  #else
> > -		for_each_cpu(j)
> > +		for_each_online_cpu(j)
> >  			seq_printf(p, "%10u ", 
> kstat_cpu(j).irqs[i]);  #endif
> >  		seq_printf(p, " %14s", 
> irq_desc[i].handler->typename); @@ -276,12 
> > +276,12 @@ skip:
> >  		spin_unlock_irqrestore(&irq_desc[i].lock, flags);
> >  	} else if (i == NR_IRQS) {
> >  		seq_printf(p, "NMI: ");
> > -		for_each_cpu(j)
> > +		for_each_online_cpu(j)
> >  			seq_printf(p, "%10u ", nmi_count(j));
> >  		seq_putc(p, '\n');
> >  #ifdef CONFIG_X86_LOCAL_APIC
> >  		seq_printf(p, "LOC: ");
> > -		for_each_cpu(j)
> > +		for_each_online_cpu(j)
> >  			seq_printf(p, "%10u ",
> >  				per_cpu(irq_stat,j).apic_timer_irqs);
> >  		seq_putc(p, '\n');
> > _
> 
> --
> Cheers,
> Ashok Raj
> - Open Source Technology Center
> 
