Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264113AbUIVK5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbUIVK5i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 06:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264213AbUIVK5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 06:57:38 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:45249 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264113AbUIVK5g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 06:57:36 -0400
Date: Wed, 22 Sep 2004 12:55:35 +0200
From: Jens Axboe <axboe@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] fix diskstats_show() accounting with PREEMPT
Message-ID: <20040922105534.GF2299@suse.de>
References: <20040921153750.GA21449@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040921153750.GA21449@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21 2004, Ingo Molnar wrote:
> 
> there is another (minor) bug that the smp_processor_id() debugger
> unearthed: diskstats_show() could do a disk_round_stats() ->
> disk_stat_add() with preemption enabled - possibly resulting in losing
> statistics updates.
> 
> Patch attached. (The overwhelming majority of disk_stat_add() callers
> have preemption disabled so fixing the remaining two was the best.)
> 
> 	Ingo
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> 
> --- linux/drivers/block/genhd.c.orig	
> +++ linux/drivers/block/genhd.c	
> @@ -365,7 +365,9 @@ static ssize_t disk_size_read(struct gen
>  
>  static ssize_t disk_stats_read(struct gendisk * disk, char *page)
>  {
> +	preempt_disable();
>  	disk_round_stats(disk);
> +	preempt_enable();
>  	return sprintf(page,
>  		"%8u %8u %8llu %8u "
>  		"%8u %8u %8llu %8u "
> @@ -494,7 +496,9 @@ static int diskstats_show(struct seq_fil
>  				"\n\n");
>  	*/
>   
> +	preempt_disable();
>  	disk_round_stats(gp);
> +	preempt_enable();
>  	seq_printf(s, "%4d %4d %s %u %u %llu %u %u %u %llu %u %u %u %u\n",
>  		gp->major, n + gp->first_minor, disk_name(gp, n, buf),
>  		disk_stat_read(gp, reads), disk_stat_read(gp, read_merges),

Looks fine, thanks Ingo.

-- 
Jens Axboe

