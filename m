Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313384AbSEHMIa>; Wed, 8 May 2002 08:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313416AbSEHMI3>; Wed, 8 May 2002 08:08:29 -0400
Received: from sol.mixi.net ([208.131.233.11]:22247 "EHLO sol.mixi.net")
	by vger.kernel.org with ESMTP id <S313384AbSEHMIY>;
	Wed, 8 May 2002 08:08:24 -0400
X-Envelope-From: <todd@tekinteractive.com>
X-Mailer: emacs 21.1.95.1 (via feedmail 8 I);
	VM 7.04 under Emacs 21.1.95.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15577.5431.625191.582701@rtfm.ofc.tekinteractive.com>
Date: Wed, 8 May 2002 07:08:23 -0500
From: "Todd R. Eigenschink" <todd@tekinteractive.com>
To: linux-kernel@vger.kernel.org
Subject: kswapd OOPS under 2.4.19-pre8 (ext3, Reiserfs + (soft)raid0)
Reply-To: todd@tekinteractive.com
X-RAVMilter-Version: 8.3.1(snapshot 20020108) (sol)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After anywhere from 6 hours to three days, this machine oopses and
locks up.  I've reported this a number of times before in the 2.4
series with no response.  The nature and timing of the oops have
shifted slightly as 2.4 has progressed, but it's always basically the
same drill.

The oopsen used to be generally non-fatal in that the machine would
continue--the oops would be reported against a regular process, which
would croak.  In most of the pre-patches for 2.4.19, they've always
locked the machine up solid.  I finally hooked up a serial console
last night before I left work and the box cooperated and died at 2:00
this morning.  Decoded oops below.

The box is a dual P3/500, 2GB RAM, Intel L440GX-C mainboard.  Disk
config is 1x9GB and 1x36 GB SCSI-3 drive standalone on the on-board
Adaptec host adapter, and 4x30GB Maxtor disks on the internal IDE in a
RAID0 configuration.  Everything is ext3 except the RAID0; that's one
big ~120GB reiserfs partition.

The load on the box is usually very light, and I haven't really been
able to correlate the event to anything in particular happening, since
it happens at any time of the day or night.  Last night I rebooted it
before I left about 20:00, and hardly anything would have been run on
it between then and 02:00 today.

Modules are configured/available, but none are compiled or loaded.
Here's the oops; the kernel config and boot log are below.

----------------------------------------------------------------------

gemini 06:50:16 eigenstr > ksymoops -m /boot/System.map-2.4.19-pre8 capture.txt
ksymoops 2.4.4 on i686 2.4.19-pre8.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-pre8/ (default)
     -m /boot/System.map-2.4.19-pre8 (specified)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Warning (compare_maps): ksyms_base symbol vmalloc_to_page_R__ver_vmalloc_to_page not found in System.map.  Ignoring ksyms_base entry
1151MB HIGHMEM available.
cpu: 0, clocks: 994886, slice: 331628
cpu: 1, clocks: 994886, slice: 331628
Oops: 0000
CPU:    0
EIP:    0010:[<c01158e3>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010087
eax: c2802db4   ebx: c2002db4   ecx: 00000000   edx: 00000003
esi: c2802db0   edi: c2802db0   ebp: f7bf3f40   esp: f7bf3f24
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, stackpage=f7bf3000)
Stack: c1a604f0 c2802db0 00000020 c2802db4 00000000 00000282 00000003 00000200 
       c0128cfe f758d420 c1a604f0 c012fd17 00000020 000001d0 00000020 00000006 
       f7bf2000 f7bf2000 000094c6 000001d0 c02ecb34 c012ff76 00000006 00000005 
Call Trace: [<c0128cfe>] [<c012fd17>] [<c012ff76>] [<c012ffd3>] [<c0130063>] 
   [<c01300be>] [<c01301cd>] [<c0107004>] 
Code: 8b 01 85 45 fc 74 66 31 d2 9c 5e fa f0 fe 0d 80 b9 34 c0 0f 

>>EIP; c01158e3 <__wake_up+3b/c0>   <=====
Trace; c0128cfe <unlock_page+62/68>
Trace; c012fd17 <shrink_cache+293/3b0>
Trace; c012ff76 <shrink_caches+56/7c>
Trace; c012ffd3 <try_to_free_pages+37/58>
Trace; c0130063 <kswapd_balance_pgdat+43/8c>
Trace; c01300be <kswapd_balance+12/28>
Trace; c01301cd <kswapd+99/b4>
Trace; c0107004 <kernel_thread+28/38>
Code;  c01158e3 <__wake_up+3b/c0>
00000000 <_EIP>:
Code;  c01158e3 <__wake_up+3b/c0>   <=====
   0:   8b 01                     mov    (%ecx),%eax   <=====
Code;  c01158e5 <__wake_up+3d/c0>
   2:   85 45 fc                  test   %eax,0xfffffffc(%ebp)
