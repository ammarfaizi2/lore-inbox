Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261793AbVASRap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbVASRap (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 12:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbVASRap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 12:30:45 -0500
Received: from opersys.com ([64.40.108.71]:10245 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261803AbVASR2S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 12:28:18 -0500
Message-ID: <41EE9B28.4020108@opersys.com>
Date: Wed, 19 Jan 2005 12:38:48 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Werner Almesberger <wa@almesberger.net>
CC: tglx@linutronix.de, Roman Zippel <zippel@linux-m68k.org>,
       Tim Bird <tim.bird@am.sony.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>
Subject: Re: [RFC] Instrumentation (was Re: 2.6.11-rc1-mm1)
References: <20050114002352.5a038710.akpm@osdl.org> <1105742791.13265.3.camel@tglx.tec.linutronix.de> <41E8543A.8050304@am.sony.com> <1105794499.13265.247.camel@tglx.tec.linutronix.de> <41E9CCEF.50401@opersys.com> <Pine.LNX.4.61.0501160352130.6118@scrub.home> <41E9EC5A.7070502@opersys.com> <1105919017.13265.275.camel@tglx.tec.linutronix.de> <41EB1AEC.3000106@opersys.com> <20050119041325.C26705@almesberger.net>
In-Reply-To: <20050119041325.C26705@almesberger.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Werner Almesberger wrote:
>>From all I've heard and seen of LTT (and I have to admit that most
> of it comes from reading this thread, not from reading the code),

Might I add that this is part of the problem ... No personal
offence intended, but there's been _A LOT_ of things said about
LTT that were based on third-hand account and no direct contact
with the toolset/code. And part of the problem is that _many_
people on this list, and elsewhere, have done some form of
tracing or another as part of their development, so they all
have their idea of how this is best done. Yet, while such
experience can help provide additional ideas to LTT's development,
it also often requires re-explaining to every new suggestor why we
added features he couldn't imagine would be useful to any of
his/her own tracing needs ... Sometimes I wish my interests lied
in some arcane feature that few had ever played with ;)

IOW, while I don't discount anybody else's experience with tracing,
please give us at least the benefit of the doubt by actually:
a) Looking at the code
b) Looking at the mailing list archives
c) Asking us questions directly related to the code

> I have the impression that it may try to be a bit too specialized,
> and thus might miss opportunities for synergy. 

Bare with me on this one ...

> You must be getting tired of people trying to redesign things from
> scratch, but maybe you'll humor me anyway ;-)

Hey, from you Werner I'll take anything. It's always a pleasure
talking with you :)

> Karim Yaghmour wrote:
> 
>>If you really want to define layers, then there are actually four
>>layers:
>>1- hooking mechanism
>>2- event definition / registration
>>3- event management infrastructure
>>4- transport mechanism
> 
> 
> For 1, kprobes would seem largely sufficient. In cases where you
> don't have a usable attachment point (e.g. in the middle of a
> function and you need access to variables with unknown location),
> you can add lightweight instrumentation that arranges the code
> flow suitably. [1, 2]

Let me say outright, as I said to Andi early on in the sister thread,
that I have no problems with having the trace points being fed by
kprobes. In fact, in 2000, way back before kprobes even existed, LTT
was already interfacing with DProbes for dynamic insertion of trace
points.

... There I said it ... now watch me have to repeat this yet again
later on ... :/

However, kprobes is not magic:
a) Like I said to Andi:
> As far as kprobes go, then you still need to have some form or another
> of marking the code for key events, unless you keep maintaining a set
> of kprobes-able points separately, which really makes it unusable for
> the rest of us, as the users of LTT have discovered over time (having
> to create a new patch for every new kernel that comes out.)

b) Like I said to Andrew back in July:
> I've double-checked what I already knew about kprobes and have looked again
> at the site and the patch, and unless there's some feature of kprobes I don't
> know about that allows using something else than the debug interrupt to add
> hooks,
...
> Generating new interrupts is simply unacceptable for LTT's functionality.
> Not to mention that it breaks LTT because tracing something will generate
> events of its own, which will generating tracing events of their own ...
> recursion.

Ok, you can argue about the recursion thing with an "if()", but you'll
have to admit that like in the case I described to Roman:
> ... Say you're getting
> 2MB/s of data (which is not unrealistic on a loaded system.) That means
> that if I'm tracing for 2 days, I've got 345GB of data (~7.5GB/hour).
IOW, something like 200,000events/s (average of 10bytes/event). Do I
really need to explain that 200,000 traps/interrupts per second is
not something you want ... ?

But don't despair, like I said to Andi:
> So lately I've been thinking that there may be a middle-ground here
> where everyone could be happy. Define three states for the hooks:
> disabled, static, marker. The third one just adds some info into
> System.map for allowing the automation of the insertion of kprobes
> hooks (though you would still need the debugging info to find the
> values of the variables that you want to log.) Hence, you get to
> choose which type of poison you prefer. For my part, I think the
> noop/early-check should be sufficient to get better performance from
> the existing hook-set.
I have received very little feedback on this suggestion, though I
really think it's worth entertaining, especially with your mention
of uml-sim markers further below.

As for the location of ltt trace points, then they are very rarely
at function boundaries. Here's a classic:
		prepare_arch_switch(rq, next);
		ltt_ev_schedchange(prev, next);
		prev = context_switch(rq, prev, next);

