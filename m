Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272415AbRIVW3i>; Sat, 22 Sep 2001 18:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272417AbRIVW33>; Sat, 22 Sep 2001 18:29:29 -0400
Received: from jalon.able.es ([212.97.163.2]:49110 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S272415AbRIVW3X>;
	Sat, 22 Sep 2001 18:29:23 -0400
Date: Sun, 23 Sep 2001 00:29:41 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: PTRACE_SINGLESTEP x86 vs alpha
Message-ID: <20010923002941.A8177@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.2.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyrone.

I'm trying to solve rejects when applying bproc-3.0.1 (designed for 2.4.7)
to 2.4.10-pre14. Everything is solved but this.

In arch/[i386,alpha]/kernel/ptrace.c:sys_ptrace,
code looks a bit different between i386 and alpha:

x86:
    case PTRACE_SINGLESTEP: {  /* set the trap flag. */
        long tmp;

        ret = -EIO;
        if ((unsigned long) data > _NSIG)
            break;
        child->ptrace &= ~PT_TRACESYS;
        if ((child->ptrace & PT_DTRACE) == 0) {
            /* Spurious delayed TF traps may occur */
            child->ptrace |= PT_DTRACE;
        }
        tmp = get_stack_long(child, EFL_OFFSET) | TRAP_FLAG;
        put_stack_long(child, EFL_OFFSET, tmp);
        child->exit_code = data;
        /* give it a chance to run. */
        wake_up_process(child);
        ret = 0;
        break;
    }

alpha:
    case PTRACE_SINGLESTEP:  /* execute single instruction. */
        ret = -EIO;
        if ((unsigned long) data > _NSIG)
            goto out;
        child->thread.bpt_nsaved = -1;  /* mark single-stepping */
        child->ptrace &= ~PT_TRACESYS;
        wake_up_process(child);          <==========0
        child->exit_code = data;         <==========0 different
												order than x86
        /* give it a chance to run. */
        ret = 0;
        goto out;                        <==========0 so bad are
										breaks in alpha gcc ??

Is it safe to reorder wake_up_process(child) and put it just before the goto ?

TIA

--
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.1 (Cooker) for i586
Linux werewolf 2.4.10-pre14 #1 SMP Sat Sep 22 11:04:31 CEST 2001 i686
