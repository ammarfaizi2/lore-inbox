Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264856AbSLLOOC>; Thu, 12 Dec 2002 09:14:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264863AbSLLOOB>; Thu, 12 Dec 2002 09:14:01 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:16850 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264856AbSLLON5>;
	Thu, 12 Dec 2002 09:13:57 -0500
Date: Thu, 12 Dec 2002 19:49:57 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: dipankar@in.ibm.com, linux-kernel@vger.kernel.org,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: [patch] kmalloc_percpu -- stripped down version
Message-ID: <20021212194957.A24330@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
Here's a simpler kmalloc_percpu imlementation (minus the interlaced
allocator).  Hope this is acceptable....

Thanks,
Kiran

D: Name: kmalloc_percpu-2.5.51-1.patch
D: Author: Dipankar Sarma & Ravikiran Thirumalai
D: Description:  Dynamic per-cpu kernel memory allocator 

 include/linux/percpu.h |   61 +++++++++++++++++++++++++++++++++++++++++
 kernel/ksyms.c         |    4 ++
 mm/slab.c              |   72 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 137 insertions(+)


diff -X dontdiff -ruN linux-2.5.51/include/linux/percpu.h kmalloc_percpu-2.5.51/include/linux/percpu.h
--- linux-2.5.51/include/linux/percpu.h	Tue Dec 10 08:16:21 2002
+++ kmalloc_percpu-2.5.51/include/linux/percpu.h	Thu Dec 12 16:18:55 2002
@@ -1,10 +1,71 @@
 #ifndef __LINUX_PERCPU_H
 #define __LINUX_PERCPU_H
 #include <linux/spinlock.h> /* For preempt_disable() */
+#include <linux/slab.h> /* For kmalloc_percpu() */
 #include <asm/percpu.h>
 
 /* Must be an lvalue. */
 #define get_cpu_var(var) (*({ preempt_disable(); &__get_cpu_var(var); }))
 #define put_cpu_var(var) preempt_enable()
 
+#ifdef CONFIG_SMP
+
+struct percpu_data {
+	void *ptrs[NR_CPUS];
+	void *blkp;
+};
+
+/* 
+ * Use this to get to a cpu's version of the per-cpu object allocated using
+ * kmalloc_percpu.  If you want to get "this cpu's version", maybe you want
+ * to use get_cpu_ptr... 
+ */ 
+#define per_cpu_ptr(ptr, cpu)                   \
+({                                              \
+        struct percpu_data *__p = (struct percpu_data *)~(unsigned long)(ptr); \
+        (__typeof__(ptr))__p->ptrs[(cpu)];	\
+})
+
+extern void *kmalloc_percpu(size_t size, int flags);
+extern void kfree_percpu(const void *);
+extern void kmalloc_percpu_init(void);
+
+#else /* CONFIG_SMP */
+
+#define per_cpu_ptr(ptr, cpu) (ptr)
+
+static inline void *kmalloc_percpu(size_t size, int flags)
+{
+	return(kmalloc(size, flags));
+}
+static inline void kfree_percpu(const void *ptr)
+{	
+	kfree(ptr);
+}
+static inline void kmalloc_percpu_init(void) { }
+
+#endif /* CONFIG_SMP */
+
+/* 
+ * Use these with kmalloc_percpu. If
+ * 1. You want to operate on memory allocated by kmalloc_percpu (dereference
+ *    and read/modify/write)  AND 
+ * 2. You want "this cpu's version" of the object AND 
+ * 3. You want to do this safely since:
+ *    a. On multiprocessors, you don't want to switch between cpus after 
+ *    you've read the current processor id due to preemption -- this would 
+ *    take away the implicit  advantage to not have any kind of traditional 
+ *    serialization for per-cpu data
+ *    b. On uniprocessors, you don't want another kernel thread messing
+ *    up with the same per-cpu data due to preemption
+ *    
+ * So, Use get_cpu_ptr to disable preemption and get pointer to the 
+ * local cpu version of the per-cpu object. Use put_cpu_ptr to enable
+ * preemption.  Operations on per-cpu data between get_ and put_ is
+ * then considered to be safe. And ofcourse, "Thou shalt not sleep between 
+ * get_cpu_ptr and put_cpu_ptr"
+ */
+#define get_cpu_ptr(ptr) per_cpu_ptr(ptr, get_cpu())
+#define put_cpu_ptr(ptr) put_cpu()
+
 #endif /* __LINUX_PERCPU_H */
