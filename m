Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751890AbWIGVfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890AbWIGVfo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 17:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751892AbWIGVfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 17:35:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9169 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751890AbWIGVfm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 17:35:42 -0400
Date: Thu, 7 Sep 2006 14:35:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Cross <james_cross@symantec.com>
Cc: Jens Axboe <axboe@suse.de>, Andries Brouwer <Andries.Brouwer@cwi.nl>,
       linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
       Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] fix /proc/partitions oops
Message-Id: <20060907143513.7024c15c.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0609071703420.28780@boogie.wat.veritas.com>
References: <Pine.LNX.4.62.0609071703420.28780@boogie.wat.veritas.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Sep 2006 17:04:20 +0100 (BST)
James Cross <james_cross@symantec.com> wrote:

> If show_partition happens to race with re-reading a partition table
> (rescan_partitions), sgp->part[n] can become NULL just after it's been
> tested, and so cause an oops: read it once (and read nr_sects just the
> once too, to avoid a chance of showing 0).
> 

OK.

> 
>  block/genhd.c |   12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> --- 2.6.18-rc6/block/genhd.c.orig	2006-09-07 12:14:32.183218000 +0100
> +++ 2.6.18-rc6/block/genhd.c	2006-09-07 12:15:16.134498000 +0100
> @@ -261,14 +261,18 @@ static int show_partition(struct seq_fil
>  		(unsigned long long)get_capacity(sgp) >> 1,
>  		disk_name(sgp, 0, buf));
>  	for (n = 0; n < sgp->minors - 1; n++) {
> -		if (!sgp->part[n])
> +		struct hd_struct *partn;
> +		unsigned long long nr_sects;
> +
> +		partn = sgp->part[n];
> +		if (!partn)
>  			continue;
> -		if (sgp->part[n]->nr_sects == 0)
> +		nr_sects = partn->nr_sects;
> +		if (nr_sects == 0)
>  			continue;
>  		seq_printf(part, "%4d  %4d %10llu %s\n",
>  			sgp->major, n + 1 + sgp->first_minor,
> -			(unsigned long long)sgp->part[n]->nr_sects >> 1 ,
> -			disk_name(sgp, n + 1, buf));
> +			nr_sects >> 1, disk_name(sgp, n + 1, buf));
>  	}
>  
>  	return 0;

But that'll leave us reading possibly-freed memory.

I expect the correct way to fix this is with locking: the /proc/partitions
reading code needs to lock down the partition information while it's
reading it.

AFAICT the appropriate lock to take is the bdev->bd_mutex on the blockdev
which represents the "whole" disk.  But I'm not sure whether that's
correct, nor what the official way is of hunting down that block_device*,
nor whether the code in do_open() is managing to take the correct lock.

Cc's hopefully added.
