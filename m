Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135176AbRDZHmm>; Thu, 26 Apr 2001 03:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135178AbRDZHmc>; Thu, 26 Apr 2001 03:42:32 -0400
Received: from tepid.osl.fast.no ([213.188.9.130]:29449 "EHLO
	tepid.osl.fast.no") by vger.kernel.org with ESMTP
	id <S135176AbRDZHmS>; Thu, 26 Apr 2001 03:42:18 -0400
From: "Troels Walsted Hansen" <troels@fast.no>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel 2.4 diskcache pushes applications into swap?
Date: Thu, 26 Apr 2001 09:42:11 +0200
Message-ID: <CKECLHEEHJOPHGPCOCKPKEEECCAA.troels@fast.no>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Not subscribed to list, please CC - thanks.]

Hi all,

The need for Large File Support drove us to upgrade a dual CPU server to
RedHat 7.1 (kernel 2.4.2-2smp) to get a distribution with kernel 2.4. While
working with 2-4GB files on the system, we found some odd behaviour. The
server is equipped with 512MB RAM and 1GB swap. When copying large files
around, all RAM is consumed by the diskcache which is fine and natural.
Unfortunately the kernel seems very reluctant to release this memory to
applications. After running large file copying operations for a minute or
two, interactive performance of the server is horrible, with a simple
console login taking several minutes.

I looked at top output, and couldn't help but notice that the kernel was
starting to eat into swap. I made a similar test on my laptop (256MB RAM,
128 MB swap) running Mandrake 8.0 (kernel 2.4.3-20mdk).

After boot the machine uses 42MB RAM, and 0B swap.

Running top in one console and "dd if=/dev/hda of=/dev/null" in another, I
observe RAM usage climbing rapidly. It peaks out at about 3MB free RAM, and
then it slowly starts eating into _swap_. After it's been running now for 10
minutes, it's using 5.8MB swap.

Interactive performance is not as bad as on the SMP server, so I'm not sure
I've identified the problem, but I would like to know if this is really the
intended behaviour?

I tried the same dd test on a completely different machine with 64MB RAM and
kernel 2.2.19. On this machine no swap was consumed by the test.

Here's some memory statistics from the laptop while running the dd test, let
me know if you need anything else.

/proc/meminfo:
        total:    used:    free:  shared: buffers:  cached:
Mem:  261873664 258998272  2875392        0 224747520  4030464
Swap: 139788288  4308992 135479296
MemTotal:       255736 kB
MemFree:          2808 kB
MemShared:           0 kB
Buffers:        219480 kB
Cached:           3936 kB
Active:         222184 kB
Inact_dirty:       260 kB
Inact_clean:       972 kB
Inact_target:       64 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       255736 kB
LowFree:          2808 kB
SwapTotal:      136512 kB
SwapFree:       132304 kB

/proc/slabinfo:
slabinfo - version: 1.1
kmem_cache            58     78    100    2    2    1
urb_priv               0      0     32    0    0    1
uhci_desc           1038   1062     64   18   18    1
clip_arp_cache         0      0    128    0    0    1
ip_mrt_cache           0      0     96    0    0    1
tcp_tw_bucket          0      0    128    0    0    1
tcp_bind_bucket        1    113     32    1    1    1
tcp_open_request       0      0     96    0    0    1
inet_peer_cache        0      0     64    0    0    1
ip_fib_hash           10    113     32    1    1    1
ip_dst_cache          18     24    160    1    1    1
arp_cache              3     30    128    1    1    1
blkdev_requests      512    520     96   13   13    1
dnotify cache          0      0     20    0    0    1
file lock cache        1     42     92    1    1    1
fasync cache           0      0     16    0    0    1
uid_cache              2    113     32    1    1    1
skbuff_head_cache    140    144    160    6    6    1
sock                  17     18   1280    6    6    1
inode_cache          219    536    480   67   67    1
bdev_cache             5     59     64    1    1    1
sigqueue               0      0    132    0    0    1
kiobuf                 0      0    128    0    0    1
dentry_cache         208    960    128   32   32    1
dquot                  0      0    128    0    0    1
filp                 350    360     96    9    9    1
names_cache            0      1   4096    0    1    1
buffer_head       219909 220720     96 5504 5518    1
mm_struct             24     24    160    1    1    1
vm_area_struct       642    708     64   11   12    1
fs_cache              23     59     64    1    1    1
files_cache           23     27    416    3    3    1
signal_act            28     30   1312   10   10    1
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
size-4096             32     33   4096   32   33    1
size-2048(DMA)         0      0   2048    0    0    1
size-2048             63     64   2048   32   32    1
size-1024(DMA)         0      0   1024    0    0    1
size-1024             30     32   1024    8    8    1
size-512(DMA)          0      0    512    0    0    1
size-512              43     48    512    6    6    1
size-256(DMA)          0      0    256    0    0    1
size-256              81     90    256    6    6    1
size-128(DMA)          0      0    128    0    0    1
size-128             473    480    128   16   16    1
size-64(DMA)           0      0     64    0    0    1
size-64              103    118     64    2    2    1
size-32(DMA)           0      0     32    0    0    1
size-32             1273   1808     32   16   16    1

--
Troels Walsted Hansen, M.Eng.      Mail:  troels@fast.no
System Architect                   Web:   http://www.fast.no
Fast Search & Transfer ASA         Phone: +47 21 60 11 84
P.O. Box 1126                      Fax:   +47 77 69 66 89
NO-9261 Tromsø, NORWAY             Mob:   +47 99 25 16 43

Try FAST Search: http://alltheweb.com

