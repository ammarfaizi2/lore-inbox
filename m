Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbTFFNr6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 09:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbTFFNr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 09:47:58 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:36736 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id S261454AbTFFNrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 09:47:47 -0400
Subject: [RFC][PATCH 2.5.70] dynamically tuning msgtql
From: Dhruv Anand <dhruv.anand@wipro.com>
To: linux-kernel@vger.kernel.org
Cc: indou.takao@jp.fujitsu.com, akpm@zip.com.au, ahaas@airmail.net,
       dalecki@evision-ventures.com, ezolt@perf.zko.dec.com,
       rob.naccarato@sheridanc.on.ca, Dave@imladris.demon.co.uk
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-4) 
Date: 06 Jun 2003 19:30:10 +0530
Message-Id: <1054908010.18527.7.camel@m2-arvind>
Mime-Version: 1.0
X-OriginalArrivalTime: 06 Jun 2003 14:00:51.0408 (UTC) FILETIME=[09FE2D00:01C32C34]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Please find below the patch (RFC) that makes msgtql dynamically tunable
through /proc interface. 

1) IPC_NOWAIT flag not handled.
Handling this will cause overheads (additional queue, wake-ups etc). 
Please comment.

Or Handling IPC_NOWAIT may require:
a) An additional global queue for processes when message to be 
queued is > msgtql && IPC_NOWAIT flag is not set.
Please comment.

Thanks,
Dhruv

diff -Nur linux-2.5.70/include/linux/msg.h linux-2.5.70msg/include/linux/msg.h
--- linux-2.5.70/include/linux/msg.h	Tue May 27 06:30:40 2003
+++ linux-2.5.70msg/include/linux/msg.h	Fri Jun  6 14:31:26 2003
@@ -49,13 +49,13 @@
 	unsigned short  msgseg; 
 };
 
-#define MSGMNI    16   /* <= IPCMNI */     /* max # of msg queue identifiers */
-#define MSGMAX  8192   /* <= INT_MAX */   /* max size of message (bytes) */
-#define MSGMNB 16384   /* <= INT_MAX */   /* default max size of a message queue */
+#define MSGMNI    16      /* <= IPCMNI  */   /* max # of msg queue identifiers */
+#define MSGMAX  8192      /* <= INT_MAX */   /* max size of message (bytes) */
+#define MSGMNB 16384   	  /* <= INT_MAX */   /* default max size of a message queue */
+#define MSGTQL 0x7fffffff /* <= INT_MAX */   /* number of system message */
 
 /* unused */
 #define MSGPOOL (MSGMNI*MSGMNB/1024)  /* size in kilobytes of message pool */
-#define MSGTQL  MSGMNB            /* number of system message headers */
 #define MSGMAP  MSGMNB            /* number of entries in message map */
 #define MSGSSZ  16                /* message segment size */
 #define __MSGSEG ((MSGPOOL*1024)/ MSGSSZ) /* max no. of segments */
diff -Nur linux-2.5.70/include/linux/sysctl.h linux-2.5.70msg/include/linux/sysctl.h
--- linux-2.5.70/include/linux/sysctl.h	Tue May 27 06:30:40 2003
+++ linux-2.5.70msg/include/linux/sysctl.h	Fri Jun  6 14:00:54 2003
@@ -130,6 +130,7 @@
 	KERN_PIDMAX=55,		/* int: PID # limit */
   	KERN_CORE_PATTERN=56,	/* string: pattern for core-file names */
 	KERN_PANIC_ON_OOPS=57,  /* int: whether we will panic on an oops */
+	KERN_MSGTQL=57,         /* int: Maximum number of messages system wide */
 };
 

diff -Nur linux-2.5.70/ipc/msg.c linux-2.5.70msg/ipc/msg.c
--- linux-2.5.70/ipc/msg.c	Tue May 27 06:30:20 2003
+++ linux-2.5.70msg/ipc/msg.c	Fri Jun  6 18:43:42 2003
@@ -32,6 +32,9 @@
 int msg_ctlmax = MSGMAX;
 int msg_ctlmnb = MSGMNB;
 int msg_ctlmni = MSGMNI;
