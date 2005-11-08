Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030213AbVKHAwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030213AbVKHAwN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 19:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030215AbVKHAwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 19:52:13 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:53653 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030213AbVKHAwL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 19:52:11 -0500
Message-ID: <436FF6B3.3050901@us.ibm.com>
Date: Mon, 07 Nov 2005 16:52:03 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kernel-janitors@lists.osdl.org
CC: Pekka J Enberg <penberg@cs.Helsinki.FI>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] Fix alloc_percpu()'s args
References: <436FF51D.8080509@us.ibm.com>
In-Reply-To: <436FF51D.8080509@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------050103090809000300090708"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050103090809000300090708
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

We don't actually ever use the 'align' parameter, so drop it.

mcd@arrakis:~/linux/source/linux-2.6.14+slab_cleanup/patches $ diffstat
alloc_percpu.patch
 include/linux/percpu.h |    7 +++----
 mm/slab.c              |   10 +++-------
 net/ipv6/af_inet6.c    |    4 ++--
 3 files changed, 8 insertions(+), 13 deletions(-)

-Matt

--------------050103090809000300090708
Content-Type: text/x-patch;
 name="alloc_percpu.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alloc_percpu.patch"

__alloc_percpu and alloc_percpu both take an 'align' argument which is
completely ignored.  snmp6_mib_init() in net/ipv6/af_inet6.c attempts to
use it, but it will be ignored.  Therefore, remove the 'align' argument
and fixup the lone caller.

Also, remove an unnecessary cpu_possible check in the oom_unwind loop since
kfree() is happy to ignore NULL pointers passed to it.

Index: linux-2.6.14+slab_cleanup/include/linux/percpu.h
===================================================================
--- linux-2.6.14+slab_cleanup.orig/include/linux/percpu.h	2005-11-07 15:58:05.640293976 -0800
+++ linux-2.6.14+slab_cleanup/include/linux/percpu.h	2005-11-07 15:58:48.540772112 -0800
@@ -33,14 +33,14 @@ struct percpu_data {
         (__typeof__(ptr))__p->ptrs[(cpu)];	\
 })
 
-extern void *__alloc_percpu(size_t size, size_t align);
+extern void *__alloc_percpu(size_t size);
 extern void free_percpu(const void *);
 
 #else /* CONFIG_SMP */
 
 #define per_cpu_ptr(ptr, cpu) (ptr)
 
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
Index: linux-2.6.14+slab_cleanup/mm/slab.c
===================================================================
--- linux-2.6.14+slab_cleanup.orig/mm/slab.c	2005-11-07 15:58:46.313110768 -0800
+++ linux-2.6.14+slab_cleanup/mm/slab.c	2005-11-07 15:58:48.547771048 -0800
@@ -2952,12 +2952,11 @@ EXPORT_SYMBOL(__kmalloc);
  * Objects should be dereferenced using the per_cpu_ptr macro only.
  *
  * @size: how many bytes of memory are required.
- * @align: the alignment, which can't be greater than SMP_CACHE_BYTES.
  */
-void *__alloc_percpu(size_t size, size_t align)
+void *__alloc_percpu(size_t size)
 {
 	int i;
-	struct percpu_data *pdata = kmalloc(sizeof(*pdata), GFP_KERNEL);
+	struct percpu_data *pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
 
 	if (!pdata)
 		return NULL;
@@ -2984,11 +2983,8 @@ void *__alloc_percpu(size_t size, size_t
 	return (void *) (~(unsigned long) pdata);
 
 unwind_oom:
-	while (--i >= 0) {
-		if (!cpu_possible(i))
-			continue;
+	while (--i >= 0)
 		kfree(pdata->ptrs[i]);
-	}
 	kfree(pdata);
 	return NULL;
 }
Index: linux-2.6.14+slab_cleanup/net/ipv6/af_inet6.c
===================================================================
--- linux-2.6.14+slab_cleanup.orig/net/ipv6/af_inet6.c	2005-11-07 15:58:05.641293824 -0800
+++ linux-2.6.14+slab_cleanup/net/ipv6/af_inet6.c	2005-11-07 15:58:48.549770744 -0800
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
 

--------------050103090809000300090708--
