Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261721AbUKXF0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261721AbUKXF0e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 00:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261819AbUKXF0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 00:26:33 -0500
Received: from siaag2ag.compuserve.com ([149.174.40.140]:37565 "EHLO
	siaag2ag.compuserve.com") by vger.kernel.org with ESMTP
	id S261721AbUKXF03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 00:26:29 -0500
Date: Wed, 24 Nov 2004 00:23:23 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: x86_64 GPF handler (was: [PATCH] remove errornous semicolon)
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200411240026_MC3-1-8F47-CE27@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:

> arch/i386/kernel/traps.c: In function `do_general_protection':
> arch/i386/kernel/traps.c:506: warning: empty body in an if-statement
> 
> upon inspecting the code I see what looks like a mistakenly placed ";"
> 
>         if (!fixup_exception(regs)) {
>                 if (notify_die(DIE_GPF, "general protection fault", regs,
>                                 error_code, 13, SIGSEGV) == NOTIFY_STOP);
>                         return;
>                 die("general protection fault", regs, error_code);
>         }


  Ouch.  No matter what the notifier chain returns it will be treated
as if it returned NOTIFY_STOP, and no kernel-mode GPF will ever reach
the die().

  This bug was introduced 31 Aug 04 by prasanna@in.ibm.com during a
kprobes update.  The comments say it was ported from x86_64, so I had
a look:

        /* kernel gp */
        {
                const struct exception_table_entry *fixup;
                fixup = search_exception_tables(regs->rip);
                if (fixup) {
                        regs->rip = fixup->fixup;
                        return;
                }
                notify_die(DIE_GPF, "general protection fault", regs, error_code,
                           13, SIGSEGV); 
                die("general protection fault", regs, error_code);
        }

x86_64 never checks the result of notify_die() and unconditionally does a die().
I don't know if this is a bug or not...

Andi, if this is not a bug could you explain why not?


--Chuck Ebbert  24-Nov-04  00:23:50
