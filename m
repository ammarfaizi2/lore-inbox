Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318945AbSIIW5q>; Mon, 9 Sep 2002 18:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318949AbSIIW5q>; Mon, 9 Sep 2002 18:57:46 -0400
Received: from pintail.mail.pas.earthlink.net ([207.217.120.122]:58803 "EHLO
	pintail.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S318945AbSIIW5o>; Mon, 9 Sep 2002 18:57:44 -0400
Date: Mon, 9 Sep 2002 19:02:30 -0400
To: linux-kernel@vger.kernel.org
Subject: AIM7 on 2.5 has process hang in do_IRQ, but 2.4 doesn't
Message-ID: <20020909230230.GA5677@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AIM7 on 2.5.x behaves different than 2.4.x.

On 2.5.x aim7 eventually has a process that doesn't exit.
The process appears to be in an infinite loop.  vmstat shows 
100% user time.  strace -p PID doesn't print anything.

A tasktrace on the hung process (from sysrq T) shows:
multitask     R current     16 955243 958223           (NOTLB)
do_IRQ
common_interrupt

vmstat 60 leading up to the never-exiting process:
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 9  0  0   1652 289020  44476  10996   0   0     1  1595 1362   758  67  16  17
17  0  0   1652 288712  44796   8552   0   0     0  2184 1526  1097  56  25  19
17  0  0   1652 282968  45068   8428   0   0     0  1415 1337   694  86  14   0
 7  0  0   1652 293420  45380   8532   0   0     0  2028 1486  1019  73  22   5
24  0  0   1652 280248  45696  11572   0   0     0  1767 1416   891  59  23  18
24  0  0   1652 273480  45996   6716   0   0     0  2252 1538  1133  78  22   0
24  0  0   1652 277976  46272   9320   0   0     0   908 1209   438  90  10   0
 9  0  0   1652 290508  46608   9000   0   0     0   922 1212   449  83  17   0
 1  0  0   1652 294960  46848   6744   0   0     0  1217 1298   604  86  14   0
 1  0  0   1652 294944  46864   6744   0   0     0     1 1000     2 100   0   0
 5  0  0   1652 294456  46884   6888   5   0     8     0  333     1  95   0   5
 1  0  0   1608 294208  46908   7068   1   0     4     0 1003     5 100   0   0
 1  0  0   1608 294048  46924   7084   0   0     0     1 1001     2 100   0   0
 1  0  0   1608 294032  46940   7084   0   0     0     1 1000     2 100   0   0


14 kernels between 2.5.25 and 2.5.33-mm5 including dj have
behaved the same.  None of the 27 kernels between 2.4.19-rc1
and 2.4.20-pre5 (various trees) have had the problem.  It has
only been an issue on a uniprocessor box.  On SMP aim7 completes 
normally.

The last thing in the logfile is a job called "job_timing".
Earlier in the run, job_timing completes on the "dbase" workload.  
(job_timing gets scheduled several times).

This is the current config:
CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_NET=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_MK6=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_TSC=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_BLK_DEV_FD=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IPV6_SCTP__=y
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_8139TOO=y
CONFIG_INPUT=y
CONFIG_SOUND_GAMEPORT=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=64
CONFIG_REISERFS_FS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
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
CONFIG_EXPORTFS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_VGA_CONSOLE=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_SECURITY_CAPABILITIES=y

Anything else that would be helpful?

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

