Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751390AbWACNNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbWACNNh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 08:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbWACNNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 08:13:37 -0500
Received: from hera.kernel.org ([140.211.167.34]:28645 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751390AbWACNNg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 08:13:36 -0500
Date: Tue, 3 Jan 2006 08:11:06 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Christoph Lameter <clameter@sgi.com>, lkml <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, Andi Kleen <ak@suse.de>
Subject: Re: [RFC] Event counters [1/3]: Basic counter functionality
Message-ID: <20060103101106.GA3435@dmt.cnet>
References: <20051220235733.30925.55642.sendpatchset@schroedinger.engr.sgi.com> <20051231064615.GB11069@dmt.cnet> <43B63931.6000307@yahoo.com.au> <20051231202602.GC3903@dmt.cnet> <20060102214016.GA13905@dmt.cnet> <1136265106.5261.34.camel@npiggin-nld.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136265106.5261.34.camel@npiggin-nld.site>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2006 at 04:11:46PM +1100, Nick Piggin wrote:
> On Mon, 2006-01-02 at 19:40 -0200, Marcelo Tosatti wrote:
> 
> > Nick, 
> > 
> > The following patch:
> > 
> > - Moves the lightweight "inc/dec" versions of mod_page_state variants
> > to three underscores, making those the default for locations where enough
> > locks are held.
> > 
> 
> I guess I was hoping to try to keep it simple, and just have two
> variants, the __ version would require the caller to do the locking.

I see - one point is that the two/three underscore versions make
it clear that preempt is required, though, but it might be a bit
over-complicated as you say.

Well, its up to you - please rearrange the patch as you wish and merge
up?

> In cases like eg. allocstall, they should happen infrequently enough
> that the extra complexity is probably not worth worrying about.

True, but it reduces kernel code, which is always good.

> I don't think I commented about the preempt race though (and requirement
> to have preempt off from process context), which obviously can be a
> problem as you say (though I think things are currently safe?).

"I think it should not be racy because the function should always be
called with the page table lock held, which disables preempt. I guess
the comment should be explicit about that as well."

Yes, you're right! My bad.

> > - Make the two-underscore version disable and enable preemption, which 
> > is required to avoid preempt-related races which can result in missed
> > updates.
> > 
> > - Extends the lightweight version usage in page reclaim, 
> > pte allocation, and a few other codepaths.
> > 
> 
> I guess nr_dirty looks OK in the places it can be put under tree_lock.
> 
> nr_page_table_pages is OK because ptl should be held to prevent preempt.
> 
> pgrotated and pgactivate should be good because of lru_lock.
> 
> Thanks for going through these!

There's still probably a few more counters but the ones covered till now 
should be the most significant ones performance-wise.
