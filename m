Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261621AbVB1Nys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbVB1Nys (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 08:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbVB1Nya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 08:54:30 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:19428 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261596AbVB1NvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 08:51:09 -0500
Subject: [PATCH] Audit permission changes on IPC objects.
From: David Woodhouse <dwmw2@infradead.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-audit@redhat.com
Content-Type: text/plain
Date: Mon, 28 Feb 2005 13:50:43 +0000
Message-Id: <1109598643.22578.5.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 8bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Capture the requested permissions on IPC_SET calls. We do this with a
hook in ipc/{sem,shm,msg}.c for two reasons. Firstly, it would require a
lot of arch-specific knowledge about syscall numbers and sys_ipc()
multiplexing to get at this information from syscall_trace_enter().
Secondly, if we did it there it could be changed by the time the IPC
code does copy_from_user() to fetch it again.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

===== include/linux/audit.h 1.2 vs edited =====
--- 1.2/include/linux/audit.h	2005-01-31 06:33:47 +00:00
+++ edited/include/linux/audit.h	2005-02-28 13:39:05 +00:00
@@ -150,6 +150,7 @@
 			    struct timespec *t, int *serial);
 extern int  audit_set_loginuid(struct audit_context *ctx, uid_t loginuid);
 extern uid_t audit_get_loginuid(struct audit_context *ctx);
+extern int audit_ipc_perms(unsigned long qbytes, uid_t uid, gid_t gid, mode_t mode);
 #else
 #define audit_alloc(t) ({ 0; })
 #define audit_free(t) do { ; } while (0)
@@ -159,6 +160,7 @@
 #define audit_putname(n) do { ; } while (0)
 #define audit_inode(n,i,d) do { ; } while (0)
 #define audit_get_loginuid(c) ({ -1; })
+#define audit_ipc_perms(q,u,g,m) ({ 0; })
 #endif
 
 #ifdef CONFIG_AUDIT
===== ipc/msg.c 1.24 vs edited =====
--- 1.24/ipc/msg.c	2004-10-28 08:39:57 +01:00
+++ edited/ipc/msg.c	2005-02-28 13:39:42 +00:00
@@ -25,6 +25,7 @@
 #include <linux/security.h>
 #include <linux/sched.h>
 #include <linux/syscalls.h>
+#include <linux/audit.h>
 #include <asm/current.h>
 #include <asm/uaccess.h>
 #include "util.h"
@@ -425,6 +426,8 @@
 			return -EFAULT;
 		if (copy_msqid_from_user (&setbuf, buf, version))
 			return -EFAULT;
+		if ((err = audit_ipc_perms(setbuf.qbytes, setbuf.uid, setbuf.gid, setbuf.mode)))
+			return err;
 		break;
 	case IPC_RMID:
 		break;
===== ipc/sem.c 1.36 vs edited =====
--- 1.36/ipc/sem.c	2005-01-05 02:48:17 +00:00
+++ edited/ipc/sem.c	2005-02-28 13:39:48 +00:00
@@ -72,6 +72,7 @@
 #include <linux/smp_lock.h>
 #include <linux/security.h>
 #include <linux/syscalls.h>
+#include <linux/audit.h>
 #include <asm/uaccess.h>
 #include "util.h"
 
@@ -803,6 +804,8 @@
 	if(cmd == IPC_SET) {
 		if(copy_semid_from_user (&setbuf, arg.buf, version))
 			return -EFAULT;
+		if ((err = audit_ipc_perms(0, setbuf.uid, setbuf.gid, setbuf.mode)))
+			return err;
 	}
 	sma = sem_lock(semid);
 	if(sma==NULL)
===== ipc/shm.c 1.43 vs edited =====
--- 1.43/ipc/shm.c	2004-12-13 10:47:27 +00:00
+++ edited/ipc/shm.c	2005-02-28 13:39:28 +00:00
@@ -27,6 +27,7 @@
 #include <linux/shmem_fs.h>
 #include <linux/security.h>
 #include <linux/syscalls.h>
+#include <linux/audit.h>
 #include <asm/uaccess.h>
 
 #include "util.h"
@@ -600,6 +601,8 @@
 			err = -EFAULT;
 			goto out;
 		}
+		if ((err = audit_ipc_perms(0, setbuf.uid, setbuf.gid, setbuf.mode)))
+			return err;
 		down(&shm_ids.sem);
 		shp = shm_lock(shmid);
 		err=-EINVAL;
===== kernel/auditsc.c 1.6 vs edited =====
--- 1.6/kernel/auditsc.c	2005-01-31 06:33:47 +00:00
+++ edited/kernel/auditsc.c	2005-02-28 13:43:01 +00:00
@@ -92,6 +92,23 @@
 	dev_t		rdev;
 };
 
