Return-Path: <linux-kernel-owner+w=401wt.eu-S1161306AbXAMIAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161306AbXAMIAb (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 03:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161311AbXAMIAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 03:00:31 -0500
Received: from smtp.osdl.org ([65.172.181.24]:39072 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161306AbXAMIAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 03:00:30 -0500
Date: Sat, 13 Jan 2007 00:00:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       ak@suse.de, shai@scalex86.org, pravin.shelar@calsoftinc.com
Subject: Re: High lock spin time for zone->lru_lock under extreme conditions
Message-Id: <20070113000017.2ad2df12.akpm@osdl.org>
In-Reply-To: <20070113073643.GA4234@localhost.localdomain>
References: <20070112160104.GA5766@localhost.localdomain>
	<45A86291.8090408@yahoo.com.au>
	<20070113073643.GA4234@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 12 Jan 2007 23:36:43 -0800 Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
> On Sat, Jan 13, 2007 at 03:39:45PM +1100, Nick Piggin wrote:
> > Ravikiran G Thirumalai wrote:
> > >Hi,
> > >We noticed high interrupt hold off times while running some memory 
> > >intensive
> > >tests on a Sun x4600 8 socket 16 core x86_64 box.  We noticed softlockups,
> > 
> > [...]
> > 
> > >We did not use any lock debugging options and used plain old rdtsc to
> > >measure cycles.  (We disable cpu freq scaling in the BIOS). All we did was
> > >this:
> > >
> > >void __lockfunc _spin_lock_irq(spinlock_t *lock)
> > >{
> > >        local_irq_disable();
> > >        ------------------------> rdtsc(t1);
> > >        preempt_disable();
> > >        spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
> > >        _raw_spin_lock(lock);
> > >        ------------------------> rdtsc(t2);
> > >        if (lock->spin_time < (t2 - t1))
> > >                lock->spin_time = t2 - t1;
> > >}
> > >
> > >On some runs, we found that the zone->lru_lock spun for 33 seconds or more
> > >while the maximal CS time was 3 seconds or so.
> > 
> > What is the "CS time"?
> 
> Critical Section :).  This is the maximal time interval I measured  from 
> t2 above to the time point we release the spin lock.  This is the hold 
> time I guess.

By no means.  The theory here is that CPUA is taking and releasing the
lock at high frequency, but CPUB never manages to get in and take it.  In
which case the maximum-acquisition-time is much larger than the
maximum-hold-time.

I'd suggest that you use a similar trick to measure the maximum hold time:
start the timer after we got the lock, stop it just before we release the
lock (assuming that the additional rdtsc delay doesn't "fix" things, of
course...)


