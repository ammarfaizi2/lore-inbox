Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbWBJQEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbWBJQEO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 11:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbWBJQEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 11:04:13 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:19338 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751268AbWBJQEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 11:04:12 -0500
Date: Fri, 10 Feb 2006 11:04:11 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/8] Notifier chain update: Simple definition changes
Message-ID: <Pine.LNX.4.44L0.0602101103360.5227-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Notifier chain re-implementation (as633b): Simple changes that involve
only the definition or declaration of chain heads.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Chandra Seetharaman <sekharan@us.ibm.com>

Index: l2616/arch/alpha/kernel/setup.c
===================================================================
--- l2616.orig/arch/alpha/kernel/setup.c
+++ l2616/arch/alpha/kernel/setup.c
@@ -42,7 +42,7 @@
 #include <asm/setup.h>
 #include <asm/io.h>
 
-extern struct notifier_block *panic_notifier_list;
+extern struct atomic_notifier_head panic_notifier_list;
 static int alpha_panic_event(struct notifier_block *, unsigned long, void *);
 static struct notifier_block alpha_panic_block = {
 	alpha_panic_event,
@@ -507,7 +507,8 @@ setup_arch(char **cmdline_p)
 	}
 
 	/* Register a call for panic conditions. */
-	notifier_chain_register(&panic_notifier_list, &alpha_panic_block);
+	atomic_notifier_chain_register(&panic_notifier_list,
+			&alpha_panic_block);
 
 #ifdef CONFIG_ALPHA_GENERIC
 	/* Assume that we've booted from SRM if we haven't booted from MILO.
Index: l2616/net/ipv4/devinet.c
===================================================================
--- l2616.orig/net/ipv4/devinet.c
+++ l2616/net/ipv4/devinet.c
@@ -81,7 +81,7 @@ static struct ipv4_devconf ipv4_devconf_
 
 static void rtmsg_ifa(int event, struct in_ifaddr *);
 
-static struct notifier_block *inetaddr_chain;
+static BLOCKING_NOTIFIER_HEAD(inetaddr_chain);
 static void inet_del_ifa(struct in_device *in_dev, struct in_ifaddr **ifap,
 			 int destroy);
 #ifdef CONFIG_SYSCTL
@@ -267,7 +267,8 @@ static void inet_del_ifa(struct in_devic
 				*ifap1 = ifa->ifa_next;
 
 				rtmsg_ifa(RTM_DELADDR, ifa);
-				notifier_call_chain(&inetaddr_chain, NETDEV_DOWN, ifa);
+				blocking_notifier_call_chain(&inetaddr_chain,
+						NETDEV_DOWN, ifa);
 				inet_free_ifa(ifa);
 			} else {
 				promote = ifa;
@@ -291,7 +292,7 @@ static void inet_del_ifa(struct in_devic
 	   So that, this order is correct.
 	 */
 	rtmsg_ifa(RTM_DELADDR, ifa1);
