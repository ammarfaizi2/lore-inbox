Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317762AbSGZPHF>; Fri, 26 Jul 2002 11:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317763AbSGZPHF>; Fri, 26 Jul 2002 11:07:05 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:22761 "EHLO e1.esmtp.ibm.com.")
	by vger.kernel.org with ESMTP id <S317762AbSGZPHB>;
	Fri, 26 Jul 2002 11:07:01 -0400
Date: Fri, 26 Jul 2002 20:40:33 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: lse <lse-tech@lists.sourceforge.net>, riel@conectiva.com.br
Subject: [RFC] Scalable statistics counters using kmalloc_percpu
Message-ID: <20020726204033.D18570@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a Scalable statistics counter implementation which works on top
of the kmalloc_percpu dynamic allocator published by Dipankar.
This patch is against 2.5.27.

Description:
The following patch provides easy to use interfaces to replace 
kernel counters where read accuracy is not that important and write is
frequent, for better cache characteristics.  The foll patch also exports 
the kernel counters to user apps via /proc.   
Major benefits can be acheived when these statistics counters are used
inplace of  atomic_t counters as you avoid expensive locked instructions.

This patch provides the following interfaces :

1. statctr_init(statctr_t *ctr, unsigned long initval,
	struct proc_dir_entry *parent, const char *procname);
   Allocates memory to the counter and initialises it; 
2. statctr_cleanup(statctr_t *); 
   Cleans up allocated counter
3. statctr_inc(statctr_t *);
   Increments the counter
4. statctr_dec(statctr_t *);
   Decrements the counter
5. statctr_add
.
.

For more details visit
http://lse.sf.net/counters

Rik, You were interested in using this.  Does this implementation suit
your needs?

Comments most welcome

Thanks,
Kiran



diff -ruN -X dontdiff linux-2.5.25/fs/proc/root.c statctr-2.5.25/fs/proc/root.c
--- linux-2.5.25/fs/proc/root.c	Sat Jul  6 05:12:33 2002
+++ statctr-2.5.25/fs/proc/root.c	Sun Jul 14 14:24:47 2002
@@ -19,6 +19,7 @@
 #include <linux/smp_lock.h>
 
 struct proc_dir_entry *proc_net, *proc_bus, *proc_root_fs, *proc_root_driver;
+struct proc_dir_entry *proc_stats;
 
 #ifdef CONFIG_SYSCTL
 struct proc_dir_entry *proc_sys_root;
@@ -77,6 +78,7 @@
 	proc_rtas_init();
 #endif
 	proc_bus = proc_mkdir("bus", 0);
+	proc_stats = proc_mkdir("stats", 0);
 }
 
 static struct dentry *proc_root_lookup(struct inode * dir, struct dentry * dentry)

