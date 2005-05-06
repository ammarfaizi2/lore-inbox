Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbVEFNEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbVEFNEx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 09:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVEFNEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 09:04:53 -0400
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35]:33671 "EHLO
	dgate1.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S261220AbVEFNEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 09:04:49 -0400
X-SBRSScore: None
X-IronPort-AV: i="3.92,160,1112565600"; 
   d="scan'208"; a="8801796:sNHT29884680"
Message-ID: <427B6B6D.5080609@fujitsu-siemens.com>
Date: Fri, 06 May 2005 15:04:45 +0200
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ulrich Weigand <uweigand@de.ibm.com>
CC: schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Again: UML on s390 (31Bit)
References: <200505042133.j44LX8Xk010820@53v30g15.boeblingen.de.ibm.com>
In-Reply-To: <200505042133.j44LX8Xk010820@53v30g15.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Weigand wrote:
> Bodo Stroesser wrote:
> 
> 
>>Unfortunately, I guess this will not help. But maybe I'm missing
>>something, as I don't even understand, what the effect of the
>>attached patch should be.
> 
> Have you tried it?
> 
> 
>>AFAICS, after each call to do_signal(),
>>entry.S will return to user without regs->trap being checked again.
>>do_signal() is the only place, where regs->trap is checked, and
>>it will be called on return to user exactly once.
> 
> It will be called multiple times if *multiple* signals are pending,
> and this is exactly the situation in your problem case (some other
> signal is pending after the ptrace intercept SIGTRAP was delievered).
No, that's not the situation, we talk about.

UML runs its child with ptrace(PTRACE_SYSCALL).
The syscall-interceptions do not use *real* signals. Instead, before
and after it calls the syscall-handler, entry.S calls syscall_trace(),
which again uses ptrace_notify() to inform the father.
The father will see an event similar to the child receiving SIGTRAP or
(SIGTRAP|0x80), but there will be no signal queued and do_signal() will
not be called.

UML does all changes to its child on these two interceptions. It reads
syscall-number and register contents from the first syscall-interception,
writes a dummy number to the syscall-number, restarts the child with
ptrace(PTRACE_SYSCALL) and waits until the second interception for the
syscall happens. Next it internally executes its syscall-handler for the
original syscall-number and writes the resulting register contents to
the child. Now syscall-handling in UML is finished and the child is
resumed with ptrace(PTRACE_SYSCALL). Host's do_signal() is not called
while doing all this.

UML does not know, whether a signal is pending or not. It would not
even help, if there would be a way to retrieve this information. A
signal still could come in between retrieving the info and the child
being scheduled after ptrace(PTRACE_SYSCALL).

If there is a signal pending for the child, entry.S now jumps to
sysc_return, which again jumps to sysc_work, which calls do_signal()
exactly once. As trap still indicates a syscall, do_signal() possibly
modifies psw and gpr2, which makes UML fail.

The signal is not related to the syscall. UML does not know, if it is
delivered while returning from syscall, with do_signal() changing
registers, or later, without changes from do_signal(). So UML can't
undo the changes done by do_signal().

To UML the signal is an interrupt, and normally when returning from
interrupt it doesn't want to modify child's psw or gprs. So UML
normally does not modify psw or gprs on signal interceptions.

Having said all this, unfortunately I don't see a way to satisfy UML's
need with the current host implementation.

Regards,
Bodo
> 
> 
>>So a practical solution should allow to reset regs->trap while the
>>child is on the first or second syscall interception.
> 
> This is exactly what this patch is supposed to do: whenever during
> a ptrace intercept the PSW is changed (as it presumably is by your
> sigreturn implementation), regs->trap is automatically reset.
> 
> Bye,
> Ulrich
> 
