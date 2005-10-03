Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbVJCL3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbVJCL3o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 07:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbVJCL3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 07:29:44 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:32772
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S1750763AbVJCL3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 07:29:43 -0400
Date: Mon, 3 Oct 2005 13:29:31 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Roland McGrath <roland@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Gerd Knorr <kraxel@suse.de>
Subject: [PATCH] ptrace/coredump/exit_group deadlock
Message-ID: <20051003112931.GA5209@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I could seldom reproduce a deadlock with a task not killable in T state
(TASK_STOPPED, not TASK_TRACED) by attaching a NPTL threaded program to
gdb, by segfaulting the task and triggering a core dump while some other
task is executing exit_group and while one task is in ptrace_attached
TASK_STOPPED state (not TASK_TRACED yet). This originated from a gdb
bugreport (the fact gdb was segfaulting the task wasn't a kernel bug),
but I just incidentally noticed the gdb bug triggered a real kernel bug
as well.

Most threads hangs in exit_mm because the core_dumping is still going,
the core dumping hangs because the stopped task doesn't exit, the
stopped task can't wakeup because it has SIGNAL_GROUP_EXIT set, hence
the deadlock.

To me it seems that the problem is that the force_sig_specific(SIGKILL)
in zap_threads is a noop if the task has PF_PTRACED set (like in this
case because gdb is attached). The __ptrace_unlink does nothing because
the signal->flags is set to SIGNAL_GROUP_EXIT|SIGNAL_STOP_DEQUEUED
(verified).

The above info also shows that the stopped task hit a race and got the
stop signal (presumably by the ptrace_attach, only the attach, state is
still TASK_STOPPED and gdb hangs waiting the core before it can set it
to TASK_TRACED) after one of the thread invoked the core dump (it's the
core dump that sets signal->flags to SIGNAL_GROUP_EXIT).

So beside the fact nobody would wakeup the task in __ptrace_unlink (the
state is _not_ TASK_TRACED), there's a secondary problem in the signal
handling code, where a task should ignore the ptrace-sigstops as long as
SIGNAL_GROUP_EXIT is set (or the wakeup in __ptrace_unlink path wouldn't
be enough).

So I attempted to make this patch that seems to fix the problem. There
were various ways to fix it, perhaps you prefer a different one, I just
opted to the one that looked safer to me.

I also removed the clearing of the stopped bits from the
zap_other_threads (zap_other_threads was safe unlike zap_threads). I
don't like useless code, this whole NPTL signal/ptrace thing is already
unreadable enough and full of corner cases without confusing useless
code into it to make it even less readable. And if this code is really
needed, then you may want to explain why it's not being done in the
other paths that sets SIGNAL_GROUP_EXIT at least.

Even after this patch I still wonder who serializes the read of
p->ptrace in zap_threads.

Patch is called ptrace-core_dump-exit_group-deadlock-1.

This was the trace I've got:

test          T ffff81003e8118c0     0 14305      1         14311 14309 (NOTLB)
ffff810058ccdde8 0000000000000082 000001f4000037e1 ffff810000000013
       00000000000000f8 ffff81003e811b00 ffff81003e8118c0 ffff810011362100
       0000000000000012 ffff810017ca4180
Call Trace:<ffffffff801317ed>{try_to_wake_up+893} <ffffffff80141677>{finish_stop+87}
       <ffffffff8014367f>{get_signal_to_deliver+1359} <ffffffff8010d3ad>{do_signal+157}
       <ffffffff8013deee>{ptrace_check_attach+222} <ffffffff80111575>{sys_ptrace+2293}
       <ffffffff80131810>{default_wake_function+0} <ffffffff80196399>{sys_ioctl+73}
       <ffffffff8010dd27>{sysret_signal+28} <ffffffff8010e00f>{ptregscall_common+103}

test          D ffff810011362100     0 14309      1         14305 14312 (NOTLB)
ffff810053c81cf8 0000000000000082 0000000000000286 0000000000000001
       0000000000000195 ffff810011362340 ffff810011362100 ffff81002e338040
       ffff810001e0ca80 0000000000000001
Call Trace:<ffffffff801317ed>{try_to_wake_up+893} <ffffffff8044677d>{wait_for_completion+173}
       <ffffffff80131810>{default_wake_function+0} <ffffffff80137435>{exit_mm+149}
       <ffffffff801381af>{do_exit+479} <ffffffff80138d0c>{do_group_exit+252}
       <ffffffff801436db>{get_signal_to_deliver+1451} <ffffffff8010d3ad>{do_signal+157}
       <ffffffff8013deee>{ptrace_check_attach+222} <ffffffff80140850>{specific_send_sig_info+2

       <ffffffff8014208a>{force_sig_info+186} <ffffffff804479a0>{do_int3+112}
       <ffffffff8010e308>{retint_signal+61}
test          D ffff81002e338040     0 14311      1         14716 14305 (NOTLB)
ffff81005ca8dcf8 0000000000000082 0000000000000286 0000000000000001
       0000000000000120 ffff81002e338280 ffff81002e338040 ffff8100481cb740
       ffff810001e0ca80 0000000000000001
Call Trace:<ffffffff801317ed>{try_to_wake_up+893} <ffffffff8044677d>{wait_for_completion+173}
       <ffffffff80131810>{default_wake_function+0} <ffffffff80137435>{exit_mm+149}
       <ffffffff801381af>{do_exit+479} <ffffffff80142d0e>{__dequeue_signal+558}
       <ffffffff80138d0c>{do_group_exit+252} <ffffffff801436db>{get_signal_to_deliver+1451}
       <ffffffff8010d3ad>{do_signal+157} <ffffffff8013deee>{ptrace_check_attach+222}
       <ffffffff80140850>{specific_send_sig_info+208} <ffffffff8014208a>{force_sig_info+186}
       <ffffffff804479a0>{do_int3+112} <ffffffff8010e308>{retint_signal+61}

test          D ffff810017ca4180     0 14312      1         14309 13882 (NOTLB)
ffff81005d15fcb8 0000000000000082 ffff81005d15fc58 ffffffff80130816
       0000000000000897 ffff810017ca43c0 ffff810017ca4180 ffff81003e8118c0
       0000000000000082 ffffffff801317ed
Call Trace:<ffffffff80130816>{activate_task+150} <ffffffff801317ed>{try_to_wake_up+893}
       <ffffffff8044677d>{wait_for_completion+173} <ffffffff80131810>{default_wake_function+0}
       <ffffffff8018cdc3>{do_coredump+819} <ffffffff80445f52>{thread_return+82}
       <ffffffff801436d4>{get_signal_to_deliver+1444} <ffffffff8010d3ad>{do_signal+157}
       <ffffffff8013deee>{ptrace_check_attach+222} <ffffffff80140850>{specific_send_sig_info+2

       <ffffffff804472e5>{_spin_unlock_irqrestore+5} <ffffffff8014208a>{force_sig_info+186}
       <ffffffff804476ff>{do_general_protection+159} <ffffffff8010e308>{retint_signal+61}



Comments welcome, thanks!

Signed-off-by: Andrea Arcangeli <andrea@suse.de>

diff -r 7c862f664e58 kernel/ptrace.c
--- a/kernel/ptrace.c	Sun Oct  2 00:02:13 2005
+++ b/kernel/ptrace.c	Mon Oct  3 03:32:50 2005
@@ -56,6 +56,10 @@
 			signal_wake_up(child, 1);
 		}
 	}
+	if (child->signal->flags & SIGNAL_GROUP_EXIT) {
+		sigaddset(&child->pending.signal, SIGKILL);
+		signal_wake_up(child, 1);
+	}
 	spin_unlock(&child->sighand->siglock);
 }
 
