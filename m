Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262485AbVD2Lsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262485AbVD2Lsv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 07:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262500AbVD2Lsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 07:48:50 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:39920 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S262485AbVD2Lsa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 07:48:30 -0400
In-Reply-To: <42713084.7070403@fujitsu-siemens.com>
Subject: Re: Again: UML on s390 (31Bit)
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux devel 
	<user-mode-linux-devel@lists.sourceforge.net>
X-Mailer: Lotus Notes Build V651_12042003 December 04, 2003
Message-ID: <OFC64AA10F.5C318C60-ONC1256FF2.003E8736-C1256FF2.0040BFA0@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Fri, 29 Apr 2005 13:47:13 +0200
X-MIMETrack: Serialize by Router on D12ML062/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 29/04/2005 13:48:26
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Stroesser <bstroesser@fujitsu-siemens.com> wrote on 04/28/2005
08:50:44 PM:

> 5) UML runs its own sys_(rt_)sigreturn for the process, skips its own
>     syscall restart processing and writes the registers of the child with
>     the values, that result from sys_(rt_)sigreturn processing. Now GPR2
>     is loaded with ERESTARTXXXXXX again.
>
> 6) The child is resumed with PTRACE_SYSCALL. If a further signal is
>     pending in the host for that child, the host runs do_signal().
>     As regs->trap still is set for a syscall, syscall restarting is
>     processed in the host, the process in UML will fail.

That is what I was after, the additional signal that causes the problem
is pending for the child, not for the ptrace father process.

> Obviously, this is a rare case. On i386, the syscall number is used as
> trap, so -1 can be written to it at the second interception to skip
> syscall restarting. Some months ago, UML/i386 did not yet use this, so
> I wrote a litte program, that made the problem happen.

The rare cases are always the most complicated ones. To make UML work
reliably this needs to get fixed.

> > I don't claim to know, and that is why I don't like to see this done in the
> > syscall_ptrace function. Perhaps via peekusr/pokeuser interface but then
> > trap should be a member of struct user.
> As trap could be added to struct user at the end of struct user only, this
> would result in an additional ptrace call in UML :-(
>
> Is it safe to increase size of struct user? What about software being
> recompiled partly (e.g. using a private lib which isn't recompiled; or the
> lib is recompiled, while the program isn't).
> So maybe an additional ptrace operation (PTRACE_SETTRAP?) would be better,
> but still we would need one more syscall in UML.

Yes, it is not a really good idea to add something to struct user. That will
affect the dump format and debugging tools. So it would be an additional ptrace
command like PTRACE_SETTRAP/PTRACE_GETTRAP. The only other solution I can think
of is to be more specific about what the debugger can indicate to the debuggee
what needs to be done after the first syscall_trace invocation. At the moment
it is either
1) a valid system call number, execute the new syscall, or
2) an invalid system call number, skip the system call but don't change
   regs->traps and do system call restarting if another signal is pending
If we use more specific error codes instead of just any invalid syscall number
we could have e.g. this:
1) a vaild system call number, execute the new syscall,
2) -Exxx, skip the system call, store -1 to regs->trap and then continue
   with restarting system calls if another system call is pending.
3) -Eyyy, skip the system call but leave regs->trap intact so that a pending
   signal will restart the system call.

But we really have to be very careful not to break either strace or gdb if
we do this change. Probably it is much easier to introduce PTRACE_SET/GET_TRAP.

blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

