Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbTH2UCh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 16:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261933AbTH2UCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 16:02:37 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:63418 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261821AbTH2T4S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 15:56:18 -0400
Subject: [RFC/PATCH] CKRM cpu control patch 2.6.0-test2
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
To: LKML <linux-kernel@vger.kernel.org>
Cc: ckrm-tech <ckrm-tech@lists.sourceforge.net>
Content-Type: text/plain
Organization: 
Message-Id: <1062186933.15245.840.camel@elinux05.watson.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 29 Aug 2003 15:55:35 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The CPU controller patch for Class-based Kernel Resource Management.
Applies over ckcore-A01-2.6.0-test2 patch posted earlier.

For more details, please refer to 
	http://ckrm.sf.net

and the earlier posting on lkml.

-- Shailabh

--------------------------------------------------------------------------------


diff -Nru a/fs/proc/base.c b/fs/proc/base.c
--- a/fs/proc/base.c	Fri Aug 29 14:49:47 2003
+++ b/fs/proc/base.c	Fri Aug 29 14:49:47 2003
@@ -53,6 +53,8 @@
 	PROC_PID_FD,
 	PROC_PID_ENVIRON,
 	PROC_PID_CMDLINE,
+	PROC_PID_CLASS,
+	PROC_PID_INTERACTIVE,
 	PROC_PID_STAT,
 	PROC_PID_STATM,
 	PROC_PID_MAPS,
@@ -81,6 +83,8 @@
   E(PROC_PID_ENVIRON,	"environ",	S_IFREG|S_IRUSR),
   E(PROC_PID_STATUS,	"status",	S_IFREG|S_IRUGO),
   E(PROC_PID_CMDLINE,	"cmdline",	S_IFREG|S_IRUGO),
+  E(PROC_PID_CLASS,     "class",        S_IFREG|S_IRUGO),
+  E(PROC_PID_INTERACTIVE,"interactive", S_IFREG|S_IRUGO),
   E(PROC_PID_STAT,	"stat",		S_IFREG|S_IRUGO),
   E(PROC_PID_STATM,	"statm",	S_IFREG|S_IRUGO),
   E(PROC_PID_MAPS,	"maps",		S_IFREG|S_IRUGO),
@@ -267,6 +271,18 @@
 	return res;
 }
 
+static int proc_pid_class(struct task_struct *task, char *buffer)
+{
+       return sprintf(buffer, "%d\n", task->classid);
+}
+
+extern int task_interactive(struct task_struct * p);
+
+static int proc_pid_interactive(struct task_struct *task, char *buffer)
+{
+       return sprintf(buffer, "%d\n", task_interactive(task));
+}
+
 #ifdef CONFIG_KALLSYMS
 /*
  * Provides a wchan file via kallsyms in a proper one-value-per-file
format.
@@ -1173,6 +1189,14 @@
 		case PROC_PID_CMDLINE:
 			inode->i_fop = &proc_info_file_operations;
 			ei->op.proc_read = proc_pid_cmdline;
+			break;
+	        case PROC_PID_CLASS:
+			inode->i_fop = &proc_info_file_operations;
+			ei->op.proc_read = proc_pid_class;
+			break;
+	        case PROC_PID_INTERACTIVE:
+			inode->i_fop = &proc_info_file_operations;
+			ei->op.proc_read = proc_pid_interactive;
 			break;
 		case PROC_PID_STATM:
 			inode->i_fop = &proc_info_file_operations;
diff -Nru a/fs/proc/proc_misc.c b/fs/proc/proc_misc.c
--- a/fs/proc/proc_misc.c	Fri Aug 29 14:49:47 2003
+++ b/fs/proc/proc_misc.c	Fri Aug 29 14:49:47 2003
@@ -356,6 +356,20 @@
 	.release	= seq_release,
 };
 
+extern struct seq_operations classes_op;
+extern ssize_t classes_write(struct file *, const char *, size_t,
loff_t *);
+static int classes_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &classes_op);
+}
+static struct file_operations proc_classes_operations = {
+	.open		= classes_open,
+	.read		= seq_read,
+	.write		= classes_write,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
 static int kstat_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
@@ -650,6 +664,10 @@
 #ifdef CONFIG_MODULES
 	create_seq_entry("modules", 0, &proc_modules_operations);
 #endif
+
+	create_seq_entry("classes", S_IWUSR|S_IRUGO,
&proc_classes_operations);
+
+
 	proc_root_kcore = create_proc_entry("kcore", S_IRUSR, NULL);
 	if (proc_root_kcore) {
 		proc_root_kcore->proc_fops = &proc_kcore_operations;
diff -Nru a/include/linux/circularqueue.h
b/include/linux/circularqueue.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/circularqueue.h	Fri Aug 29 14:49:47 2003
@@ -0,0 +1,47 @@
+/* include/linux/circularqueue.h : cpu control for CKRM
+ *
+ * Copyright (C) Haoqiang Zheng, IBM Corp. 2003
+ *           (C) Hubertus Franke, IBM Corp. 2003
+ * 
+ * Circular queue functionality for CKRM cpu controller
+ *
+ * Latest version, more details at http://ckrm.sf.net
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+/* Changes
+ *
+ * 28 Aug 2003
+ *        Created.
+ */
+
+#ifndef _CIRCULARQUEUE_H
+#define _CIRCULARQUEUE_H
+
+#include <linux/list.h>
+
+struct circularqueue_struct;
+
+struct cq_node_struct {
+	struct list_head list;
+	int pos; 
+	int real_pos;
+	void *parent; //parent structure, maintained by outsider
+};
+
+typedef  struct cq_node_struct  cp_node_t;
+
+
+//void addto_circular_queue(struct circularqueue_struct *cq,cp_node_t*
node,int pos);
+void removefrom_circular_queue(struct circularqueue_struct
*cq,cp_node_t* node);
+void adjust_cq_pos(struct circularqueue_struct *cq,cp_node_t * node,int
new_pos);
+cp_node_t * get_first_element(struct circularqueue_struct *cq);
+
+struct circularqueue_struct * create_circular_queue(int size);
+void get_next_element(struct circularqueue_struct *cq,int* last_pos,
cp_node_t** last_node);
+#endif
diff -Nru a/include/linux/class.h b/include/linux/class.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/class.h	Fri Aug 29 14:49:47 2003
@@ -0,0 +1,109 @@
+/* include/linux/class.h : cpu control for CKRM
+ *
+ * Copyright (C) Haoqiang Zheng, IBM Corp. 2003
+ *           (C) Hubertus Franke, IBM Corp. 2003
+ * 
+ * Main functions, CKRM API functions and proc interface 
+ * for cpu controller for CKRM
+ *
+ * Latest version, more details at http://ckrm.sf.net
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+/* Changes
+ *
+ * 28 Aug 2003
+ *        Created.
+ */
+
+#ifndef _LINUX_CLASS_H
+#define _LINUX_CLASS_H
+
+#include <linux/circularqueue.h>
+
+#define MAX_CLASS_NUM  32  //max number of classes supported in the
sytem
+//sample every 2000 ticks
+#define CLASS_SAMPLE_RATE 2000 
+
+struct global_class_struct;
+struct local_class_queue;
+struct runqueue;
+struct task_struct;
+
+typedef long long CVT_t;
+
+void init_classes(void);
+inline CVT_t *get_class_CVT(struct local_class_queue *  class_queue);
+inline cp_node_t * get_ecp_queue(struct local_class_queue * 
class_queue);
+inline struct global_class_struct * get_class(int classid);
+inline struct local_class_queue* get_local_class_queue(int classid, int
cpu);
+inline int get_class_running(struct local_class_queue *  class_queue);
+inline int get_class_weight(struct local_class_queue *  class_queue);
+inline int get_class_id(struct local_class_queue *  class_queue);
+inline int get_class_priority(struct local_class_queue *  class_queue);
+inline int get_queue_pressure_byid(int class_id, int cpu);
+
+//enqueue to active to expired queue
+void enqueue_to_class(struct task_struct* p,int active);
+void dequeue_from_class(struct task_struct* p);
+inline void class_add_member(int class_id);
+inline void class_remove_member(int class_id);
+
+
+struct task_struct* get_first_job(struct local_class_queue * 
class_queue);
+int is_task_active(struct task_struct* p);
+int check_interactive_starving(struct task_struct *p);
+void update_lCVT(struct task_struct * p, unsigned long dt);
+inline void update_gCVT(struct local_class_queue* class_queue);
+
+void check_queue_switch(struct task_struct* p);
+
+struct task_struct* find_mp_from_class(struct local_class_queue*
busiest,	 
+			    struct runqueue* busiest_runqueue,
+			    int imbalance);
+
+
+void sample_classes(int cpu);
+struct task_struct * balance_local_queue(
+	 struct local_class_queue * busiest_queue,
+	 struct runqueue* busiest_runqueue,
+	 struct local_class_queue * this_queue);
+
+#define bonus(p) (p->static_prio - p->prio)
+#define process_pressure(p) ( task_timeslice(p) * ( 5- bonus(p) ) )
+struct global_class_struct * __create_class(int class_id,char*
classname,int weight,int init);
+
+/********* all the tunable parameters here ****************/
+//advance 100 ticks for interactive job
+#define CVT_ACCURACY 13
+/*
+  how many tick is one step?
+  let me use 16 tick for one step
+ */
+#define CLASS_BONUS_RATE 15
+#define PRIORITY_BONUS_RATE 0
+
+#define BPT_QUEUE_SIZE 128
+#define CVT_WINDOW_SIZE (BPT_QUEUE_SIZE << CLASS_BONUS_RATE)
+
+#include <linux/bootmem.h>
+#include <asm/bitops.h>
+#include <linux/zhq_debug.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+
+#define ALLOC_MEM(name,type) name = (type *)
alloc_bootmem(sizeof(type))
+#define ALLOC_MUL_MEM(name,type,num) name = (type *)
alloc_bootmem(sizeof(type)*num)
+#define ALLOC_MEM_SIZE(name,size) name = alloc_bootmem(size)
+#define KERNEL_ALLOC_MEM(name,type) name = (type *)
kmalloc(sizeof(type),GFP_KERNEL)
+
+extern int task_interactive(struct task_struct * p);
+inline struct runqueue *task_rq_lock(struct task_struct *p, unsigned
long *flags);
+inline void task_rq_unlock(struct runqueue *rq, unsigned long *flags);
+
+#endif
diff -Nru a/include/linux/init_task.h b/include/linux/init_task.h
--- a/include/linux/init_task.h	Fri Aug 29 14:49:47 2003
+++ b/include/linux/init_task.h	Fri Aug 29 14:49:47 2003
@@ -108,6 +108,7 @@
 	.proc_lock	= SPIN_LOCK_UNLOCKED,				\
 	.switch_lock	= SPIN_LOCK_UNLOCKED,				\
 	.journal_info	= NULL,						\
