Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262265AbSJKBgP>; Thu, 10 Oct 2002 21:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262269AbSJKBgP>; Thu, 10 Oct 2002 21:36:15 -0400
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:14046 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id <S262265AbSJKBgJ>; Thu, 10 Oct 2002 21:36:09 -0400
Message-ID: <3DA62C5E.6030901@sun.com>
Date: Thu, 10 Oct 2002 18:41:50 -0700
From: Tim Hockin <thockin@sun.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: PATCH idea
Content-Type: multipart/mixed;
 boundary="------------040802040306060306000600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040802040306060306000600
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Looking for feedback on this quickie patch.  This enables netlink to 
deliver link-change events, as reported by drivers via 
netif_carrier_{on,off}.

* We could use a different RTM than NEWLINK (RTM_LINKCHANGE?) if we care
* We could do notifier_call_chain(netdev_chain) with NETDEV_UP or 
NETDEV_LINKCHANGE (new) if we care

comments?
-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Linux Kernel Engineering
thockin@sun.com

--------------040802040306060306000600
Content-Type: text/plain;
 name="link_change_via_netlink.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="link_change_via_netlink.diff"

===== drivers/net/net_init.c 1.9 vs edited =====
--- 1.9/drivers/net/net_init.c	Mon Feb  4 23:44:55 2002
+++ edited/drivers/net/net_init.c	Thu Oct 10 11:44:18 2002
@@ -93,6 +93,7 @@
 		dev->priv = (void *) (((long)(dev + 1) + 31) & ~31);
 
 	setup(dev);
+	INIT_WORK(&dev->link_work, NULL, NULL);
 	strcpy(dev->name, mask);
 
 	return dev;
@@ -163,6 +164,7 @@
 	 */
 	
 	setup(dev);
+	INIT_WORK(&dev->link_work, NULL, NULL);
 	
 	if (new_device) {
 		int err;
===== include/linux/netdevice.h 1.24 vs edited =====
--- 1.24/include/linux/netdevice.h	Fri Oct  4 19:17:35 2002
+++ edited/include/linux/netdevice.h	Thu Oct 10 14:56:23 2002
@@ -35,6 +35,7 @@
 
 #ifdef __KERNEL__
 #include <linux/config.h>
+#include <linux/workqueue.h>
 #ifdef CONFIG_NET_PROFILE
 #include <net/profile.h>
 #endif
@@ -437,6 +438,7 @@
 	/* this will get initialized at each interface type init routine */
 	struct divert_blk	*divert;
 #endif /* CONFIG_NET_DIVERT */
+	struct work_struct	link_work;
 };
 
 
@@ -637,17 +639,20 @@
 }
 
 extern void __netdev_watchdog_up(struct net_device *dev);
+extern void netdev_do_link_work(struct net_device *dev);
 
 static inline void netif_carrier_on(struct net_device *dev)
 {
 	clear_bit(__LINK_STATE_NOCARRIER, &dev->state);
 	if (netif_running(dev))
 		__netdev_watchdog_up(dev);
+	netdev_do_link_work(dev);
 }
 
 static inline void netif_carrier_off(struct net_device *dev)
 {
 	set_bit(__LINK_STATE_NOCARRIER, &dev->state);
+	netdev_do_link_work(dev);
 }
 
 /* Hot-plugging. */
===== include/linux/workqueue.h 1.3 vs edited =====
--- 1.3/include/linux/workqueue.h	Thu Oct  3 14:29:58 2002
+++ edited/include/linux/workqueue.h	Thu Oct 10 16:50:36 2002
@@ -7,6 +7,7 @@
 
 #include <linux/timer.h>
 #include <linux/linkage.h>
+#include <linux/spinlock.h>
 
 struct workqueue_struct;
 
@@ -17,12 +18,15 @@
 	void *data;
 	void *wq_data;
 	struct timer_list timer;
+	spinlock_t lock;
 };
 
 #define __WORK_INITIALIZER(n, f, d) {				\
         .entry	= { &(n).entry, &(n).entry },			\
+	.pending = 0,						\
 	.func = (f),						\
-	.data = (d) }
+	.data = (d),						\
+	.lock = SPIN_LOCK_UNLOCKED }
 
 #define DECLARE_WORK(n, f, d)					\
 	struct work_struct n = __WORK_INITIALIZER(n, f, d)
