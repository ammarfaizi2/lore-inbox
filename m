Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262380AbTA2B7s>; Tue, 28 Jan 2003 20:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262394AbTA2B7s>; Tue, 28 Jan 2003 20:59:48 -0500
Received: from fmr05.intel.com ([134.134.136.6]:23794 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S262380AbTA2B7X>; Tue, 28 Jan 2003 20:59:23 -0500
Message-ID: <15927.14127.261752.943121@milikk.co.intel.com>
Date: Tue, 28 Jan 2003 18:06:39 -0800
From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: [PATCH 2.5.59] prioarray-1.0: Priority arrays as a separate data structure
To: linux-kernel@vger.kernel.org, mingo@redhat.com, pwaechtler@mac.com,
       rusty@rustcorp.com.au
X-Mailer: VM 7.07 under Emacs 21.2.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This patch extracts some of the stuff that Ingo uses for the O(1)
scheduler and makes it avalable in linux/prioarray.h, so that it
can be used by other parts of the kernel. 

It's main use right now is by the pfutex patch, that implements
priority based futexes.

Caveats:

 - Ugly kludge in sched.h to include prioarray.h ... 

Enjoy

This patch requires linux-2.5.59 

diff -u /dev/null linux/include/linux/prioarray.h:1.1.2.1
--- /dev/null	Tue Jan 28 17:37:07 2003
+++ linux/include/linux/prioarray.h	Wed Dec 11 12:44:33 2002
@@ -0,0 +1,57 @@
+/*
+ * O(1) priority arrays
+ *
+ * Modified from code (C) 2002 Ingo Molnar <mingo@redhat.com> in
+ * sched.c by Iñaky Pérez-González <inaky.perez-gonzalez@intel.com> so
+ * that other parts of the kernel can use the same constructs.
+ */
+
+#ifndef _LINUX_PRIOARRAY_
+#define _LINUX_PRIOARRAY_
+
+        /* This inclusion is kind of recursive ... hmmm */
+
+#include <linux/sched.h>
+
+struct prio_array {
+	int nr_active;
+	unsigned long bitmap[BITMAP_SIZE];
+	struct list_head queue[MAX_PRIO];
+};
+
+typedef struct prio_array prio_array_t;
+
+static inline
+void pa_init (prio_array_t *array)
+{
+        unsigned cnt;
+	array->nr_active = 0;
+        memset (array->bitmap, 0, sizeof (array->bitmap));
+        for (cnt = 0; cnt < MAX_PRIO; cnt++)
+                INIT_LIST_HEAD (&array->queue[cnt]);
+}
+
+/*
+ * Adding/removing a node to/from a priority array:
+ */
+
+static inline
+void pa_dequeue (struct list_head *p, unsigned prio, prio_array_t *array)
+{
+	array->nr_active--;
+	list_del(p);
+	if (list_empty(array->queue + prio))
+		__clear_bit(prio, array->bitmap);
+}
+
+static inline
+void pa_enqueue (struct list_head *p, unsigned prio, prio_array_t *array)
+{
+	list_add_tail(p, array->queue + prio);
+	__set_bit(prio, array->bitmap);
+	array->nr_active++;
+}
+
+
+
+#endif /* #ifndef _LINUX_PRIOARRAY_ */
diff -u linux/include/linux/sched.h:1.1.1.13 linux/include/linux/sched.h:1.1.1.1.2.7
--- linux/include/linux/sched.h:1.1.1.13	Thu Jan 16 18:56:22 2003
+++ linux/include/linux/sched.h	Fri Jan 24 20:00:58 2003
@@ -252,6 +252,9 @@
 #define MAX_RT_PRIO		MAX_USER_RT_PRIO
 
 #define MAX_PRIO		(MAX_RT_PRIO + 40)
+#define BITMAP_SIZE ((((MAX_PRIO+1+7)/8)+sizeof(long)-1)/sizeof(long))
+
+#include <linux/prioarray.h> /* Okay, this is ugly, but needs MAX_PRIO */
  
 /*
  * Some day this will be a full-fledged user tracking system..
@@ -276,7 +279,6 @@
 extern struct user_struct root_user;
 #define INIT_USER (&root_user)
 
-typedef struct prio_array prio_array_t;
 struct backing_dev_info;
 
 struct task_struct {
diff -u linux/kernel/sched.c:1.1.1.10 linux/kernel/sched.c:1.1.1.1.2.5
--- linux/kernel/sched.c:1.1.1.10	Thu Jan 16 18:56:23 2003
+++ linux/kernel/sched.c	Fri Jan 24 20:00:58 2003
@@ -130,15 +130,8 @@
  * These are the runqueue data structures:
  */
 
-#define BITMAP_SIZE ((((MAX_PRIO+1+7)/8)+sizeof(long)-1)/sizeof(long))
-
 typedef struct runqueue runqueue_t;
 
-struct prio_array {
-	int nr_active;
-	unsigned long bitmap[BITMAP_SIZE];
-	struct list_head queue[MAX_PRIO];
-};
 
 /*
  * This is the main, per-CPU runqueue data structure.
@@ -273,17 +266,12 @@
  */
 static inline void dequeue_task(struct task_struct *p, prio_array_t *array)
 {
-	array->nr_active--;
-	list_del(&p->run_list);
-	if (list_empty(array->queue + p->prio))
-		__clear_bit(p->prio, array->bitmap);
+        pa_dequeue (&p->run_list, p->prio, array);
 }
 
 static inline void enqueue_task(struct task_struct *p, prio_array_t *array)
 {
-	list_add_tail(&p->run_list, array->queue + p->prio);
-	__set_bit(p->prio, array->bitmap);
-	array->nr_active++;
+        pa_enqueue (&p->run_list, p->prio, array);
 	p->array = array;
 }
 

-- 

Inaky Perez-Gonzalez -- Not speaking for Intel - opinions are my own [or my fault]
