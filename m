Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262602AbTJPBvQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 21:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262617AbTJPBvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 21:51:16 -0400
Received: from 205-158-62-67.outblaze.com ([205.158.62.67]:55748 "EHLO
	spf13.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S262602AbTJPBvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 21:51:10 -0400
Message-ID: <20031016015105.27987.qmail@email.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Clayton Weaver" <cgweav@email.com>
To: linux-kernel@vger.kernel.org
Cc: jamie@shareable.org
Date: Wed, 15 Oct 2003 20:51:05 -0500
Subject: Re: Circular Convolution scheduler
X-Originating-Ip: 172.138.175.242
X-Originating-Server: ws3-5.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: Jamie Lokier <jamie@shareable.org>
Date: Tue, 14 Oct 2003 11:18:53 +0100
To: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: Circular Convolution scheduler


> Ok, but what is "circular convolution scheduling"?

It was a vague idea that I had for integrating
our current, more-or-less distributed system
of priority scaling heuristics into a single
state model and applying them all at once to a
scheduling decision with a single matrix
multiply. The motivation would be to engineer
out unexpected interactions between different
parts of the heuristic analyses that produce unpredicted (and potentially unwanted) behavior
in the scheduler.

Ad hoc code is fast, but it depends on
implementers being able to model the implied
state machine in their imagination, with the implementation of it distributed across various
code points in the scheduler. This makes isolated simulation and verification (proof that the
scheduler does what we intend it to do)
difficult, and we might get farther faster
by having an implementation of these scheduling-relevant runtime heuristic analyses
that allows us to reliably model scheduler
state in the abstract.

I'm not saying that can't be done with the
present system, it's just a lot harder to be
sure that your model really reflects what is
happening at runtime when you start with ad
hoc code and try to model it than if you start
with a model of a set of state transitions
that does what you want and then
implement/optimize the model.

As other people have pointed out, runtime
scheduler performance is the trump card,
and abstract verifiability that a scheduler
(with heuristic priority scaling) meets a
specified set of state transition constraints
is not much help if you can't implement the
model with code that performs at least as well
as a scheduler with ad-hoc heuristics pasted
in "wherever it looked convenient".

(But you are not likely to need to revert stuff
very often with a heuristic-enhanced scheduler
implemented from a verified formal model,
because you aren't guessing what a code change
is going to do to the state machine. You
already know.)

> Nick Piggin wrote:
> > I don't know anything about it, but I don't see what exactly you'd be
> > trying to predict: the kernel's scheduler _dictates_ scheduling behaviour,
> > obviously. Also, "best use of system resources" wrt scheduling is a big
> > ask considering there isn't one ideal scheduling pattern for all but the
> > most trivial loads, even on a single processor computer (fairness, latency,
> > priority, thoughput, etc). Its difficult to even say one pattern is better
> > than another.

> Hmm.  Prediction is potentially useful.
 
> Instead of an educated ad-hoc pile of heuristics for _dictating_
> scheduling behaviour, you can systematically analyse just what is it
> you're trying to achieve, and design a behaviour which achieves that
> as closely as possible.
 
> This is where good predictors come in: you feed all the possible
> scheduling decisions at any point in time into the predictor, and use
> the output to decide which decision gave the most desired result -
> taking into account the likelihood of future behaviours.  Of course
> you have to optimise this calculation.
 
> This is classical control theory.  In practice it comes up with
> something like what we have already :)  But the design path is
> different, and if you're very thoroughly analytical about it, maybe
> there's a chance of avoiding weird corner behaviours that weren't
> intended.
 
> The down side is that crafted heuristics, like the ones we have, tend
> to run a _lot_ faster.

> -- Jamie

I'm not qualified to comment on the value of
predictive scheduling, although that seems to
me the real intention of heuristics for
interactive process priority adaptation,
to predict that the process is going to need
higher effective priority than what the nominal
nice value of it may indicate, given some
scheduling latency threshold generated from
total time utilization of other concurrent
processes.

Other questions:

What about priority scaling history? Do we want
to try to smooth off spikes in what I think
of as a graph of positive indications of
interactive behavior over time? (I was
remembering someone's comment a while back
about some process doing something that
satisfies one of the heuristics for
interactive behavior and then proceeds to
spend the next 12 hours running code that
doesn't need interactive process priority
scaling. It scaled its effective nice
value to -[whatever] without the user
requesting it, needing it, or wanting it.)

Or do we want to react to spikes in the graph
quickly, with a fast decay in the interactive
process priority scaling factor? While you
are typing, clicking, dragging, digitizing,
etc, you want response right now, but batch
processes running in the background shouldn't
have to pay while you stare at the screen for
10 minutes at a time in between mouse clicks
or keystrokes.

(Or should they? Should people really expect
optimum batch performance on a 2-week simulation running in the background on the same box where
they read their email, play games, listen to
music, browse the web, and expect instant
response to actions on their desktop? Seems a bit
in the way of have-your-cake-and-eat-it-too to
me, but that isn't really relevant to the
discussion, which is about how to make the
scheduler heuristics implementation more
predictable.)
 
What about the X environment? What nice value
are people starting the X server, X session
manager, their window manager (and thus any
helper processes forked by the X server) at?
Don't those things need interactive process
priority scaling along with whatever foreground
process the keystroke or mouse click was intended
for, if you are really going to have snappy
desktop performance concurrent with a
substantial load of background batch processing?
Will the interactive process heuristics pick
up the need to scale the effective priority for
a group of other concurrent processes that the
foreground process depends on, too?

I don't really see how, but feel free to enlighten
me. (I think I'd be starting X, xdm, and
window managers at -19 if I wanted fast
type, click, and drag response under any
conditions.)

[make config option]

People who run purely batch servers will
inevitably see scheduler heuristics for
interactive process priority adaptation as
an unnecessary complication. (Designing the
scheduler originally to get good performance
for non-interactive server processes was not
a silly idea. That's a big market for linux.)
Concentrating the application of heuristics
under the umbrella of a single unified model,
whether it uses convolution or not, would seem
to simplify compiling them out for dedicated
batch servers with a make config option.

What do we do exactly when we get a positive
hit on the interactivity heuristics? Jump
queues in the scheduler to a faster tier?
Shorten time slices in front of us?

For some scheduler issues this is going to be
irrelevant, interactive box or not.
Real-time processes should always be
higher-priority than what you can get from
adaptive priority scaling. All processes
always have to get from the tail of the
scheduling queue to the front of the queue
for sure, no matter what kind of adaptive
priority scaling is happening concurrently.
These would be invariants in a scheduler state
model and in implementation probably outside
the application of a convolution to heuristic
results to obtain adaptive priority scaling
values.

I just don't like to see us trying to hack
around a problem with ad hoc special cases.
For hardware we don't have a choice, the
special cases exist a priori, ditto for
network protocols and patchwork standards
compliance on other systems, but we invented
this scheduler ourselves. One would expect that
we could fix problems with it top-down.

(Maybe that's practical, maybe not. Maybe the
intuition is right but a circular convolution
would be an impractical implementation. The
reason to explore the question is avoidance
of "three steps forward and two steps back"
scheduler code development sequences.)

Regards,

Clayton Weaver
<mailto: cgweav@email.com>

-- 
__________________________________________________________
Sign-up for your own personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

CareerBuilder.com has over 400,000 jobs. Be smarter about your job search
http://corp.mail.com/careers

