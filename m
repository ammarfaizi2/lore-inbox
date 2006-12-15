Return-Path: <linux-kernel-owner+w=401wt.eu-S1753272AbWLOTY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753272AbWLOTY7 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 14:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753271AbWLOTY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 14:24:59 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:54574 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753268AbWLOTY4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 14:24:56 -0500
Message-ID: <4582F683.5010208@us.ibm.com>
Date: Fri, 15 Dec 2006 13:24:51 -0600
From: Maynard Johnson <maynardj@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, oprofile-list@lists.sourceforge.net
Subject: [PATCH -- RFC] Add support OProfile for profiling Cell BE SPUs
Content-Type: multipart/mixed;
 boundary="------------000606060509070105070208"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000606060509070105070208
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch extends OProfile's Cell support (committed into 
2.6.20-rc1), adding the capability to do time-based profiling of the SPUs.

This is a preliminary patch we're posting for comments.  Development is 
not 100% complete yet, but very close.  This patch is dependent on two 
outstanding patches that have not yet been committed to mainline:  1) 
the cleanup patch for the initial OProfile Cell PPU support (posted on 
Nov 27); and 2) the spu notifier patch (posted on Dec 1), which exports 
the [un]register functions in SPUFS.  It is also dependent on an 
internal patch, which will be submitted once the cleanup patch is 
committed.  So please don't try to apply this patch to a source tree yet.

