Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbVDDPee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbVDDPee (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 11:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbVDDPee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 11:34:34 -0400
Received: from orb.pobox.com ([207.8.226.5]:35297 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261261AbVDDPdy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 11:33:54 -0400
Date: Mon, 4 Apr 2005 10:33:45 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Li Shaohua <shaohua.li@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, Len Brown <len.brown@intel.com>,
       Pavel Machek <pavel@suse.cz>
Subject: Re: [ACPI] Re: [RFC 5/6]clean cpu state after hotremove CPU
Message-ID: <20050404153345.GC3611@otto>
References: <1112580367.4194.344.camel@sli10-desk.sh.intel.com> <20050404052844.GB3611@otto> <1112593338.4194.362.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112593338.4194.362.camel@sli10-desk.sh.intel.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2005 at 01:42:18PM +0800, Li Shaohua wrote:
> Hi,
> On Mon, 2005-04-04 at 13:28, Nathan Lynch wrote:
> > On Mon, Apr 04, 2005 at 10:07:02AM +0800, Li Shaohua wrote:
> > > Clean up all CPU states including its runqueue and idle thread, 
> > > so we can use boot time code without any changes.
> > > Note this makes /sys/devices/system/cpu/cpux/online unworkable.
> > 
> > In what sense does it make the online attribute unworkable?
> I removed the idle thread and other CPU states, and makes the dead CPU
> into a 'halt' busy loop. 
> 
> > 
> > > diff -puN kernel/exit.c~cpu_state_clean kernel/exit.c
> > > --- linux-2.6.11/kernel/exit.c~cpu_state_clean	2005-03-31 10:50:27.000000000 +0800
> > > +++ linux-2.6.11-root/kernel/exit.c	2005-03-31 10:50:27.000000000 +0800
> > > @@ -845,6 +845,65 @@ fastcall NORET_TYPE void do_exit(long co
> > >  	for (;;) ;
> > >  }
> > >  
> > > +#ifdef CONFIG_STR_SMP
> > > +void do_exit_idle(void)
> > > +{
> > > +	struct task_struct *tsk = current;
> > > +	int group_dead;
> > > +
> > > +	BUG_ON(tsk->pid);
> > > +	BUG_ON(tsk->mm);
> > > +
> > > +	if (tsk->io_context)
> > > +		exit_io_context();
> > > +	tsk->flags |= PF_EXITING;
> > > + 	tsk->it_virt_expires = cputime_zero;
> > > + 	tsk->it_prof_expires = cputime_zero;
> > > +	tsk->it_sched_expires = 0;
> > > +
> > > +	acct_update_integrals(tsk);
> > > +	update_mem_hiwater(tsk);
> > > +	group_dead = atomic_dec_and_test(&tsk->signal->live);
> > > +	if (group_dead) {
> > > + 		del_timer_sync(&tsk->signal->real_timer);
> > > +		acct_process(-1);
> > > +	}
> > > +	exit_mm(tsk);
> > > +
> > > +	exit_sem(tsk);
> > > +	__exit_files(tsk);
> > > +	__exit_fs(tsk);
> > > +	exit_namespace(tsk);
> > > +	exit_thread();
> > > +	exit_keys(tsk);
> > > +
> > > +	if (group_dead && tsk->signal->leader)
> > > +		disassociate_ctty(1);
> > > +
> > > +	module_put(tsk->thread_info->exec_domain->module);
> > > +	if (tsk->binfmt)
> > > +		module_put(tsk->binfmt->module);
> > > +
> > > +	tsk->exit_code = -1;
> > > +	tsk->exit_state = EXIT_DEAD;
> > > +
> > > +	/* in release_task */
> > > +	atomic_dec(&tsk->user->processes);
> > > +	write_lock_irq(&tasklist_lock);
> > > +	__exit_signal(tsk);
> > > +	__exit_sighand(tsk);
> > > +	write_unlock_irq(&tasklist_lock);
> > > +	release_thread(tsk);
> > > +	put_task_struct(tsk);
> > > +
> > > +	tsk->flags |= PF_DEAD;
> > > +#ifdef CONFIG_NUMA
> > > +	mpol_free(tsk->mempolicy);
> > > +	tsk->mempolicy = NULL;
> > > +#endif
> > > +}
> > > +#endif
> > 
> > I don't understand why this is needed at all.  It looks like a fair
> > amount of code from do_exit is being duplicated here.  
> Yes, exactly. Someone who understand do_exit please help clean up the
> code. I'd like to remove the idle thread, since the smpboot code will
> create a new idle thread.

I'd say fix the smpboot code so that it doesn't create new idle tasks
except during boot.

> 
> > We've been
> > doing cpu removal on ppc64 logical partitions for a while and never
> > needed to do anything like this. 
> Did it remove idle thread? or dead cpu is in a busy loop of idle?

Neither.  The cpu is definitely offline, but there is no reason to
free the idle thread.

> 
> >  Maybe idle_task_exit would suffice?
> idle_task_exit seems just drop mm. We need destroy the idle task for
> physical CPU hotplug, right?

No.

> > 
> > I don't understand the need for this, either.  The existing cpu
> > hotplug notifier in the scheduler takes care of initializing the sched
> > domains and groups appropriately for online/offline events; why do you
> > need to touch the runqueue structures?
> If a CPU is physically hotremoved from the system, shouldn't we clean
> its runqueue?

No.  It should make zero difference to the scheduler whether the "play
dead" cpu hotplug or "physical" hotplug is being used.  


Nathan
