Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272175AbRHWBjI>; Wed, 22 Aug 2001 21:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272181AbRHWBi7>; Wed, 22 Aug 2001 21:38:59 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:57095 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S272175AbRHWBio>; Wed, 22 Aug 2001 21:38:44 -0400
Date: Wed, 22 Aug 2001 21:10:44 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: tommy@teatime.com.tw, Linux Kernel <linux-kernel@vger.kernel.org>,
        Ben LaHaise <bcrl@redhat.com>
Subject: Re: Memory Problem in 2.4.9 ?
In-Reply-To: <20010823010444Z16129-32383+926@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.21.0108222103261.2685-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 23 Aug 2001, Daniel Phillips wrote:

> On August 22, 2001 09:05 pm, Marcelo Tosatti wrote:
> > On Wed, 22 Aug 2001, Daniel Phillips wrote:
> > > What can we do right now?  We could always just comment out the alloc failed 
> > > message.  The result will be a lot of busy waiting on dirty page writeout 
> > > which will work but it will keep us from focussing on the question: how did 
> > > we get so short of bounce buffers?  Well, maybe we are submitting too much IO 
> > > without intelligent throttling (/me waves at Ben).  That sounds like the 
> > > place to attack first.
> > 
> > We can just wait on the writeout of lowmem buffers at page_launder()
> > (which will not cause IO buffering since we are doing lowmem IO, duh), and
> > then we are done.
> > 
> > Take a look at the patch I posted before (__GFP_NOBOUNCE). 
> 
> A little light reading for a Wednesday afternoon ;-)
> 
> Nice hack, way to go.  So this will wait synchronously in try_to_free_buffers
> if we have to go around twice in alloc_bounce_page or alloc_bounce_bh (the
> latter eventually resulting in a page_alloc from kmem_cache grow).

Not synchronously, no. It will just allow allocations trying to get memory
for bounce buffering to block on lowmem IO.

With this behaviour, its safe to completly remove Ingo's emergency scheme.

> What does SLAB_LEVEL_MASK do?  Did you find out by hitting the BUG when you
> tried the patch?  Anyway, it needs a comment.

SLAB_LEVEL_MASK is the mask for SLAB-valid allocations.

> I had in mind a completely different approach to try, using a semaphore to
> count bounce buffers, and block when they run out.  Your patch fits the
> pattern of the current busy-waiting strategy much better.  It's the right
> thing to do.
> 
> OK, race you to the next bug ;-)


