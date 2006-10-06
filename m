Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422921AbWJFUXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422921AbWJFUXd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 16:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422925AbWJFUXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 16:23:32 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:58695 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1422921AbWJFUXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 16:23:30 -0400
Date: Fri, 6 Oct 2006 22:23:24 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Rajesh Shah <rajesh.shah@intel.com>, Andi Kleen <ak@muc.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Luck, Tony" <tony.luck@intel.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Badari Pulavarty <pbadari@gmail.com>
Subject: Re: 2.6.19-rc1 genirq causes either boot hang or "do_IRQ: cannot handle IRQ -1"
Message-ID: <20061006202324.GJ14186@rhun.haifa.ibm.com>
References: <20061005212216.GA10912@rhun.haifa.ibm.com> <m11wpl328i.fsf@ebiederm.dsl.xmission.com> <20061006155021.GE14186@rhun.haifa.ibm.com> <m1d5951gm7.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1d5951gm7.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2006 at 11:47:12AM -0600, Eric W. Biederman wrote:
> Muli Ben-Yehuda <muli@il.ibm.com> writes:
> 
> > On Fri, Oct 06, 2006 at 09:14:53AM -0600, Eric W. Biederman wrote:
> >
> >> Muli Ben-Yehuda <muli@il.ibm.com> writes:
> >
> > In some cases we haven't made it to userspace at all. In other, we're
> > in the initrd.
> 
> Ok.  So no irqbalanced? 

Nope.

> Any non-standard firmware on this box like a hypervisor or weird APM
> code that could be causing problems.

BIOS is bog standard and has been working fine for at least a
year. The only firmware I updated recently was the aic94xx firmware
when aic94xx was merged into mainline.

> I'm just trying to think of things that might trip over a change in
> irq handling, besides a chipset.

Looking at the code below, aic94xx is certainly suspect.

> Can you try the debug patch below and tell me what it reports.
> As long as the problem irq is not for something important this
> should allow you to boot, and just collect the information.

Unfortunately aic94xx is pretty important, but we do get a lot
further.

> What I am hoping is that we will see which irq or irqs are having
> problems. Then we can check out how the irq controller for those
> irq are programmed.

I had to slightly redo your patch to cut down on the verbosity (and
get the pet CPU vector arrays correctly). This is over Serial-Over-Lan
which is painful beyond words and also tends to lose the most
interesting bits of the log. Sorry. Hopefully there's enough in here
to make progress.

patch I used (note: does not print vectors where IRQ is '-1'!):

