Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130309AbQKJUHg>; Fri, 10 Nov 2000 15:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131439AbQKJUH0>; Fri, 10 Nov 2000 15:07:26 -0500
Received: from TELOS.ODYSSEY.CS.CMU.EDU ([128.2.185.175]:20491 "EHLO
	telos.odyssey.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S130309AbQKJUHP>; Fri, 10 Nov 2000 15:07:15 -0500
Date: Fri, 10 Nov 2000 15:06:52 -0500
From: Jan Harkes <jaharkes@cs.cmu.edu>
To: Rafal Maszkowski <rzm@icm.edu.pl>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test11-pre2
Message-ID: <20001110150652.F27422@cs.cmu.edu>
Mail-Followup-To: Rafal Maszkowski <rzm@icm.edu.pl>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10011091748300.2316-100000@penguin.transmeta.com> <20001110202747.A16806@burza.icm.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001110202747.A16806@burza.icm.edu.pl>; from rzm@icm.edu.pl on Fri, Nov 10, 2000 at 08:27:47PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2000 at 08:27:47PM +0100, Rafal Maszkowski wrote:
> On Thu, Nov 09, 2000 at 05:52:29PM -0800, Linus Torvalds wrote:
> >  - pre2:
> >     - David Miller: sparc64 updates, make sparc32 boot again
> 
> Thanks for working on it but I am getting still:
> 
> boot: 11.2
> Uncompressing image...
> PROMLIB: obio_ranges 5
> bootmem_init: Scan sp_banks,  init_bootmem(spfn[1f5],bpfn[1f5],mlpfn[c000])
> free_bootmem: base[0] size[1000000]
> free_bootmem: base[4000000] size[1000000]
> free_bootmem: base[8000000] size[1000000]
> reserve_bootmem: base[0] size[1f5000]
> reserve_bootmem: base[1f5000] size[1800]
> Booting Linux...
> 
> Watchdog Reset
> Type  help  for more information
> ok
> 
> Turning off software watchdog does not help, I am not sure if the "Watchdog
> Reset" message is from the kernel though. I am using
> 
> make dep clean modules modules_install vmlinux ; gzip vmlinux
> 
> for compiling.
> 
> SPARCstation 10, 1 CPU, Fore 200e SBA, 64 MB RAM
> gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)
> Linux etest.icm.edu.pl 2.2.17 #1 Fri Oct 27 03:43:05 MEST 2000 sparc unknown
> 
> I wonder if it could be my fault - could anybody testify that he was able to
> boot any 2.4.0 on Sparc32?

Yup, SparcStation IPC, 48MB

What you are not seeing is probably the BUG() at bootmem.c:219. I can
almost bet it is related to the `holes' in your memory map,

> free_bootmem: base[0] size[1000000]
hole from 1000000 to 3fffffff
> free_bootmem: base[4000000] size[1000000]
hole from 5000000 to 7fffffff
> free_bootmem: base[8000000] size[1000000]

And when the zones are initialized, a test_and_set_bit goes wrong when
you hit the zone. To see the printk's during boot, change

arch/sparc/kernel/setup.c:48
- #undef PROM_DEBUG_CONSOLE
+ #define PROM_DEBUG_CONSOLE 1

Here is the dmesg output of my machine.

==========================================================
phoenix:/usr/src/linux# dmesg                                                   
PROMLIB: Sun Boot Prom Version 0 Revision 0
Linux version 2.4.0-test10 (root@phoenix) (gcc version 2.95.2 20000220 (Debian GNU/Linux)) #10 Thu Nov 9 14:09:21 EST 2000
ARCH: SUN4C
TYPE: Sun4c SparcStation IPC
Ethernet address: 8:0:20:b:45:88
Loading sun4c MMU routines
Boot time fixup v1.6. 4/Mar/98 Jakub Jelinek (jj@ultra.linux.cz). Patching kernel for sun4c
On node 0 totalpages: 12288
zone(0): 12288 pages.
zone(1): 0 pages.
zone(2): 0 pages.
SUN4C: 63 mmu entries for the kernel
Kernel command line: root=/dev/sda1
Console: colour dummy device 80x25
Calibrating delay loop... 24.73 BogoMIPS
Memory: 46628k available (1080k kernel code, 208k data, 112k init, 0k highmem) [f0000000,03000000]                                                              
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
POSIX conformance testing by UNIFIX
sbus0: Clock 25.0 MHz
dma0: Revision 1
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
Console: switching to mono frame buffer device 142x54
fb0: bwtwo at 1.fe000000
pty: 256 Unix98 ptys configured
Floppy drive(s): fd0 is 1.44M
FDC 0 is an 82072A
sunlance.c:v2.00 11/Sep/99 Miguel de Icaza (miguel@nuclecu.unam.mx)
eth0: LANCE 08:00:20:0b:45:88
SCSI subsystem driver Revision: 1.00
esp0: IRQ 3 SCSI ID 7 Clk 25MHz CCYC=40000 CCF=5 TOut 167 NCR53C90A(esp100a)
ESP: Total of 1 ESP hosts found, 1 actually in use.
scsi0 : Sparc ESP100A (NCR53C90A)
  Vendor: HP        Model: C3725S            Rev: 6019
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
esp0: target 0 [period 200ns offset 15 5.00MHz synchronous SCSI]
SCSI device sda: 4194058 512-byte hdwr sectors (2147 MB)
Partition check:
 sda: sda1 sda2 sda3 sda4
Sparc Zilog8530 serial driver version 1.60
Sun Mouse-Systems mouse driver version 1.00
tty00 at 0xffd02004 (irq = 12) is a Zilog8530
tty01 at 0xffd02000 (irq = 12) is a Zilog8530
tty02 at 0xffd00004 (irq = 12) is a Zilog8530
tty03 at 0xffd00000 (irq = 12) is a Zilog8530
Sun TYPE 4 keyboard detected without keyclick
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 112k freed
Warning: unable to open an initial console.
Adding Swap: 47764k swap-space (priority -1)
"""

> 
> R.
> -- 
> W iskier krzesaniu ?ywem/Materia? to rzecz g?ówna
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
