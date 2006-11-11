Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946867AbWKKB0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946867AbWKKB0G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 20:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946870AbWKKB0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 20:26:05 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:16561 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1946867AbWKKB0E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 20:26:04 -0500
Message-ID: <4555265F.2090006@linux.vnet.ibm.com>
Date: Fri, 10 Nov 2006 17:24:47 -0800
From: suzuki <suzuki@linux.vnet.ibm.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: [RFC] [PATCH] Fix compat space msg size limit for msgsnd/msgrcv (
 Was Re: Behaviour of compat_msgsnd/compat_msgrcv calls )
References: <453FB3F9.9080704@in.ibm.com> <20061025.134932.63125874.davem@davemloft.net> <45521580.5000606@in.ibm.com> <4552217A.5040401@in.ibm.com>
In-Reply-To: <4552217A.5040401@in.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------090509050404060808040100"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090509050404060808040100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

[Resending]

hi,

The compat_sys_{msgsnd,msgrcv} calls cannot handle a message of size > 
(64k - sizeof(struct msgbuf)). These calls would fail with -EINVAL for 
such invocations.

This is mainly due to the difference in the layout of the msgbuf 
structure in compat space and the native space. In compat_sys_msgrcv() 
we allocate space (at most 64k, and hence the limit) on the user stack 
using compat_alloc_user_space() and use this as the msgbuf for 
sys_msgrcv(). The results are later copied IN user space using 
copy_in_user(), which is an overhead.

The attached patch introduces (as per Dave's suggestion) helper routines 
   which accepts an additional pointer to the buf for the msgbuf. Thus 
this avoids the message size limit as well as the overhead of a 
copy_in_user().

Comments ?

Thanks

Suzuki
Linux Technology Centre
IBM Systems & Technology Labs.




Suzuki K P wrote:
> Corrected patch for some coding style errs..
> 
> Comments ?
> 
> Thanks
> 
> Suzuki
> 
> Suzuki K P wrote:
> 
>> Suzuki K P wrote:
>>
>>>
>>> -- Original Post ---
>>>
>>>> Hi,
>>>>
>>>> I have a question regarding the behaviour of the comapt_msgsnd/ 
>>>> compat_msgrcv ()s. Don't know if this has been discussed already or 
>>>> if as I could not find any threads in the archives. Please bear with 
>>>> me if this is really a stupid question.
>>>>
>>>>  The maximum length of the message that can be sent or received in 
>>>> any of those functions above is MAXBUF-(sizeof (struct msgbuf)), 
>>>> where MAXBUF is 64k.
>>>>
>>>> ipc/compat.c : compat_msgrcv()
>>>>         if (second < 0 || (second >= MAXBUF - sizeof(struct msgbuf)))
>>>>                           ^^^^^^
>>>>                 return -EINVAL;
>>>>
>>>> Is this limit due to the buffer allocation in user space as below ?
>>>>
>>>>  And the way we are doing this is by allocating a buffer of msgsize 
>>>> on the userspace stack using compat_alloc_user_space() instead of 
>>>> using the buffer provided by the user and later copying the result 
>>>> back to the user buffer.
>>>>
>>>>>
>>>>> Is there any specific reason behind this ? Can't we just use the 
>>>>> user buffer directly instead of doing an additional copy_in_user ?
>>>>> ie,
>>>>>     err = sys_msgrcv(first, uptr, second, msgtyp, third);
>>>>
>>>>
>>>>
>>>>
>>>>
>>> -- Dave suggested --
>>>
>>>> It's the cleanest way to deal with the difference in
>>>> "struct msgbuf" layout between native and compat userspace.
>>>>
>>>> I guess we could make some common do_sys_msgrcv() function
>>>> that passed in a pointer to the "msgbuf" and the buffer
>>>> seperately.
>>>
>>>
>>>
>>>
>>> Dave,
>>>
>>> I have attached a patch which does the same here. It introduces
>>> do_msgrcv()/ do_msgsnd() routines to service the sys_msgxxx variants.
>>> The do_msgxxx variants accepts an additional "mtext" parameter along
>>> with the sys_msgxxx paramters.
>>> i.e,
>>>
>>> asmlinkage long sys_msgrcv(int msqid, struct msgbuf __user *msgp,
>>>                 size_t msgsz, long msgtyp, int msgflg)
>>> {
>>>           return do_msgrcv(msqid, msgp, msgp->mtext, msgsz, msgtyp,
>>>                  msgflg);
>>> }
>>>
>>> Comments ?
>>>
>>> Thanks,
>>>
>>> -Suzuki
>>>
>>>
>>>
>>>
>>>
>>>
>>>
> 
> ------------------------------------------------------------------------

--------------090509050404060808040100
Content-Type: text/x-patch;
 name="fix-compat-msg-size.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-compat-msg-size.diff"


* 	Fix the size limit of compat space msgsize. 

Currently we allocate 64k space on the user stack and use it the msgbuf for sys_{msgrcv,msgsnd}
 for compat and the results are later copied in user [ by copy_in_user]. This patch introduces 
helper routines for sys_{msgrcv,msgsnd} which would accept the pointer to msgbuf along with the 
msgp->mtext. This avoids the need to allocate the msgsize on the userspace ( thus removing the 
size limt ) and the overhead of an extra copy_in_user().

Signed-off-by: Suzuki K P <suzuki@in.ibm.com>

Index: linux-2.6.19-rc2/include/linux/msg.h
===================================================================
--- linux-2.6.19-rc2.orig/include/linux/msg.h	2006-09-20 09:12:06.000000000 +0530
+++ linux-2.6.19-rc2/include/linux/msg.h	2006-11-08 23:45:57.000000000 +0530
@@ -92,6 +92,12 @@
 	struct list_head q_senders;
 };
 
