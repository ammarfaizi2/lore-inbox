Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261780AbVBXCip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbVBXCip (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 21:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbVBXChx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 21:37:53 -0500
Received: from fire.osdl.org ([65.172.181.4]:39327 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261766AbVBXCgx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 21:36:53 -0500
Date: Wed, 23 Feb 2005 18:36:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Chad N. Tindel" <chad@tindel.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Xterm Hangs - Possible scheduler defect?
Message-Id: <20050223183634.31869fa6.akpm@osdl.org>
In-Reply-To: <20050223230639.GA33795@calma.pair.com>
References: <20050223230639.GA33795@calma.pair.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Chad N. Tindel" <chad@tindel.net> wrote:
>
>  We have hit a defect where an exiting xterm process will hang.  This is running
>  on a 2-cpu IA-64 box.  We have a multithreaded application, where one thread
>  is SCHED_FIFO and is running with priority 98, and the other thread is just
>  a normal SCHED_OTHER thread.  The SCHED_FIFO thread is in a CPU bound tight
>  loop, but I wouldn't expect that to cause since there are 2 CPUs.  
> 
>  However, it does seem to cause some problems.  For example, if you ssh into
>  the system and run an Xterm using X11 forwarding, when you type "exit" in
>  the xterm window, the window hangs and doesn't close.  Killing the CPU-bound
>  app causes the window to exit immediately.  The sysrq output shows the 
>  following:
> 
>  xterm         D a0000001000bef60     0  2905   2876                     (NOTLB)
> 
>  Call Trace:
>   [<a0000001004ac480>] schedule+0xca0/0x1300
>                                  sp=e000000012257d20 bsp=e000000012251080
>   [<a0000001000bef60>] flush_cpu_workqueue+0x1a0/0x4a0
>                                  sp=e000000012257d30 bsp=e000000012251020
>   [<a0000001000bf360>] flush_workqueue+0x100/0x160
>                                  sp=e000000012257d90 bsp=e000000012250fe8
>   [<a0000001000bfd60>] flush_scheduled_work+0x20/0x40
>                                  sp=e000000012257d90 bsp=e000000012250fd0
>   [<a0000001002e2060>] release_dev+0x8e0/0x1100
>                                  sp=e000000012257d90 bsp=e000000012250f20
>   [<a0000001002e3350>] tty_release+0x30/0x60
>                                  sp=e000000012257e30 bsp=e000000012250ef8
>   [<a00000010012d430>] __fput+0x330/0x340
>                                  sp=e000000012257e30 bsp=e000000012250ea8
>   [<a00000010012d0e0>] fput+0x40/0x60
>                                  sp=e000000012257e30 bsp=e000000012250e88
>   [<a00000010012a1b0>] filp_close+0xd0/0x160
>                                  sp=e000000012257e30 bsp=e000000012250e58
>   [<a00000010012a380>] sys_close+0x140/0x1a0
>                                  sp=e000000012257e30 bsp=e000000012250dd8
>   [<a00000010000aba0>] ia64_ret_from_syscall+0x0/0x20
>                                  sp=e000000012257e30 bsp=e000000012250dd8
> 
>  So it would appear that xterm is hung in close() trying to shutdown a tty.
>  The comment says that is calling flush_scheduled_work() to 
>  "Wait for ->hangup_work and ->flip.work handlers to terminate".  Perhaps there
>  is some locking issue that is causing these to not run and complete?

`xterm' is waiting for the other CPU to schedule a kernel thread (which is
bound to that CPU).  Once that kernel thread has done a little bit of work,
`xterm' can terminate.

But kernel threads don't run with realtime policy, so your userspace app
has permanently starved that kernel thread.

It's potentially quite a problem, really.  For example it could prevent
various tty operations from completing, it will prevent kjournald from ever
writing back anything (on uniprocessor, etc).  I've been waiting for
someone to complain ;)

But the other side of the coin is that a SCHED_FIFO userspace task
presumably has extreme latency requirements, so it doesn't *want* to be
preempted by some routine kernel operation.  People would get irritated if
we were to do that.

So what to do?
