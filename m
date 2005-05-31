Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbVEaIAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbVEaIAw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 04:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbVEaIAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 04:00:52 -0400
Received: from fmr21.intel.com ([143.183.121.13]:43193 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S261356AbVEaIAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 04:00:39 -0400
Date: Tue, 31 May 2005 01:00:31 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Shaohua Li <shaohua.li@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       nickpiggin@yahoo.com.au
Subject: Re: [PATCH]CPU hotplug breaks wake_up_new_task
Message-ID: <20050531010030.A5239@unix-os.sc.intel.com>
References: <1117524909.3820.11.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1117524909.3820.11.camel@linux-hp.sh.intel.com>; from shaohua.li@intel.com on Tue, May 31, 2005 at 12:35:09AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2005 at 12:35:09AM -0700, Shaohua Li wrote:
> 
>    Hi,
>    There is a race condition at wake_up_new_task at CPU hotplug case.
>    Say do_fork
>             copy_process  (which  sets  new  forked  task's  current cpu,
>    cpu_allowed)
>                    <-------- the new forked task's current cpu is offline
>            wake_up_new_task
>    wake_up_new_task will put the forked task into a dead cpu.
> 
>    Thanks,
>    Shaohua
> 
>    Signed-off-by: Shaohua Li<shaohua.li@intel.com>
>    ---
> 
>     linux-2.6.11-rc5-mm1-root/kernel/sched.c            |              25
.... Deleted....
>     /*
>       *  wake_up_new_task  -  wake  up a newly created task for the first
>    time.
>      *
>    @@ -1426,9 +1430,20 @@ void fastcall wake_up_new_task(task_t *
>            runqueue_t *rq, *this_rq;
> 
>            rq = task_rq_lock(p, &flags);
>    -       BUG_ON(p->state != TASK_RUNNING);
>            this_cpu = smp_processor_id();
>            cpu = task_cpu(p);
>    +#ifdef CONFIG_HOTPLUG_CPU
>    +       while (!cpu_online(cpu)) {
>    +               cpu = task_select_online_cpu(cpu, p);
>    +               set_task_cpu(p, cpu);
>    +               task_rq_unlock(rq, &flags);
>    +               /* CPU hotplug might occur here */
>    +               rq = task_rq_lock(p, &flags);
>    +               this_cpu = smp_processor_id();
>    +               cpu = task_cpu(p);
>    +       }
>    +#endif

The while() loop doesnt look pretty here.. could you try to 
disable preempt, and see the problem goes away? or use 
get_cpu()/put_cpu() combo when you get this_cpu?

Just wondering if the code would be a little more simpler in this
case.

Nick should have something to say ...

Cheers,
ashok
