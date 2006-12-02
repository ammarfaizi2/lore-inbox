Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162751AbWLBEY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162751AbWLBEY0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 23:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162768AbWLBEY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 23:24:26 -0500
Received: from mta9.adelphia.net ([68.168.78.199]:5821 "EHLO mta9.adelphia.net")
	by vger.kernel.org with ESMTP id S1162751AbWLBEYZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 23:24:25 -0500
Date: Fri, 1 Dec 2006 22:24:22 -0600
From: Corey Minyard <minyard@acm.org>
To: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Cc: OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>,
       Carol Hebert <cah@us.ibm.com>
Subject: [Patch 2/12] IPMI: remove interface number limits
Message-ID: <20061202042422.GB30214@localdomain>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch removes the arbitrary limit of number of IPMI interfaces.
This has been tested with 8 interfaces.

Signed-off-by: Corey Minyard <minyard@acm.org>
Cc: Carol Hebert <cah@us.ibm.com>

Index: linux-2.6.19-rc6/drivers/char/ipmi/ipmi_msghandler.c
===================================================================
--- linux-2.6.19-rc6.orig/drivers/char/ipmi/ipmi_msghandler.c
+++ linux-2.6.19-rc6/drivers/char/ipmi/ipmi_msghandler.c
@@ -193,6 +193,9 @@ struct ipmi_smi
 
 	struct kref refcount;
 
+	/* Used for a list of interfaces. */
+	struct list_head link;
+
 	/* The list of upper layers that are using me.  seq_lock
 	 * protects this. */
 	struct list_head users;
@@ -338,13 +341,6 @@ struct ipmi_smi
 };
 #define to_si_intf_from_dev(device) container_of(device, struct ipmi_smi, dev)
 
-/* Used to mark an interface entry that cannot be used but is not a
- * free entry, either, primarily used at creation and deletion time so
- * a slot doesn't get reused too quickly. */
-#define IPMI_INVALID_INTERFACE_ENTRY ((ipmi_smi_t) ((long) 1))
-#define IPMI_INVALID_INTERFACE(i) (((i) == NULL) \
-				   || (i == IPMI_INVALID_INTERFACE_ENTRY))
-
 /**
  * The driver model view of the IPMI messaging driver.
  */
@@ -354,11 +350,8 @@ static struct device_driver ipmidriver =
 };
 static DEFINE_MUTEX(ipmidriver_mutex);
 
-#define MAX_IPMI_INTERFACES 4
-static ipmi_smi_t ipmi_interfaces[MAX_IPMI_INTERFACES];
-
-/* Directly protects the ipmi_interfaces data structure. */
-static DEFINE_SPINLOCK(interfaces_lock);
+static struct list_head ipmi_interfaces = LIST_HEAD_INIT(ipmi_interfaces);
+static DEFINE_MUTEX(ipmi_interfaces_mutex);
 
 /* List of watchers that want to know when smi's are added and
    deleted. */
@@ -423,25 +416,50 @@ static void intf_free(struct kref *ref)
 	kfree(intf);
 }
 
