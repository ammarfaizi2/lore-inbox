Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262533AbVD2MsB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262533AbVD2MsB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 08:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262534AbVD2MsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 08:48:00 -0400
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35]:23076 "EHLO
	dgate1.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S262533AbVD2Mr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 08:47:57 -0400
X-SBRSScore: None
X-IronPort-AV: i="3.92,138,1112565600"; 
   d="scan'208"; a="8351054:sNHT1595595280"
Message-ID: <42722CF7.4000005@fujitsu-siemens.com>
Date: Fri, 29 Apr 2005 14:47:51 +0200
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
CC: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux devel 
	<user-mode-linux-devel@lists.sourceforge.net>
Subject: Re: Again: UML on s390 (31Bit)
References: <OFC64AA10F.5C318C60-ONC1256FF2.003E8736-C1256FF2.0040BFA0@de.ibm.com>
In-Reply-To: <OFC64AA10F.5C318C60-ONC1256FF2.003E8736-C1256FF2.0040BFA0@de.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky wrote:
> Yes, it is not a really good idea to add something to struct user. That will
> affect the dump format and debugging tools. So it would be an additional ptrace
> command like PTRACE_SETTRAP/PTRACE_GETTRAP. The only other solution I can think
> of is to be more specific about what the debugger can indicate to the debuggee
> what needs to be done after the first syscall_trace invocation. At the moment
> it is either
> 1) a valid system call number, execute the new syscall, or
> 2) an invalid system call number, skip the system call but don't change
>    regs->traps and do system call restarting if another signal is pending
> If we use more specific error codes instead of just any invalid syscall number
> we could have e.g. this:
> 1) a vaild system call number, execute the new syscall,
> 2) -Exxx, skip the system call, store -1 to regs->trap and then continue
>    with restarting system calls if another system call is pending.
Typo with<->without?

Yes. That's what I suggested as a "special magic number". Only if that magic
is written as syscall number at the first interception, syscall_trace() would
modify regs->trap to -1.
Currently my patch uses -1 as the magic number, but there might be better
choices.

> 3) -Eyyy, skip the system call but leave regs->trap intact so that a pending
>    signal will restart the system call.
Not only -Eyyy, but all values unequal to "special magic number" could leave
regs->trap intact.

> 
> But we really have to be very careful not to break either strace or gdb if
> we do this change. Probably it is much easier to introduce PTRACE_SET/GET_TRAP.
It's easier for s390-kernel, but from UML's point of view, the magic number
solution would be better.
Anyway, if you decide not to allow the magic number, we have to find a way
to use PTRACE_SETTRAP in UML without having to call it too often (Performance).
Because of UML's splitting in kernel-obj and user-obj, this might be a bit
tricky.

BTW: I see no reason to implement PTRACE_GETTRAP, as
PTRACE_SETOPTIONS/PTRACE_TRACESYSGOOD give us a way to distinguish between
syscall interceptions and other SIGTRAPs.

Regards, Bodo
