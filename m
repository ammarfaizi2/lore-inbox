Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267571AbUIMOd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267571AbUIMOd1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 10:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267566AbUIMObI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 10:31:08 -0400
Received: from asplinux.ru ([195.133.213.194]:60686 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S266833AbUIMO1h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 10:27:37 -0400
Message-ID: <4145B111.2050008@sw.ru>
Date: Mon, 13 Sep 2004 18:39:13 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Roel van der Made <roel@telegraafnet.nl>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, torvalds@osdl.org
Subject: Re: [PATCH]: Re: kernel 2.6.9-rc1-mm4 oops
References: <20040912184804.GC19067@telegraafnet.nl> <4145550F.8030601@sw.ru> <20040913083100.GA16921@elte.hu> <41456536.6090801@sw.ru> <20040913092443.GA19437@elte.hu>
In-Reply-To: <20040913092443.GA19437@elte.hu>
Content-Type: multipart/mixed;
 boundary="------------030109000601040607040605"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030109000601040607040605
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> * Kirill Korotaev <dev@sw.ru> wrote:
>>>the BUG() is useful for all the code that uses next_thread() - you can
>>>only do a safe next_thread() iteration if you've locked ->sighand.
> 
>>1. I don't see spin_lock() on p->sighand->siglock in do_task_stat() 
>>before calling next_thread(). And the check inside next_thread() permits 
>>only one of the locks to be taken:
>>
>>        if (!spin_is_locked(&p->sighand->siglock) &&
>>                                !rwlock_is_locked(&tasklist_lock))
>>
>>which is probably wrong, since tasklist_lock is always required!
> 
> It's not 'wrong' in terms of correctness it's simply too restrictive for
> no reason. I agree that we should check for the tasklist lock only.
that is what I wanted to say :)
I removed check for siglock being locked and changed check for sighand 
!= NULL to pid.nr check as we discussed below.

>>2. I think the idea of checking sighand is quite obscure. Probably it
>>would be better to call pid_alive() for check at such places in proc,
>>isn't it?
> yeah, it's just as good of a check.
So I replaced the check in your patch with pid_alive() one, ok?

>>But I would propose to reorganize these checks in next_thread() to
>>something like this:
>>
>>if (!rwlock_is_locked(&tasklist_lock) || p->pids[PIDTYPE_TGID].nr == 0)
>>	BUG();
>>
>>the last check ensures that we are still hashed and this check is more 
>>straithforward for understanding, agree?
> yep - please send a new patch to Andrew.
here it is, please review it as well.

There are 2 patches here:

diff-next_thread (for both linus and 2.6.9-rc1-mm4 trees)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
This patch changes obscure BUG() checks in next_thread() with pid checks 
meaning exactly the same (It checks for task being hashed).

Signed-Off-By: Kirill Korotaev <dev@sw.ru>

diff-task_stat (for 2.6.9-rc1-mm4 tree)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
This patch fixes BUG() happening in do_task_stat()->next_thread(), since 
tsk->sighand can be NULL there. It adds check for pid_alive() in 
do_task_stat() to prevent thread loop for already unhashed task.

Signed-Off-By: Kirill Korotaev <dev@sw.ru>

Kirill

--------------030109000601040607040605
Content-Type: text/plain;
 name="diff-task_stat"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-task_stat"

--- ./include/linux/sched.h.nt	2004-09-13 18:00:12.000000000 +0400
+++ ./include/linux/sched.h	2004-09-13 18:06:03.680828072 +0400
@@ -699,6 +699,12 @@ extern struct task_struct *find_task_by_
 extern void set_special_pids(pid_t session, pid_t pgrp);
 extern void __set_special_pids(pid_t session, pid_t pgrp);
 
+/* checks whether task is still hashed and can be accessed safely */
+static inline int pid_alive(struct task_struct *p)
+{
+	return p->pids[PIDTYPE_PID].nr != 0;
+}
+
 /* per-UID process charging. */
 extern struct user_struct * alloc_uid(uid_t);
 static inline struct user_struct *get_uid(struct user_struct *u)
--- ./fs/proc/array.c.nt	2004-09-13 18:00:09.178720584 +0400
+++ ./fs/proc/array.c	2004-09-13 18:00:51.861231856 +0400
@@ -356,7 +356,7 @@ static int do_task_stat(struct task_stru
 			stime = task->signal->stime;
 		}
 	}
-	if (whole) {
+	if (whole && pid_alive(task)) {
 		t = task;
 		do {
 			min_flt += t->min_flt;
--- ./fs/proc/base.c.nt	2004-09-13 18:00:09.181720128 +0400
+++ ./fs/proc/base.c	2004-09-13 18:00:51.862231704 +0400
@@ -793,11 +793,6 @@ static struct inode_operations proc_pid_
 	.follow_link	= proc_pid_follow_link
 };
 
-static inline int pid_alive(struct task_struct *p)
-{
-	return p->pids[PIDTYPE_PID].nr != 0;
-}
-
 #define NUMBUF 10
 
 static int proc_readfd(struct file * filp, void * dirent, filldir_t filldir)

--------------030109000601040607040605
Content-Type: text/plain;
 name="diff-next_thread"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-next_thread"

--- ./kernel/exit.c.nt	2004-09-13 18:00:12.727181136 +0400
+++ ./kernel/exit.c	2004-09-13 18:00:51.864231400 +0400
@@ -848,10 +848,7 @@ asmlinkage long sys_exit(int error_code)
 task_t fastcall *next_thread(const task_t *p)
 {
 #ifdef CONFIG_SMP
-	if (!p->sighand)
-		BUG();
-	if (!spin_is_locked(&p->sighand->siglock) &&
-				!rwlock_is_locked(&tasklist_lock))
+	if (!rwlock_is_locked(&tasklist_lock) || p->pids[PIDTYPE_TGID].nr == 0)
 		BUG();
 #endif
 	return pid_task(p->pids[PIDTYPE_TGID].pid_list.next, PIDTYPE_TGID);

--------------030109000601040607040605--

