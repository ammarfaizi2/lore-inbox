Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263296AbVBCMjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263296AbVBCMjd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 07:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263387AbVBCMjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 07:39:33 -0500
Received: from dgate2.fujitsu-siemens.com ([217.115.66.36]:16404 "EHLO
	dgate2.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S263296AbVBCMi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 07:38:29 -0500
X-SBRSScore: None
X-IronPort-AV: i="3.88,175,1102287600"; 
   d="c'?scan'208"; a="2959828:sNHT40179508"
Message-ID: <42021E35.8050601@fujitsu-siemens.com>
Date: Thu, 03 Feb 2005 13:51:01 +0100
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland Mc Grath <roland@redhat.com>
CC: Jeff Dike <jdike@addtoit.com>, BlaisorBlade <blaisorblade_spam@yahoo.it>,
       user-mode-linux devel 
	<user-mode-linux-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Race condition in ptrace
Content-Type: multipart/mixed;
 boundary="------------010009020407000307030200"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010009020407000307030200
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Working with the new UML skas0 mode on my Xeon HT host, sporadically I saw
some processes on UML segfaulting.

In all cases, I could track this down to be caused by a gs segment register,
that had the wrong contents.

This again is caused by a problem in the host linux: A ptraced child going to
stop and having woken up its parent, will save some of its registers (on i386
they are fs, gs and the fp-registers) very late in switch_to. The parent is
granted access to child's registers as soon, as the child is removed from
the runqueue. Thus, in rare cases, the parent might access child's register
savearea before the registers really are saved.

This problem might also be the reason for problems with floatpoint on UML,
that were reported some time ago.

I've written a test program, that reproduces the problem on my 2.6.9 vanilla
host quite quick. Using SuSE kernel 2.6.5-7.97-smp, I can't reproduce the
problem, although the relevant parts seem to be unchanged. Maybe not related
changes modify the timing?

I also created a patch, that fixes the problem on my 2.6.9 host. This probably
isn't a sane patch, but is enough to demonstrate, where I think, the bug is.
Both files are attached.

        Bodo

--------------010009020407000307030200
Content-Type: text/x-diff;
 name="fix-ptrace-race.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-ptrace-race.patch"

--- a/include/linux/sched.h	2005-02-02 22:15:51.000000000 +0100
+++ b/include/linux/sched.h	2005-02-02 22:22:54.000000000 +0100
@@ -584,6 +584,7 @@ struct task_struct {
   	struct mempolicy *mempolicy;
   	short il_next;		/* could be shared with used_math */
 #endif
+	volatile long saving;
 };
 
 static inline pid_t process_group(struct task_struct *tsk)
--- a/kernel/sched.c	2005-02-02 21:32:51.000000000 +0100
+++ b/kernel/sched.c	2005-02-02 22:12:14.000000000 +0100
@@ -2689,8 +2689,10 @@ need_resched:
 		if (unlikely((prev->state & TASK_INTERRUPTIBLE) &&
 				unlikely(signal_pending(prev))))
 			prev->state = TASK_RUNNING;
-		else
+		else {
+			prev->saving = 1;
 			deactivate_task(prev, rq);
+		}
 	}
 
 	cpu = smp_processor_id();
