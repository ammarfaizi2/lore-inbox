Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbUBTO5E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 09:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbUBTO5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 09:57:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:33929 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261274AbUBTO5A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 09:57:00 -0500
Date: Fri, 20 Feb 2004 14:59:44 +0000
From: Joe Thornber <thornber@redhat.com>
To: Miquel van Smoorenburg <miquels@cistron.net>
Cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <piggin@cyberone.com.au>,
       miquels@cistron.nl, axboe@suse.de, linux-lvm@sistina.com,
       linux-kernel@vger.kernel.org, thornber@redhat.com
Subject: Re: [PATCH] bdi_congestion_funp (was: Re: [PATCH] per process request limits (was Re: IO scheduler, queue depth, nr_requests))
Message-ID: <20040220145944.GM27549@reti>
References: <20040219101519.GG30621@drinkel.cistron.nl> <20040219101915.GJ27190@suse.de> <20040219205907.GE32263@drinkel.cistron.nl> <40353E30.6000105@cyberone.com.au> <20040219235303.GI32263@drinkel.cistron.nl> <40355F03.9030207@cyberone.com.au> <20040219172656.77c887cf.akpm@osdl.org> <40356599.3080001@cyberone.com.au> <20040219183218.2b3c4706.akpm@osdl.org> <20040220144042.GC20917@traveler.cistron.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040220144042.GC20917@traveler.cistron.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 20, 2004 at 03:40:42PM +0100, Miquel van Smoorenburg wrote:
> --- linux-2.6.3/drivers/md/dm-table.c.ORIG	2004-02-04 04:44:59.000000000 +0100
> +++ linux-2.6.3/drivers/md/dm-table.c	2004-02-20 15:14:35.000000000 +0100

<snip>

> +	if ((t = dm_get_table(md)) == NULL)
> +		return 0;

struct mapped_device has no business in this file.  You should move
this function to dm.c, and provide accessor fns in dm-table.c.

> +	devices = dm_table_get_devices(t);
> +	for (d = devices->next; d != devices; d = d->next) {
> +		struct dm_dev *dd = list_entry(d, struct dm_dev, list);
> +		request_queue_t *q = bdev_get_queue(dd->bdev);
> +		r |= test_bit(bdi_state, &(q->backing_dev_info.state));

Shouldn't this be calling your bdi_*_congested function rather than
assuming it is a real device under dm ? (often not true).

I'm also very slightly worried that or'ing together the congestion
results for all the seperate devices isn't always the right thing.
These devices include anything that the targets are using, exception
stores for snapshots, logs for mirror, all paths for multipath (or'ing
is most likely to be wrong for multipath).

- Joe
