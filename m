Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314272AbSDVQxZ>; Mon, 22 Apr 2002 12:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314274AbSDVQxY>; Mon, 22 Apr 2002 12:53:24 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:11525 "HELO holly.csn.ul.ie")
	by vger.kernel.org with SMTP id <S314272AbSDVQxX>;
	Mon, 22 Apr 2002 12:53:23 -0400
Date: Mon, 22 Apr 2002 17:52:11 +0100 (IST)
From: Mel <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vmalloc comments patch
In-Reply-To: <E16zI1f-0001F9-00@starship>
Message-ID: <Pine.LNX.4.44.0204221717270.14168-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Apr 2002, Daniel Phillips wrote:

> > +	/* A PMD can be bad if it's either read only or the accessed or dirty
> > +	 * bits are not cleared
> > +	 */
>
> Classic 'Linus' multi-line comment style looks like this:
>
> /*
>  * The comment goes here
>  * and so on
>  */
>

Do you mean that multi-line comments should be on the left hand margin?
It's not something I see adhered to in other parts of the mm tree.

> Just goes to show, there's not way to make /* bracket comments */ look
> nice ;-)
>

Too true unfortunatly

> > +	/* Treat the address as if it starts from 0 relative to the beginning
> > +	 * of the PMD*/
>
> IOW, it's an offset.

Rephrased to

/* Treat the address as an offset relative to the PMD */

> This is a (minor) flaw in the api.  Address should
> be passed as (void *) and we should have:
>
> 	ulong offset = address &= ~PMD_MASK;
>
> Granted, such cleanupd are not the goal of your patch.
>

no it's not, but I made a note of it. Later on, if someone else hasn't
done the cleanup on this type of thing, I'll take a look at it. Right now,
I felt there was enough coders in the mm/ tree without me jumping in as
well. I'm hoping at the end of all this commentry, the barrier to entry
for doing any examination of the vm will be lower.

>
> >+	/* If this free would need to go to the next PGD, make sure we
> >+	* exit out at the end of this PGD
> >+	*/
>
> Whitespace glitch here.
>

Fixed

> > +		/* The page table is unlocked because we don't need to traverse
> > +		 * the page tables while a page is been allocated. As
> > +		 * alloc_page could block for a long time, let go the lock
> > +		 */
> >  		spin_unlock(&init_mm.page_table_lock);
> >  		page = alloc_page(gfp_mask);
> >  		spin_lock(&init_mm.page_table_lock);
>
> Actually, the spinlock is dropped because alloc_page can sleep, which is a
> bug if you are holding a spinlock.
>

yep, was pointed out to me already. Comment is updated.

> > +		/* QUERY: If this is true, it means someone allocated took this
>
> Typo here.
>

fixed

> > +	/* This is a bit subtle
> > +	 * The PGD bits of the address are masked out so it's like the first
> > +	 * PMD is now at address 0 and end will be size. This way we know not
> > +	 * to go beyound the end of the PMD entry
> > +	 */
>
> It's not subtle, it's just awkwardly written.  We should have ulong offset and
> void *address.  The masking is a meme in Linux mm and does not require a
> comment.
>

Not been aware of all the mm memes, it took me a while to work out.
Granted it's second nature to me now, it wasn't when I first started
reading. Should I remove the comment or leave it there for people who
could read it and not have to scribble out bitmaps to see what happens?

> > +		 * QUERY: Again, the return value will be ignored, was it
> > +		 *        originally intended to pass this up to the higher
> > +		 *        caller functions?
>
> If so, it's a 'fixme'.
>

Agreed, but at the moment, I'm commenting on what is there, not what I
think is meant to be there. If it's a fixme, I presume that people who
know for a fact it's a fixme will flag it as such.

> > +	/* size reaches the end of the linear address needed for this
> > +	 * allocation
> > +	 */
>
> This comment is too much like:	x = 1 /* assign 1 to x */
>

Agreed, removed.

> > +		/* Return -ENOMEM if a PMD could not be allocated
>
> Same category as above.
>

Again, removed

> > +		 *
> > +		 * NOTE: Doesn't matter what vmalloc_area_pages actually
> > +		 *       returns as long as it's non-zero.
> > +		 */
>
> But this part is somewhat interesting.
>

I left the note in. I felt it was the most reliable way of finding out if
that is the intended behaviour.

> > +		/* QUERY: Dead code? ret was set a few lines ago */
> >  		ret = -ENOMEM;
>
> It certainly is.
>

When (or if) I try to submit cleanup patches, I'll remove the dead code
and the comment. For the moment, I'll leave it in for other people
actively coding the vm.

> > +
> > +		/* Allocate all the PTE's needed for this PMD and in turn
> > +		 * allocate the page frames
> > +		 */
> >  		if (alloc_area_pmd(pmd, address, end - address, gfp_mask, prot))
> >  			break;
>
> Redundant comment.  You can look at the comment on alloc_are_pmd to know that,
> and the name says it as well.
>

Removed.

> Well, I'm only about 20% of the way through the patch and have other work to
> attend to.  I suggest that you now try to *remove* as much redundant verbiage
> as you can.

I've tuned down the verbosity and will make any future patch less verbose.
While I've been looking at this a while myself and now understand most of
it, I didn't want to presume too much advance knowledge for peopl who
would be reading this for the first time

> You should really assume a somewhat higher level of familiarity
> with Linux basics.  Just as a guess, you should end up with less than half
> the text you've proposed adding.
>

I'm not sure what level to set this at yet, I was hoping for a few mails
that told me "Too Verbose or not verbose enough because...." to help me
gauge. From someone who first read this a few months ago though, I would
have been a lot happier if the comments had been available so I didn't
have to second guess the developer

There is a second reason why I'm been so verbose. The code says perfectly
what it is doing but comments say what it is meant to be doing. I am
presuming that people who helped write the vm will see the comments and
confirm if they are right. i.e. are the comments (and code) as they stand
doing what they were intended to do. If the comments are wrong, I'm pretty
sure they will take great delight in telling me how wrong I am. But if I'm
right and the code sometimes has unintentional side effects, things will
probably get fixed. Granted, I don't expect to actually find any serious
bug

I'll cut down on the verbosity a bit on the vmalloc, but the verbosity of
the commentry will be still relatively high, especially in comparison to
how verbose (or non-existant) the comments currently are.

> That said, I found some of your comments to be informative even though I'm
> familiar with this particular piece of code.  For someone not familiar with
> it but familiar with Linux in general, your additional comments will save
> time in reading the code.
>

Who, ultimatly, are the people this is aimed at.

> IMHO, with some more work this will be a useful contribution.
>

Thanks, I intend to keep working on it and thanks for the commentry

			Mel

