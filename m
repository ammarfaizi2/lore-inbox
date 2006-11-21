Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934339AbWKUGW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934339AbWKUGW0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 01:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934340AbWKUGW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 01:22:26 -0500
Received: from tapsys.com ([72.36.178.242]:35268 "EHLO tapsys.com")
	by vger.kernel.org with ESMTP id S934339AbWKUGWY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 01:22:24 -0500
Message-ID: <45629AE3.5030908@madrabbit.org>
Date: Mon, 20 Nov 2006 22:21:23 -0800
From: Ray Lee <ray-lk@madrabbit.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Cc: Larry Finger <Larry.Finger@lwfinger.net>,
       Johannes Berg <johannes@sipsolutions.net>,
       Joseph Fannin <jhf@columbus.rr.com>, Andrew Morton <akpm@osdl.org>,
       netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
       John Linville <linville@tuxdriver.com>, Michael Buesch <mb@bu3sch.de>,
       Bcm43xx-dev@lists.berlios.de
Subject: Re: bcm43xx regression 2.6.19rc3 -> rc5, rtnl_lock trouble?
References: <455B63EC.8070704@madrabbit.org> <20061118112438.GB15349@nineveh.rivenstone.net> <1163868955.27188.2.camel@johannes.berg> <455F3D44.4010502@lwfinger.net> <455F4271.1060405@madrabbit.org> <20061118183001.GY31879@stusta.de>
In-Reply-To: <20061118183001.GY31879@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
>> That said, /proc/interrupts doesn't show MSI routed things on my AMD64 laptop.
>> ...
> 
> If there is any interrupt related problem involved, it should be visible 
> from dmesg.

This was useful, thanks. There were other differences I should have looked at.
I'd added noapic to rc5 to avoid problems you'll see in rc3's boot log below.

> Can you send the complete dmesg's from -rc3, -rc5 and -rc6?

I don't have rc6 compiled yet (sorry -- didn't want that to hold me up any
longer on this message), but pulling dmesg from boot logs of rc3 versus rc5,
the diff is shows that one had the apic enabled, the other didn't. So the
interrupt routing did change, with rc5 (the problematic kernel) having the
apic disabled.

There's still debate over whether this is a locking problem or something else,
so the following may just send everyone off the wrong direction.

In the meantime, I'm offline for travel through Tuesday evening.

--- rc3-diffable	2006-11-20 21:53:50.000000000 -0800
+++ rc5-diffable	2006-11-20 21:53:43.000000000 -0800
@@ -1,10 +1,10 @@
  restart.
- Inspecting /boot/System.map-2.6.19-rc3
- Loaded 25288 symbols from /boot/System.map-2.6.19-rc3.
+ Inspecting /boot/System.map-2.6.19-rc5
+ Loaded 25298 symbols from /boot/System.map-2.6.19-rc5.
  Symbols match kernel version 2.6.19.
  No module symbols loaded - kernel modules not enabled.
- Linux version 2.6.19-rc3 (ray@phoenix) (gcc version 4.1.2 20060928
(prerelease) (Ubuntu 4.1.1-13ubuntu5)) #3 PREEMPT Sat Oct 28 13:50:27 PDT 2006
- Command line: root=UUID=bf7dc35f-5eff-4a85-b398-590f37c5679e ro quiet splash
+ Linux version 2.6.19-rc5 (ray@phoenix) (gcc version 4.1.2 20060928
(prerelease) (Ubuntu 4.1.1-13ubuntu5)) #1 PREEMPT Thu Nov 9 21:25:32 PST 2006
+ Command line: root=UUID=bf7dc35f-5eff-4a85-b398-590f37c5679e ro noapic
  BIOS-provided physical RAM map:
   BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
   BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
@@ -32,24 +32,21 @@
  ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
  Processor #0 (Bootup-CPU)
  ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
- ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
- IOAPIC[0]: apic_id 1, address 0xfec00000, GSI 0-23
- ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
- ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 21 low level)
- Setting APIC routing to flat
- Using ACPI (MADT) for SMP configuration information
+ ACPI: Skipping IOAPIC probe due to 'noapic' option.
+ arch/x86_64/mm/init.c:145: bad pte ffff810001c58fe8(80000000fec01173).
  Nosave address range: 000000000009f000 - 00000000000a0000
  Nosave address range: 00000000000a0000 - 00000000000e0000
  Nosave address range: 00000000000e0000 - 0000000000100000
  Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
