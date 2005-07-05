Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261805AbVGEK0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbVGEK0H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 06:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbVGEK0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 06:26:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29578 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261805AbVGEKTw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 06:19:52 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86-64: ptrace ia32 BP fix
In-Reply-To: Andi Kleen's message of  Tuesday, 5 July 2005 11:59:16 +0200 <20050705095916.GV21330@wotan.suse.de>
X-Antipastobozoticataclysm: Bariumenemanilow
Message-Id: <20050705101934.2E307180980@magilla.sf.frob.com>
Date: Tue,  5 Jul 2005 03:19:34 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Jul 05, 2005 at 02:31:15AM -0700, Roland McGrath wrote:
> > --- a/arch/x86_64/ia32/ia32entry.S
> > +++ b/arch/x86_64/ia32/ia32entry.S
> > @@ -102,6 +102,7 @@ sysenter_do_call:	
> >  	.byte	0xf, 0x35
> >  
> >  sysenter_tracesys:
> > +	movl	%r9d,%ebp
> >  	SAVE_REST
> 
> This is wrong because it will clobber ebp before it is saved.
> It is only saved in SAVE_REST.

It is right because it stores %ebp before it is saved in the argument block
that ptrace can access.  That is the point of it.  %r9d has the value
loaded from (%rbp) just prior to this code, which is what %ebp should
reflect to match the i386 behavior.

> 
> >  	CLEAR_RREGS
> >  	movq	$-ENOSYS,RAX(%rsp)	/* really needed? */
> > @@ -109,13 +110,7 @@ sysenter_tracesys:
> >  	call	syscall_trace_enter
> >  	LOAD_ARGS ARGOFFSET  /* reload args from stack in case ptrace changed it */
> >  	RESTORE_REST
> > -	movl	%ebp, %ebp
> > -	/* no need to do an access_ok check here because rbp has been
> > -	   32bit zero extended */ 
> > -1:	movl	(%rbp),%r9d
> > -	.section __ex_table,"a"
> > -	.quad 1b,ia32_badarg
> > -	.previous
> > +	movl	%ebp,%r9d
> 
> And this also cannot be correct because RESTORE_REST has overwritten %rbp
> already.

This is also correct because RESTORE_REST has stored into %rbp the value in
the argument block, which ptrace may have modified.  This movl ensures that
this changed value is what the system call's argument will be.

The patch is tested and works.  Just try strace on a 32-bit program that
calls mmap2 and look at the 6th argument value.  It shows a stack address
without this patch.  With this patch, it shows the argument value the same
as strace on a native i386 kernel does.


Thanks,
Roland
