Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262791AbTJYUYQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 16:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262792AbTJYUYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 16:24:16 -0400
Received: from adicia.telenet-ops.be ([195.130.132.56]:49562 "EHLO
	adicia.telenet-ops.be") by vger.kernel.org with ESMTP
	id S262791AbTJYUYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 16:24:12 -0400
Subject: Re: LVM on md0: raid0_make_request bug: can't convert block acros
	s chunks or bigger than 64k
From: Karl Vogel <karl.vogel@seagha.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Kevin Corry <kevcorry@us.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <16276.31028.9351.994009@notabene.cse.unsw.edu.au>
References: <16276.31028.9351.994009@notabene.cse.unsw.edu.au>
Content-Type: text/plain
Message-Id: <1067113434.1179.7.camel@kvo.local.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2) 
Date: Sat, 25 Oct 2003 22:23:55 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-10-21 at 02:09, Neil Brown wrote:

> The problem is that dm is not honouring the merge_bvec_fn that
> raid0 has set.
> 
> This patch might fix it, but I'm not very familiar with the dm code,
> so I make no promises.
> 
> (I wonder why you are running LVM on top of raid0 given that lvm
> contains raid0 functionality).
> 
> NeilBrown
> 
> 
> 
>  ----------- Diffstat output ------------
>  ./drivers/md/dm-table.c |    5 +++++
>  1 files changed, 5 insertions(+)
> 
> diff ./drivers/md/dm-table.c~current~ ./drivers/md/dm-table.c
> --- ./drivers/md/dm-table.c~current~	2003-10-21 10:05:29.000000000
> +1000
> +++ ./drivers/md/dm-table.c	2003-10-21 10:06:27.000000000 +1000
> @@ -489,6 +489,11 @@ int dm_get_device(struct dm_target *ti, 
>  		rs->max_sectors =
>  			min_not_zero(rs->max_sectors, q->max_sectors);
>  
> +		if (q->merge_bvec_fn)
> +			rs->max_sectors =
> +				min_not_zero(rs->max_sectors,
> PAGE_SIZE>>9);
> +			
> +
>  		rs->max_phys_segments =
>  			min_not_zero(rs->max_phys_segments,
>  				     q->max_phys_segments);


I noticed in the 2.6.0-test9 notes the following:

---
Neil Brown:
  o md -  Use sector rather than block numbers when splitting raid0
    requests
---

I'm not sure if this is related to the problem I was experiencing?!
Anyway this doesn't fix the problem I was having. I still get the errors
with -test9. Above patch to dm-table.c works for me.

Just thought I'd mention this..


