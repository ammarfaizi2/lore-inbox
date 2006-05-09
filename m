Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbWEIRsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWEIRsV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 13:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbWEIRsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 13:48:21 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:16023 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750786AbWEIRsV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 13:48:21 -0400
Date: Tue, 9 May 2006 10:48:38 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Add SYSTEM_BOOTING_KMALLOC_AVAIL system_state
Message-ID: <20060509174838.GB3168@w-mikek2.ibm.com>
References: <20060509053512.GA20073@monkey.ibm.com> <20060508224952.0b43d0fd.akpm@osdl.org> <1147195205.23893.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147195205.23893.15.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 10:20:04AM -0700, Dave Hansen wrote:
> On Mon, 2006-05-08 at 22:49 -0700, Andrew Morton wrote:
> > 
> > How about some private boolean in slab.c, and some special allocation
> > function like
> > 
> > void __init *alloc_memory_early(size_t size, gfp_t gfp_flags)
> > {
> > 	if (slab_is_available)
> > 		return kmalloc(size, gfp_flags);
> > 	return alloc_bootmem(size);
> > }	
> 
> One issue with that approach is that you can't use it for larger
> allocations (which we have a lot of at boot-time).  Would it be OK to
> fall back to the raw page allocator for things where kmalloc() fails?
> Oh, and do we want to make it explicitly NUMA aware?

Well, I am making it NUMA aware as the first identified user of such
a routine does want to make node specific allocations.  I haven't thought
about the 'large' allocations.

Any thoughts about also including free_memory_early() routines?  It
seems like a good idea.  However,  I'm somewhat afraid of these gaining
widespread use and the potential mis-use.  Using free in the same routine
as the alloc (such as in error paths) is generally ok.  But, trying to
do a free at a later time requires the attention of the coder.  Just don't
want people to think these wrappers will be a substitute for that analysis.

-- 
Mike
