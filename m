Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265375AbSJRWG3>; Fri, 18 Oct 2002 18:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265376AbSJRWG2>; Fri, 18 Oct 2002 18:06:28 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:46834 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S265375AbSJRWG0>; Fri, 18 Oct 2002 18:06:26 -0400
Date: Fri, 18 Oct 2002 15:03:15 -0700
From: Chris Wright <chris@wirex.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5 and Zsh bug
Message-ID: <20021018150315.F26442@figure1.int.wirex.com>
Mail-Followup-To: Stephen Hemminger <shemminger@osdl.org>,
	Kernel List <linux-kernel@vger.kernel.org>
References: <1034974867.5475.26.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1034974867.5475.26.camel@dell_ss3.pdx.osdl.net>; from shemminger@osdl.org on Fri, Oct 18, 2002 at 02:01:07PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Hemminger (shemminger@osdl.org) wrote:
> When running zsh on a Linux 2.5 kernel, the prompt always has a hash
> sign '#' rather than the normal user '$'.  This probably happens because
> the shell function privasserted() is returning true for all users.  I
> know nothing about Posix capabilities but the zsh code for this looks
> suspicious.

See if this patch fixes your problem.  There is a bug in capget(2) which
is called by cap_get_proc(3).  I was holding off on submitting this patch
to Linus until the LSM stuff is resolved.

thanks,
-chris

--- 2.5.43/kernel/capability.c	Sun Sep 15 12:19:29 2002
+++ 2.5.43-capget/kernel/capability.c	Wed Oct 16 00:51:33 2002
@@ -54,15 +54,15 @@
      spin_lock(&task_capability_lock);
      read_lock(&tasklist_lock); 
 
-     target = find_task_by_pid(pid);
-     if (!target) {
-          ret = -ESRCH;
-          goto out;
-     }
+     if (pid && pid != current->pid) {
+	     target = find_task_by_pid(pid);
+	     if (!target) {
+	          ret = -ESRCH;
+	          goto out;
+	     }
+     } else
+	     target = current;
 
-     data.permitted = cap_t(target->cap_permitted);
-     data.inheritable = cap_t(target->cap_inheritable); 
-     data.effective = cap_t(target->cap_effective);
      ret = security_ops->capget(target, &data.effective, &data.inheritable, &data.permitted);
 
 out:
--- 2.5.43/security/dummy.c	Fri Oct 11 14:22:54 2002
+++ 2.5.43-capget/security/dummy.c	Tue Oct 15 00:47:24 2002
@@ -27,6 +27,17 @@
 static int dummy_capget (struct task_struct *target, kernel_cap_t * effective,
 			 kernel_cap_t * inheritable, kernel_cap_t * permitted)
 {
+	*effective = *inheritable = *permitted = 0;
+	if (!issecure(SECURE_NOROOT)) {
+		if (target->euid == 0) {
+			*permitted |= (~0 & ~CAP_FS_MASK);
+			*effective |= (~0 & ~CAP_TO_MASK(CAP_SETPCAP) & ~CAP_FS_MASK);
+		}
+		if (target->fsuid == 0) {
+			*permitted |= CAP_FS_MASK;
+			*effective |= CAP_FS_MASK;
+		}
+	}
 	return 0;
 }
 
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