The code is functional and passing all test scenarios, except one:  if 
an SPU task is already active before OProfile is started, the 
notification we receive for this already-active task happens in the 
wrong context, so we're unable to collect the information we need about 
the SPU binary being executed.  The spu notifer patch mentioned above 
was meant to solve this problem, but in fact, it does not (which is why 
that patch hasn't been committed yet).  We're currently investigating
other options.

All comments are welcome.

NOTE:  The availability of the developers of this patch is limited 
between now and Jan 2, 2007, so replies to comments may be delayed until 
then.

Thanks.
Maynard Johnson
IBM LTC Toolchain

--------------000606060509070105070208
Content-Type: text/plain;
 name="oprof-spu.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oprof-spu.diff"

Subject: Add support to OProfile for profiling Cell BE SPUs

From: Maynard Johnson <maynardj@us.ibm.com>

This patch updates the existing arch/powerpc/oprofile/op_model_cell.c
to add in the SPU profiling capabilities.  In addition, a 'cell' subdirectory
was added to arch/powerpc/oprofile to hold Cell-specific SPU profiling
code.

Signed-off-by: Carl Love <carll@us.ibm.com>
Signed-off-by: Maynard Johnson <mpjohn@us.ibm.com>

Index: linux-2.6.19-rc6-arnd1+patches/arch/powerpc/configs/cell_defconfig
===================================================================
--- linux-2.6.19-rc6-arnd1+patches.orig/arch/powerpc/configs/cell_defconfig	2006-12-04 10:56:04.699570280 -0600
+++ linux-2.6.19-rc6-arnd1+patches/arch/powerpc/configs/cell_defconfig	2006-12-08 10:38:58.049707128 -0600
@@ -1136,7 +1136,7 @@
 # Instrumentation Support
 #
 CONFIG_PROFILING=y
-CONFIG_OPROFILE=y
+CONFIG_OPROFILE=m
 # CONFIG_KPROBES is not set
 
 #
Index: linux-2.6.19-rc6-arnd1+patches/arch/powerpc/oprofile/cell/pr_util.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.19-rc6-arnd1+patches/arch/powerpc/oprofile/cell/pr_util.h	2006-12-14 11:58:04.393836120 -0600
@@ -0,0 +1,74 @@
+ /*
+ * Cell Broadband Engine OProfile Support
+ *
+ * (C) Copyright IBM Corporation 2006
+ *
+ * Author: Maynard Johnson <maynardj@us.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef PR_UTIL_H
+#define PR_UTIL_H
+
+#include <linux/cpumask.h>
+#include <linux/oprofile.h>
+#include <asm/cell-pmu.h>
+#include <asm/spu.h>
+
+#define number_of_online_nodes(nodes)          \
+        u32 cpu; u32 tmp;                      \
+        nodes = 0;                             \
+        for_each_online_cpu(cpu) {             \
+                tmp = cbe_cpu_to_node(cpu) + 1;\
+                if (tmp > nodes)               \
+                        nodes++;               \
+	}
+
+
+/* Defines used for sync_start */
+#define SKIP_GENERIC_SYNC 0
+#define SYNC_START_ERROR -1
+#define DO_GENERIC_SYNC 1
+
+typedef struct vma_map
+{
+	struct vma_map *next;
+	unsigned int vma;
+	unsigned int size;
+	unsigned int offset;
+	unsigned int guard_ptr;
+	unsigned int guard_val;
+} vma_map_t;
+
+/* The three functions below are for maintaining and accessing
+ * the vma-to-file offset map.
+ */
+vma_map_t * create_vma_map(const struct spu * spu, u64 objectid);
+unsigned int vma_map_lookup(vma_map_t *map, unsigned int vma,
+			    const struct spu * aSpu);
+void vma_map_free(struct vma_map *map);
+
+/*
+ * Entry point for SPU profiling.
+ * cycles_reset is the SPU_CYCLES count value specified by the user.
+ */
+void start_spu_profiling(unsigned int cycles_reset);
+
+void stop_spu_profiling(void);
+
+ 
+/* add the necessary profiling hooks */
+int spu_sync_start(void);
+
+/* remove the hooks */
+int spu_sync_stop(void);
+ 
+/* Record SPU program counter samples to the oprofile event buffer. */
+void spu_sync_buffer(int spu_num, unsigned int * samples, 
+		     int num_samples);
+
+#endif    // PR_UTIL_H 
Index: linux-2.6.19-rc6-arnd1+patches/arch/powerpc/oprofile/cell/spu_profiler.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.19-rc6-arnd1+patches/arch/powerpc/oprofile/cell/spu_profiler.c	2006-12-15 13:10:54.349846544 -0600
@@ -0,0 +1,203 @@
+/*
+ * Cell Broadband Engine OProfile Support
+ *
+ * (C) Copyright IBM Corporation 2006
+ *
+ * Authors: Maynard Johnson <maynardj@us.ibm.com>
+ *          Carl Love <carll@us.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/hrtimer.h>
+#include <linux/smp.h>
+#include <asm/cell-pmu.h>
+#include "pr_util.h"
+
+#define TRACE_ARRAY_SIZE 1024
+static u32 * samples;
+static u32 * samples_per_node;
+
+static int spu_prof_running = 0;
+static unsigned int profiling_interval = 0;
+
+extern int num_nodes;
+extern unsigned int khzfreq;
+
+/*
+ * Oprofile setup functions
+ */
+
+#define NUM_SPU_BITS_TRBUF 16
+#define SPUS_PER_TB_ENTRY   4
+#define SPUS_PER_NODE       8
+
+/* 
+ * Collect the SPU program counter samples from the trace buffer.
+ * The global variable usage is as follows:
+ *    samples[<total-spus>][TRACE_ARRAY_SIZE] - array to store SPU PC samples
+ *           Assumption, the array will be all zeros on entry.
+ *    u32 samples_per_node[num_nodes] - array of how many valid samples per node
+ */
+static void cell_spu_pc_collection(void)
+{
+	int cpu;
+	int node;
+	int spu;
+	u32 trace_addr;
+        /* the trace buffer is 128 bits */
+	u64 trace_buffer[2];
+	u64 spu_pc_lower;  
+	u64 spu_pc_upper;
+	u64 spu_mask;
+	int entry, node_factor;
+	// process the collected SPU PC for each node
+	for_each_online_cpu(cpu) {
+		if (cbe_get_hw_thread_id(cpu))
+			continue;
+
+		node = cbe_cpu_to_node(cpu);
+		node_factor = node * SPUS_PER_NODE;
+                /* number of valid entries for this node */
+		entry = 0;
+
+		trace_addr = cbe_read_pm(cpu, trace_address);
+		while ((trace_addr & CBE_PM_TRACE_BUF_EMPTY) != 0x400)
+		{
+			/* there is data in the trace buffer to process */
+			cbe_read_trace_buffer(cpu, trace_buffer);  
+			spu_mask = 0xFFFF000000000000;
+
+			/* Each SPU PC is 16 bits; hence, four spus in each of 
+			 * the two 64-bit buffer entries that make up the
+			 * 128-bit trace_buffer entry.  Process the upper and
+			 * lower 64-bit values simultaneously.
+			 */
+			for (spu = 0; spu < SPUS_PER_TB_ENTRY; spu++) {
+				spu_pc_lower = spu_mask & trace_buffer[0];
+				spu_pc_lower = spu_pc_lower >> (NUM_SPU_BITS_TRBUF
+								* (SPUS_PER_TB_ENTRY-spu-1));
+
+				spu_pc_upper = spu_mask & trace_buffer[1];
+				spu_pc_upper = spu_pc_upper >> (NUM_SPU_BITS_TRBUF
+								* (SPUS_PER_TB_ENTRY-spu-1));
+
+				spu_mask = spu_mask >> NUM_SPU_BITS_TRBUF;
+
+				/* spu PC trace entry is upper 16 bits of the
+				 * 18 bit SPU program counter 
+				 */
+				spu_pc_lower = spu_pc_lower << 2;
+				spu_pc_upper = spu_pc_upper << 2;
+
+				samples[((node_factor + spu) * TRACE_ARRAY_SIZE) + entry]
+					= (u32) spu_pc_lower;
+				samples[((node_factor + spu + SPUS_PER_TB_ENTRY) * TRACE_ARRAY_SIZE) + entry]
+					= (u32) spu_pc_upper;
+			}
+
+			entry++;
+
+			if (entry >= TRACE_ARRAY_SIZE) 
+				/* spu_samples is full */
+				break;
+
+			trace_addr = cbe_read_pm(cpu, trace_address);
+		}
+		samples_per_node[node] = entry;
+	}
+}
+
+
+static int profile_spus(struct hrtimer * timer)
+{
+	ktime_t kt;
+        int cpu, node, k, num_samples, spu_num;
+	
+	if (!spu_prof_running)
+		goto STOP;
+
+	cell_spu_pc_collection();
+	for_each_online_cpu(cpu) {
+		if (cbe_get_hw_thread_id(cpu))
+			continue;
+
+		node = cbe_cpu_to_node(cpu);
+
+		num_samples = samples_per_node[node];
+		if (num_samples == 0)
+			continue;
+		for (k = 0; k < SPUS_PER_NODE; k++) {
+			spu_num = k + (node * SPUS_PER_NODE);
+			spu_sync_buffer(spu_num, samples + (spu_num * TRACE_ARRAY_SIZE), num_samples);
+		}
+	}
+	smp_rmb();
+
+	kt = ktime_set(0, profiling_interval);
+	if (!spu_prof_running)
+		goto STOP;
+	hrtimer_forward(timer, timer->base->get_time(), kt);
+	return HRTIMER_RESTART;
+
+ STOP:
+	printk(KERN_INFO "SPU_PROF: spu-prof timer ending\n");
+	return HRTIMER_NORESTART;
+}
+
+static struct hrtimer timer;
+#define SCALE_SHIFT 14 
+/*
+ * Entry point for SPU profiling.
+ * NOTE:  SPU profiling is done system-wide, not per-CPU.
+ *
+ * cycles_reset is the count value specified by the user when
+ * setting up OProfile to count SPU_CYCLES.
+ */
+void start_spu_profiling(unsigned int cycles_reset) {
+
+	ktime_t kt;
+
+        /* To calculate a timeout in nanoseconds, the basic
+	 * formula is ns = cycles_reset * (NSEC_PER_SEC / cpu frequency).
+	 * To avoid floating point math, we use the scale math
+	 * technique as described in linux/jiffies.h.  We use
+	 * a scale factor of SCALE_SHIFT,which provides 4 decimal places
+	 * of precision, which is close enough for the purpose at hand.
+	 */
+
+	/* Since cpufreq_quick_get returns frequency in kHz, we use
+	 * USEC_PER_SEC here vs NSEC_PER_SEC.
+	 */
+	unsigned long nsPerCyc = (USEC_PER_SEC << SCALE_SHIFT)/khzfreq;
+	profiling_interval = (nsPerCyc * cycles_reset) >> SCALE_SHIFT;
+	
+	pr_debug("timer resolution: %lu\n", 
+		 TICK_NSEC);
+	kt = ktime_set(0, profiling_interval);
+	hrtimer_init(&timer, CLOCK_MONOTONIC, HRTIMER_REL);
+	timer.expires = kt;
+	timer.function = profile_spus;
+
+        /* Allocate arrays for collecting SPU PC samples */
+	samples = (u32 *) kzalloc(num_nodes * SPUS_PER_NODE * TRACE_ARRAY_SIZE * sizeof(u32), GFP_ATOMIC);
+	samples_per_node = (u32 *) kzalloc(num_nodes * sizeof(u32), GFP_ATOMIC);
+
+	spu_prof_running = 1;
+	hrtimer_start(&timer, kt, HRTIMER_REL);
+}
+
+void stop_spu_profiling(void) 
+{
+
+	hrtimer_cancel(&timer);
+	kfree(samples);
+	kfree(samples_per_node);
+	pr_debug("SPU_PROF: stop_spu_profiling issued\n");
+	spu_prof_running = 0;
+}
+
+
Index: linux-2.6.19-rc6-arnd1+patches/arch/powerpc/oprofile/cell/spu_task_sync.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.19-rc6-arnd1+patches/arch/powerpc/oprofile/cell/spu_task_sync.c	2006-12-15 13:14:18.297859464 -0600
@@ -0,0 +1,486 @@
+/*
+ * Cell Broadband Engine OProfile Support
+ *
+ * (C) Copyright IBM Corporation 2006
+ *
+ * Author: Maynard Johnson <maynardj@us.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+/* The purpose of this file is to handle SPU event task switching
+ * and to record SPU context information into the OProfile
+ * event buffer. 
+ *
+ * Additionally, the spu_sync_buffer function is provided as a helper
+ * for recoding actual SPU program counter samples to the event buffer.
+ */
+
+#include <linux/notifier.h>
+#include <linux/list.h>
+#include <linux/numa.h>
+#include <linux/mm.h>
+#include <linux/dcookies.h>
+#include <linux/spinlock.h>
+#include <linux/kref.h>
+#include <linux/oprofile.h>
+#include "pr_util.h"
+
+#define DISCARD_ALL 9999
+
+static spinlock_t buffer_lock = SPIN_LOCK_UNLOCKED;
+static int num_spu_nodes;
+int num_nodes;
+
+/* Conainer for caching information about an active SPU task.
+ *   :map -- pointer to a list of vma_maps
+ *   :spu -- the spu for this active SPU task
+ *   :list -- potentially could be used to contain the cached_infos
+ *            for inactive SPU tasks.
+ * 
+ * Ideally, we would like to be able to create the cached_info for
+ * an SPU task just one time -- when libspe first loads the SPU 
+ * binary file.  We would store the cached_info in a list.  Then, as
+ * SPU tasks are switched out and new ones switched in, the cached_info
+ * for inactive tasks would be kept, and the active one would be placed
+ * at the head of the list.  But this technique may not with
+ * current spufs functionality since the spu used in bind_context may
+ * be a different spu than was used in a previous bind_context for a
+ * reactivated SPU task.  Additionally, a reactivated SPU task may be
+ * assigned to run on a different physical SPE.  We will investigate
+ * further if this can be done.
+ *
+ */
+struct cached_info {
+	vma_map_t * map;
+	struct spu * the_spu;
+	struct kref cache_ref;
+	struct list_head list;
+};
+
+/* A data structure for cached information about active SPU tasks.
+ * Storage is dynamically allocated, sized as
+ * "number of active nodes multplied by 8". 
+ * The info_list[n] member holds 0 or more 
+ * 'struct cached_info' objects for SPU#=n. 
+ *
+ * As currently implemented, there will only ever be one cached_info 
+ * in the list for a given SPU.  If we can devise a way to maintain
+ * multiple cached_infos in our list, then it would make sense
+ * to also cache the dcookie representing the PPU task application.
+ * See above description of struct cached_info for more details.
+ */
+struct spu_info_stacks {
+	struct list_head * info_list;
+};
+
+static spinlock_t cache_lock = SPIN_LOCK_UNLOCKED;
+
+
+static struct spu_info_stacks * spu_info;
+
+static void destroy_cached_info(struct kref * kref)
+{
+	struct cached_info * info;
+	info = container_of(kref, struct cached_info, cache_ref);
+	vma_map_free(info->map);
+	kfree(info);
+}
+
+static int put_cached_info(struct cached_info * info)
+{
+	return kref_put(&info->cache_ref, &destroy_cached_info);
+}
+
+/* Return the cached_info for the passed SPU number.
+ * Current implementation is such that a list will hold, at most,
+ * one cached_info.
+ * 
+ * NOTE: Clients of this function MUST call put_cached_info()
+ *       when finished using the returned cached_info (if the
+ *       returned value is non-null).
+ */
+static struct cached_info * get_cached_info(int spu_num)
+{
+	struct cached_info * ret_info, * info;
+	unsigned long flags = 0;
+	ret_info = NULL;
+	spin_lock_irqsave(&cache_lock, flags);
+	if (spu_info == NULL) {
+		pr_debug("SPU_PROF:%s: spu_info does not exist\n",
+			 __FUNCTION__);
+		goto out;
+	}
+	if (spu_num >= num_spu_nodes) {
+		printk(KERN_ERR "SPU_PROF: " 
+		       "%s, line %d: Invalid index %d into spu info cache\n",
+		       __FUNCTION__, __LINE__, spu_num);
+		goto out;
+	}
+	list_for_each_entry(info, &spu_info->info_list[spu_num], list) {
+		/* Only one item in the list, so return it. */
+		ret_info = info;
+		kref_get(&info->cache_ref);
+		break;
+	}
+
+out:
+	spin_unlock_irqrestore(&cache_lock, flags);
+	return ret_info;
+}
+
+
+/* Looks for cached info for the passed spu.  If not found, the
+ * cached info is created for the passed spu.
+ * Returns 0 for success; otherwise, -1 for error.  
+ */ 
+static int
+prepare_cached_spu_info(struct spu * spu, unsigned int objectId)
+{
+	vma_map_t * new_map;
+	unsigned long flags = 0;
+	int retval = 0;
+	/* spu->number is a system-wide value, not a per-node value. */
+	struct cached_info * info = get_cached_info(spu->number);
+	if (info == NULL) {
+		/* create cached_info and add it to the list for SPU #<n>.*/
+		info = kzalloc(sizeof(struct cached_info), GFP_ATOMIC);
+		if (!info) {
+			printk(KERN_ERR "SPU_PROF: "
+			       "%s, line %d: create vma_map failed\n",
+			       __FUNCTION__, __LINE__);
+			goto ERR_ALLOC;
+		}
+		new_map = create_vma_map(spu, objectId);
+		if (!new_map) {
+			printk(KERN_ERR "SPU_PROF: "
+			       "%s, line %d: create vma_map failed\n",
+			       __FUNCTION__, __LINE__);
+			goto ERR_ALLOC;
+		}
+
+		pr_debug("Created vma_map\n");
+ 		info->map = new_map;
+		info->the_spu = spu;
+		kref_init(&info->cache_ref);
+		spin_lock_irqsave(&cache_lock, flags);
+		list_add(&info->list, &spu_info->info_list[spu->number]);
+		spin_unlock_irqrestore(&cache_lock, flags);
+		goto OUT;
+	} else {
+        /* Immedidately put back reference to cached_info since we don't
+	 * really need it -- just checking whether we have it.
+	 */
+		put_cached_info(info);
+		pr_debug("Found cached SPU info.\n");
+	}
+	
+ERR_ALLOC:
+	retval = -1;
+OUT:
+	return retval;
+}
+
+
+/* Discard all cached info and free the memory.
+ * NOTE:  The caller is responsible for locking the
+ *        spu_info struct containing the cached_info
+ *        prior to calling this function.
+ */
+static int discard_cached_info(int spu_index)
+{
+	struct cached_info * info, * tmp;
+	int index, end;
+	if (spu_index == DISCARD_ALL) {
+		end = num_spu_nodes;
+		index = 0;
+	} else {
+	        if (spu_index >= num_spu_nodes) {
+        	        printk(KERN_ERR "SPU_PROF: "
+			       "%s, line %d: Invalid index %d into spu info cache\n",
+               	               __FUNCTION__, __LINE__, spu_index);
+	                goto out;
+	        }
+		end = spu_index +1;
+		index = spu_index;
+	}
+	for (; index < end; index++) {
+		list_for_each_entry_safe(info, tmp, 
+					 &spu_info->info_list[index],
+					 list) {
+			list_del(&info->list);
+			put_cached_info(info);
+		}
+	}
+out:
+	return 0;
+}
+
+/* The source code for fast_get_dcookie was "borrowed"
+ * from drivers/oprofile/buffer_sync.c.
+ */
+
+/* Optimisation. We can manage without taking the dcookie sem
+ * because we cannot reach this code without at least one
+ * dcookie user still being registered (namely, the reader
+ * of the event buffer).
+ */
+static inline unsigned long fast_get_dcookie(struct dentry * dentry,
+					     struct vfsmount * vfsmnt)
+{
+        unsigned long cookie;
+
+        if (dentry->d_cookie)
+                return (unsigned long)dentry;
+        get_dcookie(dentry, vfsmnt, &cookie);
+        return cookie;
+}
+
+/* Look up the dcookie for the task's first VM_EXECUTABLE mapping,
+ * which corresponds loosely to "application name". Also, determine
+ * the offset for the SPU ELF object.  If computed offset is 
+ * non-zero, it implies an embedded SPU object; otherwise, it's a
+ * separate SPU binary, in which case we retrieve it's dcookie.
+ */
+static unsigned long 
+get_exec_dcookie_and_offset(
+	struct spu * spu, unsigned int * offsetp,
+	unsigned long * spu_bin_dcookie,
+	unsigned int spu_ref)
+{
+        unsigned long cookie = 0;
+	unsigned int my_offset = 0;
+        struct vm_area_struct * vma;
+	struct mm_struct * mm = spu->mm;
+
+        if (!mm)
+                goto OUT;
+
+        for (vma = mm->mmap; vma; vma = vma->vm_next) {
+                if (!vma->vm_file)
+                        continue;
+                if (!(vma->vm_flags & VM_EXECUTABLE))
+                        continue;
+                cookie = fast_get_dcookie(vma->vm_file->f_dentry,
+                        vma->vm_file->f_vfsmnt);
+		pr_debug("got dcookie for %s\n",
+			  vma->vm_file->f_dentry->d_name.name);
+                break;
+        }
+
+	for (vma = mm->mmap; vma; vma = vma->vm_next) {
+		if (vma->vm_start > spu_ref || vma->vm_end < spu_ref)
+			continue;
+		my_offset = spu_ref - vma->vm_start;
+		pr_debug("Found spu ELF at "
+			  " %X for file %s\n", my_offset,
+			  vma->vm_file->f_dentry->d_name.name);
+		*offsetp = my_offset;
+		if (my_offset == 0) {
+			if (!vma->vm_file) {
+				goto FAIL_NO_SPU_COOKIE;
+			}
+			*spu_bin_dcookie = fast_get_dcookie(
+				vma->vm_file->f_dentry,
+				vma->vm_file->f_vfsmnt);
+			pr_debug("got dcookie for %s\n",
+				  vma->vm_file->f_dentry->d_name.name);
+		}
+		break;			
+	}
+	
+OUT:
+        return cookie;
+
+FAIL_NO_SPU_COOKIE:
+	printk(KERN_ERR "SPU_PROF: "
+	       "%s, line %d: Cannot find dcookie for SPU binary\n",
+	       __FUNCTION__, __LINE__);
+	goto OUT;
+}
+
+
+
+/* This function finds or creates cached context information for the
+ * passed SPU and records SPU context information into the OProfile
+ * event buffer.
+ */
+static int process_context_switch(struct spu * spu, unsigned int objectId)
+{
+	unsigned long flags = 0;
+	int retval = 0;
+	unsigned int offset = 0;
+	unsigned long spu_cookie = 0, app_dcookie = 0;
+	retval = prepare_cached_spu_info(spu, objectId);
+	if (retval == -1) {
+		goto OUT;
+	}
+        /* Get dcookie first because a mutex_lock is taken in that
+	 * code path, so interrupts must not be disabled.
+	 */
+	app_dcookie = get_exec_dcookie_and_offset(spu, &offset, 
+						  &spu_cookie, objectId);
+
+        /* Record context info in event buffer */
+	spin_lock_irqsave(&buffer_lock, flags);
+	add_event_entry(ESCAPE_CODE);
+	add_event_entry(SPU_CTX_SWITCH_CODE);
+	add_event_entry(spu->number);
+	add_event_entry(spu->pid);
+	add_event_entry(spu->tgid);
+	add_event_entry(app_dcookie);
+
+	add_event_entry(ESCAPE_CODE);
+	if (offset) {
+	  /* When offset is non-zero,  this means the SPU ELF was embedded;
+	   * otherwise, it was loaded from a separate binary file.  For the
+	   * embedded case, we record the offset of the SPU ELF into the PPU
+	   * executable; for the non-embedded case, we record a dcookie that
+	   * points to the location of the SPU binary that was loaded.
+	   */
+		add_event_entry(SPU_OFFSET_CODE);
+		add_event_entry(offset);
+	} else {
+		add_event_entry(SPU_COOKIE_CODE);
+		add_event_entry(spu_cookie);
+	}
+	spin_unlock_irqrestore(&buffer_lock, flags);
+	smp_rmb();
+OUT:
+	return retval;
+}
+
+/* 
+ * This function is invoked on either a bind_context or unbind_context.  
+ * If called for an unbind_context, the val arg is 0; otherwise, 
+ * it is the object-id value for the spu context.
+ * The data arg is of type 'struct spu *'.
+ */
+static int spu_active_notify(struct notifier_block * self, unsigned long val,
+			     void * data)
+{
+	int retval ;
+	unsigned long flags = 0;
+	struct spu * the_spu = (struct spu *) data;
+	pr_debug("SPU event notification arrived\n");
+	if (val == 0){
+		spin_lock_irqsave(&cache_lock, flags);
+		retval = discard_cached_info(the_spu->number);
+		spin_unlock_irqrestore(&cache_lock, flags);
+	} else {
+		retval = process_context_switch(the_spu, val);
+	}
+	return retval;
+}
+
+static struct notifier_block spu_active = {
+	.notifier_call = spu_active_notify,
+};
+
+/* The main purpose of this function is to synchronize
+ * OProfile with SPUFS by registering to be notified of
+ * SPU task switches.
+ *
+ * NOTE: When profiling SPUs, we must ensure that only
+ * spu_sync_start is invoked and not the generic sync_start
+ * in drivers/oprofile/oprof.c.  A return value of
+ * SKIP_GENERIC_SYNC or SYNC_START_ERROR will
+ * accomplish this.
+ */
+int spu_sync_start(void) {
+	int ret = SKIP_GENERIC_SYNC;
+	int register_ret;
+	int i;
+	unsigned long flags = 0;
+	number_of_online_nodes(num_nodes);
+	num_spu_nodes = num_nodes * 8;
+	spin_lock_irqsave(&cache_lock, flags);
+	spu_info = kzalloc(sizeof(struct spu_info_stacks), GFP_ATOMIC);
+	spu_info->info_list = kzalloc(sizeof(struct list_head) * num_spu_nodes,
+				      GFP_ATOMIC);
+
+	for (i = 0; i <  num_spu_nodes; i++) {
+		INIT_LIST_HEAD(&spu_info->info_list[i]);
+	}
+	spin_unlock_irqrestore(&cache_lock, flags);
+
+        /* Register for SPU events  */
+	register_ret = spu_switch_event_register(&spu_active);
+	if (register_ret) {
+		ret = SYNC_START_ERROR;
+		goto OUT;
+	}
+
+	spin_lock_irqsave(&buffer_lock, flags);
+	add_event_entry(ESCAPE_CODE);
+	add_event_entry(SPU_PROFILING_CODE);
+	add_event_entry(num_spu_nodes);
+	spin_unlock_irqrestore(&buffer_lock, flags);
+	pr_debug("spu_sync_start -- running.\n");
+OUT:
+	return ret;	
+}
+
+/* Record SPU program counter samples to the oprofile event buffer. */
+void spu_sync_buffer(int spu_num, unsigned int * samples, 
+		     int num_samples)
+{
+	unsigned long flags = 0;
+	int i;
+	vma_map_t * map;
+	struct spu * the_spu;
+	unsigned long long spu_num_ll = spu_num;
+	unsigned long long spu_num_shifted = spu_num_ll << 32;
+	struct cached_info * c_info = get_cached_info(spu_num);
+	if (c_info == NULL) {
+/* This legitimately happens when the SPU task ends before all 
+ * samples are recorded.  No big deal -- so we just drop a few samples.
+ */
+		pr_debug("SPU_PROF: No cached SPU contex "
+			  "for SPU #%d. Dropping samples.\n", spu_num);
+		return ;
+	}
+
+	map = c_info->map;
+	the_spu = c_info->the_spu;
+	spin_lock_irqsave(&buffer_lock, flags);
+	for (i = 0; i < num_samples; i++) {
+		unsigned long long file_offset;
+		unsigned int sample = *(samples+i);
+		if (sample == 0)
+			continue;
+		file_offset = vma_map_lookup(
+			map, sample, the_spu);
+		add_event_entry(file_offset | spu_num_shifted);
+	}
+	spin_unlock_irqrestore(&buffer_lock, flags);
+	put_cached_info(c_info);
+}
+
+
+int spu_sync_stop(void)
+{
+	unsigned long flags = 0;
+	int ret = spu_switch_event_unregister(&spu_active);
+	if (ret) {
+		printk(KERN_ERR "SPU_PROF: "
+		       "%s, line %d: spu_switch_event_unregister returned %d\n",
+		       __FUNCTION__, __LINE__, ret);
+		goto OUT;
+	} 
+
+	spin_lock_irqsave(&cache_lock, flags);
+	ret = discard_cached_info(DISCARD_ALL);
+	kfree(spu_info->info_list);
+	kfree(spu_info);
+	spin_unlock_irqrestore(&cache_lock, flags);
+
+OUT:
+	pr_debug("spu_sync_stop -- done.\n");
+	return ret;
+}
+
+
Index: linux-2.6.19-rc6-arnd1+patches/arch/powerpc/oprofile/cell/vma_map.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.19-rc6-arnd1+patches/arch/powerpc/oprofile/cell/vma_map.c	2006-12-15 12:12:23.949796688 -0600
@@ -0,0 +1,233 @@
+ /*
+ * Cell Broadband Engine OProfile Support
+ *
+ * (C) Copyright IBM Corporation 2006
+ *
+ * Author: Maynard Johnson <maynardj@us.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+/* The code in this source file is responsible for generating
+ * vma-to-fileOffset maps for both overlay and non-overlay SPU
+ * applications.
+ */
+
+#include <linux/mm.h>
+#include <linux/string.h>
+#include <linux/uaccess.h>
+#include <linux/elf.h>
+#include "pr_util.h"
+
+
+void vma_map_free(struct vma_map *map)
+{
+	while (map) {
+		vma_map_t *next = map->next;
+		kfree(map);
+		map = next;
+	}
+}
+
+unsigned int vma_map_lookup(vma_map_t *map, unsigned int vma,
+			    const struct spu * aSpu)
+{
+	unsigned int offset = -1;
+	for (; map; map = map->next) {
+		if (vma < map->vma || vma >= map->vma + map->size)
+			continue;
+
+		if (map->guard_ptr) {
+			unsigned int val;
+			if (memcpy(&val,
+				   aSpu->local_store + map->guard_ptr,
+				   sizeof(int))) {
+				printk(KERN_ERR "SPU_PROF: "
+				       "%s, line %d: Error in SPU offset lookup\n",
+				       __FUNCTION__, __LINE__);
+				goto OUT;
+			}
+			if (val != map->guard_val)
+				continue;
+		}
+
+		offset = vma - map->vma + map->offset;
+	}
+OUT:
+	return offset;
+}
+
+static vma_map_t *
+vma_map_add(vma_map_t *map, unsigned int vma, unsigned int size,
+	     unsigned int offset, unsigned int guard_ptr, 
+	     unsigned int guard_val)
+{
+	vma_map_t *new = kzalloc(sizeof(vma_map_t), GFP_ATOMIC);
+	if (!new) {
+		printk(KERN_ERR "SPU_PROF: %s, line %d: malloc failed\n",
+		       __FUNCTION__, __LINE__);
+		vma_map_free(map);
+		return NULL;
+	}
+
+	new->next = map;
+	new->vma = vma;
+	new->size = size;
+	new->offset = offset;
+	new->guard_ptr = guard_ptr;
+	new->guard_val = guard_val;
+
+	return new;
+}
+
+
+/* Parse SPE ELF header and generate a list of vma_maps.
+ * A pointer to the first vma_map in the generated list
+ * of vma_maps is returned.  */
+vma_map_t * create_vma_map(const struct spu * aSpu, 
+			   unsigned long spu_elf_start)
+{
+	static const unsigned char expected[EI_PAD] = {
+		[EI_MAG0] = ELFMAG0,
+		[EI_MAG1] = ELFMAG1,
+		[EI_MAG2] = ELFMAG2,
+		[EI_MAG3] = ELFMAG3,
+		[EI_CLASS] = ELFCLASS32,
+		[EI_DATA] = ELFDATA2MSB,
+		[EI_VERSION] = EV_CURRENT,
+		[EI_OSABI] = ELFOSABI_NONE
+	};
+
+	struct vma_map *map = NULL;
+	unsigned int overlay_tbl_offset = -1;
+	unsigned long phdr_start, shdr_start;
+	Elf32_Ehdr ehdr;
+	Elf32_Phdr phdr;
+	Elf32_Shdr shdr, shdr_str;
+	Elf32_Sym sym;
+	int i, j;
+	char name[32];
+
+	unsigned int ovly_table_sym = 0;
+	unsigned int ovly_buf_table_sym = 0;
+	unsigned int ovly_table_end_sym = 0;
+	unsigned int ovly_buf_table_end_sym = 0;
+	unsigned long ovly_table;
+	unsigned int n_ovlys;
+
+	struct {
+		unsigned int vma;
+		unsigned int size;
+		unsigned int offset;
+		unsigned int buf;
+	} ovly;
+
+	/* Get and validate ELF header.  */
+
+	copy_from_user(&ehdr, (void *) spu_elf_start, sizeof (ehdr));
+	if (memcmp(ehdr.e_ident, expected, EI_PAD) != 0) {
+		printk(KERN_ERR "SPU_PROF: "
+		       "%s, line %d: Unexpected value parsing SPU ELF\n",
+		       __FUNCTION__, __LINE__);
+		return NULL;
+	}
+	if (ehdr.e_machine != 23) {
+		printk(KERN_ERR "SPU_PROF: "
+		       "%s, line %d: Unexpected value parsing SPU ELF\n",
+		       __FUNCTION__,  __LINE__);
+
+		return NULL;
+	}
+	if (ehdr.e_type != ET_EXEC) {
+		printk(KERN_ERR "SPU_PROF: "
+		       "%s, line %d: Unexpected value parsing SPU ELF\n",
+		       __FUNCTION__, __LINE__);
+		return NULL;
+	}
+	phdr_start = spu_elf_start + ehdr.e_phoff;
+	shdr_start = spu_elf_start + ehdr.e_shoff;
+
+	/* Traverse program headers.  */
+	for (i = 0; i < ehdr.e_phnum; i++) {
+		copy_from_user(&phdr, (void *) (phdr_start + i * sizeof(phdr)), 
+			       sizeof(phdr));
+		if (phdr.p_type != PT_LOAD)
+			continue;
+		if (phdr.p_flags & (1 << 27))
+			continue;
+
+		map = vma_map_add(map, phdr.p_vaddr, phdr.p_memsz, 
+				  phdr.p_offset, 0, 0);
+		if (!map)
+			return NULL;
+	}
+
+	pr_debug("SPU_PROF: Created non-overlay maps\n");	
+	/* Traverse section table and search for overlay-related symbols.  */
+	for (i = 0; i < ehdr.e_shnum; i++) {
+		copy_from_user(&shdr, (void *) (shdr_start + i * sizeof(shdr)), 
+			       sizeof(shdr));
+		if (shdr.sh_type != SHT_SYMTAB)
+			continue;
+		if (shdr.sh_entsize != sizeof (sym))
+			continue;
+
+		copy_from_user(&shdr_str, 
+			       (void *) (shdr_start + shdr.sh_link * sizeof(shdr)),
+			       sizeof(shdr));
+		if (shdr_str.sh_type != SHT_STRTAB)
+			return NULL;
+
+		for (j = 0; j < shdr.sh_size / sizeof (sym); j++) {
+			copy_from_user(&sym, (void *) (spu_elf_start +
+						       shdr.sh_offset + j * sizeof (sym)),
+				       sizeof (sym));
+			copy_from_user(name, (void *) (spu_elf_start + shdr_str.sh_offset + 
+						       sym.st_name),
+				       20);
+			if (memcmp(name, "_ovly_table", 12) == 0)
+				ovly_table_sym = sym.st_value;
+			if (memcmp(name, "_ovly_buf_table", 16) == 0)
+				ovly_buf_table_sym = sym.st_value;
+			if (memcmp(name, "_ovly_table_end", 16) == 0)
+				ovly_table_end_sym = sym.st_value;
+			if (memcmp(name, "_ovly_buf_table_end", 20) == 0)
+				ovly_buf_table_end_sym = sym.st_value;
+		}
+	}
+
+	/* If we don't have overlays, we're done.  */
+	if (ovly_table_sym == 0 || ovly_buf_table_sym == 0
+	    || ovly_table_end_sym == 0 || ovly_buf_table_end_sym == 0) {
+		pr_debug("SPU_PROF: No overlay table found\n");
+		return map;
+	}
+	else {
+		pr_debug("SPU_PROF: Overlay table found\n");
+	}
+
+	overlay_tbl_offset = vma_map_lookup(map, ovly_table_sym, aSpu);
+	if (overlay_tbl_offset < 0) {
+		printk(KERN_ERR "SPU_PROF: "
+		       "%s, line %d: Error finding SPU overlay table\n",
+		       __FUNCTION__, __LINE__);
+		return NULL;
+	}
+	ovly_table = spu_elf_start + overlay_tbl_offset;
+	n_ovlys = (ovly_table_end_sym - ovly_table_sym) / sizeof (ovly);
+
+	/* Traverse overlay table.  */
+	for (i = 0; i < n_ovlys; i++) {
+		copy_from_user(&ovly, (void *) (ovly_table + i * sizeof (ovly)),
+			       sizeof (ovly));
+		map = vma_map_add(map, ovly.vma, ovly.size, ovly.offset,
+				   ovly_buf_table_sym + (ovly.buf - 1) * 4, i + 1);
+		if (!map)
+			return NULL;
+	}
+	
+	return map;
+}
Index: linux-2.6.19-rc6-arnd1+patches/arch/powerpc/oprofile/common.c
===================================================================
--- linux-2.6.19-rc6-arnd1+patches.orig/arch/powerpc/oprofile/common.c	2006-12-04 10:56:04.907671816 -0600
+++ linux-2.6.19-rc6-arnd1+patches/arch/powerpc/oprofile/common.c	2006-12-08 10:38:58.071703784 -0600
@@ -150,6 +150,8 @@
 #ifdef CONFIG_PPC_CELL
 		case PPC_OPROFILE_CELL:
 			model = &op_model_cell;
+			ops->sync_start = model->sync_start;
+			ops->sync_stop = model->sync_stop;
 			break;
 #endif
 		case PPC_OPROFILE_RS64:
Index: linux-2.6.19-rc6-arnd1+patches/arch/powerpc/oprofile/Kconfig
===================================================================
--- linux-2.6.19-rc6-arnd1+patches.orig/arch/powerpc/oprofile/Kconfig	2006-12-04 10:56:04.907671816 -0600
+++ linux-2.6.19-rc6-arnd1+patches/arch/powerpc/oprofile/Kconfig	2006-12-08 10:38:58.072703632 -0600
@@ -7,7 +7,8 @@
 
 config OPROFILE
 	tristate "OProfile system profiling (EXPERIMENTAL)"
-	depends on PROFILING
+	default m
+	depends on SPU_FS && PROFILING && CBE_CPUFREQ
 	help
 	  OProfile is a profiling system capable of profiling the
 	  whole system, include the kernel, kernel modules, libraries,
Index: linux-2.6.19-rc6-arnd1+patches/arch/powerpc/oprofile/Makefile
===================================================================
--- linux-2.6.19-rc6-arnd1+patches.orig/arch/powerpc/oprofile/Makefile	2006-12-04 10:56:04.906671968 -0600
+++ linux-2.6.19-rc6-arnd1+patches/arch/powerpc/oprofile/Makefile	2006-12-08 10:38:58.074703328 -0600
@@ -11,7 +11,8 @@
 		timer_int.o )
 
 oprofile-y := $(DRIVER_OBJS) common.o backtrace.o
