Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265294AbUBPA34 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 19:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265310AbUBPA34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 19:29:56 -0500
Received: from [217.7.64.198] ([217.7.64.198]:53382 "EHLO mx1.net4u.de")
	by vger.kernel.org with ESMTP id S265294AbUBPA3i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 19:29:38 -0500
From: Ernst Herzberg <earny@net4u.de>
Reply-To: earny@net4u.de
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Linux 2.6.3-rc3
Date: Mon, 16 Feb 2004 01:29:32 +0100
User-Agent: KMail/1.6
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0402141931050.14025@home.osdl.org> <200402160033.43438.earny@net4u.de> <1076889243.11392.130.camel@gaston>
In-Reply-To: <1076889243.11392.130.camel@gaston>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_s7AMAgrIa0PZBCF"
Message-Id: <200402160129.32011.earny@net4u.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_s7AMAgrIa0PZBCF
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Montag, 16. Februar 2004 00:54, Benjamin Herrenschmidt wrote:
> On Mon, 2004-02-16 at 10:33, Ernst Herzberg wrote:
> > On Montag, 16. Februar 2004 00:08, you wrote:
> > > It couldn't mmap the framebuffer, the problem is that you have run
> > > out of kernel virtual space. I'll try to find a workaround, but in
> > > the meantime, you need to change the lowmem/highmem ratio.
>
> Can you try this patch ?

Yupp :-)

Direct hit.

Works immediatly. Ok, with some little cosmetic problems: Direct after boot 
you can see for (less than?)  ~1/10 sec the kernel screen in normal 25/80 
resolution. After that you see the Pinguin on the top with funny blinking 
characters on the bottom, following with the normal boot messages. The 
funny characters scrolls out  normaly... look like that a random screen 
with resolution 25/80 are inserted when the fb are initialized...


