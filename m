Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965143AbVL2JyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965143AbVL2JyM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 04:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965144AbVL2JyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 04:54:12 -0500
Received: from nproxy.gmail.com ([64.233.182.207]:25627 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965143AbVL2JyL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 04:54:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gNvWOxM3PkIeypSnWxBbMPa70s40grBjUr8ZZATjdxYd+xYn6Xwx6jqX51v++SNWktGkIeqLD4apB6E7ejQdqEI4FUWFNDDdRw+8LFZtSaoVkJDX7XWI72BYQrnBgr5vG0vnwovRKiCgZ7o16jY6QxGIcXRCEUmTB5+5E36IgLM=
Message-ID: <2cd57c900512290154k12a2265cx@mail.gmail.com>
Date: Thu, 29 Dec 2005 17:54:08 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: + drop-pagecache.patch added to -mm tree
Cc: akpm@osdl.org
In-Reply-To: <200512020130.jB21UWpS019783@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200512020130.jB21UWpS019783@shell0.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/12/2, akpm@osdl.org <akpm@osdl.org>:
>
> The patch titled
>
>      drop-pagecache
>
> has been added to the -mm tree.  Its filename is
>
>      drop-pagecache.patch
>
>
> From: Andrew Morton <akpm@osdl.org>
>
> Add /proc/sys/vm/drop-pagecache.  When written to, this will cause the kernel
> to discard as much pagecache and reclaimable slab objects as it can.
>
> It won't drop dirty data, so the user should run `sync' first.
>
> Caveats:
>
> a) Holds inode_lock for exorbitant amounts of time.
>
> b) Needs to be taught about NUMA nodes: propagate these all the way through
>    so the discarding can be controlled on a per-node basis.
>
> c) The pagecache shrinking and slab shrinking should probably have separate
>    controls.

Yes. Let /proc/sys/vm/drop-pagecache for pagecache shrinking only and
add another /proc/sys/vm/drop-slab for slab shrinking.

>
>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
>
>  fs/Makefile            |    2 -
>  fs/drop-pagecache.c    |   62 +++++++++++++++++++++++++++++++++++++++++++++++++

I'd rather have drop-pagecache.c stay in mm/. Fix mm/Makefile and do
not touch fs/ at all.

-- Coywolf

