Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269796AbUICVqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269796AbUICVqJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 17:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269763AbUICVqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 17:46:07 -0400
Received: from mta9.srv.hcvlny.cv.net ([167.206.5.42]:55163 "EHLO
	mta9.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S268328AbUICVo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 17:44:58 -0400
Date: Fri, 03 Sep 2004 17:44:24 -0400
From: "Josef 'Jeff' Sipek" <jeffpc@optonline.net>
Subject: Re: [PATCH 2.6] watch64: generic variable monitoring system
In-reply-to: <20040903121657.355a6a8b@dell_ss3.pdx.osdl.net>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Message-id: <200409031744.32970.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_9IoCL9KP09e0Mk4d4FE7DQ)"
Content-disposition: inline
User-Agent: KMail/1.6.2
References: <200409031307.01240.jeffpc@optonline.net>
 <200409031319.24863.jeffpc@optonline.net>
 <20040903121657.355a6a8b@dell_ss3.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary_(ID_9IoCL9KP09e0Mk4d4FE7DQ)
Content-type: Text/Plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Friday 03 September 2004 15:16, Stephen Hemminger wrote:
> - Code doesn't match the kernel style (read Documentation/CodingStyle)

Sorry about the white space, KMail apparently likes to butcher the text. These 
are the same patches with the little cleanup update.

Jeff.

- -- 
Reality is merely an illusion, albeit a very persistent one.
  - Albert Einstein
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD4DBQFBOOW+wFP0+seVj/4RAgSiAJj54qcqdEx66lbMW9ik0XviupTNAKC82an1
R0pGX0pTBZ78NWrZpxJm+w==
=EesC
-----END PGP SIGNATURE-----

--Boundary_(ID_9IoCL9KP09e0Mk4d4FE7DQ)
Content-type: text/x-diff; charset=iso-8859-1; name=watch64-patch
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=watch64-patch

diff -Nru a/Documentation/00-INDEX b/Documentation/00-INDEX
--- a/Documentation/00-INDEX	2004-09-03 17:41:06 -04:00
+++ b/Documentation/00-INDEX	2004-09-03 17:41:06 -04:00
@@ -250,6 +250,8 @@
 	- directory with info regarding video/TV/radio cards and linux.
 vm/
 	- directory with info on the Linux vm code.
+watch64.txt
+	- watch64 API description
 watchdog/
 	- how to auto-reboot Linux if it has "fallen and can't get up". ;-)
 x86_64/
