Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966478AbWKNXaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966478AbWKNXaw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 18:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966476AbWKNXaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 18:30:52 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:57238 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S966478AbWKNXav
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 18:30:51 -0500
Message-ID: <455A51AA.3080600@linux.vnet.ibm.com>
Date: Tue, 14 Nov 2006 15:30:50 -0800
From: suzuki <suzuki@linux.vnet.ibm.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: akpm@osdl.org, davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: + fix-compat-space-msg-size-limit-for-msgsnd-msgrcv.patch added
 to -mm tree
References: <200611132358.kADNwF0V012270@shell0.pdx.osdl.net>	<200611141049.36145.arnd@arndb.de> <455A3392.6040501@linux.vnet.ibm.com> <200611150024.25647.arnd@arndb.de>
In-Reply-To: <200611150024.25647.arnd@arndb.de>
Content-Type: multipart/mixed;
 boundary="------------030209050608060507030304"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030209050608060507030304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Arnd Bergmann wrote:
> On Tuesday 14 November 2006 22:22, suzuki wrote:
> 
>>Does the following change look fine ?
>>
>>do_msgsnd() - Accepting the mtype and user space ptr to the mtext. i.e.,
>>
>>long do_msgsnd(int msqid, long mtype, void __user *mtext,
>>                size_t msgsz, int msgflg);
>>and,
>>
>>do_msgrcv() - accepting the kernel space data ptr to pmtype and user 
>>space ptr to mtext. The caller has to copy the *pmtype back to the user 
>>space.
>>
>>i.e.,
>>
>>long do_msgrcv(int msqid, long *pmtype, void __user *mtext,
>>                        size_t msgsz, long msgtyp, int msgflg);
> 
> 
> Yes, that looks fine.
> 
> 
>>Can we use the kernel space "struct msgbuf" instead of the mtype being 
>>passed explicitly.
> 
> 
> That works as well, although it may be a little confusing to have
> the extra mtext byte of that structure included there, so I'd prefer
> the first solution.
Arnd,

Thanks for the input !

Here we go ! As per the suggestions, I have modified the patch.


Thanks,

Suzuki
> 
> 	Arnd <><


--------------030209050608060507030304
Content-Type: text/x-patch;
 name="fix-compat-msg-size.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-compat-msg-size.diff"


* 	Fix the size limit of compat space msgsize. 

Currently we allocate 64k space on the user stack and use it the msgbuf for sys_{msgrcv,msgsnd} for compat and the results are later copied in user [ by copy_in_user]. This patch introduces helper routines for sys_{msgrcv,msgsnd} as below:

do_msgsnd() : Accepts the mtype and user space ptr to the buffer along with the msqid and msgflg.
do_msgrcv() : Accepts a kernel space ptr to mtype and a userspace ptr to the buffer. The mtype has to be copied back the user space msgbuf by the caller.

These changes avoid the need to allocate the msgsize on the userspace ( thus removing the size limt ) and the overhead of an extra copy_in_user().

Signed-off-by: Suzuki K P <suzuki@in.ibm.com>

Index: linux-2.6.19-rc1/include/linux/msg.h
===================================================================
--- linux-2.6.19-rc1.orig/include/linux/msg.h	2006-09-19 20:42:06.000000000 -0700
+++ linux-2.6.19-rc1/include/linux/msg.h	2006-11-14 11:28:58.000000000 -0800
@@ -92,6 +92,12 @@
 	struct list_head q_senders;
 };
 
+/* Helper routines for sys_msgsnd and sys_msgrcv */
+extern long do_msgsnd(int msqid, long mtype, void __user *mtext,
+			size_t msgsz, int msgflg);
+extern long do_msgrcv(int msqid, long *pmtype, void __user *mtext,
+			size_t msgsz, long msgtyp, int msgflg);
+
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_MSG_H */
Index: linux-2.6.19-rc1/ipc/compat.c
===================================================================
--- linux-2.6.19-rc1.orig/ipc/compat.c	2006-09-19 20:42:06.000000000 -0700
+++ linux-2.6.19-rc1/ipc/compat.c	2006-11-14 11:27:21.000000000 -0800
@@ -115,7 +115,6 @@
 
 extern int sem_ctls[];
 #define sc_semopm	(sem_ctls[2])
