Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933297AbWKSVLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933297AbWKSVLU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 16:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933301AbWKSVLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 16:11:20 -0500
Received: from pool-71-111-72-250.ptldor.dsl-w.verizon.net ([71.111.72.250]:7774
	"EHLO IBM-8EC8B5596CA.beaverton.ibm.com") by vger.kernel.org
	with ESMTP id S933297AbWKSVLT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 16:11:19 -0500
Date: Sun, 19 Nov 2006 13:07:46 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
       Jens Axboe <jens.axboe@oracle.com>,
       Alan Stern <stern@rowland.harvard.edu>,
       Linus Torvalds <torvalds@osdl.org>, Thomas Gleixner <tglx@timesys.com>,
       Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>, David Miller <davem@davemloft.net>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, manfred@colorfullife.com
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061119210746.GD4427@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <Pine.LNX.4.64.0611161414580.3349@woody.osdl.org> <Pine.LNX.4.44L0.0611162148360.24994-100000@netrider.rowland.org> <20061117065128.GA5452@us.ibm.com> <20061117092925.GT7164@kernel.dk> <20061117183945.GA367@oleg> <20061118002845.GF2632@us.ibm.com> <20061118184624.GA163@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061118184624.GA163@oleg>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2006 at 09:46:24PM +0300, Oleg Nesterov wrote:
> On 11/17, Paul E. McKenney wrote:
> >
> > Oleg, any thoughts about Jens's optimization?  He would code something
> > like:
> >
> > 	if (srcu_readers_active(&my_srcu))
> > 		synchronize_srcu();
> > 	else
> > 		smp_mb();
> 
> Well, this is clearly racy, no? I am not sure, but may be we can do
> 
> 	smp_mb();
> 	if (srcu_readers_active(&my_srcu))
> 		synchronize_srcu();
> 
> in this case we also need to add 'smp_mb()' into srcu_read_lock() after
> 'atomic_inc(&sp->hardluckref)'.
> 
> > However, he is doing ordered I/O requests rather than protecting data
> > structures.
> 
> Probably this makes a difference, but I don't understand this.

OK, one hypothesis here...

	The I/Os must be somehow explicitly ordered to qualify
	for I/O-barrier separation.  If two independent processes
	issue I/Os concurrently with a third process doing an
	I/O barrier, the I/O barrier is free to separate the
	two concurrent I/Os or not, on its whim.

Jens, is the above correct?  If so, what would the two processes
need to do in order to ensure that their I/O was considered to be
ordered with respect to the I/O barrier?  Here are some possibilities:

1.	I/O barriers apply only to preceding and following I/Os from
	the process issuing the I/O barrier.

2.	As for #1 above, but restricted to task rather than process.

3.	I/O system calls that have completed are ordered by the
	barrier to precede I/O system calls that have not yet
	started, but I/O system calls still in flight could legally
	land on either side of the concurrently executing I/O
	barrier.

4.	Something else entirely?

Given some restriction like one of the above, it is entirely possible
that we don't even need the memory barrier...

						Thanx, Paul
