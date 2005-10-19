Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751372AbVJSV72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbVJSV72 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 17:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbVJSV72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 17:59:28 -0400
Received: from mail02.birthdayalarm.com ([207.7.149.42]:5326 "EHLO
	mail02.birthdayalarm.com") by vger.kernel.org with ESMTP
	id S1751372AbVJSV71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 17:59:27 -0400
Message-ID: <4356C1B2.3070401@bebo.com>
Date: Wed, 19 Oct 2005 14:59:14 -0700
From: Dave Pifke <dave@bebo.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Question about buffer usage
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm doing some performance tweaking on a web server and am curious about 
a memory usage pattern I'm seeing.  After doing some Googling I'm still 
not sure whether what I'm seeing is normal or is indicative of 
suboptimal VM or VFS behavior.

The system has 2GB of RAM.  At the moment, ~117MB is free, ~1.5GB is 
being used for buffers(!), and ~180MB is cached.  I would expect cache 
to be much larger than buffers.

According to Documentation/filesystems/proc.txt:

      Buffers: Relatively temporary storage for raw disk blocks
               shouldn't get tremendously large (20MB or so)

75% of total RAM is seeming tremendously large to me. :)

I'm running Debian stable on a dual-Opteron system:

Linux file003b 2.6.8-11-amd64-k8-smp #1 SMP Wed Jun 1 00:01:27 CEST 2005 
x86_64 GNU/Linux

(I can upgrade the kernel if this is a known issue with 2.6.8.)

Perhaps of interest is that I have a 2TB JFS filesystem on a 3ware SATA 
RAID controller.  The machine is running Apache (mpm_worker) and that's 
about it.  It's all image files - a third thumbnails (<1kB), a third 
resized to the 50-100kB range, and a third originals (max 1MB). 
Thumbnails should be getting served much more frequently than the 
others, so the disk access pattern is lots of small files.  Directories 
are hashed year/month/day/hour with maybe 4000 files in each.

slabtop shows ~161MB total size (I think this counts against buffers?). 
  Far and away the bigest users are buffer_head at ~50MB and 
radix_tree_node at ~99MB.

The machine is fairly responsive, but I'm seeing a load average of 
between 2 and 3 with about 250 concurrent Apache requests - I'm 
obviously hoping for better performance.

Ideas?  Or is this about what one would expect given the system 
configuration and workload?

/proc/meminfo:

MemTotal:      2053532 kB
MemFree:        181112 kB
Buffers:       1520348 kB
Cached:         116888 kB
SwapCached:          0 kB
Active:         891464 kB
Inactive:       785828 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:      2053532 kB
LowFree:        181112 kB
SwapTotal:     7815580 kB
SwapFree:      7815580 kB
Dirty:           17772 kB
Writeback:           0 kB
Mapped:          48116 kB
Slab:           174020 kB
Committed_AS:  2630836 kB
PageTables:       2996 kB
VmallocTotal: 536870911 kB
VmallocUsed:      4592 kB
VmallocChunk: 536866319 kB

/proc/slabinfo:

slabinfo - version: 2.0
# name            <active_objs> <num_objs> <objsize> <objperslab> 
<pagesperslab> : tunables <batchcount> <limit> <sharedfactor> : slabdata 
<active_slabs> <num_slabs> <sharedavail>
xfrm6_tunnel_spi       0      0     64   61    1 : tunables  120   60 
  8 : slabdata      0      0      0
fib6_nodes             5     61     64   61    1 : tunables  120   60 
  8 : slabdata      1      1      0
ip6_dst_cache         10     24    320   12    1 : tunables   54   27 
  8 : slabdata      2      2      0
ndisc_cache            1     15    256   15    1 : tunables  120   60 
  8 : slabdata      1      1      0
raw6_sock              0      0   1024    4    1 : tunables   54   27 
  8 : slabdata      0      0      0
udp6_sock              0      0    960    4    1 : tunables   54   27 
  8 : slabdata      0      0      0
tcp6_sock            219    240   1664    4    2 : tunables   24   12 
  8 : slabdata     60     60      0
ip_fib_hash            9    119     32  119    1 : tunables  120   60 
  8 : slabdata      1      1      0
jfs_mp               241    270    144   27    1 : tunables  120   60 
  8 : slabdata     10     10     60
jfs_ip              4212   4212   1176    3    1 : tunables   24   12 
  8 : slabdata   1404   1404      0
ext3_inode_cache     254    335    768    5    1 : tunables   54   27 
  8 : slabdata     67     67      0
ext3_xattr             0      0     88   45    1 : tunables  120   60 
  8 : slabdata      0      0      0
journal_handle        81     81     48   81    1 : tunables  120   60 
  8 : slabdata      1      1      0
journal_head         179    405     88   45    1 : tunables  120   60 
  8 : slabdata      9      9      0
revoke_table           8    225     16  225    1 : tunables  120   60 
  8 : slabdata      1      1      0
revoke_record          0      0     32  119    1 : tunables  120   60 
  8 : slabdata      0      0      0
