Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265800AbSLIQxJ>; Mon, 9 Dec 2002 11:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265806AbSLIQxJ>; Mon, 9 Dec 2002 11:53:09 -0500
Received: from miranda.axis.se ([193.13.178.2]:20430 "EHLO miranda.axis.se")
	by vger.kernel.org with ESMTP id <S265800AbSLIQxG>;
	Mon, 9 Dec 2002 11:53:06 -0500
Message-ID: <3C6BEE8B5E1BAC42905A93F13004E8AB017DE4E9@mailse01.axis.se>
From: Mikael Starvik <mikael.starvik@axis.com>
To: "'Linus Torvalds'" <torvalds@transmeta.com>,
       "'Daniel Jacobowitz'" <dan@debian.org>
Cc: "'george anzinger'" <george@mvista.com>,
       "'Jim Houston'" <jim.houston@ccur.com>,
       "'Stephen Rothwell'" <sfr@canb.auug.org.au>,
       "'LKML'" <linux-kernel@vger.kernel.org>,
       "'anton@samba.org'" <anton@samba.org>,
       "'David S. Miller'" <davem@redhat.com>, "'ak@muc.de'" <ak@muc.de>,
       "'davidm@hpl.hp.com'" <davidm@hpl.hp.com>,
       "'schwidefsky@de.ibm.com'" <schwidefsky@de.ibm.com>,
       "'ralf@gnu.org'" <ralf@gnu.org>,
       "'willy@debian.org'" <willy@debian.org>
Subject: RE: [PATCH] compatibility syscall layer (lets try again)
Date: Mon, 9 Dec 2002 17:58:40 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No problem for CRIS architechture (port will be submitted when 2.5.51
has been released if that happens before xmas).

/Mikael

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Linus Torvalds
Sent: Monday, December 09, 2002 5:48 PM
To: Daniel Jacobowitz
Cc: george anzinger; Jim Houston; Stephen Rothwell; LKML;
anton@samba.org; David S. Miller; ak@muc.de; davidm@hpl.hp.com;
schwidefsky@de.ibm.com; ralf@gnu.org; willy@debian.org
Subject: Re: [PATCH] compatibility syscall layer (lets try again)




On Mon, 9 Dec 2002, Daniel Jacobowitz wrote:
>
> Well, here's something to consider.  This isn't entirely hypothetical;
> there are test cases in GDB's regression suite that cover nearly this.
>
> Suppose a process is sleeping for an hour.  The user wants to see what
> another thread is doing, so he hits Control-C; the thread which happens
> to be reported as 'current' is the one that was in nanosleep().  It
> used to be that when he said continue, the nanosleep would return; now
> hopefully it'll continue.  Great!  But this damnable user isn't done
> yet.  He wants to look at one of his data structures.  He calls a
> debugging print_foo() function from GDB.  He realizes he left a
> sleep-for-a-minute nanosleep call in it and C-c's again.  Now we have
> two interrupted nanosleep calls and the application will never see a
> signal to interrupt either of them; he says "continue" twice and
> expects to get back to his hour-long sleep.

Ok, this will definitely not work with the current restart mechanism.

We could make it work, but it would be rather involved. To make nesting
work correctly for the above, you could take two approaches:

 - tell gdb about the restart state through some ptrace() interface, and
   have gdb save and restore it.

 - save all the restart state in user space registers/memory (on the
   stack, for example), so that it automatically nests correctly.

The second approach has the advantage that that not only would it work
with unmodified gdb binaries, it would also allow us to nest correctly
over a signal handler invocation, which is needed if we ever allow
restarting even if a handler is invoced.

It's not really hard to do, but both approaches open up restarting to
potential security issues, ie now you have to make sure that you're not
leaking kernel data or forgetting to check something over a restart. That
doesn't matter for nanosleep() itself (none of the data there is in any
way security-conscious, even if one of the restart arguments has been
modified to the in-kernel "jiffies" representation), but it might make a
difference for other system calls.

If you want to test this out and play with it, the x86 implementation is
pretty easy. I don't know how nasty it can be to re-initialize the system
call argument registers on other architectures, but going through the
do_signal() logic _should_ mean that we have access to all user mode
register state (otherwise ptrace() wouldn't work on such architectures).

NOTE NOTE NOTE! This patch is totally untested. It may or may not compile
and work. It _looks_ correct, but that's all I'm going to guarantee about
it.

Architecture maintainers, can you comment on how easy/hard it is to do the
same thing on your architectures? I _assume_ it's trivial (akin to the
three-liner register state change in i386/kernel/signal.c).

		Linus

===== arch/i386/kernel/signal.c 1.22 vs edited =====
--- 1.22/arch/i386/kernel/signal.c	Fri Dec  6 09:43:43 2002
+++ edited/arch/i386/kernel/signal.c	Mon Dec  9 08:39:57 2002
@@ -594,7 +594,10 @@
 			regs->eip -= 2;
 		}
 		if (regs->eax == -ERESTART_RESTARTBLOCK){
+			struct restart_block *restart = &current_thread_info()->restart_block;
 			regs->eax = __NR_restart_syscall;
+			regs->ebx = restart->arg0;
+			regs->ecx = restart->arg1;
 			regs->eip -= 2;
 		}
 	}
===== include/linux/thread_info.h 1.4 vs edited =====
--- 1.4/include/linux/thread_info.h	Fri Dec  6 09:43:43 2002
+++ edited/include/linux/thread_info.h	Mon Dec  9 08:44:56 2002
@@ -11,11 +11,11 @@
  * System call restart block.
  */
 struct restart_block {
-	long (*fn)(struct restart_block *);
-	unsigned long arg0, arg1, arg2;
+	long (*fn)(unsigned long arg0, unsigned long arg1);
+	unsigned long arg0, arg1;
 };

-extern long do_no_restart_syscall(struct restart_block *parm);
+extern long do_no_restart_syscall(unsigned long arg0, unsigned long arg1);

 #include <linux/bitops.h>
 #include <asm/thread_info.h>
===== kernel/signal.c 1.55 vs edited =====
--- 1.55/kernel/signal.c	Fri Dec  6 11:08:28 2002
+++ edited/kernel/signal.c	Mon Dec  9 08:45:19 2002
@@ -1351,13 +1351,13 @@
  * System call entry points.
  */

-asmlinkage long sys_restart_syscall(void)
+asmlinkage long sys_restart_syscall(unsigned long arg0, unsigned long arg1)
 {
 	struct restart_block *restart = &current_thread_info()->restart_block;
-	return restart->fn(restart);
+	return restart->fn(arg0, arg1);
 }

-long do_no_restart_syscall(struct restart_block *param)
+long do_no_restart_syscall(unsigned long arg0, unsigned long arg1)
 {
 	return -EINTR;
 }
===== kernel/timer.c 1.37 vs edited =====
--- 1.37/kernel/timer.c	Fri Dec  6 11:10:33 2002
+++ edited/kernel/timer.c	Mon Dec  9 08:42:36 2002
@@ -1021,10 +1021,10 @@
 	return current->pid;
 }

-static long nanosleep_restart(struct restart_block *restart)
+static long nanosleep_restart(unsigned long arg0, unsigned long arg1)
 {
-	unsigned long expire = restart->arg0, now = jiffies;
-	struct timespec *rmtp = (struct timespec *) restart->arg1;
+	unsigned long expire = arg0, now = jiffies;
+	struct timespec *rmtp = (struct timespec *) arg1;
 	long ret;

 	/* Did it expire while we handled signals? */

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