diff -Nru a/Documentation/watch64.txt b/Documentation/watch64.txt
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/Documentation/watch64.txt	2004-09-03 17:41:06 -04:00
@@ -0,0 +1,35 @@
+int watch64_register(unsigned long* ptr, unsigned int interval);
+
+	- Registers *ptr to be monitored every interval jiffies.
+	- If interval==0, WATCH64_INTERVAL will be used (HZ/10 by default)
+
+int watch64_unregister(unsigned long* ptr, struct watch64* st);
+
+	- Unregister *ptr
+	- st is optional pointer to the struct containing the registration
+		information
+	- if st==NULL, it will be looked up automatically
+
+struct watch64* watch64_find(unsigned long* ptr);
+
+	- Return struct with registration information of *ptr
+
+int watch64_disable(unsigned long* ptr, struct watch64* st);
+
+	- Disable *ptr from being monitored, without removing it from the list
+	- st is optional (see watch64_unregister for more information)
+
+int watch64_enable(unsigned long* ptr, struct watch64* st);
+
+	- Enable *ptr from being monitored (opposite of watch64_disable)
+	- st is optional (see watch64_unregister for more information)
+
+int watch64_toggle(unsigned long* ptr, struct watch64* st);
+
+	- Toggle the enable/disable status
+	- st is optional (see watch64_unregister for more information)
+
+inline u_int64_t watch64_getval(unsigned long* ptr, struct watch64* st);
+
+	- Return the whole 64-bit counter
+	- st is optional (see watch64_unregister for more information)
diff -Nru a/include/linux/watch64.h b/include/linux/watch64.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/linux/watch64.h	2004-09-03 17:41:06 -04:00
@@ -0,0 +1,63 @@
+/*
+ *  inclue/linux/watch64.h
+ *
+ *  Copyright (C) 2003 Josef "Jeff" Sipek <jeffpc@optonline.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef _LINUX_64WATCH_H
+#define _LINUX_64WATCH_H
+
+#include <linux/list.h>
+#include <linux/timer.h>
+#include <linux/kernel.h>
+#include <linux/seqlock.h>
+#include <linux/rcupdate.h>
+
+#define WATCH64_INTERVAL	(HZ/10)
+#define WATCH64_MINIMUM		(HZ/20)
+#define WATCH64_MAGIC		0x573634
+
+#if (BITS_PER_LONG == 64)
+
+struct watch64 {
+};
+
+#else
+
+struct watch64 {
+	struct list_head list;
+	unsigned long *ptr;
+	unsigned long oldval;
+	u_int64_t total;
+	unsigned int interval;
+	int active;
+	seqlock_t lock;
+	struct rcu_head rcuhead;
+};
+
+#endif /* (BITS_PER_LONG == 64) */
+
+/*
+ *   Prototypes
+ */
+
+void watch64_init(void);
+void watch64_run(unsigned long var);
+int watch64_register(unsigned long* ptr, unsigned int interval);
+int watch64_unregister(unsigned long* ptr, struct watch64* st);
+void watch64_rcufree(struct rcu_head* p);
+struct watch64* watch64_find(unsigned long* ptr);
+inline struct watch64* __watch64_find(unsigned long* ptr);
+int watch64_disable(unsigned long* ptr, struct watch64* st);
+inline int __watch64_disable(unsigned long* ptr, struct watch64* st);
+int watch64_enable(unsigned long* ptr, struct watch64* st);
+inline int __watch64_enable(unsigned long* ptr, struct watch64* st);
+int watch64_toggle(unsigned long* ptr, struct watch64* st);
+inline u_int64_t watch64_getval(unsigned long* ptr, struct watch64* st);
+
+#endif /* _LINUX_WATCH64_H */
diff -Nru a/kernel/Makefile b/kernel/Makefile
--- a/kernel/Makefile	2004-09-03 17:41:06 -04:00
+++ b/kernel/Makefile	2004-09-03 17:41:06 -04:00
@@ -7,7 +7,7 @@
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
-	    kthread.o
+	    kthread.o watch64.o
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
diff -Nru a/kernel/watch64.c b/kernel/watch64.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/kernel/watch64.c	2004-09-03 17:41:06 -04:00
@@ -0,0 +1,396 @@
+/*
+ *  kernel/watch64.c
+ *
+ *  Copyright (C) 2003 Josef "Jeff" Sipek <jeffpc@optonline.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+ 
+#include <asm/param.h>
+#include <linux/slab.h>
+#include <linux/errno.h>
+#include <linux/jiffies.h>
+#include <linux/module.h>
+#include <linux/list.h>
+#include <linux/timer.h>
+#include <linux/kernel.h>
+#include <linux/seqlock.h>
+#include <linux/spinlock.h>
+#include <linux/rcupdate.h>
+#include <linux/watch64.h>
+
+/*
+ *   Watch64 global variables
+ */
+
+spinlock_t watch64_biglock = SPIN_LOCK_UNLOCKED;
+LIST_HEAD(watch64_head);
+struct timer_list watch64_timer;
+int watch64_setup;
+
+#if (BITS_PER_LONG == 64)
+
+void watch64_init(void)
+{
+}
+
+void watch64_run(unsigned long var)
+{
+}
+
+int watch64_register(unsigned long* ptr, unsigned int interval)
+{
+	return 0;
+}
+
+int watch64_unregister(unsigned long* ptr, struct watch64* st)
+{
+	return 0;
+}
+
+void watch64_rcufree(void* p)
+{
+}
+
+struct watch64* watch64_find(unsigned long* ptr)
+{
+	return NULL;
+}
+
+struct watch64* __watch64_find(unsigned long* ptr)
+{
+	return NULL;
+}
+
+int watch64_disable(unsigned long* ptr, struct watch64* st)
+{
+	return 0;
+}
+
+int __watch64_disable(unsigned long* ptr, struct watch64* st)
+{
+	return 0;
+}
+
+int watch64_enable(unsigned long* ptr, struct watch64* st)
+{
+	return 0;
+}
+
+int __watch64_enable(unsigned long* ptr, struct watch64* st)
+{
+	return 0;
+}
+
+int watch64_toggle(unsigned long* ptr, struct watch64* st)
+{
+	return 0;
+}
+
+inline u_int64_t watch64_getval(unsigned long* ptr, struct watch64* st)
+{
+	return (u_int64_t) *ptr;
+}
+
+#else
+
+/*
+ *   Initiate watch64 system
+ */
+
+void watch64_init(void)
+{
+	spin_lock(&watch64_biglock);
+	
+	if (watch64_setup==WATCH64_MAGIC) {
+		spin_unlock(&watch64_biglock);
+		return;
+	}
+	
+	printk(KERN_WARNING "watch64: 2003/08/22 Josef 'Jeff' Sipek "
+					"<jeffpc@optonline.net>\n");
+	printk(KERN_WARNING "watch64: Enabling Watch64 extensions...");
+
+	init_timer(&watch64_timer);
+	watch64_timer.function = watch64_run;
+	watch64_timer.data = (unsigned long) NULL;
+	watch64_timer.expires = jiffies + WATCH64_MINIMUM;
+	add_timer(&watch64_timer);
+
+	printk("done.\n");
+	
+	watch64_setup = WATCH64_MAGIC;
+	
+	spin_unlock(&watch64_biglock);
+}
+
+/*
+ *   Go through the list of registered variables and check them for changes
+ */
+
+void watch64_run(unsigned long var)
+{
+	struct list_head* entry;
+	struct watch64* watch_struct;
+	unsigned long tmp;
+
+	rcu_read_lock();
+	list_for_each_rcu(entry, &watch64_head) {
+		watch_struct = list_entry(entry, struct watch64, list);
+		if (*watch_struct->ptr == watch_struct->oldval)
+			continue;
+		
+		tmp = *watch_struct->ptr;
+		if (tmp > watch_struct->oldval) {
+			write_seqlock(&watch_struct->lock);
+			watch_struct->total += tmp - watch_struct->oldval;
+			write_sequnlock(&watch_struct->lock);
+		} else if (tmp < watch_struct->oldval) {
+			write_seqlock(&watch_struct->lock);
+			watch_struct->total += ((u_int64_t) 1<<BITS_PER_LONG)
+						- watch_struct->oldval + tmp;
+			write_sequnlock(&watch_struct->lock);
+		}
+		watch_struct->oldval = tmp;
+	}
+	rcu_read_unlock();
+	
+	mod_timer(&watch64_timer, jiffies + WATCH64_MINIMUM);
+}
+
+/*
+ *   Register a new variable with watch64
+ */
+
+int watch64_register(unsigned long* ptr, unsigned int interval)
+{
+	struct watch64* temp;
+	
+	temp = (struct watch64*) kmalloc(sizeof(struct watch64),GFP_ATOMIC);
+
+	if (!temp)
+		return -ENOMEM;
+
+	if (watch64_setup!=WATCH64_MAGIC)
+		watch64_init();
+
+	temp->ptr = ptr;
+	temp->oldval = 0;
+	temp->total = 0;
+	if (interval==0)
+		temp->interval = WATCH64_INTERVAL;
+	else if (interval<WATCH64_MINIMUM) {
+		temp->interval = WATCH64_MINIMUM;
+		printk("watch64: attempted to add new watch with "
+				"interval below %d jiffies",WATCH64_MINIMUM);
+	} else
+		temp->interval = interval;
+
+	temp->active = 0;
+	
+	seqlock_init(&temp->lock);
+
+	list_add_rcu(&temp->list, &watch64_head);
+
+	return 0;
+}
+
+/*
+ *   Unregister a variable with watch64
+ */
+
+int watch64_unregister(unsigned long* ptr, struct watch64* st)
+{
+	rcu_read_lock();
+	if (!st)
+		st = __watch64_find(ptr); 
+
+	if (!st)
+		return -EINVAL;
+
+	__watch64_disable(ptr, st);
+	list_del_rcu(&st->list);
+	
+	call_rcu(&st->rcuhead, watch64_rcufree);
+	rcu_read_unlock();
+
+	return 0;
+}
+
+/*
+ *   Free memory via RCU
+ */
+ 
+void watch64_rcufree(struct rcu_head* p)
+{
+	kfree(container_of(p, struct watch64, rcuhead));
+}
+
+/*
+ *   Find watch64 structure with RCU lock
+ */
+
+struct watch64* watch64_find(unsigned long* ptr)
+{
+	struct watch64* tmp;
+	
+	rcu_read_lock();
+	tmp = __watch64_find(ptr);
+	rcu_read_unlock();
+	
+	return tmp;
+}
+
+/*
+ *   Find watch64 structure without RCU lock
+ */
+
+inline struct watch64* __watch64_find(unsigned long* ptr)
+{
+	struct list_head* tmp;
+	struct watch64* watch64_struct;
+
+	list_for_each_rcu(tmp, &watch64_head) {
+		watch64_struct = list_entry(tmp, struct watch64, list);
+		if (watch64_struct->ptr==ptr)
+			return watch64_struct;
+	}
+
+	return NULL;
+}
+
+/*
+ *   Disable a variable watch with RCU lock
+ */
+
+int watch64_disable(unsigned long* ptr, struct watch64* st)
+{
+	int tmp;
+	
+	rcu_read_lock();
+	tmp = __watch64_disable(ptr,st);
+	rcu_read_unlock();
+	
+	return tmp;
+}
+ 
+/*
+ *   Disable a variable watch without RCU lock
+ */
+
+inline int __watch64_disable(unsigned long* ptr, struct watch64* st)
+{
+	if (!st)
+		st = watch64_find(ptr);
+
+	if (!st)
+		return -EINVAL;
+
+	st->active = 0;
+
+	return 0;
+}
+
+/*
+ *   Enable a variable watch with RCU lock
+ */
+
+int watch64_enable(unsigned long* ptr, struct watch64* st)
+{
+	int tmp;
+	
+	rcu_read_lock();
+	tmp = __watch64_enable(ptr,st);
+	rcu_read_unlock();
+	
+	return tmp;
+}
+ 
+/*
+ *   Enable a variable watch without RCU lock
+ */
+
+inline int __watch64_enable(unsigned long* ptr, struct watch64* st)
+{
+	if (!st)
+		st = __watch64_find(ptr);
+
+	if (!st)
+		return -EINVAL;
+
+	st->oldval = *ptr;
+	write_seqlock(&st->lock);
+	st->total  = (u_int64_t) st->oldval;
+	write_sequnlock(&st->lock);
+	st->active = 1;
+
+	return 0;
+}
+
+/*
+ *   Toggle a variable watch
+ */
+
+int watch64_toggle(unsigned long* ptr, struct watch64* st)
+{
+	rcu_read_lock();
+	if (!st)
+		st = __watch64_find(ptr);
+
+	if (!st) {
+		rcu_read_unlock();
+		return -EINVAL;
+	}
+
+	if (st->active)
+		__watch64_disable(ptr,st);
+	else
+		__watch64_enable(ptr,st);
+	rcu_read_unlock();
+
+	return 0;
+}
+
+/*
+ *   Return the total 64-bit value
+ */
+
+inline u_int64_t watch64_getval(unsigned long* ptr, struct watch64* st)
+{
+	unsigned int seq;
+	u_int64_t total;
+
+	rcu_read_lock();
+	if (!st)
+		st = __watch64_find(ptr);
+
+	if (!st) {
+		rcu_read_unlock();
+		return *ptr;
+	}
+
+	do {
+		seq = read_seqbegin(&st->lock);
+		total = st->total;
+	} while (read_seqretry(&st->lock, seq));
+	rcu_read_unlock();
+	
+	return total;
+}
+
+#endif /* (BITS_PER_LONG == 64) */
+
+/*
+ *   Export all the necessary symbols
+ */
+
+EXPORT_SYMBOL(watch64_register);
+EXPORT_SYMBOL(watch64_unregister);
+EXPORT_SYMBOL(watch64_find);
+EXPORT_SYMBOL(watch64_disable);
+EXPORT_SYMBOL(watch64_enable);
+EXPORT_SYMBOL(watch64_toggle);
+EXPORT_SYMBOL(watch64_getval);

