Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964804AbVIKK5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbVIKK5R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 06:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbVIKK5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 06:57:17 -0400
Received: from THUNK.ORG ([69.25.196.29]:62918 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932467AbVIKK5Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 06:57:16 -0400
Date: Sun, 11 Sep 2005 06:57:09 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: VM balancing issues on 2.6.13: dentry cache not getting shrunk enough
Message-ID: <20050911105709.GA16369@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I've been noticing this for a while (probably since at least 2.6.11 or
so, but I haven't been keeping close attention), but I haven't had the
time to get some proof that this was the cause, and to write it up
until now.

I have a T40 laptop (Pentium M processor) with 2 gigs of memory, and
from time to time, after the system has been up for a while, the
dentry cache grows huge, as does the ext3_inode_cache:

slabinfo - version: 2.1
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
dentry_cache      434515 514112    136   29    1 : tunables  120   60    0 : slabdata  17728  17728      0
ext3_inode_cache  587635 589992    464    8    1 : tunables   54   27    0 : slabdata  73748  73749      0

Leading to an impending shortage in low memory:

LowFree:          9268 kB

... and if I don't take corrective measures, very shortly thereafter
the system will become unresponsive and will end up thrashing itself
to death, with symptoms that are identical to a case of 2.4 lowmem
exhaustion --- except this is on a 2.6.13 kernel, where all of these
problems were supposed to be solved.

It turns out I can head off the system lockup by requesting the
formation of hugepages, which will immediately cause a dramatic
reduction of memory usage in both high- and low- memory as various
caches and flushed:

	echo 100 > /proc/sys/vm/nr_hugepages
	echo 0 > /proc/sys/vm/nr_hugepages

The question is why isn't the kernel able to figure out how to do
release dentry cache entries automatically when it starts thrashing due
to a lack of low memory?   Clearly it can, since requesting hugepages
does shrink the dentry cache:

dentry_cache       20097  20097    136   29    1 : tunables  120   60    0 : slabdata    693    693      0
ext3_inode_cache   17782  17784    464    8    1 : tunables   54   27    0 : slabdata   2223   2223      0

LowFree:        835916 kB

Has anyone else seen this, or have some ideas about how to fix it?

Thanks, regards,

						- Ted


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=slabinfo

slabinfo - version: 2.1
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
nfs_write_data        36     36    448    9    1 : tunables   54   27    0 : slabdata      4      4      0
nfs_read_data         32     36    448    9    1 : tunables   54   27    0 : slabdata      4      4      0
nfs_inode_cache       69     72    592    6    1 : tunables   54   27    0 : slabdata     12     12      0
nfs_page               0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
rpc_buffers            8      8   2048    2    1 : tunables   24   12    0 : slabdata      4      4      0
rpc_tasks              8     20    192   20    1 : tunables  120   60    0 : slabdata      1      1      0
rpc_inode_cache        8      9    448    9    1 : tunables   54   27    0 : slabdata      1      1      0
uhci_urb_priv          0      0     44   88    1 : tunables  120   60    0 : slabdata      0      0      0
fib6_nodes             7    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
ip6_dst_cache          7     15    256   15    1 : tunables  120   60    0 : slabdata      1      1      0
ndisc_cache            1     20    192   20    1 : tunables  120   60    0 : slabdata      1      1      0
RAWv6                  3      6    640    6    1 : tunables   54   27    0 : slabdata      1      1      0
UDPv6                  2      7    576    7    1 : tunables   54   27    0 : slabdata      1      1      0
request_sock_TCPv6      0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
TCPv6                 12     14   1088    7    2 : tunables   24   12    0 : slabdata      2      2      0
ip_fib_alias          11    226     16  226    1 : tunables  120   60    0 : slabdata      1      1      0
ip_fib_hash           11    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
UNIX                 343    350    384   10    1 : tunables   54   27    0 : slabdata     35     35      0
tcp_tw_bucket          0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
tcp_bind_bucket       29    226     16  226    1 : tunables  120   60    0 : slabdata      1      1      0
inet_peer_cache        0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
secpath_cache          0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
xfrm_dst_cache         0      0    320   12    1 : tunables   54   27    0 : slabdata      0      0      0
ip_dst_cache          29     45    256   15    1 : tunables  120   60    0 : slabdata      3      3      0
arp_cache              4     31    128   31    1 : tunables  120   60    0 : slabdata      1      1      0
RAW                    2      9    448    9    1 : tunables   54   27    0 : slabdata      1      1      0
UDP                   28     28    512    7    1 : tunables   54   27    0 : slabdata      4      4      0
request_sock_TCP       0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
TCP                  144    148    960    4    1 : tunables   54   27    0 : slabdata     37     37      0
flow_cache             0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
cfq_ioc_pool           0      0     48   81    1 : tunables  120   60    0 : slabdata      0      0      0
cfq_pool               0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
crq_pool               0      0     44   88    1 : tunables  120   60    0 : slabdata      0      0      0
deadline_drq           0      0     48   81    1 : tunables  120   60    0 : slabdata      0      0      0
as_arq                65    130     60   65    1 : tunables  120   60    0 : slabdata      2      2      0
mqueue_inode_cache      1      7    512    7    1 : tunables   54   27    0 : slabdata      1      1      0
hugetlbfs_inode_cache      1     12    316   12    1 : tunables   54   27    0 : slabdata      1      1      0
ext2_inode_cache       0      0    444    9    1 : tunables   54   27    0 : slabdata      0      0      0
ext2_xattr             0      0     44   88    1 : tunables  120   60    0 : slabdata      0      0      0
journal_handle         8    185     20  185    1 : tunables  120   60    0 : slabdata      1      1      0
journal_head        2985   3000     52   75    1 : tunables  120   60    0 : slabdata     40     40      0
revoke_table           6    290     12  290    1 : tunables  120   60    0 : slabdata      1      1      0
revoke_record          0      0     16  226    1 : tunables  120   60    0 : slabdata      0      0      0
ext3_inode_cache  587635 589992    464    8    1 : tunables   54   27    0 : slabdata  73748  73749      0
ext3_xattr             0      0     44   88    1 : tunables  120   60    0 : slabdata      0      0      0
dnotify_cache          5    185     20  185    1 : tunables  120   60    0 : slabdata      1      1      0
eventpoll_pwq          0      0     36  107    1 : tunables  120   60    0 : slabdata      0      0      0
eventpoll_epi          0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
inotify_event_cache      0      0     28  135    1 : tunables  120   60    0 : slabdata      0      0      0
inotify_watch_cache      0      0     36  107    1 : tunables  120   60    0 : slabdata      0      0      0
kioctx                 0      0    192   20    1 : tunables  120   60    0 : slabdata      0      0      0
kiocb                  0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
fasync_cache           3    226     16  226    1 : tunables  120   60    0 : slabdata      1      1      0
shmem_inode_cache    963    963    408    9    1 : tunables   54   27    0 : slabdata    107    107      0
posix_timers_cache      0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
uid_cache             10     61     64   61    1 : tunables  120   60    0 : slabdata      1      1      0
blkdev_ioc            95    135     28  135    1 : tunables  120   60    0 : slabdata      1      1      0
blkdev_queue          25     30    380   10    1 : tunables   54   27    0 : slabdata      3      3      0
blkdev_requests       78     78    152   26    1 : tunables  120   60    0 : slabdata      3      3      0
biovec-(256)         256    256   3072    2    2 : tunables   24   12    0 : slabdata    128    128      0
biovec-128           256    260   1536    5    2 : tunables   24   12    0 : slabdata     52     52      0
biovec-64            256    260    768    5    1 : tunables   54   27    0 : slabdata     52     52      0
biovec-16            256    260    192   20    1 : tunables  120   60    0 : slabdata     13     13      0
biovec-4             258    305     64   61    1 : tunables  120   60    0 : slabdata      5      5      0
biovec-1             340    904     16  226    1 : tunables  120   60    0 : slabdata      4      4      0
bio                  374    465    128   31    1 : tunables  120   60    0 : slabdata     14     15      0
file_lock_cache       45     45     88   45    1 : tunables  120   60    0 : slabdata      1      1      0
sock_inode_cache     570    570    384   10    1 : tunables   54   27    0 : slabdata     57     57      0
skbuff_head_cache    880   1160    192   20    1 : tunables  120   60    0 : slabdata     58     58      0
proc_inode_cache     672    672    332   12    1 : tunables   54   27    0 : slabdata     56     56      0
sigqueue              75    108    148   27    1 : tunables  120   60    0 : slabdata      4      4      0
radix_tree_node    27827  29162    276   14    1 : tunables   54   27    0 : slabdata   2083   2083      0
bdev_cache             7      9    448    9    1 : tunables   54   27    0 : slabdata      1      1      0
sysfs_dir_cache     3540   3552     40   96    1 : tunables  120   60    0 : slabdata     37     37      0
mnt_cache             28     31    128   31    1 : tunables  120   60    0 : slabdata      1      1      0
inode_cache         1251   1404    316   12    1 : tunables   54   27    0 : slabdata    117    117      0
dentry_cache      434515 514112    136   29    1 : tunables  120   60    0 : slabdata  17728  17728      0
filp                4500   4660    192   20    1 : tunables  120   60    0 : slabdata    233    233      0
names_cache            7      7   4096    1    1 : tunables   24   12    0 : slabdata      7      7      0
key_jar               20     31    128   31    1 : tunables  120   60    0 : slabdata      1      1      0
idr_layer_cache       91    116    136   29    1 : tunables  120   60    0 : slabdata      4      4      0
buffer_head       153510 162891     48   81    1 : tunables  120   60    0 : slabdata   2011   2011      0
mm_struct            119    119    576    7    1 : tunables   54   27    0 : slabdata     17     17      0
vm_area_struct      8115   8640     88   45    1 : tunables  120   60    0 : slabdata    192    192      0
fs_cache             113    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
files_cache          114    117    448    9    1 : tunables   54   27    0 : slabdata     13     13      0
signal_cache         135    140    384   10    1 : tunables   54   27    0 : slabdata     14     14      0
sighand_cache        132    135   1344    3    1 : tunables   24   12    0 : slabdata     45     45      0
task_struct          150    153   1328    3    1 : tunables   24   12    0 : slabdata     51     51      0
anon_vma            3535   3663      8  407    1 : tunables  120   60    0 : slabdata      9      9      0
pgd                  115    115   4096    1    1 : tunables   24   12    0 : slabdata    115    115      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-65536             0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-32768            18     18  32768    1    8 : tunables    8    4    0 : slabdata     18     18      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0
size-16384             1      1  16384    1    4 : tunables    8    4    0 : slabdata      1      1      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : slabdata      0      0      0
size-8192            158    158   8192    1    2 : tunables    8    4    0 : slabdata    158    158      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    0 : slabdata      0      0      0
size-4096            385    387   4096    1    1 : tunables   24   12    0 : slabdata    385    387      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    0 : slabdata      0      0      0
size-2048             75     76   2048    2    1 : tunables   24   12    0 : slabdata     38     38      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    0 : slabdata      0      0      0
size-1024            212    212   1024    4    1 : tunables   54   27    0 : slabdata     53     53      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27    0 : slabdata      0      0      0
size-512             375    456    512    8    1 : tunables   54   27    0 : slabdata     57     57      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
size-256             645    750    256   15    1 : tunables  120   60    0 : slabdata     50     50      0
size-192(DMA)          0      0    192   20    1 : tunables  120   60    0 : slabdata      0      0      0
size-192             100    100    192   20    1 : tunables  120   60    0 : slabdata      5      5      0
size-128(DMA)          0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
size-128            4259   4557    128   31    1 : tunables  120   60    0 : slabdata    147    147      0
size-64(DMA)           0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
size-64           150913 150914     64   61    1 : tunables  120   60    0 : slabdata   2474   2474      0
size-32(DMA)           0      0     32  119    1 : tunables  120   60    0 : slabdata      0      0      0
size-32             3273   3332     32  119    1 : tunables  120   60    0 : slabdata     28     28      0
kmem_cache           124    124    128   31    1 : tunables  120   60    0 : slabdata      4      4      0

--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=meminfo

MemTotal:      2074880 kB
MemFree:         15220 kB
Buffers:        339900 kB
Cached:         798368 kB
SwapCached:      18252 kB
Active:        1025436 kB
Inactive:       603900 kB
HighTotal:     1178944 kB
HighFree:         5952 kB
LowTotal:       895936 kB
LowFree:          9268 kB
SwapTotal:     2124352 kB
SwapFree:      2060040 kB
Dirty:            9356 kB
Writeback:           0 kB
Mapped:         691788 kB
Slab:           405400 kB
CommitLimit:   3161792 kB
Committed_AS:  1206060 kB
PageTables:       5276 kB
VmallocTotal:   114680 kB
VmallocUsed:     24256 kB
VmallocChunk:    89588 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     4096 kB

--82I3+IH0IqGh5yIs
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="config.gz"
Content-Transfer-Encoding: base64

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

--82I3+IH0IqGh5yIs--
