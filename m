Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbWC3TuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWC3TuU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 14:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWC3TuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 14:50:20 -0500
Received: from ns2.suse.de ([195.135.220.15]:38281 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750719AbWC3TuT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 14:50:19 -0500
From: Andi Kleen <ak@suse.de>
To: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] ioremap_cached()
Date: Thu, 30 Mar 2006 21:50:05 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060330164120.GJ13590@parisc-linux.org> <p73zmj7949i.fsf@verdi.suse.de> <20060330193457.GL13590@parisc-linux.org>
In-Reply-To: <20060330193457.GL13590@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603302150.05357.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 March 2006 21:34, Matthew Wilcox wrote:
> On Thu, Mar 30, 2006 at 08:27:53PM +0200, Andi Kleen wrote:
> > Matthew Wilcox <matthew@wil.cx> writes:
> > 
> > > We currently have three ways for getting access to device memory --
> > > ioremap(), ioremap_nocache() and pci_iomap().  99% of the callers of
> > > ioremap() are doing it to access device registers, and really, really
> > > want to use ioremap_nocache() instead.  I presume nobody notices on PCs
> > > because they have write-through caches, but it ought to trip up people
> > > trying to flush writes.
> > 
> > Actually MTRRs take care of that on x86.
> > So essentially on x86 ioremap() for devices is already ioremap_uncached()
> > And ioremap on memory is cached.
> > 
> > That's nice and simple semantics that other platforms can emulate too.
> > Doing things differently will just cause pain for the other platforms
> > when they have to fix up drivers all the time.
> 
> That doesn't make any sense.  What's the point of ioremap_nocache() if
> ioremap() does magic things that make things uncached? 

In theory ioremap_nocache would force uncached even if there is no MTRR
and is better/clearer.

But on x86 there normally is, so lots of code gets it wrong.

My point is just that forcing a semantics that's not enforced
on x86 would be a uphill battle for everybody else. Probably not
a good idea. Better fake x86.

> And who says 
> you're allowed to ioremap() memory anyway?

Why not? There are cases when it's needed.

> > It all works fine until someone wants WC too. I would rather add a 
> > ioremap_wc(), that would be more useful.
> 
> ioremap_wc() sounds like a good idea.

It's unfortunately tricky to get it fully right on x86. The issue
is to have a good way avoid illegal cache aliases. There were some
attempts, but so far they never were polished up from the initial
prototypes.

-Andi
