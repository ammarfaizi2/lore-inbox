Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbWEHIAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbWEHIAW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 04:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbWEHIAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 04:00:21 -0400
Received: from mga02.intel.com ([134.134.136.20]:37165 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932180AbWEHIAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 04:00:19 -0400
X-IronPort-AV: i="4.05,100,1146466800"; 
   d="scan'208"; a="32990960:sNHT69193873"
Subject: Re: [PATCH 1/10] make stop_machine_run accept cpumask
From: Shaohua Li <shaohua.li@intel.com>
To: Nathan Lynch <ntl@pobox.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>, Ashok Raj <ashok.raj@intel.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060508074823.GC9344@localdomain>
References: <1147067141.2760.78.camel@sli10-desk.sh.intel.com>
	 <20060508074823.GC9344@localdomain>
Content-Type: text/plain
Date: Mon, 08 May 2006 15:59:04 +0800
Message-Id: <1147075144.2760.114.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-08 at 02:48 -0500, Nathan Lynch wrote:
> Shaohua Li wrote:
> > 
> > Make __stop_machine_run accepts 'cpumask_t' parameter and 
> > multiple cpus be able to run specified task.
> > 
> > Signed-off-by: Ashok Raj <ashok.raj@intel.com> 
> > Signed-off-by: Shaohua Li <shaohua.li@intel.com> 
> > ---
> > 
> >  linux-2.6.17-rc3-root/include/linux/stop_machine.h |    4 -
> >  linux-2.6.17-rc3-root/kernel/cpu.c                 |    2 
> >  linux-2.6.17-rc3-root/kernel/stop_machine.c        |   68 ++++++++++++++-------
> >  3 files changed, 50 insertions(+), 24 deletions(-)
> > 
> > diff -puN include/linux/stop_machine.h~stopmachine-run-accept-cpumask include/linux/stop_machine.h
> > --- linux-2.6.17-rc3/include/linux/stop_machine.h~stopmachine-run-accept-cpumask	2006-05-07 07:44:34.000000000 +0800
> > +++ linux-2.6.17-rc3-root/include/linux/stop_machine.h	2006-05-07 07:44:34.000000000 +0800
> > @@ -28,14 +28,14 @@ int stop_machine_run(int (*fn)(void *), 
> >   * __stop_machine_run: freeze the machine on all CPUs and run this function
> >   * @fn: the function to run
> >   * @data: the data ptr for the @fn
> > - * @cpu: the cpu to run @fn on (or any, if @cpu == NR_CPUS.
> > + * @cpus: the cpus to run @fn on.
> >   *
> >   * Description: This is a special version of the above, which returns the
> >   * thread which has run @fn(): kthread_stop will return the return value
> >   * of @fn().  Used by hotplug cpu.
> >   */
> >  struct task_struct *__stop_machine_run(int (*fn)(void *), void *data,
> > -				       unsigned int cpu);
> > +				       cpumask_t cpus);
> >  
> >  #else
> >  
> > diff -puN kernel/cpu.c~stopmachine-run-accept-cpumask kernel/cpu.c
> > --- linux-2.6.17-rc3/kernel/cpu.c~stopmachine-run-accept-cpumask	2006-05-07 07:44:34.000000000 +0800
> > +++ linux-2.6.17-rc3-root/kernel/cpu.c	2006-05-07 07:44:34.000000000 +0800
> > @@ -148,7 +148,7 @@ int cpu_down(unsigned int cpu)
> >  	cpu_clear(cpu, tmp);
> >  	set_cpus_allowed(current, tmp);
> >  
> > -	p = __stop_machine_run(take_cpu_down, NULL, cpu);
> > +	p = __stop_machine_run(take_cpu_down, NULL, cpumask_of_cpu(cpu));
> >  	if (IS_ERR(p)) {
> >  		/* CPU didn't die: tell everyone.  Can't complain. */
> >  		if (blocking_notifier_call_chain(&cpu_chain, CPU_DOWN_FAILED,
> > diff -puN kernel/stop_machine.c~stopmachine-run-accept-cpumask kernel/stop_machine.c
> > --- linux-2.6.17-rc3/kernel/stop_machine.c~stopmachine-run-accept-cpumask	2006-05-07 07:44:34.000000000 +0800
> > +++ linux-2.6.17-rc3-root/kernel/stop_machine.c	2006-05-07 07:44:34.000000000 +0800
> > @@ -17,18 +17,31 @@ enum stopmachine_state {
> >  	STOPMACHINE_WAIT,
> >  	STOPMACHINE_PREPARE,
> >  	STOPMACHINE_DISABLE_IRQ,
> > +	STOPMACHINE_PREPARE_TASK,
> > +	STOPMACHINE_FINISH_TASK,
> >  	STOPMACHINE_EXIT,
> >  };
> >  
> > +struct stop_machine_data
> > +{
> > +	cpumask_t task_cpus;
> > +	int (*fn)(void *);
> > +	void *data;
> > +	struct completion done;
> > +};
> > +
> >  static enum stopmachine_state stopmachine_state;
> >  static unsigned int stopmachine_num_threads;
> >  static atomic_t stopmachine_thread_ack;
> >  static DECLARE_MUTEX(stopmachine_mutex);
> > +static struct stop_machine_data *smdata;
> >  
> >  static int stopmachine(void *cpu)
> >  {
> >  	int irqs_disabled = 0;
> >  	int prepared = 0;
> > +	int task_prepared = 0;
> > +	int task_finished = 0;
> >  
> >  	set_cpus_allowed(current, cpumask_of_cpu((int)(long)cpu));
> >  
> > @@ -52,7 +65,22 @@ static int stopmachine(void *cpu)
> >  			prepared = 1;
> >  			smp_mb(); /* Must read state first. */
> >  			atomic_inc(&stopmachine_thread_ack);
> > +		} else if (stopmachine_state == STOPMACHINE_PREPARE_TASK
> > +			   && !task_prepared) {
> > +			task_prepared = 1;
> > +			smp_mb(); /* Must read state first. */
> > +			atomic_inc(&stopmachine_thread_ack);
> > +			/* do the task */
> > +			if (cpu_isset((int)(long)cpu, smdata->task_cpus))
> > +				smdata->fn(smdata->data);
> 
> Bug?  smdata->fn() should be called first, and only then should
> stopmachine_thread_ack be incremented, no?
No. The master cpu will wait for other cpus to ack and then it will call
the function. The master cpu set STOPMACHINE_PREPARE_TASK, all cpus
start doing the tasks. And later master cpu set STOPMACHINE_FINISH_TASK
to wait for task finish in other cpus.

> 
> > +		} else if (stopmachine_state == STOPMACHINE_FINISH_TASK
> > +			   && !task_finished) {
> > +			task_finished = 1;
> > +			smp_mb(); /* Must read state first. */
> > +			atomic_inc(&stopmachine_thread_ack);
> >  		}
> > +
> > +
> >  		/* Yield in first stage: migration threads need to
> >  		 * help our sisters onto their CPUs. */
> >  		if (!prepared && !irqs_disabled)
> > @@ -133,21 +161,18 @@ static void restart_machine(void)
> >  	preempt_enable_no_resched();
> >  }
> >  
> > -struct stop_machine_data
> > -{
> > -	int (*fn)(void *);
> > -	void *data;
> > -	struct completion done;
> > -};
> >  
> >  static int do_stop(void *_smdata)
> >  {
> > -	struct stop_machine_data *smdata = _smdata;
> >  	int ret;
> >  
> >  	ret = stop_machine();
> >  	if (ret == 0) {
> > +		stopmachine_set_state(STOPMACHINE_PREPARE_TASK);
> > +		/* only record first cpu's return value */
> >  		ret = smdata->fn(smdata->data);
> > +		/* wait peers finish task */
> > +		stopmachine_set_state(STOPMACHINE_FINISH_TASK);
> 
> It seems rather arbitrary to record the return value of smdata->fn
> from only one of the cpus.  I'm really not keen to have this kind of
> situation where the function can partially fail and there's no sane
> way to report this back to the caller, nor is there any way to roll
> back to the state beforehand.
It doesn't really matter. In the task (smdata->fn), the cpus can
communicate with each other and let the master cpu return a proper
value. please see the i386 implementation.

Thanks,
Shaohua
