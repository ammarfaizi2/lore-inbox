Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264780AbUEKRfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264780AbUEKRfr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 13:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbUEKRez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 13:34:55 -0400
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139]:933 "HELO
	smtp101.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264873AbUEKReU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 13:34:20 -0400
Subject: Re: [patch] really-ptrace-single-step
From: Fabiano Ramos <ramos_fabiano@yahoo.com.br>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Davide Libenzi <davidel@xmailserver.org>
In-Reply-To: <Pine.LNX.4.58.0405111007440.25232@bigblue.dev.mdolabs.com>
References: <Pine.LNX.4.58.0405111007440.25232@bigblue.dev.mdolabs.com>
Content-Type: text/plain
Message-Id: <1084297014.1729.10.camel@slack.domain.invalid>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 11 May 2004 14:36:54 -0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It would not work against 2.6.5, since

do_syscall_trace()

makes the check

if (!test_thread_flag(TIF_SYSCALL_TRACE))
		return;


Simply removing it would do?



On Tue, 2004-05-11 at 14:12, Davide Libenzi wrote:
> This patch lets a ptrace process on x86 to "see" the instruction 
> following the INT #80h op.
> 
> 
> 
> - Davide
> 
> 
> arch/i386/kernel/entry.S       |    2 +-
> include/asm-i386/thread_info.h |    2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)
> 
> 
> 
> 
> Index: arch/i386/kernel/entry.S
> ===================================================================
> RCS file: /usr/src/bkcvs/linux-2.5/arch/i386/kernel/entry.S,v
> retrieving revision 1.83
> diff -u -r1.83 entry.S
> --- arch/i386/kernel/entry.S	12 Apr 2004 20:29:12 -0000	1.83
> +++ arch/i386/kernel/entry.S	11 May 2004 06:35:29 -0000
> @@ -354,7 +354,7 @@
>  	# perform syscall exit tracing
>  	ALIGN
>  syscall_exit_work:
> -	testb $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT), %cl
> +	testb $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SINGLESTEP), %cl
>  	jz work_pending
>  	sti				# could let do_syscall_trace() call
>  					# schedule() instead
> Index: include/asm-i386/thread_info.h
> ===================================================================
> RCS file: /usr/src/bkcvs/linux-2.5/include/asm-i386/thread_info.h,v
> retrieving revision 1.19
> diff -u -r1.19 thread_info.h
> --- include/asm-i386/thread_info.h	12 Apr 2004 20:29:12 -0000	1.19
> +++ include/asm-i386/thread_info.h	11 May 2004 06:34:47 -0000
> @@ -165,7 +165,7 @@
>  
>  /* work to do on interrupt/exception return */
>  #define _TIF_WORK_MASK \
> -  (0x0000FFFF & ~(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT))
> +  (0x0000FFFF & ~(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SINGLESTEP))
>  #define _TIF_ALLWORK_MASK	0x0000FFFF	/* work to do on any return to u-space */
>  
>  /*
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

