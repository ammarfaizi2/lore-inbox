Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbUC0Fve (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 00:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbUC0Fve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 00:51:34 -0500
Received: from palrel11.hp.com ([156.153.255.246]:53907 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S261602AbUC0FvZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 00:51:25 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16485.5722.591616.846576@napali.hpl.hp.com>
Date: Fri, 26 Mar 2004 21:51:22 -0800
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: replace MAX_MAP_COUNT with /proc/sys/vm/max_map_count
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below is a warmed up version of a patch originally done by Werner
Almesberger (see http://tinyurl.com/25zra) to replace the
MAX_MAP_COUNT limit with a sysctl variable.  I thought this had gone
into the tree a long time ago but alas it has not and as luck would
have it, the hard limit bit someone today once again with a large app
on a large machine.

Here is a small test app:

-----------------------------------------------------------------
#include <stdio.h>
#include <stdlib.h>

#include <sys/mman.h>

int
main (int argc, char **argv)
{
  long n = 0;

  printf ("Starting mmap test...\n");
  while (1)
    if (mmap (0, 1, (n++ & 1) ? PROT_READ : PROT_WRITE,
	      MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE,
	      -1, 0) == MAP_FAILED)
      {
	printf ("Failed after %ld successful maps\n", n - 1);
	exit (0);
      }
  return -1;
}
-----------------------------------------------------------------

After applying the patch, I was able to do 20,000,000 successful maps
while consuming about 3.6GB of memory (~ 180 bytes/map) which matches
well enough with the actual vm_area_struct size of 128 bytes.  If I
set the max_map_count insanely high, the above test keeps running
until we're out of memory and then the OOM killer kicks in.
Basically: no surprises.

Please consider for inclusion.

Thanks,

	--david

===== Documentation/sysctl/vm.txt 1.11 vs edited =====
--- 1.11/Documentation/sysctl/vm.txt	Tue Jan 20 17:58:52 2004
+++ edited/Documentation/sysctl/vm.txt	Fri Mar 26 21:04:47 2004
@@ -22,6 +22,7 @@
 - dirty_background_ratio
 - dirty_expire_centisecs
 - dirty_writeback_centisecs
+- max_map_count
 - min_free_kbytes
 
 ==============================================================
@@ -74,6 +75,21 @@
 The number of pages the kernel reads in at once is equal to
 2 ^ page-cluster. Values above 2 ^ 5 don't make much sense
 for swap because we only cluster swap data in 32-page groups.
+
+==============================================================
+
+max_map_count:
+
+This file contains the maximum number of memory map areas a process
+may have. Memory map areas are used as a side-effect of calling
+malloc, directly by mmap and mprotect, and also when loading shared
+libraries.
+
+While most applications need less than a thousand maps, certain
+programs, particularly malloc debuggers, may consume lots of them,
+e.g., up to one or two maps per allocation.
+
+The default value is 65536.
 
 ==============================================================
 
===== include/linux/sched.h 1.170 vs edited =====
--- 1.170/include/linux/sched.h	Fri Mar 19 20:31:17 2004
+++ edited/include/linux/sched.h	Fri Mar 26 21:16:57 2004
@@ -179,7 +179,9 @@
 struct namespace;
 
 /* Maximum number of active map areas.. This is a random (large) number */
-#define MAX_MAP_COUNT	(65536)
+#define DEFAULT_MAX_MAP_COUNT	65536
+
+extern int sysctl_max_map_count;
 
 #include <linux/aio.h>
 
===== include/linux/sysctl.h 1.60 vs edited =====
--- 1.60/include/linux/sysctl.h	Wed Mar 10 12:07:02 2004
+++ edited/include/linux/sysctl.h	Fri Mar 26 21:06:40 2004
@@ -158,6 +158,7 @@
 	VM_SWAPPINESS=19,	/* Tendency to steal mapped memory */
 	VM_LOWER_ZONE_PROTECTION=20,/* Amount of protection of lower zones */
 	VM_MIN_FREE_KBYTES=21,	/* Minimum free kilobytes to maintain */
+	VM_MAX_MAP_COUNT=22,	/* int: Maximum number of active map areas per address-space */
 };
 
 
===== kernel/sysctl.c 1.58 vs edited =====
--- 1.58/kernel/sysctl.c	Wed Mar 24 10:52:11 2004
+++ edited/kernel/sysctl.c	Fri Mar 26 21:14:53 2004
@@ -736,6 +736,14 @@
 		.strategy	= &sysctl_intvec,
 		.extra1		= &zero,
 	},
+	{
+		.ctl_name	= VM_MAX_MAP_COUNT,
+		.procname	= "max_map_count",
+		.data		= &sysctl_max_map_count,
+		.maxlen		= sizeof(sysctl_max_map_count),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec
+	},
 	{ .ctl_name = 0 }
 };
 
===== mm/mmap.c 1.99 vs edited =====
--- 1.99/mm/mmap.c	Mon Mar 15 22:50:13 2004
+++ edited/mm/mmap.c	Fri Mar 26 21:14:40 2004
@@ -54,10 +54,12 @@
 
 int sysctl_overcommit_memory = 0;	/* default is heuristic overcommit */
 int sysctl_overcommit_ratio = 50;	/* default is 50% */
+int sysctl_max_map_count = DEFAULT_MAX_MAP_COUNT;
 atomic_t vm_committed_space = ATOMIC_INIT(0);
 
 EXPORT_SYMBOL(sysctl_overcommit_memory);
 EXPORT_SYMBOL(sysctl_overcommit_ratio);
+EXPORT_SYMBOL(sysctl_max_map_count);
 EXPORT_SYMBOL(vm_committed_space);
 
 /*
@@ -512,7 +514,7 @@
 		return -EINVAL;
 
 	/* Too many mappings? */
-	if (mm->map_count > MAX_MAP_COUNT)
+	if (mm->map_count > sysctl_max_map_count)
 		return -ENOMEM;
 
 	/* Obtain the address to map to. we verify (or select) it and ensure
@@ -1197,7 +1199,7 @@
 	struct vm_area_struct *new;
 	struct address_space *mapping = NULL;
 
-	if (mm->map_count >= MAX_MAP_COUNT)
+	if (mm->map_count >= sysctl_max_map_count)
 		return -ENOMEM;
 
 	new = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
@@ -1375,7 +1377,7 @@
 	    > current->rlim[RLIMIT_AS].rlim_cur)
 		return -ENOMEM;
 
-	if (mm->map_count > MAX_MAP_COUNT)
+	if (mm->map_count > sysctl_max_map_count)
 		return -ENOMEM;
 
 	if (security_vm_enough_memory(len >> PAGE_SHIFT))
