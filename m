Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263768AbTJCQAB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 12:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263773AbTJCQAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 12:00:00 -0400
Received: from smtpout.mac.com ([17.250.248.97]:51682 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S263768AbTJCP7s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 11:59:48 -0400
Subject: [PATCH] [1/2] posix message queues
From: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@mac.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, torvalds@osdl.org, bo.z.li@intel.com,
       manfred@colorfullife.com
Content-Type: multipart/mixed; boundary="=-bR1VYPx6m3CVSnetVbL3"
Organization: 
Message-Id: <1065196642.3682.52.camel@picklock.adams.family>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 03 Oct 2003 17:57:22 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-bR1VYPx6m3CVSnetVbL3
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I was made aware that OSDL wants to include a Posix mqueue
implementation for 2.6

The following patchset includes that.

[1/2] splits up ipc/msg.c and ipc/util.c so that code can be shared
between SySV and Posix mqueues

I renamed store_msg/load_msg to put_msg/get_msg for better reading
and removed some signed/unsigned warnings

[2/2] implements the interface in ipc/posixmsg.c through a set of
new syscalls and a new pseudo filesystem msgfs
the implementation passes the posixtestsuite 1.2 and has SIGEV_THREAD
support through userspace (taken from Benedyczak,Wronski)




--=-bR1VYPx6m3CVSnetVbL3
Content-Description: 
Content-Disposition: attachment; filename=px.msg
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

diff -X dontdiff -Nur vanilla-2.6.0-test6/ipc/msg.c linux-2.6.0-test6/ipc/msg.c
--- vanilla-2.6.0-test6/ipc/msg.c	2003-09-24 22:41:47.000000000 +0200
+++ linux-2.6.0-test6/ipc/msg.c	2003-10-03 13:28:08.000000000 +0200
@@ -33,29 +33,6 @@
 int msg_ctlmnb = MSGMNB;
 int msg_ctlmni = MSGMNI;
 
-/* one msg_receiver structure for each sleeping receiver */
-struct msg_receiver {
-	struct list_head r_list;
-	struct task_struct* r_tsk;
-
-	int r_mode;
-	long r_msgtype;
-	long r_maxsize;
-
-	struct msg_msg* volatile r_msg;
-};
-
-/* one msg_sender for each sleeping sender */
-struct msg_sender {
-	struct list_head list;
-	struct task_struct* tsk;
-};
-
-struct msg_msgseg {
-	struct msg_msgseg* next;
-	/* the next part of the message follows immediately */
-};
-
 #define SEARCH_ANY		1
 #define SEARCH_EQUAL		2
 #define SEARCH_NOTEQUAL		3
@@ -129,106 +106,6 @@
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
@@ -657,7 +534,7 @@
 	if (mtype < 1)
 		return -EINVAL;
 
-	msg = load_msg(msgp->mtext, msgsz);
+	msg = get_msg(msgp->mtext, msgsz);
 	if(IS_ERR(msg))
 		return PTR_ERR(msg);
 
@@ -810,7 +687,7 @@
 out_success:
 		msgsz = (msgsz > msg->m_ts) ? msg->m_ts : msgsz;
 		if (put_user (msg->m_type, &msgp->mtype) ||
-		    store_msg(msgp->mtext, msg, msgsz)) {
+		    put_msg(msgp->mtext, msg, msgsz)) {
 			    msgsz = -EFAULT;
 		}
 		free_msg(msg);
diff -X dontdiff -Nur vanilla-2.6.0-test6/ipc/util.c linux-2.6.0-test6/ipc/util.c
--- vanilla-2.6.0-test6/ipc/util.c	2003-09-24 22:41:47.000000000 +0200
+++ linux-2.6.0-test6/ipc/util.c	2003-10-03 14:58:35.000000000 +0200
@@ -85,6 +86,126 @@
 }
 
 /**
+ *	get_msg	-	fetches a msg from userspace and copies it into kernel space
+ *	@src: user pointer to read from
+ *	@len: length of msg
+ *	
+ *  returns the newly kmalloc'ed address of the message
+ */
+struct msg_msg* get_msg(void* src, int len)
+{
+	struct msg_msg* msg;
+	struct msg_msgseg** pseg;
+	int err;
+	int alen;
+
+	alen = len;
+	if(alen > (int)DATALEN_MSG)
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
+		if(alen > (int)DATALEN_SEG)
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
+/**
+ *	put_msg	-	copies a msg to userspace
+ *	@dest: user space pointer to destination buffer
+ *	@msg: message to copy
+ *	@len: length of the buffer
+ *
+ *  returns 0 on success and -1 on error
+ */
+int put_msg(void* dest, struct msg_msg* msg, int len)
+{
+	int alen;
+	struct msg_msgseg *seg;
+
+	alen = len;
+	if(alen > (int)DATALEN_MSG)
+		alen = DATALEN_MSG;
+	if(copy_to_user (dest, msg+1, alen))
+		return -1;
+
+	len -= alen;
+	dest = ((char*)dest)+alen;
+	seg = msg->next;
+	while(len > 0) {
+		alen = len;
+		if(alen > (int)DATALEN_SEG)
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
+/**
+ *	free_msg	-	frees the msg formerly stored by get_msg
+ *	@msg: message to free
+ *
+ */
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
+/**
  *	ipc_findkey	-	find a key in an ipc identifier set	
  *	@ids: Identifier set
  *	@key: The key to find
@@ -253,7 +374,7 @@
 void* ipc_alloc(int size)
 {
 	void* out;
-	if(size > PAGE_SIZE)
+	if(size > (int)PAGE_SIZE)
 		out = vmalloc(size);
 	else
 		out = kmalloc(size, GFP_KERNEL);
@@ -271,7 +392,7 @@
 
 void ipc_free(void* ptr, int size)
 {
-	if(size > PAGE_SIZE)
+	if(size > (int)PAGE_SIZE)
 		vfree(ptr);
 	else
 		kfree(ptr);
@@ -504,7 +625,7 @@
 
 int ipc_checkid(struct ipc_ids* ids, struct kern_ipc_perm* ipcp, int uid)
 {
-	if(uid/SEQ_MULTIPLIER != ipcp->seq)
+	if((unsigned long)uid/SEQ_MULTIPLIER != ipcp->seq)
 		return 1;
 	return 0;
 }
diff -X dontdiff -Nur vanilla-2.6.0-test6/ipc/util.h linux-2.6.0-test6/ipc/util.h
--- vanilla-2.6.0-test6/ipc/util.h	2003-08-23 01:56:56.000000000 +0200
+++ linux-2.6.0-test6/ipc/util.h	2003-10-01 00:18:39.000000000 +0200
@@ -25,6 +25,32 @@
 	struct kern_ipc_perm* p;
 };
 
+/* one msg_receiver structure for each sleeping receiver */
+struct msg_receiver {
+	struct list_head r_list;
+	struct task_struct* r_tsk;
+
+	int r_mode;
+	long r_msgtype;
+	long r_maxsize;
+
+	struct msg_msg* volatile r_msg;
+};
+
+/* one msg_sender for each sleeping sender */
+struct msg_sender {
+	struct list_head list;
+	struct task_struct* tsk;
+};
+
+struct msg_msgseg {
+	struct msg_msgseg* next;
+	/* the next part of the message follows immediately */
+};
+struct msg_msg* get_msg(void* src, int len);
+int put_msg(void* dest, struct msg_msg* msg, int len);
+void free_msg(struct msg_msg* msg);
+
 void __init ipc_init_ids(struct ipc_ids* ids, int size);
 
 /* must be called with ids->sem acquired.*/

--=-bR1VYPx6m3CVSnetVbL3--

