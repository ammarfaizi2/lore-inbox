Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262401AbVAPCMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262401AbVAPCMQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 21:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262387AbVAPCFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 21:05:46 -0500
Received: from opersys.com ([64.40.108.71]:55565 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262388AbVAPCCa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 21:02:30 -0500
Message-ID: <41E9CCEF.50401@opersys.com>
Date: Sat, 15 Jan 2005 21:09:51 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Tim Bird <tim.bird@am.sony.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] Instrumentation (was Re: 2.6.11-rc1-mm1)
References: <20050114002352.5a038710.akpm@osdl.org>	 <1105742791.13265.3.camel@tglx.tec.linutronix.de>	 <41E8543A.8050304@am.sony.com> <1105794499.13265.247.camel@tglx.tec.linutronix.de>
In-Reply-To: <1105794499.13265.247.camel@tglx.tec.linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Thomas,

I don't mind having a general discussion about instrumentation, but
it has to be understood that the topic is so general and means so
many different things to different people that we are unlikely to
reach any useful consensus. Believe me, it's not for the lack of
trying. More below.

Thomas Gleixner wrote:
> </Flame off>

:D

> One of those backends is LTT+relayfs. 
> I really respect the work you have done there, but please accept that I
> just see the limitations and try to figure out a way to make it more
> generic and flexible before it is cemented into the kernel and makes it
> hard to use for other interesting instrumentation aspects and maybe
> enforces redundant implementation of infrastructure related
> functionality.
> 
> E.g. tracking down timing related issues can make use from such
> functionality if the infrastructure is provided seperately.
> I guess a lot of developers would be happy to use it when it is already
> around in the kernel and it can help testers for giving better
> information to developers.

I would invite you to review the history behind LTT and the history
behind the efforts to get LTT integrated in the kernel (which are
two separate topics.) If you look back, you will see that I worked
very hard trying to get people to think about a common framework
and that I and others made numerous suggestions in this regard. Here
are a few examples:

- DProbes (kprobes ancestor):
Shortly after dprobes came out in 2000, I was one of the first to
suggest that there could be interfacing between both to allow
dynamically added trace points. We worked with, and eventually
joined forces with, the IBM team working on this and very early
on, LTT and DProbes were interfacing:
http://marc.theaimsgroup.com/?l=linux-kernel&m=97079714009328&w=2
- OProfile:
When time came to integrate oprofile in the kernel, I tried to push
for oprofile to use ltt as it's logging engine (to John's utter
horror.) relayfs didn't exist at the time, and obviously oprofile
made it in without relying on ltt.
Here's a posting from July 2002 where I suggested oprofile rely on
ltt. In that same posting I listed a number of drivers/subsystems
that already contained tracing statements. Obviously I was pointing
out that there was an opportunity to create a common, uniform
infrastructure based on ltt:
http://marc.theaimsgroup.com/?l=linux-kernel&m=102624656615567&w=2
- Syscalltrack:
In replying to a posting of someone looking for tracing info, there
was a brief discussion as to how syscalltrack could use ltt instead
of: a) redirecting the syscall table, b) have its own buffering
mechanism. Again, relayfs didn't exist at the time:
http://marc.theaimsgroup.com/?l=linux-kernel&m=102822343523369&w=2
- Event logging:
When there was discussion about event logging, there was suggestion
to use ltt's engine. Again, relayfs wasn't there:
http://marc.theaimsgroup.com/?l=linux-kernel&m=101836133400796&w=2

And there are many other cases. As you can see, it's not as if
I didn't try to have this discussion before. Unfortunately, interest
in this was rather limited.

In addition, and this is a very important issue, quite a few
kernel developers mistook LTT for a kernel debugging tool, which
it was never meant to be. When, in fact, if you ask those who have
looked at using it for that purpose (try Marcelo or Andrea) you will
see that they didn't find it to be appropriate for them. And
rightly so, it was never meant for that purpose. Even lately, when
I suggested Ingo try using relayfs instead of his custom tracing
code for his preemption work, he looked at it and said that it
wasn't suited, but would consider reusing parts of it if it were
in the kernel.

So, in general, one thing I learned over the years is to not touch
the topic of kernel debugging even with a 10 foot poll when
discussing LTT.

What you are hinting at here (mention of developers vs. testers,
for example), and your stated preference for the type of ring-buffer
you described earlier clearly goes in the direction I've learned to
avoid: buffering support for the general purpose of kernel debugging.

Let me say outright that I see the relevance of what you are looking
for, but let me also say that what we tried to achieve with relayfs
is to provide a general mechanism for kernel subsystems that need to
convey large amounts of data to user-space. We did not attempt to
solve the problem of providing a buffering framework for core kernel
debugging. As I mentioned to Ingo in the mail I referred to earlier
regarding the type of buffering you are looking for:
> The above tracer may indeed be very appropriate for kernel development,
> but it doesn't provide enough functionality for the requirements of
> mainstream users.

If there is interest for using either relayfs and/or ltt for that
purpose, then this is an entirely different mandate and a few things
would need to be added for that to happen. For starters, we could
add another mode to relayfs. Currently, it supports a locking and
a lockless buffering scheme. We could also have ring-buffer mode
which would function very much as you, and Ingo before, have
described. But let me be crystal clear about this: don't count on
me to make a case for it on LKML. I've had enough flak as it is.
If you believe this is necessary, then you are welcome to make a
case for it, and obtain support from others on LKML. Obviously, as
the maintainers of relayfs, we see no reason to avoid extending it
for purposes others may find it useful for and/or accepting patches
to that end, if indeed such extensions don't preclude its adoption
in the mainline kernel.

Hope this helps clarify things a little,

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