-#define MAXBUF (64*1024)
 
 static inline int compat_ipc_parse_version(int *cmd)
 {
@@ -307,35 +306,30 @@
 
 long compat_sys_msgsnd(int first, int second, int third, void __user *uptr)
 {
-	struct msgbuf __user *p;
 	struct compat_msgbuf __user *up = uptr;
 	long type;
 
 	if (first < 0)
 		return -EINVAL;
-	if (second < 0 || (second >= MAXBUF - sizeof(struct msgbuf)))
+	if (second < 0)
 		return -EINVAL;
 
-	p = compat_alloc_user_space(second + sizeof(struct msgbuf));
-	if (get_user(type, &up->mtype) ||
-	    put_user(type, &p->mtype) ||
-	    copy_in_user(p->mtext, up->mtext, second))
+	if (get_user(type, &up->mtype)) 
 		return -EFAULT;
 
-	return sys_msgsnd(first, p, second, third);
+	return do_msgsnd(first, type, up->mtext, second, third);
 }
 
 long compat_sys_msgrcv(int first, int second, int msgtyp, int third,
 			   int version, void __user *uptr)
 {
-	struct msgbuf __user *p;
 	struct compat_msgbuf __user *up;
 	long type;
 	int err;
 
 	if (first < 0)
 		return -EINVAL;
-	if (second < 0 || (second >= MAXBUF - sizeof(struct msgbuf)))
+	if (second < 0)
 		return -EINVAL;
 
 	if (!version) {
@@ -349,14 +343,11 @@
 		uptr = compat_ptr(ipck.msgp);
 		msgtyp = ipck.msgtyp;
 	}
-	p = compat_alloc_user_space(second + sizeof(struct msgbuf));
-	err = sys_msgrcv(first, p, second, msgtyp, third);
+	up = uptr;
+	err = do_msgrcv(first, &type, up->mtext, second, msgtyp, third);
 	if (err < 0)
 		goto out;
-	up = uptr;
-	if (get_user(type, &p->mtype) ||
-	    put_user(type, &up->mtype) ||
-	    copy_in_user(up->mtext, p->mtext, err))
+	if (put_user(type, &up->mtype))
 		err = -EFAULT;
 out:
 	return err;
Index: linux-2.6.19-rc1/ipc/msg.c
===================================================================
--- linux-2.6.19-rc1.orig/ipc/msg.c	2006-10-10 05:54:32.000000000 -0700
+++ linux-2.6.19-rc1/ipc/msg.c	2006-11-14 13:05:00.000000000 -0800
@@ -625,12 +625,11 @@
 	return 0;
 }
 
-asmlinkage long
-sys_msgsnd(int msqid, struct msgbuf __user *msgp, size_t msgsz, int msgflg)
+long do_msgsnd(int msqid, long mtype, void __user *mtext,
+		size_t msgsz, int msgflg)
 {
 	struct msg_queue *msq;
 	struct msg_msg *msg;
-	long mtype;
 	int err;
 	struct ipc_namespace *ns;
 
@@ -638,12 +637,10 @@
 
 	if (msgsz > ns->msg_ctlmax || (long) msgsz < 0 || msqid < 0)
 		return -EINVAL;
-	if (get_user(mtype, &msgp->mtype))
-		return -EFAULT;
 	if (mtype < 1)
 		return -EINVAL;
 
-	msg = load_msg(msgp->mtext, msgsz);
+	msg = load_msg(mtext, msgsz);
 	if (IS_ERR(msg))
 		return PTR_ERR(msg);
 
@@ -722,6 +719,16 @@
 	return err;
 }
 
+asmlinkage long
+sys_msgsnd(int msqid, struct msgbuf __user *msgp, size_t msgsz, int msgflg)
+{
+	long mtype;
+
+	if (get_user(mtype, &msgp->mtype))
+		return -EFAULT;
+	return do_msgsnd(msqid, mtype, msgp->mtext, msgsz, msgflg);
+}
+
 static inline int convert_mode(long *msgtyp, int msgflg)
 {
 	/*
@@ -741,8 +748,8 @@
 	return SEARCH_EQUAL;
 }
 
-asmlinkage long sys_msgrcv(int msqid, struct msgbuf __user *msgp, size_t msgsz,
-			   long msgtyp, int msgflg)
+long do_msgrcv(int msqid, long *pmtype, void __user *mtext,
+		size_t msgsz, long msgtyp, int msgflg)
 {
 	struct msg_queue *msq;
 	struct msg_msg *msg;
@@ -888,15 +895,30 @@
 		return PTR_ERR(msg);
 
 	msgsz = (msgsz > msg->m_ts) ? msg->m_ts : msgsz;
-	if (put_user (msg->m_type, &msgp->mtype) ||
-	    store_msg(msgp->mtext, msg, msgsz)) {
+	*pmtype = msg->m_type;
+	if (store_msg(mtext, msg, msgsz)) 
 		msgsz = -EFAULT;
-	}
+
 	free_msg(msg);
 
 	return msgsz;
 }
 
+asmlinkage long sys_msgrcv(int msqid, struct msgbuf __user *msgp, size_t msgsz,
+			   long msgtyp, int msgflg)
+{
+	long err, mtype;
+
+	err =  do_msgrcv(msqid, &mtype, msgp->mtext, msgsz, msgtyp, msgflg);
+	if (err < 0)
+		goto out;
+
+	if (put_user(mtype, &msgp->mtype))
+		err = -EFAULT;
+out:
+	return err;
+}
+
 #ifdef CONFIG_PROC_FS
 static int sysvipc_msg_proc_show(struct seq_file *s, void *it)
 {

--------------030209050608060507030304--
