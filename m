Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131663AbQLRPyh>; Mon, 18 Dec 2000 10:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131762AbQLRPy1>; Mon, 18 Dec 2000 10:54:27 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:59637 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131663AbQLRPyR>; Mon, 18 Dec 2000 10:54:17 -0500
Message-ID: <3A3E2D2C.355F2FA2@uow.edu.au>
Date: Tue, 19 Dec 2000 02:28:44 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: "shuu@wondernetworkresources.com" <shuu@wondernetworkresources.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: [patch] unblock signals in exec_usermodehelper
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Shuu Yamaguchi has found an interesting problem.  When 8139too
is managed by /sbin/hotplug, 8139too's kernel thread becomes
unkillable.  Attempts to close the interface cause ifconfig
to get stuck in D state, etc...

This is because keventd blocks all signals except SIGCHLD.

keventd parents /sbin/hotplug, which parents ifconfig, 
which parents the 8139too kernel thread.  The net
result is that the 8139too kernel thread blocks
SIGTERM via its current->blocked.  SIGTERM is supposed
to stop it.

Obviously, 8139too should be more defensive about
its environment and I will address that in a separate
patch.

However I suggest that the kernel should be running usermode
processes in a more predictable environment,  so this
patch simply unblocks all signals and calls recalc_sigpending()
just prior to doing the execve().  The rest of this patch
is just the standard optimisation of caching `current'
in a local variable.

This affects modprobe as well.  Currently, modprobe
is executed with basically a random current->blocked.
It gets whatever its parent gives it, and its parent
can be anyone who autoloads a module.

Generally, the recent proliferation of kernel threads
and signal handlers in the kernel is causing us some
trouble.  I suggest that we soon move to a scheme
where kernel threads are _always_ parented by keventd.
This is very simple to do.

For example, I have a bad feeling that if user Fred
has CAP_NET_ADMIN and he opens the 8139too device,
the 8139too thread will run with uid=Fred.  If user
Bill also has CAP_NET_ADMIN, Bill won't be able to close
the device if he can't send SIGTERM to Fred's process.

For another example, I suspect that if a process
opens the 8139too device and then, for some other
reason does a waitpid(), and then someone closes
the device, the original opener will receive
notification of the exit of a child which it didn't
know it had.




--- linux-2.4.0-test13-pre3/kernel/kmod.c	Tue Dec 12 19:24:23 2000
+++ linux-akpm/kernel/kmod.c	Tue Dec 19 01:43:07 2000
@@ -11,6 +11,9 @@
 	Limit the concurrent number of kmod modprobes to catch loops from
 	"modprobe needs a service that is in a module".
 	Keith Owens <kaos@ocs.com.au> December 1999
+
+	Unblock all signals when we exec a usermode process.
+	Shuu Yamaguchi <shuu@wondernetworkresources.com> December 2000
 */
 
 #define __KERNEL_SYSCALLS__
@@ -83,9 +86,10 @@
 int exec_usermodehelper(char *program_path, char *argv[], char *envp[])
 {
 	int i;
+	struct task_struct *curtask = current;
 
-	current->session = 1;
-	current->pgrp = 1;
+	curtask->session = 1;
+	curtask->pgrp = 1;
 
 	use_init_fs_context();
 
@@ -95,19 +99,21 @@
 	   as the super user right after the execve fails if you time
 	   the signal just right.
 	*/
-	spin_lock_irq(&current->sigmask_lock);
-	flush_signals(current);
-	flush_signal_handlers(current);
-	spin_unlock_irq(&current->sigmask_lock);
+	spin_lock_irq(&curtask->sigmask_lock);
+	sigemptyset(&curtask->blocked);
+	flush_signals(curtask);
+	flush_signal_handlers(curtask);
+	recalc_sigpending(curtask);
+	spin_unlock_irq(&curtask->sigmask_lock);
 
-	for (i = 0; i < current->files->max_fds; i++ ) {
-		if (current->files->fd[i]) close(i);
+	for (i = 0; i < curtask->files->max_fds; i++ ) {
+		if (curtask->files->fd[i]) close(i);
 	}
 
 	/* Drop the "current user" thing */
 	{
-		struct user_struct *user = current->user;
-		current->user = INIT_USER;
+		struct user_struct *user = curtask->user;
+		curtask->user = INIT_USER;
 		atomic_inc(&INIT_USER->__count);
 		atomic_inc(&INIT_USER->processes);
 		atomic_dec(&user->processes);
@@ -115,9 +121,9 @@
 	}
 
 	/* Give kmod all effective privileges.. */
-	current->euid = current->fsuid = 0;
-	current->egid = current->fsgid = 0;
-	cap_set_full(current->cap_effective);
+	curtask->euid = curtask->fsuid = 0;
+	curtask->egid = curtask->fsgid = 0;
+	cap_set_full(curtask->cap_effective);
 
 	/* Allow execve args to be in kernel space. */
 	set_fs(KERNEL_DS);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
