Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316588AbSHNLTj>; Wed, 14 Aug 2002 07:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316880AbSHNLTi>; Wed, 14 Aug 2002 07:19:38 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:30708 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S316588AbSHNLT3>; Wed, 14 Aug 2002 07:19:29 -0400
Date: Wed, 14 Aug 2002 16:50:49 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Andrew Morton <akpm@zip.com.au>, Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, dipankar@in.ibm.com
Subject: [patch] Scalable statistics counters using seq_file interfaces
Message-ID: <20020814165049.I27366@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, 
Here is the statctr 2.5.31 patch which uses the seq_file interfaces for
/proc reporting now. Do you think it is good enough to get into mainline
kernel now?  The foll patch depends on kmalloc_percpu patch for 
2.5.31 published earlier.

Christoph, since statctr_pentry describes only a proc entry for a
set of counters, I thought it'd be more descriptive to use 
statctr_proc_entry or statctr_pentry...something to indicate it is 
for proc reporting only. If CONFIG_PROC_FS is not defined, 
statctr_pentry functions will not be available.  This was my line of thought,
of course I can change it to statctr_group if you still feel that is
better. 
Thanx for the review and suggestions.  

Thanks,
Kiran



diff -ruN -X dontdiff linux-2.5.31/fs/proc/root.c statctr-2.5.31/fs/proc/root.c
--- linux-2.5.31/fs/proc/root.c	Sun Aug 11 07:11:50 2002
+++ statctr-2.5.31/fs/proc/root.c	Tue Aug 13 10:14:46 2002
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
diff -ruN -X dontdiff linux-2.5.31/include/linux/statctr.h statctr-2.5.31/include/linux/statctr.h
--- linux-2.5.31/include/linux/statctr.h	Thu Jan  1 05:30:00 1970
+++ statctr-2.5.31/include/linux/statctr.h	Tue Aug 13 10:14:46 2002
@@ -0,0 +1,254 @@
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
+#ifndef _LINUX_STATCTR_H
+#define _LINUX_STATCTR_H
+ 
+#ifdef  __KERNEL__
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/proc_fs.h>
+
+struct statctr_pentry {
+	struct proc_dir_entry 	*parent;
+	char			*procname;
+	struct list_head	head;
+};
+
+typedef struct {
+#ifdef	CONFIG_SMP
+	unsigned long 		*ctr;
+#else
+	unsigned long 		ctr;
+#endif
+#ifdef	CONFIG_PROC_FS
+	char 			*name;
+	struct list_head	pentrylist;
+#endif  /* CONFIG_PROC_FS */
+} statctr_t;
+
+/* prototypes */
+extern int statctr_init(statctr_t *, 
+			struct statctr_pentry *, const char *,int);
+extern void statctr_cleanup(statctr_t *);
+
+#ifdef CONFIG_PROC_FS
+extern struct proc_dir_entry *proc_statistics;
+extern struct statctr_pentry 
+	*create_statctr_pentry(struct proc_dir_entry *, const char *);
+extern void free_statctr_pentry(struct statctr_pentry *);
+#else
+static inline struct statctr_pentry 
+*create_statctr_pentry(struct proc_dir_entry *parent, const char *name) 
+{
+	return(NULL);
+}
+static inline void free_statctr_pentry(struct statctr_entry *pentry)
+{ 
+} 
+#endif
+
+#ifdef	CONFIG_SMP 
+
+static inline int __statctr_init(statctr_t *stctr, int gfp_mask)
+{
+	stctr->ctr = kmalloc_percpu(sizeof(*(stctr->ctr)), gfp_mask); 
+	if(!stctr->ctr) 
+		return -1;
+	return 0;
+}
+
+static inline void __statctr_cleanup(statctr_t *stctr)
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
+static inline void statctr_inc(statctr_t *stctr)
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
+static inline void statctr_dec(statctr_t *stctr)
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
+static inline void statctr_set(statctr_t *stctr, unsigned long val)
+{
+	int i;
+
+	for (i=0; i < NR_CPUS; i++) {
+		if(cpu_possible(i))
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
+static inline unsigned long statctr_read(statctr_t *stctr)
+{
+	int i;
+	unsigned long res = 0;
+	for( i=0; i < NR_CPUS; i++ )
+		if(cpu_possible(i))
+			res += *per_cpu_ptr(stctr->ctr, i);
+	return res;
+}
+
+/**
+ * statctr_read_local - Returns the cpu local counter value.
+ * @stctr: Statistics counter
+ */
+ 
+static inline unsigned long statctr_read_local(statctr_t *stctr)
+{
+	return *this_cpu_ptr(stctr->ctr);
+}
+
+/**
+ * statctr_read_cpu - Returns the cpu counter value.
+ * @stctr: Statistics counter
+ */
+ 
+static inline unsigned long statctr_read_cpu(statctr_t *stctr, int cpu)
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
+static inline void statctr_add(statctr_t *stctr, unsigned long val)
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
+static inline void statctr_sub(statctr_t *stctr, unsigned long val)
+{
+        *this_cpu_ptr(stctr->ctr) -= val;
+}
+
+#else /* CONFIG_SMP */
+
+static inline int __statctr_init(statctr_t *stctr, int gfp_mask)
+{
+	return 0;
+}
+
+static inline void __statctr_cleanup(statctr_t *stctr) {}
+
+static inline void statctr_inc(statctr_t *stctr)
+{
+	(stctr->ctr)++;
+}
+
+static inline void statctr_dec(statctr_t *stctr)
+{
+	(stctr->ctr)--;
+}
+
+static inline unsigned long statctr_read(statctr_t *stctr)
+{
+	return(stctr->ctr);
+}
+
+static inline unsigned long statctr_read_local(statctr_t *stctr)
+{
+	return(stctr->ctr);
+}
+
+static inline unsigned long statctr_read_cpu(statctr_t *stctr, int cpu)
+{
+	return(stctr->ctr);
+}
+
+static inline void statctr_set(statctr_t *stctr, unsigned long val) 
+{
+	stctr->ctr = val;
+}
+
+static inline void statctr_add(statctr_t *stctr, unsigned long val) 
+{
+	stctr->ctr += val;
+}
+
+static inline void statctr_sub(statctr_t *stctr, unsigned long val)
+{
+	stctr->ctr -= val;
+}
+
+#endif  /* CONFIG_SMP */
+
+#endif  /* __KERNEL__ */
+ 
+#endif  /* _LINUX_STATCTR_H */
diff -ruN -X dontdiff linux-2.5.31/kernel/Makefile statctr-2.5.31/kernel/Makefile
--- linux-2.5.31/kernel/Makefile	Sun Aug 11 07:11:23 2002
+++ statctr-2.5.31/kernel/Makefile	Tue Aug 13 10:14:46 2002
@@ -10,12 +10,13 @@
 O_TARGET := kernel.o
 
 export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o \
-		printk.o platform.o suspend.o dma.o
+		printk.o platform.o suspend.o dma.o statctr.o
 
 obj-y     = sched.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o context.o futex.o platform.o
+	    signal.o sys.o kmod.o context.o futex.o platform.o \
+	    statctr.o
 
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += cpu.o
diff -ruN -X dontdiff linux-2.5.31/kernel/statctr.c statctr-2.5.31/kernel/statctr.c
--- linux-2.5.31/kernel/statctr.c	Thu Jan  1 05:30:00 1970
+++ statctr-2.5.31/kernel/statctr.c	Wed Aug 14 12:47:21 2002
@@ -0,0 +1,264 @@
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
+	struct statctr_pentry *pentry = m->private;
+	struct list_head *tmp;
+	loff_t n = *pos; 
+
+	list_for_each(tmp, &pentry->head) 
+		if(!n--)
+			return list_entry(tmp, statctr_t, pentrylist); 
+	return NULL;
+}
+		
+static void *statctr_next(struct seq_file *m, void *v, loff_t *pos) 
+{
+	struct statctr_pentry *pentry = m->private;
+	struct list_head *p = ((statctr_t *)v)->pentrylist.next;
+	(*pos)++;
+	return p==&pentry->head ? NULL : list_entry(p, statctr_t, pentrylist);
+}
+
+static void statctr_stop(struct seq_file *m, void *v)
+{
+}
+
+static int statctr_show(struct seq_file *m, void *v)
+{
+	char *spc = " ", *str; 
+	statctr_t *stctr = v;
+	if(!stctr->name)
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
+			 struct statctr_pentry *pentry)
+{
+	int ret = 0;
+	struct proc_dir_entry *entry; 
+	entry = create_proc_entry(name, mode, parent);
+	if (entry) {
+		entry->proc_fops = &proc_statctr_ops;
+		entry->data = pentry;
+	}
+	else
+		ret = -1;
+	return ret;
+}
+
+/**
+ * create_statctr_pentry - Creates and sets up a "statctr proc entry" 
+ * @parent  : proc_dir_entry under which @procname entry should appear.
+ *	      NULL is ok; but procname will be created under 
+ *	      '/proc/statistics/' -- that is as /proc/statistics/$procname
+ * @procname: Name of the /proc file which the statctr pentry represents
+ * 
+ * Memory to the statctr proc entry will be allocated by this method.
+ * This method registers the procname file under proc_dir_entry.
+ * Returns non zero on error.
+ */
+struct statctr_pentry 
+	*create_statctr_pentry(struct proc_dir_entry *parent,
+				   const char *procname)
+{
+	struct statctr_pentry *pentry = NULL;
+	struct proc_dir_entry *tmpparent;
+
+	if(!procname)
+		return NULL;
+
+	if(!parent)
+		tmpparent = proc_statistics;
+	else
+		tmpparent = parent;
+
+	pentry = kmalloc(sizeof(*pentry), GFP_KERNEL);
+	if(!pentry) 
+		return NULL;
+
+	if(create_statctr_seq_entry (procname, 0444, tmpparent, pentry)) {
+		kfree(pentry);
+		return NULL;
+	}
+
+	pentry->procname = kmalloc(strlen(procname) + 1, GFP_KERNEL);
+	if(!pentry->procname) {
+		remove_proc_entry(procname, tmpparent);
+		kfree(pentry);
+		return NULL;
+	}
+	memcpy(pentry->procname, procname, strlen(procname)+1);
+	pentry->parent = tmpparent;
+	INIT_LIST_HEAD(&pentry->head);
+	
+	return pentry;
+}
+
+/**
+ * free_statctr_pentry - Perform cleanup functions on a statctr pentry
+ * @pentry: Pointer to struct statctr_pentry type; 
+ * This method unregisters the proc entry associated with this @pentry and
+ * frees the memory pointed by it. 
+ */
+void free_statctr_pentry(struct statctr_pentry *pentry)
+{
+	if(!list_empty(&pentry->head))
+		BUG();
+	remove_proc_entry(pentry->procname, pentry->parent);
+	kfree(pentry->procname);
+	kfree(pentry);
+}
+
+static int statctr_link_pentry(statctr_t *stctr, 
+			       struct statctr_pentry *pentry,
+			       const char *ctrname, 
+			       int gfp_mask)
+{
+	stctr->name = NULL;
+	if(!pentry) {
+		INIT_LIST_HEAD(&stctr->pentrylist);
+		return 0;
+	}
+	
+	if(ctrname) {
+		stctr->name = kmalloc(strlen(ctrname) + 1, gfp_mask); 
+		if(!stctr->name)
+			return -1;
+		memcpy(stctr->name, ctrname, strlen(ctrname)+1);
+	}
+	
+	list_add_tail(&stctr->pentrylist, &pentry->head);
+	return 0;
+}
+	
+static void statctr_unlink_pentry(statctr_t *stctr)
+{
+	if(stctr->name)
+		kfree(stctr->name);
+	if(!list_empty(&stctr->pentrylist))
+		list_del(&stctr->pentrylist);
+}
+#else	/* CONFIG_PROC_FS */
+#define statctr_link_pentry(stctr, pentry, ctrname, gfp_mask) \
+		({do { } while (0); 0;}) 
+#define	statctr_unlink_pentry(stctr)  do { } while (0)
+#endif	/* CONFIG_PROC_FS */
+
+/**
+ * statctr_init - Sets up the statistics counter
+ * @stctr    :	Pointer to statctr_t type; counter to be initialised
+ * @pentry   : 	The struct statctr_pentry type which represents a 
+ *		/proc entry. This should have been created by using the 
+ *		create_statctr_pentry interface. Passing NULL turns 
+ *		off /proc association for the counter & @ctrname is ignored.
+ * @ctrname  :	This is the label of the counter in the /proc file
+ *		indicated by @pentry. NULL is also fine; you just don't see
+ *		a label against the counter value then.
+ * @gfp_mask     :	GFP_xx flags to be passed for kernel memory allocation.
+ *
+ * Allocates memory to a statistics counter. Returns 0 on successful
+ * allocation and non zero otherwise.  Makes a /proc entry based on the
+ * pentry parameter.  statctr_init s linking to a single statctr_pentry
+ * should be done either single threadedly or with your own serialization.
+ * There could have been a per pentry lock on the statctr_pentry, but
+ * then you would have no control over the order in which entries show up 
+ * on /proc
+ */
+int statctr_init(statctr_t *stctr, 
+		 struct statctr_pentry *pentry, 
+		 const char *ctrname, 
+		 int gfp_mask)
+{
+	if(__statctr_init(stctr, gfp_mask)) 
+		return -1;
+	if(statctr_link_pentry(stctr, pentry, ctrname, gfp_mask)) {
+		__statctr_cleanup(stctr);
+		return -1;
+	}
+	return 0;
+}
+
+/**
+ * statctr_cleanup - Perform cleanup functions on a statctr counter
+ * @ctr: Pointer to statctr_t type; 
+ */
+void statctr_cleanup(statctr_t *stctr)
+{
+	__statctr_cleanup(stctr);
+	statctr_unlink_pentry(stctr);
+}
+
+#ifdef  CONFIG_PROC_FS  
+EXPORT_SYMBOL(create_statctr_pentry);
+EXPORT_SYMBOL(free_statctr_pentry);
+#endif
+
+EXPORT_SYMBOL(statctr_init);
+EXPORT_SYMBOL(statctr_cleanup);
+
