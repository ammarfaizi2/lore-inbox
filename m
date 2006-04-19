Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750921AbWDSQXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbWDSQXq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 12:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbWDSQXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 12:23:45 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:30156 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750878AbWDSQXp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 12:23:45 -0400
Subject: Re: [RFC][PATCH 4/5] utsname namespaces: sysctl hack
From: Dave Hansen <haveblue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Kirill Korotaev <dev@sw.ru>,
       linux-kernel@vger.kernel.org, herbert@13thfloor.at, devel@openvz.org,
       sam@vilain.net, xemul@sw.ru, James Morris <jmorris@namei.org>
In-Reply-To: <m1bquxmuk5.fsf@ebiederm.dsl.xmission.com>
References: <20060407095132.455784000@sergelap>
	 <20060407183600.E40C119B902@sergelap.hallyn.com> <4446547B.4080206@sw.ru>
	 <20060419152129.GA14756@sergelap.austin.ibm.com>
	 <m1bquxmuk5.fsf@ebiederm.dsl.xmission.com>
Content-Type: multipart/mixed; boundary="=-7YXo9Pp2aTo0LpcpTGeL"
Date: Wed, 19 Apr 2006 09:23:34 -0700
Message-Id: <1145463814.31812.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7YXo9Pp2aTo0LpcpTGeL
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Besides ipc and utsnames, can anybody think of some other things in
sysctl that we really need to virtualize?

It seems to me that most of the other stuff is kernel-global and we
simply won't allow anything in a container to touch it.

That said, there may be things in the future that need to get added as
we separate out different subsystems.  Things like min_free_kbytes could
have a container-centric meaning (although I think that is probably a
really bad one to mess with).

I have a slightly revamped way of doing the sysv namespace sysctl code.
I've attached a couple of (still pretty raw) patches.  Do these still
fall in the "hacks" category?

-- Dave

--=-7YXo9Pp2aTo0LpcpTGeL
Content-Disposition: attachment; filename=sysv-do-sysctl-strategies2.patch
Content-Type: text/x-patch; name=sysv-do-sysctl-strategies2.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit



---

 work-dave/ipc/sysctl.c    |    2 --
 work-dave/kernel/sysctl.c |    7 -------
 2 files changed, 9 deletions(-)

