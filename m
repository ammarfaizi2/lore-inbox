Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264238AbUGYRad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264238AbUGYRad (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 13:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbUGYRad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 13:30:33 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:2017 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S264238AbUGYRaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 13:30:09 -0400
Date: Sun, 25 Jul 2004 19:30:23 +0200
From: Kronos <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org
Subject: [2.6.8-rc2][XFS] Page allocation failure
Message-ID: <20040725173022.GA8345@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I just got the following stack trace in my logs:

java: page allocation failure. order:5, mode:0xd0
 [<c01065b7>] dump_stack+0x17/0x20
 [<c014cd3c>] __alloc_pages+0x29c/0x300
 [<c014cdc2>] __get_free_pages+0x22/0x50
 [<c015164a>] kmem_getpages+0x1a/0xc0
 [<c015272a>] cache_grow+0x14a/0x380
 [<c0152b56>] cache_alloc_refill+0x1f6/0x340
 [<c01533e8>] __kmalloc+0x78/0xa0
 [<f1a47d97>] kmem_alloc+0x57/0xc0 [xfs]
 [<f1a2163c>] xfs_iread_extents+0x4c/0xf0 [xfs]
 [<f19fc9f6>] xfs_bmapi+0x226/0x1400 [xfs]
 [<f1a25965>] xfs_iomap+0x165/0x430 [xfs]
 [<f1a4937c>] linvfs_get_block_core+0x7c/0x270 [xfs]
 [<f1a495a3>] linvfs_get_block+0x33/0x40 [xfs]
 [<c01a369e>] do_mpage_readpage+0x17e/0x490
 [<c01a3ab7>] mpage_readpages+0x107/0x130
 [<c015077d>] read_pages+0xfd/0x110
 [<c0150d3e>] do_page_cache_readahead+0x1ae/0x3e0
 [<c0151060>] page_cache_readahead+0xf0/0x1d0
 [<c0147d56>] do_generic_mapping_read+0xd6/0x430
 [<c014834f>] __generic_file_aio_read+0x1bf/0x1f0
 [<f1a50101>] xfs_read+0x141/0x240 [xfs]
 [<f1a4c677>] linvfs_read+0x77/0x90 [xfs]
 [<c0170a25>] do_sync_read+0x65/0xa0
 [<c0170b02>] vfs_read+0xa2/0xf0
 [<c0170d15>] sys_read+0x35/0x60
 [<c010580f>] syscall_call+0x7/0xb
java: page allocation failure. order:5, mode:0xd0
 [<c01065b7>] dump_stack+0x17/0x20
 [<c014cd3c>] __alloc_pages+0x29c/0x300
 [<c014cdc2>] __get_free_pages+0x22/0x50
 [<c015164a>] kmem_getpages+0x1a/0xc0
 [<c015272a>] cache_grow+0x14a/0x380
 [<c0152b56>] cache_alloc_refill+0x1f6/0x340
 [<c01533e8>] __kmalloc+0x78/0xa0
 [<f1a47d97>] kmem_alloc+0x57/0xc0 [xfs]
 [<f1a2163c>] xfs_iread_extents+0x4c/0xf0 [xfs]
 [<f19fc9f6>] xfs_bmapi+0x226/0x1400 [xfs]
 [<f1a25965>] xfs_iomap+0x165/0x430 [xfs]
 [<f1a4937c>] linvfs_get_block_core+0x7c/0x270 [xfs]
 [<f1a495a3>] linvfs_get_block+0x33/0x40 [xfs]
 [<c01a369e>] do_mpage_readpage+0x17e/0x490
 [<c01a3ab7>] mpage_readpages+0x107/0x130
 [<c015077d>] read_pages+0xfd/0x110
 [<c0150d3e>] do_page_cache_readahead+0x1ae/0x3e0
 [<c0151060>] page_cache_readahead+0xf0/0x1d0
 [<c0147d56>] do_generic_mapping_read+0xd6/0x430
 [<c014834f>] __generic_file_aio_read+0x1bf/0x1f0
 [<f1a50101>] xfs_read+0x141/0x240 [xfs]
 [<f1a4c677>] linvfs_read+0x77/0x90 [xfs]
 [<c0170a25>] do_sync_read+0x65/0xa0
 [<c0170b02>] vfs_read+0xa2/0xf0
 [<c0170d15>] sys_read+0x35/0x60
 [<c010580f>] syscall_call+0x7/0xb

It seems that XFS failed an order 5 allocation (not atomic) on the read
path two times (there are 80 secs between the warnings). Can I assume
that the FS is not harmed?

Btw, even if the allocation is quite big the machine was up for a bit
more the one hour, it's strange that the memory is fragmented so
badly...

Below are relevants VM infos, VM parameters are untouched except for
swappiness which is set to 90.

kronos:~$ uptime
 19:09:39 up  1:12, 11 users,  load average: 0.80, 0.37, 0.25

kronos:~$ cat /proc/vmstat
nr_dirty 6
nr_writeback 0
nr_unstable 0
nr_page_table_pages 334
nr_mapped 43893
nr_slab 27774
pgpgin 1831095
pgpgout 535073
pswpin 12365
pswpout 19530
pgalloc_high 0
pgalloc_normal 4161446
pgalloc_dma 385265
pgfree 4548167
pgactivate 167093
pgdeactivate 170027
pgfault 2134461
pgmajfault 2590
pgrefill_high 0
pgrefill_normal 347828
pgrefill_dma 46606
pgsteal_high 0
pgsteal_normal 363175
pgsteal_dma 44184
pgscan_kswapd_high 0
pgscan_kswapd_normal 342375
pgscan_kswapd_dma 51419
pgscan_direct_high 0
pgscan_direct_normal 77220
pgscan_direct_dma 2446
pginodesteal 37
slabs_scanned 1191152
kswapd_steal 337732
kswapd_inodesteal 12596
pageoutrun 1359
allocstall 2043
pgrotated 19589

kronos:~$ cat /proc/meminfo
MemTotal:       775256 kB
MemFree:          4964 kB
Buffers:         23316 kB
Cached:         476872 kB
SwapCached:      33672 kB
Active:         143984 kB
Inactive:       505688 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       775256 kB
LowFree:          4964 kB
SwapTotal:      265064 kB
SwapFree:       193480 kB
Dirty:              28 kB
Writeback:           0 kB
Mapped:         175588 kB
Slab:           111028 kB
Committed_AS:   402436 kB
PageTables:       1336 kB
VmallocTotal:   253876 kB
VmallocUsed:     20940 kB
VmallocChunk:   232856 kB

cat /proc/slabinfo
slabinfo - version: 2.0
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <batchcount> <limit> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
ip_fib_hash            9    226     16  226    1 : tunables  120   60    0 : slabdata      1      1      0
uhci_urb_priv          0      0     44   88    1 : tunables  120   60    0 : slabdata      0      0      0
isofs_inode_cache      2      8    480    8    1 : tunables   54   27    0 : slabdata      1      1      0
fat_inode_cache       13     32    480    8    1 : tunables   54   27    0 : slabdata      4      4      0
ntfs_big_inode_cache   7931  21020    704    5    1 : tunables   54   27    0 : slabdata   4204   4204      0
ntfs_inode_cache      32     90    256   15    1 : tunables  120   60    0 : slabdata      6      6      0
ntfs_name_cache        0      0    512    8    1 : tunables   54   27    0 : slabdata      0      0      0
ntfs_attr_ctx_cache      0      0     32  119    1 : tunables  120   60    0 : slabdata      0      0      0
ntfs_index_ctx_cache      0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
xfs_chashlist       3309  10175     20  185    1 : tunables  120   60    0 : slabdata     55     55      0
xfs_ili              181    700    140   28    1 : tunables  120   60    0 : slabdata     25     25      0
xfs_ifork              0      0     56   70    1 : tunables  120   60    0 : slabdata      0      0      0
xfs_efi_item           0      0    260   15    1 : tunables   54   27    0 : slabdata      0      0      0
xfs_efd_item           0      0    260   15    1 : tunables   54   27    0 : slabdata      0      0      0
xfs_buf_item          54     54    148   27    1 : tunables  120   60    0 : slabdata      2      2      0
xfs_dabuf             16    226     16  226    1 : tunables  120   60    0 : slabdata      1      1      0
xfs_da_state           0      0    336   12    1 : tunables   54   27    0 : slabdata      0      0      0
xfs_trans             24     24    616    6    1 : tunables   54   27    0 : slabdata      4      4      0
xfs_inode          14463  42786    448    9    1 : tunables   54   27    0 : slabdata   4754   4754      0
xfs_btree_cur         28     28    140   28    1 : tunables  120   60    0 : slabdata      1      1      0
xfs_bmap_free_item      0      0     16  226    1 : tunables  120   60    0 : slabdata      0      0      0
xfs_buf_t             60     60    320   12    1 : tunables   54   27    0 : slabdata      5      5      0
linvfs_icache      14458  37527    512    7    1 : tunables   54   27    0 : slabdata   5361   5361      0
xfrm6_tunnel_spi       0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
fib6_nodes            13    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
ip6_dst_cache         11     18    224   18    1 : tunables  120   60    0 : slabdata      1      1      0
ndisc_cache            2     20    192   20    1 : tunables  120   60    0 : slabdata      1      1      0
raw6_sock              0      0    768    5    1 : tunables   54   27    0 : slabdata      0      0      0
udp6_sock              2      5    768    5    1 : tunables   54   27    0 : slabdata      1      1      0
tcp6_sock            164    270   1376    5    2 : tunables   24   12    0 : slabdata     54     54      0
unix_sock            130    133    576    7    1 : tunables   54   27    0 : slabdata     19     19      0
tcp_tw_bucket         10     31    128   31    1 : tunables  120   60    0 : slabdata      1      1      0
tcp_bind_bucket       99    904     16  226    1 : tunables  120   60    0 : slabdata      4      4      0
tcp_open_request       9     41     96   41    1 : tunables  120   60    0 : slabdata      1      1      0
inet_peer_cache        0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
secpath_cache          0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
xfrm_dst_cache         0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
ip_dst_cache         291    960    256   15    1 : tunables  120   60    0 : slabdata     64     64      0
arp_cache              3     20    192   20    1 : tunables  120   60    0 : slabdata      1      1      0
raw4_sock              0      0    640    6    1 : tunables   54   27    0 : slabdata      0      0      0
udp_sock               7     12    640    6    1 : tunables   54   27    0 : slabdata      2      2      0
tcp_sock              23     24   1248    3    1 : tunables   24   12    0 : slabdata      8      8      0
flow_cache             0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
ext2_inode_cache    2139   5278    544    7    1 : tunables   54   27    0 : slabdata    754    754      0
reiser_inode_cache   1320   2072    544    7    1 : tunables   54   27    0 : slabdata    296    296      0
eventpoll_pwq          0      0     36  107    1 : tunables  120   60    0 : slabdata      0      0      0
eventpoll_epi          0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
kioctx                 0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
kiocb                  0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
dnotify_cache          0      0     20  185    1 : tunables  120   60    0 : slabdata      0      0      0
file_lock_cache       13     34    116   34    1 : tunables  120   60    0 : slabdata      1      1      0
fasync_cache           0      0     16  226    1 : tunables  120   60    0 : slabdata      0      0      0
shmem_inode_cache    173    175    576    7    1 : tunables   54   27    0 : slabdata     25     25      0
posix_timers_cache      0      0    144   27    1 : tunables  120   60    0 : slabdata      0      0      0
uid_cache              7    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
sgpool-128            32     32   2048    2    1 : tunables   24   12    0 : slabdata     16     16      0
sgpool-64             32     32   1024    4    1 : tunables   54   27    0 : slabdata      8      8      0
sgpool-32             32     32    512    8    1 : tunables   54   27    0 : slabdata      4      4      0
sgpool-16             32     45    256   15    1 : tunables  120   60    0 : slabdata      3      3      0
sgpool-8              32     62    128   31    1 : tunables  120   60    0 : slabdata      2      2      0
cfq_pool              64    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
crq_pool               0      0     40   96    1 : tunables  120   60    0 : slabdata      0      0      0
deadline_drq           0      0     52   75    1 : tunables  120   60    0 : slabdata      0      0      0
as_arq               135    183     64   61    1 : tunables  120   60    0 : slabdata      3      3      0
blkdev_ioc            89    185     20  185    1 : tunables  120   60    0 : slabdata      1      1      0
blkdev_queue           5      7    544    7    1 : tunables   54   27    0 : slabdata      1      1      0
blkdev_requests      115    175    160   25    1 : tunables  120   60    0 : slabdata      7      7      0
biovec-(256)         256    256   3072    2    2 : tunables   24   12    0 : slabdata    128    128      0
biovec-128           256    260   1536    5    2 : tunables   24   12    0 : slabdata     52     52      0
biovec-64            256    260    768    5    1 : tunables   54   27    0 : slabdata     52     52      0
biovec-16            260    260    192   20    1 : tunables  120   60    0 : slabdata     13     13      0
biovec-4             281    305     64   61    1 : tunables  120   60    0 : slabdata      5      5      0
biovec-1             340    678     16  226    1 : tunables  120   60    0 : slabdata      3      3      0
bio                  353    410     96   41    1 : tunables  120   60    0 : slabdata     10     10      0
sock_inode_cache     323    504    512    7    1 : tunables   54   27    0 : slabdata     72     72      0
skbuff_head_cache    240    780    192   20    1 : tunables  120   60    0 : slabdata     39     39      0
sock                   2      8    480    8    1 : tunables   54   27    0 : slabdata      1      1      0
proc_inode_cache     180    405    448    9    1 : tunables   54   27    0 : slabdata     45     45      0
sigqueue              16     27    148   27    1 : tunables  120   60    0 : slabdata      1      1      0
radix_tree_node     6846  11256    276   14    1 : tunables   54   27    0 : slabdata    804    804      0
bdev_cache            13     18    608    6    1 : tunables   54   27    0 : slabdata      3      3      0
mnt_cache             30     41     96   41    1 : tunables  120   60    0 : slabdata      1      1      0
inode_cache         1793   1818    448    9    1 : tunables   54   27    0 : slabdata    202    202      0
dentry_cache       14076  85776    164   24    1 : tunables  120   60    0 : slabdata   3574   3574      0
filp                1459   1880    192   20    1 : tunables  120   60    0 : slabdata     94     94      0
names_cache           23     23   4096    1    1 : tunables   24   12    0 : slabdata     23     23      0
idr_layer_cache       84     87    136   29    1 : tunables  120   60    0 : slabdata      3      3      0
buffer_head       114586 140625     52   75    1 : tunables  120   60    0 : slabdata   1875   1875      0
mm_struct             70     99    704   11    2 : tunables   54   27    0 : slabdata      9      9      0
vm_area_struct      2713   2773     84   47    1 : tunables  120   60    0 : slabdata     59     59      0
fs_cache              72    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
files_cache           70     81    448    9    1 : tunables   54   27    0 : slabdata      9      9      0
signal_cache          91    123     96   41    1 : tunables  120   60    0 : slabdata      3      3      0
sighand_cache         82     84   1312    3    1 : tunables   24   12    0 : slabdata     28     28      0
task_struct          153    155   1536    5    2 : tunables   24   12    0 : slabdata     31     31      0
anon_vma            1297   1309     32  119    1 : tunables  120   60    0 : slabdata     11     11      0
pgd                   67     67   4096    1    1 : tunables   24   12    0 : slabdata     67     67      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-131072            3      3 131072    1   32 : tunables    8    4    0 : slabdata      3      3      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-65536             3      3  65536    1   16 : tunables    8    4    0 : slabdata      3      3      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-32768            18     18  32768    1    8 : tunables    8    4    0 : slabdata     18     18      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0
size-16384            28     28  16384    1    4 : tunables    8    4    0 : slabdata     28     28      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : slabdata      0      0      0
size-8192            158    160   8192    1    2 : tunables    8    4    0 : slabdata    158    160      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    0 : slabdata      0      0      0
size-4096           2854   2854   4096    1    1 : tunables   24   12    0 : slabdata   2854   2854      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    0 : slabdata      0      0      0
size-2048            194    218   2048    2    1 : tunables   24   12    0 : slabdata    108    109      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    0 : slabdata      0      0      0
size-1024            220    220   1024    4    1 : tunables   54   27    0 : slabdata     55     55      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27    0 : slabdata      0      0      0
size-512             262    592    512    8    1 : tunables   54   27    0 : slabdata     74     74      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
size-256             183    525    256   15    1 : tunables  120   60    0 : slabdata     35     35      0
size-192(DMA)          0      0    192   20    1 : tunables  120   60    0 : slabdata      0      0      0
size-192             520    980    192   20    1 : tunables  120   60    0 : slabdata     49     49      0
size-128(DMA)          0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
size-128            4326   6200    128   31    1 : tunables  120   60    0 : slabdata    200    200      0
size-64(DMA)           0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
size-64             2200   5551     64   61    1 : tunables  120   60    0 : slabdata     91     91      0
size-32(DMA)           0      0     32  119    1 : tunables  120   60    0 : slabdata      0      0      0
size-32             4334   5236     32  119    1 : tunables  120   60    0 : slabdata     44     44      0
kmem_cache           125    125    160   25    1 : tunables  120   60    0 : slabdata      5      5      0


Luca
-- 
Home: http://kronoz.cjb.net
"Sei l'unica donna della mia vita".
(Adamo)
