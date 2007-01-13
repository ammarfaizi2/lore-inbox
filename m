Return-Path: <linux-kernel-owner+w=401wt.eu-S1161301AbXAMHhA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161301AbXAMHhA (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 02:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161309AbXAMHhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 02:37:00 -0500
Received: from server99.tchmachines.com ([72.9.230.178]:45867 "EHLO
	server99.tchmachines.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161301AbXAMHg7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 02:36:59 -0500
Date: Fri, 12 Jan 2007 23:36:43 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       pravin b shelar <pravin.shelar@calsoftinc.com>
Subject: Re: High lock spin time for zone->lru_lock under extreme conditions
Message-ID: <20070113073643.GA4234@localhost.localdomain>
References: <20070112160104.GA5766@localhost.localdomain> <45A86291.8090408@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45A86291.8090408@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server99.tchmachines.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 13, 2007 at 03:39:45PM +1100, Nick Piggin wrote:
> Ravikiran G Thirumalai wrote:
> >Hi,
> >We noticed high interrupt hold off times while running some memory 
> >intensive
> >tests on a Sun x4600 8 socket 16 core x86_64 box.  We noticed softlockups,
> 
> [...]
> 
> >We did not use any lock debugging options and used plain old rdtsc to
> >measure cycles.  (We disable cpu freq scaling in the BIOS). All we did was
> >this:
> >
> >void __lockfunc _spin_lock_irq(spinlock_t *lock)
> >{
> >        local_irq_disable();
> >        ------------------------> rdtsc(t1);
> >        preempt_disable();
> >        spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
> >        _raw_spin_lock(lock);
> >        ------------------------> rdtsc(t2);
> >        if (lock->spin_time < (t2 - t1))
> >                lock->spin_time = t2 - t1;
> >}
> >
> >On some runs, we found that the zone->lru_lock spun for 33 seconds or more
> >while the maximal CS time was 3 seconds or so.
> 
> What is the "CS time"?

Critical Section :).  This is the maximal time interval I measured  from 
t2 above to the time point we release the spin lock.  This is the hold 
time I guess.

> 
> It would be interesting to know how long the maximal lru_lock *hold* time 
> is,
> which could give us a better indication of whether it is a hardware problem.
> 
> For example, if the maximum hold time is 10ms, that it might indicate a
> hardware fairness problem.

The maximal hold time was about 3s.