diff -puN kernel/sysctl.c~sysv-do-sysctl-strategies2 kernel/sysctl.c
--- work/kernel/sysctl.c~sysv-do-sysctl-strategies2	2006-04-19 09:13:52.000000000 -0700
+++ work-dave/kernel/sysctl.c	2006-04-19 09:13:52.000000000 -0700
@@ -439,7 +439,6 @@ static ctl_table kern_table[] = {
 	{
 		.ctl_name	= KERN_SHMMAX,
 		.procname	= "shmmax",
-		.data		= &shm_ctlmax,
 		.maxlen		= sizeof (size_t),
 		.mode		= 0644,
 		.proc_handler	= &proc_doulongvec_minmax,
@@ -448,7 +447,6 @@ static ctl_table kern_table[] = {
 	{
 		.ctl_name	= KERN_SHMALL,
 		.procname	= "shmall",
-		.data		= &shm_ctlall,
 		.maxlen		= sizeof (size_t),
 		.mode		= 0644,
 		.proc_handler	= &proc_doulongvec_minmax,
@@ -457,7 +455,6 @@ static ctl_table kern_table[] = {
 	{
 		.ctl_name	= KERN_SHMMNI,
 		.procname	= "shmmni",
-		.data		= &shm_ctlmni,
 		.maxlen		= sizeof (int),
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
@@ -466,7 +463,6 @@ static ctl_table kern_table[] = {
 	{
 		.ctl_name	= KERN_MSGMAX,
 		.procname	= "msgmax",
-		.data		= &msg_ctlmax,
 		.maxlen		= sizeof (int),
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
@@ -475,7 +471,6 @@ static ctl_table kern_table[] = {
 	{
 		.ctl_name	= KERN_MSGMNI,
 		.procname	= "msgmni",
-		.data		= &msg_ctlmni,
 		.maxlen		= sizeof (int),
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
@@ -484,7 +479,6 @@ static ctl_table kern_table[] = {
 	{
 		.ctl_name	= KERN_MSGMNB,
 		.procname	=  "msgmnb",
-		.data		= &msg_ctlmnb,
 		.maxlen		= sizeof (int),
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
@@ -493,7 +487,6 @@ static ctl_table kern_table[] = {
 	{
 		.ctl_name	= KERN_SEM,
 		.procname	= "sem",
-		.data		= &sem_ctls,
 		.maxlen		= 4*sizeof (int),
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
diff -L pushpa -puN /dev/null /dev/null
diff -L strategies-fix0 -puN /dev/null /dev/null
diff -puN ipc/sysctl.c~sysv-do-sysctl-strategies2 ipc/sysctl.c
--- work/ipc/sysctl.c~sysv-do-sysctl-strategies2	2006-04-19 09:14:03.000000000 -0700
+++ work-dave/ipc/sysctl.c	2006-04-19 09:14:13.000000000 -0700
@@ -39,8 +39,6 @@ int sysctl_ipc_strategy (ctl_table *tabl
 		default:
 			WARN_ON(1);
 	}
-	/* an excellent check to make sure everything is going as expected */
-	WARN_ON(data != table->data);
 	return default_sysctl_strategy(table, data, oldval, oldlenp,
 				       newval, newlen);
 }
_

--=-7YXo9Pp2aTo0LpcpTGeL
Content-Disposition: attachment; filename=sysv-do-sysctl-strategies1.patch
Content-Type: text/x-patch; name=sysv-do-sysctl-strategies1.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit


DESC
strategies-fix0
EDESC

---

 work-dave/include/linux/ipc.h |    5 ++++
 work-dave/ipc/Makefile        |    2 -
 work-dave/ipc/sysctl.c        |   48 ++++++++++++++++++++++++++++++++++++++++++
 work-dave/ipc/util.c          |    1 
 work-dave/kernel/sysctl.c     |    8 +++++++
 5 files changed, 63 insertions(+), 1 deletion(-)

diff -puN kernel/sysctl.c~sysv-do-sysctl-strategies1 kernel/sysctl.c
--- work/kernel/sysctl.c~sysv-do-sysctl-strategies1	2006-04-18 17:16:10.000000000 -0700
+++ work-dave/kernel/sysctl.c	2006-04-18 17:16:10.000000000 -0700
@@ -47,6 +47,7 @@
 #include <linux/syscalls.h>
 #include <linux/nfs_fs.h>
 #include <linux/acpi.h>
+#include <linux/ipc.h>
 
 #include <asm/uaccess.h>
 #include <asm/processor.h>
@@ -442,6 +443,7 @@ static ctl_table kern_table[] = {
 		.maxlen		= sizeof (size_t),
 		.mode		= 0644,
 		.proc_handler	= &proc_doulongvec_minmax,
+		.strategy	= &sysctl_ipc_strategy,
 	},
 	{
 		.ctl_name	= KERN_SHMALL,
@@ -450,6 +452,7 @@ static ctl_table kern_table[] = {
 		.maxlen		= sizeof (size_t),
 		.mode		= 0644,
 		.proc_handler	= &proc_doulongvec_minmax,
+		.strategy	= &sysctl_ipc_strategy,
 	},
 	{
 		.ctl_name	= KERN_SHMMNI,
@@ -458,6 +461,7 @@ static ctl_table kern_table[] = {
 		.maxlen		= sizeof (int),
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
+		.strategy	= &sysctl_ipc_strategy,
 	},
 	{
 		.ctl_name	= KERN_MSGMAX,
@@ -466,6 +470,7 @@ static ctl_table kern_table[] = {
 		.maxlen		= sizeof (int),
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
+		.strategy	= &sysctl_ipc_strategy,
 	},
 	{
 		.ctl_name	= KERN_MSGMNI,
@@ -474,6 +479,7 @@ static ctl_table kern_table[] = {
 		.maxlen		= sizeof (int),
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
+		.strategy	= &sysctl_ipc_strategy,
 	},
 	{
 		.ctl_name	= KERN_MSGMNB,
@@ -482,6 +488,7 @@ static ctl_table kern_table[] = {
 		.maxlen		= sizeof (int),
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
+		.strategy	= &sysctl_ipc_strategy,
 	},
 	{
 		.ctl_name	= KERN_SEM,
@@ -490,6 +497,7 @@ static ctl_table kern_table[] = {
 		.maxlen		= 4*sizeof (int),
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
+		.strategy	= &sysctl_ipc_strategy,
 	},
 #endif
 #ifdef CONFIG_MAGIC_SYSRQ
diff -puN include/linux/ipc.h~sysv-do-sysctl-strategies1 include/linux/ipc.h
--- work/include/linux/ipc.h~sysv-do-sysctl-strategies1	2006-04-18 17:16:10.000000000 -0700
+++ work-dave/include/linux/ipc.h	2006-04-18 17:18:03.000000000 -0700
@@ -2,6 +2,7 @@
 #define _LINUX_IPC_H
 
 #include <linux/types.h>
+#include <linux/sysctl.h>
 
 #define IPC_PRIVATE ((__kernel_key_t) 0)  
 
@@ -53,6 +54,10 @@ struct ipc_perm
 
 #define IPCMNI 32768  /* <= MAX_INT limit for ipc arrays (including sysctl changes) */
 
+int sysctl_ipc_strategy (/*ctl_table *table,*/ int __user *name, int nlen,
+			 void __user *oldval, size_t __user *oldlenp,
+			 void __user *newval, size_t newlen, void **context);
+
 /* used by in-kernel data structures */
 struct kern_ipc_perm
 {
diff -puN ipc/util.c~sysv-do-sysctl-strategies1 ipc/util.c
--- work/ipc/util.c~sysv-do-sysctl-strategies1	2006-04-18 17:16:10.000000000 -0700
+++ work-dave/ipc/util.c	2006-04-19 09:01:53.000000000 -0700
@@ -27,6 +27,7 @@
 #include <linux/workqueue.h>
 #include <linux/seq_file.h>
 #include <linux/proc_fs.h>
+#include <linux/sysctl.h>
 
 #include <asm/unistd.h>
 
diff -puN /dev/null ipc/sysctl.c
--- /dev/null	2005-03-30 22:36:15.000000000 -0800
+++ work-dave/ipc/sysctl.c	2006-04-19 09:04:23.000000000 -0700
@@ -0,0 +1,48 @@
+#include <linux/sysctl.h>
+#include <asm/bug.h>
+
+extern size_t shm_ctlmax;
+extern size_t shm_ctlall;
+extern int shm_ctlmni;
+extern int msg_ctlmax;
+extern int msg_ctlmnb;
+extern int msg_ctlmni;
+extern int sem_ctls[];
+
+int sysctl_ipc_strategy (ctl_table *table, int __user *name, int nlen,
+                         void __user *oldval, size_t __user *oldlenp,
+                         void __user *newval, size_t newlen, void **context)
+{
+	void *data = NULL;
+	switch (table->ctl_name) {
+		case KERN_SHMMAX:
+			data = &shm_ctlmax;
+			break;
+		case KERN_SHMALL:
+			data = &shm_ctlall;
+			break;
+		case KERN_SHMMNI:
+			data = &shm_ctlmni;
+			break;
+		case KERN_MSGMAX:
+			data = &msg_ctlmax;
+			break;
+		case KERN_MSGMNI:
+			data = &msg_ctlmni;
+			break;
+		case KERN_MSGMNB:
+			data = &msg_ctlmnb;
+			break;
+		case KERN_SEM:
+			data = &sem_ctls;
+			break;
+		default:
+			WARN_ON(1);
+	}
+	/* an excellent check to make sure everything is going as expected */
+	WARN_ON(data != table->data);
+	return default_sysctl_strategy(table, data, oldval, oldlenp,
+				       newval, newlen);
+}
+
+
diff -puN ipc/Makefile~sysv-do-sysctl-strategies1 ipc/Makefile
--- work/ipc/Makefile~sysv-do-sysctl-strategies1	2006-04-19 09:02:50.000000000 -0700
+++ work-dave/ipc/Makefile	2006-04-19 09:02:58.000000000 -0700
@@ -3,7 +3,7 @@
 #
 
 obj-$(CONFIG_SYSVIPC_COMPAT) += compat.o
-obj-$(CONFIG_SYSVIPC) += util.o msgutil.o msg.o sem.o shm.o
+obj-$(CONFIG_SYSVIPC) += util.o msgutil.o msg.o sem.o shm.o sysctl.c
 obj_mq-$(CONFIG_COMPAT) += compat_mq.o
 obj-$(CONFIG_POSIX_MQUEUE) += mqueue.o msgutil.o $(obj_mq-y)
 
_

--=-7YXo9Pp2aTo0LpcpTGeL
Content-Disposition: attachment; filename=sysv-do-sysctl-strategies0.patch
Content-Type: text/x-patch; name=sysv-do-sysctl-strategies0.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit



---

 work-dave/include/linux/sysctl.h |    4 ++
 work-dave/kernel/sysctl.c        |   55 +++++++++++++++++++++------------------
 2 files changed, 35 insertions(+), 24 deletions(-)

diff -puN ipc/compat.c~sysv-do-sysctl-strategies0 ipc/compat.c
diff -puN ipc/compat_mq.c~sysv-do-sysctl-strategies0 ipc/compat_mq.c
diff -puN ipc/mqueue.c~sysv-do-sysctl-strategies0 ipc/mqueue.c
diff -puN ipc/msg.c~sysv-do-sysctl-strategies0 ipc/msg.c
diff -puN ipc/msgutil.c~sysv-do-sysctl-strategies0 ipc/msgutil.c
diff -puN ipc/sem.c~sysv-do-sysctl-strategies0 ipc/sem.c
diff -puN ipc/shm.c~sysv-do-sysctl-strategies0 ipc/shm.c
diff -puN ipc/util.c~sysv-do-sysctl-strategies0 ipc/util.c
diff -puN kernel/sysctl.c~sysv-do-sysctl-strategies0 kernel/sysctl.c
--- work/kernel/sysctl.c~sysv-do-sysctl-strategies0	2006-04-18 17:06:49.000000000 -0700
+++ work-dave/kernel/sysctl.c	2006-04-18 17:13:06.000000000 -0700
@@ -1251,6 +1251,35 @@ repeat:
 	return -ENOTDIR;
 }
 
+int default_sysctl_strategy(ctl_table *table, void *data,
+			       void __user *oldval, size_t __user *oldlenp,
+			       void __user *newval, size_t newlen)
+{
+	size_t len;
+	if (data && table->maxlen) {
+		if (oldval && oldlenp) {
+			if (get_user(len, oldlenp))
+				return -EFAULT;
+			if (len) {
+				if (len > table->maxlen)
+					len = table->maxlen;
+				if(copy_to_user(oldval, data, len))
+					return -EFAULT;
+				if(put_user(len, oldlenp))
+					return -EFAULT;
+			}
+		}
+		if (newval && newlen) {
+			len = newlen;
+			if (len > table->maxlen)
+				len = table->maxlen;
+			if(copy_from_user(data, newval, len))
+				return -EFAULT;
+		}
+	}
+	return 0;
+}
+
 /* Perform the actual read/write of a sysctl table entry. */
 int do_sysctl_strategy (ctl_table *table, 
 			int __user *name, int nlen,
@@ -1258,7 +1287,6 @@ int do_sysctl_strategy (ctl_table *table
 			void __user *newval, size_t newlen, void **context)
 {
 	int op = 0, rc;
-	size_t len;
 
 	if (oldval)
 		op |= 004;
@@ -1275,31 +1303,10 @@ int do_sysctl_strategy (ctl_table *table
 		if (rc > 0)
 			return 0;
 	}
-
 	/* If there is no strategy routine, or if the strategy returns
 	 * zero, proceed with automatic r/w */
-	if (table->data && table->maxlen) {
-		if (oldval && oldlenp) {
-			if (get_user(len, oldlenp))
-				return -EFAULT;
-			if (len) {
-				if (len > table->maxlen)
-					len = table->maxlen;
-				if(copy_to_user(oldval, table->data, len))
-					return -EFAULT;
-				if(put_user(len, oldlenp))
-					return -EFAULT;
-			}
-		}
-		if (newval && newlen) {
-			len = newlen;
-			if (len > table->maxlen)
-				len = table->maxlen;
-			if(copy_from_user(table->data, newval, len))
-				return -EFAULT;
-		}
-	}
-	return 0;
+	return default_sysctl_strategy(table, table->data, oldval,oldlenp,
+				       newval, newlen);
 }
 
 /**
diff -puN drivers/char/random.c~sysv-do-sysctl-strategies0 drivers/char/random.c
diff -puN include/linux/sysctl.h~sysv-do-sysctl-strategies0 include/linux/sysctl.h
--- work/include/linux/sysctl.h~sysv-do-sysctl-strategies0	2006-04-18 17:13:37.000000000 -0700
+++ work-dave/include/linux/sysctl.h	2006-04-18 17:14:40.000000000 -0700
@@ -945,6 +945,10 @@ extern int do_sysctl_strategy (ctl_table
 			       void __user *oldval, size_t __user *oldlenp,
 			       void __user *newval, size_t newlen, void ** context);
 
+extern int default_sysctl_strategy(ctl_table *table, void *data,
+				   void __user *oldval, size_t __user *oldlenp,
+				   void __user *newval, size_t newlen);
+
 extern ctl_handler sysctl_string;
 extern ctl_handler sysctl_intvec;
 extern ctl_handler sysctl_jiffies;
_

--=-7YXo9Pp2aTo0LpcpTGeL--

