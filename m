Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbTDQU2h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 16:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262578AbTDQU2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 16:28:37 -0400
Received: from [12.47.58.203] ([12.47.58.203]:58834 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262577AbTDQU2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 16:28:35 -0400
Date: Thu, 17 Apr 2003 13:41:03 -0700
From: Andrew Morton <akpm@digeo.com>
To: Neil Schemenauer <nas@arctrix.com>
Cc: linux-kernel@vger.kernel.org, axboe@suse.de, conman@kolivas.net
Subject: Re: [PATCH][CFT] new IO scheduler for 2.4.20
Message-Id: <20030417134103.4e69fc1b.akpm@digeo.com>
In-Reply-To: <20030417172818.GA8848@glacier.arctrix.com>
References: <20030417172818.GA8848@glacier.arctrix.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Apr 2003 20:40:25.0661 (UTC) FILETIME=[931B5ED0:01C30521]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Schemenauer <nas@arctrix.com> wrote:
>
> Hi all,
> 
> Recently I was bitten badly by bad IO scheduler behavior on an important
> Linux server.  An easy way to trigger this problem is to start a
> streaming write process:
> 
>     while :
>     do
>             dd if=/dev/zero of=foo bs=1M count=512 conv=notrunc
>     done

That's a local DoS.

> and then try doing a bunch of small reads:
> 
>     time (find kernel-tree -type f | xargs cat > /dev/null)

Awful, isn't it?

> +int elevator_neil_merge(request_queue_t *q, struct request **req,

This is a nice looking patch!

> ...
> +	unsigned int expire_time = jiffies - 1*HZ;
> ...
> +		if (time_before(__rq->start_time, expire_time)) {
> +			break;
> +		}

It has a deadline component.  One second is probably too long.

> +	if (!*req && rw == READ) {
> +		long extra_writes = write_sectors - read_sectors;
> +		/*
> +		 * If there are more writes than reads in the queue then put
> +		 * read requests ahead of the extra writes.  This prevents
> +		 * writes from starving reads.
> +		 */
> +		entry = q->queue_head.prev;
> +		while (extra_writes > 0 && entry != head) {
> +			__rq = blkdev_entry_to_request(entry);
> +			if (__rq->cmd == WRITE)
> +				extra_writes -= __rq->nr_sectors;
> +			entry = entry->prev;
> +		}
> +		*req = blkdev_entry_to_request(entry);

One suggestion I'd make here is to not count "sectors" at all.  Just count
requests.

See, the code at present is assuming that 100 discrete requests are
equivalent to a single 100 sector request.  And that is most definitely not
the case.  A 100 sector request is worth (guess) just two discontiguous
requests.


I'd be interested in seeing some comparative benchmark results with the above
DoS attack.  And contest numbers too...

