Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262680AbVA0Rj0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262680AbVA0Rj0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 12:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbVA0Ri3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 12:38:29 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:3751 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262686AbVA0Rgf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 12:36:35 -0500
Date: Thu, 27 Jan 2005 11:36:31 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       linux-audit@redhat.com
Cc: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>
Subject: [PATCH] [audit] handle loginuid through proc
Message-ID: <20050127173631.GB3252@IBM-BWN8ZTBWA01.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The audit subsystem uses netlink messages to request loginuid
changes.  Due to the sensitivity of loginuid, netlink appears to
be insufficient.  For instance, it is not easy to guarantee that
the loginuid message will be handled before any other auditable
actions, and there is even the remote possibility of the process
terminating and another process with the same pid being created
before the message is handled.  Finally, other kernel code, in
particular selinux, is interested in easily querying the loginuid
for inclusion in its own messages.

The following patch moves loginuid handling from netlink to the
/proc/$$/loginuid file, and adds a audit_get_loginuid() function.
It also includes Stephen Smalley's patch to correctly inherit the
loginuid on fork.  It has been actively discussed on the
linux-audit mailing list.

Please apply.

thanks,
-serge

Signed-off-by: Serge Hallyn <serue@us.ibm.com>

Index: linux-2.6.10/fs/proc/base.c
===================================================================
--- linux-2.6.10.orig/fs/proc/base.c	2005-01-27 10:25:39.585367912 -0600
+++ linux-2.6.10/fs/proc/base.c	2005-01-27 10:51:02.915786488 -0600
@@ -71,6 +71,9 @@ enum pid_directory_inos {
 	PROC_TGID_ATTR_EXEC,
 	PROC_TGID_ATTR_FSCREATE,
 #endif
+#ifdef CONFIG_AUDITSYSCALL
+	PROC_TGID_LOGINUID,
+#endif
 	PROC_TGID_FD_DIR,
 	PROC_TID_INO,
 	PROC_TID_STATUS,
@@ -97,6 +100,9 @@ enum pid_directory_inos {
 	PROC_TID_ATTR_EXEC,
 	PROC_TID_ATTR_FSCREATE,
 #endif
+#ifdef CONFIG_AUDITSYSCALL
+	PROC_TID_LOGINUID,
+#endif
 	PROC_TID_FD_DIR = 0x8000,	/* 0x8000-0xffff */
 };
 
@@ -133,6 +139,9 @@ static struct pid_entry tgid_base_stuff[
 #ifdef CONFIG_SCHEDSTATS
 	E(PROC_TGID_SCHEDSTAT, "schedstat", S_IFREG|S_IRUGO),
 #endif
+#ifdef CONFIG_AUDITSYSCALL
+	E(PROC_TGID_LOGINUID, "loginuid", S_IFREG|S_IWUSR|S_IRUGO),
+#endif
 	{0,0,NULL,0}
 };
 static struct pid_entry tid_base_stuff[] = {
@@ -158,6 +167,9 @@ static struct pid_entry tid_base_stuff[]
 #ifdef CONFIG_SCHEDSTATS
 	E(PROC_TID_SCHEDSTAT, "schedstat",S_IFREG|S_IRUGO),
 #endif
+#ifdef CONFIG_AUDITSYSCALL
+	E(PROC_TID_LOGINUID, "loginuid", S_IFREG|S_IWUSR|S_IRUGO),
+#endif
 	{0,0,NULL,0}
 };
 
@@ -661,6 +673,71 @@ static struct inode_operations proc_mem_
 	.permission	= proc_permission,
 };
 
