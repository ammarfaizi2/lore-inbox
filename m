Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751516AbWBVXHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbWBVXHW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 18:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbWBVXHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 18:07:22 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:35560 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751512AbWBVXHO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 18:07:14 -0500
Message-ID: <43FCEDF0.15D70D0D@tv-sign.ru>
Date: Thu, 23 Feb 2006 02:04:16 +0300
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
Subject: [PATCH 1/6] sys_times: don't take tasklist_lock
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sys_times: dont' take tasklist_lock

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.16-rc3/kernel/sys.c~	Thu Feb 23 00:27:27 2006
+++ 2.6.16-rc3/kernel/sys.c	Thu Feb 23 00:28:24 2006
@@ -1018,7 +1018,7 @@ asmlinkage long sys_times(struct tms __u
 		struct task_struct *t;
 		cputime_t utime, stime, cutime, cstime;
 
-		read_lock(&tasklist_lock);
+		spin_lock_irq(&tsk->sighand->siglock);
 		utime = tsk->signal->utime;
 		stime = tsk->signal->stime;
 		t = tsk;
@@ -1028,20 +1028,9 @@ asmlinkage long sys_times(struct tms __u
 			t = next_thread(t);
 		} while (t != tsk);
 
-		/*
-		 * While we have tasklist_lock read-locked, no dying thread
-		 * can be updating current->signal->[us]time.  Instead,
-		 * we got their counts included in the live thread loop.
-		 * However, another thread can come in right now and
-		 * do a wait call that updates current->signal->c[us]time.
-		 * To make sure we always see that pair updated atomically,
-		 * we take the siglock around fetching them.
-		 */
-		spin_lock_irq(&tsk->sighand->siglock);
 		cutime = tsk->signal->cutime;
 		cstime = tsk->signal->cstime;
 		spin_unlock_irq(&tsk->sighand->siglock);
-		read_unlock(&tasklist_lock);
 
 		tmp.tms_utime = cputime_to_clock_t(utime);
 		tmp.tms_stime = cputime_to_clock_t(stime);
