Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287817AbSA2AM5>; Mon, 28 Jan 2002 19:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287827AbSA2AMs>; Mon, 28 Jan 2002 19:12:48 -0500
Received: from dsl-213-023-039-090.arcor-ip.net ([213.23.39.90]:54407 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S287817AbSA2AMa>;
	Mon, 28 Jan 2002 19:12:30 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.18pre4aa1
Date: Tue, 29 Jan 2002 01:15:04 +0100
X-Mailer: KMail [version 1.3.2]
Cc: rwhron@earthlink.net, linux-kernel@vger.kernel.org
In-Reply-To: <20020124002342.A630@earthlink.net> <E16VIO8-0000CO-00@starship.berlin> <20020129004001.F1309@athlon.random>
In-Reply-To: <20020129004001.F1309@athlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16VLvU-0000Du-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 29, 2002 12:40 am, Andrea Arcangeli wrote:
> On Mon, Jan 28, 2002 at 09:28:24PM +0100, Daniel Phillips wrote:
> > Just ask around.  Marcelo or Andrew Morton would be a good place to start.
> 
> ah, btw, if you test with a broken page replacement (kind of random)
> it's normal you get huge variations.
> 
> But with my -aa tree, you should never get a significant difference (no
> matter if it's Marcelo or Andrew to run the benchmark).

Oh, that's interesting, and actually I can see why that might be (feedback
in your VM is quite predictable, so it isn't prone to oscillation).  It's
not just the VM that affects dbench's running pattern though, it's also
scheduling.

> I've also to say I always mke2fs first when I run my benchmarks,

Yes, and it would be nice if we had an operation to squeeze cache down to
its minimum size (whatever that means) just for running benchmarks
accurately without rebooting.

> so I don't consider
> possible filesystem layout differences into the equation but I doubt
> (unless you're running with a corner case like running out of space or
> stuff like that), that it will make a significant difference either.

> > > Anyways dbench tells you mostly about elevator etc... it's a good test
> > > to check the elevator is working properly, the ++ must be mixed with the
> > > dots etc... if the elevator is aggressive enough. Of course that means
> > > the elevator is not perfectly fair but that's the whole point about
> > > having an elevator. It is also an interesting test for page replacement,
> > > but with page replacement it would be possible to write a broken
> > > algorithm that produces good numbers, that's the thing I believe to be
> > > bad about dbench (oh, like tiotest fake numbers too of course). Other
> > > than this it just shows rmap12a has an elevator not aggressive enough
> > > which is probably true, I doubt it has anything to do with the VM
> > > changes in rmap (of course rmap design significant overhead is helping
> > > to slow it down too though), more likely the bomb_segments logic from
> > > Andrew that Rik has included, infact the broken page replacement that
> > > lefts old stuff in cache if something might generate more unfairness
> > > that should generate faster dbench numbers for rmap, but on this last
> > > bit I'm not 100% sure (AFIK to get a fast dbench by cheating with the vm
> > > you need to make sure to cache lots of the readahead as well (also the
> > > one not used yet), but I'm not 100% sure on the effect of lefting old
> > > pollution in cache rather than recycling it, I never attempted it).
> > 
> > Interesting analysis.  It's a hint at how hard the elevator problem really 
> > is.  Fairness as in 'equal load distribution' is not the best policy under 
> > heavy load, just as it is not the best policy under heavy swapping.  Exactly 
> 
> as always it depends if the object is throughput or latency, for dbench
> that's the object.
> 
> Also the function between throughtput and latency is not linear and it
> depends on too many factors to find an elevator algorithm that works
> well on the paper.
> 
> So, in function of that, one vapourware idea I had while reading your
> email is to use the feedback from the output througput generated to know
> when it's worthwhile to decrease or increase the latency. If decreasing
> latency doesn't decrease the final throughput generated, that means
> we're ok to decrease latency even more.  As soon as the throughput
> decreases (despite of people waiting on the submit_bh pipeline), we know
> we'd better not decrease latency further, unless we want to hurt
> performance.

But what is the knob by which you control latency?

> The current elevator (not rmap) is always very permissive, so throughput
> is ok in dbench (and anything seeking as hard as dbench), but latency
> often sucks (actually in -aa I decreased the read latency so it's
> acceptable, not like in mainline, but still it's far from being very
> reactive under a write flood). The feedback from the output channel to
> control the latency parameters in a dynamic manner may help to decrease
> latency when possible (not unconditionally with elvtune). One of the
> thing I love about the analog electronics are the operational chips, a
> feedback loop solves so much difficult problems so easily. Software can
> do similar things lots of times.

Oh yes, that's exactly the way I think of these things and I did
experiment with a similar idea earlier this year with my 'early flush with
bandwidth estimation' earlier this year.  What I found is, it's very hard
to get a good 'signal' by tracking kernel statistics.  By the time I
averaged the disk bandwidth enough to get a smooth signal, the lag was way
too high to be useful.  The statistics just aren't very coninuous, so they
tend to resist analysis by analog methods.  Note: they resist analysis,
they don't defy it.

> Anyways this is just vapourware
> (probably quite complex to implement in a generic manner) but fixed
> algorithms are not likely to give us a solution (we'll be either too
> permissive or too slow in dbench), while this kind of feedback sounds
> like something that may solve the problem dynamically, or maybe I'm
> simply just dreaming :).

Well I'm dreaming the same dreams, and by coincidence it's the reason I was
complaining earlier today on lkml about the lack of good muldiv operations
with double-wide intermediate results in the kernel.  Such operators are
needed to do the filtering calculations and so on with enough precision -
and by this, I mean 'enough choices of divisor' more than 'enough bits' -
so the algorithms don't choke on their own noise.

But before you can do signal processing, feedback, or whatever, you have to
have a good signal.

-- 
Daniel
