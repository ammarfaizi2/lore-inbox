Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422635AbWJFLzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422635AbWJFLzw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 07:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422641AbWJFLzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 07:55:52 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:167 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1422635AbWJFLzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 07:55:51 -0400
Date: Fri, 6 Oct 2006 13:56:05 +0200
From: Jan Kara <jack@suse.cz>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH 2/3] Fix IO error reporting on fsync()
Message-ID: <20061006115604.GE14533@atrey.karlin.mff.cuni.cz>
References: <20061006114947.GC14533@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061006114947.GC14533@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reorganize headers with buffer heads. Separate buffer_head declaration and
functions handling it so that fs.h can see the whole buffer head structure.
This is needed so that address_space can contain a dummy buffer_head.

Signed-off-by: Jan Kara <jack@suse.cz>

diff -ruNpX /home/jack/.kerndiffexclude linux-2.6.18-1-mark_error_buffer/include/linux/buffer_head.h linux-2.6.18-2-buffer_headers/include/linux/buffer_head.h
--- linux-2.6.18-1-mark_error_buffer/include/linux/buffer_head.h	2006-09-27 13:09:04.000000000 +0200
+++ linux-2.6.18-2-buffer_headers/include/linux/buffer_head.h	2006-10-06 13:11:06.000000000 +0200
@@ -7,132 +7,9 @@
 #ifndef _LINUX_BUFFER_HEAD_H
 #define _LINUX_BUFFER_HEAD_H
 
-#include <linux/types.h>
+#include <linux/buffer_head_struct.h>
 #include <linux/fs.h>
-#include <linux/linkage.h>
 #include <linux/pagemap.h>
