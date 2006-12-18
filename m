Return-Path: <linux-kernel-owner+w=401wt.eu-S1754546AbWLRUef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754546AbWLRUef (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 15:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754553AbWLRUef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 15:34:35 -0500
Received: from [194.112.174.227] ([194.112.174.227]:33851 "EHLO mail.hofr.at"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754546AbWLRUee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 15:34:34 -0500
X-Greylist: delayed 1976 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Dec 2006 15:34:33 EST
Date: Mon, 18 Dec 2006 20:05:35 +0100 (CET)
From: Nicholas Mc Guire <der.herr@hofr.at>
To: linux-kernel@vger.kernel.org
Subject: problem with signal delivery SIGCHLD
Message-ID: <Pine.LNX.4.60.0612181924470.2560@rtl14.hofr.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi !

  I have a phenomena that I don't quite understand. gdbserver forks and 
after setting ptrace (PTRACE_TRACEME, 0, 0, 0); it then execv 
(program, allargs); when this child process hits ptrace_stoped (breakpoint
it does the following in kernel space:

pid 1242 = child process
pid 1241 = gdbserver
pid 0    = kernel
pid -1   = interrupt
                                     pid
          1        559          5    1242 ptrace_stop
          3          6          2    1242 |  do_notify_parent_cldstop
          4          3          2    1242 |  |  __group_send_sig_info
          5          1          1    1242 |  |  |  handle_stop_signal
          7          0          0    1242 |  |  |  sig_ignored
          8          1          0    1242 |  |  __wake_up_sync
          8          1          1    1242 |  |  |  __wake_up_common
         10        547        541    1242 |  schedule
         10          2          2    1242 |  |  profile_hit
         13          1          1    1242 |  |  sched_clock
         15          1          0    1242 |  |  deactivate_task
         15          1          1    1242 |  |  |  dequeue_task
         19          2          2       0 |  |  __switch_to
----------- !!!! start --------------
         24        574        574       0 default_idle
----------- $$$$ end ----------------
----------- //// start --------------
        780         41         12       0 do_IRQ
        780         29          2      -1 /  __do_IRQ
        ...
        807          2          2      -1 /  /  /  enable_8259A_irq
----------- //// end ----------------
----------- {{{{ start --------------
        810         11          0       0 do_softirq
        ...
        820          0          0      -1 {  {  {  preempt_schedule
----------- {{{{ end ----------------
----------- %%%% start --------------
        822        358          1       0 preempt_schedule_irq
        ...
        827          1          1    1241 %  %  __switch_to
----------- %%%% end ----------------
        829          1          1    1241 (  (  (  del_timer
----------- (((( end ----------------
----------- ]]]] start --------------
        837          8          2    1241 sys_waitpid

So basically child signals -> delayed to next tick -> parent wakes up.

  now what I don't understand is why does it not schedule the parent ? in
fact the traces show that on an idle system the parent will not be 
scheduled until the next tick.

  I don't want to post the full traces as they are very lengthy - but if 
someone could point me in what direction to search to find out why this 
delay between the child process signaling and the parent breaking out of 
waitpid it would be helpfull - the background is that we implemented GDB 
tracepoints but they only work properly on highly loaded systems (the 
parent gets scheduled fast then and the tracepoint is processed "fast"
but on an idle system it is simply not usabel as you get almost 
deterministic 10ms between the child process signaling and the parent 
waking up...

  Is this delay on sigchild expected behavior ?

  any ideas ?

thx !
hofrat

ps.: if anybody is intersted in the detailed logs see
      http://dslab.lzu.edu.cn/~hofrat/sigchld_problem.html