+int msg_ctltql = MSGTQL;
+static int msg_count = 0;               /* counter for MSGTQL */
+static spinlock_t msg_count_lock;       /* spinlock for MSGTQL */
 
 /* one msg_receiver structure for each sleeping receiver */
 struct msg_receiver {
@@ -137,6 +140,9 @@
 
 	seg = msg->next;
 	kfree(msg);
+	spin_lock(&msg_count_lock);
+	msg_count--;
+	spin_unlock(&msg_count_lock);
 	while(seg != NULL) {
 		struct msg_msgseg* tmp = seg->next;
 		kfree(seg);
@@ -154,48 +160,59 @@
 	alen = len;
 	if(alen > DATALEN_MSG)
 		alen = DATALEN_MSG;
-
-	msg = (struct msg_msg *) kmalloc (sizeof(*msg) + alen, GFP_KERNEL);
-	if(msg==NULL)
-		return ERR_PTR(-ENOMEM);
-
-	msg->next = NULL;
-	msg->security = NULL;
-
-	if (copy_from_user(msg+1, src, alen)) {
-		err = -EFAULT;
-		goto out_err;
-	}
-
-	len -= alen;
-	src = ((char*)src)+alen;
-	pseg = &msg->next;
-	while(len > 0) {
-		struct msg_msgseg* seg;
-		alen = len;
-		if(alen > DATALEN_SEG)
-			alen = DATALEN_SEG;
-		seg = (struct msg_msgseg *) kmalloc (sizeof(*seg) + alen, GFP_KERNEL);
-		if(seg==NULL) {
-			err=-ENOMEM;
-			goto out_err;
+	
+	spin_lock(&msg_count_lock);
+	if(msg_count < msg_ctltql){
+		msg = (struct msg_msg *) kmalloc (sizeof(*msg) + alen, GFP_KERNEL);
+		if(msg==NULL) {
+			spin_unlock(msg_count_lock);
+			return ERR_PTR(-ENOMEM);
 		}
-		*pseg = seg;
-		seg->next = NULL;
-		if(copy_from_user (seg+1, src, alen)) {
+		msg_count++;
+                spin_unlock(msg_count_lock);
+		msg->next = NULL;
+		msg->security = NULL;
+
+		if (copy_from_user(msg+1, src, alen)) {
 			err = -EFAULT;
 			goto out_err;
 		}
-		pseg = &seg->next;
+
 		len -= alen;
 		src = ((char*)src)+alen;
-	}
+		pseg = &msg->next;
+		while(len > 0) {
+			struct msg_msgseg* seg;
+			alen = len;
+			if(alen > DATALEN_SEG)
+			alen = DATALEN_SEG;
+			seg = (struct msg_msgseg *) kmalloc (sizeof(*seg) + alen, GFP_KERNEL);
+			if(seg==NULL) {
+				err=-ENOMEM;
+				goto out_err;
+			}
+			*pseg = seg;
+			seg->next = NULL;
+			if(copy_from_user (seg+1, src, alen)) {
+				err = -EFAULT;
+				goto out_err;
+			}
+			pseg = &seg->next;
+			len -= alen;
+			src = ((char*)src)+alen;
+		}
 	
-	err = security_msg_msg_alloc(msg);
-	if (err)
-		goto out_err;
+		err = security_msg_msg_alloc(msg);
+		if (err)
+			goto out_err;
 
-	return msg;
+		return msg;
+	}
+	else {
+		spin_unlock(&msg_count_lock);
+	        err= -EAGAIN;
+	        return ERR_PTR(err);
+	}
 
 out_err:
 	free_msg(msg);
diff -Nur linux-2.5.70/kernel/sysctl.c linux-2.5.70msg/kernel/sysctl.c
--- linux-2.5.70/kernel/sysctl.c	Tue May 27 06:30:23 2003
+++ linux-2.5.70msg/kernel/sysctl.c	Fri Jun  6 14:35:06 2003
@@ -61,6 +61,9 @@
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
 static int maxolduid = 65535;
 static int minolduid;
+static int zero = 0;
+static int one = 1;
+static int one_hundred = 100;
 
 #ifdef CONFIG_KMOD
 extern char modprobe_path[];
@@ -78,6 +81,7 @@
 extern int msg_ctlmax;
 extern int msg_ctlmnb;
 extern int msg_ctlmni;
+extern int msg_ctltql;
 extern int sem_ctls[];
 #endif
 
@@ -235,6 +239,8 @@
 	 0644, NULL, &proc_dointvec},
 	{KERN_MSGMNB, "msgmnb", &msg_ctlmnb, sizeof (int),
 	 0644, NULL, &proc_dointvec},
+	{KERN_MSGTQL, "msgtql", &msg_ctltql, sizeof (int),
+         0644, NULL, &proc_dointvec_minmax, NULL, NULL, &zero, NULL},
 	{KERN_SEM, "sem", &sem_ctls, 4*sizeof (int),
 	 0644, NULL, &proc_dointvec},
 #endif
@@ -270,9 +276,6 @@
 
 /* Constants for minimum and maximum testing in vm_table.
    We use these as one-element integer vectors. */
-static int zero = 0;
-static int one = 1;
-static int one_hundred = 100;
 

 static ctl_table vm_table[] = {