-oprofile-$(CONFIG_PPC_CELL) += op_model_cell.o
+oprofile-$(CONFIG_PPC_CELL) += op_model_cell.o \
+				cell/spu_profiler.o cell/vma_map.o cell/spu_task_sync.o
 oprofile-$(CONFIG_PPC64) += op_model_rs64.o op_model_power4.o
 oprofile-$(CONFIG_FSL_BOOKE) += op_model_fsl_booke.o
 oprofile-$(CONFIG_6xx) += op_model_7450.o
Index: linux-2.6.19-rc6-arnd1+patches/arch/powerpc/oprofile/op_model_cell.c
===================================================================
--- linux-2.6.19-rc6-arnd1+patches.orig/arch/powerpc/oprofile/op_model_cell.c	2006-12-04 13:13:57.494583440 -0600
+++ linux-2.6.19-rc6-arnd1+patches/arch/powerpc/oprofile/op_model_cell.c	2006-12-14 17:31:26.417821880 -0600
@@ -37,6 +37,18 @@
 #include <asm/system.h>
 
 #include "../platforms/cell/interrupt.h"
+#include "cell/pr_util.h"
+
+/* spu_cycle_reset is the number of cycles between samples.
+ * This variable is used for SPU profiling and should ONLY be set
+ * at the beginning of cell_reg_setup; otherwise, it's read-only.
+ */
+static unsigned int spu_cycle_reset = 0;
+static int profiling_spus = 0;
+unsigned int khzfreq;
+
+#define NUM_SPUS_PER_NODE    8
+#define SPU_CYCLES_EVENT_NUM 2        /*  event number for SPU_CYCLES */
 
 #define PPU_CYCLES_EVENT_NUM 1	/*  event number for CYCLES */
 #define PPU_CYCLES_GRP_NUM   1  /* special group number for identifying
