Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030454AbWBPMID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030454AbWBPMID (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 07:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030374AbWBPMIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 07:08:01 -0500
Received: from [195.23.16.24] ([195.23.16.24]:20422 "EHLO
	linuxbipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S1030296AbWBPMIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 07:08:00 -0500
Message-ID: <43F46B1C.3070208@grupopie.com>
Date: Thu, 16 Feb 2006 12:07:56 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paulo Marques <pmarques@grupopie.com>
CC: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [SOLVED] Trap flag handling change in 2.6.10-bk5 broke Kylix
 debugger
References: <43F23BB4.8070703@grupopie.com> <Pine.LNX.4.64.0602141243020.3691@g5.osdl.org> <43F36833.9060100@grupopie.com>
In-Reply-To: <43F36833.9060100@grupopie.com>
Content-Type: multipart/mixed;
 boundary="------------040803030409060601080502"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040803030409060601080502
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Paulo Marques wrote:
> Linus Torvalds wrote:
>> [...]
>> Hmm. You could try variations on the appended patch. Try changing the 
>> "#if 0" to "#if 1" in various combinations, to see which one Kylix 
>> seems to care about.
> [...]
> Anyway, I thought of trying to attach a strace to the debugger tonight 
> to try to see exactly what the debugger is doing. Is this supposed to 
> work? Or trying to trace a process that is itself tracing another 
> process a no-no and can give unreliable results?

After another hacking session last night with Paulo Costa, we found the 
problem.

The debugger process launches another 2 processes. One of them is 
supposed to be replaced by the running application if it works ok.

When attaching a strace to the parent process (pid 7660) we got this:

....
ptrace(PTRACE_GETREGS, 7662, 0, 0xbfe00e84) = 0
ptrace(PTRACE_SINGLESTEP, 7662, 0, SIG_0) = 0
wait4(7662, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGTRAP}], 0, NULL) = 7662
ptrace(PTRACE_GETREGS, 7662, 0, 0xbfe00e84) = 0
ptrace(PTRACE_SINGLESTEP, 7662, 0, SIG_0) = 0
wait4(7662, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGTRAP}], 0, NULL) = 7662
ptrace(PTRACE_GETREGS, 7662, 0, 0xbfe00e84) = 0
...

It seemed that the process was stuck in a loop doing single step on a 
child process, getting the regs and repeating.

Since the change that made this behavior appear was to hide the trap 
flag from user space, we tried to unconditionally set the value of the 
trap flag returned to user space when handling PTRACE_GETREGS.

With this change the debugger no longer hanged on the same spot, but 
complained later. This was probably because it was receiveing the trap 
flag when it wasn't expecting it.

I changed the unconditional set of the flag to:

+		if (test_tsk_thread_flag(child, TIF_SINGLESTEP))
+			regs->eflags |= TRAP_FLAG;

and the debugger got a little further, but still had problems. I straced 
it again and saw that it was also using PTRACE_SETREGS, probably sending 
the same flag values it received, and that was causing problems.

We then filtered the trap flag in PTRACE_SETREGS, too. The result is the 
attached patch. The debugger worked fine with this patch applied on top 
of a vanilla 2.6.16-rc3 kernel.

This is an extremelly ugly hack, specially because it basically shows 
the trap flag again, which is exactly what we wanted to avoid when the 
2.6.10-bk5 kernel code was written.

Anyway, since it only affected the ptrace call, I tried to solve this 
using a LD_PRELOAD stub on the ptrace function in user-space. The 
debugger is actually a dynamic executable and indeed had the ptrace 
undefined symbol, so my chances were good.

The result was the attached program that interposes the ptrace call and 
sets / clears the trap flag to fool the kylix debugger.

The problem with this approach is that it is not easy to see from user 
space if the child process is being single stepped or not.

I tried to replace the kernel code:

+ if (test_tsk_thread_flag(child, TIF_SINGLESTEP))

with:

+ ret = func(PTRACE_PEEKUSER, pid, &(((struct user *) 
0)->u_debugreg[6]), NULL);
+ if (ret & DR_STEP)

because in arch/i386/kernel/traps.c there is this code:

	/* Save debug status register where ptrace can see it */
	tsk->thread.debugreg[6] = condition;

	/*
	 * Single-stepping through TF: make sure we ignore any events in
	 * kernel space (but re-enable TF when returning to user mode).
	 */
	if (condition & DR_STEP) {

that made it look like there was some single stepping information stored 
in debugreg[6]. However, the debugger didn't work, so I suppose that 
debugreg isn't updated as often as I wanted to, or something like that.

I did a workaround in the interposer (remembering that a single step was 
requested so that it sets the trap flag on the next call to ptrace) and 
the debugger actually works, but I would prefer to do it better.

BTW, is there a good way to do the "test_tsk_thread_flag(child, 
TIF_SINGLESTEP)" from user space?

