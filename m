Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286557AbRL1PYO>; Fri, 28 Dec 2001 10:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282491AbRL1PYI>; Fri, 28 Dec 2001 10:24:08 -0500
Received: from sol.mixi.net ([208.131.233.11]:8394 "EHLO sol.mixi.net")
	by vger.kernel.org with ESMTP id <S286557AbRL1PYC>;
	Fri, 28 Dec 2001 10:24:02 -0500
X-Envelope-From: <todd@tekinteractive.com>
X-Mailer: emacs 21.1.1 (via feedmail 8 I);
	VM 7.00 under Emacs 21.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15404.36497.77658.797884@rtfm.ofc.tekinteractive.com>
Date: Fri, 28 Dec 2001 10:24:01 -0500
From: "Todd R. Eigenschink" <todd@tekinteractive.com>
To: linux-kernel@vger.kernel.org
Subject: oops in sync_page_buffers, 2.4.17 & 2.4.18-pre1
Reply-To: todd@tekinteractive.com
X-RAVMilter-Version: 8.3.0(snapshot 20010925) (sol)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having a repeated oops in sync_page_buffers running 2.4.18-pre1,
that also happened with 2.4.16/17.  They are repeatable to the extent
that if the machine is up and processing long enough, I *will* get
them, but I can't quite duplicate them on demand.

The machine is used almost exclusively for running WebTrends (web
stats).  There's really nothing exceptional about WebTrends apart from
the amount of info it processes: lots of log files, huge amounts of
RAM, and it writes *lots* of small HTML files.

Most of the oopsen happen in kswapd, or occasionally in ld-linux.so.2.
(I'm running "/older/libs/ld-linux.so.2 --library-path /older/libs ..."
because WebTrends was built against versions of everything older
than what's currently on the machine.)  When they happen in ld-linux.so,
one of the threads dies and I have to kill -9 it, but I can usually
continue without trouble.  When they happen in kswapd, the process
usually hangs in the "D" state, and I have to reboot to clear it.

Below is the basic configuration, the kernel's config, the oopsen
themselves (run through ksymoops) at the bottom, and the output of
"dmesg" right after boot.  The second oops is from "agent.be", which
is the remote agent for Backup Exec.  This pair just happened
overnight, and it's the first I've seen an oops in anything other than
kswapd or ld-linux.so while running WebTrends.  The backup server must
have been connected at that time for the nightly incremental.

I'll be glad to provide anything additional if something would be
helpful.

----------------------------------------------------------------------
Basic info:

Dual P3/500, 2GB RAM.  2 SCSI disks + 1 software raid0 partition
across 4 32GB IDE disks.  reiserfs + ext2 (see /etc/mtab below).
Intel L440GX+ server board, updated to latest BIOS the night before
last (in the hopes that a BIOS update would fix the problem).

Linux gemini 2.4.18pre1 #2 SMP Wed Dec 26 16:08:21 EST 2001 i686 unknown

  9:09am  up 1 day,  9:17,  2 users,  load average: 0.76, 0.80, 0.48

Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sda1              8064272   3270876   4383744  43% /
/dev/hda1                 5334      3034      2025  60% /boot
/dev/sdb1             35558752  24534896  11023856  69% /logs
/dev/md0             132084028  40634172  91449856  31% /logs/webtrends
sol:/home/employees    4134932   3680940    243944  94% /mnt/home


/dev/root / ext2 rw 0 0
/dev/hda1 /boot ext2 rw 0 0
none /proc proc rw 0 0
none /dev/pts devpts rw 0 0
automount(pid161) /mnt autofs rw 0 0
/dev/sdb1 /logs reiserfs rw,noatime 0 0
/dev/md0 /logs/webtrends reiserfs rw 0 0
sol:/home/employees /mnt/home nfs rw,v2,rsize=8192,wsize=8192,hard,udp,lock,addr=sol 0 0

----------------------------------------------------------------------
.config  (grep "=y" .config) (modules are enabled, but nothing is
                              configured as a module)

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
CONFIG_BLK_DEV_ADMA=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
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
CONFIG_UNIX98_PTYS=y
CONFIG_RTC=y
CONFIG_AUTOFS_FS=y
CONFIG_AUTOFS4_FS=y
CONFIG_REISERFS_FS=y
CONFIG_REISERFS_PROC_INFO=y
CONFIG_TMPFS=y
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
ksymoops 2.4.3 on i686 2.4.18pre1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18pre1/ (default)
     -m /boot/System.map-2.4.18-pre1 (specified)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c0207470, System.map says c014feb0.  Ignoring ksyms_base entry
Unable to handle kernel paging request at virtual address 2d74617b
c0136830
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0136830>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010207
eax: 00000010   ebx: 2d746163   ecx: 000001d0   edx: 00000000
esi: 00000000   edi: d128c800   ebp: c2fa2d80   esp: f7bfbf10
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, stackpage=f7bfb000)
Stack: c02ca9a0 d128c800 d128c800 c01369fe d128c800 c2fa2d80 000001d0 00000014 
       00000200 c013506c c2fa2d80 000001d0 d128c800 c2fa2d80 c012bf82 c2fa2d80 
       000001d0 00000020 000001d0 00000020 00000006 f7bfa000 f7bfa000 0000c6f6 