@@ -50,7 +62,6 @@
 #define NUM_TRACE_BUS_WORDS 4
 #define NUM_INPUT_BUS_WORDS 2
 
-
 struct pmc_cntrl_data {
 	unsigned long vcntr;
 	unsigned long evnts;
@@ -134,6 +145,7 @@
 /*
  * Firmware interface functions
  */
+
 static int
 rtas_ibm_cbe_perftools(int subfunc, int passthru,
 		       void *address, unsigned long length)
@@ -418,7 +430,7 @@
 			    = cbe_read_ctr(cpu, i);
 
 			if (per_cpu(pmc_values, cpu + next_hdw_thread)[i]
-			    == 0xFFFFFFFF) 
+			    == 0xFFFFFFFF)
 				/* If the cntr value is 0xffffffff, we must
 				 * reset that to 0xfffffff0 when the current
 				 * thread is restarted.  This will generate a 
@@ -480,7 +492,22 @@
 	       struct op_system_config *sys, int num_ctrs)
 {
 	int i, j, cpu;
+	spu_cycle_reset = 0;
 
+	/* The cpufreq_quick_get function requires that cbe_cpufreq module
+	 * be loaded.  This function is not actually provided and exported
+	 * by cbe_cpufreq, but it relies on cbe_cpufreq initialize kernel
+	 * data structures.  Since there's no way for depmod to realize
+	 * that our OProfile module depends on cbe_cpufreq, we currently
+	 * are letting the userspace tool, opcontrol, ensure that the
+	 * cbe_cpufreq module is loaded.
+	 */
+	khzfreq = cpufreq_quick_get(smp_processor_id());
+
+	if (ctr[0].event == SPU_CYCLES_EVENT_NUM) {
+		spu_cycle_reset = ctr[0].count;
+		return;
+	}
 	pm_rtas_token = rtas_token("ibm,cbe-perftools");
 	if (pm_rtas_token == RTAS_UNKNOWN_SERVICE) {
 		printk(KERN_WARNING "%s: RTAS_UNKNOWN_SERVICE\n",
@@ -553,12 +580,12 @@
 				     pmc_cntrl[0][i].masks);
 
 			/* global, used by cell_cpu_setup */
-			ctr_enabled |= (1 << i); 
+			ctr_enabled |= (1 << i);
 		}
 	}
 
 	/* initialize the previous counts for the virtual cntrs */
