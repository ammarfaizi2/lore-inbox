Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262102AbVD1NE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262102AbVD1NE0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 09:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbVD1NE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 09:04:26 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:48784 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S262102AbVD1NEQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 09:04:16 -0400
In-Reply-To: <4270B2C9.2030603@fujitsu-siemens.com>
Sensitivity: 
Subject: Re: Again: UML on s390 (31Bit)
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux devel 
	<user-mode-linux-devel@lists.sourceforge.net>
X-Mailer: Lotus Notes Build V651_12042003 December 04, 2003
Message-ID: <OF7DA21BA7.6A0D6C67-ONC1256FF1.003C86C5-C1256FF1.0047B648@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Thu, 28 Apr 2005 15:03:17 +0200
X-MIMETrack: Serialize by Router on D12ML062/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 28/04/2005 15:04:14
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Stroesser <bstroesser@fujitsu-siemens.com> wrote on 04/28/2005
11:54:17 AM:

> > This patch is not good. !entryexit indicates that you want to change
the trap
> > indication on the first of the two calls of syscall_trace for a system
call. The
> > second condition is gprs[2] < 0 but that can be true for a normal
system call as
> > well, like sys_exit(-1).
> Sorry, that's not right. At that point, gprs[2] holds the syscall number,
while the
> first argument of the syscall is in origgpr2. If the debugger sets the
syscall number
> to -1, which is an invalid syscall, changing trap to -1 will result in a
changed
> behavior only in case, that the debugger on the second syscall
interception also sets
> the syscall result to ERESTARTXXXXX (This again is modifying gprs[2]).
ERESTARTXXXXX
> normally would/could be handled by do_signal(), but with the patch it no
longer will.
> So, I think the patch doesn't hurt in normal cases, but does the trick
for UML.

Yes, your are right. gprs[2] holds the syscall number for the debugger to
change.
So (!entryexit & regs->gprs[2] < 0) translates to the debugger changed the
guest
system call to something illegal on the first of the two ptrace calls. So
the
patch doesn't hurt for normal, non-ptraced operation but it might hurt
other
users of ptrace.

> > Independent from that it do not understand why you need it at all. If
the
> > uml host intercepted and invalidated the guest system call the system
restart
> > indication bit _TIF_RESTART_SVC shouldn't be set because the guest
didn't
> > execute a system call.
> Let my explain a bit more. UML invalidates UML-user's syscalls on the
host, processes
> the syscall itself and inserts the result into gprs[2] on the second
syscall
> interception. For nearly all syscalls ERESTARTXXXXX is a result not
returned to user,
> but handled in UML kernel internally. But that's not true for
sys_(rt_)sigreturn.
> The "result" of those is the original contents of gpr2 of the interrupted
routine,
> which accidentally also might be ERESTARTXXXXXXX (BTW, that's the reason
for
> sys_(rt_)sigreturn setting trap to -1 also). We skip UML's syscall
restart handling
> in this case, but we need to skip it in the host, too.

Ok, I think I've understood the problem now. What you are basically have is
a process running in a UML guest that happens to have -ERESTARTXXX in grp2
when it gets interrupted. A signal is delivered and on return from that
signal
with sys_(rt_)sigreturn >another< signal might be pending and then
do_signal
gets confused because of -ERESTARTXXX in grp2. For normal, non-uml
operation
restore_sigregs resets regs->trap to -1 which avoids the confusion. With
UML
the host intercepts sys_rt_sigreturn and does whatever needs to be done for
the guest >except< resetting regs->trap to -1. So the problem seems to be
that you need a ptrace interface to do that. I don't think it is a good
idea
to kludge syscall_trace to reset regs->trap under some conditions.

blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

