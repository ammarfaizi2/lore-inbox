Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWATKr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWATKr0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 05:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWATKrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 05:47:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20420 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750809AbWATKrY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 05:47:24 -0500
Date: Fri, 20 Jan 2006 02:47:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <npiggin@suse.de>
Cc: npiggin@suse.de, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, dougg@torque.net
Subject: Re: [patch] sg: simplify page_count manipulations
Message-Id: <20060120024702.6f894a13.akpm@osdl.org>
In-Reply-To: <20060120101815.GD1756@wotan.suse.de>
References: <20060118155242.GB28418@wotan.suse.de>
	<20060118195937.3586c94f.akpm@osdl.org>
	<20060119144548.GF958@wotan.suse.de>
	<20060119140525.223a8ebf.akpm@osdl.org>
	<20060120101815.GD1756@wotan.suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <npiggin@suse.de> wrote:
>
> On Thu, Jan 19, 2006 at 02:05:25PM -0800, Andrew Morton wrote:
> > Nick Piggin <npiggin@suse.de> wrote:
> > >
> > > On Wed, Jan 18, 2006 at 07:59:37PM -0800, Andrew Morton wrote:
> > > > Nick Piggin <npiggin@suse.de> wrote:
> > > > > -	/* N.B. correction _not_ applied to base page of each allocation */
> > > > > -	for (k = 0; k < rsv_schp->k_use_sg; ++k, ++sg) {
> > > > > -		for (m = PAGE_SIZE; m < sg->length; m += PAGE_SIZE) {
> > > > > -			page = sg->page;
> > > > > -			if (startFinish)
> > > > > -				get_page(page);
> > > > > -			else {
> > > > > -				if (page_count(page) > 0)
> > > > > -					__put_page(page);
> > > > > -			}
> > > > > -		}
> > > > > -	}
> > > > > -}
> > > > 
> > > > What on earth is the above trying to do?  The inner loop is a rather
> > > > complex way of doing atomic_add(&page->count, sg->length/PAGE_SIZE).  One
> > > > suspects there's a missing "[m]" in there.
> > > > 
> > > 
> > > It does this on the first mmap of the device, in the hope that subsequent
> > > nopage, unmaps would not free the constituent pages in the scatterlist.
> > > 
> > 
> > But it's doing it wrongly, isn't it?  Or am I completely nuts?
> 
> No I think you're right. I'm not sure why this doesn't oops but I
> thought it was the (main) reason others wanted to get rid of this
> convoluted code earlier on. I see nobody else is planning to do anything
> about it though, so I figure I must have missed the reason why it isn't
> a problem.
> 
> But either way I don't think the code actually _does_ anything, even if
> its bugginess doesn't actually lead to a bug.
> 

I suspect nobody tried to munmap pages beyond the first one.

Yes, let's use a compound page in there and I expect Doug will be able to
test it for us sometime.

