Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283916AbRLKV1S>; Tue, 11 Dec 2001 16:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284079AbRLKV1A>; Tue, 11 Dec 2001 16:27:00 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:65096 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S283916AbRLKV0l>; Tue, 11 Dec 2001 16:26:41 -0500
Date: Tue, 11 Dec 2001 16:26:39 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>, axboe@suse.de
Cc: Big Fish <linux-kernel@vger.kernel.org>
Subject: [PATCH] v2.5.1-pre9-00_kvec.diff
Message-ID: <20011211162639.F6878@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey dudes,

Since the big block melee has started pretty quickly, I'd like to try 
to start reeling things in so that they aren't off on a tangent that 
completely excludes the requirements of aio and the revamped kiobufs 
that were discussed earlier.  To that end, I'm offering up the below 
patch that adds the kvec structure and helpers so that we can begin 
converting kiobuf users, as well as networking and the newly introduced 
bio_vecs into a unified set of primatives.  Comments?

-- 
Fish.

... ~/patches/v2.5.1-pre9-00_kvec.diff ...

diff -urN v2.5.1-pre9/include/linux/kiovec.h work-v2.5.1-pre9.diff/include/linux/kiovec.h
--- v2.5.1-pre9/include/linux/kiovec.h	Wed Dec 31 19:00:00 1969
+++ work-v2.5.1-pre9.diff/include/linux/kiovec.h	Tue Dec 11 15:43:05 2001
@@ -0,0 +1,107 @@
+#ifndef __LINUX__KIOVEC_H
+#define __LINUX__KIOVEC_H
+
+struct page;
+struct list;
+
+struct kveclet {
+	struct page	*page;
+	unsigned	offset;
+	unsigned	length;
+};
+
+struct kvec {
+	unsigned	max_nr;
+	unsigned	nr;
+	struct kveclet	veclet[0];
+};
+
+struct kvec_cb {
+	struct kvec	*vec;
+	void		(*fn)(void *data, struct kvec *vec, ssize_t res);
+	void		*data;
+};
+
+struct kvec_cb_list {
+	struct list_head	list;
+	struct kvec_cb		cb;
+};
+
+#ifndef _LINUX_TYPES_H
+#include <linux/types.h>
+#endif
+#ifndef _LINUX_KDEV_T_H
+#include <linux/kdev_t.h>
+#endif
+#ifndef _ASM_KMAP_TYPES_H
+#include <asm/kmap_types.h>
+#endif
+
+extern struct kvec *map_user_kvec(int rw, unsigned long va, size_t len);
+extern void unmap_kvec(struct kvec *, int dirtied);
+extern void free_kvec(struct kvec *);
+
+/* brw_kvec_async:
+ *	Performs direct io to/from disk into cb.vec.  Count is the number
+ *	of sectors to read, sector_shift is the blocksize (which must be
+ *	compatible with the kernel's current idea of the device's sector
+ *	size) in log2.  blknr is the starting sector offset on dev.
+ *
+ */
+extern int brw_kvec_async(int rw, kvec_cb_t cb, kdev_t dev, unsigned count,
+			  unsigned long blknr, int sector_shift);
+
+/* Memory copy helpers usage:
+ * void foo(... struct kveclet *veclet...)
+ *
+ *	struct kvec_dst	dst;
+ *
+ *	kvec_dst_init(&dst, KM_USER0);
+ *	kvec_dst_map(&dst, veclet);			-- activates kmap
+ *	for (...)
+ *		memcpy_to_kvec_dst(&dst, data, size);	-- each copy appends
+ *	kvec_dst_unmap(&dst);				-- releases kmap
+ *
+ * Note that scheduling is not permitted between kvec_dst_map() and
+ * kvec_dst_unmap().  This is because internally the routines make use
+ * of an atomic kmap.
+ */
+struct kvec_dst {
+	char		*addr;
+	char		*dst;
+	struct kveclet	*let;
+	int		space;
+	int		offset;
+	enum km_type	type;
+};
+
+
+#define kvec_dst_map(Xdst, Xlet)					\
+	do {								\
+		struct kvec_dst *_dst = (Xdst);				\
+		struct kveclet *_let = (Xlet);				\
+		_dst->dst = _dst->addr = kmap_atomic(_let->page, _dst->type);\
+		_dst->dst += _let->offset + _dst->offset;		\
+		_dst->space = _let->length;				\
+		_dst->offset = 0;					\
+	} while(0)
+
+#define kvec_dst_init(Xdst, Xtype)					\
+	do {								\
+		(Xdst)->offset = 0;					\
+		(Xdst)->type = Xtype;					\
+	} while(0)
+
+#define	kvec_dst_unmap(Xdst)						\
+	do {								\
+		kunmap_atomic((Xdst)->addr, (Xdst)->type);		\
+		(Xdst)->offset = (Xdst)->dst - (Xdst)->addr;		\
+		(Xdst)->offset -= (Xdst)->let->offset;			\
+	} while(0)
+
+extern void FASTCALL(memcpy_to_kvec_dst(struct kvec_dst *dst,
+					const char *from, long len));
+extern void FASTCALL(memcpy_from_kvec_dst(char *to,
+					  struct kvec_dst *from, long len));
+
+#endif /* __LINUX__KIOVEC_H */
diff -urN v2.5.1-pre9/include/linux/types.h work-v2.5.1-pre9.diff/include/linux/types.h
--- v2.5.1-pre9/include/linux/types.h	Tue Dec 11 15:28:08 2001
+++ work-v2.5.1-pre9.diff/include/linux/types.h	Tue Dec 11 15:48:31 2001
@@ -138,4 +138,9 @@
 	char			f_fpack[6];
 };
 
