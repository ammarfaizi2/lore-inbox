Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262211AbVATW6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262211AbVATW6M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 17:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262209AbVATW5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 17:57:49 -0500
Received: from opersys.com ([64.40.108.71]:1806 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262208AbVATW5Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 17:57:24 -0500
Message-ID: <41F039C7.1080300@opersys.com>
Date: Thu, 20 Jan 2005 18:07:51 -0500
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
References: <20050120183951.A17570@almesberger.net>
In-Reply-To: <20050120183951.A17570@almesberger.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Werner Almesberger wrote:
>  - if the probe target is an instruction long enough, replace it with
>    a jump or call (that's what I think the kprobes folks are working
>    on. I remember for sure that they were thinking about it.)

I heard about this years ago, but I don't know that anything came of
it. I suspect that this is not as simple as it looks and that the
only reliable way to do it is with a trap.

> Probably because everybody saw that it was good :-)

Great, thanks. That's what we'll aim for then. We've already got
the "disable" and "static" implemented, so now we need to figure
out how do we best implement this tagging. IBM's kernel hooks
allowed the NOP solution, so I'm guessing it shouldn't be that
much of a stretch to extend it for marking up the code for kprobes
and friends. I don't know whether this code is still maintained or
not, but I'd like to hear input as to whether this is a good basis,
or whether you're thinking of something like your uml-sim hooks?

> So you need seeking, even in the presence of fine-grained control
> over what gets traced in the first place ? (As opposed to extracting
> the interesting data from the full trace, given that the latter
> shouldn't contain too much noise.)

The problem is that you don't necessarily know beforehand what's
the problem. So here's an actual example:

I had a client who had this box on which a task was always getting
picked up by the OOM killer. Try as they might, the development
team couldn't figure out which part of the code was causing this.
So we put LTT in there and in less than 5 minutes we found the
problem. It turned out that a user-space access to a memory-mapped
FPGA caused an unexpected FP interrupt to occur, and the application
found itself in a recursive signal handler. In this case there was
an application symptom, but it was a hardware problem.

This is just a simple example, but there are plenty of other
examples where a sysadmin will be experiencing some weird
hard to reproduce bugs on some of his systems and he'll spend
a considerable amount of time trying to guess what's happening.
This is especially complicated when there's no indication as to
what's the root of the problem. So at that point being able to
log everything and being able to rapidely browse through it is
critical.

Once you've done such a first trace you _may_ _possibly_ be
able to refine your search requirements and relog with that in
mind, but that's after the fact.

> Or that they have been consumed. My question is just whether this
> kind of aggregation is something you need.

Absolutely. If you're thinking about short 100kb or MBs traces,
then a simpler scheme would be possible. But when we're talking
about GB and 100GBs spaning days, there's got to be a managed
way of doing it.

>>I have nothing against kprobes. People keep refering to it as if
>>it magically made all the related problems go away, and it doesn't.
> 
> 
> Yes, I know just too well :-) In umlsim, I have pretty much the
> same problems, and the solutions aren't always nice. So far, I've
> been lucky enough that I could almost always find a suitable
> function entry to abuse.

Glad you acknowledge as much.

> However, since a kprobes-based mechanism is - in the worst case,
> i.e. when needing markup - as good as direct calls to LTT, and gives
> you a lot more flexibility if things aren't quite as hostile, I
> think it makes sense to focus on such a solution.

You certainly have a lot more experience than I do with that, so
I'd like to solicit your help. As above: what's the best way to
provide this in addition to the static and disable points?

> Yup, but you could move even more intelligence outside the kernel.
> All you really need in the kernel is a place to put the probe,
> plus some debugging information to tell you where you find the
> data (the latter possibly combined with gently coercing the
> compiler to put it at some accessible place).

Right, but then you end up with a mechanism with generalized hooks.
Actually there was a time when LTT was a driver and you could
either build it as a module or keep it built-in. However, when
we published patches to get LTT accepted in 2.5 we were told on
LKML to move LTT into kernel/ and avoid all this driver stuff.
Having it, or parts of it, in the kernel makes it much simpler
and much more likely that the existing ad-hoc tracing code
spreading accross the sources be removed in exchange for a
single agreed upon way of doing things.

It must be said that like I had done with relayfs, the LTT patch
will go through a major redux and I will post the patches for
review like before on LKML.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
