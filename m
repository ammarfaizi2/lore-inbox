Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261967AbSIYMOR>; Wed, 25 Sep 2002 08:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261966AbSIYMOR>; Wed, 25 Sep 2002 08:14:17 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:27330 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261963AbSIYMOI>;
	Wed, 25 Sep 2002 08:14:08 -0400
Date: Wed, 25 Sep 2002 17:43:05 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@zip.com.au>, Christoph Hellwig <hch@infradead.org>
Subject: Scalable statistics counters on loopback_xmit and tbench
Message-ID: <20020925174305.C30508@in.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gj572EiMnwbLXET9"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gj572EiMnwbLXET9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
I ran tbench on loopback with counters for tx_packets, rx_packets, tx_bytes,
rx_bytes replaced by statctrs.  Here're the results

2.5.38
-------
236450 total                                      0.1960  
...
  2498 loopback_xmit                              9.1838  

2.5.38+statctrs for lo
--------------------
218334 total                                      0.1805  
...
  1129 loopback_xmit                              3.5281         

Since loopback_xmit is not a significant fraction of the total ticks, 
throughput improvement is not statistically significant.

This was on a 4xPIII 700, 1G RAM, 64 tbench clients.

Below is a 2.5.38 patch for statctr, and attatched is the looopback driver 
modifications used. statctr_t is now struct statctr as per Andrew Morton's 
suggestion. statctr_ninit has been introduced to init n counters at a time.

Is this good enough to go in? 

Thanks,
Kiran


diff -X dontdiff -ruN linux-2.5.38/fs/proc/root.c statctr-2.5.38/fs/proc/root.c
--- linux-2.5.38/fs/proc/root.c	Sun Sep 22 09:55:17 2002
+++ statctr-2.5.38/fs/proc/root.c	Wed Sep 25 08:23:21 2002
@@ -19,6 +19,7 @@
 #include <linux/smp_lock.h>
 
 struct proc_dir_entry *proc_net, *proc_bus, *proc_root_fs, *proc_root_driver;
+struct proc_dir_entry *proc_statistics;
 
 #ifdef CONFIG_SYSCTL
 struct proc_dir_entry *proc_sys_root;
@@ -77,6 +78,7 @@
 	proc_rtas_init();
 #endif
 	proc_bus = proc_mkdir("bus", 0);
+	proc_statistics = proc_mkdir("statistics", 0);
 }
 
 static struct dentry *proc_root_lookup(struct inode * dir, struct dentry * dentry)