+#ifdef CONFIG_AUDITSYSCALL
+#define TMPBUFLEN 21
+static ssize_t proc_loginuid_read(struct file * file, char __user * buf,
+				  size_t count, loff_t *ppos)
+{
+	struct inode * inode = file->f_dentry->d_inode;
+	struct task_struct *task = proc_task(inode);
+	ssize_t length;
+	char tmpbuf[TMPBUFLEN];
+
+	length = scnprintf(tmpbuf, TMPBUFLEN, "%u",
+				audit_get_loginuid(task->audit_context));
+	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
+}
+
+static ssize_t proc_loginuid_write(struct file * file, const char __user * buf,
+				   size_t count, loff_t *ppos)
+{ 
+	struct inode * inode = file->f_dentry->d_inode;
+	char *page, *tmp;
+	ssize_t length;
+	struct task_struct *task = proc_task(inode);
+	uid_t loginuid;
+
+	if (!capable(CAP_AUDIT_CONTROL))
+		return -EPERM;
+
+	if (current != task)
+		return -EPERM;
+
+	if (count > PAGE_SIZE)
+		count = PAGE_SIZE;
+
+	if (*ppos != 0) {
+		/* No partial writes. */
+		return -EINVAL;
+	}
+	page = (char*)__get_free_page(GFP_USER);
+	if (!page)
+		return -ENOMEM;
+	length = -EFAULT;
+	if (copy_from_user(page, buf, count))
+		goto out_free_page;
+
+	loginuid = simple_strtoul(page, &tmp, 10);
+	if (tmp == page) {
+		length = -EINVAL;
+		goto out_free_page;
+
+	}
+	length = audit_set_loginuid(task->audit_context, loginuid);
+	if (likely(length == 0))
+		length = count;
+
+out_free_page:
+	free_page((unsigned long) page);
+	return length;
+}
+
+static struct file_operations proc_loginuid_operations = {
+	.read		= proc_loginuid_read,
+	.write		= proc_loginuid_write,
+};
+#endif
+
 static int proc_pid_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	struct inode *inode = dentry->d_inode;
@@ -1336,6 +1413,12 @@ static struct dentry *proc_pident_lookup
 			ei->op.proc_read = proc_pid_schedstat;
 			break;
 #endif
+#ifdef CONFIG_AUDITSYSCALL
+		case PROC_TID_LOGINUID:
+		case PROC_TGID_LOGINUID:
+			inode->i_fop = &proc_loginuid_operations;
+			break;
+#endif
 		default:
 			printk("procfs: impossible type (%d)",p->type);
 			iput(inode);
Index: linux-2.6.10/include/linux/audit.h
===================================================================
--- linux-2.6.10.orig/include/linux/audit.h	2004-12-24 15:34:57.000000000 -0600
+++ linux-2.6.10/include/linux/audit.h	2005-01-27 10:46:57.887036520 -0600
@@ -114,12 +114,6 @@ struct audit_status {
 	__u32		backlog;	/* messages waiting in queue */
 };
 
