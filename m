Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964770AbWIQJUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964770AbWIQJUI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 05:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbWIQJUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 05:20:08 -0400
Received: from opersys.com ([64.40.108.71]:64010 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S932411AbWIQJUF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 05:20:05 -0400
Message-ID: <450D182B.9060300@opersys.com>
Date: Sun, 17 Sep 2006 05:40:59 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Ingo Molnar <mingo@elte.hu>, Ingo Molnar <mingo@redhat.com>,
       Jes Sorensen <jes@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Roman Zippel <zippel@linux-m68k.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Paul Mundt <lethal@linux-sh.org>, Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: The emperor is naked: why *comprehensive* static markup belongs in
 mainline
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Time and again we've had this debate. In the past many claimed,
and many continue to claim, that the mainlining of static markup
of key kernel events (i.e. otherwise designated as static
instrumentation or static tracing) is heresy. The following is
meant as a case-in-point rebuttal.

First, some historical context:
-------------------------------

I personally introduced the Linux Trace Toolkit in July 1999.
Subsequently, I initiated discussions with the IBM DProbes
team back in 2000 and thereafter implemented facilities for
enabling dynamically-inserted probes to route their events
through ltt -- all of which was functional as of November
2000. Further down the road, many efforts were made for mainlining
some of ltt's functionality, with little success. Fast forward
a few years, maintenance of the project has been passed to
Mathieu Desnoyers as of November of 2005. Mathieu inherited
from the project but the name, his is an entire rewrite of
everything I had done.

[ Disclaimer: The following is *not* an attempt to push ltt
specifically. Rather, it is an argument for the inclusion of
*comprehensive* static markup, regardless of the underlying
tool. Whether the reader cares to take my word on this or not
isn't within my ability to influence as I write this. Hopefully
those who choose to continue reading will confirm my stated
goal. ]

Parallel to that, for various reasons which have been
documented elsewhere, a variety of different projects were
initiated in and around the similar scope or nature or as
an outgrowth of existing relevant components. Here are but a
few in no particular order: LKST, syscalltrack, SystemTap, LKET,
GKHI, evlog, kernel hooks, kprobes, relayfs, etc. LTT having
been the first to attempt mainlining, and miserably fail at it,
many of those involved in those other projects paid special
attention to LTT's fate on lkml -- and they were wise to do so.
Some of the criticism against LTT was entirely warranted: it
had many technical flaws -- simply because I was learning the
ropes of kernel development. But while technical flaws could
have been overcome with appropriate guidance, systematic
resistance to mainline static instrumentation could not.

There was/is also a slew of heavily-tailored subsystem-specific
and kernel-debugging/specialized tracing mechanisms that
flourished, died or, surprisingly, got mainlined: iotrace,
latency-trace, blktrace, ktrace, kft, and many others. Usually
some source greping yields to interesting discoveries in
mainline. The history of these has been entirely independent
from that of those other efforts mentioned above mainly in
that they were mostly developed by/for kernel developers.

The commonly held wisdom:
-------------------------

Now, orthodox Linux kernel development philosophy, in as far
I've experienced it online and face-to-face with various
developers, has been that *any* form of static instrumentation
is to be avoided. And the single argument that has constantly
come back has always been that such instrumentation creates
unmaintainable bloat. Factoring in that most developers, at
least the ones I spoke to while being a maintainer, could
only conceive of kernel tracing as they themselves had used
it (i.e. for kernel debugging) and you get an unsurmountable
obstacle for anyone pushing for inclusion of such functionality.

[ This misconception was so profound that many initially labeled
ltt as a kernel debugging tool. Even educated observers from
reputable Linux news sources repeatedly mislabeled ltt. The
misconception went so far that prominent kernel developers
tried to use ltt or attempted helping others use ltt for kernel
debugging purposes, which it obviously wasn't much good at. ]

So what was the solution I asked? And the answer was: none. I
was told I would likely have to maintain ltt out of tree
forever. But I don't give up easily and I figured time would
show purpose, namely that ordinary sysadmins and developers
actually need to understand the dynamic behavior of the
kernel they're using.

The "perfect" solution:
-----------------------

And sure enough, eventually, truth came knocking. And truth
had a name. It was called dtrace. All of a sudden, everybody
and his little sister insisted Linux should have an equivalent.
I'll spare the reader all the political stuff in between, but
I'll readily admit to this: ltt wasn't a dtrace substitute.
While it did target the right audience, it lacked the ability
to allow the user to arbitrarily control instrumentation at
runtime.

[ I've claimed in the past, not without some bitterness I
confess, that history might have been different had ltt been
given a chance to mainline earlier, thereby freeing time from
chasing kernel versions and onto more interesting endeavors,
but alternative historical possibilities aren't the topic of
this post. ]

Leading up to that, of course, the submitting of ltt patches
continued. And, of course, suggestions had already been made
to the effect that kprobes was the way to go instead of
static inlined calls. And my objections were the same then
as they are today: a) taking an int3 at every event is not
my idea of performance b) I'd still have to keep chasing
kernels to make sure those events needed by ltt still work.
If I was to chase kernels, it might as well be in source.

