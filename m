Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269561AbUICRXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269561AbUICRXi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 13:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269343AbUICRXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 13:23:37 -0400
Received: from mta4.srv.hcvlny.cv.net ([167.206.5.70]:48160 "EHLO
	mta4.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S269725AbUICRT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 13:19:29 -0400
Date: Fri, 03 Sep 2004 13:19:24 -0400
From: "Josef 'Jeff' Sipek" <jeffpc@optonline.net>
Subject: [PATCH 2.6] watch64: generic variable monitoring system
In-reply-to: <200409031307.01240.jeffpc@optonline.net>
To: linux-kernel@vger.kernel.org
Cc: netdev@oss.sgi.com
Message-id: <200409031319.24863.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.6.2
References: <200409031307.01240.jeffpc@optonline.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The watch64 system allows the programmer to specify the approximate interval
at which he wants his variables checked. If he tries to specify shorter
interval than the minimum a default value of HZ/10 is used. To minimize
locking, RCU and seqlock are used. On 64-bit systems, all is optimized away.

The following patch can be also pulled from http://jeffpc.bkbits.net/watch64-2.6

Josef "Jeff" Sipek.

Signed-off-by: Josef "Jeff" Sipek <jeffpc@optonline.net>


diff -Nru a/Documentation/00-INDEX b/Documentation/00-INDEX
--- a/Documentation/00-INDEX 2004-09-03 12:21:17 -04:00
+++ b/Documentation/00-INDEX 2004-09-03 12:21:17 -04:00
@@ -250,6 +250,8 @@
  - directory with info regarding video/TV/radio cards and linux.
 vm/
  - directory with info on the Linux vm code.
+watch64.txt
+ - watch64 API description
 watchdog/
  - how to auto-reboot Linux if it has "fallen and can't get up". ;-)
 x86_64/