diff -r fe0dbfd19a52 arch/x86_64/kernel/irq.c
--- a/arch/x86_64/kernel/irq.c	Wed Oct 04 21:55:29 2006 +0700
+++ b/arch/x86_64/kernel/irq.c	Fri Oct 06 22:02:45 2006 +0200
@@ -113,9 +113,21 @@ asmlinkage unsigned int do_IRQ(struct pt
 	irq = __get_cpu_var(vector_irq)[vector];
 
 	if (unlikely(irq >= NR_IRQS)) {
-		printk(KERN_EMERG "%s: cannot handle IRQ %d\n",
-					__FUNCTION__, irq);
-		BUG();
+		if (printk_ratelimit()) {
+			int cpu, vec;
+			printk(KERN_EMERG "%s: cannot handle IRQ %d vector: %d cpu: %d\n",
+                               __FUNCTION__, irq, vector, smp_processor_id());
+			for_each_online_cpu(cpu) {
+				for (vec = 0; vec < NR_VECTORS; vec++) {
+					irq = per_cpu(vector_irq, cpu)[vec];
+					if (irq != -1)
+						printk("v[%d][%d] -> %d\n",
+						       cpu, vec, irq);
+				}
+			}
+		}
+		irq_exit();
+		return 1;
 	}

Boot log:

kernel (hd0,1)/boot/calgary/bzImage root=/dev/sda2 console=tty0 console=ttyS1,1
9200    [Linux-bzImage, setup=0x1c00, size=0x2e3a9e]
initrd (hd0,1)/boot/calgary/aic94xxfw.initramfs.gz    [Linux-initrd @ 0x37e3f000, 0x1b01ca bytes]
savedefault
                                                                                
[    0.000000] Linux version 2.6.18mx (muli@rhun) (gcc version 3.4.1) #159 SMP Fri Oct 6 22:03:10 IST 2006
[    0.000000] Command line: root=/dev/sda2 console=tty0 console=ttyS1,19200
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 0000000000099000 (usable) [    0.000000]  BIOS-e820: 0000000000099000 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000e7f9c640 (usable)
[    0.000000]  BIOS-e820: 00000000e7f9c640 - 00000000e7fa6a40 (ACPI data)
[    0.000000]  BIOS-e820: 00000000e7fa6a40 - 00000000e8000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 0000000198000000 (usable)
[    0.000000] end_pfn_map = 1671168
[    0.000000] DMI 2.3 present.
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   DMA32        4096 ->  1048576
[    0.000000]   Normal    1048576 ->  1671168
[    0.000000] early_node_map[3] active PFN ranges
[    0.000000]     0:        0 ->      153
[    0.000000]     0:      256 ->   950172
[    0.000000]     0:  1048576 ->  1671168
[    0.000000] ACPI: PM-Timer IO Port: 0x9c
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] Processor #0 (Bootup-CPU)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] Processor #1
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)
[    0.000000] Processor #6
[    0.000000] ACPI: LAPIC (acpix1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] dfl dfl lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x0f] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 15, address 0xfec00RC_OVR (bus 0 bus_irq 8 global_irq 8 low edge)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 low edge)
[    0.000000] Setting APIC routing to flat
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Nosave address range: 0000000000099000 - 00000000000a0000
[    0.000000] Nosave address range: 00000000000a0000 - 00000000000e0000
[    0.000000] Nosave address range: 00000000000e0000 - 0000000000100000
[    0.000000] Nosave address range: 00000000e7f9c000 - 00000000e7f9d000
[    0.000000] Nosave address range: 00000000e7f9d000 - 00000000e7fa6000
[    0.000000] Nosave address range: 00000000e7fa6000 - 00000000e7fa7000
[    0.000000] Nosave address range: 00000000e7fa7000 - 00000000e8000000
[    0.000000] Nosave address range: 00000000e8000000 - 00000000fec00000
[    0.000000] Nosave address range: 00000000fec00000 - 0000000100000000
[    0.000000] Allocating PCI resources starting at ea000000 (gap: e8000000:16c00000)
78634] Console: colour VGA+ 80x25 34304 bytes of per cpu data
[  145.314411] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[  145.360930] ... MAX_LOCKDEP_SUBCLASSES:    8
[  145.386603] ... MAX_LOCK_DEPTH:          30
[  145.411759] ... MAX_LOCKDEP_KEYS:        2048
[  145.437952] ... CLASSHASH_SIZE:           1024
[  145.464683] ... MAX_LOCKDEP_ENTRIES:     8192
[  145.490864] ... MAX_LOCKDEP_CHAINS:      8192
[  145.517060] ... CHAINHASH_SIZE:          4096
[  145.543257]  memory used by lock dependency info: 1328 kB
[  145.575696]  per task-struct memory footprint: 1680 bytes
[  145.615363] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[  145.670335] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[  145.716748] Checking aperture...
[  145.759143] PCI-DMA: Calgary IOMMU detected.
[  145.784792] PCI-DMA: Calgary TCE table spec is 7, CONFIG_IOMMU_DEBUG is enabled.
[  145.946885] Memory: 6096428k/6684672k available (3789k kernel code, 193716k reserved, 2726k data, 276k init)
[  146.085394] Calibrating delay using timer specific routine.. 6346.33 BogoMIPS (lpj=12692676)
[  146.136398] Mount-cache hash table entries: 256
[  146.165244] CPU: Trace cache: 12K uops, L1 D cache: 16K
[  146.196746] CPU: L2 cache: 1024K
[  146.216144] using mwait in[  146.412642] ..MP-BIOS bug: 8254 timer not connected to IO-APIC
[  146.487676] Using local APIC timer interrupts.
[  146.545914] result 10425790
[  146.562697] Detected 10.425 MHz APIC timer.
[  146.590401] lockdep: not fixing up alternatives.
[  146.618683] Booting processor 1/4 APIC 0x1
[  146.653732] Initializing CPU#1
[  146.733219] Calibrating delay using timer specific routine.. 6339.05 BogoMIPS (lpj=12678102)
[  146.733236] CPU: Trace cache: 12K uops, L1 D cache: 16K
[  146.733240] CPU: L2 cache: 1024K
[  146.733244] CPU: Physical Processor ID: 0
[  146.733246] CPU: Processor Core ID: 0
[  146.733258] CPU1: Thermal monitoring enabled (TM1)
[  146.733546]                Intel(R) Xeon(TM) MP CPU 3.16GHz stepping 01
[  146.737545] lockdep: not fixing up alternatives.
[  146.999581] Booting processor 2/4 APIC 0x6
[  147.034599] Initializing CPU#2
[  147.113122] Calibrating delay using timer specific routine.. 6339.23 BogoMIPS (lpj=12678471)
[  147.113135] CPU: Trace cache: 12K uops, L1 D cache: 16K
[  147.113138] CPU: L2 cache: 1024K
[  147.113141] CPU: Physical Processor ID: 3
[  147.113143] CPU: Processor Core ID: 0
[  147.113154] CPU2: Thermal monitoring enabled (TM1)
[  147.113401]               Intel(R) Pentium(R) 4 CPU 3.16GHz stepping 09
[  147.117438] lockdep: not fixing up alternatives.
[  147.379484] Booting processor 3/4 APIC 0x7
[  147.414498] Initializing CPU#3
[  147.493025] Calibrating delay using timer specific routine.. 6339.30 BogoMIPS (lpj=12678616)
[  147.493039] CPU: Trace cache: 12K uops, L1 D cache: 16K
[  147.493042] CPU: L2 cache: 1024K
[  147.493045] CPU: Physical Processor ID: 3
[  147.493047] CPU: Processor Core ID: 0
[  147.493057] CPU3: Thermal monitoring enabled (TM1)
[  147.493304]               Intel(R) Pentium(R) 4 CPU 3.16GHz stepping 09
[  147.497060] Brought up 4 CPUs
[  147.749269] testing NMI watchdog ... OK.
[  147.812984] time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
[  147.850065] time.c: Detected 3169.464 MHz processor.
[  148.098097] migration_cost=8,697
[  148.118549] checking if image is initramfs... it is
[  148.310397] Freeing initrd memory: 1728k freed
[  148.340100] NET: Registered protocol family 16
[  148.377174] ACPI: bus type pci registered
[  148.401279] PCI: Using configuration type 1
[  148.555966] ACPI: Interpreter enabled
[  148.577976] ACPI: Using IOAPIC for interrupt routing
[  148.614688] ACPI: PCI Root Bridge [VP00] (0000:00)
[  148.646922] PCI: Ignoring BAR0-3 of IDE controller 0000:00:0f.1
[  148.699359] ACPI: PCI Root Bridge [VP01] (0000:01)
[  148.734053] ACPI: PCI Root Bridge [VP02] (0000:02)
[  148.771953] ACPI: PCI Root Bridge [VP03] (0000:04)
[  148.809918] ACPI: PCI Root Bridge [VP04] (0000:06)
[  148.847903] ACPI: PCI Root Bridge [VP05] (0000:08)
[  148.886043] ACPI: PCI Root Bridge [VP06] (0000:0a)
[  148.923887] ACPI: PCI Root Bridge [VP07] (0000:0c)
[  148.962138] SCSI subsystem initialized
[  148.984887] usbcore: registered new interface driver usbfs
[  149.018005] usbcore: registered new interface driver hub
[  149.050080] usbcore: registered new device driver usb
[  149.080874] PCI: Using ACPI for IRQ routing
[  149.106052] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[  149.155947] PCI-DMA: Using Calgary IOMMU
[  149.535125] Calgary: enabling translation on PHB 0
[  149.563893] Calgary: errant DMAs will now be prevented on this bus.
[  149.956626] Calgary: enabling translation on PHB 1
[  149.985385] Calgary: errant DMAs will now be prevented on this bus.
[  150.378420] Calgary: enabling translation on PHB 2
[  150.407200] Calgary: errant DMAs will now be prevented on this bus.
[  150.444887] PCI-GART: No AMD northbridge found.
[  150.481504] NET: Registered protocol family 2
[  150.564490] IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
[  150.610394] TCP established hash table entries: 65536 (order: 9, 3670016 bytes)
[  150.662161] TCP bind hash table entries: 32768 (order: 8, 1835008 bytes)
[  150.705585] TCP: Hash tables configured (established 65536 bind 32768)
[  150.744845] TCP reno registered
[  150.788016] Total HugeTLB memory allocated, 0
[  150.815888] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[  150.854967] io scheduler noop registered
[  150.878661] io scheduler anticipatory registered (default)
[  150.911820] io scheduler deadline registered
[  150.937631] io scheduler cfq registered
[  150.968969] GSI 16 sharing vector 0xA9 and IRQ 16
[  150.997256] ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
[  151.042013] radeonfb: Found Intel x86 BIOS ROM Image
[  151.084087] radeonfb: Retrieved PLL infos from BIOS
[  151.113402] radeonfb: Reference=27.00 MHz (RefDiv=60) Memory=143.00 Mhz, System=143.00 MHz
[  151.163038] radeonfb: PLL min 12000 max 35000
[  151.293564] i2c_adapter i2c-1: unable to read EDID block.
[  151.485429] i2c_adapter i2c-1: unable to read EDID block.
[  151.677378] i2c_adapter i2c-1: unable to read EDID block.
[  152.141253] i2c_adapter i2c-2: unable to read EDID block.
[  152.333202] i2c_adapter i2c-2: unable to read EDID block.
[  152.525151] i2c_adapter i2c-2: unable to read EDID block.
[  152.679651] radeonfb: Monitor 1 type DFP found
[  152.706339] radeonfb: EDID probed
[  152.726291] radeonfb: Monitor 2 type CRT found
[  153.789033] Console: switching to colour frame buffer device 128x48
[  154.501204] radeonfb (0000:00:01.0): ATI Radeon QY
[  154.533124] tridentfb: Trident framebuffer 0.7.8-NEWAPI initializing
[  154.573158] hgafb: HGA card not detected.
[  154.597485] hgafb: probe of hgafb.0 failed with error -22
[  154.632874] vga16fb: mapped to 0xffff8100000a0000
[  154.661533] fb1: VGA16 VGA frame buffer device
[  154.690014] fb2: Virtual frame buffer device, using 1024K of video memory
[  154.731323] ACPI: Power Button (FF) [PWRF]
[  154.756904] ibm_acpi: ec object not found
[  155.168952] Linux agpgart interface v0.101 (c) Dave Jones
[  155.201821] ipmi message handler version 39.0
[  155.228099] ipmi device interface
[  155.248427] Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
[  155.302532] Hangcheck: Using monotonic_clock().
[  155.329922] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
[  155.377566] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[  155.414588] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[  155.463482] RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
[  155.515187] loop: loaded (max 8 devices)
[  155.539151] ibmasm: IBM ASM Service Processor Driver version 1.0 loaded
[  155.579273] GSI 17 sharing vector 0xB1 and IRQ 17
[  155.607733] ACPI: PCI Interrupt 0000:02:01.0[A] -> GSI 18 (level, low) -> IRQ 17
[  155.652707] 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
[  155.652720] 0000:02:01.0: 3Com PCI 3c905C Tornado at ffffc20000042000.
[  155.679897] tg3.c:v3.66 (September 23, 2006)
[  155.679934] GSI 18 sharing vector 0xB9 and IRQ 18
[  155.679943] ACPI: PCI Interrupt 0000:01:01.0[A] -> GSI 24 (level, low) -> IRQ 18
[  155.820675] eth1: Tigon3 [partno(BCM95704A6) rev 2100 PHY(5704)] (PCIX:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:0d:60:98:74:22
[  155.820710] eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] Split[0] WireSpeed[1] TSOcap[0]
[  155.820737] eth1: dma_rwctrl[769f0000] dma_mask[64-bit]
[  155.821520] GSI 19 sharing vector 0xC1 and IRQ 19
[  155.821530] ACPI: PCI Interrupt 0000:01:01.1[B] -> GSI 28 (level, low) -> IRQ 19
[  155.987822] eth2: Tigon3 [partno(BCM95704A6) rev 2100 PHY(5704)] (PCIX:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:0d:60:98:74:23
[  155.987833] eth2: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1]
[  155.987837] eth2: dma_rwctrl[769f0000] dma_mask[64-bit]
[  155.988518] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[  155.988524] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[  155.988627] SvrWks CSB6: IDE controller at PCI slot 0000:00:0f.1
[  155.988651] SvrWks CSB6: chipset revision 160
[  155.988654] SvrWks CSB6: not 100% native mode: will probe irqs later
[  155.988682]     ide0: BM-DMA at 0x0700-0x0707, BIOS settings: hda:DMA, hdb:DMA
[  155.988705] SvrWks CSB6: simplex device: DMA disabled
[  155.988708] ide1: SvrWks CSB6 Bus-Master DMA disabled (BIOS)
[  156.731022] hda: HL-DT-STDVD-ROM GDR8082N, ATAPI CD/DVD-ROM drive
[  157.075385] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[  157.650961] hda: ATAPI 24X DVD-ROM drive, 256kB Cache
[  157.666573] Uniform CD-ROM driver Revision: 3.20
[  157.795737] usbmon: debugfs is not available
[  157.864486] GSI 20 sharing vector 0xC9 and IRQ 20
[  157.934987] ACPI: PCI Interrupt 0000:00:03.0[A] -> GSI 20 (level, low) -> IRQ 20
[  158.022162] ohci_hcd 0000:00:03.0: OHCI Host Controller
[  158.097479] ohci_hcd 0000:00:03.0: new USB bus registered, assigned bus number 1
[  158.184780] ohci_hcd 0000:00:03.0: irq 20, io mem 0xf2c10000
[  158.348499] usb usb1: Product: OHCI Host Controller
[  158.420345] usb usb1: Manufacturer: Linux 2.6.18mx ohci_hcd
[  158.496076] usb usb1: SerialNumber: 0000:00:03.0
[  158.566466] usb usb1: configuration #1 chosen from 1 choice
[  158.642874] hub 1-0:1.0: USB hub found
[  158.707016] hub 1-0:1.0: 2 ports detected
[  158.879585] ACPI: PCI Interrupt 0000:00:03.1[B] -> GSI 20 (level, low) -> IRQ 20
[  158.965660] ohci_hcd 0000:00:03.1: OHCI Host Controller
[  159.037917] ohci_hcd 0000:00:03.1: new USB bus registered, assigned bus number 2
[  159.123547] ohci_hcd 0000:00:03.1: irq 20, io mem 0xf2c11000
[  159.288015] usb usb2: Product: OHCI Host Controller
[  159.357481] usb usb2: Manufacturer: Linux 2.6.18mx ohci_hcd
[  159.430967] usb usb2: SerialNumber: 0000:00:03.1
[  159.432415] usb usb2: configuration #1 chosen from 1 choice
[  159.433482] hub 2-0:1.0: USB hub found
[  159.433500] hub 2-0:1.0: 2 ports detected
[  159.2833] USB Universal Host Controller Interface driver v3.0
[  159.705996] serio: i8042 KBD port at 0x60,0x64 irq 1
[  159.706135] serio: i8042 AUX port at 0x60,0x64 irq 12
[  159.750228] mice: PS/2 mouse device common for all mice
[  159.769058] input: PC Speaker as /class/input/input0
[  159.781128] input: AT Translated Set 2 keyboard as /class/input/input1
[  159.791200] i2c /dev entries driver
[  159.798292] do_IRQ: cannot handle IRQ -1 vector: 137 cpu: 1
[  159.798299] v[0][32] -> 0
[  159.798302] v[0][33] -> 1
[  159.798308] v[0][34] -> 2
[  159.798313] v[0][35] -> 3
[  159.798318] v[0][36] -> 4
[  159.798323] v[0][37] -> 5
[  159.798328] v[0][38] -> 6
[  159.798333] v[0][39] -> 7
[  159.798338] v[0][40] -> 8
[  159.798341] v[0][41] -> 9
[  159.798345] v[0][42] -> 10
[  159.798351] v[0][43] -> 11
[  159.798356] v[0][44] -> 12
[  159.798361] v[0][45] -> 13
[  159.798366] v[0][46] -> 14
[  159.798371] v[0][47] -> 15
[  159.798376] v[0][49] -> 0
[  159.798382] v[0][57] -> 1
[  159.798387] v[0][65] -> 3
[  159.798392] v[0][73] -> 4
[  159.798397] v[0][81] -> 5
[  159.798402] v[0][89] -> 6
[  159.798407] v[0][97] -> 7
[  159.798412] v[0][105] -> 8
[  159.798417] v[0][113] -> 9
[  159.798422] v[0][121] -> 10
[  159.798427] v[0][129] -> 11
[  159.798431] v[0][137] -> 12
[  159.798436] v[0][145] -> 13
[  159.798441] v[0][153] -> 14
[  159.798446] v[0][161] -> 15
[  159.798451] v[0][169] -> 16
[  159.798456] v[0][177] -> 17
[  159.798461] v[0][185] -> 18
[  159.798465] v[0][193] -> 19
[  159.798469] v[0][201] -> 20
[  159.798475] v[1][32] -> 0
[  159.798478] v[1][33] -> 1
[  159.798482] v[1][34] -> 2
[  159.798485] v[1][35] -> 3
[  159.798489] v[1][36] -> 4
[  159.798494] v[1][37] -> 5
[  159.798497] v[1][38] -> 6
[  159.798500] v[1][39] -> 7
[  159.798503] v[1][40] -> 8
[  159.798507] v[1][41] -> 9
[  159.798512] v[1][42] -> 10
[  159.798517] v[1][43] -> 11
[  159.798522] v[1][44] -> 12
[  159.798527] v[1][45] -> 13
[  159.798532] v[1][46] -> 14
[  159.798537] v[1][47] -> 15
[  159.798544] v[2][32] -> 0
[  159.798548] v[2][33] -> 1
[  159.798553] v[2][34] -> 2
[  159.798558] v[2][35] -> 3
[  159.798564] v[2][36] -> 4
[  159.798567] v[2][37] -> 5
[  159.798571] v[2][38] -> 6
[  159.798575] v[2][39] -> 7
[  159.798581] v[2][40] -> 8
[  159.798586] v[2][41] -> 9
[  159.798589] v[2][[  159.798632] v[3][35] -> 3
[  159.798637] v[3][36] -> 4
[  159.798642] v[3][37] -> 5
[  159.798647] v[3][38] -> 6
[  159.798653] v[3][39] -> 7
[  159.798657] v[3][40] -> 8
[  159.798663] v[3][41] -> 9
[  159.798667] v[3][42] -> 10
[  159.798670] v[3][43] -> 11
[  159.798674] v[3][44] -> 12
[  159.798679] v[3][45] -> 13
[  159.798683] v[3][46] -> 14
[  159.798688] v[3][47] -> 15
[  159.804460] i2c-parport: adapter type unspecified
[  160.009819] i2c_adapter i2c-9191: Driver w83781d-isa failed to attach adapter, unregistering
[  160.018828] i2c_adapter i2c-9191: Driver lm78-isa failed to attach adapter, unregistering
[  160.025448] md: linear personality registered for level -1
[  160.025457] md: raid0 personality registered for level 0
[  160.025461] md: raid1 personality registered for level 1
[  160.025466] md: multipath personality registered for level -4
[  163.205667] device-mapper: ioctl: 4.10.0-ioctl (2006-09-14) initialised: dm-devel@redhat.com
[  163.268868] device-mapper: multipath: version 1.0.5 loaded
[  163.314732] device-mapper: multipath round-robin: version 1.0.0 loaded
[  163.366960] device-mapper: multipath emc: version 0.0.3 loaded
[  163.415568] EDAC MC: Ver: 2.0.1 Oct  6 2006
[  163.455463] pktgen v2.68: Packet Generator for packet performance testing.
[  163.512367] u32 classifier
[  163.544695]     OLD policer on
[  163.579860] IPv4 over IPv4 tunneling driver
[  163.621848] GRE over IPv4 tunneling driver
[  163.663831] TCP cubic registered
[  163.700685] Initializing XFRM netlink socket
[  163.744394] NET: Registered protocol family 1
[  163.788355] NET: Registered protocol family 17
[  163.833095] NET: Registered protocol family 15
[  163.878044] 802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
[  163.937434] All bugs added by David S. Miller <davem@redhat.com>
[  164.033637] SCTP: Hash tables configured (established 37449 bind 37449)
[  164.095781] Freeing unused kernel memory: 276k freed
 running (1:0) /init
hello worl[  164.161678] aic94xx: Adaptec aic94xx SAS/SATA driver version 1.0.2 loaded
d from the initrd1!
 
 
[  164.359782] aic94xx: found Adaptec AIC-9410W SAS/SATA Host Adapter, device 0000:01:02.0
[  164.431025] scsi0 : aic94xx
[  164.474953] aic94xx: BIOS present (1,1), 1323
[  164.525536] aic94xx: ue num:2, ue size:88
[  164.592941] aic94xx: manuf sect SAS_ADDR 5005076a0112df00
[  164.650431] aic94xx: manuf sect PCBA SN
[  164.699353] aic94xx: ms: num_phy_desc: 8
[  164.748439] aic94xx: ms: phy0: ENEBLEABLE
[  164.798368] aic94xx: ms: phy1: ENEBLEABLE
[  164.848359] aic94xx: ms: phy2: ENEBLEABLE
[  164.898376] aic94xx: ms: phy3: ENEBLEABLE
[  164.948424] aic94xx: ms: phy4: ENEBLEABLE
[  164.998583] aic94xx: ms: phy5: ENEBLEABLE
[  165.048668] aic94xx: ms: phy6: ENEBLEABLE
[  165.098863] aic94xx: ms: phy7: ENEBLEABLE
[  165.149062] aic94xx: ms: max_phys:0x8, num_phys:0x8
[  165.204777] aic94xx: ms: enabled_phys:0xff
[  165.268987] aic94xx: ctrla: phy0: sas_addr: 5005076a0112df00, sas rate:0x9-0x8, sata rate:0x0-0x0, flags:0x0
[  165.355790] aic94xx: ctrla: phy1: sas_addr: 5005076a0112df00, sas rate:0x9-0x8, sata rate:0x0-0x0, flags:0x0
[  165.442336] aic94xx: ctrla: phy2: sas_addr: 5005076a0112df00, sas rate:0x9-0x8, sata rate:0x0-0x0, flags:0x0
[  165.527401] aic94xx: ctrla: phy3: sas_addr: 5005076a0112df00, sas rate:0x9-0x8, sata rate:0x0-0x0, flags:0x0
[  165.611685] aic94xx: ctrla: phy4: sas_addr: 5005076a0112df00, sas rate:0x9-0x8, sata rate:0x0-0x0, flags:0x0
[  165.695125] aic94xx: ctrla: phy5: sas_addr: 5005076a0112df00, sas rate:0x9-0x8, sata rate:0x0-0x0, flags:0x0
[  165.778164] aic94xx: ctrla: phy6: sas_addr: 5005076a0112df00, sas rate:0x9-0x8, sata rate:0x0-0x0, flags:0x0
[  165.861369] aic94xx: ctrla: phy7: sas_addr: 5005076a0112df00, sas rate:0x9-0x8, sata rate:0x0-0x0, flags:0x0
[  165.944102] aic94xx: max_scbs:512, max_ddbs:128
[  165.995003] aic94xx: setting phy0 addr to 5005076a0112df00
[  166.051079] aic94xx: setting phy1 addr to 5005076a0112df00
[  166.107028] aic94xx: setting phy2 addr to 5005076a0112df00
[  166.162587] aic94xx: setting phy3 addr to 5005076a0112df00
[  166.217456] aic94xx: setting phy4 addr to 5005076a0112df00
[  166.271516] aic94xx: setting phy5 addr to 5005076a0112df00
[  166.324662] aic94xx: setting phy6 addr to 5005076a0112df00
[  166.377457] aic94xx: setting phy7 addr to 5005076a0112df00
[  166.430105] aic94xx: num_edbs:21
[  166.469378] aic94xx: num_escbs:3
[  166.513157] aic94xx: using sequencer V17/10c6
[  166.558549] aic94xx: downloading CSEQ...
[  166.601389] aic94xx: dma-ing 8192 bytes
[  166.647675] aic94xx: verified 8192 bytes, passed
[  166.695042] aic94xx: downloading LSEQs...
[  166.738834] aic94xx: dma-ing 14336 bytes
[  166.788238] aic94xx: LSEQ0 verified 14336 bytes, passed
[  166.844965] aic94xx: LSEQ1 verified 14336 bytes, passed
[  166.901410] aic94xx: LSEQ2 verified 14336 bytes, passed
[  166.957139] aic94xx: LSEQ3 verified 14336 bytes, passed
[  167.011865] aic94xx: LSEQ4 verified 14336 bytes, passed
[  167.065769] aic94xx: LSEQ5 verified 14336 bytes, passed
[  167.119471] aic94xx: LSEQ6 verified 14336 bytes, passed
[  167.172184] aic94xx: LSEQ7 verified 14336 bytes, passed
[  167.241724] aic94xx: max_scbs:446
[  167.276569] aic94xx: first_scb_site_no:0x20
[  167.316600] aic94xx: last_scb_site_no:0x1fe
[  167.356463] aic94xx: First SCB dma_handle: 0xd000
[  167.400345] aic94xx: device 0000:01:02.0: SAS addr 5005076a0112df00, PCBA SN , 8 phys, 8 enabled phys, flash present, BIOS build 1323
[  167.506200] aic94xx: posting 3 escbs
[  167.546503] aic94xx: escbs posted
[  167.591039] aic94xx: posting 8 control phy scbs
[  167.637137] aic94xx: enabled phys
[  167.640100] aic94xx: control_phy_tasklet_complete: phy0, lrate:0x9, proto:0xe
[  167.640188] aic94xx: escb_tasklet_complete: phy0: BYTES_DMAED
[  167.640383] aic94xx: SAS proto IDENTIFY:
[  167.640386] aic94xx: 00: 10 00 00 08
[  167.640388] aic94xx: 04: 00 00 00 00
[  167.640390] aic94xx: 08: 00 00 00 00
[  167.640392] aic94xx: 0c: 50 00 c5 00
[  167.640394] aic94xx: 10: 00 32 f3 95
[  167.640396] aic94xx: 14: 00 00 00 00
[  167.640398] aic94xx: 18: 00 00 00 00
[  167.640581] aic94xx: control_phy_tasklet_complete: phy4, lrate:0x9, proto:0xe
[  167.640585] aic94xx: escb_tasklet_complete: phy4: BYTES_DMAED
[  167.640588] aic94xx: SAS proto IDENTIFY:
[  167.640590] aic94xx: 00: 10 00 00 08
[  167.640592] aic94xx: 04: 00 00 00 00
[  167.640594] aic94xx: 08: 00 00 00 00
[  167.640596] aic94xx: 0c: 50 00 c5 00
[  167.640598] aic94xx: 10: 00 32 f5 25
[  167.640599] aic94xx: 14: 00 00 00 00
[  167.640601] aic94xx: 18: 00 00 00 00
[  167.640725] sas: phy0 added to port0, phy_mask:0x1
[  167.641150] sas: phy4 added to port1, phy_mask:0x10
[  167.647276] aic94xx: control_phy_tasklet_complete: phy1: no device present: oob_status:0x0
[  167.647292] aic94xx: control_phy_tasklet_complete: phy2: no device present: oob_status:0x0
[  167.647306] aic94xx: control_phy_tasklet_complete: phy3: no device present: oob_status:0x0
[  167.647320] aic94xx: control_phy_tasklet_complete: phy5: no device present: oob_status:0x0
[  167.647334] aic94xx: control_phy_tasklet_complete: phy6: no device present: oob_status:0x0
[  167.647347] aic94xx: control_phy_tasklet_complete: phy7: no device present: oob_status:0x0
[  167.647904] sas: DOING DISCOVERY on port 0, pid:1091
[  167.660165] scsi 0:0:0:0: Direct-Access     IBM-ESXS ST936701SS    F  B512 PQ: 0 ANSI: 4
[  167.673935] SCSI device sda: 71096640 512-byte hdwr sectors (36401 MB)
[  167.675156] sda: Write Protect is off
[  167.676755] SCSI device sda: drive cache: write through w/ FUA
[  167.680184] SCSI device sda: 71096640 512-byte hdwr sectors (36401 MB)
[  167.681399] sda: Write Protect is off
[  167.682899] SCSI device sda: drive cache: write through w/ FUA
[  167.683098]  sda: sda1 sda2
[  169.583450] sd 0:0:0:0: Attached scsi disk sda
[  169.636424] sd 0:0:0:0: Attached scsi generic sg0 type 0
[  169.694797] sas: DONE DISCOVERY on port 0, pid:1091, result:0
[  169.755353] sas: DOING DISCOVERY on port 1, pid:1091
[  169.813547] scsi 0:0:1:0: Direct-Access     IBM-ESXS ST936701SS    F  B512 PQ: 0 ANSI: 4
[  169.889504] SCSI device sdb: 71096640 512-byte hdwr sectors (36401 MB)
[  169.954627] sdb: Write Protect is off
[  170.003087] SCSI device sdb: drive cache: write through w/ FUA
[  170.003785] SCSI device sdb: 71096640 512-byte hdwr sectors (36401 MB)
[  170.004997] sdb: Write Protect is off
[  170.006496] SCSI device sdb: drive cache: write through w/ FUA
[  170.006500]  sdb: sdb1 sdb2
[  170.066820] sd 0:0:1:0: Attached scsi disk sdb
[  170.068203] sd 0:0:1:0: Attached scsi generic sg1 type 0
[  170.068551] do_IRQ: cannot handle IRQ -1 vector: 209 cpu: 1
[  170.068556] v[0][32] -> 0
[  170.068559] v[0][33] -> 1
[  170.068562] v[0][34] -> 2
[  170.068564] v[0][35] -> 3
[  170.068566] v[0][36] -> 4
[  170.068569] v[0][37] -> 5
[  170.068571] v[0][38] -> 6
[  170.068573] v[0][39] -> 7
[  170.068576] v[0][40] -> 8
[  170.068578] v[0][41] -> 9
[  170.068581] v[0][42] -> 10
[  170.068583] v[0][43] -> 11
[  170.068586] v[0][44] -> 12
[  170.068588] v[0][45] -> 13
[  170.068591] v[0][46] -> 14
[  170.068594] v[0][47] -> 15
[  170.068597] v[0][49] -> 0
[  170.068600] v[0][57] -> 1
[  170.068602] v[0][65] -> 3
[  170.068605] v[0][73] -> 4
[  170.068607] v[0][81] -> 5
[  170.068610] v[0][89] -> 6
[  170.068613] v[0][97] -> 7
[  170.068615] v[0][105] -> 8
[  170.068619] v[0][113] -> 9
[  170.068622] v[0][121] -> 10
[  170.068624] v[0][129] -> 11
[  170.068627] v[0][137] -> 12
[  170.068630] v[0][145] -> 13
[  170.068633] v[0][153] -> 14
[  170.068635] v[0][161] -> 15
[  170.068638] v[0][169] -> 16
[  170.068641] v[0][177] -> 17
[  170.068644] v[0][185] -> 18
[  170.068647] v[0][193] -> 19
[  170.068650] v[0][201] -> 20
[  170.068653] v[0][209] -> 21
[  170.068656] v[1][32] -> 0
[  170.068659] v[1][33] -> 1
[  170.068662] v[1][34] -> 2
[  170.068664] v[1][35] -> 3
[  170.068667] v[1][36] -> 4
[  170.068670] v[1][37] -> 5
[  170.068673] v[1][38] -> 6
[  170.068675] v[1][39] -> 7
[  170.068678] v[1][40] -> 8
[  170.068681] v[1][41] -> 9
[  170.068684] v[1][42] -> 10
[  170.068686] v[1][  170.068713] v[2][36] -> 4
[  170.068716] v[2][37] -> 5
[  170.068719] v[2][38] -> 6
[  170.068721] v[2][39] -> 7
[  170.068724] v[2][40] -> 8
[  170.068727] v[2][41] -> 9
[  170.068729] v[2][42] -> 10
[  170.068732] v[2][43] -> 11
[  170.068735] v[2][44] -> 12
[  170.068737] v[2][45] -> 13
[  170.068740] v[2][46] -> 14
[  170.068743] v[2][47] -> 15
[  170.068748] v[3][32] -> 0
[  170.068750] v[3][33] -> 1
[  170.068753] v[3][34] -> 2
[  170.068756] v[3][35] -> 3
[  170.068758] v[3][36] -> 4
[  170.068761] v[3][37] -> 5
[  170.068763] v[3][38] -> 6
[  170.068766] v[3][39] -> 7
[  170.068768] v[3][40] -> 8
[  170.068771] v[3][41] -> 9
[  170.068773] v[3][42] -> 10
[  170.068776] v[3][43] -> 11
[  170.068779] v[3][44] -> 12
[  170.068781] v[3][45] -> 13
[  170.068784] v[3][46] -> 14
[  170.068786] v[3][47] -> 15
[  176.069363] sas: command 0xffff810196bc5e00, task 0xffff810196bc0c80, timed out: EH_NOT_HANDLED
[  176.129298] sas: Enter sas_scsi_recover_host
[  176.163414] sas: going over list...
[  176.163417] sas: trying to find task 0xffff810196bc0c80
[  176.163421] sas: sas_scsi_find_task: aborting task 0xffff810196bc0c80
[  181.163990] aic94xx: tmf timed out
[  181.194452] aic94xx: tmf came back
[  181.225064] aic94xx: task not done, clearing nexus
[  181.264643] aic94xx: asd_clear_nexus_index: PRE
[  181.302787] aic94xx: asd_clear_nexus_index: POST
[  181.341540] aic94xx: asd_clear_nexus_index: clear nexus posted, waiting...
[  186.342601] aic94xx: asd_clear_nexus_timedout: here
[  191.385250] aic94xx: came back from clear nexus
[  191.425072] aic94xx: task not done, clearing nexus
[  191.467109] aic94xx: asd_clear_nexus_index: PRE
[  191.507704] aic94xx: asd_clear_nexus_index: POST
[  191.548862] aic94xx: asd_clear_nexus_index: clear nexus posted, waiting...
[  196.547861] aic94xx: asd_clear_nexus_timedout: here
[  201.590511] aic94xx: came back from clear nexus
[  201.632681] aic94xx: task 0xffff810196bc0c80 aborted, res: 0x5
[  201.683243] sas: sas_scsi_find_task: querying task 0xffff810196bc0c80
[  206.737126] aic94xx: tmf timed out
[  206.774250] aic94xx: asd_initiate_ssp_tmf: converting result 0x5 to TMF_RESP_FUNC_FAILED
[  206.840183] sas: sas_scsi_find_task: aborting task 0xffff810196bc0c80
[  211.839757] aic94xx: tmf timed out
[  211.878727] aic94xx: tmf came back
[  211.917837] aic94xx: task not done, clearing nexus
[  211.965846] aic94xx: asd_clear_nexus_index: PRE
[  212.012452] aic94xx: asd_clear_nexus_index: POST
[  212.059737] aic94xx: asd_clear_nexus_index: clear nexus posted, waiting...
[  217.058357] aic94xx: asd_clear_nexus_timedout: here
[  222.109005] aic94xx: came back from clear nexus
[  222.157294] aic94xx: task not done, clearing nexus
[  222.207692] aic94xx: asd_clear_nexus_index: PRE
[  222.256718] aic94xx: asd_clear_nexus_index: POST
[  222.306425] aic94xx: asd_clear_nexus_index: clear nexus posted, waiting...
[  227.307607] aic94xx: asd_clear_nexus_timedout: here
[  232.358255] aic94xx: came back from clear nexus
[  232.409012] aic94xx: task 0xffff810196bc0c80 aborted, res: 0x5
[  232.468159] sas: sas_scsi_find_task: querying task 0xffff810196bc0c80
[  237.532862] aic94xx: tmf timed out
[  237.578545] aic94xx: asd_initiate_ssp_tmf: converting result 0x5 to TMF_RESP_FUNC_FAILED
[  237.652894] sas: sas_scsi_find_task: aborting task 0xffff810196bc0c80
[  242.719470] aic94xx: tmf timed out
[  242.766948] aic94xx: tmf came back
[  242.766951] aic94xx: task not done, clearing nexus
[  242.766953] aic94xx: asd_clear_nexus_index: PRE
[  242.766962] aic94xx: asd_clear_nexus_index: POST
[  242.766982] aic94xx: asd_clear_nexus_index: clear nexus posted, waiting...

Cheers,
Muli
