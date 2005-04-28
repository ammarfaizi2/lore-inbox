Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261717AbVD1Jyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbVD1Jyh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 05:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbVD1Jya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 05:54:30 -0400
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35]:6711 "EHLO
	dgate1.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S261717AbVD1JyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 05:54:21 -0400
X-SBRSScore: None
X-IronPort-AV: i="3.92,136,1112565600"; 
   d="scan'208"; a="8279406:sNHT23413556"
Message-ID: <4270B2C9.2030603@fujitsu-siemens.com>
Date: Thu, 28 Apr 2005 11:54:17 +0200
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
CC: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux devel 
	<user-mode-linux-devel@lists.sourceforge.net>
Subject: Re: Again: UML on s390 (31Bit)
References: <OF558C84FC.0C649F6F-ONC1256FF1.002D4CEF-C1256FF1.002F4B2C@de.ibm.com>
In-Reply-To: <OF558C84FC.0C649F6F-ONC1256FF1.002D4CEF-C1256FF1.002F4B2C@de.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky wrote:
> Bodo Stroesser <bstroesser@fujitsu-siemens.com> wrote on 04/27/2005
> 10:21:58 PM:
>>1) UML includes some of the subarch's (s390) headers. I had to
>>    change one of them with the following one-liner, to make this
>>    compile. AFAICS, this change doesn't break compilation of s390
>>    itself.
> 
> 
> This one isn't a problem. I'll add it to the repository.
Thank you!

> 
> 
>>==============================================================================
>>--- linux-2.6.11.orig/arch/s390/kernel/ptrace.c   2005-04-04 18:57:
>>38.000000000 +0200
>>+++ linux-2.6.11/arch/s390/kernel/ptrace.c   2005-04-04 19:01:51.
>>000000000 +0200
>>@@ -726,6 +726,13 @@
>>              ? 0x80 : 0));
>>
>>     /*
>>+    * If debugger has set an invalid syscall number,
>>+    * we prepare to skip syscall restart handling
>>+    */
>>+   if (!entryexit && (long )regs->gprs[2] < 0 )
>>+      regs->trap = -1;
>>+
>>+   /*
>>      * this isn't the same as continuing with a signal, but it will do
>>      * for normal use.  strace only continues with a signal if the
>>      * stopping signal is not SIGTRAP.  -brl
>>==============================================================================
> 
> 
> This patch is not good. !entryexit indicates that you want to change the trap
> indication on the first of the two calls of syscall_trace for a system call. The
> second condition is gprs[2] < 0 but that can be true for a normal system call as
> well, like sys_exit(-1).
Sorry, that's not right. At that point, gprs[2] holds the syscall number, while the
first argument of the syscall is in origgpr2. If the debugger sets the syscall number
to -1, which is an invalid syscall, changing trap to -1 will result in a changed
behavior only in case, that the debugger on the second syscall interception also sets
the syscall result to ERESTARTXXXXX (This again is modifying gprs[2]). ERESTARTXXXXX
normally would/could be handled by do_signal(), but with the patch it no longer will.
So, I think the patch doesn't hurt in normal cases, but does the trick for UML.

> It might even be true for user addresses if we really
> extent the virtual address space to full 64 bit one day (and the hardware can do
> it with a 5 level paging table). To change regs->trap to -1 with the current
> condition is definitly wrong.
> Independent from that it do not understand why you need it at all. If the
> uml host intercepted and invalidated the guest system call the system restart
> indication bit _TIF_RESTART_SVC shouldn't be set because the guest didn't
> execute a system call.
Let my explain a bit more. UML invalidates UML-user's syscalls on the host, processes
the syscall itself and inserts the result into gprs[2] on the second syscall
interception. For nearly all syscalls ERESTARTXXXXX is a result not returned to user,
but handled in UML kernel internally. But that's not true for sys_(rt_)sigreturn.
The "result" of those is the original contents of gpr2 of the interrupted routine,
which accidentally also might be ERESTARTXXXXXXX (BTW, that's the reason for
sys_(rt_)sigreturn setting trap to -1 also). We skip UML's syscall restart handling
in this case, but we need to skip it in the host, too.

> 
> blue skies,
>    Martin
> 
> Martin Schwidefsky
> Linux for zSeries Development & Services
> IBM Deutschland Entwicklung GmbH

Regards,  Bodo