> 2 and 3 should be the main domain of LTT, with 2 sitting on top
> of kprobes. kprobes currently doesn't have a nice way for
> describing handlers, but that can be fixed [3]. But you probably
> don't need a "nice" interface right now, but might be satisfied
> with one that works and is fast (?)

The functions have been there for DProbes for 5 years:
int ltt_create_event(char *event_type,
		     char *event_desc,
		     int format_type,
		     char *format_data)
int ltt_log_raw_event(int event_id, int event_size, void *event_data)

>>From the discussion, it seems that the management is partially
> done by relayfs. I find this a little strange. E.g. instead of
> filtering events, you may just not generate them in the first
> place, e.g. by not placing a probe, or by filtering in LTT,
> before submitting the event.

Like I said to Andi:
> ... For one thing, the current
> ltt hooks aren't as fast as they should be (i.e. we check whether
> the tracing is enabled for a certain event way too far in the code-path.)
> This should be rather simple to fix.
And I've already got the code snippet to fix this ready.

> Timestamps may be fine either way. Restoring sequence should be
> a task user-space can handle: in the worst case, you'd have to
> read and merge from #cpus streams. Seeking works in that context,
> too.
> 
> Last but not least, 4 should be simple. Particularly since you're
> worried about extreme speeds, there should be as little
> processing as you can afford. If you need to seek efficiently
> (do you, really ?), you may not even want message boundaries at
> that level.

Like I said to Roman:
> Removing this data would require more data for each event to
> be logged, and require parsing through the trace before reading it in
> order to obtain markers allowing random access. This wouldn't be so
> bad if we were expecting users to use LTT sporadically for very short
> periods of time. However, given ltt's target audience (i.e. need to
> run traces for hours, maybe days, weeks), traces would rapidely become
> useless because while plowing through a few hundred KBs of data and
> allocating RAM for building internal structures as you go is fine,
> plowing through tens of GBs of data, possibly hundreds, requires that
> you come up with a format that won't require unreasonable resources
> from your system, while incuring negligeable runtime costs for generating
> it. We believe the format we currently have achieves the right balance
> here.

What we've agreed with Roman is that relayfs won't write anything at
the boundaries. Its clients will provide it with callbacks to be
invoked at buffer boundaries. When invoked, said callbacks can add
whatever they feel is important to the buffer, relayfs doesn't care.

> Something that isn't entirely clear to me is if you also need to
> aggregate information in buffers. E.g. by updating a record until
> is has been retrieved by user space, or by updating a record
> when there is no space to create a new one. Such functionality
> would add complexity and needs tight sychronization with the
> transport.

If I understand you correctly, you are talking about the fact that
the transport layer's management of the buffers is syncrhonized
with some user-space entity that consumes the buffers produced
and talks back to relayfs (albeit indirectly) to let it know that
said buffers are now available? If so, then that's why I suggested
elsewhere that we have two modes for relayfs: managed and adhoc.
In the former, you have the required mechanics for what I just
described. In the latter, you have a very basic buffering scheme
that cares nothing about user-space synchronization.

> [1] I've seen the argument that kprobes aren't portable. This
>     strikes me a highly questionable. Even if an architecture
>     doesn't have a trap instruction (or equivalent code sequence)
>     that is at least as short as the shortest instruction, you
>     can always fall back to adding instrumentation [2]. Also, if
>     you know where your basic blocks are, you may be able to
>     use traps that span multiple instructions. I recall that
>     things of this kind are already planned for kprobes.

I have nothing against kprobes. People keep refering to it as if
it magically made all the related problems go away, and it doesn't.
See above.

> [2] See the "reliable markers" of umlsim from umlsim.sf.net.
>     Implementation: cd umlsim/lib; make; tail -50 markers_kernel.h
>     Examples: cd umlsim/sim/tests; cat sbug.marker
>     They're basically extra-light markup in the source code.
>     Works on ia32, but I haven't found a way to get the assembler
>     to cooperate for amd64, yet.

Nothing precludes us to move in this direction once something is
in the kernel, it's all currently hidden away in a .h, and it would
be the same with this.

> [3] I've already solved this problem in umlsim: there, I have a
>     Perl/C-like scripting language that allows handlers to do
>     pretty much anything they want. Of course, kprobes would
>     want pre-compiled C code, not some scripts, but I think the
>     design could be developped in a direction that would allow
>     both. Will take a while, but since I'll eventually have to
>     rewrite the "microcode" anyway, ...

Like I said, nothing precludes us ...

> So my comments are basically as follows:
> 
> 1) kprobes seems like a suitable and elegant mechanism for
>    placing all the hooks LTT needs, so I think that it would
>    be better to build on this basis, and extend it where
>    necessary, than to build yet another specialized variant
>    in parallel.

Whichever way you look at this, you need to mark the code. What's
in the .h is something we can tweak ad-nauseam.

> 2) LTT should do what it is good at, and not have to worry
>    about the rest (i.e. supporting infrastructure).

I'm guessing that when you're talking about "supporting
infrastructure" you are refering to the trace statements. If so,
please see above. Also note that without the existing marker set
LTT is useless to its users (application developers, sysadmins,
power users, etc.)

> 3) relayfs should be lean and fast, as you intend it to be, so
>    that non-LTT tracing or fnord debugging fnord code may find
>    it useful, too.

relayfs has already been used for many non-LTT related. Ask
Hubertus or Jamal, to name a few.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
