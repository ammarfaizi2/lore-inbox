Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750939AbWABScY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbWABScY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 13:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750940AbWABScY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 13:32:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59881 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750933AbWABScX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 13:32:23 -0500
Date: Mon, 2 Jan 2006 10:28:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: mingo@elte.hu, tim@physik3.uni-rostock.de, arjan@infradead.org,
       torvalds@osdl.org, davej@redhat.com, linux-kernel@vger.kernel.org,
       mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-Id: <20060102102824.4c7ff9ad.akpm@osdl.org>
In-Reply-To: <20060102134228.GC17398@stusta.de>
References: <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org>
	<Pine.LNX.4.64.0512291322560.3298@g5.osdl.org>
	<20051229224839.GA12247@elte.hu>
	<1135897092.2935.81.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.63.0512300035550.2747@gockel.physik3.uni-rostock.de>
	<20051230074916.GC25637@elte.hu>
	<20051231143800.GJ3811@stusta.de>
	<20051231144534.GA5826@elte.hu>
	<20051231150831.GL3811@stusta.de>
	<20060102103721.GA8701@elte.hu>
	<20060102134228.GC17398@stusta.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> On Mon, Jan 02, 2006 at 11:37:21AM +0100, Ingo Molnar wrote:
> >...
> > to say it loud and clear again: our current way of handling inlines is 
> > _FUNDAMENTALLY BROKEN_. To me this means that fundamental changes are 
> > needed for the _mechanics_ and meaning of inlines. We default to 'always 
> > inline' which has a current information to noise ratio of 1:10 perhaps.  
> > My patch changes the mechanics and meaning of inlines, and pretty much 
> > anything else but a change to the meaning of inlines will still result 
> > in the same scenario occuring over and over again.
> 
> Let's emphasize what we both agree on:
> It is _FUNDAMENTALLY BROKEN_ that too much code is marked as
> 'always inline'.
> 
> We only disagree on how to achieve an improvement.
> 

The best approach is to manually review and fix up all the inline statements.

We cannot just delete them all, because that would cause performance loss
for well-chosen inlinings when using gcc-3.

I'd be reluctant to trust gcc-4 to do the right thing in all cases.  If the
compiler fails to inline functions in certain critical cases we'll suffer
some performance loss and the source of that performance loss will be
utterly obscure.

If someone types `inline' into a piece of code then we want to inline the
function, dammit.  The fact that lots of people typed `inline' when they
shouldn't have is not a good argument for defeating (or adding uncertainty
to) manual inlining in well-developed and well-maintained code.

All those squillions of bogus inlines which you've identified are probably
mainly in code we just don't care about much.  We shouldn't penalise
well-maintained code because of legacy problems in less well-maintained
code.