But, regardless, the snapshot in time for anyone tasked with
coming up with a dtrace-equivalent for Linux was the
following: a) passed attempts to mainline tracing have been
countered with remarkable ferocity, b) the most prominent
tracing project out there, ltt, seems to have an especially
bad reputation with kernel developers. So any sane being
concludes the following: a) we should start from a clean
slate and adopt the path of least resistance (i.e. the
bloody thing better not depend on anything static), b)
anybody blacklisted by kernel developers for attempting to
mainline tracing is to be avoided -- especially that Karim
guy, he doesn't, shall we say, seem to be too preoccupied
with offending prominent developers; we're going to spend
good money on this, and things better go smoothly from
here on.

[ Of course the above is my interpretation of things. I
could just be off my a mile or a thousand. Though ... ]

So off they went.

I know what I did last summer:
------------------------------

Frustrating as it was, I remained convinced that no matter
how much they try, they'll eventually come back to the
same point I was making: maintaining instrumentation outside
the kernel is a bitch.

And sure enough, once more, truth came knocking. After being
heckled at a BoF at OLS2005 for having suggested the
introduction of a markers infrastructure allowing developers
to identify important events, what do we have in OLS2006?

Well, we have one paper from a SystemTap developer discussing
that specific topic:
http://www.linuxsymposium.org/2006/view_abstract.php?content_key=17
And a BoF on none other than ... wait for it ... drumroll ...
"Divorcing Linux kernel analysis tools from kernel version":
http://www.linuxsymposium.org/2006/view_abstract.php?content_key=196

Obviously I attended both. Frank's presentation was not only
excellent, but the room it was given in was packed. And
most everybody in there seemed to agree: we need this marker
stuff. Good, I thought, that's progress in the right direction.

But the divorce bof the previous evening was priceless. Here
we have everybody that's been involved in some form of tracing
in the kernel over the passed 5 years, and the whole atmosphere
is just surreal. The chair introduces the topic, and then, you'll
have to use your imagination a little to picture this, you've
got these puzzled looks on people's faces as they discuss
back and forth very seriously how they should solve these
maintenance issues they're encountering ... stuff like:
"well, yes, we've had this case when variable X changed,
and then our stuff didn't work no more" ... "yeah, plugged
this here, and that there" ... etc.

And I was sitting there mesmerized by the exchange between
these participants going back and forth having this
discussion whom simply couldn't state the obvious. Of course,
I'm not usually shy to state my opinion and I called
bullshit by its name. Needless to say things went downhill
from there. This was like a scene from Harry Potter: the
one who's name you shall not pronounce. I mean, one would
have believed I was to shut up lest the dead rise from their
grave.

So that was last summer.

The *real* picture emerges:
---------------------------

And now, this week, we have this huge thread sparked by
... you guessed it ... the posting of an ltt patch to the
lkml. And again, the same arguments are put forth, the same
type of personal attacks are made, etc. But this time it's
different. It's different because those that did travel the
road kernel developers had requested be taken -- that of
exclusive reliance on dynamic instrumentation -- have
actually done enough of it that they know exactly the cost
of having to maintain dynamic instrumentation out of the
kernel. While I personally predicted this diagnostic 2 or 3
years ago, they've actually had to do the stuff.

And you can still feel the weight of Linux's twisted tracing
history on those of the dynamic instrumentation camp as they
post their comments. I mean, for me, this comment by Frank
speaks volumes on the fear instilled by passed flamewars
on lkml about static instrumentation:

> This is the reason why I'm in favour of some lightweight event-marking
> facility: a way of catching those points where dynamic probing is not
> sufficiently fast or dependable.

[ The following is an arbitrary interpretation of Frank's
writing and I hope Frank won't be upset with my liberal
interpretation of his writing. For the record, I think
Frank is a great guy and while I've disagreed with him
in the past, I highly respect his technical abilities. ]

