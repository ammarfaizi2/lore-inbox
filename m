Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbVDDFpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbVDDFpa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 01:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbVDDFp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 01:45:29 -0400
Received: from fmr19.intel.com ([134.134.136.18]:4547 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261286AbVDDFoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 01:44:38 -0400
Subject: Re: [ACPI] Re: [RFC 5/6]clean cpu state after hotremove CPU
From: Li Shaohua <shaohua.li@intel.com>
To: Nathan Lynch <ntl@pobox.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, Len Brown <len.brown@intel.com>,
       Pavel Machek <pavel@suse.cz>
In-Reply-To: <20050404052844.GB3611@otto>
References: <1112580367.4194.344.camel@sli10-desk.sh.intel.com>
	 <20050404052844.GB3611@otto>
Content-Type: text/plain
Message-Id: <1112593338.4194.362.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 04 Apr 2005 13:42:18 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Mon, 2005-04-04 at 13:28, Nathan Lynch wrote:
> On Mon, Apr 04, 2005 at 10:07:02AM +0800, Li Shaohua wrote:
> > Clean up all CPU states including its runqueue and idle thread, 
> > so we can use boot time code without any changes.
> > Note this makes /sys/devices/system/cpu/cpux/online unworkable.
> 
> In what sense does it make the online attribute unworkable?
I removed the idle thread and other CPU states, and makes the dead CPU
into a 'halt' busy loop. 

> 
> > diff -puN kernel/exit.c~cpu_state_clean kernel/exit.c
> > --- linux-2.6.11/kernel/exit.c~cpu_state_clean	2005-03-31 10:50:27.000000000 +0800
> > +++ linux-2.6.11-root/kernel/exit.c	2005-03-31 10:50:27.000000000 +0800
> > @@ -845,6 +845,65 @@ fastcall NORET_TYPE void do_exit(long co
> >  	for (;;) ;
> >  }
> >  
> > +#ifdef CONFIG_STR_SMP
> > +void do_exit_idle(void)
> > +{
> > +	struct task_struct *tsk = current;
> > +	int group_dead;
> > +
> > +	BUG_ON(tsk->pid);
> > +	BUG_ON(tsk->mm);
> > +
> > +	if (tsk->io_context)
> > +		exit_io_context();
> > +	tsk->flags |= PF_EXITING;
> > + 	tsk->it_virt_expires = cputime_zero;
> > + 	tsk->it_prof_expires = cputime_zero;
> > +	tsk->it_sched_expires = 0;
> > +
> > +	acct_update_integrals(tsk);
> > +	update_mem_hiwater(tsk);
> > +	group_dead = atomic_dec_and_test(&tsk->signal->live);
> > +	if (group_dead) {
> > + 		del_timer_sync(&tsk->signal->real_timer);
> > +		acct_process(-1);
> > +	}
> > +	exit_mm(tsk);
> > +
> > +	exit_sem(tsk);
> > +	__exit_files(tsk);
> > +	__exit_fs(tsk);
> > +	exit_namespace(tsk);
> > +	exit_thread();
> > +	exit_keys(tsk);
> > +
> > +	if (group_dead && tsk->signal->leader)
> > +		disassociate_ctty(1);
> > +
> > +	module_put(tsk->thread_info->exec_domain->module);
> > +	if (tsk->binfmt)
> > +		module_put(tsk->binfmt->module);
> > +
> > +	tsk->exit_code = -1;
> > +	tsk->exit_state = EXIT_DEAD;
> > +
> > +	/* in release_task */
> > +	atomic_dec(&tsk->user->processes);
> > +	write_lock_irq(&tasklist_lock);
> > +	__exit_signal(tsk);
> > +	__exit_sighand(tsk);
> > +	write_unlock_irq(&tasklist_lock);
> > +	release_thread(tsk);
> > +	put_task_struct(tsk);
> > +
> > +	tsk->flags |= PF_DEAD;
> > +#ifdef CONFIG_NUMA
> > +	mpol_free(tsk->mempolicy);
> > +	tsk->mempolicy = NULL;
> > +#endif
> > +}
> > +#endif
> 
> I don't understand why this is needed at all.  It looks like a fair
> amount of code from do_exit is being duplicated here.  
Yes, exactly. Someone who understand do_exit please help clean up the
code. I'd like to remove the idle thread, since the smpboot code will
create a new idle thread.

> We've been
> doing cpu removal on ppc64 logical partitions for a while and never
> needed to do anything like this. 
Did it remove idle thread? or dead cpu is in a busy loop of idle?

>  Maybe idle_task_exit would suffice?
idle_task_exit seems just drop mm. We need destroy the idle task for
physical CPU hotplug, right?

> 
> 
> > diff -puN kernel/sched.c~cpu_state_clean kernel/sched.c
> > --- linux-2.6.11/kernel/sched.c~cpu_state_clean	2005-03-31 10:50:27.000000000 +0800
> > +++ linux-2.6.11-root/kernel/sched.c	2005-04-04 09:06:40.362357104 +0800
> > @@ -4028,6 +4028,58 @@ void __devinit init_idle(task_t *idle, i
> >  }
> >  
> >  /*
> > + * Initial dummy domain for early boot and for hotplug cpu. Being static,
> > + * it is initialized to zero, so all balancing flags are cleared which is
> > + * what we want.
> > + */
> > +static struct sched_domain sched_domain_dummy;
> > +
> > +#ifdef CONFIG_STR_SMP
> > +static void __devinit exit_idle(int cpu)
> > +{
> > +	runqueue_t *rq = cpu_rq(cpu);
> > +	struct task_struct *p = rq->idle;
> > +	int j, k;
> > +	prio_array_t *array;
> > +
> > +	/* init runqueue */
> > +	spin_lock_init(&rq->lock);
> > +	rq->active = rq->arrays;
> > +	rq->expired = rq->arrays + 1;
> > +	rq->best_expired_prio = MAX_PRIO;
> > +
> > +	rq->prev_mm = NULL;
> > +	rq->curr = rq->idle = NULL;
> > +	rq->expired_timestamp = 0;
> > +
> > +	rq->sd = &sched_domain_dummy;
> > +	rq->cpu_load = 0;
> > +	rq->active_balance = 0;
> > +	rq->push_cpu = 0;
> > +	rq->migration_thread = NULL;
> > +	INIT_LIST_HEAD(&rq->migration_queue);
> > +	atomic_set(&rq->nr_iowait, 0);
> > +
> > +	for (j = 0; j < 2; j++) {
> > +		array = rq->arrays + j;
> > +		for (k = 0; k < MAX_PRIO; k++) {
> > +			INIT_LIST_HEAD(array->queue + k);
> > +			__clear_bit(k, array->bitmap);
> > +		}
> > +		// delimiter for bitsearch
> > +		__set_bit(MAX_PRIO, array->bitmap);
> > +	}
> > +	/* Destroy IDLE thread.
> > +	 * it's safe now, the CPU is in busy loop
> > +	 */
> > +	if (p->active_mm)
> > +		mmdrop(p->active_mm);
> > +	p->active_mm = NULL;
> > +	put_task_struct(p);
> > +}
> > +#endif
> > +
> > +/*
> >   * In a system that switches off the HZ timer nohz_cpu_mask
> >   * indicates which cpus entered this state. This is used
> >   * in the rcu update to wait only for active cpus. For system
> > @@ -4432,6 +4484,9 @@ static int migration_call(struct notifie
> >  			complete(&req->done);
> >  		}
> >  		spin_unlock_irq(&rq->lock);
> > +#ifdef CONFIG_STR_SMP
> > +		exit_idle(cpu);
> > +#endif
> 
> I don't understand the need for this, either.  The existing cpu
> hotplug notifier in the scheduler takes care of initializing the sched
> domains and groups appropriately for online/offline events; why do you
> need to touch the runqueue structures?
If a CPU is physically hotremoved from the system, shouldn't we clean
its runqueue?

Thanks,
Shaohua

