Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316763AbSEaU2V>; Fri, 31 May 2002 16:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316770AbSEaU2U>; Fri, 31 May 2002 16:28:20 -0400
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:13277 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S316763AbSEaU2T>; Fri, 31 May 2002 16:28:19 -0400
Date: Fri, 31 May 2002 13:28:31 -0700
From: David Brownell <david-b@pacbell.net>
Subject: 2.5.19 (and earlier) IDE (+EXT3+???) bugs
To: linux-kernel@vger.kernel.org
Message-id: <3CF7DCEF.9050203@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to use a slightly elderly laptop for some testing
on the 2.5 kernels.  (As an ultralight, it's got some hardware
that tweaks some interesting USB/APM codepaths that don't
otherwise show up.)  It's run Linux (mostly) since I got it,
and I can install and use RH 7.3 on it, no troubles.

But it doesn't seem to want to run any recent 2.5 kernels.
I first tried with 2.5.15, and kernels up to and including
the latest (2.5.19 as I write) have the same overall failure
mode ... which does not happen with any of the 2.4 kernels
I've tried.  (No recent ones other than the RH 7.3 code,
but many earlier ones.)  Basically, I see:

- kernel loads OK ... I attach "dmesg" output.
- runs init, which runs init scripts.
- everything's fine, disk fscks as right, UNTIL ...
- ...it  blows up when remounting the root filesystem r/w
   * Takes a *long* time, if it even succeeds
   * Most of that time is evidently used to scribble over
     as much of the disk as it can!
   * If I powerdown the system very quickly, "fsck" can mostly
     recover.  If not, then both root and /boot get trashed.
- Next step is to re-install the OS again.

As a stock RH 7.3 install, this root filesystem uses ext3.

I was able to boot with "init=/bin/sh" and do some basic
testing with a read-only root FS.  Reading files works ok,
"hdparm -I" gives the same info it did under the RH7.3 kernel,
and I can use DD to read and write to the disk.  (USB works OK;
I can bring it up by hand using the "ohci-hcd" driver, which
is how I could transfer the dmesg info off this system.)

So far the only really suggestive thing I've come up with is
that if I do much disk I/O, I start to see "hda: lost interrupt"
and the operation seems to become timeout-driven.  I first
noticed that with DD, but then "fsck" of the root FS (5+MBytes)
turned up the same failure.  (The fsck took so much time I had
to kill it; running on 2.4, it quickly reported no problems.)

Does anyone know what might be going on here?  Or better yet,
have a fix to whatever it is that's wrong? :)  Seems to me there
is a clear IDE problem: lost interrupts were not an issue on
the 2.4 kernels.  Whether fixing that would make that "scribble
on the disk" problem go away, I couldn't say.

- Dave

p.s. Hardware is a Toshiba Portege 3020ct, pci host bridge
      is a "Toshiba America Info Systems 601 (rev a2)"
      according to lspci.


Linux version 2.5.19 (root@neon) (gcc version 2.96 20000731 (Red Hat Linux 7.3 
2.96-110)) #1 Thu May 30 19:40:52 PDT 2002
Video mode to be used for restore is f03
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 0000000004010000 (usable)
  BIOS-e820: 0000000004010000 - 0000000004020000 (ACPI data)
  BIOS-e820: 0000000004020000 - 0000000004040000 (reserved)
  BIOS-e820: 00000000fef80000 - 00000000ff000000 (reserved)
  BIOS-e820: 00000000ffee0000 - 00000000ffee6e00 (reserved)
  BIOS-e820: 00000000ffee6e00 - 00000000ffee7000 (ACPI NVS)
  BIOS-e820: 00000000ffee7000 - 00000000ffef0000 (reserved)
  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
64MB LOWMEM available.
On node 0 totalpages: 16400
zone(0): 4096 pages.
zone(1): 12304 pages.
zone(2): 0 pages.
Kernel command line: init=/bin/sh ro root=/dev/hda2 vga=0x0f03
Initializing CPU#0
Detected 299.947 MHz processor.
Console: colour VGA+ 80x28
Calibrating delay loop... 598.01 BogoMIPS
Memory: 62912k/65600k available (1004k kernel code, 2300k reserved, 244k data, 
216k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Before vendor init, caps: 008001bf 00000000 00000000, vendor = 0
Intel Pentium with F0 0F bug - workaround enabled.
CPU: After vendor init, caps: 008001bf 00000000 00000000 00000000
CPU:     After generic, caps: 008001bf 00000000 00000000 00000000
CPU:             Common caps: 008001bf 00000000 00000000 00000000
CPU: Intel Mobile Pentium MMX stepping 02
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfd84f, last bus=21
PCI: Using configuration type 1
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PnPBIOS: Found PnP BIOS installation structure at 0xc00f9020
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x9563, dseg 0x0
PnPBIOS: 17 nodes reported by PnP BIOS; 17 recorded by driver
PnPBIOS: PNP0c02: ioport range 0x1882-0x1885 has been reserved
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
apm: BIOS version 1.2 Flags 0x02 (Driver version 1.16)
Starting kswapd
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec: init pool 0, 1 entries, 12 bytes
biovec: init pool 1, 4 entries, 48 bytes
biovec: init pool 2, 16 entries, 192 bytes
biovec: init pool 3, 64 entries, 768 bytes
biovec: init pool 4, 128 entries, 1536 bytes
biovec: init pool 5, 256 entries, 3072 bytes
Journalled Block Device driver loaded
pty: 512 Unix98 ptys configured
Real Time Clock Driver v1.11
block: 256 slots per queue, batch=32
Floppy drive(s): fd0 is 1.44M
FDC 0 is an 8272A
ATA/ATAPI device driver v7.0.0
ATA: PCI bus speed 33.3MHz
hda: TOSHIBA MK6411MAT, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
  hda: 12685680 sectors, CHS=13424/15/63
  hda: [PTBL] [789/255/63] hda1 hda2 hda3
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 216k freed

