Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263573AbTLXLRU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 06:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263584AbTLXLRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 06:17:20 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:8401 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263573AbTLXLRE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 06:17:04 -0500
Date: Wed, 24 Dec 2003 12:16:41 +0100
From: Jens Axboe <axboe@suse.de>
To: Bart Samwel <bart@samwel.tk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] laptop-mode for 2.6, version 2
Message-ID: <20031224111640.GL1601@suse.de>
References: <3FE92517.1000306@samwel.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FE92517.1000306@samwel.tk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 24 2003, Bart Samwel wrote:
> Hi Jens,
> 
> Here's a new version of the laptop-mode patch (and control script). I've
> made a couple of improvements because of your comments. The block_dump
> functionality (including block dirtying) is back, and my alternative
> functionality has gone. There's just one bit of the block dumping patch 
> that I couldn't place, the bit in filemap.c. The 2.6 code is so 
> different here that I really couldn't figure out what I should do with 
> it. Do you have any idea where this has gone (and if it is still needed)?

It looks better, getting there! Some comments further down.

> diff -baur --speed-large-files linux-2.6.0/drivers/block/ll_rw_blk.c linux-2.6.0-withlaptopmode/drivers/block/ll_rw_blk.c
> --- linux-2.6.0/drivers/block/ll_rw_blk.c	2003-12-24 05:19:46.000000000 +0100
> +++ linux-2.6.0-withlaptopmode/drivers/block/ll_rw_blk.c	2003-12-24 06:00:16.000000000 +0100
> @@ -27,6 +27,7 @@
>  #include <linux/completion.h>
>  #include <linux/slab.h>
>  #include <linux/swap.h>
> +#include <linux/writeback.h>
>  
>  static void blk_unplug_work(void *data);
>  static void blk_unplug_timeout(unsigned long data);
> @@ -2582,6 +2583,14 @@
>  
>  EXPORT_SYMBOL(end_that_request_chunk);
>  
> +static struct timer_list writeback_timer;
> +
> +static void blk_writeback_timer(unsigned long data)
> +{
> +	wakeup_bdflush(0);
> +	wakeup_kupdate();
> +}
> +
>  /*
>   * queue lock must be held
>   */
> @@ -2598,6 +2607,11 @@
>  			disk_stat_add(disk, write_ticks, duration);
>  			break;
>  		    case READ:
> +			/*
> +			 * schedule the writeout of pending dirty data when the disk is idle
> +			 */
> +			if (unlikely(laptop_mode))
> +				mod_timer(&writeback_timer, jiffies + 5 * HZ);
>  			disk_stat_inc(disk, reads);
>  			disk_stat_add(disk, read_ticks, duration);
>  			break;
> @@ -2689,6 +2703,10 @@
>  
>  	for (i = 0; i < ARRAY_SIZE(congestion_wqh); i++)
>  		init_waitqueue_head(&congestion_wqh[i]);
> +	
> +	init_timer(&writeback_timer);
> +	writeback_timer.function = blk_writeback_timer;
> +	
>  	return 0;
>  }
>  
> diff -baur --speed-large-files linux-2.6.0/fs/buffer.c linux-2.6.0-withlaptopmode/fs/buffer.c
> --- linux-2.6.0/fs/buffer.c	2003-12-24 05:19:46.000000000 +0100
> +++ linux-2.6.0-withlaptopmode/fs/buffer.c	2003-12-24 06:06:18.000000000 +0100
> @@ -1259,7 +1259,11 @@
>  	if (!buffer_uptodate(bh))
>  		buffer_error();
>  	if (!buffer_dirty(bh) && !test_set_buffer_dirty(bh))
> +	{
>  		__set_page_dirty_nobuffers(bh->b_page);
> +		if (unlikely(block_dump))
> +			printk("%s(%d): dirtied buffer\n", current->comm, current->pid);
> +	}

Probably want to move this to the actual set_page_dirty() function(s).

