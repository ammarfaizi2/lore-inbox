Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289762AbSCOKyN>; Fri, 15 Mar 2002 05:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289606AbSCOKx5>; Fri, 15 Mar 2002 05:53:57 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:54444 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S289556AbSCOKxh>;
	Fri, 15 Mar 2002 05:53:37 -0500
Date: Fri, 15 Mar 2002 16:12:28 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: lse-tech@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [RFC] [patch] Scalable statistics counters with /proc reporting
Message-ID: <20020315161228.A29347@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
Here is another go towards cache friendly scalable statistics counters.
This version incorporates /proc reporting, and applies cleanly on 2.5.6.

Recap:
Global shared memory locations are usually used to gather statistics of 
various events in the kernel.  This would typically cause bouncing of
cachelines along with serialization overheads for such counters in a SMP
scenario.  The following patch provides interfaces to gather statistics
in a cache friendly manner by using per-cpu data for counters. The
patch sits on top of a per-cpu dynamic word allocator, hence these interfaces
can be used in dynamically allocated structures, modules etc.  Also note that
serialization mechanisms for these counters can be done away with if your
application can tolerate slightly stale values during reads.

Usage:
Typical usage would be something like this:

struct foo {
	char *data;
	statctr_t a;
	....
	....
} foovar;


static int __init blah_init_module(void)
{
	....
	foovar = kmalloc(sizeof (struct foo), GFP_KERNEL);
	if(statctr_init(&foovar->a, 0, NULL, "procentryfora")) {
		/* could not init .. so cleanup */
		blah_cleanup(foovar)
		return -ENOMEM;
	}
	....
}

static void __exit blah_exit_module(void)
{
	....
	statctr_cleanup(&foovar->a);
	....
}	


static void blah_somefunc(void)
{
	....
	statctr_inc(&foovar->a);
	....
}


The statctr_init routine takes struct proc_dir_entry *parent as 3rd arg 
and const char *procname as fourth.  If procname is NULL, no proc entry
is created, if parent is null, entry if need to be created will be made
under  /proc/stats. There is also a statctr_ninit routine to initialise
an array/ contiguous counters part of packed structures.  But they donot
provide /proc functionality as yet.

Perfromance studies for such counters have been put up on 
http://lse.sf.net/counters/statctr.html

Comments welcome.

Regards,
Kiran.



diff -ruN linux-2.5.6/fs/proc/root.c statctr/fs/proc/root.c
--- linux-2.5.6/fs/proc/root.c	Fri Mar  8 07:48:56 2002
+++ statctr/fs/proc/root.c	Thu Mar 14 08:58:53 2002
@@ -19,6 +19,7 @@
 #include <linux/smp_lock.h>
 
 struct proc_dir_entry *proc_net, *proc_bus, *proc_root_fs, *proc_root_driver;
+struct proc_dir_entry *proc_stats;
 
 #ifdef CONFIG_SYSCTL
 struct proc_dir_entry *proc_sys_root;
@@ -76,6 +77,7 @@
 	proc_rtas_init();
 #endif
 	proc_bus = proc_mkdir("bus", 0);
+	proc_stats = proc_mkdir("stats", 0);
 }
 
 static struct dentry *proc_root_lookup(struct inode * dir, struct dentry * dentry)
