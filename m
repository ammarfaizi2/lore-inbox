Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261680AbVGDNJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbVGDNJQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 09:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbVGDNJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 09:09:16 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:22252 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261686AbVGDNFn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 09:05:43 -0400
Date: Mon, 4 Jul 2005 15:06:02 +0200
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, alexn@telia.com, pbadari@us.ibm.com,
       jlan@engr.sgi.com
Subject: [PATCH 2.6.13-rc1-mm1] connector: Remove the union declaration
Message-ID: <20050704150602.380876bf@frecb000711.frec.bull.fr>
Organization: BULL SA.
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 04/07/2005 15:17:18,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 04/07/2005 15:17:19,
	Serialize complete at 04/07/2005 15:17:19
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

 This patch removes the ugly union declaration in cn_fork.h and
cn_exit.h files. The code is cleaner without the union and the price is
only four bytes added in the structure.

 Thanks to Alexander Nyberg for reporting this.

Signed-off-by: Guillaume Thouvenin <guillaume.thouvenin@polymtl.ca>

---
 drivers/connector/cn_exit.c |    8 ++++----
 drivers/connector/cn_fork.c |   10 +++++-----
 include/linux/cn_exit.h     |   16 ++++++++--------
 include/linux/cn_fork.h     |   18 +++++++++---------
 4 files changed, 26 insertions(+), 26 deletions(-)


Index: linux-2.6.13-rc1-mm1/drivers/connector/cn_exit.c
===================================================================
--- linux-2.6.13-rc1-mm1.orig/drivers/connector/cn_exit.c	2005-07-04 14:20:59.000000000 +0200
+++ linux-2.6.13-rc1-mm1/drivers/connector/cn_exit.c	2005-07-04 14:36:47.000000000 +0200
@@ -73,9 +73,9 @@ void exit_connector(pid_t pid, pid_t pti
 		exitmsg = (struct cn_exit_msg *)msg->data;
 		exitmsg->type = EXIT_CN_MSG_P;
 		exitmsg->cpu = smp_processor_id();
-		exitmsg->u.s.pid = pid;
-		exitmsg->u.s.ptid = ptid;
-		exitmsg->u.s.code = code;
+		exitmsg->pid = pid;
+		exitmsg->ptid = ptid;
+		exitmsg->code = code;
 
 		put_cpu_var(exit_counts);
 
@@ -107,7 +107,7 @@ static inline void cn_exit_send_status(v
 	msg->len = CN_EXIT_INFO_SIZE;
 	exitmsg = (struct cn_exit_msg *)msg->data;
 	exitmsg->type = EXIT_CN_MSG_S;
-	exitmsg->u.status = cn_exit_enable;
+	exitmsg->status = cn_exit_enable;
 
 	cn_netlink_send(msg, CN_IDX_EXIT, GFP_KERNEL);
 }
Index: linux-2.6.13-rc1-mm1/drivers/connector/cn_fork.c
===================================================================
--- linux-2.6.13-rc1-mm1.orig/drivers/connector/cn_fork.c	2005-07-04 14:20:59.000000000 +0200
+++ linux-2.6.13-rc1-mm1/drivers/connector/cn_fork.c	2005-07-04 14:36:50.000000000 +0200
@@ -72,10 +72,10 @@ void fork_connector(pid_t ppid, pid_t pt
 		forkmsg = (struct cn_fork_msg *)msg->data;
 		forkmsg->type = FORK_CN_MSG_P;
 		forkmsg->cpu = smp_processor_id();
-		forkmsg->u.s.ppid = ppid;
-		forkmsg->u.s.ptid = ptid;
-		forkmsg->u.s.cpid = cpid;
-		forkmsg->u.s.ctid = ctid;
+		forkmsg->ppid = ppid;
+		forkmsg->ptid = ptid;
+		forkmsg->cpid = cpid;
+		forkmsg->ctid = ctid;
 
 		put_cpu_var(fork_counts);
 
@@ -107,7 +107,7 @@ static inline void cn_fork_send_status(v
 	msg->len = CN_FORK_INFO_SIZE;
 	forkmsg = (struct cn_fork_msg *)msg->data;
 	forkmsg->type = FORK_CN_MSG_S;
-	forkmsg->u.status = cn_fork_enable;
+	forkmsg->status = cn_fork_enable;
 
 	cn_netlink_send(msg, CN_IDX_FORK, GFP_KERNEL);
 }
Index: linux-2.6.13-rc1-mm1/include/linux/cn_exit.h
===================================================================
--- linux-2.6.13-rc1-mm1.orig/include/linux/cn_exit.h	2005-07-04 14:21:05.000000000 +0200
+++ linux-2.6.13-rc1-mm1/include/linux/cn_exit.h	2005-07-04 14:42:11.000000000 +0200
@@ -41,14 +41,14 @@ struct cn_exit_msg {
 	int type;	/* 0: information about processes
 			   1: exit connector's state      */
 	int cpu;	/* ID of the cpu where the exit occurred */
-	union {
-		struct {
-			pid_t pid;	/* process ID */
-			pid_t ptid;	/* process thread ID  */
-			pid_t code;	/* process exit code */
-		} s;
-		int status;
-	} u;
+	
+	/* Information about processes */
+	pid_t pid;	/* process ID */
+	pid_t ptid;	/* process thread ID  */
+	pid_t code;	/* process exit code */
+	
+	/* Exit connector's state */	
+	int status;
 };
 
 /* Code above is only inside the kernel */
Index: linux-2.6.13-rc1-mm1/include/linux/cn_fork.h
===================================================================
--- linux-2.6.13-rc1-mm1.orig/include/linux/cn_fork.h	2005-07-04 14:21:05.000000000 +0200
+++ linux-2.6.13-rc1-mm1/include/linux/cn_fork.h	2005-07-04 14:39:17.000000000 +0200
@@ -49,15 +49,15 @@ struct cn_fork_msg {
 	int type;	/* 0: information about processes
 			   1: fork connector's state      */
 	int cpu;	/* ID of the cpu where the fork occurred */
-	union {
-		struct {
-			pid_t ppid;	/* parent process ID */
-			pid_t ptid;	/* parent thread ID  */
-			pid_t cpid;	/* child process ID  */
-			pid_t ctid;	/* child thread ID   */
-		} s;
-		int status;
-	} u;
+
+	/* Information about processes */
+	pid_t ppid;	/* parent process ID */
+	pid_t ptid;	/* parent thread ID  */
+	pid_t cpid;	/* child process ID  */
+	pid_t ctid;	/* child thread ID   */
+	
+	/* fork connector's state */
+	int status;
 };
 
 /* Code above is only inside the kernel */
