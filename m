Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbTKYLkt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 06:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262355AbTKYLkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 06:40:49 -0500
Received: from leon.mat.uni.torun.pl ([158.75.2.17]:37773 "EHLO
	Leon.mat.uni.torun.pl") by vger.kernel.org with ESMTP
	id S262352AbTKYLkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 06:40:42 -0500
Date: Tue, 25 Nov 2003 12:40:24 +0100 (CET)
From: Michal Wronski <wrona@mat.uni.torun.pl>
X-X-Sender: wrona@Juliusz
To: linux-kernel@vger.kernel.org
cc: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
Subject: [PATCH] 1/2 POSIX message queues 
Message-ID: <Pine.GSO.4.58.0311251233040.12527@Juliusz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is improved version of mqueues (against 2.6.0-test10).
As suggested it is split into two patches.
The first one moves free/load/store_msg from msg.c to util.c
The second one contains mqueues specific code.

We have applied some fixes and added support for sysctls. Each parameter
is now tunable. Global limit for messages size was removed.
Also there are some changes taken from J. Korty patch to make this code
more arch portable.

New library is available at:
http://www.mat.uni.torun.pl/~wrona/posix_ipc

Regards,
Michal



diff -urN 2.6.0-test10-orig_1/ipc/msg.c 2.6.0-test10-patched_1/ipc/msg.c
--- 2.6.0-test10-orig_1/ipc/msg.c	2003-11-07 17:07:13.000000000 +0100
+++ 2.6.0-test10-patched_1/ipc/msg.c	2003-11-21 17:11:17.000000000 +0100
@@ -51,11 +51,6 @@
 	struct task_struct* tsk;
 };

-struct msg_msgseg {
-	struct msg_msgseg* next;
-	/* the next part of the message follows immediately */
-};
-
 #define SEARCH_ANY		1
 #define SEARCH_EQUAL		2
 #define SEARCH_NOTEQUAL		3
@@ -129,106 +124,6 @@
 	return msg_buildid(id,msq->q_perm.seq);
 }

-static void free_msg(struct msg_msg* msg)
-{
-	struct msg_msgseg* seg;
-
-	security_msg_msg_free(msg);
-
-	seg = msg->next;
-	kfree(msg);
-	while(seg != NULL) {
-		struct msg_msgseg* tmp = seg->next;
-		kfree(seg);
-		seg = tmp;
-	}
-}
-
-static struct msg_msg* load_msg(void* src, int len)
-{
-	struct msg_msg* msg;
-	struct msg_msgseg** pseg;
-	int err;
-	int alen;
-
-	alen = len;
-	if(alen > DATALEN_MSG)
-		alen = DATALEN_MSG;
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
-		}
-		*pseg = seg;
-		seg->next = NULL;
-		if(copy_from_user (seg+1, src, alen)) {
-			err = -EFAULT;
-			goto out_err;
-		}
-		pseg = &seg->next;
-		len -= alen;
-		src = ((char*)src)+alen;
-	}
-
-	err = security_msg_msg_alloc(msg);
-	if (err)
-		goto out_err;
-
-	return msg;
-
-out_err:
-	free_msg(msg);
-	return ERR_PTR(err);
-}
-
-static int store_msg(void* dest, struct msg_msg* msg, int len)
-{
-	int alen;
-	struct msg_msgseg *seg;
-
-	alen = len;
-	if(alen > DATALEN_MSG)
-		alen = DATALEN_MSG;
-	if(copy_to_user (dest, msg+1, alen))
-		return -1;
-
-	len -= alen;
-	dest = ((char*)dest)+alen;
-	seg = msg->next;
-	while(len > 0) {
-		alen = len;
-		if(alen > DATALEN_SEG)
-			alen = DATALEN_SEG;
-		if(copy_to_user (dest, seg+1, alen))
-			return -1;
-		len -= alen;
-		dest = ((char*)dest)+alen;
-		seg=seg->next;
-	}
-	return 0;
-}
-
 static inline void ss_add(struct msg_queue* msq, struct msg_sender* mss)
 {
 	mss->tsk=current;
diff -urN 2.6.0-test10-orig_1/ipc/util.c 2.6.0-test10-patched_1/ipc/util.c
--- 2.6.0-test10-orig_1/ipc/util.c	2003-11-07 17:07:13.000000000 +0100
+++ 2.6.0-test10-patched_1/ipc/util.c	2003-11-21 17:11:17.000000000 +0100
@@ -611,3 +611,107 @@
 }

 #endif /* CONFIG_SYSVIPC */
