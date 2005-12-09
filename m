Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964882AbVLIV5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882AbVLIV5a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 16:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbVLIV5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 16:57:30 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:61112 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964882AbVLIV53 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 16:57:29 -0500
Date: Fri, 9 Dec 2005 13:57:05 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Adrian Bunk <bunk@stusta.de>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       linux-ia64@ver.kernel.org, ak@suse.de
Subject: Re: [RFC] Introduce atomic_long_t
In-Reply-To: <20051209201127.GE23349@stusta.de>
Message-ID: <Pine.LNX.4.62.0512091352590.3182@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0512091053260.2656@schroedinger.engr.sgi.com>
 <20051209201127.GE23349@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Dec 2005, Adrian Bunk wrote:

> What about creating an include/linux/atomic.h [1] that contains both 
> this new code and other common code like the atomic_t typedef (unless 
> there's a good reason why counter isn't volatile on h8300 and v850...).

Ok that would look something like the attached patch [only exist to
give an idea on how this would work]. It would require

1. A replacement of all #include <asm/atomic.h>s with #include 
  <linux/atomic.h> throughout all files of the kernel

2. Rework of all include/asm-xx/atomic.h to extract common code.

I will do just that if everyone agrees to this approach.

----

Index: linux-2.6.15-rc5/include/linux/sched.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/sched.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/linux/sched.h	2005-12-09 13:45:34.000000000 -0800
@@ -254,25 +254,12 @@ extern void arch_unmap_area_topdown(stru
  * The mm counters are not protected by its page_table_lock,
  * so must be incremented atomically.
  */
-#ifdef ATOMIC64_INIT
-#define set_mm_counter(mm, member, value) atomic64_set(&(mm)->_##member, value)
-#define get_mm_counter(mm, member) ((unsigned long)atomic64_read(&(mm)->_##member))
-#define add_mm_counter(mm, member, value) atomic64_add(value, &(mm)->_##member)
-#define inc_mm_counter(mm, member) atomic64_inc(&(mm)->_##member)
-#define dec_mm_counter(mm, member) atomic64_dec(&(mm)->_##member)
-typedef atomic64_t mm_counter_t;
-#else /* !ATOMIC64_INIT */
-/*
- * The counters wrap back to 0 at 2^32 * PAGE_SIZE,
- * that is, at 16TB if using 4kB page size.
- */
-#define set_mm_counter(mm, member, value) atomic_set(&(mm)->_##member, value)
-#define get_mm_counter(mm, member) ((unsigned long)atomic_read(&(mm)->_##member))
-#define add_mm_counter(mm, member, value) atomic_add(value, &(mm)->_##member)
-#define inc_mm_counter(mm, member) atomic_inc(&(mm)->_##member)
-#define dec_mm_counter(mm, member) atomic_dec(&(mm)->_##member)
-typedef atomic_t mm_counter_t;
-#endif /* !ATOMIC64_INIT */
+#define set_mm_counter(mm, member, value) atomic_long_set(&(mm)->_##member, value)
+#define get_mm_counter(mm, member) ((unsigned long)atomic_long_read(&(mm)->_##member))
+#define add_mm_counter(mm, member, value) atomic_long_add(value, &(mm)->_##member)
+#define inc_mm_counter(mm, member) atomic_long_inc(&(mm)->_##member)
+#define dec_mm_counter(mm, member) atomic_long_dec(&(mm)->_##member)
+typedef atomic_long_t mm_counter_t;
 
 #else  /* NR_CPUS < CONFIG_SPLIT_PTLOCK_CPUS */
 /*
Index: linux-2.6.15-rc5/include/linux/atomic.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-rc5/include/linux/atomic.h	2005-12-09 13:46:38.000000000 -0800
@@ -0,0 +1,48 @@
+#ifdef __KERNEL_ATOMIC_H
+#define __KERNEL_ATOMIC_H
+
+#include <linux/config.h>
+#include <linux/types.h>
+
+typedef struct { volatile _s32 counter; } atomic32_t;
+#ifdef CONFIG_64BIT
+typedef struct { volatile _s64 counter; } atomic64_t;
+#endif
+
+#include <asm/atomic.h>
+
+#define ATOMIC_LONG_INIT(i)	ATOMIC32_INIT(i)
+#define atomic_t		atomic32_t
+#define atomic_read(v)		atomic32_read(v)
+#define atomic_set(v,i)		atomic32_set(v,i)
+#define atomic_inc(v)		atomic32_inc(v)
+#define atomic_dec(v)		atomic32_dec(v)
+#define atomic_add(i,v)		atomic32_add(i,v)
+#define atomic_sub(i,v)		atomic32_sub(i,v)
+
+#ifdef CONFIG_64BIT
+
+#define ATOMIC_LONG_INIT(i)	ATOMIC64_INIT(i)
+#define atomic_long_t		atomic64_t
+#define atomic_long_read(v)	atomic64_read(v)
+#define atomic_long_set(v,i)	atomic64_set(v,i)
+#define atomic_long_inc(v)	atomic64_inc(v)
+#define atomic_long_dec(v)	atomic64_dec(v)
+#define atomic_long_add(i,v)	atomic64_add(i,v)
+#define atomic_long_sub(i,v)	atomic64_sub(i,v)
+
+#else
+
+#define ATOMIC_LONG_INIT(i)	ATOMIC32_INIT(i)
+#define atomic_long_t		atomic32_t
+#define atomic_long_read(v)	atomic32_read(v)
+#define atomic_long_set(v,i)	atomic32_set(v,i)
+#define atomic_long_inc(v)	atomic32_inc(v)
+#define atomic_long_dec(v)	atomic32_dec(v)
+#define atomic_long_add(i,v)	atomic32_add(i,v)
+#define atomic_long_sub(i,v)	atomic32_sub(i,v)
+
+#endif
+
+
+#endif
Index: linux-2.6.15-rc5/include/asm-ia64/atomic.h
===================================================================
--- linux-2.6.15-rc5.orig/include/asm-ia64/atomic.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/asm-ia64/atomic.h	2005-12-09 13:45:34.000000000 -0800
@@ -2,34 +2,18 @@
 #define _ASM_IA64_ATOMIC_H
 
 /*
- * Atomic operations that C can't guarantee us.  Useful for
- * resource counting etc..
- *
- * NOTE: don't mess with the types below!  The "unsigned long" and
- * "int" types were carefully placed so as to ensure proper operation
- * of the macros.
- *
  * Copyright (C) 1998, 1999, 2002-2003 Hewlett-Packard Co
  *	David Mosberger-Tang <davidm@hpl.hp.com>
  */
-#include <linux/types.h>
-
 #include <asm/intrinsics.h>
 
-/*
- * On IA-64, counter must always be volatile to ensure that that the
- * memory accesses are ordered.
- */
-typedef struct { volatile __s32 counter; } atomic_t;
-typedef struct { volatile __s64 counter; } atomic64_t;
-
-#define ATOMIC_INIT(i)		((atomic_t) { (i) })
+#define ATOMIC32_INIT(i)	((atomic32_t) { (i) })
 #define ATOMIC64_INIT(i)	((atomic64_t) { (i) })
 
-#define atomic_read(v)		((v)->counter)
+#define atomic32_read(v)	((v)->counter)
 #define atomic64_read(v)	((v)->counter)
 
-#define atomic_set(v,i)		(((v)->counter) = (i))
+#define atomic32_set(v,i)	(((v)->counter) = (i))
 #define atomic64_set(v,i)	(((v)->counter) = (i))
 
 static __inline__ int
@@ -176,10 +160,10 @@ atomic64_add_negative (__s64 i, atomic64
 #define atomic64_dec_and_test(v)	(atomic64_sub_return(1, (v)) == 0)
 #define atomic64_inc_and_test(v)	(atomic64_add_return(1, (v)) == 0)
 
-#define atomic_add(i,v)			atomic_add_return((i), (v))
-#define atomic_sub(i,v)			atomic_sub_return((i), (v))
-#define atomic_inc(v)			atomic_add(1, (v))
-#define atomic_dec(v)			atomic_sub(1, (v))
+#define atomic32_add(i,v)		atomic_add_return((i), (v))
+#define atomic32_sub(i,v)		atomic_sub_return((i), (v))
+#define atomic32_inc(v)			atomic32_add(1, (v))
+#define atomic32_dec(v)			atomic32_sub(1, (v))
 
 #define atomic64_add(i,v)		atomic64_add_return((i), (v))
 #define atomic64_sub(i,v)		atomic64_sub_return((i), (v))
Index: linux-2.6.15-rc5/include/linux/swap.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/swap.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/linux/swap.h	2005-12-09 13:50:47.000000000 -0800
@@ -8,7 +8,7 @@
 #include <linux/list.h>
 #include <linux/sched.h>
 
-#include <asm/atomic.h>
+#include <linux/atomic.h>
 #include <asm/page.h>
 
 #define SWAP_FLAG_PREFER	0x8000	/* set if swap priority specified */
Index: linux-2.6.15-rc5/include/linux/file.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/file.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/linux/file.h	2005-12-09 13:47:42.000000000 -0800
@@ -5,7 +5,7 @@
 #ifndef __LINUX_FILE_H
 #define __LINUX_FILE_H
 
-#include <asm/atomic.h>
+#include <linux/atomic.h>
 #include <linux/posix_types.h>
 #include <linux/compiler.h>
 #include <linux/spinlock.h>
Index: linux-2.6.15-rc5/include/linux/sonet.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/sonet.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/linux/sonet.h	2005-12-09 13:50:29.000000000 -0800
@@ -58,7 +58,7 @@ struct sonet_stats {
 
 #ifdef __KERNEL__
 
-#include <asm/atomic.h>
+#include <linux/atomic.h>
 
 struct k_sonet_stats {
 #define __HANDLE_ITEM(i) atomic_t i
Index: linux-2.6.15-rc5/include/linux/netdevice.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/netdevice.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/linux/netdevice.h	2005-12-09 13:49:08.000000000 -0800
@@ -30,7 +30,7 @@
 #include <linux/if_packet.h>
 
 #ifdef __KERNEL__
-#include <asm/atomic.h>
+#include <linux/atomic.h>
 #include <asm/cache.h>
 #include <asm/byteorder.h>
 
Index: linux-2.6.15-rc5/include/linux/kobject.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/kobject.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/linux/kobject.h	2005-12-09 13:48:19.000000000 -0800
@@ -25,7 +25,7 @@
 #include <linux/kref.h>
 #include <linux/kobject_uevent.h>
 #include <linux/kernel.h>
-#include <asm/atomic.h>
+#include <linux/atomic.h>
 
 #define KOBJ_NAME_LEN	20
 
Index: linux-2.6.15-rc5/include/linux/key.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/key.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/linux/key.h	2005-12-09 13:48:12.000000000 -0800
@@ -19,7 +19,7 @@
 #include <linux/list.h>
 #include <linux/rbtree.h>
 #include <linux/rcupdate.h>
-#include <asm/atomic.h>
+#include <linux/atomic.h>
 
 #ifdef __KERNEL__
 
Index: linux-2.6.15-rc5/include/linux/oprofile.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/oprofile.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/linux/oprofile.h	2005-12-09 13:49:40.000000000 -0800
@@ -15,7 +15,7 @@
 
 #include <linux/types.h>
 #include <linux/spinlock.h>
-#include <asm/atomic.h>
+#include <linux/atomic.h>
  
 struct super_block;
 struct dentry;
Index: linux-2.6.15-rc5/include/linux/atmdev.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/atmdev.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/linux/atmdev.h	2005-12-09 13:46:31.000000000 -0800
@@ -216,7 +216,7 @@ struct atm_cirange {
 #include <linux/skbuff.h> /* struct sk_buff */
 #include <linux/uio.h>
 #include <net/sock.h>
-#include <asm/atomic.h>
+#include <linux/atomic.h>
 
 #ifdef CONFIG_PROC_FS
 #include <linux/proc_fs.h>
Index: linux-2.6.15-rc5/include/linux/aio.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/aio.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/linux/aio.h	2005-12-09 13:46:15.000000000 -0800
@@ -5,7 +5,7 @@
 #include <linux/workqueue.h>
 #include <linux/aio_abi.h>
 
-#include <asm/atomic.h>
+#include <linux/atomic.h>
 
 #define AIO_MAXSEGS		4
 #define AIO_KIOGRP_NR_ATOMIC	8
Index: linux-2.6.15-rc5/include/linux/rwsem.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/rwsem.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/linux/rwsem.h	2005-12-09 13:50:07.000000000 -0800
@@ -17,7 +17,7 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <asm/system.h>
-#include <asm/atomic.h>
+#include <linux/atomic.h>
 
 struct rw_semaphore;
 
Index: linux-2.6.15-rc5/include/linux/netfilter_bridge.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/netfilter_bridge.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/linux/netfilter_bridge.h	2005-12-09 13:49:19.000000000 -0800
@@ -7,7 +7,7 @@
 #include <linux/config.h>
 #include <linux/netfilter.h>
 #if defined(__KERNEL__) && defined(CONFIG_BRIDGE_NETFILTER)
-#include <asm/atomic.h>
+#include <linux/atomic.h>
 #include <linux/if_ether.h>
 #endif
 
Index: linux-2.6.15-rc5/include/linux/skbuff.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/skbuff.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/linux/skbuff.h	2005-12-09 13:50:21.000000000 -0800
@@ -20,7 +20,7 @@
 #include <linux/time.h>
 #include <linux/cache.h>
 
-#include <asm/atomic.h>
+#include <linux/atomic.h>
 #include <asm/types.h>
 #include <linux/spinlock.h>
 #include <linux/mm.h>
Index: linux-2.6.15-rc5/include/linux/connector.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/connector.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/linux/connector.h	2005-12-09 13:47:16.000000000 -0800
@@ -90,7 +90,7 @@ struct cn_ctl_msg {
 
 #ifdef __KERNEL__
 
-#include <asm/atomic.h>
+#include <linux/atomic.h>
 
 #include <linux/list.h>
 #include <linux/workqueue.h>
Index: linux-2.6.15-rc5/include/linux/fs.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/fs.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/linux/fs.h	2005-12-09 13:47:58.000000000 -0800
@@ -221,7 +221,7 @@ extern int dir_notify_enable;
 #include <linux/init.h>
 #include <linux/sched.h>
 
-#include <asm/atomic.h>
+#include <linux/atomic.h>
 #include <asm/semaphore.h>
 #include <asm/byteorder.h>
 
Index: linux-2.6.15-rc5/include/linux/spinlock.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/spinlock.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/linux/spinlock.h	2005-12-09 13:50:41.000000000 -0800
@@ -229,7 +229,7 @@ extern int __lockfunc generic__raw_read_
  * Pull the atomic_t declaration:
  * (asm-mips/atomic.h needs above definitions)
  */
-#include <asm/atomic.h>
+#include <linux/atomic.h>
 /**
  * atomic_dec_and_lock - lock on reaching reference count zero
  * @atomic: the atomic counter
Index: linux-2.6.15-rc5/include/linux/mm.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/mm.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/linux/mm.h	2005-12-09 13:48:46.000000000 -0800
@@ -35,7 +35,7 @@ extern int sysctl_legacy_va_layout;
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/processor.h>
-#include <asm/atomic.h>
+#include <linux/atomic.h>
 
 #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
 
Index: linux-2.6.15-rc5/include/linux/backing-dev.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/backing-dev.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/linux/backing-dev.h	2005-12-09 13:46:52.000000000 -0800
@@ -8,7 +8,7 @@
 #ifndef _LINUX_BACKING_DEV_H
 #define _LINUX_BACKING_DEV_H
 
-#include <asm/atomic.h>
+#include <linux/atomic.h>
 
 /*
  * Bits in backing_dev_info.state
Index: linux-2.6.15-rc5/include/linux/nfs_page.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/nfs_page.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/linux/nfs_page.h	2005-12-09 13:49:32.000000000 -0800
@@ -17,7 +17,7 @@
 #include <linux/sunrpc/auth.h>
 #include <linux/nfs_xdr.h>
 
-#include <asm/atomic.h>
+#include <linux/atomic.h>
 
 /*
  * Valid flags for the radix tree
Index: linux-2.6.15-rc5/include/linux/netfilter_logging.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/netfilter_logging.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/linux/netfilter_logging.h	2005-12-09 13:49:25.000000000 -0800
@@ -4,7 +4,7 @@
 #define __LINUX_NETFILTER_LOGGING_H
 
 #ifdef __KERNEL__
-#include <asm/atomic.h>
+#include <linux/atomic.h>
 
 struct nf_logging_t {
 	void (*nf_log_packet)(struct sk_buff **pskb,
Index: linux-2.6.15-rc5/include/linux/sysfs.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/sysfs.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/linux/sysfs.h	2005-12-09 13:50:54.000000000 -0800
@@ -10,7 +10,7 @@
 #ifndef _SYSFS_H_
 #define _SYSFS_H_
 
-#include <asm/atomic.h>
+#include <linux/atomic.h>
 
 struct kobject;
 struct module;
Index: linux-2.6.15-rc5/include/linux/rcuref.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/rcuref.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/linux/rcuref.h	2005-12-09 13:50:01.000000000 -0800
@@ -35,7 +35,7 @@
 #include <linux/types.h>
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
-#include <asm/atomic.h>
+#include <linux/atomic.h>
 
 /*
  * These APIs work on traditional atomic_t counters used in the
Index: linux-2.6.15-rc5/include/linux/proc_fs.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/proc_fs.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/linux/proc_fs.h	2005-12-09 13:49:53.000000000 -0800
@@ -4,7 +4,7 @@
 #include <linux/config.h>
 #include <linux/slab.h>
 #include <linux/fs.h>
-#include <asm/atomic.h>
+#include <linux/atomic.h>
 
 /*
  * The proc filesystem constants/structures
Index: linux-2.6.15-rc5/include/linux/mount.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/mount.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/linux/mount.h	2005-12-09 13:49:01.000000000 -0800
@@ -15,7 +15,7 @@
 #include <linux/types.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
-#include <asm/atomic.h>
+#include <linux/atomic.h>
 
 #define MNT_NOSUID	0x01
 #define MNT_NODEV	0x02
Index: linux-2.6.15-rc5/include/linux/pm.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/pm.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/linux/pm.h	2005-12-09 13:49:46.000000000 -0800
@@ -25,7 +25,7 @@
 
 #include <linux/config.h>
 #include <linux/list.h>
-#include <asm/atomic.h>
+#include <linux/atomic.h>
 
 /*
  * Power management requests... these are passed to pm_send_all() and friends.
Index: linux-2.6.15-rc5/include/linux/filter.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/filter.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/linux/filter.h	2005-12-09 13:47:50.000000000 -0800
@@ -9,7 +9,7 @@
 #include <linux/types.h>
 
 #ifdef __KERNEL__
-#include <asm/atomic.h>
+#include <linux/atomic.h>
 #endif
 
 /*
Index: linux-2.6.15-rc5/include/linux/dcache.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/dcache.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/linux/dcache.h	2005-12-09 13:47:24.000000000 -0800
@@ -3,7 +3,7 @@
 
 #ifdef __KERNEL__
 
-#include <asm/atomic.h>
+#include <linux/atomic.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/cache.h>
Index: linux-2.6.15-rc5/include/linux/buffer_head.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/buffer_head.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/linux/buffer_head.h	2005-12-09 13:47:02.000000000 -0800
@@ -12,7 +12,7 @@
 #include <linux/linkage.h>
 #include <linux/pagemap.h>
 #include <linux/wait.h>
-#include <asm/atomic.h>
+#include <linux/atomic.h>
 
 enum bh_state_bits {
 	BH_Uptodate,	/* Contains valid data */
Index: linux-2.6.15-rc5/include/linux/interrupt.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/interrupt.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/linux/interrupt.h	2005-12-09 13:48:04.000000000 -0800
@@ -10,7 +10,7 @@
 #include <linux/cpumask.h>
 #include <linux/hardirq.h>
 #include <linux/sched.h>
-#include <asm/atomic.h>
+#include <linux/atomic.h>
 #include <asm/ptrace.h>
 #include <asm/system.h>
 
Index: linux-2.6.15-rc5/include/linux/device.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/device.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/linux/device.h	2005-12-09 13:47:33.000000000 -0800
@@ -20,7 +20,7 @@
 #include <linux/module.h>
 #include <linux/pm.h>
 #include <asm/semaphore.h>
-#include <asm/atomic.h>
+#include <linux/atomic.h>
 
 #define DEVICE_NAME_SIZE	50
 #define DEVICE_NAME_HALF	__stringify(20)	/* Less than half to accommodate slop */
Index: linux-2.6.15-rc5/include/linux/sem.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/sem.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/linux/sem.h	2005-12-09 13:50:13.000000000 -0800
@@ -2,7 +2,7 @@
 #define _LINUX_SEM_H
 
 #include <linux/ipc.h>
-#include <asm/atomic.h>
+#include <linux/atomic.h>
 
 /* semop flags */
 #define SEM_UNDO        0x1000  /* undo the operation on exit */
Index: linux-2.6.15-rc5/include/linux/mmzone.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/mmzone.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/linux/mmzone.h	2005-12-09 13:48:53.000000000 -0800
@@ -13,7 +13,7 @@
 #include <linux/numa.h>
 #include <linux/init.h>
 #include <linux/seqlock.h>
-#include <asm/atomic.h>
+#include <linux/atomic.h>
 
 /* Free memory management - zoned buddy allocator.  */
 #ifndef CONFIG_FORCE_MAX_ZONEORDER
Index: linux-2.6.15-rc5/include/linux/mman.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/mman.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/linux/mman.h	2005-12-09 13:48:35.000000000 -0800
@@ -4,7 +4,7 @@
 #include <linux/config.h>
 #include <linux/mm.h>
 
-#include <asm/atomic.h>
+#include <linux/atomic.h>
 #include <asm/mman.h>
 
 #define MREMAP_MAYMOVE	1
Index: linux-2.6.15-rc5/include/linux/kref.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/kref.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/linux/kref.h	2005-12-09 13:48:27.000000000 -0800
@@ -18,7 +18,7 @@
 #ifdef __KERNEL__
 
 #include <linux/types.h>
-#include <asm/atomic.h>
+#include <linux/atomic.h>
 
 struct kref {
 	atomic_t refcount;
 