diff -ruN -X dontdiff linux-2.5.25/include/linux/statctr.h statctr-2.5.25/include/linux/statctr.h
--- linux-2.5.25/include/linux/statctr.h	Thu Jan  1 05:30:00 1970
+++ statctr-2.5.25/include/linux/statctr.h	Sun Jul 14 14:24:47 2002
@@ -0,0 +1,186 @@
+/*
+ * Scalable Statistics Counters.
+ *
+ * Visit http://lse.sourceforge.net/counters for detailed explanation of
+ *  Scalable Statistic Counters 
+ *
+ * Copyright (c) International Business Machines Corp., 2001
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
+#if     !defined(_LINUX_STATCTR_H)
+#define _LINUX_STATCTR_H
+ 
+#if     defined(__KERNEL__)
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/proc_fs.h>
+
+#ifdef	CONFIG_PROC_FS
+extern struct proc_dir_entry *proc_stats;
+#endif
+
+typedef struct {
+#ifdef	CONFIG_SMP
+	unsigned long *ctr;
+#else
+	unsigned long ctr;
+#endif
+#ifdef	CONFIG_PROC_FS
+	struct proc_dir_entry *base;
+	char *name;
+#endif  /* CONFIG_PROC_FS */
+} statctr_t;
+
+/* prototypes */
+extern int statctr_init(statctr_t *, unsigned long,
+			struct proc_dir_entry *, const char *);
+extern void statctr_cleanup(statctr_t *);
+extern int statctr_ninit(statctr_t *, unsigned long, int);
+extern void statctr_ncleanup(statctr_t *, int);
+
+#ifdef	CONFIG_SMP 
+
+static inline int __statctr_init(statctr_t *stctr)
+{
+	stctr->ctr = kmalloc_percpu(sizeof(*(stctr->ctr)), GFP_ATOMIC); 
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
+#else	/* CONFIG_SMP */
+
+static inline int __statctr_init(statctr_t *stctr)
+{
+	return 0;
+}
+
+static inline void __statctr_cleanup(statctr_t *stctr) {}
+
+#endif	/* CONFIG_SMP */
+
+/* inlines */
+#ifdef	CONFIG_SMP
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
+	(*per_cpu_ptr(stctr->ctr, smp_processor_id()))++;
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
+	(*per_cpu_ptr(stctr->ctr, smp_processor_id()))--;
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
+		*per_cpu_ptr(stctr->ctr, i) = 0;
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
+static inline long statctr_read(statctr_t *stctr)
+{
+	int i;
+	unsigned long res = 0;
+	for( i=0; i < NR_CPUS; i++ )
+		res += *per_cpu_ptr(stctr->ctr, i);
+	return res;
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
+        *per_cpu_ptr(stctr->ctr, smp_processor_id()) += val;
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
+        *per_cpu_ptr(stctr->ctr, smp_processor_id()) -= val;
+}
+#else /* CONFIG_SMP */
+#define statctr_inc(stctr)	(((stctr)->ctr)++)
+#define statctr_dec(stctr) (((stctr)->ctr)--)
+#define statctr_read(stctr) ((stctr)->ctr)
+#define statctr_set(stctr,val) ((stctr)->ctr = (val))
+#define statctr_add(stctr,val) (((stctr)->ctr)+=(val))
+#define statctr_sub(stctr,val) (((stctr)->ctr)-=(val))
+#endif
+
+#endif  /* __KERNEL__ */
+ 
+#endif  /* _LINUX_STATCTR_H */
diff -ruN -X dontdiff linux-2.5.25/kernel/Makefile statctr-2.5.25/kernel/Makefile
--- linux-2.5.25/kernel/Makefile	Sat Jul  6 05:12:18 2002
+++ statctr-2.5.25/kernel/Makefile	Sun Jul 14 14:24:47 2002
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
 
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
diff -ruN -X dontdiff linux-2.5.25/kernel/statctr.c statctr-2.5.25/kernel/statctr.c
--- linux-2.5.25/kernel/statctr.c	Thu Jan  1 05:30:00 1970
+++ statctr-2.5.25/kernel/statctr.c	Sun Jul 14 14:24:47 2002
@@ -0,0 +1,165 @@
+/*
+ * Scalable Statistics Counters.
+ *
+ * Visit http://lse.sourceforge.net/counters for detailed explanation of
+ *  Scalable Statistic Counters
+ *  
+ * Copyright (c) International Business Machines Corp., 2001
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
+static int proc_read_statctr(char *page, char **start,
+			     off_t off, int count, int *eof, void *data)
+{
+	int len;
+	statctr_t *stctr = (statctr_t *) data;
+	len = sprintf(page, "%ld\n", statctr_read(stctr));
+	return len;
+}
+
+static int statctr_proc_init(statctr_t *stctr, struct proc_dir_entry *procbase,
+			     const char *procname)
+{
+	struct proc_dir_entry *tmpbase, *tmp;
+
+	stctr->name = NULL;
+	stctr->base = NULL;
+	tmpbase = proc_stats;
+
+	if (procname != NULL) {
+		if(procbase != NULL) 
+			tmpbase = procbase;
+		tmp = create_proc_read_entry( procname, 0444, tmpbase, 
+			proc_read_statctr, stctr);
+		if (!tmp)
+			return -1;
+		stctr->name = kmalloc(strlen(procname) + 1, GFP_ATOMIC);
+		if(!stctr->name) {
+			remove_proc_entry(procname, tmpbase);
+			return -1;
+		}
+		memcpy(stctr->name, procname, strlen(procname)+1);
+		stctr->base = tmpbase;
+	}
+	return 0;
+}
+
+static void statctr_proc_remove(statctr_t *stctr)
+{
+	if(stctr->name) {
+		remove_proc_entry(stctr->name, stctr->base);
+		kfree(stctr->name);
+	}
+}
+
+#else	/* CONFIG_PROC_FS */
+#define statctr_proc_init(ctr, base, name) ({do { } while (0); 0;})
+#define statctr_proc_remove(ctr)  do { } while (0) 
+#endif	/* CONFIG_PROC_FS */
+
+/**
+ * statctr_init - Sets up the statistics counter
+ * @ctr: Pointer to statctr_t type; counter to be initialised
+ * @val: Initialization value.
+ * @procbase: The base /proc dir where the statctr entry is to be created -
+ *		(return value of a proc_mkdir)
+ *		/proc/stats will be considered as the base if
+ *		NULL is passed to this parameter
+ * @procname: /proc entry name.  No /proc stuff inits are done if the 
+ *		name is NULL, but statctr is nevertheless initialized
+ *
+ * Allocates memory to a statistics counter. Returns 0 on successful
+ * allocation and non zero otherwise.  Makes a /proc entry based on the
+ * procbase and procname parameters.
+ */
+int statctr_init(statctr_t *stctr, unsigned long val, 
+		 struct proc_dir_entry *procbase, const char *procname)
+{
+	if(statctr_proc_init(stctr, procbase, procname))
+		return -1;
+	if(__statctr_init(stctr)) {
+		statctr_proc_remove(stctr);
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
+	statctr_proc_remove(stctr);
+}
+
+/**
+ * statctr_ninit - Inits a bunch of contiguos statctrs
+ * @ctr: Ptr to first ctr to be inited in the bunch
+ * @val: Val to be set
+ * @no : No of ctrs to be inited
+ *
+ * Inits a bunch of contigious statctrs.  Useful when statctrs
+ * are used as arrays or in "packed" structures.
+ * Returns non zero if inits fail
+ */
+int statctr_ninit(statctr_t *stctr, unsigned long val, int no)
+{
+        int i;
+        for(i=0; i < no; i++) {
+                if(statctr_init(&stctr[i], val, NULL, NULL))
+                        goto cleanup;
+        }
+        return 0;
+ 
+cleanup:
+	i--;
+        for(; i >= 0; i--) {
+                statctr_cleanup(&stctr[i]);
+        }
+	return -1;
+}
+
+/**
+ * statctr_ncleanup - cleans up a bunch of contiguos statctrs
+ * @ctr: Ptr to first ctr to be inited in the bunch
+ * @no : No of ctrs to be inited
+ *
+ */
+void statctr_ncleanup(statctr_t *stctr, int no)
+{
+        int i;
+        for(i=0; i < no; i++) 
+                statctr_cleanup(&stctr[i]);
+}
+
+EXPORT_SYMBOL(statctr_init);
+EXPORT_SYMBOL(statctr_cleanup);
+EXPORT_SYMBOL(statctr_ninit);
+EXPORT_SYMBOL(statctr_ncleanup);
+
