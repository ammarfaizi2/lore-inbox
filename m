Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262063AbVBPQ2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbVBPQ2h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 11:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbVBPQ2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 11:28:36 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:58141 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262063AbVBPQ2O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 11:28:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=V5hcOuim5O+ucHEaTXwBfRRer/0Ymhu9O8Otk4o9gc7AI1ufs3CFGd1gLNzaXPS5NVV4sCV+ZFPTllgjEaaAqviQQzkKhI4dMR+edZ3s8ixAui3McWnQHSaLXCyYqndTijCl/PN4benmAWYWKRIMzUCJ1PNVZtd1VV9TSi8cPqk=
Message-ID: <712fce1050216082847bec092@mail.gmail.com>
Date: Wed, 16 Feb 2005 08:28:09 -0800
From: Martin Bogomolni <martinbogo@gmail.com>
Reply-To: Martin Bogomolni <martinbogo@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: NTFS - Kernel memory leak in driver for kernel 2.4.28?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am maintaining an embedded linux environment that is used for
disaster data recovery for Xpoint Technologies.  The environment is
based on kernel 2.4.28, and a 32megabyte ramdisk containing bash, a
minimal busybox environment, and the backup software with no swap.

During software development to add a new feature to restore individual
files from an NTFS partition, the software started to exhibit out of
memory errors.

The following procedure can be used to replicate the error :

Boot a 2.4.28 kernel, with a 32meg ramdisk and minimal busybox
environment in the initrd ramdisk with the "find" utility.  The NTFS
driver can be compiled in, or can be a module.  This has also been
experimentally verified using a small program that replicates "find"
with careful attention to malloc( ) and free ( ).   However, the
standard "find" utility suffices to show the problem :

Note the available memory in /proc/meminfo, and look at /proc/slabinfo

Mount a large NTFS filesystem, and then run : find /path/to/ntfs -name *

Note the available memory in /proc/meminfo, and look at /proc/slabinfo

Unmounting the ntfs filesystem, and unloading the kernel module (when
compiled as such) had no effect on the amount of free ram available
after the 'find' command is run.   malloc( ) fails to allocate
afterwards. so the kernel does not free any of the missing RAM for
malloc( ).

-------------------------------------------------------------------------

On a testbed machine (P4, 256Mb RAM = IBM Netvista) :

Free Memory before : 209768448 (~200 Mb)
Free Memory after : 3579904 (~35 Mb)

Linux (none) 2.4.28 #1 Tue Feb 15 10:25:25 EST 2005 i686 unknown

(/proc/meminfo before)

       total:    used:    free:  shared: buffers:  cached:
Mem:  252907520 43139072 209768448        0   385024 38862848
Swap:        0        0        0
MemTotal:       246980 kB
MemFree:        204852 kB
MemShared:           0 kB
Buffers:           376 kB
Cached:          37952 kB
SwapCached:          0 kB
Active:           2784 kB
Inactive:        35552 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       246980 kB
LowFree:        204852 kB
SwapTotal:           0 kB
SwapFree:            0 kB

(/proc/slabinfo before)

slabinfo - version: 1.1
kmem_cache            61     72    108    2    2    1
tcp_tw_bucket          0      0     96    0    0    1
tcp_bind_bucket        0      0     32    0    0    1
tcp_open_request       0      0     64    0    0    1
inet_peer_cache        0      0     64    0    0    1
ip_fib_hash            4    113     32    1    1    1
ip_dst_cache           0      0    160    0    0    1
arp_cache              0      0     96    0    0    1
blkdev_requests     3072   4120     96   77  103    1
nfs_write_data         0      0    352    0    0    1
nfs_read_data          0      0    352    0    0    1
nfs_page               0      0     96    0    0    1
journal_head           0      0     48    0    0    1
revoke_table           0      0     12    0    0    1
revoke_record          0      0     32    0    0    1
dnotify_cache          0      0     20    0    0    1
file_lock_cache        0      0     92    0    0    1
fasync_cache           0      0     16    0    0    1
uid_cache              0      0     32    0    0    1
skbuff_head_cache      1     24    160    1    1    1
sock                   5      9    864    1    1    2
sigqueue               0     29    132    0    1    1
kiobuf                 0      0     64    0    0    1
cdev_cache             6     59     64    1    1    1
bdev_cache             3     59     64    1    1    1
mnt_cache             11     59     64    1    1    1
inode_cache          167    168    480   21   21    1
dentry_cache         224    240    128    8    8    1
filp                  37     60    128    2    2    1
names_cache            0      2   4096    0    2    1
buffer_head         5941   5960     96  149  149    1
mm_struct              7     24    160    1    1    1
vm_area_struct        69    120     96    2    3    1
fs_cache               6    113     32    1    1    1
files_cache            7     18    416    1    2    1
signal_act             8     12   1312    3    4    1
size-131072(DMA)       0      0 131072    0    0   32
size-131072            0      0 131072    0    0   32
size-65536(DMA)        0      0  65536    0    0   16
size-65536             0      0  65536    0    0   16
size-32768(DMA)        0      0  32768    0    0    8
size-32768             0      1  32768    0    1    8
size-16384(DMA)        0      0  16384    0    0    4
size-16384             1      2  16384    1    2    4
size-8192(DMA)         0      0   8192    0    0    2
size-8192              4      5   8192    4    5    2
size-4096(DMA)         0      0   4096    0    0    1
size-4096              6      6   4096    6    6    1
size-2048(DMA)         0      0   2048    0    0    1
size-2048              5      6   2048    3    3    1
size-1024(DMA)         0      4   1024    0    1    1
size-1024             95     96   1024   24   24    1
size-512(DMA)          0      0    512    0    0    1
size-512              28     32    512    4    4    1
size-256(DMA)          0      0    256    0    0    1
size-256               6     15    256    1    1    1
size-128(DMA)          0      0    128    0    0    1
size-128             490    510    128   17   17    1
size-64(DMA)           0      0     64    0    0    1
size-64              108    118     64    2    2    1
size-32(DMA)           0      0     32    0    0    1
size-32              206    339     32    2    3    1