diff -X dontdiff -ruN linux-2.5.38/include/linux/statctr.h statctr-2.5.38/include/linux/statctr.h
--- linux-2.5.38/include/linux/statctr.h	Thu Jan  1 05:30:00 1970
+++ statctr-2.5.38/include/linux/statctr.h	Wed Sep 25 09:54:08 2002
@@ -0,0 +1,301 @@
+/*
+ * Scalable Statistics Counters.
+ *
+ * Visit http://lse.sourceforge.net/counters for detailed explanation of
+ *  Scalable Statistic Counters 
+ *
+ * Copyright (c) IBM Corporation, 2001, 2002
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Author:              Ravikiran Thirumalai <kiran@in.ibm.com>
+ *
+ * include/linux/statctr.h
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/proc_fs.h>
+
+struct statctr_group {
+	struct proc_dir_entry 	*parent;
+	char			*procname;
+	struct list_head	head;
+};
+
+struct statctr {
+#ifdef	CONFIG_SMP
+	unsigned long 		*ctr;
+#else
+	unsigned long 		ctr;
+#endif
+#ifdef	CONFIG_PROC_FS
+	char 			*name;
+	struct list_head	grouplist;
+#endif  /* CONFIG_PROC_FS */
+};
+
+/* prototypes */
+extern int statctr_init(struct statctr *, 
+			struct statctr_group *, const char *,int);
+extern void statctr_cleanup(struct statctr *);
+
+#ifdef CONFIG_PROC_FS
+extern struct proc_dir_entry *proc_statistics;
+extern struct statctr_group *
+create_statctr_group(struct proc_dir_entry *, const char *);
+extern void free_statctr_group(struct statctr_group *);
+#else
+static inline struct statctr_group *
+create_statctr_group(struct proc_dir_entry *parent, const char *name) 
+{
+	return NULL;
+}
+static inline void free_statctr_group(struct statctr_group *group)
+{ 
+} 
+#endif
+
+#ifdef	CONFIG_SMP 
+
+static inline int __statctr_init(struct statctr *stctr, int gfp_mask)
+{
+	stctr->ctr = kmalloc_percpu(sizeof(*(stctr->ctr)), gfp_mask); 
+	if (!stctr->ctr) 
+		return -ENOMEM;
+	return 0;
+}
+
+static inline void __statctr_cleanup(struct statctr *stctr)
+{
+	kfree_percpu(stctr->ctr);
+}
+
+/** 
+ * statctr_inc - Increment the statistics counter by one.
+ * @stctr: Statistics counter 
+ *
+ * Increments the counter by one.  Internally only the per-cpu counter is 
+ * incremented.
+ */
+
+static inline void statctr_inc(struct statctr *stctr)
+{
+	(*this_cpu_ptr(stctr->ctr))++;
+}
+
+/**
+ * statctr_dec - Deccrement the statistics counter by one.
+ * @stctr: Statistics counter
+ *
+ * Decrements the counter by one.  Internally only the per-cpu counter is
+ * incremented.
+ */
+ 
+static inline void statctr_dec(struct statctr *stctr)
+{
+	(*this_cpu_ptr(stctr->ctr))--;
+}
+
+/**
+ * statctr_set - Set the statistics counter to value passed.
+ * @stctr: Statistcs counter
+ * @val: Value to be set..
+ *
+ * Sets the statistics counter. If statctr_read() is invoked after a counter 
+ * is set, return value of statctr_read shud reflect the value set.
+ */
+ 
+static inline void statctr_set(struct statctr *stctr, unsigned long val)
+{
+	int i;
+
+	for (i=0; i < NR_CPUS; i++) {
+		if (cpu_possible(i))
+			*per_cpu_ptr(stctr->ctr, i) = 0;
+	}
+	*this_cpu_ptr(stctr->ctr) = val;
+}
+
+/**
+ * statctr_read - Returns the counter value.
+ * @stctr: Statistics counter
+ *
+ * Reads all of the other per-cpu versions of this counter, consolidates them
+ * and returns to the caller.
+ */
+ 
+static inline unsigned long statctr_read(struct statctr *stctr)
+{
+	int i;
+	unsigned long res = 0;
+	for (i=0; i < NR_CPUS; i++)
+		if (cpu_possible(i))
+			res += *per_cpu_ptr(stctr->ctr, i);
+	return res;
+}
+
+/**
+ * statctr_read_local - Returns the cpu local counter value.
+ * @stctr: Statistics counter
+ */
+ 
+static inline unsigned long statctr_read_local(struct statctr *stctr)
+{
+	return *this_cpu_ptr(stctr->ctr);
+}
+
+/**
+ * statctr_read_cpu - Returns the cpu counter value.
+ * @stctr: Statistics counter
+ */
+ 
+static inline unsigned long statctr_read_cpu(struct statctr *stctr, int cpu)
+{
+	return *per_cpu_ptr(stctr->ctr, cpu);
+}
+
+/**
+ * statctr_add - Adds the passed val to the counter value.
+ * @stctr: Statistics counter
+ * @val: Addend
+ *
+ */
+ 
+static inline void statctr_add(struct statctr *stctr, unsigned long val)
+{
+        *this_cpu_ptr(stctr->ctr) += val;
+}
+
+/**
+ * statctr_sub - Subtracts the passed val from the counter value.
+ * @stctr: Statistics counter
+ * @val: Subtrahend
+ *
+ */
+ 
+static inline void statctr_sub(struct statctr *stctr, unsigned long val)
+{
+        *this_cpu_ptr(stctr->ctr) -= val;
+}
+
+#else /* CONFIG_SMP */
+
+static inline int __statctr_init(struct statctr *stctr, int gfp_mask)
+{
+	return 0;
+}
+
+static inline void __statctr_cleanup(struct statctr *stctr) {}
+
+static inline void statctr_inc(struct statctr *stctr)
+{
+	(stctr->ctr)++;
+}
+
+static inline void statctr_dec(struct statctr *stctr)
+{
+	(stctr->ctr)--;
+}
+
+static inline unsigned long statctr_read(struct statctr *stctr)
+{
+	return stctr->ctr;
+}
+
+static inline unsigned long statctr_read_local(struct statctr *stctr)
+{
+	return stctr->ctr;
+}
+
+static inline unsigned long statctr_read_cpu(struct statctr *stctr, int cpu)
+{
+	return stctr->ctr;
+}
+
+static inline void statctr_set(struct statctr *stctr, unsigned long val) 
+{
+	stctr->ctr = val;
+}
+
+static inline void statctr_add(struct statctr *stctr, unsigned long val) 
+{
+	stctr->ctr += val;
+}
+
+static inline void statctr_sub(struct statctr *stctr, unsigned long val)
+{
+	stctr->ctr -= val;
+}
+
+#endif  /* CONFIG_SMP */
+
+/**
+ * statctr_ninit - Inits 'n' counters at a time.
+ * @group: Same as in statctr_init,
+ * @gfp_mask: Same as in statctr_init
+ * @n: No of counters to be inited 
+ * @...: Pointers to struct statctr type
+ */
+ 
+static inline int statctr_ninit(struct statctr_group *group, int gfp_mask,
+				 	int n, ...)
+{
+	va_list		ap;
+	int 		i;
+	struct statctr	*stctr;
+	
+	va_start(ap, n);
+	for (i=0; i < n; i++) {
+		stctr = va_arg(ap, struct statctr *);
+		if (statctr_init(stctr, group, NULL, gfp_mask))
+			goto cleanup;
+	}
+	va_end(ap);
+	return 0;
+
+cleanup:
+	i--;
+	va_end(ap);
+	va_start(ap, n);
+	for (; i >= 0; i--) {
+		stctr = va_arg(ap, struct statctr *);
+		statctr_cleanup(stctr);
+	}
+	va_end(ap);
+	return -ENOMEM;
+}	
+
+/**
+ * statctr_ncleanup - Cleans up 'n' counters at a time.
+ * @n: No of counters to be inited 
+ * @...: Pointers to struct statctr type
+ */
+ 
+static inline void statctr_ncleanup(int n, ...)
+{
+	va_list		ap;
+	int 		i;
+	struct statctr	*stctr;
+	
+	va_start(ap, n);
+	for (i=0; i < n; i++) {
+		stctr = va_arg(ap, struct statctr *);
+		statctr_cleanup(stctr);
+	}
+	va_end(ap);
+}
diff -X dontdiff -ruN linux-2.5.38/kernel/Makefile statctr-2.5.38/kernel/Makefile
--- linux-2.5.38/kernel/Makefile	Sun Sep 22 09:55:03 2002
+++ statctr-2.5.38/kernel/Makefile	Wed Sep 25 08:23:22 2002
@@ -3,12 +3,12 @@
 #
 
 export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o \
