Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284041AbRLEK6r>; Wed, 5 Dec 2001 05:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284039AbRLEK6k>; Wed, 5 Dec 2001 05:58:40 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:22513 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S284038AbRLEK6X>;
	Wed, 5 Dec 2001 05:58:23 -0500
Date: Wed, 5 Dec 2001 16:31:53 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: lse-tech@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [RFC] [PATCH] Scalable Statistics Counters
Message-ID: <20011205163153.E16315@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Here is a RFC for Scalable Statistics Counters.

Statistics counters are used in many places in the Linux kernel, including
storage, network I/O subsystems etc.  These counters are not atomic since 
accuracy is not so important. Nevertheless, frequent updation of these
counters result in cacheline bouncing among various cpus in a multi processor
environment. This patch introduces a new set of interfaces, which should
improve performance of such counters in MP environment.  This implementation 
switches to code that is devoid of overheads for SMP if these interfaces 
are used with a UP kernel.

The enclosed patch uses a per cpu counter allocator which allocates 
smp_num_cpus words of memory per counter, each word being on a different
cache line (hence processor local).  On counter updation requests,
processor local versions of the counter are operated upon, thus
reducing cacheline bouncing and improving performace.

Initial results of micro benchmarking on 3 cpus showed a 65% reduction 
in cpu cycles used to update the proposed statistics counter, over global 
non atomic counter. Further benchmarking is to be done by replacing many of
the existing statistics counter in the linux kernel.

You can find detailed information on the proposed set of interfaces
along with  design notes on

http://lse.sourceforge.net/counters/statctr.html

This patch uses the flexible counter allocation scheme mentioned in the
statctr document.  I have a patch ready for fixed counter allocation scheme
too, if any one is interested.

Comments are welcome :)
 
Regards,
Kiran

-- 
Ravikiran G Thirumalai
Linux Technology Center
IBM Software Labs
Golden Towers Airport Road,
BANGALORE-560 017
Phone-91-80-504 4987
email: kiran@in.ibm.com


This patch applies cleanly on linux-2.4.14
-------------------------------------------

diff -ruN /sdc/linux-2.4.14/include/linux/pcpu_alloc.h pcpu2414.01/include/linux/pcpu_alloc.h
--- /sdc/linux-2.4.14/include/linux/pcpu_alloc.h	Thu Jan  1 05:30:00 1970
+++ pcpu2414.01/include/linux/pcpu_alloc.h	Tue Dec  4 19:46:56 2001
@@ -0,0 +1,57 @@
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
+#endif  /* CONFIG_SMP */
+ 
+#endif  /* __KERNEL__ */
+ 
+#endif  /* _LINUX_PCPU_ALLOC_H */
diff -ruN /sdc/linux-2.4.14/include/linux/statctr.h pcpu2414.01/include/linux/statctr.h
--- /sdc/linux-2.4.14/include/linux/statctr.h	Thu Jan  1 05:30:00 1970
+++ pcpu2414.01/include/linux/statctr.h	Tue Dec  4 19:46:56 2001
@@ -0,0 +1,155 @@
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
+#else
+#define statctr_init(stctr, num)	({*(stctr) = (num); 0;)
+#define statctr_cleanup(stctr)	do { } while (0)
+#endif
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
+#define statctr_add(stctr,val)) ((*(stctr))+=(val))
+#define statctr_sub(stctr,val)) ((*(stctr))-=(val))
+#endif
+
+#endif  /* __KERNEL__ */
+ 
+#endif  /* _LINUX_STATCTR_H */
diff -ruN /sdc/linux-2.4.14/init/main.c pcpu2414.01/init/main.c
--- /sdc/linux-2.4.14/init/main.c	Fri Oct 12 22:47:15 2001
+++ pcpu2414.01/init/main.c	Mon Dec  3 18:27:15 2001
@@ -27,6 +27,7 @@
 #include <linux/iobuf.h>
 #include <linux/bootmem.h>
 #include <linux/tty.h>
+#include <linux/pcpu_alloc.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -617,6 +618,7 @@
 	 *	make syscalls (and thus be locked).
 	 */
 	smp_init();
+	pcpu_ctr_sys_init();
 	rest_init();
 }
 
diff -ruN /sdc/linux-2.4.14/kernel/Makefile pcpu2414.01/kernel/Makefile
--- /sdc/linux-2.4.14/kernel/Makefile	Mon Sep 17 09:52:40 2001
+++ pcpu2414.01/kernel/Makefile	Mon Dec  3 18:27:15 2001
@@ -9,7 +9,8 @@
 
 O_TARGET := kernel.o
 
-export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o printk.o
+export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o \
+	      printk.o statctr.o
 
 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o info.o time.o softirq.o resource.o \
@@ -19,6 +20,7 @@
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
 obj-$(CONFIG_PM) += pm.o
+obj-$(CONFIG_SMP) += statctr.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff -ruN /sdc/linux-2.4.14/kernel/statctr.c pcpu2414.01/kernel/statctr.c
--- /sdc/linux-2.4.14/kernel/statctr.c	Thu Jan  1 05:30:00 1970
+++ pcpu2414.01/kernel/statctr.c	Tue Dec  4 19:46:56 2001
@@ -0,0 +1,62 @@
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
+EXPORT_SYMBOL(statctr_init);
+EXPORT_SYMBOL(statctr_cleanup);
+
diff -ruN /sdc/linux-2.4.14/mm/Makefile pcpu2414.01/mm/Makefile
--- /sdc/linux-2.4.14/mm/Makefile	Thu Oct 25 03:51:18 2001
+++ pcpu2414.01/mm/Makefile	Mon Dec  3 18:27:15 2001
@@ -9,7 +9,7 @@
 
 O_TARGET := mm.o
 
-export-objs := shmem.o filemap.o
+export-objs := shmem.o filemap.o pcpu_alloc.o
 
 obj-y	 := memory.o mmap.o filemap.o mprotect.o mlock.o mremap.o \
 	    vmalloc.o slab.o bootmem.o swap.o vmscan.o page_io.o \
@@ -17,5 +17,6 @@
 	    shmem.o
 
 obj-$(CONFIG_HIGHMEM) += highmem.o
+obj-$(CONFIG_SMP) += pcpu_alloc.o
 
 include $(TOPDIR)/Rules.make
diff -ruN /sdc/linux-2.4.14/mm/pcpu_alloc.c pcpu2414.01/mm/pcpu_alloc.c
--- /sdc/linux-2.4.14/mm/pcpu_alloc.c	Thu Jan  1 05:30:00 1970
+++ pcpu2414.01/mm/pcpu_alloc.c	Tue Dec  4 19:46:56 2001
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