+
+#ifdef CONFIG_SYSVIPC
+
+void free_msg(struct msg_msg* msg)
+{
+	struct msg_msgseg* seg;
+
+	security_msg_msg_free(msg);
+
+	seg = msg->next;
+	kfree(msg);
+	while(seg != NULL) {
+		struct msg_msgseg* tmp = seg->next;
+		kfree(seg);
+		seg = tmp;
+	}
+}
+
+struct msg_msg* load_msg(void* src, int len)
+{
+	struct msg_msg* msg;
+	struct msg_msgseg** pseg;
+	int err;
+	int alen;
+
+	alen = len;
+	if(alen > DATALEN_MSG)
+		alen = DATALEN_MSG;
+
+	msg = (struct msg_msg *) kmalloc (sizeof(*msg) + alen, GFP_KERNEL);
+	if(msg==NULL)
+		return ERR_PTR(-ENOMEM);
+
+	msg->next = NULL;
+	msg->security = NULL;
+
+	if (copy_from_user(msg+1, src, alen)) {
+		err = -EFAULT;
+		goto out_err;
+	}
+
+	len -= alen;
+	src = ((char*)src)+alen;
+	pseg = &msg->next;
+	while(len > 0) {
+		struct msg_msgseg* seg;
+		alen = len;
+		if(alen > DATALEN_SEG)
+			alen = DATALEN_SEG;
+		seg = (struct msg_msgseg *) kmalloc (sizeof(*seg) + alen, GFP_KERNEL);
+		if(seg==NULL) {
+			err=-ENOMEM;
+			goto out_err;
+		}
+		*pseg = seg;
+		seg->next = NULL;
+		if(copy_from_user (seg+1, src, alen)) {
+			err = -EFAULT;
+			goto out_err;
+		}
+		pseg = &seg->next;
+		len -= alen;
+		src = ((char*)src)+alen;
+	}
+
+	err = security_msg_msg_alloc(msg);
+	if (err)
+		goto out_err;
+
+	return msg;
+
+out_err:
+	free_msg(msg);
+	return ERR_PTR(err);
+}
+
+int store_msg(void* dest, struct msg_msg* msg, int len)
+{
+	int alen;
+	struct msg_msgseg *seg;
+
+	alen = len;
+	if(alen > DATALEN_MSG)
+		alen = DATALEN_MSG;
+	if(copy_to_user (dest, msg+1, alen))
+		return -1;
+
+	len -= alen;
+	dest = ((char*)dest)+alen;
+	seg = msg->next;
+	while(len > 0) {
+		alen = len;
+		if(alen > DATALEN_SEG)
+			alen = DATALEN_SEG;
+		if(copy_to_user (dest, seg+1, alen))
+			return -1;
+		len -= alen;
+		dest = ((char*)dest)+alen;
+		seg=seg->next;
+	}
+	return 0;
+}
+
+#endif /* CONFIG_SYSVIPC */
diff -urN 2.6.0-test10-orig_1/ipc/util.h 2.6.0-test10-patched_1/ipc/util.h
--- 2.6.0-test10-orig_1/ipc/util.h	2003-11-07 17:07:13.000000000 +0100
+++ 2.6.0-test10-patched_1/ipc/util.h	2003-11-21 17:11:17.000000000 +0100
@@ -25,6 +25,16 @@
 	struct kern_ipc_perm* p;
 };

+struct msg_msgseg {
+	struct msg_msgseg* next;
+	/* the next part of the message follows immediately */
+};
+
+void free_msg(struct msg_msg* msg);
+struct msg_msg* load_msg(void* src, int len);
+int store_msg(void* dest, struct msg_msg* msg, int len);
+
+
 void __init ipc_init_ids(struct ipc_ids* ids, int size);

 /* must be called with ids->sem acquired.*/
