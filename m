Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbVE3Rn2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbVE3Rn2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 13:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVE3Rn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 13:43:28 -0400
Received: from opersys.com ([64.40.108.71]:1805 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261497AbVE3RnS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 13:43:18 -0400
Message-ID: <429B5316.2080500@opersys.com>
Date: Mon, 30 May 2005 13:53:26 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: James Bruce <bruce@andrew.cmu.edu>
CC: Nick Piggin <nickpiggin@yahoo.com.au>, "Bill Huey (hui)" <bhuey@lnxw.com>,
       Andi Kleen <ak@muc.de>, Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org,
       Philippe Gerum <rpm@xenomai.org>
Subject: Re: RT patch acceptance
References: <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net> <20050526193230.GY86087@muc.de> <1117138270.1583.44.camel@sdietrich-xp.vilm.net> <20050526202747.GB86087@muc.de> <4296ADE9.50805@yahoo.com.au> <20050527120812.GA375@nietzsche.lynx.com> <429715DE.6030008@yahoo.com.au> <20050527233645.GA2283@nietzsche.lynx.com> <4297EB57.5090902@yahoo.com.au> <20050528054503.GA2958@nietzsche.lynx.com> <42981467.6020409@yahoo.com.au> <4299A98D.1080805@andrew.cmu.edu>
In-Reply-To: <4299A98D.1080805@andrew.cmu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ From my point of view, it is clear that this part of the thread is
non-technical. IOW, we could go on back-and-worth indefinitely. In
the following, I'm putting my nanokernel-promoter hat back on to point
out a few things ... Previous disclaimers still apply :) ]

James Bruce wrote:
> I think it's a bit more like you haven't realized the answer when people 
> gave it, so let me try to be more clear.  It's purely a matter of effort 
> - in general it's far easier to write one process than two communicating 
> processes.  As far as APIs, with a single-kernel approach, an RT 
> programmer just has to restrict the program to calling APIs known to be 
> RT-safe (compare with MT-safe programming).  In a split-kernel approach, 
> the programmer has to write RT-kernel support for the APIs he wants to 
> use (or beg for them to be written).  Most programmers would much rather 
> limit API usage than implement new kernel support themselves.

Actually, I would suggest that anybody who's for PREEMPT_RT to drop
this argument. Fact is, requiring more work on the part of those wanting
to accomplishing very specialized tasks (such as RT) can very much be
seen as the Linux way.

So yes, it sucks having to write two apps, and it sucks having to port
drivers, but let's face it, 95% of Linux applications and 95% of drivers
-- statistics accurate 19 times out of 20 with a margin of error of +/-
3% :D -- will never ever be used in a hard-rt environment.

Based on that, it is likely (and indeed from reading responses, I seems
this is what is happening) that most kernel subsystem maintainers may
find the added cost of maintainership too high for the perceived benefits.

> In general an app may enter and exit RT sections several times, which 
> really makes a split-kernel approach less than ideal.

I'd hate to disappoint you, but RTAI has been providing the following
calls from standard Linux apps (e.g. type "$ ./my_app" ENTER) for _five_
years:
rt_make_hard_real_time()
rt_make_soft_real_time()

Switching back-and-forth to/from hard-rt mode has been possible and
done many times.

<alternate proposal>
Much like there is nothing precluding PREEMPT_RT to co-exist with
the nanokernel approach (on which RTAI is based), it could be suggested
the adding of a linux/hard-rt directory containing the (re?)implementation
of services/abstractions required for hard-rt applications. You still
get a single tree, but there's then a clear separation at many levels,
including maintainership. As such, much of what RTAI-fusion is currently
doing could find itself in linux/hard-rt. For example, RTAI-fusion
transparently provides a hard-rt deterministic nanosleep(). This and
other such replacements for kernel/*.c would live in hard-rt/ with
no disturbance to the rest of the tree. In the same way, include/linux
could be a symbolic link to either include/linux-hrt or include/linux-srt,
with headers in include/linux-hrt referring back to include/linux-srt
where appropriate. Again, zero cost for mainstream maintainers. If the
hard-rt stuff breaks, only the rt folks get the pain. Note that I'm not
suggesting creating duplicates like this for all directories. In fact,
most of what's in arch/* and drivers/* would remain unchanged, and
where appropriate, hard-rt/* and include/linux-hrt should reuse as much
of what already exists as possible.

Sure, the hard-rt part wouldn't have all the bells and whistles of the
mainstream part, but that's what we're going to have anyway if
PREEMPT_RT is included (as is clearly acknowledged elsewhere in this
thread by those backing it), unless there's a general consensus amongst
all subsystem maintainers that Linux should become QNX-like ... which,
to the best of my reading of this thread, most are not interested in.

The above suggestion doesn't solve the two-app vs. one-app dilemma, but
it takes away the "oh, horror, we need to maintain two separate kernel
trees for our application development" from those against the nanokernel
approach _without_ imposing additional burden on mainstream maintainers.
</alternate proposal>

... so here goes, it's just an idea I'm throwing in the lion pit ...
it clearly would require much more work and input ... so devour, tear,
and crush at will ...

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