+	.classid	= 0,						\
 }
 
 
diff -Nru a/include/linux/progress.h b/include/linux/progress.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/progress.h	Fri Aug 29 14:49:47 2003
@@ -0,0 +1,39 @@
+/* include/linux/progress.h : cpu control for CKRM
+ *
+ * Copyright (C) Haoqiang Zheng, IBM Corp. 2003
+ *           (C) Hubertus Franke, IBM Corp. 2003
+ * 
+ * Helper functions for cpu controller for CKRM
+ *
+ * Latest version, more details at http://ckrm.sf.net
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+/* Changes
+ *
+ * 28 Aug 2003
+ *        Created.
+ */
+
+#ifndef _LINUX_PROGRESS_H
+#define _LINUX_PROGRESS_H
+
+#include <linux/class.h>
+
+struct bpt_struct;
+struct local_class_queue;
+
+struct task_struct * get_CF_next(struct bpt_struct* bpt,struct
task_struct* prev);
+void update_ecp_pos(struct local_class_queue* class_queue, struct
bpt_struct* bpt);
+void init_bpts(void);
+
+inline struct bpt_struct* get_bpt(int cpu_id);
+inline void remove_from_bpt(struct bpt_struct* bpt,struct
local_class_queue* class_queue);
+struct task_struct * find_mp_from_bpt(struct bpt_struct* bpt,struct
runqueue* busiest_runqueue,int imbalance);
+
+#endif
diff -Nru a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Fri Aug 29 14:49:47 2003
+++ b/include/linux/sched.h	Fri Aug 29 14:49:47 2003
@@ -457,12 +457,12 @@
 
 	unsigned long ptrace_message;
 	siginfo_t *last_siginfo; /* For ptrace use.  */
-
 	struct ckrm_cpu_class *cpu_class;
 	struct ckrm_mem_class *mem_class;
 	struct ckrm_net_class *net_class;
 	struct ckrm_io_class  *io_class;
-	void *ckrm_client_data;              
+	void *ckrm_client_data;	
+	int classid; //for class fiar scheduling
 };
 
 extern void __put_task_struct(struct task_struct *tsk);
@@ -868,6 +868,11 @@
 
 #endif /* CONFIG_SMP */
 
+//additional exports
+inline unsigned int task_timeslice(task_t *p);
+struct runqueue;
+int can_migrate_task(struct task_struct * p,struct runqueue *rq,int
this_cpu);
+inline struct runqueue * get_cpu_rq(int cpu);
 #endif /* __KERNEL__ */
 
 #endif
