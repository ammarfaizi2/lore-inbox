Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263649AbTIBKkn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 06:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263666AbTIBKkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 06:40:42 -0400
Received: from hermes.py.intel.com ([146.152.216.3]:11479 "EHLO
	hermes.py.intel.com") by vger.kernel.org with ESMTP id S263649AbTIBKkl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 06:40:41 -0400
Message-ID: <3F5472EE.20804@intel.com>
Date: Tue, 02 Sep 2003 13:37:34 +0300
From: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] Resource leak in reparent_to_init
X-Enigmail-Version: 0.76.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In reparent_to_init, it is clear bug that causes resource leak. It is 
pretty easy to test that this bug causes problems: if your module allows 
to create thread for non-root user (using daemonize() and 
reparent_to_init()), it will mis-count number of processes running for 
that user.
Patch follows.
P.S. I do not subscribed to the list, thus please in your reply CC me 
(vladimir.kondratiev@intel.com)

--- kernel/sched.c.orig    2003-08-17 20:12:14.000000000 +0300
+++ kernel/sched.c    2003-08-17 21:21:08.000000000 +0300
@@ -1274,8 +1274,16 @@
    this_task->cap_permitted = CAP_FULL_SET;
    this_task->keep_capabilities = 0;
    memcpy(this_task->rlim, init_task.rlim, sizeof(*(this_task->rlim)));
-    this_task->user = INIT_USER;
-
+    if (this_task->uid) { /* not root? switch user */
+        struct user_struct *old_user = this_task->user,
+            *new_user = INIT_USER;
+        this_task->uid = 0;
+        this_task->user = new_user;
+        atomic_inc(&new_user->__count);
+        atomic_inc(&new_user->processes);
+        atomic_dec(&old_user->processes);
+        free_uid(old_user);
+    }
    spin_unlock(&runqueue_lock);
    write_unlock_irq(&tasklist_lock);
}



