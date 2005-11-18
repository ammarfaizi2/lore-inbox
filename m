Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030216AbVKRR0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030216AbVKRR0G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 12:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbVKRR0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 12:26:06 -0500
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:20431 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S932332AbVKRR0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 12:26:04 -0500
Subject: [PATCH 2/5] slab: remove unused align parameter from alloc_percpu
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, colpatch@us.ibm.com,
       manfred@colorfullife.com
Content-Type: text/plain
Message-Id: <iq5uu6.r1w80m.fi2lra14o0wdqqk5ln4hwlcm.beaver@cs.helsinki.fi>
In-Reply-To: <iq5uu1.87bo1s.3tcvszwr6pjjr4ngr04pw358p.beaver@cs.helsinki.fi>
Date: Fri, 18 Nov 2005 19:20:30 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


__alloc_percpu and alloc_percpu both take an 'align' argument which is
completely ignored.  snmp6_mib_init() in net/ipv6/af_inet6.c attempts to
use it, but it will be ignored.  Therefore, remove the 'align' argument
and fixup the lone caller.

Signed-off-by: Matthew Dobson <colpatch@us.ibm.com>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 include/linux/percpu.h |    7 +++----
 mm/slab.c              |    3 +--
 net/ipv6/af_inet6.c    |    4 ++--
 3 files changed, 6 insertions(+), 8 deletions(-)

Index: 2.6/include/linux/percpu.h
===================================================================
--- 2.6.orig/include/linux/percpu.h
+++ 2.6/include/linux/percpu.h
@@ -33,14 +33,14 @@ struct percpu_data {
         (__typeof__(ptr))__p->ptrs[(cpu)];	\
 })
 
-extern void *__alloc_percpu(size_t size, size_t align);
+extern void *__alloc_percpu(size_t size);
 extern void free_percpu(const void *);
 
 #else /* CONFIG_SMP */
 
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); (ptr); })
 
-static inline void *__alloc_percpu(size_t size, size_t align)
+static inline void *__alloc_percpu(size_t size)
 {
 	void *ret = kmalloc(size, GFP_KERNEL);
 	if (ret)
@@ -55,7 +55,6 @@ static inline void free_percpu(const voi
 #endif /* CONFIG_SMP */
 
 /* Simple wrapper for the common case: zeros memory. */
-#define alloc_percpu(type) \
-	((type *)(__alloc_percpu(sizeof(type), __alignof__(type))))
+#define alloc_percpu(type)	((type *)(__alloc_percpu(sizeof(type))))
 
 #endif /* __LINUX_PERCPU_H */
Index: 2.6/mm/slab.c
===================================================================
--- 2.6.orig/mm/slab.c
+++ 2.6/mm/slab.c
@@ -2949,9 +2949,8 @@ EXPORT_SYMBOL(__kmalloc);
  * Objects should be dereferenced using the per_cpu_ptr macro only.
  *
  * @size: how many bytes of memory are required.
- * @align: the alignment, which can't be greater than SMP_CACHE_BYTES.
  */
-void *__alloc_percpu(size_t size, size_t align)
+void *__alloc_percpu(size_t size)
 {
 	int i;
 	struct percpu_data *pdata = kmalloc(sizeof (*pdata), GFP_KERNEL);
Index: 2.6/net/ipv6/af_inet6.c
===================================================================
--- 2.6.orig/net/ipv6/af_inet6.c
+++ 2.6/net/ipv6/af_inet6.c
@@ -596,11 +596,11 @@ snmp6_mib_init(void *ptr[2], size_t mibs
 	if (ptr == NULL)
 		return -EINVAL;
 
-	ptr[0] = __alloc_percpu(mibsize, mibalign);
+	ptr[0] = __alloc_percpu(mibsize);
 	if (!ptr[0])
 		goto err0;
 
-	ptr[1] = __alloc_percpu(mibsize, mibalign);
+	ptr[1] = __alloc_percpu(mibsize);
 	if (!ptr[1])
 		goto err1;
 
