Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbTIOLc7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 07:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbTIOLc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 07:32:59 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:22401 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261288AbTIOLc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 07:32:56 -0400
Date: Mon, 15 Sep 2003 12:46:33 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200309151146.h8FBkXcw001170@81-2-122-30.bradfords.org.uk>
To: john@grabjohn.com, piggin@cyberone.com.au
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Cc: alan@lxorguk.ukuu.org.uk, davidsen@tmr.com, linux-kernel@vger.kernel.org,
       zwane@linuxpower.ca
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>>>>>>That's a non-issue.  300 bytes matters a lot on some systems.  The
> >>>>>>>fact that there are drivers that are bloated is nothing to do with
> >>>>>>>it.
> >>>>>>>
> >>>>>>Its kind of irrelevant when by saying "Athlon" you've added 128 byte
> >>>>>>alignment to all the cache friendly structure padding.
> >>>>>>
> >>>>>My intention is that we won't have done 128 byte alignments just by
> >>>>>'supporting' Athlons, only if we want to run fast on Athlons.  A
> >>>>>distribution kernel that is intended to boot on all CPUs needs
> >>>>>workarounds for Athlon bugs, but it doesn't need 128 byte alignment.
> >>>>>
> >>>>>Obviously using such a kernel for anything other than getting a system
> >>>>>up and running to compile a better kernel is a Bad Thing, but the
> >>>>>distributions could supply separate Athlon, PIV, and 386 _optimised_
> >>>>>kernels.
> >>>>>
> >>>>Why bother with that complexity? Just use 128 byte lines. This allows
> >>>>a decent generic kernel. The people who have space requirements would
> >>>>only compile what they need anyway.
> >>>>
> >>>So, basically, if you compile a kernel for a 386, but think that maybe
> >>>one day you might need to run it on an Athlon for debugging purposes,
> >>>you use 128 byte padding, because it's not too bad on the 386?  Seems
> >>>pretty wasteful to me when the obvious, simple, elegant solution is to
> >>>allow independent selection of workaround inclusion and optimisation.
> >>>Especially since half of the work has already been done.
> >>>
> >>I missed the "simple, elegant" part. Conceptually elegant maybe.
> >>
> >>If you mean to use the optimise option only to set cache line size, then
> >>that might be a bit saner.
> >>
> >>As far as the case study goes though: if you were worried about being
> >>wasteful, why wouldn't you compile just for the 386 and debug from that?
> >
> >In the model I'm proposing, the 386 kernel would be missing the Athlon
> >workarounds.
>
> No, debug the kernel while its running on the 386.

What if the 386 is a wristwatch, or similar embedded device?

> And what of my other
> concerns?

Since nobody seemed to agree with me, I was sparing the list the
bandwidth, but...

> 1. It doesn't appear to be simple and elegant.

Well, it's obviously not as simple as just using 128 byte padding all
the time, but the basic idea of, 'choose required work-arounds, and
optimisations independently of each other', is fairly simple, (in
concept), and elegant, (as it lets you compile the most finely tuned
binary).

Maybe we are not thinking along the same lines.

Up to now, selecting a CPU to compile for basically means, "Use
compiler optimisations for this CPU, and don't care about
compatibility with anything before it".  Adrian's patch to change this
to an arbitrary bitmap selection of CPUs to support seems like a good
idea to me for two reasons, firstly with increasing numbers of
work-arounds, it's silly to include them all in a kernel for a 386.
Secondly, ever since we included support for optimising for the 686,
the idea that a kernels compiled for progressively more recent CPUs
would be faster than each other on the same hardware has been false -
a kernel compiled for a Pentium is slower on a 686 than a kernel
compiled for a 486 is.

So, if we move from selecting a range of CPUs to support, I.E. 386 ->
whatever, to selecting individual CPUs, E.G. 386, PIV, and Athlon,
there is no question about which workarounds we should include.  By
the way, I am talking about including them at compile time, not
checking at run time whether they are needed - maybe I wasn't clear
about that.  I don't see the point in checking at runtime - any kernel
that supports multiple CPUs is not optimial anyway, so why bother
trying to optimise it at all?  I know there is another way of looking
at it, that distributions will want a kernel that runs on anything,
(well, these days, probably a 486 or higher CPU), that is not
particularly sub-optimial on any CPU, so that users can just install
it, and have it work.  In that case, I totally agree with you that 128
byte padding is the most sensible way to go, but that is a
distribution thing.  Anybody who compiles their own kernel is probably
going to want to compile it for the processor it's destined to run on,
rather than make a generic kernel, unless they are making a boot disk
for emergencies, in which case performance is not usually an issue.
So, the question of which workarounds to include is simple, but what
to do about optimisation?  In the current model, where you are
selecting a range of CPUs to support, (E.G. 386->Pentium), the
question is answered by saying, OK, we'll optimise for the most recent
processor in that range.  With an arbitrary selection, E.G. PIV and
Athlon, which do you pad for?  Whichever is least harmful to
performance on the others?  This is what I meant by simple and elegant
- you just present independent choice to the user in the
configurator.

> 2. It would drive developers nuts if it was used for anything other than
>    a couple of critical functions (cache size would be one).

OK, well by using the 'optimisation' setting simply for setting cache
size alone, you'd still get a nice tunable kernel.  Much better than
just setting it to an arbitrary value.

> 3. Are there valid situations where you would need it? This isn't a
>    rhetorical question. Your example would be fine if somebody really
>    needed to do that.

Personally, I compile specific kernels for all of my boxes separately.
No box runs any kind of generic kernel in normal use, so I'd like to
see as many unnecessary workarounds removed from the code as possible
at compile time, and appropriate compiler optimisations for only the
specific CPU the kernel is destined for.  That maximises kernel
performance on that mahcine.  On the other hand, if I'm working on an
embedded project with a 386 or a 486, I'm usually running the same
environment on a more powerful box as well, for testing purposes, so I
need workarounds for the, (E.G. Athlon), CPU in the development box,
but I don't want performance optimisations for that faster CPU,
especially if they have a negative effect on the embedded CPU.

John.
