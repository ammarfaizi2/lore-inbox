Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261669AbVEJPRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbVEJPRZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 11:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbVEJPQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 11:16:50 -0400
Received: from schlund.terranet.ro ([80.96.218.84]:39998 "EHLO
	dizzywork.schlund.ro") by vger.kernel.org with ESMTP
	id S261672AbVEJPNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 11:13:37 -0400
Message-ID: <4280CF9C.6010208@schlund.ro>
Date: Tue, 10 May 2005 18:13:32 +0300
From: Mihai Rusu <dizzy@schlund.ro>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Robert Love <rml@novell.com>
Subject: [RFC][PATCH 2.4 2/4] inotify 0.22 2.4.x backport - idr
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------050604030503070801070505"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050604030503070801070505
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi

Copied idr.[ch] from 2.6.11 with one modification: replaced the
__clear_bit() calls with clear_bit() (__clear_bit() is not available and
I didn't wanted to have one more architecture specific backport, see the
atomic_inc_return patch). As far as I can see __clear_bit() misses a
"lock" on x86. I don't know if the overhead is big or not...

This is needed by "inotify.c".

-- 
Mihai Rusu
Linux System Development

Schlund + Partner AG   Tel         : +40-21-231-2544
Str Mircea Eliade 18   EMail       : dizzy@schlund.ro
Sect 1, Bucuresti
71295, Romania




--------------050604030503070801070505
Content-Type: text/x-patch;
 name="02_idr-2.4.30.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="02_idr-2.4.30.patch"


 include/linux/idr.h |   78 +++++++++
 lib/Makefile        |    4 
 lib/idr.c           |  409 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 489 insertions(+), 2 deletions(-)


diff -uNr linux-2.4.30.orig/include/linux/idr.h linux-2.4.30/include/linux/idr.h
--- linux-2.4.30.orig/include/linux/idr.h	1970-01-01 02:00:00.000000000 +0200
+++ linux-2.4.30/include/linux/idr.h	2005-05-09 11:58:56.000000000 +0300
@@ -0,0 +1,78 @@
+/*
+ * include/linux/idr.h
+ * 
+ * 2002-10-18  written by Jim Houston jim.houston@ccur.com
+ *	Copyright (C) 2002 by Concurrent Computer Corporation
+ *	Distributed under the GNU GPL license version 2.
+ *
+ * Small id to pointer translation service avoiding fixed sized
+ * tables.
+ */
+#include <linux/types.h>
+#include <linux/bitops.h>
+
+#if BITS_PER_LONG == 32
+# define IDR_BITS 5
+# define IDR_FULL 0xfffffffful
+/* We can only use two of the bits in the top level because there is
+   only one possible bit in the top level (5 bits * 7 levels = 35
+   bits, but you only use 31 bits in the id). */
+# define TOP_LEVEL_FULL (IDR_FULL >> 30)
+#elif BITS_PER_LONG == 64
+# define IDR_BITS 6
+# define IDR_FULL 0xfffffffffffffffful
+/* We can only use two of the bits in the top level because there is
+   only one possible bit in the top level (6 bits * 6 levels = 36
+   bits, but you only use 31 bits in the id). */
+# define TOP_LEVEL_FULL (IDR_FULL >> 62)
+#else
+# error "BITS_PER_LONG is not 32 or 64"
+#endif
+
+#define IDR_SIZE (1 << IDR_BITS)
+#define IDR_MASK ((1 << IDR_BITS)-1)
+
+#define MAX_ID_SHIFT (sizeof(int)*8 - 1)
+#define MAX_ID_BIT (1U << MAX_ID_SHIFT)
+#define MAX_ID_MASK (MAX_ID_BIT - 1)
+
+/* Leave the possibility of an incomplete final layer */
+#define MAX_LEVEL (MAX_ID_SHIFT + IDR_BITS - 1) / IDR_BITS
+
+/* Number of id_layer structs to leave in free list */
+#define IDR_FREE_MAX MAX_LEVEL + MAX_LEVEL
+
+struct idr_layer {
+	unsigned long		 bitmap; /* A zero bit means "space here" */
+	struct idr_layer	*ary[1<<IDR_BITS];
+	int			 count;	 /* When zero, we can release it */
+};
+
+struct idr {
+	struct idr_layer *top;
+	struct idr_layer *id_free;
+	int		  layers;
+	int		  id_free_cnt;
+	spinlock_t	  lock;
+};
+
+#define IDR_INIT(name)						\
+{								\
+	.top		= NULL,					\
+	.id_free	= NULL,					\
+	.layers 	= 0,					\
+	.id_free_cnt	= 0,					\
+	.lock		= SPIN_LOCK_UNLOCKED,			\
+}
+#define DEFINE_IDR(name)	struct idr name = IDR_INIT(name)
+
+/*
+ * This is what we export.
+ */
+
+void *idr_find(struct idr *idp, int id);
+int idr_pre_get(struct idr *idp, unsigned gfp_mask);
+int idr_get_new(struct idr *idp, void *ptr, int *id);
+int idr_get_new_above(struct idr *idp, void *ptr, int starting_id, int *id);
+void idr_remove(struct idr *idp, int id);
+void idr_init(struct idr *idp);
diff -uNr linux-2.4.30.orig/lib/Makefile linux-2.4.30/lib/Makefile
--- linux-2.4.30.orig/lib/Makefile	2005-05-09 13:55:46.000000000 +0300
+++ linux-2.4.30/lib/Makefile	2005-05-09 13:55:59.000000000 +0300
@@ -9,10 +9,10 @@
 L_TARGET := lib.a
 
 export-objs := cmdline.o dec_and_lock.o rwsem-spinlock.o rwsem.o \
-	       rbtree.o crc32.o firmware_class.o
+	       rbtree.o crc32.o firmware_class.o idr.o
 
 obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o \
-	 bust_spinlocks.o rbtree.o dump_stack.o find_next_bit.o
+	 bust_spinlocks.o rbtree.o dump_stack.o find_next_bit.o idr.o
 
 obj-$(CONFIG_FW_LOADER) += firmware_class.o
 obj-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
diff -uNr linux-2.4.30.orig/lib/idr.c linux-2.4.30/lib/idr.c
--- linux-2.4.30.orig/lib/idr.c	1970-01-01 02:00:00.000000000 +0200
+++ linux-2.4.30/lib/idr.c	2005-05-09 11:58:56.000000000 +0300
@@ -0,0 +1,409 @@
+/*
+ * 2002-10-18  written by Jim Houston jim.houston@ccur.com
+ *	Copyright (C) 2002 by Concurrent Computer Corporation
+ *	Distributed under the GNU GPL license version 2.
+ *
+ * Modified by George Anzinger to reuse immediately and to use
+ * find bit instructions.  Also removed _irq on spinlocks.
+ *
+ * Small id to pointer translation service.  
+ *
+ * It uses a radix tree like structure as a sparse array indexed 
+ * by the id to obtain the pointer.  The bitmap makes allocating
+ * a new id quick.  
+ *
+ * You call it to allocate an id (an int) an associate with that id a
+ * pointer or what ever, we treat it as a (void *).  You can pass this
+ * id to a user for him to pass back at a later time.  You then pass
+ * that id to this code and it returns your pointer.
+
+ * You can release ids at any time. When all ids are released, most of 
+ * the memory is returned (we keep IDR_FREE_MAX) in a local pool so we
+ * don't need to go to the memory "store" during an id allocate, just 
+ * so you don't need to be too concerned about locking and conflicts
+ * with the slab allocator.
+ */
+
+#ifndef TEST                        // to test in user space...
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#endif
+#include <linux/bitops.h>
+#include <linux/string.h>
+#include <linux/idr.h>
+
+static kmem_cache_t *idr_layer_cache;
+
+static struct idr_layer *alloc_layer(struct idr *idp)
+{
+	struct idr_layer *p;
+
+	spin_lock(&idp->lock);
+	if ((p = idp->id_free)) {
+		idp->id_free = p->ary[0];
+		idp->id_free_cnt--;
+		p->ary[0] = NULL;
+	}
+	spin_unlock(&idp->lock);
+	return(p);
+}
+
+static void free_layer(struct idr *idp, struct idr_layer *p)
+{
+	/*
+	 * Depends on the return element being zeroed.
+	 */
+	spin_lock(&idp->lock);
+	p->ary[0] = idp->id_free;
+	idp->id_free = p;
+	idp->id_free_cnt++;
+	spin_unlock(&idp->lock);
+}
+
+/**
+ * idr_pre_get - reserver resources for idr allocation
+ * @idp:	idr handle
+ * @gfp_mask:	memory allocation flags
+ *
+ * This function should be called prior to locking and calling the
+ * following function.  It preallocates enough memory to satisfy
+ * the worst possible allocation.
+ *
+ * If the system is REALLY out of memory this function returns 0,
+ * otherwise 1.
+ */
+int idr_pre_get(struct idr *idp, unsigned gfp_mask)
+{
+	while (idp->id_free_cnt < IDR_FREE_MAX) {
+		struct idr_layer *new;
+		new = kmem_cache_alloc(idr_layer_cache, gfp_mask);
+		if(new == NULL)
+			return (0);
+		free_layer(idp, new);
+	}
+	return 1;
+}
+EXPORT_SYMBOL(idr_pre_get);
+
+static int sub_alloc(struct idr *idp, void *ptr, int *starting_id)
+{
+	int n, m, sh;
+	struct idr_layer *p, *new;
+	struct idr_layer *pa[MAX_LEVEL];
+	int l, id;
+	long bm;
+
+	id = *starting_id;
+	p = idp->top;
+	l = idp->layers;
+	pa[l--] = NULL;
+	while (1) {
+		/*
+		 * We run around this while until we reach the leaf node...
+		 */
+		n = (id >> (IDR_BITS*l)) & IDR_MASK;
+		bm = ~p->bitmap;
+		m = find_next_bit(&bm, IDR_SIZE, n);
+		if (m == IDR_SIZE) {
+			/* no space available go back to previous layer. */
+			l++;
+			id = (id | ((1 << (IDR_BITS*l))-1)) + 1;
+			if (!(p = pa[l])) {
+				*starting_id = id;
+				return -2;
+			}
+			continue;
+		}
+		if (m != n) {
+			sh = IDR_BITS*l;
+			id = ((id >> sh) ^ n ^ m) << sh;
+		}
+		if ((id >= MAX_ID_BIT) || (id < 0))
+			return -3;
+		if (l == 0)
+			break;
+		/*
+		 * Create the layer below if it is missing.
+		 */
+		if (!p->ary[m]) {
+			if (!(new = alloc_layer(idp)))
+				return -1;
+			p->ary[m] = new;
+			p->count++;
+		}
+		pa[l--] = p;
+		p = p->ary[m];
+	}
+	/*
+	 * We have reached the leaf node, plant the
+	 * users pointer and return the raw id.
+	 */
+	p->ary[m] = (struct idr_layer *)ptr;
+	__set_bit(m, &p->bitmap);
+	p->count++;
+	/*
+	 * If this layer is full mark the bit in the layer above
+	 * to show that this part of the radix tree is full.
+	 * This may complete the layer above and require walking
+	 * up the radix tree.
+	 */
+	n = id;
+	while (p->bitmap == IDR_FULL) {
+		if (!(p = pa[++l]))
+			break;
+		n = n >> IDR_BITS;
+		__set_bit((n & IDR_MASK), &p->bitmap);
+	}
+	return(id);
+}
+
+static int idr_get_new_above_int(struct idr *idp, void *ptr, int starting_id)
+{
+	struct idr_layer *p, *new;
+	int layers, v, id;
+	
+	id = starting_id;
+build_up:
+	p = idp->top;
+	layers = idp->layers;
+	if (unlikely(!p)) {
+		if (!(p = alloc_layer(idp)))
+			return -1;
+		layers = 1;
+	}
+	/*
+	 * Add a new layer to the top of the tree if the requested
+	 * id is larger than the currently allocated space.
+	 */
+	while ((layers < MAX_LEVEL) && (id >= (1 << (layers*IDR_BITS)))) {
+		layers++;
+		if (!p->count)
+			continue;
+		if (!(new = alloc_layer(idp))) {
+			/*
+			 * The allocation failed.  If we built part of
+			 * the structure tear it down.
+			 */
+			for (new = p; p && p != idp->top; new = p) {
+				p = p->ary[0];
+				new->ary[0] = NULL;
+				new->bitmap = new->count = 0;
+				free_layer(idp, new);
+			}
+			return -1;
+		}
+		new->ary[0] = p;
+		new->count = 1;
+		if (p->bitmap == IDR_FULL)
+			__set_bit(0, &new->bitmap);
+		p = new;
+	}
+	idp->top = p;
+	idp->layers = layers;
+	v = sub_alloc(idp, ptr, &id);
+	if (v == -2)
+		goto build_up;
+	return(v);
+}
+
+/**
+ * idr_get_new_above - allocate new idr entry above a start id
+ * @idp: idr handle
+ * @ptr: pointer you want associated with the ide
+ * @start_id: id to start search at
+ * @id: pointer to the allocated handle
+ *
+ * This is the allocate id function.  It should be called with any
+ * required locks.
+ *
+ * If memory is required, it will return -EAGAIN, you should unlock
+ * and go back to the idr_pre_get() call.  If the idr is full, it will
+ * return -ENOSPC.
+ *
+ * @id returns a value in the range 0 ... 0x7fffffff
+ */
+int idr_get_new_above(struct idr *idp, void *ptr, int starting_id, int *id)
+{
+	int rv;
+	rv = idr_get_new_above_int(idp, ptr, starting_id);
+	/*
+	 * This is a cheap hack until the IDR code can be fixed to
+	 * return proper error values.
+	 */
+	if (rv < 0) {
+		if (rv == -1)
+			return -EAGAIN;
+		else /* Will be -3 */
+			return -ENOSPC;
+	}
+	*id = rv;
+	return 0;
+}
+EXPORT_SYMBOL(idr_get_new_above);
+
+/**
+ * idr_get_new - allocate new idr entry
+ * @idp: idr handle
+ * @ptr: pointer you want associated with the ide
+ * @id: pointer to the allocated handle
+ *
+ * This is the allocate id function.  It should be called with any
+ * required locks.
+ *
+ * If memory is required, it will return -EAGAIN, you should unlock
+ * and go back to the idr_pre_get() call.  If the idr is full, it will
+ * return -ENOSPC.
+ *
+ * @id returns a value in the range 0 ... 0x7fffffff
+ */
+int idr_get_new(struct idr *idp, void *ptr, int *id)
+{
+	int rv;
+	rv = idr_get_new_above_int(idp, ptr, 0);
+	/*
+	 * This is a cheap hack until the IDR code can be fixed to
+	 * return proper error values.
+	 */
+	if (rv < 0) {
+		if (rv == -1)
+			return -EAGAIN;
+		else /* Will be -3 */
+			return -ENOSPC;
+	}
+	*id = rv;
+	return 0;
+}
+EXPORT_SYMBOL(idr_get_new);
+
+static void idr_remove_warning(int id)
+{
+	printk("idr_remove called for id=%d which is not allocated.\n", id);
+	dump_stack();
+}
+
+static void sub_remove(struct idr *idp, int shift, int id)
+{
+	struct idr_layer *p = idp->top;
+	struct idr_layer **pa[MAX_LEVEL];
+	struct idr_layer ***paa = &pa[0];
+	int n;
+
+	*paa = NULL;
+	*++paa = &idp->top;
+
+	while ((shift > 0) && p) {
+		n = (id >> shift) & IDR_MASK;
+		clear_bit(n, &p->bitmap);
+		*++paa = &p->ary[n];
+		p = p->ary[n];
+		shift -= IDR_BITS;
+	}
+	n = id & IDR_MASK;
+	if (likely(p != NULL && test_bit(n, &p->bitmap))){
+		clear_bit(n, &p->bitmap);
+		p->ary[n] = NULL;
+		while(*paa && ! --((**paa)->count)){
+			free_layer(idp, **paa);
+			**paa-- = NULL;
+		}
+		if ( ! *paa )
+			idp->layers = 0;
+	} else {
+		idr_remove_warning(id);
+	}
+}
+
+/**
+ * idr_remove - remove the given id and free it's slot
+ * idp: idr handle
+ * id: uniqueue key
+ */
+void idr_remove(struct idr *idp, int id)
+{
+	struct idr_layer *p;
+
+	/* Mask off upper bits we don't use for the search. */
+	id &= MAX_ID_MASK;
+
+	sub_remove(idp, (idp->layers - 1) * IDR_BITS, id);
+	if ( idp->top && idp->top->count == 1 && 
+	     (idp->layers > 1) &&
+	     idp->top->ary[0]){  // We can drop a layer
+
+		p = idp->top->ary[0];
+		idp->top->bitmap = idp->top->count = 0;
+		free_layer(idp, idp->top);
+		idp->top = p;
+		--idp->layers;
+	}
+	while (idp->id_free_cnt >= IDR_FREE_MAX) {
+		
+		p = alloc_layer(idp);
+		kmem_cache_free(idr_layer_cache, p);
+		return;
+	}
+}
+EXPORT_SYMBOL(idr_remove);
+
+/**
+ * idr_find - return pointer for given id
+ * @idp: idr handle
+ * @id: lookup key
+ *
+ * Return the pointer given the id it has been registered with.  A %NULL
+ * return indicates that @id is not valid or you passed %NULL in
+ * idr_get_new().
+ *
+ * The caller must serialize idr_find() vs idr_get_new() and idr_remove().
+ */
+void *idr_find(struct idr *idp, int id)
+{
+	int n;
+	struct idr_layer *p;
+
+	n = idp->layers * IDR_BITS;
+	p = idp->top;
+
+	/* Mask off upper bits we don't use for the search. */
+	id &= MAX_ID_MASK;
+
+	if (id >= (1 << n))
+		return NULL;
+
+	while (n > 0 && p) {
+		n -= IDR_BITS;
+		p = p->ary[(id >> n) & IDR_MASK];
+	}
+	return((void *)p);
+}
+EXPORT_SYMBOL(idr_find);
+
+static void idr_cache_ctor(void * idr_layer, 
+			   kmem_cache_t *idr_layer_cache, unsigned long flags)
+{
+	memset(idr_layer, 0, sizeof(struct idr_layer));
+}
+
+static  int init_id_cache(void)
+{
+	if (!idr_layer_cache)
+		idr_layer_cache = kmem_cache_create("idr_layer_cache", 
+			sizeof(struct idr_layer), 0, 0, idr_cache_ctor, NULL);
+	return 0;
+}
+
+/**
+ * idr_init - initialize idr handle
+ * @idp:	idr handle
+ *
+ * This function is use to set up the handle (@idp) that you will pass
+ * to the rest of the functions.
+ */
+void idr_init(struct idr *idp)
+{
+	init_id_cache();
+	memset(idp, 0, sizeof(struct idr));
+	spin_lock_init(&idp->lock);
+}
+EXPORT_SYMBOL(idr_init);




--------------050604030503070801070505--
