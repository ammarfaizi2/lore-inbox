Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751599AbWCNArK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599AbWCNArK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 19:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751761AbWCNArK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 19:47:10 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:50597 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751599AbWCNArJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 19:47:09 -0500
Subject: [Patch 3/9] Block I/O accounting initialization
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>
In-Reply-To: <1142296834.5858.3.camel@elinux04.optonline.net>
References: <1142296834.5858.3.camel@elinux04.optonline.net>
Content-Type: text/plain
Organization: IBM
Message-Id: <1142297222.5858.13.camel@elinux04.optonline.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 13 Mar 2006 19:47:02 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

delayacct-blkio-init.patch

Setup variables and functions to collect per-task
block I/O delays.

Separating the collection part to a later patch
for easier review and discussion.

Signed-off-by: Shailabh Nagar <nagar@watson.ibm.com>


 include/linux/delayacct.h |   16 ++++++++++++++++
 include/linux/sched.h     |    4 ++++
 kernel/delayacct.c        |   14 ++++++++++++++
 3 files changed, 34 insertions(+)

Index: linux-2.6.16-rc5/include/linux/delayacct.h
===================================================================
--- linux-2.6.16-rc5.orig/include/linux/delayacct.h	2006-03-11 07:41:37.000000000 -0500
+++ linux-2.6.16-rc5/include/linux/delayacct.h	2006-03-11 07:41:38.000000000 -0500
@@ -22,6 +22,8 @@ extern kmem_cache_t *delayacct_cache;
 extern int delayacct_init(void);
 extern void __delayacct_tsk_init(struct task_struct *);
 extern void __delayacct_tsk_exit(struct task_struct *);
+extern void __delayacct_blkio_start(void);
+extern void __delayacct_blkio_end(void);
 
 static inline void delayacct_tsk_init(struct task_struct *tsk)
 {
@@ -37,6 +39,16 @@ static inline void delayacct_tsk_exit(st
 		__delayacct_tsk_exit(tsk);
 }
 
+static inline void delayacct_blkio_start(void)
+{
+	if (unlikely(delayacct_on))
+		__delayacct_blkio_start();
+}
+static inline void delayacct_blkio_end(void)
+{
+	if (unlikely(delayacct_on))
+		__delayacct_blkio_end();
+}
 #else
 static inline int delayacct_init(void)
 {}
@@ -44,5 +56,9 @@ static inline void delayacct_tsk_init(st
 {}
 static inline void delayacct_tsk_exit(struct task_struct *tsk)
 {}
+static inline void delayacct_blkio_start(void)
+{}
+static inline void delayacct_blkio_end(void)
+{}
 #endif /* CONFIG_TASK_DELAY_ACCT */
 #endif /* _LINUX_TASKDELAYS_H */
Index: linux-2.6.16-rc5/kernel/delayacct.c
===================================================================
--- linux-2.6.16-rc5.orig/kernel/delayacct.c	2006-03-11 07:41:37.000000000 -0500
+++ linux-2.6.16-rc5/kernel/delayacct.c	2006-03-11 07:41:38.000000000 -0500
@@ -90,3 +90,17 @@ static inline void delayacct_end(struct 
 	spin_unlock(&current->delays->lock);
 }
 
+void __delayacct_blkio_start(void)
+{
+	if (current->delays)
+		delayacct_start(&current->delays->blkio_start);
+}
+
+void __delayacct_blkio_end(void)
+{
+	if (current->delays)
+		delayacct_end(&current->delays->blkio_start,
+				&current->delays->blkio_end,
+				&current->delays->blkio_delay,
+				&current->delays->blkio_count);
+}
Index: linux-2.6.16-rc5/include/linux/sched.h
===================================================================
--- linux-2.6.16-rc5.orig/include/linux/sched.h	2006-03-11 07:41:37.000000000 -0500
+++ linux-2.6.16-rc5/include/linux/sched.h	2006-03-11 07:41:38.000000000 -0500
@@ -549,6 +549,10 @@ struct task_delay_info {
 	 * u64 XXX_delay;
 	 * u32 XXX_count;
 	 */
+
+	struct timespec blkio_start, blkio_end;
+	u64 blkio_delay;	/* wait for sync block io completion */
+	u32 blkio_count;
 };
 #endif
 