+/* kernel typedefs -- they belong here. */
+#ifdef __KERNEL__
+typedef struct kvec_cb kvec_cb_t;
+#endif /* __KERNEL__ */
+
 #endif /* _LINUX_TYPES_H */
diff -urN v2.5.1-pre9/mm/memory.c work-v2.5.1-pre9.diff/mm/memory.c
--- v2.5.1-pre9/mm/memory.c	Thu Nov 15 13:03:06 2001
+++ work-v2.5.1-pre9.diff/mm/memory.c	Tue Dec 11 15:52:09 2001
@@ -44,6 +44,9 @@
 #include <linux/iobuf.h>
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
+#include <linux/slab.h>
+#include <linux/compiler.h>
+#include <linux/kiovec.h>
 
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
@@ -1432,3 +1435,203 @@
 	} while (addr < end);
 	return 0;
 }
+
+/*
+ * Force in an entire range of pages from the current process's user VA,
+ * and pin them in physical memory.  
+ * FIXME: some architectures need to flush the cache based on user addresses 
+ * here.  Someone please provide a better macro than flush_cache_page.
+ */
+
+#define dprintk(x...)
+struct kvec *map_user_kvec(int rw, unsigned long ptr, size_t len)
+{
+	struct kvec		*vec;
+	struct kveclet		*veclet;
+	unsigned long		end;
+	int			err;
+	struct mm_struct *	mm;
+	struct vm_area_struct *	vma = 0;
+	int			i;
+	int			datain = (rw == READ);
+	unsigned		nr_pages;
+
+	end = ptr + len;
+	if (end < ptr)
+		return ERR_PTR(-EINVAL);
+
+	nr_pages = (ptr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	nr_pages -= ptr >> PAGE_SHIFT;
+	nr_pages ++;
+	vec = kmalloc(sizeof(struct kvec) + nr_pages * sizeof(struct kveclet),
+			GFP_KERNEL);
+	if (!vec)
+		return ERR_PTR(-ENOMEM);
+	vec->nr = 0;
+	vec->max_nr = nr_pages;
+	veclet = vec->veclet;
+	
+	/* Make sure the iobuf is not already mapped somewhere. */
+	mm = current->mm;
+	dprintk ("map_user_kiobuf: begin\n");
+	
+	down_read(&mm->mmap_sem);
+
+	err = -EFAULT;
+	
+	i = 0;
+
+	/* 
+	 * First of all, try to fault in all of the necessary pages
+	 */
+	while (ptr < end) {
+		struct page *map;
+		veclet->offset = ptr & ~PAGE_MASK;
+		veclet->length = PAGE_SIZE - veclet->offset;
+		if (len < veclet->length)
+			veclet->length = len;
+		ptr &= PAGE_MASK;
+		len -= veclet->length;
+
+		if (!vma || ptr >= vma->vm_end) {
+			vma = find_vma(current->mm, ptr);
+			if (!vma) 
+				goto out_unlock;
+			if (vma->vm_start > ptr) {
+				if (!(vma->vm_flags & VM_GROWSDOWN))
+					goto out_unlock;
+				if (expand_stack(vma, ptr))
+					goto out_unlock;
+			}
+			if (((datain) && (!(vma->vm_flags & VM_WRITE))) ||
+					(!(vma->vm_flags & VM_READ))) {
+				err = -EACCES;
+				goto out_unlock;
+			}
+		}
+		spin_lock(&mm->page_table_lock);
+		while (!(map = follow_page(ptr, datain))) {
+			int ret;
+
+			spin_unlock(&mm->page_table_lock);
+			ret = handle_mm_fault(current->mm, vma, ptr, datain);
+			if (ret <= 0) {
+				if (!ret)
+					goto out_unlock;
+				else {
+					err = -ENOMEM;
+					goto out_unlock;
+				}
+			}
+			spin_lock(&mm->page_table_lock);
+		}			
+		map = get_page_map(map);
+		if (map) {
+			flush_dcache_page(map);
+			atomic_inc(&map->count);
+		} else
+			printk (KERN_INFO "Mapped page missing [%d]\n", i);
+		spin_unlock(&mm->page_table_lock);
+		veclet->page = map;
+		veclet++;
+
+		ptr += PAGE_SIZE;
+		vec->nr = ++i;
+	}
+
+	veclet->page = NULL;	/* dummy for the prefetch in free_kvec */
+	veclet->length = 0;	/* bug checking ;-) */
+
+	up_read(&mm->mmap_sem);
+	dprintk ("map_user_kiobuf: end OK\n");
+	return vec;
+
+ out_unlock:
+	up_read(&mm->mmap_sem);
+	unmap_kvec(vec, 0);
+	printk(KERN_DEBUG "map_user_kvec: err(%d)\n", err);
+	kfree(vec);
+	return ERR_PTR(err);
+}
+
+/*
+ * Unmap all of the pages referenced by a kiobuf.  We release the pages,
+ * and unlock them if they were locked. 
+ */
+
+void unmap_kvec (struct kvec *vec, int dirtied)
+{
+	struct kveclet *veclet = vec->veclet;
+	struct kveclet *end = vec->veclet + vec->nr;
+	struct page *map = veclet->page;
+
+	prefetchw(map);
+	for (; veclet<end; map = (++veclet)->page) {
+		prefetchw(veclet[1].page);
+		if (likely(map != NULL) && !PageReserved(map)) {
+			if (dirtied) {
+				SetPageDirty(map);
+				flush_dcache_page(map);	/* FIXME */
+			}
+			__free_page(map);
+		}
+	}
+
+	vec->nr = 0;
+}
+
+void free_kvec(struct kvec *vec)
+{
+	kfree(vec);
+}
+
+/* kvec memory copy helper: appends len bytes in from to dst.
+ */
+void memcpy_to_kvec_dst(struct kvec_dst *dst, const char *from, long len)
+{
+	if (unlikely(len < 0))
+		BUG();
+	do {
+		int cnt = len;
+		if (dst->space < cnt)
+			cnt = dst->space;
+
+		memcpy(dst->dst, from, cnt);
+		from += cnt;
+		dst->space -= cnt;
+		dst->dst += cnt;
+		len -= cnt;
+		if (!dst->space && len) {
+			kvec_dst_unmap(dst);
+			kvec_dst_map(dst, dst->let + 1);
+			if (unlikely(!dst->space))
+				BUG();
+		}
+	} while (len);
+}
+
+/* kvec memory copy helper: copies and consumes len bytes in from to dst.
+ */
+void memcpy_from_kvec_dst(char *to, struct kvec_dst *from, long len)
+{
+	if (unlikely(len < 0))
+		BUG();
+	do {
+		int cnt = len;
+		if (from->space < cnt)
+			cnt = from->space;
+
+		memcpy(to, from->dst, cnt);
+		to += cnt;
+		from->space -= cnt;
+		from->dst += cnt;
+		len -= cnt;
+		if (unlikely(!from->space && len)) {
+			kvec_dst_unmap(from);
+			kvec_dst_map(from, from->let + 1);
+			if (unlikely(!from->space))
+				BUG();
+		}
+	} while (len);
+}
+
