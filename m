Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261537AbVESLfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbVESLfq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 07:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbVESLfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 07:35:45 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:31120 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261537AbVESLeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 07:34:14 -0400
Subject: Re: 2.6.12-rc4-mm2 - sleeping function called from invalid context
	at mm/slab.c:2502
From: David Woodhouse <dwmw2@infradead.org>
To: Linux Audit Discussion <linux-audit@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200505171624.j4HGOQwo017312@turing-police.cc.vt.edu>
References: <200505171624.j4HGOQwo017312@turing-police.cc.vt.edu>
Content-Type: text/plain
Date: Thu, 19 May 2005 12:34:08 +0100
Message-Id: <1116502449.23972.207.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-17 at 12:24 -0400, Valdis.Kletnieks@vt.edu wrote:
> [4295584.974000] Debug: sleeping function called from invalid context
> at mm/slab.c:2502
> [4295584.974000] in_atomic():1, irqs_disabled():0
> [4295584.974000]  [<c01035a8>] dump_stack+0x15/0x17
> [4295584.974000]  [<c013ba6d>] kmem_cache_alloc+0x1e/0x6a
> [4295584.974000]  [<c02de4fa>] skb_clone+0x14/0x183
> [4295584.974000]  [<c02ef64a>] netlink_unicast+0x7d/0x171
> [4295584.974000]  [<c0130947>] audit_log_end_fast+0xf5/0x188
> [4295584.974000]  [<c01c3c56>] avc_audit+0x94d/0x958

OK, we'll just let audit_log() assemble its own skb and queue it for a
separate kernel thread to feed up to auditd. We'll fix up the horrid
error handling mess we had before too, where we used to clone the skb
because we know netlink_unicast() would free it even on temporary errors
(like the SO_RCVBUF limit being reached).

This includes one of Steve's earlier patches which ensures that messages
in the skb are NUL-terminated. It should all appear some time soon in
http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/dwmw2/audit-2.6.git;a=summary
or more perhaps more usefully (since Thomas allows us to distinguish
between local and merged commits) in
http://www.tglx.de/cgi-bin/gittracker/commit/tracker-linux/audit-2.6.git?project=tracker-linux%2Fdwmw2%2Faudit-2.6.git&pagelen=10&exclude=tracker-linux%2Ftorvalds%2Flinux-2.6.git&offset=0

Index: kernel/audit.c
===================================================================
--- e45ee43e7af31f847377e8bb3a0a61581732b653/kernel/audit.c  (mode:100644)
+++ c1096ff7ae35b77bf8108c3a60b856551c50a9d7/kernel/audit.c  (mode:100644)
@@ -46,6 +46,8 @@
 #include <asm/types.h>
 #include <linux/mm.h>
 #include <linux/module.h>
+#include <linux/err.h>
+#include <linux/kthread.h>
 
 #include <linux/audit.h>
 
@@ -77,7 +79,6 @@
 
 /* Number of outstanding audit_buffers allowed. */
 static int	audit_backlog_limit = 64;
-static atomic_t	audit_backlog	    = ATOMIC_INIT(0);
 
 /* The identity of the user shutting down the audit system. */
 uid_t		audit_sig_uid = -1;
@@ -95,19 +96,17 @@
 /* The netlink socket. */
 static struct sock *audit_sock;
 
-/* There are two lists of audit buffers.  The txlist contains audit
- * buffers that cannot be sent immediately to the netlink device because
- * we are in an irq context (these are sent later in a tasklet).
- *
- * The second list is a list of pre-allocated audit buffers (if more
+/* The audit_freelist is a list of pre-allocated audit buffers (if more
  * than AUDIT_MAXFREE are in use, the audit buffer is freed instead of
  * being placed on the freelist). */
-static DEFINE_SPINLOCK(audit_txlist_lock);
 static DEFINE_SPINLOCK(audit_freelist_lock);
 static int	   audit_freelist_count = 0;
-static LIST_HEAD(audit_txlist);
 static LIST_HEAD(audit_freelist);
 
+static struct sk_buff_head audit_skb_queue;
+static struct task_struct *kauditd_task;
+static DECLARE_WAIT_QUEUE_HEAD(kauditd_wait);
+
 /* There are three lists of rules -- one to search at task creation
  * time, one to search at syscall entry time, and another to search at
  * syscall exit time. */
@@ -151,9 +150,6 @@
 	struct audit_rule rule;
 };
 
