Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281865AbRLHPkC>; Sat, 8 Dec 2001 10:40:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281877AbRLHPjn>; Sat, 8 Dec 2001 10:39:43 -0500
Received: from nc-ashvl-66-169-84-151.charternc.net ([66.169.84.151]:12928
	"EHLO orp.orf.cx") by vger.kernel.org with ESMTP id <S281865AbRLHPjV>;
	Sat, 8 Dec 2001 10:39:21 -0500
Message-Id: <200112081539.fB8FdFj03048@orp.orf.cx>
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: 2.4.16 memory badness (reproducible)
Organization: Department of Tesselating Kumquats
X-URL: http://orf.cx
X-face: "(Qpt_9H~41JFy=C&/h^zmz6Dm6]1ZKLat1<W!0bNwz2!LxG-lZ=r@4Me&uUvG>-r\?<DcD
 b+Y'p'sCMJ
From: Leigh Orf <orf@mailbag.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 08 Dec 2001 10:39:14 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been having confounding out-of-memory problems with 2.4.16 on my
1.4MHz Athlon with 1 GB of memory (2 GB of swap). I just caught it in
the act and I think it relates to some of the weirdness others have been
reporting.

I'm running RedHat 7.2. After bootup, it runs a program called updatedb
(slocate -u) which does a lot of file i/o as it indexes all the files on
my hard drives. Following this action, my machine is in a state which
make many applications give "cannot allocate memory" errors. It seems
the kernel is not freeing up buffered or cached memory, and even more
troubling is the fact that it isn't using any of my swap space.

Here is the state of the machine after updatedb runs:

home[1006]:/home/orf% free
             total       used       free     shared    buffers     cached
Mem:       1029820    1021252       8568          0     471036      90664
-/+ buffers/cache:     459552     570268
Swap:      2064344          0    2064344

home[1003]:/home/orf% cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  1054535680 1045901312  8634368        0 480497664 93954048
Swap: 2113888256        0 2113888256
MemTotal:      1029820 kB
MemFree:          8432 kB
MemShared:           0 kB
Buffers:        469236 kB
Cached:          91752 kB
SwapCached:          0 kB
Active:         383812 kB
Inactive:       229016 kB
HighTotal:      130992 kB
HighFree:         2044 kB
LowTotal:       898828 kB
LowFree:          6388 kB
SwapTotal:     2064344 kB
SwapFree:      2064344 kB

home[1005]:/home/orf% cat /proc/slabinfo
slabinfo - version: 1.1
kmem_cache            65     68    112    2    2    1
ip_conntrack           9     50    384    4    5    1
nfs_write_data         0      0    384    0    0    1
nfs_read_data          0      0    384    0    0    1
nfs_page               0      0    128    0    0    1
ip_fib_hash           10    112     32    1    1    1
urb_priv               0      0     64    0    0    1
clip_arp_cache         0      0    128    0    0    1
ip_mrt_cache           0      0    128    0    0    1
tcp_tw_bucket          0      0    128    0    0    1
tcp_bind_bucket        8    112     32    1    1    1
tcp_open_request       0      0    128    0    0    1
inet_peer_cache        4     59     64    1    1    1
ip_dst_cache          27     40    192    2    2    1
arp_cache              3     30    128    1    1    1
blkdev_requests      640    660    128   22   22    1
journal_head           0      0     48    0    0    1
revoke_table           0      0     12    0    0    1
revoke_record          0      0     32    0    0    1
dnotify cache          0      0     20    0    0    1
file lock cache        2     42     92    1    1    1
fasync cache           2    202     16    1    1    1
uid_cache              5    112     32    1    1    1
skbuff_head_cache    327    340    192   17   17    1
sock                 188    198   1280   66   66    1
sigqueue               2     29    132    1    1    1
cdev_cache          2313   2360     64   40   40    1
bdev_cache             8     59     64    1    1    1
mnt_cache             19     59     64    1    1    1
inode_cache       439584 439586    512 62798 62798    1
dentry_cache      454136 454200    128 15140 15140    1
dquot                  0      0    128    0    0    1
filp                1471   1500    128   50   50    1
names_cache            0      2   4096    0    2    1
buffer_head       144413 173280    128 5776 5776    1
mm_struct             57     80    192    4    4    1
vm_area_struct      2325   2760    128   92   92    1
fs_cache              56    118     64    2    2    1
files_cache           56     72    448    8    8    1
signal_act            64     72   1344   24   24    1
size-131072(DMA)       0      0 131072    0    0   32
size-131072            0      0 131072    0    0   32
size-65536(DMA)        0      0  65536    0    0   16
size-65536             1      1  65536    1    1   16
size-32768(DMA)        0      0  32768    0    0    8
size-32768             1      1  32768    1    1    8
size-16384(DMA)        0      0  16384    0    0    4
size-16384             1      1  16384    1    1    4
size-8192(DMA)         0      0   8192    0    0    2
size-8192              4      4   8192    4    4    2
size-4096(DMA)         0      0   4096    0    0    1
size-4096             64     68   4096   64   68    1
size-2048(DMA)         0      0   2048    0    0    1
size-2048             52     66   2048   27   33    1
size-1024(DMA)         0      0   1024    0    0    1
size-1024          11042  11048   1024 2762 2762    1
size-512(DMA)          0      0    512    0    0    1
size-512           12004  12016    512 1501 1502    1
size-256(DMA)          0      0    256    0    0    1
size-256            1678   1695    256  113  113    1
size-128(DMA)          2     30    128    1    1    1
size-128           29398  29430    128  980  981    1
size-64(DMA)           0      0     64    0    0    1
size-64             7954   7965     64  135  135    1
size-32(DMA)          34     59     64    1    1    1
size-32            66711  66729     64 1131 1131    1

