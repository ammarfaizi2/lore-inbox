Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267338AbSLKXXN>; Wed, 11 Dec 2002 18:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267345AbSLKXXN>; Wed, 11 Dec 2002 18:23:13 -0500
Received: from LIGHT-BRIGADE.MIT.EDU ([18.244.1.25]:20231 "HELO
	light-brigade.mit.edu") by vger.kernel.org with SMTP
	id <S267338AbSLKXXM>; Wed, 11 Dec 2002 18:23:12 -0500
Date: Wed, 11 Dec 2002 18:30:59 -0500
From: Gerald Britton <gbritton@alum.mit.edu>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: HyperThreading in recent 2.4-ac kernels
Message-ID: <20021211183059.A19030@light-brigade.mit.edu>
References: <200212112043.gBBKhLE28272@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200212112043.gBBKhLE28272@devserv.devel.redhat.com>; from alan@redhat.com on Wed, Dec 11, 2002 at 03:43:21PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HyperThreading appears to work properly in vanilla 2.4.x, but fails to
initialize the sibling CPUs in 2.4.x-ac.  The problem appears to be in
improper indexing by physical vs. logical CPU numbers.

in smpboot.c (in smp_boot_cpus):

        Dprintk("CPU present map: %lx\n", phys_cpu_present_map);
        cpu = 1;
        for (bit = 0; bit < NR_CPUS; bit++) {
                ...
                phys_apicid = raw_phys_apicid[bit];
                ...
                if ((cpu_to_physical_apicid(bit) == BAD_APICID) &&
                ...

in mpparse.c (in MP_processor_info):

        raw_phys_apicid[num_processors - 1] = m->mpc_apicid;

Booting with HT and some debugging enabled yields:

...
LAPIC (acpi_id[0x0000] id[0x0] enabled[1])
CPU 0 (0x0000) enabledProcessor #0 Pentium 4(tm) XEON(tm) APIC version 16
LAPIC (acpi_id[0x0001] id[0x6] enabled[1])
CPU 1 (0x0600) enabledProcessor #6 Pentium 4(tm) XEON(tm) APIC version 16
LAPIC (acpi_id[0x0002] id[0x1] enabled[1])
CPU 2 (0x0100) enabledProcessor #1 Pentium 4(tm) XEON(tm) APIC version 16
LAPIC (acpi_id[0x0003] id[0x7] enabled[1])
CPU 3 (0x0700) enabledProcessor #7 Pentium 4(tm) XEON(tm) APIC version 16
...
CPU present map: c3
...

The processors appear to have physical IDs 0, 1, 6, 7.  raw_phys_apicid[] gets
filled at indexes 0-4, but when the kernel tries to boot the CPUs, it queries
it with physical indexes 0, 1, 6, 7 and loses.  I'm not sure exactly what the
correct way to fix this is.  (a quick hack to raw_phys_apicid does get all 4
CPUs up and apparently working though)

There appear to be other areas where holes in the physical IDs will cause
problems (things fill indexes by a logical cpu number and index later by
physical ID, or the other way around).

Example: following booting a cpu, the check to see if it booted checks
cpu_to_physical_apicid(bit) where bit is the physical cpu id in the map, but
the table it's checking is indexed by logical cpu number.

				-- Gerald

