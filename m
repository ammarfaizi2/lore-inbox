Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262618AbRF0O1q>; Wed, 27 Jun 2001 10:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262580AbRF0O11>; Wed, 27 Jun 2001 10:27:27 -0400
Received: from [202.96.44.20] ([202.96.44.20]:12216 "HELO smtp.263.net")
	by vger.kernel.org with SMTP id <S262609AbRF0O1I>;
	Wed, 27 Jun 2001 10:27:08 -0400
Message-ID: <001e01c0ff14$0bdc7540$0101a8c0@weqeqe>
Reply-To: "Zeng Yu" <yu_zeng@263.net>
From: "Zeng Yu" <yu_zeng@263.net>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: Ramdisk Bug?
Date: Wed, 27 Jun 2001 22:18:26 +0800
Organization: Capitel
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I think find a ramdisk bug of 2.4.4 kernel -- ramdisk
use both buffers and cached mem of the same size, thus
double the mem use. 
mke2fs -m0 /dev/ram1
mount /dev/ram1 /mnt
dd if=/dev/zero of=/mnt/data bs=1k count=110000
cat /proc/meminfo will see that both buffers and
cached mem increase about 110M of size. More worse,
the cached mem won't be released untile the ramdisk
be umounted. I attach the meminfo and slabinfo before
and after data transfer below.

This problem is not found on redhat7.1 of 2.4.2 kernel and
redhat7.0 of 2.2.16 kernel.

meminfo before transfer data to ramdisk:
        total:    used:    free:  shared: buffers:  cached:
Mem:  260780032 17068032 243712000     0  4943872  6971392
Swap: 139788288        0 139788288
MemTotal:       254668 kB
MemFree:        238000 kB
MemShared:           0 kB
Buffers:          4828 kB
Cached:           6808 kB
Active:           8376 kB
Inact_dirty:      3260 kB
Inact_clean:         0 kB
Inact_target:      108 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       254668 kB
LowFree:        238000 kB
SwapTotal:      136512 kB
SwapFree:       136512 kB

meminfo after transfer data to ramdisk:
        total:    used:    free:  shared: buffers:  cached:
Mem:  260780032 258662400  2117632    0 117317632 115666944
Swap: 139788288  2048000 137740288
MemTotal:       254668 kB
MemFree:          2068 kB
MemShared:           0 kB
Buffers:        114568 kB
Cached:         112956 kB
Active:         224960 kB
Inact_dirty:        52 kB
Inact_clean:      2512 kB
Inact_target:     1924 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       254668 kB
LowFree:          2068 kB
SwapTotal:      136512 kB
SwapFree:       134512 kB

slabinfo before transfer data to ramdisk:
slabinfo - version: 1.1
kmem_cache            58     78    100    2    2    1
ip_fib_hash           17    113     32    1    1    1
ip_conntrack           3     11    352    1    1    1
ip_mrt_cache           0      0     96    0    0    1
tcp_tw_bucket          0      0     96    0    0    1
tcp_bind_bucket        1    113     32    1    1    1
tcp_open_request       0      0     64    0    0    1
inet_peer_cache        0      0     64    0    0    1
ip_dst_cache           7     20    192    1    1    1
arp_cache              0      0    128    0    0    1
nfs_read_data          0      0    384    0    0    1
nfs_write_data         0      0    384    0    0    1
nfs_page               0      0     96    0    0    1
blkdev_requests     2048   2080     96   52   52    1
dnotify cache          0      0     20    0    0    1
file lock cache        1     42     92    1    1    1
fasync cache           0      0     16    0    0    1
uid_cache              1    113     32    1    1    1
skbuff_head_cache     93     96    160    4    4    1
sock                   9     18    832    1    2    2
inode_cache          237    240    480   30   30    1
bdev_cache             7     59     64    1    1    1
sigqueue               0     29    132    0    1    1
dentry_cache         434    450    128   15   15    1
dquot                  0      0     96    0    0    1
filp                  77     80     96    2    2    1
names_cache            0      8   4096    0    8    1
buffer_head         5959   5960     96  149  149    1
mm_struct             12     30    128    1    1    1
vm_area_struct       153    177     64    3    3    1
fs_cache              11     59     64    1    1    1
files_cache           11     18    416    2    2    1
signal_act            13     15   1312    5    5    1
size-131072(DMA)       0      0 131072    0    0   32
size-131072            0      0 131072    0    0   32
size-65536(DMA)        0      0  65536    0    0   16
size-65536             0      0  65536    0    0   16
size-32768(DMA)        0      0  32768    0    0    8
size-32768             0      0  32768    0    0    8
size-16384(DMA)        0      0  16384    0    0    4
size-16384             0      0  16384    0    0    4
size-8192(DMA)         0      0   8192    0    0    2
size-8192              0      0   8192    0    0    2
size-4096(DMA)         0      0   4096    0    0    1
size-4096             19     19   4096   19   19    1
size-2048(DMA)         0      0   2048    0    0    1
size-2048             88     90   2048   45   45    1
size-1024(DMA)         0      0   1024    0    0    1
size-1024             29     32   1024    8    8    1
size-512(DMA)          0      0    512    0    0    1
size-512              21     24    512    3    3    1
size-256(DMA)          0      0    256    0    0    1
size-256              19     45    256    3    3    1
size-128(DMA)          0      0    128    0    0    1
size-128             561    570    128   19   19    1
size-64(DMA)           0      0     64    0    0    1
size-64               95    118     64    2    2    1
size-32(DMA)           0      0     32    0    0    1
size-32              343    452     32    4    4    1

