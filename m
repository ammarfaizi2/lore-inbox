Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbVHaCEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbVHaCEa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 22:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbVHaCE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 22:04:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15315 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932331AbVHaCE2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 22:04:28 -0400
Date: Tue, 30 Aug 2005 19:02:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: blaisorblade@yahoo.it
Cc: linux-kernel@vger.kernel.org, blaisorblade@yahoo.it,
       bstroesser@fujitsu-siemens.com, roland@redhat.com
Subject: Re: [patch 1/1] Ptrace - i386: fix "syscall audit" interaction with
 singlestep
Message-Id: <20050830190219.56473766.akpm@osdl.org>
In-Reply-To: <20050726184306.A104421DC16@zion.home.lan>
References: <20050726184306.A104421DC16@zion.home.lan>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

blaisorblade@yahoo.it wrote:
>
> 
> From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> CC: Roland McGrath <roland@redhat.com>
> 
> Avoid giving two traps for singlestep instead of one, when syscall auditing is
> enabled.
> 
> In fact no singlestep trap is sent on syscall entry, only on syscall exit, as
> can be seen in entry.S:
> 
> # Note that in this mask _TIF_SINGLESTEP is not tested !!! <<<<<<<<<<<<<<
>         testb $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SECCOMP),TI_flags(%ebp)
>         jnz syscall_trace_entry
> 	...
> syscall_trace_entry:
> 	...
> 	call do_syscall_trace
> 
> But auditing a SINGLESTEP'ed process causes do_syscall_trace to be called, so
> the tracer will get one more trap on the syscall entry path, which it
> shouldn't.
> 
> This does not affect (to my knowledge) UML, nor is critical, so this shouldn't
> IMHO go in 2.6.13.
> 
> Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> ---
> 
>  linux-2.6.git-paolo/arch/i386/kernel/ptrace.c |   15 +++++++++++++--
>  1 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff -puN arch/i386/kernel/ptrace.c~sysaudit-singlestep-non-umlhost arch/i386/kernel/ptrace.c
> --- linux-2.6.git/arch/i386/kernel/ptrace.c~sysaudit-singlestep-non-umlhost	2005-07-26 20:22:40.000000000 +0200
> +++ linux-2.6.git-paolo/arch/i386/kernel/ptrace.c	2005-07-26 20:23:44.000000000 +0200
> @@ -683,8 +683,19 @@ void do_syscall_trace(struct pt_regs *re
>  	/* do the secure computing check first */
>  	secure_computing(regs->orig_eax);
>  
> -	if (unlikely(current->audit_context) && entryexit)
> -		audit_syscall_exit(current, AUDITSC_RESULT(regs->eax), regs->eax);
> +	if (unlikely(current->audit_context)) {
> +		if (entryexit)
> +			audit_syscall_exit(current, AUDITSC_RESULT(regs->eax), regs->eax);
> +
> +		/* Debug traps, when using PTRACE_SINGLESTEP, must be sent only
> +		 * on the syscall exit path. Normally, when TIF_SYSCALL_AUDIT is
> +		 * not used, entry.S will call us only on syscall exit, not
> +		 * entry ; so when TIF_SYSCALL_AUDIT is used we must avoid
> +		 * calling send_sigtrap() on syscall entry.
> +		 */
> +		else if (is_singlestep)
> +			goto out;
> +	}
>  

This appears to be a UML patch, applied to x86, which has no `is_singlestep'.