-struct audit_login {
-	__u32		loginuid;
-	int		msglen;
-	char		msg[1024];
-};
-
 struct audit_rule {		/* for AUDIT_LIST, AUDIT_ADD, and AUDIT_DEL */
 	__u32		flags;	/* AUDIT_PER_{TASK,CALL}, AUDIT_PREPEND */
 	__u32		action;	/* AUDIT_NEVER, AUDIT_POSSIBLE, AUDIT_ALWAYS */
@@ -155,6 +149,7 @@ extern int  audit_receive_filter(int typ
 extern void audit_get_stamp(struct audit_context *ctx,
 			    struct timespec *t, int *serial);
 extern int  audit_set_loginuid(struct audit_context *ctx, uid_t loginuid);
+extern uid_t audit_get_loginuid(struct audit_context *ctx);
 #else
 #define audit_alloc(t) ({ 0; })
 #define audit_free(t) do { ; } while (0)
@@ -163,6 +158,7 @@ extern int  audit_set_loginuid(struct au
 #define audit_getname(n) do { ; } while (0)
 #define audit_putname(n) do { ; } while (0)
 #define audit_inode(n,i,d) do { ; } while (0)
+#define audit_get_loginuid(c) ({ -1; })
 #endif
 
 #ifdef CONFIG_AUDIT
Index: linux-2.6.10/kernel/audit.c
===================================================================
--- linux-2.6.10.orig/kernel/audit.c	2005-01-27 10:25:43.529768272 -0600
+++ linux-2.6.10/kernel/audit.c	2005-01-27 10:46:57.888036368 -0600
@@ -145,6 +145,11 @@ struct audit_buffer {
 	int		     count; /* Times requeued */
 };
 
+void audit_set_type(struct audit_buffer *ab, int type)
+{
+	ab->type = type;
+}
+
 struct audit_entry {
 	struct list_head  list;
 	struct audit_rule rule;
@@ -312,7 +317,6 @@ static int audit_netlink_ok(kernel_cap_t
 	case AUDIT_GET:
 	case AUDIT_LIST:
 	case AUDIT_SET:
-	case AUDIT_LOGIN:
 	case AUDIT_ADD:
 	case AUDIT_DEL:
 		if (!cap_raised(eff_cap, CAP_AUDIT_CONTROL))
@@ -334,7 +338,6 @@ static int audit_receive_msg(struct sk_b
 	u32			uid, pid, seq;
 	void			*data;
 	struct audit_status	*status_get, status_set;
-	struct audit_login	*login;
 	int			err;
 	struct audit_buffer	*ab;
 	u16			msg_type = nlh->nlmsg_type;
@@ -397,27 +400,6 @@ static int audit_receive_msg(struct sk_b
 		ab->pid  = pid;
 		audit_log_end(ab);
 		break;
-	case AUDIT_LOGIN:
-		if (nlh->nlmsg_len < sizeof(struct audit_login))
-			return -EINVAL;
-		login = (struct audit_login *)data;
-		ab = audit_log_start(NULL);
-		if (ab) {
-			audit_log_format(ab, "login pid=%d uid=%d loginuid=%d"
-					 " length=%d msg='%.1024s'",
-					 pid, uid,
-					 login->loginuid,
-					 login->msglen,
-					 login->msg);
-			ab->type = AUDIT_LOGIN;
-			ab->pid  = pid;
-			audit_log_end(ab);
-		}
-#ifdef CONFIG_AUDITSYSCALL
-		err = audit_set_loginuid(current->audit_context,
-					 login->loginuid);
-#endif
-		break;
 	case AUDIT_ADD:
 	case AUDIT_DEL:
 		if (nlh->nlmsg_len < sizeof(struct audit_rule))
Index: linux-2.6.10/kernel/auditsc.c
===================================================================
--- linux-2.6.10.orig/kernel/auditsc.c	2005-01-27 10:25:43.655749120 -0600
+++ linux-2.6.10/kernel/auditsc.c	2005-01-27 10:46:57.890036064 -0600
@@ -547,8 +547,8 @@ int audit_alloc(struct task_struct *tsk)
 
 				/* Preserve login uid */
 	context->loginuid = -1;
-	if (tsk->audit_context)
-		context->loginuid = tsk->audit_context->loginuid;
+	if (current->audit_context)
+		context->loginuid = current->audit_context->loginuid;
 
 	tsk->audit_context  = context;
 	set_tsk_thread_flag(tsk, TIF_SYSCALL_AUDIT);
@@ -903,12 +903,27 @@ void audit_get_stamp(struct audit_contex
 	}
 }
 
+extern int audit_set_type(struct audit_buffer *ab, int type);
+
 int audit_set_loginuid(struct audit_context *ctx, uid_t loginuid)
 {
 	if (ctx) {
-		if (loginuid < 0)
-			return -EINVAL;
+		struct audit_buffer *ab;
+
+		ab = audit_log_start(NULL);
+		if (ab) {
+			audit_log_format(ab, "login pid=%d uid=%u "
+				"old loginuid=%u new loginuid=%u",
+				ctx->pid, ctx->uid, ctx->loginuid, loginuid);
+			audit_set_type(ab, AUDIT_LOGIN);
+			audit_log_end(ab);
+		}
 		ctx->loginuid = loginuid;
 	}
 	return 0;
 }
+
+uid_t audit_get_loginuid(struct audit_context *ctx)
+{
+	return ctx ? ctx->loginuid : -1;
+}

