Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314043AbSDZOHf>; Fri, 26 Apr 2002 10:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314048AbSDZOHe>; Fri, 26 Apr 2002 10:07:34 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:34825 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S314043AbSDZOHe>; Fri, 26 Apr 2002 10:07:34 -0400
Date: Fri, 26 Apr 2002 18:07:04 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Jurriaan on Alpha <thunder7@xs4all.nl>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: [patch] Re: gdb stopped working in 2.5.10 - works fine in 2.4.x
Message-ID: <20020426180704.A22338@jurassic.park.msu.ru>
In-Reply-To: <20020426125736.GA6775@alpha.of.nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2002 at 02:57:36PM +0200, Jurriaan on Alpha wrote:
> the breakpoint with a negative number, followed by the message 'Cannot
> access memory at ...' happens on any executable I try with gdb.
> 
> This didn't happen with the 2.4.x kernels, so I suspect something in
> 2.5.x. Any ideas?

Yes, gdb and strace are broken since 2.5.6, IIRC.
Some necessary 'thread_info' changes still are missing in ptrace.c.
Fix appended. 

Ivan.

--- 2.5.9/arch/alpha/kernel/ptrace.c	Sun Apr 14 23:18:55 2002
+++ linux/arch/alpha/kernel/ptrace.c	Mon Apr 15 18:36:43 2002
@@ -106,7 +106,7 @@ get_reg_addr(struct task_struct * task, 
 		zero = 0;
 		addr = &zero;
 	} else {
-		addr = (long *)((long)task + regoff[regno]);
+		addr = (long *)((long)task->thread_info + regoff[regno]);
 	}
 	return addr;
 }
@@ -340,9 +340,9 @@ sys_ptrace(long request, long pid, long 
 		if ((unsigned long) data > _NSIG)
 			goto out;
 		if (request == PTRACE_SYSCALL)
-			set_thread_flag(TIF_SYSCALL_TRACE);
+			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		else
-			clear_thread_flag(TIF_SYSCALL_TRACE);
+			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		child->exit_code = data;
 		wake_up_process(child);
 		/* make sure single-step breakpoint is gone. */
@@ -371,7 +371,7 @@ sys_ptrace(long request, long pid, long 
 			goto out;
 		/* Mark single stepping.  */
 		child->thread_info->bpt_nsaved = -1;
-		clear_thread_flag(TIF_SYSCALL_TRACE);
+		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		wake_up_process(child);
 		child->exit_code = data;
 		/* give it a chance to run. */