-static void audit_log_end_irq(struct audit_buffer *ab);
-static void audit_log_end_fast(struct audit_buffer *ab);
-
 static void audit_panic(const char *message)
 {
 	switch (audit_failure)
@@ -224,10 +220,8 @@
 
 	if (print) {
 		printk(KERN_WARNING
-		       "audit: audit_lost=%d audit_backlog=%d"
-		       " audit_rate_limit=%d audit_backlog_limit=%d\n",
+		       "audit: audit_lost=%d audit_rate_limit=%d audit_backlog_limit=%d\n",
 		       atomic_read(&audit_lost),
-		       atomic_read(&audit_backlog),
 		       audit_rate_limit,
 		       audit_backlog_limit);
 		audit_panic(message);
@@ -281,6 +275,38 @@
 	return old;
 }
 
+int kauditd_thread(void *dummy)
+{
+	struct sk_buff *skb;
+
+	while (1) {
+		skb = skb_dequeue(&audit_skb_queue);
+		if (skb) {
+			if (audit_pid) {
+				int err = netlink_unicast(audit_sock, skb, audit_pid, 0);
+				if (err < 0) {
+					BUG_ON(err != -ECONNREFUSED); /* Shoudn't happen */
+					printk(KERN_ERR "audit: *NO* daemon at audit_pid=%d\n", audit_pid);
+					audit_pid = 0;
+				}
+			} else {
+				printk(KERN_ERR "%s\n", skb->data + NLMSG_SPACE(0));
+				kfree_skb(skb);
+			}
+		} else {
+			DECLARE_WAITQUEUE(wait, current);
+			set_current_state(TASK_INTERRUPTIBLE);
+			add_wait_queue(&kauditd_wait, &wait);
+
+			if (!skb_queue_len(&audit_skb_queue))
+				schedule();
+
+			__set_current_state(TASK_RUNNING);
+			remove_wait_queue(&kauditd_wait, &wait);
+		}
+	}
+}
+
 void audit_send_reply(int pid, int seq, int type, int done, int multi,
 		      void *payload, int size)
 {
@@ -293,13 +319,16 @@
 
 	skb = alloc_skb(len, GFP_KERNEL);
 	if (!skb)
-		goto nlmsg_failure;
+		return;
 
-	nlh		 = NLMSG_PUT(skb, pid, seq, t, len - sizeof(*nlh));
+	nlh		 = NLMSG_PUT(skb, pid, seq, t, size);
 	nlh->nlmsg_flags = flags;
 	data		 = NLMSG_DATA(nlh);
 	memcpy(data, payload, size);
-	netlink_unicast(audit_sock, skb, pid, MSG_DONTWAIT);
+
+	/* Ignore failure. It'll only happen if the sender goes away,
+	   because our timeout is set to infinite. */
+	netlink_unicast(audit_sock, skb, pid, 0);
 	return;
 
 nlmsg_failure:			/* Used by NLMSG_PUT */
@@ -351,6 +380,15 @@
 	if (err)
 		return err;
 
+	/* As soon as there's any sign of userspace auditd, start kauditd to talk to it */
+	if (!kauditd_task)
+		kauditd_task = kthread_run(kauditd_thread, NULL, "kauditd");
+	if (IS_ERR(kauditd_task)) {
+		err = PTR_ERR(kauditd_task);
+		kauditd_task = NULL;
+		return err;
+	}
+
 	pid  = NETLINK_CREDS(skb)->pid;
 	uid  = NETLINK_CREDS(skb)->uid;
 	loginuid = NETLINK_CB(skb).loginuid;
@@ -365,7 +403,7 @@
 		status_set.rate_limit	 = audit_rate_limit;
 		status_set.backlog_limit = audit_backlog_limit;
 		status_set.lost		 = atomic_read(&audit_lost);
-		status_set.backlog	 = atomic_read(&audit_backlog);
+		status_set.backlog	 = skb_queue_len(&audit_skb_queue);
 		audit_send_reply(NETLINK_CB(skb).pid, seq, AUDIT_GET, 0, 0,
 				 &status_set, sizeof(status_set));
 		break;
@@ -471,44 +509,6 @@
 	up(&audit_netlink_sem);
 }
 
-/* Grab skbuff from the audit_buffer and send to user space. */
-static inline int audit_log_drain(struct audit_buffer *ab)
-{
-	struct sk_buff *skb = ab->skb;
-
-	if (skb) {
-		int retval = 0;
-
-		if (audit_pid) {
-			struct nlmsghdr *nlh = (struct nlmsghdr *)skb->data;
-			nlh->nlmsg_len = skb->len - NLMSG_SPACE(0);
-			skb_get(skb); /* because netlink_* frees */
-			retval = netlink_unicast(audit_sock, skb, audit_pid,
-						 MSG_DONTWAIT);
-		}
-		if (retval == -EAGAIN &&
-		    (atomic_read(&audit_backlog)) < audit_backlog_limit) {
-			audit_log_end_irq(ab);
-			return 1;
-		}
-		if (retval < 0) {
-			if (retval == -ECONNREFUSED) {
-				printk(KERN_ERR
-				       "audit: *NO* daemon at audit_pid=%d\n",
-				       audit_pid);
-				audit_pid = 0;
-			} else
-				audit_log_lost("netlink socket too busy");
-		}
-		if (!audit_pid) { /* No daemon */
-			int offset = NLMSG_SPACE(0);
-			int len    = skb->len - offset;
-			skb->data[offset + len] = '\0';
-			printk(KERN_ERR "%s\n", skb->data + offset);
-		}
-	}
-	return 0;
-}
 
 /* Initialize audit support at boot time. */
 static int __init audit_init(void)
@@ -519,6 +519,8 @@
 	if (!audit_sock)
 		audit_panic("cannot initialize netlink socket");
 
+	audit_sock->sk_sndtimeo = MAX_SCHEDULE_TIMEOUT;
+	skb_queue_head_init(&audit_skb_queue);
 	audit_initialized = 1;
 	audit_enabled = audit_default;
 	audit_log(NULL, AUDIT_KERNEL, "initialized");
@@ -549,7 +551,7 @@
 
 	if (ab->skb)
 		kfree_skb(ab->skb);
-	atomic_dec(&audit_backlog);
+
 	spin_lock_irqsave(&audit_freelist_lock, flags);
 	if (++audit_freelist_count > AUDIT_MAXFREE)
 		kfree(ab);
@@ -579,13 +581,12 @@
 		if (!ab)
 			goto err;
 	}