--Boundary_(ID_9IoCL9KP09e0Mk4d4FE7DQ)
Content-type: text/x-diff; charset=iso-8859-1; name=64network-patch
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=64network-patch

diff -Nru a/include/linux/netdevice.h b/include/linux/netdevice.h
--- a/include/linux/netdevice.h	2004-09-03 12:22:08 -04:00
+++ b/include/linux/netdevice.h	2004-09-03 12:22:08 -04:00
@@ -14,6 +14,7 @@
  *		Alan Cox, <Alan.Cox@linux.org>
  *		Bjorn Ekwall. <bj0rn@blox.se>
  *              Pekka Riikonen <priikone@poseidon.pspt.fi>
+ *		Josef "Jeff" Sipek <jeffpc@optonline.net>
  *
  *		This program is free software; you can redistribute it and/or
  *		modify it under the terms of the GNU General Public License
@@ -945,6 +946,10 @@
 #ifdef CONFIG_SYSCTL
 extern char *net_sysctl_strdup(const char *s);
 #endif
+
+/*
  * Register/unregister all the members of struct net_device_stats with watch64
  */
+inline void		net_register_stats64(struct net_device_stats* stats);
+inline void		net_unregister_stats64(struct net_device_stats* stats);
 
 #endif /* __KERNEL__ */
 