+/* Helper routines for sys_msgsnd and sys_msgrcv */
+extern long do_msgsnd(int msqid, struct msgbuf __user *msgp, void __user *mtext,
+			size_t msgsz, int msgflg);
+extern long do_msgrcv(int msqid, struct msgbuf __user *msgp, void __user *mtext,
+			size_t msgsz, long msgtyp, int msgflg);
+
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_MSG_H */
Index: linux-2.6.19-rc2/ipc/compat.c
===================================================================
--- linux-2.6.19-rc2.orig/ipc/compat.c	2006-09-20 09:12:06.000000000 +0530
+++ linux-2.6.19-rc2/ipc/compat.c	2006-11-08 23:43:51.000000000 +0530
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
Index: linux-2.6.19-rc2/ipc/msg.c
===================================================================
--- linux-2.6.19-rc2.orig/ipc/msg.c	2006-10-17 10:50:56.000000000 +0530
+++ linux-2.6.19-rc2/ipc/msg.c	2006-11-08 23:43:51.000000000 +0530
@@ -625,8 +625,8 @@
 	return 0;
 }
 
-asmlinkage long
-sys_msgsnd(int msqid, struct msgbuf __user *msgp, size_t msgsz, int msgflg)
+long do_msgsnd(int msqid, struct msgbuf __user *msgp, void __user *mtext,
+		size_t msgsz, int msgflg)
 {
 	struct msg_queue *msq;
 	struct msg_msg *msg;
@@ -643,7 +643,7 @@
 	if (mtype < 1)
 		return -EINVAL;
 
-	msg = load_msg(msgp->mtext, msgsz);
+	msg = load_msg(mtext, msgsz);
 	if (IS_ERR(msg))
 		return PTR_ERR(msg);
 
@@ -722,6 +722,12 @@
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
@@ -741,8 +747,8 @@
 	return SEARCH_EQUAL;
 }
 
-asmlinkage long sys_msgrcv(int msqid, struct msgbuf __user *msgp, size_t msgsz,
-			   long msgtyp, int msgflg)
+long do_msgrcv(int msqid, struct msgbuf __user *msgp, void __user *mtext,
+		size_t msgsz, long msgtyp, int msgflg)
 {
 	struct msg_queue *msq;
 	struct msg_msg *msg;
@@ -889,7 +895,7 @@
 
 	msgsz = (msgsz > msg->m_ts) ? msg->m_ts : msgsz;
 	if (put_user (msg->m_type, &msgp->mtype) ||
-	    store_msg(msgp->mtext, msg, msgsz)) {
+	    store_msg(mtext, msg, msgsz)) {
 		msgsz = -EFAULT;
 	}
 	free_msg(msg);
@@ -897,6 +903,12 @@
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

--------------090509050404060808040100--
