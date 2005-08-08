Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbVHHQv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbVHHQv5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 12:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbVHHQv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 12:51:57 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:17575 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932115AbVHHQv4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 12:51:56 -0400
Date: Mon, 8 Aug 2005 22:16:36 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: Fw: two 2.6.13-rc3-mm3 oddities
Message-ID: <20050808164636.GA6153@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20050803095644.78b58cb4.akpm@osdl.org> <20050808140536.GC4558@in.ibm.com> <42F788F8.1000001@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42F788F8.1000001@colorfullife.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2005 at 06:31:52PM +0200, Manfred Spraul wrote:
> Dipankar Sarma wrote:
> 
> >Hugh, could you please try this with the experimental patch below ?
> >Manfred, is it safe to decrement nr_files in file_free()
> >instead of the destructor ? I can't see any problem.
> >
> > 
> >
> The ctor/dtor are only called when new objects are created, not on every 
> kmem_cache_alloc/kmem_cache_free. Thus I would expect that the counter 
> becomes negative on builds without CONFIG_DEBUG_SLAB.
> Thus increase in the ctor and decrease in file_free() is the wrong 
> thing. If you want to move the decrease from the dtor to file_free, then 
> you must move the increase, too.
> But: IIRC the counters were moved to the ctor/dtor for performance 
> reasons, I'd guess mbligh ran into cache line trashing on the 
> filp_count_lock spinlock with reaim or something like that.

Ah, so the whole idea was to inc/dec nr_files less often so
that we reduce contention on filp_count_lock, right ? This however
causes skews nr_files by the size of the slab array, AFAICS.
Since we check nr_files before we allocate files from slab, the
check seems inaccurate.

Anyway, I guess, I need to look at scaling the file counting
first.

Thanks
Dipankar
