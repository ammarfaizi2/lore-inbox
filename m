Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932478AbVJaRMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbVJaRMc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 12:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbVJaRMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 12:12:32 -0500
Received: from S01060013109fe3d4.vc.shawcable.net ([24.85.133.133]:60116 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S932478AbVJaRMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 12:12:31 -0500
Date: Mon, 31 Oct 2005 09:18:17 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
cc: "Eric W. Biederman" <ebiederm@xmission.com>, vgoyal@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, fastboot@osdl.org,
       Linux Kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       "Brown, Len" <len.brown@intel.com>
Subject: RE: [Fastboot] [PATCH] i386: move apic init in init_IRQs
In-Reply-To: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04DFF@USRV-EXCH4.na.uis.unisys.com>
Message-ID: <Pine.LNX.4.61.0510310916040.1526@montezuma.fsmlabs.com>
References: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04DFF@USRV-EXCH4.na.uis.unisys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Oct 2005, Protasevich, Natalie wrote:

> > Vivek Goyal <vgoyal@in.ibm.com> writes:
> > > I have attached a patch with the mail which is now using 
> > > boot_cpu_physical_apicid to hard set presence of boot cpu 
> > instead of 
> > > hard_smp_processor_id(). But the interesting questoin 
> > remains why BIOS 
> > > is not reporting the boot cpu.
> > 
> > 
> > Ok.  I don't know if we care but I do know why we were not 
> > seeing the report from the bios about your boot processor.  
> > We record information about cpus for up to NR_CPUS, and since 
> > you had a UP kernel NR_CPUS was one.
> > 
> > From your earlier boot log.
> > 
> > > ACPI: LAPIC (acpi_id[0x00] lapic_id[0x03] enabled) 
> > Processor #3 6:10 
> > > APIC version 17
> > > ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled) 
> > Processor #0 6:10 
> > > APIC version 17
> > > WARNING: NR_CPUS limit of 1 reached.  Processor ignored.
> > > ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled) 
> > Processor #1 6:10 
> > > APIC version 17
> > > WARNING: NR_CPUS limit of 1 reached.  Processor ignored.
> > > ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled) 
> > Processor #2 6:10 
> > > APIC version 17
> > > WARNING: NR_CPUS limit of 1 reached.  Processor ignored.
> > 
> > So it looks like we have this problem completely fixed.  
> > 
> > I don't see a good way to ensure that we always record our 
> > boot apicid when we boot a multiple processor system and only 
> > use one processor.
> 
> Hi Eric,
> 
> There is another problem with that patch - it broke ES7000, I kept
> getting timer panics. It turned out that check_timer() runs before the
> actual APIC destination is set up. The IO-APIC uses
> cpu_to_logical_apicid to find the destination - which needs
> cpu_2_logical_apicid[] to be filled - which only happens after
> processors are booted. At the time when check_timer() runs, it will
> always be BAD_APICID (0xFF - broadcast) as the IO-APIC rte destination
> for the timer, but ES7000 hardware happened not to support 0xFF so it
> panics. I used bios_cpu_apicid[] to bring it up, but
> cpu_to_logical_apicid is the only one that is kept up-to-date in the
> hotplug case, so I cannot replace it in the cpu_mask_to_apicid(). 
> 
> There are probably some ways to fix this such as one below that I tried
> (in mpparse.c):
> 
>         if (m->mpc_cpuflag & CPU_BOOTPROCESSOR) {
>                 Dprintk("    Bootup CPU\n");
>                 boot_cpu_physical_apicid = m->mpc_apicid;
> +               cpu_2_logical_apicid[num_processors] = m->mpc_apicid;
>         }
> it  worked, but looks more like a kludge of course. I think IO-APIC
> setup has to happen after processors were brought online and so is
> check_timer(), if timer is connected through the IO-APIC.

Regarding IOAPIC setup I agree, Eric's patch is causing a few problems;

Total of 2 processors activated (14407.06 BogoMIPS).
checking TSC synchronization across 2 CPUs: passed.
softlockup thread 0 started up.
APIC error on CPU1: 00(40) <====
Brought up 2 CPUs