diff -Nru a/Documentation/watch64.txt b/Documentation/watch64.txt
--- /dev/null Wed Dec 31 16:00:00 196900
+++ b/Documentation/watch64.txt 2004-09-03 12:21:17 -04:00
@@ -0,0 +1,35 @@
+int watch64_register(unsigned long* ptr, unsigned int interval);
+
+ - Registers *ptr to be monitored every interval jiffies.
+ - If interval==0, WATCH64_INTERVAL will be used (HZ/10 by default)
+
+int watch64_unregister(unsigned long* ptr, struct watch64* st);
+
+ - Unregister *ptr
+ - st is optional pointer to the struct containing the registration
+  information
+ - if st==NULL, it will be looked up automatically
+
+struct watch64* watch64_find(unsigned long* ptr);
+
+ - Return struct with registration information of *ptr
+
+int watch64_disable(unsigned long* ptr, struct watch64* st);
+
+ - Disable *ptr from being monitored, without removing it from the list
+ - st is optional (see watch64_unregister for more information)
+
+int watch64_enable(unsigned long* ptr, struct watch64* st);
+
+ - Enable *ptr from being monitored (opposite of watch64_disable)
+ - st is optional (see watch64_unregister for more information)
+
+int watch64_toggle(unsigned long* ptr, struct watch64* st);
+
+ - Toggle the enable/disable status
+ - st is optional (see watch64_unregister for more information)
+
+inline u_int64_t watch64_getval(unsigned long* ptr, struct watch64* st);
+
+ - Return the whole 64-bit counter
+ - st is optional (see watch64_unregister for more information)
diff -Nru a/include/linux/watch64.h b/include/linux/watch64.h
--- /dev/null Wed Dec 31 16:00:00 196900
+++ b/include/linux/watch64.h 2004-09-03 12:21:17 -04:00
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
+#define WATCH64_INTERVAL (HZ/10)
+#define WATCH64_MINIMUM  (HZ/20)
+#define WATCH64_MAGIC  0x573634
+
+#if (BITS_PER_LONG == 64)
+
+struct watch64 {
+};
+
+#else
+
+struct watch64 {
+ struct list_head list;
+ unsigned long *ptr;
+ unsigned long oldval;
+ u_int64_t total;
+ unsigned int interval;
+ int active;
+ seqlock_t lock;
+ struct rcu_head rcuhead;
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
--- a/kernel/Makefile 2004-09-03 12:21:17 -04:00
+++ b/kernel/Makefile 2004-09-03 12:21:17 -04:00
@@ -7,7 +7,7 @@
      sysctl.o capability.o ptrace.o timer.o user.o \
      signal.o sys.o kmod.o workqueue.o pid.o \
      rcupdate.o intermodule.o extable.o params.o posix-timers.o \
-     kthread.o
+     kthread.o watch64.o
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
diff -Nru a/kernel/watch64.c b/kernel/watch64.c
--- /dev/null Wed Dec 31 16:00:00 196900
+++ b/kernel/watch64.c 2004-09-03 12:21:17 -04:00
@@ -0,0 +1,392 @@
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
+ return 0;
+}
+
+int watch64_unregister(unsigned long* ptr, struct watch64* st)
+{
+ return 0;
+}
+
+void watch64_rcufree(void* p)
+{
+}
+
+struct watch64* watch64_find(unsigned long* ptr)
+{
+ return NULL;
+}
+
+struct watch64* __watch64_find(unsigned long* ptr)
+{
+ return NULL;
+}
+
+int watch64_disable(unsigned long* ptr, struct watch64* st)
+{
+ return 0;
+}
+
+int __watch64_disable(unsigned long* ptr, struct watch64* st)
+{
+ return 0;
+}
+
+int watch64_enable(unsigned long* ptr, struct watch64* st)
+{
+ return 0;
+}
+
+int __watch64_enable(unsigned long* ptr, struct watch64* st)
+{
+ return 0;
+}
+
+int watch64_toggle(unsigned long* ptr, struct watch64* st)
+{
+ return 0;
+}
+
+inline u_int64_t watch64_getval(unsigned long* ptr, struct watch64* st)
+{
+ return (u_int64_t) *ptr;
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
+ spin_lock(&watch64_biglock);
+ 
+ if (watch64_setup==WATCH64_MAGIC) {
+  spin_unlock(&watch64_biglock);
+  return;
+ }
+ 
+ printk(KERN_WARNING "watch64: 2003/08/22 Josef 'Jeff' Sipek <jeffpc@optonline.net>\n");
+ printk(KERN_WARNING "watch64: Enabling Watch64 extensions...");
+
+ init_timer(&watch64_timer);
+ watch64_timer.function = watch64_run;
+ watch64_timer.data = (unsigned long) NULL;
+ watch64_timer.expires = jiffies + WATCH64_MINIMUM;
+ add_timer(&watch64_timer);
+
+ printk("done.\n");
+ 
+ watch64_setup = WATCH64_MAGIC;
+ 
+ spin_unlock(&watch64_biglock);
+}
+
+/*
+ *   Go through the list of registered variables and check them for changes
+ */
+
+void watch64_run(unsigned long var)
+{
+ struct list_head* entry;
+ struct watch64* watch_struct;
+ unsigned long tmp;
+
+ rcu_read_lock();
+ list_for_each_rcu(entry, &watch64_head) {
+  watch_struct = list_entry(entry, struct watch64, list);
+  if (*watch_struct->ptr != watch_struct->oldval) {
+   tmp = *watch_struct->ptr;
+   if (tmp > watch_struct->oldval) {
+    write_seqlock(&watch_struct->lock);
+    watch_struct->total += tmp - watch_struct->oldval;
+    write_sequnlock(&watch_struct->lock);
+   } else if (tmp < watch_struct->oldval) {
+    write_seqlock(&watch_struct->lock);
+    watch_struct->total += ((u_int64_t) 1<<BITS_PER_LONG) - watch_struct->oldval + tmp;
+    write_sequnlock(&watch_struct->lock);
+   }
+   watch_struct->oldval = tmp;
+  }
+ }
+ rcu_read_unlock();
+ 
+ mod_timer(&watch64_timer, jiffies + WATCH64_MINIMUM);
+}
+
+/*
+ *   Register a new variable with watch64
+ */
+
+int watch64_register(unsigned long* ptr, unsigned int interval)
+{
+ struct watch64* temp;
+ 
+ temp = (struct watch64*) kmalloc(sizeof(struct watch64),GFP_ATOMIC);
+
+ if (!temp)
+  return -ENOMEM;
+
+ if (watch64_setup!=WATCH64_MAGIC)
+  watch64_init();
+
+ temp->ptr = ptr;
+ temp->oldval = 0;
+ temp->total = 0;
+ if (interval==0)
+  temp->interval = WATCH64_INTERVAL;
+ else if (interval<WATCH64_MINIMUM) {
+  temp->interval = WATCH64_MINIMUM;
+  printk("watch64: attempted to add new watch with interval below %d jiffies",WATCH64_MINIMUM);
+ } else
+  temp->interval = interval;
+
+ temp->active = 0;
+ 
+ seqlock_init(&temp->lock);
+
+ list_add_rcu(&temp->list, &watch64_head);
+
+ return 0;
+}
+
+/*
+ *   Unregister a variable with watch64
+ */
+
+int watch64_unregister(unsigned long* ptr, struct watch64* st)
+{
+ rcu_read_lock();
+ if (!st)
+  st = __watch64_find(ptr); 
+
+ if (!st)
+  return -EINVAL;
+
+ __watch64_disable(ptr, st);
+ list_del_rcu(&st->list);
+ 
+ call_rcu(&st->rcuhead, watch64_rcufree);
+ rcu_read_unlock();
+
+ return 0;
+}
+
+/*
+ *   Free memory via RCU
+ */
+ 
+void watch64_rcufree(struct rcu_head* p)
+{
+ kfree(container_of(p, struct watch64, rcuhead));
+}
+
+/*
+ *   Find watch64 structure with RCU lock
+ */
+
+struct watch64* watch64_find(unsigned long* ptr)
+{
+ struct watch64* tmp;
+ 
+ rcu_read_lock();
+ tmp = __watch64_find(ptr);
+ rcu_read_unlock();
+ 
+ return tmp;
+}
+
+/*
+ *   Find watch64 structure without RCU lock
+ */
+
+inline struct watch64* __watch64_find(unsigned long* ptr)
+{
+ struct list_head* tmp;
+ struct watch64* watch64_struct;
+
+ list_for_each_rcu(tmp, &watch64_head) {
+  watch64_struct = list_entry(tmp, struct watch64, list);
+  if (watch64_struct->ptr==ptr)
+   return watch64_struct;
+ }
+
+ return NULL;
+}
+
+/*
+ *   Disable a variable watch with RCU lock
+ */
+
+int watch64_disable(unsigned long* ptr, struct watch64* st)
+{
+ int tmp;
+ 
+ rcu_read_lock();
+ tmp = __watch64_disable(ptr,st);
+ rcu_read_unlock();
+ 
+ return tmp;
+}
+ 
+/*
+ *   Disable a variable watch without RCU lock
+ */
+
+inline int __watch64_disable(unsigned long* ptr, struct watch64* st)
+{
+ if (!st)
+  st = watch64_find(ptr);
+
+ if (!st)
+  return -EINVAL;
+
+ st->active = 0;
+
+ return 0;
+}
+
+/*
+ *   Enable a variable watch with RCU lock
+ */
+
+int watch64_enable(unsigned long* ptr, struct watch64* st)
+{
+ int tmp;
+ 
+ rcu_read_lock();
+ tmp = __watch64_enable(ptr,st);
+ rcu_read_unlock();
+ 
+ return tmp;
+}
+ 
+/*
+ *   Enable a variable watch without RCU lock
+ */
+
+inline int __watch64_enable(unsigned long* ptr, struct watch64* st)
+{
+ if (!st)
+  st = __watch64_find(ptr);
+
+ if (!st)
+  return -EINVAL;
+
+ st->oldval = *ptr;
+ write_seqlock(&st->lock);
+ st->total  = (u_int64_t) st->oldval;
+ write_sequnlock(&st->lock);
+ st->active = 1;
+
+ return 0;
+}
+
+/*
+ *   Toggle a variable watch
+ */
+
+int watch64_toggle(unsigned long* ptr, struct watch64* st)
+{
+ rcu_read_lock();
+ if (!st)
+  st = __watch64_find(ptr);
+
+ if (!st) {
+  rcu_read_unlock();
+  return -EINVAL;
+ }
+
+ if (st->active)
+  __watch64_disable(ptr,st);
+ else
+  __watch64_enable(ptr,st);
+ rcu_read_unlock();
+
+ return 0;
+}
+
+/*
+ *   Return the total 64-bit value
+ */
+
+inline u_int64_t watch64_getval(unsigned long* ptr, struct watch64* st)
+{
+ unsigned int seq;
+ u_int64_t total;
+
+ rcu_read_lock();
+ if (!st)
+  st = __watch64_find(ptr);
+
+ if (!st) {
+  rcu_read_unlock();
+  return *ptr;
+ }
+
+ do {
+  seq = read_seqbegin(&st->lock);
+  total = st->total;
+ } while (read_seqretry(&st->lock, seq));
+ rcu_read_unlock();
+ 
+ return total;
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
