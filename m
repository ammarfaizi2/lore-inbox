Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752052AbWCFXyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052AbWCFXyM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 18:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932490AbWCFXyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 18:54:12 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:62607 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1752468AbWCFXxC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 18:53:02 -0500
Subject: [RFC][PATCH 6/6] sysvshm: containerize sysctls
To: linux-kernel@vger.kernel.org
Cc: serue@us.ibm.com, frankeh@watson.ibm.com, clg@fr.ibm.com,
       Herbert Poetzl <herbert@13thfloor.at>, Sam Vilain <sam@vilain.net>,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Mon, 06 Mar 2006 15:52:53 -0800
References: <20060306235248.20842700@localhost.localdomain>
In-Reply-To: <20060306235248.20842700@localhost.localdomain>
Message-Id: <20060306235253.C758293E@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Note that this will effectively remove the system-wide limits
on sysv shm resources that the sysctl mechanism currently
provides and move it to a per-container limit.  This is
currently by design, and may be later addressed when we have
proper large-scale resource controls in the kernel.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 desc.txt                  |    0 
 work-dave/ipc/shm.c       |   33 +++++++++++++++++++++++----------
 work-dave/ipc/util.h      |    4 ++++
 work-dave/kernel/sysctl.c |   12 ++++++------
 4 files changed, 33 insertions(+), 16 deletions(-)

diff -puN ipc/shm.c~sysvshm-containerize-sysctls ipc/shm.c
--- work/ipc/shm.c~sysvshm-containerize-sysctls	2006-03-06 15:42:00.000000000 -0800
+++ work-dave/ipc/shm.c	2006-03-06 15:42:00.000000000 -0800
@@ -55,12 +55,12 @@ static void shm_close (struct vm_area_st
 static int sysvipc_shm_proc_show(struct seq_file *s, void *it);
 #endif
 
-size_t	shm_ctlmax = SHMMAX;
-size_t 	shm_ctlall = SHMALL;
-int 	shm_ctlmni = SHMMNI;
-
 void __init shm_init (struct ipc_shm_context *context)
 {
+	context->ctlmax = SHMMAX;
+	context->ctlall = SHMALL;
+	context->ctlmni = SHMMNI;
+
 	ipc_init_ids(&context->ids, 1);
 	ipc_init_proc_interface("sysvipc/shm",
 				"       key      shmid perms       size  cpid  lpid nattch   uid   gid  cuid  cgid      atime      dtime      ctime\n",
@@ -85,7 +85,7 @@ struct shmid_kernel *shm_rmid(struct ipc
 static inline
 int shm_addid(struct ipc_shm_context *context, struct shmid_kernel *shp)
 {
-	return ipc_addid(&context->ids, &shp->shm_perm, shm_ctlmni);
+	return ipc_addid(&context->ids, &shp->shm_perm, context->ctlmni);
 }
 
 
@@ -208,10 +208,10 @@ static int newseg (struct ipc_shm_contex
 	char name[13];
 	int id;
 
-	if (size < SHMMIN || size > shm_ctlmax)
+	if (size < SHMMIN || size > context->ctlmax)
 		return -EINVAL;
 
-	if (context->tot + numpages >= shm_ctlall)
+	if (context->tot + numpages >= context->ctlall)
 		return -ENOSPC;
 
 	shp = ipc_rcu_alloc(sizeof(*shp));
@@ -463,9 +463,9 @@ asmlinkage long sys_shmctl (int shmid, i
 			return err;
 
 		memset(&shminfo,0,sizeof(shminfo));
-		shminfo.shmmni = shminfo.shmseg = shm_ctlmni;
-		shminfo.shmmax = shm_ctlmax;
-		shminfo.shmall = shm_ctlall;
+		shminfo.shmmni = shminfo.shmseg = context->ctlmni;
+		shminfo.shmmax = context->ctlmax;
+		shminfo.shmall = context->ctlall;
 
 		shminfo.shmmin = SHMMIN;
 		if(copy_shminfo_to_user (buf, &shminfo, version))
@@ -935,3 +935,16 @@ static int sysvipc_shm_proc_show(struct 
 			  shp->shm_ctim);
 }
 #endif
+
+void *shm_ctlmax_helper(void)
+{
+	return &current->ipc_context->shm.ctlmax;
+}
+void *shm_ctlall_helper(void)
+{
+	return &current->ipc_context->shm.ctlall;
+}
+void *shm_ctlmni_helper(void)
+{
+	return &current->ipc_context->shm.ctlmni;
+}
diff -puN ipc/util.h~sysvshm-containerize-sysctls ipc/util.h
--- work/ipc/util.h~sysvshm-containerize-sysctls	2006-03-06 15:42:00.000000000 -0800
+++ work-dave/ipc/util.h	2006-03-06 15:42:00.000000000 -0800
@@ -47,6 +47,10 @@ struct ipc_sem_context {
 struct ipc_shm_context {
 	struct ipc_ids ids;
 
+	size_t ctlmax;
+	size_t ctlall;
+	int    ctlmni;
+
 	int tot; /* total number of shared memory pages */
 };
 
diff -puN kernel/sysctl.c~sysvshm-containerize-sysctls kernel/sysctl.c
--- work/kernel/sysctl.c~sysvshm-containerize-sysctls	2006-03-06 15:42:00.000000000 -0800
+++ work-dave/kernel/sysctl.c	2006-03-06 15:42:00.000000000 -0800
@@ -92,12 +92,12 @@ extern char modprobe_path[];
 extern int sg_big_buff;
 #endif
 #ifdef CONFIG_SYSVIPC
-extern size_t shm_ctlmax;
-extern size_t shm_ctlall;
+extern void *shm_ctlmax_helper(void);
+extern void *shm_ctlall_helper(void);
+extern void *shm_ctlmni_helper(void);
 extern void *msg_ctlmnb_helper(void);
 extern void *msg_ctlmni_helper(void);
 extern void *msg_ctlmax_helper(void);
-extern int shm_ctlmni;
 extern int sem_ctls[];
 #endif
 
@@ -428,7 +428,7 @@ static ctl_table kern_table[] = {
 	{
 		.ctl_name	= KERN_SHMMAX,
 		.procname	= "shmmax",
-		.data		= &shm_ctlmax,
+		.data_access	= &shm_ctlmax_helper,
 		.maxlen		= sizeof (size_t),
 		.mode		= 0644,
 		.proc_handler	= &proc_doulongvec_minmax,
@@ -436,7 +436,7 @@ static ctl_table kern_table[] = {
 	{
 		.ctl_name	= KERN_SHMALL,
 		.procname	= "shmall",
-		.data		= &shm_ctlall,
+		.data_access	= &shm_ctlall_helper,
 		.maxlen		= sizeof (size_t),
 		.mode		= 0644,
 		.proc_handler	= &proc_doulongvec_minmax,
@@ -444,7 +444,7 @@ static ctl_table kern_table[] = {
 	{
 		.ctl_name	= KERN_SHMMNI,
 		.procname	= "shmmni",
-		.data		= &shm_ctlmni,
+		.data_access	= &shm_ctlmni_helper,
 		.maxlen		= sizeof (int),
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
diff -puN desc.txt~sysvshm-containerize-sysctls desc.txt
_
