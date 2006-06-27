Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161094AbWF0PXD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161094AbWF0PXD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 11:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161090AbWF0PXB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 11:23:01 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:12527 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1161094AbWF0PXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 11:23:00 -0400
Subject: Re: [PATCH] kprobes for s390 architecture
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Michael Grundy <grundym@us.ibm.com>, Jan Glauber <jan.glauber@de.ibm.com>,
       linux-kernel@vger.kernel.org, systemtap@sources.redhat.com
In-Reply-To: <20060624113641.GB10403@osiris.ibm.com>
References: <20060623150344.GL9446@osiris.boeblingen.de.ibm.com>
	 <OF44DB398C.F7A51098-ON88257196.007CD277-88257196.007DC8F0@us.ibm.com>
	 <20060623222106.GA25410@osiris.ibm.com>
	 <20060624113641.GB10403@osiris.ibm.com>
Content-Type: text/plain
Organization: IBM Corporation
Date: Tue, 27 Jun 2006 17:23:09 +0200
Message-Id: <1151421789.5390.65.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-24 at 13:36 +0200, Heiko Carstens wrote:
> > At least this is something that could work... completely untested and might
> > have some problems that I didn't think of ;)
> > 
> > struct capture_data {
> > 	atomic_t cpus;
> > 	atomic_t done;
> > };
> > 
> > void capture_wait(void *data)
> > { 
> > 	struct capture_data *cap = data;
> > 
> > 	atomic_inc(&cap->cpus);
> > 	while(!atomic_read(&cap->done))
> > 		cpu_relax();
> > 	atomic_dec(&cap->cpus);
> > }
> > 
> > void replace_instr(int *a)
> > {
> > 	struct capture_data cap;
> > 
> > 	preempt_disable();
> > 	atomic_set(&cap.cpus, 0);
> > 	atomic_set(&cap.done, 0);
> > 	smp_call_function(capture_wait, (void *)&cap, 0, 0);
> > 	while (atomic_read(&cap.cpus) != num_online_cpus() - 1)
> > 		cpu_relax();
> > 	*a = 0x42;
> > 	atomic_inc(&cap.done);
> > 	while (atomic_read(&cap.cpus))
> > 		cpu_relax();
> > 	preempt_enable();
> > }
> 
> Forget this crap. It can easily cause deadlocks with more than two cpus.

It is not that bad. Instead of preempt_disable/preempt_enable we need a
spinlock. Then only one cpu can do this particular smp_call_function
which will "stop" all other cpus until cap->done has been set.

> Just do a compare and swap operation on the instruction you want to replace,
> then do an smp_call_function() with the wait parameter set to 1 and passing
> a pointer to a function that does nothing but return.

Not good enough. An instruction can be fetched multiple times for a
single execution (see the other mail). So you have a half executed
instruction, the cache line is invalidated, a new instruction is written
and the cache line is recreated to finished the half executed
instruction. That can easiliy happen on millicoded instructions.

> The cs/csg instruction will make sure that your cpu has exclusive access
> to the memory region in question and will invalidate the cache lines on all
> other cpus.

That the cache line is invalidated does not mean that you are safe..

> With the following smp_call_function() you can make sure that all other
> cpus discard everything they have prefetched. Hence there is only a small
> window between the cs/csg and the return of smp_call_function() where you
> do not know if other cpus are executing the old or the new instruction.

The serialization is indeed done by the smp_call_function(). No need to
have a "bcr 15,0" in the called function, the lpsw at the end of the
interrupt already does the serialization.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


