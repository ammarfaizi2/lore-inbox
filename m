Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266793AbUJWE0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266793AbUJWE0w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 00:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267720AbUJWE0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 00:26:24 -0400
Received: from [211.58.254.17] ([211.58.254.17]:32400 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S266793AbUJWEW4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 00:22:56 -0400
Date: Sat, 23 Oct 2004 13:22:46 +0900
From: Tejun Heo <tj@home-tj.org>
To: rusty@rustcorp.com.au, mochel@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC/PATCH] Per-device parameter support (1/16)
Message-ID: <20041023042246.GB3456@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 dp_01_vector.diff

 This is the 1st patch of 16 patches for devparam.

 This patch implements dynamically expandable/shrinkable generic array
which also supports constructing/destructing.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-devparam-export/include/linux/vector.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-devparam-export/include/linux/vector.h	2004-10-23 11:09:28.000000000 +0900
@@ -0,0 +1,174 @@
+/*
+ * vector.h - dynamically expandable/shrinkable generic array
+ *
+ * Copyright (C) 2004 Tejun Heo <tj@home-tj.org>
+ *
+ * This file is released under the GPLv2.
+ *
+ *  The interface is fairly self-explanatory.  However, note that
+ *
+ * - vector_elem() and vector_clear() expands the vector as necessary,
+ * and, naturally, may fail; however, they're guaranteed to succeed if
+ * the specified element is inside the current length of the vector.
+ *
+ * - If gfp_flags is 0, you're explicitly specifying that the
+ * specified element should be inside the current length of the
+ * vector.  If gfp_flags is 0 but expansion is necessary, it's BUG().
+ *
+ * - Elements inside a vector with its VECTOR_ALLOCATE bit off may
+ * move while expanding the vector, so its address may change during
+ * vector_elem(), vector_expand() or vector_shrink() call.  However,
+ * it's guaranteed that once a vector is expanded to be larger than a
+ * page, addresses of the elements won't change during tail
+ * expansion/shrink.  Hence, the following vector_elem() invocation,
+ * when successful, guarantee that unless expanded or shrinked in the
+ * middle, elements retain their addresses.
+ *
+ * vector_elem(my_vec, PAGE_SIZE / elem_size - 1, GFP_KERNEL)
+ *
+ * - If VECTOR_ALLOCATE is set, each element is allocated separately,
+ * so above problem won't appear.  Unless the size of the element is
+ * quite small, using VECTOR_ALLOCATE can be better in many cases.
+ *
+ * - If VECTOR_CLEAR is set, newly expanded elements are cleared with
+ * zero.  If constructor is also specified, elements are cleared
+ * before passed to the constructor.
+ *
+ * - Expanding and shrinking in the middle of a vector involves
+ * memmoving elements and thus can be somewhat costly.  However, if
+ * the expansion or shrink is multiple of PAGE_SIZE, vector will avoid
+ * copying memory whenever possible.
+ */
+
+#ifndef __LINUX_VECTOR_H
+#define __LINUX_VECTOR_H
+
+#ifndef __ASSEMBLY__
+
+#include <linux/types.h>
+
+#define VECTOR_MAX_INLINE_SIZE	(PAGE_SIZE / 4)
+
+enum {
+	VECTOR_CLEAR		= 0x1,
+	VECTOR_ALLOCATE		= 0x2
+};
+
+typedef int (*vector_ctor_t)(void *elem, void *arg);
+typedef void (*vector_dtor_t)(void *elem, void *arg);
+
+struct vector {
+	u16 first, flags;
+	int elem_size;
+	void *chunk;
+
+	int real_size, nr_per_chunk;
+	int len, nr_allocated;
+	vector_ctor_t ctor;
+	vector_dtor_t dtor;
+	void *arg;
+	struct vector_ext *ext;
+};
+
+#define VECTOR_INIT(Elemsize, Flags, Ctor, Dtor, Arg) {	\
+	.elem_size	= (Flags) & VECTOR_ALLOCATE	\
+			  ? sizeof(void *) : (Elemsize),\
+	.flags		= (Flags),			\
+	.real_size	= (Elemsize),			\
+	.nr_per_chunk	= (Flags) & VECTOR_ALLOCATE	\
+			  ? PAGE_SIZE / sizeof(void *)	\
+			  : PAGE_SIZE / (Elemsize),	\
+	.ctor		= Ctor,				\
+	.dtor		= Dtor,				\
+	.arg		= Arg				\
+ }
+
+/**
+ * vector_init - initialize a vector
+ * @vec: vector to initialize
+ * @elem_size: vector element size (cannot be bigger than PAGE_SIZE / 4)
+ * @flags: vector flags
+ * @ctor: elem constructor
+ * @dtor: elem destructor
+ * @arg: constructor/destructor argument
+ *
+ * Initialize a vector which contains elements of size @elem_size.
+ */
+void vector_init(struct vector *vec, size_t elem_size, unsigned flags,
+		 vector_ctor_t ctor, vector_dtor_t dtor, void *arg);
+
+void *vector_elem_slow(struct vector *vec, int index, int gfp_flags);
+
+/**
+ * vector_elem - reference a vector element
+ * @vec: target vector
+ * @index: index of the element to reference
+ * @gfp_flags: allocation flags
+ *
+ * Returns the pointer to the element at @index of @vec.  The vector is
+ * expanded as necessary.
+ */
+static inline void *vector_elem(struct vector *vec, int index, int gfp_flags)
+{
+	if (index < vec->first) {
+		void *p = vec->chunk + index * vec->elem_size;
+		return !(vec->flags & VECTOR_ALLOCATE) ? p : *(void **)p;
+	} else
+		return vector_elem_slow(vec, index, gfp_flags);
+}
+
+/**
+ * vector_len - length of the vector
+ * @vec: target vector
+ *
+ * Returns the length of the vector (maximum successfully referenced index + 1)
+ */
+static inline int vector_len(struct vector *vec)
+{
+	return vec->len;
+}
+
+/**
+ * vector_clear - clear the vector with given data
+ * @vec: target vector
+ * @at: from this element
+ * @nr: number of elements to clear
+ * @clear_data: element is cleared using this data
+ * @cdlen: length of clear_data
+ * @gfp_flags: allocation flags
+ *
+ * Clear @nr elements starting from @at using @cdlen bytes of @clear_data.
+ * The vector is expanded as necessary.
+ */
+int vector_clear(struct vector *vec, int at, int nr,
+		 const void *clear_data, size_t cdlen, int gfp_flags);
+
+/**
+ * vector_expand - expand the vector
+ * @vec: target vector
+ * @at: insert new elements at this index
+ * @nr: number of new elements
+ * @gfp_flags: allocation flags
+ *
+ * Insert @nr elements at @at.  @at can range from 0 to vector_len.
+ */
+int vector_expand(struct vector *vec, int at, int nr, int gfp_flags);
+
+/**
+ * vector_shrink - shrink the vector
+ * @vec: target vector
+ * @at: remove elements from this index
+ * @nr: number of elements to remove
+ *
+ * Remove @nr elements starting from @at.
+ */
+void vector_shrink(struct vector *vec, int at, int nr);
+
+/**
+ * vector_destroy - destroy the vector
+ * @vec: target vector
+ */
+void vector_destroy(struct vector *vec);
+
+#endif /*__ASSEMBLY__*/
+#endif /*__LINUX_VECTOR_H*/
Index: linux-devparam-export/lib/Makefile
===================================================================
--- linux-devparam-export.orig/lib/Makefile	2004-10-22 17:12:03.000000000 +0900
+++ linux-devparam-export/lib/Makefile	2004-10-23 11:09:28.000000000 +0900
@@ -6,7 +6,7 @@
 lib-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
 	 kobject.o kref.o idr.o div64.o parser.o int_sqrt.o \
