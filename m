Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262270AbUKDP1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262270AbUKDP1T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 10:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbUKDP1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 10:27:19 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34746 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262271AbUKDPVz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 10:21:55 -0500
Date: Thu, 4 Nov 2004 10:17:22 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Stefan Schmidt <zaphodb@zaphods.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.9 Multiple Page Allocation Failures (Part 2)
Message-ID: <20041104121722.GB8537@logos.cnet>
References: <20041103222447.GD28163@zaphods.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041103222447.GD28163@zaphods.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 11:24:48PM +0100, Stefan Schmidt wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> > > swapper: page allocation failure. order:0, mode:0x20
> > This should be harmless - networking will recover.  The TSO fix was
> > merged a week or so ago.
> Ahem,
> i don't think its all that harmless:
> My machine got hundreds of the same in a row even after raising
> vm.min_free_kbytes to 8192 and playing with vm.* in one direction and then in
> the other one. 

What is min_free_kbytes default on your machine?

> Essentially the application took 2.2GB and cache was around
> 1.7GB of 4GB available memory. The machine swapping heavily at ~3m intervals
> and setting swappiness to zero did not help.
> I tried the following kernels: 2.6.9-mm1, 2.6.10-rc1-bk12, 2.6.9-rc3-bk6,
> 2.6.9-rc3-bk5 all of which froze at some point presenting me only with the
> above page allocation failure. (no more sysrq) 
> 2.6.9 gave me this in the end: http://zaphods.net/~zaphodb/recursive_die.png

This should be harmless as Andrew said - it would be helpful if you could 
plug a serial cable to the box - this last oops on the picture doesnt say 
much.

How intense is the network traffic you're generating?

> Which was the point i decided to give 2.4 a try and guess what: This is
> running faster and at higher packet rates than the 2.6 kernels achived and
> is stable for the last three hours which at this load is more than the
> abovementioned 2.6 kernels managed.
> I got the impression there is another 2.6 vm-instability which made it in the
> kernel after 2.6.7.

2.6.7 was stable under the same load?

2.4 keeps a higher amount of free pages around, but you should be able
to tune that with vm.min_free_kbytes... 

For some reason the VM is not being able to keep enough pages free. 
But then it shouldnt matter - if the tg3 driver can't allocate memory 
it should drop the packet and not lockup.

Something is definately screwed, and there are quite an amount of 
similar reports.

XFS also seems to be very memory hungry...

> The machine is a Dual Opteron on Tyan K8S 4GB ECC-RAM running debian/unstable
> (yes thats 32-bit only) from a 3ware 9000 Controller (SATA) - 8 250GB Disks
> configured as single disks, no hw raid. Root-FS resides on SoftwareRAID,
> Application uses xfs filesystems on the disks.
> 
> I attached some vmstat and slapinfo output during the swapping-phase. Dont
> remember the exact kernel here but it was 2.6. (yes, the hostname is kernel.
> ;)
> 
> 	Stefan

