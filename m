Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752127AbWFWWVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127AbWFWWVv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 18:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752103AbWFWWVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 18:21:51 -0400
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:44433 "EHLO
	mtagate5.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1752126AbWFWWVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 18:21:50 -0400
Date: Sat, 24 Jun 2006 00:21:06 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Michael Grundy <grundym@us.ibm.com>
Cc: Jan Glauber <jan.glauber@de.ibm.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org, systemtap@sources.redhat.com
Subject: Re: [PATCH] kprobes for s390 architecture
Message-ID: <20060623222106.GA25410@osiris.ibm.com>
References: <20060623150344.GL9446@osiris.boeblingen.de.ibm.com> <OF44DB398C.F7A51098-ON88257196.007CD277-88257196.007DC8F0@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF44DB398C.F7A51098-ON88257196.007CD277-88257196.007DC8F0@us.ibm.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On the same page it says "All copies of a prefetched instruction are
> discarded
> when: * A serializing function is performed" Would something like this in a
> smp_call_function do it? :
> 
> bcr 15,0
> 
> if (*p->addr != breakpoint_instruction)
>       *p->addr = breakpoint_instruction;
> 
> 
> Alternatively, if we did a compare and swap on that location (serializing
> instruction) would that be acceptable?
> 
> Thanks
> Michael

The crap below is something that could solve your problem (assumes that "a"
is the address of the instruction to be replaced and 0x42 is the opcode of
the new instruction):

- generates an irq on all other cpus -> prefetched stuff on them discarded
- catches all cpus
- writes the new instruction
- the atomic_inc(&cap.done) is a compare and swap instruction -> serialization

At least this is something that could work... completely untested and might
have some problems that I didn't think of ;)

struct capture_data {
	atomic_t cpus;
	atomic_t done;
};

void capture_wait(void *data)
{ 
	struct capture_data *cap = data;

	atomic_inc(&cap->cpus);
	while(!atomic_read(&cap->done))
		cpu_relax();
	atomic_dec(&cap->cpus);
}

void replace_instr(int *a)
{
	struct capture_data cap;

	preempt_disable();
	atomic_set(&cap.cpus, 0);
	atomic_set(&cap.done, 0);
	smp_call_function(capture_wait, (void *)&cap, 0, 0);
	while (atomic_read(&cap.cpus) != num_online_cpus() - 1)
		cpu_relax();
	*a = 0x42;
	atomic_inc(&cap.done);
	while (atomic_read(&cap.cpus))
		cpu_relax();
	preempt_enable();
}
