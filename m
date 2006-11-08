Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161381AbWKHRgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161381AbWKHRgG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 12:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754612AbWKHRgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 12:36:05 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:51924 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1754613AbWKHRgC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 12:36:02 -0500
Message-ID: <45521580.5000606@in.ibm.com>
Date: Wed, 08 Nov 2006 09:36:00 -0800
From: Suzuki K P <suzuki@in.ibm.com>
Reply-To: suzuki@in.ibm.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060413 Red Hat/1.7.13-1.4.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Behaviour of compat_msgsnd/compat_msgrcv calls
References: <453FB3F9.9080704@in.ibm.com> <20061025.134932.63125874.davem@davemloft.net>
In-Reply-To: <20061025.134932.63125874.davem@davemloft.net>
Content-Type: multipart/mixed;
 boundary="------------060201020603020802090103"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060201020603020802090103
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


-- Original Post ---
> Hi,
> 
> I have a question regarding the behaviour of the comapt_msgsnd/ compat_msgrcv ()s. Don't know if this has been discussed already or if as I could not find any threads in the archives. Please bear with me if this is really a stupid question.
> 
>  The maximum length of the message that can be sent or received in any of those functions above is MAXBUF-(sizeof (struct msgbuf)), where MAXBUF is 64k.
> 
> ipc/compat.c : compat_msgrcv()
>         if (second < 0 || (second >= MAXBUF - sizeof(struct msgbuf)))
>                           ^^^^^^
>                 return -EINVAL;
> 
> Is this limit due to the buffer allocation in user space as below ?
> 
>  And the way we are doing this is by allocating a buffer of msgsize on the userspace stack using compat_alloc_user_space() instead of using the buffer provided by the user and later copying the result back to the user buffer.
>> 
>>Is there any specific reason behind this ? Can't we just use the user 
>>buffer directly instead of doing an additional copy_in_user ?
>>ie,
>>	err = sys_msgrcv(first, uptr, second, msgtyp, third);
> 
> 
-- Dave suggested --
> It's the cleanest way to deal with the difference in
> "struct msgbuf" layout between native and compat userspace.
> 
> I guess we could make some common do_sys_msgrcv() function
> that passed in a pointer to the "msgbuf" and the buffer
> seperately.

Dave,

I have attached a patch which does the same here. It introduces
do_msgrcv()/ do_msgsnd() routines to service the sys_msgxxx variants.
The do_msgxxx variants accepts an additional "mtext" parameter along
with the sys_msgxxx paramters.
i.e,

asmlinkage long sys_msgrcv(int msqid, struct msgbuf __user *msgp,
				size_t msgsz, long msgtyp, int msgflg)
{
           return do_msgrcv(msqid, msgp, msgp->mtext, msgsz, msgtyp,
   			   msgflg);
}

Comments ?

Thanks,

-Suzuki







--------------060201020603020802090103
Content-Type: text/x-patch;
 name="fix-compat-ipc-msg-size-limit.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-compat-ipc-msg-size-limit.diff"

* Fix the size limit of compat space msgsize. Currently we allocate 64k space on the user stack and use it the msgbuf for sys_msgxxx, and the results are later copied in user [ by copy_in_user]. This patch introduces helper routines for sys_msgxxx which would accept the pointer to msgbuf along with the msgp->mtext. This avoids the need to allocate the msgsize on the userspace ( thus removing the size limt ) and the overhead of an extra copy_in_user().

Signed-off-by: Suzuki K P <suzuki@in.ibm.com>

Index: linux-2.6.18.i386/include/linux/msg.h
===================================================================
--- linux-2.6.18.i386.orig/include/linux/msg.h	2006-09-19 20:42:06.000000000 -0700
+++ linux-2.6.18.i386/include/linux/msg.h	2006-11-02 10:42:13.000000000 -0800
@@ -92,6 +92,12 @@
 	struct list_head q_senders;
 };
 
+/* Helper routines for sys_msgxxx */
+extern long do_msgsnd(int msqid, struct msgbuf __user* msgp, void __user* mtext,
+			size_t msgsz, int msgflg);
+extern long do_msgrcv(int msqid, struct msgbuf __user *msgp, void __user* mtext,
+			size_t msgsz, long msgtyp, int msgflg);
+
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_MSG_H */
Index: linux-2.6.18.i386/ipc/compat.c
===================================================================
--- linux-2.6.18.i386.orig/ipc/compat.c	2006-09-19 20:42:06.000000000 -0700
+++ linux-2.6.18.i386/ipc/compat.c	2006-11-03 14:23:02.000000000 -0800
@@ -115,7 +115,6 @@
 
 extern int sem_ctls[];
 #define sc_semopm	(sem_ctls[2])
