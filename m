Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267377AbUH1QMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267377AbUH1QMS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 12:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267372AbUH1QKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 12:10:34 -0400
Received: from lakermmtao05.cox.net ([68.230.240.34]:48084 "EHLO
	lakermmtao05.cox.net") by vger.kernel.org with ESMTP
	id S267333AbUH1QJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 12:09:20 -0400
In-Reply-To: <20040828151716.GC12772@fs.tum.de>
References: <20040828151137.GA12772@fs.tum.de> <20040828151716.GC12772@fs.tum.de>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <95F4407E-F90C-11D8-A7C9-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [2.6 patch][2/3] kernel/ BUG -> BUG_ON conversions
Date: Sat, 28 Aug 2004 12:09:05 -0400
To: Adrian Bunk <bunk@fs.tum.de>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 28, 2004, at 11:17, Adrian Bunk wrote:
> The patch below does BUG -> BUG_ON conversions in kernel/ .
>
> --- linux-2.6.9-rc1-mm1-full-3.4/kernel/cpu.c.old	2004-08-28 
> 16:05:17.000000000 +0200
> +++ linux-2.6.9-rc1-mm1-full-3.4/kernel/cpu.c	2004-08-28 
> 16:06:24.000000000 +0200
> @@ -156,9 +156,8 @@
>  	kthread_bind(p, smp_processor_id());
>
>  	/* CPU is completely dead: tell everyone.  Too late to complain. */
> -	if (notifier_call_chain(&cpu_chain, CPU_DEAD, (void *)(long)cpu)
> -	    == NOTIFY_BAD)
> -		BUG();
> +	BUG_ON(notifier_call_chain(&cpu_chain, CPU_DEAD, (void *)(long)cpu)
> +	       == NOTIFY_BAD);

Can't do this, without DEBUG the notifier_call_chain _won't_ be executed

>  	check_for_tasks(cpu);
>
> @@ -203,8 +202,7 @@
>  	ret = __cpu_up(cpu);
>  	if (ret != 0)
>  		goto out_notify;
> -	if (!cpu_online(cpu))
> -		BUG();
> +	BUG_ON(!cpu_online(cpu));

Does cpu_online() have any side effects?

>
>  	/* Now call notifier in preparation. */
>  	notifier_call_chain(&cpu_chain, CPU_ONLINE, hcpu);
> --- linux-2.6.9-rc1-mm1-full-3.4/kernel/exit.c.old	2004-08-28 
> 16:05:17.000000000 +0200
> +++ linux-2.6.9-rc1-mm1-full-3.4/kernel/exit.c	2004-08-28 
> 16:08:24.000000000 +0200
> @@ -503,7 +503,7 @@
>  		down_read(&mm->mmap_sem);
>  	}
>  	atomic_inc(&mm->mm_count);
> -	if (mm != tsk->active_mm) BUG();
> +	BUG_ON(mm != tsk->active_mm);
>  	/* more a memory barrier than a real lock */
>  	task_lock(tsk);
>  	tsk->mm = NULL;
> @@ -878,11 +877,9 @@
>  	const struct list_head *tmp, *head = &link->pidptr->task_list;
>
>  #ifdef CONFIG_SMP
> -	if (!p->sighand)
> -		BUG();
> -	if (!spin_is_locked(&p->sighand->siglock) &&
> -				!rwlock_is_locked(&tasklist_lock))
> -		BUG();
> +	BUG_ON(!p->sighand);
> +	BUG_ON(!spin_is_locked(&p->sighand->siglock) &&
> +				!rwlock_is_locked(&tasklist_lock));

These _should_ be OK, but I'm not sure if spin_is_locked and 
rwlock_is_locked
have any memory barrier guarantees.

>  #endif
>  	tmp = link->pid_chain.next;
>  	if (tmp == head)
> @@ -1350,8 +1347,7 @@
>  		if (options & __WNOTHREAD)
>  			break;
>  		tsk = next_thread(tsk);
> -		if (tsk->signal != current->signal)
> -			BUG();
> +		BUG_ON(tsk->signal != current->signal);
>  	} while (tsk != current);
>
>  	read_unlock(&tasklist_lock);
> --- linux-2.6.9-rc1-mm1-full-3.4/kernel/fork.c.old	2004-08-28 
> 16:05:17.000000000 +0200
> +++ linux-2.6.9-rc1-mm1-full-3.4/kernel/fork.c	2004-08-28 
> 16:08:45.000000000 +0200
> @@ -809,8 +809,7 @@
>  	struct files_struct *files  = current->files;
>  	int rc;
>
> -	if(!files)
> -		BUG();
> +	BUG_ON(!files);
>
>  	/* This can race but the race causes us to copy when we don't
>  	   need to and drop the copy */
> --- linux-2.6.9-rc1-mm1-full-3.4/kernel/module.c.old	2004-08-28 
> 16:05:17.000000000 +0200
> +++ linux-2.6.9-rc1-mm1-full-3.4/kernel/module.c	2004-08-28 
> 16:13:44.000000000 +0200
> @@ -655,8 +655,7 @@
>  	const unsigned long *crc;
>
>  	spin_lock_irqsave(&modlist_lock, flags);
> -	if (!__find_symbol(symbol, &owner, &crc, 1))
> -		BUG();
> +	BUG_ON(!__find_symbol(symbol, &owner, &crc, 1));

Does __find_symbol have side effects?

>  	module_put(owner);
>  	spin_unlock_irqrestore(&modlist_lock, flags);
>  }
> @@ -667,8 +666,7 @@
>  	unsigned long flags;
>
>  	spin_lock_irqsave(&modlist_lock, flags);
> -	if (!kernel_text_address((unsigned long)addr))
> -		BUG();
> +	BUG_ON(!kernel_text_address((unsigned long)addr));

Side effects?

>  	module_put(module_text_address((unsigned long)addr));
>  	spin_unlock_irqrestore(&modlist_lock, flags);
> @@ -905,8 +903,7 @@
>  	const unsigned long *crc;
>  	struct module *owner;
>
> -	if (!__find_symbol("struct_module", &owner, &crc, 1))
> -		BUG();
> +	BUG_ON(!__find_symbol("struct_module", &owner, &crc, 1));
>  	return check_version(sechdrs, versindex, "struct_module", mod,
>  			     crc);
>  }

[Bunch of patch chomped]

Please verify that you don't pull important function calls into 
BUG_ON() statements.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a17 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