>  }
>  
>  /*
> @@ -2669,6 +2673,16 @@
>  	if (test_set_buffer_req(bh) && rw == WRITE)
>  		clear_buffer_write_io_error(bh);
>  
> +	if (unlikely(block_dump))
> +	{
> +		char b[BDEVNAME_SIZE];
> +		printk("%s(%d): %s block %lu/%u on %s\n",
> +			current->comm, current->pid,
> +			rw == WRITE ? "WRITE" : (rw == READA ? "READA" : "READ"),
> +			bh->b_blocknr, atomic_read(&bh->b_count),
> +			bdevname(bh->b_bdev,b));
> +	}
> +
>  	/*
>  	 * from here on down, it's all bio -- do the initial mapping,
>  	 * submit_bio -> generic_make_request may further map this bio around

You don't want this in submit_bh(), that hardly matters at all anymore.
It wants to be in submit_bio(). And you should follow the brace
placement style. And just dump device+offset, b_count is not
interesting.

> diff -baur --speed-large-files linux-2.6.0/include/linux/sysctl.h linux-2.6.0-withlaptopmode/include/linux/sysctl.h
> --- linux-2.6.0/include/linux/sysctl.h	2003-12-24 05:19:46.000000000 +0100
> +++ linux-2.6.0-withlaptopmode/include/linux/sysctl.h	2003-12-24 03:17:36.000000000 +0100
> @@ -154,6 +154,8 @@
>  	VM_SWAPPINESS=19,	/* Tendency to steal mapped memory */
>  	VM_LOWER_ZONE_PROTECTION=20,/* Amount of protection of lower zones */
>  	VM_MIN_FREE_KBYTES=21,	/* Minimum free kilobytes to maintain */
> +	VM_LAPTOP_MODE=22,      /* vm laptop mode */
> +	VM_BLOCK_DUMP=23,       /* block dump mode */
>  };
>  
>  
> diff -baur --speed-large-files linux-2.6.0/include/linux/writeback.h linux-2.6.0-withlaptopmode/include/linux/writeback.h
> --- linux-2.6.0/include/linux/writeback.h	2003-12-24 05:19:46.000000000 +0100
> +++ linux-2.6.0-withlaptopmode/include/linux/writeback.h	2003-12-24 06:01:47.000000000 +0100
> @@ -71,12 +71,15 @@
>   * mm/page-writeback.c
>   */
>  int wakeup_bdflush(long nr_pages);
> +int wakeup_kupdate(void);
>  
> -/* These 5 are exported to sysctl. */
> +/* These are exported to sysctl. */
>  extern int dirty_background_ratio;
>  extern int vm_dirty_ratio;
>  extern int dirty_writeback_centisecs;
>  extern int dirty_expire_centisecs;
> +extern int block_dump;
> +extern int laptop_mode;
>  
>  struct ctl_table;
>  struct file;
> diff -baur --speed-large-files linux-2.6.0/kernel/sysctl.c linux-2.6.0-withlaptopmode/kernel/sysctl.c
> --- linux-2.6.0/kernel/sysctl.c	2003-12-24 05:19:46.000000000 +0100
> +++ linux-2.6.0-withlaptopmode/kernel/sysctl.c	2003-12-24 06:24:53.000000000 +0100
> @@ -700,6 +700,26 @@
>  		.strategy	= &sysctl_intvec,
>  		.extra1		= &zero,
>  	},
> +	{
> +		.ctl_name	= VM_LAPTOP_MODE,
> +		.procname	= "laptop_mode",
> +		.data		= &laptop_mode,
> +		.maxlen		= sizeof(laptop_mode),
> +		.mode		= 0644,
> +		.proc_handler	= &proc_dointvec,
> +		.strategy	= &sysctl_intvec,
> +		.extra1		= &zero,
> +	},
> +	{
> +		.ctl_name	= VM_BLOCK_DUMP,
> +		.procname	= "block_dump",
> +		.data		= &block_dump,
> +		.maxlen		= sizeof(block_dump),
> +		.mode		= 0644,
> +		.proc_handler	= &proc_dointvec,
> +		.strategy	= &sysctl_intvec,
> +		.extra1		= &zero,
> +	},
>  	{ .ctl_name = 0 }
>  };
>  
> diff -baur --speed-large-files linux-2.6.0/mm/page-writeback.c linux-2.6.0-withlaptopmode/mm/page-writeback.c
> --- linux-2.6.0/mm/page-writeback.c	2003-12-24 05:19:46.000000000 +0100
> +++ linux-2.6.0-withlaptopmode/mm/page-writeback.c	2003-12-24 06:03:22.000000000 +0100
> @@ -28,6 +28,7 @@
>  #include <linux/smp.h>
>  #include <linux/sysctl.h>
>  #include <linux/cpu.h>
> +#include <linux/quotaops.h>
>  
>  /*
>   * The maximum number of pages to writeout in a single bdflush/kupdate
> @@ -81,6 +82,16 @@
>   */
>  int dirty_expire_centisecs = 30 * 100;
>  
> +/*
> + * Flag that makes the machine dump writes/reads and block dirtyings.
> + */
> +int block_dump = 0;
> +
> +/*
> + * Flag that puts the machine in "laptop mode".
> + */
> +int laptop_mode = 0;
> +
>  /* End of sysctl-exported parameters */
>  
>  
> @@ -167,7 +178,7 @@
>  
>  		get_dirty_limits(&ps, &background_thresh, &dirty_thresh);
>  		nr_reclaimable = ps.nr_dirty + ps.nr_unstable;
> -		if (nr_reclaimable + ps.nr_writeback <= dirty_thresh)
> +		if (laptop_mode || nr_reclaimable + ps.nr_writeback <= dirty_thresh)
>  			break;
>  
>  		dirty_exceeded = 1;
> @@ -192,10 +203,11 @@
>  		blk_congestion_wait(WRITE, HZ/10);
>  	}
>  
> -	if (nr_reclaimable + ps.nr_writeback <= dirty_thresh)
> +	if (laptop_mode || nr_reclaimable + ps.nr_writeback <= dirty_thresh)
>  		dirty_exceeded = 0;
>  
> -	if (!writeback_in_progress(bdi) && nr_reclaimable > background_thresh)
> +	if (!laptop_mode &&
> +	    !writeback_in_progress(bdi) && nr_reclaimable > background_thresh)
>  		pdflush_operation(background_writeout, 0);
>  }
>  
> @@ -327,6 +339,8 @@
>  	oldest_jif = jiffies - (dirty_expire_centisecs * HZ) / 100;
>  	start_jif = jiffies;
>  	next_jif = start_jif + (dirty_writeback_centisecs * HZ) / 100;
> +	if (laptop_mode)
> +		wbc.older_than_this = NULL;
>  	nr_to_write = ps.nr_dirty + ps.nr_unstable +
>  			(inodes_stat.nr_inodes - inodes_stat.nr_unused);
>  	while (nr_to_write > 0) {
> @@ -343,6 +357,12 @@
>  	}
>  	if (time_before(next_jif, jiffies + HZ))
>  		next_jif = jiffies + HZ;
> +	if (laptop_mode)
> +	{
> +		sync_inodes(0);
> +		sync_filesystems(0);
> +		DQUOT_SYNC(NULL);
> +	}
>  	if (dirty_writeback_centisecs)
>  		mod_timer(&wb_timer, next_jif);
>  }
> @@ -363,6 +383,15 @@
>  	return 0;
>  }
>  
> +/*
> + * Set the kupdate timer to run it as soon as possible.
> + */
> +int wakeup_kupdate(void)
> +{
> +	mod_timer(&wb_timer, jiffies);
> +	return 0;
> +}
> +
>  static void wb_timer_fn(unsigned long unused)
>  {
>  	if (pdflush_operation(wb_kupdate, 0) < 0)

The rest looks ok, apart from style.

-- 
Jens Axboe