- Built 1 zonelists.  Total pages: 224075
- Kernel command line: root=UUID=bf7dc35f-5eff-4a85-b398-590f37c5679e ro quiet
splash
+ Built 1 zonelists.  Total pages: 224073
+ Kernel command line: root=UUID=bf7dc35f-5eff-4a85-b398-590f37c5679e ro noapic
  Initializing CPU#0
  PID hash table entries: 4096 (order: 12, 32768 bytes)
  time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
- time.c: Detected 2194.547 MHz processor.
+ time.c: Detected 2194.622 MHz processor.
  Console: colour VGA+ 80x25
  Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
+ 1.6.9 accepting connections at 2208...
  ... MAX_LOCKDEP_SUBCLASSES:    8
  ... MAX_LOCK_DEPTH:          30
  ... MAX_LOCKDEP_KEYS:        2048
@@ -62,11 +59,11 @@
  Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
  Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
  Checking aperture...
- CPU 0: aperture @ 838c000000 size 32 MB
+ CPU 0: aperture @ c048000000 size 32 MB
  Aperture too small (32 MB)
  No AGP bridge found
- Memory: 887264k/917312k available (2275k kernel code, 29428k reserved, 1621k
data, 200k init)
- Calibrating delay using timer specific routine.. 4392.30 BogoMIPS (lpj=2196151)
+ Memory: 887256k/917312k available (2278k kernel code, 29436k reserved, 1623k
data, 200k init)
+ Calibrating delay using timer specific routine.. 4392.21 BogoMIPS (lpj=2196106)
  Security Framework v1.0.0 initialized
  SELinux:  Disabled at boot.
  Mount-cache hash table entries: 256
@@ -79,12 +76,13 @@
  Table [DSDT](id 0006) - 953 Objects with 106 Devices 297 Methods 26 Regions
  Parsing all Control Methods:
  Table [SSDT](id 0004) - 8 Objects with 0 Devices 6 Methods 0 Regions
- ACPI Namespace successfully loaded at root ffffffff809be7c0
+ ACPI Namespace successfully loaded at root ffffffff809c07c0
+ ACPI: setting ELCR to 0200 (from 0e20)
  evxfevnt-0089 [02] enable                : Transition to ACPI mode successful
  Using local APIC timer interrupts.
- result 12469039
- Detected 12.469 MHz APIC timer.
- testing NMI watchdog ... OK.
+ result 0
+ Detected 0.000 MHz APIC timer.
+ testing NMI watchdog ... CPU#0: NMI appears to be stuck (0->0)!
  checking if image is initramfs... it is
  Freeing initrd memory: 6884k freed
  NET: Registered protocol family 16
@@ -98,24 +96,23 @@
  Initializing Device/Processor/Thermal objects by executing _INI methods:......
  Executed 6 _INI methods requiring 2 _STA executions (examined 113 objects)
  ACPI: Interpreter enabled
- ACPI: Using IOAPIC for interrupt routing
+ ACPI: Using PIC for interrupt routing
  ACPI: PCI Root Bridge [C047] (0000:00)
  ACPI: Assume root bridge [\_SB_.C047] bus is 0
  PCI: Ignoring BAR0-3 of IDE controller 0000:00:14.1
  PCI: Transparent bridge - 0000:00:14.4
  PCI: Bus #03 (-#06) is hidden behind transparent bridge #02 (-#03) (try
'pci=assign-busses')
  Please report the result to linux-kernel to fix this permanently
- 1.6.9 accepting connections at 2208...
  ACPI: Power Resource [C1D3] (off)
  ACPI: Power Resource [C1BB] (on)
  ACPI: Power Resource [C1CB] (on)
- ACPI: PCI Interrupt Link [C0F0] (IRQs 10 11) *0, disabled.
- ACPI: PCI Interrupt Link [C0F1] (IRQs 10 11) *0, disabled.
+ ACPI: PCI Interrupt Link [C0F0] (IRQs *10 11)
+ ACPI: PCI Interrupt Link [C0F1] (IRQs 10 11) *5
  ACPI: PCI Interrupt Link [C0F2] (IRQs 10 11) *0, disabled.
