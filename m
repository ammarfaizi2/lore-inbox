Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263100AbUFSOfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263100AbUFSOfh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 10:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263540AbUFSOfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 10:35:37 -0400
Received: from [213.196.40.106] ([213.196.40.106]:31705 "EHLO
	eljakim.netsystem.nl") by vger.kernel.org with ESMTP
	id S263100AbUFSOfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 10:35:31 -0400
Date: Sat, 19 Jun 2004 16:35:29 +0200 (CEST)
From: Joris van Rantwijk <joris@eljakim.nl>
X-X-Sender: joris@eljakim.netsystem.nl
To: linux-kernel@vger.kernel.org
Subject: 2.6.7 Oops in signal handling with ptrace
Message-ID: <Pine.LNX.4.58.0406191611450.12748@eljakim.netsystem.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Linux 2.6.7 (and 2.6.6) gives an Oops in specific situations
related to signal handling and ptracing. The Oops is triggered when
a process which is being ptraced with TRACESYSGOOD, receives signals
in a very specific pattern. This Oops is perfectly reproducable.

Could someone help me fix this ?
I think I finally understand the cause now, so I will try to explain.
The main issue is that the kernel tries to send a signal with
signr>_NSIG, thereby messing up the task_struct.

arch/i386/kernel/ptrace.c, line 538:
---
  if (!test_thread_flag(TIF_SYSCALL_TRACE))
          return;
  if (!(current->ptrace & PT_PTRACED))
          return;
  /* the 0x80 provides a way for the tracing parent to distinguish
     between a syscall stop and SIGTRAP delivery */
  ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
                           ? 0x80 : 0));

  /*
   * this isn't the same as continuing with a signal, but it will do
   * for normal use.  strace only continues with a signal if the
   * stopping signal is not SIGTRAP.  -brl
   */
  if (current->exit_code) {
          send_sig(current->exit_code, current, 1);
          current->exit_code = 0;
  }
---

Right after the ptrace_notify(), current->exit_code could be >_NSIG.
In most cases, any nonzero exit_code was put there explicitly by the
ptracing parent through ptrace(PTRACE_CONT, ...), so the signal number
has been checked by the ptrace system call before putting it in
exit_code. However, it is posible that the ptracing parent has not even
seen the child at this point.

In my case, the sequence of events is as follows:
- Child enters/exits system call, sets exit_code=(SIGTRAP|0x80)
  and notifies its ptracing parent.
- Parent is busy with other stuff (in my case it is TASK_STOPPED).
- Someone else explicitly sends SIGCONT to child process.
- Child process is continued.
  At this point exit_code==(SIGTRAP|0x80) still holds, so it sends
  an out-of-range signal to itself.
- send_sig() and its helpers don't check the signal number.
  They used to do this in 2.4.x, but they don't do it now.
  Eventually send_signal() does sigaddset() to raise a bit in
  current->pending, but accidentally writes into current->notifier
  and messes up the task_struct integrity.
- Child process tries to handle the next signal.
  __dequeue_signal() is confused by current->notifier and dereferences
  the invalid pointer current->notifier_mask. Oops!

I believe the bug is that the kernel assumes that current->exit_code is
a valid signal number. My patch below helps to prevent the oops, but
I'm not sure if this is the best way to solve it. Other arch's
probably need the same sort of fix. Alternatively, we could restore
the check on signal number in send_sig_info() like 2.4.x used to do.

You can also say that the problem lies in the fact that an external
SIGCONT can continue a process that was still waiting for inspection by
its ptracing parent. Besides the oops, this is unfortunate when you're
trying to do funky stuff with ptrace(), because it desynchronizes the
interaction between child and ptracing parent.
Perhaps it is not really a bug, rather an inconvenience in the way
that ptrace() and signal handling are knotted together.

Bye,
  Joris.

Possible patch:
--- linux-2.6.7/arch/i386/kernel/ptrace.c.orig	Sat Jun 19 12:12:19 2004
+++ linux-2.6.7/arch/i386/kernel/ptrace.c	Sat Jun 19 12:11:55 2004
@@ -548,9 +548,12 @@
 	 * this isn't the same as continuing with a signal, but it will do
 	 * for normal use.  strace only continues with a signal if the
 	 * stopping signal is not SIGTRAP.  -brl
 	 */
 	if (current->exit_code) {
-		send_sig(current->exit_code, current, 1);
+		int signr = current->exit_code;
 		current->exit_code = 0;
+		if (signr < 0 || signr > _NSIG)
+			signr = SIGTRAP;
+		send_sig(signr, current, 1);
 	}
 }
---

Oops:
---
 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
c012017a
*pde = 00000000
Oops: 0000 [#8]
CPU:    0
EIP:    0060:[<c012017a>]    Not tainted
EFLAGS: 00010002   (2.6.7)
eax: 00000000   ebx: c3d04000   ecx: 00000000   edx: c416e780
esi: 00000001   edi: c3d05f34   ebp: c660b5c8   esp: c3d05eb8
ds: 007b   es: 007b   ss: 0068
Stack: 00000000 c3d05f34 c416eca4 c416e780 00000000 00000011 c01202c8 c660b5c8
       c416eca4 c3d05f34 c3d05f34 c3d04000 c3d04000 c3d05f34 c01214d5 c416e780
       c416eca4 c3d05f34 c3d05f34 c3d05fc4 c416eca4 c3d04000 c416eca4 c01058ba
 [<c01202c8>] dequeue_signal+0x38/0x68
 [<c01214d5>] get_signal_to_deliver+0x8d/0x298
 [<c01058ba>] do_signal+0x56/0xc4
 [<c01205a3>] send_signal+0x37/0x114
 [<c01206ea>] specific_send_sig_info+0x6a/0xa0
 [<c0120d80>] send_sig_info+0x18/0x20
 [<c0120da5>] send_sig+0x1d/0x24
 [<c010a461>] do_syscall_trace+0x55/0x64
 [<c0105955>] do_notify_resume+0x2d/0x48
 [<c0105b4e>] work_notifysig+0x13/0x15
Code: 0f a3 08 19 c0 85 c0 74 2d 8b 82 50 05 00 00 50 8b 82 4c 05


>>EIP; c012017a <__dequeue_signal+4a/160>   <=====

>>ebx; c3d04000 <pg0+391e000/3fc18000>
>>edx; c416e780 <pg0+3d88780/3fc18000>
>>edi; c3d05f34 <pg0+391ff34/3fc18000>
>>ebp; c660b5c8 <pg0+62255c8/3fc18000>
>>esp; c3d05eb8 <pg0+391feb8/3fc18000>

Code;  c012017a <__dequeue_signal+4a/160>
00000000 <_EIP>:
Code;  c012017a <__dequeue_signal+4a/160>   <=====
   0:   0f a3 08                  bt     %ecx,(%eax)   <=====
Code;  c012017d <__dequeue_signal+4d/160>
   3:   19 c0                     sbb    %eax,%eax
Code;  c012017f <__dequeue_signal+4f/160>
   5:   85 c0                     test   %eax,%eax
Code;  c0120181 <__dequeue_signal+51/160>
   7:   74 2d                     je     36 <_EIP+0x36> c01201b0 <__dequeue_signal+80/160>
Code;  c0120183 <__dequeue_signal+53/160>
   9:   8b 82 50 05 00 00         mov    0x550(%edx),%eax
Code;  c0120189 <__dequeue_signal+59/160>
   f:   50                        push   %eax
Code;  c012018a <__dequeue_signal+5a/160>
  10:   8b 82 4c 05 00 00         mov    0x54c(%edx),%eax
---
