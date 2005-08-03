Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262429AbVHCTu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbVHCTu5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 15:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262432AbVHCTu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 15:50:57 -0400
Received: from mail.suse.de ([195.135.220.2]:27855 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262429AbVHCTuy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 15:50:54 -0400
Date: Wed, 3 Aug 2005 21:50:53 +0200
From: Andi Kleen <ak@suse.de>
To: Nicholas Miell <nmiell@comcast.net>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Disable the debug.exception-trace sysctl by default
Message-ID: <20050803195053.GC8266@wotan.suse.de>
References: <1122533610.14066.4.camel@localhost.localdomain> <20050803090344.GI10895@wotan.suse.de> <1123097973.2873.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123097973.2873.4.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2005 at 12:39:33PM -0700, Nicholas Miell wrote:
> On Wed, 2005-08-03 at 11:03 +0200, Andi Kleen wrote:
> > On Wed, Jul 27, 2005 at 11:53:30PM -0700, Nicholas Miell wrote:
> > > debug.exception-trace causes a large amount of log spew when on, and
> > > it's on by default, which is an irritation.
> > 
> > > Here's a patch to turn it off.
> > Rejected. 
> 
> Why?

It is supposed to print normally silent segfaults. That improves
quality of software greatly because people actually notice them and
bugs get only fixed when they are noticed.

We started it early with the port, but it is still very useful.

Some misguided distributions unfortunately turn it off by default, but
I think they pay the price in general software quality.


> 
> Getting 5000 lines of
> "inkscape[13137] trap int3 rip:425051 rsp:7fffffa26158 error:0"
> in my logs every time I ltrace something is vastly irritating and serves
> no useful purpose.

Normally it's not supposed to print anything when the process is under control of 
a debugger.  But we made an exception for strace.

Unfortunately that triggers with ltrace because it uses PTRACE_SYSCALL instead
of PTRACE_CONT. 

Anyways, this patch would fix that:


Index: linux/arch/x86_64/mm/fault.c
===================================================================
--- linux.orig/arch/x86_64/mm/fault.c
+++ linux/arch/x86_64/mm/fault.c
@@ -211,9 +211,7 @@ int unhandled_signal(struct task_struct 
 {
 	if (tsk->pid == 1)
 		return 1;
-	/* Warn for strace, but not for gdb */
-	if (!test_ti_thread_flag(tsk->thread_info, TIF_SYSCALL_TRACE) &&
-	    (tsk->ptrace & PT_PTRACED))
+	if (tsk->ptrace & PT_PTRACED)
 		return 0;
 	return (tsk->sighand->action[sig-1].sa.sa_handler == SIG_IGN) ||
 		(tsk->sighand->action[sig-1].sa.sa_handler == SIG_DFL);


> Admittedly, I can (and have) turned this off, but disabling it by
> default will probably save somebody else the trouble of figuring out
> where this crap is coming from and how to kill it.

Giving some other users with the pleasure to figure why things mysteriously
break with silent segfaults. Not a good tradeoff.

-Andi
