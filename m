Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262513AbTCZWQR>; Wed, 26 Mar 2003 17:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262559AbTCZWQR>; Wed, 26 Mar 2003 17:16:17 -0500
Received: from [12.47.58.223] ([12.47.58.223]:50996 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id <S262513AbTCZWQQ>; Wed, 26 Mar 2003 17:16:16 -0500
Date: Wed, 26 Mar 2003 16:31:45 -0800
From: Andrew Morton <akpm@digeo.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swap 13/13 may_enter_fs?
Message-Id: <20030326163145.22c90521.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0303261649020.1315-100000@localhost.localdomain>
References: <20030325171223.7a2c50ee.akpm@digeo.com>
	<Pine.LNX.4.44.0303261649020.1315-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Mar 2003 22:27:22.0143 (UTC) FILETIME=[DE8A52F0:01C2F3E6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> On Tue, 25 Mar 2003, Andrew Morton wrote:
> > 
> > For example, a memory-backed filesystem may be trying to allocate GFP_NOFS
> > memory while holding filesystem locks which are taken by its writepage.
> > 
> > How about adding a new field to backing_dev_info for this case?  Damned if I
> > can think of a name for it though.
> 
> I think you're overcomplicating it.  Of the existing memory_backed bdis
> (ramdisk, hugetlbfs, ramfs, sysfs, tmpfs, swap) only two have non-NULL
> writepage, and both of those two go (indirectly and directly) to swap
> (and neither holds FS lock while waiting to allocate memory).

But this is a much nicer patch.  Thanks for doing all this btw.  I was
barfing at ?:, not your code ;)

> If we were looking for a correct solution, I don't think backing_dev_info
> would be the right place: we're talking about GFP_ needed for writepage,
> which should be specified in the struct address_space filled in by the
> FS: I think it's more a limitation of the FS than its backing device.

Good point.

> +			bdi = mapping->backing_dev_info;
> +			if (bdi->swap_backed)
> +				gfp_needed_for_writepage = __GFP_IO;
> +			else
> +				gfp_needed_for_writepage = __GFP_FS;
> +			if (!(gfp_mask & gfp_needed_for_writepage))

This is inaccurate?  shmem_writepage() performs no IO and could/should be
called even for GFP_NOIO allocations.

It's probably not very important but if we're going to make a change it may
as well be the right one.

Could you live with

	if (bdi->has_special_writepage)
		gfp_needed_for_writepage = bfi->gfp_needed_for_writepage;

?  So swap_backing_dev_info uses __GFP_IO and shmem_backing_dev_info() (which
is competely atomic) uses zero?

Yeah, it's a bit awkward.  I'm OK with the special-casing.  Both swap and
tmpfs _are_ special, and unique.  Recognising that fact in vmscan.c is
reasonable.  ->gfp_needed_for_writepage should probably be in the superblock,
but that's just too far away.

> -	int memory_backed;	/* Cannot clean pages with writepage */
> +	unsigned int
> +		memory_backed:1,/* Do not count its dirty pages in nr_dirty */
> +		swap_backed:1;	/* Its memory_backed writepage goes to swap */
>  };

Hard call.  It is a tradeoff between icache misses and dcache misses. 
Obviously that is trivia in this case.