Code;  c01158e8 <__wake_up+40/c0>
   5:   74 66                     je     6d <_EIP+0x6d> c0115950 <__wake_up+a8/c0>
Code;  c01158ea <__wake_up+42/c0>
   7:   31 d2                     xor    %edx,%edx
Code;  c01158ec <__wake_up+44/c0>
   9:   9c                        pushf  
Code;  c01158ed <__wake_up+45/c0>
   a:   5e                        pop    %esi
Code;  c01158ee <__wake_up+46/c0>
   b:   fa                        cli    
Code;  c01158ef <__wake_up+47/c0>
   c:   f0 fe 0d 80 b9 34 c0      lock decb 0xc034b980
Code;  c01158f6 <__wake_up+4e/c0>
  13:   0f 00 00                  sldt   (%eax)


----------------------------------------------------------------------

CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_M686=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_NET=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_RAID0=y
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_DEBUG=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_FTP=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=y
CONFIG_IP_NF_MATCH_MAC=y
CONFIG_IP_NF_MATCH_MARK=y
CONFIG_IP_NF_MATCH_MULTIPORT=y
CONFIG_IP_NF_MATCH_TOS=y
CONFIG_IP_NF_MATCH_TCPMSS=y
CONFIG_IP_NF_MATCH_STATE=y
CONFIG_IP_NF_MATCH_UNCLEAN=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
CONFIG_IP_NF_TARGET_REDIRECT=y
CONFIG_IP_NF_NAT_FTP=y
CONFIG_IP_NF_TARGET_LOG=y
CONFIG_IP_NF_TARGET_TCPMSS=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
CONFIG_IDE_CHIPSETS=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_BLK_DEV_SR=y
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_AIC7XXX=y
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_EEPRO100=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_RTC=y
CONFIG_AUTOFS_FS=y
CONFIG_AUTOFS4_FS=y
CONFIG_REISERFS_FS=y
CONFIG_REISERFS_PROC_INFO=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=y
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_VGA_CONSOLE=y

----------------------------------------------------------------------

