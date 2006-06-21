Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbWFUEc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWFUEc0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 00:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWFUEc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 00:32:26 -0400
Received: from mail1.sea5.speakeasy.net ([69.17.117.3]:57825 "EHLO
	mail1.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932123AbWFUEcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 00:32:25 -0400
Date: Wed, 21 Jun 2006 00:32:21 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Andrew Morton <akpm@osdl.org>
cc: Stephen Smalley <sds@tycho.nsa.gov>, linux-kernel@vger.kernel.org,
       David Quigley <dpquigl@tycho.nsa.gov>, Ingo Molnar <mingo@elte.hu>,
       pj@sgi.com
Subject: [PATCH 2/2] SELinux: Add security hook call to mediate attach_task
 (kernel/cpuset.c)
In-Reply-To: <Pine.LNX.4.64.0606210016370.5379@d.namei>
Message-ID: <Pine.LNX.4.64.0606210029230.5379@d.namei>
References: <Pine.LNX.4.64.0606210016370.5379@d.namei>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Quigley <dpquigl@tycho.nsa.gov>

This patch adds a security hook call to enable security modules to control 
the ability to attach a task to a cpuset.  While limited control over this 
operation is possible via permission checks on the pseudo fs interface, 
those checks are not sufficient to control access to the target task, 
which is looked up in this function.  The existing task_setscheduler hook 
is re-used for this operation since this falls under the same class of 
operations.

This is aimed at 2.6.18 inclusion to cover new code currently unmediated
by SELinux.

Please apply.

Signed-Off-By: David Quigley <dpquigl@tycho.nsa.gov>
Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: James Morris <jmorris@namei.org>

---

 kernel/cpuset.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff -uprN -X /home/dpquigl/dontdiff linux-2.6.17-rc6-mm2/kernel/cpuset.c linux-2.6.17-rc6-mm2-attach/kernel/cpuset.c
--- linux-2.6.17-rc6-mm2/kernel/cpuset.c	2006-06-15 09:46:28.000000000 -0400
+++ linux-2.6.17-rc6-mm2-attach/kernel/cpuset.c	2006-06-15 09:52:43.000000000 -0400
@@ -41,6 +41,7 @@
 #include <linux/rcupdate.h>
 #include <linux/sched.h>
 #include <linux/seq_file.h>
+#include <linux/security.h>
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
 #include <linux/spinlock.h>
@@ -1177,6 +1178,7 @@ static int attach_task(struct cpuset *cs
 	cpumask_t cpus;
 	nodemask_t from, to;
 	struct mm_struct *mm;
+	int retval;
 
 	if (sscanf(pidbuf, "%d", &pid) != 1)
 		return -EIO;
@@ -1205,6 +1207,12 @@ static int attach_task(struct cpuset *cs
 		get_task_struct(tsk);
 	}
 
+	retval = security_task_setscheduler(tsk, 0, NULL);
+	if (retval) {
+		put_task_struct(tsk);
+		return retval;
+	}
+
 	mutex_lock(&callback_mutex);
 
 	task_lock(tsk);
