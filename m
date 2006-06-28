Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932654AbWF1F76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932654AbWF1F76 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 01:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932729AbWF1F76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 01:59:58 -0400
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:65037 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP id S932654AbWF1F75
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 01:59:57 -0400
Date: Wed, 28 Jun 2006 07:58:57 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Michael Grundy <grundym@us.ibm.com>, Jan Glauber <jan.glauber@de.ibm.com>,
       linux-kernel@vger.kernel.org, systemtap@sources.redhat.com
Subject: Re: [PATCH] kprobes for s390 architecture
Message-ID: <20060628055857.GA9452@osiris.boeblingen.de.ibm.com>
References: <20060623150344.GL9446@osiris.boeblingen.de.ibm.com> <OF44DB398C.F7A51098-ON88257196.007CD277-88257196.007DC8F0@us.ibm.com> <20060623222106.GA25410@osiris.ibm.com> <20060624113641.GB10403@osiris.ibm.com> <1151421789.5390.65.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151421789.5390.65.camel@localhost>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2006 at 05:23:09PM +0200, Martin Schwidefsky wrote:
> On Sat, 2006-06-24 at 13:36 +0200, Heiko Carstens wrote:
> > > At least this is something that could work... completely untested and might
> > > have some problems that I didn't think of ;)
> > > 
> > > struct capture_data {
> > > 	atomic_t cpus;
> > > 	atomic_t done;
> > > };
> > > 
> > > void capture_wait(void *data)
> > > { 
> > > 	struct capture_data *cap = data;
> > > 
> > > 	atomic_inc(&cap->cpus);
> > > 	while(!atomic_read(&cap->done))
> > > 		cpu_relax();
> > > 	atomic_dec(&cap->cpus);
> > > }
> > > 
> > > void replace_instr(int *a)
> > > {
> > > 	struct capture_data cap;
> > > 
> > > 	preempt_disable();
> > > 	atomic_set(&cap.cpus, 0);
> > > 	atomic_set(&cap.done, 0);
> > > 	smp_call_function(capture_wait, (void *)&cap, 0, 0);
> > > 	while (atomic_read(&cap.cpus) != num_online_cpus() - 1)
> > > 		cpu_relax();
> > > 	*a = 0x42;
> > > 	atomic_inc(&cap.done);
> > > 	while (atomic_read(&cap.cpus))
> > > 		cpu_relax();
> > > 	preempt_enable();
> > > }
> > 
> > Forget this crap. It can easily cause deadlocks with more than two cpus.
> 
> It is not that bad. Instead of preempt_disable/preempt_enable we need a
> spinlock. Then only one cpu can do this particular smp_call_function
> which will "stop" all other cpus until cap->done has been set.

CPU0: smp_call_function() -> loops and waits for other cpus
CPU1: [irqs_enabled] - spin_lock(somelock) -> irq -> capture_wait() -> loop
CPU2: [irqs_enabled] ----- spin_lock_irqsave(a,..) -> toasted

CPU2 ends up trying to grab the same lock that CPU1 holds, but has interrupts
disabled and a pending external interrupt because of the smp_call_function()..

> > Just do a compare and swap operation on the instruction you want to replace,
> > then do an smp_call_function() with the wait parameter set to 1 and passing
> > a pointer to a function that does nothing but return.
> Not good enough. An instruction can be fetched multiple times for a
> single execution (see the other mail). So you have a half executed
> instruction, the cache line is invalidated, a new instruction is written
> and the cache line is recreated to finished the half executed
> instruction. That can easiliy happen on millicoded instructions.

Yes, looks like I was too optimistic. Seems like we really have to go for
stop_machine_run() unless somebody comes up with a better idea...
