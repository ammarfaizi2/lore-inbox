Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130679AbQLOLrJ>; Fri, 15 Dec 2000 06:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129325AbQLOLq7>; Fri, 15 Dec 2000 06:46:59 -0500
Received: from quoin.cqu.EDU.AU ([138.77.24.5]:44554 "EHLO quoin.cqu.edu.au")
	by vger.kernel.org with ESMTP id <S130180AbQLOLqu>;
	Fri, 15 Dec 2000 06:46:50 -0500
From: Harley Anderson <q9202867@quoin.cqu.edu.au>
Organization: Big Fish on a Bendy Stick
To: linux-kernel@vger.kernel.org
Subject: IRQ problem? (oops in test12)
Date: Fri, 15 Dec 2000 21:11:19 +1000
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: q9202867@quoin.cqu.edu.au
MIME-Version: 1.0
Message-Id: <00121521194500.17367@satan>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy again folks, I have another oops for ya's to look over...

Yesterday when I was about to patch and build the new (test12) kernel I found
the ominous message:
Kernel panic: attempted to kill init!
Something like that anyway. No other info, just locked up solid.
No real clues on that one sorry.

But now today, about 22 hours after booting test12, I got another one:

ksymoops 2.3.4 on i686 2.4.0-test12.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test12/ (default)
     -m /boot/System.map-2.4.0-test12 (specified)

Unable to handle kernel NULL pointer dereference at virtual address 0000000c
c0110959
*pde = 00000000
Oops: 0000
CPU: 0
EIP: 0010:[<c0110959>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010216
eax: 00000c48   ebx: 00000c48   ecx: 00000018   edx: 00000000
esi: c3920000   edi: c011058c   ebp: c480a03e   esp: c3921e38
ds: 0018   es: 0018   ss: 0018
Process (pid:0, stackpage=c3921000)
Stack: c3920000 00000000 c011058c c1142400 00000000 00000000 00000000 00000000
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Call Trace: [<c011058c>] [<c010a990>] [<c480a03e>] [<c480a000>] [<c480a03e>] [<c480774d>] [<c480a03e>]
            [<c48081a3>] [<c010b9e5>] [<c010bb56>] [<c010a920>] [<c0116d90>] [<c011984f>] [<c01c2480>]
            [<c010ad22>] [<c01108b2>] [<c01c04fe>] [<c011058c>]
Code: 03 5a 0c 03 05 2c 8a 1e c0 f6 03 01 0f 85 f5 fd ff ff 8b 00

>>EIP; c0110959 <do_page_fault+3cd/3f8>   <=====
Trace; c011058c <do_page_fault+0/3f8>
Trace; c010a990 <error_code+34/3c>
Trace; c480a03e <.data.end+145f/????>
Trace; c480a000 <.data.end+1421/????>
Trace; c480a03e <.data.end+145f/????>
Trace; c480774d <[8139too]rtl8139_interrupt+101/160>
Trace; c480a03e <.data.end+145f/????>
Trace; c48081a3 <[8139too]rtl8139_rx_config+17/8d4>
Trace; c010b9e5 <handle_IRQ_event+31/5c>
Trace; c010bb56 <do_IRQ+6e/b4>
Trace; c010a920 <ret_from_intr+0/20>
Trace; c0116d90 <panic+cc/d0>
Trace; c011984f <do_exit+3b/1f4>
Trace; c01c2480 <IRQ0x0f_interrupt+493c/5444>
Trace; c010ad22 <die+42/44>
Trace; c01108b2 <do_page_fault+326/3f8>
Trace; c01c04fe <IRQ0x0f_interrupt+29ba/5444>
Trace; c011058c <do_page_fault+0/3f8>
Code;  c0110959 <do_page_fault+3cd/3f8>
00000000 <_EIP>:
Code;  c0110959 <do_page_fault+3cd/3f8>   <=====
   0:   03 5a 0c                  addl   0xc(%edx),%ebx   <=====
Code;  c011095c <do_page_fault+3d0/3f8>
   3:   03 05 2c 8a 1e c0         addl   0xc01e8a2c,%eax
Code;  c0110962 <do_page_fault+3d6/3f8>
   9:   f6 03 01                  testb  $0x1,(%ebx)
Code;  c0110965 <do_page_fault+3d9/3f8>
   c:   0f 85 f5 fd ff ff         jne    fffffe07 <_EIP+0xfffffe07> c0110760 <do_page_fault+1d4/3f8>
Code;  c011096b <do_page_fault+3df/3f8>
  12:   8b 00                     movl   (%eax),%eax

Aiee, killing interrupt handler
Kernel panic: Attempted to kill the idle task!


I'm guessing it's due to a irq sharing problem between the rtl8139 and the usb
controller, which were both using 11 at the time of the oops.
After that I disabled assigning irq to the usb in the bios since I don't
actually use it. But then they both change to irq 5, as the dmesg + lspci shows:


Linux version 2.4.0-test12 (root@fury) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #3 Thu Dec 14 16:57:34 EST 2000
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
 BIOS-e820: 0000000003f00000 @ 0000000000100000 (usable)
On node 0 totalpages: 16384
zone(0): 4096 pages.
zone(1): 12288 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=test12 ro root=304 reboot=warm
Initializing CPU#0
Detected 334.093 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 666.83 BogoMIPS
Memory: 62656k/65536k available (928k kernel code, 2492k reserved, 67k data, 184k init, 0k highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
CPU: Before vendor init, caps: 0183f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183f9ff 00000000 00000000 00000000
CPU: After generic, caps: 0183f9ff 00000000 00000000 00000000
CPU: Common caps: 0183f9ff 00000000 00000000 00000000
CPU: Intel Pentium II (Deschutes) stepping 00
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfae60, last bus=1
PCI: Probing PCI hardware
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
PCI: Found IRQ 5 for device 00:07.2
PCI: The same IRQ used for device 00:0b.0
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: WDC AC36400L, ATA DISK drive
hdb: CD-ROM 36X/AKU, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 12594960 sectors (6449 MB) w/256KiB Cache, CHS=784/255/63, UDMA(33)
Partition check:
 hda: hda1 hda2 hda3 hda4
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 184k freed
Adding Swap: 32760k swap-space (priority -1)
8139too Fast Ethernet driver 0.9.12 loaded
PCI: Found IRQ 5 for device 00:0b.0
PCI: The same IRQ used for device 00:07.2
eth0: RealTek RTL8139 Fast Ethernet at 0xc480a000, 00:48:54:3f:62:a3, IRQ 5
eth0:  Identified 8139 chip type 'RTL-8139A'

00:00.0 Host bridge: Intel Corporation 440LX - 82443LX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corporation 440LX - 82443LX AGP bridge (rev 03)
00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 01)
00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 01)
00:08.0 VGA compatible controller: NVidia / SGS Thomson (Joint Venture) Riva128 (rev 10)
00:0a.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI]
00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 8139 (rev 10)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
