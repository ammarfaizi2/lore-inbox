Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266486AbUG1Wcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266486AbUG1Wcg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 18:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266397AbUG1Wb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 18:31:26 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:30213 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S266486AbUG1Waa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 18:30:30 -0400
Date: Wed, 28 Jul 2004 15:30:19 -0700
To: Karim Yaghmour <karim@opersys.com>
Cc: "Bill Huey (hui)" <bhuey@lnxw.com>, Lee Revell <rlrevell@joe-job.com>,
       Scott Wood <scott@timesys.com>, Ingo Molnar <mingo@elte.hu>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>,
       Manas Saksena <manas.saksena@timesys.com>,
       Philippe Gerum <rpm@xenomai.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] IRQ threads
Message-ID: <20040728223019.GA8938@nietzsche.lynx.com>
References: <20040727225040.GA4370@yoda.timesys> <4107CA18.4060204@opersys.com> <1091039327.747.26.camel@mindpipe> <4107FA93.3030801@opersys.com> <1091043218.766.10.camel@mindpipe> <20040728202107.GA6952@nietzsche.lynx.com> <41081F34.7080507@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41081F34.7080507@opersys.com>
User-Agent: Mutt/1.5.6+20040722i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2004 at 05:48:36PM -0400, Karim Yaghmour wrote:
> Two things:
> - What I'm suggesting is a nanokernel-based N kernel scheme, not the
> dual kernel scheme (which is patented BTW).
> - There's only one company out there that is known to sell proprietary
> products around the dual kernel approach, and it isn't mine.

I have to say that I didn't really carefully read the papers for
your stuff and I still don't exactly understand what's going on
with your nanokernel. It sounds interesting, but it doesn't solve
what I think are inescapable preemption problems with the Linux
kernel.

> Indeed. So the question now becomes: is it worth introducing that much
> complexity inside the kernel to solve a problem that matters only
> marginally to server and workstation users? It's already difficult as it
> is to manage the preemption, do we really want to go the full way with
> threaded int handlers and mutexes instead of locks?

Complexity is a kind of relative terms in this conversation. It's
more of a function of what one is uses here verses what other folks
have been doing outside of Linux. I personally don't think it's THAT
hard. It's just that folks inside Linux have really gotten comfortable
using spinlocks for everything instead of another style of thinking.
It's all learnable after you get over the shock and not as hard as
folks think it would be.

> What I'm suggesting is a very simple model that solves 90% of the time-
> sensitive problems I have seen with Linux: Use the Adeos nanokernel to
> implement the real-time component of drivers as a priority domain the
> interrupt pipeline. Hence, instead of the current driver model:
> 1- Int handler
> 2- BH/SoftIRQ/etc.
> We get:
> 1- Hard-rt handler
> 2- Normal Linux handler
> 3- BH/SoftIRQ/etc.

I don't immediately see why this is going to give us hard RT for Linux
applications. I'd like a short explanation if you have time to reply
to this.

> This is even without any RTAI/RTL or anything of that kind.
> 
> And for the rest, then you want to have a look at Philippe Gerum's
> ongoing RTAI-fusion work. With RTAI-fusion, you get the same normal
> Linux ABI for all user-space tasks, but you get hard-rt for free.
> Practically, normal Linux calls are caught and run through RTAI
> instead of Linux. Philippe has already got the standard nanosleep()
> running in hard-rt. So the question is therefore straight-forward:
> should we engineer a path for converting the entire kernel to hard-rt
> or do we keep the kernel as it was designed and add the necessary
> mechanisms for obtaining hard-rt using things that were made to
> provide it by design?

I don't really understand what RTAI fusion is and I would like
some pointers to this. I've read the web page for this, but I wasn't
able to extract a good chunk of information that would give me a
clear picture of what it does.
 
> I personally believe that the added complexity does not benefit
> Linux. I may yet be shown wrong, but with what we can currently do
> with plain vanilla Adeos, and where RTAI/fusion is heading, the
> problem space of applications which can't be serviced by this
> combination is getting increasingly limited.

Well, you have to think of it in a wider scope for a bit. If you
want rate-guarateed streaming partition support from SGI's XFS,
touching dcache, VM, etc... then you have to dealing with
non-preemptable locking throughout the Linux kernel, no choice.
Having a pervasive model is a superior solution to dual kernels
since you have the full support of Linux verses the constrained
semantics and APIs of a controlled sub-domain. That typically needs
to be temporarly buffered (and API) both in and out of the a
Linux sub-system. I fail to see how a nano-kernel, RTAI and other
supporting kernel sub-systems can get around this problem without
solving preemption issues within Linux.

When you think of things like this you have to think of what's
happening now with applications that include the traditional RT
stuff as well as media driven apps, which are becoming more and
prevalent as little things like cell phone devices get more and
more bandwidth. For media driven applications, none of the
secondary/dual kernel or things like that can properly deal with
things like IO thread/channel bonding, which depends on various
IO layers that touch many SMP locked critical sections/systems
in the kernel. Running into Linux's SMP locking logic in these
cases are inescapable, so I don't see a choice but doing some
kind of full lock conversion.

Anytime you have an application that uses a full suite of Linux
facilities will have this problem. It just hasn't been done for
a 2.6 kernel just yet.

bill

