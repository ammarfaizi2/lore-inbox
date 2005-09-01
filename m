Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030314AbVIATOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030314AbVIATOJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 15:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbVIATOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 15:14:09 -0400
Received: from sccrmhc14.comcast.net ([63.240.76.49]:58052 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1030314AbVIATOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 15:14:07 -0400
Subject: [PATCH] part 3 - Convert IPMI driver over to use refcounts
From: Corey Minyard <minyard@acm.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-03MyywW3RW2GwRQ2BVSA"
Date: Thu, 01 Sep 2005 14:14:02 -0500
Message-Id: <1125602042.4403.7.camel@i2.minyard.local>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3-5mdk 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-03MyywW3RW2GwRQ2BVSA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-03MyywW3RW2GwRQ2BVSA
Content-Disposition: attachment; filename=ipmi-use-refcounts.patch
Content-Type: text/x-patch; name=ipmi-use-refcounts.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit

The IPMI driver uses read/write locks to ensure that things
exist while they are in use.  This is bad from a number of
points of view.  This patch removes the rwlocks and uses
refcounts and a special synced list (the entries can be
refcounted and removal is blocked while an entry is in
use).

 drivers/char/ipmi/ipmi_msghandler.c | 1153 +++++++++++++++++++++---------------
 1 files changed, 692 insertions(+), 461 deletions(-)

Index: linux-2.6.13/drivers/char/ipmi/ipmi_msghandler.c
===================================================================
--- linux-2.6.13.orig/drivers/char/ipmi/ipmi_msghandler.c
+++ linux-2.6.13/drivers/char/ipmi/ipmi_msghandler.c
@@ -38,7 +38,6 @@
 #include <linux/sched.h>
 #include <linux/poll.h>
 #include <linux/spinlock.h>
-#include <linux/rwsem.h>
 #include <linux/slab.h>
 #include <linux/ipmi.h>
 #include <linux/ipmi_smi.h>
@@ -65,9 +64,210 @@ struct proc_dir_entry *proc_ipmi_root = 
    the max message timer.  This is in milliseconds. */
 #define MAX_MSG_TIMEOUT		60000
 
-struct ipmi_user
+
+/*
+ * The following is an implementation of a list that allows traversals
+ * and additions/deletions at the same time.  If a list item is in use
+ * while the deletion is occurring, then the deletion will block until
+ * the list item is no longer in use.
+ */
+#include <linux/completion.h>
+#include <asm/atomic.h>
+struct synced_list
+{
+	struct list_head head;
+	spinlock_t       lock;
+};
+
+struct synced_list_entry
+{
+	struct list_head  link;
+	atomic_t          usecount;
+
+	struct list_head  task_list;
+};
+
+/* Return values for match functions. */
+#define SYNCED_LIST_NO_MATCH		0
+#define SYNCED_LIST_MATCH_STOP		1
+#define SYNCED_LIST_MATCH_CONTINUE	-1
+
+/* Can be used for synced list find and clear operations for finding
+   and deleting a specific entry. */
+static int match_entry(struct synced_list_entry *e, void *match_data)
+{
+	if (e == match_data)
+		return SYNCED_LIST_MATCH_STOP;
+	else
+		return SYNCED_LIST_NO_MATCH;
+}
+
+struct synced_list_entry_task_q
 {
 	struct list_head link;
+	task_t           *process;
+};
+
+static inline void init_synced_list(struct synced_list *list)
+{
+	INIT_LIST_HEAD(&list->head);
+	spin_lock_init(&list->lock);
+}
+
+/* Called with the list head lock held */
+static void synced_list_wake(struct synced_list_entry *entry)
+{
+	struct synced_list_entry_task_q *e;
+
+	if (!atomic_dec_and_test(&entry->usecount))
+		/* Another thread is using the entry, too. */
+		return;
+
+	list_for_each_entry(e, &entry->task_list, link)
+		wake_up_process(e->process);
+}
+
+/* Can only be called on entries that have been "gotten". */
+#define synced_list_put_entry(pos, head) \
+	synced_list_before_exit(pos, head)
+/* Must be called with head->lock already held. */
+#define synced_list_put_entry_nolock(pos, head) \
+	synced_list_wake(pos);
+
+#define synced_list_for_each_entry(pos, l, entry, flags)		\
+	for ((spin_lock_irqsave(&(l)->lock, flags),			      \
+	      pos = container_of((l)->head.next, typeof(*(pos)),entry.link)); \
+	     (prefetch((pos)->entry.link.next),				      \
+	      &(pos)->entry.link != (&(l)->head)			      \
+	        ? (atomic_inc(&(pos)->entry.usecount),			      \
+                   spin_unlock_irqrestore(&(l)->lock, flags), 1)	      \
+	        : (spin_unlock_irqrestore(&(l)->lock, flags), 0));	      \
+	     (spin_lock_irqsave(&(l)->lock, flags),			      \
+	      synced_list_wake(&(pos)->entry),				      \
+              pos = container_of((pos)->entry.link.next, typeof(*(pos)),      \
+				 entry.link)))
+
+/* If you must exit a synced_list_for_each_entry loop abnormally (with
+   a break, return, goto) then you *must* call this first, with the
+   current entry.  Otherwise, the entry will be left locked. */
+static void synced_list_before_exit(struct synced_list_entry *entry,
+				    struct synced_list *head)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&head->lock, flags);
+	synced_list_wake(entry);
+	spin_unlock_irqrestore(&head->lock, flags);
+}
+
+/* Can only be called in a synced list loop.  This will preserve the
+   entry at least until synced_list_put_entry() is called. */
+#define synced_list_get_entry(pos) atomic_inc(&(pos)->usecount)
+
+/* Must be called with head->lock already held. */
+static void synced_list_add_nolock(struct synced_list *head,
+				   struct synced_list_entry *entry)
+{
+	atomic_set(&entry->usecount, 0);
+	INIT_LIST_HEAD(&entry->task_list);
+	list_add(&entry->link, &head->head);
+}
+
+static void synced_list_add(struct synced_list *head,
+			    struct synced_list_entry *entry)
+{
+	spin_lock_irq(&head->lock);
+	synced_list_add_nolock(head, entry);
+	spin_unlock_irq(&head->lock);
+}
+
+/*
+ * See the SYNCED_LIST_MATCH... defines for the return values from the
+ * "match" function.  If the free function is non-NULL, it will be
+ * called with the entry after it is removed from the list.  This must
+ * be called with the head->lock already held.
+ */
+static int synced_list_clear(struct synced_list *head,
+			     int (*match)(struct synced_list_entry *,
+					  void *),
+			     void (*free)(struct synced_list_entry *),
+			     void *match_data)
+{
+	struct synced_list_entry *ent, *ent2;
+	int                      rv = -ENODEV;
+	int                      mrv = SYNCED_LIST_MATCH_CONTINUE;
+
+	spin_lock_irq(&head->lock);
+ restart:
+	list_for_each_entry_safe(ent, ent2, &head->head, link) {
+		if (match) {
+			mrv = match(ent, match_data);
+			if (mrv == SYNCED_LIST_NO_MATCH)
+				continue;
+		}
+		if (atomic_read(&ent->usecount)) {
+			struct synced_list_entry_task_q e;
+			e.process = current;
+			list_add(&e.link, &ent->task_list);
+			__set_current_state(TASK_UNINTERRUPTIBLE);
+			spin_unlock_irq(&head->lock);
+			schedule();
+			spin_lock_irq(&head->lock);
+			list_del(&e.link);
+			goto restart;
+		}
+		list_del(&ent->link);
+		rv = 0;
+		if (free)
+			free(ent);
+		if (mrv == SYNCED_LIST_MATCH_STOP)
+			break;
+	}
+	spin_unlock_irq(&head->lock);
+	return rv;
+}
+
+/* Returns the entry "gotten".  Note that this will always stop on a
+   match, even if the return value is SYNCED_LIST_MATCH_CONTINUE. */
+static struct synced_list_entry *
+synced_list_find_nolock(struct synced_list *head,
+			int (*match)(struct synced_list_entry *,
+				     void *),
+			void *match_data)
+{
+	struct synced_list_entry *ent, *rv = NULL;
+
+	list_for_each_entry(ent, &head->head, link) {
+		if (match(ent, match_data)) {
+			rv = ent;
+			synced_list_get_entry(ent);
+			break;
+		}
+	}
+	return rv;
+}
+
+/* Like above, but claims the locks. */
+static struct synced_list_entry *
+synced_list_find(struct synced_list *head,
+		 int (*match)(struct synced_list_entry *,
+			      void *),
+		 void *match_data)
+{
+	struct synced_list_entry *rv = NULL;
+	unsigned long            flags;
+
+	spin_lock_irqsave(&head->lock, flags);
+	rv = synced_list_find_nolock(head, match, match_data);
+	spin_unlock_irqrestore(&head->lock, flags);
+	return rv;
+}
+
+/*
+ * The main "user" data structure.
+ */
+struct ipmi_user
+{
+	struct synced_list_entry link;
 
 	/* The upper layer that handles receive messages. */
 	struct ipmi_user_hndl *handler;
@@ -80,15 +280,58 @@ struct ipmi_user
 	int gets_events;
 };
 