-		printk.o platform.o suspend.o dma.o
+		printk.o platform.o suspend.o dma.o statctr.o
 
 obj-y     = sched.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o context.o futex.o platform.o pid.o
+	    signal.o sys.o kmod.o context.o futex.o platform.o pid.o statctr.o
 
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += cpu.o
diff -X dontdiff -ruN linux-2.5.38/kernel/statctr.c statctr-2.5.38/kernel/statctr.c
--- linux-2.5.38/kernel/statctr.c	Thu Jan  1 05:30:00 1970
+++ statctr-2.5.38/kernel/statctr.c	Wed Sep 25 08:23:22 2002
@@ -0,0 +1,265 @@
+/*
+ * Scalable Statistics Counters.
+ *
+ * Visit http://lse.sourceforge.net/counters for detailed explanation of
+ *  Scalable Statistic Counters
+ *  
+ * Copyright (c) IBM Corporation, 2001, 2002.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Author:              Ravikiran Thirumalai <kiran@in.ibm.com>
+ *
+ * kernel/statctr.c
+ *
+ */
+
+#include <linux/statctr.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/seq_file.h>
+
+#ifdef	CONFIG_PROC_FS
+
+static void *statctr_start(struct seq_file *m, loff_t *pos)
+{
+	struct statctr_group *group = m->private;
+	struct list_head *tmp;
+	loff_t n = *pos; 
+
+	list_for_each(tmp, &group->head) 
+		if (!n--)
+			return list_entry(tmp, struct statctr, grouplist); 
+	return NULL;
+}
+		
+static void *statctr_next(struct seq_file *m, void *v, loff_t *pos) 
+{
+	struct statctr_group *group = m->private;
+	struct list_head *p = ((struct statctr *)v)->grouplist.next;
+	(*pos)++;
+	return p == &group->head ? NULL : list_entry(p, struct statctr, grouplist);
+}
+
+static void statctr_stop(struct seq_file *m, void *v)
+{
+}
+
+static int statctr_show(struct seq_file *m, void *v)
+{
+	char *spc = " ", *str; 
+	struct statctr *stctr = v;
+	if (!stctr->name)
+		str = spc;
+	else 
+		str = stctr->name;
+	seq_printf(m, "%15s %lu\n", str, statctr_read(stctr));
+	return 0;
+}
+
+static struct seq_operations statctr_seq_ops = {
+	.start	= statctr_start,
+	.next	= statctr_next,
+	.stop	= statctr_stop,
+	.show	= statctr_show,
+};
+
+static int statctr_open(struct inode *inode, struct file *file)
+{
+	struct proc_dir_entry *entry;
+	int res;
+	res = seq_open(file, &statctr_seq_ops);
+	if (!res) {
+		entry = PDE(inode);
+		((struct seq_file *)file->private_data)->private = entry->data;
+	}
+	return res;
+}
+
+static struct file_operations proc_statctr_ops = {
+	.open	 = statctr_open,
+	.read	 = seq_read,
+	.llseek	 = seq_lseek,
+	.release = seq_release,
+};		
+		 
+static int
+create_statctr_seq_entry(const char *name, mode_t mode, 
+			 struct proc_dir_entry *parent,
+			 struct statctr_group *group)
+{
+	int ret = 0;
+	struct proc_dir_entry *entry; 
+	entry = create_proc_entry(name, mode, parent);
+	if (entry) {
+		entry->proc_fops = &proc_statctr_ops;
+		entry->data = group;
+	}
+	else
+		ret = -1;
+	return ret;
+}
+
+/**
+ * create_statctr_group - Creates and sets up a "statctr group" 
+ * @parent  : proc_dir_entry under which @procname entry should appear.
+ *	      NULL is ok; but procname will be created under 
+ *	      '/proc/statistics/' -- that is as /proc/statistics/$procname
+ * @procname: Name of the /proc file which the statctr group represents
+ * 
+ * Memory to the statctr proc entry will be allocated by this method.
+ * This method registers the procname file under proc_dir_entry.
+ * Returns non zero on error.
+ */
+struct statctr_group *
+	create_statctr_group(struct proc_dir_entry *parent,
+				   const char *procname)
+{
+	struct statctr_group *group = NULL;
+	struct proc_dir_entry *tmpparent;
+
+	if (!procname)
+		return NULL;
+
+	if (!parent)
+		tmpparent = proc_statistics;
+	else
+		tmpparent = parent;
+
+	group = kmalloc(sizeof(*group), GFP_KERNEL);
+	if (!group) 
+		return NULL;
+
+	if (create_statctr_seq_entry (procname, 0444, tmpparent, group)) {
+		kfree(group);
+		return NULL;
+	}
+
+	group->procname = kmalloc(strlen(procname) + 1, GFP_KERNEL);
+	if (!group->procname) {
+		remove_proc_entry(procname, tmpparent);
+		kfree(group);
+		return NULL;
+	}
+	memcpy(group->procname, procname, strlen(procname)+1);
+	group->parent = tmpparent;
+	INIT_LIST_HEAD(&group->head);
+	
+	return group;
+}
+
+/**
+ * free_statctr_group - Perform cleanup functions on a statctr group
+ * @group: Pointer to struct statctr_group type; 
+ * This method unregisters the proc entry associated with this @group and
+ * frees the memory pointed by it. 
+ */
+void free_statctr_group(struct statctr_group *group)
+{
+	if (unlikely(!list_empty(&group->head)))
+		BUG();
+	remove_proc_entry(group->procname, group->parent);
+	kfree(group->procname);
+	kfree(group);
+}
+
+static int statctr_link_group(struct statctr *stctr, 
+			       struct statctr_group *group,
+			       const char *ctrname, 
+			       int gfp_mask)
+{
+	stctr->name = NULL;
+	if (!group) {
+		INIT_LIST_HEAD(&stctr->grouplist);
+		return 0;
+	}
+	
+	if (ctrname) {
+		stctr->name = kmalloc(strlen(ctrname) + 1, gfp_mask); 
+		if (!stctr->name)
+			return -ENOMEM;
+		memcpy(stctr->name, ctrname, strlen(ctrname)+1);
+	}
+	
+	list_add_tail(&stctr->grouplist, &group->head);
+	return 0;
+}
+	
+static void statctr_unlink_group(struct statctr *stctr)
+{
+	if (stctr->name)
+		kfree(stctr->name);
+	if (!list_empty(&stctr->grouplist))
+		list_del(&stctr->grouplist);
+}
+#else	/* CONFIG_PROC_FS */
+#define statctr_link_group(stctr, group, ctrname, gfp_mask) \
+		({do { } while (0); 0;}) 
+#define	statctr_unlink_group(stctr)  do { } while (0)
+#endif	/* CONFIG_PROC_FS */
+
+/**
+ * statctr_init - Sets up the statistics counter
+ * @stctr    :	Pointer to struct statctr type; counter to be initialised
+ * @group   : 	The struct statctr_group type which represents a 
+ *		/proc entry. This should have been created by using the 
+ *		create_statctr_group interface. Passing NULL turns 
+ *		off /proc association for the counter & @ctrname is ignored.
+ * @ctrname  :	This is the label of the counter in the /proc file
+ *		indicated by @group. NULL is also fine; you just don't see
+ *		a label against the counter value then.
+ * @gfp_mask     :	GFP_xx flags to be passed for kernel memory allocation.
+ *
+ * Allocates memory to a statistics counter. Returns 0 on successful
+ * allocation and non zero otherwise.  Makes a /proc entry based on the
+ * group parameter.  statctr_init s linking to a single statctr_group
+ * should be done either single threadedly or with your own serialization.
+ * There could have been a per group lock on the statctr_group, but
+ * then you would have no control over the order in which entries show up 
+ * on /proc
+ */
+int statctr_init(struct statctr *stctr, 
+		 struct statctr_group *group, 
+		 const char *ctrname, 
+		 int gfp_mask)
+{
+	int ret;
+	if ((ret = __statctr_init(stctr, gfp_mask)))
+		return ret;
+	if ((ret = statctr_link_group(stctr, group, ctrname, gfp_mask))) {
+		__statctr_cleanup(stctr);
+		return ret;
+	}
+	return 0;
+}
+
+/**
+ * statctr_cleanup - Perform cleanup functions on a statctr counter
+ * @ctr: Pointer to struct statctr type; 
+ */
+void statctr_cleanup(struct statctr *stctr)
+{
+	__statctr_cleanup(stctr);
+	statctr_unlink_group(stctr);
+}
+
+#ifdef  CONFIG_PROC_FS  
+EXPORT_SYMBOL(create_statctr_group);
+EXPORT_SYMBOL(free_statctr_group);
+#endif
+
+EXPORT_SYMBOL(statctr_init);
+EXPORT_SYMBOL(statctr_cleanup);
+

