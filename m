Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317176AbSIEG7O>; Thu, 5 Sep 2002 02:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317189AbSIEG7O>; Thu, 5 Sep 2002 02:59:14 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:59272 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317176AbSIEG7M>; Thu, 5 Sep 2002 02:59:12 -0400
Date: Thu, 5 Sep 2002 12:33:31 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: One more bio for for floppy users in 2.5.33..
Message-ID: <20020905123331.A1984@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <200209040725.g847PrUv089710@northrelay01.pok.ibm.com> <Pine.LNX.4.44.0209040930110.1779-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0209040930110.1779-100000@home.transmeta.com>; from torvalds@transmeta.com on Wed, Sep 04, 2002 at 09:36:42AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2002 at 09:36:42AM -0700, Linus Torvalds wrote:
> 
> On Wed, 4 Sep 2002, Suparna Bhattacharya wrote:
> > 
> > Oh yes, even I had this fixed this in the bio traversal patches 
> > I had posted (had this in the core patch, and mentioned it 
> > in the description in the note :) ), guess it went unnoticed.
> 
> Well, I've never seen a "this should go in" about it.
> 
> Also, it was apparently mixed up with the "bio splitup" stuff, which was 

True, that fix ought to have gone in as a separate patch. As Jens said, 
it was like we all knew it had to be fixed, but maybe no one quite saw 
the urgency till the case that used it came about. 

Barthlomeij actually raised another point about the situation when the
partial completion happens with an error (i.e. not uptodate case), a situation
which doesn't automatically get handled correctly. Something to think
about ?

> discussed at least with Jens, and I feel strongly that we shouldn't split, 
> we should build up. Jens was working on exactly that.
> 
> In other words, I absolutely hate the fact that a major bug-fix was 
>  (a) not marked as such and sent to me
> and
>  (b) mixed up with experimental work for other drivers

I agree. The fix was a matter on the side. I'd expected it to have gone
in otherwise anyway, since it wasn't something new I'd discovered. It 
was perhaps just so obvious that it didn't happen so far !

I couldn't resist bringing it up in this context, because I really wanted
some critical feedback about whether the approach seemed right, or 
whether I should just let the patch lie by the side till someone found a use 
for it, without having feeling guilty about having abandoned it and not 
following it through enough. At least at Ottawa it sounded like this was
something people were interested in, and that was the whole reason for
my doing in the first place. (Will get to the bio splitting point later
down the line).

After all, getting all drivers fixed up to adhere to this would require 
some work, something I know I can't do on my own (I just
don't understand the subtleties that someone more familiar which them
would), and which won't be right to cause others  to handle unless people
felt it was the correct and useful thing to do. 

I don't even mind dropping it if it seems like a "not now" or "not right"
thing (I already seem to spent more effort on this then I probably should 
have), but at least after a bit of discussion to take it to that point.

> 
> Even now (assuming I hadn't fixed it on my own), I would have preferred to
> get that fix separately, as it would have impacted the floppy driver, for
> example (the fix broke the floppy driver even more than it was before,
> because the floppy driver was stupidly trying to work around the original
> bug by hand).
> 
> Imagine what a horror it is to figure out why a large experimental patch 
> breaks an existing driver? My first reaction would have been to just throw 
> the large new patch away, since it obviously broke the floppy even more. 
> Instead, if I had been passed the bug-fix only, and the floppy had broken 
> worse that it was originally, it would have been absolutely _obvious_ 
> where the problem was.
> 
> In short: please please PLEASE keep fixes to existing code separate from 
> new stuff. It makes everything easier, and I have absolutely no problems 
> with applying "obvious fixes" even if they might break something else.

OK. 

> 
> In contrast, the new stuff I really don't know if it should go in at all, 
> considering that it's trivial (and CPU-efficient) to build up legal bio 
> request on the fly and _not_ depend on splitting them later (or at least 
> making splitting a special thing only used by things like MD and other 
> such indirection layers).

This is exactly the kind of feedback or discussion I need. 

The patch actually addresses a set of problems and not just bio splitting.

Ideally I'd have liked to separately handle different problems differently
in separate patches. In fact that's the way I had started out at first, 
only to realise that things become much simpler or cleaner to implement, 
if we treat this as a whole (excluding the bug fix above) as a basic 
traversal logic change.

The problems are like this:

Today partial segment completion of a bio affects the bv_offset and bv_len
fields in the vecs themselves, because there is nothing in the bio to 
remember how far we are inside a current segment (and as deriving that by
calculating it backwards from bi_size and bi_vcnt could be inefficient).
This means that a higher layer which has passed a vector to bio can't 
assume that the vec entries would be valid after the i/o is completed. 
So though we have a uniform vec abstraction, passing it around subsystems
seamlessly may throw up some unexpected results. (Just that are likely
not to hit this often, which is why we don't hear complaints about it)

Today, it is hard to handle partial submission of a request/bio where
partial submission state has to be remembered across function invokations
(or interrupts) without making a copy of the request _and_ its corresponding 
bios (together with vectors), since the block layer traversal functions 
combine traversal and completion without a clear concept of separation 
between submission and completion state within a request. IDE mult-count 
PIO is of course a case in point. Not sure if there are others.

Today a bio cannot be split in the middle of a segment, which means that
MD or other such indirection layers need to do their own bvec allocations
in such cases. Once we have bio with has a different start offset from the
first bvec's start, we lose some simplicity (which is why I'm not
sure if all drivers necessarily need to support such bio s the first time
around). But with such a field in the bio (bi_voffset), we can use 
that as a moving counter during traversal. (BTW, an extra field may not  
have been indispensable if we didn't need to separate submission and 
completion state, e.g. rq->current_nr_sectors might work for just this 
purpose as well, and that was what I was planning to try before Jens 
suggested going ahead with bi_voffset, but then found it handy to
manage completion state separately from submission state).

BTW, I agree splitting truly becomes an issue mainly in the
case of such layered drivers, in other cases it is a good idea to build
before hand; but for indirection drivers it _is_ an issue ... one can't expect
to predict all situations and that would limit flexibility there.

Another point that I've always wanted to bring up is that the moment we
get to a need to divide an i/o into separate requests either to a single
or multiple drivers, we _are_ doing an allocation of the request struct
(using a slot in the pool of available requests for that queue). Building
the right bio sizes doesn't do away with this, does it ?

In any case, special case problem situations can always be dealt with 
special case code, but since we've redesigned the block i/o layer 
the question is whether we've got our abstractions right to deal with 
various requirements at the appropriate level and avoid workarounds 
by drivers or callers into block. 

So rather than look at the above problems individually and frequency
of situations where we can imagine they'd occur in practice, could 
you think about the basics a bit and let me know what you think ?

(a) Not the right away to go at all ?
(b) Think about it later, not now ?
(c) Try and get more pieces working correctly with this and then see ?

One concern that I have with the patches I posted (I did split them 
up last time around, so they look smaller) is the increase in number 
of counters to update / track. This also has the effect of requiring 
updates happen via helpers rather than drivers individually managing 
these counters which is not necessarily a bad thing in itself, but 
I have to say that I was a trifle worried about potential
unexpected side effects in the short run for drivers that make their
own assumptions about these. I was hoping that driver maintainers
would be able to help sound an alert for any issues they see right
away.

Regards
Suparna

> 
> 			Linus
> 
