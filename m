Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277552AbRKABla>; Wed, 31 Oct 2001 20:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277514AbRKABlT>; Wed, 31 Oct 2001 20:41:19 -0500
Received: from zanzibar.zantaz.com ([206.169.210.12]:3285 "EHLO
	zanzibar.zantaz.com") by vger.kernel.org with ESMTP
	id <S277371AbRKABlB>; Wed, 31 Oct 2001 20:41:01 -0500
Message-ID: <12C7D768CC8ED4118A9200508BEEC6FB018C2B00@zanexch.zantaz.com>
From: Vijay Gadad <vgadad@zantaz.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Slab Allocator Leak?
Date: Wed, 31 Oct 2001 17:42:45 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a script (below) which creates a file, deletes it, and loops.  In
/proc/slabinfo, I see many dentry_cache slabs being created - to the point
where nearly all free memory is consumed.  The system is still usable, as
the slab allocator responds to memory pressure and releases some of these
dentry_cache slabs.

If I understand the USENIX paper correctly, a single dentry_cache slab
buffer should be sufficient for my case, as the system will reuse that
buffer for the new dentry.

Furthermore, this memory consumption only occurs with different filenames.
If I simply do a "while [ 1 ] ; do touch myfile ; rm myfile ; done", the
extra dentry_cache slabs do not get created.

I've been able to reproduce this under 2.4.2, 2.4.9, 2.4.13, and someone
else confirmed they saw this behavior under 2.4.13-ac3.

Thanks.


Vijay Gadad
vgadad@zantaz.com


-----CUT-----
#!/bin/sh

COUNTER=2000000000

while [ $COUNTER -gt 0 ]
do
  touch testfile.$COUNTER
  rm -f testfile.$COUNTER
  COUNTER=`expr $COUNTER - 1`
done
-----CUT-----


# cat /proc/slabinfo
slabinfo - version: 1.1
kmem_cache            54     78    100    2    2    1
tcp_tw_bucket          0      0     96    0    0    1
tcp_bind_bucket       29    113     32    1    1    1
tcp_open_request       0      0     64    0    0    1
inet_peer_cache        0      0     64    0    0    1
ip_fib_hash           10    113     32    1    1    1
ip_dst_cache          14     24    160    1    1    1
arp_cache              3     30    128    1    1    1
blkdev_requests      256    280     96    7    7    1
dnotify cache          0      0     20    0    0    1
file lock cache        2     42     92    1    1    1
fasync cache           0      0     16    0    0    1
uid_cache              2    113     32    1    1    1
skbuff_head_cache     54     72    160    3    3    1
sock                  82     90    832   10   10    2
sigqueue               1     29    132    1    1    1
cdev_cache           495    826     64   12   14    1
bdev_cache          6605   6962     64  114  118    1
mnt_cache             14     59     64    1    1    1
inode_cache        10809  13632    480 1703 1704    1
dentry_cache      253205 253230    128 8441 8441    1
filp                 553    560     96   14   14    1
names_cache            0      7   4096    0    7    1
buffer_head        42229  42280     96 1056 1057    1
mm_struct             29     48    160    2    2    1
vm_area_struct       772   1062     64   14   18    1
fs_cache              28     59     64    1    1    1
files_cache           28     36    416    4    4    1
signal_act            32     33   1312   11   11    1
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
size-4096             75     76   4096   75   76    1
size-2048(DMA)         0      0   2048    0    0    1
size-2048             38     42   2048   20   21    1
size-1024(DMA)         0      0   1024    0    0    1
size-1024             25     28   1024    7    7    1
size-512(DMA)          0      0    512    0    0    1
size-512              29     32    512    4    4    1
size-256(DMA)          0      0    256    0    0    1
size-256               8     15    256    1    1    1
size-128(DMA)          0      0    128    0    0    1
size-128             439    450    128   15   15    1
size-64(DMA)           0      0     64    0    0    1
size-64              114    236     64    3    4    1
size-32(DMA)           0      0     32    0    0    1
size-32           251432 261595     32 2226 2315    1
