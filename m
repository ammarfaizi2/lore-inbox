Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267351AbUHTEr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267351AbUHTEr0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 00:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267344AbUHTEr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 00:47:26 -0400
Received: from web14925.mail.yahoo.com ([216.136.225.11]:63601 "HELO
	web14925.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267351AbUHTEqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 00:46:37 -0400
Message-ID: <20040820044635.42969.qmail@web14925.mail.yahoo.com>
Date: Thu, 19 Aug 2004 21:46:35 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: legacy VGA device requirements (was: Exposing ROM's though sysfs)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Torrey Hoffman <thoffman@arnor.net>,
       lkml <linux-kernel@vger.kernel.org>,
       Alex Romosan <romosan@sycorax.lbl.gov>, Dave Airlie <airlied@linux.ie>
In-Reply-To: <1092497235.27144.10.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attached is a real world reason why we need a VGA control device.
VesaFB loads and marks the VGA screen region as reserved. The driver
does not attach to any device.

My new radeon DRM driver load and says no one is using the radeon card,
so it can drive it. Radeon loads and fails. It can attach the PCI
device but it can't reserve the memory block.

The short term fix for this is to make VesaFB aware of the PCI ROM
patch. The PCI ROM patch makes it possible to identify the boot video
device. Once VesaFB can identify the boot video device it can properly
attach itself to both the device and memory. Then DRM radeon loads
after vesafb it will find the PCI device already has a driver attached
and revert back into stealth compatibility mode.

Long term we need the vga control device and a unified DRM/fbdev.

The immediate work around is to use the radeonfb driver instead of
vesafb. The radeonfb driver marks the PCI device in use and triggers
stealth mode in radeon.


--- Alex Romosan <romosan@sycorax.lbl.gov> wrote:
> To: Dave Airlie <airlied@linux.ie>
> CC: dri-devel@lists.sourceforge.net
> Subject: Re: r200 oops
> From: Alex Romosan <romosan@sycorax.lbl.gov>
> Date: Thu, 19 Aug 2004 17:59:51 -0700
> 
> Dave Airlie <airlied@linux.ie> writes:
> 
> > can you insert the module with drm_opts=debug option and see what
> it
> > says..
> 
> [drm] Debug messages ON
> ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 4 (level, low) -> IRQ 4
> [drm:radeon_register_regions] *ERROR* cannot reserve FB region
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000000
>  printing eip:
> e1195520
> *pde = 00000000
> Oops: 0002 [#1]
> PREEMPT
> Modules linked in: radeon sd_mod scsi_mod autofs4 microcode aes_i586
> airo ehci_hcd uhci_hcd usbcore parport_pc parport irtty_sir sir_dev
> irda crc_ccitt joydev evdev nls_iso8859_1 ntfs yenta_socket
> CPU:    0
> EIP:    0060:[<e1195520>]    Not tainted
> EFLAGS: 00010246   (2.6.8.1)
> EIP is at radeon_stub_putminor+0x20/0x110 [radeon]
> eax: 00000000   ebx: 00000000   ecx: 00000000   edx: 00000000
> esi: 00000000   edi: ffffffea   ebp: dc479e6c   esp: dc479e5c
> ds: 007b   es: 007b   ss: 0068
> Process insmod (pid: 2118, threadinfo=dc478000 task=df6e0cd0)
> Stack: dc479e78 00000000 00000000 00000000 dc479e84 e1195913 e11a363a
> e11a00f3
>        00000000 e11ab9e0 dc479ed0 e1191488 e11a37f0 e119fed0 dc479eac
> c017c056
>        41254b8f dbbab424 db054540 00000000 e11a9e18 c15c9c00 00000000
> dbbab424
> Call Trace:
>  [<c010545a>] show_stack+0x7a/0x90
>  [<c01055d9>] show_registers+0x149/0x1a0
>  [<c010576d>] die+0x8d/0x100
>  [<c0114465>] do_page_fault+0x1e5/0x567
>  [<c01050f5>] error_code+0x2d/0x38
>  [<e1195913>] radeon_stub_unregister+0x33/0x60 [radeon]
>  [<e1191488>] drm_probe+0x208/0x270 [radeon]
>  [<c01cc9d9>] pci_device_probe_static+0x49/0x60
>  [<c01cca27>] __pci_device_probe+0x37/0x50
>  [<c01cca66>] pci_device_probe+0x26/0x50
>  [<c0211f75>] bus_match+0x35/0x70
>  [<c02120a9>] driver_attach+0x59/0x90
>  [<c021254c>] bus_add_driver+0x8c/0xb0
>  [<c0212a6b>] driver_register+0x2b/0x30
>  [<c01ccc99>] pci_register_driver+0x59/0x80
>  [<e0fee09d>] drm_init+0x9d/0xd7 [radeon]
>  [<c012e178>] sys_init_module+0xf8/0x210
>  [<c0104f4b>] syscall_call+0x7/0xb
> Code: c7 04 10 00 00 00 00 a1 f0 d7 1a e1 89 4c 10 04 a1 f0 d7 1a
>  Segmentation fault
> 
> > can you also send on lspci -v and the contents of /proc/iomem
> 
> lspci -v:
> 
> 0000:00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O
> Controller (rev 03)
> 	Subsystem: IBM: Unknown device 0529
> 	Flags: bus master, fast devsel, latency 0
> 	Memory at d0000000 (32-bit, prefetchable) [size=256M]
> 	Capabilities: [e4] #09 [f104]
> 	Capabilities: [a0] AGP version 2.0
> 
> 0000:00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP
> Controller (rev 03) (prog-if 00 [Normal decode])
> 	Flags: bus master, 66MHz, fast devsel, latency 96
> 	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
> 	I/O behind bridge: 00003000-00003fff
> 	Memory behind bridge: c0100000-c01fffff
> 	Prefetchable memory behind bridge: e0000000-e7ffffff
> 
> 0000:00:1d.0 USB Controller: Intel Corp. 82801DB/DBL/DBM
> (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 01) (prog-if 00
> [UHCI])
> 	Subsystem: IBM: Unknown device 052d
> 	Flags: bus master, medium devsel, latency 0, IRQ 4
> 	I/O ports at 1800 [size=32]
> 
> 0000:00:1d.1 USB Controller: Intel Corp. 82801DB/DBL/DBM
> (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 01) (prog-if 00
> [UHCI])
> 	Subsystem: IBM: Unknown device 052d
> 	Flags: bus master, medium devsel, latency 0, IRQ 9
> 	I/O ports at 1820 [size=32]
> 
> 0000:00:1d.2 USB Controller: Intel Corp. 82801DB/DBL/DBM
> (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 01) (prog-if 00
> [UHCI])
> 	Subsystem: IBM: Unknown device 052d
> 	Flags: bus master, medium devsel, latency 0, IRQ 6
> 	I/O ports at 1840 [size=32]
> 
> 0000:00:1d.7 USB Controller: Intel Corp. 82801DB/DBM (ICH4/ICH4-M)
> USB 2.0 EHCI Controller (rev 01) (prog-if 20 [EHCI])
> 	Subsystem: IBM: Unknown device 052e
> 	Flags: bus master, medium devsel, latency 0, IRQ 11
> 	Memory at c0000000 (32-bit, non-prefetchable) [size=1K]
> 	Capabilities: [50] Power Management version 2
> 	Capabilities: [58] #0a [2080]
> 
> 0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 81)
> (prog-if 00 [Normal decode])
> 	Flags: bus master, fast devsel, latency 0
> 	Bus: primary=00, secondary=02, subordinate=08, sec-latency=64
> 	I/O behind bridge: 00004000-00008fff
> 	Memory behind bridge: c0200000-cfffffff
> 	Prefetchable memory behind bridge: e8000000-efffffff
> 
> 0000:00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface
> Controller (rev 01)
> 	Flags: bus master, medium devsel, latency 0
> 
> 0000:00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA
> Storage Controller (rev 01) (prog-if 8a [Master SecP PriP])
> 	Subsystem: IBM: Unknown device 052d
> 	Flags: bus master, medium devsel, latency 0, IRQ 6
> 	I/O ports at <unassigned>
> 	I/O ports at <unassigned>
> 	I/O ports at <unassigned>
> 	I/O ports at <unassigned>
> 	I/O ports at 1860 [size=16]
> 	Memory at 20000000 (32-bit, non-prefetchable) [size=1K]
> 
> 0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
> SMBus Controller (rev 01)
> 	Subsystem: IBM: Unknown device 052d
> 	Flags: medium devsel, IRQ 5
> 	I/O ports at 1880 [size=32]
> 
> 0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM
> (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 01)
> 	Subsystem: IBM: Unknown device 0537
> 	Flags: bus master, medium devsel, latency 0, IRQ 5
> 	I/O ports at 1c00 [size=256]
> 	I/O ports at 18c0 [size=64]
> 	Memory at c0000c00 (32-bit, non-prefetchable) [size=512]
> 	Memory at c0000800 (32-bit, non-prefetchable) [size=256]
> 	Capabilities: [50] Power Management version 2
> 
> 0000:00:1f.6 Modem: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
> AC'97 Modem Controller (rev 01) (prog-if 00 [Generic])
> 	Subsystem: IBM: Unknown device 0525
> 	Flags: bus master, medium devsel, latency 0, IRQ 5
> 	I/O ports at 2400 [size=256]
> 	I/O ports at 2000 [size=128]
> 	Capabilities: [50] Power Management version 2
> 
> 0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon
> R250 Lf [Radeon Mobility 9000 M9] (rev 02) (prog-if 00 [VGA])
> 	Subsystem: IBM: Unknown device 0531
> 	Flags: bus master, stepping, fast Back2Back, 66MHz, medium devsel,
> latency 66, IRQ 4
> 	Memory at e0000000 (32-bit, prefetchable) [size=128M]
> 	I/O ports at 3000 [size=256]
> 	Memory at c0100000 (32-bit, non-prefetchable) [size=64K]
> 	Capabilities: [58] AGP version 2.0
> 	Capabilities: [50] Power Management version 2
> 
> 0000:02:00.0 CardBus bridge: Texas Instruments PCI1520 PC card
> Cardbus Controller (rev 01)
> 	Subsystem: IBM ThinkPad T30/T40
> 	Flags: bus master, medium devsel, latency 168, IRQ 4
> 	Memory at b0000000 (32-bit, non-prefetchable) [size=4K]
> 	Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
> 	Memory window 0: 20400000-207ff000 (prefetchable)
> 	Memory window 1: 20800000-20bff000
> 	I/O window 0: 00004000-000040ff
> 	I/O window 1: 00004400-000044ff
> 	16-bit legacy interface ports at 0001
> 
> 0000:02:00.1 CardBus bridge: Texas Instruments PCI1520 PC card
> Cardbus Controller (rev 01)
> 	Subsystem: IBM ThinkPad T30/T40
> 	Flags: bus master, medium devsel, latency 168, IRQ 5
> 	Memory at b1000000 (32-bit, non-prefetchable) [size=4K]
> 	Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
> 	Memory window 0: 20c00000-20fff000 (prefetchable)
> 	Memory window 1: 21000000-213ff000
> 	I/O window 0: 00004800-000048ff
> 	I/O window 1: 00004c00-00004cff
> 	16-bit legacy interface ports at 0001
> 
> 0000:02:01.0 Ethernet controller: Intel Corp. 82540EP Gigabit
> Ethernet Controller (Mobile) (rev 03)
> 	Subsystem: IBM PRO/1000 MT Mobile Connection
> 	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 4
> 	Memory at c0220000 (32-bit, non-prefetchable) [size=128K]
> 	Memory at c0200000 (32-bit, non-prefetchable) [size=64K]
> 	I/O ports at 8400 [size=64]
> 	Capabilities: [dc] Power Management version 2
> 	Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0
> Enable-
> 
> 0000:02:02.0 Network controller: AIRONET Wireless Communications
> Cisco Aironet Wireless 802.11b
> 	Subsystem: AIRONET Wireless Communications: Unknown device 5000
> 	Flags: bus master, fast devsel, latency 64, IRQ 6
> 	I/O ports at 8000 [size=256]
> 	Memory at c0210000 (32-bit, non-prefetchable) [size=16K]
> 	Memory at c0400000 (32-bit, non-prefetchable) [size=4M]
> 	Capabilities: [40] Power Management version 2
> 	Capabilities: [48] Vital Product Data
> 
> /proc/iomem:
> 
> 00000000-0009efff : System RAM
> 0009f000-0009ffff : reserved
> 000a0000-000bffff : Video RAM area
> 000c0000-000cffff : Video ROM
> 000e0000-000effff : Extension ROM
> 000f0000-000fffff : System ROM
> 00100000-1ff5ffff : System RAM
>   00100000-003056de : Kernel code
>   003056df-003dd13f : Kernel data
> 1ff60000-1ff76fff : ACPI Tables
> 1ff77000-1ff78fff : ACPI Non-volatile Storage
> 1ff80000-1fffffff : reserved
> 20000000-200003ff : 0000:00:1f.1
> 20400000-207fffff : PCI CardBus #03
> 20800000-20bfffff : PCI CardBus #03
> 20c00000-20ffffff : PCI CardBus #07
> 21000000-213fffff : PCI CardBus #07
> b0000000-b0000fff : 0000:02:00.0
>   b0000000-b0000fff : yenta_socket
> b1000000-b1000fff : 0000:02:00.1
>   b1000000-b1000fff : yenta_socket
> c0000000-c00003ff : 0000:00:1d.7
>   c0000000-c00003ff : ehci_hcd
> c0000800-c00008ff : 0000:00:1f.5
>   c0000800-c00008ff : Intel 82801DB-ICH4 - Controller
> c0000c00-c0000dff : 0000:00:1f.5
>   c0000c00-c0000dff : Intel 82801DB-ICH4 - AC'97
> c0100000-c01fffff : PCI Bus #01
>   c0100000-c010ffff : 0000:01:00.0
>     c0100000-c010ffff : radeon
> c0200000-c020ffff : 0000:02:01.0
>   c0200000-c020ffff : e1000
> c0210000-c0213fff : 0000:02:02.0
>   c0210000-c0213fff : eth1
> c0220000-c023ffff : 0000:02:01.0
>   c0220000-c023ffff : e1000
> c0400000-c07fffff : 0000:02:02.0
>   c0400000-c043ffff : eth1
> d0000000-dfffffff : 0000:00:00.0
> e0000000-e7ffffff : PCI Bus #01
>   e0000000-e7ffffff : 0000:01:00.0
>     e0000000-e059b8bf : vesafb
> ff800000-ffffffff : reserved
> 
> i am sending the laptop back to ibm so i won't be able to run any
> tests for a while. hope this helps.
> 
> --alex--
> 
> -- 
> | I believe the moment is at hand when, by a paranoiac and active |
> |  advance of the mind, it will be possible (simultaneously with  |
> |  automatism and other passive states) to systematize confusion  |
> |  and thus to help to discredit completely the world of reality. |
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank
> Media
> 100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
> Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
> http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
> --
> _______________________________________________
> Dri-devel mailing list
> Dri-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/dri-devel
> 

=====
Jon Smirl
jonsmirl@yahoo.com


		
__________________________________
Do you Yahoo!?
Yahoo! Mail is new and improved - Check it out!
http://promotions.yahoo.com/new_mail