+struct audit_aux_data {
+	struct audit_aux_data	*next;
+	int			type;
+};
+
+#define AUDIT_AUX_IPCPERM	0
+
+struct audit_aux_data_ipcctl {
+	struct audit_aux_data	d;
+	struct ipc_perm		p;
+	unsigned long		qbytes;
+	uid_t			uid;
+	gid_t			gid;
+	mode_t			mode;
+};
+
+
 /* The per-task audit context. */
 struct audit_context {
 	int		    in_syscall;	/* 1 if task is in a syscall */
@@ -107,6 +124,7 @@
 	int		    name_count;
 	struct audit_names  names[AUDIT_NAMES];
 	struct audit_context *previous; /* For nested syscalls */
+	struct audit_aux_data *aux;
 
 				/* Save things to print about task_struct */
 	pid_t		    pid;
@@ -504,6 +522,16 @@
 	context->name_count = 0;
 }
 
+static inline void audit_free_aux(struct audit_context *context)
+{
+	struct audit_aux_data *aux;
+
+	while ((aux = context->aux)) {
+		context->aux = aux->next;
+		kfree(aux);
+	}
+}
+
 static inline void audit_zero_context(struct audit_context *context,
 				      enum audit_state state)
 {
@@ -570,6 +598,7 @@
 			       context->name_count, count);
 		}
 		audit_free_names(context);
+		audit_free_aux(context);
 		kfree(context);
 		context  = previous;
 	} while (context);
@@ -607,6 +636,29 @@
 		  context->euid, context->suid, context->fsuid,
 		  context->egid, context->sgid, context->fsgid);
 	audit_log_end(ab);
+	while (context->aux) {
+		struct audit_aux_data *aux;
+
+		ab = audit_log_start(context);
+		if (!ab)
+			continue; /* audit_panic has been called */
+
+		aux = context->aux;
+		context->aux = aux->next;
+
+		audit_log_format(ab, "auxitem=%d", aux->type);
+		switch (aux->type) {
+		case AUDIT_AUX_IPCPERM: {
+			struct audit_aux_data_ipcctl *axi = (void *)aux;
+			audit_log_format(ab, 
+					 " qbytes=%lx uid=%d gid=%d mode=%x",
+					 axi->qbytes, axi->uid, axi->gid, axi->mode);
+			}
+		}
+		audit_log_end(ab);
+		kfree(aux);
+	}
+
 	for (i = 0; i < context->name_count; i++) {
 		ab = audit_log_start(context);
 		if (!ab)
@@ -789,6 +841,7 @@
 		tsk->audit_context = new_context;
 	} else {
 		audit_free_names(context);
+		audit_free_aux(context);
 		audit_zero_context(context, context->state);
 		tsk->audit_context = context;
 	}
@@ -926,4 +979,30 @@
 uid_t audit_get_loginuid(struct audit_context *ctx)
 {
 	return ctx ? ctx->loginuid : -1;
+}
+
+        return 0;
+  }
+
+int audit_ipc_perms(unsigned long qbytes, uid_t uid, gid_t gid, mode_t mode)
+{
+	struct audit_aux_data_ipcctl *ax;
+	struct audit_context *context = current->audit_context;
+
+	if (likely(!context))
+		return 0;
+
+	ax = kmalloc(sizeof(*ax), GFP_KERNEL);
+	if (!ax)
+		return -ENOMEM;
+
+	ax->qbytes = qbytes;
+	ax->uid = uid;
+	ax->gid = gid;
+	ax->mode = mode;
+
+	ax->d.type = AUDIT_AUX_IPCPERM;
+	ax->d.next = context->aux;
+	context->aux = (void *)ax;
+	return 0;
 }	
A

6 (

x	9
z	




z	

	

z	
raph

z	


Å
Å
	

z	


z	
	
5
	




n
6 

Å

y	c liÅ
	!
50,Å
6 

9

Å
6 
0)
z	

ph



Å


 
0,Å
6Å
Å
6


Å


6!

,Å
6 

z	


phÅ
9

z	

y	

Å


A
	









	


y	
	

ph

y	c liÅ

y	

Å
50y
	

y	c link
	



h

y	c link

x	
Å
Å


!
0,Å
6


y	
y	


ph
ph




y	

y	

aph


y	c link

ph


Å

h


h
'

aph



y	c link






t


h


h





y	c link








W	ˇ
)Y	°
x	

x	Å
h
Å

“n	A







6 


6 

 

pc/msg.Å

x	c link
8Öx	
s
ne !
Å
6 
0,Å
6 

05




6 
ë8
05

Å
50,Å
6 

-- 
dwmw2