Thanks (:o

~Earny

PS: dmesg for reference attached.

> ===== drivers/video/aty/radeon_base.c 1.3 vs edited =====
> --- 1.3/drivers/video/aty/radeon_base.c	Sat Feb 14 23:00:22 2004
> +++ edited/drivers/video/aty/radeon_base.c	Mon Feb 16 10:53:27 2004
> @@ -99,6 +99,8 @@
>  #include "ati_ids.h"
>  #include "radeonfb.h"
>
> +#define MAX_MAPPED_VRAM	(2048*2048*4)
> +#define MIN_MAPPED_VRAM	(1024*768*1)
>
>  #define CHIP_DEF(id, family, flags)					\
>  	{ PCI_VENDOR_ID_ATI, id, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (flags) |
> (CHIP_FAMILY_##family) } @@ -566,8 +568,9 @@
>  		break;
>  	}
>
> -	do_div(vclk, 1000);
> -	xtal = (xtal * denom) / num;
> +	vclk *= denom;
> +	do_div(vclk, 1000 * num);
> +	xtal = vclk;
>
>  	if ((xtal > 26900) && (xtal < 27100))
>  		xtal = 2700;
> @@ -825,6 +828,9 @@
>  		v.xres_virtual = (pitch << 6) / ((v.bits_per_pixel + 1) / 8);
>  	}
>
> +	if (((v.xres_virtual * v.yres_virtual * nom) / den) >
> rinfo->mapped_vram) +		return -EINVAL;
> +
>  	if (v.xres_virtual < v.xres)
>  		v.xres = v.xres_virtual;
>
> @@ -1685,6 +1691,67 @@
>
>
>
> +static ssize_t radeonfb_read(struct file *file, char *buf, size_t
> count, loff_t *ppos) +{
> +	unsigned long p = *ppos;
> +	struct inode *inode = file->f_dentry->d_inode;
> +	int fbidx = iminor(inode);
> +	struct fb_info *info = registered_fb[fbidx];
> +	struct radeonfb_info *rinfo = info->par;
> +
> +	if (p >= rinfo->mapped_vram)
> +	    return 0;
> +	if (count >= rinfo->mapped_vram)
> +	    count = rinfo->mapped_vram;
> +	if (count + p > rinfo->mapped_vram)
> +		count = rinfo->mapped_vram - p;
> +	radeonfb_sync(info);
> +	if (count) {
> +	    char *base_addr;
> +
> +	    base_addr = info->screen_base;
> +	    count -= copy_to_user(buf, base_addr+p, count);
> +	    if (!count)
> +		return -EFAULT;
> +	    *ppos += count;
> +	}
> +	return count;
> +}
> +
> +static ssize_t radeonfb_write(struct file *file, const char *buf,
> size_t count, +			      loff_t *ppos)
> +{
> +	unsigned long p = *ppos;
> +	struct inode *inode = file->f_dentry->d_inode;
> +	int fbidx = iminor(inode);
> +	struct fb_info *info = registered_fb[fbidx];
> +	struct radeonfb_info *rinfo = info->par;
> +	int err;
> +
> +	if (p > rinfo->mapped_vram)
> +	    return -ENOSPC;
> +	if (count >= rinfo->mapped_vram)
> +	    count = rinfo->mapped_vram;
> +	err = 0;
> +	if (count + p > rinfo->mapped_vram) {
> +	    count = rinfo->mapped_vram - p;
> +	    err = -ENOSPC;
> +	}
> +	radeonfb_sync(info);
> +	if (count) {
> +	    char *base_addr;
> +
> +	    base_addr = info->screen_base;
> +	    count -= copy_from_user(base_addr+p, buf, count);
> +	    *ppos += count;
> +	    err = -EFAULT;
> +	}
> +	if (count)
> +		return count;
> +	return err;
> +}
> +
> +
>  static struct fb_ops radeonfb_ops = {
>  	.owner			= THIS_MODULE,
>  	.fb_check_var		= radeonfb_check_var,
> @@ -1697,6 +1764,8 @@
>  	.fb_fillrect		= radeonfb_fillrect,
>  	.fb_copyarea		= radeonfb_copyarea,
>  	.fb_imageblit		= radeonfb_imageblit,
> +	.fb_read		= radeonfb_read,
> +	.fb_write		= radeonfb_write,
>  	.fb_cursor		= soft_cursor,
>  };
>
> @@ -2121,11 +2190,27 @@
>
>  	RTRACE("radeonfb: probed %s %ldk videoram\n", (rinfo->ram_type),
> (rinfo->video_ram/1024));
>
> -	rinfo->fb_base = (unsigned long) ioremap (rinfo->fb_base_phys,
> rinfo->video_ram); +	rinfo->mapped_vram = MAX_MAPPED_VRAM;
> +	if (rinfo->video_ram < rinfo->mapped_vram)
> +		rinfo->mapped_vram = rinfo->video_ram;
> +	for (;;) {
> +		rinfo->fb_base = (unsigned long) ioremap (rinfo->fb_base_phys,
> +							  rinfo->mapped_vram);
> +		if (rinfo->fb_base == 0 && rinfo->mapped_vram > MIN_MAPPED_VRAM) {
> +			rinfo->mapped_vram /= 2;
> +			continue;
> +		}
> +		break;
> +	}
> +
>  	if (!rinfo->fb_base) {
>  		printk (KERN_ERR "radeonfb: cannot map FB\n");
>  		goto unmap_rom;
>  	}
> +
> +	RTRACE("radeonfb: mapped %ldk videoram\n", rinfo->mapped_vram/1024);
> +
> +
>  	/* Argh. Scary arch !!! */
>  #ifdef CONFIG_PPC64
>  	rinfo->fb_base = IO_TOKEN_TO_ADDR(rinfo->fb_base);
> ===== drivers/video/aty/radeonfb.h 1.2 vs edited =====
> --- 1.2/drivers/video/aty/radeonfb.h	Fri Feb 13 03:10:47 2004
> +++ edited/drivers/video/aty/radeonfb.h	Mon Feb 16 10:50:42 2004
> @@ -282,6 +282,7 @@
>  	u8			family;
>  	u8			rev;
>  	unsigned long		video_ram;
> +	unsigned long		mapped_vram;
>
>  	int			pitch, bpp, depth;

--Boundary-00=_s7AMAgrIa0PZBCF
Content-Type: text/plain;
  charset="iso-8859-1";
  name="dm"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dm"

Linux version 2.6.3-rc3 (root@earny) (gcc version 3.3.2 20031218 (Gentoo Linux 3.3.2-r5, propolice-3.3-7)) #1 Mon Feb 16 01:07:30 CET 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fffc000 (usable)
 BIOS-e820: 000000003fffc000 - 000000003ffff000 (ACPI data)
 BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Warning only 896MB will be used.
Use a HIGHMEM enabled kernel.
896MB LOWMEM available.
On node 0 totalpages: 229376
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                      ) @ 0x000f5f60
ACPI: RSDT (v001 ASUS   A7V8X-X  0x42302e31 MSFT 0x31313031) @ 0x3fffc000
ACPI: FADT (v001 ASUS   A7V8X-X  0x42302e31 MSFT 0x31313031) @ 0x3fffc0b2
ACPI: BOOT (v001 ASUS   A7V8X-X  0x42302e31 MSFT 0x31313031) @ 0x3fffc030
ACPI: MADT (v001 ASUS   A7V8X-X  0x42302e31 MSFT 0x31313031) @ 0x3fffc058
ACPI: DSDT (v001   ASUS A7V8X-X  0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI BALANCE SET
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Kernel command line: root=/dev/hda1 video=radeonfb:1280x1024
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 1990.658 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 904252k/917504k available (2203k kernel code, 12504k reserved, 849k data, 156k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3923.96 BogoMIPS
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0383fbff c1c3fbff 00000000 00000020
CPU: AMD Athlon(TM) XP 2400+ stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1989.0964 MHz.
..... host bus clock speed is 265.0328 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf1990, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040116
IOAPIC[0]: Set PCI routing entry (2-9 -> 0x71 -> IRQ 9 Mode:1 Active:1)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 *10 11 12)
ACPI: PCI Interrupt Link [LNKF] (IRQs *3 4 5 6 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xa9 -> IRQ 17 Mode:1 Active:1)
00:00:07[A] -> 2-17 -> IRQ 17
Pin 2-17 already programmed
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xb1 -> IRQ 18 Mode:1 Active:1)
00:00:09[A] -> 2-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xb9 -> IRQ 19 Mode:1 Active:1)
00:00:0c[A] -> 2-19 -> IRQ 19
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xc1 -> IRQ 16 Mode:1 Active:1)
00:00:0c[B] -> 2-16 -> IRQ 16
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
IOAPIC[0]: Set PCI routing entry (2-21 -> 0xc9 -> IRQ 21 Mode:1 Active:1)
00:00:10[A] -> 2-21 -> IRQ 21
Pin 2-21 already programmed
Pin 2-21 already programmed
Pin 2-21 already programmed
IOAPIC[0]: Set PCI routing entry (2-22 -> 0xd1 -> IRQ 22 Mode:1 Active:1)
00:00:11[C] -> 2-22 -> IRQ 22
IOAPIC[0]: Set PCI routing entry (2-23 -> 0xd9 -> IRQ 23 Mode:1 Active:1)
00:00:12[A] -> 2-23 -> IRQ 23
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178003
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0003
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  0    1    0   1   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 001 01  1    1    0   1   0    1    1    C1
 11 001 01  1    1    0   1   0    1    1    A9
 12 001 01  1    1    0   1   0    1    1    B1
 13 001 01  1    1    0   1   0    1    1    B9
 14 03D 0D  1    0    0   0   0    0    2    8B
 15 001 01  1    1    0   1   0    1    1    C9
 16 001 01  1    1    0   1   0    1    1    D1
 17 001 01  1    1    0   1   0    1    1    D9
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9-> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ21 -> 0:21
IRQ22 -> 0:22
IRQ23 -> 0:23
.................................... done.
ACPI: No IRQ known for interrupt pin A of device 0000:00:11.1 - using IRQ 255
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=325.00 Mhz, System=203.00 MHz
radeonfb: Monitor 1 type CRT found
radeonfb: EDID probed
radeonfb: Monitor 2 type no found
Monitor Operating Limits: From EDID
     H: 30-83KHz V: 50-75Hz DCLK: 140MHz
