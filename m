Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269120AbUJERwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269120AbUJERwE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 13:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269127AbUJERu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 13:50:58 -0400
Received: from smtp07.auna.com ([62.81.186.17]:55500 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id S269093AbUJERuT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 13:50:19 -0400
Date: Tue, 05 Oct 2004 17:50:15 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: [PATCH] Kill get/put_cpu_ptr
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
X-Mailer: Balsa 2.2.5
Message-Id: <1096998615l.5347l.1l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Someone asked for this in the list...
Against rc3-mm2, compiled and booted:

--- linux-2.6.9-rc3-mm2-cln/include/linux/percpu.h	2004-06-16 07:20:03.000000000 +0200
+++ linux-2.6.9-rc3-mm2/include/linux/percpu.h	2004-10-05 13:57:58.000000000 +0200
@@ -24,8 +24,7 @@
 
 /* 
  * Use this to get to a cpu's version of the per-cpu object allocated using
- * alloc_percpu.  If you want to get "this cpu's version", maybe you want
- * to use get_cpu_ptr... 
+ * alloc_percpu.
  */ 
 #define per_cpu_ptr(ptr, cpu)                   \
 ({                                              \
@@ -58,26 +57,4 @@
 #define alloc_percpu(type) \
 	((type *)(__alloc_percpu(sizeof(type), __alignof__(type))))
 
-/* 
- * Use these with alloc_percpu. If
- * 1. You want to operate on memory allocated by alloc_percpu (dereference
- *    and read/modify/write)  AND 
- * 2. You want "this cpu's version" of the object AND 
- * 3. You want to do this safely since:
- *    a. On multiprocessors, you don't want to switch between cpus after 
- *    you've read the current processor id due to preemption -- this would 
- *    take away the implicit  advantage to not have any kind of traditional 
- *    serialization for per-cpu data
- *    b. On uniprocessors, you don't want another kernel thread messing
- *    up with the same per-cpu data due to preemption
- *    
- * So, Use get_cpu_ptr to disable preemption and get pointer to the 
- * local cpu version of the per-cpu object. Use put_cpu_ptr to enable
- * preemption.  Operations on per-cpu data between get_ and put_ is
- * then considered to be safe. And ofcourse, "Thou shalt not sleep between 
- * get_cpu_ptr and put_cpu_ptr"
- */
-#define get_cpu_ptr(ptr) per_cpu_ptr(ptr, get_cpu())
-#define put_cpu_ptr(ptr) put_cpu()
-
 #endif /* __LINUX_PERCPU_H */
diff -ruN linux-2.6.9-rc3-mm2-cln/mm/slab.c linux-2.6.9-rc3-mm2/mm/slab.c
--- linux-2.6.9-rc3-mm2-cln/mm/slab.c	2004-10-05 13:59:56.436888255 +0200
+++ linux-2.6.9-rc3-mm2/mm/slab.c	2004-10-05 13:58:44.000000000 +0200
@@ -2435,8 +2435,7 @@
 /**
  * __alloc_percpu - allocate one copy of the object for every present
  * cpu in the system, zeroing them.
- * Objects should be dereferenced using per_cpu_ptr/get_cpu_ptr
- * macros only.
+ * Objects should be dereferenced using per_cpu_ptr macro only.
  *
  * @size: how many bytes of memory are required.
  * @align: the alignment, which can't be greater than SMP_CACHE_BYTES.


--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (Community) for i586
Linux 2.6.9-rc3-mm2 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #1


