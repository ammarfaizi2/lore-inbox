Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162794AbWLBE4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162794AbWLBE4L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 23:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162796AbWLBE4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 23:56:11 -0500
Received: from mta10.adelphia.net ([68.168.78.202]:10202 "EHLO
	mta10.adelphia.net") by vger.kernel.org with ESMTP id S1162794AbWLBE4J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 23:56:09 -0500
Date: Fri, 1 Dec 2006 22:56:06 -0600
From: Corey Minyard <minyard@acm.org>
To: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Cc: OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>
Subject: [PATCH 4/12] IPMI: Allow hot system interface remove
Message-ID: <20061202045606.GA31143@localdomain>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This modifies the IPMI driver so that a lower-level interface can be
dynamically removed while in use so it can support hot-removal of
hardware.

It also adds the ability to specify and dynamically change the
IPMI interface the watchdog timer and the poweroff code use.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.19-rc6/drivers/char/ipmi/ipmi_msghandler.c
===================================================================
--- linux-2.6.19-rc6.orig/drivers/char/ipmi/ipmi_msghandler.c
+++ linux-2.6.19-rc6/drivers/char/ipmi/ipmi_msghandler.c
@@ -200,6 +200,10 @@ struct ipmi_smi
 	 * protects this. */
 	struct list_head users;
 
+	/* Information to supply to users. */
+	unsigned char ipmi_version_major;
+	unsigned char ipmi_version_minor;
+
 	/* Used for wake ups at startup. */
 	wait_queue_head_t waitq;
 
@@ -207,7 +211,10 @@ struct ipmi_smi
 	char *my_dev_name;
 	char *sysfs_name;
 
-	/* This is the lower-layer's sender routine. */
+	/* This is the lower-layer's sender routine.  Note that you
+	 * must either be holding the ipmi_interfaces_mutex or be in
+	 * an umpreemptible region to use this.  You must fetch the
+	 * value into a local variable and make sure it is not NULL. */
 	struct ipmi_smi_handlers *handlers;
 	void                     *send_info;
 
@@ -246,6 +253,7 @@ struct ipmi_smi
 	spinlock_t       events_lock; /* For dealing with event stuff. */
 	struct list_head waiting_events;
 	unsigned int     waiting_events_count; /* How many events in queue? */
+	int              delivering_events;
 
 	/* The event receiver for my BMC, only really used at panic
 	   shutdown as a place to store this. */
@@ -357,7 +365,7 @@ static DEFINE_MUTEX(ipmi_interfaces_mute
 /* List of watchers that want to know when smi's are added and
    deleted. */
 static struct list_head smi_watchers = LIST_HEAD_INIT(smi_watchers);
-static DECLARE_RWSEM(smi_watchers_sem);
+static DEFINE_MUTEX(smi_watchers_mutex);
 
 
 static void free_recv_msg_list(struct list_head *q)
@@ -418,8 +426,9 @@ static void intf_free(struct kref *ref)
 }
 
 struct watcher_entry {
+	int              intf_num;
+	ipmi_smi_t       intf;
 	struct list_head link;
-	int intf_num;
 };
 
 int ipmi_smi_watcher_register(struct ipmi_smi_watcher *watcher)
@@ -428,36 +437,45 @@ int ipmi_smi_watcher_register(struct ipm
 	struct list_head to_deliver = LIST_HEAD_INIT(to_deliver);
 	struct watcher_entry *e, *e2;
 
+	mutex_lock(&smi_watchers_mutex);
+
 	mutex_lock(&ipmi_interfaces_mutex);
 
+	/* Build a list of things to deliver. */
 	list_for_each_entry_rcu(intf, &ipmi_interfaces, link) {
 		if (intf->intf_num == -1)
 			continue;
 		e = kmalloc(sizeof(*e), GFP_KERNEL);
 		if (!e)
 			goto out_err;
+		kref_get(&intf->refcount);
+		e->intf = intf;
 		e->intf_num = intf->intf_num;
 		list_add_tail(&e->link, &to_deliver);
 	}
 
-	down_write(&smi_watchers_sem);
-	list_add(&(watcher->link), &smi_watchers);
-	up_write(&smi_watchers_sem);
+	/* We will succeed, so add it to the list. */
+	list_add(&watcher->link, &smi_watchers);
 
 	mutex_unlock(&ipmi_interfaces_mutex);
 
 	list_for_each_entry_safe(e, e2, &to_deliver, link) {
 		list_del(&e->link);
-		watcher->new_smi(e->intf_num, intf->si_dev);
+		watcher->new_smi(e->intf_num, e->intf->si_dev);
+		kref_put(&e->intf->refcount, intf_free);
 		kfree(e);
 	}
 
+	mutex_unlock(&smi_watchers_mutex);
 
 	return 0;
 
  out_err:
+	mutex_unlock(&ipmi_interfaces_mutex);
+	mutex_unlock(&smi_watchers_mutex);
 	list_for_each_entry_safe(e, e2, &to_deliver, link) {
 		list_del(&e->link);
+		kref_put(&e->intf->refcount, intf_free);
 		kfree(e);
 	}
 	return -ENOMEM;
@@ -465,25 +483,26 @@ int ipmi_smi_watcher_register(struct ipm
 
 int ipmi_smi_watcher_unregister(struct ipmi_smi_watcher *watcher)
 {
-	down_write(&smi_watchers_sem);
+	mutex_lock(&smi_watchers_mutex);
 	list_del(&(watcher->link));
-	up_write(&smi_watchers_sem);
+	mutex_unlock(&smi_watchers_mutex);
 	return 0;
 }
 
+/*
+ * Must be called with smi_watchers_mutex held.
+ */
 static void
 call_smi_watchers(int i, struct device *dev)
 {
 	struct ipmi_smi_watcher *w;
 
-	down_read(&smi_watchers_sem);
 	list_for_each_entry(w, &smi_watchers, link) {
 		if (try_module_get(w->owner)) {
 			w->new_smi(i, dev);
 			module_put(w->owner);
 		}
 	}
-	up_read(&smi_watchers_sem);
 }
 
 static int
@@ -609,6 +628,17 @@ static void deliver_response(struct ipmi
 	}
 }
 
+static void
+deliver_err_response(struct ipmi_recv_msg *msg, int err)
+{
+	msg->recv_type = IPMI_RESPONSE_RECV_TYPE;
+	msg->msg_data[0] = err;
+	msg->msg.netfn |= 1; /* Convert to a response. */
+	msg->msg.data_len = 1;
+	msg->msg.data = msg->msg_data;
+	deliver_response(msg);
+}
+
 /* Find the next sequence number not being used and add the given
    message with the given timeout to the sequence table.  This must be
    called with the interface's seq_lock held. */
@@ -746,14 +776,8 @@ static int intf_err_seq(ipmi_smi_t   int
 	}
 	spin_unlock_irqrestore(&(intf->seq_lock), flags);
 
-	if (msg) {
-		msg->recv_type = IPMI_RESPONSE_RECV_TYPE;
-		msg->msg_data[0] = err;
-		msg->msg.netfn |= 1; /* Convert to a response. */
-		msg->msg.data_len = 1;
-		msg->msg.data = msg->msg_data;
-		deliver_response(msg);
-	}
+	if (msg)
+		deliver_err_response(msg, err);
 
 	return rv;
 }
@@ -795,19 +819,18 @@ int ipmi_create_user(unsigned int       
 	if (!new_user)
 		return -ENOMEM;
 
-	rcu_read_lock();
+	mutex_lock(&ipmi_interfaces_mutex);
 	list_for_each_entry_rcu(intf, &ipmi_interfaces, link) {
 		if (intf->intf_num == if_num)
 			goto found;
 	}
-	rcu_read_unlock();
+	/* Not found, return an error */
 	rv = -EINVAL;
 	goto out_kfree;
 
  found:
 	/* Note that each existing user holds a refcount to the interface. */
 	kref_get(&intf->refcount);
-	rcu_read_unlock();
 
 	kref_init(&new_user->refcount);
 	new_user->handler = handler;
@@ -828,6 +851,10 @@ int ipmi_create_user(unsigned int       
 		}
 	}
 
+	/* Hold the lock so intf->handlers is guaranteed to be good
+	 * until now */
+	mutex_unlock(&ipmi_interfaces_mutex);
+
 	new_user->valid = 1;
 	spin_lock_irqsave(&intf->seq_lock, flags);
 	list_add_rcu(&new_user->link, &intf->users);
@@ -838,6 +865,7 @@ int ipmi_create_user(unsigned int       
 out_kref:
 	kref_put(&intf->refcount, intf_free);
 out_kfree:
+	mutex_unlock(&ipmi_interfaces_mutex);
 	kfree(new_user);
 	return rv;
 }
@@ -867,6 +895,7 @@ int ipmi_destroy_user(ipmi_user_t user)
 		    && (intf->seq_table[i].recv_msg->user == user))
 		{
 			intf->seq_table[i].inuse = 0;
+			ipmi_free_recv_msg(intf->seq_table[i].recv_msg);
 		}
 	}
 	spin_unlock_irqrestore(&intf->seq_lock, flags);