radeonfb: ATI Radeon AQ  SDR SGRAM 128 MB
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
apm: BIOS version 1.2 Flags 0x0b (Driver version 1.16ac)
apm: overridden by ACPI.
ikconfig 0.7 with /proc/config*
VFS: Disk quotas dquot_6.5.1
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
PCI: Via IRQ fixup for 0000:00:10.0, from 10 to 5
PCI: Via IRQ fixup for 0000:00:10.1, from 10 to 5
PCI: Via IRQ fixup for 0000:00:10.2, from 10 to 5
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
Console: switching to colour frame buffer device 160x64
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA KT400/KT400A/KT600 chipset
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: AGP aperture is 64M @ 0xf8000000
[drm] Initialized radeon 1.9.0 20020828 on minor 0
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
via-rhine.c:v1.10-LK1.1.19-2.5  July-12-2003  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
eth0: VIA VT6102 Rhine-II at 0xbe000000, 00:0e:a6:33:28:fc, IRQ 23.
eth0: MII PHY found at address 1, status 0x786d advertising 01e1 Link 45e1.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
ACPI: No IRQ known for interrupt pin A of device 0000:00:11.1 - using IRQ 255
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xa800-0xa807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xa808-0xa80f, BIOS settings: hdc:DMA, hdd:pio
hda: Maxtor 6Y060L0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: HL-DT-ST GCE-8525B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 120103200 sectors (61492 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(133)
 /dev/ide/host0/bus0/target0/lun0: p1 p2
hdc: ATAPI 52X CD-ROM CD-R/RW CD-MRW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
Console: switching to colour frame buffer device 160x64
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
i2c /dev entries driver
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda1) for (hda1)
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 156k freed
Adding 2433836k swap on /dev/hda2.  Priority:-1 extents:1
PCI: Setting latency timer of device 0000:00:11.5 to 64
codec_read: codec 0 is not valid [0x87e5370]
codec_read: codec 0 is not valid [0x87e5370]
codec_read: codec 0 is not valid [0x87e5370]
codec_read: codec 0 is not valid [0x87e5370]
eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.

--Boundary-00=_s7AMAgrIa0PZBCF--
