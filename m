Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030215AbWHQTxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030215AbWHQTxL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 15:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030214AbWHQTxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 15:53:10 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:43198 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030208AbWHQTxI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 15:53:08 -0400
Subject: [RFC][PATCH 3/8] init security for init task
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>
Cc: Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 12:53:17 -0700
Message-Id: <1155844397.6788.57.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Added a LSM hook to initialize the security pointer of the init task.

Signed-off-by: Mimi Zohar <zohar@us.ibm.com> 
Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
 include/linux/security.h |   17 +++++++++++++++++
 init/main.c              |    1 +
 security/dummy.c         |    6 ++++++
 3 files changed, 24 insertions(+)

--- linux-2.6.18-rc3/include/linux/security.h	2006-07-30 01:15:36.000000000 -0500
+++ linux-2.6.18-rc3-working/include/linux/security.h	2006-08-08 13:05:48.000000000 -0500
@@ -516,6 +516,12 @@ struct swap_info_struct;
  * @task_free_security:
  *	@p contains the task_struct for process.
  *	Deallocate and clear the p->security field.
+ * @task_init_alloc_security:
+ *	@p contains the task_struct for init process.
+ *	Allocate and attach a security structure to the p->security field for
+ *	the init task. The security field is initialized to NULL when the task
+ *	structure is allocated.
+ *	Return 0 if operation was successful.
  * @task_setuid:
  *	Check permission before setting one or more of the user identity
  *	attributes of the current process.  The @flags parameter indicates
@@ -1220,6 +1226,7 @@ struct security_operations {
 	int (*task_create) (unsigned long clone_flags);
 	int (*task_alloc_security) (struct task_struct * p);
 	void (*task_free_security) (struct task_struct * p);
+	int (*task_init_alloc_security) (struct task_struct * p);
 	int (*task_setuid) (uid_t id0, uid_t id1, uid_t id2, int flags);
 	int (*task_post_setuid) (uid_t old_ruid /* or fsuid */ ,
 				 uid_t old_euid, uid_t old_suid, int flags);
@@ -1816,6 +1823,11 @@ static inline void security_task_free (s
 	security_ops->task_free_security (p);
 }
 
+static inline int security_task_init_alloc (struct task_struct *p)
+{
+	return security_ops->task_init_alloc_security (p);
+}
+
 static inline int security_task_setuid (uid_t id0, uid_t id1, uid_t id2,
 					int flags)
 {
@@ -2479,6 +2491,11 @@ static inline int security_task_alloc (s
 static inline void security_task_free (struct task_struct *p)
 { }
 
+static inline int security_task_init_alloc (struct task_struct *p)
+{
+	return 0;
+}
+
 static inline int security_task_setuid (uid_t id0, uid_t id1, uid_t id2,
 					int flags)
 {
--- linux-2.6.18-rc3/security/dummy.c	2006-07-30 01:15:36.000000000 -0500
+++ linux-2.6.18-rc3-working/security/dummy.c	2006-08-04 13:28:34.000000000 -0500
@@ -474,6 +474,11 @@ static void dummy_task_free_security (st
 	return;
 }
 
+static int dummy_task_init_alloc_security (struct task_struct *p)
+{
+	return 0;
+}
+
 static int dummy_task_setuid (uid_t id0, uid_t id1, uid_t id2, int flags)
 {
 	return 0;
@@ -982,6 +987,7 @@ void security_fixup_ops (struct security
 	set_to_dummy_if_null(ops, task_create);
 	set_to_dummy_if_null(ops, task_alloc_security);
 	set_to_dummy_if_null(ops, task_free_security);
+	set_to_dummy_if_null(ops, task_init_alloc_security);
 	set_to_dummy_if_null(ops, task_setuid);
 	set_to_dummy_if_null(ops, task_post_setuid);
 	set_to_dummy_if_null(ops, task_setgid);
--- linux-2.6.18-rc3/init/main.c	2006-07-30 01:15:36.000000000 -0500
+++ linux-2.6.18-rc3-working/init/main.c	2006-08-04 13:26:12.000000000 -0500
@@ -698,6 +698,7 @@ static int init(void * unused)
 	 * can be found.
 	 */
 	child_reaper = current;
+	security_task_init_alloc(current);
 
 	smp_prepare_cpus(max_cpus);
 


