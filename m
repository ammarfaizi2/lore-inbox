Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbVFAKu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVFAKu7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 06:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVFAKu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 06:50:58 -0400
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35]:11672 "EHLO
	dgate1.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S261187AbVFAKuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 06:50:37 -0400
X-SBRSScore: None
X-IronPort-AV: i="3.93,156,1114984800"; 
   d="scan'208"; a="10226357:sNHT29572036"
Message-ID: <429D92F6.90906@fujitsu-siemens.com>
Date: Wed, 01 Jun 2005 12:50:30 +0200
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
CC: linux-kernel@vger.kernel.org, Ulrich Weigand <uweigand@de.ibm.com>
Subject: Re: Again: UML on s390 (31Bit)
References: <OFB257B050.D41F8BE1-ON41257012.005BE91F-41257012.005D25B2@de.ibm.com>
In-Reply-To: <OFB257B050.D41F8BE1-ON41257012.005BE91F-41257012.005D25B2@de.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank You!
That's what we need.

	Bodo


Martin Schwidefsky wrote:
>>>I've prepared and attached a small program that easily can reproduce
>>>the problem. I hope this will help to find a viable solution.
>>
>>Here is a slightly modified version of my testtool. The new version
>>covers the fact, that in certain situations UML must avoid syscall
>>restarting, even if PSWADDR is not modified.
> 
> 
> Ok, Uli convinced me that the original patch to clear regs->traps if
> the system call has been canceled on the first call to syscall_trace
> is the correct thing to do. If the tracer chooses to invalidate the
> system call of the traced process then the complete handling of the
> function executed for the system call is done in the tracer. That
> includes system call restarting in the case that another system call
> is involved to implement the function. The point is that the traced
> process did not execute a system call, ergo no system call restarting
> may take place.
> So after a long discussion I'll just use a slightly modified version
> of the original patch:
> 
> Index: ptrace.c
> ===================================================================
> RCS file: /home/cvs/linux-2.5/arch/s390/kernel/ptrace.c,v
> retrieving revision 1.35
> diff -u -r1.35 ptrace.c
> --- ptrace.c      6 May 2005 18:59:13 -0000     1.35
> +++ ptrace.c      31 May 2005 16:50:50 -0000
> @@ -39,6 +39,7 @@
>  #include <asm/pgalloc.h>
>  #include <asm/system.h>
>  #include <asm/uaccess.h>
> +#include <asm/unistd.h>
> 
>  #ifdef CONFIG_S390_SUPPORT
>  #include "compat_ptrace.h"
> @@ -762,6 +763,13 @@
>             return;
>       ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
>                          ? 0x80 : 0));
> +
> +     /*
> +      * If the debuffer has set an invalid system call number,
> +      * we prepare to skip the system call restart handling.
> +      */
> +     if (!entryexit && regs->gprs[2] >= NR_syscalls)
> +           regs->trap = -1;
> 
>       /*
>        * this isn't the same as continuing with a signal, but it will do
> 
> ===================================================================
> 
> regs->trap should be reset for any invalid system call, not just for
> negative system call numbers.
> 
> blue skies,
>    Martin
> 
> Martin Schwidefsky
> Linux for zSeries Development & Services
> IBM Deutschland Entwicklung GmbH
> 
