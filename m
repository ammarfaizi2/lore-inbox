Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316437AbSEaRe3>; Fri, 31 May 2002 13:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316531AbSEaRe2>; Fri, 31 May 2002 13:34:28 -0400
Received: from mail106.mail.bellsouth.net ([205.152.58.46]:58160 "EHLO
	imf06bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S316437AbSEaRe0>; Fri, 31 May 2002 13:34:26 -0400
Date: Fri, 31 May 2002 13:34:18 -0400 (EDT)
From: Burton Windle <bwindle@fint.org>
X-X-Sender: bwindle@morpheus
To: linux-kernel@vger.kernel.org
cc: alan@redhat.com
Subject: [BUG] Kernel memory leak with swapon/swapoff?
Message-ID: <Pine.LNX.4.43.0205311327400.1593-100000@morpheus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello. I'm trying to explain an apparent memory leak in the kernel that I
can reproduce 100%. Here is the sysrq-m output after producing the leak
(in single-user mode):

Linux version 2.4.19-pre9-ac3 (root@logger) (gcc version 2.95.4 20011002
(Debian prerelease)) #1 Fri May 31 10:27:42 EDT 2002

SysRq : Show Memory
Mem-info:
Free pages:         336kB (     0kB HighMem)
Zone:DMA freepages:   132kB min:   128kB low:   256kB high:   384kB
Zone:Normal freepages:   204kB min:   128kB low:   256kB high:   384kB
Zone:HighMem freepages:     0kB min:     0kB low:     0kB high:     0kB
Free pages:         336kB (     0kB HighMem)
( Active: 251, inactive_dirty: 85, inactive_clean: 95, free: 84 )
3*4kB 1*8kB 1*16kB 1*32kB 1*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB = 132
kB)
19*4kB 2*8kB 1*16kB 1*32kB 1*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB = 20
4kB)
= 0kB)
Swap cache: add 22459, delete 22459, find 306/342, race 0+0
Free swap:            0kB
8192 pages of RAM
0 pages of HIGHMEM
587 reserved pages
419 pages shared
0 pages swap cached
0 pages in page table cache
Buffer memory:      252kB
Cache memory:     1104kB

And here is the /proc/slabinfo:
slabinfo - version: 1.1 (statistics)
kmem_cache            58     84    136    3    3    1 :     58      58     3    0    0
tcp_tw_bucket          0      0     96    0    0    1 :     12      60     3    3    0
tcp_bind_bucket        0      0     24    0    0    1 :     17     102     1    1    0
tcp_open_request       0      0     64    0    0    1 :      1      33     6    6    0
inet_peer_cache        1     78     48    1    1    1 :      2       3     1    0    0
ip_fib_hash            9    145     24    1    1    1 :      9      18     1    0    0
ip_dst_cache          14     48    160    2    2    1 :    215     436     9    7    0
arp_cache              2     32    120    1    1    1 :      4       5     1    0    0
blkdev_requests      144    160     96    4    4    1 :    144     144     4    0    0
journal_head          24     67     56    1    1    1 :    472   59897     8    7    0
revoke_table           6    169     20    1    1    1 :      6       6     1    0    0
revoke_record          0      0     24    0    0    1 :     11      34     2    2    0
dnotify_cache          0      0     28    0    0    1 :      0       0     0    0    0
file_lock_cache        0      0    100    0    0    1 :     13    5100     3    3    0
fasync_cache           0      0     24    0    0    1 :      0       0     0    0    0
uid_cache              0      0     32    0    0    1 :      4      10     1    1    0
skbuff_head_cache    128    208    152    8    8    1 :    193     376     8    0    0
sock                   4      9    832    1    1    2 :     30   25520     7    6    0
sigqueue              29     56    140    2    2    1 :     46   35422    31   29    0
kiobuf                 0      0     64    0    0    1 :      0       0     0    0    0
cdev_cache             1     78     48    1    1    1 :    273     317     4    3    0
bdev_cache             6     59     64    1    1    1 :      7    6655     1    0    0
mnt_cache             16     56     68    1    1    1 :     16      16     1    0    0
inode_cache           63    104    476   13   13    1 :   1531   59580   213    0    0
dentry_cache          49    165    116    5    5    1 :   3144   59435   136    0    0
filp                 421    442    112   13   13    1 :    421     421    13    0    0
names_cache            0      1   4096    0    1    1 :     11  341326   242  241    0
buffer_head         6939   7104    104  192  192    1 :   7129   69493   206   14    0
mm_struct              4     27    144    1    1    1 :     60   41828     3    2    0
vm_area_struct        49    100     76    1    2    1 :   1057 1229416    50   48    0
fs_cache               3     84     44    1    1    1 :     59   41828     1    0    0
files_cache            3      9    424    1    1    1 :     59   41828    11   10    0
signal_act            11     12   1312    4    4    1 :     67   41836    38   34    0
size-131072(DMA)       0      0 131072    0    0   32 :      0       0     0    0    0
size-131072            0      0 131072    0    0   32 :      0       0     0    0    0
size-65536(DMA)        0      0  65536    0    0   16 :      0       0     0    0    0
size-65536             0      0  65536    0    0   16 :      0       0     0    0    0
size-32768(DMA)        0      0  32768    0    0    8 :      0       0     0    0    0
size-32768             0      0  32768    0    0    8 :      0       0     0    0    0
size-16384(DMA)        0      0  16384    0    0    4 :      0       0     0    0    0
size-16384             2      2  16384    2    2    4 :      2       2     2    0    0
size-8192(DMA)         0      0   8192    0    0    2 :      0       0     0    0    0
size-8192              2      2   8192    2    2    2 :      2       2     2    0    0
size-4096(DMA)         0      0   4096    0    0    1 :      0       0     0    0    0
size-4096              7      7   4096    7    7    1 :     40    1269   101   94    0
size-2048(DMA)         0      0   2048    0    0    1 :      0       0     0    0    0
size-2048             10     10   2048    5    5    1 :     14     446    29   24    0
size-1024(DMA)         0      0   1024    0    0    1 :      0       0     0    0    0
size-1024             28     32   1024    8    8    1 :     60   28972    23   15    0
size-512(DMA)          0      0    512    0    0    1 :      0       0     0    0    0
size-512              28     40    512    5    5    1 :    194   11279    90   85    0
size-256(DMA)          0      0    264    0    0    1 :      0       0     0    0    0
size-256               8     15    264    1    1    1 :     98   64087    53   52    0
size-128(DMA)          0      0    136    0    0    1 :      0       0     0    0    0
size-128             433    448    136   16   16    1 :    476   51172    19    3    0
size-64(DMA)           0      0     72    0    0    1 :      0       0     0    0    0
size-64              110    159     72    3    3    1 :    162   13733     5    2    0
size-32(DMA)           0      0     40    0    0    1 :      0       0     0    0    0
size-32              151    276     40    3    3    1 :    848  391898    14   11    0


This is with the 2.4.19-pre9-ac3 kernel, on a PPro200 with 32mb of RAM.
I can reproduce this in either single-user mode or multi-user mode by a
"while true; do swapoff -a & swapon -a ; done" and letting it run a
swapon/swapoff cycle about 6,000 times.

--
Burton Windle                           burton@fint.org
Linux: the "grim reaper of innocent orphaned children."
          from /usr/src/linux-2.4.18/init/main.c:461



