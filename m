Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756906AbWK0FHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756906AbWK0FHg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 00:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756915AbWK0FHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 00:07:32 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:23703 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1756981AbWK0FGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 00:06:55 -0500
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>,
       Linux Containers <containers@lists.osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 4/4] sysctl: Fix sys_sysctl interface of ipc sysctls
Date: Sun, 26 Nov 2006 22:05:11 -0700
Message-Id: <1164603916594-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.g3cd4f
In-Reply-To: <m1hcwlmqmp.fsf@ebiederm.dsl.xmission.com>
References: <m1hcwlmqmp.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there is a regression and the ipc sysctls
don't show up in the binary sysctl namespace.

This patch adds sysctl_ipc_data to read data/write from the
appropriate namespace and deliver it in the expected manner.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 kernel/sysctl.c |   50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 638aa14..24c2ca8 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -142,6 +142,10 @@ static int sysctl_uts_string(ctl_table *
 		  void __user *oldval, size_t __user *oldlenp,
 		  void __user *newval, size_t newlen, void **context);
 
+static int sysctl_ipc_data(ctl_table *table, int __user *name, int nlen,
+		  void __user *oldval, size_t __user *oldlenp,
+		  void __user *newval, size_t newlen, void **context);
+
 #ifdef CONFIG_PROC_SYSCTL
 static int proc_do_cad_pid(ctl_table *table, int write, struct file *filp,
 		  void __user *buffer, size_t *lenp, loff_t *ppos);
@@ -475,6 +479,7 @@ #ifdef CONFIG_SYSVIPC
 		.maxlen		= sizeof (init_ipc_ns.shm_ctlmax),
 		.mode		= 0644,
 		.proc_handler	= &proc_ipc_doulongvec_minmax,
+		.strategy	= sysctl_ipc_data,
 	},
 	{
 		.ctl_name	= KERN_SHMALL,
@@ -483,6 +488,7 @@ #ifdef CONFIG_SYSVIPC
 		.maxlen		= sizeof (init_ipc_ns.shm_ctlall),
 		.mode		= 0644,
 		.proc_handler	= &proc_ipc_doulongvec_minmax,
+		.strategy	= sysctl_ipc_data,
 	},
 	{
 		.ctl_name	= KERN_SHMMNI,
@@ -491,6 +497,7 @@ #ifdef CONFIG_SYSVIPC
 		.maxlen		= sizeof (init_ipc_ns.shm_ctlmni),
 		.mode		= 0644,
 		.proc_handler	= &proc_ipc_dointvec,
+		.strategy	= sysctl_ipc_data,
 	},
 	{
 		.ctl_name	= KERN_MSGMAX,
@@ -499,6 +506,7 @@ #ifdef CONFIG_SYSVIPC
 		.maxlen		= sizeof (init_ipc_ns.msg_ctlmax),
 		.mode		= 0644,
 		.proc_handler	= &proc_ipc_dointvec,
+		.strategy	= sysctl_ipc_data,
 	},
 	{
 		.ctl_name	= KERN_MSGMNI,
@@ -507,6 +515,7 @@ #ifdef CONFIG_SYSVIPC
 		.maxlen		= sizeof (init_ipc_ns.msg_ctlmni),
 		.mode		= 0644,
 		.proc_handler	= &proc_ipc_dointvec,
+		.strategy	= sysctl_ipc_data,
 	},
 	{
 		.ctl_name	= KERN_MSGMNB,
@@ -515,6 +524,7 @@ #ifdef CONFIG_SYSVIPC
 		.maxlen		= sizeof (init_ipc_ns.msg_ctlmnb),
 		.mode		= 0644,
 		.proc_handler	= &proc_ipc_dointvec,
+		.strategy	= sysctl_ipc_data,
 	},
 	{
 		.ctl_name	= KERN_SEM,
@@ -523,6 +533,7 @@ #ifdef CONFIG_SYSVIPC
 		.maxlen		= 4*sizeof (int),
 		.mode		= 0644,
 		.proc_handler	= &proc_ipc_dointvec,
+		.strategy	= sysctl_ipc_data,
 	},
 #endif
 #ifdef CONFIG_MAGIC_SYSRQ
@@ -2613,6 +2624,45 @@ static int sysctl_uts_string(ctl_table *
 	return r;
 }
 
+/* The generic sysctl ipc data routine. */
+static int sysctl_ipc_data(ctl_table *table, int __user *name, int nlen,
+		void __user *oldval, size_t __user *oldlenp,
+		void __user *newval, size_t newlen, void **context)
+{
+	size_t len;
+	void *data;
+
+	/* Get out of I don't have a variable */
+	if (!table->data || !table->maxlen)
+		return -ENOTDIR;
+
+	data = get_ipc(table, 1);
+	if (!data)
+		return -ENOTDIR;
+
+	if (oldval && oldlenp) {
+		if (get_user(len, oldlenp))
+			return -EFAULT;
+		if (len) {
+			if (len > table->maxlen)
+				len = table->maxlen;
+			if (copy_to_user(oldval, data, len))
+				return -EFAULT;
+			if (put_user(len, oldlenp))
+				return -EFAULT;
+		}
+	}
+
+	if (newval && newlen) {
+		if (newlen > table->maxlen)
+			newlen = table->maxlen;
+
+		if (copy_from_user(data, newval, newlen))
+			return -EFAULT;
+	}
+	return 1;
+}
+
 #else /* CONFIG_SYSCTL_SYSCALL */
 
 
-- 
1.4.2.rc3.g7e18e-dirty