-	 bitmap.o extable.o kobject_uevent.o
+	 bitmap.o extable.o kobject_uevent.o vector.o
 
 lib-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
 lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
Index: linux-devparam-export/lib/vector.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-devparam-export/lib/vector.c	2004-10-23 11:09:28.000000000 +0900
@@ -0,0 +1,377 @@
+/*
+ * lib/vector.c
+ * Vector implementation
+ *
+ * Copyright (C) 2004 Tejun Heo <tj@home-tj.org>
+ *
+ * This file is released under the GPLv2.
+ */
+#include <linux/vector.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/gfp.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#define VECTOR_MIN_ALLOC	16
+#define VECTOR_MIN_SLOTS	16
+
+struct vector_ext {
+	int nr_slots;
+	void *chunks[0];
+};
+
+#define VCHUNK(vec, idx) \
+	(*((vec)->ext == NULL ? \
+	  &(vec)->chunk : &(vec)->ext->chunks[(idx) / (vec)->nr_per_chunk]))
+
+static inline void *velem(struct vector *vec, int idx)
+{
+	return VCHUNK(vec, idx) + (idx % vec->nr_per_chunk) * vec->elem_size;
+}
+
+static inline void *velem_deref(struct vector *vec, int idx)
+{
+	void *p = velem(vec, idx);
+	return !(vec->flags & VECTOR_ALLOCATE) ? p : *(void **)p;
+}
+
+static inline void set_len(struct vector *vec, int len)
+{
+	vec->len = len;
+	vec->first = min(vec->len, vec->nr_per_chunk);
+}
+
+static void release_elems(struct vector *vec, int at, int nr)
+{
+	unsigned flags = vec->flags;
+	int i;
+
+	if (!(flags & VECTOR_ALLOCATE) && !vec->dtor)
+		return;
+
+	if (flags & VECTOR_ALLOCATE)
+		for (i = at; i < at + nr; i++) {
+			void *p = *(void **)velem(vec, i);
+			if (vec->dtor)
+				vec->dtor(p, vec->arg);
+			kfree(p);
+		}
+	else
+		for (i = at; i < at + nr; i++)
+			vec->dtor(velem(vec, i), vec->arg);
+	
+}
+
+static int init_elems(struct vector *vec, int at, int nr, int gfp_flags)
+{
+	unsigned flags = vec->flags;
+	int i, ret;
+	void *p;
+
+	if (!(flags & (VECTOR_ALLOCATE|VECTOR_CLEAR)) && !vec->ctor)
+		return 0;
+
+	if (flags & VECTOR_ALLOCATE) {
+		BUG_ON(gfp_flags == 0);
+
+		for (i = at; i < at + nr; i++) {
+			ret = -ENOMEM;
+			if ((p = kmalloc(vec->real_size, gfp_flags)) == NULL)
+				goto unroll_out;
+
+			if (flags & VECTOR_CLEAR)
+				memset(p, 0, vec->real_size);
+
+			if (vec->ctor) {
+				ret = vec->ctor(p, vec->arg);
+				if (ret < 0) {
+					kfree(p);
+					goto unroll_out;
+				}
+			}
+
+			*(void **)velem(vec, i) = p;
+		}
+	} else {
+		if (flags & VECTOR_CLEAR) {
+			int t;
+			for (i = at; i < at + nr; i += t) {
+				p = velem(vec, i);
+				t = min(at + nr - i,
+					vec->nr_per_chunk-i%vec->nr_per_chunk);
+				memset(p, 0, t * vec->real_size);
+			}
+		}
+		if (vec->ctor) {
+			for (i = at; i < at + nr; i++) {
+				ret = vec->ctor(velem(vec, i), vec->arg);
+				if (ret < 0)
+					goto unroll_out;
+			}
+		}
+	}
+	
+	return 0;
+
+ unroll_out:
+	release_elems(vec, at, i - at);
+	return ret;
+}
+
+static void pull_entries(struct vector *vec, int at, int delta)
+{
+	int nr_left;
+	int si, di;
+
+	nr_left = vec->len - at;
+	si = at;
+	di = si - delta;
+
+	while (nr_left) {
+		int sav, dav, nr;
+		sav = vec->nr_per_chunk - si % vec->nr_per_chunk;
+		dav = vec->nr_per_chunk - di % vec->nr_per_chunk;
+		nr = min(nr_left, min(sav, dav));
+		if (sav == dav && sav == vec->nr_per_chunk) {
+			void *p;
+			p = VCHUNK(vec, si);
+			VCHUNK(vec, si) = VCHUNK(vec, di);
+			VCHUNK(vec, di) = p;
+		} else
+			memmove(velem(vec, di), velem(vec, si),
+				nr * vec->elem_size);
+		si += nr;
+		di += nr;
+		nr_left -= nr;
+	}
+	vec->chunk = VCHUNK(vec, 0);
+}
+
+static inline void push_entries(struct vector *vec, int at, int delta)
+{
+	int nr_left;
+	int si, di;
+
+	nr_left = vec->len - at;
+	si = vec->len - 1;
+	di = si + delta;
+
+	while (nr_left) {
+		int sav, dav, nr;
+		sav = si % vec->nr_per_chunk + 1;
+		dav = di % vec->nr_per_chunk + 1;
+		nr = min(nr_left, min(sav, dav));
+		if (sav == dav && sav == nr) {
+			void *p;
+			p = VCHUNK(vec, si);
+			VCHUNK(vec, si) = VCHUNK(vec, di);
+			VCHUNK(vec, di) = p;
+		} else
+			memmove(velem(vec, di-nr+1), velem(vec, si-nr+1),
+				nr * vec->elem_size);
+		si -= nr;
+		di -= nr;
+		nr_left -= nr;
+	}
+	vec->chunk = VCHUNK(vec, 0);
+}
+
+void vector_init(struct vector *vec, size_t elem_size, unsigned flags,
+		 vector_ctor_t ctor, vector_dtor_t dtor, void *arg)
+{
+	memset(vec, 0, sizeof(*vec));
+	vec->elem_size = flags & VECTOR_ALLOCATE ? sizeof(void *) : elem_size;
+	vec->flags = flags;
+	vec->real_size = elem_size;
+	vec->nr_per_chunk = PAGE_SIZE / vec->elem_size;
+	vec->ctor = ctor;
+	vec->dtor = dtor;
+	vec->arg = arg;
+	BUG_ON(vec->elem_size > VECTOR_MAX_INLINE_SIZE);
+}
+
+void * vector_elem_slow(struct vector *vec, int index, int gfp_flags)
+{
+	if (index < vec->len)
+		goto done;
+	if (index < vec->nr_allocated) {
+		if (init_elems(vec, vec->len, index + 1 - vec->len,
+			       gfp_flags) < 0)
+			return NULL;
+		set_len(vec, index + 1);
+		goto done;
+	}
+	if (vector_expand(vec, vec->len, index + 1 - vec->len, gfp_flags) < 0)
+		return NULL;
+ done:
+	return velem_deref(vec, index);
+}
+
+int vector_clear(struct vector *vec, int at, int nr,
+		 const void *clear_data, size_t cdlen, int gfp_flags)
+{
+	int i, end = at + nr - 1;
+
+	BUG_ON(at < 0 || nr < 0 || end < -1 || cdlen > vec->real_size);
+
+	if (nr == 0)
+		return 0;
+	if (vector_elem(vec, end, gfp_flags) == NULL)
+		return -ENOMEM;
+	for (i = at; i <= end; i++)
+		memcpy(velem_deref(vec, i), clear_data, cdlen);
+	return 0;
+}
+
+int vector_expand(struct vector *vec, int at, int nr, int gfp_flags)
+{
+	int nr_alloc = vec->nr_allocated;
+	int targ_alloc = vec->len + nr;
+	int nr_chunks, targ_chunks, i, ret;
+
+	BUG_ON(at < 0 || at > vec->len || nr < 0 || targ_alloc < 0 ||
+	       vec->elem_size > VECTOR_MAX_INLINE_SIZE);
+
+	if (nr == 0)
+		return 0;
+	if (targ_alloc <= nr_alloc)
+		goto push_entries;
+
+	BUG_ON(gfp_flags == 0);
+
+	/* If targ_alloc, after rounding up to the nearest power of
+	   two, is less than or equal to the half of nr_per_chunk,
+	   expand in place. */
+	if (targ_alloc <= vec->nr_per_chunk / 2) {
+		int cnt;
+		cnt = nr_alloc ?: min(VECTOR_MIN_ALLOC, vec->nr_per_chunk / 2);
+		while (cnt < targ_alloc) {
+			cnt *= 2;
+			BUG_ON(cnt < 0);
+		}
+		targ_alloc = cnt;
+
+		if (targ_alloc <= vec->nr_per_chunk / 2) {
+			/* Okay, expand in place */
+			void *chunk;
+			if (!(chunk = kmalloc(targ_alloc * vec->elem_size,
+					      gfp_flags)))
+				return -ENOMEM;
+			memcpy(chunk, vec->chunk, at * vec->elem_size);
+			memcpy(chunk + (at + nr) * vec->elem_size,
+			       vec->chunk + at * vec->elem_size,
+			       (vec->len - at) * vec->elem_size);
+			kfree(vec->chunk);
+			vec->chunk = chunk;
+			vec->nr_allocated = targ_alloc;
+			goto init_elems;
+		}
+	}
+
+	/* Normalize the first chunk */
+	if (nr_alloc < vec->nr_per_chunk) {
+		void *chunk;
+		if (!(chunk = (void *)__get_free_page(gfp_flags)))
+			return -ENOMEM;
+		memcpy(chunk, vec->chunk, vec->len * vec->elem_size);
+		kfree(vec->chunk);
+		vec->chunk = chunk;
+		nr_alloc = vec->nr_per_chunk;
+		vec->nr_allocated = nr_alloc;
+		if (nr_alloc >= targ_alloc)
+			goto push_entries;
+	}
+
+	/* Calculate nr/targ_chunks and round up targ_alloc to page boundary */
+	nr_chunks = nr_alloc / vec->nr_per_chunk;
+	targ_chunks = (targ_alloc + vec->nr_per_chunk - 1) / vec->nr_per_chunk;
+	targ_alloc = targ_chunks * vec->nr_per_chunk;
+
+	/* Allocate/expand vec->ext */
+	if (!vec->ext || vec->ext->nr_slots < targ_chunks) {
+		struct vector_ext *ext;
+		int cnt;
+
+		for (cnt = vec->ext ? vec->ext->nr_slots : VECTOR_MIN_SLOTS-1;
+		     cnt < targ_chunks; cnt = (cnt + 1) * 2 - 1)
+			BUG_ON(cnt < 0);
+
+		if (!(ext = kmalloc(sizeof(*ext) + cnt * sizeof(void *),
+				    gfp_flags)))
+			return -ENOMEM;
+
+		if (vec->ext) {
+			memcpy(ext->chunks, vec->ext->chunks,
+			       nr_chunks * sizeof(void *));
+			kfree(vec->ext);
+		} else
+			ext->chunks[0] = vec->chunk;
+		ext->nr_slots = cnt;
+		vec->ext = ext;
+	}
+
+	/* Allocate chunks */
+	for (i = nr_chunks; i < targ_chunks; i++)
+		if (!(vec->ext->chunks[i] = (void *)__get_free_page(gfp_flags)))
+			goto unwind_out;
+
+	vec->nr_allocated = targ_alloc;
+ push_entries:
+	push_entries(vec, at, nr);
+ init_elems:
+	if ((ret = init_elems(vec, at, nr, gfp_flags)) < 0) {
+		pull_entries(vec, at, nr);
+		return ret;
+	}
+	set_len(vec, vec->len + nr);
+	return 0;
+
+ unwind_out:
+	while (--i >= nr_chunks)
+		free_page((unsigned long)vec->ext->chunks[i]);
+	return -ENOMEM;
+}
+
+void vector_shrink(struct vector *vec, int at, int nr)
+{
+	int i, begin, end;
+
+	end = at + nr - 1;
+	BUG_ON(at < 0 || at > vec->len || nr < 0 ||
+	       end < -1 || end >= vec->len);
+		
+	if (nr == 0)
+		return;
+
+	release_elems(vec, at, nr);
+	pull_entries(vec, end + 1, nr);
+	set_len(vec, vec->len - nr);
+	
+	/* Free unused pages, always keep one extra page */
+	begin = (vec->len - 1) / vec->nr_per_chunk + 2;
+	end = vec->nr_allocated / vec->nr_per_chunk;
+	for (i = begin; i < end; i++)
+		free_page((unsigned long)vec->ext->chunks[i]);
+	vec->nr_allocated = begin * vec->nr_per_chunk;
+}
+
+void vector_destroy(struct vector *vec)
+{
+	int i;
+
+	if (vec->ext) {
+		for (i = 0; i < vec->nr_allocated / vec->nr_per_chunk; i++)
+			free_page((unsigned long)vec->ext->chunks[i]);
+		kfree(vec->ext);
+	} else
+		kfree(vec->chunk);
+	memset(vec, 0, sizeof(*vec));
+}
+
+EXPORT_SYMBOL(vector_init);
+EXPORT_SYMBOL(vector_elem_slow);
+EXPORT_SYMBOL(vector_clear);
+EXPORT_SYMBOL(vector_expand);
+EXPORT_SYMBOL(vector_shrink);
+EXPORT_SYMBOL(vector_destroy);
