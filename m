Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752048AbWCFXxB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048AbWCFXxB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 18:53:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752468AbWCFXxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 18:53:01 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:2445 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1752048AbWCFXxA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 18:53:00 -0500
Subject: [RFC][PATCH 3/6] sysvmsg: containerize sysctls
To: linux-kernel@vger.kernel.org
Cc: serue@us.ibm.com, frankeh@watson.ibm.com, clg@fr.ibm.com,
       Herbert Poetzl <herbert@13thfloor.at>, Sam Vilain <sam@vilain.net>,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Mon, 06 Mar 2006 15:52:50 -0800
References: <20060306235248.20842700@localhost.localdomain>
In-Reply-To: <20060306235248.20842700@localhost.localdomain>
Message-Id: <20060306235250.22981BC9@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use the new sysctl data accessor function pointers to put
the sysvmsg sysctl variables inside of the context structure.

Note that this will effectively remove the system-wide limits
on sysv msg resources that the sysctl mechanism currently
provides and move it to a per-container limit.  This is
currently by design, and may be later addressed when we have
proper large-scale resource controls in the kernel.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 work-dave/ipc/msg.c       |   38 +++++++++++++++++++++++++-------------
 work-dave/ipc/util.h      |    4 ++++
 work-dave/kernel/sysctl.c |   12 ++++++------
 3 files changed, 35 insertions(+), 19 deletions(-)

diff -puN ipc/msg.c~sysvmsg-containerize-sysctls ipc/msg.c
--- work/ipc/msg.c~sysvmsg-containerize-sysctls	2006-03-06 15:41:57.000000000 -0800
+++ work-dave/ipc/msg.c	2006-03-06 15:41:57.000000000 -0800
@@ -32,11 +32,6 @@
 #include <asm/uaccess.h>
 #include "util.h"
 
