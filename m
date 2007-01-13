Return-Path: <linux-kernel-owner+w=401wt.eu-S1422798AbXAMVUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422798AbXAMVUg (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 16:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422799AbXAMVUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 16:20:36 -0500
Received: from smtp.osdl.org ([65.172.181.24]:51313 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422798AbXAMVUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 16:20:35 -0500
Date: Sat, 13 Jan 2007 13:20:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       ak@suse.de, shai@scalex86.org, pravin.shelar@calsoftinc.com
Subject: Re: High lock spin time for zone->lru_lock under extreme conditions
Message-Id: <20070113132023.0f8d2da8.akpm@osdl.org>
In-Reply-To: <20070113195334.GC4234@localhost.localdomain>
References: <20070112160104.GA5766@localhost.localdomain>
	<45A86291.8090408@yahoo.com.au>
	<20070113073643.GA4234@localhost.localdomain>
	<20070113000017.2ad2df12.akpm@osdl.org>
	<20070113195334.GC4234@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, 13 Jan 2007 11:53:34 -0800 Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
> On Sat, Jan 13, 2007 at 12:00:17AM -0800, Andrew Morton wrote:
> > > On Fri, 12 Jan 2007 23:36:43 -0800 Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
> > > > >void __lockfunc _spin_lock_irq(spinlock_t *lock)
> > > > >{
> > > > >        local_irq_disable();
> > > > >        ------------------------> rdtsc(t1);
> > > > >        preempt_disable();
> > > > >        spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
> > > > >        _raw_spin_lock(lock);
> > > > >        ------------------------> rdtsc(t2);
> > > > >        if (lock->spin_time < (t2 - t1))
> > > > >                lock->spin_time = t2 - t1;
> > > > >}
> > > > >
> > > > >On some runs, we found that the zone->lru_lock spun for 33 seconds or more
> > > > >while the maximal CS time was 3 seconds or so.
> > > > 
> > > > What is the "CS time"?
> > > 
> > > Critical Section :).  This is the maximal time interval I measured  from 
> > > t2 above to the time point we release the spin lock.  This is the hold 
> > > time I guess.
> > 
> > By no means.  The theory here is that CPUA is taking and releasing the
> > lock at high frequency, but CPUB never manages to get in and take it.  In
> > which case the maximum-acquisition-time is much larger than the
> > maximum-hold-time.
> > 
> > I'd suggest that you use a similar trick to measure the maximum hold time:
> > start the timer after we got the lock, stop it just before we release the
> > lock (assuming that the additional rdtsc delay doesn't "fix" things, of
> > course...)
> 
> Well, that is exactly what I described above  as CS time.

Seeing the code helps.

>  The
> instrumentation goes like this:
> 
> void __lockfunc _spin_lock_irq(spinlock_t *lock)
> {
>         unsigned long long t1,t2;
>         local_irq_disable();
>         t1 = get_cycles_sync();
>         preempt_disable();
>         spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
>         _raw_spin_lock(lock);
>         t2 = get_cycles_sync();
>         lock->raw_lock.htsc = t2;
>         if (lock->spin_time < (t2 - t1))
>                 lock->spin_time = t2 - t1;
> }
> ...
> 
> void __lockfunc _spin_unlock_irq(spinlock_t *lock)
> {
>         unsigned long long t1 ;
>         spin_release(&lock->dep_map, 1, _RET_IP_);
>         t1 = get_cycles_sync();
>         if (lock->cs_time < (t1 -  lock->raw_lock.htsc))
>                 lock->cs_time = t1 -  lock->raw_lock.htsc;
>         _raw_spin_unlock(lock);
>         local_irq_enable();
>         preempt_enable();
> }
> 
> Am I missing something?  Is this not what you just described? (The
> synchronizing rdtsc might not be really required at all locations, but I 
> doubt if it would contribute a significant fraction to 33s  or even 
> the 3s hold time on a 2.6 GHZ opteron).

OK, now we need to do a dump_stack() each time we discover a new max hold
time.  That might a bit tricky: the printk code does spinlocking too so
things could go recursively deadlocky.  Maybe make spin_unlock_irq() return
the hold time then do:

void lru_spin_unlock_irq(struct zone *zone)
{
	long this_time;

	this_time = spin_unlock_irq(&zone->lru_lock);
	if (this_time > zone->max_time) {
		zone->max_time = this_time;
		dump_stack();
	}
}

or similar.