-#define MAXBUF (64*1024)
 
 static inline int compat_ipc_parse_version(int *cmd)
 {
@@ -313,16 +312,15 @@
 
 	if (first < 0)
 		return -EINVAL;
-	if (second < 0 || (second >= MAXBUF - sizeof(struct msgbuf)))
+	if (second < 0)
 		return -EINVAL;
 
-	p = compat_alloc_user_space(second + sizeof(struct msgbuf));
+	p = compat_alloc_user_space(sizeof(struct msgbuf));
 	if (get_user(type, &up->mtype) ||
-	    put_user(type, &p->mtype) ||
-	    copy_in_user(p->mtext, up->mtext, second))
+	    put_user(type, &p->mtype))
 		return -EFAULT;
 
-	return sys_msgsnd(first, p, second, third);
+	return do_msgsnd(first, p, up->mtext, second, third);
 }
 
 long compat_sys_msgrcv(int first, int second, int msgtyp, int third,
@@ -335,7 +333,7 @@
 
 	if (first < 0)
 		return -EINVAL;
-	if (second < 0 || (second >= MAXBUF - sizeof(struct msgbuf)))
+	if (second < 0)
 		return -EINVAL;
 
 	if (!version) {
@@ -349,14 +347,13 @@
 		uptr = compat_ptr(ipck.msgp);
 		msgtyp = ipck.msgtyp;
 	}
-	p = compat_alloc_user_space(second + sizeof(struct msgbuf));
-	err = sys_msgrcv(first, p, second, msgtyp, third);
+	up = uptr;
+	p = compat_alloc_user_space(sizeof(struct msgbuf));
+	err = do_msgrcv(first, p, up->mtext, second, msgtyp, third);
 	if (err < 0)
 		goto out;
-	up = uptr;
 	if (get_user(type, &p->mtype) ||
-	    put_user(type, &up->mtype) ||
-	    copy_in_user(up->mtext, p->mtext, err))
+	    put_user(type, &up->mtype))
 		err = -EFAULT;
 out:
 	return err;
Index: linux-2.6.18.i386/ipc/msg.c
===================================================================
--- linux-2.6.18.i386.orig/ipc/msg.c	2006-09-19 20:42:06.000000000 -0700
+++ linux-2.6.18.i386/ipc/msg.c	2006-11-02 10:43:10.000000000 -0800
@@ -575,8 +575,8 @@
 	return 0;
 }
 
-asmlinkage long
-sys_msgsnd(int msqid, struct msgbuf __user *msgp, size_t msgsz, int msgflg)
+long do_msgsnd(int msqid, struct msgbuf __user* msgp, void __user* mtext,
+		size_t msgsz, int msgflg)
 {
 	struct msg_queue *msq;
 	struct msg_msg *msg;
@@ -590,7 +590,7 @@
 	if (mtype < 1)
 		return -EINVAL;
 
-	msg = load_msg(msgp->mtext, msgsz);
+	msg = load_msg(mtext, msgsz);
 	if (IS_ERR(msg))
 		return PTR_ERR(msg);
 
@@ -669,6 +669,12 @@
 	return err;
 }
 
+asmlinkage long
+sys_msgsnd(int msqid, struct msgbuf __user *msgp, size_t msgsz, int msgflg)
+{
+	return do_msgsnd(msqid, msgp, msgp->mtext, msgsz, msgflg);
+}
+
 static inline int convert_mode(long *msgtyp, int msgflg)
 {
 	/*
@@ -688,8 +694,8 @@
 	return SEARCH_EQUAL;
 }
 
-asmlinkage long sys_msgrcv(int msqid, struct msgbuf __user *msgp, size_t msgsz,
-			   long msgtyp, int msgflg)
+long do_msgrcv(int msqid, struct msgbuf __user *msgp, void __user* mtext,
+		size_t msgsz, long msgtyp, int msgflg)
 {
 	struct msg_queue *msq;
 	struct msg_msg *msg;
@@ -834,7 +840,7 @@
 
 	msgsz = (msgsz > msg->m_ts) ? msg->m_ts : msgsz;
 	if (put_user (msg->m_type, &msgp->mtype) ||
-	    store_msg(msgp->mtext, msg, msgsz)) {
+	    store_msg(mtext, msg, msgsz)) {
 		msgsz = -EFAULT;
 	}
 	free_msg(msg);
@@ -842,6 +848,12 @@
 	return msgsz;
 }
 
+asmlinkage long sys_msgrcv(int msqid, struct msgbuf __user *msgp, size_t msgsz,
+			   long msgtyp, int msgflg)
+{
+	return do_msgrcv(msqid, msgp, msgp->mtext, msgsz, msgtyp, msgflg);
+}
+
 #ifdef CONFIG_PROC_FS
 static int sysvipc_msg_proc_show(struct seq_file *s, void *it)
 {

--------------060201020603020802090103--