-/* sysctl: */
-int msg_ctlmax = MSGMAX;
-int msg_ctlmnb = MSGMNB;
-int msg_ctlmni = MSGMNI;
-
 /* one msg_receiver structure for each sleeping receiver */
 struct msg_receiver {
 	struct list_head r_list;
@@ -76,7 +71,11 @@ static int sysvipc_msg_proc_show(struct 
 
 void __init msg_init (struct ipc_msg_context *context)
 {
-	ipc_init_ids(&context->ids,msg_ctlmni);
+	context->ctlmax = MSGMAX;
+	context->ctlmnb = MSGMNB;
+	context->ctlmni = MSGMNI;
+
+	ipc_init_ids(&context->ids,context->ctlmni);
 	ipc_init_proc_interface("sysvipc/msg",
 				"       key      msqid perms      cbytes       qnum lspid lrpid   uid   gid  cuid  cgid      stime      rtime      ctime\n",
 				&context->ids,
@@ -103,7 +102,7 @@ static int newque (struct ipc_msg_contex
 		return retval;
 	}
 
-	id = ipc_addid(&context->ids, &msq->q_perm, msg_ctlmni);
+	id = ipc_addid(&context->ids, &msq->q_perm, context->ctlmni);
 	if(id == -1) {
 		security_msg_queue_free(msq);
 		ipc_rcu_putref(msq);
@@ -114,7 +113,7 @@ static int newque (struct ipc_msg_contex
 	msq->q_stime = msq->q_rtime = 0;
 	msq->q_ctime = get_seconds();
 	msq->q_cbytes = msq->q_qnum = 0;
-	msq->q_qbytes = msg_ctlmnb;
+	msq->q_qbytes = context->ctlmnb;
 	msq->q_lspid = msq->q_lrpid = 0;
 	INIT_LIST_HEAD(&msq->q_messages);
 	INIT_LIST_HEAD(&msq->q_receivers);
@@ -356,9 +355,9 @@ asmlinkage long sys_msgctl (int msqid, i
 			return err;
 
 		memset(&msginfo,0,sizeof(msginfo));	
-		msginfo.msgmni = msg_ctlmni;
-		msginfo.msgmax = msg_ctlmax;
-		msginfo.msgmnb = msg_ctlmnb;
+		msginfo.msgmni = context->ctlmni;
+		msginfo.msgmax = context->ctlmax;
+		msginfo.msgmnb = context->ctlmnb;
 		msginfo.msgssz = MSGSSZ;
 		msginfo.msgseg = MSGSEG;
 		down(&context->ids.sem);
@@ -462,7 +461,7 @@ asmlinkage long sys_msgctl (int msqid, i
 	case IPC_SET:
 	{
 		err = -EPERM;
-		if (setbuf.qbytes > msg_ctlmnb && !capable(CAP_SYS_RESOURCE))
+		if (setbuf.qbytes > context->ctlmnb && !capable(CAP_SYS_RESOURCE))
 			goto out_unlock_up;
 
 		msq->q_qbytes = setbuf.qbytes;
@@ -560,7 +559,7 @@ asmlinkage long sys_msgsnd (int msqid, s
 	int err;
 	struct ipc_msg_context *context = &current->ipc_context->msg;
 
-	if (msgsz > msg_ctlmax || (long) msgsz < 0 || msqid < 0)
+	if (msgsz > context->ctlmax || (long) msgsz < 0 || msqid < 0)
 		return -EINVAL;
 	if (get_user(mtype, &msgp->mtype))
 		return -EFAULT; 
@@ -835,3 +834,16 @@ static int sysvipc_msg_proc_show(struct 
 			  msq->q_ctime);
 }
 #endif
+
+void *msg_ctlmnb_helper(void)
+{
+	return &current->ipc_context->msg.ctlmnb;
+}
+void *msg_ctlmni_helper(void)
+{
+	return &current->ipc_context->msg.ctlmni;
+}
+void *msg_ctlmax_helper(void)
+{
+	return &current->ipc_context->msg.ctlmax;
+}
diff -puN ipc/util.h~sysvmsg-containerize-sysctls ipc/util.h
--- work/ipc/util.h~sysvmsg-containerize-sysctls	2006-03-06 15:41:57.000000000 -0800
+++ work-dave/ipc/util.h	2006-03-06 15:41:57.000000000 -0800
@@ -34,6 +34,10 @@ struct ipc_msg_context {
 	atomic_t bytes;
 	atomic_t hdrs;
 
+	int ctlmax;
+	int ctlmnb;
+	int ctlmni;
+
 	struct ipc_ids ids;
 	struct kref count;
 };
diff -puN kernel/sysctl.c~sysvmsg-containerize-sysctls kernel/sysctl.c
--- work/kernel/sysctl.c~sysvmsg-containerize-sysctls	2006-03-06 15:41:57.000000000 -0800
+++ work-dave/kernel/sysctl.c	2006-03-06 15:41:57.000000000 -0800
@@ -94,10 +94,10 @@ extern int sg_big_buff;
 #ifdef CONFIG_SYSVIPC
 extern size_t shm_ctlmax;
 extern size_t shm_ctlall;
+extern void *msg_ctlmnb_helper(void);
+extern void *msg_ctlmni_helper(void);
+extern void *msg_ctlmax_helper(void);
 extern int shm_ctlmni;
-extern int msg_ctlmax;
-extern int msg_ctlmnb;
-extern int msg_ctlmni;
 extern int sem_ctls[];
 #endif
 
@@ -452,7 +452,7 @@ static ctl_table kern_table[] = {
 	{
 		.ctl_name	= KERN_MSGMAX,
 		.procname	= "msgmax",
-		.data		= &msg_ctlmax,
+		.data_access	= &msg_ctlmax_helper,
 		.maxlen		= sizeof (int),
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
@@ -460,7 +460,7 @@ static ctl_table kern_table[] = {
 	{
 		.ctl_name	= KERN_MSGMNI,
 		.procname	= "msgmni",
-		.data		= &msg_ctlmni,
+		.data_access	= &msg_ctlmni_helper,
 		.maxlen		= sizeof (int),
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
@@ -468,7 +468,7 @@ static ctl_table kern_table[] = {
 	{
 		.ctl_name	= KERN_MSGMNB,
 		.procname	=  "msgmnb",
-		.data		= &msg_ctlmnb,
+		.data_access	= &msg_ctlmnb_helper,
 		.maxlen		= sizeof (int),
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
_
