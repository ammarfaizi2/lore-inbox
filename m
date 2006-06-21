Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751983AbWFUE3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983AbWFUE3O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 00:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751982AbWFUE3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 00:29:14 -0400
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:17596 "EHLO
	mail6.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751983AbWFUE3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 00:29:13 -0400
Date: Wed, 21 Jun 2006 00:29:11 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Andrew Morton <akpm@osdl.org>
cc: Stephen Smalley <sds@tycho.nsa.gov>, linux-kernel@vger.kernel.org,
       David Quigley <dpquigl@tycho.nsa.gov>, Ingo Molnar <mingo@elte.hu>,
       pj@sgi.com
Subject: [PATCH 1/2] SELinux: Add security hooks to {get,set}affinity
Message-ID: <Pine.LNX.4.64.0606210016370.5379@d.namei>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Quigley <dpquigl@tycho.nsa.gov>

This patch adds LSM hooks into the setaffinity and getaffinity functions 
to enable security modules to control these operations between tasks with 
different security attributes. This implementation uses the existing 
task_setscheduler and task_getscheduler LSM hooks.

This is aimed at 2.6.18 inclusion to cover new code currently unmediated 
by SELinux.

Please apply.

Signed-Off-By: David Quigley <dpquigl@tycho.nsa.gov>
Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: James Morrisj <jmorris@namei.org>

---

kernel/sched.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff -uprN -X /home/dpquigl/dontdiff linux-2.6.17-rc6-mm2/kernel/sched.c linux-2.6.17-rc6-mm2-affinity/kernel/sched.c
--- linux-2.6.17-rc6-mm2/kernel/sched.c	2006-06-15 09:46:28.000000000 -0400
+++ linux-2.6.17-rc6-mm2-affinity/kernel/sched.c	2006-06-15 09:51:55.000000000 -0400
@@ -4266,6 +4266,10 @@ long sched_setaffinity(pid_t pid, cpumas
 			!capable(CAP_SYS_NICE))
 		goto out_unlock;
 
+	retval = security_task_setscheduler(p, 0, NULL);
+	if (retval)
+		goto out_unlock;
+
 	cpus_allowed = cpuset_cpus_allowed(p);
 	cpus_and(new_mask, new_mask, cpus_allowed);
 	retval = set_cpus_allowed(p, new_mask);
@@ -4334,7 +4338,10 @@ long sched_getaffinity(pid_t pid, cpumas
 	if (!p)
 		goto out_unlock;
 
-	retval = 0;
+	retval = security_task_getscheduler(p);
+	if (retval)
+		goto out_unlock;
+
 	cpus_and(*mask, p->cpus_allowed, cpu_online_map);
 
 out_unlock:


