Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317181AbSHGItL>; Wed, 7 Aug 2002 04:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317182AbSHGItL>; Wed, 7 Aug 2002 04:49:11 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:48081 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317181AbSHGItF>; Wed, 7 Aug 2002 04:49:05 -0400
Date: Wed, 7 Aug 2002 14:22:27 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: lse <lse-tech@lists.sourceforge.net>, Andrew Morton <akpm@zip.com.au>,
       Rik van Riel <riel@conectiva.com.br>
Subject: [patch] Scalable statistics counters with /proc reporting
Message-ID: <20020807142227.B12301@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the new statctr patch (2.5.29) on top of kmalloc_percpu dynamic 
allocator.  This one passes GFP_ flags for statctr_init  as suggested by
Andrew Morton and makes use of cpu_possible. Counters can be grouped into 
one or multiple /proc files as per Rik's suggestion. 
Here are the revised interfaces:

1. struct statctr_proc_entry
   *create_statctr_proc_entry(struct proc_dir_entry *parent, const char *name); 
   To create a /proc file to group counters for automatic /proc reporting

2. free_statctr_proc_entry(struct statctr_proc_entry *)

   To free up the proc entry

3. int statctr_init(statctr_t *stctr, unsigned long val,
                 struct statctr_proc_entry *pentry,
                 const char *ctrname, int flags)
   
   Allocates memory to the counter , initialises it, and links the counter 
   with statctr_proc_entry for automatic /proc reporting. ctrname is the
   counter label as it appears in /proc, flags are the GFP_ hints.
   /proc reporting can be turned off if pentry is NULL.

4. statctr_cleanup(statctr_t *)
   frees up counter memory and unlinks statctr_proc_entry association.

5. statctr_inc(statctr_t *) , statctr_dec(statctr_t *) ...... for fast
   counter ops.

Rik does this suit you?


Thanks,
Kiran


diff -ruN -X dontdiff linux-2.5.29/fs/proc/proc_misc.c statctr-2.5.29-6/fs/proc/proc_misc.c
--- linux-2.5.29/fs/proc/proc_misc.c	Sat Jul 27 08:28:29 2002
+++ statctr-2.5.29-6/fs/proc/proc_misc.c	Tue Aug  6 17:05:06 2002
@@ -63,7 +63,7 @@
 extern int get_ds1286_status(char *);
 #endif
 
-static int proc_calc_metrics(char *page, char **start, off_t off,
+int proc_calc_metrics(char *page, char **start, off_t off,
 				 int count, int *eof, int len)
 {
 	if (len <= off+count) *eof = 1;
diff -ruN -X dontdiff linux-2.5.29/fs/proc/root.c statctr-2.5.29-6/fs/proc/root.c
--- linux-2.5.29/fs/proc/root.c	Sat Jul 27 08:28:41 2002
+++ statctr-2.5.29-6/fs/proc/root.c	Tue Aug  6 17:05:06 2002
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
diff -ruN -X dontdiff linux-2.5.29/include/linux/proc_fs.h statctr-2.5.29-6/include/linux/proc_fs.h
--- linux-2.5.29/include/linux/proc_fs.h	Sat Jul 27 08:28:23 2002
+++ statctr-2.5.29-6/include/linux/proc_fs.h	Tue Aug  6 17:05:06 2002
@@ -101,6 +101,7 @@
 extern struct inode * proc_get_inode(struct super_block *, int, struct proc_dir_entry *);
 
 extern int proc_match(int, const char *,struct proc_dir_entry *);
+extern int proc_calc_metrics(char *, char **, off_t, int, int *, int);
 
 /*
  * These are generic /proc routines that use the internal
diff -ruN -X dontdiff linux-2.5.29/include/linux/statctr.h statctr-2.5.29-6/include/linux/statctr.h
--- linux-2.5.29/include/linux/statctr.h	Thu Jan  1 05:30:00 1970
+++ statctr-2.5.29-6/include/linux/statctr.h	Wed Aug  7 09:25:53 2002
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
+struct statctr_proc_entry {
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
+extern int statctr_init(statctr_t *, unsigned long,
+			struct statctr_proc_entry *, const char *,int);
+extern void statctr_cleanup(statctr_t *);
+
+#ifdef CONFIG_PROC_FS
+extern struct proc_dir_entry *proc_statistics;
+extern struct statctr_proc_entry 
+	*create_statctr_proc_entry(struct proc_dir_entry *, const char *);
+extern void free_statctr_proc_entry(struct statctr_proc_entry *);
+#else
+static inline struct statctr_proc_entry 
+*create_statctr_proc_entry(struct proc_dir_entry *parent, const char *name) 
+{
+	return(NULL);
+}
+static inline void free_statctr_proc_entry(struct statctr_proc_entry *pentry)
+{ 
+} 
+#endif
+
+#ifdef	CONFIG_SMP 
+
+static inline int __statctr_init(statctr_t *stctr, int flags)
+{
+	stctr->ctr = kmalloc_percpu(sizeof(*(stctr->ctr)), flags); 
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
+static inline int __statctr_init(statctr_t *stctr, int flags)
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
diff -ruN -X dontdiff linux-2.5.29/kernel/Makefile statctr-2.5.29-6/kernel/Makefile
--- linux-2.5.29/kernel/Makefile	Sat Jul 27 08:28:31 2002
+++ statctr-2.5.29-6/kernel/Makefile	Tue Aug  6 17:05:06 2002
@@ -10,12 +10,12 @@
 O_TARGET := kernel.o
 
 export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o \
-		printk.o platform.o suspend.o
+		printk.o platform.o suspend.o statctr.o
 
 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o context.o futex.o platform.o
+	    signal.o sys.o kmod.o context.o futex.o platform.o statctr.o
 
 obj-$(CONFIG_SMP) += cpu.o
 obj-$(CONFIG_UID16) += uid16.o
diff -ruN -X dontdiff linux-2.5.29/kernel/statctr.c statctr-2.5.29-6/kernel/statctr.c
--- linux-2.5.29/kernel/statctr.c	Thu Jan  1 05:30:00 1970
+++ statctr-2.5.29-6/kernel/statctr.c	Tue Aug  6 17:05:34 2002
@@ -0,0 +1,213 @@
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
+
+#ifdef	CONFIG_PROC_FS
+static int read_statctr_proc_entry(char *page, char **start,
+			     off_t off, int count, int *eof, void *data)
+{
+	struct list_head *tmp;
+	int len = 0;
+	char *spc = " ";
+	struct statctr_proc_entry *pentry = 
+					   (struct statctr_proc_entry *) data;
+	
+	list_for_each(tmp, &pentry->head) {
+		char *str;
+		statctr_t *stctr;
+		stctr = list_entry(tmp, statctr_t, pentrylist);
+		if(!stctr->name) {
+			str = spc;
+		}
+		else {
+			str = stctr->name;
+		}
+		len += sprintf(page+len, 
+				"%s %ld\n", str, statctr_read(stctr));
+	}
+
+	return proc_calc_metrics(page, start, off, count, eof, len);
+}
+
+/**
+ * create_statctr_proc_entry - Creates and sets up a "statctr proc entry" 
+ * @parent  : proc_dir_entry under which @procname entry should appear.
+ *	      NULL is ok; but procname will be created under 
+ *	      '/proc/statistics/' -- that is as /proc/statistics/$procname
+ * @procname: Name of the /proc file which the statctr pentry represents
+ * 
+ * Memory to the statctr proc entry will be allocated by this method.
+ * This method registers the procname file under proc_dir_entry.
+ * Returns non zero on error.
+ */
+struct statctr_proc_entry 
+	*create_statctr_proc_entry(struct proc_dir_entry *parent,
+				   const char *procname)
+{
+	struct statctr_proc_entry *pentry = NULL;
+	struct proc_dir_entry *tmpentry, *tmpparent;
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
+	tmpentry = create_proc_read_entry (procname, 0444, tmpparent,
+			read_statctr_proc_entry, pentry);
+	if(!tmpentry) {
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
+ * free_statctr_proc_entry - Perform cleanup functions on a statctr pentry
+ * @pentry: Pointer to struct statctr_proc_entry type; 
+ * This method unregisters the proc entry associated with this @pentry and
+ * frees the memory pointed by it. 
+ */
+void free_statctr_proc_entry(struct statctr_proc_entry *pentry)
+{
+	if(!list_empty(&pentry->head))
+		BUG();
+	remove_proc_entry(pentry->procname, pentry->parent);
+	kfree(pentry->procname);
+	kfree(pentry);
+}
+
+static int statctr_link_pentry(statctr_t *stctr, 
+			       struct statctr_proc_entry *pentry,
+			       const char *ctrname, 
+			       int flags)
+{
+	stctr->name = NULL;
+	if(!pentry) {
+		INIT_LIST_HEAD(&stctr->pentrylist);
+		return 0;
+	}
+	
+	if(ctrname) {
+		stctr->name = kmalloc(strlen(ctrname) + 1, flags); 
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
+#define statctr_link_pentry(stctr, pentry, ctrname, flags) \
+		({do { } while (0); 0;}) 
+#define	statctr_unlink_pentry(stctr)  do { } while (0)
+#endif	/* CONFIG_PROC_FS */
+
+/**
+ * statctr_init - Sets up the statistics counter
+ * @stctr    :	Pointer to statctr_t type; counter to be initialised
+ * @val      : 	Initial value.
+ * @pentry   : 	The struct statctr_proc_entry type which represents a 
+ *		/proc entry. This should have been created by using the 
+ *		create_statctr_proc_entry interface. Passing NULL turns 
+ *		off /proc association for the counter & @ctrname is ignored.
+ * @ctrname  :	This is the label of the counter in the /proc file
+ *		indicated by @pentry. NULL is also fine; you just don't see
+ *		a label against the counter value then.
+ * @flags     :	GFP_xx flags to be passed for kernel memory allocation.
+ *
+ * Allocates memory to a statistics counter. Returns 0 on successful
+ * allocation and non zero otherwise.  Makes a /proc entry based on the
+ * pentry parameter.  statctr_init s linking to a single statctr_proc_entry
+ * should be done either single threadedly or with your own serialization.
+ * There could have been a per pentry lock on the statctr_proc_entry, but
+ * then you would have no control over the order in which entries show up 
+ * on /proc
+ */
+int statctr_init(statctr_t *stctr, unsigned long val, 
+		 struct statctr_proc_entry *pentry, 
+		 const char *ctrname, 
+		 int flags)
+{
+	if(__statctr_init(stctr, flags)) 
+		return -1;
+	if(statctr_link_pentry(stctr, pentry, ctrname, flags)) {
+		__statctr_cleanup(stctr);
+		return -1;
+	}
+	statctr_set(stctr, val);
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
+EXPORT_SYMBOL(create_statctr_proc_entry);
+EXPORT_SYMBOL(free_statctr_proc_entry);
+#endif
+
+EXPORT_SYMBOL(statctr_init);
+EXPORT_SYMBOL(statctr_cleanup);
+