Well, it seems that this problem is solved and the kernel won't have to 
change a very sensitive area (Wine and DOSEMU breakages spring to mind). 
I'll just try to get some feedback from other kylix users on whether the 
stub works for them or not, to make sure everything is ok.

Thanks for all the help. It was basically this:

> With the new semantics, the process doesn't see that it's being debugged 
> any more because the TF flag change is now hidden from the signal stack. 
> That indirectly also means that the debugger itself only sees TF change in 
> the register state if the process itself set it (not if the TF bit was set 
> implicitly by the debugger asking for a singlestep event).

that set us on the right track :)

-- 
Paulo Marques - www.grupopie.com

Pointy-Haired Boss: I don't see anything that could stand in our way.
            Dilbert: Sanity? Reality? The laws of physics?

--------------040803030409060601080502
Content-Type: text/plain;
 name="trap_flag_hack"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="trap_flag_hack"

--- ./arch/i386/kernel/ptrace.c.orig	2006-02-16 02:01:15.000000000 +0000
+++ ./arch/i386/kernel/ptrace.c	2006-02-16 01:57:40.000000000 +0000
@@ -362,6 +362,8 @@ long arch_ptrace(struct task_struct *chi
 	struct user * dummy = NULL;
 	int i, ret;
 	unsigned long __user *datap = (unsigned long __user *)data;
+	unsigned long old_flags;
+	struct pt_regs *regs;
 
 	switch (request) {
 	/* when I and D space are separate, these will need to be fixed. */
@@ -544,10 +546,20 @@ long arch_ptrace(struct task_struct *chi
 			ret = -EIO;
 			break;
 		}
+
+		regs = get_child_regs(child);
+		old_flags = regs->eflags;
+
+		if (test_tsk_thread_flag(child, TIF_SINGLESTEP))
+			regs->eflags |= TRAP_FLAG;
+
 		for ( i = 0; i < FRAME_SIZE*sizeof(long); i += sizeof(long) ) {
 			__put_user(getreg(child, i), datap);
 			datap++;
 		}
+
+		regs->eflags = old_flags;
+
 		ret = 0;
 		break;
 	}
@@ -558,11 +570,18 @@ long arch_ptrace(struct task_struct *chi
 			ret = -EIO;
 			break;
 		}
+
+		regs = get_child_regs(child);
+		old_flags = regs->eflags;
+
 		for ( i = 0; i < FRAME_SIZE*sizeof(long); i += sizeof(long) ) {
 			__get_user(tmp, datap);
 			putreg(child, i, tmp);
 			datap++;
 		}
+
+		regs->eflags = (regs->eflags & ~TRAP_FLAG) | (old_flags & TRAP_FLAG);
+
 		ret = 0;
 		break;
 	}

--------------040803030409060601080502
Content-Type: text/x-c;
 name="ptrace_interposer.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ptrace_interposer.c"


#define _GNU_SOURCE

#include <dlfcn.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/ptrace.h>
#include <stdarg.h>
#include <linux/user.h>

typedef long (*ptrace_func)(enum __ptrace_request, pid_t, ...);

#define TRAP_FLAG	0x100
#define DR_STEP		0x4000

long int ptrace (enum __ptrace_request __request, ...)
{
	static ptrace_func func;
	static pid_t ps_single_stepped;
	struct user_regs_struct *regs;
	va_list va;
	pid_t pid;
	void *addr, *data;
	long int ret, debug_reg;

	if (!func)
		func = (ptrace_func) dlsym(RTLD_NEXT, "ptrace");

	va_start(va, __request);
	pid = va_arg(va, pid_t);
	addr = va_arg(va, void *);
	data = va_arg(va, void *);
	va_end(va);

	if (__request == PTRACE_GETREGS || __request == PTRACE_SETREGS)
		regs = (struct user_regs_struct *) data;

	if (__request == PTRACE_SETREGS) {
		struct user_regs_struct tmp_regs;
		ret = func(PTRACE_GETREGS, pid, &tmp_regs, NULL);
		regs->eflags = (regs->eflags & ~TRAP_FLAG) | (tmp_regs.eflags & TRAP_FLAG);
	}

	ret = func(__request, pid, addr, data);

	if (__request == PTRACE_GETREGS) {
		//ret = func(PTRACE_PEEKUSER, pid, &(((struct user *) NULL)->u_debugreg[6]), NULL);
		//if (ret & DR_STEP)
		if (ps_single_stepped == pid)
			regs->eflags |= TRAP_FLAG;
	}

	if (__request == PTRACE_SINGLESTEP)
		ps_single_stepped = pid;
	else
		ps_single_stepped = 0;

	return ret;
}

--------------040803030409060601080502--