--- a/kernel/ptrace.c	2005-02-02 22:12:33.000000000 +0100
+++ b/kernel/ptrace.c	2005-02-02 22:20:46.000000000 +0100
@@ -96,6 +96,7 @@ int ptrace_check_attach(struct task_stru
 
 	if (!ret && !kill) {
 		wait_task_inactive(child);
+		while ( child->saving ) ;
 	}
 
 	/* All systems go.. */
--- a/arch/i386/kernel/process.c	2005-02-02 22:18:29.000000000 +0100
+++ b/arch/i386/kernel/process.c	2005-02-02 22:19:22.000000000 +0100
@@ -577,6 +577,9 @@ struct task_struct fastcall * __switch_t
 	asm volatile("movl %%fs,%0":"=m" (*(int *)&prev->fs));
 	asm volatile("movl %%gs,%0":"=m" (*(int *)&prev->gs));
 
+	wmb();
+	prev_p->saving=0;
+
 	/*
 	 * Restore %fs and %gs if needed.
 	 */

--------------010009020407000307030200
Content-Type: text/plain;
 name="test_ptrace.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="test_ptrace.c"

#include <signal.h>
#include <unistd.h>
#include <errno.h>
#include <stdio.h>
#include <sched.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/mman.h>
#include <sys/ptrace.h>
#include <asm/ptrace.h>
#include <asm/unistd.h>
#include <asm/ldt.h>

void
write_ldt( int number)
{
	struct user_desc desc;
	int ret;

	memset(&desc, 0, sizeof( desc));
	desc.entry_number = number;
	desc.base_addr = 0x400179a0;
	desc.limit = 0xffffffff;
	desc.seg_32bit = 1;
	desc.limit_in_pages = 1;
	desc.useable = 1;
	ret = modify_ldt(1, &desc, sizeof( desc));
	if ( ret )
		printf("modify_ldt(write): ret=%d, errno=%d\n", ret, errno);
}

int
child_fn( void)
{
	unsigned int fs=7, new_fs;

	write_ldt(0);

	asm volatile ("movl %0,%%fs": : "m" (fs));

	if ( ptrace( PTRACE_TRACEME, 0, (void *)0, (void *)0) ) {
		perror("ptrace( PTRACE_TRACEME, 0, 0, 0)");
		exit(1);
	}
	asm volatile ("int $3");

	asm volatile("movl %%fs,%0":"=m" (new_fs));
	new_fs &= 0xffff;
	if ( new_fs != (fs ^ 7) ) {
		printf("Child: wrong fs = %d\n", new_fs);
		exit(1);
	}

	fs = new_fs;

	printf("Child: fs changed to %d\n", fs);

	asm volatile ("int $3");
}


int
parent_fn( pid_t child)
{
	int ret, status;
	unsigned long regs[FRAME_SIZE];

	ret = waitpid( child, &status, 0);
	if ( ret != child ) {
		fprintf( stderr, "Parent: ");
		perror("waitpid");
		exit(1);
	}
	if ( !WIFSTOPPED(status) || WSTOPSIG(status) != SIGTRAP ) {
		printf("\nParent: Childs status is %x: exiting\n", status);
		fflush( stdout);
		return (status != 0);
	}
	if ( ptrace( PTRACE_GETREGS, child, 0, regs) ) {
		fprintf( stderr, "Parent: ");
		perror("ptrace(GETREGS)");
		exit(1);
	}

	while (1) {
		regs[FS] ^= 7;
		if ( ptrace( PTRACE_SETREGS, child, 0, regs) ) {
			fprintf( stderr, "Parent: ");
			perror("ptrace(GETREGS)");
			exit(1);
		}
		if ( ptrace( PTRACE_CONT, child, 0, 0) < 0 ) {
			fprintf( stderr, "Parent: ");
			perror("ptrace( PTRACE_CONT, 0, 0, 0)");
			exit(1);
		}
		ret = waitpid( child, &status, 0);
		if ( ret != child ) {
			fprintf( stderr, "Parent: ");
			perror("waitpid");
			exit(1);
		}
		if ( !WIFSTOPPED(status) || WSTOPSIG(status) != SIGTRAP ) {
			printf("\nParent: Childs status is %x: exiting\n", status);
			fflush( stdout);
			return (status != 0);
		}
	}
}


int
main( int argc, char ** argv)
{
	int res;
	pid_t child;

	child = fork();

	if ( child < 0 ) {
		perror("fork");
		exit(1);
	}
	else if ( child ) {
		res = parent_fn( child);
		return res;
	} else {
		res = child_fn();
		return res;
	}
}

--------------010009020407000307030200--
