Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbWGQUDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbWGQUDj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 16:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbWGQUDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 16:03:39 -0400
Received: from liaag2ad.mx.compuserve.com ([149.174.40.155]:5598 "EHLO
	liaag2ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751174AbWGQUDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 16:03:38 -0400
Date: Mon, 17 Jul 2006 15:59:32 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] i386: fix recursive fault in page-fault handler
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Krzysztof Halasa <khc@pm.waw.pl>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200607171601_MC3-1-C544-CD36@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <Pine.LNX.4.64.0607171107390.15611@evo.osdl.org>

On Mon, 17 Jul 2006 11:08:26 -0700 (PDT), Linus Torvalds wrote:
> 
> On Mon, 17 Jul 2006, Chuck Ebbert wrote:
> >
> > Krzysztof Halasa reported recursive faults in do_page_fault()
> > causing a stream of partial oops messages on the console. Fix
> > by adding a fixup for that code.
> 
> This patch is really too ugly to live.

I was afraid to use __put_user, but I guess it's OK?

--- 2.6.18-rc1-32.orig/arch/i386/mm/fault.c
+++ 2.6.18-rc1-32/arch/i386/mm/fault.c
@@ -585,9 +585,10 @@ no_context:
 		printk(KERN_ALERT "*pte = %08lx\n", page);
 	}
 #endif
-	tsk->thread.cr2 = address;
-	tsk->thread.trap_no = 14;
-	tsk->thread.error_code = error_code;
+	/* avoid possible fault here if tsk is garbage */
+	__put_user(address, &tsk->thread.cr2);
+	__put_user(14, &tsk->thread.trap_no);
+	__put_user(error_code, &tsk->thread.error_code);
 	die("Oops", regs, error_code);
 	bust_spinlocks(0);
 	do_exit(SIGKILL);

> Does it even work? If 'tsk' is 
> broken, I'd expect the die() to oops anyway - it does
> 
>       if (notify_die(DIE_OOPS, str, regs, err,
>                        current->thread.trap_no, SIGSEG...
> 
> anyway (where that "current->thread.trap_no" gets dereferenced).

This should at least stop the endless faults because recursive faulting
in die() is handled properly.  Right now the original error message
(incomplete but still possibly useful) scrolls away.

I was going to fix handling of bad task pointer in die() and
show_registers() after I got feedback from the first patch.

-- 
Chuck
