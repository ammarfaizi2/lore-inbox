Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbVELL11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbVELL11 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 07:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbVELL11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 07:27:27 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:921 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261439AbVELL1U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 07:27:20 -0400
Date: Thu, 12 May 2005 16:58:07 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: Vivek Goyal <vgoyal@in.ibm.com>, Badari Pulavarty <pbadari@us.ibm.com>,
       Morton Andrew Morton <akpm@osdl.org>, fastboot@lists.osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] kexec+kdump testing with 2.6.12-rc3-mm3
Message-ID: <20050512112807.GA21343@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <1115769558.26913.1046.camel@dyn318077bld.beaverton.ibm.com> <20050511025325.GA3638@in.ibm.com> <1115824847.26913.1061.camel@dyn318077bld.beaverton.ibm.com> <20050512054424.GC3838@in.ibm.com> <20050512102230.GB3870@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050512102230.GB3870@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2005 at 10:25:37AM +0000, Maneesh Soni wrote:
> Following is a somewhat crude user defined command to dump stack for all the 
> processes in the crashdump
> 
> 
> (gdb) define ps
> Type commands for definition of "ps".
> End with a line saying just "end".
> >set $tasks_off=((size_t)&((struct task_struct *)0)->tasks)
> >set $init_t=&init_task
> >set $next_t=(((char *)($init_t->tasks).next) - $tasks_off)
> >while ($next_t != $init_t)
>  >set $next_t=(struct task_struct *)$next_t
>  >print $next_t.comm
>  >print $next_t.pid
>  >x/40x $next_t.thread.esp
>  >set $next_t=(char *)($next_t->tasks.next) - $tasks_off
>  >end
> >end

Probably you need another loop here for iterating thr' all the
threads of a task? do_each_thread/while_each_thread macros give
the details.

Basically the macros can be modified as:

set $tasks_off=((size_t)&((struct task_struct *)0)->tasks)
set $pid_off=((size_t)&((struct task_struct *)0)->pids[1].pid_list.next)
set $init_t=&init_task
set $next_t=(((char *)($init_t->tasks).next) - $tasks_off)
while ($next_t != $init_t)
set $next_t=(struct task_struct *)$next_t
printf "\n%s:\n", $next_t.comm
printf "PID = %d\n", $next_t.pid
printf "Stack dump:\n"
x/40x $next_t.thread.esp
set $next_th=(((char *)$next_t->pids[1].pid_list.next) - $pid_off)
while ($next_th != $next_t)
set $next_th=(struct task_struct *)$next_th
printf "\n%s:\n", $next_th.comm
printf "PID = %d\n", $next_th.pid
printf "Stack dump:\n"
x/40x $next_th.thread.esp
set $next_th=(((char *)$next_th->pids[1].pid_list.next) - $pid_off)
end
set $next_t=(char *)($next_t->tasks.next) - $tasks_off
end




-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