-	for_each_online_cpu(cpu) 
+	for_each_online_cpu(cpu)
 		for (i = 0; i < num_counters; ++i) {
 			per_cpu(pmc_values, cpu)[i] = reset_value[i];
 		}
@@ -566,6 +593,8 @@
 	;
 }
 
+
+
 /* This function is called once for each cpu */
 static void cell_cpu_setup(struct op_counter_config *cntr)
 {
@@ -573,6 +602,9 @@
 	u32 num_enabled = 0;
 	int i;
 
+	if (spu_cycle_reset)
+		return;
+
 	/* There is one performance monitor per processor chip (i.e. node),
 	 * so we only need to perform this function once per node.
 	 */
@@ -607,7 +639,131 @@
 	;
 }
 
-static void cell_global_start(struct op_counter_config *ctr)
+static int calculate_lfsr(int n)
+{
+#define size 24
+	int i;
+	unsigned int newlfsr0;
+	unsigned int lfsr = 0xFFFFFF;
+	unsigned int howmany = lfsr - n;
+
+	for (i = 2; i < howmany + 2; i++) {
+		newlfsr0 = (((lfsr >> (size - 1 - 0)) & 1) ^
+			    ((lfsr >> (size - 1 - 1)) & 1) ^
+			    (((lfsr >> (size - 1 - 6)) & 1) ^
+			     ((lfsr >> (size - 1 - 23)) & 1)));
+
+		lfsr >>= 1;
+		lfsr = lfsr | (newlfsr0 << (size - 1));
+	}
+	return lfsr;
+
+}
+
+static void pm_rtas_activate_spu_profiling(u32 node)
+{
+	int ret, i;
+	struct pm_signal pm_signal_local[NR_PHYS_CTRS];
+
+	/* Set up the rtas call to configure the debug bus to 
+	 * route the SPU PCs.  Setup the pm_signal for each SPU */
+	for (i = 0; i < NUM_SPUS_PER_NODE; i++) {
+		pm_signal_local[i].cpu = node;
+		pm_signal_local[i].signal_group = 41;
+		pm_signal_local[i].bus_word = 1 << i / 2; /* spu i on 
+							   * word (i/2) 
+							   */
+		pm_signal_local[i].sub_unit = i;	/* spu i */
+		pm_signal_local[i].bit = 63;
+	}
+
+	pm_rtas_token = rtas_token("ibm,cbe-perftools");
+	if (pm_rtas_token == RTAS_UNKNOWN_SERVICE) {
+		printk(KERN_WARNING "%s: RTAS_UNKNOWN_SERVICE \n",
+		       __FUNCTION__);
+	}
+
+	ret = rtas_ibm_cbe_perftools(SUBFUNC_ACTIVATE, PASSTHRU_ENABLE,
+				     pm_signal_local,
+				     8 * sizeof(struct pm_signal)); //FIXME 8 to #define
+
+	if (ret)
+		printk(KERN_WARNING "%s: rtas returned: %d\n",
+		       __FUNCTION__, ret);
+
+}
+
+static void cell_global_start_spu(struct op_counter_config *ctr)
+{
+	int subfunc, rtn_value;
+	unsigned int lfsr_value;
+	int cpu;
+
+	for_each_online_cpu(cpu) {
+		if (cbe_get_hw_thread_id(cpu))
+			continue;
+		/* Setup SPU cycle-based profiling.
+		 * Set perf_mon_control bit 0 to a zero before
+		 * enabling spu collection hardware.
+		 */
+		cbe_write_pm(cpu, pm_control, 0);
+		/* setup the Debug bus to route the SPU PC to the TLA,
+		 * have TLA save data to the trace buffer.
+		 */
+		pm_rtas_activate_spu_profiling(cbe_cpu_to_node(cpu));
+
+		if (spu_cycle_reset > 0xFFFFFE) 
+				lfsr_value = calculate_lfsr(1);  /* use largest possible 
+								  *  value 
+								  */
+		else 
+		    lfsr_value = calculate_lfsr(spu_cycle_reset);
+
+		if (lfsr_value == 0) {  /* must use a non zero value.  Zero
+					 * disables data collection.
+					 */
+				lfsr_value = calculate_lfsr(1);  /* use largest possible 
+								  * value 
+								 */
+		}
+
+		lfsr_value = lfsr_value << 8; /* shift lfsr to correct 
+					       * register location
+					       */
+		
+/*		pm_rtas_token = rtas_token("ibm,cbe-spu-perftools");  */
+		pm_rtas_token = 52; /* hard code due to rtas bug.  Function
+				     * call is not exported in the current
+				     * fw version.
+				     */
+
+		if (pm_rtas_token == RTAS_UNKNOWN_SERVICE) {
+			printk(KERN_ERR
+			       "%s: rtas token ibm,cbe-spu-perftools unknown\n",
+			       __FUNCTION__);
+		}
+
+		subfunc = 2;	// 2 - activate SPU tracing, 3 - deactivate
+
+		rtn_value = rtas_call(pm_rtas_token, 3, 1, NULL, subfunc,
+			  cbe_cpu_to_node(cpu), lfsr_value);
+
+		if (rtn_value != 0)
+			printk(KERN_ERR
+			       "%s: rtas call ibm,cbe-spu-perftools failed, return = %d\n",
+			       __FUNCTION__, rtn_value);
+	}
+
+	if (!profiling_spus) {   /* FIXME, not sure if we need this since 
+				    this is an spu specific routine */
+		start_spu_profiling(spu_cycle_reset);
+		profiling_spus = 1;
+	}
+
+	oprofile_running = 1;
+}
+
+static void cell_global_start_ppu(struct op_counter_config *ctr)
 {
 	u32 cpu;
 	u32 interrupt_mask = 0;
@@ -652,7 +808,47 @@
 	start_virt_cntrs();
 }
 