scsi_cmd_cache       103    112    512    7    1 : tunables   54   27 
  8 : slabdata     16     16     55
sgpool-128            32     32   4096    1    1 : tunables   24   12 
  8 : slabdata     32     32      0
sgpool-64             32     32   2048    2    1 : tunables   24   12 
  8 : slabdata     16     16      0
sgpool-32             56     56   1024    4    1 : tunables   54   27 
  8 : slabdata     14     14      0
sgpool-16             77     88    512    8    1 : tunables   54   27 
  8 : slabdata     11     11      0
sgpool-8             195    195    256   15    1 : tunables  120   60 
  8 : slabdata     13     13     60
unix_sock             35     35    768    5    1 : tunables   54   27 
  8 : slabdata      7      7      0
clip_arp_cache         0      0    256   15    1 : tunables  120   60 
  8 : slabdata      0      0      0
ip_mrt_cache           0      0    128   31    1 : tunables  120   60 
  8 : slabdata      0      0      0
tcp_tw_bucket        316    440    192   20    1 : tunables  120   60 
  8 : slabdata     22     22      0
tcp_bind_bucket      137    238     32  119    1 : tunables  120   60 
  8 : slabdata      2      2     60
tcp_open_request      28     31    128   31    1 : tunables  120   60 
  8 : slabdata      1      1      0
inet_peer_cache        0      0    128   31    1 : tunables  120   60 
  8 : slabdata      0      0      0
secpath_cache          0      0    192   20    1 : tunables  120   60 
  8 : slabdata      0      0      0
xfrm_dst_cache         0      0    384   10    1 : tunables   54   27 
  8 : slabdata      0      0      0
ip_dst_cache         892   2610    384   10    1 : tunables   54   27 
  8 : slabdata    261    261      0
arp_cache              2     15    256   15    1 : tunables  120   60 
  8 : slabdata      1      1      0
raw4_sock              0      0    832    9    2 : tunables   54   27 
  8 : slabdata      0      0      0
udp_sock               5     18    832    9    2 : tunables   54   27 
  8 : slabdata      2      2      0
tcp_sock              34     40   1472    5    2 : tunables   24   12 
  8 : slabdata      8      8      0
flow_cache             0      0    128   31    1 : tunables  120   60 
  8 : slabdata      0      0      0
mqueue_inode_cache      1      4    896    4    1 : tunables   54   27 
   8 : slabdata      1      1      0
devfsd_event           0      0     32  119    1 : tunables  120   60 
  8 : slabdata      0      0      0
dquot                  0      0    224   17    1 : tunables  120   60 
  8 : slabdata      0      0      0
eventpoll_pwq          0      0     72   54    1 : tunables  120   60 
  8 : slabdata      0      0      0
eventpoll_epi          0      0    192   20    1 : tunables  120   60 
  8 : slabdata      0      0      0
kioctx                 0      0    384   10    1 : tunables   54   27 
  8 : slabdata      0      0      0
kiocb                  0      0    128   31    1 : tunables  120   60 
  8 : slabdata      0      0      0
dnotify_cache          0      0     40   96    1 : tunables  120   60 
  8 : slabdata      0      0      0
file_lock_cache        2     23    168   23    1 : tunables  120   60 
  8 : slabdata      1      1      0
fasync_cache           0      0     24  156    1 : tunables  120   60 
  8 : slabdata      0      0      0
shmem_inode_cache      6      8    832    4    1 : tunables   54   27 
  8 : slabdata      2      2      0
posix_timers_cache      0      0    176   22    1 : tunables  120   60 
   8 : slabdata      0      0      0
uid_cache              3     61     64   61    1 : tunables  120   60 
  8 : slabdata      1      1      0
cfq_pool             150    207     56   69    1 : tunables  120   60 
  8 : slabdata      3      3      3
crq_pool             348    432     72   54    1 : tunables  120   60 
  8 : slabdata      8      8    224
deadline_drq           0      0     96   41    1 : tunables  120   60 
  8 : slabdata      0      0      0
as_arq                 0      0    112   35    1 : tunables  120   60 
  8 : slabdata      0      0      0
blkdev_ioc           450    476     32  119    1 : tunables  120   60 
  8 : slabdata      4      4      0
blkdev_queue          17     18    840    9    2 : tunables   54   27 
  8 : slabdata      2      2      0
blkdev_requests      267    375    264   15    1 : tunables   54   27 
  8 : slabdata     25     25    189
biovec-(256)         256    256   4096    1    1 : tunables   24   12 
  8 : slabdata    256    256      0
biovec-128           256    256   2048    2    1 : tunables   24   12 
  8 : slabdata    128    128      0
biovec-64            301    328   1024    4    1 : tunables   54   27 
  8 : slabdata     80     82     13
biovec-16            372    390    256   15    1 : tunables  120   60 
  8 : slabdata     25     26      0
biovec-4             397    427     64   61    1 : tunables  120   60 
  8 : slabdata      7      7     60
biovec-1             648   2025     16  225    1 : tunables  120   60 
  8 : slabdata      9      9    300
