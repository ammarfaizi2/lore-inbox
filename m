Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbVDQPji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbVDQPji (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 11:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbVDQPji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 11:39:38 -0400
Received: from p3EE21EDD.dip.t-dialin.net ([62.226.30.221]:1028 "EHLO
	gateway2.croq.loc") by vger.kernel.org with ESMTP id S261335AbVDQPje
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 11:39:34 -0400
Message-ID: <42628300.5020009@free.fr>
Date: Sun, 17 Apr 2005 17:38:40 +0200
From: Olivier Croquette <ocroquette@free.fr>
User-Agent: Mozilla Thunderbird 1.0.2 (Macintosh/20050317)
X-Accept-Language: fr-fr, en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Cc: mingo@elte.hu
Subject: [PATCH] Changing RT priority in kernel 2.6 without CAP_SYS_NICE
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Here is a patch on the permission scheme when changing RT priorities.

Presently, a process without the capability CAP_SYS_NICE can not change 
its own policy, which is OK.

But it can also not decrease its RT priority (if scheduled with policy 
SCHED_RR or SCHED_FIFO), which is what this patch changes.

The rationale is the same as for the nice value: a process should be 
able to require less priority for itself. Increasing the priority is 
still not allowed.

This is for example useful if you give a multithreaded user process a RT 
priority, and the process would like to organize its internal threads 
using priorities also. Then you can give the process the highest 
priority needed N, and the process starts its threads with lower 
priorities: N-1, N-2...

The POSIX norm says that the permissions are implementation specific, so 
I think we can do that.

In a sense, it makes the permissions consistent whatever the policy is: 
with this patch, process scheduled by SCHED_FIFO, SCHED_RR and 
SCHED_OTHER can all decrease their priority.

Please tell me what you think!

Regards

Olivier





--- linux-2.6.8-24.11/kernel/sched.c    2005-01-14 16:34:00.000000000
+0100
+++ linux-2.6.8-24.11-sched-patch/kernel/sched.c        2005-04-17
09:27:07.000000000 +0200
@@ -3248,12 +3248,19 @@
                 goto out_unlock;

         retval = -EPERM;
-       if ((policy == SCHED_FIFO || policy == SCHED_RR) &&
-           !capable(CAP_SYS_NICE))
-               goto out_unlock;
-       if ((current->euid != p->euid) && (current->euid != p->uid) &&
-           !capable(CAP_SYS_NICE))
-               goto out_unlock;
+       if(!capable(CAP_SYS_NICE)) {
+               /* can't change a policy without cap */
+               if (policy != p->policy)
+                       goto out_unlock;
+               /* can't increase priority without cap */
+               if (policy != SCHED_NORMAL &&
+                   lp.sched_priority > p->rt_priority)
+                       goto out_unlock;
+               /* can't change other processes without cap */
+               if ((current->euid != p->euid) &&
+                   (current->euid != p->uid))
+                       goto out_unlock;
+       }

         retval = security_task_setscheduler(p, policy, &lp);
         if (retval)
