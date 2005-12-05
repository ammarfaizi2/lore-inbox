Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932456AbVLEQCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbVLEQCM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 11:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbVLEQCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 11:02:12 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:35995
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S932459AbVLEQCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 11:02:11 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 0/4] linux-2.6-block: deactivating pagecache for benchmarks
Date: Sun, 4 Dec 2005 20:13:12 -0600
User-Agent: KMail/1.8
Cc: Dirk Henning Gerdes <mail@dirk-gerdes.de>, axboe@suse.de,
       linux-kernel@vger.kernel.org
References: <1133443051.6110.32.camel@noti> <20051201172520.7095e524.akpm@osdl.org>
In-Reply-To: <20051201172520.7095e524.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512042013.13214.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 December 2005 19:25, Andrew Morton wrote:
> Dirk Henning Gerdes <mail@dirk-gerdes.de> wrote:
> >  For doing benchmarks on the I/O-Schedulers, I thought it would be very
> >  useful to disable the pagecache.
>
> That's an FAQ.   Something like this?
>
>
> From: Andrew Morton <akpm@osdl.org>
>
> Add /proc/sys/vm/drop-pagecache.  When written to, this will cause the
> kernel to discard as much pagecache and reclaimable slab objects as it can.
>
> It won't drop dirty data, so the user should run `sync' first.

This is deeply, deeply cool.

> Caveats:
>
> a) Holds inode_lock for exorbitant amounts of time.

Voluntary preemption point, maybe?

> b) Needs to be taught about NUMA nodes: propagate these all the way through
>    so the discarding can be controlled on a per-node basis.
>
> c) The pagecache shrinking and slab shrinking should probably have separate
>    controls.

It could care about _what_ you write to it, maybe?  (The first byte, 
anyway...)

