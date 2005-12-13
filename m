Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbVLMQaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbVLMQaT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 11:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbVLMQaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 11:30:19 -0500
Received: from mail.ccur.com ([66.10.65.12]:31206 "EHLO mail.ccur.com")
	by vger.kernel.org with ESMTP id S932261AbVLMQaR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 11:30:17 -0500
Message-ID: <439EF717.1080408@ccur.com>
Date: Tue, 13 Dec 2005 11:30:15 -0500
From: John Blackwood <john.blackwood@ccur.com>
Reply-To: john.blackwood@ccur.com
Organization: Concurrent Computer Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.4) Gecko/20050318 Red Hat/1.4.4-1.3.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andi Kleen <ak@suse.de>, bugsy@ccur.com
Subject: [PATCH] arch/x86_64/kernel/traps.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Dec 2005 16:30:16.0862 (UTC) FILETIME=[8045A3E0:01C60002]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

I would like to throw out a suggestion for a possible change in the way that
the debug register traps are handled in do_debug() when the trap occurs
in kernel-mode.

In the x86_64 version of do_debug(), the code will skip around sending
a SIGTRAP to the current task if the trap occurred while in kernel mode.

On the i386-side of things, if the access happens to occur in kernel mode
(say during a read(2) of user's buffer that matches the address of a
debug register trap), then the do_debug() routine for i386 will go ahead
and call send_sigtrap() and send the SIGTRAP signal.  The send_sigtrap()
code will also set the info.si_addr to NULL in this case (even though I
don't understand why, since the SIGTRAP siginfo processing doesn't use
the si_addr field...).

So I would like to suggest that the x86_64 do_debug() routine also
follow this type of behavior and have it go ahead and send the
SIGTRAP signal to the current task, even if the debug register trap
happens to have occurred in kernel mode.  I have taken a stab at
a patch for this change below.  (It includes the i386-ish change
for setting si_addr to NULL when the trap occurred in kernel mode.)

It seems like a useful feature to be able to 'watch' a user location that
might also be modified in the kernel via a system service call, and have the
debugger report that information back to the user, rather than to just
silently ignore the trap.

Additionally, I realize that users that pull in a kernel debugger such as
KGDB into their kernel might want to remove this change below when they add
in KGDB support.  However, they could alternatively look at the current
task's thread.debugreg[] values to see if the trap occurred due to KGDB
or instead because of a user-space debugger trap, and still honor the
user SIGTRAP processing (instead of the KGDB breakpoint processing)
if the trap matches up with the thread.debugreg[] registers.

Thank you for your time and consideration.



diff -up linux-2.6.14.3/arch/x86_64/kernel/traps.c 
new/arch/x86_64/kernel/traps.c
--- linux-2.6.14.3/arch/x86_64/kernel/traps.c	2005-11-24 
17:10:21.000000000 -0500
+++ new/arch/x86_64/kernel/traps.c	2005-12-13 10:17:35.000000000 -0500
@@ -724,11 +724,9 @@ asmlinkage void __kprobes do_debug(struc
  	info.si_signo = SIGTRAP;
  	info.si_errno = 0;
  	info.si_code = TRAP_BRKPT;
-	if (!user_mode(regs))
-		goto clear_dr7;
-
-	info.si_addr = (void __user *)regs->rip;
+	info.si_addr = user_mode(regs) ? (void __user *)regs->rip : NULL;
  	force_sig_info(SIGTRAP, &info, tsk);	
+
  clear_dr7:
  	set_debugreg(0UL, 7);
  	return;