- ACPI: PCI Interrupt Link [C0F3] (IRQs 10 11) *0, disabled.
- ACPI: PCI Interrupt Link [C0F4] (IRQs 10 11) *0, disabled.
- ACPI: PCI Interrupt Link [C0F5] (IRQs 9) *0, disabled.
- ACPI: PCI Interrupt Link [C0F6] (IRQs 10 11) *0, disabled.
+ ACPI: PCI Interrupt Link [C0F3] (IRQs *10 11)
+ ACPI: PCI Interrupt Link [C0F4] (IRQs 10 *11)
+ ACPI: PCI Interrupt Link [C0F5] (IRQs *9)
+ ACPI: PCI Interrupt Link [C0F6] (IRQs 10 11) *5
  ACPI: PCI Interrupt Link [C0F7] (IRQs *10 11)
  ACPI: Power Resource [C251] (off)
  ACPI: Power Resource [C252] (off)
@@ -153,7 +150,8 @@
    IO window: 2000-2fff
    MEM window: d0000000-d05fffff
    PREFETCH window: 50000000-51ffffff
- ACPI: PCI Interrupt 0000:02:04.0[A] -> GSI 20 (level, low) -> IRQ 20
+ ACPI: PCI Interrupt Link [C0F4] enabled at IRQ 11
+ ACPI: PCI Interrupt 0000:02:04.0[A] -> Link [C0F4] -> GSI 11 (level, low) ->
IRQ 11
  NET: Registered protocol family 2
  IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
  TCP established hash table entries: 32768 (order: 9, 2359296 bytes)
@@ -161,7 +159,7 @@
  TCP: Hash tables configured (established 32768 bind 16384)
  TCP reno registered
  audit: initializing netlink socket (disabled)
- audit(1162046376.916:1): initialized
+ audit(1163383174.925:1): initialized
  VFS: Disk quotas dquot_6.5.1
  Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
  io scheduler noop registered
@@ -172,12 +170,14 @@
  assign_interrupt_mode Found MSI capability
  pcie_portdrv_probe->Dev[5a37:1002] has invalid IRQ. Check vendor BIOS
  assign_interrupt_mode Found MSI capability
+ Started up.
  aer: probe of 0000:00:04.0:pcie01 failed with error 1
  aer: probe of 0000:00:05.0:pcie01 failed with error 1
  Real Time Clock Driver v1.12ac
  Linux agpgart interface v0.101 (c) Dave Jones
  Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
- ACPI: PCI Interrupt 0000:00:14.6[B] -> GSI 17 (level, low) -> IRQ 17
+ ACPI: PCI Interrupt Link [C0F1] enabled at IRQ 10
+ ACPI: PCI Interrupt 0000:00:14.6[B] -> Link [C0F1] -> GSI 10 (level, low) ->
IRQ 10
  ACPI: PCI interrupt for device 0000:00:14.6 disabled
  RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
  Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
@@ -198,8 +198,6 @@
  drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
  Freeing unused kernel memory: 200k freed
  input: AT Translated Set 2 keyboard as /class/input/input0
- vga16fb: mapped to 0xffff8100000a0000
- fb0: VGA16 VGA frame buffer device
  ACPI: Transitioning device [C255] to D3
  ACPI: Transitioning device [C255] to D3
  ACPI: Fan [C255] (off)
@@ -214,12 +212,13 @@
  ACPI: Fan [C258] (off)
  ACPI: CPU0 (power states: C1[C1] C3[C3])
  ACPI: Processor [C000] (supports 8 throttling states)
- ACPI: Thermal Zone [TZ1] (77 C)
- ACPI: Thermal Zone [TZ2] (60 C)
- ACPI: Thermal Zone [TZ3] (30 C)
- ACPI: Thermal Zone [TZ4] (34 C)
+ ACPI: Thermal Zone [TZ1] (72 C)
+ ACPI: Thermal Zone [TZ2] (53 C)
+ ACPI: Thermal Zone [TZ3] (31 C)
+ ACPI: Thermal Zone [TZ4] (39 C)
  ATIIXP: IDE controller at PCI slot 0000:00:14.1
- ACPI: PCI Interrupt 0000:00:14.1[A] -> GSI 16 (level, low) -> IRQ 16
+ ACPI: PCI Interrupt Link [C0F0] enabled at IRQ 10
+ ACPI: PCI Interrupt 0000:00:14.1[A] -> Link [C0F0] -> GSI 10 (level, low) ->
IRQ 10
  ATIIXP: chipset revision 0
  ATIIXP: not 100%% native mode: will probe irqs later
      ide0: BM-DMA at 0x4010-0x4017, BIOS settings: hda:DMA, hdb:pio
