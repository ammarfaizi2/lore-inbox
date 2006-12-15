Return-Path: <linux-kernel-owner+w=401wt.eu-S1753314AbWLOTo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753314AbWLOTo6 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 14:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753317AbWLOTo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 14:44:58 -0500
Received: from pat.uio.no ([129.240.10.15]:56171 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753314AbWLOTo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 14:44:57 -0500
Subject: Re: 2.6.18 mmap hangs unrelated apps
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Michal Sabala <lkml@saahbs.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061215175030.GG6220@prosiaczek>
References: <20061215023014.GC2721@prosiaczek>
	 <1166199855.5761.34.camel@lade.trondhjem.org>
	 <20061215175030.GG6220@prosiaczek>
Content-Type: text/plain
Date: Fri, 15 Dec 2006 14:44:44 -0500
Message-Id: <1166211884.5761.49.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.172, required 12,
	autolearn=disabled, AWL 1.69, RCVD_IN_SORBS_DUL 0.14,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-15 at 11:50 -0600, Michal Sabala wrote:
> On 2006/12/15 at 10:24:15 Trond Myklebust <trond.myklebust@fys.uio.no> wrote
> > On Thu, 2006-12-14 at 20:30 -0600, Michal Sabala wrote:
> > > 
> > > `cat /proc/*PID*/wchan` for all hanging processes contains page_sync.
> > 
> > Have you tried an 'echo t >/proc/sysrq-trigger' on a client with one of
> > these hanging processes? If so, what does the output look like?
> 
> Hello Trond,
> 
> Below is the sysrq trace output for XFree86 which entered the
> uninterruptible sleep state on the P4 machine with nfs /home. Please
> note that XFree86 does not have any files open in /home - as reported by
> `lsof`. Below, I also listed the output of vmstat.


It is hanging because it is trying to free up memory by reclaiming pages
that are held by your mmapped file on NFS. Do you know why NFS is
hanging?

Cheers
  Trond

> XFree86       D 00000003     0  2471   2453                     (NOTLB)
>        c4871c0c 00003082 c86b72bc 00000003 cb7c94a4 0000001d 3b67f3ff c0146dd2 
>        c1184180 cb3e7110 00000000 001ec7ff a60f8097 00000089 c02e1e60 cb3e7000 
>        c1184180 00000000 c1180030 c4871c18 c028c7d8 c4871c5c c01435b6 c01435f3 
> Call Trace:
>  [<c0146dd2>] free_pages_bulk+0x1d/0x1d4
>  [<c028c7d8>] io_schedule+0x26/0x30
>  [<c01435b6>] sync_page+0x0/0x40
>  [<c01435f3>] sync_page+0x3d/0x40
>  [<c028c9ce>] __wait_on_bit_lock+0x2c/0x52
>  [<c0143c13>] __lock_page+0x6a/0x72
>  [<c012ec77>] wake_bit_function+0x0/0x3c
>  [<c012ec77>] wake_bit_function+0x0/0x3c
>  [<c0149d2f>] pagevec_lookup+0x17/0x1d
>  [<c014a085>] truncate_inode_pages_range+0x20a/0x260
>  [<c014a0e4>] truncate_inode_pages+0x9/0xc
>  [<c0172c8a>] generic_delete_inode+0xb6/0x10f
>  [<c0172e73>] iput+0x5f/0x61
>  [<c01706bd>] dentry_iput+0x68/0x83
>  [<c01707d8>] dput+0x100/0x118
>  [<ccb6c334>] put_nfs_open_context+0x67/0x88 [nfs]
>  [<ccb701ed>] nfs_release_request+0x38/0x47 [nfs]
>  [<ccb736dd>] nfs_wait_on_requests_locked+0x62/0x98 [nfs]
>  [<ccb74c32>] nfs_sync_inode_wait+0x4a/0x130 [nfs]
>  [<ccb6b639>] nfs_release_page+0x0/0x30 [nfs]
>  [<ccb6b655>] nfs_release_page+0x1c/0x30 [nfs]
>  [<c015f37c>] try_to_release_page+0x34/0x46
>  [<c014aa8b>] shrink_page_list+0x263/0x350
>  [<c0104db8>] do_IRQ+0x48/0x50
>  [<c01036c6>] common_interrupt+0x1a/0x20
>  [<c014acd7>] shrink_inactive_list+0x9b/0x248
>  [<c014b2fd>] shrink_zone+0xb5/0xd0
>  [<c014b382>] shrink_zones+0x6a/0x7e
>  [<c014b48e>] try_to_free_pages+0xf8/0x1da
>  [<c0147a18>] __alloc_pages+0x17c/0x278
>  [<c014f555>] do_anonymous_page+0x45/0x150
>  [<c014f9f7>] __handle_mm_fault+0xda/0x1bf
>  [<c0115849>] do_page_fault+0x1c4/0x4bc
>  [<c01021b7>] restore_sigcontext+0x10c/0x15f
>  [<c0115685>] do_page_fault+0x0/0x4bc
>  [<c0103809>] error_code+0x39/0x40
> 
> 
> 
> 
> $> vmstat
> procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
>  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
>  2  1      0  82128  11484  36096    0    0    12    21  311   287  8  3  0 89
> 
> $> vmstat -m
> Cache                       Num  Total   Size  Pages
> nfs_direct_cache              0      0     76     50
> nfs_write_data               36     91    512      7
> nfs_read_data                32     35    512      7
> nfs_inode_cache              28    108    648      6
> nfs_page                      1     59     64     59
> rpc_buffers                   8      8   2048      2
> rpc_tasks                     8     15    256     15
> rpc_inode_cache               8     14    512      7
> fib6_nodes                    5    113     32    113
> ip6_dst_cache                 4     15    256     15
> ndisc_cache                   1     15    256     15
> RAWv6                         4      6    640      6
> UDPv6                         1      6    640      6
> tw_sock_TCPv6                 0      0    128     30
> request_sock_TCPv6            0      0    128     30
> TCPv6                         2      3   1280      3
> ip_conntrack_expect           0      0     96     40
> ip_conntrack                 13     68    224     17
> ip_fib_alias                  9    113     32    113
> ip_fib_hash                   9    113     32    113
> jbd_4k                        0      0   4096      1
> Cache                       Num  Total   Size  Pages
> ext3_inode_cache          12284  25352    504      8
> ext3_xattr                    0      0     48     78
> journal_handle                2    169     20    169
> journal_head                 85    504     52     72
> revoke_table                  2    254     12    254
> revoke_record                 0      0     16    203
> uhci_urb_priv                 1    127     28    127
> clip_arp_cache                0      0    256     15
> UNIX                         46    133    512      7
> flow_cache                    0      0    128     30
> cfq_ioc_pool                 29     84     92     42
> cfq_pool                     27     80     96     40
> crq_pool                     20     84     44     84
> deadline_drq                  0      0     44     84
> as_arq                        0      0     56     67
> mqueue_inode_cache            1      6    640      6
> dnotify_cache                 0      0     20    169
> dquot                         0      0    128     30
> eventpoll_pwq                 0      0     36    101
> eventpoll_epi                 0      0    128     30
> inotify_event_cache           0      0     28    127
> Cache                       Num  Total   Size  Pages
> inotify_watch_cache           1     92     40     92
> kioctx                        0      0    256     15
> kiocb                         0      0    128     30
> fasync_cache                  2    203     16    203
> shmem_inode_cache           452    459    448      9
> posix_timers_cache            0      0     88     44
> uid_cache                     3     59     64     59
> ip_mrt_cache                  0      0    128     30
> tcp_bind_bucket              12    203     16    203
> inet_peer_cache               4     59     64     59
> secpath_cache                 0      0     32    113
> xfrm_dst_cache                0      0    384     10
> ip_dst_cache                 18     45    256     15
> arp_cache                     3     15    256     15
> RAW                           2      7    512      7
> UDP                           9     14    512      7
> tw_sock_TCP                   0      0    128     30
> request_sock_TCP              0      0     64     59
> TCP                          12     21   1152      7
> blkdev_ioc                   29    127     28    127
> blkdev_queue                 19     20    956      4
> Cache                       Num  Total   Size  Pages
> blkdev_requests              17     23    172     23
> biovec-256                    7      8   3072      2
> biovec-128                    7     10   1536      5
> biovec-64                     7     10    768      5
> biovec-16                     7     15    256     15
> biovec-4                      7     59     64     59
> biovec-1                     51    203     16    203
> bio                         276    300    128     30
> sock_inode_cache             73    154    512      7
> skbuff_fclone_cache           1     10    384     10
> skbuff_head_cache           459    615    256     15
> file_lock_cache              40     40     96     40
> Acpi-Operand                699    736     40     92
> Acpi-ParseExt                 0      0     44     84
> Acpi-Parse                    0      0     28    127
> Acpi-State                    0      0     44     84
> Acpi-Namespace              319    338     20    169
> proc_inode_cache           1218   1310    368     10
> sigqueue                     16     27    144     27
> radix_tree_node             989   2576    276     14
> bdev_cache                    4      7    512      7
> Cache                       Num  Total   Size  Pages
> sysfs_dir_cache            3656   3696     44     84
> mnt_cache                    25     30    128     30
> inode_cache                 724    869    352     11
> dentry_cache               8164  26100    132     29
> filp                        693   1840    192     20
> names_cache                   1      1   4096      1
> key_jar                       6     30    128     30
> idr_layer_cache             100    116    136     29
> buffer_head                3614   6192     52     72
> mm_struct                    54     81    448      9
> vm_area_struct             1272   2576     84     46
> fs_cache                     72    118     64     59
> files_cache                 102    135    256     15
> signal_cache                 55     90    384     10
> sighand_cache                66     66   1344      3
> task_struct                  68     87   1360      3
> anon_vma                    647   1524     12    254
> pgd                          40     40   4096      1
> pid                          65    202     36    101
> size-131072(DMA)              0      0 131072      1
> size-131072                   0      0 131072      1
> Cache                       Num  Total   Size  Pages
> size-65536(DMA)               0      0  65536      1
> size-65536                    1      1  65536      1
> size-32768(DMA)               0      0  32768      1
> size-32768                    0      0  32768      1
> size-16384(DMA)               0      0  16384      1
> size-16384                    0      0  16384      1
> size-8192(DMA)                0      0   8192      1
> size-8192                    67     69   8192      1
> size-4096(DMA)                0      0   4096      1
> size-4096                    33     33   4096      1
> size-2048(DMA)                0      0   2048      2
> size-2048                   503    534   2048      2
> size-1024(DMA)                0      0   1024      4
> size-1024                   197    208   1024      4
> size-512(DMA)                 0      0    512      8
> size-512                    241    296    512      8
> size-256(DMA)                 0      0    256     15
> size-256                     72     90    256     15
> size-192(DMA)                 0      0    192     20
> size-192                    308    320    192     20
> size-128(DMA)                 0      0    128     30
> Cache                       Num  Total   Size  Pages
> size-128                    455    480    128     30
> size-96(DMA)                  0      0    128     30
> size-96                     672    720    128     30
> size-64(DMA)                  0      0     64     59
> size-32(DMA)                  0      0     32    113
> size-64                     946   1357     64     59
> size-32                    2424   2599     32    113
> kmem_cache                  133    150    128     30
> 
> 
> Thanks, Michal
> 