+static int match_user(struct synced_list_entry *e, void *match_data)
+{
+	ipmi_user_t user = container_of(e, struct ipmi_user, link);
+	if (user == match_data)
+		return SYNCED_LIST_MATCH_STOP;
+	else
+		return SYNCED_LIST_NO_MATCH;
+}
+
+
 struct cmd_rcvr
 {
-	struct list_head link;
+	struct synced_list_entry link;
 
 	ipmi_user_t   user;
 	unsigned char netfn;
 	unsigned char cmd;
 };
 
+static int match_rcvr_user(struct synced_list_entry *e, void *match_data)
+{
+	struct cmd_rcvr *rcvr = container_of(e, struct cmd_rcvr, link);
+	if (rcvr->user == match_data)
+		/* We want to find all of the entries that match the user. */
+		return SYNCED_LIST_MATCH_CONTINUE;
+	else
+		return SYNCED_LIST_NO_MATCH;
+}
+
+static int match_rcvr(struct synced_list_entry *e, void *match_data)
+{
+	struct cmd_rcvr *rcvr = container_of(e, struct cmd_rcvr, link);
+	struct cmd_rcvr *cmp = match_data;
+	if ((cmp->netfn == rcvr->netfn) && (cmp->cmd == rcvr->cmd))
+		return SYNCED_LIST_MATCH_STOP;
+	else
+		return SYNCED_LIST_NO_MATCH;
+}
+
+static int match_rcvr_and_user(struct synced_list_entry *e, void *match_data)
+{
+	struct cmd_rcvr *rcvr = container_of(e, struct cmd_rcvr, link);
+	struct cmd_rcvr *cmp = match_data;
+	if ((cmp->netfn == rcvr->netfn) && (cmp->cmd == rcvr->cmd)
+	    && (cmp->user == rcvr->user))
+	{
+		return SYNCED_LIST_MATCH_STOP;
+	} else
+		return SYNCED_LIST_NO_MATCH;
+}
+
+
 struct seq_table
 {
 	unsigned int         inuse : 1;
@@ -150,13 +393,10 @@ struct ipmi_smi
 	/* What interface number are we? */
 	int intf_num;
 
-	/* The list of upper layers that are using me.  We read-lock
-           this when delivering messages to the upper layer to keep
-           the user from going away while we are processing the
-           message.  This means that you cannot add or delete a user
-           from the receive callback. */
-	rwlock_t                users_lock;
-	struct list_head        users;
+	struct kref refcount;
+
+	/* The list of upper layers that are using me. */
+	struct synced_list users;
 
 	/* Used for wake ups at startup. */
 	wait_queue_head_t waitq;
@@ -193,8 +433,7 @@ struct ipmi_smi
 
 	/* The list of command receivers that are registered for commands
 	   on this interface. */
-	rwlock_t	 cmd_rcvr_lock;
-	struct list_head cmd_rcvrs;
+	struct synced_list cmd_rcvrs;
 
 	/* Events that were queues because no one was there to receive
            them. */
@@ -296,16 +535,17 @@ struct ipmi_smi
 	unsigned int events;
 };
 
+/* Used to mark an interface entry that cannot be used but is not a
+ * free entry, either, primarily used at creation and deletion time so
+ * a slot doesn't get reused too quickly. */
+#define IPMI_INVALID_INTERFACE_ENTRY ((ipmi_smi_t) ((long) 1))
+#define IPMI_INVALID_INTERFACE(i) (((i) == NULL) \
+				   || (i == IPMI_INVALID_INTERFACE_ENTRY))
+
 #define MAX_IPMI_INTERFACES 4
 static ipmi_smi_t ipmi_interfaces[MAX_IPMI_INTERFACES];
 
-/* Used to keep interfaces from going away while operations are
-   operating on interfaces.  Grab read if you are not modifying the
-   interfaces, write if you are. */
-static DECLARE_RWSEM(interfaces_sem);
-
-/* Directly protects the ipmi_interfaces data structure.  This is
-   claimed in the timer interrupt. */
+/* Directly protects the ipmi_interfaces data structure. */
 static DEFINE_SPINLOCK(interfaces_lock);
 
 /* List of watchers that want to know when smi's are added and
@@ -313,20 +553,66 @@ static DEFINE_SPINLOCK(interfaces_lock);
 static struct list_head smi_watchers = LIST_HEAD_INIT(smi_watchers);
 static DECLARE_RWSEM(smi_watchers_sem);
 
-int ipmi_smi_watcher_register(struct ipmi_smi_watcher *watcher)
+
+static void free_recv_msg_list(struct list_head *q)
+{
+	struct ipmi_recv_msg *msg, *msg2;
+
+	list_for_each_entry_safe(msg, msg2, q, link) {
+		list_del(&msg->link);
+		ipmi_free_recv_msg(msg);
+	}
+}
+
+static void free_cmd_rcvr(struct synced_list_entry *e)
+{
+	struct cmd_rcvr *rcvr = container_of(e, struct cmd_rcvr, link);
+	kfree(rcvr);
+}
+
+static void clean_up_interface_data(ipmi_smi_t intf)
 {
 	int i;
 
-	down_read(&interfaces_sem);
+	free_recv_msg_list(&intf->waiting_msgs);
+	free_recv_msg_list(&intf->waiting_events);
+	synced_list_clear(&intf->cmd_rcvrs, NULL, free_cmd_rcvr, NULL);
+
+	for (i = 0; i < IPMI_IPMB_NUM_SEQ; i++) {
+		if ((intf->seq_table[i].inuse)
+		    && (intf->seq_table[i].recv_msg))
+		{
+			ipmi_free_recv_msg(intf->seq_table[i].recv_msg);
+		}
+	}
+}
+
+static void intf_free(struct kref *ref)
+{
+	ipmi_smi_t intf = container_of(ref, struct ipmi_smi, refcount);
+
+	clean_up_interface_data(intf);
+	kfree(intf);
+}
+
+int ipmi_smi_watcher_register(struct ipmi_smi_watcher *watcher)
+{
+	int           i;
+	unsigned long flags;
+
 	down_write(&smi_watchers_sem);
 	list_add(&(watcher->link), &smi_watchers);
+	up_write(&smi_watchers_sem);
+	spin_lock_irqsave(&interfaces_lock, flags);
 	for (i = 0; i < MAX_IPMI_INTERFACES; i++) {
-		if (ipmi_interfaces[i] != NULL) {
-			watcher->new_smi(i);
-		}
+		ipmi_smi_t intf = ipmi_interfaces[i];
+		if (IPMI_INVALID_INTERFACE(intf))
+			continue;
+		spin_unlock_irqrestore(&interfaces_lock, flags);
+		watcher->new_smi(i);
+		spin_lock_irqsave(&interfaces_lock, flags);
 	}
-	up_write(&smi_watchers_sem);
-	up_read(&interfaces_sem);
+	spin_unlock_irqrestore(&interfaces_lock, flags);
 	return 0;
 }
 
@@ -451,6 +737,8 @@ unsigned int ipmi_addr_length(int addr_t
 	return 0;
 }
 
+/* Note that if the message has a user, it must be called with the
+   user "gotten" by synced_list_get_entry. */
 static void deliver_response(struct ipmi_recv_msg *msg)
 {
 	if (! msg->user) {
@@ -471,8 +759,10 @@ static void deliver_response(struct ipmi
 		}
 		ipmi_free_recv_msg(msg);
 	} else {
-		msg->user->handler->ipmi_recv_hndl(msg,
-						   msg->user->handler_data);
+		ipmi_user_t user = msg->user;
+		user->handler->ipmi_recv_hndl(msg,
+					      user->handler_data);
+		synced_list_put_entry(&user->link, &user->intf->users);
 	}
 }
 