diff -Nru a/net/core/dev.c b/net/core/dev.c
--- a/net/core/dev.c	2004-09-03 12:22:08 -04:00
+++ b/net/core/dev.c	2004-09-03 12:22:08 -04:00
@@ -18,6 +18,7 @@
  *		Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
  *		Adam Sulmicki <adam@cfar.umd.edu>
  *              Pekka Riikonen <priikone@poesidon.pspt.fi>
+ *		Josef "Jeff" Sipek <jeffpc@optonline.net>
  *
  *	Changes:
  *              D.J. Barrow     :       Fixed bug where dev->refcnt gets set
@@ -70,6 +71,7 @@
  *              			indefinitely on dev->refcnt
  * 		J Hadi Salim	:	- Backlog queue sampling
  *				        - netif_rx() feedback
+ *	Josef "Jeff" Sipek	:	Added watch64 calls for network statistics
  */
 
 #include <asm/uaccess.h>
@@ -108,6 +110,7 @@
 #include <linux/kallsyms.h>
 #include <linux/netpoll.h>
 #include <linux/rcupdate.h>
+#include <linux/watch64.h>
 #ifdef CONFIG_NET_RADIO
 #include <linux/wireless.h>		/* Note : will define WIRELESS_EXT */
 #include <net/iw_handler.h>
