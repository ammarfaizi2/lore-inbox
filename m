Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbVKJX7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbVKJX7y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 18:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbVKJX7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 18:59:54 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:15086 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932225AbVKJX7x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 18:59:53 -0500
Message-ID: <4373DEF4.60100@us.ibm.com>
Date: Thu, 10 Nov 2005 15:59:48 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kernel-janitors@lists.osdl.org
CC: manfred@colorfullife.com, Pekka J Enberg <penberg@cs.Helsinki.FI>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] Fix alloc_percpu's args
References: <4373DD82.8010606@us.ibm.com>
In-Reply-To: <4373DD82.8010606@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------040908040300090006090606"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040908040300090006090606
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

alloc_percpu takes an 'align' argument that is completely ignored.  Remove it.

-Matt

--------------040908040300090006090606
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

Signed-off-by: Matthew Dobson <colpatch@us.ibm.com>

Index: linux-2.6.14+slab_cleanup/include/linux/percpu.h
===================================================================
--- linux-2.6.14+slab_cleanup.orig/include/linux/percpu.h	2005-11-10 11:09:37.549880584 -0800
+++ linux-2.6.14+slab_cleanup/include/linux/percpu.h	2005-11-10 11:43:40.218347776 -0800
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
--- linux-2.6.14+slab_cleanup.orig/mm/slab.c	2005-11-10 11:43:36.926848160 -0800
+++ linux-2.6.14+slab_cleanup/mm/slab.c	2005-11-10 11:43:40.223347016 -0800
@@ -2957,12 +2957,11 @@ EXPORT_SYMBOL(__kmalloc);
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
@@ -2989,11 +2988,8 @@ void *__alloc_percpu(size_t size, size_t
 	return (void *)(~(unsigned long) pdata);
 
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
--- linux-2.6.14+slab_cleanup.orig/net/ipv6/af_inet6.c	2005-11-10 11:09:37.550880432 -0800
+++ linux-2.6.14+slab_cleanup/net/ipv6/af_inet6.c	2005-11-10 11:43:40.224346864 -0800
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
 

--------------040908040300090006090606--
