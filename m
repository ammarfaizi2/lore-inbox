Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262675AbTHUOLA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 10:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262681AbTHUOK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 10:10:59 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:53961 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262675AbTHUOKi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 10:10:38 -0400
From: Andrew Theurer <habanero@us.ibm.com>
Reply-To: habanero@us.ibm.com
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: CPU boot problem on 2.6.0-test3-bk8
Date: Thu, 21 Aug 2003 09:10:07 -0500
User-Agent: KMail/1.5
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@aracnet.com>
References: <200308201658.05433.habanero@us.ibm.com> <200308202013.51702.habanero@us.ibm.com> <1061437329.15363.92.camel@nighthawk>
In-Reply-To: <1061437329.15363.92.camel@nighthawk>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/KNR/qLyTmC/5W9"
Message-Id: <200308210910.07722.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_/KNR/qLyTmC/5W9
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 20 August 2003 22:42, Dave Hansen wrote:
> On Wed, 2003-08-20 at 18:13, Andrew Theurer wrote:
> > On Wednesday 20 August 2003 20:02, Dave Hansen wrote:
> > > On Wed, 2003-08-20 at 14:58, Andrew Theurer wrote:
> > > > Maybe this is already known, but just in case:
> > > > I cannot fully boot on an x440 system with 2.6.0-test3-bk8.  The
> > > > kernel tries to boot more than the 16 logical processors, and after
> > > > failing (no response) on cpus 16, 17, and 18, it still thinks it has
> > > > 19 cpus total. It finally gets stuck at "checking TSC synchronization
> > > > across 19 CPUs:"
> > > >
> > > > Attached is the boot log.  Any ideas? I'll try -test3-bk7 next
> > >
> > > Can you see if it works without HT on?  Did it work on plain -test3?
> > > My 16-way x440 with no HT boots fine on test3.
> >
> > I'll try without HT to see what happens.  FWIW, it boots fine with HT if
> > I set maxcpus=16.  I am wondering if (apicid == BAD_APIC) test is not
> > working in smp_boot_cpus.
>
> Hmmm.  This is looking like fallout from the massive wli-bomb.  Here's
> the loop that controls the cpu booting, before and after cpumask_t:
>
> -	for (bit = 0; kicked < NR_CPUS && bit < BITS_PER_LONG; bit++) +	for
> (bit = 0; kicked < NR_CPUS && bit < MAX_APICS; bit++)
> 		apicid = cpu_present_to_apicid(bit);
>
> "kicked" only gets incremented for CPUs that were successfully booted,
> so it doesn't help terminate the loop much.  MAX_APICS is 256 on summit,
> which is *MUCH* bigger than BITS_PER_LONG.
> cpu_2_logical_apicid[NR_CPUS] which is referenced from
> cpu_present_to_apicid() is getting referenced up to MAX_APICs, which is
> bigger than NR_CPUS.  Overflow.  Bang.  garbage != BAD_APICID :)

Still looks like we have a problem (see attached boot log).  Maybe we should 
change that for loop to:

for (bit = 0; kicked < num_processors && bit < BITS_PER_LONG; bit++)

So we only loop for the actual number processors found in mpparse.c?  This 
seems to work for me.

-Andrew Theurer
--Boundary-00=_/KNR/qLyTmC/5W9
Content-Type: text/plain;
  charset="utf-8";
  name="260test3bk8patch1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="260test3bk8patch1"


    GRUB  version 0.93  (631K lower / 3668699K upper memory)

+-------------------------------------------------------------------------+=
||||||||||||||||||||||||+--------------------------------------------------=
=2D----------------------+
      Use the ^ and v keys to select which entry is highlighted.
      Press enter to boot the selected OS, 'e' to edit the
      commands before booting, 'a' to modify the kernel arguments
      before booting, or 'c' for a command-line.  2.6.0-test3              =
                                                2.6.0-test3-bk4            =
                                              2.6.0-test3-bk5              =
                                            2.6.0-test3-bk6                =
                                          2.6.0-test3-bk7                  =
                                        2.6.0-test3-bk8                    =
                                      2.6.0-test2-numaschedgood            =
                                    2.6.0-test2                            =
                                  249e25summit_patch                       =
                                249e20summit2                              =
                              249e20summit                                 =
                            2.6.0-test2-numasched                          =
                         vThe highlighted entry will be booted automaticall=
