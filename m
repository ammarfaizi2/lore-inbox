Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129534AbRANCSt>; Sat, 13 Jan 2001 21:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129601AbRANCSj>; Sat, 13 Jan 2001 21:18:39 -0500
Received: from owns.warpcore.org ([216.81.249.18]:50956 "EHLO
	owns.warpcore.org") by vger.kernel.org with ESMTP
	id <S129534AbRANCSh>; Sat, 13 Jan 2001 21:18:37 -0500
Date: Sat, 13 Jan 2001 20:18:03 -0600
From: Stephen Clouse <stephenc@theiqgroup.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0 oops bdflush
Message-ID: <20010113201803.A2356@owns.warpcore.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have a development SMP machine which runs a myriad of server applications for
our development purposes -- Apache, Oracle, several others.  Under 2.4.0 the
machine locks up, seemingly at random.  Usually it simply stops responding
without fanfare -- you can, oddly enough, switch consoles with Alt+F?, but
typing gets no response and all network services have stopped
responding.  However, on the most recent failure I was lucky enough to find that
it had managed to spit out a kernel oops message before biting it, which I have 
(hopefully) decoded (properly):

root@fs1:/usr/src/linux.2.4.0# ksymoops -v /usr/src/linux.2.4.0/vmlinux -m \
     /usr/src/linux.2.4.0/System.map -o /lib/modules/2.4.0/
ksymoops 2.3.7 on i686 2.2.18.  Options used
     -v /usr/src/linux.2.4.0/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0/ (specified)
     -m /usr/src/linux.2.4.0/System.map (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Reading Oops report from the terminal
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012c37e>]
EFLAGS: 00010296
eax: 0000001c   ebx: c1068518   ecx: 00000000   edx: 00000026
esi: c10684fc   edi: 0000021c   ebp: 00000001   esp: c14f9fa4
ds: 0018   es: 0018   ss: 0018
Process bdflush (pid: 5, stackpage=c14f9000)
Stack: c01f9865 c01f9a24 00000299 c14f8000 c01fb96e 00000000 0008e000 00000000
       00000004 00000040 00000000 00000110 c01369c2 00000007 00000000 00010f00
       cff93f84 cff93fd0 0008e000 c0107507 cff93fbc cff93fbc cff93fbc
Call Trace: [<c01369c2>] [<c0107507>]
Code: 0f 0b 83 c4 0c 90 8b 46 14 85 c0 75 19 68 99 02 00 00 68 24
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012c37e>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010296
eax: 0000001c   ebx: c1068518   ecx: 00000000   edx: 00000026
esi: c10684fc   edi: 0000021c   ebp: 00000001   esp: c14f9fa4
ds: 0018   es: 0018   ss: 0018
Process bdflush (pid: 5, stackpage=c14f9000)
Stack: c01f9865 c01f9a24 00000299 c14f8000 c01fb96e 00000000 0008e000 00000000
       00000004 00000040 00000000 00000110 c01369c2 00000007 00000000 00010f00
       cff93f84 cff93fd0 0008e000 c0107507 cff93fbc cff93fbc cff93fbc
Call Trace: [<c01369c2>] [<c0107507>]
Code: 0f 0b 83 c4 0c 90 8b 46 14 85 c0 75 19 68 99 02 00 00 68 24

>>EIP; c012c37e <page_launder+716/868>   <=====
Trace; c01369c2 <bdflush+96/dc>
Trace; c0107507 <kernel_thread+23/30>
Code;  c012c37e <page_launder+716/868>
00000000 <_EIP>:
Code;  c012c37e <page_launder+716/868>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012c380 <page_launder+718/868>
   2:   83 c4 0c                  addl   $0xc,%esp
Code;  c012c383 <page_launder+71b/868>
   5:   90                        nop    
Code;  c012c384 <page_launder+71c/868>
   6:   8b 46 14                  movl   0x14(%esi),%eax
Code;  c012c387 <page_launder+71f/868>
   9:   85 c0                     testl  %eax,%eax
Code;  c012c389 <page_launder+721/868>
   b:   75 19                     jne    26 <_EIP+0x26> c012c3a4 <page_launder+73c/868>
Code;  c012c38b <page_launder+723/868>
   d:   68 99 02 00 00            pushl  $0x299
Code;  c012c390 <page_launder+728/868>
  12:   68 24 00 00 00            pushl  $0x24

This machine has been running flawlessly on 2.2.18 for weeks now, which seems to
preclude a hardware issue.  And since I've been personally running 2.4.0 on my
uniprocessor machine since day one without incident, I suspect some bizarre
interaction in SMP-land.  But I'm hardly a kernel programmer....

Unforunately I can't find exact specs on the machine; it's a Dell Precision 420,
most likely built with the hardware du jour about six months ago.  The config
options used are below:

CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_M686FXSR=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_FXSR=y
CONFIG_X86_XMM=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_NOHIGHMEM=y
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
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_BLK_DEV_FD=y
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_SYN_COOKIES=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDETAPE=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_RTC=y
CONFIG_QUOTA=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_MINIX_FS=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_VGA_CONSOLE=y

I can find out more if necessary.  We've gone back to 2.2.18 for now, so I'm
sure /proc can divulge useful information, if I knew where to look.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
