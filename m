Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264810AbTGCFrH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 01:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265135AbTGCFrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 01:47:07 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:25807 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id S264810AbTGCFrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 01:47:04 -0400
Subject: PATCH] fix current->user->__count leak for processes
From: Arvind Kandhare <arvind.kan@wipro.com>
To: linux-kernel@vger.kernel.org
Cc: eric@lammerts.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Jul 2003 11:34:19 +0530
Message-Id: <1057212259.6028.6.camel@m2-arvind>
Mime-Version: 1.0
X-OriginalArrivalTime: 03 Jul 2003 06:01:21.0785 (UTC) FILETIME=[871D5690:01C34128]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
I am trying to test a patch for limiting maximum number of users on the
system(refer: [RFC][PATCH 2.5.70] Dynamically tunable maxusers, maxuprc
and max_pt_cnt on 06 Jun 2003). 

I stumbled across this problem : when switch_uid is called, 
the reference count of the new user is incremented twice. I think the
increment in the switch_uid is done because of the reparent_to_init()
function which does not increase the __count for root user. 

But if switch_uid is called from any other function, the reference count
is already incremented by the caller by calling alloc_uid for the new
user. Hence the count is incremented twice. The user struct will not be
deleted even when there are no processes holding a reference count for
it. This does not cause any problem currently because nothing is
dependent on timely deletion of the user struct. 

Here is a small patch to solve this problem. 

Thanks and regards, 
Arvind 

diff -Naur linux-2.5.73/kernel/exit.c linux-2.5.73.n/kernel/exit.c
--- linux-2.5.73/kernel/exit.c	2003-06-23 00:03:15.000000000 +0530
+++ linux-2.5.73.n/kernel/exit.c	2003-07-03 10:48:32.000000000 +0530
@@ -230,6 +230,7 @@
 	/* signals? */
 	security_task_reparent_to_init(current);
 	memcpy(current->rlim, init_task.rlim, sizeof(*(current->rlim)));
+	atomic_inc(&(INIT_USER->__count));
 	switch_uid(INIT_USER);
 
 	write_unlock_irq(&tasklist_lock);
diff -Naur linux-2.5.73/kernel/user.c linux-2.5.73.n/kernel/user.c
--- linux-2.5.73/kernel/user.c	2003-06-23 00:02:41.000000000 +0530
+++ linux-2.5.73.n/kernel/user.c	2003-07-03 10:46:59.000000000 +0530
@@ -126,7 +126,6 @@
 	 * we should be checking for it.  -DaveM
 	 */
 	old_user = current->user;
-	atomic_inc(&new_user->__count);
 	atomic_inc(&new_user->processes);
 	atomic_dec(&old_user->processes);
 	current->user = new_user;



