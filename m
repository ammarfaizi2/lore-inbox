Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262986AbSJBHkU>; Wed, 2 Oct 2002 03:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262989AbSJBHkU>; Wed, 2 Oct 2002 03:40:20 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:2814 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S262986AbSJBHkT>; Wed, 2 Oct 2002 03:40:19 -0400
Date: Wed, 2 Oct 2002 00:38:17 -0700
From: Chris Wright <chris@wirex.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Re: Capabilities-related change in 2.5.40
Message-ID: <20021002003817.B26557@figure1.int.wirex.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20021001164907.GA25307@nevyn.them.org> <20021001134552.A26557@figure1.int.wirex.com> <20021001211210.GA8784@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021001211210.GA8784@nevyn.them.org>; from dan@debian.org on Tue, Oct 01, 2002 at 05:12:11PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Daniel Jacobowitz (dan@debian.org) wrote:
> 
> Yes.  It was pointed out to me that libcap2 snapshots behave correctly.

Ah, thanks for the info.  Hmm, libcap2 still looks like it sets up the
header with pid == 0.  Maybe I'm missing something.

> Not init: swapper.

Yes, although INIT_TASK sets up the task_struct for swapper.

> Try it on 2.4:
> drow@nevyn:~% getpcaps 0
> Capabilities for `0': =
> 
> 2.5.40 gives me a very different answer :)

Heh, you're right.  However, 2.5.20 behaves the same as 2.4.  Looking
back this appears to be caused by 2.5.21 locking cleanups done by rml.
The older code interpreted pid == 0 to mean current, whereas the new
code unconditionally does find_task_by_pid(0).  This patch fixes that,
and then pid == 0 from libcap should work again.

--- 1.5/kernel/capability.c	Sun Sep 15 12:19:29 2002
+++ edited/kernel/capability.c	Wed Oct  2 00:28:32 2002
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
+     	read_lock(&tasklist_lock); 
+     	target = find_task_by_pid(pid);
+     	read_unlock(&tasklist_lock); 
+     	if (!target) {
+          	ret = -ESRCH;
+          	goto out;
+	}
      }
 
-     data.permitted = cap_t(target->cap_permitted);
-     data.inheritable = cap_t(target->cap_inheritable); 
-     data.effective = cap_t(target->cap_effective);
      ret = security_ops->capget(target, &data.effective, &data.inheritable, &data.permitted);
 
 out:
-     read_unlock(&tasklist_lock); 
      spin_unlock(&task_capability_lock);
 
      if (!ret && copy_to_user(dataptr, &data, sizeof data))

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