y in 10 seconds.    The highlighted entry will be booted automatically in 9=
 seconds.    The highlighted entry will be booted automatically in 8 second=
s.    The highlighted entry will be booted automatically in 7 seconds.     =
                                                                     Bootin=
g '2.6.0-test3-bk8'

root (hd0,0)
 Filesystem type is ext2fs, partition type 0x83
kernel /bzImage-2.6.0-test3-bk8 ro root=3D/dev/sda7 console=3DttyS0,38400n8=
=20
   [Linux-bzImage, setup=3D0xc00, size=3D0x1fc8a6]

Linux version 2.6.0-test3-bk8 (root@x4408way2) (gcc version 3.2.2) #3 SMP T=
hu Aug 21 10:13:50 CDT 2003
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009dc00 (usable)
 BIOS-e820: 000000000009dc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000dffb6ec0 (usable)
 BIOS-e820: 00000000dffb6ec0 - 00000000dffbf800 (ACPI data)
 BIOS-e820: 00000000dffbf800 - 00000000e0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000320000000 (usable)
get_memcfg_from_srat: assigning address to rsdp
RSD PTR  v0 [IBM   ]
Begin table scan....
CPU 0x00 in proximity domain 0x00
CPU 0x02 in proximity domain 0x00
CPU 0x10 in proximity domain 0x00
CPU 0x12 in proximity domain 0x00
CPU 0x20 in proximity domain 0x01
CPU 0x22 in proximity domain 0x01
CPU 0x30 in proximity domain 0x01
CPU 0x32 in proximity domain 0x01
CPU 0x01 in proximity domain 0x00
CPU 0x03 in proximity domain 0x00
CPU 0x11 in proximity domain 0x00
CPU 0x13 in proximity domain 0x00
CPU 0x21 in proximity domain 0x01
CPU 0x23 in proximity domain 0x01
CPU 0x31 in proximity domain 0x01
CPU 0x33 in proximity domain 0x01
Memory range 0x0 to 0xE0000 (type 0x1) in proximity domain 0x00 enabled
Memory range 0x100000 to 0x220000 (type 0x1) in proximity domain 0x00 enabl=
ed
Memory range 0x220000 to 0x320000 (type 0x1) in proximity domain 0x01 enabl=
ed
acpi20_parse_srat: Entry length value is zero; can't parse any further!
pxm bitmap: 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00 00 00 00 00=20
Number of logical nodes in system =3D 2
Number of memory chunks in system =3D 3
chunk 0 nid 0 start_pfn 00000000 end_pfn 000e0000
chunk 1 nid 0 start_pfn 00100000 end_pfn 00220000
chunk 2 nid 1 start_pfn 00220000 end_pfn 00320000
Reserving 11776 pages of KVA for lmem_map of node 1
Shrinking node 1 from 3276800 pages to 3265024 pages
Reserving total of 11776 pages for numa KVA remap
11904MB HIGHMEM available.
850MB LOWMEM available.
min_low_pfn =3D 1445, max_low_pfn =3D 217600, highstart_pfn =3D 229376
Low memory ends at vaddr f5200000
node 0 will remap to vaddr f8000000 - f8000000
node 1 will remap to vaddr f5200000 - f8000000
High memory starts at vaddr f8000000
ACPI: S3 and PAE do not like each other for now, S3 disabled.
found SMP MP-table at 0009dd40
hm, page 0009d000 reserved twice.
hm, page 0009e000 reserved twice.
hm, page 0009e000 reserved twice.
hm, page 0009f000 reserved twice.
On node 0 totalpages: 2097152
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 213504 pages, LIFO batch:16
  HighMem zone: 1879552 pages, LIFO batch:16
