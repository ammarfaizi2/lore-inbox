Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbWC0RgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbWC0RgF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 12:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbWC0RgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 12:36:05 -0500
Received: from sccrmhc11.comcast.net ([63.240.77.81]:65523 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1750835AbWC0RgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 12:36:02 -0500
Date: Mon, 27 Mar 2006 11:36:00 -0600
From: Corey Minyard <minyard@acm.org>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH 3/3] IPMI: convert from semaphores to mutexes
Message-ID: <20060327173600.GC14601@i2.minyard.local>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Convert the remaining semaphores to mutexes in the IPMI driver.  The
watchdog was using a semaphore as a real semaphore (for IPC), so the
conversion there required adding a completion.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.16/drivers/char/ipmi/ipmi_devintf.c
===================================================================
--- linux-2.6.16.orig/drivers/char/ipmi/ipmi_devintf.c
+++ linux-2.6.16/drivers/char/ipmi/ipmi_devintf.c
@@ -42,7 +42,7 @@
 #include <linux/slab.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/ipmi.h>
-#include <asm/semaphore.h>
+#include <linux/mutex.h>
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/compat.h>
@@ -55,7 +55,7 @@ struct ipmi_file_private
 	struct file          *file;
 	struct fasync_struct *fasync_queue;
 	wait_queue_head_t    wait;
-	struct semaphore     recv_sem;
+	struct mutex	     recv_mutex;
 	int                  default_retries;
 	unsigned int         default_retry_time_ms;
 };
@@ -141,7 +141,7 @@ static int ipmi_open(struct inode *inode
 	INIT_LIST_HEAD(&(priv->recv_msgs));
 	init_waitqueue_head(&priv->wait);
 	priv->fasync_queue = NULL;
-	sema_init(&(priv->recv_sem), 1);
+	mutex_init(&priv->recv_mutex);
 
 	/* Use the low-level defaults. */
 	priv->default_retries = -1;
@@ -285,15 +285,15 @@ static int ipmi_ioctl(struct inode  *ino
 			break;
 		}
 
-		/* We claim a semaphore because we don't want two
+		/* We claim a mutex because we don't want two
                    users getting something from the queue at a time.
                    Since we have to release the spinlock before we can
                    copy the data to the user, it's possible another
                    user will grab something from the queue, too.  Then
                    the messages might get out of order if something
                    fails and the message gets put back onto the
-                   queue.  This semaphore prevents that problem. */
-		down(&(priv->recv_sem));
+                   queue.  This mutex prevents that problem. */
+		mutex_lock(&priv->recv_mutex);
 
 		/* Grab the message off the list. */
 		spin_lock_irqsave(&(priv->recv_msg_lock), flags);
@@ -352,7 +352,7 @@ static int ipmi_ioctl(struct inode  *ino
 			goto recv_putback_on_err;
 		}
 
-		up(&(priv->recv_sem));
+		mutex_unlock(&priv->recv_mutex);
 		ipmi_free_recv_msg(msg);
 		break;
 
@@ -362,11 +362,11 @@ static int ipmi_ioctl(struct inode  *ino
 		spin_lock_irqsave(&(priv->recv_msg_lock), flags);
 		list_add(entry, &(priv->recv_msgs));
 		spin_unlock_irqrestore(&(priv->recv_msg_lock), flags);
-		up(&(priv->recv_sem));
+		mutex_unlock(&priv->recv_mutex);
 		break;
 
 	recv_err:
-		up(&(priv->recv_sem));
+		mutex_unlock(&priv->recv_mutex);
 		break;
 	}
 
Index: linux-2.6.16/drivers/char/ipmi/ipmi_msghandler.c
===================================================================
--- linux-2.6.16.orig/drivers/char/ipmi/ipmi_msghandler.c
+++ linux-2.6.16/drivers/char/ipmi/ipmi_msghandler.c
@@ -38,6 +38,7 @@
 #include <linux/sched.h>
 #include <linux/poll.h>
 #include <linux/spinlock.h>
+#include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/ipmi.h>
 #include <linux/ipmi_smi.h>
@@ -234,7 +235,7 @@ struct ipmi_smi
 
 	/* The list of command receivers that are registered for commands
 	   on this interface. */
-	struct semaphore cmd_rcvrs_lock;
+	struct mutex     cmd_rcvrs_mutex;
 	struct list_head cmd_rcvrs;
 
 	/* Events that were queues because no one was there to receive
@@ -387,10 +388,10 @@ static void clean_up_interface_data(ipmi
 
 	/* Wholesale remove all the entries from the list in the
 	 * interface and wait for RCU to know that none are in use. */
-	down(&intf->cmd_rcvrs_lock);
+	mutex_lock(&intf->cmd_rcvrs_mutex);
 	list_add_rcu(&list, &intf->cmd_rcvrs);
 	list_del_rcu(&intf->cmd_rcvrs);
-	up(&intf->cmd_rcvrs_lock);
+	mutex_unlock(&intf->cmd_rcvrs_mutex);
 	synchronize_rcu();
 
 	list_for_each_entry_safe(rcvr, rcvr2, &list, link)
@@ -848,7 +849,7 @@ int ipmi_destroy_user(ipmi_user_t user)
 	 * since other things may be using it till we do
 	 * synchronize_rcu()) then free everything in that list.
 	 */