@@ -237,121 +236,96 @@
  usbcore: registered new interface driver usbfs
  usbcore: registered new interface driver hub
  usbcore: registered new device driver usb
- ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 19 (level, low) -> IRQ 19
+ ACPI: PCI Interrupt Link [C0F3] enabled at IRQ 10
+ ACPI: PCI Interrupt 0000:00:13.0[A] -> Link [C0F3] -> GSI 10 (level, low) ->
IRQ 10
  ohci_hcd 0000:00:13.0: OHCI Host Controller
  ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 1
- ohci_hcd 0000:00:13.0: irq 19, io mem 0xd0a00000
+ ohci_hcd 0000:00:13.0: irq 10, io mem 0xd0a00000
  usb usb1: configuration #1 chosen from 1 choice
  hub 1-0:1.0: USB hub found
  hub 1-0:1.0: 4 ports detected
- ACPI: PCI Interrupt 0000:00:13.2[A] -> GSI 19 (level, low) -> IRQ 19
+ ACPI: PCI Interrupt 0000:00:13.2[A] -> Link [C0F3] -> GSI 10 (level, low) ->
IRQ 10
  ehci_hcd 0000:00:13.2: EHCI Host Controller
  ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 2
- ehci_hcd 0000:00:13.2: irq 19, io mem 0xd0a02000
+ ehci_hcd 0000:00:13.2: irq 10, io mem 0xd0a02000
  ehci_hcd 0000:00:13.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
  usb usb2: configuration #1 chosen from 1 choice
  hub 2-0:1.0: USB hub found
  hub 2-0:1.0: 8 ports detected
- ACPI: PCI Interrupt 0000:02:04.2[C] -> GSI 21 (level, low) -> IRQ 21
- ACPI: PCI Interrupt 0000:00:13.1[A] -> GSI 19 (level, low) -> IRQ 19
+ ACPI: PCI Interrupt Link [C0F5] enabled at IRQ 9
+ ACPI: PCI Interrupt 0000:02:04.2[C] -> Link [C0F5] -> GSI 9 (level, low) ->
IRQ 9
+ ACPI: PCI Interrupt 0000:00:13.1[A] -> Link [C0F3] -> GSI 10 (level, low) ->
IRQ 10
  ohci_hcd 0000:00:13.1: OHCI Host Controller
  ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 3
- ohci_hcd 0000:00:13.1: irq 19, io mem 0xd0a01000
- ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[21]  MMIO=[d0013000-d00137ff]
 Max Packet=[2048]  IR/IT contexts=[4/8]
+ ohci_hcd 0000:00:13.1: irq 10, io mem 0xd0a01000
+ ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[9]  MMIO=[d0013000-d00137ff]
Max Packet=[2048]  IR/IT contexts=[4/8]
  usb usb3: configuration #1 chosen from 1 choice
  hub 3-0:1.0: USB hub found
  hub 3-0:1.0: 4 ports detected
  Attempting manual resume
- kjournald starting.  Commit interval 5 seconds
- EXT3-fs: mounted filesystem with writeback data mode.
+ EXT3-fs: INFO: recovery required on readonly filesystem.
+ EXT3-fs: write access will be enabled during recovery.
  usb 3-1: new full speed USB device using ohci_hcd and address 2
  usb 3-1: configuration #1 chosen from 1 choice
- Started up.
  usb 1-2: new full speed USB device using ohci_hcd and address 2
  usb 1-2: configuration #1 chosen from 1 choice