Call Trace: [<c01369fe>] [<c013506c>] [<c012bf82>] [<c012c236>] [<c012c293>] 
   [<c012c323>] [<c012c37e>] [<c012c48d>] [<c0105594>] 
Code: f6 43 18 06 0f 84 91 00 00 00 b8 07 00 00 00 f0 0f ab 43 18 

>>EIP; c0136830 <sync_page_buffers+10/bc>   <=====
Trace; c01369fe <try_to_free_buffers+122/14c>
Trace; c013506c <try_to_release_page+3c/44>
Trace; c012bf82 <shrink_cache+21e/39c>
Trace; c012c236 <shrink_caches+56/7c>
Trace; c012c292 <try_to_free_pages+36/58>
Trace; c012c322 <kswapd_balance_pgdat+42/8c>
Trace; c012c37e <kswapd_balance+12/28>
Trace; c012c48c <kswapd+98/bc>
Trace; c0105594 <kernel_thread+28/38>
Code;  c0136830 <sync_page_buffers+10/bc>
00000000 <_EIP>:
Code;  c0136830 <sync_page_buffers+10/bc>   <=====
   0:   f6 43 18 06               testb  $0x6,0x18(%ebx)   <=====
Code;  c0136834 <sync_page_buffers+14/bc>
   4:   0f 84 91 00 00 00         je     9b <_EIP+0x9b> c01368ca <sync_page_buffers+aa/bc>
Code;  c013683a <sync_page_buffers+1a/bc>
   a:   b8 07 00 00 00            mov    $0x7,%eax
Code;  c013683e <sync_page_buffers+1e/bc>
   f:   f0 0f ab 43 18            lock bts %eax,0x18(%ebx)

Unable to handle kernel NULL pointer dereference at virtual address 00000018
c0136830
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<c0136830>]    Not tainted
EFLAGS: 00010203
eax: 00000012   ebx: 00000000   ecx: 000001d2   edx: 00000000
esi: 00000000   edi: c30cfc80   ebp: c2c82d80   esp: de5f7e0c
ds: 0018   es: 0018   ss: 0018
Process agent.be (pid: 20105, stackpage=de5f7000)
Stack: c02ca9a0 c30cfc80 c30cfc80 c01369fe c30cfc80 c2c82d80 000001d2 00000017 
       00000104 c013506c c2c82d80 000001d2 c30cfc80 c2c82d80 c012bf82 c2c82d80 
       000001d2 00000020 000001d2 00000020 00000006 de5f6000 de5f6000 0000b324 
Call Trace: [<c01369fe>] [<c013506c>] [<c012bf82>] [<c012c236>] [<c012c293>] 
   [<c012cae0>] [<c012cd02>] [<c012ca82>] [<c0125711>] [<c0125d35>] [<c0125f8d>] 
   [<c012650a>] [<c01263bc>] [<c0132cdb>] [<c0106d8f>] 
Code: f6 43 18 06 0f 84 91 00 00 00 b8 07 00 00 00 f0 0f ab 43 18 

>>EIP; c0136830 <sync_page_buffers+10/bc>   <=====
Trace; c01369fe <try_to_free_buffers+122/14c>
Trace; c013506c <try_to_release_page+3c/44>
Trace; c012bf82 <shrink_cache+21e/39c>
Trace; c012c236 <shrink_caches+56/7c>
Trace; c012c292 <try_to_free_pages+36/58>
Trace; c012cae0 <balance_classzone+5c/178>
Trace; c012cd02 <__alloc_pages+106/164>
Trace; c012ca82 <_alloc_pages+16/18>
Trace; c0125710 <page_cache_read+7c/cc>
Trace; c0125d34 <generic_file_readahead+100/138>
Trace; c0125f8c <do_generic_file_read+1f0/450>
Trace; c012650a <generic_file_read+7e/12c>
Trace; c01263bc <file_read_actor+0/d0>
Trace; c0132cda <sys_read+8e/c4>
Trace; c0106d8e <system_call+32/38>
Code;  c0136830 <sync_page_buffers+10/bc>
00000000 <_EIP>:
Code;  c0136830 <sync_page_buffers+10/bc>   <=====
   0:   f6 43 18 06               testb  $0x6,0x18(%ebx)   <=====
