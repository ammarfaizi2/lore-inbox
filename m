Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129807AbRBSMSB>; Mon, 19 Feb 2001 07:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129852AbRBSMRv>; Mon, 19 Feb 2001 07:17:51 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:27984 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129807AbRBSMRj>; Mon, 19 Feb 2001 07:17:39 -0500
Date: Mon, 19 Feb 2001 06:15:22 -0600 (CST)
From: Philipp Rumpf <prumpf@mandrakesoft.com>
Reply-To: Philipp Rumpf <prumpf@mandrakesoft.com>
To: Keith Owens <kaos@ocs.com.au>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.1-ac15 
In-Reply-To: <30069.982583679@ocs3.ocs-net>
Message-ID: <Pine.LNX.3.96.1010219055750.16489G-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Feb 2001, Keith Owens wrote:
> On Mon, 19 Feb 2001 11:35:08 +0000 (GMT), 
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> >The problem isnt running module code. What happens in this case
> >
> >        mod->next = module_list;
> >        module_list = mod;      /* link it in */
> >
> >Note no write barrier.
> 
> <humour>It works on ix86 so the code must be right</humour>

Too bad it doesn't.

> >Delete is even worse
> >
> >We unlink the module
> >We free the memory
> >
> >At the same time another cpu may be walking the exception table that we free.
> 
> Another good reason why locking modules via use counts from external
> code is not the right fix.  We definitely need a quiesce model for
> module removal.

Unless I'm mistaken, we need both use counts and SMP magic (though not
necessarily as extreme as what the "freeze all other CPUs during module
unload" patch did).


I think something like this would work (in addition to use counts)

int callin_func(void *p)
{
	int *cpu = p;

	while (*cpu != smp_processor_id()) {
		current->cpus_allowed = 1 << *cpu;
		schedule();
	}

	return 0;
}

void callin_other_cpus(void)
{
	int cpus[smp_num_cpus];
	int i;

	for (i=0; i<smp_num_cpus; i++) {
		cpus[i] = i;

		kernel_thread(callin_func, &cpus[i], ...);
	}
}

and call callin_other_cpus() before unloading a module.


I'm not sure how you could make exception handling safe without locking
all accesses to the module list - but that sounds like the sane thing to
do anyway.

