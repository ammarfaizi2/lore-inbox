Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266216AbUIVQ2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266216AbUIVQ2h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 12:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266221AbUIVQ2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 12:28:37 -0400
Received: from 8.75.30.213.rev.vodafone.pt ([213.30.75.8]:30483 "EHLO
	odie.graycell.biz") by vger.kernel.org with ESMTP id S266216AbUIVQ2S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 12:28:18 -0400
Subject: Re: problem with suspend and usb
From: Nuno Ferreira <nuno.ferreira@graycell.biz>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040922094844.GA9197@elf.ucw.cz>
References: <1095685487.4294.14.camel@taz.graycell.biz>
	 <20040922094844.GA9197@elf.ucw.cz>
Content-Type: text/plain
Organization: Graycell
Date: Wed, 22 Sep 2004 17:28:10 +0100
Message-Id: <1095870490.3809.3.camel@taz.graycell.biz>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Sep 2004 16:28:13.0396 (UTC) FILETIME=[2807F940:01C4A0C1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Qua, 2004-09-22 at 11:48 +0200, Pavel Machek wrote: 
> Hi!
> 
> > Tried suspend for the first time and after I booted with "nomce" (a
> > workaround for my broken BIOS, I think) everything worked, apart from
> > USB.
> > When resuming, usb does not work. If I unload and load ohci_hcd module
> > USB starts working again. My laptop is a Compaq Presario 920.
> > Is it a known problem? 
> 
> Try latest -mm kernel.

Well, turns out that the lastest -mm kernel is much worse.
Found several problems:
* Shutdown is very slow. After the message "acpi_power_off called"
appears, it taken ~30s for the laptop to shutdown. Using 2.6.8 it shuts
down immediately after that message is printed.

* Suspend with ohci_hcd hangs. Removing the ohci_hcd module suspend
works.
Here's what's printed on the screen before hanging (I hand-write it so
there could be some typos)

Freeing memory.... done (54077 pages freed)
usbhid1-1:1.0: resume is unsafe!
usb1-1: no poweroff yet, suspending instead.
usb usb1: no poweroff yet, suspending instead.
............. swsusp: Need to copy 9776 pages
............. swsusp: critical section/: done (9840 pages copied)

* Network doesn't work after resuming. I'm using 8139cp. I tried "ifdown
eth0 && ifup eth0" and network stil. doesn't work after suspend.
Even tried "ifdown eth0 && modprobe -r 8139cp && modprobe 8139cp && ifup
eth0" and network still doesn't work. Only started to work after reboot
Here are the logs from the suspend request 

- Me unloading the usb modules
Sep 22 15:33:43 taz kernel: ohci_hcd 0000:00:02.0: remove, state 1
Sep 22 15:33:43 taz kernel: usb usb1: USB disconnect, address 1
Sep 22 15:33:43 taz kernel: usb 1-1: USB disconnect, address 2
Sep 22 15:33:43 taz udev: removing device node '/dev/input/mouse1'
Sep 22 15:33:43 taz udev: removing device node '/dev/input/event2'
Sep 22 15:33:43 taz hal.hotplug[3863]: DEVPATH is not set
Sep 22 15:33:43 taz kernel: ohci_hcd 0000:00:02.0: USB bus 1 deregistered

- Supend request
Sep 22 15:33:55 taz kernel: Stopping tasks: =================================|
Sep 22 15:33:55 taz kernel: Freeing memory...  ^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^Hdone (11255 pages freed)
Sep 22 15:33:55 taz kernel: ..................swsusp: Need to copy 9397 pages
Sep 22 15:33:55 taz kernel: .<6>ACPI: PCI interrupt 0000:00:08.0[A] -> GSI 5 (level, low) -> IRQ 5
Sep 22 15:33:55 taz kernel: ACPI: PCI interrupt 0000:00:10.0[A]: no GSI - using IRQ 0
Sep 22 15:33:55 taz kernel: Restarting tasks... done
Sep 22 15:33:55 taz kernel: atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
Sep 22 15:34:00 taz kernel: Warning: CPU frequency is 1655837, cpufreq assumed 529868 kHz.
Sep 22 15:34:14 taz ntpd[2715]: kernel time sync enabled 0001

- At this poit network doesn't workm try unloading and realoding the network module
Sep 22 15:34:57 taz kernel: 8139cp: 10/100 PCI Ethernet driver v1.2 (Mar 22, 2004)
Sep 22 15:34:57 taz kernel: ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 11 (level, low) -> IRQ 11
Sep 22 15:34:57 taz kernel: eth0: RTL-8139C+ at 0xdf89e000, 00:08:02:f2:52:e1, IRQ 11
Sep 22 15:35:00 taz dhclient: Internet Systems Consortium DHCP Client V3.0.1
Sep 22 15:35:00 taz dhclient: Copyright 2004 Internet Systems Consortium.
Sep 22 15:35:00 taz dhclient: All rights reserved.
Sep 22 15:35:00 taz dhclient: For info, please visit http://www.isc.org/products/DHCP
Sep 22 15:35:00 taz dhclient:
Sep 22 15:35:00 taz kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Sep 22 15:35:01 taz /USR/SBIN/CRON[4105]: (root) CMD ([ -x /usr/lib/sysstat/sa1 ] && { [ -r "$DEFAULT" ] && . "$DEFAULT" ; [ "$ENABLED" = "true" ] && exec /usr/lib/sysstat/sa1; })
Sep 22 15:35:01 taz dhclient: Listening on LPF/eth0/00:08:02:f2:52:e1
Sep 22 15:35:01 taz dhclient: Sending on   LPF/eth0/00:08:02:f2:52:e1
Sep 22 15:35:01 taz dhclient: Sending on   Socket/fallback
Sep 22 15:35:02 taz dhclient: DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 4
Sep 22 15:35:06 taz dhclient: DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 2
Sep 22 15:35:08 taz dhclient: No DHCPOFFERS received.
Sep 22 15:35:08 taz dhclient: No working leases in persistent database - sleeping.
Sep 22 15:35:20 taz ntpd[2715]: sendto(10.1.1.254): Invalid argument
-- Network still doesn't work

* If after suspending I try to load ohci_hcd I get these messages and
modprobe hangs, doing a ps shows it in D state. 

Sep 22 15:35:56 taz kernel: ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
Sep 22 15:35:56 taz kernel: ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 11 (level, low) -> IRQ 11
Sep 22 15:35:56 taz kernel: ohci_hcd 0000:00:02.0: ALi Corporation USB 1.1 Controller
Sep 22 15:35:56 taz kernel: ohci_hcd 0000:00:02.0: irq 11, pci mem 0xf4010000
Sep 22 15:35:56 taz kernel: ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
Sep 22 15:35:56 taz kernel: hub 1-0:1.0: USB hub found
Sep 22 15:35:56 taz kernel: hub 1-0:1.0: 2 ports detected
Sep 22 15:35:56 taz kernel: ACPI: PCI interrupt 0000:00:0f.0[A] -> GSI 11 (level, low) -> IRQ 11
Sep 22 15:35:56 taz kernel: ohci_hcd 0000:00:0f.0: ALi Corporation USB 1.1 Controller (#2)
Sep 22 15:35:56 taz kernel: ohci_hcd 0000:00:0f.0: irq 11, pci mem 0xf4012000
Sep 22 15:35:56 taz kernel: ohci_hcd 0000:00:0f.0: new USB bus registered, assigned bus number 2
Sep 22 15:35:56 taz kernel: ohci_hcd 0000:00:0f.0: init err (00002edf 0000)
Sep 22 15:35:56 taz kernel: ohci_hcd 0000:00:0f.0: can't start
Sep 22 15:35:56 taz kernel: ohci_hcd 0000:00:0f.0: init error -75
Sep 22 15:35:56 taz kernel: ohci_hcd 0000:00:0f.0: remove, state 0
Sep 22 15:35:56 taz kernel: ohci_hcd 0000:00:0f.0: USB bus 2 deregistered
Sep 22 15:35:57 taz kernel: usb 1-1: new low speed USB device using address 2
Sep 22 15:36:02 taz kernel: usb 1-1: control timeout on ep0out
Sep 22 15:36:02 taz kernel: ohci_hcd 0000:00:02.0: Unlink after no-IRQ?  Different ACPI or APIC settings may help.

Any ideas?

Here's the complete boot log and lspci -v output.
boot log
-------- 
Sep 22 15:29:42 taz kernel: klogd 1.4.1#15, log source = /proc/kmsg started.
Sep 22 15:29:42 taz kernel: Inspecting /boot/System.map-2.6.9-rc2-mm1
Sep 22 15:29:42 taz kernel: Loaded 25849 symbols from /boot/System.map-2.6.9-rc2-mm1.
Sep 22 15:29:42 taz kernel: Symbols match kernel version 2.6.9.
Sep 22 15:29:42 taz kernel: No module symbols loaded - kernel modules not enabled.
Sep 22 15:29:42 taz kernel: Linux version 2.6.9-rc2-mm1 (root@taz) (gcc version 3.4.2 (Debian 3.4.2-2)) #1 Wed Sep 22 15:17:40 WEST 2004
Sep 22 15:29:42 taz kernel: BIOS-provided physical RAM map:
Sep 22 15:29:42 taz kernel:  BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
Sep 22 15:29:42 taz kernel:  BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
Sep 22 15:29:42 taz kernel:  BIOS-e820: 00000000000d0000 - 0000000000100000 (reserved)
Sep 22 15:29:42 taz kernel:  BIOS-e820: 0000000000100000 - 000000001eef0000 (usable)
Sep 22 15:29:42 taz kernel:  BIOS-e820: 000000001eef0000 - 000000001eeff000 (ACPI data)
Sep 22 15:29:42 taz kernel:  BIOS-e820: 000000001eeff000 - 000000001ef00000 (ACPI NVS)
Sep 22 15:29:42 taz kernel:  BIOS-e820: 000000001ef00000 - 000000001f000000 (usable)
Sep 22 15:29:42 taz kernel:  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
Sep 22 15:29:42 taz kernel: 496MB LOWMEM available.
Sep 22 15:29:42 taz kernel: On node 0 totalpages: 126976
Sep 22 15:29:42 taz kernel:   DMA zone: 4096 pages, LIFO batch:1
Sep 22 15:29:42 taz kernel:   Normal zone: 122880 pages, LIFO batch:16
Sep 22 15:29:42 taz kernel:   HighMem zone: 0 pages, LIFO batch:1
Sep 22 15:29:42 taz kernel: DMI 2.3 present.
Sep 22 15:29:42 taz kernel: ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f7020
Sep 22 15:29:42 taz kernel: ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x1eefad51
Sep 22 15:29:42 taz kernel: ACPI: FADT (v001 COMPAQ Presario 0x06040000 PTL_ 0x000f4240) @ 0x1eefee53
Sep 22 15:29:42 taz kernel: ACPI: SSDT (v001 PTLTD  POWERNOW 0x06040000  LTP 0x00000001) @ 0x1eefeec7
Sep 22 15:29:42 taz kernel: ACPI: DSDT (v001 COMPAQ    BOONE 0x06040000 MSFT 0x0100000d) @ 0x00000000
Sep 22 15:29:42 taz kernel: ACPI: PM-Timer IO Port: 0x8008
Sep 22 15:29:42 taz kernel: Built 1 zonelists
Sep 22 15:29:42 taz kernel: Initializing CPU#0
Sep 22 15:29:42 taz kernel: Kernel command line: BOOT_IMAGE=Linux ro root=302 nomce resume=/dev/hda3 rootflags=data=writeback psmouse.proto=imps
Sep 22 15:29:42 taz kernel: CPU 0 irqstacks, hard=c039d000 soft=c039c000
Sep 22 15:29:42 taz kernel: PID hash table entries: 2048 (order: 11, 32768 bytes)
Sep 22 15:29:42 taz kernel: Detected 1655.842 MHz processor.
Sep 22 15:29:42 taz kernel: Using pmtmr for high-res timesource
Sep 22 15:29:42 taz kernel: Console: colour VGA+ 80x25
Sep 22 15:29:42 taz kernel: Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Sep 22 15:29:42 taz kernel: Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Sep 22 15:29:42 taz kernel: Memory: 500008k/507904k available (1762k kernel code, 7288k reserved, 743k data, 140k init, 0k highmem)
Sep 22 15:29:42 taz kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Sep 22 15:29:42 taz kernel: Calibrating delay loop... 3293.18 BogoMIPS (lpj=1646592)
Sep 22 15:29:42 taz kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Sep 22 15:29:42 taz kernel: CPU: After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000
Sep 22 15:29:42 taz kernel: CPU: After vendor identify, caps:  0383fbff c1cbfbff 00000000 00000000
Sep 22 15:29:42 taz kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Sep 22 15:29:42 taz kernel: CPU: L2 Cache: 256K (64 bytes/line)
Sep 22 15:29:42 taz kernel: CPU: After all inits, caps:        0383fbff c1cbfbff 00000000 00000020
Sep 22 15:29:42 taz kernel: CPU: AMD Mobile AMD Athlon(tm) XP 2000+ stepping 01
Sep 22 15:29:42 taz kernel: Enabling fast FPU save and restore... done.
Sep 22 15:29:42 taz kernel: Enabling unmasked SIMD FPU exception support... done.
Sep 22 15:29:42 taz kernel: Checking 'hlt' instruction... OK.
Sep 22 15:29:42 taz kernel: ACPI: IRQ9 SCI: Edge set to Level Trigger.
Sep 22 15:29:42 taz kernel: NET: Registered protocol family 16
Sep 22 15:29:42 taz kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd87e, last bus=1
Sep 22 15:29:42 taz kernel: PCI: Using configuration type 1
Sep 22 15:29:42 taz kernel: mtrr: v2.0 (20020519)
Sep 22 15:29:42 taz kernel: ACPI: Subsystem revision 20040816
Sep 22 15:29:42 taz kernel: spurious 8259A interrupt: IRQ7.
Sep 22 15:29:42 taz kernel: ACPI: Interpreter enabled
Sep 22 15:29:42 taz kernel: ACPI: Using PIC for interrupt routing
Sep 22 15:29:42 taz kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Sep 22 15:29:42 taz kernel: PCI: Probing PCI hardware (bus 00)
Sep 22 15:29:42 taz kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Sep 22 15:29:42 taz kernel: ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 10 11 12) *0, disabled.
Sep 22 15:29:42 taz kernel: ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 11 12) *0, disabled.
Sep 22 15:29:42 taz kernel: ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 *10 11 12)
Sep 22 15:29:42 taz kernel: ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 10 *11 12)
Sep 22 15:29:42 taz kernel: ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 10 *11 12)
Sep 22 15:29:42 taz kernel: ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 11 12) *0, disabled.
Sep 22 15:29:42 taz kernel: ACPI: PCI Interrupt Link [LNK6] (IRQs 3 4 5 6 7 10 11 12) *0, disabled.
Sep 22 15:29:42 taz kernel: ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 11 12) *0, disabled.
Sep 22 15:29:42 taz kernel: ACPI: PCI Interrupt Link [LNK6] (IRQs 3 4 5 6 7 10 11 12) *0, disabled.
Sep 22 15:29:42 taz kernel: ACPI: PCI Interrupt Link [LNK7] (IRQs 3 4 *5 6 7 10 11 12)
Sep 22 15:29:42 taz kernel: ACPI: PCI Interrupt Link [LNK8] (IRQs 3 4 5 6 7 10 *11 12)
Sep 22 15:29:42 taz kernel: ACPI: Embedded Controller [EC] (gpe 24)
Sep 22 15:29:42 taz kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
Sep 22 15:29:42 taz kernel: usbcore: registered new driver usbfs
Sep 22 15:29:42 taz kernel: usbcore: registered new driver hub
Sep 22 15:29:42 taz kernel: PCI: Using ACPI for IRQ routing
Sep 22 15:29:42 taz kernel: ** PCI interrupts are no longer routed automatically.  If this
Sep 22 15:29:42 taz kernel: ** causes a device to stop working, it is probably because the
Sep 22 15:29:42 taz kernel: ** driver failed to call pci_enable_device().  As a temporary
Sep 22 15:29:42 taz kernel: ** workaround, the "pci=routeirq" argument restores the old
Sep 22 15:29:42 taz kernel: ** behavior.  If this argument makes the device work again,
Sep 22 15:29:42 taz kernel: ** please email the output of "lspci" to bjorn.helgaas@hp.com
Sep 22 15:29:42 taz kernel: ** so I can fix the driver.
Sep 22 15:29:42 taz kernel: Machine check exception polling timer started.
Sep 22 15:29:42 taz kernel: Initializing Cryptographic API
Sep 22 15:29:42 taz kernel: ATI Northbridge, reserving I/O ports 0x3b0 to 0x3bb.
Sep 22 15:29:42 taz kernel: Activating ISA DMA hang workarounds.
Sep 22 15:29:42 taz kernel: ACPI: AC Adapter [AC] (on-line)
Sep 22 15:29:42 taz kernel: ACPI: Battery Slot [BAT0] (battery present)
Sep 22 15:29:42 taz kernel: ACPI: Power Button (FF) [PWRF]
Sep 22 15:29:42 taz kernel: ACPI: Sleep Button (FF) [SLPF]
Sep 22 15:29:42 taz kernel: ACPI: Lid Switch [LID]
Sep 22 15:29:42 taz kernel: ACPI: Processor [CPU0] (supports C1 C2, 8 throttling states)
Sep 22 15:29:42 taz kernel: ACPI: Thermal Zone [THRM] (56 C)
Sep 22 15:29:42 taz kernel: Real Time Clock Driver v1.12
Sep 22 15:29:42 taz kernel: Linux agpgart interface v0.100 (c) Dave Jones
Sep 22 15:29:42 taz kernel: i8042: ACPI  [KBC0] at I/O 0x60, 0x64, irq 1
Sep 22 15:29:42 taz kernel: i8042: ACPI  [MSE0] at irq 12
Sep 22 15:29:42 taz kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Sep 22 15:29:42 taz kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Sep 22 15:29:42 taz kernel: floppy: ACPI  [FDC] at I/O 0x3f0-0x3f5, 0x3f7 irq 6 dma channel 2
Sep 22 15:29:42 taz kernel: Using anticipatory io scheduler
Sep 22 15:29:42 taz kernel: Floppy drive(s): fd0 is 1.44M
Sep 22 15:29:42 taz kernel: FDC 0 is a post-1991 82077
Sep 22 15:29:42 taz kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Sep 22 15:29:42 taz kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Sep 22 15:29:42 taz kernel: Warning: ATI Radeon IGP Northbridge is not yet fully tested.
Sep 22 15:29:42 taz kernel: ALI15X3: IDE controller at PCI slot 0000:00:10.0
Sep 22 15:29:42 taz kernel: ACPI: PCI interrupt 0000:00:10.0[A]: no GSI - using IRQ 0
Sep 22 15:29:42 taz kernel: ALI15X3: chipset revision 196
Sep 22 15:29:42 taz kernel: ALI15X3: not 100%% native mode: will probe irqs later
Sep 22 15:29:42 taz kernel:     ide0: BM-DMA at 0x8080-0x8087, BIOS settings: hda:DMA, hdb:pio
Sep 22 15:29:42 taz kernel:     ide1: BM-DMA at 0x8088-0x808f, BIOS settings: hdc:pio, hdd:pio
Sep 22 15:29:42 taz kernel: Probing IDE interface ide0...
Sep 22 15:29:42 taz kernel: hda: HITACHI_DK23DA-30, ATA DISK drive
Sep 22 15:29:42 taz kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Sep 22 15:29:42 taz kernel: Probing IDE interface ide1...
Sep 22 15:29:42 taz kernel: hdc: HL-DT-STCD-RW/DVD DRIVE GCC-4240N, ATAPI CD/DVD-ROM drive
Sep 22 15:29:42 taz kernel: ide1 at 0x170-0x177,0x376 on irq 15
Sep 22 15:29:42 taz kernel: Probing IDE interface ide2...
Sep 22 15:29:42 taz kernel: ide2: Wait for ready failed before probe !
Sep 22 15:29:42 taz kernel: Probing IDE interface ide3...
Sep 22 15:29:42 taz kernel: ide3: Wait for ready failed before probe !
Sep 22 15:29:42 taz kernel: Probing IDE interface ide4...
Sep 22 15:29:42 taz kernel: ide4: Wait for ready failed before probe !
Sep 22 15:29:42 taz kernel: Probing IDE interface ide5...
Sep 22 15:29:42 taz kernel: ide5: Wait for ready failed before probe !
Sep 22 15:29:42 taz kernel: hda: max request size: 128KiB
Sep 22 15:29:42 taz kernel: hda: 58605120 sectors (30005 MB) w/2048KiB Cache, CHS=58140/16/63, UDMA(100)
Sep 22 15:29:42 taz kernel: hda: cache flushes supported
Sep 22 15:29:42 taz kernel:  hda: hda1 hda2 hda3
Sep 22 15:29:42 taz kernel: hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, DMA
Sep 22 15:29:42 taz kernel: Uniform CD-ROM driver Revision: 3.20
Sep 22 15:29:42 taz kernel: mice: PS/2 mouse device common for all mice
Sep 22 15:29:42 taz kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Sep 22 15:29:42 taz kernel: atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
Sep 22 15:29:42 taz kernel: input: ImPS/2 Synaptics TouchPad on isa0060/serio1
Sep 22 15:29:42 taz kernel: perfctr: driver 2.7.5, cpu type AMD K7/K8 at 1655842 kHz
Sep 22 15:29:42 taz kernel: NET: Registered protocol family 2
Sep 22 15:29:42 taz kernel: IP: routing cache hash table of 4096 buckets, 32Kbytes
Sep 22 15:29:42 taz kernel: TCP: Hash tables configured (established 32768 bind 65536)
Sep 22 15:29:42 taz kernel: Initializing IPsec netlink socket
Sep 22 15:29:42 taz kernel: NET: Registered protocol family 1
Sep 22 15:29:42 taz kernel: NET: Registered protocol family 17
Sep 22 15:29:42 taz kernel: NET: Registered protocol family 15
Sep 22 15:29:42 taz kernel: ACPI: (supports S0 S3 S4 S5)
Sep 22 15:29:42 taz kernel: ACPI wakeup devices:
Sep 22 15:29:42 taz kernel: SLPB PWRB  LID KBC0 MSE0 CRD0 NICD MODM
Sep 22 15:29:42 taz kernel: kjournald starting.  Commit interval 5 seconds
Sep 22 15:29:42 taz kernel: EXT3-fs: mounted filesystem with writeback data mode.
Sep 22 15:29:42 taz kernel: VFS: Mounted root (ext3 filesystem) readonly.
Sep 22 15:29:42 taz kernel: Freeing unused kernel memory: 140k freed
Sep 22 15:29:42 taz kernel: Adding 393584k swap on /dev/hda3.  Priority:-1 extents:1
Sep 22 15:29:42 taz kernel: EXT3 FS on hda2, internal journal
Sep 22 15:29:42 taz kernel: powernow: PowerNOW! Technology present. Can scale: frequency and voltage.
Sep 22 15:29:42 taz kernel: powernow: SGTC: 13333
Sep 22 15:29:42 taz kernel: powernow: Minimum speed 529 MHz. Maximum speed 1655 MHz.
Sep 22 15:29:42 taz kernel: NET: Registered protocol family 8
Sep 22 15:29:42 taz kernel: NET: Registered protocol family 20
Sep 22 15:29:42 taz kernel: CSLIP: code copyright 1989 Regents of the University of California
Sep 22 15:29:42 taz kernel: PPP generic driver version 2.4.2
Sep 22 15:29:42 taz kernel: i2c_adapter i2c-0: Error: command never completed
Sep 22 15:29:42 taz last message repeated 5 times
Sep 22 15:29:42 taz kernel: agpgart: Detected Ati IGP320/M chipset
Sep 22 15:29:42 taz kernel: agpgart: Maximum main memory to use for agp memory: 425M
Sep 22 15:29:42 taz kernel: agpgart: AGP aperture is 64M @ 0xf8000000
Sep 22 15:29:42 taz kernel: ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
Sep 22 15:29:42 taz kernel: ACPI: PCI Interrupt Link [LNK8] enabled at IRQ 11
Sep 22 15:29:42 taz kernel: ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 11 (level, low) -> IRQ 11
Sep 22 15:29:42 taz kernel: ohci_hcd 0000:00:02.0: ALi Corporation USB 1.1 Controller
Sep 22 15:29:42 taz kernel: ohci_hcd 0000:00:02.0: irq 11, pci mem 0xf4010000
Sep 22 15:29:42 taz kernel: ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
Sep 22 15:29:42 taz kernel: hub 1-0:1.0: USB hub found
Sep 22 15:29:42 taz kernel: hub 1-0:1.0: 2 ports detected
Sep 22 15:29:42 taz kernel: ACPI: PCI Interrupt Link [LNK4] enabled at IRQ 11
Sep 22 15:29:42 taz kernel: ACPI: PCI interrupt 0000:00:0f.0[A] -> GSI 11 (level, low) -> IRQ 11
Sep 22 15:29:42 taz kernel: ohci_hcd 0000:00:0f.0: ALi Corporation USB 1.1 Controller (#2)
Sep 22 15:29:42 taz kernel: ohci_hcd 0000:00:0f.0: irq 11, pci mem 0xf4012000
Sep 22 15:29:42 taz kernel: ohci_hcd 0000:00:0f.0: new USB bus registered, assigned bus number 2
Sep 22 15:29:42 taz kernel: ohci_hcd 0000:00:0f.0: init err (00002edf 0000)
Sep 22 15:29:42 taz kernel: ohci_hcd 0000:00:0f.0: can't start
Sep 22 15:29:42 taz kernel: ohci_hcd 0000:00:0f.0: init error -75
Sep 22 15:29:42 taz kernel: ohci_hcd 0000:00:0f.0: remove, state 0
Sep 22 15:29:42 taz kernel: ohci_hcd 0000:00:0f.0: USB bus 2 deregistered
Sep 22 15:29:42 taz kernel: ohci_hcd: probe of 0000:00:0f.0 failed with error -75
Sep 22 15:29:42 taz kernel: usb 1-1: new low speed USB device using address 2
Sep 22 15:29:42 taz kernel: usbcore: registered new driver hiddev
Sep 22 15:29:42 taz kernel: input: USB HID v1.00 Mouse [MacALLY USB Two Button Mini Mouse] on usb-0000:00:02.0-1
Sep 22 15:29:42 taz kernel: usbcore: registered new driver usbhid
Sep 22 15:29:42 taz kernel: drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Sep 22 15:29:42 taz kernel: ACPI: PCI Interrupt Link [LNK7] enabled at IRQ 5
Sep 22 15:29:42 taz kernel: ACPI: PCI interrupt 0000:00:08.0[A] -> GSI 5 (level, low) -> IRQ 5
Sep 22 15:29:42 taz kernel: Linux Kernel Card Services
Sep 22 15:29:42 taz kernel:   options:  [pci] [cardbus] [pm]
Sep 22 15:29:42 taz kernel: ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 10
Sep 22 15:29:42 taz kernel: ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 10 (level, low) -> IRQ 10
Sep 22 15:29:42 taz kernel: Yenta: CardBus bridge found at 0000:00:0a.0 [0e11:00b0]
Sep 22 15:29:42 taz kernel: yenta 0000:00:0a.0: Preassigned resource 1 busy, reconfiguring...
Sep 22 15:29:42 taz kernel: Yenta: Enabling burst memory read transactions
Sep 22 15:29:42 taz kernel: Yenta: Using CSCINT to route CSC interrupts to PCI
Sep 22 15:29:42 taz kernel: Yenta: Routing CardBus interrupts to PCI
Sep 22 15:29:42 taz kernel: Yenta TI: socket 0000:00:0a.0, mfunc 0x01001002, devctl 0x64
Sep 22 15:29:42 taz kernel: Yenta: ISA IRQ mask 0x0098, PCI irq 10
Sep 22 15:29:42 taz kernel: Socket status: 30000006
Sep 22 15:29:42 taz kernel: 8139cp: 10/100 PCI Ethernet driver v1.2 (Mar 22, 2004)
Sep 22 15:29:42 taz kernel: ACPI: PCI Interrupt Link [LNK3] enabled at IRQ 11
Sep 22 15:29:42 taz kernel: ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 11 (level, low) -> IRQ 11
Sep 22 15:29:42 taz kernel: eth0: RTL-8139C+ at 0xdf8de000, 00:08:02:f2:52:e1, IRQ 11

lspci -v
--------
0000:00:00.0 Host bridge: ATI Technologies Inc AGP Bridge [IGP 320M] (rev 13)
	Flags: bus master, 66MHz, medium devsel, latency 64
	Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Memory at f4400000 (32-bit, prefetchable) [size=4K]
	I/O ports at 8090 [disabled] [size=4]
	Capabilities: <available only to root>

0000:00:01.0 PCI bridge: ATI Technologies Inc PCI Bridge [IGP 320M] (rev 01) (prog-if 00 [Normal decode])
	Flags: bus master, 66MHz, medium devsel, latency 99
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: f4100000-f41fffff
	Prefetchable memory behind bridge: f6000000-f7ffffff

0000:00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
	Subsystem: ALi Corporation USB 1.1 Controller
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at f4010000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

0000:00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
	Subsystem: ALi Corporation ALI M1533 Aladdin IV ISA Bridge
	Flags: bus master, medium devsel, latency 0
	Capabilities: <available only to root>

0000:00:08.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link Controller Audio Device (rev 02)
	Subsystem: Compaq Computer Corporation: Unknown device 00b0
	Flags: bus master, medium devsel, latency 64, IRQ 5
	I/O ports at 8400 [size=256]
	Memory at f4011000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

0000:00:0a.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 02)
	Subsystem: Compaq Computer Corporation: Unknown device 00b0
	Flags: bus master, medium devsel, latency 168, IRQ 10
	Memory at ffbfe000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 1: 1f000000-1f3ff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	16-bit legacy interface ports at 0001

