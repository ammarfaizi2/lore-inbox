Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbTKRMLq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 07:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262397AbTKRMLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 07:11:46 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:51646
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S262344AbTKRMLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 07:11:38 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Patrick Mochel <mochel@osdl.org>
Subject: Re: Patrick's Test9 suspend code.
Date: Tue, 18 Nov 2003 06:02:18 -0600
User-Agent: KMail/1.5
Cc: Pavel Machek <pavel@ucw.cz>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0311170844230.12994-100000@cherise>
In-Reply-To: <Pine.LNX.4.44.0311170844230.12994-100000@cherise>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Kpgu/iRimjxpxm9"
Message-Id: <200311180602.18511.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_Kpgu/iRimjxpxm9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 17 November 2003 10:45, Patrick Mochel wrote:
> > Currently, patrick's code isn't working for me anymore either.  I think
> > it's because I haven't figured out how I had ACPI set up last time
> > (performance covernor, probably.  If I tell it to use the userspace
> > governor, there's still nothing in /sys/devices/system/cpu/cpu0, the
> > directory is empty.  Maybe the documentation isn't up to date anymore, I
> > don't know...)  When I tried to suspend with it, it sort of worked but
> > the writing to disk phase (which never caused a problem before) had a
> > visible pause between each sector written, and writing out the 3000
> > sectors took over 5 minutes, and the end result wasn't something it could
> > resume from anyway.  Sigh...
>
> Are you using preempt? There was a similar problem reported a while back
> that was solved by disabling it. Though it's not a true fix, it should at
> least get you going again.
>
> Thanks,
>
>
> 	Pat

Finally got it working again.  Disabling preempt didn't seem to fix anything, 
but I've left it off for now anyway.  Module unload support also wasn't 
selected, and that could have been causing problems too.  (It certainly 
confused cardbus and my shutdown scripts...)

The actual save part was slow because DMA was off (I had generic dma on, but 
on a laptop with an ALI M5229 IDE controller you need to enable ALI M15x9 
DMA.  Right.)  Writing out pages is AMAZINGLY slow in PIO mode, by the way.  
5 minutes vs 5 seconds kind of slow...

It then saved happily but didn't resume because I hadn't told it the default 
resume partition was /dev/hda2.  (I don't have to specify which partition to 
save to, why do I have to specify which one to resume from?  Oh well...)

And lo, I hath once again resumed!  (My copy of the suspend code still has a 
large number of printk statements in it, but at the moment I consider that a 
GOOD thing.)

On another note, here's a panic I managed to save when one of the suspend 
attempts decided to go "boing", yet dumped me back to a console that sort of 
worked for a bit until I tried to shutdown, where it hung shutting down 
pcmcia.  (Amazingly, it didn't seem to eat my filesystem when I sent dmesg to 
a file.  Go figure.)

I don't believe this has anything to do with the prink statements or config 
tweaks I was doing, this is one of those intermittent panics I mentioned 
earlier where it tries to save and bits wind up on the floor.  This is from a 
system that, right after it booted, I immediately logged in (text console 1) 
and ran my suspend script, which got as far as "sync; echo -n disk > 
/sys/power/state" and panicked trying to stop all the tasks.  X had not run.

Let me know if there's something more recent I should try...

Rob
--Boundary-00=_Kpgu/iRimjxpxm9
Content-Type: text/plain;
  charset="iso-8859-1";
  name="out.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="out.txt"

Linux version 2.6.0-test9-ook (root@localhost.localdomain) (gcc version 3.2=
=2E2 20030222 (Red Hat Linux 3.2.2-5)) #5 SMP Tue Nov 18 04:20:47 CST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000b7e0000 (usable)
 BIOS-e820: 000000000b7e0000 - 000000000b7f0000 (reserved)
 BIOS-e820: 000000000b7f0000 - 000000000b7f8000 (ACPI data)
 BIOS-e820: 000000000b7f8000 - 000000000b800000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
183MB LOWMEM available.
On node 0 totalpages: 47072
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 42976 pages, LIFO batch:10
  HighMem zone: 0 pages, LIFO batch:1
DMI not present.
ACPI: RSDP (v000 IBM                                       ) @ 0x000eab70
ACPI: RSDT (v001 IBM    AXXXXXX4 0x00000001 IBM  0x00000000) @ 0x0b7f0000
ACPI: FADT (v001 IBM    AXXXXXX4 0x00000001 IBM  0x00000000) @ 0x0b7f008c
ACPI: BOOT (v001 IBM    AXXXXXX4 0x00000001 IBM  0x00000000) @ 0x0b7f0030
ACPI: DBGP (v001 IBM    AXXXXXX4 0x00000001 IBM  0x00000000) @ 0x0b7f0058
ACPI: DSDT (v001    IBM AXXXXXX4 0x00000001 MSFT 0x0100000c) @ 0x00000000
Building zonelist for node : 0
Kernel command line: ro root=3D/dev/hda1
Local APIC disabled by BIOS -- reenabling.
Could not enable APIC!
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 697.823 MHz processor.
Console: colour VGA+ 80x25
Memory: 181736k/188288k available (2205k kernel code, 5932k reserved, 978k =
data, 152k init, 0k highmem)
Calibrating delay loop... 1368.06 BogoMIPS
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
checking if image is initramfs...it isn't (no cpio magic); looks like an in=
itrd
=46reeing initrd memory: 219k freed
CPU:     After generic identify, caps: 0383f9ff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0383f9ff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU:     After all inits, caps: 0383f9ff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel Celeron (Coppermine) stepping 06
per-CPU timeslice cutoff: 365.89 usecs.
task migration cache decay timeout: 1 msecs.
SMP motherboard not detected.
Local APIC not detected. Using dummy APIC emulation.
Starting migration thread for cpu 0
CPUS done 8
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0200, last bus=3D1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031002
ACPI: IRQ 9 was Edge Triggered, setting to Level Triggerd
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [PILA] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [PILB] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [PILC] (IRQs 1 3 4 5 *6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [PILD] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [PILE] (IRQs 1 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [PILF] (IRQs 1 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [PILG] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [PILH] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [PILI] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC0] (gpe 34)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [PILH] enabled at IRQ 11
ACPI: PCI Interrupt Link [PILC] enabled at IRQ 6
ACPI: No IRQ known for interrupt pin A of device 0000:00:10.0 - using IRQ 15
ACPI: PCI Interrupt Link [PILD] enabled at IRQ 10
ACPI: PCI Interrupt Link [PILI] enabled at IRQ 10
ACPI: PCI Interrupt Link [PILA] enabled at IRQ 10
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=3Dnoacpi' or even 'a=
cpi=3Doff'
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x80
Machine check exception polling timer started.
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LID]
ACPI: Processor [CPU0] (supports C1 C2 C3)
ACPI: Thermal Zone [THR2] (54 C)
pty: 256 Unix98 ptys configured
request_module: failed /sbin/modprobe -- parport_lowlevel. error =3D -16
lp: driver loaded but no devices found
Linux agpgart interface v0.100 (c) Dave Jones
[drm:drm_init] *ERROR* Cannot initialize the agpgart module.
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
parport0: PC-style at 0x3bc [PCSPP(,...)]
lp0: using parport0 (polling).
Using anticipatory io scheduler
=46loppy drive(s): fd0 is unknown type 12 (usb?)
floppy0: no floppy controllers found
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
hda: IBM-DJSA-220, ATA DISK drive
hdc: UJDA330, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 39070080 sectors (20003 MB) w/1874KiB Cache, CHS=3D38760/16/63
 hda: hda1 hda2 hda3
hdc: ATAPI 24X CD-ROM CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.12
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver=
 v2.1
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 19:16:36=
 2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error =3D -16
ALSA device list:
  No soundcards found.
NET: Registered protocol family 2
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET: Registered protocol family 1
NET: Registered protocol family 17
PM: Reading pmdisk image.
PM: Resume from disk failed.
ACPI: (supports S0 S1 S4 S5)
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
=46reeing unused kernel memory: 152k freed
spurious 8259A interrupt: IRQ7.
EXT3 FS on hda1, internal journal
Unable to find swap-space signature
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Unable to find swap-space signature
pcmcia_core: falsely claims to have parameter  [8=C1set_delay
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
PCI: Enabling device 0000:00:0a.0 (0000 -> 0002)
Yenta: CardBus bridge found at 0000:00:0a.0 [12a3:ab01]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta: ISA IRQ list 0000, PCI irq6
Socket status: 30000011
Yenta: CardBus bridge found at 0000:00:13.0 [1014:01a3]
Yenta: ISA IRQ list 0838, PCI irq10
Socket status: 30000007
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x2c8-0x2cf 0x3c0-0x3df 0x408-0x=
40f 0x480-0x48f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
Unable to handle kernel paging request at virtual address cc044120
 printing eip:
c0131bf3
*pde =3D 01276067
*pte =3D 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c0131bf3>]    Not tainted
EFLAGS: 00010246
EIP is at module_unload_init+0xe/0x52
eax: cc044120   ebx: cc036df0   ecx: cc043c20   edx: 00000000
esi: cc039cef   edi: cc0436ff   ebp: c4e1ff28   esp: c4e1ff28
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 920, threadinfo=3Dc4e1e000 task=3Dc4ba7310)
Stack: c4e1ff9c c0133364 cc043c20 00000000 000003e8 cb015da0 cc013000 00000=
000=20
       cc043c20 00000000 00000000 00000000 00000000 00000000 00000008 00000=
012=20
       00000010 0000000c 00000000 00000000 00000018 00000017 00000019 cc039=
3e0=20
Call Trace:
 [<c0133364>] load_module+0x4d8/0x7f7
 [<c01336fa>] sys_init_module+0x77/0x234
 [<c0108f85>] sysenter_past_esp+0x52/0x71

Code: 89 81 00 05 00 00 89 81 04 05 00 00 89 c8 42 c7 80 00 01 00=20
 Stopping tasks: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
 stopping tasks failed (1 tasks remaining)
Restarting tasks...<6> Strange, modprobe not stopped
 done

--Boundary-00=_Kpgu/iRimjxpxm9--

