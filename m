Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264461AbTDXVWp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 17:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264463AbTDXVWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 17:22:45 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:46087 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264461AbTDXVWk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 17:22:40 -0400
Date: Thu, 24 Apr 2003 17:29:40 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Andrew Theurer <habanero@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       ricklind@us.ibm.com
Subject: Re: [patch] HT scheduler, sched-2.5.68-B2
In-Reply-To: <1574320000.1051137515@flay>
Message-ID: <Pine.LNX.3.96.1030424162544.11351D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Apr 2003, Andrew Theurer wrote:

> Well on high load, you shouldn't have an idle cpu anyway, so you would never 
> pass the requirements for the agressive -idle- steal even if it was turned 
> on.   On low loads on HT, without this agressive balance on cpu bound tasks, 
> you will always load up one core before using any of the others.  When you 
> fork/exec, the child will start on the same runqueue as the parent, the idle 
> sibling will start running it, and it will never get a chance to balance 
> properly while it's in a run state.  This is the same behavior I saw with the 
> NUMA-HT solution, because I didn't have this agressive balance (although it 
> could be added I suppose), and as a result it consistently performed less 
> than Ingo's solution (but still better than no patch at all).

Sorry if I misunderstand, but if HT is present, I would think that you
would want to start the child of a fork on the same runqueue, because the
cache is loaded, and to run the child first because in many cases the
child will do and exac. At that point it is probable that the exec'd
process run on another CPU would leave the cache useful to the parent.

I fully admit that this is "seems to me" rather than measured, but
protecting the cache is certainly a good thing in general.


On Wed, 23 Apr 2003, Martin J. Bligh wrote:

> Actually, what must be happening here is that we're agressively stealing
> things on non-HT machines ... we should be able to easily prevent that.
> 
> Suppose we have 2 real cpus + HT ... A,B,C,D are the cpus, where A, B 
> are HT twins, and C,D are HT twins. A&B share runqueue X, and C&D share
> runqueue Y
> 
> What I presume you're trying to do is when A and B are running 1 task
> each, and C and D are not running anything, balance out so we have
> one on A and one on C. If we define some "nr_active(rq)" concept to be
> the number of tasks actually actively running on cpus, then if we we're
> switching from nr_actives of 2/0 to 1/0.
> 
> However, we don't want to switch from 2/1 to 1/2 ... that's pointless.
> Or 0/1 to 1/0 (which I think it's what's happening). But in the case
> where we had (theoretically) 4 HT siblings per real cpu, we would want
> to migrate 1/3 to 2/2.
> 
> The key is that we want to agressively steal when 
> nr_active(remote) - nr_active(idle) > 1 ... not > 0.
> This will implicitly *never* happen on non HT machines, so it seems
> like a nice algorithm ... ?

Is it really that simple? 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

