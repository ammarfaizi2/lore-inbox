Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262541AbVAESap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262541AbVAESap (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 13:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbVAESap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 13:30:45 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:47509 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262541AbVAESab
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 13:30:31 -0500
Date: Wed, 5 Jan 2005 10:30:07 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       Dipankar Sarma <dipankar@in.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] rcu: eliminate rcu_data.last_qsctr
Message-ID: <20050105183007.GA1272@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <41AA0D5F.21CB9ED3@tv-sign.ru> <41D2CF3B.4040304@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41D2CF3B.4040304@colorfullife.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2004 at 04:37:31PM +0100, Manfred Spraul wrote:
> Oleg Nesterov wrote:
> 
> >last_qsctr is used in rcu_check_quiescent_state() exclusively.
> >We can reset qsctr at the start of the grace period, and then
> >just test qsctr against 0.
> >
> > 
> >
> It seems the patch got lost, I've updated it a bit and resent it to Andrew.
> 
> But: I think there is the potential for an even larger cleanup, although 
> this would be more a rewrite:
> Get rid of rcu_check_quiescent_state and instead use something like this 
> in rcu_qsctr_inc:
> 
> static inline void rcu_qsctr_inc(int cpu)
> {
>        struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
>        if (rdp->quiescbatch != rcp->cur) {
>             /* a new grace period is running. And we are at a quiescent
>              * point, so complete it
>              */
>             spin_lock(&rsp->lock);
>             rdp->quiescbatch = rcp->cur;
>             cpu_quiet(rdp->cpu, rcp, rsp);
>            spin_unlock(&rsp->lock);
>     }
> }
> 
> It's just an idea, it needs testing on big systems - does reading from 
> the global rcp from every schedule call cause any problems? The cache 
> line is virtually read-only, so it shouldn't cause trashing, but who knows?

Hello, Manfred,

The main concern I have with this is not cache thrashing of rcp->cur,
but shrinking the grace periods on large systems, which can result in
extra overhead per callback, since the shorter grace periods will tend
to have fewer callbacks.  We saw this problem on some of the early
RCU-infrastructure patches.

Another approach would be to conditionally compile the two versions,
though that might make the code more complex.

						Thanx, Paul
