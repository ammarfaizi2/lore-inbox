Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265883AbTL3SRu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 13:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265884AbTL3SRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 13:17:49 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:47118 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265883AbTL3SRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 13:17:45 -0500
Date: Tue, 30 Dec 2003 18:17:41 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: 2.6.0-test6: APM unable to suspend (the 2.6.0-test2 saga continues)
Message-ID: <20031230181741.D13556@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Vojtech Pavlik <vojtech@suse.cz>
References: <20031005171055.A21478@flint.arm.linux.org.uk> <20031228174622.A20278@flint.arm.linux.org.uk> <20031228182545.B20278@flint.arm.linux.org.uk> <Pine.LNX.4.58.0312281248190.11299@home.osdl.org> <20031230114324.A1632@flint.arm.linux.org.uk> <20031230165042.B13556@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031230165042.B13556@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Tue, Dec 30, 2003 at 04:50:42PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 30, 2003 at 04:50:42PM +0000, Russell King wrote:
> Ok, the binary search led me to a changeset between 2.5.25 and 2.5.26
> kernels.  Further investigation led me to i8042.c, specifically this:
> 
> static void __init i8042_start_polling(void)
> {
>         i8042_ctr &= ~I8042_CTR_KBDDIS;
>         if (i8042_aux_values.exists)
>                 i8042_ctr &= ~I8042_CTR_AUXDIS;
> 
>         if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
>                 printk(KERN_WARNING "i8042.c: Can't write CTR while starting polling.\n");
>                 return;
>         }
> 
> //      i8042_timer.function = i8042_timer_func;
> //      mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
> }
> 
> With the function as above, the observed behaviour is as follows:
> 
> - don't call i8042_start_polling at all - suspend works
> - call i8042_start_polling - suspend fails
> 
> It seems that my BIOS is taking exception to CTR value we're writing.
> 
> My next step will be to try this with 2.6.0 and see whether this is the
> only issue affecting APM suspend.  In the mean time, does Vojtech have
> any hints?

Ok, further info with 2.6.0:

- disabling i8042.c completely by adding return 0; to the start of
  i8042_init() allows the suspend hotkey to work, and it works
  multiple times!  The hibernate hotkey also works, but once the
  laptop has resumed from hibernate, it's no longer possible to
  suspend it.

- i8042_noaux=1 - this doesn't seem to make any difference, although
  this does appear to leave the CTR set as 0x65, which appears to be
  the BIOS-set value.

There seems to be more going on than just the CTR here - it seems that
this APM BIOS has some dislike for our i8042 driver.

Here's the boot messages under (a failing) 2.6.0:

Linux version 2.6.0 (rmk@dyn-67.arm.linux.org.uk) (gcc version 3.3.2 20031022 (Red Hat Linux 3.3.2-1)) #2 Sun Dec 28 21:16:27 GMT 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000003fd0000 (usable)
 BIOS-e820: 0000000003fd0000 - 0000000003fdf000 (ACPI data)
 BIOS-e820: 0000000003fdf000 - 0000000003fe0000 (ACPI NVS)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
63MB LOWMEM available.
On node 0 totalpages: 16336
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 12240 pages, LIFO batch:2
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.0 present.
IBM machine detected. Enabling interrupts during APM calls.
IBM machine detected. Disabling SMBus accesses.
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=linux-2.6 ro root=302 BOOT_FILE=/boot/vmlinuz-2.6.0 pci=usepirqmask
Initializing CPU#0
PID hash table entries: 256 (order 8: 2048 bytes)
Detected 232.122 MHz processor.
Console: colour VGA+ 80x25
Memory: 61716k/65344k available (1607k kernel code, 3172k reserved, 675k data, 96k init, 0k highmem)
Calibrating delay loop... 458.75 BogoMIPS
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Intel Pentium with F0 0F bug - workaround enabled.
CPU: Intel Mobile Pentium MMX stepping 01
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd880, last bus=0
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router PIIX/ICH [8086/7110] at 0000:00:06.0
PCI: Found IRQ 11 for device 0000:00:02.0
PCI: Sharing IRQ 11 with 0000:00:03.0
PCI: Found IRQ 11 for device 0000:00:02.1
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
Limiting direct PCI/PCI transfers.
pty: 256 Unix98 ptys configured
[drm] Initialized radeon 1.9.0 20020828 on minor 0
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:06.1
PIIX4: chipset revision 1
PIIX4: not 100%% native mode: will probe irqs later
    ide0: BM-DMA at 0xfcf0-0xfcf7, BIOS settings: hda:DMA, hdb:DMA
hda: IBM-DTCA-24090, ATA DISK drive
hdb: SANYO CRD-S372B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 8007552 sectors (4099 MB) w/468KiB Cache, CHS=7944/16/63, UDMA(33)
 hda: hda1 hda2 hda4 < hda5 hda6 hda7 hda8 hda9 >
end_request: I/O error, dev hdb, sector 0
hdb: ATAPI 24X CD-ROM drive, 256kB Cache
Uniform CD-ROM driver Revision: 3.12
mice: PS/2 mouse device common for all mice
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 8192)
NET: Registered protocol family 1
NET: Registered protocol family 17
BIOS EDD facility v0.10 2003-Oct-11, 1 devices found
Please report your BIOS at http://domsch.com/linux/edd30/results.html
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 96k freed


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
