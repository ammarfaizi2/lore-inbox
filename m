Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286502AbRL0TE2>; Thu, 27 Dec 2001 14:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286477AbRL0TEU>; Thu, 27 Dec 2001 14:04:20 -0500
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:13309 "EHLO
	swan.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S286519AbRL0TEI>; Thu, 27 Dec 2001 14:04:08 -0500
Date: Thu, 27 Dec 2001 14:07:23 -0500
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.2-pre1 dbench 32 hangs in vmstat "b" state
Message-ID: <20011227140723.A4713@earthlink.net>
In-Reply-To: <20011221091104.A120@earthlink.net> <20011221154654.E811@suse.de> <20011221185538.A131@earthlink.net> <20011224150337.A593@suse.de> <20011224115953.A118@earthlink.net> <20011224180244.C1241@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011224180244.C1241@suse.de>; from axboe@suse.de on Mon, Dec 24, 2001 at 06:02:44PM +0100
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2001 at 06:02:44PM +0100, Jens Axboe wrote:
> > I tried unpatched 2.5.2-pre1 on a k6-2.  dbench 32 hung similarly with 
> > 32 in "b", bo and bi = 0, and id = 100.  That machine is ill now and can't
> > find "init" when booting, boot single, or boot init=/bin/bash.
> 
> Please send ps -eo cmd,wchan info for a hung machine.
> 
> -- 
> Jens Axboe
> 

I rebuilt the reiserfs that dbench writes to.
Here is ps -eo cmd,wchan on the k6-2 running 2.5.2-pre2:

CMD              WCHAN
init             do_select
[keventd]        context_thread
[ksoftirqd_CPU0] ksoftirqd
[kswapd]         kswapd
[bdflush]        bdflush
[kupdated]       get_request_wait
[kreiserfsd]     get_request_wait
/usr/sbin/syslog get_request_wait
/usr/sbin/klogd  do_syslog
[eth0]           rtl8139_thread
/usr/sbin/iplog  do_select
/usr/sbin/iplog  do_poll
/usr/sbin/iplog  get_request_wait
/usr/sbin/iplog  do_select
/usr/sbin/iplog  wait_for_packet
/usr/sbin/sshd   do_select
/sbin/agetty tty read_chan
/bin/login --    down
/usr/sbin/sshd   do_select
-bash            wait4
-su              wait4
/usr/sbin/sshd   do_select
-bash            wait4
/dbench 32      get_request_wait
/dbench 32      get_request_wait
/dbench 32      get_request_wait
/dbench 32      get_request_wait
/dbench 32      get_request_wait
/dbench 32      get_request_wait
/dbench 32      get_request_wait
/dbench 32      get_request_wait
/dbench 32      get_request_wait
/dbench 32      get_request_wait
/dbench 32      get_request_wait
/dbench 32      get_request_wait
/dbench 32      get_request_wait
/dbench 32      get_request_wait
/dbench 32      get_request_wait
/dbench 32      get_request_wait
/dbench 32      get_request_wait
/dbench 32      get_request_wait
/dbench 32      get_request_wait
/dbench 32      get_request_wait
/dbench 32      get_request_wait
/dbench 32      get_request_wait
/dbench 32      get_request_wait
/dbench 32      get_request_wait
/dbench 32      get_request_wait
/dbench 32      get_request_wait
/dbench 32      get_request_wait
/dbench 32      get_request_wait
/dbench 32      get_request_wait
/dbench 32      get_request_wait
/dbench 32      get_request_wait
/dbench 32      get_request_wait
/usr/sbin/sshd   do_select
/usr/sbin/sshd   get_request_wait
ed /tmp/ls       get_request_wait
ps -eo cmd,wchan -


vmstat 3
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 1 37  2      0  25464   3224 333252   0   0    13   371  107    33   0   4  96
 0 37  2      0  25460   3224 333252   0   0     0     0  102     6   0   0 100
 0 37  2      0  25460   3224 333252   0   0     0     0  101     7   0   0 100


I rebooted and ran dbench 32 on a new ext2 filesystem.  dbench runs okay for about
30 seconds.  Towards the end of the vmstat output below, I try to ssh in, the "b"
column goes up, but I don't the a bash prompt.

mountain:~$ vmstat 10
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 1  0  0      0 346236  20012   6316   0   0   793    67  174   164   3   8  90
 0 32  0      0 182364  21396 162428   0   0    79  3492  136   109   2  26  72
21 11  0      0 163904  21532 180264   0   0     0 11683  209    97   0  11  89
 0 32  0      0  32416  23224 306540   0   0     5  6375  226   108   1  27  72
 0 32  1      0  22552  23392 315972   0   0     3  9807  206    98   0   8  92
 0 32  2    132   4584   7128 349660   0   0    13  2905  192   204   2  29  69
 0 32  2    132   4580   7128 349660   0   0     0     0  101    44   0   0 100
 0 32  2    132   4580   7128 349660   0   0     0     0  100    45   0   0 100
 0 32  2    132   4580   7128 349660   0   0     0     0  100    44   0   0 100
 0 32  2    132   4580   7128 349660   0   0     0     0  100    44   0   0 100
 0 32  2    132   4580   7128 349660   0   0     0     0  100    44   0   0 100
 0 32  2    132   4580   7128 349660   0   0     0     0  100    44   0   0 100
 0 32  2    132   4580   7128 349660   0   0     0     0  101    45   0   0 100
 0 35  2    132   4156   7128 349672   0   0     1     1  104    52   1   0  99
 0 35  2    132   4156   7128 349672   0   0     0     0  100    44   0   0 100

Below is software, hardware, and kernel configs:

Linux (none) 2.5.2-pre2 #1 Thu Dec 27 12:32:39 EST 2001 i586 unknown

Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.11.2
util-linux             2.11n
mount                  2.11n
modutils               2.4.11
e2fsprogs              1.25
reiserfsprogs          3.x.0k-pre14
PPP                    2.4.1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
Modules Loaded


This machine has a VIA chipset.  No proprietary drivers.
384 MB RAM.
Root filesystem on /dev/hdc2  # not the usual /dev/hda

00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 04)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (rev 47)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:07.3 Host bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
00:13.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
01:00.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev 15)

2.4.18-pre1 (and other 2.4.17* kernels run dbench 32, 128 okay on this system)
This is the config difference:

diff 2.5.2-pre2 2.4.18-pre1
> CONFIG_NETLINK_DEV=y
< CONFIG_RAMFS=y


# 2.5.2-pre2 config
CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_KMOD=y
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
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_PM=y
CONFIG_APM=m
CONFIG_APM_DO_ENABLE=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETFILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=y
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_STATE=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_8139TOO=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=64
CONFIG_MOUSE=m
CONFIG_PSMOUSE=y
CONFIG_REISERFS_FS=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=m
CONFIG_NTFS_FS=m
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_CODA_FS=m
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y

-- 
Randy Hron

