Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261785AbVAYDWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbVAYDWl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 22:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbVAYDWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 22:22:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:47582 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261781AbVAYDWT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 22:22:19 -0500
From: Andrew Tridgell <tridge@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16885.47804.68041.144011@samba.org>
Date: Tue, 25 Jan 2005 14:19:24 +1100
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Andreas Gruenbacher <agruen@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: memory leak in 2.6.11-rc2
In-Reply-To: <16884.56071.773949.280386@samba.org>
References: <20050120020124.110155000@suse.de>
	<16884.8352.76012.779869@samba.org>
	<200501232358.09926.agruen@suse.de>
	<200501240032.17236.agruen@suse.de>
	<16884.56071.773949.280386@samba.org>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: tridge@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've fixed up the problems I had with raid, and am now testing the
recent xattr changes with dbench and nbench.

The problem I've hit now is a severe memory leak. I have applied the
patch from Linus for the leak in free_pipe_info(), and still I'm
leaking memory at the rate of about 100Mbyte/minute.

I've tested with both 2.6.11-rc2 and with 2.6.11-rc1-mm2, both with
the pipe leak fix. The setup is:

 - 4 way PIII with 4G ram
 - qla2200 adapter with ibm fastt200 disk array 
 - running dbench -x and nbench on separate disks, in a loop

The oom killer kicks in after about 30 minutes. Naturally the oom
killer decided to kill my sshd, which was running vmstat :-) 

Killing the dbench and nbench processes does not recovery the memory.
Here is what it looks like after I kill all processes except a sshd
after about 15 minutes of running:

             total       used       free     shared    buffers     cached
Mem:       3734304    2471608    1262696          0      26820     921440
-/+ buffers/cache:    1523348    2210956
Swap:      4194272          0    4194272

so we've lost nearly 1.5G in that time.

here is /proc/meminfo:

dev4-003:~# cat /proc/meminfo 
MemTotal:      3734304 kB
MemFree:       1266944 kB
Buffers:         27000 kB
Cached:         921464 kB
SwapCached:          0 kB
Active:         292524 kB
Inactive:      2108928 kB
HighTotal:     2850752 kB
HighFree:       472768 kB
LowTotal:       883552 kB
LowFree:        794176 kB
SwapTotal:     4194272 kB
SwapFree:      4194272 kB
Dirty:               4 kB
Writeback:           0 kB
Mapped:           6872 kB
Slab:            54236 kB
CommitLimit:   6061424 kB
Committed_AS:    41660 kB
PageTables:        344 kB
VmallocTotal:   114680 kB
VmallocUsed:      2204 kB
VmallocChunk:   112472 kB

and here is /proc/slabinfo 

slabinfo - version: 2.1
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <batchcount> <limit> <sharedfactor> : slabdata
 <active_slabs> <num_slabs> <sharedavail>
