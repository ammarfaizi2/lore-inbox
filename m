Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130158AbRBSNQU>; Mon, 19 Feb 2001 08:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130230AbRBSNQK>; Mon, 19 Feb 2001 08:16:10 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:14092 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130158AbRBSNQG>;
	Mon, 19 Feb 2001 08:16:06 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Philipp Rumpf <prumpf@mandrakesoft.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.1-ac15 
In-Reply-To: Your message of "Mon, 19 Feb 2001 06:15:22 MDT."
             <Pine.LNX.3.96.1010219055750.16489G-100000@mandrakesoft.mandrakesoft.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 20 Feb 2001 00:15:58 +1100
Message-ID: <30512.982588558@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Feb 2001 06:15:22 -0600 (CST), 
Philipp Rumpf <prumpf@mandrakesoft.com> wrote:
>Unless I'm mistaken, we need both use counts and SMP magic (though not
>necessarily as extreme as what the "freeze all other CPUs during module
>unload" patch did).
>
>I think something like this would work (in addition to use counts)
>
>int callin_func(void *p)
>{
>	int *cpu = p;
>
>	while (*cpu != smp_processor_id()) {
>		current->cpus_allowed = 1 << *cpu;
>		schedule();
>	}
>
>	return 0;
>}
>
>void callin_other_cpus(void)
>{
>	int cpus[smp_num_cpus];
>	int i;
>
>	for (i=0; i<smp_num_cpus; i++) {
>		cpus[i] = i;
>
>		kernel_thread(callin_func, &cpus[i], ...);
>	}
>}
>
>and call callin_other_cpus() before unloading a module.
>
>I'm not sure how you could make exception handling safe without locking
>all accesses to the module list - but that sounds like the sane thing to
>do anyway.

No need for a callin routine, you can get this for free as part of
normal scheduling.  The sequence goes :-

if (use_count == 0) {
  module_unregister();
  wait_for_at_least_one_schedule_on_every_cpu();
  if (use_count != 0) {
    module_register();	/* lost the unregister race */
  }
  else {
    /* nobody can enter the module now */
    module_release_resources();
    unlink_module_from_list();
    wait_for_at_least_one_schedule_on_every_cpu();
    free_module_storage();
  }
}

wait_for_at_least_one_schedule_on_every_cpu() prevents the next
operation until at least one schedule has been executed on every cpu.
Whether this is done as a call back or a separate kernel thread that
schedules itself on every cpu or the current process scheduling itself
on every cpu is an implementation detail.  All that matters is that any
other cpu that might have been accessing the module has gone through
schedule and therefore is no longer accessing the module's data or
code.

The beauty of this approach is that the rest of the cpus can do normal
work.  No need to bring everything to a dead stop.