-static void cell_global_stop(void)
+static void cell_global_start(struct op_counter_config *ctr)
+{
+	if (spu_cycle_reset) {
+		cell_global_start_spu(ctr);
+	} else {
+		cell_global_start_ppu(ctr);
+	}
+}
+
+static void cell_global_stop_spu(void)
+{
+	int subfunc, rtn_value;
+	unsigned int lfsr_value;
+	int cpu;
+
+	oprofile_running = 0;
+
+	for_each_online_cpu(cpu) {
+		if (cbe_get_hw_thread_id(cpu))
+			continue;
+
+		subfunc = 3;	// 2 - activate SPU tracing, 3 - deactivate
+		lfsr_value = 0x8f100000;
+
+		rtn_value =
+		    rtas_call(pm_rtas_token, 3, 1, NULL, subfunc,
+			      cbe_cpu_to_node(cpu), lfsr_value);
+
+		if (rtn_value != 0)
+			printk
+			    ("ERROR, rtas call ibm,cbe-spu-perftools failed, return = %d\n",
+			     rtn_value);
+	}
+	if (profiling_spus) {
+		stop_spu_profiling();
+		profiling_spus = 0;
+	}
+
+}
+
+static void cell_global_stop_ppu(void)
 {
 	int cpu;
 
@@ -680,6 +876,16 @@
 	}
 }
 
