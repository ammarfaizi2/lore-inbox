Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262148AbVD1P2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262148AbVD1P2s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 11:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbVD1P2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 11:28:48 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:3577 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S262148AbVD1P2e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 11:28:34 -0400
In-Reply-To: <4270E813.50706@fujitsu-siemens.com>
Sensitivity: 
Subject: Re: Again: UML on s390 (31Bit)
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux devel 
	<user-mode-linux-devel@lists.sourceforge.net>
X-Mailer: Lotus Notes Build V651_12042003 December 04, 2003
Message-ID: <OF39B8E361.04396517-ONC1256FF1.004C000E-C1256FF1.0054E609@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Thu, 28 Apr 2005 17:27:19 +0200
X-MIMETrack: Serialize by Router on D12ML062/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 28/04/2005 17:28:30
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Stroesser <bstroesser@fujitsu-siemens.com> wrote on 04/28/2005
03:41:39 PM:

> Martin Schwidefsky wrote:
> > So (!entryexit & regs->gprs[2] < 0) translates to the debugger changed
the guest
> > system call to something illegal on the first of the two ptrace calls.
So the
> > patch doesn't hurt for normal, non-ptraced operation but it might hurt
other
> > users of ptrace.
> I don't think, it hurts. If a debugger willingly sets the syscall number
> to -1, what would happen without the patch?
> The kernel will set the result -ENOSYS into grps[2]. So, even if trap
> still indicates a syscall and a signal is pending, no syscall restarting
> will be done.

Why should the kernel set the result to -ENOSYS? If the debugger
invalidated
the system call, entry.S will just skip the system call and gprs[2] will
keep
the value that the debugger put there. But if regs->traps still indicates a
system call and there is another signal pending do_signal will try to
restart
the system call. In case of sys_(rt_)return there is no system call anymore
because the debugger = UML took care of it. That's why UML wants to have
access to regs->traps.

> With the patch, a debugger would observe changed behavior of the kernel
> *only*, if it writes the syscall number to -1 on the first syscall
> interception and then writes the result to ERESTARTXXXXX on the second,
> while at the same time a signal is pending for the debugged process.

In theory the debugger may want to intercept specific system calls and
do magic things instead but still want to have the system call restarting
to intercept it again after the (guest) signal has been delivered. You
just don't know.

> I assumed, that non of the current users of ptrace exactly does this.
> If I'm wrong here, the patch *really* is bad.

At least strace and gdb won't do it.

> > Ok, I think I've understood the problem now. What you are basically
have is
> > a process running in a UML guest that happens to have -ERESTARTXXX in
grp2
> > when it gets interrupted. A signal is delivered and on return from that
signal
> > with sys_(rt_)sigreturn >another< signal might be pending and then
do_signal
> > gets confused because of -ERESTARTXXX in grp2.
> This other signal must be pending on the *host*, in UML, this might be
> SIGVTALRM.

Why on the host ?!? Now I'm really confused. I thought the problem is the
regs->trap value in the guest system, how can a signal pending in the host
have an effect on the guest?

> > For normal, non-uml operation
> > restore_sigregs resets regs->trap to -1 which avoids the confusion.
With UML
> > the host intercepts sys_rt_sigreturn and does whatever needs to be done
for
> > the guest >except< resetting regs->trap to -1. So the problem seems to
be
> > that you need a ptrace interface to do that. I don't think it is a good
idea
> > to kludge syscall_trace to reset regs->trap under some conditions.
> My idea was to enable the existing ptrace interface to do what UML
> needs, without changing it in a way observable to other users of ptrace.
> I expected my patch to exactly do that, but maybe I missed something.
> Any better idea is welcome.

The patch does a very specific thing that UML needs, hardcoded into the
ptrace
interface. Who knows what kind of things other user of ptrace might need?
I don't claim to know, and that is why I don't like to see this done in the
syscall_ptrace function. Perhaps via peekusr/pokeuser interface but then
trap should be a member of struct user.

blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