-	atomic_inc(&audit_backlog);
 
 	ab->skb = alloc_skb(AUDIT_BUFSIZ, gfp_mask);
 	if (!ab->skb)
 		goto err;
 
-	ab->ctx   = ctx;
+	ab->ctx = ctx;
 	nlh = (struct nlmsghdr *)skb_put(ab->skb, NLMSG_SPACE(0));
 	nlh->nlmsg_type = type;
 	nlh->nlmsg_flags = 0;
@@ -612,18 +613,6 @@
 	if (!audit_initialized)
 		return NULL;
 
-	if (audit_backlog_limit
-	    && atomic_read(&audit_backlog) > audit_backlog_limit) {
-		if (audit_rate_check())
-			printk(KERN_WARNING
-			       "audit: audit_backlog=%d > "
-			       "audit_backlog_limit=%d\n",
-			       atomic_read(&audit_backlog),
-			       audit_backlog_limit);
-		audit_log_lost("backlog limit exceeded");
-		return NULL;
-	}
-
 	ab = audit_buffer_alloc(ctx, GFP_ATOMIC, type);
 	if (!ab) {
 		audit_log_lost("out of memory in audit_log_start");
@@ -692,7 +681,8 @@
 			goto out;
 		len = vsnprintf(skb->tail, avail, fmt, args2);
 	}
-	skb_put(skb, (len < avail) ? len : avail);
+	if (len > 0)
+		skb_put(skb, len);
 out:
 	return;
 }
@@ -710,20 +700,47 @@
 	va_end(args);
 }
 
-void audit_log_hex(struct audit_buffer *ab, const unsigned char *buf, size_t len)
+/* This function will take the passed buf and convert it into a string of
+ * ascii hex digits. The new string is placed onto the skb. */
+void audit_log_hex(struct audit_buffer *ab, const unsigned char *buf, 
+		size_t len)
 {
-	int i;
+	int i, avail, new_len;
+	unsigned char *ptr;
+	struct sk_buff *skb;
+	static const unsigned char *hex = "0123456789ABCDEF";
+
+	BUG_ON(!ab->skb);
+	skb = ab->skb;
+	avail = skb_tailroom(skb);
+	new_len = len<<1;
+	if (new_len >= avail) {
+		/* Round the buffer request up to the next multiple */
+		new_len = AUDIT_BUFSIZ*(((new_len-avail)/AUDIT_BUFSIZ) + 1);
+		avail = audit_expand(ab, new_len);
+		if (!avail)
+			return;
+	}
 
-	for (i=0; i<len; i++)
-		audit_log_format(ab, "%02x", buf[i]);
+	ptr = skb->tail;
+	for (i=0; i<len; i++) {
+		*ptr++ = hex[(buf[i] & 0xF0)>>4]; /* Upper nibble */
+		*ptr++ = hex[buf[i] & 0x0F];	  /* Lower nibble */
+	}
+	*ptr = 0;
+	skb_put(skb, len << 1); /* new string is twice the old string */
 }
 
