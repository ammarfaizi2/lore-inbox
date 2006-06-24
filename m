Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933065AbWFXLh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933065AbWFXLh2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 07:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933066AbWFXLh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 07:37:28 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:14841 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP id S933065AbWFXLh1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 07:37:27 -0400
Date: Sat, 24 Jun 2006 13:36:41 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Michael Grundy <grundym@us.ibm.com>
Cc: Jan Glauber <jan.glauber@de.ibm.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org, systemtap@sources.redhat.com
Subject: Re: [PATCH] kprobes for s390 architecture
Message-ID: <20060624113641.GB10403@osiris.ibm.com>
References: <20060623150344.GL9446@osiris.boeblingen.de.ibm.com> <OF44DB398C.F7A51098-ON88257196.007CD277-88257196.007DC8F0@us.ibm.com> <20060623222106.GA25410@osiris.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623222106.GA25410@osiris.ibm.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> At least this is something that could work... completely untested and might
> have some problems that I didn't think of ;)
> 
> struct capture_data {
> 	atomic_t cpus;
> 	atomic_t done;
> };
> 
> void capture_wait(void *data)
> { 
> 	struct capture_data *cap = data;
> 
> 	atomic_inc(&cap->cpus);
> 	while(!atomic_read(&cap->done))
> 		cpu_relax();
> 	atomic_dec(&cap->cpus);
> }
> 
> void replace_instr(int *a)
> {
> 	struct capture_data cap;
> 
> 	preempt_disable();
> 	atomic_set(&cap.cpus, 0);
> 	atomic_set(&cap.done, 0);
> 	smp_call_function(capture_wait, (void *)&cap, 0, 0);
> 	while (atomic_read(&cap.cpus) != num_online_cpus() - 1)
> 		cpu_relax();
> 	*a = 0x42;
> 	atomic_inc(&cap.done);
> 	while (atomic_read(&cap.cpus))
> 		cpu_relax();
> 	preempt_enable();
> }

Forget this crap. It can easily cause deadlocks with more than two cpus.

Just do a compare and swap operation on the instruction you want to replace,
then do an smp_call_function() with the wait parameter set to 1 and passing
a pointer to a function that does nothing but return.

The cs/csg instruction will make sure that your cpu has exclusive access
to the memory region in question and will invalidate the cache lines on all
other cpus.
With the following smp_call_function() you can make sure that all other
cpus discard everything they have prefetched. Hence there is only a small
window between the cs/csg and the return of smp_call_function() where you
do not know if other cpus are executing the old or the new instruction.
