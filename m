Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262595AbVAKIpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262595AbVAKIpE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 03:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262557AbVAKIpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 03:45:04 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:20626
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S262605AbVAKIoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 03:44:55 -0500
Subject: Re: User space out of memory approach
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Edjard Souza Mota <edjard@gmail.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Mauricio Lin <mauriciolin@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <4d6522b90501101803523eea79@mail.gmail.com>
References: <3f250c71050110134337c08ef0@mail.gmail.com>
	 <20050110192012.GA18531@logos.cnet>
	 <4d6522b9050110144017d0c075@mail.gmail.com>
	 <20050110200514.GA18796@logos.cnet>
	 <1105403747.17853.48.camel@tglx.tec.linutronix.de>
	 <4d6522b90501101803523eea79@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 11 Jan 2005 09:44:53 +0100
Message-Id: <1105433093.17853.78.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-11 at 04:03 +0200, Edjard Souza Mota wrote:
> > I have no objections against the userspace provided candidate list
> > option, but as long as the main sources of trouble
> > 
> >         - invocation
> >         - reentrancy
> >         - timed, counted, blah ugly protection
> >         - selection problem
> > 
> > are not fixed properly, we don't need to discuss the inclusion of a
> > userspace provided candidate list.
> 
> Any solution that doesn't  offer a proper approach to the above issues
> should not be discussed anyway. By allowing the ranking goes up to the
> user space is not meant only for user testing ranking, but to keep the
> OOM Killer kernel code simpler and clean. As a matter of fact, even
> protected.
>
> Consider the invocation for example. It comes in two phases with this proposal:

I consider the invocation of out_of_memory in the first place. This is
the real root of the problems. The ranking is a different playground.
Your solution does not solve
- invocation madness
- reentrancy protection
- the ugly mess of timers, counters... in out_of_memory, which aren't
neccecary at all

This must be solved first in a proper way, before we talk about ranking.

You are definitely curing the symptom instead of the cause.

> 1) ranking for the most likely culprits only starts when memory consumption
>     gets close to the red zone (for example 98% or something like that).
> 2) killing just gets the first candidate from the list and kills it.
> No need to calculate
>     at kernel level.

What is the default behaviour when no userspace settings are available -
Nothing ? Are you really expecting that we change every root fs in order
to be able to upgrade the kernel for solving this _kernel_ problem ?

Who is setting up those userspace constraints ? Joe User, who is barely
able to find the power on button on his box ? The sysadmin, who will
have to adjust the list for each box depending on the apps it runs or
the user who is logged into the box ?

Memory management _is_ a kernel task and so the shortage of memory has
to be handled by the kernel on its own in the first place. Adding user
space support for certain tasks is a good thing, but not a solution to
the problem itself.

> The selection problem is very dependent on the ranking algorithm. For PCs it
> may not be a trouble, but for emdedded devices? yes it is. The ranking at the
> kernel level uses only int type of integer. If you get the log file
> for the ranking
> in any embedded device you will notice that many processes end up with
> the same ranking point. Thus, there will never be the best choice in this way.

I know the constrains of embedded boxes well enough to know that there
is a bit of a difference to a desktop machine.

> By moving just the ranking to the user space fix this problem 'cause you may
> use float to order PIDs with different indexes. The good side effect is that we 
> allow better ways of choosing the culprit by means of diffrent calculations to 
> meet different patterns of memory consumtion.

I'm running Andrea's and my combined fixes on a couple of embedded and
desktop boxes and it has proven to be a proper in kernel solution for
the in kernel problem. 

I don't argue againts the ability to provide a culprit list to the
kernel, but as I said before it only can be a optional addon to a proper
in kernel solution.

tglx


