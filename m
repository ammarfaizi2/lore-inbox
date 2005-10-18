Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751428AbVJRAQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbVJRAQa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 20:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbVJRAQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 20:16:30 -0400
Received: from serv01.siteground.net ([70.85.91.68]:51372 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751425AbVJRAQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 20:16:29 -0400
Date: Mon, 17 Oct 2005 17:16:20 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org, tglx@linutronix.de,
       shai@scalex86.org
Subject: Re: x86_64: 2.6.14-rc4 swiotlb broken
Message-ID: <20051018001620.GD8932@localhost.localdomain>
References: <20051017093654.GA7652@localhost.localdomain> <200510171153.56063.ak@suse.de> <20051017153020.GB7652@localhost.localdomain> <200510171743.47926.ak@suse.de> <20051017134401.3b0d861d.akpm@osdl.org> <Pine.LNX.4.64.0510171405510.3369@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="raC6veAxrt5nqIoY"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510171405510.3369@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--raC6veAxrt5nqIoY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 17, 2005 at 02:11:20PM -0700, Linus Torvalds wrote:
> 
> 
> On Mon, 17 Oct 2005, Andrew Morton wrote:
> > 
> > There seem to be a lot of proposed solutions floating about and I fear that
> > different people will try to fix this in different ways.  Do we all agree
> > that this patch is the correct solution to this problem, or is something
> > more needed?
> 
> I think this will fix it. 
> 

I just tried Yasunori-sans patch on our x460.  It doesn't fix the problem.  
Attaching the dmesg capture. However, the patch to iterate over nodes and 
allocate bootmem works, and should work for ia64s, boxes with insufficient 
memory on node 0, nodes with just cpus etc.  I have requested Alex to try this 
on the superdome (although the the use of swiotlb on superdomes seem to be
optional).  If this works on superdomes, then please apply.  This has been
tested on x460.

Thanks,
Kiran

Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>

Index: linux-2.6.14-rc4/arch/ia64/lib/swiotlb.c
===================================================================
--- linux-2.6.14-rc4.orig/arch/ia64/lib/swiotlb.c	2005-10-17 13:27:35.000000000 -0700
+++ linux-2.6.14-rc4/arch/ia64/lib/swiotlb.c	2005-10-17 16:00:44.000000000 -0700
@@ -106,6 +106,8 @@
 __setup("swiotlb=", setup_io_tlb_npages);
 /* make io_tlb_overflow tunable too? */
 
+#define IS_LOWPAGES(paddr, size) ((paddr < 0xffffffff) && ((paddr+size) < 0xffffffff))
+
 /*
  * Statically reserve bounce buffer space and initialize bounce buffer data
  * structures for the software IO TLB used to implement the PCI DMA API.
@@ -114,17 +116,32 @@
 swiotlb_init_with_default_size (size_t default_size)
 {
 	unsigned long i;
+	unsigned long iotlbsz;
+	int node;
 
 	if (!io_tlb_nslabs) {
 		io_tlb_nslabs = (default_size >> IO_TLB_SHIFT);
 		io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
 	}
 
+	iotlbsz = io_tlb_nslabs * (1 << IO_TLB_SHIFT);	
+
 	/*
-	 * Get IO TLB memory from the low pages
+	 * Get IO TLB memory from the 0-4G range
 	 */
-	io_tlb_start = alloc_bootmem_low_pages(io_tlb_nslabs *
-					       (1 << IO_TLB_SHIFT));
+	
+	for_each_node(node) {
+		io_tlb_start = alloc_bootmem_node(NODE_DATA(node), iotlbsz);
+		if (io_tlb_start) {
+			if (IS_LOWPAGES(virt_to_phys(io_tlb_start), iotlbsz))
+				break;
+			free_bootmem_node(NODE_DATA(node), 
+					  virt_to_phys(io_tlb_start), iotlbsz);
+			io_tlb_start = NULL;
+		}
+	}
+
+	
 	if (!io_tlb_start)
 		panic("Cannot allocate SWIOTLB buffer");
 	io_tlb_end = io_tlb_start + io_tlb_nslabs * (1 << IO_TLB_SHIFT);

--raC6veAxrt5nqIoY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg-x460-fail

[    0.000000] Bootdata ok (command line is root=LABEL=/  console=ttyS1,115200 console=ttyS0,115200 console=tty1 console=tty0)
[    0.000000] Linux version 2.6.14-rc4 (root@x460) (gcc version 3.4.3 20050227 (Red Hat 3.4.3-22.1)) #4 SMP Mon Oct 17 16:32:57 PDT 2005
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 0000000000098000 (usable)
[    0.000000]  BIOS-e820: 0000000000098000 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000e7f94d40 (usable)
[    0.000000]  BIOS-e820: 00000000e7f94d40 - 00000000e7fa6a40 (ACPI data)
[    0.000000]  BIOS-e820: 00000000e7fa6a40 - 00000000e8000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 00000003f8000000 (usable)
[    0.000000] ACPI: RSDP (v000 IBM                                   ) @ 0x00000000000fdcf0
[    0.000000] ACPI: RSDT (v001 IBM    EXA01ZEU 0x00001000 IBM  0x45444f43) @ 0x00000000e7fa69c0
[    0.000000] ACPI: FADT (v001 IBM    EXA01ZEU 0x00001000 IBM  0x45444f43) @ 0x00000000e7fa6940
[    0.000000] ACPI: MADT (v001 IBM    EXA01ZEU 0x00001000 IBM  0x45444f43) @ 0x00000000e7fa6840
[    0.000000] ACPI: SRAT (v001 IBM    EXA01ZEU 0x00001000 IBM  0x45444f43) @ 0x00000000e7fa6700
[    0.000000] ACPI: HPET (v001 IBM    EXA01ZEU 0x00001000 IBM  0x45444f43) @ 0x00000000e7fa66c0
[    0.000000] ACPI: SSDT (v001 IBM    VIGSSDT0 0x00001000 INTL 0x20030122) @ 0x00000000e7f9f0c0
[    0.000000] ACPI: SSDT (v001 IBM    VIGSSDT1 0x00001000 INTL 0x20030122) @ 0x00000000e7f97b00
[    0.000000] ACPI: DSDT (v001 IBM    EXA01ZEU 0x00001000 INTL 0x20030122) @ 0x0000000000000000
[    0.000000] SRAT: PXM 0 -> APIC 0 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 6 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 16 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 22 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 32 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 38 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 48 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 54 -> Node 1
[    0.000000] SRAT: Node 0 PXM 0 0-e7ffffff
[    0.000000] SRAT: Node 0 PXM 0 0-207ffffff
[    0.000000] SRAT: Node 1 PXM 1 208000000-3f7ffffff
[    0.000000] Using 22 for the hash shift. Max adder is 3f7ffffff 
[    0.000000] Bootmem setup node 0 0000000000000000-0000000207ffffff
[    0.000000] Bootmem setup node 1 0000000208000000-00000003f7ffffff
[    0.000000] On node 0 totalpages: 2031403
[    0.000000]   DMA zone: 3992 pages, LIFO batch:1
[    0.000000]   Normal zone: 2027411 pages, LIFO batch:31
[    0.000000]   HighMem zone: 0 pages, LIFO batch:1
[    0.000000] On node 1 totalpages: 2031615
[    0.000000]   DMA zone: 0 pages, LIFO batch:1
[    0.000000]   Normal zone: 2031615 pages, LIFO batch:31
[    0.000000]   HighMem zone: 0 pages, LIFO batch:1
[    0.000000] ACPI: PM-Timer IO Port: 0x9c
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] Processor #0 15:4 APIC version 20
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x06] enabled)
[    0.000000] Processor #6 15:4 APIC version 20
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x10] enabled)
[    0.000000] Processor #16 15:4 APIC version 20
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x16] enabled)
[    0.000000] Processor #22 15:4 APIC version 20
[    0.000000] ACPI: LAPIC (acpi_id[0x10] lapic_id[0x20] enabled)
[    0.000000] Processor #32 15:4 APIC version 20
[    0.000000] ACPI: LAPIC (acpi_id[0x11] lapic_id[0x26] enabled)
[    0.000000] Processor #38 15:4 APIC version 20
[    0.000000] ACPI: LAPIC (acpi_id[0x12] lapic_id[0x30] enabled)
[    0.000000] Processor #48 15:4 APIC version 20
[    0.000000] ACPI: LAPIC (acpi_id[0x13] lapic_id[0x36] enabled)
[    0.000000] Processor #54 15:4 APIC version 20
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x10] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x11] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x12] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x13] dfl dfl lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x0f] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 15, version 17, address 0xfec00000, GSI 0-35
[    0.000000] ACPI: IOAPIC (id[0x0e] address[0xfec01000] gsi_base[35])
[    0.000000] IOAPIC[1]: apic_id 14, version 17, address 0xfec01000, GSI 35-70
[    0.000000] ACPI: IOAPIC (id[0x0d] address[0xfec02000] gsi_base[70])
[    0.000000] IOAPIC[2]: apic_id 13, version 17, address 0xfec02000, GSI 70-105
[    0.000000] ACPI: IOAPIC (id[0x0c] address[0xfec03000] gsi_base[105])
[    0.000000] IOAPIC[3]: apic_id 12, version 17, address 0xfec03000, GSI 105-140
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 8 global_irq 8 low edge)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 low edge)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ8 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] ACPI: IRQ14 used by override.
[    0.000000] Setting APIC routing to clustered
[    0.000000] ACPI: HPET id: 0x10142201 base: 0xfde84000
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Allocating PCI resources starting at ea000000 (gap: e8000000:16c00000)
[    0.000000] Checking aperture...
[    0.000000] Built 2 zonelists
[    0.000000] Kernel command line: root=LABEL=/  console=ttyS1,115200 console=ttyS0,115200 console=tty1 console=tty0
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 131072 bytes)
[    0.000000] time.c: Using 3.579545 MHz PM timer.
[    0.000000] time.c: Detected 3336.353 MHz processor.
[  331.470062] Console: colour VGA+ 80x25
[  331.978248] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes)
[  332.010808] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[  332.163134] bootmem alloc DMA of 67108864 bytes failed, retry normal area!
[  332.171394] 
[  332.171395] Call Trace:<ffffffff8054d1b6>{__alloc_bootmem+227} <ffffffff8011c268>{swiotlb_init_with_default_size+51}
[  332.185629]        <ffffffff80549fac>{mem_init+76} <ffffffff8053a725>{start_kernel+320}
[  332.195279]        <ffffffff8053a237>{_sinittext+567} 
[  332.269214] Placing software IO TLB between 0x21051c000 - 0x21451c000
[  332.837489] Memory: 15927888k/16646144k available (2594k kernel code, 324192k reserved, 1356k data, 208k init)
[  332.992581] Calibrating delay using timer specific routine.. 6683.98 BogoMIPS (lpj=33419944)
[  333.002891] Mount-cache hash table entries: 256
[  333.008517] CPU: Trace cache: 12K uops, L1 D cache: 16K
[  333.014787] CPU: L2 cache: 1024K
[  333.018668] CPU: L3 cache: 8192K
[  333.022565] CPU 0 -> Node 0
[  333.025890] using mwait in idle threads.
[  333.030578] CPU: Hyper-Threading is disabled
[  333.035732] CPU0: Thermal monitoring enabled (TM1)
[  333.041447] mtrr: v2.0 (20020519)
[  333.176831] ..MP-BIOS bug: 8254 timer not connected to IO-APIC
[  333.183779]  failed.
[  333.186407] timer doesn't work through the IO-APIC - disabling NMI Watchdog!
[  333.195849] Uhhuh. NMI received for unknown reason 35.
[  333.201975] Dazed and confused, but trying to continue
[  333.208117] Do you have a strange power saving mode enabled?
[  333.312735]  works.
[  333.315252] Using local APIC timer interrupts.
[  333.350450] Detected 10.426 MHz APIC timer.
[  333.355548] softlockup thread 0 started up.
[  333.360675] Booting processor 1/8 APIC 0x6
[  333.376738] Initializing CPU#1
[  333.520948] Calibrating delay using timer specific routine.. 6672.53 BogoMIPS (lpj=33362682)
[  333.520963] CPU: Trace cache: 12K uops, L1 D cache: 16K
[  333.520965] CPU: L2 cache: 1024K
[  333.520966] CPU: L3 cache: 8192K
[  333.520969] CPU 1 -> Node 0
[  333.520971] CPU: Hyper-Threading is disabled
[  333.520983] CPU1: Thermal monitoring enabled (TM1)
[  333.522091]                Intel(R) Xeon(TM) MP CPU 3.33GHz stepping 01
[  333.522102] APIC error on CPU1: 00(40)
[  333.522105] CPU 1: Syncing TSC to CPU 0.
[  333.522443] CPU 1: synchronized TSC with CPU 0 (last diff 10 cycles, maxerr 3060 cycles)
[  333.522468] softlockup thread 1 started up.
[  333.522561] Booting processor 2/8 APIC 0x10
[  333.533706] Initializing CPU#2
[  333.680458] Calibrating delay using timer specific routine.. 6672.80 BogoMIPS (lpj=33364014)
[  333.680474] CPU: Trace cache: 12K uops, L1 D cache: 16K
[  333.680476] CPU: L2 cache: 1024K
[  333.680478] CPU: L3 cache: 8192K
[  333.680480] CPU 2 -> Node 0
[  333.680482] CPU: Hyper-Threading is disabled
[  333.680495] CPU2: Thermal monitoring enabled (TM1)
[  333.681600]                Intel(R) Xeon(TM) MP CPU 3.33GHz stepping 01
[  333.681611] APIC error on CPU2: 00(40)
[  333.681614] CPU 2: Syncing TSC to CPU 0.
[  333.682057] CPU 2: synchronized TSC with CPU 0 (last diff 1 cycles, maxerr 3850 cycles)
[  333.682082] softlockup thread 2 started up.
[  333.682193] Booting processor 3/8 APIC 0x16
[  333.693347] Initializing CPU#3
[  333.839967] Calibrating delay using timer specific routine.. 6672.58 BogoMIPS (lpj=33362942)
[  333.839983] CPU: Trace cache: 12K uops, L1 D cache: 16K
[  333.839985] CPU: L2 cache: 1024K
[  333.839986] CPU: L3 cache: 8192K
[  333.839989] CPU 3 -> Node 0
[  333.839991] CPU: Hyper-Threading is disabled
[  333.840004] CPU3: Thermal monitoring enabled (TM1)
[  333.841110]                Intel(R) Xeon(TM) MP CPU 3.33GHz stepping 01
[  333.841121] APIC error on CPU3: 00(40)
[  333.841124] CPU 3: Syncing TSC to CPU 0.
[  333.841567] CPU 3: synchronized TSC with CPU 0 (last diff 56 cycles, maxerr 3850 cycles)
[  333.841593] softlockup thread 3 started up.
[  333.841689] Booting processor 4/8 APIC 0x20
[  205.772353] Initializing CPU#4
[  205.918959] Calibrating delay using timer specific routine.. 6672.85 BogoMIPS (lpj=33364294)
[  205.918982] CPU: Trace cache: 12K uops, L1 D cache: 16K
[  205.918984] CPU: L2 cache: 1024K
[  205.918986] CPU: L3 cache: 8192K
[  205.918990] CPU 4 -> Node 1
[  205.918993] CPU: Hyper-Threading is disabled
[  205.919009] CPU4: Thermal monitoring enabled (TM1)
[  205.920145]                Intel(R) Xeon(TM) MP CPU 3.33GHz stepping 01
[  205.920159] APIC error on CPU4: 00(40)
[  205.920163] CPU 4: Syncing TSC to CPU 0.
[  334.001485] CPU 4: synchronized TSC with CPU 0 (last diff -580 cycles, maxerr 8060 cycles)
[  334.001527] softlockup thread 4 started up.
[  334.001627] Booting processor 5/8 APIC 0x26
[  205.932263] Initializing CPU#5
[  206.078469] Calibrating delay using timer specific routine.. 6672.50 BogoMIPS (lpj=33362542)
[  206.078484] CPU: Trace cache: 12K uops, L1 D cache: 16K
[  206.078486] CPU: L2 cache: 1024K
[  206.078488] CPU: L3 cache: 8192K
[  206.078491] CPU 5 -> Node 1
[  206.078493] CPU: Hyper-Threading is disabled
[  206.078506] CPU5: Thermal monitoring enabled (TM1)
[  206.079636]                Intel(R) Xeon(TM) MP CPU 3.33GHz stepping 01
[  206.079648] APIC error on CPU5: 00(40)
[  206.079651] CPU 5: Syncing TSC to CPU 0.
[  334.160963] CPU 5: synchronized TSC with CPU 0 (last diff -95 cycles, maxerr 6740 cycles)
[  334.161001] softlockup thread 5 started up.
[  334.161101] Booting processor 6/8 APIC 0x30
[  206.091737] Initializing CPU#6
[  206.237979] Calibrating delay using timer specific routine.. 6673.07 BogoMIPS (lpj=33365394)
[  206.237995] CPU: Trace cache: 12K uops, L1 D cache: 16K
[  206.237998] CPU: L2 cache: 1024K
[  206.237999] CPU: L3 cache: 8192K
[  206.238002] CPU 6 -> Node 1
[  206.238005] CPU: Hyper-Threading is disabled
[  206.238017] CPU6: Thermal monitoring enabled (TM1)
[  206.239145]                Intel(R) Xeon(TM) MP CPU 3.33GHz stepping 01
[  206.239156] APIC error on CPU6: 00(40)
[  206.239159] CPU 6: Syncing TSC to CPU 0.
[  334.320471] CPU 6: synchronized TSC with CPU 0 (last diff 57 cycles, maxerr 6800 cycles)
[  334.320510] softlockup thread 6 started up.
[  334.320619] Booting processor 7/8 APIC 0x36
[  206.251256] Initializing CPU#7
[  206.397489] Calibrating delay using timer specific routine.. 6672.83 BogoMIPS (lpj=33364186)
[  206.397505] CPU: Trace cache: 12K uops, L1 D cache: 16K
[  206.397507] CPU: L2 cache: 1024K
[  206.397508] CPU: L3 cache: 8192K
[  206.397511] CPU 7 -> Node 1
[  206.397514] CPU: Hyper-Threading is disabled
[  206.397526] CPU7: Thermal monitoring enabled (TM1)
[  206.398656]                Intel(R) Xeon(TM) MP CPU 3.33GHz stepping 01
[  206.398666] APIC error on CPU7: 00(40)
[  206.398670] CPU 7: Syncing TSC to CPU 0.
[  334.479982] CPU 7: synchronized TSC with CPU 0 (last diff -760 cycles, maxerr 8020 cycles)
[  334.480006] Brought up 8 CPUs
[  334.480023] softlockup thread 7 started up.
[  334.549366] time.c: Using PIT/HPET based timekeeping.
[  334.555402] testing NMI watchdog ... CPU#0: NMI appears to be stuck (12->12)!
[  334.664231] checking if image is initramfs... it is
[  334.724472] NET: Registered protocol family 16
[  334.729831] ACPI: bus type pci registered
[  334.734651] PCI: Using configuration type 1
[  334.742672] ACPI: Subsystem revision 20050902
[  334.805446] ACPI: Interpreter enabled
[  334.809834] ACPI: Using IOAPIC for interrupt routing
[  334.818357] ACPI: PCI Root Bridge [VP00] (0000:00)
[  334.824082] PCI: Probing PCI hardware (bus 00)
[  334.832542] Boot video device is 0000:00:01.0
[  334.833064] PCI: Ignoring BAR0-3 of IDE controller 0000:00:0f.1
[  334.840283] ACPI: PCI Interrupt Routing Table [\_SB_.VP00._PRT]
[  334.847085] ACPI: PCI Root Bridge [VP01] (0000:01)
[  334.852820] PCI: Probing PCI hardware (bus 01)
[  334.861538] ACPI: PCI Interrupt Routing Table [\_SB_.VP01._PRT]
[  334.862989] ACPI: PCI Root Bridge [VP02] (0000:02)
[  334.868741] PCI: Probing PCI hardware (bus 02)
[  334.877037] ACPI: PCI Interrupt Routing Table [\_SB_.VP02._PRT]
[  334.879307] ACPI: PCI Root Bridge [VP03] (0000:04)
[  334.885052] PCI: Probing PCI hardware (bus 04)
[  334.893360] ACPI: PCI Interrupt Routing Table [\_SB_.VP03._PRT]
[  334.896057] ACPI: PCI Root Bridge [VP04] (0000:06)
[  334.901825] PCI: Probing PCI hardware (bus 06)
[  334.910117] ACPI: PCI Interrupt Routing Table [\_SB_.VP04._PRT]
[  334.912590] ACPI: PCI Root Bridge [VP05] (0000:08)
[  334.918326] PCI: Probing PCI hardware (bus 08)
[  334.926600] ACPI: PCI Interrupt Routing Table [\_SB_.VP05._PRT]
[  334.929213] ACPI: PCI Root Bridge [VP06] (0000:0a)
[  334.934929] PCI: Probing PCI hardware (bus 0a)
[  334.943195] ACPI: PCI Interrupt Routing Table [\_SB_.VP06._PRT]
[  334.945676] ACPI: PCI Root Bridge [VP07] (0000:0c)
[  334.951417] PCI: Probing PCI hardware (bus 0c)
[  334.959780] ACPI: PCI Interrupt Routing Table [\_SB_.VP07._PRT]
[  334.962958] ACPI: PCI Root Bridge [VP10] (0000:0e)
[  334.968707] PCI: Probing PCI hardware (bus 0e)
[  334.977583] ACPI: PCI Interrupt Routing Table [\_SB_.VP10._PRT]
[  334.979453] ACPI: PCI Root Bridge [VP11] (0000:0f)
[  334.985178] PCI: Probing PCI hardware (bus 0f)
[  334.993900] ACPI: PCI Interrupt Routing Table [\_SB_.VP11._PRT]
[  334.995202] ACPI: PCI Root Bridge [VP12] (0000:10)
[  335.000942] PCI: Probing PCI hardware (bus 10)
[  335.009184] ACPI: PCI Interrupt Routing Table [\_SB_.VP12._PRT]
[  335.011565] ACPI: PCI Root Bridge [VP13] (0000:12)
[  335.017305] PCI: Probing PCI hardware (bus 12)
[  335.025550] ACPI: PCI Interrupt Routing Table [\_SB_.VP13._PRT]
[  335.028008] ACPI: PCI Root Bridge [VP14] (0000:14)
[  335.033746] PCI: Probing PCI hardware (bus 14)
[  335.042015] ACPI: PCI Interrupt Routing Table [\_SB_.VP14._PRT]
[  335.044684] ACPI: PCI Root Bridge [VP15] (0000:16)
[  335.050424] PCI: Probing PCI hardware (bus 16)
[  335.058724] ACPI: PCI Interrupt Routing Table [\_SB_.VP15._PRT]
[  335.061213] ACPI: PCI Root Bridge [VP16] (0000:18)
[  335.066947] PCI: Probing PCI hardware (bus 18)
[  335.075231] ACPI: PCI Interrupt Routing Table [\_SB_.VP16._PRT]
[  335.077637] ACPI: PCI Root Bridge [VP17] (0000:1a)
[  335.083369] PCI: Probing PCI hardware (bus 1a)
[  335.092760] ACPI: PCI Interrupt Routing Table [\_SB_.VP17._PRT]
[  335.096962] SCSI subsystem initialized
[  335.101472] PCI: Using ACPI for IRQ routing
[  335.106488] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[  335.116783] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[  335.131226] PCI: Bridge: 0000:1a:01.0
[  335.135613]   IO window: f000-ffff
[  335.139707]   MEM window: f8600000-f86fffff
[  335.144732]   PREFETCH window: disabled.
[  335.154788] IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
[  335.174698] IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
[  335.192707] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[  335.200742] SGI XFS with large block/inode numbers, no debug enabled
[  335.210377] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[  335.383127] Real Time Clock Driver v1.12
[  335.387870] Linux agpgart interface v0.101 (c) Dave Jones
[  335.396008] serio: i8042 AUX port at 0x60,0x64 irq 12
[  335.402168] serio: i8042 KBD port at 0x60,0x64 irq 1
[  335.408211] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
[  335.417966] ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[  335.424185] ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[  335.431595] io scheduler noop registered
[  335.436386] io scheduler anticipatory registered
[  335.441989] io scheduler deadline registered
[  335.447246] io scheduler cfq registered
[  335.455801] RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
[  335.467104] loop: loaded (max 8 devices)
[  335.471840] Intel(R) PRO/1000 Network Driver - version 6.0.60-k2-NAPI
[  335.479602] Copyright (c) 1999-2005 Intel Corporation.
[  335.485973] ACPI: PCI Interrupt 0000:1b:04.0[A] -> GSI 124 (level, low) -> IRQ 169
[  335.837702] e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
[  335.845989] ACPI: PCI Interrupt 0000:1b:04.1[B] -> GSI 128 (level, low) -> IRQ 177
[  336.196842] e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
[  336.205097] ACPI: PCI Interrupt 0000:1b:06.0[A] -> GSI 132 (level, low) -> IRQ 185
[  336.555498] e1000: eth2: e1000_probe: Intel(R) PRO/1000 Network Connection
[  336.563729] ACPI: PCI Interrupt 0000:1b:06.1[B] -> GSI 136 (level, low) -> IRQ 193
[  336.914373] e1000: eth3: e1000_probe: Intel(R) PRO/1000 Network Connection
[  336.922749] tg3.c:v3.42 (Oct 3, 2005)
[  336.927149] ACPI: PCI Interrupt 0000:01:01.0[A] -> GSI 24 (level, low) -> IRQ 201
[  336.965752] eth4: Tigon3 [partno(BCM95704A6) rev 2100 PHY(5704)] (PCIX:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:0d:60:98:3d:7e
[  336.979682] eth4: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] Split[0] WireSpeed[1] TSOcap[0] 
[  336.989691] eth4: dma_rwctrl[769f0000]
[  336.994219] ACPI: PCI Interrupt 0000:01:01.1[B] -> GSI 28 (level, low) -> IRQ 209
[  337.033389] eth5: Tigon3 [partno(BCM95704A6) rev 2100 PHY(5704)] (PCIX:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:0d:60:98:3d:7f
[  337.047249] eth5: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
[  337.057270] eth5: dma_rwctrl[769f0000]
[  337.061834] ACPI: PCI Interrupt 0000:0f:01.0[A] -> GSI 94 (level, low) -> IRQ 217
[  337.094316] eth6: Tigon3 [partno(BCM95704A6) rev 2100 PHY(5704)] (PCIX:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:0d:60:98:3d:78
[  337.108200] eth6: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] Split[0] WireSpeed[1] TSOcap[0] 
[  337.118220] eth6: dma_rwctrl[769f0000]
[  337.122760] ACPI: PCI Interrupt 0000:0f:01.1[B] -> GSI 98 (level, low) -> IRQ 225
[  337.162010] eth7: Tigon3 [partno(BCM95704A6) rev 2100 PHY(5704)] (PCIX:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:0d:60:98:3d:79
[  337.175900] eth7: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
[  337.185927] eth7: dma_rwctrl[769f0000]
[  337.190609] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[  337.198195] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[  337.209240] libata version 1.12 loaded.
[  337.210284] mice: PS/2 mouse device common for all mice
[  337.216669] oprofile: using NMI interrupt.
[  337.221799] NET: Registered protocol family 2
[  337.254300] input: AT Translated Set 2 keyboard on isa0060/serio0
[  337.343559] IP route cache hash table entries: 524288 (order: 10, 4194304 bytes)
[  337.356297] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
[  337.369703] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[  337.378656] TCP: Hash tables configured (established 262144 bind 65536)
[  337.386587] TCP reno registered
[  337.390511] TCP bic registered
[  337.394230] NET: Registered protocol family 1
[  337.399462] NET: Registered protocol family 17
[  337.405423] Freeing unused kernel memory: 208k freed
[  337.496659] Loading AIC-94xx Linux SAS/SATA Family Driver, Rev: 1.0.7-3
[  337.496663] 
[  337.506547] Probing Adaptec AIC-94xx Controller(s)...
[  337.512641] ACPI: PCI Interrupt 0000:01:02.0[A] -> GSI 25 (level, low) -> IRQ 233
[  337.521196] input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
[  337.659493] Probing Adaptec AIC-94xx Controller(s)...
[  337.665600] ACPI: PCI Interrupt 0000:0f:02.0[A] -> GSI 95 (level, low) -> IRQ 50
[  337.819855] scsi0 : Adaptec AIC-9410 SAS/SATA Host Adapter
[  338.035597]   Vendor: IBM-ESXS  Model: ST973401SS    F   Rev: B515
[  338.043272]   Type:   Direct-Access                      ANSI SCSI revision: 04
[  338.052045] adp94xx:1:128:0: Tagged Queuing enabled.  Depth 32
[  338.059835] SCSI device sda: 143374000 512-byte hdwr sectors (73407 MB)
[  338.069220] SCSI device sda: drive cache: write through
[  338.076194] SCSI device sda: 143374000 512-byte hdwr sectors (73407 MB)
[  338.085563] SCSI device sda: drive cache: write through
[  338.091839]  sda: sda1 sda2 sda3
[  338.104332] Attached scsi disk sda at scsi0, channel 1, id 128, lun 0
[  338.112206] Attached scsi generic sg0 at scsi0, channel 1, id 128, lun 0,  type 0
[  338.179425] scsi1 : Adaptec AIC-9410 SAS/SATA Host Adapter
[  338.387094]   Vendor: IBM-ESXS  Model: ST973401SS    F   Rev: B515
[  338.394754]   Type:   Direct-Access                      ANSI SCSI revision: 04
[  338.403536] adp94xx:0:128:0: Tagged Queuing enabled.  Depth 32
[  338.411259] SCSI device sdb: 143374000 512-byte hdwr sectors (73407 MB)
[  338.420596] SCSI device sdb: drive cache: write through
[  338.427596] SCSI device sdb: 143374000 512-byte hdwr sectors (73407 MB)
[  338.436941] SCSI device sdb: drive cache: write through
[  338.443194]  sdb: sdb1 sdb2 sdb3 < sdb5 >
[  338.465813] Attached scsi disk sdb at scsi1, channel 0, id 128, lun 0
[  338.473691] Attached scsi generic sg1 at scsi1, channel 0, id 128, lun 0,  type 0
[  338.546790] AIC-94xx controller(s) attached = 2.
[  338.546792] 
[  338.671790] kjournald starting.  Commit interval 5 seconds
[  338.671771] EXT3-fs: mounted filesystem with ordered data mode.
[  390.457834] EXT3 FS on sda2, internal journal
[  390.721768] kjournald starting.  Commit interval 5 seconds
[  390.730787] EXT3 FS on sda1, internal journal
[  390.730796] EXT3-fs: mounted filesystem with ordered data mode.
[  390.745000] kjournald starting.  Commit interval 5 seconds
[  390.755673] EXT3 FS on sdb2, internal journal
[  390.755681] EXT3-fs: mounted filesystem with ordered data mode.
[  390.766741] XFS mounting filesystem sdb5
[  390.856620] Ending clean XFS mount for filesystem: sdb5

--raC6veAxrt5nqIoY--
