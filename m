Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263199AbVAFXDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263199AbVAFXDq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 18:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263069AbVAFXBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 18:01:34 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:63685 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S263102AbVAFWvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 17:51:33 -0500
Subject: Re: [hugang@soulinfo.com: [PATH]software suspend for ppc.]
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: hugang@soulinfo.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050106223132.GD25913@elf.ucw.cz>
References: <20050103122653.GB8827@hugang.soulinfo.com>
	 <20050103221718.GC25250@elf.ucw.cz>
	 <20050106160306.GA20127@hugang.soulinfo.com>
	 <20050106223132.GD25913@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1105051964.4507.2.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 07 Jan 2005 09:52:46 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2005-01-07 at 09:31, Pavel Machek wrote:
> Hi!
> 
> > > swsusp_arch_{suspend,resume} should really be written in
> > > assembly. Just compile this, disassemble it and put it into source
> > > file. Otherwise it looks OK.
> > > 								Pavel
> > 
> > After do more test, I have to drop my last patch, That's unstable.
> > Current I using this one from 
> >  http://honk.physik.uni-konstanz.de/~agx/linux-ppc/kernel/
> > 
> > Here is another patch try make software suspend work well. This idea
> > base on swsusp2.
> > 
> > adding a option to freeze/thaw_processes, first freeze all user
> > processess, from now only kernel processess running, Now we can shrink
> > more memory than current version, after that freeze all processes.
> > that's mean if your swap space enough, swsusp will not fail. 
> 
> Thanks for the port... ...what is the test case this fixes?

I don't know what Steve wants it for, but I use it for freezing
userspace, then syncing, then freezing kernelspace.. and I use a couple
of #defines to make the argument more readable.

Regards,

Nigel

