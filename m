Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbUCQJO3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 04:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbUCQJO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 04:14:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:32729 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261215AbUCQJOV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 04:14:21 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16472.5852.375648.739489@neuro.alephnull.com>
Date: Wed, 17 Mar 2004 04:14:04 -0500
From: Rik Faith <faith@redhat.com>
To: paulmck@us.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Light-weight Auditing Framework
In-Reply-To: [Paul E. McKenney <paulmck@us.ibm.com>] Fri 12 Mar 2004 10:50:33 -0800
References: <16464.30442.852919.24605@neuro.alephnull.com>
	<20040312185033.GA2507@us.ibm.com>
X-Key: 7EB57214; 958B 394D AD29 257E 553F  E7C7 9F67 4BE0 7EB5 7214
X-Url: http://www.redhat.com/
X-Mailer: VM 7.17; XEmacs 21.4; Linux 2.4.22-1.2163.nptl (neuro)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 12 Mar 2004 10:50:33 -0800,
   Paul E. McKenney <paulmck@us.ibm.com> wrote:
> o	I don't see any rcu_read_lock() or rcu_read_unlock() calls.

Fixed.

> o	Presumably something surrounding netlink_kernel_create()
> 	ensures that only one instance of audit_del_rule() will
> 	be executing at a given time.  If not, some locking is
> 	needed.

I was unable to find anything, so I added a semaphore to the receive
routine, and comments to the add and delete routines.

> o	The audit_add_rule() function also needs something to prevent
> 	races with other audit_add_rule() and audit_del_rule()
> 	instances.

This is also handled by the semaphore.

Thanks for your comments!  This patch is against 2.6.5-rc1-mm1.  It also
corrects a problem that could trigger a BUG() near boot time.

 audit.c   |    9 +++++++++
 auditsc.c |   38 +++++++++++++++++++++++++++++---------
 2 files changed, 38 insertions(+), 9 deletions(-)

diff -rupP --exclude-from=ignore linux-2.6.4-pristine/kernel/audit.c linux-2.6.4/kernel/audit.c
--- linux-2.6.4-pristine/kernel/audit.c	2004-03-16 11:01:00.000000000 -0500
+++ linux-2.6.4/kernel/audit.c	2004-03-16 15:47:45.000000000 -0500
@@ -111,6 +111,11 @@ static LIST_HEAD(audit_tsklist);
 static LIST_HEAD(audit_entlist);
 static LIST_HEAD(audit_extlist);
 
+/* The netlink socket is only to be read by 1 CPU, which lets us assume
+ * that list additions and deletions never happen simultaneiously in
+ * auditsc.c */
+static DECLARE_MUTEX(audit_netlink_sem);
+
 /* AUDIT_BUFSIZ is the size of the temporary buffer used for formatting
  * audit records.  Since printk uses a 1024 byte buffer, this buffer
  * should be at least that large. */
