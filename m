Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293193AbSCAOum>; Fri, 1 Mar 2002 09:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293219AbSCAOuh>; Fri, 1 Mar 2002 09:50:37 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:24210 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S293193AbSCAOuZ>; Fri, 1 Mar 2002 09:50:25 -0500
Date: Fri, 1 Mar 2002 20:13:32 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [Patch] Performance improvements with scalable statistics counters
Message-ID: <20020301201332.A26176@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
We did some measurements by modifying the loopback driver to use scalable
statistics counters, and the results follow...

Recall that this approach uses per-cpu versions for counters instead of a 
shared global location; reducing counter cacheline bouncing thus 
improving SMP performance. Particularly useful for frequently updated
statistics counters used in the kernel. The implementation uses a per-cpu 
dynamic word allocator.  For the UP case, the interfaces wrap onto the 
usual global shared counter.

Results:
-------

1. Running tbench with 40 clients on loopback interface on 8 way smp.
   (Throughput in MB/sec averaged for 10 runs)

Cpus	Vanilla kernel		Statctr mods to lo	% improvement
----	-------------		------------------	-------------
 8	72.69243		78.45725		7.93
 7	71.88495		73.35581		2.04
 6	77.65202		78.95159		1.67
 5	83.02133		90.67332		9.21
 4	83.77254		84.41258		0.76
 3	73.32989		74.73163		1.91
 2	56.27168		57.20956		1.67

2. Kernprof PC sample profile count in loopback_xmit (This is the lo routine
   which is modified to use scalable statistics counters). This was for 4 runs
   of tbench 40 on the loopback interface 
   (kernprof -b -c all -d time  -f 20000 -t pc) 

Cpus	Vanilla Kernel		Statctr mods to lo	% less time spent
----	-------------		------------------	-----------------
 8	217844  		66648			69.40
 7	136920  		65836			51.91
 6	134528  		64739			51.87
 5	131168  		62214			52.56
 4	119877  		65441			45.40
 3	123957  		63022			49.15
 2	125826  		59127			53.00


You can find microbenchmark comparisons and interface/implementation details on
http://lse.sourceforge.net/counters/statctr.html

Measurements above were made on a 2.4.16 kernel.  Find the statctr and lo 
modification patches for 2.5.5 below.  

Comments, suggestions welcome.

Regards,
Kiran

PS: Note that you cannot compile any other network driver if lo patch is 
applied too..

Statctr Patch:
--------------

diff -ruN linux-2.5.5/include/linux/pcpu_alloc.h statctr-2.5.5/include/linux/pcpu_alloc.h
--- linux-2.5.5/include/linux/pcpu_alloc.h	Thu Jan  1 05:30:00 1970
+++ statctr-2.5.5/include/linux/pcpu_alloc.h	Fri Mar  1 11:38:16 2002
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
diff -ruN linux-2.5.5/include/linux/statctr.h statctr-2.5.5/include/linux/statctr.h
--- linux-2.5.5/include/linux/statctr.h	Thu Jan  1 05:30:00 1970
+++ statctr-2.5.5/include/linux/statctr.h	Fri Mar  1 12:22:27 2002
@@ -0,0 +1,171 @@
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
+#include <linux/pcpu_alloc.h>
+
+#ifdef	CONFIG_SMP
+typedef struct {
+	pcpu_ctr_t *ctr;
+} statctr_t;
+
+#else
+typedef unsigned long statctr_t;
+#endif
+
+
+/* prototypes */
+#ifdef	CONFIG_SMP 
+extern int statctr_init(statctr_t *, unsigned long);
+extern void statctr_cleanup(statctr_t *);
+extern int statctr_ninit(statctr_t *, unsigned long, int);
+extern void statctr_ncleanup(statctr_t *, int);
+#else
+#define statctr_init(stctr, val)	({*(stctr) = (val); 0;})
+#define statctr_cleanup(stctr)	do { } while (0)
+
+static inline int 
+statctr_ninit(statctr_t *stctr, unsigned long val, int no)
+{
+	int i;
+	for(i=0; i < no; i++) {
+		*(stctr) = val;
+		stctr++;
+	}
+	return 0;
+}
+
+#define statctr_ncleanup(st, bn)	do { } while (0)
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
+#define statctr_inc(stctr)	((*(stctr))++)
+#define statctr_dec(stctr) ((*(stctr))--)
+#define statctr_read(stctr) (*stctr)
+#define statctr_set(stctr,val) (*(stctr) = (val))
+#define statctr_add(stctr,val) ((*(stctr))+=(val))
+#define statctr_sub(stctr,val) ((*(stctr))-=(val))
+#endif
+
+#endif  /* __KERNEL__ */
+ 
+#endif  /* _LINUX_STATCTR_H */
diff -ruN linux-2.5.5/init/main.c statctr-2.5.5/init/main.c
--- linux-2.5.5/init/main.c	Wed Feb 20 07:40:56 2002
+++ statctr-2.5.5/init/main.c	Fri Mar  1 11:38:16 2002
@@ -27,6 +27,7 @@
 #include <linux/iobuf.h>
 #include <linux/bootmem.h>
 #include <linux/tty.h>