diff -X dontdiff -ruN linux-2.5.51/kernel/ksyms.c kmalloc_percpu-2.5.51/kernel/ksyms.c
--- linux-2.5.51/kernel/ksyms.c	Tue Dec 10 08:15:41 2002
+++ kmalloc_percpu-2.5.51/kernel/ksyms.c	Tue Dec 10 19:52:59 2002
@@ -98,6 +98,10 @@
 EXPORT_SYMBOL(remove_shrinker);
 EXPORT_SYMBOL(kmalloc);
 EXPORT_SYMBOL(kfree);
+#ifdef CONFIG_SMP
+EXPORT_SYMBOL(kmalloc_percpu);
+EXPORT_SYMBOL(kfree_percpu);
+#endif
 EXPORT_SYMBOL(vfree);
 EXPORT_SYMBOL(__vmalloc);
 EXPORT_SYMBOL(vmalloc);
diff -X dontdiff -ruN linux-2.5.51/mm/slab.c kmalloc_percpu-2.5.51/mm/slab.c
--- linux-2.5.51/mm/slab.c	Tue Dec 10 08:16:15 2002
+++ kmalloc_percpu-2.5.51/mm/slab.c	Wed Dec 11 17:16:23 2002
@@ -1826,6 +1826,56 @@
 	return NULL;
 }
 
+#ifdef CONFIG_SMP
+/**
+ * kmalloc_percpu - allocate one copy of the object for every present
+ * cpu in the system.
+ * Objects should be dereferenced using per_cpu_ptr/get_cpu_ptr
+ * macros only.
+ *
+ * @size: how many bytes of memory are required.
+ * @flags: the type of memory to allocate.
+ * The @flags argument may be one of:
+ *
+ * %GFP_USER - Allocate memory on behalf of user.  May sleep.
+ *
+ * %GFP_KERNEL - Allocate normal kernel ram.  May sleep.
+ *
+ * %GFP_ATOMIC - Allocation will not sleep.  Use inside interrupt handlers.
+ */
+void *
+kmalloc_percpu(size_t size, int flags)
+{
+	int i;
+	struct percpu_data *pdata = kmalloc(sizeof (*pdata), flags);
+
+	if (!pdata)
+		goto out_done;
+
+	for (i = 0; i < NR_CPUS; i++) {
+		if (!cpu_possible(i))
+			continue;
+		pdata->ptrs[i] = kmalloc(size, flags);
+		if (!pdata->ptrs[i])
+			goto unwind_oom;
+	}
+
+	/* Catch derefs w/o wrappers */
+	return (void *) (~(unsigned long) pdata);
+
+unwind_oom:
+	while (--i >= 0) {
+		if (!cpu_possible(i))
+			continue;
+		kfree(pdata->ptrs[i]);
+	}
+out:
+	kfree(pdata);
+out_done:
+	return NULL;
+}
+#endif
+
 /**
  * kmem_cache_free - Deallocate an object
  * @cachep: The cache the allocation was from.
@@ -1864,6 +1914,28 @@
 	local_irq_restore(flags);
 }
 
+#ifdef CONFIG_SMP
+/**
+ * kfree_percpu - free previously allocated percpu memory
+ * @objp: pointer returned by kmalloc_percpu.
+ *
+ * Don't free memory not originally allocated by kmalloc_percpu()
+ * The complemented objp is to check for that.
+ */
+void
+kfree_percpu(const void *objp)
+{
+	int i;
+	struct percpu_data *p = (struct percpu_data *) (~(unsigned long) objp);
+
+	for (i = 0; i < NR_CPUS; i++) {
+		if (!cpu_possible(i))
+			continue;
+		kfree(p->ptrs[i]);
+	}
+}
+#endif
+
 unsigned int kmem_cache_size(kmem_cache_t *cachep)
 {
 #if DEBUG
