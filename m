Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965171AbVIAOwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965171AbVIAOwc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 10:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965173AbVIAOwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 10:52:32 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:51632 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S965171AbVIAOwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 10:52:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=Lnj0lyNQwDctWR9gcPaST/aj159idYYCqPcbndqQLn8IQOYf8LGtQGHxqrtgoA7BaKB1res324NMKtfgUlDMcv4dPdCDbiCJJNt8w4k5KMoXDqjufHdDN6dp88T8A3YAkGQQ87w2UlH/ZENd9M+O6mV39F6ITqlaglDb5AeryRs=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 1/1] Ptrace - i386: fix "syscall audit" interaction with singlestep
Date: Thu, 1 Sep 2005 16:49:12 +0200
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, bstroesser@fujitsu-siemens.com,
       roland@redhat.com
References: <20050726184306.A104421DC16@zion.home.lan> <20050830190219.56473766.akpm@osdl.org>
In-Reply-To: <20050830190219.56473766.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509011649.12983.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 31 August 2005 04:02, Andrew Morton wrote:
> blaisorblade@yahoo.it wrote:
> > From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, Paolo
> > 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it> CC: Roland McGrath
> > <roland@redhat.com>
> >
> > Avoid giving two traps for singlestep instead of one, when syscall
> > auditing is enabled.
> >
> > In fact no singlestep trap is sent on syscall entry, only on syscall
> > exit, as can be seen in entry.S:
> >
> > # Note that in this mask _TIF_SINGLESTEP is not tested !!! <<<<<<<<<<<<<<
> >         testb
> > $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SECCOMP),TI_flags(%ebp) jnz
> > syscall_trace_entry
> > 	...
> > syscall_trace_entry:
> > 	...
> > 	call do_syscall_trace
> >
> > But auditing a SINGLESTEP'ed process causes do_syscall_trace to be
> > called, so the tracer will get one more trap on the syscall entry path,
> > which it shouldn't.
> >
> > This does not affect (to my knowledge) UML, nor is critical, so this
> > shouldn't IMHO go in 2.6.13.
> >
> > Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> > ---
> >
> >  linux-2.6.git-paolo/arch/i386/kernel/ptrace.c |   15 +++++++++++++--
> >  1 files changed, 13 insertions(+), 2 deletions(-)
> >
> > diff -puN arch/i386/kernel/ptrace.c~sysaudit-singlestep-non-umlhost
> > arch/i386/kernel/ptrace.c ---
> > linux-2.6.git/arch/i386/kernel/ptrace.c~sysaudit-singlestep-non-umlhost	2
> >005-07-26 20:22:40.000000000 +0200 +++
> > linux-2.6.git-paolo/arch/i386/kernel/ptrace.c	2005-07-26
> > 20:23:44.000000000 +0200 @@ -683,8 +683,19 @@ void
> > do_syscall_trace(struct pt_regs *re
> >  	/* do the secure computing check first */
> >  	secure_computing(regs->orig_eax);
> >
> > -	if (unlikely(current->audit_context) && entryexit)
> > -		audit_syscall_exit(current, AUDITSC_RESULT(regs->eax), regs->eax);
> > +	if (unlikely(current->audit_context)) {
> > +		if (entryexit)
> > +			audit_syscall_exit(current, AUDITSC_RESULT(regs->eax), regs->eax);
> > +
> > +		/* Debug traps, when using PTRACE_SINGLESTEP, must be sent only
> > +		 * on the syscall exit path. Normally, when TIF_SYSCALL_AUDIT is
> > +		 * not used, entry.S will call us only on syscall exit, not
> > +		 * entry ; so when TIF_SYSCALL_AUDIT is used we must avoid
> > +		 * calling send_sigtrap() on syscall entry.
> > +		 */
> > +		else if (is_singlestep)
> > +			goto out;
> > +	}

> This appears to be a UML patch,
No, absolutely.
> applied to x86, which has no 
> `is_singlestep'.

It is a x86 patch, is_singlestep just comes from later patches (in fact -mm 
has built because that var is created in later patches (about SYSEMU) from 
me).

I took this from one of your mail notices:

ptrace-i386-fix-syscall-audit-interaction-with-singlestep.patch
uml-support-ptrace-adds-the-host-sysemu-support-for-uml-and-general-usage.patch
uml-support-reorganize-ptrace_sysemu-support.patch
uml-support-add-ptrace_sysemu_singlestep-option-to-i386.patch
sysemu-fix-sysaudit--singlestep-interaction.patch

Note in particular the last 
(sysemu-fix-sysaudit--singlestep-interaction.patch) is the original version 
of the patch you're talking about (i.e. this fix was first made again the 
SYSEMU patch, even if it's of general interest).

Just use test_thread_flag(TIF_SINGLESTEP), but leave later patches as-is, they 
need the current 
       int is_singlestep = !is_sysemu && test_thread_flag(TIF_SINGLESTEP);
to be left there, and is_singlestpe to be used in that check.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