+#include <linux/pcpu_alloc.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -383,6 +384,7 @@
 	 *	make syscalls (and thus be locked).
 	 */
 	smp_init();
+	pcpu_ctr_sys_init();
 
 	/* Do the rest non-__init'ed, we're now alive */
 	rest_init();
diff -ruN linux-2.5.5/kernel/Makefile statctr-2.5.5/kernel/Makefile
--- linux-2.5.5/kernel/Makefile	Wed Feb 20 07:40:57 2002
+++ statctr-2.5.5/kernel/Makefile	Fri Mar  1 11:38:16 2002
@@ -10,7 +10,7 @@
 O_TARGET := kernel.o
 
 export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o \
-		printk.o 
+		printk.o statctr.o
 
 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o info.o time.o softirq.o resource.o \
@@ -20,6 +20,7 @@
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
 obj-$(CONFIG_PM) += pm.o
+obj-$(CONFIG_SMP) += statctr.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff -ruN linux-2.5.5/kernel/statctr.c statctr-2.5.5/kernel/statctr.c
--- linux-2.5.5/kernel/statctr.c	Thu Jan  1 05:30:00 1970
+++ statctr-2.5.5/kernel/statctr.c	Fri Mar  1 12:13:36 2002
@@ -0,0 +1,104 @@
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
+/**
+ * statctr_init - Sets up the statistics counter
+ * @ctr: Pointer to statctr_t type; counter to be initialised
+ * @val: Initialization value.
+ *
+ * Allocates memory to a statistics counter. Returns 0 on successful
+ * allocation and non zero otherwise
+ */
+int statctr_init(statctr_t *stctr, unsigned long val)
+{
+	stctr->ctr = pcpu_ctr_alloc(GFP_ATOMIC);
+	if(!stctr->ctr) 
+		return -1;
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
+	pcpu_ctr_free(stctr->ctr);
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
+                if(statctr_init(&stctr[i], val))
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
diff -ruN linux-2.5.5/mm/Makefile statctr-2.5.5/mm/Makefile
--- linux-2.5.5/mm/Makefile	Wed Feb 20 07:41:04 2002
+++ statctr-2.5.5/mm/Makefile	Fri Mar  1 11:38:16 2002
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
diff -ruN linux-2.5.5/mm/pcpu_alloc.c statctr-2.5.5/mm/pcpu_alloc.c
--- linux-2.5.5/mm/pcpu_alloc.c	Thu Jan  1 05:30:00 1970
+++ statctr-2.5.5/mm/pcpu_alloc.c	Fri Mar  1 11:38:16 2002
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


lo driver modifications:
------------------------

diff -ruN linux-2.5.5/drivers/net/loopback.c statctrusagelo/drivers/net/loopback.c
--- linux-2.5.5/drivers/net/loopback.c	Wed Feb 20 07:40:56 2002
+++ statctrusagelo/drivers/net/loopback.c	Fri Mar  1 16:11:35 2002
@@ -87,10 +87,10 @@
 #endif
 
 	dev->last_rx = jiffies;
-	stats->rx_bytes+=skb->len;
-	stats->tx_bytes+=skb->len;
-	stats->rx_packets++;
-	stats->tx_packets++;
+	statctr_add(&stats->rx_bytes, skb->len);
+	statctr_add(&stats->tx_bytes, skb->len);
+	statctr_inc(&stats->rx_packets);
+	statctr_inc(&stats->tx_packets);
 
 	netif_rx(skb);
 
@@ -120,7 +120,11 @@
 	dev->priv = kmalloc(sizeof(struct net_device_stats), GFP_KERNEL);
 	if (dev->priv == NULL)
 			return -ENOMEM;
-	memset(dev->priv, 0, sizeof(struct net_device_stats));
+	if (statctr_ninit((statctr_t *)dev->priv, 0, 23)) {
+		/* Init failed cleanup.. */
+		kfree(dev->priv);
+		return -ENOMEM;
+	}
 	dev->get_stats = get_stats;
 
 	/*
diff -ruN linux-2.5.5/include/linux/netdevice.h statctrusagelo/include/linux/netdevice.h
--- linux-2.5.5/include/linux/netdevice.h	Wed Feb 20 07:41:05 2002
+++ statctrusagelo/include/linux/netdevice.h	Fri Mar  1 16:11:35 2002
@@ -28,6 +28,7 @@
 #include <linux/if.h>
 #include <linux/if_ether.h>
 #include <linux/if_packet.h>
+#include <linux/statctr.h>
 
 #include <asm/atomic.h>
 #include <asm/cache.h>
@@ -95,35 +96,35 @@
  
 struct net_device_stats
 {
-	unsigned long	rx_packets;		/* total packets received	*/
-	unsigned long	tx_packets;		/* total packets transmitted	*/
-	unsigned long	rx_bytes;		/* total bytes received 	*/
-	unsigned long	tx_bytes;		/* total bytes transmitted	*/
-	unsigned long	rx_errors;		/* bad packets received		*/
-	unsigned long	tx_errors;		/* packet transmit problems	*/
-	unsigned long	rx_dropped;		/* no space in linux buffers	*/
-	unsigned long	tx_dropped;		/* no space available in linux	*/
-	unsigned long	multicast;		/* multicast packets received	*/
-	unsigned long	collisions;
+	statctr_t	rx_packets;		/* total packets received	*/
+	statctr_t	tx_packets;		/* total packets transmitted	*/
+	statctr_t	rx_bytes;		/* total bytes received 	*/
+	statctr_t	tx_bytes;		/* total bytes transmitted	*/
+	statctr_t	rx_errors;		/* bad packets received		*/
+	statctr_t	tx_errors;		/* packet transmit problems	*/
+	statctr_t	rx_dropped;		/* no space in linux buffers	*/
+	statctr_t	tx_dropped;		/* no space available in linux	*/
+	statctr_t	multicast;		/* multicast packets received	*/
+	statctr_t	collisions;
 
 	/* detailed rx_errors: */
-	unsigned long	rx_length_errors;
-	unsigned long	rx_over_errors;		/* receiver ring buff overflow	*/
-	unsigned long	rx_crc_errors;		/* recved pkt with crc error	*/
-	unsigned long	rx_frame_errors;	/* recv'd frame alignment error */
-	unsigned long	rx_fifo_errors;		/* recv'r fifo overrun		*/
-	unsigned long	rx_missed_errors;	/* receiver missed packet	*/
+	statctr_t	rx_length_errors;
+	statctr_t	rx_over_errors;		/* receiver ring buff overflow	*/
+	statctr_t	rx_crc_errors;		/* recved pkt with crc error	*/
+	statctr_t	rx_frame_errors;	/* recv'd frame alignment error */
+	statctr_t	rx_fifo_errors;		/* recv'r fifo overrun		*/
+	statctr_t	rx_missed_errors;	/* receiver missed packet	*/
 
 	/* detailed tx_errors */
-	unsigned long	tx_aborted_errors;
-	unsigned long	tx_carrier_errors;
-	unsigned long	tx_fifo_errors;
-	unsigned long	tx_heartbeat_errors;
-	unsigned long	tx_window_errors;
+	statctr_t	tx_aborted_errors;
+	statctr_t	tx_carrier_errors;
+	statctr_t	tx_fifo_errors;
+	statctr_t	tx_heartbeat_errors;
+	statctr_t	tx_window_errors;
 	
 	/* for cslip etc */
-	unsigned long	rx_compressed;
-	unsigned long	tx_compressed;
+	statctr_t	rx_compressed;
+	statctr_t	tx_compressed;
 };
 
 
