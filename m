Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVEQGKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVEQGKw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 02:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVEQGKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 02:10:52 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:431 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261167AbVEQGKY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 02:10:24 -0400
Subject: [PATCH 2.6.12-rc4-mm2] fork connector: connector-send-status.patch
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Alexander Nyberg <alexn@dsv.su.se>, aq <aquynh@gmail.com>
Date: Tue, 17 May 2005 08:10:18 +0200
Message-Id: <1116310218.8374.11.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 17/05/2005 08:21:01,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 17/05/2005 08:21:02,
	Serialize complete at 17/05/2005 08:21:02
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

  This patch implements the sending of a message about the fork
connector's state (enabled or disabled). Now, when a user space
application asks the fork connector about its state, the fork connector
sends a message through the appropriate netlink interface.

		
Signed-off-by: guillaume.thouvenin@bull.net

---

 drivers/connector/cn_fork.c |   37 +++++++++++++++++++++++++++++++++++--
 include/linux/cn_fork.h     |   20 +++++++++++++++-----
 2 files changed, 50 insertions(+), 7 deletions(-)

Index: linux-2.6.12-rc4-mm2/drivers/connector/cn_fork.c
===================================================================
--- linux-2.6.12-rc4-mm2.orig/drivers/connector/cn_fork.c	2005-05-16 12:41:23.000000000 +0200
+++ linux-2.6.12-rc4-mm2/drivers/connector/cn_fork.c	2005-05-16 12:58:18.000000000 +0200
@@ -44,6 +44,16 @@ struct cb_id cb_fork_id = { CN_IDX_FORK,
 /* fork_counts is used as the sequence number of the netlink message */
 static DEFINE_PER_CPU(unsigned long, fork_counts);
 
+/**
+ * fork_connector - send information about fork through a connector
+ * @ppid: Parent process ID
+ * @ptid: Parent thread ID
+ * @cpid: Child process ID
+ * @ctid: Child thread ID
+ *
+ * It sends information to a user space application through the
+ * connector when a new process is created.
+ */
 void fork_connector(pid_t ppid, pid_t ptid, pid_t cpid, pid_t ctid)
 {
 	if (cn_fork_enable) {
@@ -60,6 +70,7 @@ void fork_connector(pid_t ppid, pid_t pt
 
 		msg->len = CN_FORK_INFO_SIZE;
 		forkmsg = (struct cn_fork_msg *)msg->data;
+		forkmsg->type = FORK_CN_MSG_P;
 		forkmsg->cpu = smp_processor_id();
 		forkmsg->ppid = ppid;
 		forkmsg->ptid = ptid;
@@ -73,10 +84,32 @@ void fork_connector(pid_t ppid, pid_t pt
 	}
 }
 
+/**
+ * cn_fork_send_status - send a message with the status
+ * 
+ * It sends information about the status of the fork connector 
+ * to a user space application through the connector. The status
+ * is stored in the global variable "cn_fork_enable".
+ */
 static inline void cn_fork_send_status(void)
 {
-	/* TODO: An informational line in log is maybe not enough... */
-	printk(KERN_INFO "cn_fork_enable == %d\n", cn_fork_enable);
+	struct cn_msg *msg;
+	struct cn_fork_msg *forkmsg;
+	__u8 buffer[CN_FORK_MSG_SIZE];
+
+	msg = (struct cn_msg *)buffer;
+
+	memcpy(&msg->id, &cb_fork_id, sizeof(msg->id));
+
+	msg->ack = 0;	/* not used */
+	msg->seq = 0;	/* not used */
+
+	msg->len = CN_FORK_INFO_SIZE;
+	forkmsg = (struct cn_fork_msg *)msg->data;
+	forkmsg->type = FORK_CN_MSG_S;
+	forkmsg->status = cn_fork_enable;
+
+	cn_netlink_send(msg, CN_IDX_FORK, GFP_KERNEL);
 }
 
 /**
Index: linux-2.6.12-rc4-mm2/include/linux/cn_fork.h
===================================================================
--- linux-2.6.12-rc4-mm2.orig/include/linux/cn_fork.h	2005-05-16 12:41:38.000000000 +0200
+++ linux-2.6.12-rc4-mm2/include/linux/cn_fork.h	2005-05-17 08:07:35.000000000 +0200
@@ -29,6 +29,9 @@
 #define FORK_CN_START	1
 #define FORK_CN_STATUS	2
 
+#define FORK_CN_MSG_P   0  /* Message about processes */
+#define FORK_CN_MSG_S   1  /* Message about fork connector's state */
+
 /*
  * The fork connector sends information to a user-space
  * application. From the user's point of view, the process
@@ -43,11 +46,18 @@
  * child  thread  ID  =  child->pid
  */
 struct cn_fork_msg {
-	int cpu;		/* ID of the cpu where the fork occured */
-	pid_t ppid;		/* parent process ID */
-	pid_t ptid;		/* parent thread ID  */
-	pid_t cpid;		/* child process ID  */
-	pid_t ctid;		/* child thread ID   */
+	int type;	/* 0: information about processes
+			   1: fork connector's state      */
+	int cpu;	/* ID of the cpu where the fork occurred */
+	union { 
+		struct {
+			pid_t ppid;	/* parent process ID */
+			pid_t ptid;	/* parent thread ID  */
+			pid_t cpid;	/* child process ID  */
+			pid_t ctid;	/* child thread ID   */
+		};
+		int status;
+	};
 };
 
 /* Code above is only inside the kernel */