+struct watcher_entry {
+	struct list_head link;
+	int intf_num;
+};
+
 int ipmi_smi_watcher_register(struct ipmi_smi_watcher *watcher)
 {
-	int           i;
-	unsigned long flags;
+	ipmi_smi_t intf;
+	struct list_head to_deliver = LIST_HEAD_INIT(to_deliver);
+	struct watcher_entry *e, *e2;
+
+	mutex_lock(&ipmi_interfaces_mutex);
+
+	list_for_each_entry_rcu(intf, &ipmi_interfaces, link) {
+		if (intf->intf_num == -1)
+			continue;
+		e = kmalloc(sizeof(*e), GFP_KERNEL);
+		if (!e)
+			goto out_err;
+		e->intf_num = intf->intf_num;
+		list_add_tail(&e->link, &to_deliver);
+	}
 
 	down_write(&smi_watchers_sem);
 	list_add(&(watcher->link), &smi_watchers);
 	up_write(&smi_watchers_sem);
-	spin_lock_irqsave(&interfaces_lock, flags);
-	for (i = 0; i < MAX_IPMI_INTERFACES; i++) {
-		ipmi_smi_t intf = ipmi_interfaces[i];
-		if (IPMI_INVALID_INTERFACE(intf))
-			continue;
-		spin_unlock_irqrestore(&interfaces_lock, flags);
-		watcher->new_smi(i, intf->si_dev);
-		spin_lock_irqsave(&interfaces_lock, flags);
+
+	mutex_unlock(&ipmi_interfaces_mutex);
+
+	list_for_each_entry_safe(e, e2, &to_deliver, link) {
+		list_del(&e->link);
+		watcher->new_smi(e->intf_num, intf->si_dev);
+		kfree(e);
 	}
-	spin_unlock_irqrestore(&interfaces_lock, flags);
+
+
 	return 0;
+
+ out_err:
+	list_for_each_entry_safe(e, e2, &to_deliver, link) {
+		list_del(&e->link);
+		kfree(e);
+	}
+	return -ENOMEM;
 }
 
 int ipmi_smi_watcher_unregister(struct ipmi_smi_watcher *watcher)
@@ -776,17 +794,19 @@ int ipmi_create_user(unsigned int       
 	if (!new_user)
 		return -ENOMEM;
 
-	spin_lock_irqsave(&interfaces_lock, flags);
-	intf = ipmi_interfaces[if_num];
-	if ((if_num >= MAX_IPMI_INTERFACES) || IPMI_INVALID_INTERFACE(intf)) {
-		spin_unlock_irqrestore(&interfaces_lock, flags);
-		rv = -EINVAL;
-		goto out_kfree;
+	rcu_read_lock();
+	list_for_each_entry_rcu(intf, &ipmi_interfaces, link) {
+		if (intf->intf_num == if_num)
+			goto found;
 	}
+	rcu_read_unlock();
+	rv = -EINVAL;
+	goto out_kfree;
 
+ found:
 	/* Note that each existing user holds a refcount to the interface. */
 	kref_get(&intf->refcount);
-	spin_unlock_irqrestore(&interfaces_lock, flags);
+	rcu_read_unlock();
 
 	kref_init(&new_user->refcount);
 	new_user->handler = handler;
@@ -2449,9 +2469,10 @@ int ipmi_register_smi(struct ipmi_smi_ha
 	int              i, j;
 	int              rv;
 	ipmi_smi_t       intf;
-	unsigned long    flags;
+	ipmi_smi_t       tintf;
 	int              version_major;
 	int              version_minor;
+	struct list_head *link;
 
 	version_major = ipmi_version_major(device_id);
 	version_minor = ipmi_version_minor(device_id);
@@ -2477,7 +2498,7 @@ int ipmi_register_smi(struct ipmi_smi_ha
 		kfree(intf);
 		return -ENOMEM;
 	}
-	intf->intf_num = -1;
+	intf->intf_num = -1; /* Mark it invalid for now. */
 	kref_init(&intf->refcount);
 	intf->bmc->id = *device_id;
 	intf->si_dev = si_dev;
@@ -2511,20 +2532,22 @@ int ipmi_register_smi(struct ipmi_smi_ha
 	spin_lock_init(&intf->counter_lock);
 	intf->proc_dir = NULL;
 
-	rv = -ENOMEM;
-	spin_lock_irqsave(&interfaces_lock, flags);
-	for (i = 0; i < MAX_IPMI_INTERFACES; i++) {
-		if (ipmi_interfaces[i] == NULL) {
-			intf->intf_num = i;
-			/* Reserve the entry till we are done. */
-			ipmi_interfaces[i] = IPMI_INVALID_INTERFACE_ENTRY;
-			rv = 0;
+	mutex_lock(&ipmi_interfaces_mutex);
+	/* Look for a hole in the numbers. */
+	i = 0;
+	link = &ipmi_interfaces;
+	list_for_each_entry_rcu(tintf, &ipmi_interfaces, link) {
+		if (tintf->intf_num != i) {
+			link = &tintf->link;
 			break;
 		}
+		i++;
 	}
-	spin_unlock_irqrestore(&interfaces_lock, flags);
-	if (rv)
-		goto out;
+	/* Add the new interface in numeric order. */
+	if (i == 0)
+		list_add_rcu(&intf->link, &ipmi_interfaces);
+	else
+		list_add_tail_rcu(&intf->link, link);
 
 	rv = handlers->start_processing(send_info, intf);
 	if (rv)
@@ -2562,16 +2585,14 @@ int ipmi_register_smi(struct ipmi_smi_ha
 	if (rv) {
 		if (intf->proc_dir)
 			remove_proc_entries(intf);
+		list_del_rcu(&intf->link);
+		mutex_unlock(&ipmi_interfaces_mutex);
+		synchronize_rcu();
 		kref_put(&intf->refcount, intf_free);
-		if (i < MAX_IPMI_INTERFACES) {
-			spin_lock_irqsave(&interfaces_lock, flags);
-			ipmi_interfaces[i] = NULL;
-			spin_unlock_irqrestore(&interfaces_lock, flags);
-		}
 	} else {
-		spin_lock_irqsave(&interfaces_lock, flags);
-		ipmi_interfaces[i] = intf;
-		spin_unlock_irqrestore(&interfaces_lock, flags);
+		/* After this point the interface is legal to use. */
+		intf->intf_num = i;
+		mutex_unlock(&ipmi_interfaces_mutex);
 		call_smi_watchers(i, intf->si_dev);
 	}
 
@@ -2580,26 +2601,14 @@ int ipmi_register_smi(struct ipmi_smi_ha
 
 int ipmi_unregister_smi(ipmi_smi_t intf)
 {
-	int                     i;
 	struct ipmi_smi_watcher *w;
-	unsigned long           flags;
 
 	ipmi_bmc_unregister(intf);
 
-	spin_lock_irqsave(&interfaces_lock, flags);
-	for (i = 0; i < MAX_IPMI_INTERFACES; i++) {
-		if (ipmi_interfaces[i] == intf) {
-			/* Set the interface number reserved until we
-			 * are done. */
-			ipmi_interfaces[i] = IPMI_INVALID_INTERFACE_ENTRY;
-			intf->intf_num = -1;
-			break;
-		}
-	}
-	spin_unlock_irqrestore(&interfaces_lock,flags);
-
-	if (i == MAX_IPMI_INTERFACES)
-		return -ENODEV;
+	mutex_lock(&ipmi_interfaces_mutex);
+	list_del_rcu(&intf->link);
+	mutex_unlock(&ipmi_interfaces_mutex);
+	synchronize_rcu();
 
 	remove_proc_entries(intf);
 
@@ -2607,14 +2616,9 @@ int ipmi_unregister_smi(ipmi_smi_t intf)
 	   an interface is gone. */
 	down_read(&smi_watchers_sem);
 	list_for_each_entry(w, &smi_watchers, link)
-		w->smi_gone(i);
+		w->smi_gone(intf->intf_num);
 	up_read(&smi_watchers_sem);
 
-	/* Allow the entry to be reused now. */
-	spin_lock_irqsave(&interfaces_lock, flags);
-	ipmi_interfaces[i] = NULL;
-	spin_unlock_irqrestore(&interfaces_lock,flags);
-
 	kref_put(&intf->refcount, intf_free);
 	return 0;
 }
@@ -3446,18 +3450,12 @@ static void ipmi_timeout_handler(long ti
 	struct ipmi_recv_msg *msg, *msg2;
 	struct ipmi_smi_msg  *smi_msg, *smi_msg2;
 	unsigned long        flags;
-	int                  i, j;
+	int                  i;
 
 	INIT_LIST_HEAD(&timeouts);
 
-	spin_lock(&interfaces_lock);
-	for (i = 0; i < MAX_IPMI_INTERFACES; i++) {
-		intf = ipmi_interfaces[i];
-		if (IPMI_INVALID_INTERFACE(intf))
-			continue;
-		kref_get(&intf->refcount);
-		spin_unlock(&interfaces_lock);
-
+	rcu_read_lock();
+	list_for_each_entry_rcu(intf, &ipmi_interfaces, link) {
 		/* See if any waiting messages need to be processed. */
 		spin_lock_irqsave(&intf->waiting_msgs_lock, flags);
 		list_for_each_entry_safe(smi_msg, smi_msg2,
@@ -3477,35 +3475,26 @@ static void ipmi_timeout_handler(long ti
 		   have timed out, putting them in the timeouts
 		   list. */
 		spin_lock_irqsave(&intf->seq_lock, flags);
-		for (j = 0; j < IPMI_IPMB_NUM_SEQ; j++)
-			check_msg_timeout(intf, &(intf->seq_table[j]),
-					  &timeouts, timeout_period, j,
+		for (i = 0; i < IPMI_IPMB_NUM_SEQ; i++)
+			check_msg_timeout(intf, &(intf->seq_table[i]),
+					  &timeouts, timeout_period, i,
 					  &flags);
 		spin_unlock_irqrestore(&intf->seq_lock, flags);
 
 		list_for_each_entry_safe(msg, msg2, &timeouts, link)
 			handle_msg_timeout(msg);
-
-		kref_put(&intf->refcount, intf_free);
-		spin_lock(&interfaces_lock);
 	}
-	spin_unlock(&interfaces_lock);
+	rcu_read_unlock();
 }
 
 static void ipmi_request_event(void)
 {
 	ipmi_smi_t intf;
-	int        i;
-
-	spin_lock(&interfaces_lock);
-	for (i = 0; i < MAX_IPMI_INTERFACES; i++) {
-		intf = ipmi_interfaces[i];
-		if (IPMI_INVALID_INTERFACE(intf))
-			continue;
 
+	rcu_read_lock();
+	list_for_each_entry_rcu(intf, &ipmi_interfaces, link)
 		intf->handlers->request_events(intf->send_info);
-	}
-	spin_unlock(&interfaces_lock);
+	rcu_read_unlock();
 }
 
 static struct timer_list ipmi_timer;
@@ -3634,7 +3623,6 @@ static void send_panic_events(char *str)
 	struct kernel_ipmi_msg            msg;
 	ipmi_smi_t                        intf;
 	unsigned char                     data[16];
-	int                               i;
 	struct ipmi_system_interface_addr *si;
 	struct ipmi_addr                  addr;
 	struct ipmi_smi_msg               smi_msg;
@@ -3668,9 +3656,9 @@ static void send_panic_events(char *str)
 	recv_msg.done = dummy_recv_done_handler;
 
 	/* For every registered interface, send the event. */
-	for (i = 0; i < MAX_IPMI_INTERFACES; i++) {
-		intf = ipmi_interfaces[i];
-		if (IPMI_INVALID_INTERFACE(intf))
+	list_for_each_entry_rcu(intf, &ipmi_interfaces, link) {
+		if (intf->intf_num == -1)
+			/* Interface was not ready yet. */
 			continue;
 
 		/* Send the event announcing the panic. */
@@ -3695,13 +3683,14 @@ static void send_panic_events(char *str)
 	if (!str) 
 		return;
 
-	for (i = 0; i < MAX_IPMI_INTERFACES; i++) {
+	/* For every registered interface, send the event. */
+	list_for_each_entry_rcu(intf, &ipmi_interfaces, link) {
 		char                  *p = str;
 		struct ipmi_ipmb_addr *ipmb;
 		int                   j;
 
-		intf = ipmi_interfaces[i];
-		if (IPMI_INVALID_INTERFACE(intf))
+		if (intf->intf_num == -1)
+			/* Interface was not ready yet. */
 			continue;
 
 		/* First job here is to figure out where to send the
@@ -3827,7 +3816,6 @@ static int panic_event(struct notifier_b
 		       unsigned long         event,
                        void                  *ptr)
 {
-	int        i;
 	ipmi_smi_t intf;
 
 	if (has_panicked)
@@ -3835,9 +3823,9 @@ static int panic_event(struct notifier_b
 	has_panicked = 1;
 
 	/* For every registered interface, set it to run to completion. */
-	for (i = 0; i < MAX_IPMI_INTERFACES; i++) {
-		intf = ipmi_interfaces[i];
-		if (IPMI_INVALID_INTERFACE(intf))
+	list_for_each_entry_rcu(intf, &ipmi_interfaces, link) {
+		if (intf->intf_num == -1)
+			/* Interface was not ready yet. */
 			continue;
 
 		intf->handlers->set_run_to_completion(intf->send_info, 1);
@@ -3858,7 +3846,6 @@ static struct notifier_block panic_block
 
 static int ipmi_init_msghandler(void)
 {
-	int i;
 	int rv;
 
 	if (initialized)
@@ -3873,9 +3860,6 @@ static int ipmi_init_msghandler(void)
 	printk(KERN_INFO "ipmi message handler version "
 	       IPMI_DRIVER_VERSION "\n");
 
-	for (i = 0; i < MAX_IPMI_INTERFACES; i++)
-		ipmi_interfaces[i] = NULL;
-
 #ifdef CONFIG_PROC_FS
 	proc_ipmi_root = proc_mkdir("ipmi", NULL);
 	if (!proc_ipmi_root) {
