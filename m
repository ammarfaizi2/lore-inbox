Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316408AbSGQSVt>; Wed, 17 Jul 2002 14:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316430AbSGQSVs>; Wed, 17 Jul 2002 14:21:48 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:24595 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316408AbSGQSVo>;
	Wed, 17 Jul 2002 14:21:44 -0400
Date: Wed, 17 Jul 2002 11:23:32 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [BK PATCH] LSM setup changes for 2.5.26
Message-ID: <20020717182332.GC9550@kroah.com>
References: <20020717182305.GB9550@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020717182305.GB9550@kroah.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Wed, 19 Jun 2002 17:18:18 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.639   -> 1.639.1.1
#	 include/linux/msg.h	1.1     -> 1.2    
#	           ipc/msg.c	1.4     -> 1.5    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/15	greg@kroah.com	1.639.1.1
# LSM: move the struct msg_msg and struct msg_queue definitions out of the msg.c file to the msg.h file
# 
# Also move where the msg->q_perm.mode and .key values get set to before 
# ipc_addid() gets called to make placing a hook there easier.
# --------------------------------------------
#
diff -Nru a/include/linux/msg.h b/include/linux/msg.h
--- a/include/linux/msg.h	Wed Jul 17 11:08:16 2002
+++ b/include/linux/msg.h	Wed Jul 17 11:08:16 2002
@@ -63,6 +63,35 @@
 
 #ifdef __KERNEL__
 
+/* one msg_msg structure for each message */
+struct msg_msg {
+	struct list_head m_list; 
+	long  m_type;          
+	int m_ts;           /* message text size */
+	struct msg_msgseg* next;
+	/* the actual message follows immediately */
+};
+
+#define DATALEN_MSG	(PAGE_SIZE-sizeof(struct msg_msg))
+#define DATALEN_SEG	(PAGE_SIZE-sizeof(struct msg_msgseg))
+
+/* one msq_queue structure for each present queue on the system */
+struct msg_queue {
+	struct kern_ipc_perm q_perm;
+	time_t q_stime;			/* last msgsnd time */
+	time_t q_rtime;			/* last msgrcv time */
+	time_t q_ctime;			/* last change time */
+	unsigned long q_cbytes;		/* current number of bytes on queue */
+	unsigned long q_qnum;		/* number of messages in queue */
+	unsigned long q_qbytes;		/* max number of bytes on queue */
+	pid_t q_lspid;			/* pid of last msgsnd */
+	pid_t q_lrpid;			/* last receive pid */
+
+	struct list_head q_messages;
+	struct list_head q_receivers;
+	struct list_head q_senders;
+};
+
 asmlinkage long sys_msgget (key_t key, int msgflg);
 asmlinkage long sys_msgsnd (int msqid, struct msgbuf *msgp, size_t msgsz, int msgflg);
 asmlinkage long sys_msgrcv (int msqid, struct msgbuf *msgp, size_t msgsz, long msgtyp, int msgflg);
diff -Nru a/ipc/msg.c b/ipc/msg.c
--- a/ipc/msg.c	Wed Jul 17 11:08:16 2002
+++ b/ipc/msg.c	Wed Jul 17 11:08:16 2002
@@ -52,34 +52,6 @@
 	struct msg_msgseg* next;
 	/* the next part of the message follows immediately */
 };
-/* one msg_msg structure for each message */
-struct msg_msg {
-	struct list_head m_list; 
-	long  m_type;          
-	int m_ts;           /* message text size */
-	struct msg_msgseg* next;
-	/* the actual message follows immediately */
-};
-
-#define DATALEN_MSG	(PAGE_SIZE-sizeof(struct msg_msg))
-#define DATALEN_SEG	(PAGE_SIZE-sizeof(struct msg_msgseg))
-
-/* one msq_queue structure for each present queue on the system */
-struct msg_queue {
-	struct kern_ipc_perm q_perm;
-	time_t q_stime;			/* last msgsnd time */
-	time_t q_rtime;			/* last msgrcv time */
-	time_t q_ctime;			/* last change time */
-	unsigned long q_cbytes;		/* current number of bytes on queue */
-	unsigned long q_qnum;		/* number of messages in queue */
-	unsigned long q_qbytes;		/* max number of bytes on queue */
-	pid_t q_lspid;			/* pid of last msgsnd */
-	pid_t q_lrpid;			/* last receive pid */
-
-	struct list_head q_messages;
-	struct list_head q_receivers;
-	struct list_head q_senders;
-};
 
 #define SEARCH_ANY		1
 #define SEARCH_EQUAL		2
@@ -122,13 +94,15 @@
 	msq  = (struct msg_queue *) kmalloc (sizeof (*msq), GFP_KERNEL);
 	if (!msq) 
 		return -ENOMEM;
+
+	msq->q_perm.mode = (msgflg & S_IRWXUGO);
+	msq->q_perm.key = key;
+
 	id = ipc_addid(&msg_ids, &msq->q_perm, msg_ctlmni);
 	if(id == -1) {
 		kfree(msq);
 		return -ENOSPC;
 	}
-	msq->q_perm.mode = (msgflg & S_IRWXUGO);
-	msq->q_perm.key = key;
 
 	msq->q_stime = msq->q_rtime = 0;
 	msq->q_ctime = CURRENT_TIME;
