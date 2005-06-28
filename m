Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261909AbVF1Hdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbVF1Hdf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 03:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbVF1Hda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 03:33:30 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:45492 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S261947AbVF1Hap (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 03:30:45 -0400
Message-ID: <42C0FCB3.4030205@sw.ru>
Date: Tue, 28 Jun 2005 11:30:59 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Christoph Lameter <christoph@lameter.com>
CC: Pavel Machek <pavel@ucw.cz>, Linus Torvalds <torvalds@osdl.org>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org, raybry@engr.sgi.com,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: [RFC] Fix SMP brokenness for PF_FREEZE and make freezing usable
 for other purposes
References: <Pine.LNX.4.62.0506241316370.30503@graphe.net> <20050625025122.GC22393@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.62.0506242311220.7971@graphe.net> <20050626023053.GA2871@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.62.0506251954470.26198@graphe.net> <20050626030925.GA4156@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.62.0506261928010.1679@graphe.net> <Pine.LNX.4.58.0506262121070.19755@ppc970.osdl.org> <Pine.LNX.4.62.0506262249080.4374@graphe.net> <20050627141320.GA4945@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.62.0506270804450.17400@graphe.net> <42C0EBAB.8070709@sw.ru> <Pine.LNX.4.62.0506272323490.30956@graphe.net>
In-Reply-To: <Pine.LNX.4.62.0506272323490.30956@graphe.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>-static inline int freezing(struct task_struct *p)
>>>-{
>>>-	return p->flags & PF_FREEZE;
>>>-}
>>>+#if defined(CONFIG_PM) || defined(CONFIG_MIGRATE)
>>
>><<<< why not to make a single option CONFIG_REFRIGERATOR? It looks to be a
>>more robust way, since there are multiple users of it.
> 
> 
> Yes. That may be better. We can do that once the migration code is 
> finished and when we know what kind of CONFIG_XXX the migration code 
> really needs.
> 
> 
>>>+#ifdef CONFIG_PM
>>
>><<<< is it intentionaly? or you just lost CONFIG_MIGRATE?
> It is intentional. freeze_processes and thaw_processes are only needed 
> for suspend. One only needs to freeze a couple of processes for process 
> migration.
But PM and your migrate code can be not the only users of it.

>><<<< I still think this refrigerator is racy with freeze_processes():
>><<<< scenarios:
>><<<< scenario 1
>><<<<
>>task1 -> freeze_processes():			taskXXX ->refrigerator()
>>  checked (task->flags & PF_FROZEN) == 0	cur->flags |= PF_FROZEN
>>						clear TIF_FREEZE
>>						<sleep on thaw>
>>  set TIF_FREEZING
>>						clear PF_FROZEN
>>
>><<<< so the task awakes with TIF_FREEZE flag set!!!
> 
> 
> Hmm... If we wait to clear both flags until after the completion 
> notification then we do not have the race right? But then we need to move 
> the signal recalc since it tests for TIF_FREEZE too.
It is almost ok, but it is still not fine :)

look what happens if you call freeze/unfreeze in a loop:

refrigerator:
awakes

freezer:
check PF_FROZEN, it is still set, skips task and thinks it is finished 
freezing.

refrigerator:
clears PF_FROZEN and TIF_FREEZE and returns.

I think you can fix this by moving PF_FROZEN check and set in both 
places under siglock.

Kirill


>><<<< scenario 2
>><<<< look at error path in freeze_processes (on timeout), it is broken as
>>well. You need to wakeup tasks there...
> 
> 
> Ok. How about this additional patch? This still requires that process 
> freezing does not immediately occurr again after the completion 
> handler. All of this is iffy due to not having a real lock protecting all 
> these values and we may still need to add some barriers.
> 
> Index: linux-2.6.12/kernel/power/process.c
> ===================================================================
> --- linux-2.6.12.orig/kernel/power/process.c	2005-06-28 06:34:52.000000000 +0000
> +++ linux-2.6.12/kernel/power/process.c	2005-06-28 06:40:28.000000000 +0000
> @@ -47,12 +47,13 @@ int freeze_processes(void)
>  			unsigned long flags;
>  			if (!freezeable(p))
>  				continue;
> -			if ((p->flags & PF_FROZEN) ||
> -			    (p->state == TASK_TRACED) ||
> +			if ((p->state == TASK_TRACED) ||
>  			    (p->state == TASK_STOPPED))
>  				continue;
>  
>  			set_thread_flag(TIF_FREEZE);
> +			if (p->flags & PF_FROZEN)
> +				continue;
>  			spin_lock_irqsave(&p->sighand->siglock, flags);
>  			signal_wake_up(p, 0);
>  			spin_unlock_irqrestore(&p->sighand->siglock, flags);
> @@ -63,6 +64,8 @@ int freeze_processes(void)
>  		if (time_after(jiffies, start_time + TIMEOUT)) {
>  			printk( "\n" );
>  			printk(KERN_ERR " stopping tasks failed (%d tasks remaining)\n", todo );
> +			complete_all(&thaw);
> +			up(&freezer_sem);
>  			return todo;
>  		}
>  	} while(todo);
> Index: linux-2.6.12/kernel/sched.c
> ===================================================================
> --- linux-2.6.12.orig/kernel/sched.c	2005-06-28 06:34:52.000000000 +0000
> +++ linux-2.6.12/kernel/sched.c	2005-06-28 06:37:36.000000000 +0000
> @@ -5210,13 +5210,13 @@ DECLARE_COMPLETION(thaw);
>  void refrigerator(void)
>  {
>  	current->flags |= PF_FROZEN;
> +	wait_for_completion(&thaw);
>  	clear_thread_flag(TIF_FREEZE);
> +	current->flags &= ~PF_FROZEN;
>  	/* A fake signal 0 may have been sent. Recalculate sigpending */
>  	spin_lock_irq(&current->sighand->siglock);
>  	recalc_sigpending();
>  	spin_unlock_irq(&current->sighand->siglock);
> -	wait_for_completion(&thaw);
> -	current->flags &= ~PF_FROZEN;
>  }
>  EXPORT_SYMBOL(refrigerator);
>  #endif
> 


