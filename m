Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261960AbULVKxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbULVKxJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 05:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbULVKxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 05:53:09 -0500
Received: from cantor.suse.de ([195.135.220.2]:38600 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261960AbULVKxC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 05:53:02 -0500
Date: Wed, 22 Dec 2004 11:53:01 +0100
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Increase page fault rate by prezeroing V1 [1/3]: Introduce __GFP_ZERO
Message-ID: <20041222105301.GE15894@wotan.suse.de>
References: <B8E391BBE9FE384DAA4C5C003888BE6F02900FBD@scsmsx401.amr.corp.intel.com.suse.lists.linux.kernel> <41C20E3E.3070209@yahoo.com.au.suse.lists.linux.kernel> <Pine.LNX.4.58.0412211154100.1313@schroedinger.engr.sgi.com.suse.lists.linux.kernel> <Pine.LNX.4.58.0412211155340.1313@schroedinger.engr.sgi.com.suse.lists.linux.kernel> <p73mzw7cm1p.fsf@verdi.suse.de> <Pine.LNX.4.58.0412211452110.2541@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0412211452110.2541@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2004 at 02:54:46PM -0800, Christoph Lameter wrote:
> On Tue, 21 Dec 2004, Andi Kleen wrote:
> 
> > Christoph Lameter <clameter@sgi.com> writes:
> > > @@ -0,0 +1,52 @@
> > > +/*
> > > + * Zero a page.
> > > + * rdi	page
> > > + */
> > > +	.globl zero_page
> > > +	.p2align 4
> > > +zero_page:
> > > +	xorl   %eax,%eax
> > > +	movl   $4096/64,%ecx
> > > +	shl	%ecx, %esi
> >
> > Surely must be shl %esi,%ecx
> 
> Ahh. Thanks.
> 
> > But for the one instruction it seems overkill to me to have a new
> > function. How about you just extend clear_page with the order argument?
> 
> We can just
> 
> #define clear_page(__p) zero_page(__p, 0)
> 
> and remove clear_page?

It depends. If you plan to do really big zero_page then it
may be worth experimenting with cache bypassing clears 
(movntq) or even SSE2 16 byte stores (movntdq %xmm..,..) 
and take out the rep ; stosq optimization. I tried it all
long ago and it wasn't a win for only 4K. 

For normal 4K clear_page that's definitely not a win (tested) 
and especially cache bypassing is a loss.

> 
> >
> > BTW I think Andrea has been playing with prezeroing on x86 and
> > he found no benefit at all. So it's doubtful it makes any sense
> > on x86/x86-64.
> 
> Andrea's approach was:
> 
> 1. Zero hot pages
> 2. Zero single pages
> 
> which simply results in shifting the processing time somewhere else.

Yours too at least on non Altix no? Can you demonstrate any benefit? 
Where are the numbers? 

I'm sceptical for example that there will be enough higher orders
to make the batch clearing worthwhile after the system is up for a days. 
Normally memory tends to fragment rather badly in Linux.
I suspect after some time your approach will just degenerate to be 
the same as Andrea's, even if it should be a win at the beginning (is it?)

-Andi

