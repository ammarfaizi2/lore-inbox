Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262363AbTEFEs3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 00:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262365AbTEFEs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 00:48:29 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:50919 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262363AbTEFEsS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 00:48:18 -0400
Date: Tue, 6 May 2003 10:37:44 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, dipankar@in.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kmalloc_percpu
Message-ID: <20030506050744.GA29352@in.ibm.com>
References: <20030505081300.6B2ED2C016@lists.samba.org> <20030505014729.5db76f70.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030505014729.5db76f70.akpm@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05, 2003 at 08:46:58AM +0000, Andrew Morton wrote:
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> >
> > This is the kmalloc_percpu patch.
> 
> How does it work?  What restrictions does it have, and
> what compromises were made?
> 
> +#define PERCPU_POOL_SIZE 32768
> 
> What's this?
> 
> 
> The current implementation of kmalloc_per_cpu() turned out to be fairly
> disappointing because of the number of derefs which were necessary to get at
> the data in fastpaths.   How does this implementation compare?
>
Andrew,
Here is a comparision of kmalloc_percpu techniques as I see it,

Current Implementation:
1. Two dereferences to get to the per-cpu data 
2. Allocates for cpu_possible cpus only, and can deal with sparse cpu nos
 
Rusty's Implementation
1. One extra memory reference (__per_cpu_offset) 
2. allocates for NR_CPUS and probably breaks with sparse cpu nos?
3. Let you do per-cpu data in modules
4. fragmentation

The simpler patch I mailed you sometime back,
1. Minimal dereference overhead, offsets to per-cpu data calculated at 
   compile time
2. allocates for NR_CPUS and problems with sparse cpu nos
3. Very Simple.

My guess is performancewise Rusty's iplementation and the simpler
implementation of kmalloc_percpu will be comparable. (I'll run some
tests to compare them and post them later).  I am including the
simpler kmalloc_percpu patch which I'd mailed to you earlier.

Thanks,
Kiran 

diff -ruN -X dontdiff linux-2.5.65/include/linux/percpu.h kmalloc-new-2.5.65/include/linux/percpu.h
--- linux-2.5.65/include/linux/percpu.h	Tue Mar 18 03:14:43 2003
+++ kmalloc-new-2.5.65/include/linux/percpu.h	Wed Mar 19 17:18:59 2003
@@ -9,22 +9,14 @@
 #define put_cpu_var(var) preempt_enable()
 
 #ifdef CONFIG_SMP
-
-struct percpu_data {
-	void *ptrs[NR_CPUS];
-	void *blkp;
-};
-
 /* 
  * Use this to get to a cpu's version of the per-cpu object allocated using
  * kmalloc_percpu.  If you want to get "this cpu's version", maybe you want
  * to use get_cpu_ptr... 
  */ 
 #define per_cpu_ptr(ptr, cpu)                   \
-({                                              \
-        struct percpu_data *__p = (struct percpu_data *)~(unsigned long)(ptr); \
-        (__typeof__(ptr))__p->ptrs[(cpu)];	\
-})
+        ((__typeof__(ptr)) 			\
+		(RELOC_HIDE(ptr, ALIGN(sizeof (*ptr), SMP_CACHE_BYTES)*cpu))) 
 
 extern void *kmalloc_percpu(size_t size, int flags);
 extern void kfree_percpu(const void *);
diff -ruN -X dontdiff linux-2.5.65/mm/slab.c kmalloc-new-2.5.65/mm/slab.c
--- linux-2.5.65/mm/slab.c	Tue Mar 18 03:14:38 2003
+++ kmalloc-new-2.5.65/mm/slab.c	Wed Mar 19 16:32:33 2003
@@ -1951,31 +1951,7 @@
 void *
 kmalloc_percpu(size_t size, int flags)
 {
-	int i;
-	struct percpu_data *pdata = kmalloc(sizeof (*pdata), flags);
-
-	if (!pdata)
-		return NULL;
-
-	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_possible(i))
-			continue;
-		pdata->ptrs[i] = kmalloc(size, flags);
-		if (!pdata->ptrs[i])
-			goto unwind_oom;
-	}
-
-	/* Catch derefs w/o wrappers */
-	return (void *) (~(unsigned long) pdata);
-
-unwind_oom:
-	while (--i >= 0) {
-		if (!cpu_possible(i))
-			continue;
-		kfree(pdata->ptrs[i]);
-	}
-	kfree(pdata);
-	return NULL;
+	return kmalloc(ALIGN(size, SMP_CACHE_BYTES)*NR_CPUS, flags);
 }
 #endif
 
@@ -2028,14 +2004,7 @@
 void
 kfree_percpu(const void *objp)
 {
-	int i;
-	struct percpu_data *p = (struct percpu_data *) (~(unsigned long) objp);
-
-	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_possible(i))
-			continue;
-		kfree(p->ptrs[i]);
-	}
+	kfree(objp);
 }
 #endif
 
