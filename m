Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbULWKup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbULWKup (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 05:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbULWKup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 05:50:45 -0500
Received: from ns.suse.de ([195.135.220.2]:62636 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261201AbULWKuc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 05:50:32 -0500
Date: Thu, 23 Dec 2004 11:50:20 +0100
From: Andi Kleen <ak@suse.de>
To: Jeff Dike <jdike@addtoit.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: An apparent x86_64 ptrace bug
Message-ID: <20041223105020.GA14560@wotan.suse.de>
References: <200412230759.iBN7xEBG005840@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412230759.iBN7xEBG005840@ccure.user-mode-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2004 at 02:59:14AM -0500, Jeff Dike wrote:
> I'm seeing some odd ptrace behavior on x86_64.  Namely,
> 	singlestep hitting the same IP twice,
> 	r11 and rcx changing values to those in eflags and rip, respectively
> 
> Singlestep stopping at the same instruction twice is suspicious in itself.
> In looking through entry.S, I notice that the r11/eflags and rcx/rip pairs
> have the same relation, namely that one member is stored in the stack slot
> reserved for the other.
> 
> It looks like this is not being fixed up correctly in all cases before
> returning to userspace.

That only happens for the system call entry path, and there is no
system call in your example.

> 
> Does this ring any bells?  The kernel here is stock FC3, 
> config-2.6.9-1.681_FC3smp.


You could try to revert 

http://linux.bkbits.net:8080/linux-2.6/cset@412a49d0Duv_YlSqDMoYxkNhiBwoWw?nav=index.html|src/|src/arch|src/arch/x86_64|src/arch/x86_64/kernel|related/arch/x86_64/kernel/entry.S

I never liked this patch and I bet it can cause strange problems
like that.

Another potential issue is a bug I just fixed in that signals could sometimes
jump two bytes backwards.

> Below is the gdb session in question.  The first stepi seems to be gdb seeing
> the queued SIGSTOP, which it has been told not to pass along to the process.
> There are no register changes here.  The next stepi is the interesting one.
> Here we get the same IP again, plus the rip/rcx and eflags/r11 copying.
> 
This could be the "signal restart" bug. Apply this patch.

-Andi

---------------------------------------------------------------

Fix a pretty bad bug that caused sometimes signals on x86-64 
to be restarted like system calls. This corrupted the RIP and 
in general caused undesirable effects.

The problem happens because orig_rax is unsigned on x86-64,
but it originally was signed when the signal code was written.
And gcc didn't warn about this, because the warning is only in 
-Wextra. 

In 2.4 we still had a cast for it, but somehow it got dropped
in 2.5. 

Credit goes to John Slice for tracking it down and Erich Boleyn
for the original fix. I fixed it at another place too.

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/arch/x86_64/kernel/signal.c
===================================================================
--- linux.orig/arch/x86_64/kernel/signal.c	2004-12-19 15:23:48.%N +0100
+++ linux/arch/x86_64/kernel/signal.c	2004-12-20 21:38:01.%N +0100
@@ -357,7 +357,7 @@
 #endif
 
 	/* Are we from a system call? */
-	if (regs->orig_rax >= 0) {
+	if ((long)regs->orig_rax >= 0) {
 		/* If so, check system call restarting.. */
 		switch (regs->rax) {
 		        case -ERESTART_RESTARTBLOCK:
@@ -442,7 +442,7 @@
 
  no_signal:
 	/* Did we come from a system call? */
-	if (regs->orig_rax >= 0) {
+	if ((long)regs->orig_rax >= 0) {
 		/* Restart the system call - no handlers present */
 		long res = regs->rax;
 		if (res == -ERESTARTNOHAND ||