@@ -45,6 +49,7 @@
 		(_work)->pending = 0;				\
 		PREPARE_WORK((_work), (_func), (_data));	\
 		init_timer(&(_work)->timer);			\
+		spin_lock_init(&(_work)->lock);			\
 	} while (0)
 
 extern struct workqueue_struct *create_workqueue(const char *name);
@@ -56,10 +61,13 @@
 
 extern int FASTCALL(schedule_work(struct work_struct *work));
 extern int FASTCALL(schedule_delayed_work(struct work_struct *work, unsigned long delay));
+extern int FASTCALL(cancel_work(struct work_struct *work));
 extern void flush_scheduled_work(void);
 extern int current_is_keventd(void);
 
 extern void init_workqueues(void);
+
+#define work_pending(_work)	test_bit(0, &(_work)->pending)
 
 #endif
 
===== kernel/workqueue.c 1.3 vs edited =====
--- 1.3/kernel/workqueue.c	Thu Oct  3 05:37:56 2002
+++ edited/kernel/workqueue.c	Thu Oct 10 17:12:28 2002
@@ -140,10 +140,13 @@
 		void *data = work->data;
 
 		list_del_init(cwq->worklist.next);
-		spin_unlock_irqrestore(&cwq->lock, flags);
+		spin_lock(&work->lock);
+		spin_unlock(&cwq->lock);
 
 		BUG_ON(work->wq_data != cwq);
 		clear_bit(0, &work->pending);
+		spin_unlock_irqrestore(&work->lock, flags);
+		
 		f(data);
 
 		/*
@@ -354,6 +357,28 @@
 	flush_workqueue(keventd_wq);
 }
 
+int cancel_work(struct work_struct *work)
+{
+	unsigned long flags;
+	struct cpu_workqueue_struct *cwq;
+	int cancelled = 0;
+
+	/* this should be safe to read - it only races with queue_*work() */
+	cwq = work->wq_data;
+
+	spin_lock_irqsave(&cwq->lock, flags);
+	spin_lock(&work->lock);
+	if (work_pending(work)) {
+		list_del_init(&work->entry);
+		clear_bit(0, &work->pending);
+		cancelled = 1;
+	}
+	spin_unlock(&work->lock);
+	spin_unlock_irqrestore(&cwq->lock, flags);
+
+	return cancelled;
+}
+
 int current_is_keventd(void)
 {
 	struct cpu_workqueue_struct *cwq;
@@ -386,4 +411,5 @@
 EXPORT_SYMBOL(schedule_work);
 EXPORT_SYMBOL(schedule_delayed_work);
 EXPORT_SYMBOL(flush_scheduled_work);
+EXPORT_SYMBOL(cancel_work);
 
===== net/netsyms.c 1.29 vs edited =====
--- 1.29/net/netsyms.c	Fri Oct  4 19:17:35 2002
+++ edited/net/netsyms.c	Thu Oct 10 14:57:53 2002
@@ -471,6 +471,7 @@
 EXPORT_SYMBOL(register_netdevice);
 EXPORT_SYMBOL(unregister_netdevice);
 EXPORT_SYMBOL(netdev_state_change);
+EXPORT_SYMBOL(netdev_do_link_work);
 EXPORT_SYMBOL(dev_new_index);
 EXPORT_SYMBOL(dev_get_by_index);
 EXPORT_SYMBOL(__dev_get_by_index);
===== net/core/dev.c 1.41 vs edited =====
--- 1.41/net/core/dev.c	Mon Oct  7 05:31:06 2002
+++ edited/net/core/dev.c	Thu Oct 10 16:05:06 2002
@@ -629,6 +629,20 @@
 	}
 }
 
+static void do_link_work(void *cookie)
+{
+	struct net_device *dev = cookie;
+	rtnl_lock();
+	rtmsg_ifinfo(RTM_NEWLINK, dev, IFF_RUNNING);
+	rtnl_unlock();
+}
+
+void netdev_do_link_work(struct net_device *dev)
+{
+	cancel_work(&dev->link_work);
+	PREPARE_WORK(&dev->link_work, do_link_work, dev);
+	schedule_work(&dev->link_work);
+}
 
 #ifdef CONFIG_KMOD
 

--------------040802040306060306000600--

