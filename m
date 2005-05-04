Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbVEDTCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbVEDTCo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 15:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbVEDTCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 15:02:44 -0400
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35]:50499 "EHLO
	dgate1.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S261362AbVEDTCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 15:02:38 -0400
X-SBRSScore: None
X-IronPort-AV: i="3.92,154,1112565600"; 
   d="scan'208"; a="8665704:sNHT28449244"
Message-ID: <42791C49.7010206@fujitsu-siemens.com>
Date: Wed, 04 May 2005 21:02:33 +0200
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
CC: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: Again: UML on s390 (31Bit)
References: <20050504160437.GA573@mschwid3.boeblingen.de.ibm.com>
In-Reply-To: <20050504160437.GA573@mschwid3.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky wrote:
> I talked with Uli about the problem and we came up with a more
> elegant solution. We already have a debugger specific code in
> do_signal that sets up the registers for system call restarting
> BEFORE calling the debugger. Only if the debugger did not change
> the restart psw and the return value still indicates 
> -ERESTARTNOHAND or -ERESTARTSYS we undo this change. In the case
> that the debugger did change the psw or the return value we do
> not want to restart a system call if another signal is pending.
> This is in fact a bug in the signal delivery code. To fix it we
> have to set regs->traps to something != __LC_SVC_OLD_PSW while
> the debugger has control. regs->traps is reset to the value
> indicating a system call if the system call is not restarted
> after all.
> 
> Will that make UML happy?
Unfortunately, I guess this will not help. But maybe I'm missing
something, as I don't even understand, what the effect of the
attached patch should be. AFAICS, after each call to do_signal(),
entry.S will return to user without regs->trap being checked again.
do_signal() is the only place, where regs->trap is checked, and
it will be called on return to user exactly once.

What does UML need? It needs a way to prohibit host's do_signal()
from doing *any* changes in regs->psw or regs->gprs[2], no matter
if the kernel was entered by a syscall or what value is in gprs[2].

You know, the problem is a sigreturn syscall done by a process
that runs inside of UML. UML intercepts the syscall and executes
its own sys_(rt_)sigreturn. At the second syscall interception it
restores the registers to the values that were saved in
sigcontext. Maybe, regs->gprs[2] now is -ERESTARTXXXXX. Next, UML
resumes the process with ptrace(PTRACE_SYSCALL).
UML can't know, whether the host will or will not call do_signal().
Whether a signal is pending or not in most cases isn't related to
the syscall.
So a practical solution should allow to reset regs->trap while the
child is on the first or second syscall interception.
This could be "PTRACE_SETTRAP" or the "magic syscall number".
The latter I would prefer.

BTW:
There would be a very nasty way to work around all this. At the
second syscall interception UML could write a "safe" dummy value
(e.g. 0) as the result of sys_(rt_)sigreturn to regs->gprs[2].
Then, it could send an additional signal to the child, to make
sure, that do_signal *will* be called by the host. Next, it
resumes the child with ptrace(PTRACE_SYSCALL) and waits for the
interception of signal delivery. Now it writes the *real* result
and resumes the child while suppressing delivery of the additional
signal.
Other signals might be pending at the same time and might be
intercepted before the additional one. They need to be suppressed
also, but have to be send again, after the additional one was
nullified. This really is nasty and slow, but would not need any
change in host.
I hope, I will not have to use it ;-)

Regards,
    Bodo
> 
> blue skies,
>   Martin.
> 
> ---
> 
> Index: arch/s390/kernel/signal.c
> ===================================================================
> RCS file: /home/cvs/linux-2.5/arch/s390/kernel/signal.c,v
> retrieving revision 1.22
> diff -u -p -r1.22 signal.c
> --- arch/s390/kernel/signal.c	23 Mar 2005 08:30:01 -0000	1.22
> +++ arch/s390/kernel/signal.c	4 May 2005 14:51:31 -0000
> @@ -482,6 +482,7 @@ int do_signal(struct pt_regs *regs, sigs
>  		} else if (retval == -ERESTART_RESTARTBLOCK) {
>  			regs->gprs[2] = -EINTR;
>  		}
> +		regs->trap = -1;
>  	}
>  
>  	/* Get signal to deliver.  When running under ptrace, at this point
> @@ -497,6 +498,7 @@ int do_signal(struct pt_regs *regs, sigs
>  			      & SA_RESTART))) {
>  			regs->gprs[2] = -EINTR;
>  			regs->psw.addr = continue_addr;
> +			regs->trap = __LC_SVC_OLD_PSW;
>  		}
>  	}
>  