Code;  c0136834 <sync_page_buffers+14/bc>
   4:   0f 84 91 00 00 00         je     9b <_EIP+0x9b> c01368ca <sync_page_buffers+aa/bc>
Code;  c013683a <sync_page_buffers+1a/bc>
   a:   b8 07 00 00 00            mov    $0x7,%eax
Code;  c013683e <sync_page_buffers+1e/bc>
   f:   f0 0f ab 43 18            lock bts %eax,0x18(%ebx)


2 warnings issued.  Results may not be reliable.

----------------------------------------------------------------------
dmesg output right after boot:

Linux version 2.4.18pre1 (eigenstr@gemini) (gcc version 2.95.3 20010315 (release)) #2 SMP Wed Dec 26 16:08:21 EST 2001
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
Kernel command line: auto BOOT_IMAGE=linux2418pre1 ro root=801 BOOT_FILE=/boot/vmlinuz-2.4.18pre1
Initializing CPU#0
Detected 497.440 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 992.87 BogoMIPS
Memory: 2061284k/2097088k available (1474k kernel code, 35416k reserved, 451k data, 228k init, 1179584k highmem)
Dentry-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Mount-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 131072 (order: 7, 524288 bytes)
Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
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
Intel machine check reporting enabled on CPU#0.
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
Intel machine check reporting enabled on CPU#1.
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
..... CPU clock speed is 497.4245 MHz.
..... host bus clock speed is 99.4848 MHz.
cpu: 0, clocks: 994848, slice: 331616
CPU0<T0:994848,T1:663232,D:0,S:331616,C:994848>
cpu: 1, clocks: 994848, slice: 331616
CPU1<T0:994848,T1:331616,D:0,S:331616,C:994848>
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
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
block: 128 slots per queue, batch=32
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
hda: 66055248 sectors (33820 MB) w/2048KiB Cache, CHS=4111/255/63, UDMA(33)
hdb: 66055248 sectors (33820 MB) w/2048KiB Cache, CHS=4111/255/63, UDMA(33)
hdc: 66055248 sectors (33820 MB) w/2048KiB Cache, CHS=65531/16/63, UDMA(33)
hdd: 66055248 sectors (33820 MB) w/2048KiB Cache, CHS=65531/16/63, UDMA(33)
Partition check:
 hda: hda1 hda2
 hdb: hdb1 hdb2
 hdc: hdc1 hdc2
 hdd: hdd1 hdd2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
loop: loaded (max 8 devices)
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eth0: Intel Corp. 82557 [Ethernet Pro 100], 00:90:27:E0:0A:05, IRQ 21.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
        <Adaptec aic7896/97 Ultra2 SCSI adapter>
        aic7896/97: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
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
ip_tables: (c)2000 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 228k freed
 [events: 00000081]
 [events: 00000081]
 [events: 00000081]
 [events: 00000081]
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
md: hdd2's event counter: 00000081
md: hdc2's event counter: 00000081
md: hdb2's event counter: 00000081
md: hda2's event counter: 00000081
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
md: hdd2 [events: 00000082]<6>(write) hdd2's sb offset: 33022016
md: hdc2 [events: 00000082]<6>(write) hdc2's sb offset: 33022016
md: hdb2 [events: 00000082]<6>(write) hdb2's sb offset: 33022016
md: hda2 [events: 00000082]<6>(write) hda2's sb offset: 33022016
md: ... autorun DONE.
Adding Swap: 690752k swap-space (priority -1)
reiserfs: checking transaction log (device 08:11) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 09:00) ...
reiserfs: replayed 1 transactions in 4 seconds
Using r5 hash to sort names
Removing [300791 301241 0x0 SD]..<4>done
There were 1 uncompleted unlinks/truncates. Completed
ReiserFS version 3.6.25
----------------------------------------------------------------------

Todd
-- 
Todd R. Eigenschink             TEK Interactive Group, Inc.
todd@tekinteractive.com         http://www.tekinteractive.com/
System Administrator            (219) 459-2521


