Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264180AbTFDV4Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 17:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264181AbTFDV4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 17:56:15 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:50853 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S264180AbTFDVz5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 17:55:57 -0400
Date: Thu, 5 Jun 2003 00:08:50 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.70: some power management changes
Message-ID: <20030604220849.GL333@elf.ucw.cz>
References: <20030529122122.GA21147@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030529122122.GA21147@rhlx01.fht-esslingen.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> - much more verbose suspend output in order to actually enable people
>   to see what's going on inside the still highly problematic suspend handling
>   (on my Dell Inspiron 8000, only ACPI S1 works at all, and only
>   after a LOT of investigation and tweaking)
>   And let's be extra aggressive about drivers that don't have suspend
>   handlers yet but might need them and thus cause problems on resume
>   due to missing hardware state saving...
>   A lot of drivers don't handle that yet, so point that out properly for the
>   time being.
> - fix invidual suspend handlers' output to be able to properly identify
>   them
> - rename strangely named INTERESTING define to IGNORE_SPECIAL_THREADS which
>   makes much more sense
> - some spelling stuff
> - update my email address ;)
> 
> This patch doesn't include the pccardd suspend fix, since I noticed that
> it has been fixed by someone else already ;-\
> (which was pccardd-suspend-fix.patch)
> 
> Patch against vanilla 2.5.70.
> 
> I just hope that the right person knows that (s)he is supposed to commit it.
> (or not...)

Well, you are supposed to push it, yourself.

Separate spelling fixes, that goes to linus with "Spelling fixes" subject.

> @@ -35,19 +35,25 @@
>  	struct list_head * node;
>  	int error = 0;
>  
> -	printk(KERN_EMERG "Suspending devices\n");
> +	printk(KERN_EMERG "Suspending devices (%d, %d)\n", state, level);
>  
>  	down_write(&devices_subsys.rwsem);
>  	list_for_each(node,&devices_subsys.kset.list) {
>  		struct device * dev = to_dev(node);
> -		if (dev->driver && dev->driver->suspend) {
> -			pr_debug("suspending device %s\n",dev->name);
> -			error = dev->driver->suspend(dev,state,level);
> -			if (error)
> -				printk(KERN_ERR "%s: suspend returned %d\n",dev->name,error);
> +		if (dev->driver)
> +		{

Formating!

> +			if (dev->driver->suspend) {
> +				printk("suspending device %s\n",dev->name);
> +				error = dev->driver->suspend(dev,state,level);
> +				if (error)
> +					printk(KERN_ERR "%s: suspend failed, error %d\n",dev->name,error);
> +			}
> +			else
> +				printk("no suspend function (yet?) in driver for %s\n",dev->name);
>  		}
>  	}
>  	up_write(&devices_subsys.rwsem);
> +
>  	return error;
>  }
>  

I like this patch, Patrick Mochel is probably right person to push it through...


