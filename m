Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270499AbTHQTMD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 15:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270501AbTHQTMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 15:12:03 -0400
Received: from fmr02.intel.com ([192.55.52.25]:24023 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S270499AbTHQTMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 15:12:00 -0400
Message-ID: <3F3FD2E7.9030808@intel.com>
Date: Sun, 17 Aug 2003 22:09:27 +0300
From: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] Re: Kernel threads resource leakage
X-Enigmail-Version: 0.76.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I do not subscribed to the list, thus please in your reply CC me 
(vladimir.kondratiev@intel.com)

Some time ago, I reported problem WRT resource leakage in kernel_thread. 
(2.4.20) To demonstrate it, I submitted program that uses /proc file to 
display some info and to start/stop kernel thread. I don't want to 
re-post this code again.

Finally, I found that resource leak present only if you create 
kernel_thread as non-root. With my previous example, do "insmod" as 
root, while perform actual thread creation/destruction (echo "+" 
 >/proc/kthread etc.) as non-root.

To demonstrate it better, I added to /proc 'read' procedure content of 
"struct user_struct" (current->user).
It makes clear, that in this case current->user->processes do not 
decremented when thread destroyed, and eventually reaches user limit 
(usually 4k processes). At this point, this user can do nothing.

Problem leaves in "reparent_to_init" code in kernel/sched.c; there 
current->user is simply changed to point to INIT_USER without proper 
resource management.

Does it worth inclusion in 2.4.22?

Following patch fixes this bug. I verified that with this patch applied, 
kernel_thread behaves properly.

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


