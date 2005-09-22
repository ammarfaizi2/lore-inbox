Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750847AbVIVDym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbVIVDym (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 23:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbVIVDym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 23:54:42 -0400
Received: from zctfs063.nortelnetworks.com ([47.164.128.120]:6321 "EHLO
	zctfs063.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S1750838AbVIVDyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 23:54:41 -0400
Message-ID: <43322AE6.1080408@nortel.com>
Date: Wed, 21 Sep 2005 21:54:14 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
CC: Roland Dreier <rolandd@cisco.com>, dipankar@in.ibm.com,
       Sonny Rao <sonny@burdell.org>, linux-kernel@vger.kernel.org,
       "Theodore Ts'o" <tytso@mit.edu>, bharata@in.ibm.com,
       trond.myklebust@fys.uio.no
Subject: Re: dentry_cache using up all my zone normal memory -- also seen
 on 2.6.14-rc2
References: <433189B5.3030308@nortel.com> <43318FFA.4010706@nortel.com> <4331B89B.3080107@nortel.com> <20050921200758.GA25362@kevlar.burdell.org> <4331C9B2.5070801@nortel.com> <20050921210019.GF4569@in.ibm.com> <4331CFAD.6020805@nortel.com> <52ll1qkrii.fsf@cisco.com> <20050922031136.GE7992@ftp.linux.org.uk>
In-Reply-To: <20050922031136.GE7992@ftp.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Sep 2005 03:54:33.0544 (UTC) FILETIME=[57ACE480:01C5BF29]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:

>>Hmm... could there be a race in shmem_rename()??

> Not likely - in that setup all calls of ->unlink() and ->rename()
> are completely serialized by ->i_sem on parent.  One question:
> is it dcache or icache that ends up leaking?

dcache.  Here's some information I sent to dipankar earlier, with his 
debug patch applied.  This is within half a second of the oom killer 
kicking in.

/proc/sys/fs/dentry-state:
1185    415     45      0       0       0

/proc/meminfo:
MemTotal:      3366368 kB
MemFree:       2522660 kB
Buffers:             0 kB
Cached:           8040 kB
SwapCached:          0 kB
Active:           9372 kB
Inactive:         2544 kB
HighTotal:     2489836 kB
HighFree:      2477520 kB
LowTotal:       876532 kB
LowFree:         45140 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               4 kB
Writeback:           0 kB
Mapped:           6476 kB
Slab:           824648 kB
CommitLimit:   1683184 kB
Committed_AS:    18624 kB
PageTables:        336 kB
VmallocTotal:   114680 kB
VmallocUsed:       444 kB
VmallocChunk:   114036 kB
pages_with_[ 0]_dentries: 0
pages_with_[ 1]_dentries: 3
pages_with_[ 2]_dentries: 2
pages_with_[ 3]_dentries: 2
pages_with_[ 4]_dentries: 1
pages_with_[ 5]_dentries: 4
pages_with_[ 6]_dentries: 3
pages_with_[ 7]_dentries: 3
pages_with_[ 8]_dentries: 2
pages_with_[ 9]_dentries: 2
pages_with_[10]_dentries: 1
pages_with_[11]_dentries: 0
pages_with_[12]_dentries: 2
pages_with_[13]_dentries: 1
pages_with_[14]_dentries: 0
pages_with_[15]_dentries: 1
pages_with_[16]_dentries: 0
pages_with_[17]_dentries: 0
pages_with_[18]_dentries: 3
pages_with_[19]_dentries: 1
pages_with_[20]_dentries: 2
pages_with_[21]_dentries: 1
pages_with_[22]_dentries: 2
pages_with_[23]_dentries: 1
pages_with_[24]_dentries: 0
pages_with_[25]_dentries: 0
pages_with_[26]_dentries: 0
pages_with_[27]_dentries: 0
pages_with_[28]_dentries: 0
pages_with_[29]_dentries: 139491
dcache_pages total: 139528
prune_dcache: requested  1 freed 1
dcache lru list data:
dentries total: 416
dentries in_use: 36
dentries free: 380
dentries referenced: 416
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     4096 kB

/proc/slabinfo:
slabinfo - version: 2.1
# name            <active_objs> <num_objs> <objsize> <objperslab> 
<pagesperslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata 
<active_slabs> <num_slabs> <sharedavail>
ip_fib_alias          11    113     32  113    1 : tunables  120   60  0 
: slabdata      1      1      0
ip_fib_hash           11    113     32  113    1 : tunables  120   60  0 
: slabdata      1      1      0
rpc_buffers            8      8   2048    2    1 : tunables   24   12  0 
: slabdata      4      4      0
rpc_tasks             20     20    192   20    1 : tunables  120   60  0 
: slabdata      1      1      0
rpc_inode_cache        8      9    448    9    1 : tunables   54   27  0 
: slabdata      1      1      0
xfrm6_tunnel_spi       0      0     64   59    1 : tunables  120   60  0 
: slabdata      0      0      0
fib6_nodes             5    113     32  113    1 : tunables  120   60  0 
: slabdata      1      1      0
ip6_dst_cache          4     15    256   15    1 : tunables  120   60  0 
: slabdata      1      1      0
ndisc_cache            1     20    192   20    1 : tunables  120   60  0 
: slabdata      1      1      0
RAWv6                  3      6    640    6    1 : tunables   54   27  0 
: slabdata      1      1      0
UDPv6                  0      0    576    7    1 : tunables   54   27  0 
: slabdata      0      0      0
tw_sock_TCPv6          0      0    128   30    1 : tunables  120   60  0 
: slabdata      0      0      0
request_sock_TCPv6      0      0    128   30    1 : tunables  120   60 
  0 : slabdata      0      0      0
TCPv6                  4      7   1088    7    2 : tunables   24   12  0 
: slabdata      1      1      0
UNIX                   5     20    384   10    1 : tunables   54   27  0 
: slabdata      2      2      0
ip_mrt_cache           0      0    128   30    1 : tunables  120   60  0 
: slabdata      0      0      0
tcp_bind_bucket        3    203     16  203    1 : tunables  120   60  0 
: slabdata      1      1      0
inet_peer_cache        2     59     64   59    1 : tunables  120   60  0 
: slabdata      1      1      0
secpath_cache          0      0    128   30    1 : tunables  120   60  0 
: slabdata      0      0      0
xfrm_dst_cache         0      0    320   12    1 : tunables   54   27  0 
: slabdata      0      0      0
ip_dst_cache           7     15    256   15    1 : tunables  120   60  0 
: slabdata      1      1      0
arp_cache              2     30    128   30    1 : tunables  120   60  0 
: slabdata      1      1      0
RAW                    2      9    448    9    1 : tunables   54   27  0 
: slabdata      1      1      0
UDP                    1      7    512    7    1 : tunables   54   27  0 
: slabdata      1      1      0
tw_sock_TCP            0      0    128   30    1 : tunables  120   60  0 
: slabdata      0      0      0
request_sock_TCP       0      0     64   59    1 : tunables  120   60  0 
: slabdata      0      0      0
TCP                    2      4    960    4    1 : tunables   54   27  0 
: slabdata      1      1      0
flow_cache             0      0    128   30    1 : tunables  120   60  0 
: slabdata      0      0      0
cfq_ioc_pool           0      0     48   78    1 : tunables  120   60  0 
: slabdata      0      0      0
cfq_pool               0      0     96   40    1 : tunables  120   60  0 
: slabdata      0      0      0
crq_pool               0      0     44   84    1 : tunables  120   60  0 
: slabdata      0      0      0
deadline_drq           0      0     48   78    1 : tunables  120   60  0 
: slabdata      0      0      0
as_arq                 0      0     60   63    1 : tunables  120   60  0 
: slabdata      0      0      0
relayfs_inode_cache      0      0    320   12    1 : tunables   54   27 
    0 : slabdata      0      0      0
nfs_direct_cache       0      0     40   92    1 : tunables  120   60  0 
: slabdata      0      0      0
nfs_write_data        45     45    448    9    1 : tunables   54   27  0 
: slabdata      5      5      0
nfs_read_data         33     45    448    9    1 : tunables   54   27  0 
: slabdata      5      5      0
nfs_inode_cache      204    228    592    6    1 : tunables   54   27  0 
: slabdata     38     38      0
nfs_page              59     59     64   59    1 : tunables  120   60  0 
: slabdata      1      1      0
hugetlbfs_inode_cache      1     12    316   12    1 : tunables   54 27 
    0 : slabdata      1      1      0
ext2_inode_cache       0      0    436    9    1 : tunables   54   27  0 
: slabdata      0      0      0
ext2_xattr             0      0     44   84    1 : tunables  120   60  0 
: slabdata      0      0      0
dnotify_cache          0      0     20  169    1 : tunables  120   60  0 
: slabdata      0      0      0
eventpoll_pwq          0      0     36  101    1 : tunables  120   60  0 
: slabdata      0      0      0
eventpoll_epi          0      0    128   30    1 : tunables  120   60  0 
: slabdata      0      0      0
inotify_event_cache      0      0     28  127    1 : tunables  120   60 
    0 : slabdata      0      0      0
inotify_watch_cache      0      0     36  101    1 : tunables  120   60 
    0 : slabdata      0      0      0
kioctx                 0      0    192   20    1 : tunables  120   60  0 
: slabdata      0      0      0
kiocb                  0      0    128   30    1 : tunables  120   60  0 
: slabdata      0      0      0
fasync_cache           0      0     16  203    1 : tunables  120   60  0 
: slabdata      0      0      0
shmem_inode_cache    405    405    408    9    1 : tunables   54   27  0 
: slabdata     45     45      0
posix_timers_cache      0      0     96   40    1 : tunables  120   60 
  0 : slabdata      0      0      0
uid_cache              0     59     64   59    1 : tunables  120   60  0 
: slabdata      0      1      0
blkdev_ioc             0      0     28  127    1 : tunables  120   60  0 
: slabdata      0      0      0
blkdev_queue          24     30    380   10    1 : tunables   54   27  0 
: slabdata      3      3      0
blkdev_requests        0      0    152   26    1 : tunables  120   60  0 
: slabdata      0      0      0
biovec-(256)         256    256   3072    2    2 : tunables   24   12  0 
: slabdata    128    128      0
biovec-128           256    260   1536    5    2 : tunables   24   12  0 
: slabdata     52     52      0
biovec-64            256    260    768    5    1 : tunables   54   27  0 
: slabdata     52     52      0
biovec-16            256    260    192   20    1 : tunables  120   60  0 
: slabdata     13     13      0
biovec-4             256    295     64   59    1 : tunables  120   60  0 
: slabdata      5      5      0
biovec-1             256    406     16  203    1 : tunables  120   60  0 
: slabdata      2      2      0
bio                  256    295     64   59    1 : tunables  120   60  0 
: slabdata      5      5      0
file_lock_cache        0     44     88   44    1 : tunables  120   60  0 
: slabdata      0      1      0
sock_inode_cache      22     40    384   10    1 : tunables   54   27  0 
: slabdata      4      4      0
skbuff_fclone_cache     12     12    320   12    1 : tunables   54   27 
    0 : slabdata      1      1      0
skbuff_head_cache    266    300    192   20    1 : tunables  120   60  0 
: slabdata     15     15      0
proc_inode_cache     140    144    332   12    1 : tunables   54   27  0 
: slabdata     12     12      0
sigqueue               1     26    148   26    1 : tunables  120   60  0 
: slabdata      1      1      0
radix_tree_node      330    476    276   14    1 : tunables   54   27  0 
: slabdata     34     34      0
bdev_cache             2      9    448    9    1 : tunables   54   27  0 
: slabdata      1      1      0
sysfs_dir_cache     1356   1380     40   92    1 : tunables  120   60  0 
: slabdata     15     15      0
mnt_cache             20     30    128   30    1 : tunables  120   60  0 
: slabdata      1      1      0
inode_cache          258    288    316   12    1 : tunables   54   27  0 
: slabdata     24     24      0
dentry_cache      4071717 4072354    136   29    1 : tunables  120   60 
    0 : slabdata 140424 140426      0
filp              1300260 1300500    192   20    1 : tunables  120   60 
    0 : slabdata  65020  65025      0
names_cache            4      4   4096    1    1 : tunables   24   12  0 
: slabdata      4      4      0
idr_layer_cache       69     87    136   29    1 : tunables  120   60  0 
: slabdata      3      3      0
buffer_head            0      0     48   78    1 : tunables  120   60  0 
: slabdata      0      0      0
mm_struct             35     35    576    7    1 : tunables   54   27  0 
: slabdata      5      5      0
vm_area_struct       536    880     88   44    1 : tunables  120   60  0 
: slabdata     20     20      0
fs_cache              40    113     32  113    1 : tunables  120   60  0 
: slabdata      1      1      0
files_cache           41     54    448    9    1 : tunables   54   27  0 
: slabdata      6      6      0
signal_cache          50     50    384   10    1 : tunables   54   27  0 
: slabdata      5      5      0
sighand_cache         42     42   1344    3    1 : tunables   24   12  0 
: slabdata     14     14      0
task_struct           42     42   1264    3    1 : tunables   24   12  0 
: slabdata     14     14      0
anon_vma             278    678      8  339    1 : tunables  120   60  0 
: slabdata      2      2      0
pgd                   28     28   4096    1    1 : tunables   24   12  0 
: slabdata     28     28      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4  0 
: slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4  0 
: slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4  0 
: slabdata      0      0      0
size-65536             0      0  65536    1   16 : tunables    8    4  0 
: slabdata      0      0      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4  0 
: slabdata      0      0      0
size-32768             0      0  32768    1    8 : tunables    8    4  0 
: slabdata      0      0      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4  0 
: slabdata      0      0      0
size-16384             0      0  16384    1    4 : tunables    8    4  0 
: slabdata      0      0      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4  0 
: slabdata      0      0      0
size-8192             38     38   8192    1    2 : tunables    8    4  0 
: slabdata     38     38      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12  0 
: slabdata      0      0      0
size-4096            314    314   4096    1    1 : tunables   24   12  0 
: slabdata    314    314      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12  0 
: slabdata      0      0      0
size-2048             24     24   2048    2    1 : tunables   24   12  0 
: slabdata     12     12      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27  0 
: slabdata      0      0      0
size-1024             84     84   1024    4    1 : tunables   54   27  0 
: slabdata     21     21      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27  0 
: slabdata      0      0      0
size-512             130    152    512    8    1 : tunables   54   27  0 
: slabdata     19     19      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60  0 
: slabdata      0      0      0
size-256              75     75    256   15    1 : tunables  120   60  0 
: slabdata      5      5      0
size-192(DMA)          0      0    192   20    1 : tunables  120   60  0 
: slabdata      0      0      0
size-192              40     40    192   20    1 : tunables  120   60  0 
: slabdata      2      2      0
size-128(DMA)          0      0    128   30    1 : tunables  120   60  0 
: slabdata      0      0      0
size-128             964    990    128   30    1 : tunables  120   60  0 
: slabdata     33     33      0
size-64(DMA)           0      0     64   59    1 : tunables  120   60  0 
: slabdata      0      0      0
size-32(DMA)           0      0     32  113    1 : tunables  120   60  0 
: slabdata      0      0      0
size-64              503    767     64   59    1 : tunables  120   60  0 
: slabdata     13     13      0
size-32             1161   1808     32  113    1 : tunables  120   60  0 
: slabdata     16     16      0
kmem_cache           120    120    128   30    1 : tunables  120   60  0 
: slabdata      4      4      0
