Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287684AbSA1XjF>; Mon, 28 Jan 2002 18:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287697AbSA1Xiz>; Mon, 28 Jan 2002 18:38:55 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:25424 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S287684AbSA1Xip>; Mon, 28 Jan 2002 18:38:45 -0500
Date: Tue, 29 Jan 2002 00:40:01 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: rwhron@earthlink.net, linux-kernel@vger.kernel.org
Subject: Re: 2.4.18pre4aa1
Message-ID: <20020129004001.F1309@athlon.random>
In-Reply-To: <20020124002342.A630@earthlink.net> <E16V8Te-00008L-00@starship.berlin> <20020128162916.B1309@athlon.random> <E16VIO8-0000CO-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <E16VIO8-0000CO-00@starship.berlin>; from phillips@bonn-fries.net on Mon, Jan 28, 2002 at 09:28:24PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2002 at 09:28:24PM +0100, Daniel Phillips wrote:
> Just ask around.  Marcelo or Andrew Morton would be a good place to start.

ah, btw, if you test with a broken page replacement (kind of random)
it's normal you get huge variations.

But with my -aa tree, you should never get a significant difference (no
matter if it's Marcelo or Andrew to run the benchmark). I've also to say
I always mke2fs first when I run my benchmarks, so I don't consider
possible filesystem layout differences into the equation but I doubt
(unless you're running with a corner case like running out of space or
stuff like that), that it will make a significant difference either.

> > Anyways dbench tells you mostly about elevator etc... it's a good test
> > to check the elevator is working properly, the ++ must be mixed with the
> > dots etc... if the elevator is aggressive enough. Of course that means
> > the elevator is not perfectly fair but that's the whole point about
> > having an elevator. It is also an interesting test for page replacement,
> > but with page replacement it would be possible to write a broken
> > algorithm that produces good numbers, that's the thing I believe to be
> > bad about dbench (oh, like tiotest fake numbers too of course). Other
> > than this it just shows rmap12a has an elevator not aggressive enough
> > which is probably true, I doubt it has anything to do with the VM
> > changes in rmap (of course rmap design significant overhead is helping
> > to slow it down too though), more likely the bomb_segments logic from
> > Andrew that Rik has included, infact the broken page replacement that
> > lefts old stuff in cache if something might generate more unfairness
> > that should generate faster dbench numbers for rmap, but on this last
> > bit I'm not 100% sure (AFIK to get a fast dbench by cheating with the vm
> > you need to make sure to cache lots of the readahead as well (also the
> > one not used yet), but I'm not 100% sure on the effect of lefting old
> > pollution in cache rather than recycling it, I never attempted it).
> 
> Interesting analysis.  It's a hint at how hard the elevator problem really 
> is.  Fairness as in 'equal load distribution' is not the best policy under 
> heavy load, just as it is not the best policy under heavy swapping.  Exactly 

as always it depends if the object is throughput or latency, for dbench
that's the object.

Also the function between throughtput and latency is not linear and it
depends on too many factors to find an elevator algorithm that works
well on the paper.

So, in function of that, one vapourware idea I had while reading your
email is to use the feedback from the output througput generated to know
when it's worthwhile to decrease or increase the latency. If decreasing
latency doesn't decrease the final throughput generated, that means
we're ok to decrease latency even more.  As soon as the throughput
decreases (despite of people waiting on the submit_bh pipeline), we know
we'd better not decrease latency further, unless we want to hurt
performance.

The current elevator (not rmap) is always very permissive, so throughput
is ok in dbench (and anything seeking as hard as dbench), but latency
often sucks (actually in -aa I decreased the read latency so it's
acceptable, not like in mainline, but still it's far from being very
reactive under a write flood). The feedback from the output channel to
control the latency parameters in a dynamic manner may help to decrease
latency when possible (not unconditionally with elvtune). One of the
thing I love about the analog electronics are the operational chips, a
feedback loop solves so much difficult problems so easily. Software can
do similar things lots of times. Anyways this is just vapourware
(probably quite complex to implement in a generic manner) but fixed
algorithms are not likely to give us a solution (we'll be either too
permissive or too slow in dbench), while this kind of feedback sounds
like something that may solve the problem dynamically, or maybe I'm
simply just dreaming :).

> what kind of unfairness is best, though, is a deep, difficult question.  I'll 
> bet it doesn't get seriously addressed even in this kernel cycle, or at best, 
> very late in the cycle after the big infrastructure changes settle down.
> 
> -- 
> Daniel


Andrea
