Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262748AbUKVTfw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262748AbUKVTfw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 14:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262498AbUKVTbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 14:31:24 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56029 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262919AbUKVTaa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 14:30:30 -0500
Date: Mon, 22 Nov 2004 13:01:38 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Andrea Arcangeli <andrea@suse.de>, j-nomura@ce.jp.nec.com,
       linux-kernel@vger.kernel.org, riel@redhat.com,
       Hugh Dickins <hugh@veritas.com>
Subject: Lazily add anonymous pages to LRU on v2.4? was Re: [2.4] heavy-load under swap space shortage
Message-ID: <20041122150138.GB27753@logos.cnet>
References: <20040310.195707.521627048.nomura@linux.bs1.fc.nec.co.jp> <Pine.LNX.4.44.0403141638390.1554-100000@dmt.cyclades> <20040314121503.13247112.akpm@osdl.org> <20040314230138.GV30940@dualathlon.random> <20040314152253.05c58ecc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040314152253.05c58ecc.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2004 at 03:22:53PM -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > > 
> > > Having a magic knob is a weak solution: the majority of people who are
> > > affected by this problem won't know to turn it on.
> > 
> > that's why I turned it _on_ by default in my tree ;)
> 
> So maybe Marcelo should apply this patch, and also turn it on by default.

I've been pondering this again for 2.4.29pre - the thing I'm not sure about 
what negative effect will be caused by not adding anonymous pages to LRU 
immediately on creation.

The scanning algorithm will apply more pressure to pagecache pages initially 
(which are on the LRU) - but that is _hopefully_ no problem because swap_out() will
kick-in soon moving anon pages to LRU soon as they are swap-allocated.

I'm afraid that might be a significant problem for some workloads. No?

Marc-Christian-Petersen claims it improves behaviour for him - how so Marc, 
and what is your workload/hardware description? 

This is known to decrease contention on pagemap_lru_lock.

Guys, doo you have any further thoughts on this? 
I think I'll give it a shot on 2.4.29-pre?

> > There are workloads where adding anonymous pages to the lru is
> > suboptimal for both the vm (cache shrinking) and the fast path too
> > (lru_cache_add), not sure how 2.6 optimizes those bits, since with 2.6
> > you're forced to add those pages to the lru somehow and that implies
> > some form of locking.
