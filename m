Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbWH2BdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWH2BdK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 21:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbWH2BdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 21:33:10 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:46984 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750917AbWH2BdI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 21:33:08 -0400
Date: Tue, 29 Aug 2006 07:03:14 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Paul E McKenney <paulmck@us.ibm.com>
Subject: Re: [PATCH 3/4] RCU: preemptible RCU implementation
Message-ID: <20060829013314.GD32697@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060828160845.GB3325@in.ibm.com> <20060828161222.GE3325@in.ibm.com> <20060828204611.GB719@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060828204611.GB719@infradead.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2006 at 09:46:11PM +0100, Christoph Hellwig wrote:
> On Mon, Aug 28, 2006 at 09:42:22PM +0530, Dipankar Sarma wrote:
> > From: Paul McKenney <paulmck@us.ibm.com>
> > http://www.rdrop.com/users/paulmck/RCU/OLSrtRCU.2006.08.11a.pdf
> > 
> > This patch was developed as a part of the -rt kernel
> > development and meant to provide better latencies when
> > read-side critical sections of RCU don't disable preemption.
> > As a consequence of keeping track of RCU readers, the readers
> > have a slight overhead (optimizations in the paper).
> > This implementation co-exists with the "classic" RCU
> > implementations and can be switched to at compiler.
> 
> NACK.  While a readers can sleep rcu version definitly has it's
> we should make it all or nothing.  Either we always gurantee that
> a rcu reader can sleep or never without external patches.  Having
> this a config option is the ultimate defeat for any kind of bug
> reproducabilility.

Good point. RCU users that want to sleep in the read-side
critical sections should be using *srcu APIs* which are separate
from RCU APIs - srcu_read_lock(), srcu_read_unlock(), synchronize_srcu().
I think of CONFIG_PREEMPT_RCU as similar to CONFIG_PREEMPT where
preemption is allowed in certain sections in the kernel code.
This makes even more sense once CONFIG_PREEMPT_RT is in
mainline in some form. I should perhaps put in explicit checks
to disallow people from sleeping in RCU read-side
critical sections.

> Please make the patch undconditional and see if it doesn't cause
> any significant slowdowns in production-like scenaries and then
> we can switch over to the readers can sleep variant unconditionally
> at some point.

It is still some way from getting there. It needs per-cpu callback
queues for which I am working on a patch. It also needs some
more of Paul's work to reduce read-side overheads. However,
it is reasonably useful in low-end SMP systems for workloads
requiring better scheduling latencies, so I see no reason
not to provide this for CONFIG_PREEMPT users. Besides,
this is one step forward towards merging "crazy" stuff from
-rt :)

Thanks
Dipankar