+static void cell_global_stop(void)
+{
+	if (spu_cycle_reset) {
+		cell_global_stop_spu();
+	} else {
+		cell_global_stop_ppu();
+	}
+
+}
+
 static void
 cell_handle_interrupt(struct pt_regs *regs, struct op_counter_config *ctr)
 {
@@ -732,7 +938,7 @@
 		 * routine may have cleared the interrupts.  Hence must
 		 * use the virt_cntr_inter_mask to re-enable the interrupts.
 		 */
-		cbe_enable_pm_interrupts(cpu, hdw_thread, 
+		cbe_enable_pm_interrupts(cpu, hdw_thread,
 					 virt_cntr_inter_mask);
 
 		/* The writes to the various performance counters only writes
@@ -748,10 +954,33 @@
 	spin_unlock_irqrestore(&virt_cntr_lock, flags);
 }
 
+/* This function is called from the generic OProfile
+ * driver.  When profiling PPUs, we need to do the
+ * generic sync start; otherwise, do spu_sync_start.
+ */
+static int cell_sync_start(void)
+{
+	if (spu_cycle_reset)
+		return spu_sync_start();
+	else
+		return DO_GENERIC_SYNC;
+}
+
+static int cell_sync_stop(void)
+{
+	if (spu_cycle_reset)
+		return spu_sync_stop();
+	else
+		return 1;
+}
+
+
 struct op_powerpc_model op_model_cell = {
 	.reg_setup = cell_reg_setup,
 	.cpu_setup = cell_cpu_setup,
 	.global_start = cell_global_start,
 	.global_stop = cell_global_stop,
+	.sync_start = cell_sync_start,
+	.sync_stop = cell_sync_stop,
 	.handle_interrupt = cell_handle_interrupt,
 };
Index: linux-2.6.19-rc6-arnd1+patches/arch/powerpc/platforms/cell/spufs/sched.c
===================================================================
--- linux-2.6.19-rc6-arnd1+patches.orig/arch/powerpc/platforms/cell/spufs/sched.c	2006-12-08 09:04:40.558774376 -0600
+++ linux-2.6.19-rc6-arnd1+patches/arch/powerpc/platforms/cell/spufs/sched.c	2006-12-08 10:38:58.086701504 -0600
@@ -125,6 +125,7 @@
 	ctx->spu = spu;
 	ctx->ops = &spu_hw_ops;
 	spu->pid = current->pid;
+	spu->tgid = current->tgid;
 	spu->prio = current->prio;
 	spu->mm = ctx->owner;
 	mm_needs_global_tlbie(spu->mm);
@@ -157,6 +158,7 @@
 	spu->dma_callback = NULL;
 	spu->mm = NULL;
 	spu->pid = 0;
+	spu->tgid = 0;
 	spu->prio = MAX_PRIO;
 	ctx->ops = &spu_backing_ops;
 	ctx->spu = NULL;
Index: linux-2.6.19-rc6-arnd1+patches/drivers/oprofile/buffer_sync.c
===================================================================
--- linux-2.6.19-rc6-arnd1+patches.orig/drivers/oprofile/buffer_sync.c	2006-12-04 10:56:13.234602872 -0600
+++ linux-2.6.19-rc6-arnd1+patches/drivers/oprofile/buffer_sync.c	2006-12-08 10:38:58.088701200 -0600
@@ -26,6 +26,7 @@
 #include <linux/profile.h>
 #include <linux/module.h>
 #include <linux/fs.h>
+#include <linux/oprofile.h>
  
 #include "oprofile_stats.h"
 #include "event_buffer.h"
Index: linux-2.6.19-rc6-arnd1+patches/drivers/oprofile/event_buffer.h
===================================================================
--- linux-2.6.19-rc6-arnd1+patches.orig/drivers/oprofile/event_buffer.h	2006-12-04 10:56:13.232603176 -0600
+++ linux-2.6.19-rc6-arnd1+patches/drivers/oprofile/event_buffer.h	2006-12-08 10:38:58.089701048 -0600
@@ -19,28 +19,10 @@
  
 /* wake up the process sleeping on the event file */
 void wake_up_buffer_waiter(void);
- 
-/* Each escaped entry is prefixed by ESCAPE_CODE
- * then one of the following codes, then the
- * relevant data.
- */
-#define ESCAPE_CODE			~0UL
-#define CTX_SWITCH_CODE 		1
-#define CPU_SWITCH_CODE 		2
-#define COOKIE_SWITCH_CODE 		3
-#define KERNEL_ENTER_SWITCH_CODE	4
-#define KERNEL_EXIT_SWITCH_CODE		5
-#define MODULE_LOADED_CODE		6
-#define CTX_TGID_CODE			7
-#define TRACE_BEGIN_CODE		8
-#define TRACE_END_CODE			9
- 
+  
 #define INVALID_COOKIE ~0UL
 #define NO_COOKIE 0UL
 
-/* add data to the event buffer */
-void add_event_entry(unsigned long data);
- 
 extern struct file_operations event_buffer_fops;
  
 /* mutex between sync_cpu_buffers() and the
Index: linux-2.6.19-rc6-arnd1+patches/drivers/oprofile/oprof.c
===================================================================
--- linux-2.6.19-rc6-arnd1+patches.orig/drivers/oprofile/oprof.c	2006-12-04 10:56:13.234602872 -0600
+++ linux-2.6.19-rc6-arnd1+patches/drivers/oprofile/oprof.c	2006-12-08 10:38:58.091700744 -0600
@@ -53,9 +53,23 @@
 	 * us missing task deaths and eventually oopsing
 	 * when trying to process the event buffer.
 	 */
+	if (oprofile_ops.sync_start) {
+		int sync_ret = oprofile_ops.sync_start();
+		switch (sync_ret) {
+			case 0: goto post_sync;
+				break;
+			case 1: goto do_generic;
+				break;
+			case -1: goto out3;
+				break;
+			default: goto out3;
+		}
+	}
+do_generic:
 	if ((err = sync_start()))
 		goto out3;
 
+post_sync:
 	is_setup = 1;
 	mutex_unlock(&start_mutex);
 	return 0;
@@ -118,7 +132,19 @@
 void oprofile_shutdown(void)
 {
 	mutex_lock(&start_mutex);
+        if (oprofile_ops.sync_stop) {
+                int sync_ret = oprofile_ops.sync_stop();
+                switch (sync_ret) {
+                        case 0: goto post_sync;
+                                break;
+                        case 1: goto do_generic;
+                                break;
+			default: goto post_sync;
+                }
+        }
+do_generic:
 	sync_stop();
+post_sync:
 	if (oprofile_ops.shutdown)
 		oprofile_ops.shutdown();
 	is_setup = 0;
Index: linux-2.6.19-rc6-arnd1+patches/include/asm-powerpc/oprofile_impl.h
===================================================================
--- linux-2.6.19-rc6-arnd1+patches.orig/include/asm-powerpc/oprofile_impl.h	2006-12-04 10:56:17.390638464 -0600
+++ linux-2.6.19-rc6-arnd1+patches/include/asm-powerpc/oprofile_impl.h	2006-12-08 10:38:58.093700440 -0600
@@ -47,6 +47,8 @@
         void (*global_start) (struct op_counter_config *);
 	void (*stop) (void);
 	void (*global_stop) (void);
+	int (*sync_start)(void);
+	int (*sync_stop)(void);
 	void (*handle_interrupt) (struct pt_regs *,
 				  struct op_counter_config *);
 	int num_counters;
Index: linux-2.6.19-rc6-arnd1+patches/include/asm-powerpc/spu.h
===================================================================
--- linux-2.6.19-rc6-arnd1+patches.orig/include/asm-powerpc/spu.h	2006-12-08 10:38:10.069679312 -0600
+++ linux-2.6.19-rc6-arnd1+patches/include/asm-powerpc/spu.h	2006-12-08 10:38:58.095700136 -0600
@@ -130,6 +130,7 @@
 	struct spu_runqueue *rq;
 	unsigned long long timestamp;
 	pid_t pid;
+	pid_t tgid;
 	int prio;
 	int class_0_pending;
 	spinlock_t register_lock;
Index: linux-2.6.19-rc6-arnd1+patches/include/linux/oprofile.h
===================================================================
--- linux-2.6.19-rc6-arnd1+patches.orig/include/linux/oprofile.h	2006-12-04 10:56:17.222664000 -0600
+++ linux-2.6.19-rc6-arnd1+patches/include/linux/oprofile.h	2006-12-08 10:38:58.097699832 -0600
@@ -17,6 +17,28 @@
 #include <linux/spinlock.h>
 #include <asm/atomic.h>
  
+/* Each escaped entry is prefixed by ESCAPE_CODE
+ * then one of the following codes, then the
+ * relevant data.
+ * These #defines live in this file so that arch-specific
+ * buffer sync'ing code can access them.  
+ */
+#define ESCAPE_CODE                     ~0UL
+#define CTX_SWITCH_CODE                 1
+#define CPU_SWITCH_CODE                 2
+#define COOKIE_SWITCH_CODE              3
+#define KERNEL_ENTER_SWITCH_CODE        4
+#define KERNEL_EXIT_SWITCH_CODE         5
+#define MODULE_LOADED_CODE              6
+#define CTX_TGID_CODE                   7
+#define TRACE_BEGIN_CODE                8
+#define TRACE_END_CODE                  9
+#define XEN_ENTER_SWITCH_CODE          10
+#define SPU_PROFILING_CODE             11
+#define SPU_CTX_SWITCH_CODE            12
+#define SPU_OFFSET_CODE                13
+#define SPU_COOKIE_CODE                14
+
 struct super_block;
 struct dentry;
 struct file_operations;
@@ -35,6 +57,14 @@
 	int (*start)(void);
 	/* Stop delivering interrupts. */
 	void (*stop)(void);
+	/* Arch-specific buffer sync functions.
+	 * Return value = 0:  Success
+	 * Return value = -1: Failure
+	 * Return value = 1:  Run generic sync function
+	 */
+	int (*sync_start)(void);
+	int (*sync_stop)(void);
+
 	/* Initiate a stack backtrace. Optional. */
 	void (*backtrace)(struct pt_regs * const regs, unsigned int depth);
 	/* CPU identification string. */
@@ -56,6 +86,13 @@
 void oprofile_arch_exit(void);
 
 /**
+ * Add data to the event buffer.
+ * The data passed is free-form, but typically consists of
+ * file offsets, dcookies, context information, and ESCAPE codes.
+ */
+void add_event_entry(unsigned long data);
+ 
+/**
  * Add a sample. This may be called from any context. Pass
  * smp_processor_id() as cpu.
  */

--------------000606060509070105070208--

