Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030329AbWBVXJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030329AbWBVXJL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 18:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030348AbWBVXJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 18:09:10 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:47336 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1030329AbWBVXIF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 18:08:05 -0500
Message-ID: <43FCEE23.DD675BD3@tv-sign.ru>
Date: Thu, 23 Feb 2006 02:05:07 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       David Howells <dhowells@redhat.com>
Subject: [PATCH 4/6] de_thread: don't take tasklist_lock
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

de_thread() takes tasklist_lock for zap_other_threads(),
this is unneeded now.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.16-rc3/fs/exec.c~4_DET	2006-02-18 01:12:36.000000000 +0300
+++ 2.6.16-rc3/fs/exec.c	2006-02-23 01:59:12.000000000 +0300
@@ -604,7 +604,6 @@ static int de_thread(struct task_struct 
 	 * Kill all other threads in the thread group.
 	 * We must hold tasklist_lock to call zap_other_threads.
 	 */
-	read_lock(&tasklist_lock);
 	spin_lock_irq(lock);
 	if (sig->flags & SIGNAL_GROUP_EXIT) {
 		/*
@@ -612,12 +611,10 @@ static int de_thread(struct task_struct 
 		 * return so that the signal is processed.
 		 */
 		spin_unlock_irq(lock);
-		read_unlock(&tasklist_lock);
 		kmem_cache_free(sighand_cachep, newsighand);
 		return -EAGAIN;
 	}
 	zap_other_threads(current);
-	read_unlock(&tasklist_lock);
 
 	/*
 	 * Account for the thread group leader hanging around:
