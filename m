Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbVLOOne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbVLOOne (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 09:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbVLOOix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 09:38:53 -0500
Received: from igw2.watson.ibm.com ([129.34.20.6]:46234 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP
	id S1750723AbVLOOit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 09:38:49 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
Message-Id: <20051215143841.292183000@elg11.watson.ibm.com>
References: <20051215143557.421393000@elg11.watson.ibm.com>
Date: Thu, 15 Dec 2005 09:36:08 -0500
To: linux-kernel@vger.kernel.org
Subject: [RFC][patch 11/21] PID Virtualization: use vpgid_to_pgid function
Content-Disposition: inline; filename=FB-vpgid-to-pgid-translation.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Same as previous patch for pids, but here we focus on virtual
ids that are interpreted as process group ids. Since process
groups ids can be negative, they are handled as to deal with
the negative value.

Signed-off-by: Hubertus Franke <frankeh@watson.ibm.com>
--

 fs/fcntl.c          |    1 +
 kernel/capability.c |    1 +
 kernel/exit.c       |    2 ++
 3 files changed, 4 insertions(+)

Index: linux-2.6.15-rc1/fs/fcntl.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/fcntl.c	2005-12-14 15:13:55.000000000 -0500
+++ linux-2.6.15-rc1/fs/fcntl.c	2005-12-14 15:16:34.000000000 -0500
@@ -267,6 +267,7 @@ int f_setown(struct file *filp, unsigned
 	if (err)
 		return err;
 
+	arg = vpgid_to_pgid(arg);
 	f_modown(filp, arg, current->uid, current->euid, force);
 	return 0;
 }
Index: linux-2.6.15-rc1/kernel/capability.c
===================================================================
--- linux-2.6.15-rc1.orig/kernel/capability.c	2005-12-14 15:14:38.000000000 -0500
+++ linux-2.6.15-rc1/kernel/capability.c	2005-12-14 15:14:42.000000000 -0500
@@ -188,6 +188,7 @@ asmlinkage long sys_capset(cap_user_head
      if (get_user(pid, &header->pid))
 	     return -EFAULT; 
 
+     pid = vpgid_to_pgid(pid);
      if (pid && pid != task_pid(current) && !capable(CAP_SETPCAP))
              return -EPERM;
 
Index: linux-2.6.15-rc1/kernel/exit.c
===================================================================
--- linux-2.6.15-rc1.orig/kernel/exit.c	2005-12-14 15:14:38.000000000 -0500
+++ linux-2.6.15-rc1/kernel/exit.c	2005-12-14 15:14:42.000000000 -0500
@@ -1556,6 +1556,8 @@ asmlinkage long sys_wait4(pid_t pid, int
 	if (options & ~(WNOHANG|WUNTRACED|WCONTINUED|
 			__WNOTHREAD|__WCLONE|__WALL))
 		return -EINVAL;
+	if (pid != -1)
+		pid = vpgid_to_pgid(pid);
 	ret = do_wait(pid, options | WEXITED, NULL, stat_addr, ru);
 
 	/* avoid REGPARM breakage on x86: */

--