> Nov  2 17:12:26 kernel kernel: swapper: page allocation failure. order:0, mode:0x20
> Nov  2 17:12:26 kernel kernel:  [__alloc_pages+417/800] __alloc_pages+0x1a1/0x320
> Nov  2 17:12:26 kernel kernel:  [__get_free_pages+24/48] __get_free_pages+0x18/0x30
> Nov  2 17:12:26 kernel kernel:  [kmem_getpages+24/192] kmem_getpages+0x18/0xc0
> Nov  2 17:12:26 kernel kernel:  [cache_grow+157/304] cache_grow+0x9d/0x130
> Nov  2 17:12:26 kernel kernel:  [nf_hook_slow+178/240] nf_hook_slow+0xb2/0xf0
> Nov  2 17:12:26 kernel kernel:  [cache_alloc_refill+363/544] cache_alloc_refill+0x16b/0x220
> Nov  2 17:12:26 kernel kernel:  [__kmalloc+122/144] __kmalloc+0x7a/0x90
> Nov  2 17:12:26 kernel kernel:  [alloc_skb+50/208] alloc_skb+0x32/0xd0
> Nov  2 17:12:26 kernel kernel:  [pg0+945331568/1068909568] tg3_alloc_rx_skb+0x70/0x130 [tg3]
> Nov  2 17:12:26 kernel kernel:  [pg0+945332742/1068909568] tg3_rx+0x206/0x3b0 [tg3]
> Nov  2 17:12:26 kernel kernel:  [pg0+945333307/1068909568] tg3_poll+0x8b/0x130 [tg3]
> Nov  2 17:12:26 kernel kernel:  [net_rx_action+112/240] net_rx_action+0x70/0xf0
> Nov  2 17:12:26 kernel kernel:  [__do_softirq+184/208] __do_softirq+0xb8/0xd0
> Nov  2 17:12:26 kernel kernel:  [do_softirq+45/48] do_softirq+0x2d/0x30
> Nov  2 17:12:26 kernel kernel:  [do_IRQ+43/64] do_IRQ+0x2b/0x40
> Nov  2 17:12:26 kernel kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
> Nov  2 17:12:26 kernel kernel:  [default_idle+0/64] default_idle+0x0/0x40
> Nov  2 17:12:26 kernel kernel:  [default_idle+44/64] default_idle+0x2c/0x40
> Nov  2 17:12:26 kernel kernel:  [cpu_idle+51/64] cpu_idle+0x33/0x40
> Nov  2 17:12:26 kernel kernel:  [start_kernel+332/368] start_kernel+0x14c/0x170
> Nov  2 17:12:26 kernel kernel:  [unknown_bootoption+0/416] unknown_bootoption+0x0/0x1a0
> 
> 
> procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
>  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
>  1  1 132964   3272   6420 1681888    0    0  1401  7668 15763   691  4 23 40 33
>  1  1 132964   3100   6380 1685256    0    0  1928 11176 16051   705  4 27 39 30
>  0  1 132964   3292   6212 1685288    0    0  1788  7575 16031   720  5 23 51 21
>  0  2 132964   4016   6432 1683368    0    0  1752  9379 16221   652  4 26 46 24
>  0  2 134180 197092    520 1496176   26  175  2473 12866 16302  1630  5 27 21 48
>  1  0 145608  89844   1476 1604432   56 1182  2672  9028 16248   822  4 26 37 32
>  1  0 145608  15148   2016 1675404   20    0  2127  4868 16193   612  4 26 48 22
>  0  1 146816   3152   2432 1688956  171  122  1872  6761 14757   583  2 15 29 53
>  0  2 146816   3972   2736 1693380  298    0  1982  7910 15626   666  3 23 48 27
>  1  0 146816   4028   2796 1689412  170    0  1759  7339 15586   597  2 18 35 45
>  0  1 146816   4136   2984 1690960  127    0  2091  7396 16146   557  3 26 43 27
>  0  3 146816   4320   3460 1685736   86    0  2042  7381 15981   597  3 23 32 41
>  0  1 146816  16820   3556 1672304   73    0  1082  9960 15361   777  2 18 34 46
>  0  1 146816   3348   3704 1686584   40    0  1762  8153 16247   633  4 26 42 28
>  0  2 146816   5700   3912 1683600   26    0  1973  9772 16120   669  4 24 42 30
>  0  0 146816   6096   4084 1674224   32    0  1478  7469 15378   569  2 18 33 47
>  0  3 146816   4284   4148 1680812   15    0  1052  8376 15717   576  3 24 43 30
>  0  1 146816   3572   4412 1684472   29    0  1660 10212 15740   597  3 22 38 37
>  0  0 146816   6220   4576 1680260   24    0  2256  8223 16015   656  4 25 47 25
>  0  1 146816   3448   4436 1683892   11    0  1526  8507 15820   628  4 21 38 37
>  0  0 146816   3152   4552 1687964   10    0  1609  9256 16244   665  4 25 52 18
>  0  0 146816   4212   4660 1683816    5    0  1524  8207 16066   545  3 25 42 30
> 
> labinfo - version: 2.1
> # name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <batchcount> <limit> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
> ip_conntrack_expect      0      0    128   31    1 : tunables  120   60    8 : slabdata      0      0      0
> ip_conntrack       22024  23748    320   12    1 : tunables   54   27    8 : slabdata   1979   1979     85
> fib6_nodes             5    119     32  119    1 : tunables  120   60    8 : slabdata      1      1      0
> ip6_dst_cache          4     15    256   15    1 : tunables  120   60    8 : slabdata      1      1      0
> ndisc_cache            1     20    192   20    1 : tunables  120   60    8 : slabdata      1      1      0
> rawv6_sock             4     11    704   11    2 : tunables   54   27    8 : slabdata      1      1      0
> udpv6_sock             1      6    640    6    1 : tunables   54   27    8 : slabdata      1      1      0
> tcpv6_sock             5      6   1216    3    1 : tunables   24   12    8 : slabdata      2      2      0
> unix_sock             23     27    448    9    1 : tunables   54   27    8 : slabdata      3      3      0
> tcp_tw_bucket       6281   7192    128   31    1 : tunables  120   60    8 : slabdata    232    232    120
> tcp_bind_bucket        6    226     16  226    1 : tunables  120   60    8 : slabdata      1      1      0
> tcp_open_request     214    310    128   31    1 : tunables  120   60    8 : slabdata     10     10      0
> inet_peer_cache        2     61     64   61    1 : tunables  120   60    8 : slabdata      1      1      0
> secpath_cache          0      0    128   31    1 : tunables  120   60    8 : slabdata      0      0      0
> xfrm_dst_cache         0      0    256   15    1 : tunables  120   60    8 : slabdata      0      0      0
> ip_fib_alias           9    226     16  226    1 : tunables  120   60    8 : slabdata      1      1      0
> ip_fib_hash            9    119     32  119    1 : tunables  120   60    8 : slabdata      1      1      0
> ip_dst_cache       11007  13515    256   15    1 : tunables  120   60    8 : slabdata    901    901      0
> arp_cache              1     20    192   20    1 : tunables  120   60    8 : slabdata      1      1      0
> raw_sock               3      7    512    7    1 : tunables   54   27    8 : slabdata      1      1      0
> udp_sock               3      8    512    8    1 : tunables   54   27    8 : slabdata      1      1      0
> tcp_sock            7192   7910   1088    7    2 : tunables   24   12    8 : slabdata   1130   1130     72
> flow_cache             0      0    128   31    1 : tunables  120   60    8 : slabdata      0      0      0
> dm-snapshot-in       128    162     48   81    1 : tunables  120   60    8 : slabdata      2      2      0
> dm-snapshot-ex         0      0     16  226    1 : tunables  120   60    8 : slabdata      0      0      0
> dm-crypt_io            0      0     76   52    1 : tunables  120   60    8 : slabdata      0      0      0
> dm_tio                 0      0     16  226    1 : tunables  120   60    8 : slabdata      0      0      0
> dm_io                  0      0     16  226    1 : tunables  120   60    8 : slabdata      0      0      0
> scsi_cmd_cache       100    100    384   10    1 : tunables   54   27    8 : slabdata     10     10     27
> cfq_ioc_pool           0      0     24  156    1 : tunables  120   60    8 : slabdata      0      0      0
> cfq_pool               0      0    104   38    1 : tunables  120   60    8 : slabdata      0      0      0
> crq_pool               0      0     52   75    1 : tunables  120   60    8 : slabdata      0      0      0
> deadline_drq           0      0     48   81    1 : tunables  120   60    8 : slabdata      0      0      0
> as_arq               515    845     60   65    1 : tunables  120   60    8 : slabdata     13     13    300
> xfs_chashlist        583    740     20  185    1 : tunables  120   60    8 : slabdata      4      4      0
> xfs_ili             1873   2184    140   28    1 : tunables  120   60    8 : slabdata     78     78      0
> xfs_ifork              0      0     56   70    1 : tunables  120   60    8 : slabdata      0      0      0
> xfs_efi_item          15     15    260   15    1 : tunables   54   27    8 : slabdata      1      1      0
> xfs_efd_item          15     15    260   15    1 : tunables   54   27    8 : slabdata      1      1      0
> xfs_buf_item         639    783    148   27    1 : tunables  120   60    8 : slabdata     29     29    284
> xfs_dabuf             10    226     16  226    1 : tunables  120   60    8 : slabdata      1      1      0
> xfs_da_state           0      0    336   12    1 : tunables   54   27    8 : slabdata      0      0      0
> xfs_trans            260    260    596   13    2 : tunables   54   27    8 : slabdata     20     20     27
> xfs_inode           2212   3135    368   11    1 : tunables   54   27    8 : slabdata    285    285      0
> xfs_btree_cur        120    120    132   30    1 : tunables  120   60    8 : slabdata      4      4      0
> xfs_bmap_free_item     24    290     12  290    1 : tunables  120   60    8 : slabdata      1      1      0
> xfs_buf_t            690    870    256   15    1 : tunables  120   60    8 : slabdata     58     58    224
> linvfs_icache       2003   2673    344   11    1 : tunables   54   27    8 : slabdata    243    243      0
> hugetlbfs_inode_cache      1     12    312   12    1 : tunables   54   27    8 : slabdata      1      1      0
> ext2_inode_cache       0      0    448    9    1 : tunables   54   27    8 : slabdata      0      0      0
> ext2_xattr             0      0     44   88    1 : tunables  120   60    8 : slabdata      0      0      0
> journal_handle       135    135     28  135    1 : tunables  120   60    8 : slabdata      1      1      0
> journal_head         849   2835     48   81    1 : tunables  120   60    8 : slabdata     35     35     60
> revoke_table           2    290     12  290    1 : tunables  120   60    8 : slabdata      1      1      0
> revoke_record        109    226     16  226    1 : tunables  120   60    8 : slabdata      1      1      0
> ext3_inode_cache     414    707    508    7    1 : tunables   54   27    8 : slabdata    101    101      0
> ext3_xattr             0      0     44   88    1 : tunables  120   60    8 : slabdata      0      0      0
> dnotify_cache          0      0     20  185    1 : tunables  120   60    8 : slabdata      0      0      0
> eventpoll_pwq          0      0     36  107    1 : tunables  120   60    8 : slabdata      0      0      0
> eventpoll_epi          0      0    128   31    1 : tunables  120   60    8 : slabdata      0      0      0
> kioctx                 0      0    192   20    1 : tunables  120   60    8 : slabdata      0      0      0
> kiocb                  0      0    128   31    1 : tunables  120   60    8 : slabdata      0      0      0
> fasync_cache           0      0     16  226    1 : tunables  120   60    8 : slabdata      0      0      0
> shmem_inode_cache      7      9    408    9    1 : tunables   54   27    8 : slabdata      1      1      0
> posix_timers_cache      0      0    104   38    1 : tunables  120   60    8 : slabdata      0      0      0
> uid_cache              3     61     64   61    1 : tunables  120   60    8 : slabdata      1      1      0
> sgpool-128            32     33   2560    3    2 : tunables   24   12    8 : slabdata     11     11      0
> sgpool-64             32     33   1280    3    1 : tunables   24   12    8 : slabdata     11     11      0
> sgpool-32            102    102    640    6    1 : tunables   54   27    8 : slabdata     17     17     27
> sgpool-16             96     96    320   12    1 : tunables   54   27    8 : slabdata      8      8      0
> sgpool-8             200    200    192   20    1 : tunables  120   60    8 : slabdata     10     10     60
> blkdev_ioc            84    135     28  135    1 : tunables  120   60    8 : slabdata      1      1      0
> blkdev_queue          10     20    372   10    1 : tunables   54   27    8 : slabdata      2      2      0
> blkdev_requests      471    840    140   28    1 : tunables  120   60    8 : slabdata     30     30    240
> biovec-(256)         256    256   3072    2    2 : tunables   24   12    8 : slabdata    128    128      0
> biovec-128           256    260   1536    5    2 : tunables   24   12    8 : slabdata     52     52      0
> biovec-64            320    320    768    5    1 : tunables   54   27    8 : slabdata     64     64      0
> biovec-16            350    380    192   20    1 : tunables  120   60    8 : slabdata     19     19      0
> biovec-4             374    427     64   61    1 : tunables  120   60    8 : slabdata      7      7      0
> biovec-1            1456   3164     16  226    1 : tunables  120   60    8 : slabdata     14     14    480
> bio                 1418   2196     64   61    1 : tunables  120   60    8 : slabdata     36     36    480
> file_lock_cache       23     43     92   43    1 : tunables  120   60    8 : slabdata      1      1      0
> sock_inode_cache    7064   7830    384   10    1 : tunables   54   27    8 : slabdata    783    783    135
> skbuff_head_cache  14636  23220    192   20    1 : tunables  120   60    8 : slabdata   1161   1161    420
> sock                   3     10    384   10    1 : tunables   54   27    8 : slabdata      1      1      0
> proc_inode_cache     321    360    328   12    1 : tunables   54   27    8 : slabdata     30     30      0
> sigqueue              19     27    148   27    1 : tunables  120   60    8 : slabdata      1      1      0
> radix_tree_node    22347  28602    276   14    1 : tunables   54   27    8 : slabdata   2043   2043     27
> bdev_cache            30     45    448    9    1 : tunables   54   27    8 : slabdata      5      5      0
> mnt_cache             26     62    128   31    1 : tunables  120   60    8 : slabdata      2      2      0
> inode_cache         1040   1128    312   12    1 : tunables   54   27    8 : slabdata     94     94      0
> dentry_cache       10067  15400    140   28    1 : tunables  120   60    8 : slabdata    550    550    240
> filp                8189   9100    192   20    1 : tunables  120   60    8 : slabdata    455    455     60
> names_cache           26     26   4096    1    1 : tunables   24   12    8 : slabdata     26     26      0
> idr_layer_cache      112    116    136   29    1 : tunables  120   60    8 : slabdata      4      4      0
> buffer_head       345712 472959     48   81    1 : tunables  120   60    8 : slabdata   5839   5839    480
> mm_struct             91     91    576    7    1 : tunables   54   27    8 : slabdata     13     13      0
> vm_area_struct      1994   2205     88   45    1 : tunables  120   60    8 : slabdata     49     49      0
> fs_cache              86    183     64   61    1 : tunables  120   60    8 : slabdata      3      3      0
> files_cache           87     99    448    9    1 : tunables   54   27    8 : slabdata     11     11      0
> signal_cache         111    165    256   15    1 : tunables  120   60    8 : slabdata     11     11      0
> sighand_cache        104    108   1344    3    1 : tunables   24   12    8 : slabdata     36     36      0
> task_struct          111    111   1280    3    1 : tunables   24   12    8 : slabdata     37     37      0
> anon_vma             635    870     12  290    1 : tunables  120   60    8 : slabdata      3      3      0
> pgd                  115    238     32  119    1 : tunables  120   60    8 : slabdata      2      2      0
> pmd                  180    180   4096    1    1 : tunables   24   12    8 : slabdata    180    180      0
> size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
> size-131072            0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
> size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
> size-65536            19     19  65536    1   16 : tunables    8    4    0 : slabdata     19     19      0
> size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
> size-32768           139    139  32768    1    8 : tunables    8    4    0 : slabdata    139    139      0
> size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0
> size-16384           151    153  16384    1    4 : tunables    8    4    0 : slabdata    151    153      0
> size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : slabdata      0      0      0
> size-8192            365    365   8192    1    2 : tunables    8    4    0 : slabdata    365    365      0
> size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    8 : slabdata      0      0      0
> size-4096            770    770   4096    1    1 : tunables   24   12    8 : slabdata    770    770     48
> size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    8 : slabdata      0      0      0
> size-2048          14460  14556   2048    2    1 : tunables   24   12    8 : slabdata   7278   7278     12
> size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    8 : slabdata      0      0      0
> size-1024            888    888   1024    4    1 : tunables   54   27    8 : slabdata    222    222     54
> size-512(DMA)          0      0    512    8    1 : tunables   54   27    8 : slabdata      0      0      0
> size-512             886   1352    512    8    1 : tunables   54   27    8 : slabdata    169    169    108
> size-256(DMA)          0      0    256   15    1 : tunables  120   60    8 : slabdata      0      0      0
> size-256             270    300    256   15    1 : tunables  120   60    8 : slabdata     20     20      0
> size-192(DMA)          0      0    192   20    1 : tunables  120   60    8 : slabdata      0      0      0
> size-192             156    180    192   20    1 : tunables  120   60    8 : slabdata      9      9      0
> size-128(DMA)          0      0    128   31    1 : tunables  120   60    8 : slabdata      0      0      0
> size-128            1921   2635    128   31    1 : tunables  120   60    8 : slabdata     85     85      0
> size-64(DMA)           0      0     64   61    1 : tunables  120   60    8 : slabdata      0      0      0
> size-64             7293  13603     64   61    1 : tunables  120   60    8 : slabdata    223    223    480
> size-32(DMA)           0      0     32  119    1 : tunables  120   60    8 : slabdata      0      0      0
> size-32            10802  19516     32  119    1 : tunables  120   60    8 : slabdata    164    164    120
> kmem_cache           160    160    192   20    1 : tunables  120   60    8 : slabdata      8      8      0
> 

