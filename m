Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbTISSkx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 14:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbTISSkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 14:40:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:31442 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261676AbTISSku (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 14:40:50 -0400
Date: Fri, 19 Sep 2003 11:21:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Omen Wild <Omen.Wild@Dartmouth.EDU>
Cc: linux-kernel@vger.kernel.org
Subject: Re: call_usermodehelper does not report exit status?
Message-Id: <20030919112148.42adf179.akpm@osdl.org>
In-Reply-To: <20030919162422.GB2236@descolada.dartmouth.edu>
References: <20030919162422.GB2236@descolada.dartmouth.edu>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Omen Wild <Omen.Wild@Dartmouth.EDU> wrote:
>
> I found the call_usermodehelper function and
> call it with the wait flag set, but I cannot get a non-zero return
> status of the program to propagate into the kernel.

This might fix it.

 25-akpm/kernel/exit.c |   21 +++++++++++++++++----
 25-akpm/kernel/kmod.c |    2 +-
 2 files changed, 18 insertions(+), 5 deletions(-)

diff -puN kernel/kmod.c~call_usermodehelper-retval-fix kernel/kmod.c
--- 25/kernel/kmod.c~call_usermodehelper-retval-fix	Fri Sep 19 11:14:47 2003
+++ 25-akpm/kernel/kmod.c	Fri Sep 19 11:20:14 2003
@@ -190,7 +190,7 @@ static int wait_for_helper(void *data)
 		/* We don't have a SIGCHLD signal handler, so this
 		 * always returns -ECHILD, but the important thing is
 		 * that it blocks. */
-		sys_wait4(pid, NULL, 0, NULL);
+		sys_wait4(pid, &sub_info->retval, 0, NULL);
 
 	complete(sub_info->complete);
 	return 0;
diff -puN kernel/exit.c~call_usermodehelper-retval-fix kernel/exit.c
--- 25/kernel/exit.c~call_usermodehelper-retval-fix	Fri Sep 19 11:16:59 2003
+++ 25-akpm/kernel/exit.c	Fri Sep 19 11:20:10 2003
@@ -883,10 +883,17 @@ static int wait_task_zombie(task_t *p, u
 
 	retval = ru ? getrusage(p, RUSAGE_BOTH, ru) : 0;
 	if (!retval && stat_addr) {
+		int stat;
+
 		if (p->signal->group_exit)
-			retval = put_user(p->signal->group_exit_code, stat_addr);
+			stat = p->signal->group_exit_code;
+		else
+			stat = p->exit_code;
+
+		if (current->mm)
+			retval = put_user(stat, stat_addr);
 		else
-			retval = put_user(p->exit_code, stat_addr);
+			retval = __put_user(stat, stat_addr);
 	}
 	if (retval) {
 		p->state = TASK_ZOMBIE;
@@ -987,8 +994,14 @@ static int wait_task_stopped(task_t *p, 
 	write_unlock_irq(&tasklist_lock);
 
 	retval = ru ? getrusage(p, RUSAGE_BOTH, ru) : 0;
-	if (!retval && stat_addr)
-		retval = put_user((exit_code << 8) | 0x7f, stat_addr);
+	if (!retval && stat_addr) {
+		int stat = (exit_code << 8) | 0x7f;
+
+		if (current->mm)
+			retval = put_user(stat, stat_addr);
+		else
+			retval = __put_user(stat, stat_addr);
+	}
 	if (!retval)
 		retval = p->pid;
 	put_task_struct(p);

_