diff -ruN linux-2.5.6/include/linux/pcpu_alloc.h statctr/include/linux/pcpu_alloc.h
--- linux-2.5.6/include/linux/pcpu_alloc.h	Thu Jan  1 05:30:00 1970
+++ statctr/include/linux/pcpu_alloc.h	Thu Mar 14 08:58:53 2002
@@ -0,0 +1,75 @@
+/*
+ * Per-CPU Word allocator.
+ *
+ * Inspired by the freelist maintanance of the slab allocator implementation
+ *  (in mm/slab.c)
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
+ * include/linux/pcpu_alloc.h
+ *
+ */
+#ifndef _LINUX_PCPU_ALLOC_H
+#define _LINUX_PCPU_ALLOC_H
+ 
+#ifdef __KERNEL__
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/threads.h>
+#include <linux/sched.h>
+
+/* Prototypes */
+#ifdef	CONFIG_SMP
+
+typedef struct pcpu_ctr_s {
+	void *arr[NR_CPUS];	/* Pcpu counter array */
+	void *blkp;		/* Pointer to block from which ctr was 
+				   allocated from (for use with free code) */
+} pcpu_ctr_t;
+
+extern pcpu_ctr_t *pcpu_ctr_alloc(int);
+extern void pcpu_ctr_free(pcpu_ctr_t *);
+extern void __init pcpu_ctr_sys_init(void);
+
+#define PCPU_CTR(ctr, cpuid) ((unsigned long *)ctr->arr[cpuid])
+
+#else	/* CONFIG_SMP */
+
+#include <linux/slab.h>
+
+typedef unsigned long pcpu_ctr_t;
+
+static inline pcpu_ctr_t *pcpu_ctr_alloc(int flags) 
+{
+	return(kmalloc(sizeof(pcpu_ctr_t), flags));
+}
+
+static inline void pcpu_ctr_free(pcpu_ctr_t *ptr)
+{
+	kfree(ptr);
+}
+
+#define pcpu_ctr_sys_init() do { } while (0)    
+
+#endif  /* CONFIG_SMP */
+ 
+#endif  /* __KERNEL__ */
+ 
+#endif  /* _LINUX_PCPU_ALLOC_H */
diff -ruN linux-2.5.6/include/linux/statctr.h statctr/include/linux/statctr.h
--- linux-2.5.6/include/linux/statctr.h	Thu Jan  1 05:30:00 1970
+++ statctr/include/linux/statctr.h	Thu Mar 14 08:58:53 2002
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
+#include <linux/pcpu_alloc.h>
+
+#ifdef	CONFIG_PROC_FS
+extern struct proc_dir_entry *proc_stats;
+#endif
+
+typedef struct {
+#ifdef	CONFIG_SMP
+	pcpu_ctr_t *ctr;
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
+	stctr->ctr = pcpu_ctr_alloc(GFP_ATOMIC); 
+	if(!stctr->ctr) 
+		return -1;
+	return 0;
+}
+
+static inline void __statctr_cleanup(statctr_t *stctr)
+{
+	pcpu_ctr_free(stctr->ctr);
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
+	(*PCPU_CTR(stctr->ctr, smp_processor_id()))++;
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
+	(*PCPU_CTR(stctr->ctr, smp_processor_id()))--;
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
+	*PCPU_CTR(stctr->ctr, 0) = val;
+	for (i=1; i < smp_num_cpus; i++) {
+		*PCPU_CTR(stctr->ctr, i) = 0;
+	}
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
+	for( i=0; i < smp_num_cpus; i++ )
+		res += *PCPU_CTR(stctr->ctr, i);
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
+        *PCPU_CTR(stctr->ctr, smp_processor_id()) += val;
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
+        *PCPU_CTR(stctr->ctr, smp_processor_id()) -= val;
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
diff -ruN linux-2.5.6/init/main.c statctr/init/main.c
--- linux-2.5.6/init/main.c	Fri Mar  8 07:48:15 2002
+++ statctr/init/main.c	Thu Mar 14 08:58:53 2002
@@ -27,6 +27,7 @@
 #include <linux/iobuf.h>
 #include <linux/bootmem.h>
 #include <linux/tty.h>
+#include <linux/pcpu_alloc.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -412,6 +413,7 @@
 	 *	make syscalls (and thus be locked).
 	 */
 	smp_init();
+	pcpu_ctr_sys_init();
 
 	/* Do the rest non-__init'ed, we're now alive */
 	rest_init();
diff -ruN linux-2.5.6/kernel/Makefile statctr/kernel/Makefile
--- linux-2.5.6/kernel/Makefile	Fri Mar  8 07:48:17 2002
+++ statctr/kernel/Makefile	Thu Mar 14 08:58:53 2002
@@ -10,12 +10,12 @@
 O_TARGET := kernel.o
 
 export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o \
-		printk.o 
+		printk.o statctr.o
 
 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o info.o time.o softirq.o resource.o \
 	    sysctl.o acct.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o context.o 
+	    signal.o sys.o kmod.o context.o statctr.o
 
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
diff -ruN linux-2.5.6/kernel/statctr.c statctr/kernel/statctr.c
--- linux-2.5.6/kernel/statctr.c	Thu Jan  1 05:30:00 1970
+++ statctr/kernel/statctr.c	Thu Mar 14 08:58:53 2002
@@ -0,0 +1,166 @@
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
+#include <linux/pcpu_alloc.h>
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
diff -ruN linux-2.5.6/mm/Makefile statctr/mm/Makefile
--- linux-2.5.6/mm/Makefile	Fri Mar  8 07:48:55 2002
+++ statctr/mm/Makefile	Thu Mar 14 08:58:53 2002
@@ -9,11 +9,12 @@
 
 O_TARGET := mm.o
 
-export-objs := shmem.o filemap.o mempool.o page_alloc.o
+export-objs := shmem.o filemap.o mempool.o page_alloc.o pcpu_alloc.o
 
 obj-y	 := memory.o mmap.o filemap.o mprotect.o mlock.o mremap.o \
 	    vmalloc.o slab.o bootmem.o swap.o vmscan.o page_io.o \
 	    page_alloc.o swap_state.o swapfile.o numa.o oom_kill.o \
 	    shmem.o highmem.o mempool.o
 
+obj-$(CONFIG_SMP) += pcpu_alloc.o 
 include $(TOPDIR)/Rules.make
diff -ruN linux-2.5.6/mm/pcpu_alloc.c statctr/mm/pcpu_alloc.c
--- linux-2.5.6/mm/pcpu_alloc.c	Thu Jan  1 05:30:00 1970
+++ statctr/mm/pcpu_alloc.c	Thu Mar 14 08:58:53 2002
@@ -0,0 +1,346 @@
+/*
+ * Per-CPU Counter allocator.
+ *
+ * Inspired by the freelist maintanance of the slab allocator implementation
+ *  (in mm/slab.c)
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
+ * mm/pcpu_alloc.c
+ *
+ */
+
+#include <linux/pcpu_alloc.h> 
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/cache.h>
+
+#include <asm/hardirq.h>
+
+#define PCPU_CTR_SIZE  (sizeof(unsigned long))
+#define PCPU_CTR_LINE_SIZE  (SMP_CACHE_BYTES)
+#define	PCPU_CTR_OBJS_IN_BLK  (PCPU_CTR_LINE_SIZE / PCPU_CTR_SIZE)
+
+#define	PCPU_CTR_CACHE_NAME		"pcpuctr"
+
+/*
+ * The block control structure for pcpu_ctr_t objects ...
+ */
+struct pcpu_ctr_blk {
+        void             	*lineaddr[NR_CPUS]; /* Array of pointers to 
+						       per cpu cachelines */
+        struct list_head        linkage;   /* Linkage for pcpu_ctr_blk s */
+        unsigned int            usecount;  /* To decide when to free this 
+					      block */
+	
+	/* Free list maintanance for objs on blk */
+	int			freearr[PCPU_CTR_OBJS_IN_BLK];  
+					  /* Array linked list as a per
+					      block freelist.. */
+	int			freehead;  /* Start of list ..*/
+};
+
+/*
+ * Main Control structure for pcpu_ctr_t objects ...
+ */
+struct pcpu_ctr_ctl {
+        struct list_head        blks;          /* Head ptr of the list of all 
+	                           		  blocks in the pcpu_ctr 
+						  "cache".
+						  Full, partial first then 
+						  free..*/
+        struct list_head        *firstnotfull;
+        spinlock_t              lock;
+	kmem_cache_t		*cachep;       /* Cache to alloc per cpu 
+						  cachelines from */ 
+};
+
+static struct pcpu_ctr_ctl pcpu_ctr_ctl = {
+	blks:			LIST_HEAD_INIT(pcpu_ctr_ctl.blks),
+	firstnotfull:		&pcpu_ctr_ctl.blks,
+	lock:			SPIN_LOCK_UNLOCKED,
+};
+
+/**
+ *  Allocate a block descriptor structure and initialize it.  Returns addr of
+ * block descriptor on success
+ */
+static struct pcpu_ctr_blk 
+*pcpu_ctr_blkctl_alloc(struct pcpu_ctr_ctl *ctl, int flags)
+{
+        struct pcpu_ctr_blk *blkp;
+        int i;
+        if (!(blkp = (struct pcpu_ctr_blk *) 
+			kmalloc(sizeof(struct pcpu_ctr_blk), flags)))
+                return blkp;
+        blkp->usecount = 0;
+ 
+        blkp->freehead = 0;
+        for (i=0; i < PCPU_CTR_OBJS_IN_BLK; i++)
+                blkp->freearr[i] = i+1;
+        blkp->freearr[i-1] = -1;	/* Marks the end of the array */
+ 
+        return blkp;
+}
+
+/**
+ * Frees the block descriptor structure
+ */
+static void pcpu_ctr_blkctl_free(struct pcpu_ctr_blk *blkp)
+{
+	kfree(blkp);
+}
+
+/** 
+ * Add a "block" to the pcpu_ctr object memory pool.  Returns 0 on failure and 
+ * 1 on success
+ */
+static int pcpu_ctr_mem_grow(struct pcpu_ctr_ctl *ctl, int flags)
+{
+        void *addr;
+        struct pcpu_ctr_blk *blkp;
+        unsigned int save_flags;
+        int i;
+ 
+        if (!(blkp = pcpu_ctr_blkctl_alloc(ctl, flags)))
+                return 0;
+ 
+        /* Get per cpu cache lines for the block */
+	for (i=0; i < smp_num_cpus; i++) {
+		blkp->lineaddr[i] = kmem_cache_alloc(ctl->cachep, flags);
+		if(!(blkp->lineaddr[i])) 
+			goto exit1;
+		memset(blkp->lineaddr[i], 0, PCPU_CTR_LINE_SIZE);
+        }
+ 
+        /* Now that we have the block successfully allocated and instantiated..
+           add it.....*/
+        spin_lock_irqsave(&ctl->lock, save_flags);
+        list_add_tail(&blkp->linkage, &ctl->blks);
+        if (ctl->firstnotfull == &ctl->blks)
+                ctl->firstnotfull = &blkp->linkage;
+        spin_unlock_irqrestore(&ctl->lock, save_flags);
+        return 1;
+ 
+exit1:
+	/* Free cachelines allocated to this block, and the blk struct..*/
+	i--;
+	for (i; i >= 0; i--) 
+		kmem_cache_free(ctl->cachep, blkp->lineaddr[i]);
+	pcpu_ctr_blkctl_free(blkp);	
+        return 0;
+}
+
+/**
+ * Initialise the main pcpu_ctr_ctl control structure.
+ */
+static void pcpu_ctr_init(struct pcpu_ctr_ctl * ctl)
+{
+	/*
+	 * Create cache to serve out cache line sized, cache line 
+	 * aligned chunks..
+	 */ 
+	ctl->cachep = kmem_cache_create(PCPU_CTR_CACHE_NAME,
+			PCPU_CTR_LINE_SIZE, 0, SLAB_HWCACHE_ALIGN, 
+			NULL, NULL);
+	if(!ctl->cachep)
+		BUG();
+}
+	
+/**
+ * Initialisation - setup the pcpu_ctr main control structures (pcpu_ctr_ctl)
+ */
+void __init pcpu_ctr_sys_init(void)
+{
+	pcpu_ctr_init(&pcpu_ctr_ctl);	
+	if( !pcpu_ctr_mem_grow(&pcpu_ctr_ctl, GFP_ATOMIC))
+		BUG();		
+}
+
+/**
+ * Allocs an object from the block.  Returns back the object index.
+ */
+static unsigned int
+__pcpu_ctr_alloc_one(struct pcpu_ctr_ctl *ctl, struct pcpu_ctr_blk *blkp)
+{
+        void *objp;
+        unsigned int objidx;
+ 
+        objidx = blkp->freehead;
+        blkp->freehead = blkp->freearr[objidx];
+        blkp->usecount++;
+        if(blkp->freehead < 0) {
+                /* Last obj allocated. So if this is still first not full,
+                   change it */
+                ctl->firstnotfull = blkp->linkage.next;
+        }
+ 
+        return objidx;
+}
+
+/**
+ * __pcpu_ctr_alloc - Allocate a Per CPU counter
+ */
+static pcpu_ctr_t *__pcpu_ctr_alloc(struct pcpu_ctr_ctl *ctl, int flags)
+{
+	pcpu_ctr_t *ctr;
+        struct pcpu_ctr_blk *blkp;
+        unsigned int save_flags;
+        struct list_head *l;
+	unsigned int objidx;
+	int i;
+
+	ctr = kmalloc(sizeof(pcpu_ctr_t), flags);
+	if (ctr == NULL)
+		return NULL;
+ 
+tryagain:
+ 
+        /* Get the block to allocate pcpu_ctr from.. */
+        spin_lock_irqsave(&ctl->lock, save_flags);
+        l = ctl->firstnotfull;
+        if (l == &ctl->blks)
+                goto unlock_and_get_mem;
+        blkp = list_entry(l, struct pcpu_ctr_blk, linkage);
+ 
+        /* Get the object index from the block */
+        objidx = __pcpu_ctr_alloc_one(ctl, blkp);
+        spin_unlock_irqrestore(&ctl->lock, save_flags);
+        /* Since we hold the lock and firstnotfull is not the
+           head list, we shud be getting an object alloc here.firstnotfull 
+	   can be pointing to head of the list when all the blks are 
+	   full or when there're no blocks left */
+	for (i=0; i < smp_num_cpus; i++) 
+		ctr->arr[i] = blkp->lineaddr[i] + objidx*PCPU_CTR_SIZE;
+	ctr->blkp = (void *)blkp;
+        return ctr;
+ 
+unlock_and_get_mem:
+ 
+        spin_unlock_irqrestore(&ctl->lock, save_flags);
+        if(pcpu_ctr_mem_grow(ctl, flags))
+                goto tryagain;  /* added another block..try allocing obj ..*/
+        
+	/* Unable to get mem for blocks so ret after cleanup.. */
+	kfree(ctr);
+        return NULL;
+}
+
+/**
+ * pcpu_ctr_alloc - Allocate a PCPU ctr.
+ * @flags: Type of memory to allocate
+ *	   Can take in all flags kmem_cache_alloc takes in as args.
+ * 
+ * Allocates memory to a PCPU counter. Returns NULL on failure. 
+ */
+pcpu_ctr_t *pcpu_ctr_alloc(int flags)
+{
+	return( __pcpu_ctr_alloc(&pcpu_ctr_ctl, flags));
+}
+
+/**
+ * pcpu_ctr_blk_destroy - Frees memory associated with a pcpu_ctr block
+ */
+static void 
+pcpu_ctr_blk_destroy(struct pcpu_ctr_ctl *ctl, struct pcpu_ctr_blk *blkp)
+{
+	int i;
+	
+	/* Return cache line aligned ctr lines back to slab cache */
+	for (i=0; i< smp_num_cpus; i++) 
+		kmem_cache_free(ctl->cachep, blkp->lineaddr[i]);
+
+	pcpu_ctr_blkctl_free(blkp);
+}
+
+/**
+ * Frees an object from a block and fixes the freelist accdly.
+ * Frees the slab cache memory if a block gets empty during free.
+ */
+static void __pcpu_ctr_free(struct pcpu_ctr_ctl *ctl, pcpu_ctr_t *ptr)
+{
+        struct pcpu_ctr_blk *blkp;
+        unsigned int objidx;
+        unsigned int objoffset;
+        struct list_head *t;
+	int cpuid = smp_processor_id();
+        unsigned int save_flags;
+	
+        spin_lock_irqsave(&ctl->lock, save_flags);
+ 
+        blkp = (struct pcpu_ctr_blk *)ptr->blkp;
+        objoffset = (unsigned int)(ptr->arr[cpuid] - blkp->lineaddr[cpuid]);
+        objidx = objoffset / PCPU_CTR_SIZE;
+
+	kfree(ptr);
+
+        /* Update the block freelist */
+        blkp->freearr[objidx] = blkp->freehead;
+        blkp->freehead = objidx;
+ 
+        /* Update usage count */
+        blkp->usecount--;
+ 
+        /* Fix block freelist chain */
+        if (blkp->freearr[objidx] < 0)  {
+                /* block was previously full and is now just partially full ..
+                   so make firstnotfull pt to this block and fix list accdly */
+                t = ctl->firstnotfull;
+                ctl->firstnotfull = &blkp->linkage;
+                if (blkp->linkage.next == t) {
+			spin_unlock_irqrestore(&ctl->lock, save_flags);
+                        return;
+		}
+                list_del(&blkp->linkage);
+                list_add_tail(&blkp->linkage, t);
+        	
+		spin_unlock_irqrestore(&ctl->lock, save_flags);
+                return;
+        }
+ 
+        if (blkp->usecount == 0) {
+                /* Block now empty so give mem back to the slab cache */
+                t = ctl->firstnotfull->prev;
+ 
+                list_del(&blkp->linkage);
+                if (ctl->firstnotfull == &blkp->linkage)
+                        ctl->firstnotfull = t->next;
+        	
+		spin_unlock_irqrestore(&ctl->lock, save_flags);
+		pcpu_ctr_blk_destroy(ctl, blkp);
+                return;
+        }
+ 
+        spin_unlock_irqrestore(&ctl->lock, save_flags);
+        return;
+}
+
+/**
+ * pcpu_ctr_free - Frees up a PCPU ctr from memory
+ * @ptr: Pointer to pcpu_ctr_t; 
+ */ 
+void pcpu_ctr_free(pcpu_ctr_t *ptr)
+{
+	__pcpu_ctr_free(&pcpu_ctr_ctl, ptr);
+}
+
+EXPORT_SYMBOL(pcpu_ctr_alloc);
+EXPORT_SYMBOL(pcpu_ctr_free);
