Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262534AbVBYFYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262534AbVBYFYo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 00:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbVBYFYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 00:24:43 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:37512 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262534AbVBYFYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 00:24:38 -0500
From: Parag Warudkar <kernel-stuff@comcast.net>
To: "linux-kernel" <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2.6.11-rc4] oom_kill.c: Kill obvious processes first
Date: Fri, 25 Feb 2005 00:24:30 -0500
User-Agent: KMail/1.7.92
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_OarHCu/Fnruk8FX"
Message-Id: <200502250024.30450.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_OarHCu/Fnruk8FX
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


oom_kill.c misses very obvious targets - For example, a process occupying > 
80% memory, not superuser and not having hardware access gets ignored by it. 
Logically, such a process, if killed , is going to make things return to 
normal thereby eliminating the need for oom killer to further scan for more 
processes.

This patch calculates the approximate integer percentage of memory occupied by 
the process by looking at num_physpages and p->mm->total_vm. If this process 
is not super user and doesn't have hardware access, and the percentage of 
occupied memory is more than 60%, it immediately selects this process for 
killing by returning unusually high points from badness().

Without this patch, when KDevelop running as non root user gobbles up 90% 
memory, the OOM killer kills many other irrelevant processes but not KDevelop 
And machine never recovers.. (Pls see LKML for my previous message with 
subject "2.6.11-rc4 OOM Killer - Kill the Innocent".) 

With this patch OOM killer immediately kills kdevelop and machine recovers.

Signed-off-by: Parag Warudkar <kernel-stuff@comcast.net>

--Boundary-00=_OarHCu/Fnruk8FX
Content-Type: text/x-diff;
  charset="us-ascii";
  name="oom_kill.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="oom_kill.c.patch"

--- linux-orig/mm/oom_kill.c	2005-02-23 20:03:11.000000000 -0500
+++ linux-2.6.10/mm/oom_kill.c	2005-02-25 00:21:20.000000000 -0500
@@ -44,8 +44,10 @@
 
 unsigned long badness(struct task_struct *p, unsigned long uptime)
 {
-	unsigned long points, cpu_time, run_time, s;
+	unsigned long points, cpu_time, run_time, s, pct_occ;
+	extern unsigned long num_physpages;
 	struct list_head *tsk;
+	int is_superuser=0, has_hwaccess=0;
 
 	if (!p->mm)
 		return 0;
@@ -55,6 +57,39 @@
 	 */
 	points = p->mm->total_vm;
 
+	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_ADMIN) ||
+				p->uid == 0 || p->euid == 0) 
+	{
+		is_superuser=1;
+
+	}
+	
+	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO)) {
+		has_hwaccess=1;
+	}
+	
+	if(is_superuser || has_hwaccess)
+		goto skip_pct_chk;
+
+	/* If the process 
+	 * a. Does not belong to superuser
+	 * b. Does not have hardware access, and
+	 * c. Occupies more than or equal to 50% memory 
+	 * it is a very likely candidate to kill.
+	 */
+	pct_occ = points*100 / num_physpages;
+
+	if (pct_occ >= 60) {
+#ifdef DEBUG	
+		printk(KERN_DEBUG "Process %s with PID %d occupied more
+				 than 60% memory\n", p->comm, p->pid);
+#endif
+		/* Return unusually high number to make sure this process
+		 * gets killed
+		 */
+		return points*pct_occ;
+	}
+	skip_pct_chk:	
 	/*
 	 * Processes which fork a lot of child processes are likely
 	 * a good choice. We add the vmsize of the childs if they
@@ -99,8 +134,7 @@
 	 * Superuser processes are usually more important, so we make it
 	 * less likely that we kill those.
 	 */
-	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_ADMIN) ||
-				p->uid == 0 || p->euid == 0)
+	if (is_superuser)
 		points /= 4;
 
 	/*
@@ -109,7 +143,7 @@
 	 * tend to only have this flag set on applications they think
 	 * of as important.
 	 */
-	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO))
+	if (has_hwaccess)
 		points /= 4;
 
 	/*

--Boundary-00=_OarHCu/Fnruk8FX--