@@ -427,6 +432,9 @@ static void audit_receive(struct sock *s
 {
 	struct sk_buff  *skb;
 
+	if (down_trylock(&audit_netlink_sem))
+		return;
+	
 				/* FIXME: this must not cause starvation */
 	while ((skb = skb_dequeue(&sk->sk_receive_queue))) {
 		if (audit_receive_skb(skb) && skb->len)
@@ -434,6 +442,7 @@ static void audit_receive(struct sock *s
 		else
 			kfree_skb(skb);
 	}
+	up(&audit_netlink_sem);
 }
 
 /* Move data from tmp buffer into an skb.  This is an extra copy, and
diff -rupP --exclude-from=ignore linux-2.6.4-pristine/kernel/auditsc.c linux-2.6.4/kernel/auditsc.c
--- linux-2.6.4-pristine/kernel/auditsc.c	2004-03-16 11:01:00.000000000 -0500
+++ linux-2.6.4/kernel/auditsc.c	2004-03-16 17:43:37.000000000 -0500
@@ -158,6 +158,9 @@ static int audit_compare_rule(struct aud
 	return 0;
 }
 
+/* Note that audit_add_rule and audit_del_rule are called via
+ * audit_receive() in audit.c, and are protected by
+ * audit_netlink_sem. */
 static inline int audit_add_rule(struct audit_entry *entry,
 				 struct list_head *list)
 {
@@ -175,12 +178,17 @@ static void audit_free_rule(void *arg)
 	kfree(arg);
 }
 
+/* Note that audit_add_rule and audit_del_rule are called via
+ * audit_receive() in audit.c, and are protected by
+ * audit_netlink_sem. */
 static inline int audit_del_rule(struct audit_rule *rule,
 				 struct list_head *list)
 {
 	struct audit_entry  *e;
 
-	list_for_each_entry_rcu(e, list, list) {
+	/* Do not use the _rcu iterator here, since this is the only
+	 * deletion routine. */
+	list_for_each_entry(e, list, list) {
 		if (!audit_compare_rule(rule, &e->rule)) {
 			list_del_rcu(&e->list);
 			call_rcu(&e->rcu, audit_free_rule, e);
@@ -223,6 +231,7 @@ int audit_receive_filter(int type, int p
 
 	switch (type) {
 	case AUDIT_LIST:
+		rcu_read_lock();
 		list_for_each_entry_rcu(entry, &audit_tsklist, list)
 			audit_send_reply(pid, seq, AUDIT_LIST, 0, 1,
 					 &entry->rule, sizeof(entry->rule));
@@ -232,6 +241,7 @@ int audit_receive_filter(int type, int p
 		list_for_each_entry_rcu(entry, &audit_extlist, list)
 			audit_send_reply(pid, seq, AUDIT_LIST, 0, 1,
 					 &entry->rule, sizeof(entry->rule));
+		rcu_read_unlock();
 		audit_send_reply(pid, seq, AUDIT_LIST, 1, 1, NULL, 0);
 		break;
 	case AUDIT_ADD:
@@ -382,10 +392,14 @@ static enum audit_state audit_filter_tas
 	struct audit_entry *e;
 	enum audit_state   state;
 
+	rcu_read_lock();
 	list_for_each_entry_rcu(e, &audit_tsklist, list) {
-		if (audit_filter_rules(tsk, &e->rule, NULL, &state))
+		if (audit_filter_rules(tsk, &e->rule, NULL, &state)) {
+			rcu_read_unlock();
 			return state;
+		}
 	}
+	rcu_read_unlock();
 	return AUDIT_BUILD_CONTEXT;
 }
 
@@ -403,11 +417,15 @@ static enum audit_state audit_filter_sys
 	int		   word = AUDIT_WORD(ctx->major);
 	int		   bit  = AUDIT_BIT(ctx->major);
 
+	rcu_read_lock();
 	list_for_each_entry_rcu(e, list, list) {
 		if ((e->rule.mask[word] & bit) == bit
- 		    && audit_filter_rules(tsk, &e->rule, ctx, &state))
+ 		    && audit_filter_rules(tsk, &e->rule, ctx, &state)) {
+			rcu_read_unlock();
 			return state;
+		}
 	}
+	rcu_read_unlock();
 	return AUDIT_BUILD_CONTEXT;
 }
 
@@ -753,8 +771,8 @@ void audit_getname(const char *name)
 	BUG_ON(!context);
 	if (!context->in_syscall) {
 #if AUDIT_DEBUG == 2
-		printk(KERN_ERR "audit.c:%d(:%d): ignoring getname(%p)\n",
-		       __LINE__, context->serial, name);
+		printk(KERN_ERR "%s:%d(:%d): ignoring getname(%p)\n",
+		       __FILE__, __LINE__, context->serial, name);
 		dump_stack();
 #endif
 		return;
@@ -777,8 +795,8 @@ void audit_putname(const char *name)
 	BUG_ON(!context);
 	if (!context->in_syscall) {
 #if AUDIT_DEBUG == 2
-		printk(KERN_ERR "audit.c:%d(:%d): __putname(%p)\n",
-		       __LINE__, context->serial, name);
+		printk(KERN_ERR "%s:%d(:%d): __putname(%p)\n",
+		       __FILE__, __LINE__, context->serial, name);
 		if (context->name_count) {
 			int i;
 			for (i = 0; i < context->name_count; i++)
@@ -793,10 +811,10 @@ void audit_putname(const char *name)
 	else {
 		++context->put_count;
 		if (context->put_count > context->name_count) {
-			printk(KERN_ERR "audit.c:%d(:%d): major=%d"
+			printk(KERN_ERR "%s:%d(:%d): major=%d"
 			       " in_syscall=%d putname(%p) name_count=%d"
 			       " put_count=%d\n",
-			       __LINE__,
+			       __FILE__, __LINE__,
 			       context->serial, context->major,
 			       context->in_syscall, name, context->name_count,
 			       context->put_count);
@@ -813,6 +831,8 @@ void audit_inode(const char *name, unsig
 	int idx;
 	struct audit_context *context = current->audit_context;
 
+	if (!context->in_syscall)
+		return;
 	if (context->name_count
 	    && context->names[context->name_count-1].name
 	    && context->names[context->name_count-1].name == name)


