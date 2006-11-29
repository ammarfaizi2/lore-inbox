Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758927AbWK2XHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758927AbWK2XHH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 18:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758934AbWK2XHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 18:07:07 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:21937 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1758927AbWK2XHD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 18:07:03 -0500
Date: Wed, 29 Nov 2006 15:08:18 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
       Alan Stern <stern@rowland.harvard.edu>,
       Jens Axboe <jens.axboe@oracle.com>, linux-kernel@vger.kernel.org,
       davem@davemloft.net, dhowells@redhat.com
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061129230818.GE2335@us.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <Pine.LNX.4.44L0.0611162148360.24994-100000@netrider.rowland.org> <20061117065128.GA5452@us.ibm.com> <20061117092925.GT7164@kernel.dk> <20061119190027.GA3676@oleg> <20061123145910.GA145@oleg> <20061124182153.GA9868@oleg> <20061127050247.GC5021@us.ibm.com> <20061127161106.GA279@oleg> <20061129192953.GA2335@us.ibm.com> <20061129201646.GA81@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061129201646.GA81@oleg>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2006 at 11:16:46PM +0300, Oleg Nesterov wrote:
> On 11/29, Paul E. McKenney wrote:
> >
> > 1.	The spinlock version will be easier for most people to understand.
> >
> > 2.	The atomic version has better read-side overhead -- probably
> > 	roughly twice as fast on most machines.
> 
> synchronize_xxx() should be a little bit faster too

Good point.

> > 3.	The atomic version will have better worst-case latency under
> > 	heavy read-side load -- at least assuming that the underlying
> > 	hardware is fair.
> >
> > 4.	The spinlock version would have better fairness in face of
> > 	synchronize_xxx() overload.
> 
> Not sure I understand (both 3 and 4) ...

The differences will be slight, and so hardware-dependent that they
don't mean much.

> > 5.	Neither version can be used from irq (but the same is true of
> > 	SRCU as well).
> 
> Hmm... SRCU can't be used from irq, yes. But I think that both versions
> (spinlock needs _irqsave) can ?

I didn't think you could call wait_event() from irq.

For the locked version, you would also need spin_lock_irqsave() or some
such to avoid self-deadlock.

For the atomic version, the fact that synchronize_qrcu() increments
the new counter before decrmenting the old one should mean that calls
to qrcu_read_lock() and qrcu_read_unlock() can be called from irq.
But synchronize_qrcu() must be called from process context, since it
can block.

This might well be important.

> > If I was to choose, I would probably go with the easy-to-understand
> > case, which would push me towards the spinlocks.  If there is a
> > read-side performance problem, then the atomic version can be easily
> > resurrected from the LKML archives.  Maybe have a URL in a comment
> > pointing to the atomic implementation?  ;-)
> 
> But it is so ugly to use spinlock to impement the memory barrier semantics!
> 
> Look,
> 
> 	void synchronize_xxx(struct xxx_struct *sp)
> 	{
> 		int idx;
> 
> 		mutex_lock(&sp->mutex);
> 
> 		spin_lock();
> 		idx = sp->completed++ & 0x1;
> 		spin_unlock();
> 
> 		wait_event(sp->wq, !sp->ctr[idx]);
> 
> 		spin_lock();
> 		spin_unlock();
> 
> 		mutex_unlock(&sp->mutex);
> 	}
> 
> Yes, it looks simpler. But why do we need an empty critical section? it is
> a memory barrier, we can (should?) instead do
> 
> 		/* for wait_event() above */
> 		smp_rmb();
> 		spin_unlock_wait();
> 		smp_mb();
> 
> Then,
> 
> 		spin_lock();
> 		idx = sp->completed++ & 0x1;
> 		spin_unlock();
> 
> means
> 		idx = sp->completed & 0x1;
> 		spin_lock();
> 		sp->completed++
> 		spin_unlock();
> 
> Again, this is a barrier, not a lock! ->completed protected by ->mutex,
> 
> 		sp->completed++;
> 		smp_mb();
> 		spin_unlock_wait(&sp->lock);
> 		/* for wait_event() below */
> 		smp_rmb();
> 
> So in fact spinlock_t is used to make inc/dec of ->ctr atomic. Doesn't
> we have atomic_t for that ?
> 
> That said, if you both think it is better - please send a patch. This is
> a matter of taste, and I am far from sure my taste is the best :)

Heck no!  I was under the mistaken impression that you had coded and
tested both patches.  If you have the atomic one working but the
spinlock one is not to that stage, I am all for going with the atomic
version.  ;-)

> > > Note: I suspect that Documentation/ lies about atomic_add_unless(), see
> > >
> > > 	http://marc.theaimsgroup.com/?l=linux-kernel&m=116448966030359
> >
> > Hmmm...  Some do and some don't:
> >
> > i386:	The x86 semantics, as I understand them, are in fact equivalent
> > 	to having a memory barrier before and after the operation.
> > 	However, the documentation I have is not as clear as it might be.
> 
> Even i386 has non-empty mb(), but atomic_read() is a plain LOAD.

Ah -- I was forgetting the failure path.  You are quite correct.

> > So either the docs or several of the architectures need fixing.
> 
> I think its better to fix the docs.

I must defer to the two Davids...

							Thanx, Paul