-
- Call Trace:
-  [dump_trace+185/992] dump_trace+0xb9/0x3e0
-  [show_trace+67/96] show_trace+0x43/0x60
-  [dump_stack+21/32] dump_stack+0x15/0x20
-  [__report_bad_irq+56/144] __report_bad_irq+0x38/0x90
-  [note_interrupt+561/640] note_interrupt+0x231/0x280
-  [handle_fasteoi_irq+167/224] handle_fasteoi_irq+0xa7/0xe0
-  [do_IRQ+113/192] do_IRQ+0x71/0xc0
-  [ret_from_intr+0/15] ret_from_intr+0x0/0xf
- DWARF2 unwinder stuck at ret_from_intr+0x0/0xf
-
- Leftover inexact backtrace:
-
-  <IRQ>  <EOI>  [_end+123922454/2126640872] :processor:acpi_safe_halt+0x2c/0x40
-  [_end+123922456/2126640872] :processor:acpi_safe_halt+0x2e/0x40
-  [_end+123922454/2126640872] :processor:acpi_safe_halt+0x2c/0x40
-  [_end+123922995/2126640872] :processor:acpi_processor_idle+0x181/0x402
-  [atomic_notifier_call_chain+69/112] atomic_notifier_call_chain+0x45/0x70
-  [_end+123922610/2126640872] :processor:acpi_processor_idle+0x0/0x402
-  [cpu_idle+78/144] cpu_idle+0x4e/0x90
-  [rest_init+58/64] rest_init+0x3a/0x40
-  [start_kernel+607/624] start_kernel+0x25f/0x270
-  [x86_64_start_kernel+329/336] _sinittext+0x149/0x150
-
- warning: process `ckbcomp' used the removed sysctl system call
- input: PC Speaker as /class/input/input1
+ kjournald starting.  Commit interval 5 seconds
+ EXT3-fs: recovery complete.
+ EXT3-fs: mounted filesystem with writeback data mode.
  pci_hotplug: PCI Hot Plug PCI Core version: 0.5
- sdhci: Secure Digital Host Controller Interface driver, 0.12
- sdhci: Copyright(c) Pierre Ossman
- sdhci: SDHCI controller found at 0000:02:04.4 [104c:8034] (rev 0)
- ACPI: PCI Interrupt 0000:02:04.4[C] -> GSI 21 (level, low) -> IRQ 21
- mmc0: SDHCI at 0xd001a000 irq 21 DMA
- mmc1: SDHCI at 0xd001b000 irq 21 DMA
- mmc2: SDHCI at 0xd001c000 irq 21 DMA
- ACPI: PCI Interrupt 0000:02:04.3[B] -> GSI 21 (level, low) -> IRQ 21
  shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
+ ACPI: PCI Interrupt 0000:00:14.6[B] -> Link [C0F1] -> GSI 10 (level, low) ->
IRQ 10
+ MC'97 0 converters and GPIO not ready (0x1)
  Yenta: CardBus bridge found at 0000:02:04.0 [103c:308b]
  Yenta: Enabling burst memory read transactions
  Yenta: Using INTVAL to route CSC interrupts to PCI
  Yenta: Routing CardBus interrupts to PCI
  Yenta TI: socket 0000:02:04.0, mfunc 0x01a11b22, devctl 0x64
- parport: PnPBIOS parport detected.
- parport0: PC-style at 0x378 (0x778), irq 7, dma 1
[PCSPP,TRISTATE,COMPAT,ECP,DMA]
  ieee80211: 802.11 data/management/control stack, git-1.1.13
  ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
- bcm43xx driver
- Yenta: ISA IRQ mask 0x0c78, PCI irq 20
+ sdhci: Secure Digital Host Controller Interface driver, 0.12
+ sdhci: Copyright(c) Pierre Ossman
+ input: PC Speaker as /class/input/input1
+ Yenta: ISA IRQ mask 0x00f8, PCI irq 11
  Socket status: 30000006
  Yenta: Raising subordinate bus# of parent bus (#02) from #03 to #06
  pcmcia: parent PCI bridge I/O window: 0x2000 - 0x2fff
  pcmcia: parent PCI bridge Memory window: 0xd0000000 - 0xd05fffff
  pcmcia: parent PCI bridge Memory window: 0x50000000 - 0x51ffffff
- ACPI: PCI Interrupt 0000:02:02.0[A] -> GSI 22 (level, low) -> IRQ 22
- ACPI: PCI Interrupt 0000:00:14.5[B] -> GSI 17 (level, low) -> IRQ 17
- PCI: Enabling device 0000:00:14.6 (0000 -> 0002)
- ACPI: PCI Interrupt 0000:00:14.6[B] -> GSI 17 (level, low) -> IRQ 17
- MC'97 0 converters and GPIO not ready (0x1)
- piix4_smbus 0000:00:14.0: Found 0000:00:14.0 device
- tg3.c:v3.67 (October 18, 2006)
- ACPI: PCI Interrupt 0000:02:01.0[A] -> GSI 23 (level, low) -> IRQ 23
- eth1: Tigon3 [partno(BCM95788A50) rev 3003 PHY(5705)] (PCI:33MHz:32-bit)
10/100/1000BaseT Ethernet 00:0f:b0:bb:bc:f8
- eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[0] TSOcap[1]
- eth1: dma_rwctrl[763f0000] dma_mask[32-bit]
+ sdhci: SDHCI controller found at 0000:02:04.4 [104c:8034] (rev 0)
+ ACPI: PCI Interrupt 0000:02:04.4[C] -> Link [C0F5] -> GSI 9 (level, low) ->
IRQ 9
+ mmc0: SDHCI at 0xd001a000 irq 9 DMA
+ mmc1: SDHCI at 0xd001b000 irq 9 DMA
+ mmc2: SDHCI at 0xd001c000 irq 9 DMA
+ ACPI: PCI Interrupt 0000:02:04.3[B] -> Link [C0F5] -> GSI 9 (level, low) ->
IRQ 9
+ ACPI: PCI Interrupt 0000:00:14.5[B] -> Link [C0F1] -> GSI 10 (level, low) ->
IRQ 10
+ tg3.c:v3.68 (November 02, 2006)
+ ACPI: PCI Interrupt Link [C0F7] enabled at IRQ 10
+ ACPI: PCI Interrupt 0000:02:01.0[A] -> Link [C0F7] -> GSI 10 (level, low) ->
IRQ 10
+ eth0: Tigon3 [partno(BCM95788A50) rev 3003 PHY(5705)] (PCI:33MHz:32-bit)
10/100/1000BaseT Ethernet 00:0f:b0:bb:bc:f8
+ eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[0] TSOcap[1]
+ eth0: dma_rwctrl[763f0000] dma_mask[32-bit]
+ parport: PnPBIOS parport detected.
+ parport0: PC-style at 0x378 (0x778), irq 7, dma 1
[PCSPP,TRISTATE,COMPAT,ECP,DMA]
  Bluetooth: Core ver 2.11
  NET: Registered protocol family 31
  Bluetooth: HCI device and connection manager initialized
  Bluetooth: HCI socket layer initialized
- Synaptics Touchpad, model: 1, fw: 6.2, id: 0x1a0b1, caps: 0xa04713/0x200000
- input: SynPS/2 Synaptics TouchPad as /class/input/input2
  Bluetooth: HCI USB driver ver 2.9
- usbcore: registered new interface driver hci_usb
- warning: process `alsactl' used the removed sysctl system call
- warning: process `alsactl' used the removed sysctl system call
- warning: process `alsactl' used the removed sysctl system call
  SCSI subsystem initialized
