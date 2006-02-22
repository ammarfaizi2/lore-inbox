Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030330AbWBVXIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030330AbWBVXIh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 18:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030337AbWBVXIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 18:08:36 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:50664 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1030336AbWBVXIV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 18:08:21 -0500
Message-ID: <43FCEE33.F0579745@tv-sign.ru>
Date: Thu, 23 Feb 2006 02:05:23 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       David Howells <dhowells@redhat.com>
Subject: [PATCH 5/6] do_group_exit: don't take tasklist_lock
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

do_group_exit() takes tasklist_lock for zap_other_threads(),
this is unneeded now.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.16-rc3/kernel/exit.c~5_DGE	2006-02-23 01:00:35.000000000 +0300
+++ 2.6.16-rc3/kernel/exit.c	2006-02-23 02:01:03.000000000 +0300
@@ -971,7 +971,6 @@ do_group_exit(int exit_code)
 	else if (!thread_group_empty(current)) {
 		struct signal_struct *const sig = current->signal;
 		struct sighand_struct *const sighand = current->sighand;
-		read_lock(&tasklist_lock);
 		spin_lock_irq(&sighand->siglock);
 		if (sig->flags & SIGNAL_GROUP_EXIT)
 			/* Another thread got here before we took the lock.  */
@@ -981,7 +980,6 @@ do_group_exit(int exit_code)
 			zap_other_threads(current);
 		}
 		spin_unlock_irq(&sighand->siglock);
-		read_unlock(&tasklist_lock);
 	}
 
 	do_exit(exit_code);
