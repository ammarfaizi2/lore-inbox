Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266296AbUG0Hbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266296AbUG0Hbl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 03:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266303AbUG0Hbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 03:31:41 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:21383 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266296AbUG0Hbg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 03:31:36 -0400
Date: Tue, 27 Jul 2004 03:33:38 -0200
From: Jens Axboe <axboe@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Lenar L?hmus <lenar@vision.ee>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-J4
Message-ID: <20040727053338.GE1433@suse.de>
References: <20040713122805.GZ21066@holomorphy.com> <40F3F0A0.9080100@vision.ee> <20040713143947.GG21066@holomorphy.com> <1090732537.738.2.camel@mindpipe> <1090795742.719.4.camel@mindpipe> <20040726082330.GA22764@elte.hu> <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu> <20040726100103.GA29072@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040726100103.GA29072@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26 2004, Ingo Molnar wrote:
> 
> i've uploaded the -J4 patch:
> 
>    http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc2-J4
> 
> Changes since -J3:
> 
>  - make block device max_sectors sysfs tunable. There's a new entry
>    /sys/block/*/queue/max_sectors_kb which stores the current max 
>    request size in KB. You can write it to change the size.
> 
>    Jens: i've attached a standalone patch against 2.6.8-rc2 below. 
>    Please apply if it looks good to you. (I've added extra locking to 
>    make sure max_sectors and readahead_pages gets updated at once, for 
>    the unlikely event of two CPUs updating max_sectors at once.) I've 
>    tested this on IDE using the UP kernel.
> 
>  - include the unlock-tty changes suggested by akpm and tested by Lee 
>    Revell. I've also unlocked the tty_read path - only the release/open 
>    paths remain under the big kernel lock. Please report any tty related 
>    regressions.
> 
> 	Ingo
> 
> --
> introduce max_sectors_kb tunable.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> 
> --- linux/drivers/block/ll_rw_blk.c.orig	
> +++ linux/drivers/block/ll_rw_blk.c	
> @@ -3062,13 +3063,50 @@ queue_ra_store(struct request_queue *q, 
>  	unsigned long ra_kb;
>  	ssize_t ret = queue_var_store(&ra_kb, page, count);
>  
> +	spin_lock_irq(q->queue_lock);
>  	if (ra_kb > (q->max_sectors >> 1))
>  		ra_kb = (q->max_sectors >> 1);
>  
>  	q->backing_dev_info.ra_pages = ra_kb >> (PAGE_CACHE_SHIFT - 10);
> +	spin_unlock_irq(q->queue_lock);
> +
> +	return ret;
> +}
> +
> +static ssize_t queue_max_sectors_show(struct request_queue *q, char *page)
> +{
> +	int max_sectors_kb = q->max_sectors >> 1;
> +
> +	return queue_var_show(max_sectors_kb, (page));
> +}
> +
> +static ssize_t
> +queue_max_sectors_store(struct request_queue *q, const char *page, size_t count)
> +{
> +	unsigned long max_sectors_kb;
> +	ssize_t ret = queue_var_store(&max_sectors_kb, page, count);
> +	int ra_kb;
> +
> +	/*
> +	 * Take the queue lock to update the readahead and max_sectors
> +	 * values synchronously:
> +	 */
> +	spin_lock_irq(q->queue_lock);
> +	/*
> +	 * Trim readahead window as well, if necessary:
> +	 */
> +	ra_kb = q->backing_dev_info.ra_pages << (PAGE_CACHE_SHIFT - 10);
> +	if (ra_kb > max_sectors_kb)
> +		q->backing_dev_info.ra_pages =
> +				max_sectors_kb >> (PAGE_CACHE_SHIFT - 10);
> +
> +	q->max_sectors = max_sectors_kb << 1;
> +	spin_unlock_irq(q->queue_lock);
> +
>  	return ret;
>  }
>  
> +
>  static struct queue_sysfs_entry queue_requests_entry = {
>  	.attr = {.name = "nr_requests", .mode = S_IRUGO | S_IWUSR },
>  	.show = queue_requests_show,
> @@ -3081,9 +3119,16 @@ static struct queue_sysfs_entry queue_ra
>  	.store = queue_ra_store,
>  };
>  
> +static struct queue_sysfs_entry queue_max_sectors_entry = {
> +	.attr = {.name = "max_sectors_kb", .mode = S_IRUGO | S_IWUSR },
> +	.show = queue_max_sectors_show,
> +	.store = queue_max_sectors_store,
> +};
> +
>  static struct attribute *default_attrs[] = {
>  	&queue_requests_entry.attr,
>  	&queue_ra_entry.attr,
> +	&queue_max_sectors_entry.attr,
>  	NULL,
>  };

I don't like it. First of all, the implementation really should drain
the queue first, then set max value before allowing people to queue more
io. The queue lock doesn't help here, readers don't even attempt to
serialize access to max_sectors. 

Secondly, I don't like the concept of exposing this value. If you want
to do something like this, we must split the value into two like
proposed (and patched) some months ago into a hardware and user value.

I don't see why we can't just drop ata48 default value to 256kb instead.
There's very little command over head on ide, I bet the majority of the
change in performance when playing with 256kb vs 1024kb is not the
command overhead itself, rather things like read-ahead that could be
more intelligent.

-- 
Jens Axboe