0000:00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 20)
	Subsystem: Compaq Computer Corporation: Unknown device 00b0
	Flags: bus master, medium devsel, latency 64, IRQ 11
	I/O ports at 8800 [size=256]
	Memory at f4013000 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

0000:00:0c.0 Communication controller: Conexant HSF 56k HSFi Modem (rev 01)
	Subsystem: Compaq Computer Corporation: Unknown device 8d89
	Flags: medium devsel, IRQ 10
	Memory at f4000000 (32-bit, non-prefetchable) [size=64K]
	I/O ports at 8098 [size=8]
	Capabilities: <available only to root>

0000:00:0f.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
	Subsystem: ALi Corporation USB 1.1 Controller
	Flags: medium devsel, IRQ 11
	Memory at f4012000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

0000:00:10.0 IDE interface: ALi Corporation M5229 IDE (rev c4) (prog-if fa)
	Subsystem: ALi Corporation M5229 IDE
	Flags: bus master, medium devsel, latency 32
	I/O ports at 8080 [size=16]
	Capabilities: <available only to root>

0000:00:11.0 Bridge: ALi Corporation M7101 Power Management Controller [PMU]
	Subsystem: ALi Corporation M7101 Power Management Controller [PMU]
	Flags: medium devsel

0000:01:05.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility U1 (prog-if 00 [VGA])
	Subsystem: Compaq Computer Corporation: Unknown device 00b0
	Flags: bus master, stepping, fast Back2Back, 66MHz, medium devsel, latency 66, IRQ 10
	Memory at f6000000 (32-bit, prefetchable) [size=32M]
	I/O ports at 9000 [size=256]
	Memory at f4100000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: <available only to root>


-- 
Nuno Ferreira

