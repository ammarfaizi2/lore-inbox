Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030352AbWANNtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030352AbWANNtZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 08:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030394AbWANNtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 08:49:25 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:29345
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1030352AbWANNtZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 08:49:25 -0500
Subject: Re: [patch 00/62] sem2mutex: -V1
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: linux-kernel@vger.kernel.org, chaosite@gmail.com,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>, Greg KH <greg@kroah.com>
In-Reply-To: <200601141422.16760.ioe-lkml@rameria.de>
References: <20060113124402.GA7351@elte.hu> <20060113195658.GA3780@elte.hu>
	 <43C815E3.10005@gmail.com>  <200601141422.16760.ioe-lkml@rameria.de>
Content-Type: text/plain
Date: Sat, 14 Jan 2006 14:49:33 +0100
Message-Id: <1137246573.7634.71.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

> semaphore -> mutex is explained a bit in Documentation/mutex-design.txt
> 
> Still missing:
>  - semaphore -> completion

Sempahore to completion is rather simple to explain.

The pattern is mostly like this

threadA
	init_MUTEX_LOCKED(&shared_data_struct.mutex);
	kick_off_threadB();
	down(&shared_data_struct.mutex);

threadB
	wait_for_kick_off();
	do_some_work();
	up(&shared_data_struct.mutex);

The conversion is:

threadA
	init_completion(&shared_data_struct.completion);
	kick_off_threadB();
	wait_for_completion(&shared_data_struct.completion);
	
threadB
	wait_for_kick_off();
	do_some_work();
	complete(&shared_data_struct.completion);

Note, that a completion is only useful, when there are only two parties
involved. The one which initiates an action and the one which signals
completion of the requested action. The action can be some deferred
workload or synchronization of startup / shutdown of related threads.
Its a synchronization mechanism not a concurrency control in the sense
of data protection across multiple potential users of a data structure.

Real life example:

> --- jffs2_fs_sb.h       28 Feb 2005 08:21:06 -0000      1.51
> +++ jffs2_fs_sb.h       19 May 2005 16:12:17 -0000      1.52
> @@ -32,7 +32,7 @@
>         unsigned int flags;
>  
>         struct task_struct *gc_task;    /* GC task struct */
> -       struct semaphore gc_thread_start; /* GC thread start mutex */
> +       struct completion gc_thread_start; /* GC thread start completion */
>         struct completion gc_thread_exit; /* GC thread exit completion port */
>  
>         struct semaphore alloc_sem;     /* Used to protect all the following 
> 
> 
> --- background.c        17 Mar 2005 20:15:58 -0000      1.51
> +++ background.c        19 May 2005 16:18:08 -0000      1.52
> @@ -37,7 +37,7 @@
>         if (c->gc_task)
>                 BUG();

ThreadA
 
> -       init_MUTEX_LOCKED(&c->gc_thread_start);
> +       init_completion(&c->gc_thread_start);
>         init_completion(&c->gc_thread_exit);
>  
>         pid = kernel_thread(jffs2_garbage_collect_thread, c, CLONE_FS|CLONE_FILES);
> @@ -48,7 +48,7 @@
>         } else {
>                 /* Wait for it... */
>                 D1(printk(KERN_DEBUG "JFFS2: Garbage collect thread is pid %d\n", pid));
> -               down(&c->gc_thread_start);
> +               wait_for_completion(&c->gc_thread_start);
>         }
>   
>         return ret;
> @@ -75,7 +75,7 @@
>         allow_signal(SIGCONT);

ThreadB
 
>         c->gc_task = current;
> -       up(&c->gc_thread_start);
> +       complete(&c->gc_thread_start);
>  
>         set_user_nice(current, 10);
> 

Hope that helps

	tglx



