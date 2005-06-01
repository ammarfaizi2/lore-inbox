Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261475AbVFAR3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbVFAR3g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 13:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbVFAR3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 13:29:36 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:29655 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261475AbVFAR32
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 13:29:28 -0400
Date: Wed, 1 Jun 2005 19:28:41 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>, linux-kernel@vger.kernel.org,
       dwalker@mvista.com, Joe King <atom_bomb@rocketmail.com>,
       ganzinger@mvista.com, Lee Revell <rlrevell@joe-job.com>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc4-V0.7.47-06
In-Reply-To: <20050528055322.GA14867@elte.hu>
Message-Id: <Pine.OSF.4.05.10506011926350.1707-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace
 init_MUTEX_LOCKED(&policy->lock);
with
 init_MUTEX(&policy->lock);
 down(&policy->lock);

Compiles here... Would also work upstream.

init_MUTEX_LOCKED() isn't very nice :-(

Esben



On Sat, 28 May 2005, Ingo Molnar wrote:

> 
> * Michal Schmidt <xschmi00@stud.feec.vutbr.cz> wrote:
> 
> > I wrote:
> > >I'm attaching a patch which changes a semaphore in cpufreq into a 
> > >completion. With this patch, my system runs OK even with cpufreqd.
> > >
> > 
> > Although the patch worked for me, it was probably bogus.
> 
> no, it was quite fine i think.
> 
> > The real reason why cpufreq caused problems was that it does:
> >   init_MUTEX_LOCKED(&policy->lock);
> > and later:
> >   up(&policy->lock);
> > where policy->lock is declared as:
> >   struct semaphore        lock;
> > 
> > In PREEMPT_RT, the init_MUTEX_LOCKED is defined in include/linux/rt_lock.h :
> >   /*
> >    * No locked initialization for RT semaphores:
> >    */
> >   #define init_MUTEX_LOCKED(sem) compat_init_MUTEX_LOCKED(sem)
> > (BTW, I don't understand why we have init_MUTEX but no init_MUTEX_LOCKED 
> > for RT semaphores).
> 
> RT semaphores have stricter semantics than Linux semaphores. One 
> property is that there always needs to be an owner of a semaphore. If a 
> semaphore gets initialized as init_MUTEX_LOCKED, it is a fair indication
> that the semaphore is really used as a completion object - with no
> stable owner.  (e.g. at insmod time when the init_MUTEX_LOCKED is done,
> the insmod thread will go away after some time, leaving the semaphore
> 'orphaned')
> 
> > So the fix is to change the lock type into compat_semaphore. I'm 
> > attaching the patch. It works for me with 2.6.12-rc5-RT-V0.7.47-12.
> 
> it would be nice to get the conversion to completions upstream. It is a 
> perfectly fine solution. The compat_semaphore thing is another, easier 
> solution.
> 
> 	Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