@@ -2110,6 +2113,49 @@
 		seq_printf(seq, "%6s: No statistics available.\n", dev->name);
 }
 
+static void dev_seq_printf_stats64(struct seq_file *seq, struct net_device *dev)
+{
+	if (dev->get_stats) {
+		struct net_device_stats *stats = dev->get_stats(dev);
+
+		seq_printf(seq, "%6s:%8llu %7llu %4llu %4llu %4llu %5llu %10llu %9llu "
+				"%8llu %7llu %4llu %4llu %4llu %5llu %7llu %10llu\n",
+			   dev->name, watch64_getval(&stats->rx_bytes,NULL),
+			   watch64_getval(&stats->rx_packets,NULL),
+			   watch64_getval(&stats->rx_errors,NULL),
+			   watch64_getval(&stats->rx_dropped,NULL) +
+			     watch64_getval(&stats->rx_missed_errors,NULL),
+			   watch64_getval(&stats->rx_fifo_errors,NULL),
+			   watch64_getval(&stats->rx_length_errors,NULL) + 
+			     watch64_getval(&stats->rx_over_errors,NULL) +
+			     watch64_getval(&stats->rx_crc_errors,NULL) +
+			     watch64_getval(&stats->rx_frame_errors,NULL),
+			   watch64_getval(&stats->rx_compressed,NULL),
+			   watch64_getval(&stats->multicast,NULL),
+			   watch64_getval(&stats->tx_bytes,NULL),
+			   watch64_getval(&stats->tx_packets,NULL),
+			   watch64_getval(&stats->tx_errors,NULL),
+			   watch64_getval(&stats->tx_dropped,NULL),
+			   watch64_getval(&stats->tx_fifo_errors,NULL),
+			   watch64_getval(&stats->collisions,NULL),
+			   watch64_getval(&stats->tx_carrier_errors,NULL) +
+			     watch64_getval(&stats->tx_aborted_errors,NULL) +
+			     watch64_getval(&stats->tx_window_errors,NULL) +
+			     watch64_getval(&stats->tx_heartbeat_errors,NULL),
+			   watch64_getval(&stats->tx_compressed,NULL));
+	} else
+		seq_printf(seq, "%6s: No statistics available.\n", dev->name);
+}
+
+static void dev_seq_show_header(struct seq_file *seq)
+{
+	seq_puts(seq, "Inter-|   Receive                            "
+		      "                    |  Transmit\n"
+		      " face |bytes    packets errs drop fifo frame "
+		      "compressed multicast|bytes    packets errs "
+		      "drop fifo colls carrier compressed\n");
+}
+
 /*
  *	Called from the PROCfs module. This now uses the new arbitrary sized
  *	/proc/net interface to create /proc/net/dev
@@ -2117,16 +2163,21 @@
 static int dev_seq_show(struct seq_file *seq, void *v)
 {
 	if (v == SEQ_START_TOKEN)
-		seq_puts(seq, "Inter-|   Receive                            "
-			      "                    |  Transmit\n"
-			      " face |bytes    packets errs drop fifo frame "
-			      "compressed multicast|bytes    packets errs "
-			      "drop fifo colls carrier compressed\n");
+		dev_seq_show_header(seq);
 	else
 		dev_seq_printf_stats(seq, v);
 	return 0;
 }
 
+static int dev_seq_show64(struct seq_file *seq, void *v)
+{
+	if (v == SEQ_START_TOKEN)
+		dev_seq_show_header(seq);
+	else
+		dev_seq_printf_stats64(seq, v);
+	return 0;
+}
+
 static struct netif_rx_stats *softnet_get_online(loff_t *pos)
 {
 	struct netif_rx_stats *rc = NULL;
@@ -2179,11 +2230,23 @@
 	.show  = dev_seq_show,
 };
 
+static struct seq_operations dev_seq_ops64 = {
+	.start = dev_seq_start,
+	.next  = dev_seq_next,
+	.stop  = dev_seq_stop,
+	.show  = dev_seq_show64,
+};
+
 static int dev_seq_open(struct inode *inode, struct file *file)
 {
 	return seq_open(file, &dev_seq_ops);
 }
 
+static int dev_seq_open64(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &dev_seq_ops64);
+}
+
 static struct file_operations dev_seq_fops = {
 	.owner	 = THIS_MODULE,
 	.open    = dev_seq_open,
@@ -2192,6 +2255,14 @@
 	.release = seq_release,
 };
 
+static struct file_operations dev_seq_fops64 = {
+	.owner	 = THIS_MODULE,
+	.open    = dev_seq_open64,
+	.read    = seq_read,
+	.llseek  = seq_lseek,
+	.release = seq_release,
+};
+
 static struct seq_operations softnet_seq_ops = {
 	.start = softnet_seq_start,
 	.next  = softnet_seq_next,
@@ -2224,8 +2295,10 @@
 
 	if (!proc_net_fops_create("dev", S_IRUGO, &dev_seq_fops))
 		goto out;
-	if (!proc_net_fops_create("softnet_stat", S_IRUGO, &softnet_seq_fops))
+	if (!proc_net_fops_create("dev64", S_IRUGO, &dev_seq_fops64))
 		goto out_dev;
+	if (!proc_net_fops_create("softnet_stat", S_IRUGO, &softnet_seq_fops))
+		goto out_dev64;
 	if (wireless_proc_init())
 		goto out_softnet;
 	rc = 0;
@@ -2233,6 +2306,8 @@
 	return rc;
 out_softnet:
 	proc_net_remove("softnet_stat");
+out_dev64:
+	proc_net_remove("dev64");
 out_dev:
 	proc_net_remove("dev");
 	goto out;
@@ -2910,6 +2985,9 @@
 	 *	device is present.
 	 */
 
