Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbWHXM1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbWHXM1Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 08:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWHXM1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 08:27:16 -0400
Received: from ausmtp06.au.ibm.com ([202.81.18.155]:17844 "EHLO
	ausmtp06.au.ibm.com") by vger.kernel.org with ESMTP
	id S1751196AbWHXM1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 08:27:16 -0400
Date: Thu, 24 Aug 2006 17:58:08 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Gautham R Shenoy <ego@in.ibm.com>, rusty@rustcorp.com.au,
       torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       arjan@linux.intel.com, davej@redhat.com, vatsa@in.ibm.com,
       dipankar@in.ibm.com, ashok.raj@intel.com
Subject: Re: [RFC][PATCH 3/4] (Refcount + Waitqueue) implementation for cpu_hotplug "locking"
Message-ID: <20060824122808.GH2395@in.ibm.com>
Reply-To: ego@in.ibm.com
References: <20060824103233.GD2395@in.ibm.com> <20060824111440.GA19248@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824111440.GA19248@elte.hu>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 01:14:40PM +0200, Ingo Molnar wrote:
> 
> * Gautham R Shenoy <ego@in.ibm.com> wrote:
> 
> >  void lock_cpu_hotplug(void)
> >  {
> 
> > +	DECLARE_WAITQUEUE(wait, current);
> > +	spin_lock(&cpu_hotplug.lock);
> > +	cpu_hotplug.reader_count++;
> 
> this should be per-CPU - lock_cpu_hotplug() should _not_ be a globally 
> synchronized event.
> CPU removal is such a rare event that we can easily do something like a 
> global read-mostly 'CPU is locked for writes' flag (plus a completion 
> queue) that the 'write' side takes atomically - combined with per-CPU 
> refcount and a waitqueue that the read side increases/decreases and 
> wakes. Read-locking of the CPU is much more common and should be 
> fundamentally scalable: it should increase the per-CPU refcount, then 
> check the global 'writer active' flag, and if the writer flag is set, it 
> should wait on the global completion queue. When a reader drops the 
> refcount it should wake up the per-CPU waitqueue. [in which a writer 
> might be waiting for the refcount to go down to 0.]
This was the approach I tried to make it cache friendly.
These are the problems I faced.

- Reader checks the write_active flag. If set, he waits in the global read
queue. else, he gets the lock and increments percpu refcount.

- the writer would have to check each cpu's read refcount, and ensure that
read refcount =0 on all of them before he sets write_active and 
begins a write operation.
This will create a big race window - a writer is checking
for a refcount on cpu(j), a reader comes on cpu(i) where i<j;
Let's assume the writer checks refcounts in increasing order of cpus.
Should the reader on cpu(i) wait or go ahead? If we use a global
lock to serialize this operation, we the whole purpose of maintaining
per cpu data is lost.

- If the reader decides to wait on cpu(i) and the writer on cpu(j+1) 
finds refcount!=0,do we have both reader and writer waiting?
Or should the writer perform some sort of a rollback, where he wakes up
the readers on all cpus i < j+1?

- When a reader is done, he decrements his percpu refcount. But, a 
percpu refcount = 0 does not mean there are no active readers in the 
system. So the reader too, would have to check for each cpu refcount
before he wakes up the writer in his queue. this would mean 
referencing other cpu's data.

- How do we deal when a reader takes a lock first on cpu(i) gets
migrated to cpu(j) during an unlock. Again, we have to cross-reference 
other cpu's data.

I tried and gave up. But I would love to have this whole thing
implemented in a more cache friendly manner if we can.

Thanks and Regards
ego
-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"
