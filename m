Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263131AbTE0Jsh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 05:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263176AbTE0Jsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 05:48:37 -0400
Received: from ns.suse.de ([213.95.15.193]:10259 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263131AbTE0Jsg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 05:48:36 -0400
Date: Tue, 27 May 2003 12:01:48 +0200
From: Andi Kleen <ak@suse.de>
To: Erich Focht <efocht@hpce.nec.com>
Cc: Andi Kleen <ak@suse.de>, LSE <lse-tech@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Node affine NUMA scheduler extension
Message-ID: <20030527100148.GE31510@wotan.suse.de>
References: <200305271031.55554.efocht@hpce.nec.com> <20030527091104.GB31510@wotan.suse.de> <200305271154.52608.efocht@hpce.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305271154.52608.efocht@hpce.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 11:54:52AM +0200, Erich Focht wrote:
> > But the main problems I have is that the tuning for threads is very
> > difficult. On AMD64 where Node equals CPU it is important
> > to home node balance threads too. After some experiments I settled on
> > homenode assignment on the first load balance (called "lazy homenode")
> > When a thread clones it initially executes on the CPU of the parent, but
> > there is a window until the first load balance tick where it can allocate
> > memory on the wrong node.  I found a lot of code runs very badly until the
> > cache decay parameter is set to 0 (no special cache affinity) to allow
> > quick initial migration.
> 
> Interesting observation, I didn't make it when I tried the lazy
> homenode (quite a while ago). But I was focusing on MPI jobs. So what
> if we add a condition to CAN_MIGRATE which disables the cache affinity
> before the first load balance? 

What I currently have is two cache decay variables: one is used if the
homenode is not assigned, the other otherwise. Both are sysctls too.
But it obviously only works with lazy homenode, but the state is the same.
I'm still not completely happy with it though.

Why exactly did you gave up to use the lazy homenode?

> 
> > Migration directly on fork/clone requires a lot
> > of changes and also breaks down on some benchmarks.
> 
> Hmmm, I wouldn't allow this to any task/child, only to special
> ones. Under 2.4 I currently use a sched_balance_fork() function

Yes, I agree.

> similar to  sched_balance_exec(). Tasks have a default initial load
> balancing policy of being migrated (and selecting the homenode) at
> exec(). This can be changed (with prctl) to fork(). The ilb policy is
> inheritable. Works fine for OpenMP jobs.

Hmm, I should try that I guess. Where do you call it? At the end of do_fork?
I tried to hack up wake_up_forked_process() to do it, but it required
large scale changes all over the scheduler so I eventually gave up.

-Andi
