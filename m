Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269167AbUINGcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269167AbUINGcD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 02:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269156AbUING2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 02:28:43 -0400
Received: from asplinux.ru ([195.133.213.194]:3592 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S269167AbUING1j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 02:27:39 -0400
Message-ID: <41469212.5030301@sw.ru>
Date: Tue, 14 Sep 2004 10:39:14 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.9-rc1-mm5
References: <20040913015003.5406abae.akpm@osdl.org>	<4145BACE.8090005@sw.ru> <20040913130107.5230138b.akpm@osdl.org>
In-Reply-To: <20040913130107.5230138b.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------050803050405000508010402"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050803050405000508010402
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> Kirill Korotaev <dev@sw.ru> wrote:

>>Please replace patch next_thread-bug-fixes.patch in -mm5 tree with the 
>>last diff-next_thread I sent to you.
>
> I was planning on replacing it with Ingo's patch.
1. next_thread-bug-fixes.patch has nothing to do with Ingo's patch.
next_thread-bug-fixes.patch is cosmetic and a bit unfull (it should 
better check that the process is still hashed, which I added in my patch).
So I ask you to replace it with diff-next_thread (I resend it once 
again), which fixes original kernel and should replace the above patch 
in your tree.

The comments for this patch
~~~~~~~~~~~~~~~~~~~~~~~~~~~
This patch changes obscure BUG() checks in next_thread()
with pid checks meaning exactly the same (It simply checks if the task
is still hashed). Also original check was incorrect since it required
ANY of the locks (siglock or tasklist_lock) while siglock is not 
required at all and tasklist_lock is ALWAYS required.

Signed-Off-By: Kirill Korotaev <dev@sw.ru>

2. The BUG() which is resolved in Ingo's patch is fixed in -mm5 tree 
with show-aggregate-per-process-counters-in-proc-pid-stat-2.patch
So you needn't to apply Ingo's patch.

> --- linux/fs/proc/array.c.orig
> +++ linux/fs/proc/array.c
> @@ -356,7 +356,7 @@ static int do_task_stat(struct task_stru
>   			stime = task->signal->stime;
>   		}
>   	}
> -	if (whole) {
> +	if (whole && task->sighand) {
> 
> Is there some reason why your patch is better?  If so, please do a full
> resend.

My patch was a bit more self explaining as we discussed with Ingo.
But due to being already fixed, I don't think you have to bother with it.

Kirill

--------------050803050405000508010402
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

--------------050803050405000508010402--