>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
>
>  fs/Makefile            |    2 -
>  fs/drop-pagecache.c    |   62
> +++++++++++++++++++++++++++++++++++++++++++++++++ include/linux/mm.h     | 
>   5 +++
>  include/linux/sysctl.h |    1
>  kernel/sysctl.c        |    9 +++++++
>  mm/truncate.c          |    1
>  mm/vmscan.c            |    3 --
>  7 files changed, 79 insertions(+), 4 deletions(-)
>
> diff -puN /dev/null fs/drop-pagecache.c
> --- /dev/null 2003-09-15 06:40:47.000000000 -0700
> +++ devel-akpm/fs/drop-pagecache.c 2005-12-01 17:20:55.000000000 -0800
> @@ -0,0 +1,62 @@
> +/*
> + * Implement the manual drop-all-pagecache function
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/mm.h>
> +#include <linux/fs.h>
> +#include <linux/writeback.h>
> +#include <linux/sysctl.h>
> +#include <linux/gfp.h>
> +
> +static void drop_pagecache_sb(struct super_block *sb)
> +{
> + struct inode *inode;
> +
> + spin_lock(&inode_lock);
> + list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
> +  if (inode->i_state & (I_FREEING|I_WILL_FREE))
> +   continue;
> +  invalidate_inode_pages(inode->i_mapping);
> + }
> + spin_unlock(&inode_lock);
> +}
> +
> +static void drop_pagecache(void)
> +{
> + struct super_block *sb;
> +
> + spin_lock(&sb_lock);
> +restart:
> + list_for_each_entry(sb, &super_blocks, s_list) {
> +  sb->s_count++;
> +  spin_unlock(&sb_lock);
> +  down_read(&sb->s_umount);
> +  if (sb->s_root)
> +   drop_pagecache_sb(sb);
> +  up_read(&sb->s_umount);
> +  spin_lock(&sb_lock);
> +  if (__put_super_and_need_restart(sb))
> +   goto restart;
> + }
> + spin_unlock(&sb_lock);
> + printk("shrunk pagecache\n");
> +}
> +
> +static void drop_slab(void)
> +{
> + int nr_objects;
> +
> + do {
> +  nr_objects = shrink_slab(1000, GFP_KERNEL, 1000);
> +  printk("shrunk %d cache objects\n", nr_objects);
> + } while (nr_objects > 10);
> +}
> +
> +int drop_pagecache_sysctl_handler(ctl_table *table, int write,
> + struct file *file, void __user *buffer, size_t *length, loff_t *ppos)
> +{
> + drop_pagecache();
> + drop_slab();
> + return 0;
> +}
> diff -puN fs/Makefile~drop-pagecache fs/Makefile
> --- devel/fs/Makefile~drop-pagecache 2005-12-01 16:41:22.000000000 -0800
> +++ devel-akpm/fs/Makefile 2005-12-01 16:41:22.000000000 -0800
> @@ -10,7 +10,7 @@ obj-y := open.o read_write.o file_table.
>    ioctl.o readdir.o select.o fifo.o locks.o dcache.o inode.o \
>    attr.o bad_inode.o file.o filesystems.o namespace.o aio.o \
>    seq_file.o xattr.o libfs.o fs-writeback.o mpage.o direct-io.o \
> -  ioprio.o pnode.o
> +  ioprio.o pnode.o drop-pagecache.o
>
>  obj-$(CONFIG_INOTIFY)  += inotify.o
>  obj-$(CONFIG_EPOLL)  += eventpoll.o
> diff -puN include/linux/mm.h~drop-pagecache include/linux/mm.h
> --- devel/include/linux/mm.h~drop-pagecache 2005-12-01 16:41:22.000000000
> -0800 +++ devel-akpm/include/linux/mm.h 2005-12-01 17:01:57.000000000 -0800
> @@ -1078,5 +1078,10 @@ int in_gate_area_no_task(unsigned long a
>  /* /proc/<pid>/oom_adj set to -17 protects from the oom-killer */
>  #define OOM_DISABLE -17
>
> +int drop_pagecache_sysctl_handler(struct ctl_table *, int, struct file *,
> +     void __user *, size_t *, loff_t *);
> +int shrink_slab(unsigned long scanned, gfp_t gfp_mask,
> +   unsigned long lru_pages);
> +
>  #endif /* __KERNEL__ */
>  #endif /* _LINUX_MM_H */
> diff -puN include/linux/sysctl.h~drop-pagecache include/linux/sysctl.h
> --- devel/include/linux/sysctl.h~drop-pagecache 2005-12-01
> 16:41:22.000000000 -0800 +++ devel-akpm/include/linux/sysctl.h 2005-12-01
> 16:41:22.000000000 -0800 @@ -182,6 +182,7 @@ enum
>   VM_LEGACY_VA_LAYOUT=27, /* legacy/compatibility virtual address space
> layout */ VM_SWAP_TOKEN_TIMEOUT=28, /* default time for token time out */
>   VM_SWAP_PREFETCH=29, /* int: amount to swap prefetch */
> + VM_DROP_PAGECACHE=30, /* int: nuke lots of pagecache */
>  };
>
>
> diff -puN kernel/sysctl.c~drop-pagecache kernel/sysctl.c
> --- devel/kernel/sysctl.c~drop-pagecache 2005-12-01 16:41:22.000000000
> -0800 +++ devel-akpm/kernel/sysctl.c 2005-12-01 16:41:22.000000000 -0800 @@
> -783,6 +783,15 @@ static ctl_table vm_table[] = {
>    .strategy = &sysctl_intvec,
>   },
>   {
> +  .ctl_name = VM_DROP_PAGECACHE,
> +  .procname = "drop-pagecache",
> +  .data  = NULL,
> +  .maxlen  = sizeof(int),
> +  .mode  = 0644,

So what _does_ it do when you read from it?

> +  .proc_handler = drop_pagecache_sysctl_handler,
> +  .strategy = &sysctl_intvec,
> + },
> + {
>    .ctl_name = VM_MIN_FREE_KBYTES,
>    .procname = "min_free_kbytes",
>    .data  = &min_free_kbytes,
> diff -puN mm/truncate.c~drop-pagecache mm/truncate.c
> --- devel/mm/truncate.c~drop-pagecache 2005-12-01 16:49:06.000000000 -0800
> +++ devel-akpm/mm/truncate.c 2005-12-01 16:49:13.000000000 -0800
> @@ -256,7 +256,6 @@ unlock:
>      break;
>    }
>    pagevec_release(&pvec);
> -  cond_resched();

Why drop that line?  (I don't follow...)

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.
