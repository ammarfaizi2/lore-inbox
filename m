Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030398AbVIVPRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030398AbVIVPRM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 11:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030399AbVIVPRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 11:17:12 -0400
Received: from zctfs063.nortelnetworks.com ([47.164.128.120]:1963 "EHLO
	zctfs063.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S1030398AbVIVPRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 11:17:10 -0400
Message-ID: <4332CAEA.1010509@nortel.com>
Date: Thu, 22 Sep 2005 09:16:58 -0600
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
References: <433189B5.3030308@nortel.com> <43318FFA.4010706@nortel.com> <4331B89B.3080107@nortel.com> <20050921200758.GA25362@kevlar.burdell.org> <4331C9B2.5070801@nortel.com> <20050921210019.GF4569@in.ibm.com> <4331CFAD.6020805@nortel.com> <52ll1qkrii.fsf@cisco.com> <20050922031136.GE7992@ftp.linux.org.uk> <43322AE6.1080408@nortel.com> <20050922041733.GF7992@ftp.linux.org.uk>
In-Reply-To: <20050922041733.GF7992@ftp.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Sep 2005 15:17:01.0865 (UTC) FILETIME=[AEC6D190:01C5BF88]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:

> Umm...   How many RCU callbacks are pending?

I added an atomic counter that is incremented just before call_rcu() in 
d_free(), and decremented just after kmem_cache_free() in d_callback().

According to this we had 4127306 pending rcu callbacks.  A few seconds 
later it was down to 0.

Full output is below.

Chris




/proc/sys/fs/dentry-state:
1611    838     45      0       0       0

/proc/meminfo:
MemTotal:      3366368 kB
MemFree:       2507296 kB
Buffers:             0 kB
Cached:           7932 kB
SwapCached:          0 kB
Active:           8832 kB
Inactive:         2636 kB
HighTotal:     2489836 kB
HighFree:      2478016 kB
LowTotal:       876532 kB
LowFree:         29280 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:           6116 kB
Slab:           840468 kB
CommitLimit:   1683184 kB
Committed_AS:    18096 kB
PageTables:        324 kB
VmallocTotal:   114680 kB
VmallocUsed:       420 kB
VmallocChunk:   114036 kB
pending dentry rcu callbacks: 4127306
pages_with_[ 0]_dentries: 0
pages_with_[ 1]_dentries: 6
pages_with_[ 2]_dentries: 2
pages_with_[ 3]_dentries: 2
pages_with_[ 4]_dentries: 0
pages_with_[ 5]_dentries: 2
pages_with_[ 6]_dentries: 3
pages_with_[ 7]_dentries: 3
pages_with_[ 8]_dentries: 4
pages_with_[ 9]_dentries: 1
pages_with_[10]_dentries: 3
pages_with_[11]_dentries: 3
pages_with_[12]_dentries: 2
pages_with_[13]_dentries: 2
pages_with_[14]_dentries: 1
pages_with_[15]_dentries: 0
pages_with_[16]_dentries: 1
pages_with_[17]_dentries: 1
pages_with_[18]_dentries: 0
pages_with_[19]_dentries: 1
pages_with_[20]_dentries: 2
pages_with_[21]_dentries: 5
pages_with_[22]_dentries: 3
pages_with_[23]_dentries: 1
pages_with_[24]_dentries: 1
pages_with_[25]_dentries: 1
pages_with_[26]_dentries: 2
pages_with_[27]_dentries: 0
pages_with_[28]_dentries: 0
pages_with_[29]_dentries: 142355
dcache_pages total: 142407
prune_dcache: requested  1 freed 1
dcache lru list data:
dentries total: 839
dentries in_use: 43
dentries free: 796
dentries referenced: 839
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     4096 kB

slabinfo - version: 2.1
# name            <active_objs> <num_objs> <objsize> <objperslab> 
<pagesperslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata <a
ctive_slabs> <num_slabs> <sharedavail>
ip_fib_alias          11    113     32  113    1 : tunables  120   60 
  0 : slabdata      1      1      0
ip_fib_hash           11    113     32  113    1 : tunables  120   60 
  0 : slabdata      1      1      0
rpc_buffers            8      8   2048    2    1 : tunables   24   12 
  0 : slabdata      4      4      0
rpc_tasks             20     20    192   20    1 : tunables  120   60 
  0 : slabdata      1      1      0
rpc_inode_cache        8      9    448    9    1 : tunables   54   27 
  0 : slabdata      1      1      0
xfrm6_tunnel_spi       0      0     64   59    1 : tunables  120   60 
  0 : slabdata      0      0      0
fib6_nodes             5    113     32  113    1 : tunables  120   60 
  0 : slabdata      1      1      0
ip6_dst_cache          4     15    256   15    1 : tunables  120   60 
  0 : slabdata      1      1      0
ndisc_cache            1     20    192   20    1 : tunables  120   60 
  0 : slabdata      1      1      0
RAWv6                  3      6    640    6    1 : tunables   54   27 
  0 : slabdata      1      1      0
UDPv6                  0      0    576    7    1 : tunables   54   27 
  0 : slabdata      0      0      0
tw_sock_TCPv6          0      0    128   30    1 : tunables  120   60 
  0 : slabdata      0      0      0
request_sock_TCPv6      0      0    128   30    1 : tunables  120   60 
   0 : slabdata      0      0      0
TCPv6                  4      7   1088    7    2 : tunables   24   12 
  0 : slabdata      1      1      0
UNIX                   4     10    384   10    1 : tunables   54   27 
  0 : slabdata      1      1      0
ip_mrt_cache           0      0    128   30    1 : tunables  120   60 
  0 : slabdata      0      0      0
tcp_bind_bucket        4    203     16  203    1 : tunables  120   60 
  0 : slabdata      1      1      0
inet_peer_cache        2     59     64   59    1 : tunables  120   60 
  0 : slabdata      1      1      0
secpath_cache          0      0    128   30    1 : tunables  120   60 
  0 : slabdata      0      0      0
xfrm_dst_cache         0      0    320   12    1 : tunables   54   27 
  0 : slabdata      0      0      0
ip_dst_cache           7     15    256   15    1 : tunables  120   60 
  0 : slabdata      1      1      0
arp_cache              2     30    128   30    1 : tunables  120   60 
  0 : slabdata      1      1      0
RAW                    2      9    448    9    1 : tunables   54   27 
  0 : slabdata      1      1      0
UDP                    2      7    512    7    1 : tunables   54   27 
  0 : slabdata      1      1      0
tw_sock_TCP            0      0    128   30    1 : tunables  120   60 
  0 : slabdata      0      0      0
request_sock_TCP       0      0     64   59    1 : tunables  120   60 
  0 : slabdata      0      0      0
TCP                    3      4    960    4    1 : tunables   54   27 
  0 : slabdata      1      1      0
flow_cache             0      0    128   30    1 : tunables  120   60 
  0 : slabdata      0      0      0
cfq_ioc_pool           0      0     48   78    1 : tunables  120   60 
  0 : slabdata      0      0      0
cfq_pool               0      0     96   40    1 : tunables  120   60 
  0 : slabdata      0      0      0
crq_pool               0      0     44   84    1 : tunables  120   60 
  0 : slabdata      0      0      0
deadline_drq           0      0     48   78    1 : tunables  120   60 
  0 : slabdata      0      0      0
as_arq                 0      0     60   63    1 : tunables  120   60 
  0 : slabdata      0      0      0
relayfs_inode_cache      0      0    320   12    1 : tunables   54   27 
    0 : slabdata      0      0      0
nfs_direct_cache       0      0     40   92    1 : tunables  120   60 
  0 : slabdata      0      0      0
nfs_write_data        45     45    448    9    1 : tunables   54   27 
  0 : slabdata      5      5      0
nfs_read_data         32     36    448    9    1 : tunables   54   27 
  0 : slabdata      4      4      0
nfs_inode_cache      384    384    592    6    1 : tunables   54   27 
  0 : slabdata     64     64      0
nfs_page              59     59     64   59    1 : tunables  120   60 
  0 : slabdata      1      1      0
hugetlbfs_inode_cache      1     12    316   12    1 : tunables   54 
27    0 : slabdata      1      1      0
ext2_inode_cache       0      0    436    9    1 : tunables   54   27 
  0 : slabdata      0      0      0
ext2_xattr             0      0     44   84    1 : tunables  120   60 
  0 : slabdata      0      0      0
dnotify_cache          0      0     20  169    1 : tunables  120   60 
  0 : slabdata      0      0      0
eventpoll_pwq          0      0     36  101    1 : tunables  120   60 
  0 : slabdata      0      0      0
eventpoll_epi          0      0    128   30    1 : tunables  120   60 
  0 : slabdata      0      0      0
inotify_event_cache      0      0     28  127    1 : tunables  120   60 
    0 : slabdata      0      0      0
inotify_watch_cache      0      0     36  101    1 : tunables  120   60 
    0 : slabdata      0      0      0
kioctx                 0      0    192   20    1 : tunables  120   60 
  0 : slabdata      0      0      0
kiocb                  0      0    128   30    1 : tunables  120   60 
  0 : slabdata      0      0      0
fasync_cache           0      0     16  203    1 : tunables  120   60 
  0 : slabdata      0      0      0
shmem_inode_cache    396    396    408    9    1 : tunables   54   27 
  0 : slabdata     44     44      0
posix_timers_cache      0      0     96   40    1 : tunables  120   60 
   0 : slabdata      0      0      0
uid_cache              1     59     64   59    1 : tunables  120   60 
  0 : slabdata      1      1      0
blkdev_ioc             0      0     28  127    1 : tunables  120   60 
  0 : slabdata      0      0      0
blkdev_queue          24     30    380   10    1 : tunables   54   27 
  0 : slabdata      3      3      0
blkdev_requests        0      0    152   26    1 : tunables  120   60 
  0 : slabdata      0      0      0
biovec-(256)         256    256   3072    2    2 : tunables   24   12 
  0 : slabdata    128    128      0
biovec-128           256    260   1536    5    2 : tunables   24   12 
  0 : slabdata     52     52      0
biovec-64            256    260    768    5    1 : tunables   54   27 
  0 : slabdata     52     52      0
biovec-16            256    260    192   20    1 : tunables  120   60 
  0 : slabdata     13     13      0
biovec-4             256    295     64   59    1 : tunables  120   60 
  0 : slabdata      5      5      0
biovec-1             256    406     16  203    1 : tunables  120   60 
  0 : slabdata      2      2      0
bio                  256    295     64   59    1 : tunables  120   60 
  0 : slabdata      5      5      0
file_lock_cache        0      0     88   44    1 : tunables  120   60 
  0 : slabdata      0      0      0
sock_inode_cache      24     40    384   10    1 : tunables   54   27 
  0 : slabdata      4      4      0
skbuff_fclone_cache     12     12    320   12    1 : tunables   54   27 
    0 : slabdata      1      1      0
skbuff_head_cache    288    320    192   20    1 : tunables  120   60 
  0 : slabdata     16     16      0
proc_inode_cache      68     72    332   12    1 : tunables   54   27 
  0 : slabdata      6      6      0
sigqueue              16     26    148   26    1 : tunables  120   60 
  0 : slabdata      1      1      0
radix_tree_node      420    420    276   14    1 : tunables   54   27 
  0 : slabdata     30     30      0
bdev_cache             2      9    448    9    1 : tunables   54   27 
  0 : slabdata      1      1      0
sysfs_dir_cache     1356   1380     40   92    1 : tunables  120   60 
  0 : slabdata     15     15      0
mnt_cache             20     30    128   30    1 : tunables  120   60 
  0 : slabdata      1      1      0
inode_cache          532    540    316   12    1 : tunables   54   27 
  0 : slabdata     45     45      0
dentry_cache      4118471 4119305    136   29    1 : tunables  120   60 
    0 : slabdata 142042 142045      0
filp              1311720 1312200    192   20    1 : tunables  120   60 
    0 : slabdata  65605  65610      0
names_cache            3      3   4096    1    1 : tunables   24   12 
  0 : slabdata      3      3      0
idr_layer_cache       69     87    136   29    1 : tunables  120   60 
  0 : slabdata      3      3      0
buffer_head            0      0     48   78    1 : tunables  120   60 
  0 : slabdata      0      0      0
mm_struct             35     35    576    7    1 : tunables   54   27 
  0 : slabdata      5      5      0
vm_area_struct       528    528     88   44    1 : tunables  120   60 
  0 : slabdata     12     12      0
fs_cache              39    113     32  113    1 : tunables  120   60 
  0 : slabdata      1      1      0
files_cache           40     45    448    9    1 : tunables   54   27 
  0 : slabdata      5      5      0
signal_cache          50     50    384   10    1 : tunables   54   27 
  0 : slabdata      5      5      0
sighand_cache         39     39   1344    3    1 : tunables   24   12 
  0 : slabdata     13     13      0
task_struct           36     36   1264    3    1 : tunables   24   12 
  0 : slabdata     12     12      0
anon_vma             252    678      8  339    1 : tunables  120   60 
  0 : slabdata      2      2      0
pgd                   27     27   4096    1    1 : tunables   24   12 
  0 : slabdata     27     27      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4 
  0 : slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4 
  0 : slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4 
  0 : slabdata      0      0      0
size-65536             0      0  65536    1   16 : tunables    8    4 
  0 : slabdata      0      0      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4 
  0 : slabdata      0      0      0
size-32768             0      0  32768    1    8 : tunables    8    4 
  0 : slabdata      0      0      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4 
  0 : slabdata      0      0      0
size-16384             0      0  16384    1    4 : tunables    8    4 
  0 : slabdata      0      0      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4 
  0 : slabdata      0      0      0
size-8192             37     37   8192    1    2 : tunables    8    4 
  0 : slabdata     37     37      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12 
  0 : slabdata      0      0      0
size-4096            369    369   4096    1    1 : tunables   24   12 
  0 : slabdata    369    369      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12 
  0 : slabdata      0      0      0
size-2048             24     24   2048    2    1 : tunables   24   12 
  0 : slabdata     12     12      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27 
  0 : slabdata      0      0      0
size-1024            108    108   1024    4    1 : tunables   54   27 
  0 : slabdata     27     27      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27 
  0 : slabdata      0      0      0
size-512             126    152    512    8    1 : tunables   54   27 
  0 : slabdata     19     19      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60 
  0 : slabdata      0      0      0
size-256              75     75    256   15    1 : tunables  120   60 
  0 : slabdata      5      5      0
size-192(DMA)          0      0    192   20    1 : tunables  120   60 
  0 : slabdata      0      0      0
size-192              40     40    192   20    1 : tunables  120   60 
  0 : slabdata      2      2      0
size-128(DMA)          0      0    128   30    1 : tunables  120   60 
  0 : slabdata      0      0      0
size-128             963    990    128   30    1 : tunables  120   60 
  0 : slabdata     33     33      0
size-64(DMA)           0      0     64   59    1 : tunables  120   60 
  0 : slabdata      0      0      0
size-32(DMA)           0      0     32  113    1 : tunables  120   60 
  0 : slabdata      0      0      0
size-64              487    944     64   59    1 : tunables  120   60 
  0 : slabdata     16     16      0
size-32             1169   1356     32  113    1 : tunables  120   60 
  0 : slabdata     12     12      0
kmem_cache           120    120    128   30    1 : tunables  120   60 
  0 : slabdata      4      4      0
