Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263842AbTCVTgQ>; Sat, 22 Mar 2003 14:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263846AbTCVTgQ>; Sat, 22 Mar 2003 14:36:16 -0500
Received: from csl.Stanford.EDU ([171.64.73.43]:43201 "EHLO csl.stanford.edu")
	by vger.kernel.org with ESMTP id <S263842AbTCVTgO>;
	Sat, 22 Mar 2003 14:36:14 -0500
From: Dawson Engler <engler@csl.stanford.edu>
Message-Id: <200303221947.h2MJlHA24028@csl.stanford.edu>
Subject: [CHECKER] race in 2.5.62/kernel/ptrace.c?
To: linux-kernel@vger.kernel.org
Date: Sat, 22 Mar 2003 11:47:17 -0800 (PST)
Cc: engler@csl.stanford.edu (Dawson Engler)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is the following unlocked use of recalc_sigpending  a race?

// 2.5.62/kernel/ptrace.c:339:ptrace_notify:
void ptrace_notify(int exit_code)
{
        BUG_ON (!(current->ptrace & PT_PTRACED));

        /* Let the debugger run.  */
        current->exit_code = exit_code;
        set_current_state(TASK_STOPPED);
        notify_parent(current, SIGCHLD);
        schedule();

        /*
         * Signals sent while we were stopped might set TIF_SIGPENDING.
         */
        recalc_sigpending();
}


It seems that recalc_sigpending needs to be protected by 
	&current->sighand->siglock

E.g.,:

2.5.62/kernel/signal.c:1656:sigprocmask:
        recalc_sigpending();
        spin_unlock_irq(&current->sighand->siglock);

2.5.62/kernel/signal.c:2115:sys_sigprocmas

                spin_lock_irq(&current->sighand->siglock);
                old_set = current->blocked.sig[0];

		...

                recalc_sigpending();
                spin_unlock_irq(&current->sighand->siglock);


Or does it not need a lock?  (Or am I missing the lock?)
