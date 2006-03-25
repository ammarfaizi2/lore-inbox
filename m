Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750993AbWCYAHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbWCYAHn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 19:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbWCYAHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 19:07:43 -0500
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:23192 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750897AbWCYAHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 19:07:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Disposition:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=kmgH20mNTtv2wXgyWKJ2TP+XhMb3P2tb/AguSloRwhNAX3O3hjTsRKqRC/IlEqAWbC128dC4mHE6AFmWCwc1n6DC/l9VB2Qz6+NJH8787kHGJ04+gqi+f1hnUsHQA0qk1mlJdvnumgBxmfcTZuewCsxWGAakf0ZsE/ZC/xGYV8s=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: "Charles P. Wright" <cwright@cs.sunysb.edu>
Subject: Re: [RFC] Proposed manpage additions for ptrace(2)
Date: Sat, 25 Mar 2006 01:07:39 +0100
User-Agent: KMail/1.8.3
Cc: Daniel Jacobowitz <dan@debian.org>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Michael Kerrisk <mtk-manpages@gmx.net>
References: <200603150415_MC3-1-BAB1-D3CE@compuserve.com> <200603171946.54784.blaisorblade@yahoo.it> <1142714267.22366.9.camel@localhost.localdomain>
In-Reply-To: <1142714267.22366.9.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200603250107.40332.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 March 2006 21:37, Charles P. Wright wrote:
> On Fri, 2006-03-17 at 19:46 +0100, Blaisorblade wrote:

> > If you resume it with PTRACE_SYSEMU, it'll stop at next syscall entry, as
> > expected, and next syscall will not be executed.
> >
> > If you resume it with PTRACE_SYSCALL (which made sense only for
> > debugging), the only thing which changes is that _next_ syscall will be
> > executed normally; then after stopping at syscall #2 exit you can choose
> > to resume with PTRACE_SYSEMU. You can do that even at syscall #2 entry,
> > but you get the same result.

> If you do the PTRACE_SYSEMU at the entry, then it seems that you

What were you going to write here?

> > However, I remember I answered to your request to fix this problem with
> > some patches to test (I remember I was sure enough of their correctness,
> > for what can be seen by code inspection), but got no answer and didn't
> > finish anything. Lost the email or the interest?

> Actually, I remember that you said that it wasn't very practical to try
> and fix SYSEMU because UML already relies on its interface.

Yep, I implemented in fact an extension of the call, via setting a ptrace 
option.

> You 
> suggested a "checked" version of the call, which I didn't actually lose
> interest in.  I've included a patch to 2.6.15 (based on your original
> patch) that I've been using that adds "PTRACE_CHECKEMU", which I think
> has more user-friendly semantics.

Indeed it is simpler to do PTRACE_CHECKEMU than to set an option and do 
PTRACE_SYSEMU, but a quick read I felt that doing so adds additional 
complication to the code... (mostly in the flag setting in arch_ptrace()).

Also, I've to look well at your changes to do_syscall_trace() to judge about 
them. The logic used is different from the one I wrote, though it seems valid 
too. Until I look well (and I've not the time now) I won't be able to see 
whether it's an improvement or not.

> The PTRACE_CHECKEMU call makes the emulation decision after
> ptrace_notify is called so that the tracing process can examine/update
> registers before issuing PTRACE_CHECKEMU (to emulate the call) or
> PTRACE_SYSCALL (to let the call go through).

Ok, if I'm not missing anything this is the "better interface" we talked 
about.

> I've also got a patch that allows you to execute the call, but skip the
> return.  This is useful when you are emulating a subset of calls, and
> don't care about the return value of unemulated calls.

> > I was also busy so I didn't test them myself (even because reading this
> > code and following the exact states causes me a headache).

> There is indeed some headache in here.  I think particularly for SYSEMU,
> because there is a large gap between calling it and the decision that is
> made.

Yes, but the "large gap" is achieved by the initial checking of the 
tsk_thread_flag.

> @@ -475,6 +475,7 @@
>  		  break;
>
>  	case PTRACE_SYSEMU: /* continue and stop at next syscall, which will not
> be executed */ +	case PTRACE_CHECKEMU: /* like SYSEMU, but allow per-call
> emulation decisions. */ case PTRACE_SYSCALL:	/* continue and stop at next
> (return from) syscall */ case PTRACE_CONT:	/* restart after signal. */
>  		ret = -EIO;
> @@ -483,12 +484,19 @@

This "if" has probably become too large - better separate into an inline(?) 
function the common code and split all request in different "case 
PTRACE_XXX:" labels.

>  		if (request == PTRACE_SYSEMU) {
>  			set_tsk_thread_flag(child, TIF_SYSCALL_EMU);
>  			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
> +			clear_tsk_thread_flag(child, TIF_SYSCALL_CHECKEMU);
>  		} else if (request == PTRACE_SYSCALL) {
>  			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
>  			clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
> +			clear_tsk_thread_flag(child, TIF_SYSCALL_CHECKEMU);
> +		} else if (request == PTRACE_CHECKEMU) {
> +			set_tsk_thread_flag(child, TIF_SYSCALL_CHECKEMU);
> +			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
> +			clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
>  		} else {
>  			clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
>  			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
> +			clear_tsk_thread_flag(child, TIF_SYSCALL_CHECKEMU);
>  		}
>  		child->exit_code = data;
>  		/* make sure the single step bit is not set. */
> @@ -524,6 +532,7 @@
>  			clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
>
>  		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
> +		clear_tsk_thread_flag(child, TIF_SYSCALL_CHECKEMU);
>  		set_singlestep(child);
>  		child->exit_code = data;
>  		/* give it a chance to run. */

> diff -ur linux-2.6.15-vanilla/include/linux/ptrace.h
> linux-2.6.15-checkemu/include/linux/ptrace.h ---
> linux-2.6.15-vanilla/include/linux/ptrace.h	2006-01-02 22:21:10.000000000
> -0500 +++ linux-2.6.15-checkemu/include/linux/ptrace.h	2006-02-03
> 00:47:18.000000000 -0500 @@ -22,6 +22,7 @@
>  #define PTRACE_SYSCALL		  24
>  #define PTRACE_SYSEMU		  31
>  #define PTRACE_SYSEMU_SINGLESTEP  32
> +#define PTRACE_CHECKEMU		  33

Argh - PTRACE_CHECKEMU shouldn't be 33, it was wrong from me to do so, I've 
been taught only subsequently, and it shouldn't be in linux/ptrace.h; either 
use the arch-independent range 0x4200-0x4300 (which is the better road IMHO) 
or move it to asm-i386/ptrace.h:

>  /* 0x4200-0x4300 are reserved for architecture-independent additions.  */
>  #define PTRACE_SETOPTIONS	0x4200

Indeed, I already moved PTRACE_SYSEMU* to asm-i386, because their value 
conflicted with another ptrace code, on another arch.

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


		
___________________________________ 
Yahoo! Messenger with Voice: chiama da PC a telefono a tariffe esclusive 
http://it.messenger.yahoo.com