@@ -893,9 +922,13 @@ int ipmi_destroy_user(ipmi_user_t user)
 		kfree(rcvr);
 	}
 
-	module_put(intf->handlers->owner);
-	if (intf->handlers->dec_usecount)
-		intf->handlers->dec_usecount(intf->send_info);
+	mutex_lock(&ipmi_interfaces_mutex);
+	if (intf->handlers) {
+		module_put(intf->handlers->owner);
+		if (intf->handlers->dec_usecount)
+			intf->handlers->dec_usecount(intf->send_info);
+	}
+	mutex_unlock(&ipmi_interfaces_mutex);
 
 	kref_put(&intf->refcount, intf_free);
 
@@ -908,8 +941,8 @@ void ipmi_get_version(ipmi_user_t   user
 		      unsigned char *major,
 		      unsigned char *minor)
 {
-	*major = ipmi_version_major(&user->intf->bmc->id);
-	*minor = ipmi_version_minor(&user->intf->bmc->id);
+	*major = user->intf->ipmi_version_major;
+	*minor = user->intf->ipmi_version_minor;
 }
 
 int ipmi_set_my_address(ipmi_user_t   user,
@@ -964,20 +997,33 @@ int ipmi_set_gets_events(ipmi_user_t use
 	spin_lock_irqsave(&intf->events_lock, flags);
 	user->gets_events = val;
 
-	if (val) {
-		/* Deliver any queued events. */
+	if (intf->delivering_events)
+		/*
+		 * Another thread is delivering events for this, so
+		 * let it handle any new events.
+		 */
+		goto out;
+
+	/* Deliver any queued events. */
+	while (user->gets_events && !list_empty(&intf->waiting_events)) {
 		list_for_each_entry_safe(msg, msg2, &intf->waiting_events, link)
 			list_move_tail(&msg->link, &msgs);
 		intf->waiting_events_count = 0;
-	}
 
-	/* Hold the events lock while doing this to preserve order. */
-	list_for_each_entry_safe(msg, msg2, &msgs, link) {
-		msg->user = user;
-		kref_get(&user->refcount);
-		deliver_response(msg);
+		intf->delivering_events = 1;
+		spin_unlock_irqrestore(&intf->events_lock, flags);
+
+		list_for_each_entry_safe(msg, msg2, &msgs, link) {
+			msg->user = user;
+			kref_get(&user->refcount);
+			deliver_response(msg);
+		}
+
+		spin_lock_irqsave(&intf->events_lock, flags);
+		intf->delivering_events = 0;
 	}
 
+ out:
 	spin_unlock_irqrestore(&intf->events_lock, flags);
 
 	return 0;
@@ -1088,7 +1134,8 @@ int ipmi_unregister_for_cmd(ipmi_user_t 
 void ipmi_user_set_run_to_completion(ipmi_user_t user, int val)
 {
 	ipmi_smi_t intf = user->intf;
-	intf->handlers->set_run_to_completion(intf->send_info, val);
+	if (intf->handlers)
+		intf->handlers->set_run_to_completion(intf->send_info, val);
 }
 
 static unsigned char
@@ -1199,10 +1246,11 @@ static int i_ipmi_request(ipmi_user_t   
 			  int                  retries,
 			  unsigned int         retry_time_ms)
 {
-	int                  rv = 0;
-	struct ipmi_smi_msg  *smi_msg;
-	struct ipmi_recv_msg *recv_msg;
-	unsigned long        flags;
+	int                      rv = 0;
+	struct ipmi_smi_msg      *smi_msg;
+	struct ipmi_recv_msg     *recv_msg;
+	unsigned long            flags;
+	struct ipmi_smi_handlers *handlers;
 
 
 	if (supplied_recv) {
@@ -1225,6 +1273,13 @@ static int i_ipmi_request(ipmi_user_t   
 		}
 	}
 
+	rcu_read_lock();
+	handlers = intf->handlers;
+	if (!handlers) {
+		rv = -ENODEV;
+		goto out_err;
+	}
+
 	recv_msg->user = user;
 	if (user)
 		kref_get(&user->refcount);
@@ -1541,11 +1596,14 @@ static int i_ipmi_request(ipmi_user_t   
 		printk("\n");
 	}
 #endif
-	intf->handlers->sender(intf->send_info, smi_msg, priority);
+
+	handlers->sender(intf->send_info, smi_msg, priority);
+	rcu_read_unlock();
 
 	return 0;
 
  out_err:
+	rcu_read_unlock();
 	ipmi_free_smi_msg(smi_msg);
 	ipmi_free_recv_msg(recv_msg);
 	return rv;
@@ -2492,13 +2550,8 @@ int ipmi_register_smi(struct ipmi_smi_ha
 	int              rv;
 	ipmi_smi_t       intf;
 	ipmi_smi_t       tintf;
-	int              version_major;
-	int              version_minor;
 	struct list_head *link;
 
-	version_major = ipmi_version_major(device_id);
-	version_minor = ipmi_version_minor(device_id);
-
 	/* Make sure the driver is actually initialized, this handles
 	   problems with initialization order. */
 	if (!initialized) {
@@ -2515,6 +2568,10 @@ int ipmi_register_smi(struct ipmi_smi_ha
 	if (!intf)
 		return -ENOMEM;
 	memset(intf, 0, sizeof(*intf));
+
+	intf->ipmi_version_major = ipmi_version_major(device_id);
+	intf->ipmi_version_minor = ipmi_version_minor(device_id);
+
 	intf->bmc = kzalloc(sizeof(*intf->bmc), GFP_KERNEL);
 	if (!intf->bmc) {
 		kfree(intf);
@@ -2554,6 +2611,7 @@ int ipmi_register_smi(struct ipmi_smi_ha
 	spin_lock_init(&intf->counter_lock);
 	intf->proc_dir = NULL;
 
+	mutex_lock(&smi_watchers_mutex);
 	mutex_lock(&ipmi_interfaces_mutex);
 	/* Look for a hole in the numbers. */
 	i = 0;
@@ -2577,8 +2635,9 @@ int ipmi_register_smi(struct ipmi_smi_ha
 
 	get_guid(intf);
 
-	if ((version_major > 1)
-	    || ((version_major == 1) && (version_minor >= 5)))
+	if ((intf->ipmi_version_major > 1)
+	    || ((intf->ipmi_version_major == 1)
+		&& (intf->ipmi_version_minor >= 5)))
 	{
 		/* Start scanning the channels to see what is
 		   available. */
@@ -2607,8 +2666,10 @@ int ipmi_register_smi(struct ipmi_smi_ha
 	if (rv) {
 		if (intf->proc_dir)
 			remove_proc_entries(intf);
+		intf->handlers = NULL;
 		list_del_rcu(&intf->link);
 		mutex_unlock(&ipmi_interfaces_mutex);
+		mutex_unlock(&smi_watchers_mutex);
 		synchronize_rcu();
 		kref_put(&intf->refcount, intf_free);
 	} else {
@@ -2616,30 +2677,50 @@ int ipmi_register_smi(struct ipmi_smi_ha
 		intf->intf_num = i;
 		mutex_unlock(&ipmi_interfaces_mutex);
 		call_smi_watchers(i, intf->si_dev);
+		mutex_unlock(&smi_watchers_mutex);
 	}
 
 	return rv;
 }
 
+static void cleanup_smi_msgs(ipmi_smi_t intf)
+{
+	int              i;
+	struct seq_table *ent;
+
+	/* No need for locks, the interface is down. */
+	for (i = 0; i < IPMI_IPMB_NUM_SEQ; i++) {
+		ent = &(intf->seq_table[i]);
+		if (!ent->inuse)
+			continue;
+		deliver_err_response(ent->recv_msg, IPMI_ERR_UNSPECIFIED);
+	}
+}
+
 int ipmi_unregister_smi(ipmi_smi_t intf)
 {
 	struct ipmi_smi_watcher *w;
+	int    intf_num = intf->intf_num;
 
 	ipmi_bmc_unregister(intf);
 
+	mutex_lock(&smi_watchers_mutex);
 	mutex_lock(&ipmi_interfaces_mutex);
+	intf->intf_num = -1;
+	intf->handlers = NULL;
 	list_del_rcu(&intf->link);
 	mutex_unlock(&ipmi_interfaces_mutex);
 	synchronize_rcu();
 
+	cleanup_smi_msgs(intf);
+
 	remove_proc_entries(intf);
 
 	/* Call all the watcher interfaces to tell them that
 	   an interface is gone. */
-	down_read(&smi_watchers_sem);
 	list_for_each_entry(w, &smi_watchers, link)
-		w->smi_gone(intf->intf_num);
-	up_read(&smi_watchers_sem);
+		w->smi_gone(intf_num);
+	mutex_unlock(&smi_watchers_mutex);
 
 	kref_put(&intf->refcount, intf_free);
 	return 0;
@@ -2721,6 +2802,7 @@ static int handle_ipmb_get_msg_cmd(ipmi_
 	struct ipmi_ipmb_addr    *ipmb_addr;
 	struct ipmi_recv_msg     *recv_msg;
 	unsigned long            flags;
+	struct ipmi_smi_handlers *handlers;
 
 	if (msg->rsp_size < 10) {
 		/* Message not big enough, just ignore it. */
@@ -2777,10 +2859,16 @@ static int handle_ipmb_get_msg_cmd(ipmi_
 		printk("\n");
 	}
 #endif
-		intf->handlers->sender(intf->send_info, msg, 0);
-
-		rv = -1; /* We used the message, so return the value that
-			    causes it to not be freed or queued. */
+		rcu_read_lock();
+		handlers = intf->handlers;
+		if (handlers) {
+			handlers->sender(intf->send_info, msg, 0);
+			/* We used the message, so return the value
+			   that causes it to not be freed or
+			   queued. */
+			rv = -1;
+		}
+		rcu_read_unlock();
 	} else {
 		/* Deliver the message to the user. */
 		spin_lock_irqsave(&intf->counter_lock, flags);
@@ -3370,16 +3458,6 @@ void ipmi_smi_watchdog_pretimeout(ipmi_s
 	rcu_read_unlock();
 }
 
-static void
-handle_msg_timeout(struct ipmi_recv_msg *msg)
-{
-	msg->recv_type = IPMI_RESPONSE_RECV_TYPE;
-	msg->msg_data[0] = IPMI_TIMEOUT_COMPLETION_CODE;
-	msg->msg.netfn |= 1; /* Convert to a response. */
-	msg->msg.data_len = 1;
-	msg->msg.data = msg->msg_data;
-	deliver_response(msg);
-}
 
 static struct ipmi_smi_msg *
 smi_from_recv_msg(ipmi_smi_t intf, struct ipmi_recv_msg *recv_msg,
@@ -3411,7 +3489,11 @@ static void check_msg_timeout(ipmi_smi_t
 			      struct list_head *timeouts, long timeout_period,
 			      int slot, unsigned long *flags)
 {
-	struct ipmi_recv_msg *msg;
+	struct ipmi_recv_msg     *msg;
+	struct ipmi_smi_handlers *handlers;
+
+	if (intf->intf_num == -1)
+		return;
 
 	if (!ent->inuse)
 		return;
@@ -3454,13 +3536,19 @@ static void check_msg_timeout(ipmi_smi_t
 			return;
 
 		spin_unlock_irqrestore(&intf->seq_lock, *flags);
+
 		/* Send the new message.  We send with a zero
 		 * priority.  It timed out, I doubt time is
 		 * that critical now, and high priority
 		 * messages are really only for messages to the
 		 * local MC, which don't get resent. */
-		intf->handlers->sender(intf->send_info,
-				       smi_msg, 0);
+		handlers = intf->handlers;
+		if (handlers)
+			intf->handlers->sender(intf->send_info,
+					       smi_msg, 0);
+		else
+			ipmi_free_smi_msg(smi_msg);
+
 		spin_lock_irqsave(&intf->seq_lock, *flags);
 	}
 }
@@ -3504,18 +3592,24 @@ static void ipmi_timeout_handler(long ti
 		spin_unlock_irqrestore(&intf->seq_lock, flags);
 
 		list_for_each_entry_safe(msg, msg2, &timeouts, link)
-			handle_msg_timeout(msg);
+			deliver_err_response(msg, IPMI_TIMEOUT_COMPLETION_CODE);
 	}
 	rcu_read_unlock();
 }
 
 static void ipmi_request_event(void)
 {
-	ipmi_smi_t intf;
+	ipmi_smi_t               intf;
+	struct ipmi_smi_handlers *handlers;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(intf, &ipmi_interfaces, link)
-		intf->handlers->request_events(intf->send_info);
+	/* Called from the timer, no need to check if handlers is
+	 * valid. */
+	list_for_each_entry_rcu(intf, &ipmi_interfaces, link) {
+		handlers = intf->handlers;
+		if (handlers)
+			handlers->request_events(intf->send_info);
+	}
 	rcu_read_unlock();
 }
 
@@ -3679,8 +3773,8 @@ static void send_panic_events(char *str)
 
 	/* For every registered interface, send the event. */
 	list_for_each_entry_rcu(intf, &ipmi_interfaces, link) {
-		if (intf->intf_num == -1)
-			/* Interface was not ready yet. */
+		if (!intf->handlers)
+			/* Interface is not ready. */
 			continue;
 
 		/* Send the event announcing the panic. */
@@ -3846,8 +3940,8 @@ static int panic_event(struct notifier_b
 
 	/* For every registered interface, set it to run to completion. */
 	list_for_each_entry_rcu(intf, &ipmi_interfaces, link) {
-		if (intf->intf_num == -1)
-			/* Interface was not ready yet. */
+		if (!intf->handlers)
+			/* Interface is not ready. */
 			continue;
 
 		intf->handlers->set_run_to_completion(intf->send_info, 1);
Index: linux-2.6.19-rc6/drivers/char/ipmi/ipmi_poweroff.c
===================================================================
--- linux-2.6.19-rc6.orig/drivers/char/ipmi/ipmi_poweroff.c
+++ linux-2.6.19-rc6/drivers/char/ipmi/ipmi_poweroff.c
@@ -43,6 +43,9 @@
 
 #define PFX "IPMI poweroff: "
 
+static void ipmi_po_smi_gone(int if_num);
+static void ipmi_po_new_smi(int if_num, struct device *device);
+
 /* Definitions for controlling power off (if the system supports it).  It
  * conveniently matches the IPMI chassis control values. */
 #define IPMI_CHASSIS_POWER_DOWN		0	/* power down, the default. */
@@ -51,6 +54,37 @@
 /* the IPMI data command */
 static int poweroff_powercycle;
 
+/* Which interface to use, -1 means the first we see. */
+static int ifnum_to_use = -1;
+
+/* Our local state. */
+static int ready = 0;
+static ipmi_user_t ipmi_user;
+static int ipmi_ifnum;
+static void (*specific_poweroff_func)(ipmi_user_t user) = NULL;
+
+/* Holds the old poweroff function so we can restore it on removal. */
+static void (*old_poweroff_func)(void);
+
+static int set_param_ifnum(const char *val, struct kernel_param *kp)
+{
+	int rv = param_set_int(val, kp);
+	if (rv)
+		return rv;
+	if ((ifnum_to_use < 0) || (ifnum_to_use == ipmi_ifnum))
+		return 0;
+
+	ipmi_po_smi_gone(ipmi_ifnum);
+	ipmi_po_new_smi(ifnum_to_use, NULL);
+	return 0;
+}
+
+module_param_call(ifnum_to_use, set_param_ifnum, param_get_int,
+		  &ifnum_to_use, 0644);
+MODULE_PARM_DESC(ifnum_to_use, "The interface number to use for the watchdog "
+		 "timer.  Setting to -1 defaults to the first registered "
+		 "interface");
+
 /* parameter definition to allow user to flag power cycle */
 module_param(poweroff_powercycle, int, 0644);
 MODULE_PARM_DESC(poweroff_powercycle, " Set to non-zero to enable power cycle instead of power down. Power cycle is contingent on hardware support, otherwise it defaults back to power down.");
@@ -440,15 +474,6 @@ static struct poweroff_function poweroff
 		      / sizeof(struct poweroff_function))
 
 
-/* Our local state. */
-static int ready = 0;
-static ipmi_user_t ipmi_user;
-static void (*specific_poweroff_func)(ipmi_user_t user) = NULL;
-
-/* Holds the old poweroff function so we can restore it on removal. */
-static void (*old_poweroff_func)(void);
-
-
 /* Called on a powerdown request. */
 static void ipmi_poweroff_function (void)
 {
@@ -473,6 +498,9 @@ static void ipmi_po_new_smi(int if_num, 
 	if (ready)
 		return;
 
+	if ((ifnum_to_use >= 0) && (ifnum_to_use != if_num))
+		return;
+
 	rv = ipmi_create_user(if_num, &ipmi_poweroff_handler, NULL,
 			      &ipmi_user);
 	if (rv) {
@@ -481,6 +509,8 @@ static void ipmi_po_new_smi(int if_num, 
 		return;
 	}
 
+	ipmi_ifnum = if_num;
+
         /*
          * Do a get device ide and store some results, since this is
 	 * used by several functions.
@@ -541,9 +571,15 @@ static void ipmi_po_new_smi(int if_num, 
 
 static void ipmi_po_smi_gone(int if_num)
 {
-	/* This can never be called, because once poweroff driver is
-	   registered, the interface can't go away until the power
-	   driver is unregistered. */
+	if (!ready)
+		return;
+
+	if (ipmi_ifnum != if_num)
+		return;
+
+	ready = 0;
+	ipmi_destroy_user(ipmi_user);
+	pm_power_off = old_poweroff_func;
 }
 
 static struct ipmi_smi_watcher smi_watcher =
Index: linux-2.6.19-rc6/drivers/char/ipmi/ipmi_watchdog.c
===================================================================
--- linux-2.6.19-rc6.orig/drivers/char/ipmi/ipmi_watchdog.c
+++ linux-2.6.19-rc6/drivers/char/ipmi/ipmi_watchdog.c
@@ -135,6 +135,7 @@
 static int nowayout = WATCHDOG_NOWAYOUT;
 
 static ipmi_user_t watchdog_user = NULL;
+static int watchdog_ifnum;
 
 /* Default the timeout to 10 seconds. */
 static int timeout = 10;
@@ -161,6 +162,8 @@ static struct fasync_struct *fasync_q = 
 static char pretimeout_since_last_heartbeat = 0;
 static char expect_close;
 
+static int ifnum_to_use = -1;
+
 static DECLARE_RWSEM(register_sem);
 
 /* Parameters to ipmi_set_timeout */
@@ -169,6 +172,8 @@ static DECLARE_RWSEM(register_sem);
 #define IPMI_SET_TIMEOUT_FORCE_HB		2
 
 static int ipmi_set_timeout(int do_heartbeat);
+static void ipmi_register_watchdog(int ipmi_intf);
+static void ipmi_unregister_watchdog(int ipmi_intf);
 
 /* If true, the driver will start running as soon as it is configured
    and ready. */
@@ -245,6 +250,26 @@ static int get_param_str(char *buffer, s
 	return strlen(buffer);
 }
 
+
+static int set_param_wdog_ifnum(const char *val, struct kernel_param *kp)
+{
+	int rv = param_set_int(val, kp);
+	if (rv)
+		return rv;
+	if ((ifnum_to_use < 0) || (ifnum_to_use == watchdog_ifnum))
+		return 0;
+
+	ipmi_unregister_watchdog(watchdog_ifnum);
+	ipmi_register_watchdog(ifnum_to_use);
+	return 0;
+}
+
+module_param_call(ifnum_to_use, set_param_wdog_ifnum, get_param_int,
+		  &ifnum_to_use, 0644);
+MODULE_PARM_DESC(ifnum_to_use, "The interface number to use for the watchdog "
+		 "timer.  Setting to -1 defaults to the first registered "
+		 "interface");
+
 module_param_call(timeout, set_param_int, get_param_int, &timeout, 0644);
 MODULE_PARM_DESC(timeout, "Timeout value in seconds.");
 
@@ -263,12 +288,13 @@ module_param_call(preop, set_param_str, 
 MODULE_PARM_DESC(preop, "Pretimeout driver operation.  One of: "
 		 "preop_none, preop_panic, preop_give_data.");
 
-module_param(start_now, int, 0);
+module_param(start_now, int, 0444);
 MODULE_PARM_DESC(start_now, "Set to 1 to start the watchdog as"
 		 "soon as the driver is loaded.");
 
 module_param(nowayout, int, 0644);
-MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
+		 "(default=CONFIG_WATCHDOG_NOWAYOUT)");
 
 /* Default state of the timer. */
 static unsigned char ipmi_watchdog_state = WDOG_TIMEOUT_NONE;
@@ -872,6 +898,11 @@ static void ipmi_register_watchdog(int i
 	if (watchdog_user)
 		goto out;
 
+	if ((ifnum_to_use >= 0) && (ifnum_to_use != ipmi_intf))
+		goto out;
+
+	watchdog_ifnum = ipmi_intf;
+
 	rv = ipmi_create_user(ipmi_intf, &ipmi_hndlrs, NULL, &watchdog_user);
 	if (rv < 0) {
 		printk(KERN_CRIT PFX "Unable to register with ipmi\n");
@@ -901,6 +932,39 @@ static void ipmi_register_watchdog(int i
 	}
 }
 
+static void ipmi_unregister_watchdog(int ipmi_intf)
+{
+	int rv;
+
+	down_write(&register_sem);
+
+	if (!watchdog_user)
+		goto out;
+
+	if (watchdog_ifnum != ipmi_intf)
+		goto out;
+
+	/* Make sure no one can call us any more. */
+	misc_deregister(&ipmi_wdog_miscdev);
+
+	/* Wait to make sure the message makes it out.  The lower layer has
+	   pointers to our buffers, we want to make sure they are done before
+	   we release our memory. */
+	while (atomic_read(&set_timeout_tofree))
+		schedule_timeout_uninterruptible(1);
+
+	/* Disconnect from IPMI. */
+	rv = ipmi_destroy_user(watchdog_user);
+	if (rv) {
+		printk(KERN_WARNING PFX "error unlinking from IPMI: %d\n",
+		       rv);
+	}
+	watchdog_user = NULL;
+
+ out:
+	up_write(&register_sem);
+}
+
 #ifdef HAVE_NMI_HANDLER
 static int
 ipmi_nmi(void *dev_id, int cpu, int handled)
@@ -1004,9 +1068,7 @@ static void ipmi_new_smi(int if_num, str
 
 static void ipmi_smi_gone(int if_num)
 {
-	/* This can never be called, because once the watchdog is
-	   registered, the interface can't go away until the watchdog
-	   is unregistered. */
+	ipmi_unregister_watchdog(if_num);
 }
 
 static struct ipmi_smi_watcher smi_watcher =
@@ -1148,30 +1210,32 @@ static int __init ipmi_wdog_init(void)
 
 	check_parms();
 
+	register_reboot_notifier(&wdog_reboot_notifier);
+	atomic_notifier_chain_register(&panic_notifier_list,
+			&wdog_panic_notifier);
+
 	rv = ipmi_smi_watcher_register(&smi_watcher);
 	if (rv) {
 #ifdef HAVE_NMI_HANDLER
 		if (preaction_val == WDOG_PRETIMEOUT_NMI)
 			release_nmi(&ipmi_nmi_handler);
 #endif
+		atomic_notifier_chain_unregister(&panic_notifier_list,
+						 &wdog_panic_notifier);
+		unregister_reboot_notifier(&wdog_reboot_notifier);
 		printk(KERN_WARNING PFX "can't register smi watcher\n");
 		return rv;
 	}
 
-	register_reboot_notifier(&wdog_reboot_notifier);
-	atomic_notifier_chain_register(&panic_notifier_list,
-			&wdog_panic_notifier);
-
 	printk(KERN_INFO PFX "driver initialized\n");
 
 	return 0;
 }
 
-static __exit void ipmi_unregister_watchdog(void)
+static void __exit ipmi_wdog_exit(void)
 {
-	int rv;
-
-	down_write(&register_sem);
+	ipmi_smi_watcher_unregister(&smi_watcher);
+	ipmi_unregister_watchdog(watchdog_ifnum);
 
 #ifdef HAVE_NMI_HANDLER
 	if (nmi_handler_registered)
@@ -1179,37 +1243,8 @@ static __exit void ipmi_unregister_watch
 #endif
 
 	atomic_notifier_chain_unregister(&panic_notifier_list,
-			&wdog_panic_notifier);
+					 &wdog_panic_notifier);
 	unregister_reboot_notifier(&wdog_reboot_notifier);
-
-	if (! watchdog_user)
-		goto out;
-
-	/* Make sure no one can call us any more. */
-	misc_deregister(&ipmi_wdog_miscdev);
-
-	/* Wait to make sure the message makes it out.  The lower layer has
-	   pointers to our buffers, we want to make sure they are done before
-	   we release our memory. */
-	while (atomic_read(&set_timeout_tofree))
-		schedule_timeout_uninterruptible(1);
-
-	/* Disconnect from IPMI. */
-	rv = ipmi_destroy_user(watchdog_user);
-	if (rv) {
-		printk(KERN_WARNING PFX "error unlinking from IPMI: %d\n",
-		       rv);
-	}
-	watchdog_user = NULL;
-
- out:
-	up_write(&register_sem);
-}
-
-static void __exit ipmi_wdog_exit(void)
-{
-	ipmi_smi_watcher_unregister(&smi_watcher);
-	ipmi_unregister_watchdog();
 }
 module_exit(ipmi_wdog_exit);
 module_init(ipmi_wdog_init);
Index: linux-2.6.19-rc6/Documentation/IPMI.txt
===================================================================
--- linux-2.6.19-rc6.orig/Documentation/IPMI.txt
+++ linux-2.6.19-rc6/Documentation/IPMI.txt
@@ -502,7 +502,10 @@ used to control it:
 
   modprobe ipmi_watchdog timeout=<t> pretimeout=<t> action=<action type>
       preaction=<preaction type> preop=<preop type> start_now=x
-      nowayout=x
+      nowayout=x ifnum_to_use=n
+
+ifnum_to_use specifies which interface the watchdog timer should use.
+The default is -1, which means to pick the first one registered.
 
 The timeout is the number of seconds to the action, and the pretimeout
 is the amount of seconds before the reset that the pre-timeout panic will
@@ -624,5 +627,9 @@ command line.  The parameter is also ava
 in /proc/sys/dev/ipmi/poweroff_powercycle.  Note that if the system
 does not support power cycling, it will always do the power off.
 
+The "ifnum_to_use" parameter specifies which interface the poweroff
+code should use.  The default is -1, which means to pick the first one
+registered.
+
 Note that if you have ACPI enabled, the system will prefer using ACPI to
 power off.
