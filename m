Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262208AbUDZPMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbUDZPMz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 11:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbUDZPMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 11:12:55 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:63715 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262208AbUDZPMl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 11:12:41 -0400
Date: Mon, 26 Apr 2004 10:12:30 -0500
From: "Jose R. Santos" <jrsantos@austin.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Tuning dentry cache on large memory systems
Message-ID: <20040426151230.GM2995@rx8.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been working with SpecSFS on Linux and have seem to hit minor road block
with dentry cache.  As I increase the workload, I started seeing increase time
spent in __d_lookup().  Since my system has 64Gb of ram and the filesets of
SpecSFS contain 20+ Million files, it looked like dentry cache was getting to
big and was costing performance.

I've come up with this hack that lets me tune the amount of dentry's being
flushes every time we call shrink_dcache_memory() by returning bigger chunks
at a time.  By returning eight time dentry_stat.nr_unused, I've bee able to
get a 15% improvements on SpecSFS on some systems.

The question is....  Is there a better way of doing this?  This hack is more
of a prof of concept that there is something to gain from tuning dentry cache
for some workloads but I think it hides the problem instead of fixing it.  I 
would be interested in knowing if there is a better solution to control the 
number of dentry objects that we can have on a system.

I have also try changing the dentry cache bucket size on another setup but did
not see any gains there, but have not try this on the faster setup.  On the 
slower setup with the same amount of memory, the largest bucket was only 8 entries
deep and there were only 2 of those.  Most buckets only had 1 or 2 entries which
made the distribution pretty even.

Comments?

-JRS

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1580  -> 1.1581 
#	     kernel/sysctl.c	1.64    -> 1.65   
#	         fs/dcache.c	1.69    -> 1.70   
#	include/linux/sysctl.h	1.66    -> 1.67   
#	include/linux/dcache.h	1.38    -> 1.39   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/04/21	jsantos@rx8.austin.ibm.com	1.1581
# Add tunable to control the amount of dcache entrys beeing flush 
# when kswap is called.  Some benchmarks like SpecSFS generate 
# millions of file which causes to many entrys to be in dcache and 
# take memory away from inode cache.
# 
# This tunnable allows us to flush more (or less) entrys in dcahce 
# in order for workloads were there are many filenames involved.
# --------------------------------------------
#
diff -Nru a/fs/dcache.c b/fs/dcache.c
--- a/fs/dcache.c	Wed Apr 21 10:10:54 2004
+++ b/fs/dcache.c	Wed Apr 21 10:10:54 2004
@@ -32,6 +32,8 @@
 #define DCACHE_PARANOIA 1
 /* #define DCACHE_DEBUG 1 */
 
+int vm_dcache_shrink_rate = 50;
+
 spinlock_t dcache_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 seqlock_t rename_lock __cacheline_aligned_in_smp = SEQLOCK_UNLOCKED;
 
@@ -657,7 +659,12 @@
 		if (gfp_mask & __GFP_FS)
 			prune_dcache(nr);
 	}
-	return dentry_stat.nr_unused;
+	if ( vm_dcache_shrink_rate == 50 )
+		return dentry_stat.nr_unused;
+	else if ( vm_dcache_shrink_rate > 50 )
+		return dentry_stat.nr_unused * (vm_dcache_shrink_rate - 50) + 1;
+	else
+		return dentry_stat.nr_unused * 1 / ((50 - vm_dcache_shrink_rate) + 1);
 }
 
 #define NAME_ALLOC_LEN(len)	((len+16) & ~15)
diff -Nru a/include/linux/dcache.h b/include/linux/dcache.h
--- a/include/linux/dcache.h	Wed Apr 21 10:10:54 2004
+++ b/include/linux/dcache.h	Wed Apr 21 10:10:54 2004
@@ -13,6 +13,7 @@
 struct nameidata;
 struct vfsmount;
 
+extern int vm_dcache_shrink_rate;
 /*
  * linux/include/linux/dcache.h
  *
diff -Nru a/include/linux/sysctl.h b/include/linux/sysctl.h
--- a/include/linux/sysctl.h	Wed Apr 21 10:10:54 2004
+++ b/include/linux/sysctl.h	Wed Apr 21 10:10:54 2004
@@ -165,6 +165,7 @@
 	VM_MAX_MAP_COUNT=22,	/* int: Maximum number of mmaps/address-space */
 	VM_LAPTOP_MODE=23,	/* vm laptop mode */
 	VM_BLOCK_DUMP=24,	/* block dump mode */
+	VM_DCACHE_SHRINK_RATE=25,	/* dcache shrink tunning */
 };
 
 
diff -Nru a/kernel/sysctl.c b/kernel/sysctl.c
--- a/kernel/sysctl.c	Wed Apr 21 10:10:54 2004
+++ b/kernel/sysctl.c	Wed Apr 21 10:10:54 2004
@@ -39,6 +39,7 @@
 #include <linux/initrd.h>
 #include <linux/times.h>
 #include <linux/limits.h>
+#include <linux/dcache.h>
 #include <asm/uaccess.h>
 #ifdef	CONFIG_KDB
 #include <linux/kdb.h>
@@ -807,6 +808,17 @@
 		.strategy	= &sysctl_intvec,
 		.extra1		= &zero,
 	},
+        {
+		.ctl_name       = VM_DCACHE_SHRINK_RATE,
+		.procname       = "dcache_shrink_rate",
+		.data           = &vm_dcache_shrink_rate,
+		.maxlen         = sizeof(vm_dcache_shrink_rate),
+		.mode           = 0644,
+		.proc_handler   = &proc_dointvec_minmax,
+		.strategy       = &sysctl_intvec,
+		.extra1         = &zero,
+		.extra2         = &one_hundred,
+		},
 	{ .ctl_name = 0 }
 };
 
