Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275057AbTHGEwg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 00:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275058AbTHGEwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 00:52:36 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:43656
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S275057AbTHGEwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 00:52:34 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Daniel Phillips <phillips@arcor.de>, Ed Sweetman <ed.sweetman@wmich.edu>,
       Eugene Teo <eugene.teo@eugeneteo.net>
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
Date: Wed, 6 Aug 2003 17:28:04 -0400
User-Agent: KMail/1.5
Cc: LKML <linux-kernel@vger.kernel.org>, kernel@kolivas.org
References: <1059211833.576.13.camel@teapot.felipe-alfaro.com> <3F2264DF.7060306@wmich.edu> <200307271046.30318.phillips@arcor.de>
In-Reply-To: <200307271046.30318.phillips@arcor.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308061728.04447.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 27 July 2003 11:46, Daniel Phillips wrote:

> The definition of a realtime scheduler is that the worst case latency is
> bounded.  The current crop of interactive tweaks do not do that.  So we
> need a scheduler with a bounded worst case.  Davide Libenzi's recent patch
> that implements a new SCHED_SOFTRR scheduler policy, usable by non-root
> users, provides such a bound.  Please don't lose sight of the fact that
> this is the correct solution to the problem, and that interactive tweaking,
> while it may produce good results for some or even most users in some or
> even most situations, will never magically transform Linux into an
> operating system that an audiophile could love.

Thinking out loud for a bit, please tell me if I'm wrong about SCHED_SOFTRR...

Whatever the policy is, there's only so many ticks to go around and there is 
an overload for which it will fail.  No resource allocation scheme can 
prevent starvation if there simply isn't enough of the resource to go around.

So, how does SCHED_SOFTRR fail?  Theoretically there is a minimum timeslice 
you can hand out, yes?  And an upper bound on scheduling latency.  So 
logically, there is some maximum number "N" of SCHED_SOFTRR tasks running at 
once where you wind up round-robining with minimal timeslices and the system 
is saturated.  At N+1, you fall over.  (And in reality, there are interrupts 
and kernel threads and other things going on that get kind of cramped 
somewhere below N.)

In theory, the real benefit of SCHED_SOFTRR is that an attempt to switch to it 
can fail with -EMYBRAINISMELTING up front, so you know when it won't work at 
the start, rather than having it glitch halfway through the run.  At which 
point half the fun becomes policy decisions about how to allocate the finite 
number of SCHED_SOFTRR slots between however many users are trying to use the 
system, which gets into Alan Cox's accounting work...

Sorry if this is old hat; I'm still a week and change behind on the list, but 
catching up... :)

Rob