Now, I try to run a common application:

home[1031]:/home/orf% xmms   
Memory fault 

Strace on xmms shows:

home[1008]:/home/orf/memfuck% cat xmms.strace
[snip]
modify_ldt(0x1, 0xbffff1fc, 0x10)       = -1 ENOMEM (Cannot allocate memory)
--- SIGSEGV (Segmentation fault) ---
+++ killed by SIGSEGV +++

Also, from my syslog (I have an ntfs partition):

Dec  8 09:55:01 orp kernel: NTFS: ntfs_insert_run: ntfs_vmalloc(new_size = 0x1000) failed
Dec  8 09:55:01 orp kernel: NTFS: ntfs_process_runs: ntfs_insert_run failed
Dec  8 09:55:01 orp kernel: NTFS: ntfs_getdir_unsorted(): Read failed. Returning error code -95.
Dec  8 09:55:01 orp kernel: NTFS: ntfs_insert_run: ntfs_vmalloc(new_size = 0x1000) failed
Dec  8 09:55:01 orp kernel: NTFS: ntfs_process_runs: ntfs_insert_run failed
Dec  8 09:55:01 orp kernel: NTFS: ntfs_getdir_unsorted(): Read failed. Returning error code -95.
Dec  8 09:55:01 orp kernel: NTFS: ntfs_insert_run: ntfs_vmalloc(new_size = 0x1000) failed
Dec  8 09:55:01 orp kernel: NTFS: ntfs_process_runs: ntfs_insert_run failed
Dec  8 09:55:01 orp kernel: NTFS: ntfs_insert_run: ntfs_vmalloc(new_size = 0x1000) failed
Dec  8 09:55:01 orp kernel: NTFS: ntfs_process_runs: ntfs_insert_run failed

The program nautilus, which is involved with the Gnome windowing stuff,
also complains it can't allocate memory if I log into the console after
udpatedb has run (that's what clued me into this problem in the first
place).

The only way I can find to make the system usable is to run an
application which aggressively recovers some of this buffered/cached
memory, and quit it. One easy way to do this:

home[1014]:/home/orf% lmdd opat=1 count=1 bs=900m

After I do this, much free memory is available.

Some applications are able to "reclaim" the buffered/cached memory,
while others aren't. Netscape doesn't have a problem, for instance,
running after updatedb runs.

This is a pretty serious problem. Interestingly enough, it does NOT
occur on my other machine, running same kernel and RH7.2, with 256M
memory and 512M swap.

Leigh Orf

