Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261849AbTDMVVa (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 17:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbTDMVV3 (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 17:21:29 -0400
Received: from itaipu.nitnet.com.br ([200.255.111.241]:12177 "EHLO
	itaipu.nitnet.com.br") by vger.kernel.org with ESMTP
	id S261849AbTDMVVX (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 17:21:23 -0400
Date: Sun, 13 Apr 2003 18:32:57 -0300
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-preempt memory leak?
Message-ID: <20030413213256.GA536@flower.cesarb>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
From: Cesar Eduardo Barros <cesarb@nitnet.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


After running "find / -type f -xdev -print0 | xargs -0 sha1sum" a couple
of times in a ext2 filesystem with 17 gigabytes of assorted stuff in it
(the kind of mess one would find in a typical /home) and in 90+ CDs, I
noticed the memory was running low (I have 128M of main memory and two
swapfiles of 128M each, both in the filesystem mentioned above). Both
swapfiles were full, and the cached+buffers+free was getting lower each
time.

I decided to reboot to clear whatever was happening. At the end of the
shutdown (when it does the swapoff -a), the system ran out of memory:

Out of Memory: Killed process 21619 (rc).
Out of Memory: Killed process 21854 (S40umountfs).
Out of Memory: Killed process 21858 (init).
Out of Memory: Killed process 21857 (swapoff).

This shouldn't have happened since everything was already killed by
killall5.

I got dropped to sulogin (instead of it rebooting) and copied some
information from /proc before doing a forced umount (and trying to do
another swapoff -a by hand, with the same results). e2fsck found no
errors after rebooting (I did a touch /forcefsck just in case).

The system is a Debian testing with a 2.4.20 kernel with the preempt
patches.

Here is the information I saved from before trying to shutdown and after
the failed swapoff (notice swapoff did manage to do its work in one of
the swapfiles):

/proc/meminfo before shutdown:
        total:    used:    free:  shared: buffers:  cached:
Mem:  130813952 126767104  4046848        0  1245184 34848768
Swap: 268419072 268419072        0
MemTotal:       127748 kB
MemFree:          3952 kB
MemShared:           0 kB
Buffers:          1216 kB
Cached:          34024 kB
SwapCached:          8 kB
Active:          24016 kB
Inactive:        75620 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       127748 kB
LowFree:          3952 kB
SwapTotal:      262128 kB
SwapFree:            0 kB

/proc/slabinfo before shutdown:
slabinfo - version: 1.1
kmem_cache            59     68    112    2    2    1
ip_conntrack          19     60    320    5    5    1
uhci_urb_priv          1     62     60    1    1    1
ip_mrt_cache           0      0    128    0    0    1
tcp_tw_bucket          2     30    128    1    1    1
tcp_bind_bucket       17    112     32    1    1    1
tcp_open_request       0      0     64    0    0    1
inet_peer_cache        3     59     64    1    1    1
ip_fib_hash           13    112     32    1    1    1
ip_dst_cache          43    120    192    6    6    1
arp_cache              3     30    128    1    1    1
blkdev_requests      384    390    128   13   13    1
dnotify_cache          0      0     20    0    0    1
file_lock_cache        9     40     96    1    1    1
fasync_cache           2    202     16    1    1    1
uid_cache              6    112     32    1    1    1
skbuff_head_cache    128    280    192   14   14    1
sock                  99    102   1216   34   34    1
sigqueue               0     29    132    0    1    1
kiobuf                 0      0     64    0    0    1
cdev_cache            28    118     64    2    2    1
bdev_cache             1     59     64    1    1    1
mnt_cache             12     59     64    1    1    1
inode_cache         1015   2590    512  370  370    1
dentry_cache         968   4620    128  154  154    1
dquot                  0      0    128    0    0    1
filp                1871   1890    128   63   63    1
names_cache            0      2   4096    0    2    1
buffer_head         7892   8160    128  272  272    1
mm_struct             82    100    192    5    5    1
vm_area_struct      2515   3030    128  101  101    1
fs_cache              81    118     64    2    2    1
files_cache           81     90    448   10   10    1
signal_act            85     93   1344   31   31    1
size-131072(DMA)       0      0 131072    0    0   32
size-131072            0      0 131072    0    0   32
size-65536(DMA)        0      0  65536    0    0   16
size-65536             0      0  65536    0    0   16
size-32768(DMA)        0      0  32768    0    0    8
size-32768             1      1  32768    1    1    8
size-16384(DMA)        0      0  16384    0    0    4
size-16384             1      1  16384    1    1    4
size-8192(DMA)         0      0   8192    0    0    2
size-8192             10     10   8192   10   10    2
size-4096(DMA)         0      0   4096    0    0    1
size-4096             47     47   4096   47   47    1
size-2048(DMA)         0      0   2048    0    0    1
size-2048              8     10   2048    5    5    1
size-1024(DMA)         0      0   1024    0    0    1
size-1024             70     72   1024   18   18    1
size-512(DMA)          0      0    512    0    0    1
size-512              42     48    512    6    6    1
size-256(DMA)          0      0    256    0    0    1
size-256              28     45    256    3    3    1
size-128(DMA)          2     30    128    1    1    1
size-128             544    570    128   19   19    1
size-64(DMA)           0      0     64    0    0    1
size-64              655   1121     64   19   19    1
size-32(DMA)           2     59     64    1    1    1
size-32              800   2006     64   34   34    1

/proc/meminfo after trying to shutdown:
        total:    used:    free:  shared: buffers:  cached:
Mem:  130813952 127279104  3534848        0  2551808 113352704
Swap: 134209536 134209536        0
MemTotal:       127748 kB
MemFree:          3452 kB
MemShared:           0 kB
Buffers:          2492 kB
Cached:          67284 kB
SwapCached:      43412 kB
Active:          59980 kB
Inactive:        53688 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       127748 kB
LowFree:          3452 kB
SwapTotal:      131064 kB
SwapFree:            0 kB

/proc/slabinfo after trying to shutdown:
slabinfo - version: 1.1
kmem_cache            58     68    112    2    2    1
ip_conntrack          13     60    320    5    5    1
ip_mrt_cache           0      0    128    0    0    1
tcp_tw_bucket          0      0    128    0    0    1
tcp_bind_bucket        0      0     32    0    0    1
tcp_open_request       0      0     64    0    0    1
inet_peer_cache        2     59     64    1    1    1
ip_fib_hash            4    112     32    1    1    1
ip_dst_cache           0      0    192    0    0    1
arp_cache              0      0    128    0    0    1
blkdev_requests      384    390    128   13   13    1
dnotify_cache          0      0     20    0    0    1
file_lock_cache        0      0     96    0    0    1
fasync_cache           0      0     16    0    0    1
uid_cache              0      0     32    0    0    1
skbuff_head_cache    128    280    192   14   14    1
sock                   4      6   1216    2    2    1
sigqueue              14     29    132    1    1    1
kiobuf                 0      0     64    0    0    1
cdev_cache           838    885     64   15   15    1
bdev_cache             1     59     64    1    1    1
mnt_cache             10     59     64    1    1    1
inode_cache         6980   6986    512  998  998    1
dentry_cache        7058   7080    128  236  236    1
dquot                  0      0    128    0    0    1
filp                1871   1890    128   63   63    1
names_cache            0      1   4096    0    1    1
buffer_head         7162   8730    128  291  291    1
mm_struct              3     20    192    1    1    1
vm_area_struct        37     60    128    2    2    1
fs_cache               2     59     64    1    1    1
files_cache            2      9    448    1    1    1
signal_act             4      6   1344    2    2    1
size-131072(DMA)       0      0 131072    0    0   32
size-131072            0      0 131072    0    0   32
size-65536(DMA)        0      0  65536    0    0   16
size-65536             0      0  65536    0    0   16
size-32768(DMA)        0      0  32768    0    0    8
size-32768             1      1  32768    1    1    8
size-16384(DMA)        0      0  16384    0    0    4
size-16384             0      0  16384    0    0    4
size-8192(DMA)         0      0   8192    0    0    2
size-8192              9      9   8192    9    9    2
size-4096(DMA)         0      0   4096    0    0    1
size-4096              4      4   4096    4    4    1
size-2048(DMA)         0      0   2048    0    0    1
size-2048              7      8   2048    4    4    1
size-1024(DMA)         0      0   1024    0    0    1
size-1024             24     36   1024    9    9    1
size-512(DMA)          0      0    512    0    0    1
size-512              37     48    512    6    6    1
size-256(DMA)          0      0    256    0    0    1
size-256              19     30    256    2    2    1
size-128(DMA)          0      0    128    0    0    1
size-128             530    570    128   19   19    1
size-64(DMA)           0      0     64    0    0    1
size-64              523   1062     64   18   18    1
size-32(DMA)           0      0     64    0    0    1
size-32             1323   2006     64   34   34    1

ps ax after trying to shutdown:
  PID TTY      STAT   TIME COMMAND
    1 ?        S      0:10 init [6] 
    2 ?        SW     0:06 [keventd]
    3 ?        SW     0:00 [kapmd]
    4 ?        SWN    0:00 [ksoftirqd_CPU0]
    5 ?        SW     5:12 [kswapd]
    6 ?        SW     0:01 [bdflush]
    7 ?        SW     0:05 [kupdated]
21859 ?        S      0:00 bash
21873 ?        R      0:00 ps axwww

memstat -w after trying to shutdown:
     36k: PID     1 (/sbin/init)
    264k: PID 21859 (/bin/bash)
     28k: PID 21869 (/usr/bin/memstat)
     72k: /lib/ld-2.3.1.so 1 21859 21869
   1076k: /lib/libc-2.3.1.so 1 21859 21869
      8k: /lib/libdl-2.3.1.so 21859
     68k: /lib/libnsl-2.3.1.so 21859
     40k: /lib/libnss_compat-2.3.1.so 21859
    248k: /lib/libncurses.so.5.3 21859
      8k: /usr/bin/memstat 21869
     28k: /sbin/init 1
    568k: /bin/bash 21859
--------
   2444k

/proc/cpuinfo:
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 2
model name	: AMD Athlon(tm) Processor
stepping	: 2
cpu MHz		: 748.578
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips	: 1494.22

/proc/meminfo some time after reboot (it's normally like this):
        total:    used:    free:  shared: buffers:  cached:
Mem:  130813952 125263872  5550080        0  4214784 71327744
Swap: 268419072 80072704 188346368
MemTotal:       127748 kB
MemFree:          5420 kB
MemShared:           0 kB
Buffers:          4116 kB
Cached:          48644 kB
SwapCached:      21012 kB
Active:          45116 kB
Inactive:        55212 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       127748 kB
LowFree:          5420 kB
SwapTotal:      262128 kB
SwapFree:       183932 kB

/proc/slabinfo some time after reboot:
slabinfo - version: 1.1
kmem_cache            59     68    112    2    2    1
ip_conntrack          14     60    320    5    5    1
uhci_urb_priv          1     62     60    1    1    1
ip_mrt_cache           0      0    128    0    0    1
tcp_tw_bucket          0     30    128    0    1    1
tcp_bind_bucket       18    112     32    1    1    1
tcp_open_request       0      0     64    0    0    1
inet_peer_cache        1     59     64    1    1    1
ip_fib_hash           13    112     32    1    1    1
ip_dst_cache          39    180    192    9    9    1
arp_cache              3     30    128    1    1    1
blkdev_requests      384    390    128   13   13    1
dnotify_cache          0      0     20    0    0    1
file_lock_cache        9     40     96    1    1    1
fasync_cache           2    202     16    1    1    1
uid_cache              7    112     32    1    1    1
skbuff_head_cache    128    240    192   12   12    1
sock                 110    114   1216   38   38    1
sigqueue               0     29    132    0    1    1
kiobuf                 0      0     64    0    0    1
cdev_cache            31    118     64    2    2    1
bdev_cache             1     59     64    1    1    1
mnt_cache             12     59     64    1    1    1
inode_cache         1221   1484    512  212  212    1
dentry_cache        1335   2190    128   73   73    1
dquot                  0      0    128    0    0    1
filp                1437   1440    128   48   48    1
names_cache            0      2   4096    0    2    1
buffer_head        10222  12300    128  410  410    1
mm_struct             80    100    192    4    5    1
vm_area_struct      3153   3270    128  108  109    1
fs_cache              79    118     64    2    2    1
files_cache           79     90    448    9   10    1
signal_act            83     90   1344   28   30    1
size-131072(DMA)       0      0 131072    0    0   32
size-131072            0      0 131072    0    0   32
size-65536(DMA)        0      0  65536    0    0   16
size-65536             0      0  65536    0    0   16
size-32768(DMA)        0      0  32768    0    0    8
size-32768             1      1  32768    1    1    8
size-16384(DMA)        0      0  16384    0    0    4
size-16384             1      1  16384    1    1    4
size-8192(DMA)         0      0   8192    0    0    2
size-8192             10     10   8192   10   10    2
size-4096(DMA)         0      0   4096    0    0    1
size-4096             51     63   4096   51   63    1
size-2048(DMA)         0      0   2048    0    0    1
size-2048             10     18   2048    5    9    1
size-1024(DMA)         0      0   1024    0    0    1
size-1024             59    132   1024   15   33    1
size-512(DMA)          0      0    512    0    0    1
size-512              36    104    512    5   13    1
size-256(DMA)          0      0    256    0    0    1
size-256              27     90    256    2    6    1
size-128(DMA)          2     30    128    1    1    1
size-128             512    570    128   19   19    1
size-64(DMA)           0      0     64    0    0    1
size-64              353    413     64    7    7    1
size-32(DMA)           2     59     64    1    1    1
size-32              778   1062     64   18   18    1

-- 
Cesar Eduardo Barros
cesarb@nitnet.com.br
cesarb@dcc.ufrj.br