----------- run : find /mnt/ntfs -name \*

(/proc/meminfo after)

       total:    used:    free:  shared: buffers:  cached:
Mem:  252907520 249327616  3579904        0 39251968 37748736
Swap:        0        0        0
MemTotal:       246980 kB
MemFree:          3496 kB
MemShared:           0 kB
Buffers:         38332 kB
Cached:          36864 kB
SwapCached:          0 kB
Active:          67084 kB
Inactive:         8120 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       246980 kB
LowFree:          3496 kB
SwapTotal:           0 kB
SwapFree:            0 kB

(/proc/slabinfo after)

slabinfo - version: 1.1
kmem_cache            61     72    108    2    2    1
tcp_tw_bucket          0      0     96    0    0    1
tcp_bind_bucket        0      0     32    0    0    1
tcp_open_request       0      0     64    0    0    1
inet_peer_cache        0      0     64    0    0    1
ip_fib_hash            4    113     32    1    1    1
ip_dst_cache           0      0    160    0    0    1
arp_cache              0      0     96    0    0    1
blkdev_requests     3072   3600     96   77   90    1
nfs_write_data         0      0    352    0    0    1
nfs_read_data          0      0    352    0    0    1
nfs_page               0      0     96    0    0    1
journal_head           0      0     48    0    0    1
revoke_table           0      0     12    0    0    1
revoke_record          0      0     32    0    0    1
dnotify_cache          0      0     20    0    0    1
file_lock_cache        0      0     92    0    0    1
fasync_cache           0      0     16    0    0    1
uid_cache              0      0     32    0    0    1
skbuff_head_cache      1     24    160    1    1    1
sock                   5      9    864    1    1    2
sigqueue               0     29    132    0    1    1
kiobuf                 0      0     64    0    0    1
cdev_cache             5     59     64    1    1    1
bdev_cache             3     59     64    1    1    1
mnt_cache             12     59     64    1    1    1
inode_cache        26560  26560    480 3320 3320    1
dentry_cache       20721  21840    128  728  728    1
filp                  42     60    128    2    2    1
names_cache            0      1   4096    0    1    1
buffer_head        80852  80880     96 2022 2022    1
mm_struct              7     24    160    1    1    1
vm_area_struct        69    120     96    2    3    1
fs_cache               6    113     32    1    1    1
files_cache            7     18    416    1    2    1
signal_act             8     12   1312    3    4    1
size-131072(DMA)       0      0 131072    0    0   32
size-131072            0      0 131072    0    0   32
size-65536(DMA)        0      0  65536    0    0   16
size-65536             0      0  65536    0    0   16
size-32768(DMA)        0      0  32768    0    0    8
size-32768             0      1  32768    0    1    8
size-16384(DMA)        0      0  16384    0    0    4
size-16384             1      2  16384    1    2    4
size-8192(DMA)         0      0   8192    0    0    2
size-8192              4      5   8192    4    5    2
size-4096(DMA)         0      0   4096    0    0    1
size-4096          22252  22288   4096 22252 22288    1
size-2048(DMA)         0      0   2048    0    0    1
size-2048              5      6   2048    3    3    1
size-1024(DMA)         0      4   1024    0    1    1
size-1024          26781  26992   1024 6696 6748    1
size-512(DMA)          0      0    512    0    0    1
size-512           27801  27960    512 3476 3495    1
size-256(DMA)          0      0    256    0    0    1
size-256            1718   1725    256  115  115    1
size-128(DMA)          0      0    128    0    0    1
size-128           57680  58050    128 1923 1935    1
size-64(DMA)           0      0     64    0    0    1
size-64            12190  12213     64  207  207    1
size-32(DMA)           0      0     32    0    0    1
size-32            55206  55483     32  491  491    1
