Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262130AbVD1Nlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbVD1Nlp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 09:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbVD1Nlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 09:41:45 -0400
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35]:49730 "EHLO
	dgate1.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S262130AbVD1Nlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 09:41:42 -0400
X-SBRSScore: None
X-IronPort-AV: i="3.92,136,1112565600"; 
   d="scan'208"; a="8297232:sNHT22176984"
Message-ID: <4270E813.50706@fujitsu-siemens.com>
Date: Thu, 28 Apr 2005 15:41:39 +0200
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
CC: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux devel 
	<user-mode-linux-devel@lists.sourceforge.net>
Subject: Re: Again: UML on s390 (31Bit)
References: <OF7DA21BA7.6A0D6C67-ONC1256FF1.003C86C5-C1256FF1.0047B648@de.ibm.com>
In-Reply-To: <OF7DA21BA7.6A0D6C67-ONC1256FF1.003C86C5-C1256FF1.0047B648@de.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky wrote:
> So (!entryexit & regs->gprs[2] < 0) translates to the debugger changed the
> guest
> system call to something illegal on the first of the two ptrace calls. So
> the
> patch doesn't hurt for normal, non-ptraced operation but it might hurt
> other
> users of ptrace.
I don't think, it hurts. If a debugger willingly sets the syscall number
to -1, what would happen without the patch?
The kernel will set the result -ENOSYS into grps[2]. So, even if trap
still indicates a syscall and a signal is pending, no syscall restarting
will be done.
With the patch, a debugger would observe changed behavior of the kernel
*only*, if it writes the syscall number to -1 on the first syscall
interception and then writes the result to ERESTARTXXXXX on the second,
while at the same time a signal is pending for the debugged process.

I assumed, that non of the current users of ptrace exactly does this.
If I'm wrong here, the patch *really* is bad.

> Ok, I think I've understood the problem now. What you are basically have is
> a process running in a UML guest that happens to have -ERESTARTXXX in grp2
> when it gets interrupted. A signal is delivered and on return from that
> signal
> with sys_(rt_)sigreturn >another< signal might be pending and then
> do_signal
> gets confused because of -ERESTARTXXX in grp2.
This other signal must be pending on the *host*, in UML, this might be
SIGVTALRM.

> For normal, non-uml operation
> restore_sigregs resets regs->trap to -1 which avoids the confusion. With
> UML
> the host intercepts sys_rt_sigreturn and does whatever needs to be done for
> the guest >except< resetting regs->trap to -1. So the problem seems to be
> that you need a ptrace interface to do that. I don't think it is a good
> idea
> to kludge syscall_trace to reset regs->trap under some conditions.
My idea was to enable the existing ptrace interface to do what UML
needs, without changing it in a way observable to other users of ptrace.
I expected my patch to exactly do that, but maybe I missed something.
Any better idea is welcome.

Regards,  Bodo
