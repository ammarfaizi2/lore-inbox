Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263146AbTE0JjK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 05:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263171AbTE0JjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 05:39:10 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:43980 "EHLO
	ophelia.hpce.nec.com") by vger.kernel.org with ESMTP
	id S263146AbTE0JjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 05:39:07 -0400
From: Erich Focht <efocht@hpce.nec.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: [Lse-tech] Node affine NUMA scheduler extension
Date: Tue, 27 May 2003 11:54:52 +0200
User-Agent: KMail/1.5.1
Cc: LSE <lse-tech@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200305271031.55554.efocht@hpce.nec.com> <20030527091104.GB31510@wotan.suse.de>
In-Reply-To: <20030527091104.GB31510@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305271154.52608.efocht@hpce.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 May 2003 11:11, Andi Kleen wrote:
> On Tue, May 27, 2003 at 10:31:55AM +0200, Erich Focht wrote:
> > This patch is an adaptation of the earlier work on the node affine
> > NUMA scheduler to the NUMA features meanwhile integrated into
> > 2.5. Compared to the patch posted for 2.5.39 this one is much simpler
> > and easier to understand.
>
> Yes, it is also much simpler than my implementation (I did a similar
> homenode scheduler for an 2.4 kernel). The basic principles are the same.

:-)

> But the main problems I have is that the tuning for threads is very
> difficult. On AMD64 where Node equals CPU it is important
> to home node balance threads too. After some experiments I settled on
> homenode assignment on the first load balance (called "lazy homenode")
> When a thread clones it initially executes on the CPU of the parent, but
> there is a window until the first load balance tick where it can allocate
> memory on the wrong node.  I found a lot of code runs very badly until the
> cache decay parameter is set to 0 (no special cache affinity) to allow
> quick initial migration.

Interesting observation, I didn't make it when I tried the lazy
homenode (quite a while ago). But I was focusing on MPI jobs. So what
if we add a condition to CAN_MIGRATE which disables the cache affinity
before the first load balance? 

> Migration directly on fork/clone requires a lot
> of changes and also breaks down on some benchmarks.

Hmmm, I wouldn't allow this to any task/child, only to special
ones. Under 2.4 I currently use a sched_balance_fork() function
similar to  sched_balance_exec(). Tasks have a default initial load
balancing policy of being migrated (and selecting the homenode) at
exec(). This can be changed (with prctl) to fork(). The ilb policy is
inheritable. Works fine for OpenMP jobs.

Regards,
Erich


