Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262868AbUCJWXr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 17:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262871AbUCJWXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 17:23:47 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:3830 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262868AbUCJWXk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 17:23:40 -0500
Date: Thu, 11 Mar 2004 09:22:47 +1100
From: Nathan Scott <nathans@sgi.com>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, kenneth.w.chen@intel.com,
       Andrew Morton <akpm@osdl.org>, thornber@redhat.com,
       linux-xfs@oss.sgi.com
Subject: Re: [PATCH] backing dev unplugging
Message-ID: <20040310222247.GA713@frodo>
References: <20040310124507.GU4949@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040310124507.GU4949@suse.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On Wed, Mar 10, 2004 at 01:45:07PM +0100, Jens Axboe wrote:
> ...[snip]...
> diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.4-rc2-mm1/fs/xfs/linux/xfs_buf.c linux-2.6.4-rc2-mm1-plug/fs/xfs/linux/xfs_buf.c
> --- /opt/kernel/linux-2.6.4-rc2-mm1/fs/xfs/linux/xfs_buf.c	2004-03-09 13:08:30.000000000 +0100
> +++ linux-2.6.4-rc2-mm1-plug/fs/xfs/linux/xfs_buf.c	2004-03-10 13:13:49.000000000 +0100
> @@ -1013,7 +1013,7 @@
>  {
>  	PB_TRACE(pb, "lock", 0);
>  	if (atomic_read(&pb->pb_io_remaining))
> -		blk_run_queues();
> +		blk_run_address_space(pb->pb_target->pbr_mapping);
>  	down(&pb->pb_sema);
>  	PB_SET_OWNER(pb);
>  	PB_TRACE(pb, "locked", 0);
> @@ -1109,7 +1109,7 @@
>  		if (atomic_read(&pb->pb_pin_count) == 0)
>  			break;
>  		if (atomic_read(&pb->pb_io_remaining))
> -			blk_run_queues();
> +			blk_run_address_space(pb->pb_target->pbr_mapping);
>  		schedule();
>  	}
>  	remove_wait_queue(&pb->pb_waiters, &wait);
> @@ -1407,7 +1407,7 @@
>  	if (pb->pb_flags & PBF_RUN_QUEUES) {
>  		pb->pb_flags &= ~PBF_RUN_QUEUES;
>  		if (atomic_read(&pb->pb_io_remaining) > 1)
> -			blk_run_queues();
> +			blk_run_address_space(pb->pb_target->pbr_mapping);
>  	}
>  }
>  
> @@ -1471,7 +1471,7 @@
>  {
>  	PB_TRACE(pb, "iowait", 0);
>  	if (atomic_read(&pb->pb_io_remaining))
> -		blk_run_queues();
> +		blk_run_address_space(pb->pb_target->pbr_mapping);
>  	down(&pb->pb_iodonesema);
>  	PB_TRACE(pb, "iowaited", (long)pb->pb_error);
>  	return pb->pb_error;
> @@ -1617,7 +1617,6 @@
>  pagebuf_daemon(
>  	void			*data)
>  {
> -	int			count;
>  	page_buf_t		*pb;
>  	struct list_head	*curr, *next, tmp;
>  
> @@ -1640,7 +1639,6 @@
>  
>  		spin_lock(&pbd_delwrite_lock);
>  
> -		count = 0;
>  		list_for_each_safe(curr, next, &pbd_delwrite_queue) {
>  			pb = list_entry(curr, page_buf_t, pb_list);
>  
> @@ -1657,7 +1655,7 @@
>  				pb->pb_flags &= ~PBF_DELWRI;
>  				pb->pb_flags |= PBF_WRITE;
>  				list_move(&pb->pb_list, &tmp);
> -				count++;
> +				blk_run_address_space(pb->pb_target->pbr_mapping);
>  			}

This moves the blk_run_address_space to before we submit the
I/O (this bit of code is moving buffers off the delwri queue
onto a temporary queue, buffers on the temporary queue are
then submitted a little further down) - I suspect we need to
move this new blk_run_address_space call down into the temp
list processing, just after pagebuf_iostrategy.

>  		}
>  
> @@ -1671,8 +1669,6 @@
>  
>  		if (as_list_len > 0)
>  			purge_addresses();
> -		if (count)
> -			blk_run_queues();
>  
>  		force_flush = 0;
>  	} while (pagebuf_daemon_active);
> @@ -1734,13 +1730,11 @@
>  		pagebuf_lock(pb);
>  		pagebuf_iostrategy(pb);
>  		if (++flush_cnt > 32) {
> -			blk_run_queues();
> +			blk_run_address_space(pb->pb_target->pbr_mapping);
>  			flush_cnt = 0;
>  		}
>  	}
>  
> -	blk_run_queues();
> -
>  	while (!list_empty(&tmp)) {
>  		pb = list_entry(tmp.next, page_buf_t, pb_list);
>  

For this second one, we probably just want to ditch the flush_cnt
there (this change is doing blk_run_address_space on every 32nd
buffer target, and not the intervening ones).  We will be doing a
bunch more blk_run_address_space calls than we probably need to,
not sure if thats going to become an issue or not, let me prod
some of the other XFS folks for more insight there...

thanks.

-- 
Nathan
