Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbTFBJoY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 05:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbTFBJoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 05:44:24 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:11767 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id S262095AbTFBJoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 05:44:20 -0400
Date: Mon, 2 Jun 2003 02:54:50 -0700
From: Chris Wright <chris@wirex.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com,
       greg@kroah.com, sds@epoch.ncsc.mil
Subject: [PATCH][LSM] Early init for security modules and various cleanups
Message-ID: <20030602025450.C27233@figure1.int.wirex.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, linux-security-module@wirex.com,
	greg@kroah.com, sds@epoch.ncsc.mil
References: <20030602024910.B27233@figure1.int.wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030602024910.B27233@figure1.int.wirex.com>; from chris@wirex.com on Mon, Jun 02, 2003 at 02:49:10AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1259  -> 1.1260 
#	       mm/oom_kill.c	1.23    -> 1.24   
#	include/linux/security.h	1.21    -> 1.22   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/06/02	sds@epoch.ncsc.mil	1.1260
# [LSM] Replaced the direct capability bit tests with calls to the
# security_capable hook in mm/oom_kill.c
# --------------------------------------------
#
diff -Nru a/include/linux/security.h b/include/linux/security.h
--- a/include/linux/security.h	Mon Jun  2 01:30:56 2003
+++ b/include/linux/security.h	Mon Jun  2 01:30:56 2003
@@ -1231,6 +1231,11 @@
 	return security_ops->sysctl(table, op);
 }
 
+static inline int security_capable(struct task_struct * tsk, int cap)
+{
+	return security_ops->capable(tsk, cap);
+}
+
 static inline int security_quotactl (int cmds, int type, int id,
 				     struct super_block *sb)
 {
@@ -1894,6 +1899,11 @@
 static inline int security_sysctl(ctl_table * table, int op)
 {
 	return 0;
+}
+
+static inline int security_capable(struct task_struct * tsk, int cap)
+{
+	return cap_capable(tsk, cap);
 }
 
 static inline int security_quotactl (int cmds, int type, int id,
diff -Nru a/mm/oom_kill.c b/mm/oom_kill.c
--- a/mm/oom_kill.c	Mon Jun  2 01:30:56 2003
+++ b/mm/oom_kill.c	Mon Jun  2 01:30:56 2003
@@ -20,6 +20,7 @@
 #include <linux/swap.h>
 #include <linux/timex.h>
 #include <linux/jiffies.h>
+#include <linux/security.h>
 
 /* #define DEBUG */
 
@@ -91,7 +92,7 @@
 	 * Superuser processes are usually more important, so we make it
 	 * less likely that we kill those.
 	 */
-	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_ADMIN) ||
+	if (!security_capable(p,CAP_SYS_ADMIN) ||
 				p->uid == 0 || p->euid == 0)
 		points /= 4;
 
@@ -101,7 +102,7 @@
 	 * tend to only have this flag set on applications they think
 	 * of as important.
 	 */
-	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO))
+	if (!security_capable(p,CAP_SYS_RAWIO))
 		points /= 4;
 #ifdef DEBUG
 	printk(KERN_DEBUG "OOMkill: task %d (%s) got %d points\n",
@@ -154,7 +155,7 @@
 	p->flags |= PF_MEMALLOC | PF_MEMDIE;
 
 	/* This process has hardware access, be more careful. */
-	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO)) {
+	if (!security_capable(p,CAP_SYS_RAWIO)) {
 		force_sig(SIGTERM, p);
 	} else {
 		force_sig(SIGKILL, p);