--gj572EiMnwbLXET9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="statctrusagelo.2.5.38-2.patch"

diff -ruN -X dontdiff linux-2.5.38/drivers/net/loopback.c statctr-2.5.38/drivers/net/loopback.c
--- linux-2.5.38/drivers/net/loopback.c	Sun Sep 22 09:55:01 2002
+++ statctr-2.5.38/drivers/net/loopback.c	Wed Sep 25 12:42:15 2002
@@ -39,6 +39,7 @@
 #include <linux/fcntl.h>
 #include <linux/in.h>
 #include <linux/init.h>
+#include <linux/statctr.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -115,13 +116,23 @@
 	dev_kfree_skb(skb);
 }
 
+/* Use statctrs for frequently used statistics counters. Using statctr avoids
+ * in smp. 
+ */
+
+struct fast_loopback_stats {
+	struct statctr rx_bytes;
+	struct statctr tx_bytes;
+	struct statctr rx_packets;
+	struct statctr tx_packets;
+} lstats;
+
 /*
  * The higher levels take care of making this non-reentrant (it's
  * called with bh's disabled).
  */
 static int loopback_xmit(struct sk_buff *skb, struct net_device *dev)
 {
-	struct net_device_stats *stats = (struct net_device_stats *)dev->priv;
 
 	/*
 	 *	Optimise so buffers with skb->free=1 are not copied but
@@ -160,10 +171,10 @@
 	}
 
 	dev->last_rx = jiffies;
-	stats->rx_bytes+=skb->len;
-	stats->tx_bytes+=skb->len;
-	stats->rx_packets++;
-	stats->tx_packets++;
+	statctr_add(&lstats.rx_bytes, skb->len);
+	statctr_add(&lstats.tx_bytes, skb->len);
+	statctr_inc(&lstats.rx_packets);
+	statctr_inc(&lstats.tx_packets);
 
 	netif_rx(skb);
 
@@ -172,6 +183,11 @@
 
 static struct net_device_stats *get_stats(struct net_device *dev)
 {
+	struct net_device_stats *stats = (struct net_device_stats *)dev->priv;
+	stats->rx_bytes = statctr_read(&lstats.rx_bytes);
+	stats->tx_bytes = statctr_read(&lstats.tx_bytes);
+	stats->rx_packets = statctr_read(&lstats.rx_packets);
+	stats->tx_packets = statctr_read(&lstats.tx_packets);
 	return (struct net_device_stats *)dev->priv;
 }
 
@@ -200,6 +216,13 @@
 	if (dev->priv == NULL)
 			return -ENOMEM;
 	memset(dev->priv, 0, sizeof(struct net_device_stats));
+	
+	if (statctr_ninit(NULL, GFP_KERNEL, 4, &lstats.tx_bytes, 
+				&lstats.rx_bytes, &lstats.tx_packets, 
+				&lstats.rx_packets)) {
+		kfree(dev->priv);
+		return -ENOMEM;
+	}
 	dev->get_stats = get_stats;
 
 	/*

--gj572EiMnwbLXET9--
