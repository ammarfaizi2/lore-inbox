Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290836AbSARVbb>; Fri, 18 Jan 2002 16:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290837AbSARVbY>; Fri, 18 Jan 2002 16:31:24 -0500
Received: from smtp2.vol.cz ([195.250.128.42]:33288 "EHLO smtp2.vol.cz")
	by vger.kernel.org with ESMTP id <S290836AbSARVbI>;
	Fri, 18 Jan 2002 16:31:08 -0500
Date: Fri, 18 Jan 2002 22:08:26 +0100
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: 2.4.17: sys_sigsuspend does not return value
Message-ID: <20020118210825.GA6175@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>From 2.4.17:

asmlinkage int
sys_sigsuspend(int history0, int history1, old_sigset_t mask)
{
        struct pt_regs * regs = (struct pt_regs *) &history0;
        sigset_t saveset;

        mask &= _BLOCKABLE;
        spin_lock_irq(&current->sigmask_lock);
        saveset = current->blocked;
        siginitset(&current->blocked, mask);
        recalc_sigpending(current);
        spin_unlock_irq(&current->sigmask_lock);

        regs->eax = -EINTR;
        while (1) {
                current->state = TASK_INTERRUPTIBLE;
                schedule();
                if (do_signal(regs, &saveset))
                        return -EINTR;
        }
}

...Which looks to me like it returns something undefined when
do_signal returns 0. What prevents gcc from having "top secret" value
in eax, and from returning that value to userspace?
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