-#include <linux/wait.h>
-#include <asm/atomic.h>
-
-enum bh_state_bits {
-	BH_Uptodate,	/* Contains valid data */
-	BH_Dirty,	/* Is dirty */
-	BH_Lock,	/* Is locked */
-	BH_Req,		/* Has been submitted for I/O */
-	BH_Uptodate_Lock,/* Used by the first bh in a page, to serialise
-			  * IO completion of other buffers in the page
-			  */
-
-	BH_Mapped,	/* Has a disk mapping */
-	BH_New,		/* Disk mapping was newly created by get_block */
-	BH_Async_Read,	/* Is under end_buffer_async_read I/O */
-	BH_Async_Write,	/* Is under end_buffer_async_write I/O */
-	BH_Delay,	/* Buffer is not yet allocated on disk */
-	BH_Boundary,	/* Block is followed by a discontiguity */
-	BH_Write_EIO,	/* I/O error on write */
-	BH_Ordered,	/* ordered write */
-	BH_Eopnotsupp,	/* operation not supported (barrier) */
-
-	BH_PrivateStart,/* not a state bit, but the first bit available
-			 * for private allocation by other entities
-			 */
-};
-
-#define MAX_BUF_PER_PAGE (PAGE_CACHE_SIZE / 512)
-
-struct page;
-struct buffer_head;
-struct address_space;
-typedef void (bh_end_io_t)(struct buffer_head *bh, int uptodate);
-
-/*
- * Historically, a buffer_head was used to map a single block
- * within a page, and of course as the unit of I/O through the
- * filesystem and block layers.  Nowadays the basic I/O unit
- * is the bio, and buffer_heads are used for extracting block
- * mappings (via a get_block_t call), for tracking state within
- * a page (via a page_mapping) and for wrapping bio submission
- * for backward compatibility reasons (e.g. submit_bh).
- */
-struct buffer_head {
-	unsigned long b_state;		/* buffer state bitmap (see above) */
-	struct buffer_head *b_this_page;/* circular list of page's buffers */
-	struct page *b_page;		/* the page this bh is mapped to */
-
-	sector_t b_blocknr;		/* start block number */
-	size_t b_size;			/* size of mapping */
-	char *b_data;			/* pointer to data within the page */
-
-	struct block_device *b_bdev;
-	bh_end_io_t *b_end_io;		/* I/O completion */
- 	void *b_private;		/* reserved for b_end_io */
-	struct list_head b_assoc_buffers; /* associated with another mapping */
-	atomic_t b_count;		/* users using this buffer_head */
-};
-
-/*
- * macro tricks to expand the set_buffer_foo(), clear_buffer_foo()
- * and buffer_foo() functions.
- */
-#define BUFFER_FNS(bit, name)						\
-static inline void set_buffer_##name(struct buffer_head *bh)		\
-{									\
-	set_bit(BH_##bit, &(bh)->b_state);				\
-}									\
-static inline void clear_buffer_##name(struct buffer_head *bh)		\
-{									\
-	clear_bit(BH_##bit, &(bh)->b_state);				\
-}									\
-static inline int buffer_##name(const struct buffer_head *bh)		\
-{									\
-	return test_bit(BH_##bit, &(bh)->b_state);			\
-}
-
-/*
- * test_set_buffer_foo() and test_clear_buffer_foo()
- */
-#define TAS_BUFFER_FNS(bit, name)					\
-static inline int test_set_buffer_##name(struct buffer_head *bh)	\
-{									\
-	return test_and_set_bit(BH_##bit, &(bh)->b_state);		\
-}									\
-static inline int test_clear_buffer_##name(struct buffer_head *bh)	\
-{									\
-	return test_and_clear_bit(BH_##bit, &(bh)->b_state);		\
-}									\
-
-/*
- * Emit the buffer bitops functions.   Note that there are also functions
- * of the form "mark_buffer_foo()".  These are higher-level functions which
- * do something in addition to setting a b_state bit.
- */
-BUFFER_FNS(Uptodate, uptodate)
-BUFFER_FNS(Dirty, dirty)
-TAS_BUFFER_FNS(Dirty, dirty)
-BUFFER_FNS(Lock, locked)
-TAS_BUFFER_FNS(Lock, locked)
-BUFFER_FNS(Req, req)
-TAS_BUFFER_FNS(Req, req)
-BUFFER_FNS(Mapped, mapped)
-BUFFER_FNS(New, new)
-BUFFER_FNS(Async_Read, async_read)
-BUFFER_FNS(Async_Write, async_write)
-BUFFER_FNS(Delay, delay)
-BUFFER_FNS(Boundary, boundary)
-BUFFER_FNS(Write_EIO, write_io_error)
-BUFFER_FNS(Ordered, ordered)
-BUFFER_FNS(Eopnotsupp, eopnotsupp)
-
-#define bh_offset(bh)		((unsigned long)(bh)->b_data & ~PAGE_MASK)
-#define touch_buffer(bh)	mark_page_accessed(bh->b_page)
-
-/* If we *know* page->private refers to buffer_heads */
-#define page_buffers(page)					\
-	({							\
-		BUG_ON(!PagePrivate(page));			\
-		((struct buffer_head *)page_private(page));	\
-	})
-#define page_has_buffers(page)	PagePrivate(page)
 
 /*
  * Declarations
diff -ruNpX /home/jack/.kerndiffexclude linux-2.6.18-1-mark_error_buffer/include/linux/buffer_head_struct.h linux-2.6.18-2-buffer_headers/include/linux/buffer_head_struct.h
--- linux-2.6.18-1-mark_error_buffer/include/linux/buffer_head_struct.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.18-2-buffer_headers/include/linux/buffer_head_struct.h	2006-10-06 13:26:42.000000000 +0200
@@ -0,0 +1,135 @@
+/*
+ * include/linux/buffer_head.h
+ *
+ * Everything to do with buffer_heads.
+ */
+
+#ifndef _LINUX_BUFFER_HEAD_STRUCT_H
+#define _LINUX_BUFFER_HEAD_STRUCT_H
+
+#include <linux/types.h>
+#include <linux/linkage.h>
+#include <linux/wait.h>
+#include <asm/atomic.h>
+
+enum bh_state_bits {
+	BH_Uptodate,	/* Contains valid data */
+	BH_Dirty,	/* Is dirty */
+	BH_Lock,	/* Is locked */
+	BH_Req,		/* Has been submitted for I/O */
+	BH_Uptodate_Lock,/* Used by the first bh in a page, to serialise
+			  * IO completion of other buffers in the page
+			  */
+
+	BH_Mapped,	/* Has a disk mapping */
+	BH_New,		/* Disk mapping was newly created by get_block */
+	BH_Async_Read,	/* Is under end_buffer_async_read I/O */
+	BH_Async_Write,	/* Is under end_buffer_async_write I/O */
+	BH_Delay,	/* Buffer is not yet allocated on disk */
+	BH_Boundary,	/* Block is followed by a discontiguity */
+	BH_Write_EIO,	/* I/O error on write */
+	BH_Ordered,	/* ordered write */
+	BH_Eopnotsupp,	/* operation not supported (barrier) */
+
+	BH_PrivateStart,/* not a state bit, but the first bit available
+			 * for private allocation by other entities
+			 */
+};
+
+#define MAX_BUF_PER_PAGE (PAGE_CACHE_SIZE / 512)
+
+struct page;
+struct buffer_head;
+struct address_space;
+typedef void (bh_end_io_t)(struct buffer_head *bh, int uptodate);
+
+/*
+ * Historically, a buffer_head was used to map a single block
+ * within a page, and of course as the unit of I/O through the
+ * filesystem and block layers.  Nowadays the basic I/O unit
+ * is the bio, and buffer_heads are used for extracting block
+ * mappings (via a get_block_t call), for tracking state within
+ * a page (via a page_mapping) and for wrapping bio submission
+ * for backward compatibility reasons (e.g. submit_bh).
+ */
+struct buffer_head {
+	unsigned long b_state;		/* buffer state bitmap (see above) */
+	struct buffer_head *b_this_page;/* circular list of page's buffers */
+	struct page *b_page;		/* the page this bh is mapped to */
+
+	sector_t b_blocknr;		/* start block number */
+	size_t b_size;			/* size of mapping */
+	char *b_data;			/* pointer to data within the page */
+
+	struct block_device *b_bdev;
+	bh_end_io_t *b_end_io;		/* I/O completion */
+ 	void *b_private;		/* reserved for b_end_io */
+	struct list_head b_assoc_buffers; /* associated with another mapping */
+	atomic_t b_count;		/* users using this buffer_head */
+};
+
+/*
+ * macro tricks to expand the set_buffer_foo(), clear_buffer_foo()
+ * and buffer_foo() functions.
+ */
+#define BUFFER_FNS(bit, name)						\
+static inline void set_buffer_##name(struct buffer_head *bh)		\
+{									\
+	set_bit(BH_##bit, &(bh)->b_state);				\
+}									\
+static inline void clear_buffer_##name(struct buffer_head *bh)		\
+{									\
+	clear_bit(BH_##bit, &(bh)->b_state);				\
+}									\
+static inline int buffer_##name(const struct buffer_head *bh)		\
+{									\
+	return test_bit(BH_##bit, &(bh)->b_state);			\
+}
+
+/*
+ * test_set_buffer_foo() and test_clear_buffer_foo()
+ */
+#define TAS_BUFFER_FNS(bit, name)					\
+static inline int test_set_buffer_##name(struct buffer_head *bh)	\
+{									\
+	return test_and_set_bit(BH_##bit, &(bh)->b_state);		\
+}									\
+static inline int test_clear_buffer_##name(struct buffer_head *bh)	\
+{									\
+	return test_and_clear_bit(BH_##bit, &(bh)->b_state);		\
+}									\
+
+/*
+ * Emit the buffer bitops functions.   Note that there are also functions
+ * of the form "mark_buffer_foo()".  These are higher-level functions which
+ * do something in addition to setting a b_state bit.
+ */
+BUFFER_FNS(Uptodate, uptodate)
+BUFFER_FNS(Dirty, dirty)
+TAS_BUFFER_FNS(Dirty, dirty)
+BUFFER_FNS(Lock, locked)
+TAS_BUFFER_FNS(Lock, locked)
+BUFFER_FNS(Req, req)
+TAS_BUFFER_FNS(Req, req)
+BUFFER_FNS(Mapped, mapped)
+BUFFER_FNS(New, new)
+BUFFER_FNS(Async_Read, async_read)
+BUFFER_FNS(Async_Write, async_write)
+BUFFER_FNS(Delay, delay)
+BUFFER_FNS(Boundary, boundary)
+BUFFER_FNS(Write_EIO, write_io_error)
+BUFFER_FNS(Ordered, ordered)
+BUFFER_FNS(Eopnotsupp, eopnotsupp)
+
+#define bh_offset(bh)		((unsigned long)(bh)->b_data & ~PAGE_MASK)
+#define touch_buffer(bh)	mark_page_accessed(bh->b_page)
+
+/* If we *know* page->private refers to buffer_heads */
+#define page_buffers(page)					\
+	({							\
+		BUG_ON(!PagePrivate(page));			\
+		((struct buffer_head *)page_private(page));	\
+	})
+#define page_has_buffers(page)	PagePrivate(page)
+
+#endif /* _LINUX_BUFFER_HEAD_STRUCT_H */
diff -ruNpX /home/jack/.kerndiffexclude linux-2.6.18-1-mark_error_buffer/include/linux/fs.h linux-2.6.18-2-buffer_headers/include/linux/fs.h
--- linux-2.6.18-1-mark_error_buffer/include/linux/fs.h	2006-09-27 13:09:04.000000000 +0200
+++ linux-2.6.18-2-buffer_headers/include/linux/fs.h	2006-10-06 13:09:38.000000000 +0200
@@ -236,6 +236,7 @@ extern int dir_notify_enable;
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/mutex.h>
+#include <linux/buffer_head_struct.h>
 
 #include <asm/atomic.h>
 #include <asm/semaphore.h>
@@ -256,7 +257,6 @@ extern void __init inode_init_early(void
 extern void __init mnt_init(unsigned long);
 extern void __init files_init(unsigned long);
 
-struct buffer_head;
 typedef int (get_block_t)(struct inode *inode, sector_t iblock,
 			struct buffer_head *bh_result, int create);
 typedef void (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
diff -ruNpX /home/jack/.kerndiffexclude linux-2.6.18-1-mark_error_buffer/include/linux/mm.h linux-2.6.18-2-buffer_headers/include/linux/mm.h
--- linux-2.6.18-1-mark_error_buffer/include/linux/mm.h	2006-10-02 18:27:46.000000000 +0200
+++ linux-2.6.18-2-buffer_headers/include/linux/mm.h	2006-10-06 13:09:38.000000000 +0200
@@ -759,6 +759,8 @@ static inline int handle_mm_fault(struct
 }
 #endif
 
+struct writeback_control;
+struct file_ra_state;
 extern int make_pages_present(unsigned long addr, unsigned long end);
 extern int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len, int write);
 void install_arg_page(struct vm_area_struct *, struct page *, unsigned long);
