Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265195AbUFROfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265195AbUFROfx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 10:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265196AbUFROfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 10:35:53 -0400
Received: from cfcafw.sgi.com ([198.149.23.1]:8329 "EHLO omx1.americas.sgi.com")
	by vger.kernel.org with ESMTP id S265195AbUFROey (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 10:34:54 -0400
Date: Fri, 18 Jun 2004 09:33:32 -0500
From: Dimitri Sivanich <sivanich@sgi.com>
To: Andrew Morton <akpm@osdl.org>, manfred@colorfullife.com
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       linux-mm@kvack.org
Subject: Re: [PATCH]: Option to run cache reap in thread mode
Message-ID: <20040618143332.GA11056@sgi.com>
References: <40D08225.6060900@colorfullife.com> <20040616180208.GD6069@sgi.com> <40D09872.4090107@colorfullife.com> <20040617131031.GB8473@sgi.com> <20040617214035.01e38285.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040617214035.01e38285.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2004 at 09:40:35PM -0700, Andrew Morton wrote:
> Against which slab cache?  How many objects are being reaped in a single
> timer tick?

Against all of them.  See my analysis below.

> 
> It's very simple:
> 
> --- 25/mm/slab.c~a	2004-06-17 21:38:57.728796976 -0700
> +++ 25-akpm/mm/slab.c	2004-06-17 21:40:06.294373424 -0700
> @@ -2690,6 +2690,7 @@ static void drain_array_locked(kmem_cach
>  static inline void cache_reap (void)
>  {
>  	struct list_head *walk;
> +	static int max;
>  
>  #if DEBUG
>  	BUG_ON(!in_interrupt());
> @@ -2731,6 +2732,11 @@ static inline void cache_reap (void)
>  		}
>  
>  		tofree = (searchp->free_limit+5*searchp->num-1)/(5*searchp->num);
> +		if (tofree > max) {
> +			max = tofree;
> +			printk("%s: reap %d\n", searchp->name, tofree);
> +		}
> +
>  		do {
>  			p = list3_data(searchp)->slabs_free.next;
>  			if (p == &(list3_data(searchp)->slabs_free))
> _

Andrew & Manfred, here's what I think you've been looking for.  Keep in mind
that this analysis is done on an essentially unloaded system:

At the time of the holdoff (the point where we've spent a total of 30 usec in
the timer_interrupt), we've looped through more than 100 of the 131 caches,
usually closer to 120.

The maximum number of slabs to free (what Andrew indicated he wanted) is
almost always 1 or 2 at the time of the holdoff, and the same for the number
of per/cpu blocks.

The total number of slabs we've freed is usually on the order of 1-3.

The total number of per/cpu blocks freed is usually on the order of 1-5 but
as high as 15.

The total number of times we've acquired the spin_lock is usually on the
order of 5-10.

Below I've included the slabinfo for your reading pleasure.

slabinfo - version: 2.0
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <batchcount> <limit> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
ip_fib_hash           11    452     32  452    1 : tunables  120   60    8 : slabdata      1      1      0
rpc_buffers            8      8   2048    8    1 : tunables   24   12    8 : slabdata      1      1      0
rpc_tasks              8     42    384   42    1 : tunables   54   27    8 : slabdata      1      1      0
rpc_inode_cache        0      0    896   18    1 : tunables   54   27    8 : slabdata      0      0      0
unix_sock             29     84    768   21    1 : tunables   54   27    8 : slabdata      4      4      0
ip_mrt_cache           0      0    128  123    1 : tunables  120   60    8 : slabdata      0      0      0
tcp_tw_bucket          7     62    256   62    1 : tunables  120   60    8 : slabdata      1      1      0
tcp_bind_bucket       15    452     32  452    1 : tunables  120   60    8 : slabdata      1      1      0
tcp_open_request       0      0    128  123    1 : tunables  120   60    8 : slabdata      0      0      0
inet_peer_cache        3    123    128  123    1 : tunables  120   60    8 : slabdata      1      1      0
secpath_cache          0      0    256   62    1 : tunables  120   60    8 : slabdata      0      0      0
xfrm_dst_cache         0      0    384   42    1 : tunables   54   27    8 : slabdata      0      0      0
ip_dst_cache          30     84    384   42    1 : tunables   54   27    8 : slabdata      2      2      0
arp_cache              4     62    256   62    1 : tunables  120   60    8 : slabdata      1      1      0
raw4_sock              0      0    896   18    1 : tunables   54   27    8 : slabdata      0      0      0
udp_sock               3     18    896   18    1 : tunables   54   27    8 : slabdata      1      1      0
tcp_sock              28     44   1408   11    1 : tunables   24   12    8 : slabdata      4      4      0
flow_cache             0      0    128  123    1 : tunables  120   60    8 : slabdata      0      0      0
kcopyd-jobs          512    528    360   44    1 : tunables   54   27    8 : slabdata     12     12      0
dm_tio                 0      0     24  581    1 : tunables  120   60    8 : slabdata      0      0      0
dm_io                  0      0     32  452    1 : tunables  120   60    8 : slabdata      0      0      0
scsi_cmd_cache        34    124    512   31    1 : tunables   54   27    8 : slabdata      4      4      1
qla2xxx_srbs           0      0    256   62    1 : tunables  120   60    8 : slabdata      0      0      0
dm_session             0      0    416   38    1 : tunables   54   27    8 : slabdata      0      0      0
dm_fsreg               0      0    336   48    1 : tunables   54   27    8 : slabdata      0      0      0
dm_tokdata             0      0     72  214    1 : tunables  120   60    8 : slabdata      0      0      0
xfs_acl                0      0    304   53    1 : tunables   54   27    8 : slabdata      0      0      0
xfs_chashlist        944   1356     32  452    1 : tunables  120   60    8 : slabdata      3      3      0
xfs_ili              137    332    192   83    1 : tunables  120   60    8 : slabdata      4      4      0
xfs_ifork              0      0     64  240    1 : tunables  120   60    8 : slabdata      0      0      0
xfs_efi_item           0      0    352   45    1 : tunables   54   27    8 : slabdata      0      0      0
xfs_efd_item           0      0    360   44    1 : tunables   54   27    8 : slabdata      0      0      0
xfs_buf_item           6    172    184   86    1 : tunables  120   60    8 : slabdata      2      2      0
xfs_dabuf             16    581     24  581    1 : tunables  120   60    8 : slabdata      1      1      0
xfs_da_state          16     33    488   33    1 : tunables   54   27    8 : slabdata      1      1      0
xfs_trans              1     72    872   18    1 : tunables   54   27    8 : slabdata      1      4      0
xfs_inode          19458  19560    528   30    1 : tunables   54   27    8 : slabdata    652    652      0
xfs_btree_cur         16     83    192   83    1 : tunables  120   60    8 : slabdata      1      1      0
xfs_bmap_free_item      0      0     24  581    1 : tunables  120   60    8 : slabdata      0      0      0
xfs_buf_t             36    217    512   31    1 : tunables   54   27    8 : slabdata      7      7      2
linvfs_icache      19472  19488    768   21    1 : tunables   54   27    8 : slabdata    928    928      0
nfs_write_data        36     42    768   21    1 : tunables   54   27    8 : slabdata      2      2      0
nfs_read_data         32     42    768   21    1 : tunables   54   27    8 : slabdata      2      2      0
nfs_inode_cache        0      0   1024   15    1 : tunables   54   27    8 : slabdata      0      0      0
nfs_page               0      0    256   62    1 : tunables  120   60    8 : slabdata      0      0      0
isofs_inode_cache      0      0    640   25    1 : tunables   54   27    8 : slabdata      0      0      0
fat_inode_cache        0      0    768   21    1 : tunables   54   27    8 : slabdata      0      0      0
hugetlbfs_inode_cache      1     21    768   21    1 : tunables   54   27    8 : slabdata      1      1      0
ext2_inode_cache       0      0    768   21    1 : tunables   54   27    8 : slabdata      0      0      0
ext2_xattr             0      0     88  177    1 : tunables  120   60    8 : slabdata      0      0      0
journal_handle         0      0     48  312    1 : tunables  120   60    8 : slabdata      0      0      0
journal_head           0      0     88  177    1 : tunables  120   60    8 : slabdata      0      0      0
revoke_table           0      0     16  816    1 : tunables  120   60    8 : slabdata      0      0      0
revoke_record          0      0     32  452    1 : tunables  120   60    8 : slabdata      0      0      0
ext3_inode_cache       0      0    896   18    1 : tunables   54   27    8 : slabdata      0      0      0
ext3_xattr             0      0     88  177    1 : tunables  120   60    8 : slabdata      0      0      0
dquot                  0      0    256   62    1 : tunables  120   60    8 : slabdata      0      0      0
eventpoll_pwq          0      0     72  214    1 : tunables  120   60    8 : slabdata      0      0      0
eventpoll_epi          0      0    256   62    1 : tunables  120   60    8 : slabdata      0      0      0
kioctx                 0      0    384   42    1 : tunables   54   27    8 : slabdata      0      0      0
kiocb                  0      0    512   31    1 : tunables   54   27    8 : slabdata      0      0      0
dnotify_cache          0      0     40  371    1 : tunables  120   60    8 : slabdata      0      0      0
file_lock_cache        2    188    168   94    1 : tunables  120   60    8 : slabdata      2      2      0
fasync_cache           0      0     24  581    1 : tunables  120   60    8 : slabdata      0      0      0
shared_policy_node      0      0     56  272    1 : tunables  120   60    8 : slabdata      0      0      0
numa_policy            0      0     40  371    1 : tunables  120   60    8 : slabdata      0      0      0
shmem_inode_cache      4     18    896   18    1 : tunables   54   27    8 : slabdata      1      1      0
posix_timers_cache      0      0    144  110    1 : tunables  120   60    8 : slabdata      0      0      0
uid_cache              4    240     64  240    1 : tunables  120   60    8 : slabdata      1      1      0
sgpool-128            32     32   4096    4    1 : tunables   24   12    8 : slabdata      8      8      0
sgpool-64             32     32   2048    8    1 : tunables   24   12    8 : slabdata      4      4      0
sgpool-32             32     45   1024   15    1 : tunables   54   27    8 : slabdata      3      3      0
sgpool-16             32     62    512   31    1 : tunables   54   27    8 : slabdata      2      2      0
sgpool-8             141    310    256   62    1 : tunables  120   60    8 : slabdata      5      5      1
cfq_pool             145    272     56  272    1 : tunables  120   60    8 : slabdata      1      1      0
crq_pool             129    428     72  214    1 : tunables  120   60    8 : slabdata      2      2      7
deadline_drq           0      0     96  162    1 : tunables  120   60    8 : slabdata      0      0      0
as_arq                 0      0    112  140    1 : tunables  120   60    8 : slabdata      0      0      0
blkdev_requests       65    180    264   60    1 : tunables   54   27    8 : slabdata      3      3      4
biovec-BIO_MAX_PAGES    256    256   4096    4    1 : tunables   24   12    8 : slabdata     64     64      0
biovec-128           256    256   2048    8    1 : tunables   24   12    8 : slabdata     32     32      0
biovec-64            256    270   1024   15    1 : tunables   54   27    8 : slabdata     18     18      0
biovec-16            256    310    256   62    1 : tunables  120   60    8 : slabdata      5      5      0
biovec-4             256    480     64  240    1 : tunables  120   60    8 : slabdata      2      2      0
biovec-1             334    816     16  816    1 : tunables  120   60    8 : slabdata      1      1      1
bio                  340    615    128  123    1 : tunables  120   60    8 : slabdata      5      5      3
sock_inode_cache      69     84    768   21    1 : tunables   54   27    8 : slabdata      4      4      0
skbuff_head_cache    414    462    384   42    1 : tunables   54   27    8 : slabdata     11     11      0
sock                   3     50    640   25    1 : tunables   54   27    8 : slabdata      2      2      0
proc_inode_cache    1112   1200    640   25    1 : tunables   54   27    8 : slabdata     48     48      0
sigqueue             170    297    160   99    1 : tunables  120   60    8 : slabdata      3      3      0
radix_tree_node     1063   1110    536   30    1 : tunables   54   27    8 : slabdata     37     37      0
bdev_cache             4     18    896   18    1 : tunables   54   27    8 : slabdata      1      1      0
mnt_cache             35    123    128  123    1 : tunables  120   60    8 : slabdata      1      1      0
inode_cache         2347   2400    640   25    1 : tunables   54   27    8 : slabdata     96     96      0
dentry_cache       24571  24614    256   62    1 : tunables  120   60    8 : slabdata    397    397      0
filp                 760    868    256   62    1 : tunables  120   60    8 : slabdata     14     14      0
names_cache           51     68   4096    4    1 : tunables   24   12    8 : slabdata     17     17     18
idr_layer_cache       26     30    528   30    1 : tunables   54   27    8 : slabdata      1      1      0
buffer_head          464    648     96  162    1 : tunables  120   60    8 : slabdata      4      4      0
mm_struct            136    195   1024   15    1 : tunables   54   27    8 : slabdata     13     13      0
vm_area_struct      1933   2070    176   90    1 : tunables  120   60    8 : slabdata     23     23    224
fs_cache             111    480     64  240    1 : tunables  120   60    8 : slabdata      2      2      0
files_cache           75    180    896   18    1 : tunables   54   27    8 : slabdata     10     10      0
signal_cache         171    369    128  123    1 : tunables  120   60    8 : slabdata      3      3      0
sighand_cache        125    135   1664    9    1 : tunables   24   12    8 : slabdata     15     15      0
anon_vma             944   1162     24  581    1 : tunables  120   60    8 : slabdata      2      2      0
size-131072(DMA)       0      0 131072    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-131072            0      0 131072    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-65536(DMA)        0      0  65536    1    4 : tunables    8    4    0 : slabdata      0      0      0
size-65536             0      0  65536    1    4 : tunables    8    4    0 : slabdata      0      0      0
size-32768(DMA)        0      0  32768    1    2 : tunables    8    4    0 : slabdata      0      0      0
size-32768             9      9  32768    1    2 : tunables    8    4    0 : slabdata      9      9      0
size-16384(DMA)        0      0  16384    1    1 : tunables   24   12    8 : slabdata      0      0      0
size-16384            12     12  16384    1    1 : tunables   24   12    8 : slabdata     12     12      0
size-8192(DMA)         0      0   8192    2    1 : tunables   24   12    8 : slabdata      0      0      0
size-8192             33     34   8192    2    1 : tunables   24   12    8 : slabdata     17     17      0
size-4096(DMA)         0      0   4096    4    1 : tunables   24   12    8 : slabdata      0      0      0
size-4096            197    236   4096    4    1 : tunables   24   12    8 : slabdata     59     59      0
size-2048(DMA)         0      0   2048    8    1 : tunables   24   12    8 : slabdata      0      0      0
size-2048            339    368   2048    8    1 : tunables   24   12    8 : slabdata     46     46      0
size-1024(DMA)         0      0   1024   15    1 : tunables   54   27    8 : slabdata      0      0      0
size-1024            418    465   1024   15    1 : tunables   54   27    8 : slabdata     31     31      0
size-512(DMA)          0      0    512   31    1 : tunables   54   27    8 : slabdata      0      0      0
size-512             863    868    512   31    1 : tunables   54   27    8 : slabdata     28     28      0
size-256(DMA)          0      0    256   62    1 : tunables  120   60    8 : slabdata      0      0      0
size-256            1672   1674    256   62    1 : tunables  120   60    8 : slabdata     27     27      0
size-128(DMA)          0      0    128  123    1 : tunables  120   60    8 : slabdata      0      0      0
size-128             585    738    128  123    1 : tunables  120   60    8 : slabdata      6      6      0
size-64(DMA)           0      0     64  240    1 : tunables  120   60    8 : slabdata      0      0      0
size-64             4001   4080     64  240    1 : tunables  120   60    8 : slabdata     17     17      0
kmem_cache           148    154    704   22    1 : tunables   54   27    8 : slabdata      7      7      0
