Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932795AbWF1NhB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932795AbWF1NhB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 09:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932805AbWF1Ng7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 09:36:59 -0400
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:9962 "EHLO
	mail6.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932795AbWF1Ngt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 09:36:49 -0400
Date: Wed, 28 Jun 2006 09:36:46 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: ralf@linux-mips.org
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] SELinux/MIPS: Add security hooks to mips-mt {get,set}affinity
Message-ID: <Pine.LNX.4.64.0606280934080.12338@d.namei>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Quigley <dpquigl@tycho.nsa.gov>

This patch adds LSM hooks into the setaffinity and getaffinity functions 
for the mips architecture to enable security modules to control these 
operations between tasks with different security attributes. This 
implementation uses the existing task_setscheduler and task_getscheduler 
LSM hooks.

Please apply.

Signed-Off-By: David Quigley <dpquigl@tycho.nsa.gov>
Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: James Morris <jmorris@namei.org>

---

 arch/mips/kernel/mips-mt.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff -uprN -X /home/dpquigl/dontdiff linux-2.6.17-mm3/arch/mips/kernel/mips-mt.c linux-2.6.17-mm3-affiniy/arch/mips/kernel/mips-mt.c
--- linux-2.6.17-mm3/arch/mips/kernel/mips-mt.c	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.17-mm3-affiniy/arch/mips/kernel/mips-mt.c	2006-06-27 15:47:46.000000000 -0400
@@ -95,6 +95,10 @@ asmlinkage long mipsmt_sys_sched_setaffi
 		goto out_unlock;
 	}
 
+	retval = security_task_setscheduler(p, 0, NULL);
+	if (retval)
+		goto out_unlock;
+
 	/* Record new user-specified CPU set for future reference */
 	p->thread.user_cpus_allowed = new_mask;
 
@@ -140,8 +144,9 @@ asmlinkage long mipsmt_sys_sched_getaffi
 	p = find_process_by_pid(pid);
 	if (!p)
 		goto out_unlock;
-
-	retval = 0;
+	retval = security_task_getscheduler(p);
+	if (retval)
+		goto out_unlock;
 
 	cpus_and(mask, p->thread.user_cpus_allowed, cpu_possible_map);


