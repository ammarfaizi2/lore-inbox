Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262624AbUKXLou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262624AbUKXLou (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 06:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262625AbUKXLou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 06:44:50 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:16015 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262624AbUKXLor
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 06:44:47 -0500
Date: Wed, 24 Nov 2004 17:15:23 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Andi Kleen <ak@suse.de>, akpm@osdl.org
Cc: Chuck Ebbert <76306.1226@compuserve.com>, Jesper Juhl <juhl-lkml@dif.dk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: x86_64 GPF handler (was: [PATCH] remove errornous semicolon)
Message-ID: <20041124114523.GA2336@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <200411240026_MC3-1-8F47-CE27@compuserve.com> <20041124104338.GC10495@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041124104338.GC10495@wotan.suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > x86_64 never checks the result of notify_die() and unconditionally does a die().
> > I don't know if this is a bug or not...
> > 
> > Andi, if this is not a bug could you explain why not?
> 
> It depends on what the debugger (or kprobes) wants. These checks
> are added based on their needs. Perhaps he didn't consider it 
> necessary on x86-64. But why don't you ask Prasanna directly?  (cc'ed)
> 

I agree with Andi that it depends on the specific debugger. On handling
the general protection fault notification, kprobe handler returns NOTIFY_STOP.
This check missed out in x86_64 kprobes patch. Below patch should fix this,
please let me know if you have any issues.

Thanks
Prasanna


This patch adds the return value check for the exception notifiers at
do_general_protection as pointed out by Chuck Ebbert.

Signed-off-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>


---

 linux-2.6.10-rc2-prasanna/arch/x86_64/kernel/traps.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff -puN arch/x86_64/kernel/traps.c~notifier-fix arch/x86_64/kernel/traps.c
--- linux-2.6.10-rc2/arch/x86_64/kernel/traps.c~notifier-fix	2004-11-24 17:06:41.000000000 +0530
+++ linux-2.6.10-rc2-prasanna/arch/x86_64/kernel/traps.c	2004-11-24 17:08:18.000000000 +0530
@@ -556,8 +556,9 @@ asmlinkage void do_general_protection(st
 			regs->rip = fixup->fixup;
 			return;
 		}
-		notify_die(DIE_GPF, "general protection fault", regs, error_code,
-			   13, SIGSEGV); 
+		if (notify_die(DIE_GPF, "general protection fault", regs,
+					error_code, 13, SIGSEGV) == NOTIFY_STOP)
+			return;
 		die("general protection fault", regs, error_code);
 	}
 }

_
-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
