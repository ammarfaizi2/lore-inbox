Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265557AbTFMX15 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 19:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265571AbTFMX15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 19:27:57 -0400
Received: from air-2.osdl.org ([65.172.181.6]:28041 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265557AbTFMX1q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 19:27:46 -0400
Date: Fri, 13 Jun 2003 16:41:19 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: "David S. Miller" <davem@redhat.com>, Greg KH <greg@kroah.com>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [PATCH] network hotplug via class_device/kobject
Message-Id: <20030613164119.15209934.shemminger@osdl.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes network devices to run hotplug out of the kobject/class_device
infrastructure rather than calling it from the network core. The code gets simpler
and there is only one place for Greg to fix when he changes the API ;-)

All hotplug now happens off the chain:
	rtnl_unlock -> netdev_run_todo -> netdev_sysfs_{un}register 

The state flag "deadbeaf" was convertied to a state enumeration to handle the
necessary book keeping, and adds some defense against drivers that have unexpected
semantics. Paranoid about some driver doing something like:
	rtnl_lock(); register_netdevice(); unregister_netdevice(); rtnl_unlock() BOOM

This patch causes an external script API change.
Because network device go through the standard path, the action passed to the script
is no longer register or unregister but is now "add" or "remove" like other devices.
This is a good thing.  When testing (at least on RHAT) just change /etc/hotplug/net.agent
case statement:
	
case $ACTION in
add|register)
    # Don't do anything if the network is stopped
    if [ ! -f /var/lock/subsys/network ]; then
	exit 0
    fi

Dave, this patch is against your temporary bk tree with earlier net-sysfs cleanups.

diff -Nru a/include/linux/netdevice.h b/include/linux/netdevice.h
--- a/include/linux/netdevice.h	Fri Jun 13 16:29:18 2003
+++ b/include/linux/netdevice.h	Fri Jun 13 16:29:18 2003
@@ -355,8 +355,16 @@
 	spinlock_t		queue_lock;
 	/* Number of references to this device */
 	atomic_t		refcnt;
-	/* The flag marking that device is unregistered, but held by an user */
-	int			deadbeaf;
+	/* delayed register/unregister */
+	struct list_head	todo_list;
+
+	/* register/unregister state machine */
+	enum { NETREG_UNINITIALIZED=0,
+	       NETREG_REGISTERING,	/* called register_netdevice */
+	       NETREG_REGISTERED,	/* completed register todo */
+	       NETREG_UNREGISTERING,	/* called unregister_netdevice */
+	       NETREG_UNREGISTERED,	/* completed unregister todo */
+	} reg_state;
 
 	/* Net device features */
 	int			features;
diff -Nru a/net/core/dev.c b/net/core/dev.c
--- a/net/core/dev.c	Fri Jun 13 16:29:18 2003
+++ b/net/core/dev.c	Fri Jun 13 16:29:18 2003
@@ -168,14 +168,6 @@
 static struct timer_list samp_timer = TIMER_INITIALIZER(sample_queue, 0, 0);
 #endif
 
-#ifdef CONFIG_HOTPLUG
-static void net_run_sbin_hotplug(struct net_device *dev, int is_register);
-static void net_run_hotplug_todo(void);
-#else
-#define net_run_sbin_hotplug(dev, is_register) do { } while (0)
-#define net_run_hotplug_todo() do { } while (0)
-#endif
-
 /*
  *	Our notifier list
  */
@@ -2537,6 +2529,17 @@
 
 static int dev_boot_phase = 1;
 
