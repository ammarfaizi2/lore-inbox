Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbWAPU4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbWAPU4e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 15:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWAPU4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 15:56:34 -0500
Received: from ns1.siteground.net ([207.218.208.2]:34526 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751198AbWAPU4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 15:56:33 -0500
Date: Mon, 16 Jan 2006 12:56:18 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Christoph Lameter <clameter@engr.sgi.com>,
       Shai Fultheim <shai@scalex86.org>, Nippun Goel <nippung@calsoftinc.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       dipankar@in.ibm.com
Subject: Re: [rfc][patch] Avoid taking global tasklist_lock for single threadedprocess at getrusage()
Message-ID: <20060116205618.GA5313@localhost.localdomain>
References: <20051228225752.GB3755@localhost.localdomain> <43B57515.967F53E3@tv-sign.ru> <20060104231600.GA3664@localhost.localdomain> <43BD70AD.21FC6862@tv-sign.ru> <20060106094627.GA4272@localhost.localdomain> <43C0FC4B.567D18DC@tv-sign.ru> <20060108195848.GA4124@localhost.localdomain> <43C2B1B7.635DDF0B@tv-sign.ru> <20060109205442.GB3691@localhost.localdomain> <43C40507.D1A85679@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C40507.D1A85679@tv-sign.ru>
User-Agent: Mutt/1.4.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the delay..

On Tue, Jan 10, 2006 at 10:03:35PM +0300, Oleg Nesterov wrote:
> Ravikiran G Thirumalai wrote:
> > 
> > > >
> > > > Don't we still need rmb for the RUSAGE_SELF case? we do not take the
> > > > siglock for rusage self and the non c* signal fields are written to
> > > > at __exit_signal...
> > >
> > > I think it is unneeded because RUSAGE_SELF case is "racy" anyway even
> > > if we held both locks, task_struct->xxx counters can change at any
> > > moment.
> > >
> > > But may be you are right.
> > 
> > Hmm...access to task_struct->xxx has been racy, but accessing the
> > signal->* counters were not.  What if read of the signal->utime  was  a
> > hoisted read and signal->stime was a read after the counter is updated?
> > This was not a possibility earlier no?
> 
> Sorry, I can't undestand. Could you please be more verbose ?

What I meant to say was, if a thread has just exited, since we do not use
locks anymore in ST case, the read of signal->utime may happen out of order,

(excuse long lines)

Last thread (RUSAGE_SELF)		Exiting thread


k_getrusage()				__exit_signal()
	.					.
	load sig->utime (hoisted read) 		.
	.					sig->utime = cputime_add(sig->utime, tsk->utime);
	.					sig->stime = cputime_add(sig->stime, tsk->stime);
						.
						.
						spin_unlock(&sighand->siglock); --> (A)
						.
					__unhash_process()
						.
						detach_pid(p, PIDTYPE_PGID);
	if (!thread_group_empty())		.
	.
	don't take any lock based on if --> (B)
	.
	.
	utime = cputime_add(utime, p->signal->utime); /* use cached load above */
	stime = cputime_add(stime, p->signal->stime); /* load from memory */

So although writes happen in order due to (A) above, there is no guarantee
interms of read order when we do not take locks,(as far as my understanding
goes)  so I think a rmb() is needed at (B), else as in this example, some 
counters may have values before the exiting thread updated  the sig-> fields 
and some after the thread updated the sig-> fields.  This might have a 
significant effect than the task_struct->xxx inaccuracies.  Of course 
this is theoretical.  This was not a possibility earlier because 
__exit_signal and k_getrusage() could not run at the same time due to the 
exiting thread taking tasklist lock for write and k_getrusage thread taking 
the lock for read.
I am also cc'ing experts in memory re-ordering issues to check if I am
missing something :)

I think we need a rmb() at sys_times too based on the above. I will make a
patch for that.


> 
> > >
> > > > What is wrong with optimizing by not taking the siglock in RUSAGE_BOTH
> > > > and RUSAGE_CHILDREN?  I would like to add that in too unless  I am
> > > > missing something and the optimization is incorrect.
> > >
> > > We can't have contention on ->siglock when need_lock == 0, so why should
> > > we optimize this case?
> > 
> > We would be saving 1 buslocked operation in that case (on some arches), a
> > cacheline fetch for exclusive (since signal and sighand are on different memory
> > locations), and disabling/enabling onchip interrupts.  But yes, this would be a
> > smaller optimization....Unless you have strong objections this can also
> > go in?
> 
> I don't have strong objections, but I am not a maintainer.
> 
> However, do you have any numbers or thoughts why this optimization
> can make any _visible_ effect?

We know we don't need locks there, so I do not understand why we
should keep them.  Locks are always serializing and expensive operations.  I
believe on some arches disabling on-chip interrupts is also an expensive
operation...some arches might use hypervisor calls to do that which I guess
will have its own overhead...so why have it when we know we don't need it?

Thanks,
Kiran
