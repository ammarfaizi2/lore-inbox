Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286910AbRL1OLH>; Fri, 28 Dec 2001 09:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286912AbRL1OK6>; Fri, 28 Dec 2001 09:10:58 -0500
Received: from falcon.mail.pas.earthlink.net ([207.217.120.74]:27791 "EHLO
	falcon.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S286911AbRL1OKl>; Fri, 28 Dec 2001 09:10:41 -0500
Date: Fri, 28 Dec 2001 09:14:01 -0500
To: Jens Axboe <axboe@suse.de>
Cc: rwhron@earthlink.net, linux-kernel@vger.kernel.org
Subject: Re: 2.5.2-pre1 dbench 32 hangs in vmstat "b" state
Message-ID: <20011228091401.A15569@earthlink.net>
In-Reply-To: <20011221091104.A120@earthlink.net> <20011221154654.E811@suse.de> <20011221185538.A131@earthlink.net> <20011224150337.A593@suse.de> <20011224115953.A118@earthlink.net> <20011224180244.C1241@suse.de> <20011227140723.A4713@earthlink.net> <20011228124037.K2973@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011228124037.K2973@suse.de>; from axboe@suse.de on Fri, Dec 28, 2001 at 12:40:37PM +0100
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2001 at 12:40:37PM +0100, Jens Axboe wrote:
> > I rebuilt the reiserfs that dbench writes to.
> > Here is ps -eo cmd,wchan on the k6-2 running 2.5.2-pre2:
> 
> Ah this is interesting, all stuck in get_request_wait. I cannot
> reproduce your problem here whatever I do, no reiser though.
> 
> -- 
> Jens Axboe

That's good news.  It's probably something with my configuration
or hardware.  I saw the livelock on both ext2 and reiserfs.

I removed these options from the config and rebuilt 2.5.2-pre2:
CONFIG_PM=y
CONFIG_APM=m
CONFIG_APM_DO_ENABLE=y
CONFIG_NTFS_FS=m
CONFIG_CODA_FS=m
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_VIDEO_SELECT=y

The initial dbench on ext2 completed for 32 processes but 128 didn't:

vmstat 8
  procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0 128  1    132  14796  22136 314916   0   0     0  5467  272   122   1  13  86
 0 128  1    636   3968  21844 328132   0   9     1  1338  132   125   1  18  81
 0 128  1    636   3964  21844 328132   0   0     0     0  101    44   0   0 100
 0 128  1    636   3964  21844 328132   0   0     0     0  101    45   0   0 100
 0 128  1    636   3964  21844 328132   0   0     0     0  101    45   0   0 100

ps -eo cmd,wchan | uniq
CMD              WCHAN
init             pollwait
[keventd]        context_thread
[ksoftirqd_CPU0] ksoftirqd
[kswapd]         refill_inactive
[bdflush]        try_to_free_buffers
[kupdated]       init_private_file
[kreiserfsd]     reiserfs_get_block
/usr/sbin/syslog pollwait
/usr/sbin/klogd  do_syslog
[eth0]           timer_do_blank_screen
/usr/sbin/iplog  pollwait
/usr/sbin/iplog  select
/usr/sbin/iplog  rt_sigsuspend
/usr/sbin/iplog  pollwait
/usr/sbin/iplog  netdev_ethtool_ioctl
/usr/sbin/sshd   pollwait
/sbin/agetty tty is_internal
/bin/login --    write_chan
/usr/sbin/sshd   pollwait
-bash            wait4
/usr/sbin/sshd   pollwait
-bash            wait4
/bin/bash ./chk  wait4
/dbench 128     wait4
/dbench 128     down
/dbench 128     write_chan
/dbench 128     init_private_file
/dbench 128     write_chan
/dbench 128     down
/dbench 128     write_chan
/dbench 128     down
/dbench 128     write_chan
/dbench 128     down
/dbench 128     write_chan
/dbench 128     down
/dbench 128     write_chan
/dbench 128     down
/dbench 128     write_chan
/dbench 128     down
/dbench 128     write_chan
/dbench 128     down
/dbench 128     write_chan
/dbench 128     down
/dbench 128     write_chan
/dbench 128     down
/dbench 128     write_chan
/dbench 128     down
/dbench 128     write_chan
/dbench 128     down
/dbench 128     write_chan
/dbench 128     down
/dbench 128     write_chan
/dbench 128     down
/dbench 128     write_chan
/dbench 128     down
/dbench 128     write_chan
/dbench 128     down
/dbench 128     write_chan
/dbench 128     down
/dbench 128     write_chan
/dbench 128     down
/dbench 128     write_chan
/dbench 128     down
/dbench 128     write_chan
/dbench 128     down
/dbench 128     write_chan
/dbench 128     add_to_page_cache_unique
/dbench 128     down
/dbench 128     write_chan
/dbench 128     down
/dbench 128     write_chan
/dbench 128     down
/dbench 128     write_chan
/dbench 128     down
ps -eo cmd,wchan -
uniq             do_execve

I stripped down the config a little more by removing these:

CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
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
CONFIG_BLK_DEV_IDECD=m
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_ISO9660_FS=m
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m

With the stripped config, I built 2.5.2-pre3.  It panic'd
with the stripped config.  2.5.2-pre3 panic'd yesterday
on this machine's normal config too.

Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
8139too Fast Ethernet driver 0.9.22
PCI: Found IRQ 11 for device 00:13.0
IRQ routing conflict for 00:13.0, have irq 9, want irq 11
eth0: RealTek RTL8139 Fast Ethernet at 0xd8800000, 00:50:bf:25:68:f3, IRQ 9
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Kernel panic: Out of memory and no killable processes...

I haven't noticed any reports of this panic on 2.5.2-pre3.

Back to 2.5.2-pre2, I removed these:
CONFIG_BLK_DEV_LOOP=m
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETFILTER=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_BLK_DEV_IDE_MODES=y

dbench 32 locked up again.

I re-ran dbench 32, 128 with 2.4.17rc2aa2 on this machine and 
it worked fine.  I'll try 2.5.1 on this machine (2.5.1 was 
okay on another machine).  

--
Randy Hron

