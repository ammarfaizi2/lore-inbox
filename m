Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751577AbWBVWgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbWBVWgw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 17:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751579AbWBVWgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 17:36:51 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:65510 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751578AbWBVWgu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 17:36:50 -0500
Message-ID: <43FCE6D0.D4822B9F@tv-sign.ru>
Date: Thu, 23 Feb 2006 01:33:52 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       David Howells <dhowells@redhat.com>,
       Christoph Lameter <clameter@engr.sgi.com>
Subject: [PATCH 3/3] do __unhash_process() under ->siglock
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves __unhash_process() call from realease_task()
to __exit_signal(), so __detach_pid() is called with ->siglock
held.

This means we don't need tasklist_lock to iterate over thread
group anymore:
 
	copy_process() was already changed to do attach_pid()
	under ->siglock.

	Eric's "pidhash-kill-switch_exec_pids.patch" from -mm
	changed de_thread() so it doesn't touch PIDTYPE_TGID.

NOTE: de_thread() still needs some attention. It still changes
task->pid lockless. Taking ->sighand.siglock here allows to do
more tasklist_lock removals.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.16-rc3/kernel/exit.c~3_FIN	2006-02-23 00:54:28.000000000 +0300
+++ 2.6.16-rc3/kernel/exit.c	2006-02-23 01:00:35.000000000 +0300
@@ -110,6 +110,8 @@ static void __exit_signal(struct task_st
 		sig = NULL; /* Marker for below. */
 	}
 
+	__unhash_process(tsk);
+
 	tsk->signal = NULL;
 	cleanup_sighand(tsk);
 	spin_unlock(&sighand->siglock);
@@ -138,8 +140,6 @@ repeat:
 	BUG_ON(!list_empty(&p->ptrace_list) || !list_empty(&p->ptrace_children));
 	__exit_signal(p);
 
-	__unhash_process(p);
-
 	/*
 	 * If we are the last non-leader member of the thread
 	 * group, and the leader is zombie, then notify the
