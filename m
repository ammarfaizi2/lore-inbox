Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbTFFQwr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 12:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262037AbTFFQwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 12:52:47 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:43493 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262030AbTFFQwi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 12:52:38 -0400
X-Mailer: Lotus Notes Release 5.0.3  March 21, 2000
MIME-Version: 1.0
Subject: PROBLEM: process crashes in kernel on exit()
To: <linux-kernel@vger.kernel.org>
Message-ID: <OFB1DD5016.355DA38A-ON87256D3D.0056DEB2@us.ibm.com>
From: Benny Wilbanks <benny@us.ibm.com>
Date: Fri, 6 Jun 2003 12:11:14 -0500
X-MIMETrack: Serialize by Router on D03NM112/03/M/IBM(Release 6.0.1 [IBM]|May 27, 2003) at
 06/06/2003 11:06:09
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Hi,
 I am having a bit of a problem with a process crashing do
to a kernel assertion. I am running a 2.4.20-9 SMP kernel.
The only difference between my kernel and plain vanilla
kernel is an AIO driver, that I picked from the SGI
Open Source Project and modified for my particular needs.
I suspect that this driver is causing the process utilizing
it to take a kernel control path this is out of the normal
case and thus uncover an existing kernel bug. But, then
again I might be full of beans.

 The problem occurs in this bit of code in the kernel/exit.c
source file:

   void check_tasklist_locked(void)
   {
#if CONFIG_SMP
        if (!rwlock_is_locked(&tasklist_lock))
                BUG();
#endif
   }

The "is not read/write locked" assertion is failing and
causing the process to abort.

Without actually running the kernel in the debugger or
adding kprint statements, I suspect that when this
problem occurs that the call stack looks something like this:


kernel level -> check_tasklist_locked()
             -> next_thread()
             -> exit_notify()
             -> do_exit()
             -> sys_exit()
user level   -> exit()
             -> main()


Now, if you look at the code in exit_notify() that calls next_thread()
(both pieces of code are included below along with the output found in
/var/log/messages after the the problem occurred) you start to wonder
if it should have a write lock on the tasklist_lock when next_thread()
is called. Either that, or you don't need a write lock at all when
finding the next thread. In this case the check in next_thread() is
bogus.

Thanks,
 Benny


Phone: 281-335-4262                                         T/L 260-4262
FAX:      281-335-4231                                         T/L 260-4231
Notes:   benny@us.ibm.com                       IBMUSM52(BENNY)
Email:    benny@clearlake.ibm.com (non-Notes)




from next_thread():

#if CONFIG_SMP
        if (!p->sighand)
                BUG();
        check_tasklist_locked();
#endif
        tmp = link->pid_chain.next;
        if (tmp == head)
                tmp = head->next;


from exit_notify():

        if (signal_pending(tsk) && !tsk->signal->group_exit
            && !thread_group_empty(tsk)) {
                /*
                 * This occurs when there was a race between our exit
                 * syscall and a group signal choosing us as the one to
                 * wake up.  It could be that we are the only thread
                 * alerted to check for pending signals, but another thread
                 * should be woken now to take the signal since we will
not.
                 * Now we'll wake all the threads in the group just to make
                 * sure someone gets all the pending signals.
                 */
                read_lock(&tasklist_lock);
                spin_lock_irq(&tsk->sighand->siglock);
                for (t = next_thread(tsk); t != tsk; t = next_thread(t))
                        if (!signal_pending(t) && !(t->flags & PF_EXITING))
{
                                recalc_sigpending_tsk(t);
                                if (signal_pending(t))
                                        signal_wake_up(t, 0);
                        }
                spin_unlock_irq(&tsk->sighand->siglock);
                read_unlock(&tasklist_lock);
        }

        write_lock_irq(&tasklist_lock);


from /var/log/messages:

May 29 15:33:09 ga703 kernel: ------------[ cut here ]------------
May 29 15:33:09 ga703 kernel: kernel BUG at exit.c:744!
May 29 15:33:09 ga703 kernel: invalid operand: 0000
May 29 15:33:09 ga703 kernel: CPU:    0
May 29 15:33:09 ga703 kernel: EIP:    0060:[<c0121a2c>]    Not tainted
May 29 15:33:09 ga703 kernel: EFLAGS: 00010246
May 29 15:33:09 ga703 kernel:
May 29 15:33:09 ga703 kernel: EIP is at  (2.4.20-9kaio)
May 29 15:33:09 ga703 kernel: eax: 01000000   ebx: f7884900   ecx: 00000000
edx: f7884930
May 29 15:33:09 ga703 kernel: esi: f528a000   edi: c02aa000   ebp: 00000000
esp: f528bf8c
May 29 15:33:09 ga703 kernel: ds: 0068   es: 0068   ss: 0068
May 29 15:33:09 ga703 kernel: Process hpss_mvr_tcp (pid: 1563,
stackpage=f528b000)
May 29 15:33:09 ga703 kernel: Stack: c0134fc6 c015636e f528a000 00000000
00000000 c014ba03 f528a000 f528a000
May 29 15:33:09 ga703 kernel:        00000004 f528a000 00000000 00000000
bfffca18 c0109033 00000007 080b153c
May 29 15:33:09 ga703 kernel:        00000000 00000000 00000000 bfffca18
000000fe 0000002b 0000002b 000000fe
May 29 15:33:09 ga703 kernel: Call Trace:   [<c0134fc6>]  (0xf528bf8c))
May 29 15:33:09 ga703 kernel: [<c015636e>]  (0xf528bf90))
May 29 15:33:09 ga703 kernel: [<c014ba03>]  (0xf528bfa0))
May 29 15:33:09 ga703 kernel: [<c0109033>]  (0xf528bfc0))
May 29 15:33:09 ga703 kernel:
May 29 15:33:09 ga703 kernel:
May 29 15:33:09 ga703 kernel: Code: 0f 0b e8 02 c8 7b 23 c0 c3 8d 74 26 00
8d bc 27 00 00 00 00



