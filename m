Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267827AbUHTN7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267827AbUHTN7q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 09:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266884AbUHTN7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 09:59:46 -0400
Received: from clusterfw.gprsrus.net ([217.118.66.232]:54656 "EHLO
	crimson.namesys.com") by vger.kernel.org with ESMTP id S267827AbUHTN7m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 09:59:42 -0400
Date: Fri, 20 Aug 2004 17:53:21 +0400
From: Alex Zarochentsev <zam@namesys.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Andrew Morton <akpm@osdl.org>, cherry@osdl.org,
       linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: 2.6.8.1-mm2
Message-ID: <20040820135321.GY5154@backtop.namesys.com>
References: <20040819014204.2d412e9b.akpm@osdl.org> <1092927166.29916.0.camel@cherrybomb.pdx.osdl.net> <4125A2F6.5050308@namesys.com> <20040820001629.387715be.akpm@osdl.org> <4125AA35.6020900@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4125AA35.6020900@namesys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2004 at 12:37:25AM -0700, Hans Reiser wrote:
> Andrew Morton wrote:
> 
> >Hans Reiser <reiser@namesys.com> wrote:
> > 
> >
> >>John Cherry wrote:
> >>
> >>   
> >>
> >>>The new "errors" are from reiser4 code and they all appear to be...
> >>>
> >>>fs/reiser4/reiser4.h:18:2: #error "Please turn 4k stack off"
> >>>
> >>>
> >>>
> >>>     
> >>>
> >>zam, can you or Mr. Demidov work on using kmalloc to reduce stack usage?
> >>
> >>Andrew suggested that for statically sized objects kmalloc is quite fast 
> >>(one instruction I think he said), so my objection to kmallocing a lot 
> >>has faded.
> >>   
> >>
> >
> >err, not that quick - but it's pretty quick.
> >
> >With a kmalloc with a constant size and, preferably, a constant gfp mask
> >we'll jump directly into __cache_alloc() and in the common case we'll pluck
> >an entry directly out of the cpu-local head array:
> >
> >So the kmalloc fastpath is, effectively:
> >
> >	local_irq_save(save_flags);
> >	ac = ac_data(cachep);
> >	if (likely(ac->avail)) {
> >		ac->touched = 1;
> >		objp = ac_entry(ac)[--ac->avail];
> >	}
> >	local_irq_restore(save_flags);
> >	return objp;
> >
> >
> >Not bad...
> >
> >
> > 
> >
> but not trivial.  Sigh.  It means determining whether we can get below 
> 4k without performance loss requires detailed code examination to 
> determine what is using up the stack in practice, and discussion.
> 
> Well, maybe zam has a comment.

yes. there are large objects (reiser4 context, balancing pools, ...) which
reiser4 allocates on stack. we will use kmalloc/slab for them and see how
performance is changed.  not trivial things will be required if those fixes
would not enough.

> 
> Hans

-- 
Alex.
