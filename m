Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751056AbWAQOvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbWAQOvI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 09:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbWAQOu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 09:50:59 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:34530 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750819AbWAQOua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 09:50:30 -0500
Message-Id: <20060117143328.171073000@sergelap>
References: <20060117143258.150807000@sergelap>
Date: Tue, 17 Jan 2006 08:33:22 -0600
From: Serge Hallyn <serue@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Dave Hansen <haveblue@us.ibm.com>,
       Serge E Hallyn <serue@us.ibm.com>
Subject: RFC [patch 24/34] PID Virtualization use vpgid_to_pgid function
Content-Disposition: inline; filename=FB-vpgid-to-pgid-translation.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Same as previous patch for pids, but here we focus on virtual
ids that are interpreted as process group ids. Since process
groups ids can be negative, they are handled as to deal with
the negative value.

Signed-off-by: Hubertus Franke <frankeh@watson.ibm.com>
---
 fs/fcntl.c          |    1 +
 kernel/capability.c |    1 +
 kernel/exit.c       |    2 ++
 3 files changed, 4 insertions(+)

Index: linux-2.6.15/fs/fcntl.c
===================================================================
--- linux-2.6.15.orig/fs/fcntl.c	2006-01-17 08:37:05.000000000 -0500
+++ linux-2.6.15/fs/fcntl.c	2006-01-17 08:37:06.000000000 -0500
@@ -267,6 +267,7 @@
 	if (err)
 		return err;
 
+	arg = vpgid_to_pgid(arg);
 	f_modown(filp, arg, current->uid, current->euid, force);
 	return 0;
 }
Index: linux-2.6.15/kernel/capability.c
===================================================================
--- linux-2.6.15.orig/kernel/capability.c	2006-01-17 08:37:06.000000000 -0500
+++ linux-2.6.15/kernel/capability.c	2006-01-17 08:37:06.000000000 -0500
@@ -188,6 +188,7 @@
      if (get_user(pid, &header->pid))
 	     return -EFAULT; 
 
+     pid = vpgid_to_pgid(pid);
      if (pid && pid != task_pid(current) && !capable(CAP_SETPCAP))
              return -EPERM;
 
Index: linux-2.6.15/kernel/exit.c
===================================================================
--- linux-2.6.15.orig/kernel/exit.c	2006-01-17 08:37:06.000000000 -0500
+++ linux-2.6.15/kernel/exit.c	2006-01-17 08:37:06.000000000 -0500
@@ -1556,6 +1556,8 @@
 	if (options & ~(WNOHANG|WUNTRACED|WCONTINUED|
 			__WNOTHREAD|__WCLONE|__WALL))
 		return -EINVAL;
+	if (pid != -1)
+		pid = vpgid_to_pgid(pid);
 	ret = do_wait(pid, options | WEXITED, NULL, stat_addr, ru);
 
 	/* avoid REGPARM breakage on x86: */

--

