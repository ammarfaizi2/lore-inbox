Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263215AbUDPOku (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 10:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263226AbUDPOku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 10:40:50 -0400
Received: from mail.cyclades.com ([64.186.161.6]:59098 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263215AbUDPOkj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 10:40:39 -0400
Date: Fri, 16 Apr 2004 11:06:13 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: drepper@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: message queue limits
Message-ID: <20040416140613.GA2253@logos.cnet>
References: <407A2DAC.3080802@redhat.com> <20040415141846.GE2085@logos.cnet> <407EB08D.4010607@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <407EB08D.4010607@colorfullife.com>
User-Agent: Mutt/1.5.5.1i
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2004 at 05:55:57PM +0200, Manfred Spraul wrote:
> Marcelo Tosatti wrote:
> 
> >On Sun, Apr 11, 2004 at 10:48:28PM -0700, Ulrich Drepper wrote:
> > 
> >
> >>Something has to change in the way message queues are created.
> >>Currently it is possible for an unprivileged user to exhaust all mq
> >>slots so that only root can create a few more.  Any other unprivileged
> >>user has no change to create anything.
> >>
> >>I think it is necessary to create a per-user limit instead of a
> >>system-wide limit.
> >>   
> >>
> >
> >Manfred, 
> >
> >Are you looking into this already? I'm doing so for queued signals 
> >(max_nr_signals global limit).
> > 
> >
> Ahm, not really. Actually:
> I had noticed the queued signal report on lkml and decided to wait for 
> the patch that fixes the signal limit. I assume I'll be able to clone 
> the fix and apply it to ipc/mqueue.c.

Ulrich, Andrew, Manfred,

This should be working, but for some reason rlim[RLIMIT_MSGQUEUE].rlim_cur of
all tasks is 0, remembering it sets init_tasks's value at ipc/mqueue.c's __init function:

	init_task.rlim[RLIMIT_MSGQUEUE].rlim_cur = 64;
	init_task.rlim[RLIMIT_MSGQUEUE].rlim_max = 64;

Probably something stupid.

It may be interesting to move the mqueue pending count to the new task at "setuid()", 

diff -Nur linux-2.6.5.org/include/linux/sched.h linux-2.6.5/include/linux/sched.h
--- linux-2.6.5.org/include/linux/sched.h	2004-04-15 19:20:57.000000000 -0300
+++ linux-2.6.5/include/linux/sched.h	2004-04-15 20:25:18.000000000 -0300
@@ -310,6 +310,9 @@
 	atomic_t __count;	/* reference count */
 	atomic_t processes;	/* How many processes does this user have? */
 	atomic_t files;		/* How many open files does this user have? */
+	atomic_t signal_pending; /* How many pending signals does this user have? */
+	/* protected by mq_lock 	*/
+	int msg_queues; 	/* How many message queues does this user have? */
 
 	/* Hash table maintenance information */
 	struct list_head uidhash_list;
diff -Nur linux-2.6.5.org/ipc/mqueue.c linux-2.6.5/ipc/mqueue.c
--- linux-2.6.5.org/ipc/mqueue.c	2004-04-15 19:20:57.000000000 -0300
+++ linux-2.6.5/ipc/mqueue.c	2004-04-16 10:07:13.000000000 -0300
@@ -43,7 +43,7 @@
 #define CTL_MSGSIZEMAX 	4
 
 /* default values */
-#define DFLT_QUEUESMAX	64	/* max number of message queues */
+#define DFLT_QUEUESMAX	256		/* max number of message queues */
 #define DFLT_MSGMAX 	40	/* max number of messages in each queue */
 #define HARD_MSGMAX 	(131072/sizeof(void*))
 #define DFLT_MSGSIZEMAX 16384	/* max message size */
@@ -217,6 +217,14 @@
 
 	spin_lock(&mq_lock);
 	queues_count--;
+
+	/* 
+	 * If we create mqueues, then "setuid()", and destroy 
+	 * mqueues later on (with the new uid), msg_queues 
+	 * can get negative.
+	 */
+	if (current->user->msg_queues > 0)
+		current->user->msg_queues--;
 	spin_unlock(&mq_lock);
 }
 
@@ -225,13 +233,16 @@
 {
 	struct inode *inode;
 	int error;
+	struct task_struct *p = current;
 
 	spin_lock(&mq_lock);
-	if (queues_count >= queues_max && !capable(CAP_SYS_RESOURCE)) {
+	if (queues_count >= queues_max && !capable(CAP_SYS_RESOURCE) &&
+	  p->user->msg_queues >= p->rlim[RLIMIT_MSGQUEUE].rlim_cur)
 		error = -ENOSPC;
 		goto out_lock;
-	}
+
 	queues_count++;
+	p->user->msg_queues++;
 	spin_unlock(&mq_lock);
 
 	inode = mqueue_get_inode(dir->i_sb, mode);
@@ -239,6 +250,7 @@
 		error = -ENOMEM;
 		spin_lock(&mq_lock);
 		queues_count--;
+		p->user->msg_queues--;
 		goto out_lock;
 	}
 
@@ -1202,6 +1214,9 @@
 	/* internal initialization - not common for vfs */
 	queues_count = 0;
 	spin_lock_init(&mq_lock);
+	
+	init_task.rlim[RLIMIT_MSGQUEUE].rlim_cur = 64;
+	init_task.rlim[RLIMIT_MSGQUEUE].rlim_max = 64;
 
 	return 0;
 
diff -Nur linux-2.6.5.org/kernel/user.c linux-2.6.5/kernel/user.c
--- linux-2.6.5.org/kernel/user.c	2004-04-15 11:14:05.000000000 -0300
+++ linux-2.6.5/kernel/user.c	2004-04-16 10:14:00.000000000 -0300
@@ -30,7 +30,9 @@
 struct user_struct root_user = {
 	.__count	= ATOMIC_INIT(1),
 	.processes	= ATOMIC_INIT(1),
-	.files		= ATOMIC_INIT(0)
+	.files		= ATOMIC_INIT(0),
+	.signal_pending = ATOMIC_INIT(0),
+	.msg_queues = 0
 };
 
 /*
@@ -98,6 +100,9 @@
 		atomic_set(&new->processes, 0);
 		atomic_set(&new->files, 0);
 
+		new->msg_queues = 0;
+		
+
 		/*
 		 * Before adding this, check whether we raced
 		 * on adding the same user already..
--- linux-2.6.5.org/include/asm-i386/resource.h	2004-04-15 11:13:28.000000000 -0300
+++ linux-2.6.5/include/asm-i386/resource.h	2004-04-15 19:26:25.000000000 -0300
@@ -16,8 +16,10 @@
 #define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_SIGPENDING 11		/* max number of pending signals */
+#define RLIMIT_MSGQUEUE 12		/* max number of POSIX msg queues */
 
-#define RLIM_NLIMITS	11
+#define RLIM_NLIMITS	13
 
 /*
  * SuS says limits have to be unsigned.
