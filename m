Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288936AbSA2Ict>; Tue, 29 Jan 2002 03:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288946AbSA2Ick>; Tue, 29 Jan 2002 03:32:40 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45830 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S288936AbSA2Icc>;
	Tue, 29 Jan 2002 03:32:32 -0500
Message-ID: <3C565C60.9275CFDA@zip.com.au>
Date: Tue, 29 Jan 2002 00:25:04 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: war <war@starband.net>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Limits broken in 2.4.x kernel.
In-Reply-To: <3C1E5A88.57F5A68A@starband.net> <3C1E5A88.57F5A68A@starband.net>
		<shspu5dv3w4.fsf@charged.uio.no> <3C1E86BD.43EAB279@zip.com.au>,
		<3C1E86BD.43EAB279@zip.com.au> <shs3d28ade3.fsf@charged.uio.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> 
> >>>>> " " == Andrew Morton <akpm@zip.com.au> writes:
> 
>      > reparent_to_init() needs to decrement current->user's processes
>      > count, and increment root's.  I'll do a patch.
> 
> Please just convert 'set_user()' into a non-static routine. Calling
> set_user(0, 1) would do precisely what you want, and the same thing
> could then be used for kmod.
> There's no real reason for having several different local hacks that
> all do the same thing kicking around the place.
> 

I bet you thought I'd forgotten.

- Make set_user() non-static

- Convert set_user() to use cached copy of `current'

- Fix world's tiniest SMP race in set_user() - we should
  increment usage count on the old struct before decrementing the
  count on the new one - they may be the same.

- change exec_usermodehelper() to use set_user()

- change reparent_to_init() to use set_user() - fixes possible
  error in user process accounting.

It is all tested.



--- linux-2.4.18-pre7/include/linux/sched.h	Fri Dec 21 11:19:23 2001
+++ linux-akpm/include/linux/sched.h	Tue Jan 29 00:04:58 2002
@@ -150,6 +150,7 @@ extern void trap_init(void);
 extern void update_process_times(int user);
 extern void update_one_process(struct task_struct *p, unsigned long user,
 			       unsigned long system, int cpu);
+extern int set_user(uid_t new_ruid, int dumpclear);
 
 #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
--- linux-2.4.18-pre7/kernel/sys.c	Wed Jan 23 15:11:35 2002
+++ linux-akpm/kernel/sys.c	Tue Jan 29 00:07:02 2002
@@ -490,9 +490,10 @@ static inline void cap_emulate_setxuid(i
 	}
 }
 
-static int set_user(uid_t new_ruid, int dumpclear)
+int set_user(uid_t new_ruid, int dumpclear)
 {
 	struct user_struct *new_user, *old_user;
+	struct task_struct *this_task = current;
 
 	/* What if a process setreuid()'s and this brings the
 	 * new uid over his NPROC rlimit?  We can check this now
@@ -502,17 +503,16 @@ static int set_user(uid_t new_ruid, int 
 	new_user = alloc_uid(new_ruid);
 	if (!new_user)
 		return -EAGAIN;
-	old_user = current->user;
-	atomic_dec(&old_user->processes);
+	old_user = this_task->user;
 	atomic_inc(&new_user->processes);
+	atomic_dec(&old_user->processes);
 
-	if(dumpclear)
-	{
-		current->mm->dumpable = 0;
+	if (dumpclear && this_task->mm) {
+		this_task->mm->dumpable = 0;
 		wmb();
 	}
-	current->uid = new_ruid;
-	current->user = new_user;
+	this_task->uid = new_ruid;
+	this_task->user = new_user;
 	free_uid(old_user);
 	return 0;
 }
--- linux-2.4.18-pre7/kernel/sched.c	Fri Dec 21 11:19:23 2001
+++ linux-akpm/kernel/sched.c	Tue Jan 29 00:04:58 2002
@@ -1259,7 +1259,8 @@ void reparent_to_init(void)
 	this_task->cap_permitted = CAP_FULL_SET;
 	this_task->keep_capabilities = 0;
 	memcpy(this_task->rlim, init_task.rlim, sizeof(*(this_task->rlim)));
-	this_task->user = INIT_USER;
+	/* Become root */
+	set_user(0, 0);
 
 	spin_unlock(&runqueue_lock);
 	write_unlock_irq(&tasklist_lock);
--- linux-2.4.18-pre7/kernel/kmod.c	Tue Jul 17 18:23:50 2001
+++ linux-akpm/kernel/kmod.c	Tue Jan 29 00:04:58 2002
@@ -111,15 +111,8 @@ int exec_usermodehelper(char *program_pa
 		if (curtask->files->fd[i]) close(i);
 	}
 
-	/* Drop the "current user" thing */
-	{
-		struct user_struct *user = curtask->user;
-		curtask->user = INIT_USER;
-		atomic_inc(&INIT_USER->__count);
-		atomic_inc(&INIT_USER->processes);
-		atomic_dec(&user->processes);
-		free_uid(user);
-	}
+	/* Become root */
+	set_user(0, 1);
 
 	/* Give kmod all effective privileges.. */
 	curtask->euid = curtask->fsuid = 0;
