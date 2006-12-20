Return-Path: <linux-kernel-owner+w=401wt.eu-S964894AbWLTHKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbWLTHKU (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 02:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964898AbWLTHKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 02:10:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:50576 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964894AbWLTHKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 02:10:19 -0500
X-Authenticated: #14349625
Subject: Re: problem with signal delivery SIGCHLD
From: Mike Galbraith <efault@gmx.de>
To: Nicholas Mc Guire <der.herr@hofr.at>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.60.0612181924470.2560@rtl14.hofr.at>
References: <Pine.LNX.4.60.0612181924470.2560@rtl14.hofr.at>
Content-Type: text/plain
Date: Wed, 20 Dec 2006 08:10:15 +0100
Message-Id: <1166598615.1614.55.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-18 at 20:05 +0100, Nicholas Mc Guire wrote:
> 
> Hi !
> 
>   I have a phenomena that I don't quite understand. gdbserver forks and 
> after setting ptrace (PTRACE_TRACEME, 0, 0, 0); it then execv 
> (program, allargs); when this child process hits ptrace_stoped (breakpoint
> it does the following in kernel space:
> 
> pid 1242 = child process
> pid 1241 = gdbserver
> pid 0    = kernel
> pid -1   = interrupt
>                                      pid
>           1        559          5    1242 ptrace_stop
>           3          6          2    1242 |  do_notify_parent_cldstop
>           4          3          2    1242 |  |  __group_send_sig_info
>           5          1          1    1242 |  |  |  handle_stop_signal
>           7          0          0    1242 |  |  |  sig_ignored
>           8          1          0    1242 |  |  __wake_up_sync
>           8          1          1    1242 |  |  |  __wake_up_common
>          10        547        541    1242 |  schedule
>          10          2          2    1242 |  |  profile_hit
>          13          1          1    1242 |  |  sched_clock
>          15          1          0    1242 |  |  deactivate_task
>          15          1          1    1242 |  |  |  dequeue_task
>          19          2          2       0 |  |  __switch_to
> ----------- !!!! start --------------
>          24        574        574       0 default_idle
> ----------- $$$$ end ----------------
> ----------- //// start --------------
>         780         41         12       0 do_IRQ
>         780         29          2      -1 /  __do_IRQ
>         ...
>         807          2          2      -1 /  /  /  enable_8259A_irq
> ----------- //// end ----------------
> ----------- {{{{ start --------------
>         810         11          0       0 do_softirq
>         ...
>         820          0          0      -1 {  {  {  preempt_schedule
> ----------- {{{{ end ----------------
> ----------- %%%% start --------------
>         822        358          1       0 preempt_schedule_irq
>         ...
>         827          1          1    1241 %  %  __switch_to
> ----------- %%%% end ----------------
>         829          1          1    1241 (  (  (  del_timer
> ----------- (((( end ----------------
> ----------- ]]]] start --------------
>         837          8          2    1241 sys_waitpid
> 
> So basically child signals -> delayed to next tick -> parent wakes up.

Hm.  What does the trace of gdbserver look like prior to the clild doing
do_notify_parent_cldstop()?  Sleeping someplace other than wait4?

	-Mike

