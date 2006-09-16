Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbWIPPo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbWIPPo4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 11:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbWIPPo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 11:44:56 -0400
Received: from opersys.com ([64.40.108.71]:16658 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S932430AbWIPPoz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 11:44:55 -0400
Message-ID: <450C20C7.30604@opersys.com>
Date: Sat, 16 Sep 2006 12:05:27 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Jes Sorensen <jes@sgi.com>
CC: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       tglx@linutronix.de, Paul Mundt <lethal@linux-sh.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060915132052.GA7843@localhost.usen.ad.jp>	<Pine.LNX.4.64.0609151535030.6761@scrub.home>	<20060915135709.GB8723@localhost.usen.ad.jp>	<450AB5F9.8040501@opersys.com>	<450AB506.30802@sgi.com>	<450AB957.2050206@opersys.com>	<20060915142836.GA9288@localhost.usen.ad.jp>	<450ABE08.2060107@opersys.com>	<1158332447.5724.423.camel@localhost.localdomain>	<20060915111644.c857b2cf.akpm@osdl.org>	<20060915181907.GB17581@elte.hu> <20060915131317.aaadf568.akpm@osdl.org> <450BCF97.3000901@sgi.com>
In-Reply-To: <450BCF97.3000901@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jes Sorensen wrote:
> Just to clarify, the stuff I have looked at in the field was based on
> LTT, but not part of the official LTT. It simply goes to show that end
> users cannot agree on a small set of fixed tracepoints because someone
> always wants a slightly different view of things, like in the cases I
> looked at. Not to mention that the changes LTT users make, at times, to
> shoehorn their stuff in, especially in sensitive codepaths such as the
> syscall path, have side effects which clearly weren't considered.

Good. So give me concrete examples of those cases that you saw and tell
me exactly what those people you were working with were attempting to
achieve.

> I don't have any objections to markers as Ingo suggested. I just don't
> buy the repeated argument that LTT has been around for years and barely
> changed. It's simply a case of the LTT team not being aware (or deciding
> to ignore, I cannot say which) what users have actually done with the
> LTT codebase, but it seems obvious they are not aware what everyone is
> doing with it. But we have seen before how if an infrastructure like LTT
> goes into the kernel, many more users will pop up and want to have their
> stuff added.

Either ltt had a userbase or it didn't. To say that all its users went
out and added their own tracepoints is to not know enough about the project
and so too is it to say that none of its users could actually just use
it out of the box without modifying it. Now, as an outsider, trying to
measure how many users were using it without modifying it is like
trying to figure out how many Linux users there are out there. There's
a silent majority and there's those that need customization. Guess
who you've been talking to?

Strange, come to think of it I don't remember *ever* getting an
email from you while being the maintainer or seing *any* emails by you
on the ltt lists -- that's indicative of mindset, namely that you
personally assumed you knew all about tracing and didn't need us to make
suggestions to help you AND that you personally never found it relevant
to contribute back. That's like me going off forking the kernel, adding
features to it and then calling the kernel developers incompetent when
they come around saying that what I'm doing is wrong. Who's patronizing
who here?

And I submit to you an idea which I submitted to Ingo yesterday and have
not yet received feedback on. Here's static markup as it could be
implemented:

The plain function:
 int global_function(int arg1, int arg2, int arg3)
 {
         ... [lots of code] ...

         x = func2();

         ... [lots of code] ...
 }

The function with static markup:
 int global_function(int arg1, int arg2, int arg3)
 {
         ... [lots of code] ...

         x = func2(); /*T* @here:arg1,arg2,arg3 */

         ... [lots of code] ...
 }

The semantics are primitive at this stage, and they could definitely
benefit from lkml input, but essentially we have a build-time parser
that goes around the code and automagically does one of two things:
a) create information for binary editors to use
b) generate an alternative C file (foo-trace.c) with inlined static
   function calls.

And there might be other possibilities I haven't thought of.

This beats every argument I've seen to date on static instrumentation.
Namely:
- It isn't visually offensive: it's a comment.
- It's not a maintenance drag: outdated comments are not alien.
- It doesn't use weird function names or caps: it's a comment.
- There is precedent: kerneldoc.
And it does preserve most of the key things those who've asked for
static markup are looking for. Namely:
- Static instrumentation
- Mainline maintainability
- Contextualized variables

When I was still part of the ltt development process we had accumulated
a huge amount of ideas of how we could optimize and fix stuff here and
there. We were never actually ever able to reduce these to practice
because folks like you never bothered interfacing with us and the
attitude on the lkml was exactly as I described. We spent our time
chasing kernels.

> The other part is the constantly repeated performance claim, which to
> this point hasn't been backed up by any hard evidence. If we are to take
> that argument serious, then I strongly encourage the LTT community to
> present some real numbers, but until then it can be classified as
> nothing but FUD.

Hmm... beats me why even the systemtap folks would themselves admit
to performance limitations.

> I shall be the first to point out that kprobes are less than ideal,
> especially the current ia64 implementation suffers from some tricky
> limitations, but thats an implementation issue.

Ah, so it's ok for kprobes to have implementation issues, but not ltt.
Somehow there's this magic thought recurring throughout this thread
that the limitations of dynamic instrumentation are trivial to fix,
but those of static instrumentation are unrecoverable. *That* is a
fallacy if I ever saw one. I'm willing to admit that a combination of
dynamic editing and static instrumentation is a good balance, but Jes
please drop this discourse, it's not constructive.

Karim
-- 
President  / Opersys Inc.
Embedded Linux Training and Expertise
www.opersys.com  /  1.866.677.4546
