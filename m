Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272195AbRHWCrh>; Wed, 22 Aug 2001 22:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272196AbRHWCr0>; Wed, 22 Aug 2001 22:47:26 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:524 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S272195AbRHWCrT>; Wed, 22 Aug 2001 22:47:19 -0400
Date: Wed, 22 Aug 2001 22:19:19 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: tommy@teatime.com.tw, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Memory Problem in 2.4.9 ?
In-Reply-To: <20010823022243Z16060-32383+932@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.21.0108222217120.2685-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 23 Aug 2001, Daniel Phillips wrote:

> On August 23, 2001 02:10 am, Marcelo Tosatti wrote:
> > On Thu, 23 Aug 2001, Daniel Phillips wrote:
> > 
> > > On August 22, 2001 09:05 pm, Marcelo Tosatti wrote:
> > > > On Wed, 22 Aug 2001, Daniel Phillips wrote:
> > > > > What can we do right now?  We could always just comment out the alloc failed 
> > > > > message.  The result will be a lot of busy waiting on dirty page writeout 
> > > > > which will work but it will keep us from focussing on the question: how did 
> > > > > we get so short of bounce buffers?  Well, maybe we are submitting too much IO 
> > > > > without intelligent throttling (/me waves at Ben).  That sounds like the 
> > > > > place to attack first.
> > > > 
> > > > We can just wait on the writeout of lowmem buffers at page_launder()
> > > > (which will not cause IO buffering since we are doing lowmem IO, duh), and
> > > > then we are done.
> > > > 
> > > > Take a look at the patch I posted before (__GFP_NOBOUNCE). 
> > > 
> > > A little light reading for a Wednesday afternoon ;-)
> > > 
> > > Nice hack, way to go.  So this will wait synchronously in try_to_free_buffers
> > > if we have to go around twice in alloc_bounce_page or alloc_bounce_bh (the
> > > latter eventually resulting in a page_alloc from kmem_cache grow).
> > 
> > Not synchronously, no. It will just allow allocations trying to get memory
> > for bounce buffering to block on lowmem IO.
> 
> Whoops, it's been a while since I read page_launder.  Hey!  Major cleanup.
> It's much easier to understand what it's doing now.
> 
> OK, sync_page_buffers no longer does what its name says, or implements what
> its comment says it does.  Now the GFP_WAIT just means wait on already-locked
> buffers so that IO can be initiated.  (By the way, there are bunch of
> comments in try_to_free_buffers that lie now.)  OK, so the busy wait is
> implemented in alloc_bounce_page, and page_launder is just used to start IO,
> fine.  Hmm, I think I will try my semaphore idea, not because you haven't
> solved the problem, but because I think a lot of CPU-wasting trips into
> page_launder could be eliminated.  (A 2.5 thing of course.)

There is no real CPU-wasting trips into page_launder().

As soon as we find a dirty, lowmem, unlocked page with ->buffers, we block
on IO there.

> > With this behaviour, its safe to completly remove Ingo's emergency scheme.
> 
> Yes, so why don't you add that to your patch, and also the correction to the
> page->zone test and call it [PATCH]?

Will do it soon.
> 
> > > What does SLAB_LEVEL_MASK do?  Did you find out by hitting the BUG when you
> > > tried the patch?  Anyway, it needs a comment.
> > 
> > SLAB_LEVEL_MASK is the mask for SLAB-valid allocations.
> 
> And "LEVEL" means?

No idea. Nothing, probably. 

