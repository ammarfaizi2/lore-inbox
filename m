Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268025AbUIAXsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268025AbUIAXsX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 19:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267523AbUIAXlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 19:41:21 -0400
Received: from ozlabs.org ([203.10.76.45]:57988 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268115AbUIAX3D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 19:29:03 -0400
Subject: Re: [PATCH] cpu hotplug fixes for dependent_sleeper and
	wake_sleeping_dependent
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ingo Molnar <mingo@elte.hu>
Cc: Nathan Lynch <nathanl@austin.ibm.com>, Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040830132925.GA1531@elte.hu>
References: <1093858876.11274.50.camel@biclops.private.network>
	 <20040830132925.GA1531@elte.hu>
Content-Type: text/plain
Message-Id: <1094042223.17828.78.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 02 Sep 2004 09:25:21 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-30 at 23:29, Ingo Molnar wrote:
> * Nathan Lynch <nathanl@austin.ibm.com> wrote:
> 
> > To recap, offlining a cpu with current bk results in the "Aiee,
> > killing interrupt handler!" panic from do_exit().  This seems to be
> > triggered only with CONFIG_PREEMPT and CONFIG_SCHED_SMT both enabled. 
> > I believe the problem is that when do_stop() calls schedule(),
> > dependent_sleeper() drops the "offline" cpu's rq->lock and never
> > reacquires it.
> > 
> > The following seems to work (tested on ppc64).  Is there a better way?
> 
> > -	if (!(sd->flags & SD_SHARE_CPUPOWER))
> > +	if (!(sd->flags & SD_SHARE_CPUPOWER) || cpu_is_offline(this_cpu))
> 
> > +	if (!(sd->flags & SD_SHARE_CPUPOWER) || cpu_is_offline(this_cpu))
> 
> it would really be nice to do this without any runtime overhead. Rusty?

If the scheduling topology is updated atomically (ie. inside
__cpu_disable), this would not happen; there are patches around to do
this and I think longer term this is the correct fix.  However, I
believe a good current fix is to merely ensure that the current cpu is
always set in dependent_sleeper(), something like:L

	/*
	 * The same locking rules and details apply as for
	 * wake_sleeping_dependent():
	 */
	spin_unlock(&this_rq->lock);
	cpus_and(sibling_map, sd->span, cpu_online_map);
+	/* Include this CPU, for special case of going us dying */
+	cpu_set(this_cpu, sibling_map);
	for_each_cpu_mask(i, sibling_map)
		spin_lock(&cpu_rq(i)->lock);
	cpu_clear(this_cpu, sibling_map);

Not quite free, but very cheap...
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