diff -Nru a/include/linux/zhq_debug.h b/include/linux/zhq_debug.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/zhq_debug.h	Fri Aug 29 14:49:47 2003
@@ -0,0 +1,26 @@
+#ifndef ZHQ_DEBUG_H
+#define ZHQ_DEBUG_H
+#include <linux/fs.h>
+
+int myprintk_cleanbuf(struct file *filep);
+
+#define  assert(cond) {\
+  if (! cond) {\
+      panic("assertion failed at file: %s line: %d
\n",__FILE__,__LINE__);\
+  }\
+}
+
+
+#define warn(buf) {}
+
+#define debug_info0(info) {}
+
+
+#define debug_info1(info,para) {}
+
+
+#define debug_info2(info,para1,para2) {}
+
+#define debug_info3(info,para1,para2,para3) {}
+
+#endif
diff -Nru a/kernel/Makefile b/kernel/Makefile
--- a/kernel/Makefile	Fri Aug 29 14:49:47 2003
+++ b/kernel/Makefile	Fri Aug 29 14:49:47 2003
@@ -6,7 +6,8 @@
 	    exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
-	    rcupdate.o intermodule.o extable.o params.o posix-timers.o
+	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
+	    class.o progress.o circularqueue.o
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
diff -Nru a/kernel/circularqueue.c b/kernel/circularqueue.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/kernel/circularqueue.c	Fri Aug 29 14:49:47 2003
@@ -0,0 +1,302 @@
+/* kernel/circularqueue.c : cpu control for CKRM
+ *
+ * Copyright (C) Haoqiang Zheng, IBM Corp. 2003
+ *           (C) Hubertus Franke, IBM Corp. 2003
+ * 
+ * Circular queue functionality for CKRM cpu controller
+ *
+ * Latest version, more details at http://ckrm.sf.net
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+/* Changes
+ *
+ * 28 Aug 2003
+ *        Created.
+ */
+
+#include <linux/class.h>
+#include <linux/circularqueue.h>
+
+/*
+Description:
+   implements circular queue
+Design:
+-- first think of a buffer with infinit length
+-- the buffer is used to store nodes
+-- node->pos represents the position of the node in the buffer
+-- if max(node->pos) - min(node->pos) < size, then a buffer with size
is enough to hold everything
+
+node = {pos,real_pos,link}
+-- add_to_queue()
+-- remove_from_queue()
+-- adjust_pos()
+
+every body compare itself with the current end of queue
+the (end, node[end]->pos) defines the status of the queue
+
+   circular queue should represent the relative position of the nodes
+
+   the current status of circular queue is defined by
(end,node[end]->pos)
+ */
+
+struct circularqueue_struct {
+	struct list_head* queues;
+	/*should always represent if the queue is empty or not */
+	unsigned long * bitmap;
+	int size;
+
+	/*end is the absolute position */
+	int end;
+	
+	int nr_member;	
+};
+
+
+#define BITMAP_SIZE(size) (((size+8)/8+sizeof(long)-1)/sizeof(long))
+ 
+/*
+Description:
+  return 0 on normal
+  return -1 on exception
+Design:
+Status: test
+ */
+struct circularqueue_struct * create_circular_queue(int size) {
+	int i;
+	struct circularqueue_struct *cq = NULL;
+
+        ALLOC_MEM(cq,struct circularqueue_struct);
+	if (! cq) {
+		assert(0);
+		return NULL;
+	}
+
+	ALLOC_MUL_MEM(cq->queues,struct list_head, size);
+	if (cq->queues == NULL) {
+		assert(0);
+		return NULL;
+	}
+	
+	ALLOC_MEM_SIZE(cq->bitmap,BITMAP_SIZE(size));
+	if (cq->bitmap == NULL) {
+		assert(0);
+		return NULL;
+	}
+	for (i = 0; i < size; i++) {
+		INIT_LIST_HEAD(&cq->queues[i]);
+		__clear_bit(i, cq->bitmap);
+	}
+	// delimiter for bitsearch
+	__set_bit(size, cq->bitmap);
+
+       
+	cq->size = size;
+	cq->end = -1; //not valid yet
+	cq->nr_member = 0;
+
+	return cq;
+}
+
+/*
+  return 1 if moved backward
+ */
+static int check_move_backward(struct circularqueue_struct *cq) {
+	int end = (cq->end + cq->size - 1) % cq->size;
+
+//	if (! test_bit(end,cq->bitmap)) {
+
+	if (list_empty(&cq->queues[end]) ) {
+		cq->end = end;
+		return 1;
+	} else {
+		return 0;
+	}
+}
+
+/*
+  if can move backward a valid pos is [min_pos-1,(min_pos + size -1]
+  else a valid pos is [min_pos,(min_pos + size -1]
+ */
+static void validate_pos(struct circularqueue_struct *cq, int* min_pos,
int* pos) {
+	int max_pos;
+
+	if (! cq->nr_member)  return;
+
+	max_pos = *min_pos + cq->size - 1;
+
+	if (*pos > max_pos) *pos = max_pos; 
+	if (*pos < *min_pos) {
+		if (check_move_backward(cq)) {
+			*min_pos = *min_pos - 1;
+		}
+		*pos = *min_pos; 
+	}
+}
+
+static inline int get_absolute_pos(struct circularqueue_struct *cq,int*
pos) {
+	int min_pos;
+	int real_pos;
+
+	if (! cq->nr_member) return 0;
+
+	min_pos = get_first_element(cq)->pos;
+
+	validate_pos(cq,&min_pos,pos);
+
+	real_pos = (cq->end + (*pos - min_pos) + cq->size) % cq->size;
+
+	return real_pos;
+}
+
+
+/*
+Description:
+  add node to the queue at virtual pos of pos
+Task:
+  validate the pos
+
+  decide the real pos
+
+  the absolute pos is relative to the 
+  the pos is relative to end
+  return the real_pos
+Status:
+ */
+static void addto_circular_queue(struct circularqueue_struct
*cq,cp_node_t* node,int pos) {
+	int real_pos = get_absolute_pos(cq,&pos);
+	
+	if (! cq->nr_member) {
+		cq->end = real_pos; //the first one
+	}
+	
+	//add to head of the queue
+	list_add(&(node->list),&cq->queues[real_pos]);
+	//set the bitmap
+	__set_bit(real_pos,cq->bitmap);
+
+	node->real_pos = real_pos;
+	node->pos = pos;
+
+	cq->nr_member ++;
+}
+
+/*
+  if the current end is cleared, move to the next non-cleared end
+ */
+static void check_update_end(struct circularqueue_struct *cq) {
+	if (! cq->nr_member) {
+		cq->end = -1; //not defined
+		return;
+	}
+
+	if (list_empty(&cq->queues[cq->end])) {
+		cq->end = find_next_bit(cq->bitmap,cq->size,cq->end);
+		if (cq->end >= cq->size) {//do circular, search from the beginning
+			cq->end = find_first_bit(cq->bitmap,cq->size);
+		}
+		if (cq->end >= cq->size) { //double check
+			assert(0);
+		}
+	}
+}
+/*
+ */
+void removefrom_circular_queue(struct circularqueue_struct
*cq,cp_node_t* node) {		//delete from node
+	list_del(&(node->list));
+	cq->nr_member --;
+
+	//check clear the bitmap
+	if (list_empty(&cq->queues[node->real_pos])) {
+		__clear_bit(node->real_pos,cq->bitmap);
+	}
+
+	node->real_pos = -1;
+
+	check_update_end(cq);
+//	report_circular_queue(cq); 
+}
+
+/*
+  always adjust the end
+ */
+void adjust_cq_pos(struct circularqueue_struct *cq,cp_node_t * node,int
new_pos) {
+	int real_pos;
+
+	if (node->real_pos < 0) { //new node
+		return addto_circular_queue(cq,node,new_pos);
+	}
+
+	real_pos = get_absolute_pos(cq,&new_pos);
+
+	//remove from the original position
+	list_del(&(node->list));
+	if (list_empty(&cq->queues[node->real_pos])) {
+		__clear_bit(node->real_pos,cq->bitmap);
+		//adjust the end
+		
+	}
+
+	//add to new positon
+	list_add_tail(&(node->list),&cq->queues[real_pos]);
+	__set_bit(real_pos,cq->bitmap);
+	node->pos = new_pos;
+	node->real_pos = real_pos;
+
+	
+	check_update_end(cq);	
+
+}
+
+cp_node_t * get_first_element(struct circularqueue_struct *cq) {
+	cp_node_t *  result = NULL;
+
+	if (! list_empty(& cq->queues[cq->end])) {
+		result = list_entry(cq->queues[cq->end].next,cp_node_t,list);		
+	} else {
+		if (cq->nr_member) {
+			assert(0);
+		}
+	}
+	return result;
+}
+
+/*
+  used for iterate
+
+  if last_pos == -1, then first one
+
+  otherwise, first check if there's anyone after this node
+  if not, find the next pos
+
+  set last_node to NULL if there's none
+
+ */
+void get_next_element(struct circularqueue_struct *cq,int* last_pos,
cp_node_t** last_node) {
+	int new_pos;
+	if (*last_pos < 0) {
+		*last_pos = cq->end;
+		*last_node = get_first_element(cq);
+	} else {
+		if (& (cq->queues[*last_pos]) == (*last_node)->list.next) { //end of
list?
+			//find the next pos
+			new_pos = find_next_bit(cq->bitmap,cq->size,*last_pos+1);
+			if (new_pos >= cq->size) {//do circular, search from the beginning
+				new_pos = find_first_bit(cq->bitmap,cq->size);
+			}
+			if (new_pos == cq->end) {
+				*last_node = NULL; //no more
+			} else {
+				*last_pos = new_pos;
+				*last_node = list_entry(cq->queues[*last_pos].next,cp_node_t,list);
			
+			}
+		} else {
+			*last_node = list_entry((*last_node)->list.next,cp_node_t,list);
+		}
+	}
+}
diff -Nru a/kernel/ckrm.c b/kernel/ckrm.c
--- a/kernel/ckrm.c	Fri Aug 29 14:49:47 2003
+++ b/kernel/ckrm.c	Fri Aug 29 14:49:47 2003
@@ -84,7 +84,7 @@
 
 
 
-DEF_CKRM_CLASS(cpu);
+//DEF_CKRM_CLASS(cpu);
 DEF_CKRM_CLASS(mem);
 DEF_CKRM_CLASS(net);
 DEF_CKRM_CLASS(io);
diff -Nru a/kernel/class.c b/kernel/class.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/kernel/class.c	Fri Aug 29 14:49:47 2003
@@ -0,0 +1,962 @@
+/* kernel/class.c : cpu control for CKRM
+ *
+ * Copyright (C) Haoqiang Zheng, IBM Corp. 2003
+ *           (C) Hubertus Franke, IBM Corp. 2003
+ * 
+ * Main functions, CKRM API functions and proc interface 
+ * for cpu controller for CKRM
+ *
+ * Latest version, more details at http://ckrm.sf.net
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+/* Changes
+ *
+ * 28 Aug 2003
+ *        Created.
+ */
+
+#include <linux/class.h>
+#include <linux/progress.h>
+
+#include <asm/uaccess.h>
+#include <linux/seq_file.h>
+#include <linux/module.h>
+
+
+/*
+Description:
+   This file holds the code class based propotional sharing
+Design:   
+ */
+#define MAX_CLASS_NAME_LEN 20
+
+/*
+ * These are the runqueue data structures:
+ */
+
+#define BITMAP_SIZE ((((MAX_PRIO+1+7)/8)+sizeof(long)-1)/sizeof(long))
+
+struct prio_array {
+	int nr_active;
+	unsigned long bitmap[BITMAP_SIZE];
+	struct list_head queue[MAX_PRIO];
+};
+
+/*
+  per CPU class object
+
+  the content of the queue can change:
+  -- add to the queue (wakeup or migrate in)
+  -- remove from the queue  (block or migrate out)
+  -- expire 
+  -- switch
+ */
+struct local_class_queue {	
+	prio_array_t *active, *expired, arrays[2];
+	/*
+	  set to 0 on init, become null or array switch
+	  set to jiffies whenever an non-interactive job expires
+	  reset to jiffies if expires
+	 */
+	unsigned long expired_timestamp;
+	/*
+	  which class this queue belonging to
+	  assigned when created
+	 */
+	struct global_class_struct  * cl;
+	struct bpt_struct * bpt;
+
+	int nr_running;
+	/*
+	  the highest priority of the processes in the active queue
+	  undefined on init
+	  update whenever enqueue, dequeue
+	 */
+	int top_priority;
+
+	/*
+	  a snapshot of gCVT, update on every loadbalance 
+	 */
+	CVT_t lCVT;
+	unsigned long uncounted_cvt;
+
+	/*
+	  initialized to be 0, 
+	  update wheneve add/remove tasks
+	 */
+	unsigned long pressure;
+	/*
+	  initialized to be 1
+	  reinitialized after each sample
+	  ++ after each schedule add the ticks	  
+	 */
+	unsigned long ticks; //ticks updated at every sample
+	/*
+	  the cpu usage of this local queue (use moving average)
+	  sample every 2000ms
+	  initialized to be: CLASS_SAMPLE_RATE
+	  adjust after each sample:
+	  usage += tick;
+	  usage /= 2;
+	 */
+	unsigned long cpu_usage;
+  
+	cp_node_t ecp_queue;
+
+	long magic;
+};
+
+/*
+  manages the class status
+  there should be only one instance of this object for each class in
the whole system
+  
+ */
+struct global_class_struct {
+	/*assigned on creation*/
+	int class_id;
+	/*assigned on creation*/
+	char name[MAX_CLASS_NAME_LEN];
+	int weight;
+	atomic_t nr_member;
+
+	/* 
+	   initialied to be the min CVT when added to progress_tracker
+	   advances based on how much it has got
+	 */
+	CVT_t gCVT;
+        /* 
+	   protect the access to global CVT
+	   I don't protect the read access since a little bit in-accuracy is
fine
+	   However write access should be protected
+	*/
+	spinlock_t cvt_lock;
+
+	struct local_class_queue local_queues[NR_CPUS];	
+};
+
+/*
+   add/remove class should be very infrequent
+   so have a big class_list_lock shouldn't be a problem
+ */
+static spinlock_t class_list_lock = SPIN_LOCK_UNLOCKED;
+struct global_class_struct * system_classes[MAX_CLASS_NUM];
+
+/*
+  manage the max_CVT
+  update on update_gCVT
+ */
+static spinlock_t maxcvt_lock = SPIN_LOCK_UNLOCKED;
+static CVT_t max_CVT = 0;
+
+/*********************** FROM LINUX ********************/
+/*
+ * Adding/removing a task to/from a priority array:
+ */
+static inline void dequeue_task(struct task_struct *p, prio_array_t
*array)
+{
+	array->nr_active--;
+	list_del(&p->run_list);
+	if (list_empty(array->queue + p->prio))
+		__clear_bit(p->prio, array->bitmap);
+}
+
+static inline void enqueue_task(struct task_struct *p, prio_array_t
*array)
+{
+	list_add_tail(&p->run_list, array->queue + p->prio);
+	__set_bit(p->prio, array->bitmap);
+	array->nr_active++;
+	p->array = array;
+} 
+
+/****************** getter and setter *******************/
+/*
+Description:
+  initialize the local queue
+Status: test
+Sanity: should be fine since no body else will access it before it's
created
+ */
+static void init_local_queue(struct local_class_queue * queue,struct
global_class_struct * cl,int cpu_id) {
+	int j,k;      
+	prio_array_t *array; 	
+
+	queue->active = queue->arrays;
+	queue->expired = queue->arrays+1;
+
+	for (j = 0; j < 2; j++) {
+		array = queue->arrays + j;
+		for (k = 0; k < MAX_PRIO; k++) {
+			INIT_LIST_HEAD(array->queue + k);
+			__clear_bit(k, array->bitmap);
+		}
+		// delimiter for bitsearch
+		__set_bit(MAX_PRIO, array->bitmap);
+		array->nr_active = 0;
+	}
+
+	queue->expired_timestamp = 0;
+
+	queue->cl = cl;
+	queue->bpt = get_bpt(cpu_id);
+	queue->nr_running = 0;
+	queue->ecp_queue.parent = queue;
+	queue->ecp_queue.real_pos = -1;
+	queue->pressure = 0;
+	queue->ticks = 1;
+	queue->cpu_usage = CLASS_SAMPLE_RATE;//assume full usage on start
+	queue->lCVT = 0;
+	queue->uncounted_cvt = 0;
+	queue->magic = 0x43FF43D7;
+}
+
+/*
+Description:
+   create the class object
+   create the class queue object
+   add the class queue object to all the runqueues
+
+   if init==1, use boot_meme
+   if init==0, use kmalloc
+return:
+  return the class object on succeed
+  return NULL on error
+Status: test
+ */
+struct global_class_struct * __create_class(int class_id,char*
classname,int weight,int init) {
+	struct global_class_struct * cl;
+	int i;
+
+	if (system_classes[class_id]) {
+		debug_info1("class %d already exists\n",class_id);
+		return NULL;
+	}
+
+	if (init) {
+		ALLOC_MEM(cl,struct global_class_struct);
+	} else {
+		KERNEL_ALLOC_MEM(cl,struct global_class_struct);
+	}
+
+	if (! cl) {
+		warn("allocating memory for class structure failed\n");
+		return NULL;
+	}
+
+	cl->class_id = class_id;
+	cl->weight = weight;
+	cl->gCVT = 0;
+	cl->nr_member.counter = 0;
+	spin_lock_init(&cl->cvt_lock);
+	strcpy(cl->name,classname);
+
+	//create all the local runqueues
+
+	for (i=0; i< NR_CPUS; i++) {
+		init_local_queue(&(cl->local_queues[i]),cl,i);
+	}
+
+	system_classes[class_id] = cl;	
+	
+	return cl; //successful
+}
+
+inline struct global_class_struct * get_class(int class_id) {
+	return system_classes[class_id];
+}
+
+inline void class_add_member(int class_id) {
+	struct global_class_struct * cl = get_class(class_id);
+	atomic_inc(&cl->nr_member);
+}
+
+inline void class_remove_member(int class_id) {
+	struct global_class_struct * cl = get_class(class_id);
+	atomic_dec(&cl->nr_member);
+}
+
+/************************ Local Queue Status*************************/
+
+static void sample_local_queue(struct local_class_queue *  class_queue)
{
+	int tick = class_queue->ticks;
+	if (tick > CLASS_SAMPLE_RATE) tick = CLASS_SAMPLE_RATE;
+	class_queue->cpu_usage += tick;
+	class_queue->cpu_usage = class_queue->cpu_usage >> 1;
+	if (! class_queue->cpu_usage) class_queue->cpu_usage = 1;
+	class_queue->ticks = 1;
+}
+
+void sample_classes(int cpu) {
+	int i;
+	struct global_class_struct *cl;
+
+	for (i=0; i< MAX_CLASS_NUM;i++) {
+		cl = system_classes[i]; 
+		if (cl != NULL) {
+			sample_local_queue(&(cl->local_queues[cpu]));
+		}
+	}
+}
+
+inline struct local_class_queue* get_local_class_queue(int classid, int
cpu) {
+	return &(get_class(classid)->local_queues[cpu]);
+}
+
+static inline struct local_class_queue* get_process_class_queue(struct
task_struct* p) {
+	return &(get_class(p->classid)->local_queues[task_cpu(p)]);
+}
+
+void update_lCVT(struct task_struct * p, unsigned long dt) {	
+	struct local_class_queue* class_queue = get_process_class_queue(p);
+	struct global_class_struct * gc = class_queue->cl;
+
+	long long cvt_inc = (dt << CVT_ACCURACY)/gc->weight;
+
+	class_queue->lCVT += cvt_inc;
+	class_queue->ticks += dt;
+	class_queue->uncounted_cvt += cvt_inc;
+
+#ifdef __LAZY_CVT__
+	if (class_queue->nr_running) {
+		update_ecp_pos(class_queue,class_queue->bpt);	
+	}
+#else
+	update_gCVT(class_queue);
+#endif
+}
+
+/*
+  called before its switch out
+   update the VCT and reposition the queue of the class
+ */
+inline void update_gCVT(struct local_class_queue* class_queue) {	
+	struct global_class_struct * gc = class_queue->cl;
+	spin_lock(&gc->cvt_lock);
+	gc->gCVT += class_queue->uncounted_cvt;
+	spin_unlock(&gc->cvt_lock);
+
+	//task the snapshot
+	class_queue->lCVT = gc->gCVT;
+	class_queue->uncounted_cvt = 0;
+
+	//can be optimized to update only lCVT changes
+	if (class_queue->nr_running) {
+		update_ecp_pos(class_queue,class_queue->bpt);	
+	}
+
+
+	//update max_CVT
+	spin_lock(&maxcvt_lock);
+	if (gc->gCVT > max_CVT) {
+		max_CVT = gc->gCVT;
+	}
+	spin_unlock(&maxcvt_lock);
+}
+
+inline CVT_t* get_class_CVT(struct local_class_queue *  class_queue) {
+#ifdef __LAZY_CVT__
+	return &(class_queue->lCVT);
+#else
+	return &(class_queue->cl->gCVT);
+#endif
+}
+
+/*
+Description:
+   set the new top priority and reposition the queue
+Design:
+     
+ */
+static void set_top_priority(struct local_class_queue* class_queue, int
new_priority) {
+	class_queue->top_priority = new_priority;
+	update_ecp_pos(class_queue,class_queue->bpt);	
+}
+
+inline int get_class_priority(struct local_class_queue *  class_queue)
{
+	return class_queue->top_priority;
+}
+
+/*
+  get the job with the highest priority
+ */
+#define task_list_entry(list) list_entry(list,struct
task_struct,run_list)
+struct task_struct* get_first_job(struct local_class_queue * 
class_queue) {
+	prio_array_t *array = class_queue->active;
+	struct task_struct* p;
+	
+	if (! array->nr_active) return NULL;
+
+	/*
+	  top_priority should be valid here	  
+	 */
+	if (class_queue->top_priority >= MAX_PRIO) {
+		panic("magic=%x top_priority=%d active=%d nr_running=%d\n",(unsigned
int)class_queue->magic,class_queue->top_priority,array->nr_active,class_queue->nr_running);
+	}
+
+	p = task_list_entry(array->queue[class_queue->top_priority].next);	
+
+	return p;
+}
+
+
+/*
+Design:
+  if no more process in the active queue, then switch the active and
expired
+  reposition the local queue in the progress tracker
+Task:
+  
+ */
+static void check_classqueue_switch(struct local_class_queue* queue) {
+	if (! queue->active->nr_active && queue->expired->nr_active) {
+		prio_array_t *array;
+		int new_top;
+
+		//do switch
+		array = queue->active;
+		queue->active = queue->expired;
+		queue->expired = array;
+		queue->expired_timestamp = 0;
+		
+		//update top priority
+		new_top = find_first_bit(queue->active->bitmap, MAX_PRIO);
+		//find the new top priority
+//		assert (new_top <  MAX_PRIO);
+		set_top_priority(queue,new_top);
+	}
+}
+
+void check_queue_switch(struct task_struct *p) {
+//	struct local_class_queue* queue = get_process_class_queue(p);
+//	check_classqueue_switch(queue);
+}
+
+/*
+  check gCVT is valid here
+  a valid gCVT < max_CVT - WINDOW_SIZE
+  
+  update lCVT
+ */
+static void init_cvt(struct local_class_queue* class_queue) {
+	struct global_class_struct * gc = class_queue->cl;
+
+	CVT_t CVT = max_CVT - CVT_WINDOW_SIZE;
+
+//	CVT -= INTERACTIVE_ADVANCE/ queue->cl->weight;	
+//		debug_info3("class %d activated, old CVT= %llu new CVT= %llu
\n",queue->cl->class_id,queue->cl->CVT,CVT);
+
+	spin_lock(&gc->cvt_lock);	
+	if (gc->gCVT < CVT) {
+		gc->gCVT = CVT;
+	}
+	class_queue->lCVT = gc->gCVT;
+	spin_unlock(&gc->cvt_lock);	
+}
+/*
+Description:
+  add the process to the class queue
+  if active = 1, then to active array
+  else, to expired array
+Design:
+  get the queue 
+  enqueue the task based on it's priority (I use the weight as the
priority)  
+ */
+void enqueue_to_class(struct task_struct* p,int active) {
+	struct local_class_queue* queue = get_process_class_queue(p);
+
+
+	//debug
+//	printk("process %d added to class %d\n",p->pid,p->classid);
+	
+	queue->nr_running ++;	
+	if (queue->nr_running == 1) { //first job
+		active = 1; //always insert to active queue for the first job		
+		queue->top_priority = p->prio;
+
+		init_cvt(queue);
+		//add to cp and ecp queue
+		update_ecp_pos(queue,queue->bpt);
+	} else {
+		if (active && p->prio < queue->top_priority) {
+			set_top_priority(queue,p->prio);
+		}	
+	}
+
+	if (active) {
+		enqueue_task(p,queue->active);
+	} else {
+		enqueue_task(p,queue->expired);
+	}
+
+	queue->pressure += process_pressure(p);
+}
+
+/*
+  should switch between active and expired if no more process is active
+ */
+void dequeue_from_class(struct task_struct* p) {
+	struct local_class_queue* queue = get_process_class_queue(p);
+	int new_top;
+
+	assert(queue->nr_running);
+
+//	printk("process %d removed from class %d\n",p->pid,p->classid);
+
+	queue->nr_running --;
+	dequeue_task(p,p->array);
+
+	if (! queue->nr_running) { //last job deleted
+		remove_from_bpt(queue->bpt,queue);	       
+	} else {
+		if (queue->active->nr_active) {
+			if (p->prio == queue->top_priority &&
list_empty(&(queue->active->queue[p->prio]))) {
+				new_top = find_next_bit(queue->active->bitmap, MAX_PRIO,p->prio);
+//				assert (new_top < MAX_PRIO);
+
+				//find the new top priority
+				set_top_priority(queue,new_top);
+			}	
+		} else {
+			check_classqueue_switch(queue);
+		}
+	}
+
+	queue->pressure -= process_pressure(p);
+}
+
+/*
+  initialize the class structure
+
+  add the default class: class 0
+ */
+void init_classes() {
+	int i;
+	for (i=0; i< MAX_CLASS_NUM;i++) system_classes[i] = NULL;
+
+	init_bpts();
+
+	//create the default class
+	__create_class(0,"Default",100,1);
+}
+
+
+
+/*
+Design:
+  check if the task is in the active queue of it's class
+Status:
+  
+ */
+int is_task_active(struct task_struct* p) {
+	struct local_class_queue* queue = get_process_class_queue(p);	
+	return (p->array == queue->active);
+}
+
+
+
+/*
+ * We place interactive tasks back into the active array, if possible.
+ *
+ * To guarantee that this does not starve expired tasks we ignore the
+ * interactivity of a task if the first expired task had to wait more
+ * than a 'reasonable' amount of time. This deadline timeout is
+ * load-dependent, as the frequency of array switched decreases with
+ * increasing number of running tasks:
+ */
+#define STARVATION_LIMIT	(10*HZ)
+#define EXPIRED_STARVING(rq) \
+		(STARVATION_LIMIT && ((rq)->expired_timestamp && \
+		(jiffies - (rq)->expired_timestamp >= \
+			STARVATION_LIMIT * ((rq)->nr_running) + 1)))
+
+
+/*
+Description:
+  return 1 if treated as interactive, otherwise return 0
+Design:
+  reset expired_timestamp if necessary
+
+ */
+int check_interactive_starving(struct task_struct *p) {
+	struct local_class_queue* rq = get_process_class_queue(p);	
+
+	if (!task_interactive(p) || EXPIRED_STARVING(rq)) {
+
+		if (!rq->expired_timestamp)
+			rq->expired_timestamp = jiffies;
+		return 0;
+		
+	}
+	return 1;
+}
+
+/*
+Description:
+   find the process to migrate from the local class queue
+Design:
+Status:
+*/
+task_t * find_mp_from_class(struct local_class_queue* busiest,	 
+			    struct runqueue* busiest_runqueue,
+			    int imbalance) 
+	{
+	struct list_head *head, *curr;
+	task_t * tmp = NULL;
+	prio_array_t *array;
+	int idx;
+
+	if (busiest->expired->nr_active)
+		array = busiest->expired;
+	else
+		array = busiest->active;
+
+new_array:
+	idx = 0;
+skip_bitmap:
+	if (!idx)
+		idx = sched_find_first_bit(array->bitmap);
+	else
+		idx = find_next_bit(array->bitmap, MAX_PRIO, idx);
+	if (idx >= MAX_PRIO) {
+		if (array == busiest->expired) {
+			array = busiest->active;
+			goto new_array;
+		}
+		tmp = NULL; //no more
+		goto out_unlock;
+	}
+
+	head = array->queue + idx;
+	curr = head->prev;
+skip_queue:
+	tmp = list_entry(curr, task_t, run_list);
+
+	curr = curr->prev;
+	
+	if (! can_migrate_task(tmp,busiest_runqueue,smp_processor_id()) ||
(process_pressure(tmp) > 1.5 * imbalance ) ) {
+		if (curr != head)
+			goto skip_queue;
+		idx++;
+		goto skip_bitmap;
+	}
+ out_unlock:
+	return tmp;
+}
+
+inline cp_node_t * get_ecp_queue(struct local_class_queue * 
class_queue) {
+	return &class_queue->ecp_queue;
+}
+
+inline int get_class_running(struct local_class_queue *  class_queue) {
+	return class_queue->nr_running;
+}
+
+inline int get_class_weight(struct local_class_queue *  class_queue) {
+	return class_queue->cl->weight;
+}
+
+inline int get_class_id(struct local_class_queue *  class_queue) {
+	return class_queue->cl->class_id;
+}
+
+inline int get_local_queue_pressure(struct local_class_queue * queue) {
+	return queue->pressure * CLASS_SAMPLE_RATE / queue->cpu_usage;
+}
+
+/*
+  optimized
+ */
+inline int get_queue_pressure_byid(int class_id, int cpu) {
+	struct local_class_queue * queue =
&(system_classes[class_id]->local_queues[cpu]);
+	return queue->pressure * CLASS_SAMPLE_RATE / queue->cpu_usage;
+}
+
+
+/*
+  check if the pressure is different enough
+  if yes, find a task to migrate
+  should be called with both runqueue lock hold
+ */
+ struct task_struct * balance_local_queue(
+	 struct local_class_queue * busiest_queue,
+	 struct runqueue* busiest_runqueue,
+	 struct local_class_queue * this_queue) 
+{
+
+	struct task_struct * result = NULL;
+
+	int max_pressure, this_pressure;
+	int imbalance;
+	int ratio = CLASS_SAMPLE_RATE /busiest_queue->cpu_usage +
CLASS_SAMPLE_RATE/this_queue->cpu_usage; 
+
+	if (busiest_queue == this_queue) return NULL;
+
+	max_pressure = get_local_queue_pressure(busiest_queue);
+	this_pressure = get_local_queue_pressure(this_queue);
+
+	imbalance = (max_pressure - this_pressure)/ratio;
+
+	if (imbalance > 1000) {
+		//find the process
+		result =
find_mp_from_class(busiest_queue,busiest_runqueue,imbalance);
+	}
+	
+	return result;
+}
+
+/*************************** code for proc file
system*******************/
+/*
+  should I allow change the class of the current process?
+  I will think of it later
+ */
+long set_class(int pid, int class_id) {
+	struct task_struct * p = NULL;
+
+	if (pid == 0) {
+		p = current;
+	} else {
+		p = find_task_by_pid(pid);
+	}
+
+	if (! p) {
+		return -1;
+	}
+
+	if (! system_classes[class_id]) {
+		return -2;
+	}
+
+	/*
+	  well, the process will remain in the same cpu
+	  but on different local runqueue
+	  I should grab the per-process task_list lock before I go ahead
+	 */
+	unsigned long flags;
+
+	class_add_member(class_id);
+	class_remove_member(p->classid);
+
+	struct runqueue * rq =  task_rq_lock(p,&flags); 
+	if (p->array) {
+		dequeue_from_class(p);
+		p->classid = class_id;
+		enqueue_to_class(p,1);
+	} else {
+		p->classid = class_id;
+	}
+	task_rq_unlock(rq,&flags);
+	
+	return 0;
+}
+
+
+/*
+  return all the classes
+ */
+int get_classes_list(char * buf) {
+	int len = 0;
+	int class_id = 0;
+	struct global_class_struct * cl;
+
+
+	while (class_id < MAX_CLASS_NUM && len < PAGE_SIZE - 80) {
+		cl = get_class(class_id);
+		if (cl) {
+			len += sprintf(buf+len, "%d %s\t%d %llu %d\n",
+				       cl->class_id,cl->name,cl->weight,
+				       cl->gCVT,cl->local_queues[0].nr_running				       
+				);
+		}
+		class_id ++;
+	}
+	return len;
+}
+
+
+static void *classes_start(struct seq_file *m, loff_t *pos)
+{
+	loff_t n = *pos;
+
+	if (!n) {
+		/*
+		 * Output format version
+		 */
+		seq_puts(m, "#classinfo - version: 1.0\n");
+		seq_puts(m, "#output format: class_id class_name weight CVT
nr_running\n");
+		seq_puts(m, "#input format: \n");
+		seq_puts(m, "# (add class): 1 classid weight name\n");
+		seq_puts(m, "# (set class): 2 classid pid 0\n");
+		seq_putc(m, '\n');
+	}
+
+	if (n) return NULL;
+	else return (void *) 1;
+}
+
+static void *classes_next(struct seq_file *m, void *arg, loff_t *pos)
+{	
+	return NULL;
+}
+
+static int classes_show(struct seq_file *m, void *arg)
+{
+	int class_id = 0;
+	struct global_class_struct * cl;
+
+
+	while (class_id < MAX_CLASS_NUM) {
+		cl = get_class(class_id);
+		if (cl) {
+			seq_printf(m, "%d %s\t%d %llu %d\n",
+				       cl->class_id,cl->name,cl->weight,
+				       cl->gCVT,cl->local_queues[0].nr_running				       
+				);
+		}
+		class_id ++;
+	}
+	return 0;
+}
+
+static void classes_stop(struct seq_file *m, void *arg)
+{
+//	kfree(arg);
+}
+
+struct seq_operations classes_op = {
+	.start	= classes_start,
+	.next	= classes_next,
+	.stop	= classes_stop,
+	.show	= classes_show,
+};
+
+#define MAX_CLASSES_WRITE 64
+#define MAX_CLASSNAME_LEN 20
+/**
+ * classes_write - update classes setting
+ * @file: unused
+ * @buffer: user buffer
+ * @count: data len
+ * @data: unused
+ */
+ssize_t classes_write(struct file *file, const char __user *buffer,
+				size_t count, loff_t *ppos)
+{
+	char kbuf[MAX_CLASSES_WRITE+1];
+	char name[MAX_CLASSNAME_LEN];
+	int classid,weight;
+	int cmd;
+	
+	if (count > MAX_CLASSES_WRITE)
+		return -EINVAL;
+	if (copy_from_user(&kbuf, buffer, count))
+		return -EFAULT;
+	kbuf[MAX_CLASSES_WRITE] = '\0'; 
+
+	if (sscanf(kbuf, "%d %d %d %s", &cmd, &classid, &weight, name) != 4)
+		return -EINVAL;
+
+	if (cmd == 1) {
+		__create_class(classid,name,weight,0);
+		return 0;
+	} 
+
+	if (cmd == 2) {
+		set_class(weight, classid);
+	}
+
+	return -1;
+}
+
+
+/*************************** Interface to CKRM *********************/
+#define ckrm_cpu_class global_class_struct
+
+/*
+  return the first empty slot
+  return -1 if not found
+ */
+static int get_unique_classid(void) {
+	int class_id;
+
+	spin_lock(&class_list_lock);
+	for (class_id = 1; class_id < MAX_CLASS_NUM; class_id ++) {
+		if (system_classes[class_id]) break;
+	}
+
+	if (class_id == MAX_CLASS_NUM) class_id = -1;
+	spin_unlock(&class_list_lock);
+
+	return class_id;	
+}
+
+/*
+   create a default object
+   status: test
+ */
+struct ckrm_cpu_class *ckrm_alloc_cpu_class(void *obj) {		
+	int class_id = get_unique_classid();
+        static int DEFAULT_CLASS_WEIGHT = 100;
+
+	if (class_id < 0) return NULL;
+	return __create_class(class_id,"ckrm_class",DEFAULT_CLASS_WEIGHT,0);		
+}		
+		
+/*
+  can't remove the default class
+  can't remove the class if there still exist processes associated with
it
+  
+  if the class object is already stand alone, simply remove it
+ */						
+int ckrm_free_cpu_class(struct ckrm_cpu_class *cls) {			
+	//can't remove default class
+	if (cls->class_id == 0) return -1;
+
+	//can't remove non-empty class, but no checking at this time
+
+	spin_lock(&class_list_lock);
+	system_classes[cls->class_id] = NULL;	
+	kfree(cls);
+	spin_unlock(&class_list_lock);
+
+        return 0;		
+}				
+			
+/*
+   the system will adjust to the new share automatically  
+ */			
+int ckrm_cpu_set_share(struct ckrm_cpu_class *cls, ulong share) {	
+	cls->weight = share;							
+	return 0;								
+}							
+			
+/*
+  translate the gCVT to ticks
+ */
+ulong ckrm_cpu_get_usage(struct ckrm_cpu_class *cls) {			
+	long long ticks = cls->gCVT * cls->weight;
+	ticks >>= CVT_ACCURACY;
+
+	return (ulong)ticks;							
+}				
+
+/*
+status: ok
+ */						
+struct ckrm_cpu_class *ckrm_dflt_cpu_class(void *obj) {			
+	return get_class(0);
+}		
+								
+void ckrm_cpu_change_class(struct task_struct *tsk,				
+                               struct ckrm_cpu_class *cls) {		
+	set_class(tsk->pid,cls->class_id);
+        tsk->cpu_class = cls;
+}							
+			
+EXPORT_SYMBOL(ckrm_alloc_cpu_class);					
+EXPORT_SYMBOL(ckrm_free_cpu_class);						
+EXPORT_SYMBOL(ckrm_cpu_set_share);						
+EXPORT_SYMBOL(ckrm_cpu_get_usage);					
+EXPORT_SYMBOL(ckrm_dflt_cpu_class);
diff -Nru a/kernel/exit.c b/kernel/exit.c
--- a/kernel/exit.c	Fri Aug 29 14:49:47 2003
+++ b/kernel/exit.c	Fri Aug 29 14:49:47 2003
@@ -28,6 +28,8 @@
 #include <asm/pgtable.h>
 #include <asm/mmu_context.h>
 
+#include <linux/class.h>
+
 extern void sem_exit (void);
 extern struct task_struct *child_reaper;
 
@@ -722,6 +724,9 @@
 
 	tsk->exit_code = code;
 	exit_notify(tsk);
+
+	class_remove_member(tsk->classid);
+
 
 	if (tsk->exit_signal == -1 && tsk->ptrace == 0)
 		release_task(tsk);
diff -Nru a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c	Fri Aug 29 14:49:47 2003
+++ b/kernel/fork.c	Fri Aug 29 14:49:47 2003
@@ -39,6 +39,9 @@
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
+#include <linux/class.h>
+
+
 extern int copy_semundo(unsigned long clone_flags, struct task_struct
*tsk);
 extern void exit_sem(struct task_struct *tsk);
 
@@ -1079,6 +1082,8 @@
 			p->vfork_done = &vfork;
 			init_completion(&vfork);
 		}
+
+		class_add_member(p->classid);
 
 		if ((p->ptrace & PT_PTRACED) || (clone_flags & CLONE_STOPPED)) {
 			/*
diff -Nru a/kernel/progress.c b/kernel/progress.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/kernel/progress.c	Fri Aug 29 14:49:47 2003
@@ -0,0 +1,140 @@
+/* kernel/progress.c : cpu control for CKRM
+ *
+ * Copyright (C) Haoqiang Zheng, IBM Corp. 2003
+ *           (C) Hubertus Franke, IBM Corp. 2003
+ * 
+ * Helper functions for cpu controller for CKRM
+ *
+ * Latest version, more details at http://ckrm.sf.net
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+/* Changes
+ *
+ * 28 Aug 2003
+ *        Created.
+ */
+
+#include <linux/progress.h>
+#include <linux/class.h>
+#include <linux/circularqueue.h>
+#include <linux/list.h>
+
+
+/*
+Description:
+    biased progress tracker: 
+    -- keep track of the relative progress of each class
+    -- biased based on the highest priority of the processes in the
class (class urgency)
+    
+    one track for each processor
+    
+    all the class starts at the same positon
+    if a class consumed t tickes, the CVT is updated, (CVT_i -
CVT_min)*c becomes the new CP,then bias with the p->prio and reinsert to
the new queue
+    
+    the scheduler always pick the top process from the class that is at
the end of the progress queue
+ */
+
+struct bpt_struct {
+	struct circularqueue_struct* ecp_queue;
+	int cpu;
+};
+
+static struct bpt_struct bpts[NR_CPUS];
+
+//safe
+inline struct bpt_struct* get_bpt(int cpu_id) {
+	return &bpts[cpu_id];
+}
+
+/*
+Design:
+   return the first job in the ecp queue
+Sanity: not sure
+  when I got here, I am holding the rq->lock
+ */
+struct task_struct * get_CF_next(struct bpt_struct* bpt,struct
task_struct* prev) {
+	cp_node_t * node = get_first_element(bpt->ecp_queue);
+	struct local_class_queue * class_queue;
+	struct task_struct * p = NULL;
+
+	if (node) {
+		//we have got the class
+		class_queue = (struct local_class_queue *)node->parent;
+		p = get_first_job(class_queue);
+
+	}
+
+	return p;
+}
+
+static inline int get_ECP(struct local_class_queue* class_queue, struct
bpt_struct* bpt) {
+	int cp = (* get_class_CVT(class_queue)) >> CLASS_BONUS_RATE;
+	int ecp = cp + (get_class_priority(class_queue) >>
PRIORITY_BONUS_RATE);
+	return ecp;
+}
+
+void update_ecp_pos(struct local_class_queue* class_queue, struct
bpt_struct* bpt) {	
+	int ecp;
+
+	if (! get_class_running(class_queue)) {
+		assert(0);
+	}
+	ecp = get_ECP(class_queue,bpt);
+	adjust_cq_pos(bpt->ecp_queue,get_ecp_queue(class_queue),ecp);	
+}
+
+
+/*
+  remove a class_queue from bpt
+ */
+inline void remove_from_bpt(struct bpt_struct* bpt,struct
local_class_queue* class_queue) {
+	removefrom_circular_queue(bpt->ecp_queue,get_ecp_queue(class_queue));	
+}
+
+/*
+  look over all the local classes in bpt queue
+
+  return the process to be migrated
+  
+ */
+task_t * find_mp_from_bpt(struct bpt_struct* bpt,struct runqueue*
busiest_runqueue,int imbalance) {
+	task_t* result = NULL;
+	int last_pos = -1;
+	cp_node_t * last_node;
+	struct local_class_queue * class_queue;
+
+	do {
+		get_next_element(bpt->ecp_queue,&last_pos,&last_node);		
+		if (last_node) {		
+			class_queue = (struct local_class_queue *)last_node->parent;
+			result = find_mp_from_class(class_queue,busiest_runqueue,imbalance);
+		}
+	} while ( !result && (last_node != NULL) );
+
+	if (result) {
+		assert(task_cpu(result) == bpt->cpu);
+	}
+
+	return result;
+}
+
+
+/*
+Design:
+  initialize the per cpu bpt 
+Status: test
+ */
+void init_bpts(void) {
+	int i;	
+
+	for (i=0; i < NR_CPUS; i++) {
+		bpts[i].ecp_queue= create_circular_queue(BPT_QUEUE_SIZE); 
+		bpts[i].cpu = i;
+	}
+}
diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Fri Aug 29 14:49:47 2003
+++ b/kernel/sched.c	Fri Aug 29 14:49:47 2003
@@ -41,6 +41,9 @@
 #define cpu_to_node_mask(cpu) (cpu_online_map)
 #endif
 
+#include <linux/class.h>
+#include <linux/progress.h>
+
 /*
  * Convert user-nice values [ -20 ... 0 ... 19 ]
  * to static priority [ MAX_RT_PRIO..MAX_PRIO-1 ],
@@ -129,7 +132,7 @@
 #define BASE_TIMESLICE(p) (MIN_TIMESLICE + \
 	((MAX_TIMESLICE - MIN_TIMESLICE) *
(MAX_PRIO-1-(p)->static_prio)/(MAX_USER_PRIO - 1)))
 
-static inline unsigned int task_timeslice(task_t *p)
+inline unsigned int task_timeslice(task_t *p)
 {
 	return BASE_TIMESLICE(p);
 }
@@ -138,15 +141,12 @@
  * These are the runqueue data structures:
  */
 
-#define BITMAP_SIZE ((((MAX_PRIO+1+7)/8)+sizeof(long)-1)/sizeof(long))
+
 
 typedef struct runqueue runqueue_t;
 
-struct prio_array {
-	int nr_active;
-	unsigned long bitmap[BITMAP_SIZE];
-	struct list_head queue[MAX_PRIO];
-};
+struct prio_array;
+
 
 /*
  * This is the main, per-CPU runqueue data structure.
@@ -157,11 +157,11 @@
  */
 struct runqueue {
 	spinlock_t lock;
-	unsigned long nr_running, nr_switches, expired_timestamp,
-			nr_uninterruptible;
+	unsigned long nr_running, nr_switches,nr_uninterruptible;
+	unsigned long switch_timestamp; //set at every time switch
 	task_t *curr, *idle;
 	struct mm_struct *prev_mm;
-	prio_array_t *active, *expired, arrays[2];
+
 	int prev_cpu_load[NR_CPUS];
 #ifdef CONFIG_NUMA
 	atomic_t *node_nr_running;
@@ -169,6 +169,7 @@
 #endif
 	task_t *migration_thread;
 	struct list_head migration_queue;
+	struct bpt_struct* bpt;
 
 	atomic_t nr_iowait;
 };
@@ -240,7 +241,7 @@
  * interrupts.  Note the ordering: we can safely lookup the task_rq
without
  * explicitly disabling preemption.
  */
-static inline runqueue_t *task_rq_lock(task_t *p, unsigned long *flags)
+inline runqueue_t *task_rq_lock(task_t *p, unsigned long *flags)
 {
 	struct runqueue *rq;
 
@@ -255,7 +256,7 @@
 	return rq;
 }
 
-static inline void task_rq_unlock(runqueue_t *rq, unsigned long *flags)
+inline void task_rq_unlock(runqueue_t *rq, unsigned long *flags)
 {
 	spin_unlock_irqrestore(&rq->lock, *flags);
 }
@@ -280,25 +281,6 @@
 }
 
 /*
- * Adding/removing a task to/from a priority array:
- */
-static inline void dequeue_task(struct task_struct *p, prio_array_t
*array)
-{
-	array->nr_active--;
-	list_del(&p->run_list);
-	if (list_empty(array->queue + p->prio))
-		__clear_bit(p->prio, array->bitmap);
-}
-
-static inline void enqueue_task(struct task_struct *p, prio_array_t
*array)
-{
-	list_add_tail(&p->run_list, array->queue + p->prio);
-	__set_bit(p->prio, array->bitmap);
-	array->nr_active++;
-	p->array = array;
-}
-
-/*
  * effective_prio - return the priority that is based on the static
  * priority but is modified by bonuses/penalties.
  *
@@ -335,7 +317,9 @@
  */
 static inline void __activate_task(task_t *p, runqueue_t *rq)
 {
-	enqueue_task(p, rq->active);
+
+	enqueue_to_class(p,1);		
+
 	nr_running_inc(rq);
 }
 
@@ -386,7 +370,10 @@
 	nr_running_dec(rq);
 	if (p->state == TASK_UNINTERRUPTIBLE)
 		rq->nr_uninterruptible++;
-	dequeue_task(p, p->array);
+
+
+	dequeue_from_class(p);		
+
 	p->array = NULL;
 }
 
