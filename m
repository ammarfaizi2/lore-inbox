Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263199AbTIARtg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 13:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263210AbTIARtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 13:49:36 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:63397
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263199AbTIARtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 13:49:32 -0400
Date: Mon, 1 Sep 2003 19:50:08 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo@parcelfarce.linux.theplanet.co.uk>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Andrea VM changes
Message-ID: <20030901175008.GK11503@dualathlon.random>
References: <Pine.LNX.4.44.0308311353170.15412-100000@logos.cnet> <Pine.LNX.4.44.0309011426390.5932-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309011426390.5932-100000@logos.cnet>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01, 2003 at 02:27:07PM -0300, Marcelo Tosatti wrote:
> 
> Mind to answer this message Andrea?

part 1 is correct. non __GFP_IO only shrinks the cache. This was mostly
a feature for some place that is calling GFP_ATOMIC by mistake, and they
shoud call GFP_NOIO, they don't want to slowdown too much, usually
they're in realtime context. However it should be safe to set
failed_swapout to zero always too.

part 2 is the thing that avoids the kernel to deadlock during oom, the
first time I scan the whole vm and nothing was freeable I stop trying
otherwise it takes way too long to handle oom gracefully.

I've another message from you in queue.

Feel free to ask for more details.

> On Sun, 31 Aug 2003, Marcelo Tosatti wrote:
> 
> > 
> > 
> > On Sat, 30 Aug 2003, Andrea Arcangeli wrote:
> > 
> > > On Sat, Aug 30, 2003 at 12:13:57PM -0300, Marcelo Tosatti wrote:
> > > > 
> > > > > You need to integrate with -aa on the VM.  It has been hard enough for
> > > > > Andrea to get his stuff in, I doubt you will fair any better.
> > > > 
> > > > Thats because I never received separate patches which make sense one by
> > > > one.  Most of Andreas changes are all grouped into few big patches that
> > > > only he knows the mess. That is not the way to merge things.
> > > > 
> > > > I want to work out with him after I merge other stuff to address that.
> > > 
> > > that's true for only one patch, the others are pretty orthogonal after
> > > Andrew helped splitting them:
> > > 
> > > 
> > > 05_vm_03_vm_tunables-4
> > > 05_vm_05_zone_accounting-2
> > > 05_vm_06_swap_out-3
> > 
> > Help me understand something about this patch. In try_to_free_pages(), you
> > set failed_swapout to zero in case we are under __GFP_IO. And
> > failed_swapout decides whether we swap_out() or not.
> > 
> > So basically with -aa swap_out() is only called by __GFP_IO tasks (which
> > are throttled by the page laundering code in shrink_cache) and in mainline
> > non __GFP_IO tasks do swap_out() (and those are not throttled by anything).
> > 
> > Did I understood this right? 
> > 
> > Part 2:
> > 
> > Now in try_to_free_pages_zone() and shrink_cache you have: 
> > 
> >     if (!*failed_swapout)
> >         *failed_swapout =  !swap_out(classzone);
> > 
> > Which means: Keep trying to swap_out() only in case swap_out()  
> > successfully desactivates nr_pages pte's. Right? Do you do that to avoid
> > terrible expensive swap_out() loops which dont successfully free pages?
> > 
> > Thanks
> > 
> > 
> > 
> > 
> > 
> 


Andrea
