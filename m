Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263271AbTE0LXp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 07:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263274AbTE0LXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 07:23:45 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:5329 "EHLO
	ophelia.hpce.nec.com") by vger.kernel.org with ESMTP
	id S263271AbTE0LXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 07:23:44 -0400
From: Erich Focht <efocht@hpce.nec.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: [Lse-tech] Node affine NUMA scheduler extension
Date: Tue, 27 May 2003 13:39:29 +0200
User-Agent: KMail/1.5.1
Cc: LSE <lse-tech@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200305271031.55554.efocht@hpce.nec.com> <200305271154.52608.efocht@hpce.nec.com> <20030527100148.GE31510@wotan.suse.de>
In-Reply-To: <20030527100148.GE31510@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305271339.29151.efocht@hpce.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 May 2003 12:01, Andi Kleen wrote:
> > > allocate memory on the wrong node.  I found a lot of code runs very
> > > badly until the cache decay parameter is set to 0 (no special cache
> > > affinity) to allow quick initial migration.
> >
> > Interesting observation, I didn't make it when I tried the lazy
> > homenode (quite a while ago). But I was focusing on MPI jobs. So what
> > if we add a condition to CAN_MIGRATE which disables the cache affinity
> > before the first load balance?
>
> What I currently have is two cache decay variables: one is used if the
> homenode is not assigned, the other otherwise. Both are sysctls too.
> But it obviously only works with lazy homenode, but the state is the same.
> I'm still not completely happy with it though.
>
> Why exactly did you gave up to use the lazy homenode?

I left the loadbalancer to decide on where the homenode should be. And
the decision wasn't good enough (it lead to unbalanced nodes, that's
certainly not the case on Opteron :-). So it made sense to have a
specialized homenode chooser which considered the node loads instead
of changing the normal load balancer.

BTW: do you assign the homenode at first load balancing or at first
cross-node balancing?

> > similar to  sched_balance_exec(). Tasks have a default initial load
> > balancing policy of being migrated (and selecting the homenode) at
> > exec(). This can be changed (with prctl) to fork(). The ilb policy is
> > inheritable. Works fine for OpenMP jobs.
>
> Hmm, I should try that I guess. Where do you call it? At the end of
> do_fork? I tried to hack up wake_up_forked_process() to do it, but it
> required large scale changes all over the scheduler so I eventually gave
> up.

For the processes with ilb_policy=FORK I chose the homenode and set
the cpu before the task is woken up. It is done in do_fork right after
the task structure has been cloned. wake_up_forked_process was changed
to lock the rq of the child (and not the one of current) and not set
the cpu any more. I don't think there was more...

Regards,
Erich