@@ -559,10 +546,7 @@
 		__activate_task(p, rq);
 	else {
 		p->prio = current->prio;
-		list_add_tail(&p->run_list, &current->run_list);
-		p->array = current->array;
-		p->array->nr_active++;
-		nr_running_inc(rq);
+		__activate_task(p, rq);
 	}
 	task_rq_unlock(rq, &flags);
 }
@@ -967,13 +951,17 @@
  * pull_task - move a task from a remote runqueue to the local
runqueue.
  * Both runqueues must be locked.
  */
-static inline void pull_task(runqueue_t *src_rq, prio_array_t
*src_array, task_t *p, runqueue_t *this_rq, int this_cpu)
+static inline void pull_task(runqueue_t *src_rq,task_t *p, runqueue_t
*this_rq, int this_cpu)
 {
-	dequeue_task(p, src_array);
+	dequeue_from_class(p);
+
 	nr_running_dec(src_rq);
+
+	check_queue_switch(p);
+	
 	set_task_cpu(p, this_cpu);
 	nr_running_inc(this_rq);
-	enqueue_task(p, this_rq->active);
+	enqueue_to_class(p, 1);
 	/*
 	 * Note that idle threads have a prio of MAX_PRIO, for this test
 	 * to be always true for them.
@@ -987,89 +975,80 @@
 	}
 }
 
-/*
- * Current runqueue is empty, or rebalance tick: if there is an
- * inbalance (current runqueue is too short) then pull from
- * busiest runqueue(s).
- *
- * We call this with the current runqueue locked,
- * irqs disabled.
- */
-static void load_balance(runqueue_t *this_rq, int idle, unsigned long
cpumask)
-{
-	int imbalance, idx, this_cpu = smp_processor_id();
+static void class_load_balance(runqueue_t *this_rq, int idle) {
+	int max_pressure,pressure;
+	int class_id;
+	struct local_class_queue *busiest_queue= NULL,*this_queue=NULL;
+	int cpu,this_cpu = smp_processor_id(),busiest_cpu;
+	struct task_struct * tmp;
 	runqueue_t *busiest;
-	prio_array_t *array;
-	struct list_head *head, *curr;
-	task_t *tmp;
+	
 
-	busiest = find_busiest_queue(this_rq, this_cpu, idle, &imbalance,
cpumask);
-	if (!busiest)
-		goto out;
+	//for all classes
+	for (class_id=0; class_id< MAX_CLASS_NUM;class_id++) {
+		if (! get_class(class_id)) continue;
 
-	/*
-	 * We first consider expired tasks. Those will likely not be
-	 * executed in the near future, and they are most likely to
-	 * be cache-cold, thus switching CPUs has the least effect
-	 * on them.
-	 */
-	if (busiest->expired->nr_active)
-		array = busiest->expired;
-	else
-		array = busiest->active;
+		max_pressure = -1;
+		busiest_cpu = -1;
 
-new_array:
-	/* Start searching at priority 0: */
-	idx = 0;
-skip_bitmap:
-	if (!idx)
-		idx = sched_find_first_bit(array->bitmap);
-	else
-		idx = find_next_bit(array->bitmap, MAX_PRIO, idx);
-	if (idx >= MAX_PRIO) {
-		if (array == busiest->expired) {
-			array = busiest->active;
-			goto new_array;
+		/*
+		  check all local queues belonging to a certain class
+		  get the busiest queue		
+		  
+		  special care need to be taken since during this process
+		  -- queue pressure can change
+		  -- the queue might not be active anymore
+		  so need to double lock if find it
+		 */
+		for (cpu=0; cpu < NR_CPUS; cpu ++) {			
+			if (!cpu_online(cpu) )
+				continue;
+
+			pressure = get_queue_pressure_byid(class_id,cpu);
+			if (pressure > max_pressure) {
+				busiest_cpu = cpu;
+				max_pressure = pressure;
+			}
 		}
-		goto out_unlock;
-	}
 
-	head = array->queue + idx;
-	curr = head->prev;
-skip_queue:
-	tmp = list_entry(curr, task_t, run_list);
+		if (busiest_cpu > 0 && busiest_cpu != this_cpu) {
+			busiest = cpu_rq(busiest_cpu);	
+			busiest_queue = 
+				get_local_class_queue(class_id,busiest_cpu);
+			this_queue = get_local_class_queue(class_id,this_cpu);
+
+			//lock the queue
+			double_lock_balance(this_rq, busiest, this_cpu, idle,0);
+
+			do {
+				tmp =  balance_local_queue(busiest_queue,busiest,this_queue);
+				
+				if ( tmp) {
+					pull_task(busiest, tmp, this_rq, this_cpu);
+				}
+			} while (tmp);
 
-	/*
-	 * We do not migrate tasks that are:
-	 * 1) running (obviously), or
-	 * 2) cannot be migrated to this CPU due to cpus_allowed, or
-	 * 3) are cache-hot on their current CPU.
-	 */
+			//assume the busiest is locked
+			spin_unlock(&busiest->lock);	
+		}
+	}	
+}
 
-#define CAN_MIGRATE_TASK(p,rq,this_cpu)					\
-	((!idle || (jiffies - (p)->last_run > cache_decay_ticks)) &&	\
-		!task_running(rq, p) &&					\
-			((p)->cpus_allowed & (1UL << (this_cpu))))
+static void load_balance(runqueue_t *this_rq, int idle, unsigned long
cpumask) {
+	struct local_class_queue* class_queue;
+	int class_id;
+	int this_cpu = smp_processor_id();
 
-	curr = curr->prev;
+	//update gCVT on every load balance
+	for (class_id=0; class_id < MAX_CLASS_NUM; class_id++) {
+		if (! get_class(class_id)) continue;
 
-	if (!CAN_MIGRATE_TASK(tmp, busiest, this_cpu)) {
-		if (curr != head)
-			goto skip_queue;
-		idx++;
-		goto skip_bitmap;
-	}
-	pull_task(busiest, array, tmp, this_rq, this_cpu);
-	if (!idle && --imbalance) {
-		if (curr != head)
-			goto skip_queue;
-		idx++;
-		goto skip_bitmap;
+		class_queue = get_local_class_queue(class_id,this_cpu);
+		update_gCVT(class_queue);
 	}
-out_unlock:
-	spin_unlock(&busiest->lock);
-out:
-	;
+
+
+	class_load_balance(this_rq,idle);
 }
 
 /*
@@ -1162,10 +1141,6 @@
  * load-dependent, as the frequency of array switched decreases with
  * increasing number of running tasks:
  */
-#define EXPIRED_STARVING(rq) \
-		(STARVATION_LIMIT && ((rq)->expired_timestamp && \
-		(jiffies - (rq)->expired_timestamp >= \
-			STARVATION_LIMIT * ((rq)->nr_running) + 1)))
 
 /*
  * This function gets called by the timer code, with HZ frequency.
@@ -1184,6 +1159,11 @@
 	if (rcu_pending(cpu))
 		rcu_check_callbacks(cpu, user_ticks);
 
+	if (jiffies % CLASS_SAMPLE_RATE == 0) {
+		//sample all the classes of this cpu
+		sample_classes(cpu);
+	}
+
 	if (p == rq->idle) {
 		/* note: this timer irq context must be accounted for as well */
 		if (irq_count() - HARDIRQ_OFFSET >= SOFTIRQ_OFFSET)
@@ -1202,7 +1182,7 @@
 	cpustat->system += sys_ticks;
 
 	/* Task might have expired already, but not scheduled off yet */
-	if (p->array != rq->active) {
+	if (! is_task_active(p)) {
 		set_tsk_need_resched(p);
 		goto out;
 	}
@@ -1228,24 +1208,23 @@
 			set_tsk_need_resched(p);
 
 			/* put it at the end of the queue: */
-			dequeue_task(p, rq->active);
-			enqueue_task(p, rq->active);
+			dequeue_from_class(p);
+			enqueue_to_class(p,1);
 		}
 		goto out_unlock;
 	}
 	if (!--p->time_slice) {
-		dequeue_task(p, rq->active);
+		dequeue_from_class(p);
 		set_tsk_need_resched(p);
 		p->prio = effective_prio(p);
 		p->time_slice = task_timeslice(p);
 		p->first_time_slice = 0;
 
-		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
-			if (!rq->expired_timestamp)
-				rq->expired_timestamp = jiffies;
-			enqueue_task(p, rq->expired);
-		} else
-			enqueue_task(p, rq->active);
+		if (check_interactive_starving(p)) {
+			enqueue_to_class(p, 1);//treated as interactive task			
+		} else {
+			enqueue_to_class(p, 0);
+		}
 	}
 out_unlock:
 	spin_unlock(&rq->lock);
@@ -1262,9 +1241,6 @@
 {
 	task_t *prev, *next;
 	runqueue_t *rq;
-	prio_array_t *array;
-	struct list_head *queue;
-	int idx;
 
 	/*
 	 * Test if we are atomic.  Since do_exit() needs to call into
@@ -1313,28 +1289,28 @@
 			goto pick_next_task;
 #endif
 		next = rq->idle;
-		rq->expired_timestamp = 0;
 		goto switch_tasks;
 	}
 
-	array = rq->active;
-	if (unlikely(!array->nr_active)) {
-		/*
-		 * Switch the active and expired arrays.
-		 */
-		rq->active = rq->expired;
-		rq->expired = array;
-		array = rq->active;
-		rq->expired_timestamp = 0;
+	check_queue_switch(prev);
+
+	next = get_CF_next(rq->bpt,prev);
+	
+	if (!next) {
+		next = rq->idle;
 	}
 
-	idx = sched_find_first_bit(array->bitmap);
-	queue = array->queue + idx;
-	next = list_entry(queue->next, task_t, run_list);
 
 switch_tasks:
 	prefetch(next);
 	clear_tsk_need_resched(prev);
+
+	if (prev != rq->idle) {
+		update_lCVT(prev, jiffies - rq->switch_timestamp);
+	}
+	rq->switch_timestamp = jiffies;
+
+
 	RCU_qsctr(task_cpu(prev))++;
 
 	if (likely(prev != next)) {
@@ -1590,12 +1566,14 @@
 		goto out_unlock;
 	}
 	array = p->array;
-	if (array)
-		dequeue_task(p, array);
+	if (array) {
+		dequeue_from_class(p);
+	}
+
 	p->static_prio = NICE_TO_PRIO(nice);
 	p->prio = NICE_TO_PRIO(nice);
-	if (array) {
-		enqueue_task(p, array);
+	if (array) { 
+		enqueue_to_class(p, 1);
 		/*
 		 * If the task is running and lowered its priority,
 		 * or increased its priority then reschedule its CPU:
@@ -1985,7 +1963,6 @@
 asmlinkage long sys_sched_yield(void)
 {
 	runqueue_t *rq = this_rq_lock();
-	prio_array_t *array = current->array;
 
 	/*
 	 * We implement yielding by moving the task into the expired
@@ -1995,11 +1972,11 @@
 	 *  array.)
 	 */
 	if (likely(!rt_task(current))) {
-		dequeue_task(current, array);
-		enqueue_task(current, rq->expired);
+		dequeue_from_class(current);
+		enqueue_to_class(current,0);
 	} else {
-		list_del(&current->run_list);
-		list_add_tail(&current->run_list, array->queue + current->prio);
+		dequeue_from_class(current);
+		enqueue_to_class(current,1);
 	}
 	/*
 	 * Since we are going to call schedule() anyway, there's
@@ -2489,21 +2466,22 @@
 void __init sched_init(void)
 {
 	runqueue_t *rq;
-	int i, j, k;
+	int i;
 
 	/* Init the kstat counters */
 	init_kstat();
+	init_classes(); //initialize all the classes
+
 	for (i = 0; i < NR_CPUS; i++) {
-		prio_array_t *array;
 
 		rq = cpu_rq(i);
-		rq->active = rq->arrays;
-		rq->expired = rq->arrays + 1;
 		spin_lock_init(&rq->lock);
 		INIT_LIST_HEAD(&rq->migration_queue);
 		atomic_set(&rq->nr_iowait, 0);
 		nr_running_init(rq);
+		rq->bpt = get_bpt(i);
 
+/*
 		for (j = 0; j < 2; j++) {
 			array = rq->arrays + j;
 			for (k = 0; k < MAX_PRIO; k++) {
@@ -2513,6 +2491,7 @@
 			// delimiter for bitsearch
 			__set_bit(MAX_PRIO, array->bitmap);
 		}
+*/
 	}
 	/*
 	 * We have to do a little magic to get the first
@@ -2520,8 +2499,9 @@
 	 */
 	rq = this_rq();
 	rq->curr = current;
-	rq->idle = current;
-	set_task_cpu(current, smp_processor_id());
+	rq->idle = current;	
+	set_task_cpu(current, smp_processor_id());       
+
 	wake_up_forked_process(current);
 
 	init_timers();
@@ -2592,3 +2572,30 @@
 	} while (!_raw_write_trylock(lock));
 }
 #endif
+
+
+struct task_struct * get_idle_task(int cpu) {
+        runqueue_t *idle_rq = cpu_rq(cpu);
+
+        if (idle_rq) {
+                return idle_rq->idle;
+        }
+        return NULL;
+}
+
+int task_interactive(struct task_struct * p) {
+	return TASK_INTERACTIVE(p);
+}
+
+#define CAN_MIGRATE_TASK(p,rq,this_cpu)					\
+	((jiffies - (p)->last_run > cache_decay_ticks) &&	\
+		!task_running(rq, p) &&					\
+			((p)->cpus_allowed & (1UL << (this_cpu))))
+
+int can_migrate_task(struct task_struct * p,runqueue_t *rq,int
this_cpu) {
+	return CAN_MIGRATE_TASK(p,rq,this_cpu);
+}
+
+inline struct runqueue * get_cpu_rq(int cpu) {
+	return cpu_rq(cpu);
+}



