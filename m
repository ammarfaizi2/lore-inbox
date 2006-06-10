Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161004AbWFJTfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161004AbWFJTfS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 15:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161003AbWFJTfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 15:35:18 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:23237 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030503AbWFJTfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 15:35:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=DuG9/twg8IKiDoK5sqRLplzq9IKHIm+JswjZFz1/Ds8PzK0PGUaQQduL/FSLCqnG7px7Ai4ZIavtDALIdRwU3bz7F6BmW6XCcWUi+4S7YupE4MPt/1qwQAL1tTQpd+bDIOBAgNhywzkkUfuP6Vt8pxWfnW9e8xZ354I0IWz7cVY=
Date: Sat, 10 Jun 2006 23:39:42 +0400
From: Paul Drynoff <pauldrynoff@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kmalloc, kzalloc comments cleanup and fix
Message-Id: <20060610233942.6c96f557.pauldrynoff@gmail.com>
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.12; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that previous patch was lost, so I resent patch,
I also folded Randy Dunlap <rdunlap@xenotime.net>'s patch to make things more simple.

Changes:
1)Move comments for kmalloc to right place, currently it near __do_kmalloc
2)Comments for kzalloc
3)More detailed comments for kmalloc
4)Appearance of "kmalloc" and "kzalloc" man pages after "make mandocs"

Signed-off-by: Paul Drynoff <pauldrynoff@gmail.com>

---

Index: linux-2.6.17-rc6-mm1/mm/slab.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/slab.c
+++ linux-2.6.17-rc6-mm1/mm/slab.c
@@ -3317,26 +3317,10 @@ EXPORT_SYMBOL(kmalloc_node);
 #endif
 
 /**
- * kmalloc - allocate memory
+ * __do_kmalloc - allocate memory
  * @size: how many bytes of memory are required.
- * @flags: the type of memory to allocate.
+ * @flags: the type of memory to allocate (see kmalloc).
  * @caller: function caller for debug tracking of the caller
- *
- * kmalloc is the normal method of allocating memory
- * in the kernel.
- *
- * The @flags argument may be one of:
- *
- * %GFP_USER - Allocate memory on behalf of user.  May sleep.
- *
- * %GFP_KERNEL - Allocate normal kernel ram.  May sleep.
- *
- * %GFP_ATOMIC - Allocation will not sleep.  Use inside interrupt handlers.
- *
- * Additionally, the %GFP_DMA flag may be set to indicate the memory
- * must be suitable for DMA.  This can mean different things on different
- * platforms.  For example, on i386, it means that the memory must come
- * from the first 16MB.
  */
 static __always_inline void *__do_kmalloc(size_t size, gfp_t flags,
 					  void *caller)
Index: linux-2.6.17-rc6-mm1/include/linux/slab.h
===================================================================
--- linux-2.6.17-rc6-mm1.orig/include/linux/slab.h
+++ linux-2.6.17-rc6-mm1/include/linux/slab.h
@@ -86,6 +86,51 @@ extern void *__kmalloc_track_caller(size
     __kmalloc_track_caller(size, flags, __builtin_return_address(0))
 #endif
 
+/**
+ * kmalloc - allocate memory
+ * @size: how many bytes of memory are required.
+ * @flags: the type of memory to allocate.
+ *
+ * kmalloc is the normal method of allocating memory
+ * in the kernel.
+ *
+ * The @flags argument may be one of:
+ *
+ * %GFP_USER - Allocate memory on behalf of user.  May sleep.
+ *
+ * %GFP_KERNEL - Allocate normal kernel ram.  May sleep.
+ *
+ * %GFP_ATOMIC - Allocation will not sleep.
+ *   For example, use this inside interrupt handlers.
+ *
+ * %GFP_HIGHUSER - Allocate pages from high memory.
+ *
+ * %GFP_NOIO - Do not do any I/O at all while trying to get memory.
+ *
+ * %GFP_NOFS - Do not make any fs calls while trying to get memory.
+ *
+ * Also it is possible to set different flags by OR'ing
+ * in one or more of the following additional @flags:
+ *
+ * %__GFP_COLD - Request cache-cold pages instead of
+ *   trying to return cache-warm pages.
+ *
+ * %__GFP_DMA - Request memory from the DMA-capable zone.
+ *
+ * %__GFP_HIGH - This allocation has high priority and may use emergency pools.
+ *
+ * %__GFP_HIGHMEM - Allocated memory may be from highmem.
+ *
+ * %__GFP_NOFAIL - Indicate that this allocation is in no way allowed to fail
+ *   (think twice before using).
+ *
+ * %__GFP_NORETRY - If memory is not immediately available,
+ *   then give up at once.
+ *
+ * %__GFP_NOWARN - If allocation fails, don't issue any warnings.
+ *
+ * %__GFP_REPEAT - If allocation fails initially, try once more before failing.
+ */
 static inline void *kmalloc(size_t size, gfp_t flags)
 {
 	if (__builtin_constant_p(size)) {
@@ -111,6 +156,11 @@ found:
 
 extern void *__kzalloc(size_t, gfp_t);
 
+/**
+ * kzalloc - allocate memory. The memory is set to zero.
+ * @size: how many bytes of memory are required.
+ * @flags: the type of memory to allocate (see kmalloc).
+ */
 static inline void *kzalloc(size_t size, gfp_t flags)
 {
 	if (__builtin_constant_p(size)) {
Index: linux-2.6.17-rc6-mm1/Documentation/DocBook/kernel-api.tmpl
===================================================================
--- linux-2.6.17-rc6-mm1.orig/Documentation/DocBook/kernel-api.tmpl
+++ linux-2.6.17-rc6-mm1/Documentation/DocBook/kernel-api.tmpl
@@ -117,6 +117,7 @@ X!Ilib/string.c
   <chapter id="mm">
      <title>Memory Management in Linux</title>
      <sect1><title>The Slab Cache</title>
+!Iinclude/linux/slab.h
 !Emm/slab.c
      </sect1>
      <sect1><title>User Space Memory Access</title>