> @@ -62,13 +68,16 @@
>  void device_resume(u32 level)
>  {
>  	struct list_head * node;
> +	int error = 0;
>  
>  	down_write(&devices_subsys.rwsem);
>  	list_for_each_prev(node,&devices_subsys.kset.list) {
>  		struct device * dev = to_dev(node);
>  		if (dev->driver && dev->driver->resume) {
> -			pr_debug("resuming device %s\n",dev->name);
> -			dev->driver->resume(dev,level);
> +			printk("resuming device %s\n",dev->name);
> +			error = dev->driver->resume(dev,level);
> +			if (error)
> +				printk(KERN_ERR "%s: resume failed, error %d\n",dev->name,error);
>  		}
>  	}
>  	up_write(&devices_subsys.rwsem);

Same here.

> diff -urN linux-2.5.70.orig/drivers/ide/ide-disk.c linux-2.5.70/drivers/ide/ide-disk.c
> --- linux-2.5.70.orig/drivers/ide/ide-disk.c	2003-05-28 17:58:47.000000000 +0200
> +++ linux-2.5.70/drivers/ide/ide-disk.c	2003-05-28 18:38:10.000000000 +0200
> @@ -1509,7 +1509,7 @@
>  {
>  	ide_drive_t *drive = dev->driver_data;
>  
> -	printk("Suspending device %p\n", dev->driver_data);
> +	printk("IDE device %s: suspend to state %d\n", drive->name, state);
>  
>  	/* I hope that every freeze operation from the upper levels have
>  	 * already been done...
> @@ -1519,7 +1519,6 @@
>  		return 0;
>  
>  	/* set the drive to standby */
> -	printk(KERN_INFO "suspending: %s ", drive->name);
>  	do_idedisk_standby(drive);
>  	drive->blocked = 1;
>  

Kill these. Someone else is fixing IDE, you don't want to clash.

> diff -urN linux-2.5.70.orig/kernel/suspend.c linux-2.5.70/kernel/suspend.c
> --- linux-2.5.70.orig/kernel/suspend.c	2003-05-28 17:59:02.000000000 +0200
> +++ linux-2.5.70/kernel/suspend.c	2003-05-27 16:05:06.000000000 +0200
> @@ -24,7 +24,7 @@
>   * Straightened the critical function in order to prevent compilers from
>   * playing tricks with local variables.
>   *
> - * Andreas Mohr <a.mohr@mailto.de>
> + * Andreas Mohr <andi@lisas.de>
>   *
>   * Alex Badea <vampire@go.ro>:
>   * Fixed runaway init
> @@ -164,7 +164,7 @@
>   * Refrigerator and related stuff
>   */
>  
> -#define INTERESTING(p) \
> +#define IGNORE_SPECIAL_THREADS(p) \
>  			/* We don't want to touch kernel_threads..*/ \
>  			if (p->flags & PF_IOTHREAD) \
>  				continue; \
> @@ -205,6 +205,9 @@
>         unsigned long start_time;
>  	struct task_struct *g, *p;
>  	
> +	/* keep iterating over all threads and signal to them that they
> +	 * are supposed to freeze (in signal handler), until timeout happens.
> +	 */
>  	printk( "Stopping tasks: " );
>  	start_time = jiffies;
>  	do {
> @@ -212,14 +215,16 @@
>  		read_lock(&tasklist_lock);
>  		do_each_thread(g, p) {
>  			unsigned long flags;
> -			INTERESTING(p);
> +			IGNORE_SPECIAL_THREADS(p);
>  			if (p->flags & PF_FROZEN)
>  				continue;
>  
> +			p->flags |= PF_FREEZE; /* this task should be frozen */
>  			/* FIXME: smp problem here: we may not access other process' flags
>  			   without locking */
> -			p->flags |= PF_FREEZE;

No its actually right the other way.

>  			spin_lock_irqsave(&p->sighand->siglock, flags);
> +			/* send signal to thread in order to schedule to it
> +			 * and freeze it in its own context there */
>  			signal_wake_up(p, 0);
>  			spin_unlock_irqrestore(&p->sighand->siglock, flags);
>  			todo++;
> @@ -232,7 +237,7 @@
>  			return todo;
>  		}
>  	} while(todo);
> -	
> + 	
>  	printk( "|\n" );
>  	BUG_ON(in_atomic());
>  	return 0;

You are adding space before tab. RIght solution is to kill both.

> @@ -245,7 +250,7 @@
>  	printk( "Restarting tasks..." );
>  	read_lock(&tasklist_lock);
>  	do_each_thread(g, p) {
> -		INTERESTING(p);
> +		IGNORE_SPECIAL_THREADS(p);
>  		
>  		if (p->flags & PF_FROZEN) p->flags &= ~PF_FROZEN;
>  		else
> 

I have nothing against that rename, but you take care of pushing that
yourselves. Tell Linus I okayed it.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
