Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262561AbVENKd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262561AbVENKd5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 06:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262618AbVENKd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 06:33:56 -0400
Received: from mailfe03.swip.net ([212.247.154.65]:15790 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262561AbVENKdb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 06:33:31 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: [Fastboot] kexec+kdump testing with 2.6.12-rc3-mm3
From: Alexander Nyberg <alexn@telia.com>
To: vatsa@in.ibm.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       fastboot@lists.osdl.org, Andrew Morton <akpm@osdl.org>,
       Badari Pulavarty <pbadari@us.ibm.com>, Vivek Goyal <vgoyal@in.ibm.com>,
       Maneesh Soni <maneesh@in.ibm.com>
In-Reply-To: <20050512112807.GA21343@in.ibm.com>
References: <1115769558.26913.1046.camel@dyn318077bld.beaverton.ibm.com>
	 <20050511025325.GA3638@in.ibm.com>
	 <1115824847.26913.1061.camel@dyn318077bld.beaverton.ibm.com>
	 <20050512054424.GC3838@in.ibm.com> <20050512102230.GB3870@in.ibm.com>
	 <20050512112807.GA21343@in.ibm.com>
Content-Type: text/plain
Date: Sat, 14 May 2005 12:33:16 +0200
Message-Id: <1116066796.919.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Probably you need another loop here for iterating thr' all the
> threads of a task? do_each_thread/while_each_thread macros give
> the details.
> 
> Basically the macros can be modified as:
> 
> set $tasks_off=((size_t)&((struct task_struct *)0)->tasks)
> set $pid_off=((size_t)&((struct task_struct *)0)->pids[1].pid_list.next)
> set $init_t=&init_task
> set $next_t=(((char *)($init_t->tasks).next) - $tasks_off)
> while ($next_t != $init_t)
> set $next_t=(struct task_struct *)$next_t
> printf "\n%s:\n", $next_t.comm
> printf "PID = %d\n", $next_t.pid
> printf "Stack dump:\n"
> x/40x $next_t.thread.esp
> set $next_th=(((char *)$next_t->pids[1].pid_list.next) - $pid_off)
> while ($next_th != $next_t)
> set $next_th=(struct task_struct *)$next_th
> printf "\n%s:\n", $next_th.comm
> printf "PID = %d\n", $next_th.pid
> printf "Stack dump:\n"
> x/40x $next_th.thread.esp
> set $next_th=(((char *)$next_th->pids[1].pid_list.next) - $pid_off)
> end
> set $next_t=(char *)($next_t->tasks.next) - $tasks_off
> end

When looking at this I thought of what information we want to save in
the ELF header to be examined after a crash. I'm currently working on
some patches to save all threads in the kernel down into the PT_NOTE
section. But do we really need this if we instead have a suite of gdb
scripts and other user-space analyzers that can find the requested
information?

This would simplify aspects such as not having to fiddle with the crash
ELF header in the kernel. I can't see a gain in dumping a bunch of
NT_PRSTATUS or NT_TASKSTRUCT in the notes section if we can find the
same information in gdb/user-space after a crash-dump.

We should be able to get get (symbol) backtraces from each task with
some gdb scripts too, so I think most analyzis can be done from
user-space. Am I missing something?

All tasks running on a cpu should be saved into NT_PRSTATUS notes
ofcourse, as they are currently. The have a (very) useful pt_regs plus
some other information such as trap number causing the panic or the
address of where the fault occured.