ip_fib_alias           9    226     16  226    1 : tunables  120   60    8 : slabdata      1      1      0
ip_fib_hash            9    119     32  119    1 : tunables  120   60    8 : slabdata      1      1      0
fib6_nodes             7    119     32  119    1 : tunables  120   60    8 : slabdata      1      1      0
ip6_dst_cache          7     36    224   18    1 : tunables  120   60    8 : slabdata      2      2      0
ndisc_cache            1     25    160   25    1 : tunables  120   60    8 : slabdata      1      1      0
rawv6_sock             6      6    672    6    1 : tunables   54   27    8 : slabdata      1      1      0
udpv6_sock             0      0    640    6    1 : tunables   54   27    8 : slabdata      0      0      0
tcpv6_sock             4      6   1184    6    2 : tunables   24   12    8 : slabdata      1      1      0
unix_sock              2      9    416    9    1 : tunables   54   27    8 : slabdata      1      1      0
ip_mrt_cache           0      0     96   41    1 : tunables  120   60    8 : slabdata      0      0      0
tcp_tw_bucket          0      0    128   31    1 : tunables  120   60    8 : slabdata      0      0      0
tcp_bind_bucket        2    226     16  226    1 : tunables  120   60    8 : slabdata      1      1      0
tcp_open_request       0      0     96   41    1 : tunables  120   60    8 : slabdata      0      0      0
inet_peer_cache        1     61     64   61    1 : tunables  120   60    8 : slabdata      1      1      0
secpath_cache          0      0    128   31    1 : tunables  120   60    8 : slabdata      0      0      0
xfrm_dst_cache         0      0    256   15    1 : tunables  120   60    8 : slabdata      0      0      0
ip_dst_cache           6     15    256   15    1 : tunables  120   60    8 : slabdata      1      1      0
arp_cache              1     25    160   25    1 : tunables  120   60    8 : slabdata      1      1      0
raw_sock               5      7    512    7    1 : tunables   54   27    8 : slabdata      1      1      0
udp_sock               3      8    512    8    1 : tunables   54   27    8 : slabdata      1      1      0
tcp_sock               1      7   1056    7    2 : tunables   24   12    8 : slabdata      1      1      0
flow_cache             0      0     96   41    1 : tunables  120   60    8 : slabdata      0      0      0
qla2xxx_srbs         256    310    128   31    1 : tunables  120   60    8 : slabdata     10     10      0
scsi_cmd_cache        22     22    352   11    1 : tunables   54   27    8 : slabdata      2      2      0
cfq_ioc_pool           0      0     24  156    1 : tunables  120   60    8 : slabdata      0      0      0
cfq_pool               0      0    104   38    1 : tunables  120   60    8 : slabdata      0      0      0
crq_pool               0      0     56   70    1 : tunables  120   60    8 : slabdata      0      0      0
deadline_drq           0      0     52   75    1 : tunables  120   60    8 : slabdata      0      0      0
as_arq                61     61     64   61    1 : tunables  120   60    8 : slabdata      1      1      0
mqueue_inode_cache      1      7    512    7    1 : tunables   54   27    8 : slabdata      1      1      0
devfsd_event           0      0     20  185    1 : tunables  120   60    8 : slabdata      0      0      0
ext2_inode_cache       0      0    456    8    1 : tunables   54   27    8 : slabdata      0      0      0
ext2_xattr             0      0     48   81    1 : tunables  120   60    8 : slabdata      0      0      0
journal_handle         2    185     20  185    1 : tunables  120   60    8 : slabdata      1      1      0
journal_head        3316 155844     48   81    1 : tunables  120   60    8 : slabdata   1924   1924      0
revoke_table          14    290     12  290    1 : tunables  120   60    8 : slabdata      1      1      0
revoke_record          0      0     16  226    1 : tunables  120   60    8 : slabdata      0      0      0
ext3_inode_cache    3626   3745    520    7    1 : tunables   54   27    8 : slabdata    535    535      0
ext3_xattr             0      0     48   81    1 : tunables  120   60    8 : slabdata      0      0      0
dnotify_cache          0      0     20  185    1 : tunables  120   60    8 : slabdata      0      0      0
eventpoll_pwq          0      0     36  107    1 : tunables  120   60    8 : slabdata      0      0      0
eventpoll_epi          0      0     96   41    1 : tunables  120   60    8 : slabdata      0      0      0
kioctx                 0      0    192   20    1 : tunables  120   60    8 : slabdata      0      0      0
kiocb                  0      0    128   31    1 : tunables  120   60    8 : slabdata      0      0      0
fasync_cache           0      0     16  226    1 : tunables  120   60    8 : slabdata      0      0      0
shmem_inode_cache      8     18    416    9    1 : tunables   54   27    8 : slabdata      2      2      0
posix_timers_cache      0      0    104   38    1 : tunables  120   60    8 : slabdata      0      0      0
uid_cache              1     61     64   61    1 : tunables  120   60    8 : slabdata      1      1      0
sgpool-128            32     32   2048    2    1 : tunables   24   12    8 : slabdata     16     16      0
sgpool-64             32     32   1024    4    1 : tunables   54   27    8 : slabdata      8      8      0
sgpool-32             32     32    512    8    1 : tunables   54   27    8 : slabdata      4      4      0
sgpool-16             32     45    256   15    1 : tunables  120   60    8 : slabdata      3      3      0
sgpool-8              50     62    128   31    1 : tunables  120   60    8 : slabdata      2      2      0
blkdev_ioc            40    270     28  135    1 : tunables  120   60    8 : slabdata      2      2      0
blkdev_queue          37     50    380   10    1 : tunables   54   27    8 : slabdata      5      5      0
blkdev_requests       70     81    148   27    1 : tunables  120   60    8 : slabdata      3      3      0
biovec-(256)         256    256   3072    2    2 : tunables   24   12    8 : slabdata    128    128      0
biovec-128           256    260   1536    5    2 : tunables   24   12    8 : slabdata     52     52      0
biovec-64            256    260    768    5    1 : tunables   54   27    8 : slabdata     52     52      0
biovec-16            260    260    192   20    1 : tunables  120   60    8 : slabdata     13     13      0
biovec-4             256    305     64   61    1 : tunables  120   60    8 : slabdata      5      5      0
biovec-1             322    452     16  226    1 : tunables  120   60    8 : slabdata      2      2      0
bio                  303    328     96   41    1 : tunables  120   60    8 : slabdata      8      8      0
file_lock_cache        0      0     92   43    1 : tunables  120   60    8 : slabdata      0      0      0
sock_inode_cache      26     60    384   10    1 : tunables   54   27    8 : slabdata      6      6      0
skbuff_head_cache    137    475    160   25    1 : tunables  120   60    8 : slabdata     19     19      0
sock                   4     11    352   11    1 : tunables   54   27    8 : slabdata      1      1      0
key_jar               90    123     96   41    1 : tunables  120   60    8 : slabdata      3      3      0
proc_inode_cache     265    336    336   12    1 : tunables   54   27    8 : slabdata     28     28      0
sigqueue               1     27    148   27    1 : tunables  120   60    8 : slabdata      1      1      0
radix_tree_node     8235   8750    276   14    1 : tunables   54   27    8 : slabdata    625    625      0
bdev_cache            14     18    448    9    1 : tunables   54   27    8 : slabdata      2      2      0
sysfs_dir_cache     2837   2996     36  107    1 : tunables  120   60    8 : slabdata     28     28      0
mnt_cache             21     41     96   41    1 : tunables  120   60    8 : slabdata      1      1      0
inode_cache          946    948    320   12    1 : tunables   54   27    8 : slabdata     79     79      0
dentry_cache       10903  11032    140   28    1 : tunables  120   60    8 : slabdata    394    394      0
filp                 300    750    160   25    1 : tunables  120   60    8 : slabdata     30     30      0
names_cache            3      3   4096    1    1 : tunables   24   12    8 : slabdata      3      3      0
idr_layer_cache       80     87    136   29    1 : tunables  120   60    8 : slabdata      3      3      0
buffer_head       593099 649500     52   75    1 : tunables  120   60    8 : slabdata   8660   8660      0
mm_struct             54     54    608    6    1 : tunables   54   27    8 : slabdata      9      9      0
vm_area_struct       543   1260     88   45    1 : tunables  120   60    8 : slabdata     28     28      0
fs_cache              82    122     64   61    1 : tunables  120   60    8 : slabdata      2      2      0
files_cache           50     63    416    9    1 : tunables   54   27    8 : slabdata      7      7      0
signal_cache          68    150    256   15    1 : tunables  120   60    8 : slabdata     10     10      0
sighand_cache         76     78   1312    3    1 : tunables   24   12    8 : slabdata     26     26      0
task_struct           78     81   1312    3    1 : tunables   24   12    8 : slabdata     27     27      0
anon_vma             273    870     12  290    1 : tunables  120   60    8 : slabdata      3      3      0
pgd                   24     24   4096    1    1 : tunables   24   12    8 : slabdata     24     24      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-65536             0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-32768             0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0
size-16384             5      5  16384    1    4 : tunables    8    4    0 : slabdata      5      5      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : slabdata      0      0      0
size-8192             75     75   8192    1    2 : tunables    8    4    0 : slabdata     75     75      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    8 : slabdata      0      0      0
size-4096             29     29   4096    1    1 : tunables   24   12    8 : slabdata     29     29      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    8 : slabdata      0      0      0
size-2048            248    258   2048    2    1 : tunables   24   12    8 : slabdata    129    129      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    8 : slabdata      0      0      0
size-1024            132    132   1024    4    1 : tunables   54   27    8 : slabdata     33     33      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27    8 : slabdata      0      0      0
size-512             403    432    512    8    1 : tunables   54   27    8 : slabdata     54     54      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60    8 : slabdata      0      0      0
size-256             255    255    256   15    1 : tunables  120   60    8 : slabdata     17     17      0
size-128(DMA)          0      0    128   31    1 : tunables  120   60    8 : slabdata      0      0      0
size-128            2403   2542    128   31    1 : tunables  120   60    8 : slabdata     82     82      0
size-64(DMA)           0      0     64   61    1 : tunables  120   60    8 : slabdata      0      0      0
size-64              670    793     64   61    1 : tunables  120   60    8 : slabdata     13     13      0
size-32(DMA)           0      0     32  119    1 : tunables  120   60    8 : slabdata      0      0      0
size-32             1415   3213     32  119    1 : tunables  120   60    8 : slabdata     27     27      0
kmem_cache           175    175    160   25    1 : tunables  120   60    8 : slabdata      7      7      0
