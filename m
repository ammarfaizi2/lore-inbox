Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262780AbSJJARh>; Wed, 9 Oct 2002 20:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262782AbSJJARh>; Wed, 9 Oct 2002 20:17:37 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:41725 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S262780AbSJJARf>; Wed, 9 Oct 2002 20:17:35 -0400
Date: Wed, 9 Oct 2002 17:15:00 -0700
From: Chris Wright <chris@wirex.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.41 capget fix
Message-ID: <20021009171500.B25393@figure1.int.wirex.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Daniel Jacobowitz noticed that sys_capget is not behaving properly when
called with pid of 0.  It is supposed to return current capabilities,
not those of swapper.  Also cleaned up some duplicate code from a merge
error.  Patch is tested, please apply.

thanks,
-chris

--- 2.5.41/kernel/capability.c	Sun Sep 15 12:19:29 2002
+++ 2.5.41-capget/kernel/capability.c	Wed Oct  9 16:31:10 2002
@@ -33,7 +33,7 @@
      int ret = 0;
      pid_t pid;
      __u32 version;
-     task_t *target;
+     task_t *target = current;
      struct __user_cap_data_struct data;
 
      if (get_user(version, &header->version))
@@ -52,21 +52,20 @@
              return -EINVAL;
 
      spin_lock(&task_capability_lock);
-     read_lock(&tasklist_lock); 
 
-     target = find_task_by_pid(pid);
-     if (!target) {
-          ret = -ESRCH;
-          goto out;
+     if (pid && pid != current->pid) {
+	     read_lock(&tasklist_lock); 
+	     target = find_task_by_pid(pid);
+	     read_unlock(&tasklist_lock); 
+	     if (!target) {
+	          ret = -ESRCH;
+	          goto out;
+	     }
      }
 
-     data.permitted = cap_t(target->cap_permitted);
-     data.inheritable = cap_t(target->cap_inheritable); 
-     data.effective = cap_t(target->cap_effective);
      ret = security_ops->capget(target, &data.effective, &data.inheritable, &data.permitted);
 
 out:
-     read_unlock(&tasklist_lock); 
      spin_unlock(&task_capability_lock);
 
      if (!ret && copy_to_user(dataptr, &data, sizeof data))
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