BUG: wrong zone alignment, it will crash
On node 1 totalpages: 1036800
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 1036800 pages, LIFO batch:16
DMI 2.3 present.
IBM machine detected. Enabling interrupts during APM calls.
IBM machine detected. Disabling SMBus accesses.
IBM eserver xSeries 440 detected: force use of acpi=3Dht
ACPI: RSDP (v000 IBM                                       ) @ 0x000fdba0
ACPI: RSDT (v001 IBM    SERVIGIL 0x00001000 IBM  0x45444f43) @ 0xdffbf780
ACPI: FADT (v001 IBM    SERVIGIL 0x00001000 IBM  0x45444f43) @ 0xdffbf700
ACPI: MADT (v001 IBM    SERVIGIL 0x00001000 IBM  0x45444f43) @ 0xdffbf580
ACPI: SRAT (v001 IBM    SERVIGIL 0x00001000 IBM  0x45444f43) @ 0xdffbf3c0
ACPI: DSDT (v001 IBM    SERVIGIL 0x00001000 INTL 0x02002025) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:1 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x02] enabled)
Processor #2 15:1 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x10] enabled)
Processor #16 15:1 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x12] enabled)
Processor #18 15:1 APIC version 20
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x20] enabled)
Processor #32 15:1 APIC version 20
ACPI: LAPIC (acpi_id[0x05] lapic_id[0x22] enabled)
Processor #34 15:1 APIC version 20
ACPI: LAPIC (acpi_id[0x06] lapic_id[0x30] enabled)
Processor #48 15:1 APIC version 20
ACPI: LAPIC (acpi_id[0x07] lapic_id[0x32] enabled)
Processor #50 15:1 APIC version 20
ACPI: LAPIC (acpi_id[0x08] lapic_id[0x01] enabled)
Processor #1 15:1 APIC version 20
ACPI: LAPIC (acpi_id[0x09] lapic_id[0x03] enabled)
Processor #3 15:1 APIC version 20
ACPI: LAPIC (acpi_id[0x0a] lapic_id[0x11] enabled)
Processor #17 15:1 APIC version 20
ACPI: LAPIC (acpi_id[0x0b] lapic_id[0x13] enabled)
Processor #19 15:1 APIC version 20
ACPI: LAPIC (acpi_id[0x0c] lapic_id[0x21] enabled)
Processor #33 15:1 APIC version 20
ACPI: LAPIC (acpi_id[0x0d] lapic_id[0x23] enabled)
Processor #35 15:1 APIC version 20
ACPI: LAPIC (acpi_id[0x0e] lapic_id[0x31] enabled)
Processor #49 15:1 APIC version 20
ACPI: LAPIC (acpi_id[0x0f] lapic_id[0x33] enabled)
Processor #51 15:1 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x0] trigger[0x0] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] polarity[0x0] trigger[0x0] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] polarity[0x0] trigger[0x0] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] polarity[0x0] trigger[0x0] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x04] polarity[0x0] trigger[0x0] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x05] polarity[0x0] trigger[0x0] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x06] polarity[0x0] trigger[0x0] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x07] polarity[0x0] trigger[0x0] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x08] polarity[0x0] trigger[0x0] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x09] polarity[0x0] trigger[0x0] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x0a] polarity[0x0] trigger[0x0] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x0b] polarity[0x0] trigger[0x0] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x0c] polarity[0x0] trigger[0x0] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x0d] polarity[0x0] trigger[0x0] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x0e] polarity[0x0] trigger[0x0] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x0f] polarity[0x0] trigger[0x0] lint[0x1])
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: IBM ENSW Product ID: VIGIL SMP    APIC at: 0xFEE00000
I/O APIC #14 Version 17 at 0xFEC00000.
I/O APIC #13 Version 17 at 0xFEC01000.
Enabling APIC mode:  Summit.  Using 2 I/O APICs
Processors: 16
Building zonelist for node : 0
Building zonelist for node : 1
Kernel command line: ro root=3D/dev/sda7 console=3DttyS0,38400n8=20
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Summit chipset: Starting Cyclone Counter.
Detected 1498.475 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 193.02 BogoMIPS
Initializing highpages for node 0
Initializing highpages for node 1
Memory: 12431384k/13107200k available (3113k kernel code, 102620k reserved,=
 1120k data, 204k init, 11665112k highmem)
