Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271187AbUJVLCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271187AbUJVLCs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 07:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271170AbUJVLCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 07:02:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23700 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S271174AbUJVLCI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 07:02:08 -0400
Date: Fri, 22 Oct 2004 04:01:54 -0700
Message-Id: <200410221101.i9MB1sMi029552@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org
Subject: Re: NPTL: Parent thread receives SIGHUP when child thread terminates?
In-Reply-To: Petr Vandrovec's message of  Thursday, 21 October 2004 12:13:13 +0200 <20041021101313.GA19246@vana.vc.cvut.cz>
X-Shopping-List: (1) Ignominious opinions
   (2) Catastrophic travesty harmonizers
   (3) Impetuous honey
   (4) Tropical pageantry apparitions
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   When process is session leader, is it supposed to receive SIGHUP when child
> thread terminates?

Nope, this is certainly wrong.

>   Probably disassociate_ctty(1) in do_exit() should not be invoked for all
> tsk->signal->leader, but only for those with thread_group_empty() == 1, i.e.
> when this process is really going away ?  Or only for thread group leader?

Indeed, but that particular kind of test is subject to race conditions.  I
think the easiest way to fix this is to use the bookkeeping I added to get
process accounting correct (another thing that has to happen on the last
thread's death).  Start with this patch:

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9/2.6.9-mm1/broken-out/acct-report-single-record-for-multithreaded-process.patch


Then throw this one on top.


Thanks,
Roland


---

The session leader should disassociate from its controlling terminal and
send SIGHUP signals only when the whole session leader process dies.
Currently, this gets done when any thread in that process dies, which is
wrong.  This patch fixes it.  


Signed-off-by: Roland McGrath <roland@redhat.com>

--- linux-2.6/kernel/exit.c.acct
+++ linux-2.6/kernel/exit.c
@@ -783,6 +783,7 @@ static void exit_notify(struct task_stru
 asmlinkage NORET_TYPE void do_exit(long code)
 {
 	struct task_struct *tsk = current;
+	int group_dead;
 
 	profile_task_exit(tsk);
 
@@ -807,7 +808,8 @@ asmlinkage NORET_TYPE void do_exit(long 
 		ptrace_notify((PTRACE_EVENT_EXIT << 8) | SIGTRAP);
 	}
 
-	if (atomic_dec_and_test(&tsk->signal->live))
+	group_dead = atomic_dec_and_test(&tsk->signal->live);
+	if (group_dead)
 		acct_process(code);
 	__exit_mm(tsk);
 
@@ -818,7 +820,7 @@ asmlinkage NORET_TYPE void do_exit(long 
 	exit_thread();
 	exit_keys(tsk);
 
-	if (tsk->signal->leader)
+	if (group_dead && tsk->signal->leader)
 		disassociate_ctty(1);
 
 	module_put(tsk->thread_info->exec_domain->module);
