Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270727AbTHGUtF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 16:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270749AbTHGUtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 16:49:05 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:41909
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S270727AbTHGUs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 16:48:59 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Daniel Phillips <phillips@arcor.de>, Ed Sweetman <ed.sweetman@wmich.edu>,
       Eugene Teo <eugene.teo@eugeneteo.net>
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
Date: Thu, 7 Aug 2003 16:51:07 -0400
User-Agent: KMail/1.5
Cc: LKML <linux-kernel@vger.kernel.org>, kernel@kolivas.org,
       Davide Libenzi <davidel@xmailserver.org>
References: <1059211833.576.13.camel@teapot.felipe-alfaro.com> <200308061728.04447.rob@landley.net> <200308071642.55517.phillips@arcor.de>
In-Reply-To: <200308071642.55517.phillips@arcor.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308071651.07522.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 August 2003 11:42, Daniel Phillips wrote:
> On Wednesday 06 August 2003 22:28, Rob Landley wrote:
> > So, how does SCHED_SOFTRR fail?  Theoretically there is a minimum
> > timeslice you can hand out, yes?  And an upper bound on scheduling
> > latency.  So logically, there is some maximum number "N" of SCHED_SOFTRR
> > tasks running at once where you wind up round-robining with minimal
> > timeslices and the system is saturated.  At N+1, you fall over.  (And in
> > reality, there are interrupts and kernel threads and other things going
> > on that get kind of cramped somewhere below N.)
>
> The upper bound for softrr realtime scheduling isn't based on number of
> tasks, it's a global slice of cpu time: so long as the sum of running times
> of all softrr tasks in the system lies below limit, softrr tasks will be
> scheduled as SCHED_RR, otherwise they will be SCHED_NORMAL.

I thought one of the advantages here was that a userspace program could give 
hints about whether the scheduler should optimize it for latency or for 
throughput, without having to be root.

XFree86 and Konqueror Xterm and Kmail could all say "latency in me is end-user 
visible, so I care more about latency than throughput".  And stuff like the 
nightly cron job that exists just to screw up my desktop because I AM awake 
at 4 am a noticeable percentage of the time...  Anyway, it cares about 
throughput and not at all about latency.  Same with just about any invocation 
of gcc, so they'd never set the flags.

If Bash really wanted to get fancy, it could set the flag depending on whether 
the process on the other end of its input PTY had the flag or not, but let's 
worry about that later... :)

> > In theory, the real benefit of SCHED_SOFTRR is that an attempt to switch
> > to it can fail with -EMYBRAINISMELTING up front, so you know when it
> > won't work at the start, rather than having it glitch halfway through the
> > run.
>
> Not as implemented.  Anyway, from the user's point of view, that would be
> an unpleasant way for a sound player to fail.  What we want is something
> more like a little red light that comes on (in the form of error
> statistics, say) any time a softrr process gets demoted.  Granted, there
> may be situations where what you want is the right behavior, but it's (as
> you say) a separate issue of resource allocation.

Uh-huh.

So with SCHED_SOFTRR, if the system gets heavily loaded enough later on then 
the SOFTRR tasks can get demoted and start skipping.  So we're back to having 
a system where cron had better not start up while you're mixing sound because 
it might put you over the edge.

I fail to see how this is an improvement on Con's "carpet bomb the problem 
with heuristics out the wazoo" approach?  (I like heuristcs.  They're like 
Duct Tape.  I like Duct Tape.)

> Regards,
>
> Daniel

Rob