Linux version 2.4.19-pre8 (eigenstr@gemini) (gcc version 2.95.3 20010315 (release)) #2 SMP Thu May 2 18:54:55 EST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
 BIOS-e820: 000000007fff0000 - 000000007ffffc00 (ACPI data)
 BIOS-e820: 000000007ffffc00 - 0000000080000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f6ab0
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
hm, page 0009f000 reserved twice.
hm, page 000a0000 reserved twice.
On node 0 totalpages: 524272
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 294896 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: INTEL    Product ID: Lancewood    APIC at: 0xFEE00000
Processor #1 Pentium(tm) Pro APIC version 17
Processor #0 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2
Kernel command line: auto BOOT_IMAGE=2419-pre8 ro root=801 BOOT_FILE=/boot/vmlinuz-2.4.19-pre8 console=ttyS0,9600 console=tty0
Initializing CPU#0
Detected 497.444 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 992.87 BogoMIPS
Memory: 2069252k/2097088k available (1581k kernel code, 27448k reserved, 485k data, 248k init, 1179584k highmem)
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode cache hash table entries: 131072 (order: 8, 1048576 bytes)
Mount-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 131072 (order: 7, 524288 bytes)
Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel Pentium III (Katmai) stepping 03
per-CPU timeslice cutoff: 1461.79 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 992.87 BogoMIPS
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU1: Intel Pentium III (Katmai) stepping 03
Total of 2 processors activated (1985.74 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-9, 2-10, 2-11, 2-16, 2-17, 2-18, 2-20, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 17.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 003 03  0    0    0   0   0    1    1    51
 06 003 03  0    0    0   0   0    1    1    59
 07 003 03  0    0    0   0   0    1    1    61
 08 003 03  0    0    0   0   0    1    1    69
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 003 03  0    0    0   0   0    1    1    71
 0d 003 03  0    0    0   0   0    1    1    79
 0e 003 03  0    0    0   0   0    1    1    81
 0f 003 03  0    0    0   0   0    1    1    89
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 003 03  1    1    0   1   0    1    1    91
 14 000 00  1    0    0   0   0    0    0    00
 15 003 03  1    1    0   1   0    1    1    99
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ19 -> 0:19
IRQ21 -> 0:21
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 497.4424 MHz.
..... host bus clock speed is 99.4883 MHz.
cpu: 0, clocks: 994883, slice: 331627
CPU0<T0:994880,T1:663248,D:5,S:331627,C:994883>
cpu: 1, clocks: 994883, slice: 331627
CPU1<T0:994880,T1:331616,D:10,S:331627,C:994883>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xfdab0, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Discovered primary peer bus ff [IRQ]
PCI: Using IRQ router PIIX [8086/7110] at 00:12.0
PCI->APIC IRQ transform: (B0,I12,P0) -> 19
PCI->APIC IRQ transform: (B0,I12,P0) -> 19
PCI->APIC IRQ transform: (B0,I14,P0) -> 21
PCI->APIC IRQ transform: (B0,I18,P3) -> 21
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 91
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x2860-0x2867, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x2868-0x286f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 54098U8, ATA DISK drive
hdb: Maxtor 54098U8, ATA DISK drive
hdc: Maxtor 54098U8, ATA DISK drive
hdd: Maxtor 54098U8, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: setmax LBA 80041248, native  66055248
hda: 66055248 sectors (33820 MB) w/2048KiB Cache, CHS=4111/255/63, UDMA(33)
hdb: setmax LBA 80041248, native  66055248
hdb: 66055248 sectors (33820 MB) w/2048KiB Cache, CHS=4111/255/63, UDMA(33)
hdc: setmax LBA 80041248, native  66055248
hdc: 66055248 sectors (33820 MB) w/2048KiB Cache, CHS=65531/16/63, UDMA(33)
hdd: setmax LBA 80041248, native  66055248
hdd: 66055248 sectors (33820 MB) w/2048KiB Cache, CHS=65531/16/63, UDMA(33)
Partition check:
 hda: hda1 hda2
 hdb: hdb1 hdb2
 hdc: hdc1 hdc2
 hdd: hdd1 hdd2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
loop: loaded (max 8 devices)
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eth0: Intel Corp. 82557/8/9 [Ethernet Pro 100], 00:90:27:E0:0A:05, IRQ 21.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.6
        <Adaptec aic7896/97 Ultra2 SCSI adapter>
        aic7896/97: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.6
        <Adaptec aic7896/97 Ultra2 SCSI adapter>
        aic7896/97: Ultra2 Wide Channel B, SCSI Id=7, 32/253 SCBs

  Vendor: SEAGATE   Model: ST39175LW         Rev: 0001
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: ST136475LW        Rev: 0001
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
scsi0:A:1:0: Tagged Queuing enabled.  Depth 253
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
(scsi0:A:0): 80.000MB/s transfers (40.000MHz, offset 15, 16bit)
SCSI device sda: 17783240 512-byte hdwr sectors (9105 MB)
 sda: sda1 sda2 < sda5 >
(scsi0:A:1): 80.000MB/s transfers (40.000MHz, offset 15, 16bit)
SCSI device sdb: 71132960 512-byte hdwr sectors (36420 MB)
 sdb: sdb1
md: raid0 personality registered as nr 2
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
ip_conntrack (8192 buckets, 65536 max)
ip_tables: (C) 2000-2002 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: sd(8,1): orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 114017
EXT3-fs: sd(8,1): 1 orphan inode deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 248k freed
 [events: 000000f0]
 [events: 000000f0]
 [events: 000000f0]
 [events: 000000f0]
md: autorun ...
md: considering hdd2 ...
md:  adding hdd2 ...
md:  adding hdc2 ...
md:  adding hdb2 ...
md:  adding hda2 ...
md: created md0
md: bind<hda2,1>
md: bind<hdb2,2>
md: bind<hdc2,3>
md: bind<hdd2,4>
md: running: <hdd2><hdc2><hdb2><hda2>
md: hdd2's event counter: 000000f0
md: hdc2's event counter: 000000f0
md: hdb2's event counter: 000000f0
md: hda2's event counter: 000000f0
md0: max total readahead window set to 992k
md0: 4 data-disks, max readahead per data-disk: 248k
raid0: looking at hda2
raid0:   comparing hda2(33022016) with hda2(33022016)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at hdb2
raid0:   comparing hdb2(33022016) with hda2(33022016)
raid0:   EQUAL
raid0: looking at hdc2
raid0:   comparing hdc2(33022016) with hda2(33022016)
raid0:   EQUAL
raid0: looking at hdd2
raid0:   comparing hdd2(33022016) with hda2(33022016)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: zone 0
raid0: checking hda2 ... contained as device 0
  (33022016) is smallest!.
raid0: checking hdb2 ... contained as device 1
raid0: checking hdc2 ... contained as device 2
raid0: checking hdd2 ... contained as device 3
raid0: zone->nb_dev: 4, size: 132088064
raid0: current zone offset: 33022016
raid0: done.
raid0 : md_size is 132088064 blocks.
raid0 : conf->smallest->size is 132088064 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: updating md0 RAID superblock on device
md: hdd2 [events: 000000f1]<6>(write) hdd2's sb offset: 33022016
md: hdc2 [events: 000000f1]<6>(write) hdc2's sb offset: 33022016
md: hdb2 [events: 000000f1]<6>(write) hdb2's sb offset: 33022016
md: hda2 [events: 000000f1]<6>(write) hda2's sb offset: 33022016
md: ... autorun DONE.
Adding Swap: 690752k swap-space (priority -1)
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on sd(8,1), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
reiserfs: checking transaction log (device 08:11) ...
reiserfs: replayed 9 transactions in 2 seconds
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 09:00) ...
reiserfs: replayed 23 transactions in 6 seconds
Using r5 hash to sort names
ReiserFS version 3.6.25

----------------------------------------------------------------------