- warning: process `amixer' used the removed sysctl system call
+ piix4_smbus 0000:00:14.0: Found 0000:00:14.0 device
+ bcm43xx driver
+ ACPI: PCI Interrupt Link [C0F6] enabled at IRQ 11
+ ACPI: PCI Interrupt 0000:02:02.0[A] -> Link [C0F6] -> GSI 11 (level, low) ->
IRQ 11
+ Synaptics Touchpad, model: 1, fw: 6.2, id: 0x1a0b1, caps: 0xa04713/0x200000
+ usbcore: registered new interface driver hci_usb
+ input: SynPS/2 Synaptics TouchPad as /class/input/input2
  lp0: using parport0 (interrupt-driven).
  ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
  ieee1394: sbp2: Try serialize_io=0 for better performance
  Adding 1116476k swap on
/dev/disk/by-uuid/45b6bcfd-44ec-4878-8110-f2164f9e8051.  Priority:-1 extents:1
across:1116476k
- EXT3 FS on hda2, internal journal
  NET: Registered protocol family 17
+ EXT3 FS on hda2, internal journal
  device-mapper: ioctl: 4.10.0-ioctl (2006-09-14) initialised: dm-devel@redhat.com
  device-mapper: ioctl: error adding target to table
  device-mapper: ioctl: error adding target to table
@@ -382,13 +356,11 @@
  powernow-k8:    4 : fid 0x0 (800 MHz), vid 0x16
  NET: Registered protocol family 10
  lo: Disabled Privacy Extensions
- ADDRCONF(NETDEV_UP): eth1: link is not ready
  ADDRCONF(NETDEV_UP): eth0: link is not ready
+ ADDRCONF(NETDEV_UP): eth1: link is not ready
  Capability LSM initialized
- SoftMAC: Open Authentication completed with 00:06:25:60:b6:81
+ SoftMAC: Open Authentication completed with 00:11:50:3c:6c:2f
  ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
- device eth0 entered promiscuous mode
- audit(1162071626.136:2): dev=eth0 prom=256 old_prom=0 auid=4294967295
  Bluetooth: L2CAP ver 2.8
  Bluetooth: L2CAP socket layer initialized
  Bluetooth: RFCOMM socket layer initialized
