Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262603AbUKXKpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262603AbUKXKpk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 05:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbUKXKpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 05:45:39 -0500
Received: from ns.suse.de ([195.135.220.2]:8910 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262603AbUKXKnj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 05:43:39 -0500
Date: Wed, 24 Nov 2004 11:43:38 +0100
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, Andi Kleen <ak@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>, prasanna@in.ibm.com
Subject: Re: x86_64 GPF handler (was: [PATCH] remove errornous semicolon)
Message-ID: <20041124104338.GC10495@wotan.suse.de>
References: <200411240026_MC3-1-8F47-CE27@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411240026_MC3-1-8F47-CE27@compuserve.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2004 at 12:23:23AM -0500, Chuck Ebbert wrote:
> Jesper Juhl wrote:
> 
> > arch/i386/kernel/traps.c: In function `do_general_protection':
> > arch/i386/kernel/traps.c:506: warning: empty body in an if-statement
> > 
> > upon inspecting the code I see what looks like a mistakenly placed ";"
> > 
> >         if (!fixup_exception(regs)) {
> >                 if (notify_die(DIE_GPF, "general protection fault", regs,
> >                                 error_code, 13, SIGSEGV) == NOTIFY_STOP);
> >                         return;
> >                 die("general protection fault", regs, error_code);
> >         }
> 
> 
>   Ouch.  No matter what the notifier chain returns it will be treated
> as if it returned NOTIFY_STOP, and no kernel-mode GPF will ever reach
> the die().
> 
>   This bug was introduced 31 Aug 04 by prasanna@in.ibm.com during a
> kprobes update.  The comments say it was ported from x86_64, so I had
> a look:
> 
>         /* kernel gp */
>         {
>                 const struct exception_table_entry *fixup;
>                 fixup = search_exception_tables(regs->rip);
>                 if (fixup) {
>                         regs->rip = fixup->fixup;
>                         return;
>                 }
>                 notify_die(DIE_GPF, "general protection fault", regs, error_code,
>                            13, SIGSEGV); 
>                 die("general protection fault", regs, error_code);
>         }
> 
> x86_64 never checks the result of notify_die() and unconditionally does a die().
> I don't know if this is a bug or not...
> 
> Andi, if this is not a bug could you explain why not?

It depends on what the debugger (or kprobes) wants. These checks
are added based on their needs. Perhaps he didn't consider it 
necessary on x86-64. But why don't you ask Prasanna directly?  (cc'ed)

-Andi