Now, you can imagine Frank writing this piece ... "must not
sound too uncompromising" ... "must insist on what kernel
developers like to see" ... "mention dynamic tracing" ...
I mean, look at the choice of words: "I'm in favour of
*some* *lightweigth* event-marking facility", "... where
*dynamic probing* is not ..." Smart. Keep to accepted
orthodox principles, don't upset the natives.

Well, clearly, I for one have no fear of upsetting the
natives. What Frank is telling us here is that
maintaining "some" -- let me call it like that for now --
of his instrumentation out of tree is a bitch. But if
you really looked at it honestly, you would see that
mainlining of most of SystemTap's scripts would actually
result in SystemTap being a much more universally usable
tool -- i.e. no need to make sure your scripts work for
the kernel you're running on.

Why, in fact, that's exactly Jose's point of view. Who's
Jose? Well, just in case you weren't aware of his work,
Jose maintains LKET. What's LKET? An ltt-equivalent
that uses SystemTap to get its events. And what does
Jose say? Well I couldn't say it better than him:

> I agree with you here, I think is silly to claim dynamic instrumentation 
> as a fix for the "constant maintainace overhead" of static trace point.  
> Working on LKET, one of the biggest burdens that we've had is mantainig 
> the probe points when something in the kernel changes enough to cause a 
> breakage of the dynamic instrumentation.  The solution to this is having 
> the SystemTap tapsets maintained by the subsystems maintainers so that 
> changes in the code can be applied to the dynamic instrumentation as 
> well.  This of course means that the subsystem maintainer would need to 
> maintain two pieces of code instead of one.  There are a lot of 
> advantages to dynamic vs static instrumentation, but I don't think 
> maintainace overhead is one of them.

Well, well, well. Here's a guy doing *exactly* what I was
asked to do a couple of years back. And what does he say?
"I think is silly to claim dynamic instrumentation as a
fix for the "constant maintainace overhead" of static trace
point."

And just in case you missed it the first time in his
paragraph, he repeats it *again* at the end:
" There are a lot of advantages to dynamic vs static
instrumentation, but I don't think maintainace overhead is
one of them."

But not content with Jose and Frank's first-hand experience
and testimonials about the cost of outside maintenance of
dynamically-inserted tracepoint, and obviously outright
dismissing the feedback from such heretics as Roman, Martin,
Mathieu, Tim, Karim and others, we have a continued barrage of
criticism from, shall we say, very orthodox kernel developers
who insist that the collective experience of the previously
mentioned people is simply misguided and that, as experienced
kernel developers, *they* know better.

Of course, I'm simplifying things a little. And in all
fairness there has been some conceding on the part of very
orthodox kernel developers that there may be in **very**
*special* cases the need for static instrumentation. Oh
boy, one almost reads those posts in glee -- imagine me
rubbing my hands -- thinking about the fate awaiting the
poor bastard that submits this first *special* case.
Boy is he going to have to prove how *special* that trace
point is.

That concession, however, still doesn't stop those very
same orthodox developers continuing to insist that
somehow "dynamic tracing" is superior to "static tracing",
even though they have actually never had to maintain an
infrastructure based on either for the purpose of allowing
mainstream users to trace their kernels for *user* purposes.
And in all fairness some are pretty open about it.

So be it. I, for one, have no fear of calling things by
their name.

Why the emperor is naked:
-------------------------

Truth be told:

There is no justification why Mathieu should continue
chasing kernels to allow his users utilize ltt on as
many kernel versions as possible.

There is no justification why the SystemTap team should
continue chasing kernels to make sure users can use
SystemTap on as many kernel versions as possible.

There is no justification why Jose should continue
chasing kernels to allow his users to use LKET on as
many kernel versions as possible.

There is, in fact, no justification why Jose, Frank,
and Mathieu aren't working on the same project.

There is no justification to any of this but the continued
*FEAR* by kernel developers that somehow their maintenance
workload is going to become unmanageable should anybody
get his way of adding static instrumentation into the
kernel. And no matter what personal *and* financial cost
this fear has had on various development teams, actual
*experience* from even those who have applied the most
outrageous of kernel developers requirements is but
grudgingly and conditionally recognized. No value, of
course, being placed on the experience of those that
*didn't* follow the orthodox diktat -- say by pointing
out that ltt tracepoints did not vary on a 5 year timespan.

