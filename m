Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277827AbRJIQuE>; Tue, 9 Oct 2001 12:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277823AbRJIQts>; Tue, 9 Oct 2001 12:49:48 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:65354 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S277822AbRJIQt2>; Tue, 9 Oct 2001 12:49:28 -0400
Date: Tue, 9 Oct 2001 18:49:12 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: pre6 VM issues
Message-ID: <20011009184912.H12727@athlon.random>
In-Reply-To: <20011009173937.M15943@athlon.random> <Pine.LNX.4.21.0110091303380.5604-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0110091303380.5604-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Tue, Oct 09, 2001 at 01:08:14PM -0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2001 at 01:08:14PM -0200, Marcelo Tosatti wrote:
> Sorry but the infinite loop does throttles page reclamation until there
> is enough memory for the process allocating memory to go on.

If you think we're missing throttling and you add the infinite loop,
yes, you'll hide the lack of throttling by looping at full cpu speed
rather than using the cpu for more useful things, but that doesn't mean
that the looping in itself is adding throttling, a loop can't add
throttling.

> > > just way too fragile IMO and it is _prone_ to fail in intensive
> > > loads. 
> > 
> > It is too fragile if the vm is doing the wrong actions and so we must
> > loop over and over again before it finally does the right thing.
> > 
> > If allocation fails that's a nice feedback that tell us "the memory
> > balancing is at least inefficient in doing the right thing, looping
> > would only waste more cache and more time for the allocation".
> > 
> > Think a list where pages can be only freeable or unfreeable.  Now scan
> > _all_ the pages and free all the freeable ones. Finished. If it failed
> > and it couldn't free anything it means there was nothing to free so
> > we're oom. How can that be "fragile"?
> 
> That is fragile IMHO, Andrea.

Mind to explain "why"? Of course you can't because it isn't fragile,
period.

If you have a list and the elements that can be freeable or unfreeable,
and you scan the whole with all the locks held and you free everything
freeable that you find in your way, you know that if you didn't free
anything after the scan completed, it means you're oom.

As said real world is more complex, but the example above is really
obvious.

> The infinite loop is simple, reliable logic which shows to works (as long
> as the OOM killer is working correctly).

The infinite loop adds oom deadlocks and hides the real problems in the
memory balancing.

> If the OOM killer is doing its job correctly, a deadlock will not happen.

I quote my first email about pre4 (I think I CC'ed you too):

	".. think if the oom-selected task is looping trying to free memory, it
	won't care about the signal you sent to it .."

and that was just a simple case, there are more problems, the above one
can be esaily fixed with a simple check for signal pending within the
loop, that is currently still missing and that you seems not to care to
add even after I mentioned this exact problem as soon as pre4 is been
released (that I didn't fixed because I'm not using the loop and because
there would be other problems and I don't need the loop just to detect
oom).

I think it's useless to keep discussing this, not matter what I say and
the problem I'm raising, you will keep thinking the loop is the right
way as far I can see.

Andrea