@@ -547,6 +837,11 @@ static int intf_find_seq(ipmi_smi_t     
 		    && (msg->msg.netfn == netfn)
 		    && (ipmi_addr_equal(addr, &(msg->addr))))
 		{
+			/* This is safe because removing the entry gets the
+			   seq lock, and we hold the seq_lock now, so the user
+			   in the recv_msg must be valid. */
+			if (msg->user)
+				synced_list_get_entry(&msg->user->link);
 			*recv_msg = msg;
 			intf->seq_table[seq].inuse = 0;
 			rv = 0;
@@ -607,6 +902,11 @@ static int intf_err_seq(ipmi_smi_t   int
 	{
 		struct seq_table *ent = &(intf->seq_table[seq]);
 
+		/* This is safe because removing the entry gets the
+		   seq lock, and we hold the seq_lock now, so the user
+		   in the recv_msg must be valid. */
+		if (ent->recv_msg->user)
+			synced_list_get_entry(&ent->recv_msg->user->link);
 		ent->inuse = 0;
 		msg = ent->recv_msg;
 		rv = 0;
@@ -662,14 +962,16 @@ int ipmi_create_user(unsigned int       
 	if (! new_user)
 		return -ENOMEM;
 
-	down_read(&interfaces_sem);
-	if ((if_num >= MAX_IPMI_INTERFACES) || ipmi_interfaces[if_num] == NULL)
-	{
-		rv = -EINVAL;
-		goto out_unlock;
+	spin_lock_irqsave(&interfaces_lock, flags);
+	intf = ipmi_interfaces[if_num];
+	if ((if_num >= MAX_IPMI_INTERFACES) || IPMI_INVALID_INTERFACE(intf)) {
+		spin_unlock_irqrestore(&interfaces_lock, flags);
+		return -EINVAL;
 	}
 
-	intf = ipmi_interfaces[if_num];
+	/* Note that each existing user holds a refcount to the interface. */
+	kref_get(&intf->refcount);
+	spin_unlock_irqrestore(&interfaces_lock, flags);
 
 	new_user->handler = handler;
 	new_user->handler_data = handler_data;
@@ -678,98 +980,61 @@ int ipmi_create_user(unsigned int       
 
 	if (!try_module_get(intf->handlers->owner)) {
 		rv = -ENODEV;
-		goto out_unlock;
+		goto out_err;
 	}
 
 	if (intf->handlers->inc_usecount) {
 		rv = intf->handlers->inc_usecount(intf->send_info);
 		if (rv) {
 			module_put(intf->handlers->owner);
-			goto out_unlock;
+			goto out_err;
 		}
 	}
 
-	write_lock_irqsave(&intf->users_lock, flags);
-	list_add_tail(&new_user->link, &intf->users);
-	write_unlock_irqrestore(&intf->users_lock, flags);
-
- out_unlock:	
-	if (rv) {
-		kfree(new_user);
-	} else {
-		*user = new_user;
-	}
+	synced_list_add(&intf->users, &new_user->link);
+	*user = new_user;
+	return 0;
 
-	up_read(&interfaces_sem);
+ out_err:
+	kfree(new_user);
+	kref_put(&intf->refcount, intf_free);
 	return rv;
 }
 
-static int ipmi_destroy_user_nolock(ipmi_user_t user)
+int ipmi_destroy_user(ipmi_user_t user)
 {
 	int              rv = -ENODEV;
-	ipmi_user_t      t_user;
-	struct cmd_rcvr  *rcvr, *rcvr2;
+	ipmi_smi_t       intf = user->intf;
 	int              i;
 	unsigned long    flags;
 
-	/* Find the user and delete them from the list. */
-	list_for_each_entry(t_user, &(user->intf->users), link) {
-		if (t_user == user) {
-			list_del(&t_user->link);
-			rv = 0;
-			break;
-		}
-	}
-
-	if (rv) {
-		goto out_unlock;
-	}
+	rv = synced_list_clear(&intf->users, match_entry, NULL, &user->link);
+	if (rv)
+		goto out;
 
-	/* Remove the user from the interfaces sequence table. */
-	spin_lock_irqsave(&(user->intf->seq_lock), flags);
+	/* Remove the user from the interface's sequence table. */
+	spin_lock_irqsave(&intf->seq_lock, flags);
 	for (i = 0; i < IPMI_IPMB_NUM_SEQ; i++) {
-		if (user->intf->seq_table[i].inuse
-		    && (user->intf->seq_table[i].recv_msg->user == user))
+		if (intf->seq_table[i].inuse
+		    && (intf->seq_table[i].recv_msg->user == user))
 		{
-			user->intf->seq_table[i].inuse = 0;
+			intf->seq_table[i].inuse = 0;
 		}
 	}
-	spin_unlock_irqrestore(&(user->intf->seq_lock), flags);
+	spin_unlock_irqrestore(&intf->seq_lock, flags);
 
 	/* Remove the user from the command receiver's table. */
-	write_lock_irqsave(&(user->intf->cmd_rcvr_lock), flags);
-	list_for_each_entry_safe(rcvr, rcvr2, &(user->intf->cmd_rcvrs), link) {
-		if (rcvr->user == user) {
-			list_del(&rcvr->link);
-			kfree(rcvr);
-		}
-	}
-	write_unlock_irqrestore(&(user->intf->cmd_rcvr_lock), flags);
+	synced_list_clear(&intf->cmd_rcvrs, match_rcvr_user, free_cmd_rcvr,
+			  user);
 
-	kfree(user);
+	module_put(intf->handlers->owner);
+	if (intf->handlers->dec_usecount)
+		intf->handlers->dec_usecount(intf->send_info);
 
- out_unlock:
-
-	return rv;
-}
-
-int ipmi_destroy_user(ipmi_user_t user)
-{
-	int           rv;
-	ipmi_smi_t    intf = user->intf;
-	unsigned long flags;
+	kref_put(&intf->refcount, intf_free);
+	kfree(user);
 
-	down_read(&interfaces_sem);
-	write_lock_irqsave(&intf->users_lock, flags);
-	rv = ipmi_destroy_user_nolock(user);
-	if (!rv) {
-		module_put(intf->handlers->owner);
-		if (intf->handlers->dec_usecount)
-			intf->handlers->dec_usecount(intf->send_info);
-	}
-		
-	write_unlock_irqrestore(&intf->users_lock, flags);
-	up_read(&interfaces_sem);
+ out:
 	return rv;
 }
 
@@ -823,24 +1088,25 @@ int ipmi_get_my_LUN(ipmi_user_t   user,
 
 int ipmi_set_gets_events(ipmi_user_t user, int val)
 {
-	unsigned long         flags;
-	struct ipmi_recv_msg  *msg, *msg2;
+	unsigned long        flags;
+	ipmi_smi_t           intf = user->intf;
+	struct ipmi_recv_msg *msg, *msg2;
 
-	read_lock(&(user->intf->users_lock));
-	spin_lock_irqsave(&(user->intf->events_lock), flags);
+	spin_lock_irqsave(&intf->events_lock, flags);
 	user->gets_events = val;
 
 	if (val) {
 		/* Deliver any queued events. */
-		list_for_each_entry_safe(msg, msg2, &(user->intf->waiting_events), link) {
+		list_for_each_entry_safe(msg, msg2, &intf->waiting_events, link) {
 			list_del(&msg->link);
+			/* The user better exist... */
+			synced_list_get_entry(&user->link);
 			msg->user = user;
 			deliver_response(msg);
 		}
 	}
 	
-	spin_unlock_irqrestore(&(user->intf->events_lock), flags);
-	read_unlock(&(user->intf->users_lock));
+	spin_unlock_irqrestore(&intf->events_lock, flags);
 
 	return 0;
 }
@@ -849,36 +1115,32 @@ int ipmi_register_for_cmd(ipmi_user_t   
 			  unsigned char netfn,
 			  unsigned char cmd)
 {
-	struct cmd_rcvr  *cmp;
-	unsigned long    flags;
-	struct cmd_rcvr  *rcvr;
-	int              rv = 0;
+	ipmi_smi_t               intf = user->intf;
+	struct synced_list_entry *entry;
+	struct cmd_rcvr          *rcvr;
+	int                      rv = 0;
 
 
 	rcvr = kmalloc(sizeof(*rcvr), GFP_KERNEL);
 	if (! rcvr)
 		return -ENOMEM;
+	rcvr->cmd = cmd;
+	rcvr->netfn = netfn;
+	rcvr->user = user;
 
-	read_lock(&(user->intf->users_lock));
-	write_lock_irqsave(&(user->intf->cmd_rcvr_lock), flags);
+	spin_lock_irq(&intf->cmd_rcvrs.lock);
 	/* Make sure the command/netfn is not already registered. */
-	list_for_each_entry(cmp, &(user->intf->cmd_rcvrs), link) {
-		if ((cmp->netfn == netfn) && (cmp->cmd == cmd)) {
-			rv = -EBUSY;
-			break;
-		}
-	}
-
-	if (! rv) {
-		rcvr->cmd = cmd;
-		rcvr->netfn = netfn;
-		rcvr->user = user;
-		list_add_tail(&(rcvr->link), &(user->intf->cmd_rcvrs));
+	entry = synced_list_find_nolock(&intf->cmd_rcvrs, match_rcvr, rcvr);
+	if (entry) {
+		synced_list_put_entry_nolock(entry, &intf->cmd_rcvrs);
+		rv = -EBUSY;
+		goto out_unlock;
 	}
 
-	write_unlock_irqrestore(&(user->intf->cmd_rcvr_lock), flags);
-	read_unlock(&(user->intf->users_lock));
+	synced_list_add_nolock(&intf->cmd_rcvrs, &rcvr->link);
 
+ out_unlock:
+	spin_unlock_irq(&intf->cmd_rcvrs.lock);
 	if (rv)
 		kfree(rcvr);
 
@@ -889,31 +1151,20 @@ int ipmi_unregister_for_cmd(ipmi_user_t 
 			    unsigned char netfn,
 			    unsigned char cmd)
 {
-	unsigned long    flags;
-	struct cmd_rcvr  *rcvr;
-	int              rv = -ENOENT;
-
-	read_lock(&(user->intf->users_lock));
-	write_lock_irqsave(&(user->intf->cmd_rcvr_lock), flags);
-	/* Make sure the command/netfn is not already registered. */
-	list_for_each_entry(rcvr, &(user->intf->cmd_rcvrs), link) {
-		if ((rcvr->netfn == netfn) && (rcvr->cmd == cmd)) {
-			rv = 0;
-			list_del(&rcvr->link);
-			kfree(rcvr);
-			break;
-		}
-	}
-	write_unlock_irqrestore(&(user->intf->cmd_rcvr_lock), flags);
-	read_unlock(&(user->intf->users_lock));
+	ipmi_smi_t      intf = user->intf;
+	struct cmd_rcvr rcvr;
 
-	return rv;
+	rcvr.cmd = cmd;
+	rcvr.netfn = netfn;
+	rcvr.user = user;
+	return synced_list_clear(&intf->cmd_rcvrs, match_rcvr_and_user,
+				 free_cmd_rcvr, &rcvr);
 }
 
 void ipmi_user_set_run_to_completion(ipmi_user_t user, int val)
 {
-	user->intf->handlers->set_run_to_completion(user->intf->send_info,
-						    val);
+	ipmi_smi_t intf = user->intf;
+	intf->handlers->set_run_to_completion(intf->send_info, val);
 }
 
 static unsigned char
@@ -1010,19 +1261,19 @@ static inline void format_lan_msg(struct
    supplied in certain circumstances (mainly at panic time).  If
    messages are supplied, they will be freed, even if an error
    occurs. */
-static inline int i_ipmi_request(ipmi_user_t          user,
-				 ipmi_smi_t           intf,
-				 struct ipmi_addr     *addr,
-				 long                 msgid,
-				 struct kernel_ipmi_msg *msg,
-				 void                 *user_msg_data,
-				 void                 *supplied_smi,
-				 struct ipmi_recv_msg *supplied_recv,
-				 int                  priority,
-				 unsigned char        source_address,
-				 unsigned char        source_lun,
-				 int                  retries,
-				 unsigned int         retry_time_ms)
+static int i_ipmi_request(ipmi_user_t          user,
+			  ipmi_smi_t           intf,
+			  struct ipmi_addr     *addr,
+			  long                 msgid,
+			  struct kernel_ipmi_msg *msg,
+			  void                 *user_msg_data,
+			  void                 *supplied_smi,
+			  struct ipmi_recv_msg *supplied_recv,
+			  int                  priority,
+			  unsigned char        source_address,
+			  unsigned char        source_lun,
+			  int                  retries,
+			  unsigned int         retry_time_ms)
 {
 	int                  rv = 0;
 	struct ipmi_smi_msg  *smi_msg;
@@ -1725,11 +1976,11 @@ int ipmi_register_smi(struct ipmi_smi_ha
 		      unsigned char            version_major,
 		      unsigned char            version_minor,
 		      unsigned char            slave_addr,
-		      ipmi_smi_t               *intf)
+		      ipmi_smi_t               *new_intf)
 {
 	int              i, j;
 	int              rv;
-	ipmi_smi_t       new_intf;
+	ipmi_smi_t       intf;
 	unsigned long    flags;
 
 
@@ -1745,189 +1996,141 @@ int ipmi_register_smi(struct ipmi_smi_ha
 			return -ENODEV;
 	}
 
-	new_intf = kmalloc(sizeof(*new_intf), GFP_KERNEL);
-	if (!new_intf)
+	intf = kmalloc(sizeof(*intf), GFP_KERNEL);
+	if (!intf)
 		return -ENOMEM;
-	memset(new_intf, 0, sizeof(*new_intf));
+	memset(intf, 0, sizeof(*intf));
+	intf->intf_num = -1;
+	kref_init(&intf->refcount);
+	intf->version_major = version_major;
+	intf->version_minor = version_minor;
+	for (j = 0; j < IPMI_MAX_CHANNELS; j++) {
+		intf->channels[j].address = IPMI_BMC_SLAVE_ADDR;
+		intf->channels[j].lun = 2;
+	}
+	if (slave_addr != 0)
+		intf->channels[0].address = slave_addr;
+	init_synced_list(&intf->users);
+	intf->handlers = handlers;
+	intf->send_info = send_info;
+	spin_lock_init(&intf->seq_lock);
+	for (j = 0; j < IPMI_IPMB_NUM_SEQ; j++) {
+		intf->seq_table[j].inuse = 0;
+		intf->seq_table[j].seqid = 0;
+	}
+	intf->curr_seq = 0;
+#ifdef CONFIG_PROC_FS
+	spin_lock_init(&intf->proc_entry_lock);
+#endif
+	spin_lock_init(&intf->waiting_msgs_lock);
+	INIT_LIST_HEAD(&intf->waiting_msgs);
+	spin_lock_init(&intf->events_lock);
+	INIT_LIST_HEAD(&intf->waiting_events);
+	intf->waiting_events_count = 0;
+	init_synced_list(&intf->cmd_rcvrs);
+	init_waitqueue_head(&intf->waitq);
 
-	new_intf->proc_dir = NULL;
+	spin_lock_init(&intf->counter_lock);
+	intf->proc_dir = NULL;
 
 	rv = -ENOMEM;
-
-	down_write(&interfaces_sem);
+	spin_lock_irqsave(&interfaces_lock, flags);
 	for (i = 0; i < MAX_IPMI_INTERFACES; i++) {
 		if (ipmi_interfaces[i] == NULL) {
-			new_intf->intf_num = i;
-			new_intf->version_major = version_major;
-			new_intf->version_minor = version_minor;
-			for (j = 0; j < IPMI_MAX_CHANNELS; j++) {
-				new_intf->channels[j].address
-					= IPMI_BMC_SLAVE_ADDR;
-				new_intf->channels[j].lun = 2;
-			}
-			if (slave_addr != 0)
-				new_intf->channels[0].address = slave_addr;
-			rwlock_init(&(new_intf->users_lock));
-			INIT_LIST_HEAD(&(new_intf->users));
-			new_intf->handlers = handlers;
-			new_intf->send_info = send_info;
-			spin_lock_init(&(new_intf->seq_lock));
-			for (j = 0; j < IPMI_IPMB_NUM_SEQ; j++) {
-				new_intf->seq_table[j].inuse = 0;
-				new_intf->seq_table[j].seqid = 0;
-			}
-			new_intf->curr_seq = 0;
-#ifdef CONFIG_PROC_FS
-			spin_lock_init(&(new_intf->proc_entry_lock));
-#endif
-			spin_lock_init(&(new_intf->waiting_msgs_lock));
-			INIT_LIST_HEAD(&(new_intf->waiting_msgs));
-			spin_lock_init(&(new_intf->events_lock));
-			INIT_LIST_HEAD(&(new_intf->waiting_events));
-			new_intf->waiting_events_count = 0;
-			rwlock_init(&(new_intf->cmd_rcvr_lock));
-			init_waitqueue_head(&new_intf->waitq);
-			INIT_LIST_HEAD(&(new_intf->cmd_rcvrs));
-
-			spin_lock_init(&(new_intf->counter_lock));
-
-			spin_lock_irqsave(&interfaces_lock, flags);
-			ipmi_interfaces[i] = new_intf;
-			spin_unlock_irqrestore(&interfaces_lock, flags);
-
+			intf->intf_num = i;
+			/* Reserve the entry till we are done. */
+			ipmi_interfaces[i] = IPMI_INVALID_INTERFACE_ENTRY;
 			rv = 0;
-			*intf = new_intf;
 			break;
 		}
 	}
+	spin_unlock_irqrestore(&interfaces_lock, flags);
+	if (rv)
+		goto out;
 
-	downgrade_write(&interfaces_sem);
-
-	if (rv == 0)
-		rv = add_proc_entries(*intf, i);
-
-	if (rv == 0) {
-		if ((version_major > 1)
-		    || ((version_major == 1) && (version_minor >= 5)))
-		{
-			/* Start scanning the channels to see what is
-			   available. */
-			(*intf)->null_user_handler = channel_handler;
-			(*intf)->curr_channel = 0;
-			rv = send_channel_info_cmd(*intf, 0);
-			if (rv)
-				goto out;
-
-			/* Wait for the channel info to be read. */
-			up_read(&interfaces_sem);
-			wait_event((*intf)->waitq,
-				   ((*intf)->curr_channel>=IPMI_MAX_CHANNELS));
-			down_read(&interfaces_sem);
-
-			if (ipmi_interfaces[i] != new_intf)
-				/* Well, it went away.  Just return. */
-				goto out;
-		} else {
-			/* Assume a single IPMB channel at zero. */
-			(*intf)->channels[0].medium = IPMI_CHANNEL_MEDIUM_IPMB;
-			(*intf)->channels[0].protocol
-				= IPMI_CHANNEL_PROTOCOL_IPMB;
-  		}
+	/* FIXME - this is an ugly kludge, this sets the intf for the
+	   caller before sending any messages with it. */
+	*new_intf = intf;
+
+	if ((version_major > 1)
+	    || ((version_major == 1) && (version_minor >= 5)))
+	{
+		/* Start scanning the channels to see what is
+		   available. */
+		intf->null_user_handler = channel_handler;
+		intf->curr_channel = 0;
+		rv = send_channel_info_cmd(intf, 0);
+		if (rv)
+			goto out;
 
-		/* Call all the watcher interfaces to tell
-		   them that a new interface is available. */
-		call_smi_watchers(i);
+		/* Wait for the channel info to be read. */
+		wait_event(intf->waitq,
+			   intf->curr_channel >= IPMI_MAX_CHANNELS);
+	} else {
+		/* Assume a single IPMB channel at zero. */
+		intf->channels[0].medium = IPMI_CHANNEL_MEDIUM_IPMB;
+		intf->channels[0].protocol = IPMI_CHANNEL_PROTOCOL_IPMB;
 	}
 
- out:
-	up_read(&interfaces_sem);
+	if (rv == 0)
+		rv = add_proc_entries(intf, i);
 
+ out:
 	if (rv) {
-		if (new_intf->proc_dir)
-			remove_proc_entries(new_intf);
-		kfree(new_intf);
+		if (intf->proc_dir)
+			remove_proc_entries(intf);
+		kref_put(&intf->refcount, intf_free);
+		if (i < MAX_IPMI_INTERFACES) {
+			spin_lock_irqsave(&interfaces_lock, flags);
+			ipmi_interfaces[i] = NULL;
+			spin_unlock_irqrestore(&interfaces_lock, flags);
+		}
+	} else {
+		spin_lock_irqsave(&interfaces_lock, flags);
+		ipmi_interfaces[i] = intf;
+		spin_unlock_irqrestore(&interfaces_lock, flags);
+		call_smi_watchers(i);
 	}
 
 	return rv;
 }
 
-static void free_recv_msg_list(struct list_head *q)
-{
-	struct ipmi_recv_msg *msg, *msg2;
-
-	list_for_each_entry_safe(msg, msg2, q, link) {
-		list_del(&msg->link);
-		ipmi_free_recv_msg(msg);
-	}
-}
-
-static void free_cmd_rcvr_list(struct list_head *q)
-{
-	struct cmd_rcvr  *rcvr, *rcvr2;
-
-	list_for_each_entry_safe(rcvr, rcvr2, q, link) {
-		list_del(&rcvr->link);
-		kfree(rcvr);
-	}
-}
-
-static void clean_up_interface_data(ipmi_smi_t intf)
-{
-	int i;
-
-	free_recv_msg_list(&(intf->waiting_msgs));
-	free_recv_msg_list(&(intf->waiting_events));
-	free_cmd_rcvr_list(&(intf->cmd_rcvrs));
-
-	for (i = 0; i < IPMI_IPMB_NUM_SEQ; i++) {
-		if ((intf->seq_table[i].inuse)
-		    && (intf->seq_table[i].recv_msg))
-		{
-			ipmi_free_recv_msg(intf->seq_table[i].recv_msg);
-		}	
-	}
-}
-
 int ipmi_unregister_smi(ipmi_smi_t intf)
 {
-	int                     rv = -ENODEV;
 	int                     i;
 	struct ipmi_smi_watcher *w;
 	unsigned long           flags;
 
-	down_write(&interfaces_sem);
-	if (list_empty(&(intf->users)))
-	{
-		for (i = 0; i < MAX_IPMI_INTERFACES; i++) {
-			if (ipmi_interfaces[i] == intf) {
-				remove_proc_entries(intf);
-				spin_lock_irqsave(&interfaces_lock, flags);
-				ipmi_interfaces[i] = NULL;
-				clean_up_interface_data(intf);
-				spin_unlock_irqrestore(&interfaces_lock,flags);
-				kfree(intf);
-				rv = 0;
-				goto out_call_watcher;
-			}
+	spin_lock_irqsave(&interfaces_lock, flags);
+	for (i = 0; i < MAX_IPMI_INTERFACES; i++) {
+		if (ipmi_interfaces[i] == intf) {
+			/* Set the interface number reserved until we
+			 * are done. */
+			ipmi_interfaces[i] = IPMI_INVALID_INTERFACE_ENTRY;
+			intf->intf_num = -1;
+			break;
 		}
-	} else {
-		rv = -EBUSY;
 	}
-	up_write(&interfaces_sem);
+	spin_unlock_irqrestore(&interfaces_lock,flags);
 
-	return rv;
+	if (i == MAX_IPMI_INTERFACES)
+		return -ENODEV;
 
- out_call_watcher:
-	downgrade_write(&interfaces_sem);
+	remove_proc_entries(intf);
 
 	/* Call all the watcher interfaces to tell them that
 	   an interface is gone. */
 	down_read(&smi_watchers_sem);
-	list_for_each_entry(w, &smi_watchers, link) {
+	list_for_each_entry(w, &smi_watchers, link)
 		w->smi_gone(i);
-	}
 	up_read(&smi_watchers_sem);
-	up_read(&interfaces_sem);
+
+	/* Allow the entry to be reused now. */
+	spin_lock_irqsave(&interfaces_lock, flags);
+	ipmi_interfaces[i] = NULL;
+	spin_unlock_irqrestore(&interfaces_lock,flags);
+
+	kref_put(&intf->refcount, intf_free);
 	return 0;
 }
 
@@ -1998,14 +2201,16 @@ static int handle_ipmb_get_msg_rsp(ipmi_
 static int handle_ipmb_get_msg_cmd(ipmi_smi_t          intf,
 				   struct ipmi_smi_msg *msg)
 {
-	struct cmd_rcvr       *rcvr;
-	int                   rv = 0;
-	unsigned char         netfn;
-	unsigned char         cmd;
-	ipmi_user_t           user = NULL;
-	struct ipmi_ipmb_addr *ipmb_addr;
-	struct ipmi_recv_msg  *recv_msg;
-	unsigned long         flags;
+	struct cmd_rcvr          *rcvr;
+	struct cmd_rcvr          crcvr;
+	int                      rv = 0;
+	unsigned char            netfn;
+	unsigned char            cmd;
+	ipmi_user_t              user = NULL;
+	struct ipmi_ipmb_addr    *ipmb_addr;
+	struct ipmi_recv_msg     *recv_msg;
+	unsigned long            flags;
+	struct synced_list_entry *entry;
 
 	if (msg->rsp_size < 10) {
 		/* Message not big enough, just ignore it. */
@@ -2023,16 +2228,23 @@ static int handle_ipmb_get_msg_cmd(ipmi_
 	netfn = msg->rsp[4] >> 2;
 	cmd = msg->rsp[8];
 
-	read_lock(&(intf->cmd_rcvr_lock));
-	
-	/* Find the command/netfn. */
-	list_for_each_entry(rcvr, &(intf->cmd_rcvrs), link) {
-		if ((rcvr->netfn == netfn) && (rcvr->cmd == cmd)) {
-			user = rcvr->user;
-			break;
-		}
-	}
-	read_unlock(&(intf->cmd_rcvr_lock));
+	spin_lock_irqsave(&intf->cmd_rcvrs.lock, flags);
+	crcvr.cmd = cmd;
+	crcvr.netfn = netfn;
+	entry = synced_list_find_nolock(&intf->cmd_rcvrs, match_rcvr,
+					&crcvr);
+	if (entry) {
+		rcvr = container_of(entry, struct cmd_rcvr, link);
+		user = rcvr->user;
+		synced_list_put_entry_nolock(entry, &intf->cmd_rcvrs);
+	} else
+		user = NULL;
+
+	if (user)
+		/* Safe because the user delete must delete the user
+		   from this table and grab this lock. */
+		synced_list_get_entry(&user->link);
+	spin_unlock_irqrestore(&intf->cmd_rcvrs.lock, flags);
 
 	if (user == NULL) {
 		/* We didn't find a user, deliver an error response. */
@@ -2104,6 +2316,7 @@ static int handle_ipmb_get_msg_cmd(ipmi_
 			       msg->rsp_size - 10);
 			deliver_response(recv_msg);
 		}
+		synced_list_put_entry(&user->link, &intf->users);
 	}
 
 	return rv;
@@ -2179,14 +2392,16 @@ static int handle_lan_get_msg_rsp(ipmi_s
 static int handle_lan_get_msg_cmd(ipmi_smi_t          intf,
 				  struct ipmi_smi_msg *msg)
 {
-	struct cmd_rcvr       *rcvr;
-	int                   rv = 0;
-	unsigned char         netfn;
-	unsigned char         cmd;
-	ipmi_user_t           user = NULL;
-	struct ipmi_lan_addr  *lan_addr;
-	struct ipmi_recv_msg  *recv_msg;
-	unsigned long         flags;
+	struct cmd_rcvr          *rcvr;
+	struct cmd_rcvr          crcvr;
+	int                      rv = 0;
+	unsigned char            netfn;
+	unsigned char            cmd;
+	ipmi_user_t              user = NULL;
+	struct ipmi_lan_addr     *lan_addr;
+	struct ipmi_recv_msg     *recv_msg;
+	unsigned long            flags;
+	struct synced_list_entry *entry;
 
 	if (msg->rsp_size < 12) {
 		/* Message not big enough, just ignore it. */
@@ -2204,19 +2419,25 @@ static int handle_lan_get_msg_cmd(ipmi_s
 	netfn = msg->rsp[6] >> 2;
 	cmd = msg->rsp[10];
 
-	read_lock(&(intf->cmd_rcvr_lock));
-
-	/* Find the command/netfn. */
-	list_for_each_entry(rcvr, &(intf->cmd_rcvrs), link) {
-		if ((rcvr->netfn == netfn) && (rcvr->cmd == cmd)) {
-			user = rcvr->user;
-			break;
-		}
-	}
-	read_unlock(&(intf->cmd_rcvr_lock));
+	spin_lock_irqsave(&intf->cmd_rcvrs.lock, flags);
+	crcvr.cmd = cmd;
+	crcvr.netfn = netfn;
+	entry = synced_list_find_nolock(&intf->cmd_rcvrs, match_rcvr,
+					&crcvr);
+	if (entry) {
+		rcvr = container_of(entry, struct cmd_rcvr, link);
+		user = rcvr->user;
+		synced_list_put_entry_nolock(entry, &intf->cmd_rcvrs);
+	} else
+		user = NULL;
+	if (user)
+		/* Safe because the user delete must delete the user
+		   from this table and grab this lock. */
+		synced_list_get_entry(&user->link);
+	spin_unlock_irqrestore(&intf->cmd_rcvrs.lock, flags);
 
 	if (user == NULL) {
-		/* We didn't find a user, deliver an error response. */
+		/* We didn't find a user, just give up. */
 		spin_lock_irqsave(&intf->counter_lock, flags);
 		intf->unhandled_commands++;
 		spin_unlock_irqrestore(&intf->counter_lock, flags);
@@ -2263,6 +2484,7 @@ static int handle_lan_get_msg_cmd(ipmi_s
 			       msg->rsp_size - 12);
 			deliver_response(recv_msg);
 		}
+		synced_list_put_entry(&user->link, &intf->users);
 	}
 
 	return rv;
@@ -2286,8 +2508,6 @@ static void copy_event_into_recv_msg(str
 	recv_msg->msg.data_len = msg->rsp_size - 3;
 }
 
-/* This will be called with the intf->users_lock read-locked, so no need
-   to do that here. */
 static int handle_read_event_rsp(ipmi_smi_t          intf,
 				 struct ipmi_smi_msg *msg)
 {
@@ -2313,7 +2533,7 @@ static int handle_read_event_rsp(ipmi_sm
 
 	INIT_LIST_HEAD(&msgs);
 
-	spin_lock_irqsave(&(intf->events_lock), flags);
+	spin_lock_irqsave(&intf->events_lock, flags);
 
 	spin_lock(&intf->counter_lock);
 	intf->events++;
@@ -2321,13 +2541,16 @@ static int handle_read_event_rsp(ipmi_sm
 
 	/* Allocate and fill in one message for every user that is getting
 	   events. */
-	list_for_each_entry(user, &(intf->users), link) {
+	synced_list_for_each_entry(user, &intf->users, link, flags) {
 		if (! user->gets_events)
 			continue;
 
 		recv_msg = ipmi_alloc_recv_msg();
 		if (! recv_msg) {
+			synced_list_before_exit(&user->link, &intf->users);
 			list_for_each_entry_safe(recv_msg, recv_msg2, &msgs, link) {
+				synced_list_put_entry(&recv_msg->user->link,
+						      &intf->users);
 				list_del(&recv_msg->link);
 				ipmi_free_recv_msg(recv_msg);
 			}
@@ -2342,6 +2565,7 @@ static int handle_read_event_rsp(ipmi_sm
 
 		copy_event_into_recv_msg(recv_msg, msg);
 		recv_msg->user = user;
+		synced_list_get_entry(&user->link);
 		list_add_tail(&(recv_msg->link), &msgs);
 	}
 
@@ -2381,10 +2605,9 @@ static int handle_read_event_rsp(ipmi_sm
 static int handle_bmc_rsp(ipmi_smi_t          intf,
 			  struct ipmi_smi_msg *msg)
 {
-	struct ipmi_recv_msg *recv_msg;
-	int                  found = 0;
-	struct ipmi_user     *user;
-	unsigned long        flags;
+	struct ipmi_recv_msg     *recv_msg;
+	struct synced_list_entry *entry;
+	unsigned long            flags;
 
 	recv_msg = (struct ipmi_recv_msg *) msg->user_data;
 	if (recv_msg == NULL)
@@ -2397,15 +2620,8 @@ static int handle_bmc_rsp(ipmi_smi_t    
 	}
 
 	/* Make sure the user still exists. */
-	list_for_each_entry(user, &(intf->users), link) {
-		if (user == recv_msg->user) {
-			/* Found it, so we can deliver it */
-			found = 1;
-			break;
-		}
-	}
-
-	if ((! found) && recv_msg->user) {
+	entry = synced_list_find(&intf->users, match_user, recv_msg->user);
+	if ((! entry) && recv_msg->user) {
 		/* The user for the message went away, so give up. */
 		spin_lock_irqsave(&intf->counter_lock, flags);
 		intf->unhandled_local_responses++;
@@ -2486,7 +2702,8 @@ static int handle_new_recv_msg(ipmi_smi_
 	{
 		/* It's a response to a response we sent.  For this we
 		   deliver a send message response to the user. */
-		struct ipmi_recv_msg *recv_msg = msg->user_data;
+		struct ipmi_recv_msg     *recv_msg = msg->user_data;
+		struct synced_list_entry *entry;
 
 		requeue = 0;
 		if (msg->rsp_size < 2)
@@ -2498,13 +2715,20 @@ static int handle_new_recv_msg(ipmi_smi_
 			/* Invalid channel number */
 			goto out;
 
-		if (recv_msg) {
-			recv_msg->recv_type = IPMI_RESPONSE_RESPONSE_TYPE;
-			recv_msg->msg.data = recv_msg->msg_data;
-			recv_msg->msg.data_len = 1;
-			recv_msg->msg_data[0] = msg->rsp[2];
-			deliver_response(recv_msg);
-		}
+		if (!recv_msg)
+			goto out;
+
+		/* Make sure the user still exists. */
+		entry = synced_list_find(&intf->users, match_user,
+					 recv_msg->user);
+		if (! entry)
+			goto out;
+
+		recv_msg->recv_type = IPMI_RESPONSE_RESPONSE_TYPE;
+		recv_msg->msg.data = recv_msg->msg_data;
+		recv_msg->msg.data_len = 1;
+		recv_msg->msg_data[0] = msg->rsp[2];
+		deliver_response(recv_msg);
 	} else if ((msg->rsp[0] == ((IPMI_NETFN_APP_REQUEST|1) << 2))
 		   && (msg->rsp[1] == IPMI_GET_MSG_CMD))
 	{
@@ -2570,14 +2794,11 @@ void ipmi_smi_msg_received(ipmi_smi_t   
 	int           rv;
 
 
-	/* Lock the user lock so the user can't go away while we are
-	   working on it. */
-	read_lock(&(intf->users_lock));
-
 	if ((msg->data_size >= 2)
 	    && (msg->data[0] == (IPMI_NETFN_APP_REQUEST << 2))
 	    && (msg->data[1] == IPMI_SEND_MSG_CMD)
-	    && (msg->user_data == NULL)) {
+	    && (msg->user_data == NULL))
+	{
 		/* This is the local response to a command send, start
                    the timer for these.  The user_data will not be
                    NULL if this is a response send, and we will let
@@ -2612,16 +2833,16 @@ void ipmi_smi_msg_received(ipmi_smi_t   
 		}
 
 		ipmi_free_smi_msg(msg);
-		goto out_unlock;
+		goto out;
 	}
 
 	/* To preserve message order, if the list is not empty, we
            tack this message onto the end of the list. */
-	spin_lock_irqsave(&(intf->waiting_msgs_lock), flags);
-	if (!list_empty(&(intf->waiting_msgs))) {
-		list_add_tail(&(msg->link), &(intf->waiting_msgs));
-		spin_unlock(&(intf->waiting_msgs_lock));
-		goto out_unlock;
+	spin_lock_irqsave(&intf->waiting_msgs_lock, flags);
+	if (!list_empty(&intf->waiting_msgs)) {
+		list_add_tail(&msg->link, &intf->waiting_msgs);
+		spin_unlock(&intf->waiting_msgs_lock);
+		goto out;
 	}
 	spin_unlock_irqrestore(&(intf->waiting_msgs_lock), flags);
 		
@@ -2629,29 +2850,28 @@ void ipmi_smi_msg_received(ipmi_smi_t   
 	if (rv > 0) {
 		/* Could not handle the message now, just add it to a
                    list to handle later. */
-		spin_lock(&(intf->waiting_msgs_lock));
-		list_add_tail(&(msg->link), &(intf->waiting_msgs));
-		spin_unlock(&(intf->waiting_msgs_lock));
+		spin_lock(&intf->waiting_msgs_lock);
+		list_add_tail(&msg->link, &intf->waiting_msgs);
+		spin_unlock(&intf->waiting_msgs_lock);
 	} else if (rv == 0) {
 		ipmi_free_smi_msg(msg);
 	}
 
- out_unlock:
-	read_unlock(&(intf->users_lock));
+ out:
+	return;
 }
 
 void ipmi_smi_watchdog_pretimeout(ipmi_smi_t intf)
 {
-	ipmi_user_t user;
+	unsigned long flags;
+	ipmi_user_t   user;
 
-	read_lock(&(intf->users_lock));
-	list_for_each_entry(user, &(intf->users), link) {
+	synced_list_for_each_entry(user, &intf->users, link, flags) {
 		if (! user->handler->ipmi_watchdog_pretimeout)
 			continue;
 
 		user->handler->ipmi_watchdog_pretimeout(user->handler_data);
 	}
-	read_unlock(&(intf->users_lock));
 }
 
 static void
@@ -2691,8 +2911,70 @@ smi_from_recv_msg(ipmi_smi_t intf, struc
 	return smi_msg;
 }
 
-static void
-ipmi_timeout_handler(long timeout_period)
+static void check_msg_timeout(ipmi_smi_t intf, struct seq_table *ent,
+			      struct list_head *timeouts, long timeout_period,
+			      int slot, unsigned long *flags)
+{
+	struct ipmi_recv_msg *msg;
+
+	if (!ent->inuse)
+		return;
+
+	ent->timeout -= timeout_period;
+	if (ent->timeout > 0)
+		return;
+
+	if (ent->retries_left == 0) {
+		/* The message has used all its retries. */
+		ent->inuse = 0;
+		msg = ent->recv_msg;
+		/* This is safe because removing the entry gets the
+		   seq lock, and we hold the seq_lock now, so the user
+		   in the recv_msg must be valid. */
+		if (msg->user)
+			synced_list_get_entry(&msg->user->link);
+		list_add_tail(&msg->link, timeouts);
+		spin_lock(&intf->counter_lock);
+		if (ent->broadcast)
+			intf->timed_out_ipmb_broadcasts++;
+		else if (ent->recv_msg->addr.addr_type == IPMI_LAN_ADDR_TYPE)
+			intf->timed_out_lan_commands++;
+		else
+			intf->timed_out_ipmb_commands++;
+		spin_unlock(&intf->counter_lock);
+	} else {
+		struct ipmi_smi_msg *smi_msg;
+		/* More retries, send again. */
+
+		/* Start with the max timer, set to normal
+		   timer after the message is sent. */
+		ent->timeout = MAX_MSG_TIMEOUT;
+		ent->retries_left--;
+		spin_lock(&intf->counter_lock);
+		if (ent->recv_msg->addr.addr_type == IPMI_LAN_ADDR_TYPE)
+			intf->retransmitted_lan_commands++;
+		else
+			intf->retransmitted_ipmb_commands++;
+		spin_unlock(&intf->counter_lock);
+
+		smi_msg = smi_from_recv_msg(intf, ent->recv_msg, slot,
+					    ent->seqid);
+		if (! smi_msg)
+			return;
+
+		spin_unlock_irqrestore(&intf->seq_lock, *flags);
+		/* Send the new message.  We send with a zero
+		 * priority.  It timed out, I doubt time is
+		 * that critical now, and high priority
+		 * messages are really only for messages to the
+		 * local MC, which don't get resent. */
+		intf->handlers->sender(intf->send_info,
+				       smi_msg, 0);
+		spin_lock_irqsave(&intf->seq_lock, *flags);
+	}
+}
+
+static void ipmi_timeout_handler(long timeout_period)
 {
 	ipmi_smi_t           intf;
 	struct list_head     timeouts;
@@ -2706,14 +2988,14 @@ ipmi_timeout_handler(long timeout_period
 	spin_lock(&interfaces_lock);
 	for (i = 0; i < MAX_IPMI_INTERFACES; i++) {
 		intf = ipmi_interfaces[i];
-		if (intf == NULL)
+		if (IPMI_INVALID_INTERFACE(intf))
 			continue;
-
-		read_lock(&(intf->users_lock));
+		kref_get(&intf->refcount);
+		spin_unlock(&interfaces_lock);
 
 		/* See if any waiting messages need to be processed. */
-		spin_lock_irqsave(&(intf->waiting_msgs_lock), flags);
-		list_for_each_entry_safe(smi_msg, smi_msg2, &(intf->waiting_msgs), link) {
+		spin_lock_irqsave(&intf->waiting_msgs_lock, flags);
+		list_for_each_entry_safe(smi_msg, smi_msg2, &intf->waiting_msgs, link) {
 			if (! handle_new_recv_msg(intf, smi_msg)) {
 				list_del(&smi_msg->link);
 				ipmi_free_smi_msg(smi_msg);
@@ -2723,73 +3005,23 @@ ipmi_timeout_handler(long timeout_period
 				break;
 			}
 		}
-		spin_unlock_irqrestore(&(intf->waiting_msgs_lock), flags);
+		spin_unlock_irqrestore(&intf->waiting_msgs_lock, flags);
 
 		/* Go through the seq table and find any messages that
 		   have timed out, putting them in the timeouts
 		   list. */
-		spin_lock_irqsave(&(intf->seq_lock), flags);
-		for (j = 0; j < IPMI_IPMB_NUM_SEQ; j++) {
-			struct seq_table *ent = &(intf->seq_table[j]);
-			if (!ent->inuse)
-				continue;
-
-			ent->timeout -= timeout_period;
-			if (ent->timeout > 0)
-				continue;
-
-			if (ent->retries_left == 0) {
-				/* The message has used all its retries. */
-				ent->inuse = 0;
-				msg = ent->recv_msg;
-				list_add_tail(&(msg->link), &timeouts);
-				spin_lock(&intf->counter_lock);
-				if (ent->broadcast)
-					intf->timed_out_ipmb_broadcasts++;
-				else if (ent->recv_msg->addr.addr_type
-					 == IPMI_LAN_ADDR_TYPE)
-					intf->timed_out_lan_commands++;
-				else
-					intf->timed_out_ipmb_commands++;
-				spin_unlock(&intf->counter_lock);
-			} else {
-				struct ipmi_smi_msg *smi_msg;
-				/* More retries, send again. */
+		spin_lock_irqsave(&intf->seq_lock, flags);
+		for (j = 0; j < IPMI_IPMB_NUM_SEQ; j++)
+			check_msg_timeout(intf, &(intf->seq_table[j]),
+					  &timeouts, timeout_period, j,
+					  &flags);
+		spin_unlock_irqrestore(&intf->seq_lock, flags);
 
-				/* Start with the max timer, set to normal
-				   timer after the message is sent. */
-				ent->timeout = MAX_MSG_TIMEOUT;
-				ent->retries_left--;
-				spin_lock(&intf->counter_lock);
-				if (ent->recv_msg->addr.addr_type
-				    == IPMI_LAN_ADDR_TYPE)
-					intf->retransmitted_lan_commands++;
-				else
-					intf->retransmitted_ipmb_commands++;
-				spin_unlock(&intf->counter_lock);
-				smi_msg = smi_from_recv_msg(intf,
-						ent->recv_msg, j, ent->seqid);
-				if (! smi_msg)
-					continue;
-
-				spin_unlock_irqrestore(&(intf->seq_lock),flags);
-				/* Send the new message.  We send with a zero
-				 * priority.  It timed out, I doubt time is
-				 * that critical now, and high priority
-				 * messages are really only for messages to the
-				 * local MC, which don't get resent. */
-				intf->handlers->sender(intf->send_info,
-							smi_msg, 0);
-				spin_lock_irqsave(&(intf->seq_lock), flags);
-			}
-		}
-		spin_unlock_irqrestore(&(intf->seq_lock), flags);
-
-		list_for_each_entry_safe(msg, msg2, &timeouts, link) {
+		list_for_each_entry_safe(msg, msg2, &timeouts, link)
 			handle_msg_timeout(msg);
-		}
 
-		read_unlock(&(intf->users_lock));
+		kref_put(&intf->refcount, intf_free);
+		spin_lock(&interfaces_lock);
 	}
 	spin_unlock(&interfaces_lock);
 }
@@ -2802,7 +3034,7 @@ static void ipmi_request_event(void)
 	spin_lock(&interfaces_lock);
 	for (i = 0; i < MAX_IPMI_INTERFACES; i++) {
 		intf = ipmi_interfaces[i];
-		if (intf == NULL)
+		if (IPMI_INVALID_INTERFACE(intf))
 			continue;
 
 		intf->handlers->request_events(intf->send_info);
@@ -2964,7 +3196,7 @@ static void send_panic_events(char *str)
 	/* For every registered interface, send the event. */
 	for (i = 0; i < MAX_IPMI_INTERFACES; i++) {
 		intf = ipmi_interfaces[i];
-		if (intf == NULL)
+		if (IPMI_INVALID_INTERFACE(intf))
 			continue;
 
 		/* Send the event announcing the panic. */
@@ -2995,7 +3227,7 @@ static void send_panic_events(char *str)
 		int                   j;
 
 		intf = ipmi_interfaces[i];
-		if (intf == NULL)
+		if (IPMI_INVALID_INTERFACE(intf))
 			continue;
 
 		/* First job here is to figure out where to send the
@@ -3131,7 +3363,7 @@ static int panic_event(struct notifier_b
 	/* For every registered interface, set it to run to completion. */
 	for (i = 0; i < MAX_IPMI_INTERFACES; i++) {
 		intf = ipmi_interfaces[i];
-		if (intf == NULL)
+		if (IPMI_INVALID_INTERFACE(intf))
 			continue;
 
 		intf->handlers->set_run_to_completion(intf->send_info, 1);
@@ -3160,9 +3392,8 @@ static int ipmi_init_msghandler(void)
 	printk(KERN_INFO "ipmi message handler version "
 	       IPMI_DRIVER_VERSION "\n");
 
-	for (i = 0; i < MAX_IPMI_INTERFACES; i++) {
+	for (i = 0; i < MAX_IPMI_INTERFACES; i++)
 		ipmi_interfaces[i] = NULL;
-	}
 
 #ifdef CONFIG_PROC_FS
 	proc_ipmi_root = proc_mkdir("ipmi", NULL);

--=-03MyywW3RW2GwRQ2BVSA--

