Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262216AbVD1Svm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262216AbVD1Svm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 14:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbVD1Svl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 14:51:41 -0400
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35]:18443 "EHLO
	dgate1.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S262225AbVD1Sus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 14:50:48 -0400
X-SBRSScore: None
X-IronPort-AV: i="3.92,136,1112565600"; 
   d="scan'208"; a="8311155:sNHT25009284"
Message-ID: <42713084.7070403@fujitsu-siemens.com>
Date: Thu, 28 Apr 2005 20:50:44 +0200
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
CC: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux devel 
	<user-mode-linux-devel@lists.sourceforge.net>
Subject: Re: Again: UML on s390 (31Bit)
References: <OF39B8E361.04396517-ONC1256FF1.004C000E-C1256FF1.0054E609@de.ibm.com>
In-Reply-To: <OF39B8E361.04396517-ONC1256FF1.004C000E-C1256FF1.0054E609@de.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky wrote:
> Bodo Stroesser <bstroesser@fujitsu-siemens.com> wrote on 04/28/2005
> 03:41:39 PM:
> 
> 
>>I don't think, it hurts. If a debugger willingly sets the syscall number
>>to -1, what would happen without the patch?
>>The kernel will set the result -ENOSYS into grps[2]. So, even if trap
>>still indicates a syscall and a signal is pending, no syscall restarting
>>will be done.
> 
> 
> Why should the kernel set the result to -ENOSYS? If the debugger
> invalidated
> the system call, entry.S will just skip the system call and gprs[2] will
> keep
> the value that the debugger put there.
You are right. I mixed it with i386, that has a separate field for the
result, which is preloaded with -ENOSYS. On s390, the -1 written as the
syscall number leads to entry.S calling nothing. If a signal is pending,
do_signal() will interprete gprs[2] as syscall's result. Since -1 is
-EPERM, no syscall restarting will be done, regardless the value of trap.

The debugger would have to write gprs[2] with -1 on the first syscall
interception *and* with ERESTARTXXXXX at the second syscall interception
to see any changed behavior.

> But if regs->traps still indicates a
> system call and there is another signal pending do_signal will try to
> restart
> the system call. In case of sys_(rt_)return there is no system call anymore
> because the debugger = UML took care of it. That's why UML wants to have
> access to regs->traps.
Yeah.

>>>A signal is delivered and on return from that
>>>signal 
>>>with sys_(rt_)sigreturn >another< signal might be pending and then
>>>do_signal 
>>>gets confused because of -ERESTARTXXX in grp2.
>>
>>This other signal must be pending on the *host*, in UML, this might be
>>SIGVTALRM.
> 
> 
> Why on the host ?!? Now I'm really confused. I thought the problem is the
> regs->trap value in the guest system, how can a signal pending in the host
> have an effect on the guest?
I think, your confusion results from the unclear terminology.
UML is a full Linux, running as some user-space processes on the host.
So, there can be signals pending in UML for the processes running in
UML, but the host won't even know about that.
On the other hand, there can be signals pending "in the host" for the
user-space processes running on the host, that make up the UML.
For example, UML intensely uses SIG(VT)ALRM as the analogue to host's
timer interrupt. UML users never will "see" these signals.
To make occur the problem, that results from host's unwanted syscall
restarting, some condition must be met:

1) A process running in UML and having ERESTARTXXXXX in its GPR2 must be
    interrupted by a signal. As GPR2 never is ERESTARTXXXXX at the end of
    a "normal" syscall, this can happen only if a "interrupt" to UML
    (SIGVTALRM, SIGIO from the host to UML) hits this situation.

2) If interrupt processing in UML results in sending a signal in UML
    to the interrupted process (e.g. alarm timeout triggered) or if
    a signal already is pending in UML, UML starts the handler for the
    signal in the interrupted process.

3) The sighandler returns by calling sys_(rt_)sigreturn.

4) The ptracing process of UML intercepts that syscall and invalidates it.
    Then it does one further PTRACE_SYSCALL and waits, until the child
    reaches the second syscall interception.

5) UML runs its own sys_(rt_)sigreturn for the process, skips its own
    syscall restart processing and writes the registers of the child with
    the values, that result from sys_(rt_)sigreturn processing. Now GPR2
    is loaded with ERESTARTXXXXXX again.

6) The child is resumed with PTRACE_SYSCALL. If a further signal is
    pending in the host for that child, the host runs do_signal().
    As regs->trap still is set for a syscall, syscall restarting is
    processed in the host, the process in UML will fail.

Obviously, this is a rare case. On i386, the syscall number is used as
trap, so -1 can be written to it at the second interception to skip
syscall restarting. Some months ago, UML/i386 did not yet use this, so
I wrote a litte program, that made the problem happen.

> 
> The patch does a very specific thing that UML needs, hardcoded into the
> ptrace
> interface. Who knows what kind of things other user of ptrace might need?
I don't *know* this, too. But I still believe, that no current user of
ptrace will see the difference, as very specific ptrace operations have
to be done to trigger the change.
If there really would be no user of ptrace doing things conflicting with
the patch yet, there would be no reason to not insert the patch. AFAICS,
the patch doesn't make any useful operation impossible. So future conflicts
can be avoided by future users of ptrace. Additionally, the -1 could be
replaced by -ENOSYS or even a special magic number.

> I don't claim to know, and that is why I don't like to see this done in the
> syscall_ptrace function. Perhaps via peekusr/pokeuser interface but then
> trap should be a member of struct user.
As trap could be added to struct user at the end of struct user only, this
would result in an additional ptrace call in UML :-(

Is it safe to increase size of struct user? What about software being
recompiled partly (e.g. using a private lib which isn't recompiled; or the
lib is recompiled, while the program isn't).
So maybe an additional ptrace operation (PTRACE_SETTRAP?) would be better,
but still we would need one more syscall in UML.

Regards, Bodo
