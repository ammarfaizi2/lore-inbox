Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbVCKVsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbVCKVsg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 16:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbVCKVrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 16:47:51 -0500
Received: from h151_115.u.wavenet.pl ([217.79.151.115]:24267 "EHLO
	alpha.polcom.net") by vger.kernel.org with ESMTP id S261496AbVCKVrA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 16:47:00 -0500
Date: Fri, 11 Mar 2005 22:47:43 +0100 (CET)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Andrew Morton <akpm@osdl.org>,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] Re: Fw: Anybody? 2.6.11 (stable and -rc) ACPI breaks USB
In-Reply-To: <1110574599.4822.54.camel@eeyore>
Message-ID: <Pine.LNX.4.62.0503112239580.25254@alpha.polcom.net>
References: <20050304234622.63e8a335.akpm@osdl.org> 
 <Pine.LNX.4.62.0503110006260.30687@alpha.polcom.net>  <1110559685.4822.15.camel@eeyore>
  <Pine.LNX.4.62.0503112009070.22293@alpha.polcom.net> <1110574599.4822.54.camel@eeyore>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Mar 2005, Bjorn Helgaas wrote:

> On Fri, 2005-03-11 at 20:36 +0100, Grzegorz Kulewski wrote:
>> On Fri, 11 Mar 2005, Bjorn Helgaas wrote:
>>> Can you check to see whether there are any BIOS updates available
>>> for your box?  It looks to me like your USB controllers are wired
>>> to IRQ9, and that's how the BIOS is leaving them configured.
>>
>> And if this is a BIOS issue then why it worked for 3 years with all
>> kernels up to at least 2.6.9
>
> Good point.
>
> Thanks for posting the 2.6.9 output as well.  It contains this:
>
>    ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
>    ACPI: PCI interrupt 0000:00:07.2[D] -> GSI 10 (level, low) -> IRQ 10
>    ACPI: PCI interrupt 0000:00:07.3[D] -> GSI 10 (level, low) -> IRQ 10
>    PCI: Via IRQ fixup for 0000:00:07.2, from 9 to 10
>    PCI: Via IRQ fixup for 0000:00:07.3, from 9 to 10
>
> In 2.6.9, we did all the ACPI IRQ routing early, then did the
> Via IRQ fixups.  In 2.6.11, ACPI IRQ routing is done only when
> a driver claims a device, and the Via IRQ fixup is done a little
> differently.  In fact, the Via fixup happens before we twiddle
> the IOAPIC, where in 2.6.9, it happened after.
>
> Can you try the attached patch to see whether it makes any
> difference?
>
> ===== drivers/acpi/pci_irq.c 1.37 vs edited =====
> --- 1.37/drivers/acpi/pci_irq.c	2005-03-01 09:57:29 -07:00
> +++ edited/drivers/acpi/pci_irq.c	2005-03-11 13:45:56 -07:00
> @@ -30,6 +30,7 @@
> #include <linux/module.h>
> #include <linux/init.h>
> #include <linux/types.h>
> +#include <linux/delay.h>
> #include <linux/proc_fs.h>
> #include <linux/spinlock.h>
> #include <linux/pm.h>
> @@ -438,10 +439,19 @@
> 		}
>  	}
>
> -	if (via_interrupt_line_quirk)
> -		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq & 15);
> -
> 	dev->irq = acpi_register_gsi(irq, edge_level, active_high_low);
> +
> +	if (via_interrupt_line_quirk) {
> +		u8 old_irq, new_irq = dev->irq & 0xf;
> +
> +		pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &old_irq);
> +		if (new_irq != old_irq) {
> +			printk(KERN_INFO PREFIX "Via IRQ fixup for %s, from %d "
> +				"to %d\n", pci_name(dev), old_irq, new_irq);
> +			udelay(15);
> +			pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
> +		}
> +	}
>
> 	printk(KERN_INFO PREFIX "PCI interrupt %s[%c] -> GSI %u "
> 		"(%s, %s) -> IRQ %d\n",

Unfortunatelly no. Here is the log:

Mar 11 23:47:44 kangur Linux version 2.6.11-cko1 (root@kangur) (gcc 
version 3.3.3 20040412 (Gentoo Linux 3.3.3-r6, ssp-3.3.2-2, pie-8.7.6)) #2 
Fri Mar 11 23:32:57 CET 2005
Mar 11 23:47:44 kangur BIOS-provided physical RAM map:
Mar 11 23:47:44 kangur BIOS-e820: 0000000000000000 - 000000000009fc00 
(usable)
Mar 11 23:47:44 kangur BIOS-e820: 000000000009fc00 - 00000000000a0000 
(reserved)
Mar 11 23:47:44 kangur BIOS-e820: 00000000000f0000 - 0000000000100000 
(reserved)
Mar 11 23:47:44 kangur BIOS-e820: 0000000000100000 - 000000001fff0000 
(usable)
Mar 11 23:47:44 kangur BIOS-e820: 000000001fff0000 - 000000001fff3000 
(ACPI NVS)
Mar 11 23:47:44 kangur BIOS-e820: 000000001fff3000 - 0000000020000000 
(ACPI data)
Mar 11 23:47:44 kangur BIOS-e820: 00000000ffff0000 - 0000000100000000 
(reserved)
Mar 11 23:47:44 kangur 511MB LOWMEM available.
Mar 11 23:47:44 kangur On node 0 totalpages: 131056
Mar 11 23:47:44 kangur DMA zone: 4096 pages, LIFO batch:1
Mar 11 23:47:44 kangur Normal zone: 126960 pages, LIFO batch:16
Mar 11 23:47:44 kangur HighMem zone: 0 pages, LIFO batch:1
Mar 11 23:47:44 kangur DMI 2.2 present.
Mar 11 23:47:44 kangur ACPI: RSDP (v000 761686 
) @ 0x000f6a70
Mar 11 23:47:44 kangur ACPI: RSDT (v001 761686 AWRDACPI 0x42302e31 AWRD 
0x00000000) @ 0x1fff3000
Mar 11 23:47:44 kangur ACPI: FADT (v001 761686 AWRDACPI 0x42302e31 AWRD 
0x00000000) @ 0x1fff3040
Mar 11 23:47:44 kangur ACPI: DSDT (v001 761686 AWRDACPI 0x00001000 MSFT 
0x0100000c) @ 0x00000000
Mar 11 23:47:44 kangur ACPI: PM-Timer IO Port: 0x4008
Mar 11 23:47:44 kangur Allocating PCI resources starting at 20000000 (gap: 
20000000:dfff0000)
Mar 11 23:47:44 kangur Built 1 zonelists
Mar 11 23:47:44 kangur Kernel command line: ro root=/dev/hdb4
Mar 11 23:47:44 kangur Local APIC disabled by BIOS -- you can enable it 
with "lapic"
Mar 11 23:47:44 kangur mapped APIC to ffffd000 (01402000)
Mar 11 23:47:44 kangur Initializing CPU#0
Mar 11 23:47:44 kangur CPU 0 irqstacks, hard=b0477000 soft=b0476000
Mar 11 23:47:44 kangur PID hash table entries: 2048 (order: 11, 32768 
bytes)
Mar 11 23:47:44 kangur Detected 1203.228 MHz processor.
Mar 11 23:47:44 kangur Using pmtmr for high-res timesource
Mar 11 23:47:44 kangur Console: colour VGA+ 80x25
Mar 11 23:47:44 kangur Dentry cache hash table entries: 131072 (order: 7, 
524288 bytes)
Mar 11 23:47:44 kangur Inode-cache hash table entries: 65536 (order: 6, 
262144 bytes)
Mar 11 23:47:44 kangur Memory: 514940k/524224k available (2543k kernel 
code, 8732k reserved, 819k data, 156k init, 0k highmem)
Mar 11 23:47:44 kangur Checking if this processor honours the WP bit even 
in supervisor mode... Ok.
Mar 11 23:47:44 kangur Calibrating delay loop... 2375.68 BogoMIPS 
(lpj=1187840)
Mar 11 23:47:44 kangur Security Framework v1.0.0 initialized
Mar 11 23:47:44 kangur Capability LSM initialized
Mar 11 23:47:44 kangur Mount-cache hash table entries: 512 (order: 0, 4096 
bytes)
Mar 11 23:47:44 kangur CPU: After generic identify, caps: 0383f9ff 
c1cbf9ff 00000000 00000000 00000000 00000000 00000000Mar 11 23:47:44 
kangur CPU: After vendor identify, caps: 0383f9ff c1cbf9ff 00000000 
00000000 00000000 00000000 00000000
Mar 11 23:47:44 kangur CPU: CLK_CTL MSR was 60071263. Reprogramming to 
20071263
Mar 11 23:47:44 kangur CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K 
(64 bytes/line)
Mar 11 23:47:44 kangur CPU: L2 Cache: 512K (64 bytes/line)
Mar 11 23:47:44 kangur CPU: After all inits, caps: 0383f9ff c1cbf9ff 
00000000 00000020 00000000 00000000 00000000
Mar 11 23:47:44 kangur Intel machine check architecture supported.
Mar 11 23:47:44 kangur Intel machine check reporting enabled on CPU#0.
Mar 11 23:47:44 kangur CPU: AMD Unknown CPU Type stepping 00
Mar 11 23:47:44 kangur Enabling fast FPU save and restore... done.
Mar 11 23:47:44 kangur Enabling unmasked SIMD FPU exception support... 
done.
Mar 11 23:47:44 kangur Checking 'hlt' instruction... OK.
Mar 11 23:47:44 kangur ACPI: setting ELCR to 0800 (from 0e20)
Mar 11 23:47:44 kangur NET: Registered protocol family 16
Mar 11 23:47:44 kangur PCI: PCI BIOS revision 2.10 entry at 0xfb690, last 
bus=1
Mar 11 23:47:44 kangur PCI: Using configuration type 1
Mar 11 23:47:44 kangur mtrr: v2.0 (20020519)
Mar 11 23:47:44 kangur ACPI: Subsystem revision 20050211
Mar 11 23:47:44 kangur ACPI: Interpreter enabled
Mar 11 23:47:44 kangur ACPI: Using PIC for interrupt routing
Mar 11 23:47:44 kangur ACPI: PCI Root Bridge [PCI0] (00:00)
Mar 11 23:47:44 kangur PCI: Probing PCI hardware (bus 00)
Mar 11 23:47:44 kangur ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Mar 11 23:47:44 kangur ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 
*10 11 12 14 15)
Mar 11 23:47:44 kangur ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 
10 *11 12 14 15)
Mar 11 23:47:44 kangur ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 *5 6 7 
10 11 12 14 15)
Mar 11 23:47:44 kangur ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 
10 11 12 14 15) *9
Mar 11 23:47:44 kangur Linux Plug and Play Support v0.97 (c) Adam Belay
Mar 11 23:47:44 kangur pnp: PnP ACPI init
Mar 11 23:47:44 kangur pnp: PnP ACPI: found 12 devices
Mar 11 23:47:44 kangur SCSI subsystem initialized
Mar 11 23:47:44 kangur PCI: Using ACPI for IRQ routing
Mar 11 23:47:44 kangur ** PCI interrupts are no longer routed 
automatically.  If this
Mar 11 23:47:44 kangur ** causes a device to stop working, it is probably 
because the
Mar 11 23:47:44 kangur ** driver failed to call pci_enable_device().  As a 
temporary
Mar 11 23:47:44 kangur ** workaround, the "pci=routeirq" argument restores 
the old
Mar 11 23:47:44 kangur ** behavior.  If this argument makes the device 
work again,
Mar 11 23:47:44 kangur ** please email the output of "lspci" to 
bjorn.helgaas@hp.com
Mar 11 23:47:44 kangur ** so I can fix the driver.
Mar 11 23:47:44 kangur pnp: the driver 'system' has been registered
Mar 11 23:47:44 kangur pnp: match found with the PnP device '00:00' and 
the driver 'system'
Mar 11 23:47:44 kangur pnp: match found with the PnP device '00:01' and 
the driver 'system'
Mar 11 23:47:44 kangur Total HugeTLB memory allocated, 0
Mar 11 23:47:44 kangur VFS: Disk quotas dquot_6.5.1
Mar 11 23:47:44 kangur Dquot-cache hash table entries: 1024 (order 0, 4096 
bytes)
Mar 11 23:47:44 kangur SGI XFS with ACLs, security attributes, realtime, 
no debug enabled
Mar 11 23:47:44 kangur SGI XFS Quota Management subsystem
Mar 11 23:47:44 kangur Initializing Cryptographic API
Mar 11 23:47:44 kangur inotify device minor=63
Mar 11 23:47:44 kangur ACPI: PS/2 Keyboard Controller [PS2K] at I/O 0x60, 
0x64, irq 1
Mar 11 23:47:44 kangur ACPI: PS/2 Mouse Controller [PS2M] at irq 12
Mar 11 23:47:44 kangur serio: i8042 AUX port at 0x60,0x64 irq 12
Mar 11 23:47:44 kangur serio: i8042 KBD port at 0x60,0x64 irq 1
Mar 11 23:47:44 kangur io scheduler noop registered
Mar 11 23:47:44 kangur io scheduler anticipatory registered
Mar 11 23:47:44 kangur io scheduler deadline registered
Mar 11 23:47:44 kangur io scheduler cfq registered
Mar 11 23:47:44 kangur 8139too Fast Ethernet driver 0.9.27
Mar 11 23:47:44 kangur ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
Mar 11 23:47:44 kangur PCI: setting IRQ 11 as level-triggered
Mar 11 23:47:44 kangur ACPI: PCI interrupt 0000:00:0f.0[A] -> GSI 11 
(level, low) -> IRQ 11
Mar 11 23:47:44 kangur eth0: RealTek RTL8139 at 0xec00, 00:06:4f:00:73:8b, 
IRQ 11
Mar 11 23:47:44 kangur eth0:  Identified 8139 chip type 'RTL-8139C'
Mar 11 23:47:44 kangur Uniform Multi-Platform E-IDE driver Revision: 
7.00alpha2
Mar 11 23:47:44 kangur ide: Assuming 33MHz system bus speed for PIO modes; 
override with idebus=xx
Mar 11 23:47:44 kangur VP_IDE: IDE controller at PCI slot 0000:00:07.1
Mar 11 23:47:44 kangur VP_IDE: chipset revision 6
Mar 11 23:47:44 kangur VP_IDE: not 100% native mode: will probe irqs later
Mar 11 23:47:44 kangur VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 
controller on pci0000:00:07.1
Mar 11 23:47:44 kangur ide0: BM-DMA at 0xc400-0xc407, BIOS settings: 
hda:pio, hdb:DMA
Mar 11 23:47:44 kangur ide1: BM-DMA at 0xc408-0xc40f, BIOS settings: 
hdc:pio, hdd:DMA
Mar 11 23:47:44 kangur Probing IDE interface ide0...
Mar 11 23:47:44 kangur hdb: SAMSUNG SV3063H, ATA DISK drive
Mar 11 23:47:44 kangur ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Mar 11 23:47:44 kangur Probing IDE interface ide1...
Mar 11 23:47:44 kangur hdd: HL-DT-ST DVDRAM GSA-4082B, ATAPI CD/DVD-ROM 
drive
Mar 11 23:47:44 kangur ide1 at 0x170-0x177,0x376 on irq 15
Mar 11 23:47:44 kangur pnp: the driver 'ide' has been registered
Mar 11 23:47:44 kangur hdb: max request size: 128KiB
Mar 11 23:47:44 kangur hdb: 59797584 sectors (30616 MB) w/426KiB Cache, 
CHS=59323/16/63, UDMA(100)
Mar 11 23:47:44 kangur hdb: cache flushes not supported
Mar 11 23:47:44 kangur hdb: hdb1 hdb2 hdb3 hdb4
Mar 11 23:47:44 kangur libata version 1.10 loaded.
Mar 11 23:47:44 kangur sata_sil version 0.8
Mar 11 23:47:44 kangur ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 11 
(level, low) -> IRQ 11
Mar 11 23:47:44 kangur ata1: SATA max UDMA/100 cmd 0xD0802080 ctl 
0xD080208A bmdma 0xD0802000 irq 11
Mar 11 23:47:44 kangur ata2: SATA max UDMA/100 cmd 0xD08020C0 ctl 
0xD08020CA bmdma 0xD0802008 irq 11
Mar 11 23:47:44 kangur ata1: dev 0 cfg 49:2f00 82:346b 83:7f61 84:4003 
85:3469 86:3c41 87:4003 88:207f
Mar 11 23:47:44 kangur ata1: dev 0 ATA, max UDMA/133, 312581808 sectors: 
lba48
Mar 11 23:47:44 kangur ata1: dev 0 configured for UDMA/100
Mar 11 23:47:44 kangur scsi0 : sata_sil
Mar 11 23:47:44 kangur ata2: no device found (phy stat 00000000)
Mar 11 23:47:44 kangur scsi1 : sata_sil
Mar 11 23:47:44 kangur Vendor: ATA       Model: WDC WD1600JD-00H  Rev: 
08.0
Mar 11 23:47:44 kangur Type:   Direct-Access                      ANSI 
SCSI revision: 05
Mar 11 23:47:44 kangur SCSI device sda: 312581808 512-byte hdwr sectors 
(160042 MB)
Mar 11 23:47:44 kangur SCSI device sda: drive cache: write back
Mar 11 23:47:44 kangur SCSI device sda: 312581808 512-byte hdwr sectors 
(160042 MB)
Mar 11 23:47:44 kangur SCSI device sda: drive cache: write back
Mar 11 23:47:44 kangur sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 
sda10 sda11 sda12 sda13 sda14 sda15 >
Mar 11 23:47:44 kangur Attached scsi disk sda at scsi0, channel 0, id 0, 
lun 0
Mar 11 23:47:44 kangur mice: PS/2 mouse device common for all mice
Mar 11 23:47:44 kangur input: AT Translated Set 2 keyboard on 
isa0060/serio0
Mar 11 23:47:44 kangur NET: Registered protocol family 2
Mar 11 23:47:44 kangur IP: routing cache hash table of 4096 buckets, 
32Kbytes
Mar 11 23:47:44 kangur TCP established hash table entries: 32768 (order: 
6, 262144 bytes)
Mar 11 23:47:44 kangur TCP bind hash table entries: 32768 (order: 5, 
131072 bytes)
Mar 11 23:47:44 kangur TCP: Hash tables configured (established 32768 bind 
32768)
Mar 11 23:47:44 kangur ip_conntrack version 2.1 (4095 buckets, 32760 max) 
- 216 bytes per conntrack
Mar 11 23:47:44 kangur ip_tables: (C) 2000-2002 Netfilter core team
Mar 11 23:47:44 kangur ipt_recent v0.3.1: Stephen Frost 
<sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
Mar 11 23:47:44 kangur arp_tables: (C) 2002 David S. Miller
Mar 11 23:47:44 kangur NET: Registered protocol family 17
Mar 11 23:47:44 kangur ACPI wakeup devices:
Mar 11 23:47:44 kangur SLPB PCI0 USB0 USB1
Mar 11 23:47:44 kangur ACPI: (supports S0 S1 S4 S5)
Mar 11 23:47:44 kangur kjournald starting.  Commit interval 5 seconds
Mar 11 23:47:44 kangur EXT3-fs: mounted filesystem with ordered data mode.
Mar 11 23:47:44 kangur VFS: Mounted root (ext3 filesystem) readonly.
Mar 11 23:47:44 kangur Freeing unused kernel memory: 156k freed
Mar 11 23:47:44 kangur NET: Registered protocol family 1
Mar 11 23:47:44 kangur EXT3 FS on hdb4, internal journal
Mar 11 23:47:44 kangur NET: Registered protocol family 8
Mar 11 23:47:44 kangur NET: Registered protocol family 20
Mar 11 23:47:44 kangur CSLIP: code copyright 1989 Regents of the 
University of California
Mar 11 23:47:44 kangur PPP generic driver version 2.4.2
Mar 11 23:47:44 kangur input: PS/2 Generic Mouse on isa0060/serio1
Mar 11 23:47:44 kangur input: PC Speaker
Mar 11 23:47:44 kangur loop: loaded (max 8 devices)
Mar 11 23:47:44 kangur Non-volatile memory driver v1.2
Mar 11 23:47:44 kangur BIOS EDD facility v0.16 2004-Jun-25, 2 devices 
found
Mar 11 23:47:44 kangur vesafb: NVidia Corporation, NV15 Reference Board, 
Chip Rev A0 (OEM: NVidia)
Mar 11 23:47:44 kangur vesafb: VBE version: 3.0
Mar 11 23:47:44 kangur vesafb: protected mode interface info at c000:0f03
Mar 11 23:47:44 kangur vesafb: pmi: set display start = b00c0f3c, set 
palette = b00c0fb2
Mar 11 23:47:44 kangur vesafb: pmi: ports = 3b4 3b5 3ba 3c0 3c1 3c4 3c5 
3c6 3c7 3c8 3c9 3cc 3ce 3cf 3d0 3d1 3d2 3d3 3d4 3d5 3da
Mar 11 23:47:44 kangur vesafb: hardware supports DCC2 transfers
Mar 11 23:47:44 kangur vesafb: monitor limits: vf = 85 Hz, hf = 64 kHz, 
clk = 108 MHz
Mar 11 23:47:44 kangur vesafb: scrolling: redraw
Mar 11 23:47:44 kangur vesafb: framebuffer at 0xe8000000, mapped to 
0xd0900000, using 6144k, total 65536k
Mar 11 23:47:44 kangur fb0: VESA VGA frame buffer device
Mar 11 23:47:44 kangur Console: switching to colour frame buffer device 
128x48
Mar 11 23:47:44 kangur device-mapper: 4.4.0-ioctl (2005-01-12) 
initialised: dm-devel@redhat.com
Mar 11 23:47:44 kangur NTFS driver 2.1.22 [Flags: R/O MODULE].
Mar 11 23:47:44 kangur NTFS volume version 3.1.
Mar 11 23:47:44 kangur NTFS volume version 3.1.
Mar 11 23:47:44 kangur usbcore: registered new driver usbfs
Mar 11 23:47:44 kangur usbcore: registered new driver hub
Mar 11 23:47:44 kangur ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
Mar 11 23:47:44 kangur PCI: setting IRQ 10 as level-triggered
Mar 11 23:47:44 kangur ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 10 
(level, low) -> IRQ 10
Mar 11 23:47:44 kangur parport_pc: VIA 686A/8231 detected
Mar 11 23:47:44 kangur parport_pc: probing current configuration
Mar 11 23:47:44 kangur parport_pc: Current parallel port base: 0x378
Mar 11 23:47:44 kangur parport_pc: Strange, can't probe VIA parallel port: 
io=0x378, irq=7, dma=-1
Mar 11 23:47:44 kangur pnp: the driver 'parport_pc' has been registered
Mar 11 23:47:44 kangur pnp: match found with the PnP device '00:09' and 
the driver 'parport_pc'
Mar 11 23:47:44 kangur parport: PnPBIOS parport detected.
Mar 11 23:47:44 kangur parport0: PC-style at 0x378, irq 7 [PCSPP(,...)]
Mar 11 23:47:44 kangur USB Universal Host Controller Interface driver v2.2
Mar 11 23:47:44 kangur ACPI: PCI interrupt 0000:00:07.2[D] -> GSI 10 
(level, low) -> IRQ 10
Mar 11 23:47:44 kangur uhci_hcd 0000:00:07.2: UHCI Host Controller
Mar 11 23:47:44 kangur uhci_hcd 0000:00:07.2: irq 10, io base 0xc800
Mar 11 23:47:44 kangur uhci_hcd 0000:00:07.2: new USB bus registered, 
assigned bus number 1
Mar 11 23:47:44 kangur hub 1-0:1.0: USB hub found
Mar 11 23:47:44 kangur hub 1-0:1.0: 2 ports detected
Mar 11 23:47:44 kangur ACPI: PCI interrupt 0000:00:07.3[D] -> GSI 10 
(level, low) -> IRQ 10
Mar 11 23:47:44 kangur uhci_hcd 0000:00:07.3: UHCI Host Controller
Mar 11 23:47:44 kangur uhci_hcd 0000:00:07.3: irq 10, io base 0xcc00
Mar 11 23:47:44 kangur uhci_hcd 0000:00:07.3: new USB bus registered, 
assigned bus number 2
Mar 11 23:47:44 kangur hub 2-0:1.0: USB hub found
Mar 11 23:47:44 kangur hub 2-0:1.0: 2 ports detected
Mar 11 23:47:44 kangur usb 1-2: new full speed USB device using uhci_hcd 
and address 2
Mar 11 23:47:44 kangur Linux video capture interface: v1.00
Mar 11 23:47:44 kangur bttv: driver version 0.9.15 loaded
Mar 11 23:47:44 kangur bttv: using 32 buffers with 2080k (520 pages) each 
for capture
Mar 11 23:47:44 kangur bttv: Bt8xx card found (0).
Mar 11 23:47:44 kangur ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
Mar 11 23:47:44 kangur PCI: setting IRQ 5 as level-triggered
Mar 11 23:47:44 kangur ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 5 
(level, low) -> IRQ 5
Mar 11 23:47:44 kangur bttv0: Bt878 (rev 17) at 0000:00:09.0, irq: 5, 
latency: 32, mmio: 0xf7000000
Mar 11 23:47:44 kangur bttv0: using: Prolink Pixelview PV-BT878P+ 
(Rev.4C,8E) [card=70,insmod option]
Mar 11 23:47:44 kangur bttv0: gpio: en=00000000, out=00000000 in=00ffc0ff 
[init]
Mar 11 23:47:44 kangur bttv0: using tuner=25
Mar 11 23:47:44 kangur bttv0: i2c: checking for MSP34xx @ 0x80... not 
found
Mar 11 23:47:44 kangur bttv0: i2c: checking for TDA9875 @ 0xb0... not 
found
Mar 11 23:47:44 kangur bttv0: i2c: checking for TDA7432 @ 0x8a... not 
found
Mar 11 23:47:44 kangur tvaudio: TV audio decoder + audio/video mux driver
Mar 11 23:47:44 kangur tvaudio: known chips: 
tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6320,tea6420,tda8425,pic16c54 
(PV951),ta8874z
Mar 11 23:47:44 kangur bttv0: i2c: checking for TDA9887 @ 0x86... not 
found
Mar 11 23:47:44 kangur tuner 0-0061: chip found @ 0xc2 (bt878 #0 [sw])
Mar 11 23:47:44 kangur tuner 0-0061: type set to 25 (LG PAL_I+FM 
(TAPC-I001D))
Mar 11 23:47:44 kangur bttv0: registered device video0
Mar 11 23:47:44 kangur bttv0: registered device vbi0
Mar 11 23:47:44 kangur bttv0: registered device radio0
Mar 11 23:47:44 kangur bttv0: PLL: 28636363 => 35468950 .. ok
Mar 11 23:47:44 kangur bttv0: add subdevice "remote0"
Mar 11 23:47:44 kangur uhci_hcd 0000:00:07.2: Unlink after no-IRQ? 
Controller is probably using the wrong IRQ.
Mar 11 23:47:44 kangur usb 1-2: khubd timed out on ep0in
Mar 11 23:47:44 kangur gameport: pci0000:00:0b.1 speed 1242 kHz
Mar 11 23:47:44 kangur nvidia: module license 'NVIDIA' taints kernel.
Mar 11 23:47:44 kangur ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
Mar 11 23:47:44 kangur ACPI: PCI interrupt 0000:01:05.0[A] -> GSI 10 
(level, low) -> IRQ 10
Mar 11 23:47:44 kangur NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module 
1.0-6629  Wed Nov  3 13:12:51 PST 2004
Mar 11 23:47:44 kangur Real Time Clock Driver v1.12
Mar 11 23:47:44 kangur Floppy drive(s): fd0 is 1.44M
Mar 11 23:47:44 kangur FDC 0 is a post-1991 82077
Mar 11 23:47:44 kangur Serial: 8250/16550 driver $Revision: 1.90 $ 8 
ports, IRQ sharing disabled
Mar 11 23:47:44 kangur ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Mar 11 23:47:44 kangur ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Mar 11 23:47:44 kangur pnp: the driver 'serial' has been registered
Mar 11 23:47:44 kangur pnp: match found with the PnP device '00:07' and 
the driver 'serial'
Mar 11 23:47:44 kangur ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Mar 11 23:47:44 kangur pnp: match found with the PnP device '00:08' and 
the driver 'serial'
Mar 11 23:47:44 kangur ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Mar 11 23:47:44 kangur usb 1-2: khubd timed out on ep0out
Mar 11 23:47:45 kangur eth0: link down
Mar 11 23:47:46 kangur eth0: link down
Mar 11 23:47:47 kangur NET: Registered protocol family 10
Mar 11 23:47:47 kangur Disabled Privacy Extensions on device b03e7aa0(lo)
Mar 11 23:47:47 kangur IPv6 over IPv4 tunneling driver


Also two more questions:

1. What is VIA fixup? Is it some hardware bug? Or BIOS problem? Why is it 
needed? On what hardware / software it is needed?

2. Why this patch shrinked bzImage that much:

-rw-r--r--  1 root root 1828186 mar 11 23:33 vmlinuz-2.6.11-cko1
-rw-r--r--  1 root root 1828355 mar  2 20:48 vmlinuz-2.6.11-cko1.old


What is your next guess?


Thanks,

Grzegorz Kulewski
