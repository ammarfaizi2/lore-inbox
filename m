Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbTEQMQS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 08:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbTEQMQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 08:16:17 -0400
Received: from dp.samba.org ([66.70.73.150]:53964 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261422AbTEQMQJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 08:16:09 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: akpm@zip.com.au, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       davidm@hpl.hp.com, rth@twiddle.net
Subject: Re: [PATCH] Unlimited per-cpu allocation 
In-reply-to: Your message of "Fri, 16 May 2003 20:10:48 MST."
             <20030516.201048.116377975.davem@redhat.com> 
Date: Sat, 17 May 2003 21:36:16 +1000
Message-Id: <20030517122903.D1EC52C0C4@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030516.201048.116377975.davem@redhat.com> you write:
>    From: Rusty Russell <rusty@rustcorp.com.au>
>    Date: Sat, 17 May 2003 13:07:21 +1000
>    
>    The question is not whether we need this allocator to implement
>    percpu inside modules (we do), but whether it can also be used for
>    kmalloc_percpu.
> 
> I hadn't caught this distinction, and thus I misunderstood what was
> going on here.  Thanks for clarifying.

Right, that makes sense.  If we leave the current implementation as a
"fix it later" thing, I think it's worth changing the interface at
least as per the patch below, so that if we change in future we
haven't promised everyone cacheline alignment.

Andrew?  Linus?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Change kmalloc_percpu interface
Author: Rusty Russell
Status: Experimental

D: kmalloc_percpu is renamed to alloc_percpu, takes a type
D: (__alloc_percpu takes an alignment as well) and zeros memory (most
D: callers want that, and it's not completely trivial), and
D: kfree_percpu renamed to free_percpu.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18029-linux-2.5.69-bk10/include/linux/genhd.h .18029-linux-2.5.69-bk10.updated/include/linux/genhd.h
--- .18029-linux-2.5.69-bk10/include/linux/genhd.h	2003-05-05 12:37:12.000000000 +1000
+++ .18029-linux-2.5.69-bk10.updated/include/linux/genhd.h	2003-05-17 21:33:57.000000000 +1000
@@ -160,16 +160,15 @@ static inline void disk_stat_set_all(str
 #ifdef  CONFIG_SMP
 static inline int init_disk_stats(struct gendisk *disk)
 {
-	disk->dkstats = kmalloc_percpu(sizeof (struct disk_stats), GFP_KERNEL);
+	disk->dkstats = alloc_percpu(struct disk_stats);
 	if (!disk->dkstats)
 		return 0;
-	disk_stat_set_all(disk, 0);
 	return 1;
 }
 
 static inline void free_disk_stats(struct gendisk *disk)
 {
-	kfree_percpu(disk->dkstats);
+	free_percpu(disk->dkstats);
 }
 #else	/* CONFIG_SMP */
 static inline int init_disk_stats(struct gendisk *disk)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18029-linux-2.5.69-bk10/include/linux/percpu.h .18029-linux-2.5.69-bk10.updated/include/linux/percpu.h
--- .18029-linux-2.5.69-bk10/include/linux/percpu.h	2003-02-07 19:20:01.000000000 +1100
+++ .18029-linux-2.5.69-bk10.updated/include/linux/percpu.h	2003-05-17 21:29:49.000000000 +1000
@@ -1,7 +1,7 @@
 #ifndef __LINUX_PERCPU_H
 #define __LINUX_PERCPU_H
 #include <linux/spinlock.h> /* For preempt_disable() */
-#include <linux/slab.h> /* For kmalloc_percpu() */
+#include <linux/slab.h> /* For kmalloc() */
 #include <asm/percpu.h>
 
 /* Must be an lvalue. */
@@ -17,7 +17,7 @@ struct percpu_data {
 
 /* 
  * Use this to get to a cpu's version of the per-cpu object allocated using
- * kmalloc_percpu.  If you want to get "this cpu's version", maybe you want
+ * alloc_percpu.  If you want to get "this cpu's version", maybe you want
  * to use get_cpu_ptr... 
  */ 
 #define per_cpu_ptr(ptr, cpu)                   \
@@ -26,19 +26,22 @@ struct percpu_data {
         (__typeof__(ptr))__p->ptrs[(cpu)];	\
 })
 
-extern void *kmalloc_percpu(size_t size, int flags);
-extern void kfree_percpu(const void *);
+extern void *__alloc_percpu(size_t size, int flags);
+extern void free_percpu(const void *);
 extern void kmalloc_percpu_init(void);
 
 #else /* CONFIG_SMP */
 
 #define per_cpu_ptr(ptr, cpu) (ptr)
 
-static inline void *kmalloc_percpu(size_t size, int flags)
+static inline void *__alloc_percpu(size_t size, size_t align)
 {
-	return(kmalloc(size, flags));
+	void *ret = kmalloc(size, GFP_KERNEL);
+	if (ret)
+		memset(ret, 0, size);
+	return ret;
 }
-static inline void kfree_percpu(const void *ptr)
+static inline void free_percpu(const void *ptr)
 {	
 	kfree(ptr);
 }
@@ -46,9 +49,13 @@ static inline void kmalloc_percpu_init(v
 
 #endif /* CONFIG_SMP */
 
+/* Simple wrapper for the common case: zeros memory. */
+#define alloc_percpu(type) \
+	((type *)(__alloc_percpu(sizeof(type), __alignof__(type))))
+
 /* 
- * Use these with kmalloc_percpu. If
- * 1. You want to operate on memory allocated by kmalloc_percpu (dereference
+ * Use these with alloc_percpu. If
+ * 1. You want to operate on memory allocated by alloc_percpu (dereference
  *    and read/modify/write)  AND 
  * 2. You want "this cpu's version" of the object AND 
  * 3. You want to do this safely since:
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18029-linux-2.5.69-bk10/include/net/ipv6.h .18029-linux-2.5.69-bk10.updated/include/net/ipv6.h
--- .18029-linux-2.5.69-bk10/include/net/ipv6.h	2003-05-16 08:08:43.000000000 +1000
+++ .18029-linux-2.5.69-bk10.updated/include/net/ipv6.h	2003-05-17 21:23:03.000000000 +1000
@@ -145,7 +145,7 @@ extern atomic_t			inet6_sock_nr;
 
 int snmp6_register_dev(struct inet6_dev *idev);
 int snmp6_unregister_dev(struct inet6_dev *idev);
-int snmp6_mib_init(void *ptr[2], size_t mibsize);
+int snmp6_mib_init(void *ptr[2], size_t mibsize, size_t mibalign);
 void snmp6_mib_free(void *ptr[2]);
 
 struct ip6_ra_chain
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18029-linux-2.5.69-bk10/kernel/ksyms.c .18029-linux-2.5.69-bk10.updated/kernel/ksyms.c
--- .18029-linux-2.5.69-bk10/kernel/ksyms.c	2003-05-16 08:08:44.000000000 +1000
+++ .18029-linux-2.5.69-bk10.updated/kernel/ksyms.c	2003-05-17 21:23:03.000000000 +1000
@@ -98,8 +98,8 @@ EXPORT_SYMBOL(remove_shrinker);
 EXPORT_SYMBOL(kmalloc);
 EXPORT_SYMBOL(kfree);
 #ifdef CONFIG_SMP
-EXPORT_SYMBOL(kmalloc_percpu);
-EXPORT_SYMBOL(kfree_percpu);
+EXPORT_SYMBOL(__alloc_percpu);
+EXPORT_SYMBOL(free_percpu);
 EXPORT_SYMBOL(percpu_counter_mod);
 #endif
 EXPORT_SYMBOL(vfree);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18029-linux-2.5.69-bk10/mm/Makefile .18029-linux-2.5.69-bk10.updated/mm/Makefile
--- .18029-linux-2.5.69-bk10/mm/Makefile	2003-02-11 14:26:20.000000000 +1100
+++ .18029-linux-2.5.69-bk10.updated/mm/Makefile	2003-05-17 21:23:03.000000000 +1000
@@ -12,3 +12,4 @@ obj-y			:= bootmem.o filemap.o mempool.o
 			   slab.o swap.o truncate.o vcache.o vmscan.o $(mmu-y)
 
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o
+obj-$(CONFIG_SMP)	+= percpu.o
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18029-linux-2.5.69-bk10/mm/slab.c .18029-linux-2.5.69-bk10.updated/mm/slab.c
--- .18029-linux-2.5.69-bk10/mm/slab.c	2003-05-16 08:08:44.000000000 +1000
+++ .18029-linux-2.5.69-bk10.updated/mm/slab.c	2003-05-17 21:27:45.000000000 +1000
@@ -1939,26 +1939,18 @@ void * kmalloc (size_t size, int flags)
 
 #ifdef CONFIG_SMP
 /**
- * kmalloc_percpu - allocate one copy of the object for every present
- * cpu in the system.
+ * __alloc_percpu - allocate one copy of the object for every present
+ * cpu in the system, zeroing them.
  * Objects should be dereferenced using per_cpu_ptr/get_cpu_ptr
  * macros only.
  *
  * @size: how many bytes of memory are required.
- * @flags: the type of memory to allocate.
- * The @flags argument may be one of:
- *
- * %GFP_USER - Allocate memory on behalf of user.  May sleep.
- *
- * %GFP_KERNEL - Allocate normal kernel ram.  May sleep.
- *
- * %GFP_ATOMIC - Allocation will not sleep.  Use inside interrupt handlers.
+ * @align: the alignment, which can't be greater than SMP_CACHE_BYTES.
  */
-void *
-kmalloc_percpu(size_t size, int flags)
+void *__alloc_percpu(size_t size, size_t align)
 {
 	int i;
-	struct percpu_data *pdata = kmalloc(sizeof (*pdata), flags);
+	struct percpu_data *pdata = kmalloc(sizeof (*pdata), GFP_KERNEL);
 
 	if (!pdata)
 		return NULL;
@@ -1966,9 +1958,10 @@ kmalloc_percpu(size_t size, int flags)
 	for (i = 0; i < NR_CPUS; i++) {
 		if (!cpu_possible(i))
 			continue;
-		pdata->ptrs[i] = kmalloc(size, flags);
+		pdata->ptrs[i] = kmalloc(size, GFP_KERNEL);
 		if (!pdata->ptrs[i])
 			goto unwind_oom;
+		memset(pdata->ptrs[i], 0, size);
 	}
 
 	/* Catch derefs w/o wrappers */
@@ -2025,14 +2018,14 @@ void kfree (const void *objp)
 
 #ifdef CONFIG_SMP
 /**
- * kfree_percpu - free previously allocated percpu memory
- * @objp: pointer returned by kmalloc_percpu.
+ * free_percpu - free previously allocated percpu memory
+ * @objp: pointer returned by alloc_percpu.
  *
- * Don't free memory not originally allocated by kmalloc_percpu()
+ * Don't free memory not originally allocated by alloc_percpu()
  * The complemented objp is to check for that.
  */
 void
-kfree_percpu(const void *objp)
+free_percpu(const void *objp)
 {
 	int i;
 	struct percpu_data *p = (struct percpu_data *) (~(unsigned long) objp);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18029-linux-2.5.69-bk10/net/ipv4/af_inet.c .18029-linux-2.5.69-bk10.updated/net/ipv4/af_inet.c
--- .18029-linux-2.5.69-bk10/net/ipv4/af_inet.c	2003-05-16 08:08:45.000000000 +1000
+++ .18029-linux-2.5.69-bk10.updated/net/ipv4/af_inet.c	2003-05-17 21:23:03.000000000 +1000
@@ -1070,52 +1070,22 @@ static int __init init_ipv4_mibs(void)
 {
 	int i;
 
-	net_statistics[0] =
-	    kmalloc_percpu(sizeof (struct linux_mib), GFP_KERNEL);
-	net_statistics[1] =
-	    kmalloc_percpu(sizeof (struct linux_mib), GFP_KERNEL);
-	ip_statistics[0] = kmalloc_percpu(sizeof (struct ip_mib), GFP_KERNEL);
-	ip_statistics[1] = kmalloc_percpu(sizeof (struct ip_mib), GFP_KERNEL);
-	icmp_statistics[0] =
-	    kmalloc_percpu(sizeof (struct icmp_mib), GFP_KERNEL);
-	icmp_statistics[1] =
-	    kmalloc_percpu(sizeof (struct icmp_mib), GFP_KERNEL);
-	tcp_statistics[0] = kmalloc_percpu(sizeof (struct tcp_mib), GFP_KERNEL);
-	tcp_statistics[1] = kmalloc_percpu(sizeof (struct tcp_mib), GFP_KERNEL);
-	udp_statistics[0] = kmalloc_percpu(sizeof (struct udp_mib), GFP_KERNEL);
-	udp_statistics[1] = kmalloc_percpu(sizeof (struct udp_mib), GFP_KERNEL);
+	net_statistics[0] = alloc_percpu(struct linux_mib);
+	net_statistics[1] = alloc_percpu(struct linux_mib);
+	ip_statistics[0] = alloc_percpu(struct ip_mib);
+	ip_statistics[1] = alloc_percpu(struct ip_mib);
+	icmp_statistics[0] = alloc_percpu(struct icmp_mib);
+	icmp_statistics[1] = alloc_percpu(struct icmp_mib);
+	tcp_statistics[0] = alloc_percpu(struct tcp_mib);
+	tcp_statistics[1] = alloc_percpu(struct tcp_mib);
+	udp_statistics[0] = alloc_percpu(struct udp_mib);
+	udp_statistics[1] = alloc_percpu(struct udp_mib);
 	if (!
 	    (net_statistics[0] && net_statistics[1] && ip_statistics[0]
 	     && ip_statistics[1] && tcp_statistics[0] && tcp_statistics[1]
 	     && udp_statistics[0] && udp_statistics[1]))
 		return -ENOMEM;
 
-	/* Set all the per cpu copies of the mibs to zero */
-	for (i = 0; i < NR_CPUS; i++) {
-		if (cpu_possible(i)) {
-			memset(per_cpu_ptr(net_statistics[0], i), 0,
-			       sizeof (struct linux_mib));
-			memset(per_cpu_ptr(net_statistics[1], i), 0,
-			       sizeof (struct linux_mib));
-			memset(per_cpu_ptr(ip_statistics[0], i), 0,
-			       sizeof (struct ip_mib));
-			memset(per_cpu_ptr(ip_statistics[1], i), 0,
-			       sizeof (struct ip_mib));
-			memset(per_cpu_ptr(icmp_statistics[0], i), 0,
-			       sizeof (struct icmp_mib));
-			memset(per_cpu_ptr(icmp_statistics[1], i), 0,
-			       sizeof (struct icmp_mib));
-			memset(per_cpu_ptr(tcp_statistics[0], i), 0,
-			       sizeof (struct tcp_mib));
-			memset(per_cpu_ptr(tcp_statistics[1], i), 0,
-			       sizeof (struct tcp_mib));
-			memset(per_cpu_ptr(udp_statistics[0], i), 0,
-			       sizeof (struct udp_mib));
-			memset(per_cpu_ptr(udp_statistics[1], i), 0,
-			       sizeof (struct udp_mib));
-		}
-	}
-
 	(void) tcp_mib_init();
 
 	return 0;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18029-linux-2.5.69-bk10/net/ipv4/route.c .18029-linux-2.5.69-bk10.updated/net/ipv4/route.c
--- .18029-linux-2.5.69-bk10/net/ipv4/route.c	2003-05-16 08:08:46.000000000 +1000
+++ .18029-linux-2.5.69-bk10.updated/net/ipv4/route.c	2003-05-17 21:23:03.000000000 +1000
@@ -2692,16 +2692,9 @@ int __init ip_rt_init(void)
 	ipv4_dst_ops.gc_thresh = (rt_hash_mask + 1);
 	ip_rt_max_size = (rt_hash_mask + 1) * 16;
 
-	rt_cache_stat = kmalloc_percpu(sizeof (struct rt_cache_stat),
-					GFP_KERNEL);
+	rt_cache_stat = alloc_percpu(struct rt_cache_stat);
 	if (!rt_cache_stat) 
 		goto out_enomem1;
-	for (i = 0; i < NR_CPUS; i++) {
-		if (cpu_possible(i)) {
-			memset(per_cpu_ptr(rt_cache_stat, i), 0,
-			       sizeof (struct rt_cache_stat));
-		}
-	}
 
 	devinet_init();
 	ip_fib_init();
@@ -2737,7 +2730,7 @@ int __init ip_rt_init(void)
 out:
 	return rc;
 out_enomem:
-	kfree_percpu(rt_cache_stat);
+	free_percpu(rt_cache_stat);
 out_enomem1:
 	rc = -ENOMEM;
 	goto out;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18029-linux-2.5.69-bk10/net/ipv6/af_inet6.c .18029-linux-2.5.69-bk10.updated/net/ipv6/af_inet6.c
--- .18029-linux-2.5.69-bk10/net/ipv6/af_inet6.c	2003-05-16 08:08:47.000000000 +1000
+++ .18029-linux-2.5.69-bk10.updated/net/ipv6/af_inet6.c	2003-05-17 21:23:03.000000000 +1000
@@ -637,32 +637,25 @@ inet6_unregister_protosw(struct inet_pro
 }
 
 int
-snmp6_mib_init(void *ptr[2], size_t mibsize)
+snmp6_mib_init(void *ptr[2], size_t mibsize, size_t mibalign)
 {
 	int i;
 
 	if (ptr == NULL)
 		return -EINVAL;
 
-	ptr[0] = kmalloc_percpu(mibsize, GFP_KERNEL);
+	ptr[0] = __alloc_percpu(mibsize, mibalign);
 	if (!ptr[0])
 		goto err0;
 
-	ptr[1] = kmalloc_percpu(mibsize, GFP_KERNEL);
+	ptr[1] = __alloc_percpu(mibsize, mibalign);
 	if (!ptr[1])
 		goto err1;
 
-	/* Zero percpu version of the mibs */
-	for (i = 0; i < NR_CPUS; i++) {
-		if (cpu_possible(i)) {
-			memset(per_cpu_ptr(ptr[0], i), 0, mibsize);
-			memset(per_cpu_ptr(ptr[1], i), 0, mibsize);
-		}
-	}
 	return 0;
 
 err1:
-	kfree_percpu(ptr[0]);
+	free_percpu(ptr[0]);
 	ptr[0] = NULL;
 err0:
 	return -ENOMEM;
@@ -673,18 +666,21 @@ snmp6_mib_free(void *ptr[2])
 {
 	if (ptr == NULL)
 		return;
-	kfree_percpu(ptr[0]);
-	kfree_percpu(ptr[1]);
+	free_percpu(ptr[0]);
+	free_percpu(ptr[1]);
 	ptr[0] = ptr[1] = NULL;
 }
 
 static int __init init_ipv6_mibs(void)
 {
-	if (snmp6_mib_init((void **)ipv6_statistics, sizeof (struct ipv6_mib)) < 0)
+	if (snmp6_mib_init((void **)ipv6_statistics, sizeof (struct ipv6_mib),
+			   __alignof__(struct ipv6_mib)) < 0)
 		goto err_ip_mib;
-	if (snmp6_mib_init((void **)icmpv6_statistics, sizeof (struct icmpv6_mib)) < 0)
+	if (snmp6_mib_init((void **)icmpv6_statistics, sizeof (struct icmpv6_mib),
+			   __alignof__(struct ipv6_mib)) < 0)
 		goto err_icmp_mib;
-	if (snmp6_mib_init((void **)udp_stats_in6, sizeof (struct udp_mib)) < 0)
+	if (snmp6_mib_init((void **)udp_stats_in6, sizeof (struct udp_mib),
+			   __alignof__(struct ipv6_mib)) < 0)
 		goto err_udp_mib;
 	return 0;
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18029-linux-2.5.69-bk10/net/ipv6/proc.c .18029-linux-2.5.69-bk10.updated/net/ipv6/proc.c
--- .18029-linux-2.5.69-bk10/net/ipv6/proc.c	2003-05-16 08:08:47.000000000 +1000
+++ .18029-linux-2.5.69-bk10.updated/net/ipv6/proc.c	2003-05-17 21:23:03.000000000 +1000
@@ -228,7 +228,8 @@ int snmp6_register_dev(struct inet6_dev 
 	if (!idev || !idev->dev)
 		return -EINVAL;
 
-	if (snmp6_mib_init((void **)idev->stats.icmpv6, sizeof(struct icmpv6_mib)) < 0)
+	if (snmp6_mib_init((void **)idev->stats.icmpv6, sizeof(struct icmpv6_mib),
+			   __alignof__(struct ipv6_mib)) < 0)
 		goto err_icmp;
 
 #ifdef CONFIG_PROC_FS
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18029-linux-2.5.69-bk10/net/sctp/protocol.c .18029-linux-2.5.69-bk10.updated/net/sctp/protocol.c
--- .18029-linux-2.5.69-bk10/net/sctp/protocol.c	2003-05-16 08:08:49.000000000 +1000
+++ .18029-linux-2.5.69-bk10.updated/net/sctp/protocol.c	2003-05-17 21:23:03.000000000 +1000
@@ -880,34 +880,22 @@ static int __init init_sctp_mibs(void)
 {
 	int i;
 
-	sctp_statistics[0] = kmalloc_percpu(sizeof (struct sctp_mib),
-					    GFP_KERNEL);
+	sctp_statistics[0] = alloc_percpu(struct sctp_mib);
 	if (!sctp_statistics[0])
 		return -ENOMEM;
-	sctp_statistics[1] = kmalloc_percpu(sizeof (struct sctp_mib),
-					    GFP_KERNEL);
+	sctp_statistics[1] = alloc_percpu(struct sctp_mib);
 	if (!sctp_statistics[1]) {
-		kfree_percpu(sctp_statistics[0]);
+		free_percpu(sctp_statistics[0]);
 		return -ENOMEM;
 	}
-
-	/* Zero all percpu versions of the mibs */
-	for (i = 0; i < NR_CPUS; i++) {
-		if (cpu_possible(i)) {
-			memset(per_cpu_ptr(sctp_statistics[0], i), 0,
-					sizeof (struct sctp_mib));
-			memset(per_cpu_ptr(sctp_statistics[1], i), 0,
-					sizeof (struct sctp_mib));
-		}
-	}
 	return 0;
 
 }
 
 static void cleanup_sctp_mibs(void)
 {
-	kfree_percpu(sctp_statistics[0]);
-	kfree_percpu(sctp_statistics[1]);
+	free_percpu(sctp_statistics[0]);
+	free_percpu(sctp_statistics[1]);
 }
 
 /* Initialize the universe into something sensible.  */