> Patch is pretty pretty simple, that's good...
> 
> 							Pavel
> 
> 
> 
> > --- 2.6.10-mm1/include/linux/sched.h	2005-01-03 18:53:51.000000000 +0800
> > +++ 2.6.10-mm1-swsusp//include/linux/sched.h	2005-01-03 22:33:37.000000000 +0800
> > @@ -1172,8 +1172,8 @@ extern void normalize_rt_tasks(void);
> >   */
> >  #ifdef CONFIG_PM
> >  extern void refrigerator(unsigned long);
> > -extern int freeze_processes(void);
> > -extern void thaw_processes(void);
> > +extern int freeze_processes(int);
> > +extern void thaw_processes(int);
> >  
> >  static inline int try_to_freeze(unsigned long refrigerator_flags)
> >  {
> > --- 2.6.10-mm1/kernel/power/disk.c	2004-12-30 14:49:03.000000000 +0800
> > +++ 2.6.10-mm1-swsusp//kernel/power/disk.c	2005-01-03 22:53:11.000000000 +0800
> > @@ -116,7 +116,7 @@ static void finish(void)
> >  	device_resume();
> >  	platform_finish();
> >  	enable_nonboot_cpus();
> > -	thaw_processes();
> > +	thaw_processes(1);
> >  	pm_restore_console();
> >  }
> >  
> > @@ -128,7 +128,7 @@ static int prepare(void)
> >  	pm_prepare_console();
> >  
> >  	sys_sync();
> > -	if (freeze_processes()) {
> > +	if (freeze_processes(0)) {
> >  		error = -EBUSY;
> >  		goto Thaw;
> >  	}
> > @@ -142,6 +142,8 @@ static int prepare(void)
> >  
> >  	/* Free memory before shutting down devices. */
> >  	free_some_memory();
> > +	
> > +	freeze_processes(1);
> >  
> >  	disable_nonboot_cpus();
> >  	if ((error = device_suspend(PM_SUSPEND_DISK)))
> > @@ -152,7 +154,7 @@ static int prepare(void)
> >  	platform_finish();
> >   Thaw:
> >  	enable_nonboot_cpus();
> > -	thaw_processes();
> > +	thaw_processes(1);
> >  	pm_restore_console();
> >  	return error;
> >  }
> > --- 2.6.10-mm1/kernel/power/main.c	2004-12-30 14:49:02.000000000 +0800
> > +++ 2.6.10-mm1-swsusp//kernel/power/main.c	2005-01-03 22:39:53.000000000 +0800
> > @@ -55,7 +55,7 @@ static int suspend_prepare(suspend_state
> >  
> >  	pm_prepare_console();
> >  
> > -	if (freeze_processes()) {
> > +	if (freeze_processes(1)) {
> >  		error = -EAGAIN;
> >  		goto Thaw;
> >  	}
> > @@ -72,7 +72,7 @@ static int suspend_prepare(suspend_state
> >  	if (pm_ops->finish)
> >  		pm_ops->finish(state);
> >   Thaw:
> > -	thaw_processes();
> > +	thaw_processes(1);
> >  	pm_restore_console();
> >  	return error;
> >  }
> > @@ -107,7 +107,7 @@ static void suspend_finish(suspend_state
> >  	device_resume();
> >  	if (pm_ops && pm_ops->finish)
> >  		pm_ops->finish(state);
> > -	thaw_processes();
> > +	thaw_processes(1);
> >  	pm_restore_console();
> >  }
> >  
> > --- 2.6.10-mm1/kernel/power/power.h	2004-12-30 14:49:02.000000000 +0800
> > +++ 2.6.10-mm1-swsusp//kernel/power/power.h	2005-01-03 22:39:24.000000000 +0800
> > @@ -45,8 +45,5 @@ static struct subsys_attribute _name##_a
> >  
> >  extern struct subsystem power_subsys;
> >  
> > -extern int freeze_processes(void);
> > -extern void thaw_processes(void);
> > -
> >  extern int pm_prepare_console(void);
> >  extern void pm_restore_console(void);
> > --- 2.6.10-mm1/kernel/power/process.c	2004-12-30 14:49:02.000000000 +0800
> > +++ 2.6.10-mm1-swsusp//kernel/power/process.c	2005-01-03 22:34:50.000000000 +0800
> > @@ -19,7 +19,7 @@
> >  #define TIMEOUT	(6 * HZ)
> >  
> >  
> > -static inline int freezeable(struct task_struct * p)
> > +static inline int freezeable(struct task_struct * p, int all)
> >  {
> >  	if ((p == current) || 
> >  	    (p->flags & PF_NOFREEZE) ||
> > @@ -28,6 +28,8 @@ static inline int freezeable(struct task
> >  	    (p->state == TASK_STOPPED) ||
> >  	    (p->state == TASK_TRACED))
> >  		return 0;
> > +	if (all == 0 && p->mm == NULL) 
> > +		return 0;
> >  	return 1;
> >  }
> >  
> > @@ -55,7 +57,7 @@ void refrigerator(unsigned long flag)
> >  }
> >  
> >  /* 0 = success, else # of processes that we failed to stop */
> > -int freeze_processes(void)
> > +int freeze_processes(int all)
> >  {
> >         int todo;
> >         unsigned long start_time;
> > @@ -68,7 +70,7 @@ int freeze_processes(void)
> >  		read_lock(&tasklist_lock);
> >  		do_each_thread(g, p) {
> >  			unsigned long flags;
> > -			if (!freezeable(p))
> > +			if (!freezeable(p, all))
> >  				continue;
> >  			if ((p->flags & PF_FROZEN) ||
> >  			    (p->state == TASK_TRACED) ||
> > @@ -97,14 +99,14 @@ int freeze_processes(void)
> >  	return 0;
> >  }
> >  
> > -void thaw_processes(void)
> > +void thaw_processes(int all)
> >  {
> >  	struct task_struct *g, *p;
> >  
> >  	printk( "Restarting tasks..." );
> >  	read_lock(&tasklist_lock);
> >  	do_each_thread(g, p) {
> > -		if (!freezeable(p))
> > +		if (!freezeable(p, all))
> >  			continue;
> >  		if (p->flags & PF_FROZEN) {
> >  			p->flags &= ~PF_FROZEN;
> > 
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com

Ph: +61 (2) 6292 8028      Mob: +61 (417) 100 574

