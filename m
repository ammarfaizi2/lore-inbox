Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282489AbRLKRbC>; Tue, 11 Dec 2001 12:31:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282483AbRLKRao>; Tue, 11 Dec 2001 12:30:44 -0500
Received: from dryas.atms.unca.edu ([152.18.35.216]:8321 "EHLO
	dryas.atms.unca.edu") by vger.kernel.org with ESMTP
	id <S282242AbRLKRa1>; Tue, 11 Dec 2001 12:30:27 -0500
Message-Id: <200112111730.fBBHUOl31029@dryas.atms.unca.edu>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Andrea Arcangeli <andrea@suse.de>
From: Leigh Orf <orf@mailbag.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Organization: Department of Tesselating Kumquats
X-URL: http://orf.cx
X-face: "(Qpt_9H~41JFy=C&/h^zmz6Dm6]1ZKLat1<W!0bNwz2!LxG-lZ=r@4Me&uUvG>-r\?<DcDb+Y'p'sCMJ
Subject: Re: 2.4.16 & OOM killer screw up (fwd) 
In-Reply-To: Your message of "Tue, 11 Dec 2001 15:01:19 +0100."
             <20011211150119.H4801@athlon.random> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 11 Dec 2001 12:30:24 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrea Arcangeli wrote:

|   > The problem is that your VM is unnecesarily eating up
|   > memory and then wants swap. That is unacceptable. Having
|   > 90% of your memory in buffers/cache and then the OOM killer
|   > kicks in because nothing is free is what we're moaning
|   > about.
|

|   Dear, Abraham please apply this patch:
|   
|   	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.17pre4aa1.bz2
|   
|   on top of a 2.4.17pre4 and then recompile, try again and send me a
|   bugreport if you can reproduce. thanks,

Andrea,

I applied your patch and it didn't fix the problem.
I reported this earlier to the kernel list but I'm not sure if you got
it. See http://groups.google.com/groups?hl=en&rnum=1&selm=linux.kernel.200112081539.fB8FdFj03048%40orp.orf.cx
or see the recent thread "2.4.16 memory badness (reproducible)". The
behavior I cite with 2.4.16 is identical to what happens with
2.4.17pre4aa1, but here it is again. It is reproducible.
Machine is 1.4GHZ Athlon with 1 GB memory, 2 GB swap, RH 7.2 with
updates.

home[1001]:/home/orf% uname -a
Linux orp.orf.cx 2.4.17-pre4 #1 Mon Dec 10 22:09:16 EST 2001 i686 unknown
(it's been patched with 2.4.17pre4aa1.bz2)
(updatedb updates RedHat's file database, does lots of file I/O)

home[1005]:/home/orf% free         
             total       used       free     shared    buffers     cached
Mem:       1029780     207976     821804          0      49468      71856
-/+ buffers/cache:      86652     943128
Swap:      2064344       6324    2058020

home[1006]:/home/orf% sudo updatedb
Password:

home[1007]:/home/orf% free
             total       used       free     shared    buffers     cached
Mem:       1029780    1017576      12204          0     471548      70924
-/+ buffers/cache:     475104     554676
Swap:      2064344       6312    2058032

home[1008]:/home/orf% xmms
Memory fault 

home[1009]:/home/orf% strace xmms 2>&1 | tail
old_mmap(NULL, 1291080, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40316000
mprotect(0x40448000, 37704, PROT_NONE)  = 0
old_mmap(0x40448000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x131000) = 0x40448000
old_mmap(0x4044e000, 13128, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4044e000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40452000
munmap(0x40018000, 72492)               = 0
modify_ldt(0x1, 0xbffff33c, 0x10)       = -1 ENOMEM (Cannot allocate memory)
--- SIGSEGV (Segmentation fault) ---
+++ killed by SIGSEGV +++

Note that some applications don't mem fault this way, but all the ones
that do die at modify_ldt (see my previous post).

home[1010]:/home/orf% cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  1054494720 1041756160 12738560        0 481837056 77209600
Swap: 2113888256  6463488 2107424768
MemTotal:      1029780 kB
MemFree:         12440 kB
MemShared:           0 kB
Buffers:        470544 kB
Cached:          71388 kB
SwapCached:       4012 kB
Active:         367796 kB
Inactive:       232088 kB
HighTotal:      130992 kB
HighFree:         2044 kB
LowTotal:       898788 kB
LowFree:         10396 kB
SwapTotal:     2064344 kB
SwapFree:      2058032 kB


home[1011]:/home/orf% cat /proc/slabinfo
slabinfo - version: 1.1
kmem_cache            65     68    112    2    2    1
ip_conntrack          22     50    384    5    5    1
nfs_write_data         0      0    384    0    0    1
nfs_read_data          0      0    384    0    0    1
nfs_page               0      0    128    0    0    1
ip_fib_hash           10    112     32    1    1    1
urb_priv               0      0     64    0    0    1
clip_arp_cache         0      0    128    0    0    1
ip_mrt_cache           0      0    128    0    0    1
tcp_tw_bucket          0      0    128    0    0    1
tcp_bind_bucket       17    112     32    1    1    1
tcp_open_request       0      0    128    0    0    1
inet_peer_cache        2     59     64    1    1    1
ip_dst_cache          56     80    192    4    4    1
arp_cache              3     30    128    1    1    1
blkdev_requests      640    660    128   22   22    1
journal_head           0      0     48    0    0    1
revoke_table           0      0     12    0    0    1
revoke_record          0      0     32    0    0    1
dnotify cache          0      0     20    0    0    1
file lock cache        2     42     92    1    1    1
fasync cache           2    202     16    1    1    1
uid_cache              7    112     32    1    1    1
skbuff_head_cache    293    320    192   16   16    1
sock                 131    132   1280   44   44    1
sigqueue               4     29    132    1    1    1
cdev_cache          2313   2360     64   40   40    1
bdev_cache             8     59     64    1    1    1
mnt_cache             19     59     64    1    1    1
inode_cache       452259 452263    512 64609 64609    1
dentry_cache      469963 469980    128 15666 15666    1
dquot                  0      0    128    0    0    1
filp                1633   1650    128   55   55    1
names_cache            0      2   4096    0    2    1
buffer_head       136268 164880    128 5496 5496    1
mm_struct             54     60    192    3    3    1
vm_area_struct      2186   2250    128   73   75    1
fs_cache              53     59     64    1    1    1
files_cache           53     63    448    6    7    1
signal_act            61     63   1344   21   21    1
size-131072(DMA)       0      0 131072    0    0   32
size-131072            0      0 131072    0    0   32
size-65536(DMA)        0      0  65536    0    0   16
size-65536             1      1  65536    1    1   16
size-32768(DMA)        0      0  32768    0    0    8
size-32768             1      1  32768    1    1    8
size-16384(DMA)        0      0  16384    0    0    4
size-16384             1      3  16384    1    3    4
size-8192(DMA)         0      0   8192    0    0    2
size-8192              5      7   8192    5    7    2
size-4096(DMA)         0      0   4096    0    0    1
size-4096             70     73   4096   70   73    1
size-2048(DMA)         0      0   2048    0    0    1
size-2048             64     68   2048   34   34    1
size-1024(DMA)         0      0   1024    0    0    1
size-1024          11028  11032   1024 2757 2758    1
size-512(DMA)          0      0    512    0    0    1
size-512           12029  12032    512 1504 1504    1
size-256(DMA)          0      0    256    0    0    1
size-256            1609   1635    256  109  109    1
size-128(DMA)          2     30    128    1    1    1
size-128           29383  29430    128  980  981    1
size-64(DMA)           0      0     64    0    0    1
size-64             9105   9145     64  155  155    1
size-32(DMA)          34     59     64    1    1    1
size-32            70942  70977     64 1203 1203    1

Leigh Orf

