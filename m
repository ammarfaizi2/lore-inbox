Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131630AbRDPRFk>; Mon, 16 Apr 2001 13:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131638AbRDPRFb>; Mon, 16 Apr 2001 13:05:31 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:9176 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131630AbRDPRFQ>; Mon, 16 Apr 2001 13:05:16 -0400
Message-ID: <3ADB2522.6A0C579C@uow.edu.au>
Date: Mon, 16 Apr 2001 10:00:18 -0700
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-ac5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: Rod Stewart <stewart@dystopia.lab43.org>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andreas Ferber <aferber@techfak.uni-bielefeld.de>
Subject: Re: [new PATCH] Re: 8139too: defunct threads
In-Reply-To: <Pine.LNX.4.33.0104150100210.13758-100000@dystopia.lab43.org> <3AD99CE4.E1ED7090@colorfullife.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> 
> I found the problem:
> 
> * init uses waitpid(-1,,), thus the __WALL flag is not set
> * without __WALL, only processes with exit_signal == SIGCHLD are reaped
> * it's impossible for user space processes to die with another
> exit_signal, forget_original_parent changes the exit_signal back to
> SIGCHLD ("We dont want people slaying init"), and init itself doesn't
> use clone.
> * kernel threads can die with an arbitrary exit_signal.

yep

> Alan, which fix would you prefer:
> * init could use wait3 and set __WALL.
> * all kernel thread users could set SIGCHLD. Some already do that
> (__call_usermodehelper).
> * the kernel_thread implementations could force the exit signal to
> SIGCHLD.

* Add SIGCHLD to all the users of kernel_thread(), in the cases
  where the thread can ever exit.

* Add
	if (current->exit_signal == 0)
		current->exit_signal = SIGCHLD;
  to daemonize().

None of these will work.  The problems with globally setting exit_signal
to SIGCHLD are that

a) If the parent does waitpid(pid, status, __WCLONE), the
   waitpid will fail.  request_module() does this.  I don't
   know _why_ it does this.  Maybe it's bogus.  There is no
   explanation.

b) When the kernel thread exits, it will send a SIGCHLD to
   its parent.  But the parent is not necessarily init!  It
   could be a userspace process (in this case, ifconfig).
   The kernel has no business spraying signals out to userspace
   tasks just because they happened to open a network interface.

   And for this reason we can't just go in and change 8139too.c
   to use SIGCHLD.

So it seems that we must reparent the thread to init, and
make sure that it delivers SIGCHLD to init when it exits.

The below patch does this, within daemonize().  But this precise
area was the source of serial screwups when I was doing the
call_usermodehelper() stuff, and I bet this approach will
still have problems.

The exit_files() will take care of releasing things like current->tty
and pwd.  But we still do not know what scheduling priority and policy
we inherited from the userspace parent, nor do we know what signal mask
we have, nor do we know what uid we're running as.  Resource limits.
Capabilties.  CPU mask.  Etcetera, etcetera.  All this stuff comes back
to bite.  Been there, got the scars :)

This is why I believe that kernel daemons should be launched by
keventd.  They belong to the *kernel*, not to userspace parents.



--- linux-2.4.4-pre3/kernel/sched.c	Sun Apr 15 15:34:25 2001
+++ linux-akpm/kernel/sched.c	Sun Apr 15 21:59:26 2001
@@ -1260,32 +1260,53 @@
 /*
  *	Put all the gunge required to become a kernel thread without
  *	attached user resources in one place where it belongs.
+ *
+ * 	Kernel 2.4.4-pre3, andrewm@uow.edu.au: reparent the caller
+ *	to init and set the exit signal to SIGCHLD so the thread
+ *	will be properly reaped if it exits.
  */
 
 void daemonize(void)
 {
 	struct fs_struct *fs;
-
+	struct task_struct *this_task = current;
 
 	/*
 	 * If we were started as result of loading a module, close all of the
 	 * user space pages.  We don't need them, and if we didn't close them
 	 * they would be locked into memory.
 	 */
-	exit_mm(current);
+	exit_mm(this_task);
 
-	current->session = 1;
-	current->pgrp = 1;
+	this_task->session = 1;
+	this_task->pgrp = 1;
 
 	/* Become as one with the init task */
 
-	exit_fs(current);	/* current->fs->count--; */
+	exit_fs(this_task);	/* this_task->fs->count--; */
 	fs = init_task.fs;
-	current->fs = fs;
+	this_task->fs = fs;
 	atomic_inc(&fs->count);
- 	exit_files(current);
-	current->files = init_task.files;
-	atomic_inc(&current->files->count);
+ 	exit_files(this_task);
+	this_task->files = init_task.files;
+	atomic_inc(&this_task->files->count);
+
+	write_lock_irq(&tasklist_lock);
+
+	/* Reparent to init */
+	REMOVE_LINKS(this_task);
+	this_task->p_opptr = child_reaper;
+	this_task->p_pptr = child_reaper;
+	SET_LINKS(this_task);
+
+	/* Set the exit signal to SIGCHLD so we signal init on exit */
+	if (this_task->exit_signal ! 0) {
+		printk(KERN_ERR "task `%s' exit_signal %d in daemonize()\n",
+			this_task->comm, this_task->exit_signal);
+	}
+	this_task->exit_signal = SIGCHLD;
+
+	write_unlock_irq(&tasklist_lock);
 }
 
 void __init init_idle(void)
