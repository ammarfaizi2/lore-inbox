Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031049AbWKUWGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031049AbWKUWGS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 17:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031223AbWKUWGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 17:06:17 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:10958 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1031049AbWKUWGR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 17:06:17 -0500
Date: Tue, 21 Nov 2006 14:07:34 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061121220734.GG2013@us.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20061120185712.GA95@oleg> <Pine.LNX.4.44L0.0611201439350.7569-100000@iolanthe.rowland.org> <20061121200441.GA341@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061121200441.GA341@oleg>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2006 at 11:04:41PM +0300, Oleg Nesterov wrote:
> On 11/20, Alan Stern wrote:
> >
> > On Mon, 20 Nov 2006, Oleg Nesterov wrote:
> >
> > > So, if we have global A == B == 0,
> > >
> > > 	CPU_0		CPU_1
> > >
> > > 	A = 1;		B = 2;
> > > 	mb();		mb();
> > > 	b = B;		a = A;
> > >
> > > It could happen that a == b == 0, yes?
> >
> > 	Both CPUs execute their "mb" instructions.  The mb forces each
> > 	cache to wait until it receives an Acknowdgement for the
> > 	Invalidate it sent.
> >
> > 	Both caches send an Acknowledgement message to the other.  The
> > 	mb instructions complete.
> >
> > 	"b = B" and "a = A" execute.  The caches return A==0 and B==0
> > 	because they haven't yet invalidated their cache lines.
> >
> > The reason the code failed is because the mb instructions didn't force
> > the caches to wait until the Invalidate messages in their queues had been
> > fully carried out (i.e., the lines had actually been invalidated).
> 
> However, from
> 	http://marc.theaimsgroup.com/?l=linux-kernel&m=113435711112941
> 
> Paul E. McKenney wrote:
> >
> > 2.      rmb() guarantees that any changes seen by the interconnect
> >         preceding the rmb() will be seen by any reads following the
> >         rmb().
> >
> > 3.      mb() combines the guarantees made by rmb() and wmb().
> 
> Confused :(

There are the weasel words "seen by the interconnect".  Alan is
pointing out that the stores to A and B might not have been "seen by the
interconnect" at the time that the pair of mb() instructions execute,
since the other function of the mb() instructions is to ensure that
any stores prior to each mb() is "seen by the interconnect" before any
subsequenct stores are "seen by the interconnect".

Why wouldn't the store to A be seen by the interconnect at the time of
CPU 1's mb()?  Because the cacheline containing A is still residing at
CPU 1.  CPU 0's store to A cannot possibly be seen by the interconnect
until after CPU 0 receives the corresponding cacheline.

Yes, it is confusing.  Memory barriers work a bit more straightforwardly
on MMIO accesses, thankfully.  But it would probably be good to strive
for minimal numbers of memory barriers, especially in common code.  :-/

						Thanx, Paul
