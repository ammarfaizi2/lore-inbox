Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285034AbRLQHDm>; Mon, 17 Dec 2001 02:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285036AbRLQHDe>; Mon, 17 Dec 2001 02:03:34 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:13700 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S285034AbRLQHC6>; Mon, 17 Dec 2001 02:02:58 -0500
Date: Mon, 17 Dec 2001 09:02:34 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: andrea@suse.com
Cc: linux-kernel@vger.kernel.org
Subject: .17-rc1 - oom killer still sneaks in
Message-ID: <20011217090234.M12063@niksula.cs.hut.fi>
In-Reply-To: <20011216124328.E21566@niksula.cs.hut.fi> <20011216191325.K12063@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011216191325.K12063@niksula.cs.hut.fi>; from vherva@niksula.hut.fi on Sun, Dec 16, 2001 at 07:13:25PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2001 at 07:13:25PM +0200, you [Ville Herva] claimed:
> I spent a good while trying to reproduce this on 17rc1 (never got as far as
> to try -aa), but I never got it booting.

Ok, I got 17-rc1 to boot (thanks to Matt Domsch). What happens is this:


uname -a
Linux whale.viasys.com 2.4.17-rc1 #4 SMP Sun Dec 16 17:42:51 EET 2001 ia64 unknown

## Fille the cache
find / -type f -exec cat {} \; > /dev/null
updatedb


             total	 used       free     shared    buffers     cached
Mem:	   2057536    2045744      11792	0	165120     1420112
-/+ buffers/cache:     460512    1597024
Swap:       255984       2064     253920

slabinfo - version: 1.1 (SMP)
kmem_cache           111    111    432    3    3    1 :  124   62
ip_fib_hash           10    454     32    1    1    1 :  252  126
devfsd_event           1    454     32    1    1    1 :  252  126
clip_arp_cache         0      0    256    0    0    1 :  252  126
ip_mrt_cache           0      0    128    0    0    1 :  252  126
tcp_tw_bucket          0      0    128    0    0    1 :  252  126
tcp_bind_bucket       36    240     64    1    1    1 :  252  126
tcp_open_request       0      0    128    0    0    1 :  252  126
inet_peer_cache        1    123    128    1    1    1 :  252  126
ip_dst_cache         186    186    256    3    3    1 :  252  126
arp_cache              3    166    192    2    2    1 :  252  126
blkdev_requests      512    581    192    7    7    1 :  252  126
journal_head         210   2655     88   12   15    1 :  252  126
revoke_table           1    816     16    1    1    1 :  252  126
revoke_record          0      0     64    0    0    1 :  252  126
dnotify cache          0      0     40    0    0    1 :  252  126
file lock cache       99    198    160    1    2    1 :  252  126
fasync cache           1    582     24    1    1    1 :  252  126
uid_cache              2    240     64    1    1    1 :  252  126
skbuff_head_cache    370    496    256    8    8    1 :  252  126
sock                 220    220   1600   22   22    1 :   60   30
sigqueue             290    348    136    3    3    1 :  252  126
cdev_cache           152    480     64    2    2    1 :  252  126
bdev_cache             5    246    128    2    2    1 :  252  126
mnt_cache             16    246    128    2    2    1 :  252  126
inode_cache       169008 169008    768 8048 8048    1 :  124   62
dentry_cache      170316 170316    192 2052 2052    1 :  252  126
dquot                  0      0    192    0    0    1 :  252  126
filp                1579   1660    192   20   20    1 :  252  126
names_cache           16     16   4096    4    4    1 :   60   30
buffer_head       393459 394333    192 4746 4751    1 :  252  126
mm_struct            186    186    256    3    3    1 :  252  126
vm_area_struct      3609   3735    192   45   45    1 :  252  126
fs_cache             240    240     64    1    1    1 :  252  126
files_cache          133    133    832    7    7    1 :  124   62
signal_act            90     90   1600    9    9    1 :   60   30


vherva@whale:/home/vherva/scratch>./alloc 1700
Allocating 1700 megs...

1615MB
zsh: killed     ./alloc 1700
dmesg: Out of memory: killed process 10298 (alloc)

It got there pretty quick - .16 spent ~15 minutes in around 1200MB grinding
in kswapd.

             total	 used       free     shared    buffers     cached
Mem:	   2057536     513184    1544352	0	 366224    20096
-/+ buffers/cache:     126864    1930672
Swap:       255984     141728     114256

slabinfo - version: 1.1 (SMP)
kmem_cache           111    111    432    3    3    1 :  124   62
ip_fib_hash           10    454     32    1    1    1 :  252  126
devfsd_event           0      0     32    0    0    1 :  252  126
clip_arp_cache         0      0    256    0    0    1 :  252  126
ip_mrt_cache           0      0    128    0    0    1 :  252  126
tcp_tw_bucket          0      0    128    0    0    1 :  252  126
tcp_bind_bucket       28    240     64    1    1    1 :  252  126
tcp_open_request       0      0    128    0    0    1 :  252  126
inet_peer_cache        2    123    128    1    1    1 :  252  126
ip_dst_cache          48    248    256    4    4    1 :  252  126
arp_cache              5     83    192    1    1    1 :  252  126
blkdev_requests      512    581    192    7    7    1 :  252  126
journal_head         146    885     88    5    5    1 :  252  126
revoke_table           1    816     16    1    1    1 :  252  126
revoke_record          0      0     64    0    0    1 :  252  126
dnotify cache          0      0     40    0    0    1 :  252  126
file lock cache        2     99    160    1    1    1 :  252  126
fasync cache           1    582     24    1    1    1 :  252  126
uid_cache              2    240     64    1    1    1 :  252  126
skbuff_head_cache    336    496    256    8    8    1 :  252  126
sock                 210    210   1600   21   21    1 :   60   30
sigqueue             222    348    136    3    3    1 :  252  126
cdev_cache           273    480     64    2    2    1 :  252  126
bdev_cache             5    246    128    2    2    1 :  252  126
mnt_cache             16    246    128    2    2    1 :  252  126
inode_cache          910   3213    768  153  153    1 :  124   62
dentry_cache         953   6723    192   81   81    1 :  252  126
dquot                  0      0    192    0    0    1 :  252  126
filp                1632   1826    192   22   22    1 :  252  126
names_cache            8      8   4096    2    2    1 :   60   30
buffer_head        93108 158613    192 1904 1911    1 :  252  126
mm_struct            181    186    256    3    3    1 :  252  126
vm_area_struct      3692   3818    192   46   46    1 :  252  126
fs_cache             181    480     64    2    2    1 :  252  126
files_cache          114    114    832    6    6    1 :  124   62
signal_act            90     90   1600    9    9    1 :   60   30


So it seems reluctant to give up buffers.

Much better than .16, though, and it readily frees icache and dcache.

Want me to try -aa?


-- v --

v@iki.fi
