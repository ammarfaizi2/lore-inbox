Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbVASHOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbVASHOk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 02:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbVASHOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 02:14:39 -0500
Received: from almesberger.net ([63.105.73.238]:2579 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S261609AbVASHO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 02:14:26 -0500
Date: Wed, 19 Jan 2005 04:13:25 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Karim Yaghmour <karim@opersys.com>
Cc: tglx@linutronix.de, Roman Zippel <zippel@linux-m68k.org>,
       Tim Bird <tim.bird@am.sony.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>
Subject: Re: [RFC] Instrumentation (was Re: 2.6.11-rc1-mm1)
Message-ID: <20050119041325.C26705@almesberger.net>
References: <20050114002352.5a038710.akpm@osdl.org> <1105742791.13265.3.camel@tglx.tec.linutronix.de> <41E8543A.8050304@am.sony.com> <1105794499.13265.247.camel@tglx.tec.linutronix.de> <41E9CCEF.50401@opersys.com> <Pine.LNX.4.61.0501160352130.6118@scrub.home> <41E9EC5A.7070502@opersys.com> <1105919017.13265.275.camel@tglx.tec.linutronix.de> <41EB1AEC.3000106@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41EB1AEC.3000106@opersys.com>; from karim@opersys.com on Sun, Jan 16, 2005 at 08:54:52PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From all I've heard and seen of LTT (and I have to admit that most
of it comes from reading this thread, not from reading the code),
I have the impression that it may try to be a bit too specialized,
and thus might miss opportunities for synergy. 

You must be getting tired of people trying to redesign things from
scratch, but maybe you'll humor me anyway ;-)

Karim Yaghmour wrote:
> If you really want to define layers, then there are actually four
> layers:
> 1- hooking mechanism
> 2- event definition / registration
> 3- event management infrastructure
> 4- transport mechanism

For 1, kprobes would seem largely sufficient. In cases where you
don't have a usable attachment point (e.g. in the middle of a
function and you need access to variables with unknown location),
you can add lightweight instrumentation that arranges the code
flow suitably. [1, 2]

2 and 3 should be the main domain of LTT, with 2 sitting on top
of kprobes. kprobes currently doesn't have a nice way for
describing handlers, but that can be fixed [3]. But you probably
don't need a "nice" interface right now, but might be satisfied
with one that works and is fast (?)

>From the discussion, it seems that the management is partially
done by relayfs. I find this a little strange. E.g. instead of
filtering events, you may just not generate them in the first
place, e.g. by not placing a probe, or by filtering in LTT,
before submitting the event.

Timestamps may be fine either way. Restoring sequence should be
a task user-space can handle: in the worst case, you'd have to
read and merge from #cpus streams. Seeking works in that context,
too.

Last but not least, 4 should be simple. Particularly since you're
worried about extreme speeds, there should be as little
processing as you can afford. If you need to seek efficiently
(do you, really ?), you may not even want message boundaries at
that level.

Something that isn't entirely clear to me is if you also need to
aggregate information in buffers. E.g. by updating a record until
is has been retrieved by user space, or by updating a record
when there is no space to create a new one. Such functionality
would add complexity and needs tight sychronization with the
transport.

[1] I've seen the argument that kprobes aren't portable. This
    strikes me a highly questionable. Even if an architecture
    doesn't have a trap instruction (or equivalent code sequence)
    that is at least as short as the shortest instruction, you
    can always fall back to adding instrumentation [2]. Also, if
    you know where your basic blocks are, you may be able to
    use traps that span multiple instructions. I recall that
    things of this kind are already planned for kprobes.

[2] See the "reliable markers" of umlsim from umlsim.sf.net.
    Implementation: cd umlsim/lib; make; tail -50 markers_kernel.h
    Examples: cd umlsim/sim/tests; cat sbug.marker
    They're basically extra-light markup in the source code.
    Works on ia32, but I haven't found a way to get the assembler
    to cooperate for amd64, yet.

[3] I've already solved this problem in umlsim: there, I have a
    Perl/C-like scripting language that allows handlers to do
    pretty much anything they want. Of course, kprobes would
    want pre-compiled C code, not some scripts, but I think the
    design could be developped in a direction that would allow
    both. Will take a while, but since I'll eventually have to
    rewrite the "microcode" anyway, ...

So my comments are basically as follows:

1) kprobes seems like a suitable and elegant mechanism for
   placing all the hooks LTT needs, so I think that it would
   be better to build on this basis, and extend it where
   necessary, than to build yet another specialized variant
   in parallel.
2) LTT should do what it is good at, and not have to worry
   about the rest (i.e. supporting infrastructure).
3) relayfs should be lean and fast, as you intend it to be, so
   that non-LTT tracing or fnord debugging fnord code may find
   it useful, too.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