-	notifier_call_chain(&inetaddr_chain, NETDEV_DOWN, ifa1);
+	blocking_notifier_call_chain(&inetaddr_chain, NETDEV_DOWN, ifa1);
 
 	if (promote) {
 
@@ -303,7 +304,8 @@ static void inet_del_ifa(struct in_devic
 
 		promote->ifa_flags &= ~IFA_F_SECONDARY;
 		rtmsg_ifa(RTM_NEWADDR, promote);
-		notifier_call_chain(&inetaddr_chain, NETDEV_UP, promote);
+		blocking_notifier_call_chain(&inetaddr_chain,
+				NETDEV_UP, promote);
 		for (ifa = promote->ifa_next; ifa; ifa = ifa->ifa_next) {
 			if (ifa1->ifa_mask != ifa->ifa_mask ||
 			    !inet_ifa_match(ifa1->ifa_address, ifa))
@@ -366,7 +368,7 @@ static int inet_insert_ifa(struct in_ifa
 	   Notifier will trigger FIB update, so that
 	   listeners of netlink will know about new ifaddr */
 	rtmsg_ifa(RTM_NEWADDR, ifa);
-	notifier_call_chain(&inetaddr_chain, NETDEV_UP, ifa);
+	blocking_notifier_call_chain(&inetaddr_chain, NETDEV_UP, ifa);
 
 	return 0;
 }
@@ -938,12 +940,12 @@ u32 inet_confirm_addr(const struct net_d
 
 int register_inetaddr_notifier(struct notifier_block *nb)
 {
-	return notifier_chain_register(&inetaddr_chain, nb);
+	return blocking_notifier_chain_register(&inetaddr_chain, nb);
 }
 
 int unregister_inetaddr_notifier(struct notifier_block *nb)
 {
-	return notifier_chain_unregister(&inetaddr_chain, nb);
+	return blocking_notifier_chain_unregister(&inetaddr_chain, nb);
 }
 
 /* Rename ifa_labels for a device name change. Make some effort to preserve existing
Index: l2616/net/bluetooth/hci_core.c
===================================================================
--- l2616.orig/net/bluetooth/hci_core.c
+++ l2616/net/bluetooth/hci_core.c
@@ -73,23 +73,23 @@ DEFINE_RWLOCK(hci_cb_list_lock);
 struct hci_proto *hci_proto[HCI_MAX_PROTO];
 
 /* HCI notifiers list */
-static struct notifier_block *hci_notifier;
+static ATOMIC_NOTIFIER_HEAD(hci_notifier);
 
 /* ---- HCI notifications ---- */
 
 int hci_register_notifier(struct notifier_block *nb)
 {
-	return notifier_chain_register(&hci_notifier, nb);
+	return atomic_notifier_chain_register(&hci_notifier, nb);
 }
 
 int hci_unregister_notifier(struct notifier_block *nb)
 {
-	return notifier_chain_unregister(&hci_notifier, nb);
+	return atomic_notifier_chain_unregister(&hci_notifier, nb);
 }
 
 static void hci_notify(struct hci_dev *hdev, int event)
 {
-	notifier_call_chain(&hci_notifier, event, hdev);
+	atomic_notifier_call_chain(&hci_notifier, event, hdev);
 }
 
 /* ---- HCI requests ---- */
Index: l2616/net/decnet/dn_dev.c
===================================================================
--- l2616.orig/net/decnet/dn_dev.c
+++ l2616/net/decnet/dn_dev.c
@@ -68,7 +68,7 @@ dn_address decnet_address = 0;
 
 static DEFINE_RWLOCK(dndev_lock);
 static struct net_device *decnet_default_device;
-static struct notifier_block *dnaddr_chain;
+static BLOCKING_NOTIFIER_HEAD(dnaddr_chain);
 
 static struct dn_dev *dn_dev_create(struct net_device *dev, int *err);
 static void dn_dev_delete(struct net_device *dev);
@@ -446,7 +446,7 @@ static void dn_dev_del_ifa(struct dn_dev
 	}
 
 	rtmsg_ifa(RTM_DELADDR, ifa1);
-	notifier_call_chain(&dnaddr_chain, NETDEV_DOWN, ifa1);
+	blocking_notifier_call_chain(&dnaddr_chain, NETDEV_DOWN, ifa1);
 	if (destroy) {
 		dn_dev_free_ifa(ifa1);
 
@@ -481,7 +481,7 @@ static int dn_dev_insert_ifa(struct dn_d
 	dn_db->ifa_list = ifa;
 
 	rtmsg_ifa(RTM_NEWADDR, ifa);
-	notifier_call_chain(&dnaddr_chain, NETDEV_UP, ifa);
+	blocking_notifier_call_chain(&dnaddr_chain, NETDEV_UP, ifa);
 
 	return 0;
 }
@@ -1285,12 +1285,12 @@ void dn_dev_devices_on(void)
 
 int register_dnaddr_notifier(struct notifier_block *nb)
 {
-	return notifier_chain_register(&dnaddr_chain, nb);
+	return blocking_notifier_chain_register(&dnaddr_chain, nb);
 }
 
 int unregister_dnaddr_notifier(struct notifier_block *nb)
 {
-	return notifier_chain_unregister(&dnaddr_chain, nb);
+	return blocking_notifier_chain_unregister(&dnaddr_chain, nb);
 }
 
 #ifdef CONFIG_PROC_FS
Index: l2616/net/netlink/af_netlink.c
===================================================================
--- l2616.orig/net/netlink/af_netlink.c
+++ l2616/net/netlink/af_netlink.c
@@ -122,7 +122,7 @@ static void netlink_destroy_callback(str
 static DEFINE_RWLOCK(nl_table_lock);
 static atomic_t nl_table_users = ATOMIC_INIT(0);
 
-static struct notifier_block *netlink_chain;
+static ATOMIC_NOTIFIER_HEAD(netlink_chain);
 
 static u32 netlink_group_mask(u32 group)
 {
@@ -450,7 +450,8 @@ static int netlink_release(struct socket
 						.protocol = sk->sk_protocol,
 						.pid = nlk->pid,
 					  };
-		notifier_call_chain(&netlink_chain, NETLINK_URELEASE, &n);
+		atomic_notifier_call_chain(&netlink_chain,
+				NETLINK_URELEASE, &n);
 	}	
 
 	if (nlk->module)
@@ -1649,12 +1650,12 @@ static struct file_operations netlink_se
 
 int netlink_register_notifier(struct notifier_block *nb)
 {
-	return notifier_chain_register(&netlink_chain, nb);
+	return atomic_notifier_chain_register(&netlink_chain, nb);
 }
 
 int netlink_unregister_notifier(struct notifier_block *nb)
 {
-	return notifier_chain_unregister(&netlink_chain, nb);
+	return atomic_notifier_chain_unregister(&netlink_chain, nb);
 }
                 
 static const struct proto_ops netlink_ops = {
Index: l2616/net/ipv6/addrconf.c
===================================================================
--- l2616.orig/net/ipv6/addrconf.c
+++ l2616/net/ipv6/addrconf.c
@@ -147,7 +147,7 @@ static void inet6_prefix_notify(int even
 				struct prefix_info *pinfo);
 static int ipv6_chk_same_addr(const struct in6_addr *addr, struct net_device *dev);
 
-static struct notifier_block *inet6addr_chain;
+static ATOMIC_NOTIFIER_HEAD(inet6addr_chain);
 
 struct ipv6_devconf ipv6_devconf = {
 	.forwarding		= 0,
@@ -583,7 +583,7 @@ out2:
 	read_unlock_bh(&addrconf_lock);
 
 	if (likely(err == 0))
-		notifier_call_chain(&inet6addr_chain, NETDEV_UP, ifa);
+		atomic_notifier_call_chain(&inet6addr_chain, NETDEV_UP, ifa);
 	else {
 		kfree(ifa);
 		ifa = ERR_PTR(err);
@@ -678,7 +678,7 @@ static void ipv6_del_addr(struct inet6_i
 
 	ipv6_ifa_notify(RTM_DELADDR, ifp);
 
-	notifier_call_chain(&inet6addr_chain,NETDEV_DOWN,ifp);
+	atomic_notifier_call_chain(&inet6addr_chain, NETDEV_DOWN, ifp);
 
 	addrconf_del_timer(ifp);
 
@@ -3716,12 +3716,12 @@ static void addrconf_sysctl_unregister(s
 
 int register_inet6addr_notifier(struct notifier_block *nb)
 {
-        return notifier_chain_register(&inet6addr_chain, nb);
+        return atomic_notifier_chain_register(&inet6addr_chain, nb);
 }
 
 int unregister_inet6addr_notifier(struct notifier_block *nb)
 {
-        return notifier_chain_unregister(&inet6addr_chain,nb);
+        return atomic_notifier_chain_unregister(&inet6addr_chain,nb);
 }
 
 /*
Index: l2616/arch/powerpc/platforms/pseries/reconfig.c
===================================================================
--- l2616.orig/arch/powerpc/platforms/pseries/reconfig.c
+++ l2616/arch/powerpc/platforms/pseries/reconfig.c
@@ -94,16 +94,16 @@ static struct device_node *derive_parent
 	return parent;
 }
 
-static struct notifier_block *pSeries_reconfig_chain;
+static BLOCKING_NOTIFIER_HEAD(pSeries_reconfig_chain);
 
 int pSeries_reconfig_notifier_register(struct notifier_block *nb)
 {
-	return notifier_chain_register(&pSeries_reconfig_chain, nb);
+	return blocking_notifier_chain_register(&pSeries_reconfig_chain, nb);
 }
 
 void pSeries_reconfig_notifier_unregister(struct notifier_block *nb)
 {
-	notifier_chain_unregister(&pSeries_reconfig_chain, nb);
+	blocking_notifier_chain_unregister(&pSeries_reconfig_chain, nb);
 }
 
 static int pSeries_reconfig_add_node(const char *path, struct property *proplist)
@@ -131,7 +131,7 @@ static int pSeries_reconfig_add_node(con
 		goto out_err;
 	}
 
-	err = notifier_call_chain(&pSeries_reconfig_chain,
+	err = blocking_notifier_call_chain(&pSeries_reconfig_chain,
 				  PSERIES_RECONFIG_ADD, np);
 	if (err == NOTIFY_BAD) {
 		printk(KERN_ERR "Failed to add device node %s\n", path);
@@ -171,7 +171,7 @@ static int pSeries_reconfig_remove_node(
 
 	remove_node_proc_entries(np);
 
-	notifier_call_chain(&pSeries_reconfig_chain,
+	blocking_notifier_call_chain(&pSeries_reconfig_chain,
 			    PSERIES_RECONFIG_REMOVE, np);
 	of_detach_node(np);
 
Index: l2616/arch/s390/kernel/process.c
===================================================================
--- l2616.orig/arch/s390/kernel/process.c
+++ l2616/arch/s390/kernel/process.c
@@ -76,17 +76,17 @@ unsigned long thread_saved_pc(struct tas
 /*
  * Need to know about CPUs going idle?
  */
-static struct notifier_block *idle_chain;
+static BLOCKING_NOTIFIER_HEAD(idle_chain);
 
 int register_idle_notifier(struct notifier_block *nb)
 {
-	return notifier_chain_register(&idle_chain, nb);
+	return blocking_notifier_chain_register(&idle_chain, nb);
 }
 EXPORT_SYMBOL(register_idle_notifier);
 
 int unregister_idle_notifier(struct notifier_block *nb)
 {
-	return notifier_chain_unregister(&idle_chain, nb);
+	return blocking_notifier_chain_unregister(&idle_chain, nb);
 }
 EXPORT_SYMBOL(unregister_idle_notifier);
 
@@ -95,7 +95,7 @@ void do_monitor_call(struct pt_regs *reg
 	/* disable monitor call class 0 */
 	__ctl_clear_bit(8, 15);
 
-	notifier_call_chain(&idle_chain, CPU_NOT_IDLE,
+	blocking_notifier_call_chain(&idle_chain, CPU_NOT_IDLE,
 			    (void *)(long) smp_processor_id());
 }
 
@@ -116,7 +116,8 @@ void default_idle(void)
 		return;
 	}
 
-	rc = notifier_call_chain(&idle_chain, CPU_IDLE, (void *)(long) cpu);
+	rc = blocking_notifier_call_chain(&idle_chain,
+			CPU_IDLE, (void *)(long) cpu);
 	if (rc != NOTIFY_OK && rc != NOTIFY_DONE)
 		BUG();
 	if (rc != NOTIFY_OK) {
Index: l2616/drivers/base/memory.c
===================================================================
--- l2616.orig/drivers/base/memory.c
+++ l2616/drivers/base/memory.c
@@ -47,16 +47,16 @@ static struct kset_uevent_ops memory_uev
 	.uevent		= memory_uevent,
 };
 
-static struct notifier_block *memory_chain;
+static BLOCKING_NOTIFIER_HEAD(memory_chain);
 
 int register_memory_notifier(struct notifier_block *nb)
 {
-        return notifier_chain_register(&memory_chain, nb);
+        return blocking_notifier_chain_register(&memory_chain, nb);
 }
 
 void unregister_memory_notifier(struct notifier_block *nb)
 {
-        notifier_chain_unregister(&memory_chain, nb);
+        blocking_notifier_chain_unregister(&memory_chain, nb);
 }
 
 /*
@@ -140,7 +140,7 @@ static ssize_t show_mem_state(struct sys
 
 static inline int memory_notify(unsigned long val, void *v)
 {
-	return notifier_call_chain(&memory_chain, val, v);
+	return blocking_notifier_call_chain(&memory_chain, val, v);
 }
 
 /*
Index: l2616/drivers/char/ipmi/ipmi_si_intf.c
===================================================================
--- l2616.orig/drivers/char/ipmi/ipmi_si_intf.c
+++ l2616/drivers/char/ipmi/ipmi_si_intf.c
@@ -226,10 +226,10 @@ struct smi_info
         struct task_struct *thread;
 };
 
-static struct notifier_block *xaction_notifier_list;
+static ATOMIC_NOTIFIER_HEAD(xaction_notifier_list);
 static int register_xaction_notifier(struct notifier_block * nb)
 {
-	return notifier_chain_register(&xaction_notifier_list, nb);
+	return atomic_notifier_chain_register(&xaction_notifier_list, nb);
 }
 
 static void si_restart_short_timer(struct smi_info *smi_info);
@@ -291,7 +291,8 @@ static enum si_sm_result start_next_msg(
 		do_gettimeofday(&t);
 		printk("**Start2: %d.%9.9d\n", t.tv_sec, t.tv_usec);
 #endif
-		err = notifier_call_chain(&xaction_notifier_list, 0, smi_info);
+		err = atomic_notifier_call_chain(&xaction_notifier_list,
+				0, smi_info);
 		if (err & NOTIFY_STOP_MASK) {
 			rv = SI_SM_CALL_WITHOUT_DELAY;
 			goto out;
Index: l2616/drivers/macintosh/adb.c
===================================================================
--- l2616.orig/drivers/macintosh/adb.c
+++ l2616/drivers/macintosh/adb.c
@@ -80,7 +80,7 @@ static struct adb_driver *adb_driver_lis
 static struct class *adb_dev_class;
 
 struct adb_driver *adb_controller;
-struct notifier_block *adb_client_list = NULL;
+BLOCKING_NOTIFIER_HEAD(adb_client_list);
 static int adb_got_sleep;
 static int adb_inited;
 static pid_t adb_probe_task_pid;
@@ -354,7 +354,8 @@ adb_notify_sleep(struct pmu_sleep_notifi
 		/* Stop autopoll */
 		if (adb_controller->autopoll)
 			adb_controller->autopoll(0);
-		ret = notifier_call_chain(&adb_client_list, ADB_MSG_POWERDOWN, NULL);
+		ret = blocking_notifier_call_chain(&adb_client_list,
+				ADB_MSG_POWERDOWN, NULL);
 		if (ret & NOTIFY_STOP_MASK) {
 			up(&adb_probe_mutex);
 			return PBOOK_SLEEP_REFUSE;
@@ -391,7 +392,8 @@ do_adb_reset_bus(void)
 	if (adb_controller->autopoll)
 		adb_controller->autopoll(0);
 
-	nret = notifier_call_chain(&adb_client_list, ADB_MSG_PRE_RESET, NULL);
+	nret = blocking_notifier_call_chain(&adb_client_list,
+			ADB_MSG_PRE_RESET, NULL);
 	if (nret & NOTIFY_STOP_MASK) {
 		if (adb_controller->autopoll)
 			adb_controller->autopoll(autopoll_devs);
@@ -426,7 +428,8 @@ do_adb_reset_bus(void)
 	}
 	up(&adb_handler_sem);
 
-	nret = notifier_call_chain(&adb_client_list, ADB_MSG_POST_RESET, NULL);
+	nret = blocking_notifier_call_chain(&adb_client_list,
+			ADB_MSG_POST_RESET, NULL);
 	if (nret & NOTIFY_STOP_MASK)
 		return -EBUSY;
 	
Index: l2616/drivers/macintosh/adbhid.c
===================================================================
--- l2616.orig/drivers/macintosh/adbhid.c
+++ l2616/drivers/macintosh/adbhid.c
@@ -1214,7 +1214,8 @@ static int __init adbhid_init(void)
 
 	adbhid_probe();
 
-	notifier_chain_register(&adb_client_list, &adbhid_adb_notifier);
+	blocking_notifier_chain_register(&adb_client_list,
+			&adbhid_adb_notifier);
 
 	return 0;
 }
Index: l2616/drivers/macintosh/via-pmu.c
===================================================================
--- l2616.orig/drivers/macintosh/via-pmu.c
+++ l2616/drivers/macintosh/via-pmu.c
@@ -185,7 +185,7 @@ extern int disable_kernel_backlight;
 
 int __fake_sleep;
 int asleep;
-struct notifier_block *sleep_notifier_list;
+BLOCKING_NOTIFIER_HEAD(sleep_notifier_list);
 
 #ifdef CONFIG_ADB
 static int adb_dev_map = 0;
Index: l2616/drivers/macintosh/via-pmu68k.c
===================================================================
--- l2616.orig/drivers/macintosh/via-pmu68k.c
+++ l2616/drivers/macintosh/via-pmu68k.c
@@ -102,7 +102,7 @@ static int pmu_kind = PMU_UNKNOWN;
 static int pmu_fully_inited = 0;
 
 int asleep;
-struct notifier_block *sleep_notifier_list;
+BLOCKING_NOTIFIER_HEAD(sleep_notifier_list);
 
 static int pmu_probe(void);
 static int pmu_init(void);
@@ -913,7 +913,8 @@ int powerbook_sleep(void)
 	struct adb_request sleep_req;
 
 	/* Notify device drivers */
-	ret = notifier_call_chain(&sleep_notifier_list, PBOOK_SLEEP, NULL);
+	ret = blocking_notifier_call_chain(&sleep_notifier_list,
+			PBOOK_SLEEP, NULL);
 	if (ret & NOTIFY_STOP_MASK)
 		return -EBUSY;
 
@@ -984,7 +985,7 @@ int powerbook_sleep(void)
 			enable_irq(i);
 
 	/* Notify drivers */
-	notifier_call_chain(&sleep_notifier_list, PBOOK_WAKE, NULL);
+	blocking_notifier_call_chain(&sleep_notifier_list, PBOOK_WAKE, NULL);
 
 	/* reenable ADB autopoll */
 	pmu_adb_autopoll(adb_dev_map);
Index: l2616/drivers/macintosh/windfarm_core.c
===================================================================
--- l2616.orig/drivers/macintosh/windfarm_core.c
+++ l2616/drivers/macintosh/windfarm_core.c
@@ -49,7 +49,7 @@
 static LIST_HEAD(wf_controls);
 static LIST_HEAD(wf_sensors);
 static DECLARE_MUTEX(wf_lock);
-static struct notifier_block *wf_client_list;
+static BLOCKING_NOTIFIER_HEAD(wf_client_list);
 static int wf_client_count;
 static unsigned int wf_overtemp;
 static unsigned int wf_overtemp_counter;
@@ -61,7 +61,7 @@ struct task_struct *wf_thread;
 
 static inline void wf_notify(int event, void *param)
 {
-	notifier_call_chain(&wf_client_list, event, param);
+	blocking_notifier_call_chain(&wf_client_list, event, param);
 }
 
 int wf_critical_overtemp(void)
@@ -330,7 +330,7 @@ int wf_register_client(struct notifier_b
 	struct wf_sensor *sr;
 
 	down(&wf_lock);
-	rc = notifier_chain_register(&wf_client_list, nb);
+	rc = blocking_notifier_chain_register(&wf_client_list, nb);
 	if (rc != 0)
 		goto bail;
 	wf_client_count++;
@@ -349,7 +349,7 @@ EXPORT_SYMBOL_GPL(wf_register_client);
 int wf_unregister_client(struct notifier_block *nb)
 {
 	down(&wf_lock);
-	notifier_chain_unregister(&wf_client_list, nb);
+	blocking_notifier_chain_unregister(&wf_client_list, nb);
 	wf_client_count++;
 	if (wf_client_count == 0)
 		wf_stop_thread();
Index: l2616/drivers/video/fbmem.c
===================================================================
--- l2616.orig/drivers/video/fbmem.c
+++ l2616/drivers/video/fbmem.c
@@ -55,7 +55,7 @@
 
 #define FBPIXMAPSIZE	(1024 * 8)
 
-static struct notifier_block *fb_notifier_list;
+static BLOCKING_NOTIFIER_HEAD(fb_notifier_list);
 struct fb_info *registered_fb[FB_MAX];
 int num_registered_fb;
 
@@ -784,7 +784,7 @@ fb_set_var(struct fb_info *info, struct 
 
 		    event.info = info;
 		    event.data = &mode1;
-		    ret = notifier_call_chain(&fb_notifier_list,
+		    ret = blocking_notifier_call_chain(&fb_notifier_list,
 					      FB_EVENT_MODE_DELETE, &event);
 		}
 
@@ -830,8 +830,8 @@ fb_set_var(struct fb_info *info, struct 
 
 				info->flags &= ~FBINFO_MISC_USEREVENT;
 				event.info = info;
-				notifier_call_chain(&fb_notifier_list, evnt,
-						    &event);
+				blocking_notifier_call_chain(&fb_notifier_list,
+						evnt, &event);
 			}
 		}
 	}
@@ -854,7 +854,8 @@ fb_blank(struct fb_info *info, int blank
 
 		event.info = info;
 		event.data = &blank;
-		notifier_call_chain(&fb_notifier_list, FB_EVENT_BLANK, &event);
+		blocking_notifier_call_chain(&fb_notifier_list,
+				FB_EVENT_BLANK, &event);
 	}
 
  	return ret;
@@ -925,7 +926,7 @@ fb_ioctl(struct inode *inode, struct fil
 		con2fb.framebuffer = -1;
 		event.info = info;
 		event.data = &con2fb;
-		notifier_call_chain(&fb_notifier_list,
+		blocking_notifier_call_chain(&fb_notifier_list,
 				    FB_EVENT_GET_CONSOLE_MAP, &event);
 		return copy_to_user(argp, &con2fb,
 				    sizeof(con2fb)) ? -EFAULT : 0;
@@ -944,7 +945,7 @@ fb_ioctl(struct inode *inode, struct fil
 		    return -EINVAL;
 		event.info = info;
 		event.data = &con2fb;
-		return notifier_call_chain(&fb_notifier_list,
+		return blocking_notifier_call_chain(&fb_notifier_list,
 					   FB_EVENT_SET_CONSOLE_MAP,
 					   &event);
 	case FBIOBLANK:
@@ -1330,7 +1331,7 @@ register_framebuffer(struct fb_info *fb_
 	devfs_mk_cdev(MKDEV(FB_MAJOR, i),
 			S_IFCHR | S_IRUGO | S_IWUGO, "fb/%d", i);
 	event.info = fb_info;
-	notifier_call_chain(&fb_notifier_list,
+	blocking_notifier_call_chain(&fb_notifier_list,
 			    FB_EVENT_FB_REGISTERED, &event);
 	return 0;
 }
@@ -1372,7 +1373,7 @@ unregister_framebuffer(struct fb_info *f
  */
 int fb_register_client(struct notifier_block *nb)
 {
-	return notifier_chain_register(&fb_notifier_list, nb);
+	return blocking_notifier_chain_register(&fb_notifier_list, nb);
 }
 
 /**
@@ -1381,7 +1382,7 @@ int fb_register_client(struct notifier_b
  */
 int fb_unregister_client(struct notifier_block *nb)
 {
-	return notifier_chain_unregister(&fb_notifier_list, nb);
+	return blocking_notifier_chain_unregister(&fb_notifier_list, nb);
 }
 
 /**
@@ -1399,11 +1400,13 @@ void fb_set_suspend(struct fb_info *info
 
 	event.info = info;
 	if (state) {
-		notifier_call_chain(&fb_notifier_list, FB_EVENT_SUSPEND, &event);
+		blocking_notifier_call_chain(&fb_notifier_list,
+				FB_EVENT_SUSPEND, &event);
 		info->state = FBINFO_STATE_SUSPENDED;
 	} else {
 		info->state = FBINFO_STATE_RUNNING;
-		notifier_call_chain(&fb_notifier_list, FB_EVENT_RESUME, &event);
+		blocking_notifier_call_chain(&fb_notifier_list,
+				FB_EVENT_RESUME, &event);
 	}
 }
 
@@ -1475,7 +1478,7 @@ int fb_new_modelist(struct fb_info *info
 
 	if (!list_empty(&info->modelist)) {
 		event.info = info;
-		err = notifier_call_chain(&fb_notifier_list,
+		err = blocking_notifier_call_chain(&fb_notifier_list,
 					   FB_EVENT_NEW_MODELIST,
 					   &event);
 	}
@@ -1501,7 +1504,7 @@ int fb_con_duit(struct fb_info *info, in
 	evnt.info = info;
 	evnt.data = data;
 
-	return notifier_call_chain(&fb_notifier_list, event, &evnt);
+	return blocking_notifier_call_chain(&fb_notifier_list, event, &evnt);
 }
 EXPORT_SYMBOL(fb_con_duit);
 
Index: l2616/include/linux/adb.h
===================================================================
--- l2616.orig/include/linux/adb.h
+++ l2616/include/linux/adb.h
@@ -85,7 +85,7 @@ enum adb_message {
     ADB_MSG_POST_RESET	/* Called after resetting the bus (re-do init & register) */
 };
 extern struct adb_driver *adb_controller;
-extern struct notifier_block *adb_client_list;
+extern struct blocking_notifier_head adb_client_list;
 
 int adb_request(struct adb_request *req, void (*done)(struct adb_request *),
 		int flags, int nbytes, ...);
Index: l2616/include/linux/kernel.h
===================================================================
--- l2616.orig/include/linux/kernel.h
+++ l2616/include/linux/kernel.h
@@ -87,7 +87,7 @@ extern int cond_resched(void);
 		(__x < 0) ? -__x : __x;		\
 	})
 
-extern struct notifier_block *panic_notifier_list;
+extern struct atomic_notifier_head panic_notifier_list;
 extern long (*panic_blink)(long time);
 NORET_TYPE void panic(const char * fmt, ...)
 	__attribute__ ((NORET_AND format (printf, 1, 2)));
Index: l2616/include/linux/memory.h
===================================================================
--- l2616.orig/include/linux/memory.h
+++ l2616/include/linux/memory.h
@@ -77,7 +77,6 @@ extern int remove_memory_block(unsigned 
 
 #define CONFIG_MEM_BLOCK_SIZE	(PAGES_PER_SECTION<<PAGE_SHIFT)
 
-struct notifier_block;
 
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
Index: l2616/include/linux/netfilter_ipv4/ip_conntrack.h
===================================================================
--- l2616.orig/include/linux/netfilter_ipv4/ip_conntrack.h
+++ l2616/include/linux/netfilter_ipv4/ip_conntrack.h
@@ -306,29 +306,30 @@ DECLARE_PER_CPU(struct ip_conntrack_ecac
 
 #define CONNTRACK_ECACHE(x)	(__get_cpu_var(ip_conntrack_ecache).x)
  
-extern struct notifier_block *ip_conntrack_chain;
-extern struct notifier_block *ip_conntrack_expect_chain;
+extern struct atomic_notifier_head ip_conntrack_chain;
+extern struct atomic_notifier_head ip_conntrack_expect_chain;
 
 static inline int ip_conntrack_register_notifier(struct notifier_block *nb)
 {
-	return notifier_chain_register(&ip_conntrack_chain, nb);
+	return atomic_notifier_chain_register(&ip_conntrack_chain, nb);
 }
 
 static inline int ip_conntrack_unregister_notifier(struct notifier_block *nb)
 {
-	return notifier_chain_unregister(&ip_conntrack_chain, nb);
+	return atomic_notifier_chain_unregister(&ip_conntrack_chain, nb);
 }
 
 static inline int 
 ip_conntrack_expect_register_notifier(struct notifier_block *nb)
 {
-	return notifier_chain_register(&ip_conntrack_expect_chain, nb);
+	return atomic_notifier_chain_register(&ip_conntrack_expect_chain, nb);
 }
 
 static inline int
 ip_conntrack_expect_unregister_notifier(struct notifier_block *nb)
 {
-	return notifier_chain_unregister(&ip_conntrack_expect_chain, nb);
+	return atomic_notifier_chain_unregister(&ip_conntrack_expect_chain,
+			nb);
 }
 
 extern void ip_ct_deliver_cached_events(const struct ip_conntrack *ct);
@@ -353,14 +354,14 @@ static inline void ip_conntrack_event(en
 				      struct ip_conntrack *ct)
 {
 	if (is_confirmed(ct) && !is_dying(ct))
-		notifier_call_chain(&ip_conntrack_chain, event, ct);
+		atomic_notifier_call_chain(&ip_conntrack_chain, event, ct);
 }
 
 static inline void 
 ip_conntrack_expect_event(enum ip_conntrack_expect_events event,
 			  struct ip_conntrack_expect *exp)
 {
-	notifier_call_chain(&ip_conntrack_expect_chain, event, exp);
+	atomic_notifier_call_chain(&ip_conntrack_expect_chain, event, exp);
 }
 #else /* CONFIG_IP_NF_CONNTRACK_EVENTS */
 static inline void ip_conntrack_event_cache(enum ip_conntrack_events event, 
Index: l2616/include/net/netfilter/nf_conntrack.h
===================================================================
--- l2616.orig/include/net/netfilter/nf_conntrack.h
+++ l2616/include/net/netfilter/nf_conntrack.h
@@ -297,29 +297,30 @@ DECLARE_PER_CPU(struct nf_conntrack_ecac
 
 #define CONNTRACK_ECACHE(x)	(__get_cpu_var(nf_conntrack_ecache).x)
 
-extern struct notifier_block *nf_conntrack_chain;
-extern struct notifier_block *nf_conntrack_expect_chain;
+extern struct atomic_notifier_head nf_conntrack_chain;
+extern struct atomic_notifier_head nf_conntrack_expect_chain;
 
 static inline int nf_conntrack_register_notifier(struct notifier_block *nb)
 {
-	return notifier_chain_register(&nf_conntrack_chain, nb);
+	return atomic_notifier_chain_register(&nf_conntrack_chain, nb);
 }
 
 static inline int nf_conntrack_unregister_notifier(struct notifier_block *nb)
 {
-	return notifier_chain_unregister(&nf_conntrack_chain, nb);
+	return atomic_notifier_chain_unregister(&nf_conntrack_chain, nb);
 }
 
 static inline int
 nf_conntrack_expect_register_notifier(struct notifier_block *nb)
 {
-	return notifier_chain_register(&nf_conntrack_expect_chain, nb);
+	return atomic_notifier_chain_register(&nf_conntrack_expect_chain, nb);
 }
 
 static inline int
 nf_conntrack_expect_unregister_notifier(struct notifier_block *nb)
 {
-	return notifier_chain_unregister(&nf_conntrack_expect_chain, nb);
+	return atomic_notifier_chain_unregister(&nf_conntrack_expect_chain,
+			nb);
 }
 
 extern void nf_ct_deliver_cached_events(const struct nf_conn *ct);
@@ -344,14 +345,14 @@ static inline void nf_conntrack_event(en
 				      struct nf_conn *ct)
 {
 	if (nf_ct_is_confirmed(ct) && !nf_ct_is_dying(ct))
-		notifier_call_chain(&nf_conntrack_chain, event, ct);
+		atomic_notifier_call_chain(&nf_conntrack_chain, event, ct);
 }
 
 static inline void
 nf_conntrack_expect_event(enum ip_conntrack_expect_events event,
 			  struct nf_conntrack_expect *exp)
 {
-	notifier_call_chain(&nf_conntrack_expect_chain, event, exp);
+	atomic_notifier_call_chain(&nf_conntrack_expect_chain, event, exp);
 }
 #else /* CONFIG_NF_CONNTRACK_EVENTS */
 static inline void nf_conntrack_event_cache(enum ip_conntrack_events event,
Index: l2616/kernel/panic.c
===================================================================
--- l2616.orig/kernel/panic.c
+++ l2616/kernel/panic.c
@@ -26,7 +26,7 @@ int tainted;
 
 EXPORT_SYMBOL(panic_timeout);
 
-struct notifier_block *panic_notifier_list;
+ATOMIC_NOTIFIER_HEAD(panic_notifier_list);
 
 EXPORT_SYMBOL(panic_notifier_list);
 
@@ -94,7 +94,7 @@ NORET_TYPE void panic(const char * fmt, 
 	smp_send_stop();
 #endif
 
-	notifier_call_chain(&panic_notifier_list, 0, buf);
+	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
 
 	if (!panic_blink)
 		panic_blink = no_blink;
Index: l2616/net/core/dev.c
===================================================================
--- l2616.orig/net/core/dev.c
+++ l2616/net/core/dev.c
@@ -193,7 +193,7 @@ static inline struct hlist_head *dev_ind
  *	Our notifier list
  */
 
-static struct notifier_block *netdev_chain;
+static BLOCKING_NOTIFIER_HEAD(netdev_chain);
 
 /*
  *	Device drivers call our routines to queue packets here. We empty the
@@ -736,7 +736,8 @@ int dev_change_name(struct net_device *d
 	if (!err) {
 		hlist_del(&dev->name_hlist);
 		hlist_add_head(&dev->name_hlist, dev_name_hash(dev->name));
-		notifier_call_chain(&netdev_chain, NETDEV_CHANGENAME, dev);
+		blocking_notifier_call_chain(&netdev_chain,
+				NETDEV_CHANGENAME, dev);
 	}
 
 	return err;
@@ -750,7 +751,7 @@ int dev_change_name(struct net_device *d
  */
 void netdev_features_change(struct net_device *dev)
 {
-	notifier_call_chain(&netdev_chain, NETDEV_FEAT_CHANGE, dev);
+	blocking_notifier_call_chain(&netdev_chain, NETDEV_FEAT_CHANGE, dev);
 }
 EXPORT_SYMBOL(netdev_features_change);
 
@@ -765,7 +766,8 @@ EXPORT_SYMBOL(netdev_features_change);
 void netdev_state_change(struct net_device *dev)
 {
 	if (dev->flags & IFF_UP) {
-		notifier_call_chain(&netdev_chain, NETDEV_CHANGE, dev);
+		blocking_notifier_call_chain(&netdev_chain,
+				NETDEV_CHANGE, dev);
 		rtmsg_ifinfo(RTM_NEWLINK, dev, 0);
 	}
 }
@@ -862,7 +864,7 @@ int dev_open(struct net_device *dev)
 		/*
 		 *	... and announce new interface.
 		 */
-		notifier_call_chain(&netdev_chain, NETDEV_UP, dev);
+		blocking_notifier_call_chain(&netdev_chain, NETDEV_UP, dev);
 	}
 	return ret;
 }
@@ -885,7 +887,7 @@ int dev_close(struct net_device *dev)
 	 *	Tell people we are going down, so that they can
 	 *	prepare to death, when device is still operating.
 	 */
-	notifier_call_chain(&netdev_chain, NETDEV_GOING_DOWN, dev);
+	blocking_notifier_call_chain(&netdev_chain, NETDEV_GOING_DOWN, dev);
 
 	dev_deactivate(dev);
 
@@ -922,7 +924,7 @@ int dev_close(struct net_device *dev)
 	/*
 	 * Tell people we are down
 	 */
-	notifier_call_chain(&netdev_chain, NETDEV_DOWN, dev);
+	blocking_notifier_call_chain(&netdev_chain, NETDEV_DOWN, dev);
 
 	return 0;
 }
@@ -953,7 +955,7 @@ int register_netdevice_notifier(struct n
 	int err;
 
 	rtnl_lock();
-	err = notifier_chain_register(&netdev_chain, nb);
+	err = blocking_notifier_chain_register(&netdev_chain, nb);
 	if (!err) {
 		for (dev = dev_base; dev; dev = dev->next) {
 			nb->notifier_call(nb, NETDEV_REGISTER, dev);
@@ -978,7 +980,7 @@ int register_netdevice_notifier(struct n
 
 int unregister_netdevice_notifier(struct notifier_block *nb)
 {
-	return notifier_chain_unregister(&netdev_chain, nb);
+	return blocking_notifier_chain_unregister(&netdev_chain, nb);
 }
 
 /**
@@ -987,12 +989,12 @@ int unregister_netdevice_notifier(struct
  *      @v:   pointer passed unmodified to notifier function
  *
  *	Call all network notifier blocks.  Parameters and return value
- *	are as for notifier_call_chain().
+ *	are as for blocking_notifier_call_chain().
  */
 
 int call_netdevice_notifiers(unsigned long val, void *v)
 {
-	return notifier_call_chain(&netdev_chain, val, v);
+	return blocking_notifier_call_chain(&netdev_chain, val, v);
 }
 
 /* When > 0 there are consumers of rx skb time stamps */
@@ -2200,7 +2202,8 @@ int dev_change_flags(struct net_device *
 	if (dev->flags & IFF_UP &&
 	    ((old_flags ^ dev->flags) &~ (IFF_UP | IFF_PROMISC | IFF_ALLMULTI |
 					  IFF_VOLATILE)))
-		notifier_call_chain(&netdev_chain, NETDEV_CHANGE, dev);
+		blocking_notifier_call_chain(&netdev_chain,
+				NETDEV_CHANGE, dev);
 
 	if ((flags ^ dev->gflags) & IFF_PROMISC) {
 		int inc = (flags & IFF_PROMISC) ? +1 : -1;
@@ -2244,8 +2247,8 @@ int dev_set_mtu(struct net_device *dev, 
 	else
 		dev->mtu = new_mtu;
 	if (!err && dev->flags & IFF_UP)
-		notifier_call_chain(&netdev_chain,
-				    NETDEV_CHANGEMTU, dev);
+		blocking_notifier_call_chain(&netdev_chain,
+				NETDEV_CHANGEMTU, dev);
 	return err;
 }
 
@@ -2261,7 +2264,8 @@ int dev_set_mac_address(struct net_devic
 		return -ENODEV;
 	err = dev->set_mac_address(dev, sa);
 	if (!err)
-		notifier_call_chain(&netdev_chain, NETDEV_CHANGEADDR, dev);
+		blocking_notifier_call_chain(&netdev_chain,
+				NETDEV_CHANGEADDR, dev);
 	return err;
 }
 
@@ -2317,7 +2321,7 @@ static int dev_ifsioc(struct ifreq *ifr,
 				return -EINVAL;
 			memcpy(dev->broadcast, ifr->ifr_hwaddr.sa_data,
 			       min(sizeof ifr->ifr_hwaddr.sa_data, (size_t) dev->addr_len));
-			notifier_call_chain(&netdev_chain,
+			blocking_notifier_call_chain(&netdev_chain,
 					    NETDEV_CHANGEADDR, dev);
 			return 0;
 
@@ -2771,7 +2775,7 @@ int register_netdevice(struct net_device
 	write_unlock_bh(&dev_base_lock);
 
 	/* Notify protocols, that a new device appeared. */
-	notifier_call_chain(&netdev_chain, NETDEV_REGISTER, dev);
+	blocking_notifier_call_chain(&netdev_chain, NETDEV_REGISTER, dev);
 
 	/* Finish registration after unlock */
 	net_set_todo(dev);
@@ -2850,7 +2854,7 @@ static void netdev_wait_allrefs(struct n
 			rtnl_shlock();
 
 			/* Rebroadcast unregister notification */
-			notifier_call_chain(&netdev_chain,
+			blocking_notifier_call_chain(&netdev_chain,
 					    NETDEV_UNREGISTER, dev);
 
 			if (test_bit(__LINK_STATE_LINKWATCH_PENDING,
@@ -3106,7 +3110,7 @@ int unregister_netdevice(struct net_devi
 	/* Notify protocols, that we are about to destroy
 	   this device. They should clean all the things.
 	*/
-	notifier_call_chain(&netdev_chain, NETDEV_UNREGISTER, dev);
+	blocking_notifier_call_chain(&netdev_chain, NETDEV_UNREGISTER, dev);
 	
 	/*
 	 *	Flush the multicast chain
Index: l2616/drivers/net/bonding/bond_main.c
===================================================================
--- l2616.orig/drivers/net/bonding/bond_main.c
+++ l2616/drivers/net/bonding/bond_main.c
@@ -3149,7 +3149,7 @@ static int bond_slave_netdev_event(unsig
  * bond_netdev_event: handle netdev notifier chain events.
  *
  * This function receives events for the netdev chain.  The caller (an
- * ioctl handler calling notifier_call_chain) holds the necessary
+ * ioctl handler calling blocking_notifier_call_chain) holds the necessary
  * locks for us to safely manipulate the slave devices (RTNL lock,
  * dev_probe_lock).
  */
Index: l2616/net/ipv4/netfilter/ip_conntrack_core.c
===================================================================
--- l2616.orig/net/ipv4/netfilter/ip_conntrack_core.c
+++ l2616/net/ipv4/netfilter/ip_conntrack_core.c
@@ -80,8 +80,8 @@ static int ip_conntrack_vmalloc;
 static unsigned int ip_conntrack_next_id = 1;
 static unsigned int ip_conntrack_expect_next_id = 1;
 #ifdef CONFIG_IP_NF_CONNTRACK_EVENTS
-struct notifier_block *ip_conntrack_chain;
-struct notifier_block *ip_conntrack_expect_chain;
+ATOMIC_NOTIFIER_HEAD(ip_conntrack_chain);
+ATOMIC_NOTIFIER_HEAD(ip_conntrack_expect_chain);
 
 DEFINE_PER_CPU(struct ip_conntrack_ecache, ip_conntrack_ecache);
 
@@ -92,7 +92,7 @@ __ip_ct_deliver_cached_events(struct ip_
 {
 	DEBUGP("ecache: delivering events for %p\n", ecache->ct);
 	if (is_confirmed(ecache->ct) && !is_dying(ecache->ct) && ecache->events)
-		notifier_call_chain(&ip_conntrack_chain, ecache->events,
+		atomic_notifier_call_chain(&ip_conntrack_chain, ecache->events,
 				    ecache->ct);
 	ecache->events = 0;
 	ip_conntrack_put(ecache->ct);
Index: l2616/net/netfilter/nf_conntrack_core.c
===================================================================
--- l2616.orig/net/netfilter/nf_conntrack_core.c
+++ l2616/net/netfilter/nf_conntrack_core.c
@@ -85,8 +85,8 @@ static int nf_conntrack_vmalloc;
 static unsigned int nf_conntrack_next_id = 1;
 static unsigned int nf_conntrack_expect_next_id = 1;
 #ifdef CONFIG_NF_CONNTRACK_EVENTS
-struct notifier_block *nf_conntrack_chain;
-struct notifier_block *nf_conntrack_expect_chain;
+ATOMIC_NOTIFIER_HEAD(nf_conntrack_chain);
+ATOMIC_NOTIFIER_HEAD(nf_conntrack_expect_chain);
 
 DEFINE_PER_CPU(struct nf_conntrack_ecache, nf_conntrack_ecache);
 
@@ -98,7 +98,7 @@ __nf_ct_deliver_cached_events(struct nf_
 	DEBUGP("ecache: delivering events for %p\n", ecache->ct);
 	if (nf_ct_is_confirmed(ecache->ct) && !nf_ct_is_dying(ecache->ct)
 	    && ecache->events)
-		notifier_call_chain(&nf_conntrack_chain, ecache->events,
+		atomic_notifier_call_chain(&nf_conntrack_chain, ecache->events,
 				    ecache->ct);
 
 	ecache->events = 0;
Index: l2616/kernel/sys.c
===================================================================
--- l2616.orig/kernel/sys.c
+++ l2616/kernel/sys.c
@@ -95,7 +95,7 @@ int cad_pid = 1;
  *	and the like. 
  */
 
-static struct notifier_block *reboot_notifier_list;
+static BLOCKING_NOTIFIER_HEAD(reboot_notifier_list);
 
 /*
  *	Notifier chain core routines.  The exported routines below
@@ -385,13 +385,13 @@ EXPORT_SYMBOL(raw_notifier_call_chain);
  *	Registers a function with the list of functions
  *	to be called at reboot time.
  *
- *	Currently always returns zero, as notifier_chain_register
+ *	Currently always returns zero, as blocking_notifier_chain_register
  *	always returns zero.
  */
  
 int register_reboot_notifier(struct notifier_block * nb)
 {
-	return notifier_chain_register(&reboot_notifier_list, nb);
+	return blocking_notifier_chain_register(&reboot_notifier_list, nb);
 }
 
 EXPORT_SYMBOL(register_reboot_notifier);
@@ -408,7 +408,7 @@ EXPORT_SYMBOL(register_reboot_notifier);
  
 int unregister_reboot_notifier(struct notifier_block * nb)
 {
-	return notifier_chain_unregister(&reboot_notifier_list, nb);
+	return blocking_notifier_chain_unregister(&reboot_notifier_list, nb);
 }
 
 EXPORT_SYMBOL(unregister_reboot_notifier);
@@ -581,7 +581,7 @@ EXPORT_SYMBOL_GPL(emergency_restart);
 
 void kernel_restart_prepare(char *cmd)
 {
-	notifier_call_chain(&reboot_notifier_list, SYS_RESTART, cmd);
+	blocking_notifier_call_chain(&reboot_notifier_list, SYS_RESTART, cmd);
 	system_state = SYSTEM_RESTART;
 	device_shutdown();
 }
@@ -631,7 +631,7 @@ EXPORT_SYMBOL_GPL(kernel_kexec);
 
 void kernel_shutdown_prepare(enum system_states state)
 {
-	notifier_call_chain(&reboot_notifier_list,
+	blocking_notifier_call_chain(&reboot_notifier_list,
 		(state == SYSTEM_HALT)?SYS_HALT:SYS_POWER_OFF, NULL);
 	system_state = state;
 	device_shutdown();