diff -ruN linux-2.5.5/net/core/dev.c statctrusagelo/net/core/dev.c
--- linux-2.5.5/net/core/dev.c	Wed Feb 20 07:41:03 2002
+++ statctrusagelo/net/core/dev.c	Fri Mar  1 16:11:35 2002
@@ -1691,19 +1691,19 @@
 	if (stats)
 		size = sprintf(buffer, "%6s:%8lu %7lu %4lu %4lu %4lu %5lu %10lu %9lu %8lu %7lu %4lu %4lu %4lu %5lu %7lu %10lu\n",
  		   dev->name,
-		   stats->rx_bytes,
-		   stats->rx_packets, stats->rx_errors,
-		   stats->rx_dropped + stats->rx_missed_errors,
-		   stats->rx_fifo_errors,
-		   stats->rx_length_errors + stats->rx_over_errors
-		   + stats->rx_crc_errors + stats->rx_frame_errors,
-		   stats->rx_compressed, stats->multicast,
-		   stats->tx_bytes,
-		   stats->tx_packets, stats->tx_errors, stats->tx_dropped,
-		   stats->tx_fifo_errors, stats->collisions,
-		   stats->tx_carrier_errors + stats->tx_aborted_errors
-		   + stats->tx_window_errors + stats->tx_heartbeat_errors,
-		   stats->tx_compressed);
+		   statctr_read(&stats->rx_bytes),
+		   statctr_read(&stats->rx_packets), statctr_read(&stats->rx_errors),
+		   statctr_read(&stats->rx_dropped) + statctr_read(&stats->rx_missed_errors),
+		   statctr_read(&stats->rx_fifo_errors),
+		   statctr_read(&stats->rx_length_errors) + statctr_read(&stats->rx_over_errors)
+		   + statctr_read(&stats->rx_crc_errors) + statctr_read(&stats->rx_frame_errors),
+		   statctr_read(&stats->rx_compressed), statctr_read(&stats->multicast),
+		   statctr_read(&stats->tx_bytes),
+		   statctr_read(&stats->tx_packets), statctr_read(&stats->tx_errors), statctr_read(&stats->tx_dropped),
+		   statctr_read(&stats->tx_fifo_errors), statctr_read(&stats->collisions),
+		   statctr_read(&stats->tx_carrier_errors) + statctr_read(&stats->tx_aborted_errors)
+		   + statctr_read(&stats->tx_window_errors) + statctr_read(&stats->tx_heartbeat_errors),
+		   statctr_read(&stats->tx_compressed));
 	else
 		size = sprintf(buffer, "%6s: No statistics available.\n", dev->name);
 