For the argument, as it is at this stage of the long
intertwined thread of this week, is that "dynamic tracing"
is superior to "static tracing" because, amongst other
things, "static tracing" requires more instrumentation
than "dynamic tracing". But that, as I said within said
thread, is a fallacy. The statement that "static tracing"
requires more instrumentation than "dynamic tracing" is
only true in as far as you ignore that there is a cost
for out-of-tree maintenance of scripts for use by probe
mechanisms. And as you've read earlier, those doing this
stuff tell us there *is* cost to this. Not only do they
say that, but they go as far as telling us that this
cost is *no different* than that involved in maintaining
static trace points. That, in itself, flies in the face
of all accepted orthodox principles on the topic of
mainlined static tracing.

And that is but the maintenance aspect, I won't even
start on the performance issue. Because the current party
line is that while the kprobes mechanism is slow: a) it's
fast enough for all applicable uses, b) there's this
great new mechanism we're working on called djprobes which
eliminates all of kprobes' performance limitations. Of
course you are asked to pay no attention to the man behind
the curtain: a) if there is justification to work on
djprobes, it's because kprobes is dog-slow, which even
those using it for systemtap readily acknowledge, b)
djprobes has been more or less "on its way" for a year or
two now, and that's for one single architecture.

Meanwhile, if any of those screaming at me ever bothered
listening, my claim has been rather simple (as taken from
an earlier email):

What is sufficient for tracing a given set of events by means
of binary editing *that-does-not-require-out-of-tree-maintenance*
can be made to be sufficient for the tracing of events using
direct inlined static calls. The *only* difference being that
binary editing allows further extension of the pool of events
of interest by means of outside specification of additional
interest points.

And that, therefore, if we accept the idea that static
markup is necessary, then what hides behind the marked up
code becomes utterly *irrelevant*.

A proposal catering for orthodox fears:
---------------------------------------

Now here I am, 7 years after starting ltt, with all the stories
above, having passed on maintainership to someone else close
to a year ago, yet somehow I'm still around to ruin the party
for the naysayers and spend 4 days full-time addressing all
the misguided cruft I've encountered through the years in the
hope that someone somewhere will see the light and a unified
approach will emerge. For make no mistake, none of my
interventions were for profit or for ego -- both have long
been lost in the topic of ltt. This was on principle. If I
see BS I say BS, and this schizophrenic fear of static
instrumentation to which I've been a witness for the passed
7 years is but a classic example of unjustified fears getting
out of hand.

Nevertheless, I persist and submit a proposal which I feel
addresses many, if not all, of the previous fears I've heard
voiced over the years. Yet, while ample opportunity was
given and repeated requests, hardliners and observers alike
refuse to even comment on what I propose -- what's changed.
So, here again, yet another time, a proposal for a static
markup system:

> The plain function:
>  int global_function(int arg1, int arg2, int arg3)
>  {
>          ... [lots of code] ...
> 
>          x = func2();
> 
>          ... [lots of code] ...
>  }
> 
> The function with static markup:
>  int global_function(int arg1, int arg2, int arg3)
>  {
>          ... [lots of code] ...
> 
>          x = func2(); /*T* @here:arg1,arg2,arg3 */
> 
>          ... [lots of code] ...
>  }
> 
> The semantics are primitive at this stage, and they could definitely
> benefit from lkml input, but essentially we have a build-time parser
> that goes around the code and automagically does one of two things:
> a) create information for binary editors to use
> b) generate an alternative C file (foo-trace.c) with inlined static
>    function calls.
> 
> And there might be other possibilities I haven't thought of.
> 
> This beats every argument I've seen to date on static instrumentation.
> Namely:
> - It isn't visually offensive: it's a comment.
> - It's not a maintenance drag: outdated comments are not alien.
> - It doesn't use weird function names or caps: it's a comment.
> - There is precedent: kerneldoc.
> And it does preserve most of the key things those who've asked for
> static markup are looking for. Namely:
> - Static instrumentation
> - Mainline maintainability
> - Contextualized variables

To date, only one comment came in on this. And, amazingly, it
confirms everything I say above:
> This makes sense to me, when combined with kprobes.

Again, the misconception is so entrenched that, while being
positive, the feedback entirely misses the point that once
you agree on markup, the underlying mechanism is entirely
*irrelevant*.

N'ough said:
------------

Now, I really have to ask: How much time do we have to
continue wasting? If collective feedback from those who's
combined considerable work dictates a course of action --
while still this course of action is begrudgingly accepted --
explanations are given why existing processes allow for
vetting of unnecessary markup and proposals are made to
alleviate much of the entrenched fears, what more level of
proof will be sufficient to come to terms with the obvious?

Namely that *comprehensive* static markup belongs in
mainline and *nowhere* else.

Karim
-- 
President  / Opersys Inc.
Embedded Linux Training and Expertise
www.opersys.com  /  1.866.677.4546



