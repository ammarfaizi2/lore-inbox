Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264310AbUBSO1b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 09:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267197AbUBSO1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 09:27:31 -0500
Received: from leon.mat.uni.torun.pl ([158.75.2.17]:13962 "EHLO
	Leon.mat.uni.torun.pl") by vger.kernel.org with ESMTP
	id S264310AbUBSO1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 09:27:04 -0500
Date: Thu, 19 Feb 2004 15:26:58 +0100 (CET)
From: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
X-X-Sender: golbi@Juliusz
To: linux-kernel@vger.kernel.org
cc: Michal Wronski <wrona@mat.uni.torun.pl>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: [RFC][PATCH] 1/6 POSIX message queues
Message-ID: <Pine.GSO.4.58.0402191525500.18841@Juliusz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 6
//  SUBLEVEL = 2
//  EXTRAVERSION =
--- 2.6/ipc/msg.c	2004-02-14 16:44:43.000000000 +0100
+++ build-2.6/ipc/msg.c	2004-02-14 16:51:51.000000000 +0100
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
--- 2.6/ipc/util.c	2004-01-09 07:59:26.000000000 +0100
+++ build-2.6/ipc/util.c	2004-02-14 16:51:51.000000000 +0100
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
--- 2.6/ipc/util.h	2004-01-09 07:59:44.000000000 +0100
+++ build-2.6/ipc/util.h	2004-02-14 16:51:51.000000000 +0100
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
