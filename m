Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbULABfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbULABfJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 20:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbULABef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 20:34:35 -0500
Received: from fw.osdl.org ([65.172.181.6]:54958 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261192AbULABeH (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 20:34:07 -0500
Date: Tue, 30 Nov 2004 17:33:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: nickpiggin@yahoo.com.au, nikita@clusterfs.com,
       Linux-Kernel@vger.kernel.org, AKPM@osdl.org, linux-mm@kvack.org
Subject: Re: [PATCH]: 1/4 batch mark_page_accessed()
Message-Id: <20041130173323.0b3ac83d.akpm@osdl.org>
In-Reply-To: <20041130162956.GA3047@dmt.cyclades>
References: <16800.47044.75874.56255@gargle.gargle.HOWL>
	<20041126185833.GA7740@logos.cnet>
	<41A7CC3D.9030405@yahoo.com.au>
	<20041130162956.GA3047@dmt.cyclades>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
> Because the ordering of LRU pages should be enhanced in respect to locality, 
>  with the mark_page_accessed batching you group together tasks accessed pages 
>  and move them at once to the active list. 
> 
>  You maintain better locality ordering, while decreasing the precision of aging/
>  temporal locality.
> 
>  Which should enhance disk writeout performance.

I'll buy that explanation.  Although I'm a bit sceptical that it is
measurable.

Was that particular workload actually performing significant amounts of
writeout in vmscan.c?  (We should have direct+kswapd counters for that, but
we don't.  /proc/vmstat:pgrotated will give us an idea).


>  On the other hand, without batching you mix the locality up in LRU - the LRU becomes 
>  more precise in terms of "LRU aging", but less ordered in terms of sequential 
>  access pattern.
> 
>  The disk IO intensive reaim has very significant gain from the batching, its
>  probably due to the enhanced LRU ordering (what Nikita says).
> 
>  The slowdown is probably due to the additional atomic_inc by page_cache_get(). 
> 
>  Is there no way to avoid such page_cache_get there (and in lru_cache_add also)?

Not really.  The page is only in the pagevec at that time - if someone does
a put_page() on it the page will be freed for real, and will then be
spilled onto the LRU.  Messy.
