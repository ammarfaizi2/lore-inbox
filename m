Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbVD1IpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbVD1IpU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 04:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbVD1InY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 04:43:24 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:58581 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S261898AbVD1Ihe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 04:37:34 -0400
In-Reply-To: <426FF466.10501@fujitsu-siemens.com>
Subject: Re: Again: UML on s390 (31Bit)
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux devel 
	<user-mode-linux-devel@lists.sourceforge.net>
X-Mailer: Lotus Notes Build V651_12042003 December 04, 2003
Message-ID: <OF558C84FC.0C649F6F-ONC1256FF1.002D4CEF-C1256FF1.002F4B2C@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Thu, 28 Apr 2005 10:36:34 +0200
X-MIMETrack: Serialize by Router on D12ML062/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 28/04/2005 10:37:31
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Stroesser <bstroesser@fujitsu-siemens.com> wrote on 04/27/2005
10:21:58 PM:

> I'm sending this mail again, because unfortunately I didn't receive
> any reply. It was sent the first time at April, 5th.

Sorry, I put it on the to-do pile and promptly forgot about it.

> currently I'm porting UML to s390 31-bit.

Nice...

> To make UML build and run on s390, I needed to do these two little
> changes (the patches are copy and paste. I hope that doesn't hurt,
> since they are very small):
>
> 1) UML includes some of the subarch's (s390) headers. I had to
>     change one of them with the following one-liner, to make this
>     compile. AFAICS, this change doesn't break compilation of s390
>     itself.

This one isn't a problem. I'll add it to the repository.

> 2) UML needs to intercept syscalls via ptrace to invalidate the syscall,
>     read syscall's parameters and write the result with the result of
>     UML's syscall processing. Also, UML needs to make sure, that the host
>     does no syscall restart processing. On i386 for example, this can be
>     done by writing -1 to orig_eax on the 2nd syscall interception
>     (orig_eax is the syscall number, which after the interception is used
>     as a "interrupt was a syscall" flag only.
>     Unfortunately, s390 holds syscall number and syscall result in gpr2 and
>     its "interrupt was a syscall" flag (trap) is unreachable via ptrace.
>     So I changed the host to set trap to -1, if the syscall number is written
>     to a negative value on the first syscall interception.
>     I hope, this adds what UML needs without changing ptrace visibly to other
>     ptrace users.
>     (This isn't tested on a 2.6 host yet, because my host still is a 2.4.21 SuSE.
>     But I've adapted this change to 2.4 and tested, it works.)
>
>
> ==============================================================================
> --- linux-2.6.11.orig/arch/s390/kernel/ptrace.c   2005-04-04 18:57:
> 38.000000000 +0200
> +++ linux-2.6.11/arch/s390/kernel/ptrace.c   2005-04-04 19:01:51.
> 000000000 +0200
> @@ -726,6 +726,13 @@
>               ? 0x80 : 0));
>
>      /*
> +    * If debugger has set an invalid syscall number,
> +    * we prepare to skip syscall restart handling
> +    */
> +   if (!entryexit && (long )regs->gprs[2] < 0 )
> +      regs->trap = -1;
> +
> +   /*
>       * this isn't the same as continuing with a signal, but it will do
>       * for normal use.  strace only continues with a signal if the
>       * stopping signal is not SIGTRAP.  -brl
> ==============================================================================

This patch is not good. !entryexit indicates that you want to change the trap
indication on the first of the two calls of syscall_trace for a system call. The
second condition is gprs[2] < 0 but that can be true for a normal system call as
well, like sys_exit(-1). It might even be true for user addresses if we really
extent the virtual address space to full 64 bit one day (and the hardware can do
it with a 5 level paging table). To change regs->trap to -1 with the current
condition is definitly wrong.
Independent from that it do not understand why you need it at all. If the
uml host intercepted and invalidated the guest system call the system restart
indication bit _TIF_RESTART_SVC shouldn't be set because the guest didn't
execute a system call.

blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