@@ -77,8 +81,7 @@
 		SET_LINKS(child);
 	}
 
-	if (child->state == TASK_TRACED)
-		ptrace_untrace(child);
+	ptrace_untrace(child);
 }
 
 /*
diff -r 7c862f664e58 kernel/signal.c
--- a/kernel/signal.c	Sun Oct  2 00:02:13 2005
+++ b/kernel/signal.c	Mon Oct  3 03:32:50 2005
@@ -1118,8 +1118,8 @@
 		if (t != p->group_leader)
 			t->exit_signal = -1;
 
+		/* SIGKILL will be handled before any pending SIGSTOP */
 		sigaddset(&t->pending.signal, SIGKILL);
-		rm_from_queue(SIG_KERNEL_STOP_MASK, &t->pending);
 		signal_wake_up(t, 1);
 	}
 }
@@ -1856,9 +1856,9 @@
 			/* Let the debugger run.  */
 			ptrace_stop(signr, signr, info);
 
-			/* We're back.  Did the debugger cancel the sig?  */
+			/* We're back.  Did the debugger cancel the sig or group_exit? */
 			signr = current->exit_code;
-			if (signr == 0)
+			if (signr == 0 || current->signal->flags & SIGNAL_GROUP_EXIT)
 				continue;
 
 			current->exit_code = 0;
