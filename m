Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263786AbTCVUG6>; Sat, 22 Mar 2003 15:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263787AbTCVUG6>; Sat, 22 Mar 2003 15:06:58 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:26502 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S263786AbTCVUG5>;
	Sat, 22 Mar 2003 15:06:57 -0500
Message-ID: <3E7CC4F2.8000500@colorfullife.com>
Date: Sat, 22 Mar 2003 21:17:54 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@holomorphy.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUG: Use after free in detach_pid
References: <Pine.LNX.4.50.0303221152460.18911-100000@montezuma.mastecende.com>
In-Reply-To: <Pine.LNX.4.50.0303221152460.18911-100000@montezuma.mastecende.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:

>Process bash (pid: 1292, threadinfo=caaa2000 task=cbb02560)
>Call Trace:
> [<c01232ec>] __unhash_process+0x10c/0x170
> [<c01233dc>] release_task+0x8c/0x200
> [<c01251cb>] wait_task_zombie+0x15b/0x1c0
> [<c0125681>] sys_wait4+0x241/0x290
> [<c011cb10>] default_wake_function+0x0/0x20
> [<c011cb10>] default_wake_function+0x0/0x20
> [<c0109477>] syscall_call+0x7/0xb
>
>Code: 89 01 89 48 04 f0 ff 4b 04 0f 94 c0 31 f6 84 c0 74 1f 8b 43 
>
>  
>
   0:   89 01                     mov    %eax,(%ecx)
   2:   89 48 04                  mov    %ecx,0x4(%eax)
	list_del(&link->pid_chain):
		link->pid_chain->next, prev == 0x6b6b6b6b 
   5:   f0 ff 4b 04               lock decl 0x4(%ebx)
		%ebx: link->pidptr == 0x6b6b6b6b


The whole link structure is filled with slab poison. The link structure is embedded in the task struct stucture.
You mentioned that the last detach_pid() within __unhash_process oopsed. That means the reference count of the task structure was off by one, and the
	put_task_struct(pid->task)
within 
	detach_pid(p,PIDTYPE_PGID);
freed the task structure.

The process was bash - does your bash use anything fancy, or plain boring single threaded app?

--
	Manfred