>  include/linux/mm.h     |    5 +++
>  include/linux/sysctl.h |    1
>  kernel/sysctl.c        |    9 +++++++
>  mm/truncate.c          |    1
>  mm/vmscan.c            |    3 --
>  7 files changed, 79 insertions(+), 4 deletions(-)
>
> diff -puN /dev/null fs/drop-pagecache.c
> --- /dev/null   2003-09-15 06:40:47.000000000 -0700
> +++ devel-akpm/fs/drop-pagecache.c      2005-12-01 17:30:18.000000000 -0800
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
> +       struct inode *inode;
> +
> +       spin_lock(&inode_lock);
> +       list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
> +               if (inode->i_state & (I_FREEING|I_WILL_FREE))
> +                       continue;
> +               invalidate_inode_pages(inode->i_mapping);
> +       }
> +       spin_unlock(&inode_lock);
> +}
> +
> +static void drop_pagecache(void)
> +{
> +       struct super_block *sb;
> +
> +       spin_lock(&sb_lock);
> +restart:
> +       list_for_each_entry(sb, &super_blocks, s_list) {
> +               sb->s_count++;
> +               spin_unlock(&sb_lock);
> +               down_read(&sb->s_umount);
> +               if (sb->s_root)
> +                       drop_pagecache_sb(sb);
> +               up_read(&sb->s_umount);
> +               spin_lock(&sb_lock);
> +               if (__put_super_and_need_restart(sb))
> +                       goto restart;
> +       }
> +       spin_unlock(&sb_lock);
> +       printk("shrunk pagecache\n");
> +}
> +
> +static void drop_slab(void)
> +{
> +       int nr_objects;
> +
> +       do {
> +               nr_objects = shrink_slab(1000, GFP_KERNEL, 1000);
> +               printk("shrunk %d cache objects\n", nr_objects);
> +       } while (nr_objects > 10);
> +}
> +
> +int drop_pagecache_sysctl_handler(ctl_table *table, int write,
> +       struct file *file, void __user *buffer, size_t *length, loff_t *ppos)
> +{
> +       drop_pagecache();
> +       drop_slab();
> +       return 0;
> +}
> diff -puN fs/Makefile~drop-pagecache fs/Makefile
> --- devel/fs/Makefile~drop-pagecache    2005-12-01 17:30:18.000000000 -0800
> +++ devel-akpm/fs/Makefile      2005-12-01 17:30:18.000000000 -0800
> @@ -10,7 +10,7 @@ obj-y :=      open.o read_write.o file_table.
>                 ioctl.o readdir.o select.o fifo.o locks.o dcache.o inode.o \
>                 attr.o bad_inode.o file.o filesystems.o namespace.o aio.o \
>                 seq_file.o xattr.o libfs.o fs-writeback.o mpage.o direct-io.o \
> -               ioprio.o pnode.o
> +               ioprio.o pnode.o drop-pagecache.o
>
>  obj-$(CONFIG_INOTIFY)          += inotify.o
>  obj-$(CONFIG_EPOLL)            += eventpoll.o
> diff -puN include/linux/mm.h~drop-pagecache include/linux/mm.h
> --- devel/include/linux/mm.h~drop-pagecache     2005-12-01 17:30:18.000000000 -0800
> +++ devel-akpm/include/linux/mm.h       2005-12-01 17:30:18.000000000 -0800
> @@ -1078,5 +1078,10 @@ int in_gate_area_no_task(unsigned long a
>  /* /proc/<pid>/oom_adj set to -17 protects from the oom-killer */
>  #define OOM_DISABLE -17
>
> +int drop_pagecache_sysctl_handler(struct ctl_table *, int, struct file *,
> +                                       void __user *, size_t *, loff_t *);
> +int shrink_slab(unsigned long scanned, gfp_t gfp_mask,
> +                       unsigned long lru_pages);
> +
>  #endif /* __KERNEL__ */
>  #endif /* _LINUX_MM_H */
> diff -puN include/linux/sysctl.h~drop-pagecache include/linux/sysctl.h
> --- devel/include/linux/sysctl.h~drop-pagecache 2005-12-01 17:30:18.000000000 -0800
> +++ devel-akpm/include/linux/sysctl.h   2005-12-01 17:30:18.000000000 -0800
> @@ -182,6 +182,7 @@ enum
>         VM_LEGACY_VA_LAYOUT=27, /* legacy/compatibility virtual address space layout */
>         VM_SWAP_TOKEN_TIMEOUT=28, /* default time for token time out */
>         VM_SWAP_PREFETCH=29,    /* int: amount to swap prefetch */
> +       VM_DROP_PAGECACHE=30,   /* int: nuke lots of pagecache */
>  };
>
>
> diff -puN kernel/sysctl.c~drop-pagecache kernel/sysctl.c
> --- devel/kernel/sysctl.c~drop-pagecache        2005-12-01 17:30:18.000000000 -0800
> +++ devel-akpm/kernel/sysctl.c  2005-12-01 17:30:18.000000000 -0800
> @@ -783,6 +783,15 @@ static ctl_table vm_table[] = {
>                 .strategy       = &sysctl_intvec,
>         },
>         {
> +               .ctl_name       = VM_DROP_PAGECACHE,
> +               .procname       = "drop-pagecache",
> +               .data           = NULL,
> +               .maxlen         = sizeof(int),
> +               .mode           = 0644,
> +               .proc_handler   = drop_pagecache_sysctl_handler,
> +               .strategy       = &sysctl_intvec,
> +       },
> +       {
>                 .ctl_name       = VM_MIN_FREE_KBYTES,
>                 .procname       = "min_free_kbytes",
>                 .data           = &min_free_kbytes,
> diff -puN mm/truncate.c~drop-pagecache mm/truncate.c
> --- devel/mm/truncate.c~drop-pagecache  2005-12-01 17:30:18.000000000 -0800
> +++ devel-akpm/mm/truncate.c    2005-12-01 17:30:18.000000000 -0800
> @@ -256,7 +256,6 @@ unlock:
>                                 break;
>                 }
>                 pagevec_release(&pvec);
> -               cond_resched();
>         }
>         return ret;
>  }
> diff -puN mm/vmscan.c~drop-pagecache mm/vmscan.c
> --- devel/mm/vmscan.c~drop-pagecache    2005-12-01 17:30:18.000000000 -0800
> +++ devel-akpm/mm/vmscan.c      2005-12-01 17:30:18.000000000 -0800
> @@ -181,8 +181,7 @@ EXPORT_SYMBOL(remove_shrinker);
>   *
>   * Returns the number of slab objects which we shrunk.
>   */
> -static int shrink_slab(unsigned long scanned, gfp_t gfp_mask,
> -                       unsigned long lru_pages)
> +int shrink_slab(unsigned long scanned, gfp_t gfp_mask, unsigned long lru_pages)
>  {
>         struct shrinker *shrinker;
>         int ret = 0;
> _


--
Coywolf Qi Hunt