slabinfo after transfer data to ramdisk:
slabinfo - version: 1.1
kmem_cache            58     78    100    2    2    1
ip_fib_hash           17    113     32    1    1    1
ip_conntrack           1     11    352    1    1    1
ip_mrt_cache           0      0     96    0    0    1
tcp_tw_bucket          0      0     96    0    0    1
tcp_bind_bucket        1    113     32    1    1    1
tcp_open_request       0      0     64    0    0    1
inet_peer_cache        0      0     64    0    0    1
ip_dst_cache           7     20    192    1    1    1
arp_cache              0      0    128    0    0    1
nfs_read_data          0      0    384    0    0    1
nfs_write_data         0      0    384    0    0    1
nfs_page               0      0     96    0    0    1
blkdev_requests     2048   2080     96   52   52    1
dnotify cache          0      0     20    0    0    1
file lock cache        1     42     92    1    1    1
fasync cache           0      0     16    0    0    1
uid_cache              1    113     32    1    1    1
skbuff_head_cache     93     96    160    4    4    1
sock                   9      9    832    1    1    2
inode_cache           81    200    480   25   25    1
bdev_cache             3     59     64    1    1    1
sigqueue               0     29    132    0    1    1
dentry_cache          73    330    128   11   11    1
dquot                  0      0     96    0    0    1
filp                  77     80     96    2    2    1
names_cache            0      2   4096    0    2    1
buffer_head       224544 224880     96 5622 5622    1
mm_struct             12     30    128    1    1    1
vm_area_struct       153    177     64    3    3    1
fs_cache              11     59     64    1    1    1
files_cache           11     18    416    2    2    1
signal_act            13     15   1312    5    5    1
size-131072(DMA)       0      0 131072    0    0   32
size-131072            0      0 131072    0    0   32
size-65536(DMA)        0      0  65536    0    0   16
size-65536             0      0  65536    0    0   16
size-32768(DMA)        0      0  32768    0    0    8
size-32768             0      0  32768    0    0    8
size-16384(DMA)        0      0  16384    0    0    4
size-16384             0      0  16384    0    0    4
size-8192(DMA)         0      0   8192    0    0    2
size-8192              0      0   8192    0    0    2
size-4096(DMA)         0      0   4096    0    0    1
size-4096             19     19   4096   19   19    1
size-2048(DMA)         0      0   2048    0    0    1
size-2048             88     90   2048   45   45    1
size-1024(DMA)         0      0   1024    0    0    1
size-1024             29     32   1024    8    8    1
size-512(DMA)          0      0    512    0    0    1
size-512              21     24    512    3    3    1
size-256(DMA)          0      0    256    0    0    1
size-256              19     45    256    3    3    1
size-128(DMA)          0      0    128    0    0    1
size-128             561    570    128   19   19    1
size-64(DMA)           0      0     64    0    0    1
size-64               87    118     64    2    2    1
size-32(DMA)           0      0     32    0    0    1
size-32              199    452     32    4    4    1


Best,

Zeng Yu