bio                  707   1364    128   31    1 : tunables  120   60 
  8 : slabdata     44     44    300
sock_inode_cache     308    366    640    6    1 : tunables   54   27 
  8 : slabdata     61     61      0
skbuff_head_cache   1035   1440    320   12    1 : tunables   54   27 
  8 : slabdata    120    120    162
sock                   2      6    640    6    1 : tunables   54   27 
  8 : slabdata      1      1      0
proc_inode_cache      78     78    640    6    1 : tunables   54   27 
  8 : slabdata     13     13      0
sigqueue               0      0    168   23    1 : tunables  120   60 
  8 : slabdata      0      0      0
radix_tree_node   158919 174223    536    7    1 : tunables   54   27 
  8 : slabdata  24889  24889      0
bdev_cache             9     15    768    5    1 : tunables   54   27 
  8 : slabdata      3      3      0
mnt_cache             26     40    192   20    1 : tunables  120   60 
  8 : slabdata      2      2      0
inode_cache         2256   2282    576    7    1 : tunables   54   27 
  8 : slabdata    326    326      0
dentry_cache        6848   8144    248   16    1 : tunables  120   60 
  8 : slabdata    509    509      0
filp                 672   1050    256   15    1 : tunables  120   60 
  8 : slabdata     70     70     60
names_cache           33     33   4096    1    1 : tunables   24   12 
  8 : slabdata     33     33      0
idr_layer_cache       51     56    528    7    1 : tunables   54   27 
  8 : slabdata      8      8      0
buffer_head       409537 514796     96   41    1 : tunables  120   60 
  8 : slabdata  12556  12556      0
mm_struct             96     96   1024    4    1 : tunables   54   27 
  8 : slabdata     24     24      0
vm_area_struct      2912   4444    176   22    1 : tunables  120   60 
  8 : slabdata    202    202    480
fs_cache              92    183     64   61    1 : tunables  120   60 
  8 : slabdata      3      3      0
files_cache           59     81    832    9    2 : tunables   54   27 
  8 : slabdata      9      9      0
signal_cache         123    155    128   31    1 : tunables  120   60 
  8 : slabdata      5      5      0
sighand_cache         79     84   2112    3    2 : tunables   24   12 
  8 : slabdata     28     28      0
task_struct          387    399   2112    3    2 : tunables   24   12 
  8 : slabdata    133    133      0
anon_vma             636   1092     24  156    1 : tunables  120   60 
  8 : slabdata      7      7    240
shared_policy_node      0      0     56   69    1 : tunables  120   60 
   8 : slabdata      0      0      0
numa_policy           23    225     16  225    1 : tunables  120   60 
  8 : slabdata      1      1      0
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
size-32768             4      4  32768    1    8 : tunables    8    4 
  0 : slabdata      4      4      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4 
  0 : slabdata      0      0      0
size-16384           209    209  16384    1    4 : tunables    8    4 
  0 : slabdata    209    209      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4 
  0 : slabdata      0      0      0
size-8192             23     23   8192    1    2 : tunables    8    4 
  0 : slabdata     23     23      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12 
  8 : slabdata      0      0      0
size-4096            106    127   4096    1    1 : tunables   24   12 
  8 : slabdata    106    127      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12 
  8 : slabdata      0      0      0
size-2048            788    800   2048    2    1 : tunables   24   12 
  8 : slabdata    400    400     60
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27 
  8 : slabdata      0      0      0
size-1024            344    508   1024    4    1 : tunables   54   27 
  8 : slabdata    127    127     11
size-512(DMA)          0      0    512    8    1 : tunables   54   27 
  8 : slabdata      0      0      0
size-512             408    608    512    8    1 : tunables   54   27 
  8 : slabdata     76     76    189
size-256(DMA)          0      0    256   15    1 : tunables  120   60 
  8 : slabdata      0      0      0
size-256              77    780    256   15    1 : tunables  120   60 
  8 : slabdata     52     52      0
size-192(DMA)          0      0    192   20    1 : tunables  120   60 
  8 : slabdata      0      0      0
size-192            1725   1780    192   20    1 : tunables  120   60 
  8 : slabdata     89     89      0
size-128(DMA)          0      0    128   31    1 : tunables  120   60 
  8 : slabdata      0      0      0
size-128            1178   1178    128   31    1 : tunables  120   60 
  8 : slabdata     38     38      0
size-64(DMA)           0      0     64   61    1 : tunables  120   60 
  8 : slabdata      0      0      0
size-64             2542   3843     64   61    1 : tunables  120   60 
  8 : slabdata     63     63      0
size-32(DMA)           0      0     32  119    1 : tunables  120   60 
  8 : slabdata      0      0      0
size-32              758   3213     32  119    1 : tunables  120   60 
  8 : slabdata     27     27     60
kmem_cache           120    120    256   15    1 : tunables  120   60 
  8 : slabdata      8      8      0


--
Dave Pifke, dave@bebo.com
Sr. System Administrator, www.bebo.com