-	down(&intf->cmd_rcvrs_lock);
+	mutex_lock(&intf->cmd_rcvrs_mutex);
 	list_for_each_entry_rcu(rcvr, &intf->cmd_rcvrs, link) {
 		if (rcvr->user == user) {
 			list_del_rcu(&rcvr->link);
@@ -856,7 +857,7 @@ int ipmi_destroy_user(ipmi_user_t user)
 			rcvrs = rcvr;
 		}
 	}
-	up(&intf->cmd_rcvrs_lock);
+	mutex_unlock(&intf->cmd_rcvrs_mutex);
 	synchronize_rcu();
 	while (rcvrs) {
 		rcvr = rcvrs;
@@ -986,7 +987,7 @@ int ipmi_register_for_cmd(ipmi_user_t   
 	rcvr->netfn = netfn;
 	rcvr->user = user;
 
-	down(&intf->cmd_rcvrs_lock);
+	mutex_lock(&intf->cmd_rcvrs_mutex);
 	/* Make sure the command/netfn is not already registered. */
 	entry = find_cmd_rcvr(intf, netfn, cmd);
 	if (entry) {
@@ -997,7 +998,7 @@ int ipmi_register_for_cmd(ipmi_user_t   
 	list_add_rcu(&rcvr->link, &intf->cmd_rcvrs);
 
  out_unlock:
-	up(&intf->cmd_rcvrs_lock);
+	mutex_unlock(&intf->cmd_rcvrs_mutex);
 	if (rv)
 		kfree(rcvr);
 
@@ -1011,17 +1012,17 @@ int ipmi_unregister_for_cmd(ipmi_user_t 
 	ipmi_smi_t      intf = user->intf;
 	struct cmd_rcvr *rcvr;
 
-	down(&intf->cmd_rcvrs_lock);
+	mutex_lock(&intf->cmd_rcvrs_mutex);
 	/* Make sure the command/netfn is not already registered. */
 	rcvr = find_cmd_rcvr(intf, netfn, cmd);
 	if ((rcvr) && (rcvr->user == user)) {
 		list_del_rcu(&rcvr->link);
-		up(&intf->cmd_rcvrs_lock);
+		mutex_unlock(&intf->cmd_rcvrs_mutex);
 		synchronize_rcu();
 		kfree(rcvr);
 		return 0;
 	} else {
-		up(&intf->cmd_rcvrs_lock);
+		mutex_unlock(&intf->cmd_rcvrs_mutex);
 		return -ENOENT;
 	}
 }
@@ -2368,7 +2369,7 @@ int ipmi_register_smi(struct ipmi_smi_ha
 	spin_lock_init(&intf->events_lock);
 	INIT_LIST_HEAD(&intf->waiting_events);
 	intf->waiting_events_count = 0;
-	init_MUTEX(&intf->cmd_rcvrs_lock);
+	mutex_init(&intf->cmd_rcvrs_mutex);
 	INIT_LIST_HEAD(&intf->cmd_rcvrs);
 	init_waitqueue_head(&intf->waitq);
 
Index: linux-2.6.16/drivers/char/ipmi/ipmi_watchdog.c
===================================================================
--- linux-2.6.16.orig/drivers/char/ipmi/ipmi_watchdog.c
+++ linux-2.6.16/drivers/char/ipmi/ipmi_watchdog.c
@@ -39,6 +39,7 @@
 #include <linux/watchdog.h>
 #include <linux/miscdevice.h>
 #include <linux/init.h>
+#include <linux/completion.h>
 #include <linux/rwsem.h>
 #include <linux/errno.h>
 #include <asm/uaccess.h>
@@ -303,21 +304,22 @@ static int ipmi_heartbeat(void);
 static void panic_halt_ipmi_heartbeat(void);
 
 
-/* We use a semaphore to make sure that only one thing can send a set
+/* We use a mutex to make sure that only one thing can send a set
    timeout at one time, because we only have one copy of the data.
-   The semaphore is claimed when the set_timeout is sent and freed
+   The mutex is claimed when the set_timeout is sent and freed
    when both messages are free. */
 static atomic_t set_timeout_tofree = ATOMIC_INIT(0);
-static DECLARE_MUTEX(set_timeout_lock);
+static DEFINE_MUTEX(set_timeout_lock);
+static DECLARE_COMPLETION(set_timeout_wait);
 static void set_timeout_free_smi(struct ipmi_smi_msg *msg)
 {
     if (atomic_dec_and_test(&set_timeout_tofree))
-	    up(&set_timeout_lock);
+	    complete(&set_timeout_wait);
 }
 static void set_timeout_free_recv(struct ipmi_recv_msg *msg)
 {
     if (atomic_dec_and_test(&set_timeout_tofree))
-	    up(&set_timeout_lock);
+	    complete(&set_timeout_wait);
 }
 static struct ipmi_smi_msg set_timeout_smi_msg =
 {
@@ -399,7 +401,7 @@ static int ipmi_set_timeout(int do_heart
 
 
 	/* We can only send one of these at a time. */
-	down(&set_timeout_lock);
+	mutex_lock(&set_timeout_lock);
 
 	atomic_set(&set_timeout_tofree, 2);
 
@@ -407,16 +409,21 @@ static int ipmi_set_timeout(int do_heart
 				&set_timeout_recv_msg,
 				&send_heartbeat_now);
 	if (rv) {
-		up(&set_timeout_lock);
-	} else {
-		if ((do_heartbeat == IPMI_SET_TIMEOUT_FORCE_HB)
-		    || ((send_heartbeat_now)
-			&& (do_heartbeat == IPMI_SET_TIMEOUT_HB_IF_NECESSARY)))
-		{
-			rv = ipmi_heartbeat();
-		}
+		mutex_unlock(&set_timeout_lock);
+		goto out;
+	}
+
+	wait_for_completion(&set_timeout_wait);
+
+	if ((do_heartbeat == IPMI_SET_TIMEOUT_FORCE_HB)
+	    || ((send_heartbeat_now)
+		&& (do_heartbeat == IPMI_SET_TIMEOUT_HB_IF_NECESSARY)))
+	{
+		rv = ipmi_heartbeat();
 	}
+	mutex_unlock(&set_timeout_lock);
 
+out:
 	return rv;
 }
 
@@ -458,17 +465,17 @@ static void panic_halt_ipmi_set_timeout(
    The semaphore is claimed when the set_timeout is sent and freed
    when both messages are free. */
 static atomic_t heartbeat_tofree = ATOMIC_INIT(0);
-static DECLARE_MUTEX(heartbeat_lock);
-static DECLARE_MUTEX_LOCKED(heartbeat_wait_lock);
+static DEFINE_MUTEX(heartbeat_lock);
+static DECLARE_COMPLETION(heartbeat_wait);
 static void heartbeat_free_smi(struct ipmi_smi_msg *msg)
 {
     if (atomic_dec_and_test(&heartbeat_tofree))
-	    up(&heartbeat_wait_lock);
+	    complete(&heartbeat_wait);
 }
 static void heartbeat_free_recv(struct ipmi_recv_msg *msg)
 {
     if (atomic_dec_and_test(&heartbeat_tofree))
-	    up(&heartbeat_wait_lock);
+	    complete(&heartbeat_wait);
 }
 static struct ipmi_smi_msg heartbeat_smi_msg =
 {
@@ -511,14 +518,14 @@ static int ipmi_heartbeat(void)
 		return ipmi_set_timeout(IPMI_SET_TIMEOUT_HB_IF_NECESSARY);
 	}
 
-	down(&heartbeat_lock);
+	mutex_lock(&heartbeat_lock);
 
 	atomic_set(&heartbeat_tofree, 2);
 
 	/* Don't reset the timer if we have the timer turned off, that
            re-enables the watchdog. */
 	if (ipmi_watchdog_state == WDOG_TIMEOUT_NONE) {
-		up(&heartbeat_lock);
+		mutex_unlock(&heartbeat_lock);
 		return 0;
 	}
 
@@ -539,14 +546,14 @@ static int ipmi_heartbeat(void)
 				      &heartbeat_recv_msg,
 				      1);
 	if (rv) {
-		up(&heartbeat_lock);
+		mutex_unlock(&heartbeat_lock);
 		printk(KERN_WARNING PFX "heartbeat failure: %d\n",
 		       rv);
 		return rv;
 	}
 
 	/* Wait for the heartbeat to be sent. */
-	down(&heartbeat_wait_lock);
+	wait_for_completion(&heartbeat_wait);
 
 	if (heartbeat_recv_msg.msg.data[0] != 0) {
 	    /* Got an error in the heartbeat response.  It was already
@@ -555,7 +562,7 @@ static int ipmi_heartbeat(void)
 	    rv = -EINVAL;
 	}
 
-	up(&heartbeat_lock);
+	mutex_unlock(&heartbeat_lock);
 
 	return rv;
 }
Index: linux-2.6.16/drivers/char/ipmi/ipmi_si_intf.c
===================================================================
--- linux-2.6.16.orig/drivers/char/ipmi/ipmi_si_intf.c
+++ linux-2.6.16/drivers/char/ipmi/ipmi_si_intf.c
@@ -1016,7 +1016,7 @@ static struct ipmi_smi_handlers handlers
 
 #define SI_MAX_PARMS 4
 static LIST_HEAD(smi_infos);
-static DECLARE_MUTEX(smi_infos_lock);
+static DEFINE_MUTEX(smi_infos_lock);
 static int smi_num; /* Used to sequence the SMIs */
 
 #define DEFAULT_REGSPACING	1
@@ -2278,7 +2278,7 @@ static int try_smi_init(struct smi_info 
 		       new_smi->slave_addr, new_smi->irq);
 	}
 
-	down(&smi_infos_lock);
+	mutex_lock(&smi_infos_lock);
 	if (!is_new_interface(new_smi)) {
 		printk(KERN_WARNING "ipmi_si: duplicate interface\n");
 		rv = -EBUSY;
@@ -2434,7 +2434,7 @@ static int try_smi_init(struct smi_info 
 
 	list_add_tail(&new_smi->link, &smi_infos);
 
-	up(&smi_infos_lock);
+	mutex_unlock(&smi_infos_lock);
 
 	printk(" IPMI %s interface initialized\n",si_to_str[new_smi->si_type]);
 
@@ -2471,7 +2471,7 @@ static int try_smi_init(struct smi_info 
 
 	kfree(new_smi);
 
-	up(&smi_infos_lock);
+	mutex_unlock(&smi_infos_lock);
 
 	return rv;
 }
@@ -2529,26 +2529,26 @@ static __devinit int init_ipmi_si(void)
 #endif
 
 	if (si_trydefaults) {
-		down(&smi_infos_lock);
+		mutex_lock(&smi_infos_lock);
 		if (list_empty(&smi_infos)) {
 			/* No BMC was found, try defaults. */
-			up(&smi_infos_lock);
+			mutex_unlock(&smi_infos_lock);
 			default_find_bmc();
 		} else {
-			up(&smi_infos_lock);
+			mutex_unlock(&smi_infos_lock);
 		}
 	}
 
-	down(&smi_infos_lock);
+	mutex_lock(&smi_infos_lock);
 	if (list_empty(&smi_infos)) {
-		up(&smi_infos_lock);
+		mutex_unlock(&smi_infos_lock);
 #ifdef CONFIG_PCI
 		pci_unregister_driver(&ipmi_pci_driver);
 #endif
 		printk("ipmi_si: Unable to find any System Interface(s)\n");
 		return -ENODEV;
 	} else {
-		up(&smi_infos_lock);
+		mutex_unlock(&smi_infos_lock);
 		return 0;
 	}
 }
@@ -2624,10 +2624,10 @@ static __exit void cleanup_ipmi_si(void)
 	pci_unregister_driver(&ipmi_pci_driver);
 #endif
 
-	down(&smi_infos_lock);
+	mutex_lock(&smi_infos_lock);
 	list_for_each_entry_safe(e, tmp_e, &smi_infos, link)
 		cleanup_one_si(e);
-	up(&smi_infos_lock);
+	mutex_unlock(&smi_infos_lock);
 
 	driver_unregister(&ipmi_driver);
 }
