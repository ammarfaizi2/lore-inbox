Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbULELw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbULELw5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 06:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbULELw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 06:52:57 -0500
Received: from CPE-203-51-26-41.nsw.bigpond.net.au ([203.51.26.41]:17142 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP id S261292AbULELwR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 06:52:17 -0500
Message-ID: <41B2F651.5030803@eyal.emu.id.au>
Date: Sun, 05 Dec 2004 22:51:45 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Cal Peake <cp@absolutedigital.net>
CC: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.10-rc3 oops when 'modprobe -r dvb-bt8xx'
References: <Pine.LNX.4.58.0412031611460.22796@ppc970.osdl.org> <41B1BD24.4050603@eyal.emu.id.au> <Pine.LNX.4.61.0412050455440.27512@linaeum.absolutedigital.net>
In-Reply-To: <Pine.LNX.4.61.0412050455440.27512@linaeum.absolutedigital.net>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cal Peake wrote:
> On Sun, 5 Dec 2004, Eyal Lebedinsky wrote:
> 
> 
>>In the spirit of festive testing I would like to say that the oops that I
>>enjoyed throughout rc2-bk* is still present in -rc3. -mm series does not
>>have this problem.
>>
>>EIP is at bttv_i2c_info+0x36/0x6a [bttv]
> 
> 
> Hi Eyal,
> 
>>From what I can tell the oops comes from the above function calling 
> dvb_bt8xx_i2c_info after the module that holds it (dvb-bt8xx) gets 
> unloaded. The dvb_bt8xx... function has been removed from rc2-mm4 so 
> that's prolly why you don't get the oops in the -mm kernels.
> 
> Until the changes propagate from -mm to Linus' tree the below patch should 
> take care of it.
> 
> -- Cal
> 
> Signed-off-by: Cal Peake <cp@absolutedigital.net>
> 
> --- linux-2.6.10-rc3/drivers/media/dvb/bt8xx/dvb-bt8xx.c.orig	2004-12-05 02:19:58.000000000 -0500
> +++ linux-2.6.10-rc3/drivers/media/dvb/bt8xx/dvb-bt8xx.c	2004-12-05 05:11:14.000000000 -0500
> @@ -331,24 +331,6 @@
>  	return 0;
>  	}
>  
> -static void dvb_bt8xx_i2c_info(struct bttv_sub_device *sub,
> -			       struct i2c_client *client, int attach)
> -{
> -	struct dvb_bt8xx_card *card = dev_get_drvdata(&sub->dev);
> -
> -	if (attach) {
> -		printk("xxx attach\n");
> -		if (client->driver->command)
> -			client->driver->command(client, FE_REGISTER,
> -						card->dvb_adapter);
> -	} else {
> -		printk("xxx detach\n");
> -		if (client->driver->command)
> -			client->driver->command(client, FE_UNREGISTER,
> -						card->dvb_adapter);
> -	}
> -}
> -
>  static struct bttv_sub_driver driver = {
>  	.drv = {
>  		.name		= "dvb-bt8xx",
> @@ -360,7 +342,6 @@
>  		 * .resume	= dvb_bt8xx_resume,
>  		 */
>  	},
> -	.i2c_info = dvb_bt8xx_i2c_info,
>  };
>  
>  static int __init dvb_bt8xx_init(void)

Not good. My rc.boot/local has this line
	modprobe dvb_bt8xx
	modprobe v4l1-compat
	modprobe sp887x
	modprobe mt352

and this now seems to generate an oops (see end of boot log).


Restarting system.
Linux version 2.6.10-rc3 (root@e7) (gcc version 3.3.4 (Debian 1:3.3.4-13)) #1 SMP Sat Dec 4 22:39:19 EST 2004
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
  BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
  BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f5200
