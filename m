Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932491AbWAQNz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbWAQNz3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 08:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbWAQNz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 08:55:29 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:14858 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932491AbWAQNz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 08:55:29 -0500
Date: Tue, 17 Jan 2006 14:57:31 +0100
From: Jens Axboe <axboe@suse.de>
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: Max Waterman <davidmaxwaterman+kernel@fastmail.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: io performance...
Message-ID: <20060117135731.GM3945@suse.de>
References: <43CB4CC3.4030904@fastmail.co.uk> <43CB4C03.7070304@wolfmountaingroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43CB4C03.7070304@wolfmountaingroup.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16 2006, Jeff V. Merkey wrote:
> Max Waterman wrote:
> 
> >Hi,
> >
> >I've been referred to this list from the linux-raid list.
> >
> >I've been playing with a RAID system, trying to obtain best bandwidth
> >from it.
> >
> >I've noticed that I consistently get better (read) numbers from kernel 
> >2.6.8
> >than from later kernels.
> 
> 
> To open the bottlenecks, the following works well.  Jens will shoot me 
> for recommending this,
> but it works well.  2.6.9 so far has the highest numbers with this fix.  
> You can manually putz
> around with these numbers, but they are an artificial constraint if you 
> are using RAID technology
> that caches ad elevators requests and consolidates them.
> 
> 
> Jeff
> 
> 

> 
> diff -Naur ./include/linux/blkdev.h ../linux-2.6.9/./include/linux/blkdev.h
> --- ./include/linux/blkdev.h	2004-10-18 15:53:43.000000000 -0600
> +++ ../linux-2.6.9/./include/linux/blkdev.h	2005-12-06 09:54:46.000000000 -0700
> @@ -23,8 +23,10 @@
>  typedef struct elevator_s elevator_t;
>  struct request_pm_state;
>  
> -#define BLKDEV_MIN_RQ	4
> -#define BLKDEV_MAX_RQ	128	/* Default maximum */
> +//#define BLKDEV_MIN_RQ	4
> +//#define BLKDEV_MAX_RQ	128	/* Default maximum */
> +#define BLKDEV_MIN_RQ	4096
> +#define BLKDEV_MAX_RQ	8192	/* Default maximum */

Yeah I could shoot you. However I'm more interested in why this is
necessary, eg I'd like to see some numbers from you comparing:

- The stock settings
- Doing
        # echo 8192 > /sys/block/<dev>/queue/nr_requests
  for each drive you are accessing.
- The kernel with your patch.

If #2 and #3 don't provide very similar profiles/scores, then we have
something to look at.

The BLKDEV_MIN_RQ increase is just silly and wastes a huge amount of
memory for no good reason.

-- 
Jens Axboe

