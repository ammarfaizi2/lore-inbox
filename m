Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273455AbRIQCQ2>; Sun, 16 Sep 2001 22:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273458AbRIQCQT>; Sun, 16 Sep 2001 22:16:19 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:61708 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S273455AbRIQCQH>; Sun, 16 Sep 2001 22:16:07 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: broken VM in 2.4.10-pre9
Date: Mon, 17 Sep 2001 04:23:41 +0200
X-Mailer: KMail [version 1.3.1]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0109161738110.1054-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0109161738110.1054-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010917021624Z16012-2757+380@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 17, 2001 03:07 am, Linus Torvalds wrote:
> > The 'partially read/written' state isn't handled properly now.  The
> > transition to the 'used-once' state should only occur if the transfer ends at
> > the exact end of the page.  Right now it always takes place after the *first*
> > transfer on the page which is correct only for full-page transfers.
> 
> No, it's not as easy as you make it sound.
> 
> The problem is that partial accesses are real, and they should be counted
> as such - except when they are _linear_ partial accesses, in which case
> they should not be counted at all except for the first one.

Yes, in a really fancy VM manager we'd analyze the access patterns to get a 
reliable determination of what is serial access and what is not, and we'd do 
things like retroactively lowering the priority of pages we didn't initially 
know much about but were later able to determine were part of a serial access.

But we can pick the low-hanging fruit by just looking at where the most 
recent access lands.  This relies on the fact that most serial transfers 
procede forward.  If we get it wrong, a few pages end up referenced when they 
should not be, but so what?  Also, if a page ends up unreferenced when it 
should be then it still has a good chance to be rescued.

> Having some "if transfer ends at end of page" logic would minimally get
> the enf-of-file case wrong,

Right, the condition should be "transfer ends exactly at the lower of the end 
of page or end of file".

> for example, never mind the case of a reader
> that is seeking around in the file. The EOF case could be worked around
> with yet another hack, but I suspect that the real fix is to try to fix
> applications that do bad things.

I'd say this one isn't a hack, its just a matter of finishing the job.
Sorry I should have done tested this a week ago but I got a little
distracted if you know what I mean.

Seeking around in a file will be handled OK.  We'll tend to drop those 
pages that are fully accessed but not reaccessed soon and retain pages that
are partially accessed.  So long as the aging mechanism doesn't drop the
ball, such pages will just live a little longer in cache, not forever.

What we're missing is a way for the swap cache to 'push back' at the page
cache.  Right now, the little bit of extra pressure I accidently created
by ignoring the subpage transfers is pushing all anonymous pages out of
memory.  That's way too fragile.

--
Daniel