+	if (dev->get_stats)
+		net_register_stats64(dev->get_stats(dev));
+	
 	set_bit(__LINK_STATE_PRESENT, &dev->state);
 
 	dev->next = NULL;
@@ -2922,7 +3000,7 @@
 	dev_hold(dev);
 	dev->reg_state = NETREG_REGISTERING;
 	write_unlock_bh(&dev_base_lock);
-
+	
 	/* Notify protocols, that a new device appeared. */
 	notifier_call_chain(&netdev_chain, NETDEV_REGISTER, dev);
 
@@ -3145,6 +3223,9 @@
 	/* If device is running, close it first. */
 	if (dev->flags & IFF_UP)
 		dev_close(dev);
+		
+	if (dev->get_stats)
+		net_unregister_stats64(dev->get_stats(dev));
 
 	/* And unlink it from device chain. */
 	for (dp = &dev_base; (d = *dp) != NULL; dp = &d->next) {
@@ -3246,6 +3327,98 @@
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
+/*
+ *	Register all the members of the net_device_stats structure
+ *
+ */
+ 
+inline void net_register_stats64(struct net_device_stats* stats)
+{
+	if (!stats)
+		return;
+
+	watch64_register(&stats->tx_packets,0);
+	watch64_enable  (&stats->tx_packets,NULL);
+	watch64_register(&stats->rx_packets,0);
+	watch64_enable  (&stats->rx_packets,NULL);
+	watch64_register(&stats->tx_bytes,0);
+	watch64_enable  (&stats->tx_bytes,NULL);
+	watch64_register(&stats->rx_bytes,0);
+	watch64_enable  (&stats->rx_bytes,NULL);
+	watch64_register(&stats->tx_errors,0);
+	watch64_enable  (&stats->tx_errors,NULL);
+	watch64_register(&stats->rx_errors,0);
+	watch64_enable  (&stats->rx_errors,NULL);
+	watch64_register(&stats->tx_dropped,0);
+	watch64_enable  (&stats->tx_dropped,NULL);
+	watch64_register(&stats->rx_dropped,0);
+	watch64_enable  (&stats->rx_dropped,NULL);
+	watch64_register(&stats->multicast,0);
+	watch64_enable  (&stats->multicast,NULL);
+	watch64_register(&stats->collisions,0);
+	watch64_enable  (&stats->collisions,NULL);
+	watch64_register(&stats->rx_length_errors,0);
+	watch64_enable  (&stats->rx_length_errors,NULL);
+	watch64_register(&stats->rx_over_errors,0);
+	watch64_enable  (&stats->rx_over_errors,NULL);
+	watch64_register(&stats->rx_crc_errors,0);
+	watch64_enable  (&stats->rx_crc_errors,NULL);
+	watch64_register(&stats->rx_frame_errors,0);
+	watch64_enable  (&stats->rx_frame_errors,NULL);
+	watch64_register(&stats->rx_fifo_errors,0);
+	watch64_enable  (&stats->rx_fifo_errors,NULL);
+	watch64_register(&stats->rx_missed_errors,0);
+	watch64_enable  (&stats->rx_missed_errors,NULL);
+	watch64_register(&stats->tx_aborted_errors,0);
+	watch64_enable  (&stats->tx_aborted_errors,NULL);
+	watch64_register(&stats->tx_carrier_errors,0);
+	watch64_enable  (&stats->tx_carrier_errors,NULL);
+	watch64_register(&stats->tx_fifo_errors,0);
+	watch64_enable  (&stats->tx_fifo_errors,NULL);
+	watch64_register(&stats->tx_heartbeat_errors,0);
+	watch64_enable  (&stats->tx_heartbeat_errors,NULL);
+	watch64_register(&stats->tx_window_errors,0);
+	watch64_enable  (&stats->tx_window_errors,NULL);
+	watch64_register(&stats->rx_compressed,0);
+	watch64_enable  (&stats->rx_compressed,NULL);
+	watch64_register(&stats->tx_compressed,0);
+	watch64_enable  (&stats->tx_compressed,NULL);
+}
+
+/*
+ *	Unregister all the members of the net_device_stats structure
+ *
+ */
+ 
+inline void net_unregister_stats64(struct net_device_stats* stats)
+{
+	if (!stats)
+		return;
+
+	watch64_unregister(&stats->tx_packets,0);
+	watch64_unregister(&stats->rx_packets,0);
+	watch64_unregister(&stats->tx_bytes,0);
+	watch64_unregister(&stats->rx_bytes,0);
+	watch64_unregister(&stats->tx_errors,0);
+	watch64_unregister(&stats->rx_errors,0);
+	watch64_unregister(&stats->tx_dropped,0);
+	watch64_unregister(&stats->rx_dropped,0);
+	watch64_unregister(&stats->multicast,0);
+	watch64_unregister(&stats->collisions,0);
+	watch64_unregister(&stats->rx_length_errors,0);
+	watch64_unregister(&stats->rx_over_errors,0);
+	watch64_unregister(&stats->rx_crc_errors,0);
+	watch64_unregister(&stats->rx_frame_errors,0);
+	watch64_unregister(&stats->rx_fifo_errors,0);
+	watch64_unregister(&stats->rx_missed_errors,0);
+	watch64_unregister(&stats->tx_aborted_errors,0);
+	watch64_unregister(&stats->tx_carrier_errors,0);
+	watch64_unregister(&stats->tx_fifo_errors,0);
+	watch64_unregister(&stats->tx_heartbeat_errors,0);
+	watch64_unregister(&stats->tx_window_errors,0);
+	watch64_unregister(&stats->rx_compressed,0);
+	watch64_unregister(&stats->tx_compressed,0);
+}
 
 /*
  *	Initialize the DEV module. At boot time this walks the device list and
diff -Nru a/net/core/net-sysfs.c b/net/core/net-sysfs.c
--- a/net/core/net-sysfs.c	2004-09-03 12:22:08 -04:00
+++ b/net/core/net-sysfs.c	2004-09-03 12:22:08 -04:00
@@ -16,6 +16,7 @@
 #include <net/sock.h>
 #include <linux/rtnetlink.h>
 #include <linux/wireless.h>
+#include <linux/watch64.h>
 
 #define to_class_dev(obj) container_of(obj,struct class_device,kobj)
 #define to_net_dev(class) container_of(class, struct net_device, class_dev)
@@ -23,6 +24,7 @@
 static const char fmt_hex[] = "%#x\n";
 static const char fmt_dec[] = "%d\n";
 static const char fmt_ulong[] = "%lu\n";
+static const char fmt_ullong[] = "%llu\n";
 
 static inline int dev_isalive(const struct net_device *dev) 
 {
@@ -204,8 +206,8 @@
 	read_lock(&dev_base_lock);
 	if (dev_isalive(dev) && dev->get_stats &&
 	    (stats = (*dev->get_stats)(dev))) 
-		ret = sprintf(buf, fmt_ulong,
-			      *(unsigned long *)(((u8 *) stats) + offset));
+		ret = sprintf(buf, fmt_ullong,
+			      watch64_getval((unsigned long *)(((u8 *) stats) + offset),NULL));
 
 	read_unlock(&dev_base_lock);
 	return ret;

--Boundary_(ID_9IoCL9KP09e0Mk4d4FE7DQ)--
