Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129387AbQKMVg4>; Mon, 13 Nov 2000 16:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129405AbQKMVgp>; Mon, 13 Nov 2000 16:36:45 -0500
Received: from zeus.kernel.org ([209.10.41.242]:55311 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129429AbQKMVgg>;
	Mon, 13 Nov 2000 16:36:36 -0500
Date: Mon, 13 Nov 2000 22:50:05 +0100 (MET)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: <linux-kernel@vger.kernel.org>
cc: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
Subject: [PATCH] Re: reliability of linux-vm subsystem
Message-ID: <Pine.LNX.4.30.0011132116420.20626-100000@fs129-190.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Nov 13, 2000 Erik Mouw wrote:
> On Mon, Nov 13, 2000 at 05:29:48PM +0530, aprasad@in.ibm.com wrote:
> > System becomes useless till all of the instance of this  programming are
> > killed by vmm.
> Good, so the OOM killer works.

But it doesn't work for this kind of application misbehaviours (or
user attacks):

main() { while(1) if (fork()) malloc(1); }

or using IPC shared memory (code by Michal Zalewski)

int i,d=1; char*x; main(){ while(1){ x=shmat(shmget(0,10000000/d,511),0,0);
if(x==-1){ d*=10; continue; } for(i=0;i<10000000/d;i++) if(*(x+i)); } }

Linux 2.[24] "deadlocks" (without quotas). BTW, apparently FreeBSD, OpenBSD,
SCO also become unusable while e.g. Solaris and Tru64 survives (root can
clean up) both in non-overcommit and overcommit mode (no user quotas in
any case).

With the patch below [tried only with 2.2.18pre21 but it's easy to port to
2.4 and should apply to any late 2.2 kernels] Linux should also survive in
both cases without any performance loss (well, trashing would start about
the same time by adding 1.66% extra swap as the original one).

> Sounds quite normal to me. If you don't enforce process limits, you
> allow a normal user to thrash the system.

Home users don't quote themself so they must hit the reset button. Really
is this the maximum that the kernel can do? Also many enterprises expect
the OS won't deadlock in case of application misbehaviours so they don't
have to care about quota setup and can keep the good performance. This
shortcoming^Wfeature of the kernel is one of the reasons Linux is still
considered a toy or hobby OS by many ....

	Szaka

PS: The reserved system memory protection could be much better but I'm
pessimistic Linux kernel developers care about this kind of user issues
[it's a longstanding continuous problem, still never tried to be solved].

diff -urw linux-2.2.18pre21/include/linux/sysctl.h linux/include/linux/sysctl.h
--- linux-2.2.18pre21/include/linux/sysctl.h	Thu Nov  9 08:20:19 2000
+++ linux/include/linux/sysctl.h	Thu Nov  9 06:30:11 2000
@@ -122,7 +122,8 @@
 	VM_PAGECACHE=7,		/* struct: Set cache memory thresholds */
 	VM_PAGERDAEMON=8,	/* struct: Control kswapd behaviour */
 	VM_PGT_CACHE=9,		/* struct: Set page table cache parameters */
-	VM_PAGE_CLUSTER=10	/* int: set number of pages to swap together */
+	VM_PAGE_CLUSTER=10,	/* int: set number of pages to swap together */
+	VM_RESERVED=11		/* int: number of pages reserved for root */
 };


diff -urw linux-2.2.18pre21/ipc/shm.c linux/ipc/shm.c
--- linux-2.2.18pre21/ipc/shm.c	Wed Jun  7 17:26:44 2000
+++ linux/ipc/shm.c	Mon Nov 13 03:50:51 2000
@@ -101,8 +101,8 @@
 		return -ENOMEM;
 	}

-	shp->shm_pages = (ulong *) vmalloc (numpages*sizeof(ulong));
-	if (!shp->shm_pages) {
+	if (!vm_enough_memory(numpages)
+	    || !(shp->shm_pages = (ulong *) vmalloc(numpages*sizeof(ulong)))) {
 		shm_segs[id] = (struct shmid_kernel *) IPC_UNUSED;
 		wake_up (&shm_lock);
 		kfree(shp);
diff -urw linux-2.2.18pre21/kernel/sysctl.c linux/kernel/sysctl.c
--- linux-2.2.18pre21/kernel/sysctl.c	Thu Nov  9 08:20:19 2000
+++ linux/kernel/sysctl.c	Fri Nov 10 06:29:56 2000
@@ -32,6 +32,7 @@
 #if defined(CONFIG_SYSCTL)

 /* External variables not in a header file. */
+extern int vm_reserved;
 extern int panic_timeout;
 extern int console_loglevel, C_A_D;
 extern int bdf_prm[], bdflush_min[], bdflush_max[];
@@ -249,6 +250,8 @@
 	 &bdflush_min, &bdflush_max},
 	{VM_OVERCOMMIT_MEMORY, "overcommit_memory", &sysctl_overcommit_memory,
 	 sizeof(sysctl_overcommit_memory), 0644, NULL, &proc_dointvec},
+	{VM_RESERVED, "reserved",
+	 &vm_reserved, sizeof(int), 0644, NULL, &proc_dointvec},
 	{VM_BUFFERMEM, "buffermem",
 	 &buffer_mem, sizeof(buffer_mem_t), 0644, NULL, &proc_dointvec},
 	{VM_PAGECACHE, "pagecache",
diff -urw linux-2.2.18pre21/mm/mmap.c linux/mm/mmap.c
--- linux-2.2.18pre21/mm/mmap.c	Thu Nov  9 08:20:19 2000
+++ linux/mm/mmap.c	Mon Nov 13 11:27:56 2000
@@ -40,6 +40,7 @@
 kmem_cache_t *vm_area_cachep;

 int sysctl_overcommit_memory;
+int vm_reserved;

 /* Check that a process has enough memory to allocate a
  * new virtual mapping.
@@ -67,6 +68,8 @@
 	free += nr_free_pages;
 	free += nr_swap_pages;
 	free -= (page_cache.min_percent + buffer_mem.min_percent + 2)*num_physpages/100;
+	if (vm_reserved > 0 && current->uid && free < vm_reserved)
+		return 0;
 	return free > pages;
 }

@@ -872,6 +875,23 @@

 void __init vma_init(void)
 {
+        struct sysinfo i;
+
+        /*
+	 * Setup default reserved VM pages for root. You can tune it
+         * via /proc/sys/vm/reserved. Default value is based on RAM size
+         *    - no reserved pages if RAM is less than 8MB
+         *    - 5MB should be enough on boxes w/ RAM > 100 MB
+         *    - otherwise reserve 5%
+	 */
+        si_meminfo(&i);
+        if (i.totalram < 8 * 1024 * 1024)
+                vm_reserved = 0;
+        else if (i.totalram > 100 * 1024 * 1024)
+                vm_reserved = 5 * 1024 * 1024 >> PAGE_SHIFT;
+        else
+                vm_reserved = (i.totalram >> PAGE_SHIFT) / 20;
+
 	vm_area_cachep = kmem_cache_create("vm_area_struct",
 					   sizeof(struct vm_area_struct),
 					   0, SLAB_HWCACHE_ALIGN,

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
