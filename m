Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbWBBQYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWBBQYx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 11:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbWBBQYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 11:24:53 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:44478 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932136AbWBBQYw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 11:24:52 -0500
Message-ID: <43E232B4.2090003@openvz.org>
Date: Thu, 02 Feb 2006 19:26:28 +0300
From: Kirill Korotaev <dev@openvz.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Kirill Korotaev <dev@openvz.org>
CC: serue@us.ibm.com, arjan@infradead.org, frankeh@watson.ibm.com,
       clg@fr.ibm.com, haveblue@us.ibm.com, mrmacman_g4@mac.com,
       alan@lxorguk.ukuu.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, devel@openvz.org
Subject: [RFC][PATCH 4/7] VPIDs: vpid macros in non-VPID case
References: <43E22B2D.1040607@openvz.org>
In-Reply-To: <43E22B2D.1040607@openvz.org>
Content-Type: multipart/mixed;
 boundary="------------090401050407000803090100"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090401050407000803090100
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch specifies an "interface" to virtual pids. That is
some macros/inlines to obtain pids from tasks, convert pids
to vpids and vice versa and set pids.

Kirill

--------------090401050407000803090100
Content-Type: text/plain;
 name="diff-vpids-macro"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-vpids-macro"

--- ./include/linux/pid.h.vpid_macro	2006-01-03 06:21:10.000000000 +0300
+++ ./include/linux/pid.h	2006-02-02 14:32:41.162807472 +0300
@@ -19,6 +19,19 @@ struct pid
 	struct list_head pid_list;
 };
 
+#ifndef CONFIG_VIRTUAL_PIDS
+#define __is_virtual_pid(pid)		0
+#define is_virtual_pid(pid)		0
+#define vpid_to_pid(pid)		(pid)
+#define __vpid_to_pid(pid)		(pid)
+#define pid_type_to_vpid(type, pid)	(pid)
+#define __pid_type_to_vpid(type, pid)	(pid)
+#define comb_vpid_to_pid(pid)		(pid)
+#define comb_pid_to_vpid(pid)		(pid)
+#define alloc_vpid(pid, vpid)		(pid)
+#define free_vpid(vpid)			do { } while (0)
+#endif
+
 #define pid_task(elem, type) \
 	list_entry(elem, struct task_struct, pids[type].pid_list)
 
--- ./include/linux/sched.h.vpid_macro	2006-02-02 14:15:55.455698192 +0300
+++ ./include/linux/sched.h	2006-02-02 14:32:41.164807168 +0300
@@ -1257,6 +1257,78 @@ static inline unsigned long *end_of_stac
 
 #endif
 
+#ifndef CONFIG_VIRTUAL_PIDS
+static inline pid_t virt_pid(struct task_struct *tsk)
+{
+	return tsk->pid;
+}
+
+static inline pid_t virt_tgid(struct task_struct *tsk)
+{
+	return tsk->tgid;
+}
+
+static inline pid_t virt_pgid(struct task_struct *tsk)
+{
+	return tsk->signal->pgrp;
+}
+
+static inline pid_t virt_sid(struct task_struct *tsk)
+{
+	return tsk->signal->session;
+}
+
+static inline pid_t get_task_pid_ve(struct task_struct *tsk,
+		struct task_struct *ve_tsk)
+{
+	return tsk->pid;
+}
+
+static inline pid_t get_task_pid(struct task_struct *tsk)
+{
+	return tsk->pid;
+}
+
+static inline pid_t get_task_tgid(struct task_struct *tsk)
+{
+	return tsk->tgid;
+}
+
+static inline pid_t get_task_pgid(struct task_struct *tsk)
+{
+	return tsk->signal->pgrp;
+}
+
+static inline pid_t get_task_sid(struct task_struct *tsk)
+{
+	return tsk->signal->session;
+}
+
+static inline int set_virt_pid(struct task_struct *tsk, pid_t pid)
+{
+	return 0;
+}
+
+static inline void set_virt_tgid(struct task_struct *tsk, pid_t pid)
+{
+}
+
+static inline void set_virt_pgid(struct task_struct *tsk, pid_t pid)
+{
+}
+
+static inline void set_virt_sid(struct task_struct *tsk, pid_t pid)
+{
+}
+
+static inline pid_t get_task_ppid(struct task_struct *p)
+{
+	if (!pid_alive(p))
+		return 0;
+	return (p->pid > 1 ? p->group_leader->real_parent->tgid : 0);
+}
+#endif
+
 /* set thread flags in other task's structures
  * - see asm/thread_info.h for TIF_xxxx flags available
  */

--------------090401050407000803090100--

