Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbVACABg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbVACABg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 19:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbVACABg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 19:01:36 -0500
Received: from colin2.muc.de ([193.149.48.15]:18702 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261348AbVACABb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 19:01:31 -0500
Date: 3 Jan 2005 01:01:30 +0100
Date: Mon, 3 Jan 2005 01:01:30 +0100
From: Andi Kleen <ak@muc.de>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org, davidel@xmailserver.org,
       mh@codeweavers.com, the3dfxdude@gmail.com
Subject: Re: [PATCH] Fix typo in i386 single step changes
Message-ID: <20050103000130.GA74276@muc.de>
References: <m1brc7xv98.fsf@muc.de> <20050102234155.GA29453@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050102234155.GA29453@nevyn.them.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2005 at 06:41:55PM -0500, Daniel Jacobowitz wrote:
> On Mon, Jan 03, 2005 at 12:32:19AM +0100, Andi Kleen wrote:
> > 
> > Fix an obvious typo in the recent i386 single stepping changes.
> > 
> > I would recommend to redo all the Wine etc. testing that lead to this patch
> > since it probably never worked.
> > 
> > Signed-off-by: Andi Kleen <ak@muc.de>
> > 
> > --- linux-2.6.10-bk5/arch/i386/kernel/traps.c-o	Mon Jan  3 01:02:06 2005
> > +++ linux-2.6.10-bk5/arch/i386/kernel/traps.c	Mon Jan  3 01:03:05 2005
> > @@ -725,7 +725,7 @@
> >  		if (tsk->ptrace & PT_DTRACE) {
> >  			regs->eflags &= ~TF_MASK;
> >  			tsk->ptrace &= ~PT_DTRACE;
> > -			if (!tsk->ptrace & PT_DTRACE)
> > +			if (!(tsk->ptrace & PT_DTRACE))
> >  				goto clear_TF;
> >  		}
> >  	}
> 
> That test is still wrong... the bit is cleared on the previous line. 
> Is it supposed to be testing something else entirely?

Davide also pointed out that the typo was already in the old code.
The goto was never executed because neither 0 nor 1 gave true 
when anded with 2 (PT_DTRACE)

And we need to deliver the signal anyways, otherwise the debugger
cannot see it. The early return is definitely wrong.

Also looking at the code more closely the comment above doesn't 
match what the code does. I fixed that too.

So a better patch is probably:

Fix logic that worked only by accident in ptrace path. 

Fix wrong comment.

Signed-off-by: Andi Kleen <ak@muc.de>


--- linux-2.6.10-bk5/arch/i386/kernel/traps.c-o	Mon Jan  3 01:02:06 2005
+++ linux-2.6.10-bk5/arch/i386/kernel/traps.c	Mon Jan  3 01:41:17 2005
@@ -706,27 +706,23 @@
 
 	/* Mask out spurious TF errors due to lazy TF clearing */
 	if (condition & DR_STEP) {
-		/*
-		 * The TF error should be masked out only if the current
-		 * process is not traced and if the TRAP flag has been set
-		 * previously by a tracing process (condition detected by
-		 * the PT_DTRACE flag); remember that the i386 TRAP flag
-		 * can be modified by the process itself in user mode,
-		 * allowing programs to debug themselves without the ptrace()
-		 * interface.
+		/* 
+		 * Ignore steps comming from kernel space.
+		 * Apparently they can happen due to lazy TF clearing
+		 * (where exactly? -AK) 
 		 */
 		if ((regs->xcs & 3) == 0)
 			goto clear_TF_reenable;
 
 		/*
 		 * Was the TF flag set by a debugger? If so, clear it now,
-		 * so that register information is correct.
+		 * so that register information is correct and then
+		 * deliver it as signal so that the debugger sees the 
+		 * step.
 		 */
 		if (tsk->ptrace & PT_DTRACE) {
 			regs->eflags &= ~TF_MASK;
 			tsk->ptrace &= ~PT_DTRACE;
-			if (!tsk->ptrace & PT_DTRACE)
-				goto clear_TF;
 		}
 	}
 
@@ -748,7 +744,6 @@
 
 clear_TF_reenable:
 	set_tsk_thread_flag(tsk, TIF_SINGLESTEP);
-clear_TF:
 	regs->eflags &= ~TF_MASK;
 	return;
 }

