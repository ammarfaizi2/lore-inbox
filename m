Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263944AbRFDExO>; Mon, 4 Jun 2001 00:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263945AbRFDEwz>; Mon, 4 Jun 2001 00:52:55 -0400
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:51517 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S263944AbRFDEwx>; Mon, 4 Jun 2001 00:52:53 -0400
Date: Mon, 4 Jun 2001 00:52:51 -0400 (EDT)
From: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] balance inactive_dirty list
In-Reply-To: <87pucma6dd.fsf@atlas.iskon.hr>
Message-ID: <Pine.LNX.4.10.10106040046300.7350-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> while observing lots of different workloads (all I/O bound). Finally,

well, not all loads are IO-bound in the sense you're looking at.
in particular, the test I usually run (make -j2 with mem=48m)
is actually hurt by this patch.  but you're right, this change 
does improve streaming IO.

> We're trying to be too clever there, and that eventually hurts
> performance because inactive_dirty list is too small for typical

I certainly agree the code is dubious, but this is the reason 
inactive_target exists, afaikt.

> have tested. The patch simplifies code a lot and removes unnecessary
> complex calculation. Code is now completely autotuning. I have a

otoh, the "complex calculation" was always trivial, 
and *more* autotuning than your suggested fix...

> -	if (!target) {
> -		int inactive = nr_free_pages() + nr_inactive_clean_pages() +
> -						nr_inactive_dirty_pages;
> -		int active = MAX(nr_active_pages, num_physpages / 2);
> -		if (active > 10 * inactive)
> -			maxscan = nr_active_pages >> 4;
> -		else if (active > 3 * inactive)
> -			maxscan = nr_active_pages >> 8;
> -		else
> -			return 0;
> -	}
> +	if (!target)
> +		maxscan = nr_active_pages >> 4;