+/* Delayed registration/unregisteration */
+static spinlock_t net_todo_list_lock = SPIN_LOCK_UNLOCKED;
+static struct list_head net_todo_list = LIST_HEAD_INIT(net_todo_list);
+
+static inline void net_set_todo(struct net_device *dev)
+{
+	spin_lock(&net_todo_list_lock);
+	list_add_tail(&dev->todo_list, &net_todo_list);
+	spin_unlock(&net_todo_list_lock);
+}
+
 /**
  *	register_netdevice	- register a network device
  *	@dev: device to register
@@ -2563,6 +2566,9 @@
 	BUG_ON(dev_boot_phase);
 	ASSERT_RTNL();
 
+	/* When net_device's are persistent, this will be fatal. */
+	WARN_ON(dev->reg_state != NETREG_UNINITIALIZED);
+
 	spin_lock_init(&dev->queue_lock);
 	spin_lock_init(&dev->xmit_lock);
 	dev->xmit_lock_owner = -1;
@@ -2592,9 +2598,6 @@
 			goto out_err;
 	}
 	
-	if ((ret = netdev_register_sysfs(dev)))
-	    goto out_err;
-
 	/* Fix illegal SG+CSUM combinations. */
 	if ((dev->features & NETIF_F_SG) &&
 	    !(dev->features & (NETIF_F_IP_CSUM |
@@ -2625,13 +2628,14 @@
 	write_lock_bh(&dev_base_lock);
 	*dp = dev;
 	dev_hold(dev);
-	dev->deadbeaf = 0;
+	dev->reg_state = NETREG_REGISTERING;
 	write_unlock_bh(&dev_base_lock);
 
 	/* Notify protocols, that a new device appeared. */
 	notifier_call_chain(&netdev_chain, NETDEV_REGISTER, dev);
 
-	net_run_sbin_hotplug(dev, 1);
+	/* Finish registration after unlock */
+	net_set_todo(dev);
 	ret = 0;
 
 out:
@@ -2654,7 +2658,7 @@
 	BUG_TRAP(!dev->ip6_ptr);
 	BUG_TRAP(!dev->dn_ptr);
 
-	if (!dev->deadbeaf) {
+	if (dev->reg_state != NETREG_UNREGISTERED) {
 		printk(KERN_ERR "Freeing alive device %p, %s\n",
 		       dev, dev->name);
 		return 0;
@@ -2731,41 +2735,60 @@
  *	rtnl_unlock();
  *
  * We are invoked by rtnl_unlock() after it drops the semaphore.
- * This allows us to deal with two problems:
- * 1) We can invoke hotplug without deadlocking with linkwatch via
- *    keventd.
+ * This allows us to deal with problems:
+ * 1) We can create/delete sysfs objects which invoke hotplug
+ *    without deadlocking with linkwatch via keventd.
  * 2) Since we run with the RTNL semaphore not held, we can sleep
  *    safely in order to wait for the netdev refcnt to drop to zero.
  */
-static spinlock_t unregister_todo_lock = SPIN_LOCK_UNLOCKED;
-static struct net_device *unregister_todo;
-
+static DECLARE_MUTEX(net_todo_run_mutex);
 void netdev_run_todo(void)
 {
-	struct net_device *dev;
-
-	net_run_hotplug_todo();
-
-	spin_lock(&unregister_todo_lock);
-	dev = unregister_todo;
-	unregister_todo = NULL;
-	spin_unlock(&unregister_todo_lock);
-
-	while (dev) {
-		struct net_device *next = dev->next;
-
-		dev->next = NULL;
+	struct list_head list = LIST_HEAD_INIT(list);
 
-		netdev_unregister_sysfs(dev);
+	/* Safe outside mutex since we only care about entries that
+	 * this cpu put into queue while under RTNL.
+	 */
+	if (list_empty(&net_todo_list))
+		return;
 
-		netdev_wait_allrefs(dev);
+	/* Need to guard against multiple cpu's getting out of order. */
+	down(&net_todo_run_mutex);
 
-		BUG_ON(atomic_read(&dev->refcnt));
+	/* Snapshot list, allow later requests */
+	spin_lock(&net_todo_list_lock);
+	list_splice_init(&net_todo_list, &list);
+	spin_unlock(&net_todo_list_lock);
+		
+	while (!list_empty(&list)) {
+		struct net_device *dev
+			= list_entry(list.next, struct net_device, todo_list);
+		list_del(&dev->todo_list);
+
+		switch(dev->reg_state) {
+		case NETREG_REGISTERING:
+			netdev_register_sysfs(dev);
+			dev->reg_state = NETREG_REGISTERED;
+			break;
 
-		netdev_finish_unregister(dev);
+		case NETREG_UNREGISTERING:
+			netdev_unregister_sysfs(dev);
+			dev->reg_state = NETREG_UNREGISTERED;
+
+			netdev_wait_allrefs(dev);
+			BUG_ON(atomic_read(&dev->refcnt));
+				
+			netdev_finish_unregister(dev);
+			break;
 
-		dev = next;
+		default:
+			printk(KERN_ERR "network todo '%s' but state %d\n",
+			       dev->name, dev->reg_state);
+			break;
+		}
 	}
+
+	up(&net_todo_run_mutex);
 }
 
 /* Synchronize with packet receive processing. */
@@ -2795,13 +2818,19 @@
 	BUG_ON(dev_boot_phase);
 	ASSERT_RTNL();
 
+	/* Some devices call without registering for initialization unwind. */
+	if (dev->reg_state == NETREG_UNINITIALIZED) {
+		printk(KERN_DEBUG "unregister_netdevice: device %s/%p never "
+				  "was registered\n", dev->name, dev);
+		return -ENODEV;
+	}
+
+	BUG_ON(dev->reg_state != NETREG_REGISTERED);
+
 	/* If device is running, close it first. */
 	if (dev->flags & IFF_UP)
 		dev_close(dev);
 
-	BUG_TRAP(!dev->deadbeaf);
-	dev->deadbeaf = 1;
-
 	/* And unlink it from device chain. */
 	for (dp = &dev_base; (d = *dp) != NULL; dp = &d->next) {
 		if (d == dev) {
@@ -2812,11 +2841,13 @@
 		}
 	}
 	if (!d) {
-		printk(KERN_DEBUG "unregister_netdevice: device %s/%p never "
-				  "was registered\n", dev->name, dev);
+		printk(KERN_ERR "unregister net_device: '%s' not found\n",
+		       dev->name);
 		return -ENODEV;
 	}
 
+	dev->reg_state = NETREG_UNREGISTERING;
+
 	synchronize_net();
 
 #ifdef CONFIG_NET_FASTROUTE
@@ -2826,7 +2857,6 @@
 	/* Shutdown queueing discipline. */
 	dev_shutdown(dev);
 
-	net_run_sbin_hotplug(dev, 0);
 	
 	/* Notify protocols, that we are about to destroy
 	   this device. They should clean all the things.
@@ -2846,10 +2876,8 @@
 
 	free_divert_blk(dev);
 
-	spin_lock(&unregister_todo_lock);
-	dev->next = unregister_todo;
-	unregister_todo = dev;
-	spin_unlock(&unregister_todo_lock);
+	/* Finish processing unregister after unlock */
+	net_set_todo(dev);
 
 	dev_put(dev);
 	return 0;
@@ -2955,11 +2983,11 @@
 			 * dev_alloc_name can now advance to next suitable
 			 * name that is checked next.
 			 */
-			dev->deadbeaf = 1;
 			dp = &dev->next;
 		} else {
 			dp = &dev->next;
 			dev->ifindex = dev_new_index();
+			dev->reg_state = NETREG_REGISTERED;
 			if (dev->iflink == -1)
 				dev->iflink = dev->ifindex;
 			if (!dev->rebuild_header)
@@ -2974,7 +3002,7 @@
 	 */
 	dp = &dev_base;
 	while ((dev = *dp) != NULL) {
-		if (dev->deadbeaf) {
+		if (dev->reg_state != NETREG_REGISTERED) {
 			write_lock_bh(&dev_base_lock);
 			*dp = dev->next;
 			write_unlock_bh(&dev_base_lock);
@@ -3001,96 +3029,3 @@
 }
 
 subsys_initcall(net_dev_init);
-
-#ifdef CONFIG_HOTPLUG
-
-struct net_hotplug_todo {
-	struct list_head	list;
-	char			ifname[IFNAMSIZ];
-	int			is_register;
-};
-static spinlock_t net_hotplug_list_lock = SPIN_LOCK_UNLOCKED;
-static DECLARE_MUTEX(net_hotplug_run);
-static struct list_head net_hotplug_list = LIST_HEAD_INIT(net_hotplug_list);
-
-static inline void net_run_hotplug_one(struct net_hotplug_todo *ent)
-{
-	char *argv[3], *envp[5], ifname[12 + IFNAMSIZ], action_str[32];
-	int i;
-
-	sprintf(ifname, "INTERFACE=%s", ent->ifname);
-	sprintf(action_str, "ACTION=%s",
-		(ent->is_register ? "register" : "unregister"));
-
-        i = 0;
-        argv[i++] = hotplug_path;
-        argv[i++] = "net";
-        argv[i] = 0;
-
-	i = 0;
-	/* minimal command environment */
-	envp [i++] = "HOME=/";
-	envp [i++] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
-	envp [i++] = ifname;
-	envp [i++] = action_str;
-	envp [i] = 0;
-
-	call_usermodehelper(argv [0], argv, envp, 0);
-}
-
-/* Run all queued hotplug requests. 
- * Requests are run in FIFO order.
- */
-static void net_run_hotplug_todo(void)
-{
-	struct list_head list = LIST_HEAD_INIT(list);
-
-	/* This is racy but okay since any other requests will get
-	 * processed when the other guy does rtnl_unlock.
-	 */
-	if (list_empty(&net_hotplug_list))
-		return;
-
-	/* Need to guard against multiple cpu's getting out of order. */
-	down(&net_hotplug_run);	
-
-	/* Snapshot list, allow later requests */
-	spin_lock(&net_hotplug_list_lock);
-	list_splice_init(&net_hotplug_list, &list);
-	spin_unlock(&net_hotplug_list_lock);
-
-	while (!list_empty(&list)) {
-		struct net_hotplug_todo *ent;
-
-		ent = list_entry(list.next, struct net_hotplug_todo, list);
-		list_del(&ent->list);
-		net_run_hotplug_one(ent);
-		kfree(ent);
-	}
-
-	up(&net_hotplug_run);
-}
-
-/* Notify userspace when a netdevice event occurs,
- * by running '/sbin/hotplug net' with certain
- * environment variables set.
- */
-
-static void net_run_sbin_hotplug(struct net_device *dev, int is_register)
-{
-	struct net_hotplug_todo *ent = kmalloc(sizeof(*ent), GFP_KERNEL);
-
-	ASSERT_RTNL();
-
-	if (!ent)
-		return;
-
-	INIT_LIST_HEAD(&ent->list);
-	memcpy(ent->ifname, dev->name, IFNAMSIZ);
-	ent->is_register = is_register;
-
-	spin_lock(&net_hotplug_list_lock);
-	list_add(&ent->list, &net_hotplug_list);
-	spin_unlock(&net_hotplug_list_lock);
-}
-#endif
diff -Nru a/net/core/net-sysfs.c b/net/core/net-sysfs.c
--- a/net/core/net-sysfs.c	Fri Jun 13 16:29:18 2003
+++ b/net/core/net-sysfs.c	Fri Jun 13 16:29:18 2003
@@ -15,6 +15,11 @@
 #define to_class_dev(obj) container_of(obj,struct class_device,kobj)
 #define to_net_dev(class) container_of(class, struct net_device, class_dev)
 
+static inline int dev_isalive(const struct net_device *dev) 
+{
+	return dev->reg_state == NETREG_REGISTERED;
+}
+
 /* use same locking rules as GIF* ioctl's */
 static ssize_t netdev_show(const struct class_device *cd, char *buf,
 			   ssize_t (*format)(const struct net_device *, char *))
@@ -23,7 +28,7 @@
 	ssize_t ret = -EINVAL;
 
 	read_lock(&dev_base_lock);
-	if (!net->deadbeaf)
+	if (dev_isalive(net))
 		ret = (*format)(net, buf);
 	read_unlock(&dev_base_lock);
 
@@ -60,7 +65,7 @@
 		goto err;
 
 	rtnl_lock();
-	if (!net->deadbeaf) {
+	if (dev_isalive(net)) {
 		if ((ret = (*set)(net, new)) == 0)
 			ret = len;
 	}
@@ -97,17 +102,17 @@
 static ssize_t show_address(struct class_device *dev, char *buf)
 {
 	struct net_device *net = to_net_dev(dev);
-	if (net->deadbeaf)
-		return -EINVAL;
-	return format_addr(buf, net->dev_addr, net->addr_len);
+	if (dev_isalive(net))
+	    return format_addr(buf, net->dev_addr, net->addr_len);
+	return -EINVAL;
 }
 
 static ssize_t show_broadcast(struct class_device *dev, char *buf)
 {
 	struct net_device *net = to_net_dev(dev);
-	if (net->deadbeaf)
-		return -EINVAL;
-	return format_addr(buf, net->broadcast, net->addr_len);
+	if (dev_isalive(net))
+		return format_addr(buf, net->broadcast, net->addr_len);
+	return -EINVAL;
 }
 
 static CLASS_DEVICE_ATTR(address, S_IRUGO, show_address, NULL);
@@ -152,16 +157,12 @@
 
 static ssize_t store_tx_queue_len(struct class_device *dev, const char *buf, size_t len)
 {
-	return netdev_store(dev, buf,len, change_tx_queue_len);
+	return netdev_store(dev, buf, len, change_tx_queue_len);
 }
 
 static CLASS_DEVICE_ATTR(tx_queue_len, S_IRUGO | S_IWUSR, show_tx_queue_len, 
 			 store_tx_queue_len);
 
-static struct class net_class = {
-	.name = "net",
-};
-
 
 static struct class_device_attribute *net_class_attributes[] = {
 	&class_device_attr_ifindex,
@@ -263,7 +264,7 @@
 	ssize_t ret = -EINVAL;
 	
 	read_lock(&dev_base_lock);
-	if (!dev->deadbeaf && entry->show && dev->get_stats &&
+	if (dev_isalive(dev) && entry->show && dev->get_stats &&
 	    (stats = (*dev->get_stats)(dev)))
 		ret = entry->show(stats, buf);
 	read_unlock(&dev_base_lock);
@@ -277,6 +278,35 @@
 static struct kobj_type netstat_ktype = {
 	.sysfs_ops	= &netstat_sysfs_ops,
 	.default_attrs  = default_attrs,
+};
+
+#ifdef CONFIG_HOTPLUG
+static int netdev_hotplug(struct class_device *cd, char **envp,
+			  int num_envp, char *buf, int size)
+{
+	struct net_device *dev = to_net_dev(cd);
+	int i = 0;
+	int n;
+
+	/* pass interface in env to hotplug. */
+	envp[i++] = buf;
+	n = snprintf(buf, size, "INTERFACE=%s", dev->name) + 1;
+	buf += n;
+	size -= n;
+
+	if ((size <= 0) || (i >= num_envp))
+		return -ENOMEM;
+
+	envp[i] = 0;
+	return 0;
+}
+#endif
+
+static struct class net_class = {
+	.name = "net",
+#ifdef CONFIG_HOTPLUG
+	.hotplug = netdev_hotplug,
+#endif
 };
 
 /* Create sysfs entries for network device. */