Dentry cache hash table entries: 1048576 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 1048576 (order: 10, 4194304 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
=2D> /dev
=2D> /dev/console
=2D> /root
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel(R) Genuine CPU 1.50GHz stepping 01
per-CPU timeslice cutoff: 731.48 usecs.
task migration cache decay timeout: 1 msecs.
enabled ExtINT on CPU#0
Leaving ESR disabled.
Mapping cpu 0 to node 0
Booting processor 1/2 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
Leaving ESR disabled.
Mapping cpu 1 to node 0
Calibrating delay loop... 199.16 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 1
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU#1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#1: Thermal monitoring enabled
CPU1: Intel(R) Xeon(TM) CPU 1.50GHz stepping 01
Booting processor 2/16 eip 2000
Initializing CPU#2
masked ExtINT on CPU#2
Leaving ESR disabled.
Mapping cpu 2 to node 0
Calibrating delay loop... 198.65 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 2
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#2.
CPU#2: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#2: Thermal monitoring enabled
CPU2: Intel(R) Xeon(TM) CPU 1.50GHz stepping 01
Booting processor 3/18 eip 2000
Initializing CPU#3
masked ExtINT on CPU#3
Leaving ESR disabled.
Mapping cpu 3 to node 0
Calibrating delay loop... 199.16 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 3
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#3.
CPU#3: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#3: Thermal monitoring enabled
CPU3: Intel(R) Xeon(TM) CPU 1.50GHz stepping 01
Booting processor 4/32 eip 2000
Initializing CPU#4
masked ExtINT on CPU#4
Leaving ESR disabled.
Mapping cpu 4 to node 1
Calibrating delay loop... 198.65 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 8
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#4.
CPU#4: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#4: Thermal monitoring enabled
CPU4: Intel(R) Genuine CPU 1.50GHz stepping 01
Booting processor 5/34 eip 2000
Initializing CPU#5
masked ExtINT on CPU#5
Leaving ESR disabled.
Mapping cpu 5 to node 1
Calibrating delay loop... 199.16 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 9
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#5.
CPU#5: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#5: Thermal monitoring enabled
CPU5: Intel(R) Xeon(TM) CPU 1.50GHz stepping 01
Booting processor 6/48 eip 2000
Initializing CPU#6
masked ExtINT on CPU#6
Leaving ESR disabled.
Mapping cpu 6 to node 1
Calibrating delay loop... 199.16 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 10
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#6.
CPU#6: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#6: Thermal monitoring enabled
CPU6: Intel(R) Xeon(TM) CPU 1.50GHz stepping 01
Booting processor 7/50 eip 2000
Initializing CPU#7
masked ExtINT on CPU#7
Leaving ESR disabled.
Mapping cpu 7 to node 1
Calibrating delay loop... 199.16 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 11
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#7.
CPU#7: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#7: Thermal monitoring enabled
CPU7: Intel(R) Xeon(TM) CPU 1.50GHz stepping 01
Booting processor 8/1 eip 2000
Initializing CPU#8
masked ExtINT on CPU#8
Leaving ESR disabled.
Mapping cpu 8 to node 0
Calibrating delay loop... 199.16 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#8.
CPU#8: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#8: Thermal monitoring enabled
CPU8: Intel(R) Genuine CPU 1.50GHz stepping 01
Booting processor 9/3 eip 2000
Initializing CPU#9
masked ExtINT on CPU#9
Leaving ESR disabled.
Mapping cpu 9 to node 0
Calibrating delay loop... 199.16 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 1
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#9.
CPU#9: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#9: Thermal monitoring enabled
CPU9: Intel(R) Xeon(TM) CPU 1.50GHz stepping 01
Booting processor 10/17 eip 2000
Initializing CPU#10
masked ExtINT on CPU#10
Leaving ESR disabled.
Mapping cpu 10 to node 0
Calibrating delay loop... 199.16 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 2
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#10.
CPU#10: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#10: Thermal monitoring enabled
CPU10: Intel(R) Xeon(TM) CPU 1.50GHz stepping 01
Booting processor 11/19 eip 2000
Initializing CPU#11
masked ExtINT on CPU#11
Leaving ESR disabled.
Mapping cpu 11 to node 0
Calibrating delay loop... 199.16 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 3
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#11.
CPU#11: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#11: Thermal monitoring enabled
CPU11: Intel(R) Xeon(TM) CPU 1.50GHz stepping 01
Booting processor 12/33 eip 2000
Initializing CPU#12
masked ExtINT on CPU#12
Leaving ESR disabled.
Mapping cpu 12 to node 1
Calibrating delay loop... 198.65 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 8
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#12.
CPU#12: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#12: Thermal monitoring enabled
CPU12: Intel(R) Genuine CPU 1.50GHz stepping 01
Booting processor 13/35 eip 2000
Initializing CPU#13
masked ExtINT on CPU#13
Leaving ESR disabled.
Mapping cpu 13 to node 1
Calibrating delay loop... 198.65 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 9
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#13.
CPU#13: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#13: Thermal monitoring enabled
CPU13: Intel(R) Xeon(TM) CPU 1.50GHz stepping 01
Booting processor 14/49 eip 2000
Initializing CPU#14
masked ExtINT on CPU#14
Leaving ESR disabled.
Mapping cpu 14 to node 1
Calibrating delay loop... 198.65 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 10
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#14.
CPU#14: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#14: Thermal monitoring enabled
CPU14: Intel(R) Xeon(TM) CPU 1.50GHz stepping 01
Booting processor 15/51 eip 2000
Initializing CPU#15
masked ExtINT on CPU#15
Leaving ESR disabled.
Mapping cpu 15 to node 1
Calibrating delay loop... 198.65 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 11
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#15.
CPU#15: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#15: Thermal monitoring enabled
CPU15: Intel(R) Xeon(TM) CPU 1.50GHz stepping 01
Booting processor 16/114 eip 2000
Not responding.
Unmapping cpu 16 from all nodes
CPU #114 not responding - cannot use it.
Booting processor 16/159 eip 2000
Not responding.
Unmapping cpu 16 from all nodes
CPU #159 not responding - cannot use it.
Booting processor 16/17 eip 2000
Initializing CPU#16
masked ExtINT on CPU#16
Leaving ESR disabled.
Mapping cpu 16 to node 0
Calibrating delay loop... 199.16 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 2
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#16.
CPU#16: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#16: Thermal monitoring enabled
CPU16: Intel(R) Xeon(TM) CPU 1.50GHz stepping 01
Booting processor 17/192 eip 2000
Not responding.
Unmapping cpu 17 from all nodes
CPU #192 not responding - cannot use it.
Booting processor 17/17 eip 2000
Initializing CPU#17
masked ExtINT on CPU#17
Leaving ESR disabled.
Mapping cpu 17 to node 0
Calibrating delay loop... 199.16 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 2
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#17.
CPU#17: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#17: Thermal monitoring enabled
CPU17: Intel(R) Xeon(TM) CPU 1.50GHz stepping 01
Booting processor 18/160 eip 2000
Not responding.
Unmapping cpu 18 from all nodes
CPU #160 not responding - cannot use it.
Booting processor 18/17 eip 2000
Initializing CPU#18
masked ExtINT on CPU#18
Leaving ESR disabled.
Mapping cpu 18 to node 0
Calibrating delay loop... 199.16 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 2
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#18.
CPU#18: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#18: Thermal monitoring enabled
CPU18: Intel(R) Xeon(TM) CPU 1.50GHz stepping 01
Booting processor 19/192 eip 2000
Not responding.
Unmapping cpu 19 from all nodes
CPU #192 not responding - cannot use it.
Booting processor 19/108 eip 2000
Not responding.
Unmapping cpu 19 from all nodes
CPU #108 not responding - cannot use it.
Booting processor 19/97 eip 2000
Not responding.
Unmapping cpu 19 from all nodes
CPU #97 not responding - cannot use it.
Booting processor 19/112 eip 2000
Not responding.
Unmapping cpu 19 from all nodes
CPU #112 not responding - cannot use it.
Booting processor 19/105 eip 2000
Not responding.
Unmapping cpu 19 from all nodes
CPU #105 not responding - cannot use it.
Booting processor 19/99 eip 2000
Not responding.
Unmapping cpu 19 from all nodes
CPU #99 not responding - cannot use it.
Booting processor 19/160 eip 2000
Not responding.
Unmapping cpu 19 from all nodes
CPU #160 not responding - cannot use it.
Booting processor 19/185 eip 2000
Not responding.
Unmapping cpu 19 from all nodes
CPU #185 not responding - cannot use it.
Booting processor 19/72 eip 2000
Not responding.
Unmapping cpu 19 from all nodes
CPU #72 not responding - cannot use it.
Booting processor 19/192 eip 2000
Not responding.
Unmapping cpu 19 from all nodes
CPU #192 not responding - cannot use it.
Booting processor 19/232 eip 2000
Not responding.
Unmapping cpu 19 from all nodes
CPU #232 not responding - cannot use it.
Booting processor 19/3 eip 2000
Initializing CPU#19
masked ExtINT on CPU#19
Leaving ESR disabled.
Mapping cpu 19 to node 0
Calibrating delay loop... 199.16 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 1
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#19.
CPU#19: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#19: Thermal monitoring enabled
CPU19: Intel(R) Xeon(TM) CPU 1.50GHz stepping 01
Total of 20 processors activated (3974.14 BogoMIPS).
cpu_sibling_map[0] =3D 8
cpu_sibling_map[1] =3D 9
cpu_sibling_map[2] =3D 10
cpu_sibling_map[3] =3D 11
cpu_sibling_map[4] =3D 12
cpu_sibling_map[5] =3D 13
cpu_sibling_map[6] =3D 14
cpu_sibling_map[7] =3D 15
cpu_sibling_map[8] =3D 0
cpu_sibling_map[9] =3D 1
cpu_sibling_map[10] =3D 2
cpu_sibling_map[11] =3D 3
cpu_sibling_map[12] =3D 4
cpu_sibling_map[13] =3D 5
cpu_sibling_map[14] =3D 6
cpu_sibling_map[15] =3D 7
cpu_sibling_map[16] =3D 2
cpu_sibling_map[17] =3D 2
cpu_sibling_map[18] =3D 2
cpu_sibling_map[19] =3D 1
ENABLING IO-APIC IRQs
Setting 14 in the phys_id_present_map
=2E..changing IO-APIC physical APIC ID to 14 ... ok.
Setting 13 in the phys_id_present_map
=2E..changing IO-APIC physical APIC ID to 13 ... ok.
=2E.TIMER: vector=3D0x31 pin1=3D0 pin2=3D-1
testing the IO APIC.......................
=2E................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
=2E.... CPU clock speed is 1496.0674 MHz.
=2E.... host bus clock speed is 99.0778 MHz.
checking TSC synchronization across 20 CPUs:=20
--Boundary-00=_/KNR/qLyTmC/5W9
Content-Type: text/x-diff;
  charset="utf-8";
  name="patch-boot-cpu.260test3bk8"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-boot-cpu.260test3bk8"

diff -Naurp linux-2.6.0-test3-bk8/arch/i386/kernel/mpparse.c linux-2.6.0-test3-bk8-patch/arch/i386/kernel/mpparse.c
--- linux-2.6.0-test3-bk8/arch/i386/kernel/mpparse.c	2003-08-21 10:42:38.000000000 -0500
+++ linux-2.6.0-test3-bk8-patch/arch/i386/kernel/mpparse.c	2003-08-21 10:36:26.000000000 -0500
@@ -68,7 +68,7 @@ unsigned long mp_lapic_addr;
 unsigned int boot_cpu_physical_apicid = -1U;
 unsigned int boot_cpu_logical_apicid = -1U;
 /* Internal processor count */
-static unsigned int __initdata num_processors;
+unsigned int __initdata num_processors;
 
 /* Bitmask of physically existing CPUs */
 physid_mask_t phys_cpu_present_map;
diff -Naurp linux-2.6.0-test3-bk8/arch/i386/kernel/smpboot.c linux-2.6.0-test3-bk8-patch/arch/i386/kernel/smpboot.c
--- linux-2.6.0-test3-bk8/arch/i386/kernel/smpboot.c	2003-08-21 10:42:38.000000000 -0500
+++ linux-2.6.0-test3-bk8-patch/arch/i386/kernel/smpboot.c	2003-08-21 10:36:26.000000000 -0500
@@ -64,6 +64,8 @@ int phys_proc_id[NR_CPUS]; /* Package ID
 /* bitmap of online cpus */
 cpumask_t cpu_online_map;
 
+extern unsigned int num_processors;
+
 static cpumask_t cpu_callin_map;
 cpumask_t cpu_callout_map;
 static cpumask_t smp_commenced_mask;
@@ -1020,7 +1022,7 @@ static void __init smp_boot_cpus(unsigne
 	Dprintk("CPU present map: %lx\n", physids_coerce(phys_cpu_present_map));
 
 	kicked = 1;
-	for (bit = 0; kicked < NR_CPUS && bit < MAX_APICS; bit++) {
+	for (bit = 0; kicked < num_processors && bit < MAX_APICS; bit++) {
 		apicid = cpu_present_to_apicid(bit);
 		/*
 		 * Don't even attempt to start the boot CPU!

--Boundary-00=_/KNR/qLyTmC/5W9--