DMI 2.3 present.
ACPI: PM-Timer IO Port: 0x1008
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] disabled)
ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Kernel command line: BOOT_IMAGE=2.6.10-rc3 ro root=306 console=ttyS0,38400 console=tty0 single
Initializing CPU#0
CPU 0 irqstacks, hard=c040c000 soft=c0404000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 3015.508 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x50
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1035104k/1048512k available (1747k kernel code, 12832k reserved, 1024k data, 292k init, 131008k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Hyper-Threading is disabled
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 09
per-CPU timeslice cutoff: 1462.69 usecs.
task migration cache decay timeout: 2 msecs.
Total of 1 processors activated (5980.16 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
Brought up 1 CPUs
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xfb500, last bus=3
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20041105
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 15 devices
PnPBIOS: Disabled by ACPI
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
Machine check exception polling timer started.
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
vesafb: probe of vesafb0 failed with error -6
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 14 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC WD1200BB-00DWA0, ATA DISK drive
elevator: using anticipatory as default io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: ATAPI DVD RW 8XMax, ATAPI CD/DVD-ROM drive
hdd: Pioneer DVD-ROM ATAPIModel DVD-115 0122, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
  /dev/ide/host0/bus0/target0/lun0: p2 p3 p4 < p5 p6 p7 >
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
EISA: Probing bus 0 at eisa0
Cannot allocate resource for EISA slot 1
EISA: Detected 0 cards.
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
ACPI wakeup devices:
SLPB PCI0 CSAD HUB0 USB0 USB1 USB2 USB3 USBE
ACPI: (supports S0 S1 S4 S5)
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 292k freed
NET: Registered protocol family 1
Adding 2097140k swap on /dev/hda5.  Priority:1 extents:1
Real Time Clock Driver v1.12
device-mapper: 4.3.0-ioctl (2004-09-30) initialised: dm-devel@redhat.com
parport_pc: Unknown parameter `io'
parport_pc: Ignoring new-style parameters in presence of obsolete ones
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 865 Chipset.
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: AGP aperture is 128M @ 0xd0000000
cpci_hotplug: CompactPCI Hot Plug Core version: 0.2
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
pciehp: add_host_bridge: status 5
pciehp: Fails to gain control of native hot-plug
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
pciehp: add_host_bridge: status 5
pciehp: Fails to gain control of native hot-plug
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1d.0: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1
uhci_hcd 0000:00:1d.0: irq 16, io base 0xbc00
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
uhci_hcd 0000:00:1d.1: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2
uhci_hcd 0000:00:1d.1: irq 19, io base 0xb000
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
uhci_hcd 0000:00:1d.2: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3
uhci_hcd 0000:00:1d.2: irq 18, io base 0xb400
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1d.3: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #4
uhci_hcd 0000:00:1d.3: irq 16, io base 0xb800
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:1d.7: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller
ehci_hcd 0000:00:1d.7: irq 23, pci mem 0xde100000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 26 Oct 2004
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
hw_random: RNG not detected
pciehp: add_host_bridge: status 5
pciehp: Fails to gain control of native hot-plug
Found: SST 49LF004B
ichxrom @fff00000: Found 1 x8 devices at 0x0 in 8-bit bank
using fwh lock/unlock method
number of JEDEC chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
Found: SST 49LF004B
ichxrom @fff80000: Found 1 x8 devices at 0x0 in 8-bit bank
using fwh lock/unlock method
number of JEDEC chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
Intel 810 + AC97 Audio, version 1.01, 23:14:48 Dec  4 2004
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17
i810: Intel ICH5 found at IO 0xdc00 and 0xd800, MEM 0xde101000 and 0xde102000, IRQ 17
i810: Intel ICH5 mmio at 0xf89aa000 and 0xf8a08000
i810_audio: Primary codec has ID 2
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
i810_audio: Connection 0 with codec id 2
ac97_codec: AC97 Audio codec, id: ALG128 (Unknown)
i810_audio: AC'97 codec 2 Unable to map surround DAC's (or DAC's not present), total channels = 2
Intel(R) PRO/1000 Network Driver - version 5.5.4-k2
Copyright (c) 1999-2004 Intel Corporation.
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 18 (level, low) -> IRQ 18
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
Linux video capture interface: v1.00
bttv: driver version 0.9.15 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
ACPI: PCI interrupt 0000:03:01.0[A] -> GSI 21 (level, low) -> IRQ 21
bttv0: Bt848 (rev 18) at 0000:03:01.0, irq: 21, latency: 32, mmio: 0xde000000
bttv0: using: STB, Gateway P/N 6000699 (bt848) [card=3,insmod option]
bttv0: gpio config override: mask=0x7, mux=0x1,0x0,0x2,0x3,0x4
tuner: chip found at addr 0xc0 i2c-bus bt848 #0 [sw]
tuner: type set to 5 (Philips PAL_BG (FI1216 and compatibles)) by insmod option
tuner: The type=<n> insmod option will go away soon.
tuner: Please use the tuner=<n> option provided by
tuner: tv aard core driver (bttv, saa7134, ...) instead.
bttv0: using tuner=2
tuner: type already set to 5, ignoring request for 2
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: registered device radio0
bttv0: PLL can sleep, using XTAL (35468950).
bttv: Bt8xx card found (1).
ACPI: PCI interrupt 0000:03:02.0[A] -> GSI 22 (level, low) -> IRQ 22
bttv1: Bt878 (rev 17) at 0000:03:02.0, irq: 22, latency: 32, mmio: 0xde001000
bttv1: detected: AVermedia DVB-T 771 [card=123], PCI subsystem ID is 1461:0771
bttv1: using: AVerMedia AVerTV DVB-T 771 [card=123,autodetected]
bttv1: gpio config override: mask=0x7, mux=0x1,0x0,0x2,0x3,0x4
bttv1: using tuner=4
bttv1: registered device video1
bttv1: registered device vbi1
bttv1: PLL: 28636363 => 35468950 .. ok
bttv1: add subdevice "remote1"
bttv1: add subdevice "dvb1"
bttv: Bt8xx card found (2).
ACPI: PCI interrupt 0000:03:03.0[A] -> GSI 16 (level, low) -> IRQ 16
bttv2: Bt878 (rev 17) at 0000:03:03.0, irq: 16, latency: 32, mmio: 0xde003000
bttv2: detected: AverMedia AverTV DVB-T [card=124], PCI subsystem ID is 1461:0761
bttv2: using: AverMedia AverTV DVB-T 761 [card=124,autodetected]
bttv2: gpio config override: mask=0x7, mux=0x1,0x0,0x2,0x3,0x4
bttv2: using tuner=-1
bttv2: registered device video2
bttv2: registered device vbi2
bttv2: PLL: 28636363 => 35468950 .. ok
bttv2: add subdevice "remote2"
bttv2: add subdevice "dvb2"
bt878: AUDIO driver version 0.0.0 loaded
bt878: Bt878 AUDIO function found (0).
ACPI: PCI interrupt 0000:03:02.1[A] -> GSI 22 (level, low) -> IRQ 22
bt878(0): Bt878 (rev 17) at 03:02.1, irq: 22, latency: 32, memory: 0xde002000
bt878: Bt878 AUDIO function found (1).
ACPI: PCI interrupt 0000:03:03.1[A] -> GSI 16 (level, low) -> IRQ 16
bt878(1): Bt878 (rev 17) at 03:03.1, irq: 16, latency: 32, memory: 0xde004000
btaudio: driver version 0.7 loaded [digital+analog]
SCSI subsystem initialized
dc395x: Tekram DC395(U/UW/F), DC315(U) - ASIC TRM-S1040 v2.05, 2004/03/08
ACPI: PCI interrupt 0000:03:04.0[A] -> GSI 18 (level, low) -> IRQ 18
dc395x: Used settings: AdapterID=07, Speed=0(20.0MHz), dev_mode=0x57
dc395x:                AdaptMode=0x0f, Tags=4(16), DelayReset=1s
dc395x: Connectors: ext50  Termination: Auto Low High
dc395x: Performing initial SCSI bus reset
scsi0 : Tekram DC395(U/UW/F), DC315(U) - ASIC TRM-S1040 v2.05, 2004/03/08
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
ACPI: PCI interrupt 0000:03:05.0[A] -> GSI 21 (level, low) -> IRQ 21
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[21]  MMIO=[dd004000-dd0047ff]  Max Packet=[2048]
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
eth1394: $Rev: 1224 $ Ben Collins <bcollins@debian.org>
eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
ide-cd: ignoring drive hdc
hdd: ATAPI 40X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX as device
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
   Vendor: ATAPI     Model: DVD RW 8XMax      Rev: 130D
   Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi generic sg0 at scsi1, channel 0, id 0, lun 0,  type 5
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Intel 810 + AC97 Audio, version 1.01, 23:14:48 Dec  4 2004
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17
i810: Intel ICH5 found at IO 0xdc00 and 0xd800, MEM 0xde101000 and 0xde102000, IRQ 17
i810: Intel ICH5 mmio at 0xf8a08000 and 0xf8a4e000
i810_audio: Primary codec has ID 2
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
i810_audio: Connection 0 with codec id 2
ac97_codec: AC97 Audio codec, id: ALG128 (Unknown)
i810_audio: AC'97 codec 2 Unable to map surround DAC's (or DAC's not present), total channels = 2
DVB: registering new adapter (bttv1).
DVB: registering new adapter (bttv2).
sp887x: waiting for firmware upload...
i2c_adapter i2c-3: sendbytes: error - bailout.
sp887x_initial_setup: firmware upload... done.
Unable to handle kernel paging request at virtual address 6332692f
  printing eip:
f91bbcba
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP
Modules linked in: sp887x v4l1_compat dvb_bt8xx dvb_core i810_audio ac97_codec sr_mod sg ide_scsi ide_cd cdrom it87 eeprom i2c_isa i2c_i801 i2c_sensor eth1394 ohci_hcd ohci1394 ieee1394 dc395x scsi_mod snd_bt87x bt878 bttv tuner video_buf firmware_class i2c_algo_bit v4l2_common btcx_risc videodev e1000 snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd snd_page_alloc soundcore i2c_core cfi_cmdset_0002 cfi_util mtdpart jedec_probe cfi_probe gen_probe ichxrom mtdcore chipreg map_funcs ehci_hcd uhci_hcd usbcore shpchp pci_hotplug intel_mch_agp intel_agp agpgart parport_pc parport evdev nls_cp437 msdos fat dm_mod rtc unix
CPU:    0
EIP:    0060:[<f91bbcba>]    Not tainted VLI
EFLAGS: 00010246   (2.6.10-rc3)
EIP is at dvb_register_frontend+0x1cd/0x28c [dvb_core]
eax: 6332692f   ebx: f778e800   ecx: 00000000   edx: f91c7590
esi: 6332692f   edi: f778ea20   ebp: f90e4200   esp: f76e4f24
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 4709, threadinfo=f76e4000 task=f786c020)
Stack: c1920a80 000000d0 f90e4200 00000000 00000000 00000000 f7708600 00000000
        f7708618 f772d4e0 f90e2f2d f90e2b5e 6332692f f772d4e0 f90e4200 f90e4500
        f77733a0 00000070 00000000 00000000 f90e42c4 f9066d14 f90e42c0 00000000
Call Trace:
  [<f90e2f2d>] attach_adapter+0x12e/0x1c3 [sp887x]
  [<f90e2b5e>] sp887x_ioctl+0x0/0x2a1 [sp887x]
  [<f8a20549>] i2c_add_driver+0x8f/0xb5 [i2c_core]
  [<f8ff100f>] init_sp887x+0xf/0x13 [sp887x]
  [<c0135379>] sys_init_module+0x16f/0x21e
  [<c010308b>] syscall_call+0x7/0xb
Code: 75 e7 8b 15 94 75 1c f9 8d 83 d0 01 00 00 c7 83 d0 01 00 00 90 75 1c f9 a3 94 75 1c f9 89 02 89 50 04 8b 03 89 44 24 08 8b 43 14 <8b> 00 c7 04 24 a0 03 1c f9 89 44 24 04 e8 16 17 f6 c6 8d 43 24
  <0>Restarting system.

-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
	If attaching .zip rename to .dat