+/* This code will escape a string that is passed to it if the string
+ * contains a control character, unprintable character, double quote mark, 
+ * or a space. Unescaped strings will start and end with a double quote mark.
+ * Strings that are escaped are printed in hex (2 digits per char). */
 void audit_log_untrustedstring(struct audit_buffer *ab, const char *string)
 {
 	const unsigned char *p = string;
 
 	while (*p) {
-		if (*p == '"' || *p == ' ' || *p < 0x20 || *p > 0x7f) {
+		if (*p == '"' || *p < 0x21 || *p > 0x7f) {
 			audit_log_hex(ab, string, strlen(string));
 			return;
 		}
@@ -732,97 +749,54 @@
 	audit_log_format(ab, "\"%s\"", string);
 }
 
-
-/* This is a helper-function to print the d_path without using a static
- * buffer or allocating another buffer in addition to the one in
- * audit_buffer. */
+/* This is a helper-function to print the escaped d_path */
 void audit_log_d_path(struct audit_buffer *ab, const char *prefix,
 		      struct dentry *dentry, struct vfsmount *vfsmnt)
 {
-	char *p;
-	struct sk_buff *skb = ab->skb;
-	int  len, avail;
+	char *p, *path;
 
 	if (prefix)
 		audit_log_format(ab, " %s", prefix);
 
-	avail = skb_tailroom(skb);
-	p = d_path(dentry, vfsmnt, skb->tail, avail);
-	if (IS_ERR(p)) {
-		/* FIXME: can we save some information here? */
-		audit_log_format(ab, "<toolong>");
-	} else {
-		/* path isn't at start of buffer */
-		len = ((char *)skb->tail + avail - 1) - p;
-		memmove(skb->tail, p, len);
-		skb_put(skb, len);
-	}
-}
-
-/* Remove queued messages from the audit_txlist and send them to user space. */
-static void audit_tasklet_handler(unsigned long arg)
-{
-	LIST_HEAD(list);
-	struct audit_buffer *ab;
-	unsigned long	    flags;
-
-	spin_lock_irqsave(&audit_txlist_lock, flags);
-	list_splice_init(&audit_txlist, &list);
-	spin_unlock_irqrestore(&audit_txlist_lock, flags);
-
-	while (!list_empty(&list)) {
-		ab = list_entry(list.next, struct audit_buffer, list);
-		list_del(&ab->list);
-		audit_log_end_fast(ab);
+	/* We will allow 11 spaces for ' (deleted)' to be appended */
+	path = kmalloc(PATH_MAX+11, GFP_KERNEL);
+	if (!path) {
+		audit_log_format(ab, "<no memory>");
+		return;
 	}
+	p = d_path(dentry, vfsmnt, path, PATH_MAX+11);
+	if (IS_ERR(p)) { /* Should never happen since we send PATH_MAX */
+		/* FIXME: can we save some information here? */
+		audit_log_format(ab, "<too long>");
+	} else 
+		audit_log_untrustedstring(ab, p);
+	kfree(path);
 }
 
-static DECLARE_TASKLET(audit_tasklet, audit_tasklet_handler, 0);
-
 /* The netlink_* functions cannot be called inside an irq context, so
  * the audit buffer is places on a queue and a tasklet is scheduled to
  * remove them from the queue outside the irq context.  May be called in
  * any context. */
-static void audit_log_end_irq(struct audit_buffer *ab)
-{
-	unsigned long flags;
-
-	if (!ab)
-		return;
-	spin_lock_irqsave(&audit_txlist_lock, flags);
-	list_add_tail(&ab->list, &audit_txlist);
-	spin_unlock_irqrestore(&audit_txlist_lock, flags);
-
-	tasklet_schedule(&audit_tasklet);
-}
-
-/* Send the message in the audit buffer directly to user space.  May not
- * be called in an irq context. */
-static void audit_log_end_fast(struct audit_buffer *ab)
+void audit_log_end(struct audit_buffer *ab)
 {
-	BUG_ON(in_irq());
 	if (!ab)
 		return;
 	if (!audit_rate_check()) {
 		audit_log_lost("rate limit exceeded");
 	} else {
-		if (audit_log_drain(ab))
-			return;
+		if (audit_pid) {
+			struct nlmsghdr *nlh = (struct nlmsghdr *)ab->skb->data;
+			nlh->nlmsg_len = ab->skb->len - NLMSG_SPACE(0);
+			skb_queue_tail(&audit_skb_queue, ab->skb);
+			ab->skb = NULL;
+			wake_up_interruptible(&kauditd_wait);
+		} else {
+			printk("%s\n", ab->skb->data + NLMSG_SPACE(0));
+		}
 	}
 	audit_buffer_free(ab);
 }
 
-/* Send or queue the message in the audit buffer, depending on the
- * current context.  (A convenience function that may be called in any
- * context.) */
-void audit_log_end(struct audit_buffer *ab)
-{
-	if (in_irq())
-		audit_log_end_irq(ab);
-	else
-		audit_log_end_fast(ab);
-}
-
 /* Log an audit record.  This is a convenience function that calls
  * audit_log_start, audit_log_vformat, and audit_log_end.  It may be
  * called in any context. */


-- 
dwmw2

