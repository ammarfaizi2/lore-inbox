Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964858AbWARCtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbWARCtx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 21:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbWARCtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 21:49:53 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:2949 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S964858AbWARCtw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 21:49:52 -0500
Date: Tue, 17 Jan 2006 18:49:48 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Keith Owens <kaos@sgi.com>
Cc: John Hesterberg <jh@sgi.com>, Matt Helsley <matthltc@us.ibm.com>,
       Jes Sorensen <jes@trained-monkey.org>,
       Shailabh Nagar <nagar@watson.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Jay Lan <jlan@engr.sgi.com>, LKML <linux-kernel@vger.kernel.org>,
       elsa-devel@lists.sourceforge.net, lse-tech@lists.sourceforge.net,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, Paul Jackson <pj@sgi.com>,
       Erik Jacobson <erikj@sgi.com>, Jack Steiner <steiner@sgi.com>
Subject: Re: [Lse-tech] Re: [ckrm-tech] Re: [PATCH 00/01] Move Exit Connectors
Message-ID: <20060118024948.GA10407@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060117172617.GA9283@us.ibm.com> <22822.1137542267@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22822.1137542267@ocs3.ocs.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 10:57:47AM +1100, Keith Owens wrote:
> "Paul E. McKenney" (on Tue, 17 Jan 2006 09:26:17 -0800) wrote:
[ . . .]
> >One other thing -- given that you are requiring that the read side
> >have preemption disabled, another update-side option would be to
> >use synchronize_sched() to wait for all preemption-disabled code
> >segments to complete.  This would allow you to remove the per-CPU
> >reference counters from the read side, but would require that the
> >update side either (1) be able to block or (2) be able to defer
> >the cleanup to process context.
> 
> Originally I looked at that code but the comment scared me off.
> synchronize_sched() maps to synchronize_rcu() and the comment says that
> this only protects against rcu_read_lock(), not against preempt_disable().

Good point -- in mainline kernels (but not in some realtime
variants), the two guarantees happen to be one and the same.
But the comment certainly does not make this clear.

> /**
>  * synchronize_sched - block until all CPUs have exited any non-preemptive
>  * kernel code sequences.
>  *
>  * This means that all preempt_disable code sequences, including NMI and
>  * hardware-interrupt handlers, in progress on entry will have completed
>  * before this primitive returns.  However, this does not guarantee that
>  * softirq handlers will have completed, since in some kernels
>  *
>  * This primitive provides the guarantees made by the (deprecated)
>  * synchronize_kernel() API.  In contrast, synchronize_rcu() only
>  * guarantees that rcu_read_lock() sections will have completed.
>  */
> #define synchronize_sched() synchronize_rcu()

Does the following change help?

							Thanx, Paul

diff -urpNa -X dontdiff linux-2.6.15/include/linux/rcupdate.h linux-2.6.15-RCUcomment/include/linux/rcupdate.h
--- linux-2.6.15/include/linux/rcupdate.h	2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.15-RCUcomment/include/linux/rcupdate.h	2006-01-17 18:48:33.000000000 -0800
@@ -265,11 +265,14 @@ static inline int rcu_pending(int cpu)
  * This means that all preempt_disable code sequences, including NMI and
  * hardware-interrupt handlers, in progress on entry will have completed
  * before this primitive returns.  However, this does not guarantee that
- * softirq handlers will have completed, since in some kernels
+ * softirq handlers will have completed, since in some kernels, these
+ * handlers can run in process context, and can block.
  *
  * This primitive provides the guarantees made by the (deprecated)
  * synchronize_kernel() API.  In contrast, synchronize_rcu() only
  * guarantees that rcu_read_lock() sections will have completed.
+ * In "classic RCU", these two guarantees happen to be one and
+ * the same, but can differ in realtime RCU implementations.
  */
 #define synchronize_sched() synchronize_rcu()
 
