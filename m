Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbTLTEQm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 23:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263805AbTLTEQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 23:16:41 -0500
Received: from csbd.org ([66.220.23.20]:52897 "EHLO csbd.org")
	by vger.kernel.org with ESMTP id S263795AbTLTEQh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 23:16:37 -0500
To: wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: Re: 2.6.0 fails to complete boot - Sony VAIO laptop
Date: Fri Dec 19 20:09:53 2003
Content-Type: text/plain; charset="utf8"
Content-Transfer-Encoding: 7bit
Message-Id: <20031220040953.9C35D1E030CA3@csbd.org>
From: atp@csbd.org (Alexander Poquet)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey folks.

On Fri, 19 Dec 2003 02:28:21 -0800, William Lee Irwin III wrote:
> The hardware solution is better, but I'll settle for anything you can
> get that way.

Not having a hardware solution at my disposal, I copied the dmesg by hand from
the screen, giving myself screenfuls by hacking null while loops into various
places.  I've attached it below; as it was copied by hand there may be a typo
or two but I was as careful as possible.  There are a few lines that I did not
get, at the very beginning, because the last place I could put a hang was after
console_init() in start_kernel() -- if information from up there is needed,
I can probably hack printk.  It doesn't look too hard but I didn't want to mess
with it unless someone requires the information.

As is evident from the dmesg, the blank out happens while doing an isapnp
scan.  Now, I'm wondering why I have isapnp configured -- I think it has
something to do with 16-bit PCMCIA cards, but I can't remember exactly -- but
at any rate as stock kernels are likely to have it setup perhaps this is a bug
that should be ironed out.  I haven't tried compiling the kernel without
isapnp support, but I can do that if you think the bug is a symptom of something
else and not a fsck-up in the isapnp code itself.  At any rate, the exact
function call that generates the black out is in drivers/pnp/isapnp/core.c,
on line 1132 (or just about).  The code in question (it's in isapnp_init()):

        isapnp_detected = 1;
        if (isapnp_rdp < 0x203 || isapnp_rdp > 0x3ff) {
                cards = isapnp_isolate();
                if (cards < 0 ||
                    (isapnp_rdp < 0x203 || isapnp_rdp > 0x3ff)) {
#ifdef ISAPNP_REGION_OK
                        release_region(_PIDXR, 1);
#endif
----------------->      release_region(_PNPWRP, 1);
                        isapnp_detected = 0;
                        printk(KERN_INFO "isapnp: No Plug & Play device found\n");
                        return 0;
                }
                request_region(isapnp_rdp, 1, "isapnp read");
        }
        isapnp_build_device_list();

The corresponding request_region is a little bit higher up in the function.
Why would releasing the region cause a console blank?

WRT to the console blank, it was very much as if the card jumped out of text
mode, or something.  The monitor felt ... weird.  (I'm connecting to my laptop
using an external monitor; the Sony VAIO model I have, the PCG-F450, has a
documented issue with its LCD panel).  I'm not exactly sure how to put it into
words, but it was like doing "SCREEN 9" in BASICA back on DOS.  Like it jumped
into a graphics mode, or something.

The boot obviously doesn't continue -- does that imply that the kernel panics
after the console black out?  Without a serial cable I can't be sure that
there isn't more stuff being printed after the console black out that might be
useful.  Any ideas on how to deal with this would be appreciated.

Oh, and also, what does that address space collision stuff in the PCI init
portion of the dmesg mean?  Should I be worried about that?

Alexander

dmesg follows...
-------------------------------------------------------------------------------
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000eb000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007ff0000 (usable)
 BIOS-e820: 0000000007ff0000 - 0000000007fffc00 (ACPI data)
 BIOS-e820: 0000000007fffc00 - 0000000008000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
127MB LOWMEM available.
On node 0 totalpages: 32752
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 28656 pages, LIFO batch:6
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.1 present.
Sony Vaio laptop detected.
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=Linux ro root=301
Local APIC disabled by BIOS -- reenabling.
Could not enable APIC!
Initializing CPU#0
PID hash table entries: 512 (order 9: 4096 bytes)
Detected 496.456 MHz processor.
Console: colour VGA+ 80x25
Memory: 125336k/131008k available (2581k kernel code, 5116k reserved, 893k data, 164k init, 0k highmem)
Calibrating delay loop... 980.99 BogoMIPS
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Coppermine) stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd99e, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0x00f71f0
pnp: 00:00: ioport range 0x398-0x399 has been reserved
pnp: 00:00: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:00: ioport range 0x8000-0x804f has been reserved
pnp: 00:00: ioport range 0x1040-0x104f has been reserved
PnPBIOS: 17 nodes reported by PnP BIOS; 17 recorded by driver
SCSI subsystem initialized
Linux Kernel Card Services
  options: [pci] [cardbus] [pm]
drivers/usb/core/usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Address space collision on region 7 of bridge 0000:00:07.3 [8000:803f]
PCI: Address space collision on region 8 of bridge 0000:00:07.3 [1040:105f]
PCI: Using IRQ router PIIX/ICH [8086/7110] at 0000:00:07.0
PCI: IRQ 0 for device 0000:00:07.2 doesn't match PIRQ mask - try pci=usepirqmask
PCI: IRQ 0 for device 0000:00:08.0 doesn't match PIRQ mask - try pci=usepirqmask
PCI: IRQ 0 for device 0000:00:0c.0 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Found IRQ 9 for device 0000:00:0c.0
PCI: IRQ 0 for device 0000:00:0c.1 doesn't match PIRQ mask - try pci=usepirqmask
NET: Registered protocol family 23
neofb: mapped io at c8800000
Autodetected external display
Panel is a 1024x768 color TFT display
neofb: mapped framebuffer at c8a01000
neofb v0.4.1: 2560kB VRAM, using 1024x768, 48.361kHz, 60Hz
fb0: MagicGraph 256AV frame buffer device
SBF: ACPI BOOT descriptor is wrong length (39)
SBF: Simple Boot Flag extension found and enabled.
SBF: Seting boot flags 0x1
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
Limiting direct PCI/PCI transfers.
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
isapnp: Scanning for PnP cards...
