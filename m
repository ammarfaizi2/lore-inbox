Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285153AbRL2SS2>; Sat, 29 Dec 2001 13:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285161AbRL2SSP>; Sat, 29 Dec 2001 13:18:15 -0500
Received: from colorfullife.com ([216.156.138.34]:30728 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S285183AbRL2SSB>;
	Sat, 29 Dec 2001 13:18:01 -0500
Date: Sat, 29 Dec 2001 13:23:11 -0500
From: Manfred Spraul <manfred@colorfullife.com>
Message-Id: <200112291823.fBTINBb29439@colorfullife.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC, CFT] include file cleanup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

slab.h is currently one of the worst include files:
it includes <mm.h>, that one <sched.h>, that one <fs.h>, 
just because it needs the GFP_ defines.

I've split the gfp functions out of mm.h into a seperate <gfp.h>
header file.

Is that a step in the right direction?
Another similar cleanup would be  splitting the 'struct task_struct'
definition out of sched.h into a seperate <linux/current.h>:
some source files only include sched.h because they dereference
one field within current.

Any comments?
The patch is against 2.5.1-dj6, but also applies to 2.5.2-pre3
with some minor line shifts.

--
	Manfred
<<<<<<<<<<<< PATCH:
diff -urN 2.5/fs/autofs/inode.c build-2.5/fs/autofs/inode.c
--- 2.5/fs/autofs/inode.c	Sat Jul  7 13:06:13 2001
+++ build-2.5/fs/autofs/inode.c	Sat Dec 29 16:42:30 2001
@@ -11,6 +11,7 @@
  * ------------------------------------------------------------------------- */
 
 #include <linux/kernel.h>
+#include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/file.h>
 #include <linux/locks.h>
diff -urN 2.5/fs/char_dev.c build-2.5/fs/char_dev.c
--- 2.5/fs/char_dev.c	Sun Nov 11 11:36:22 2001
+++ build-2.5/fs/char_dev.c	Sat Dec 29 17:05:18 2001
@@ -6,6 +6,7 @@
 
 #include <linux/config.h>
 #include <linux/init.h>
+#include <linux/fs.h>
 #include <linux/slab.h>
 
 #define HASH_BITS	6
diff -urN 2.5/fs/isofs/joliet.c build-2.5/fs/isofs/joliet.c
--- 2.5/fs/isofs/joliet.c	Thu Aug 16 23:06:06 2001
+++ build-2.5/fs/isofs/joliet.c	Sat Dec 29 16:44:12 2001
@@ -8,7 +8,7 @@
 
 #include <linux/string.h>
 #include <linux/nls.h>
-#include <linux/slab.h>
+#include <linux/mm.h>
 #include <linux/iso_fs.h>
 #include <asm/unaligned.h>
 
diff -urN 2.5/fs/isofs/namei.c build-2.5/fs/isofs/namei.c
--- 2.5/fs/isofs/namei.c	Mon Dec 17 17:23:59 2001
+++ build-2.5/fs/isofs/namei.c	Sat Dec 29 16:43:39 2001
@@ -12,7 +12,7 @@
 #include <linux/string.h>
 #include <linux/stat.h>
 #include <linux/fcntl.h>
-#include <linux/slab.h>
+#include <linux/mm.h>
 #include <linux/errno.h>
 #include <linux/config.h>	/* Joliet? */
 
diff -urN 2.5/fs/namespace.c build-2.5/fs/namespace.c
--- 2.5/fs/namespace.c	Fri Dec 28 00:31:33 2001
+++ build-2.5/fs/namespace.c	Sat Dec 29 17:12:25 2001
@@ -10,6 +10,7 @@
 
 #include <linux/config.h>
 #include <linux/slab.h>
+#include <linux/sched.h>
 #include <linux/smp_lock.h>
 #include <linux/init.h>
 #include <linux/quotaops.h>
diff -urN 2.5/fs/nfs/write.c build-2.5/fs/nfs/write.c
--- 2.5/fs/nfs/write.c	Fri Dec 28 00:31:33 2001
+++ build-2.5/fs/nfs/write.c	Sat Dec 29 17:30:03 2001
@@ -49,7 +49,7 @@
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/slab.h>
-#include <linux/swap.h>
+#include <linux/mm.h>
 #include <linux/pagemap.h>
 #include <linux/file.h>
 
diff -urN 2.5/fs/nfsd/export.c build-2.5/fs/nfsd/export.c
--- 2.5/fs/nfsd/export.c	Thu Oct 11 15:20:15 2001
+++ build-2.5/fs/nfsd/export.c	Sat Dec 29 18:25:46 2001
@@ -16,6 +16,7 @@
 
 #include <linux/unistd.h>
 #include <linux/slab.h>
+#include <linux/sched.h>
 #include <linux/stat.h>
 #include <linux/in.h>
 
diff -urN 2.5/fs/proc/base.c build-2.5/fs/proc/base.c
--- 2.5/fs/proc/base.c	Fri Dec 28 00:31:34 2001
+++ build-2.5/fs/proc/base.c	Sat Dec 29 16:53:53 2001
@@ -25,6 +25,7 @@
 #include <linux/string.h>
 #include <linux/seq_file.h>
 #include <linux/namespace.h>
+#include <linux/mm.h>
 
 /*
  * For hysterical raisins we keep the same inumbers as in the old procfs.
diff -urN 2.5/fs/qnx4/inode.c build-2.5/fs/qnx4/inode.c
--- 2.5/fs/qnx4/inode.c	Fri Dec 28 00:31:34 2001
+++ build-2.5/fs/qnx4/inode.c	Sat Dec 29 18:28:16 2001
@@ -18,8 +18,8 @@
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
-#include <linux/qnx4_fs.h>
 #include <linux/fs.h>
+#include <linux/qnx4_fs.h>
 #include <linux/locks.h>
 #include <linux/init.h>
 #include <linux/highuid.h>
diff -urN 2.5/fs/qnx4/truncate.c build-2.5/fs/qnx4/truncate.c
--- 2.5/fs/qnx4/truncate.c	Fri Feb 23 15:25:23 2001
+++ build-2.5/fs/qnx4/truncate.c	Sat Dec 29 18:28:07 2001
@@ -13,9 +13,8 @@
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/errno.h>
-#include <linux/slab.h>
-#include <linux/qnx4_fs.h>
 #include <linux/fs.h>
+#include <linux/qnx4_fs.h>
 #include <linux/locks.h>
 #include <asm/uaccess.h>
 
diff -urN 2.5/include/linux/file.h build-2.5/include/linux/file.h
--- 2.5/include/linux/file.h	Wed Aug 23 20:22:26 2000
+++ build-2.5/include/linux/file.h	Sat Dec 29 18:07:10 2001
@@ -5,6 +5,8 @@
 #ifndef __LINUX_FILE_H
 #define __LINUX_FILE_H
 
+#include <linux/sched.h>
+
 extern void FASTCALL(fput(struct file *));
 extern struct file * FASTCALL(fget(unsigned int fd));
  
diff -urN 2.5/include/linux/gfp.h build-2.5/include/linux/gfp.h
--- 2.5/include/linux/gfp.h	Thu Jan  1 01:00:00 1970
+++ build-2.5/include/linux/gfp.h	Sat Dec 29 18:07:00 2001
@@ -0,0 +1,81 @@
+#ifndef __LINUX_GFP_H
+#define __LINUX_GFP_H
+
+#include <linux/mmzone.h>
+#include <linux/stddef.h>
+#include <linux/linkage.h>
+/*
+ * GFP bitmasks..
+ */
+/* Zone modifiers in GFP_ZONEMASK (see linux/mmzone.h - low four bits) */
+#define __GFP_DMA	0x01
+#define __GFP_HIGHMEM	0x02
+
+/* Action modifiers - doesn't change the zoning */
+#define __GFP_WAIT	0x10	/* Can wait and reschedule? */
+#define __GFP_HIGH	0x20	/* Should access emergency pools? */
+#define __GFP_IO	0x40	/* Can start low memory physical IO? */
+#define __GFP_HIGHIO	0x80	/* Can start high mem physical IO? */
+#define __GFP_FS	0x100	/* Can call down to low-level FS? */
+
+#define GFP_NOHIGHIO	(__GFP_HIGH | __GFP_WAIT | __GFP_IO)
+#define GFP_NOIO	(__GFP_HIGH | __GFP_WAIT)
+#define GFP_NOFS	(__GFP_HIGH | __GFP_WAIT | __GFP_IO | __GFP_HIGHIO)
+#define GFP_ATOMIC	(__GFP_HIGH)
+#define GFP_USER	(             __GFP_WAIT | __GFP_IO | __GFP_HIGHIO | __GFP_FS)
+#define GFP_HIGHUSER	(             __GFP_WAIT | __GFP_IO | __GFP_HIGHIO | __GFP_FS | __GFP_HIGHMEM)
+#define GFP_KERNEL	(__GFP_HIGH | __GFP_WAIT | __GFP_IO | __GFP_HIGHIO | __GFP_FS)
+#define GFP_NFS		(__GFP_HIGH | __GFP_WAIT | __GFP_IO | __GFP_HIGHIO | __GFP_FS)
+#define GFP_KSWAPD	(             __GFP_WAIT | __GFP_IO | __GFP_HIGHIO | __GFP_FS)
+
+/* Flag - indicates that the buffer will be suitable for DMA.  Ignored on some
+   platforms, used as appropriate on others */
+
+#define GFP_DMA		__GFP_DMA
+
+/*
+ * There is only one page-allocator function, and two main namespaces to
+ * it. The alloc_page*() variants return 'struct page *' and as such
+ * can allocate highmem pages, the *get*page*() variants return
+ * virtual kernel addresses to the allocated page(s).
+ */
+extern struct page * FASTCALL(_alloc_pages(unsigned int gfp_mask, unsigned int order));
+extern struct page * FASTCALL(__alloc_pages(unsigned int gfp_mask, unsigned int order, zonelist_t *zonelist));
+extern struct page * alloc_pages_node(int nid, unsigned int gfp_mask, unsigned int order);
+
+static inline struct page * alloc_pages(unsigned int gfp_mask, unsigned int order)
+{
+	/*
+	 * Gets optimized away by the compiler.
+	 */
+	if (order >= MAX_ORDER)
+		return NULL;
+	return _alloc_pages(gfp_mask, order);
+}
+
+#define alloc_page(gfp_mask) alloc_pages(gfp_mask, 0)
+
+extern unsigned long FASTCALL(__get_free_pages(unsigned int gfp_mask, unsigned int order));
+extern unsigned long FASTCALL(get_zeroed_page(unsigned int gfp_mask));
+
+#define __get_free_page(gfp_mask) \
+		__get_free_pages((gfp_mask),0)
+
+#define __get_dma_pages(gfp_mask, order) \
+		__get_free_pages((gfp_mask) | GFP_DMA,(order))
+
+/*
+ * The old interface name will be removed in 2.5:
+ */
+#define get_free_page get_zeroed_page
+
+/*
+ * There is only one 'core' page-freeing function.
+ */
+extern void FASTCALL(__free_pages(struct page *page, unsigned int order));
+extern void FASTCALL(free_pages(unsigned long addr, unsigned int order));
+
+#define __free_page(page) __free_pages((page), 0)
+#define free_page(addr) free_pages((addr),0)
+
+#endif /* __LINUX_GFP_H */
diff -urN 2.5/include/linux/interrupt.h build-2.5/include/linux/interrupt.h
--- 2.5/include/linux/interrupt.h	Sun Sep 30 16:25:53 2001
+++ build-2.5/include/linux/interrupt.h	Sat Dec 29 18:07:00 2001
@@ -9,6 +9,7 @@
 
 #include <asm/bitops.h>
 #include <asm/atomic.h>
+#include <asm/system.h>
 #include <asm/ptrace.h>
 
 struct irqaction {
diff -urN 2.5/include/linux/kernel.h build-2.5/include/linux/kernel.h
--- 2.5/include/linux/kernel.h	Fri Dec 28 00:31:36 2001
+++ build-2.5/include/linux/kernel.h	Sat Dec 29 18:07:00 2001
@@ -44,16 +44,6 @@
 #define minimum_console_loglevel (console_printk[2])
 #define default_console_loglevel (console_printk[3])
 
-# define NORET_TYPE    /**/
-# define ATTRIB_NORET  __attribute__((noreturn))
-# define NORET_AND     noreturn,
-
-#ifdef __i386__
-#define FASTCALL(x)	x __attribute__((regparm(3)))
-#else
-#define FASTCALL(x)	x
-#endif
-
 struct completion;
 
 extern struct notifier_block *panic_notifier_list;
diff -urN 2.5/include/linux/linkage.h build-2.5/include/linux/linkage.h
--- 2.5/include/linux/linkage.h	Mon Dec 11 21:49:54 2000
+++ build-2.5/include/linux/linkage.h	Sat Dec 29 16:28:32 2001
@@ -60,4 +60,14 @@
 
 #endif
 
+# define NORET_TYPE    /**/
+# define ATTRIB_NORET  __attribute__((noreturn))
+# define NORET_AND     noreturn,
+
+#ifdef __i386__
+#define FASTCALL(x)	x __attribute__((regparm(3)))
+#else
+#define FASTCALL(x)	x
+#endif
+
 #endif
diff -urN 2.5/include/linux/mm.h build-2.5/include/linux/mm.h
--- 2.5/include/linux/mm.h	Fri Dec 28 00:31:36 2001
+++ build-2.5/include/linux/mm.h	Sat Dec 29 18:07:00 2001
@@ -7,6 +7,7 @@
 #ifdef __KERNEL__
 
 #include <linux/config.h>
+#include <linux/gfp.h>
 #include <linux/string.h>
 #include <linux/list.h>
 #include <linux/mmzone.h>
@@ -344,51 +345,6 @@
 /* The array of struct pages */
 extern mem_map_t * mem_map;
 
-/*
- * There is only one page-allocator function, and two main namespaces to
- * it. The alloc_page*() variants return 'struct page *' and as such
- * can allocate highmem pages, the *get*page*() variants return
- * virtual kernel addresses to the allocated page(s).
- */
-extern struct page * FASTCALL(_alloc_pages(unsigned int gfp_mask, unsigned int order));
-extern struct page * FASTCALL(__alloc_pages(unsigned int gfp_mask, unsigned int order, zonelist_t *zonelist));
-extern struct page * alloc_pages_node(int nid, unsigned int gfp_mask, unsigned int order);
-
-static inline struct page * alloc_pages(unsigned int gfp_mask, unsigned int order)
-{
-	/*
-	 * Gets optimized away by the compiler.
-	 */
-	if (order >= MAX_ORDER)
-		return NULL;
-	return _alloc_pages(gfp_mask, order);
-}
-
-#define alloc_page(gfp_mask) alloc_pages(gfp_mask, 0)
-
-extern unsigned long FASTCALL(__get_free_pages(unsigned int gfp_mask, unsigned int order));
-extern unsigned long FASTCALL(get_zeroed_page(unsigned int gfp_mask));
-
-#define __get_free_page(gfp_mask) \
-		__get_free_pages((gfp_mask),0)
-
-#define __get_dma_pages(gfp_mask, order) \
-		__get_free_pages((gfp_mask) | GFP_DMA,(order))
-
-/*
- * The old interface name will be removed in 2.5:
- */
-#define get_free_page get_zeroed_page
-
-/*
- * There is only one 'core' page-freeing function.
- */
-extern void FASTCALL(__free_pages(struct page *page, unsigned int order));
-extern void FASTCALL(free_pages(unsigned long addr, unsigned int order));
-
-#define __free_page(page) __free_pages((page), 0)
-#define free_page(addr) free_pages((addr),0)
-
 extern void show_free_areas(void);
 extern void show_free_areas_node(pg_data_t *pgdat);
 
@@ -514,35 +470,6 @@
 /* generic vm_area_ops exported for stackable file systems */
 extern int filemap_sync(struct vm_area_struct *, unsigned long,	size_t, unsigned int);
 extern struct page *filemap_nopage(struct vm_area_struct *, unsigned long, int);
-
-/*
- * GFP bitmasks..
- */
-/* Zone modifiers in GFP_ZONEMASK (see linux/mmzone.h - low four bits) */
-#define __GFP_DMA	0x01
-#define __GFP_HIGHMEM	0x02
-
-/* Action modifiers - doesn't change the zoning */
-#define __GFP_WAIT	0x10	/* Can wait and reschedule? */
-#define __GFP_HIGH	0x20	/* Should access emergency pools? */
-#define __GFP_IO	0x40	/* Can start low memory physical IO? */
-#define __GFP_HIGHIO	0x80	/* Can start high mem physical IO? */
-#define __GFP_FS	0x100	/* Can call down to low-level FS? */
-
-#define GFP_NOHIGHIO	(__GFP_HIGH | __GFP_WAIT | __GFP_IO)
-#define GFP_NOIO	(__GFP_HIGH | __GFP_WAIT)
-#define GFP_NOFS	(__GFP_HIGH | __GFP_WAIT | __GFP_IO | __GFP_HIGHIO)
-#define GFP_ATOMIC	(__GFP_HIGH)
-#define GFP_USER	(             __GFP_WAIT | __GFP_IO | __GFP_HIGHIO | __GFP_FS)
-#define GFP_HIGHUSER	(             __GFP_WAIT | __GFP_IO | __GFP_HIGHIO | __GFP_FS | __GFP_HIGHMEM)
-#define GFP_KERNEL	(__GFP_HIGH | __GFP_WAIT | __GFP_IO | __GFP_HIGHIO | __GFP_FS)
-#define GFP_NFS		(__GFP_HIGH | __GFP_WAIT | __GFP_IO | __GFP_HIGHIO | __GFP_FS)
-#define GFP_KSWAPD	(             __GFP_WAIT | __GFP_IO | __GFP_HIGHIO | __GFP_FS)
-
-/* Flag - indicates that the buffer will be suitable for DMA.  Ignored on some
-   platforms, used as appropriate on others */
-
-#define GFP_DMA		__GFP_DMA
 
 static inline unsigned int pf_gfp_mask(unsigned int gfp_mask)
 {
diff -urN 2.5/include/linux/parport.h build-2.5/include/linux/parport.h
--- 2.5/include/linux/parport.h	Fri Nov 23 20:35:39 2001
+++ build-2.5/include/linux/parport.h	Sat Dec 29 18:22:12 2001
@@ -8,6 +8,7 @@
 
 #ifndef _PARPORT_H_
 #define _PARPORT_H_
+#include <linux/sched.h>
 
 /* Start off with user-visible constants */
 
diff -urN 2.5/include/linux/proc_fs.h build-2.5/include/linux/proc_fs.h
--- 2.5/include/linux/proc_fs.h	Sat Jul 21 22:09:10 2001
+++ build-2.5/include/linux/proc_fs.h	Sat Dec 29 18:07:06 2001
@@ -3,6 +3,8 @@
 
 #include <linux/config.h>
 #include <linux/slab.h>
+#include <linux/fs.h>
+#include <asm/atomic.h>
 
 /*
  * The proc filesystem constants/structures
diff -urN 2.5/include/linux/reiserfs_fs.h build-2.5/include/linux/reiserfs_fs.h
--- 2.5/include/linux/reiserfs_fs.h	Fri Dec 28 00:31:37 2001
+++ build-2.5/include/linux/reiserfs_fs.h	Sat Dec 29 18:34:34 2001
@@ -15,10 +15,10 @@
 #include <linux/types.h>
 #ifdef __KERNEL__
 #include <linux/slab.h>
+#include <linux/interrupt.h>
 #include <linux/tqueue.h>
 #include <asm/unaligned.h>
 #include <linux/bitops.h>
-#include <asm/hardirq.h>
 #include <linux/proc_fs.h>
 #endif
 
diff -urN 2.5/include/linux/shm.h build-2.5/include/linux/shm.h
--- 2.5/include/linux/shm.h	Thu Jan  4 23:50:47 2001
+++ build-2.5/include/linux/shm.h	Sat Dec 29 18:13:39 2001
@@ -80,7 +80,6 @@
 asmlinkage long sys_shmat (int shmid, char *shmaddr, int shmflg, unsigned long *addr);
 asmlinkage long sys_shmdt (char *shmaddr);
 asmlinkage long sys_shmctl (int shmid, int cmd, struct shmid_ds *buf);
-extern void shm_unuse(swp_entry_t entry, struct page *page);
 
 #endif /* __KERNEL__ */
 
diff -urN 2.5/include/linux/slab.h build-2.5/include/linux/slab.h
--- 2.5/include/linux/slab.h	Mon Dec 17 17:23:59 2001
+++ build-2.5/include/linux/slab.h	Sat Dec 29 18:07:00 2001
@@ -11,8 +11,8 @@
 
 typedef struct kmem_cache_s kmem_cache_t;
 
-#include	<linux/mm.h>
-#include	<linux/cache.h>
+#include	<linux/gfp.h>
+#include	<linux/types.h>
 
 /* flags for kmem_cache_alloc() */
 #define	SLAB_NOFS		GFP_NOFS
@@ -64,6 +64,7 @@
 extern int FASTCALL(kmem_cache_reap(int));
 extern int slabinfo_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data);
+struct file;
 extern int slabinfo_write_proc(struct file *file, const char *buffer,
 			   unsigned long count, void *data);
 
diff -urN 2.5/include/linux/sunrpc/clnt.h build-2.5/include/linux/sunrpc/clnt.h
--- 2.5/include/linux/sunrpc/clnt.h	Sat Aug 11 16:15:29 2001
+++ build-2.5/include/linux/sunrpc/clnt.h	Sat Dec 29 18:12:02 2001
@@ -15,6 +15,7 @@
 #include <linux/sunrpc/auth.h>
 #include <linux/sunrpc/stats.h>
 #include <linux/sunrpc/xdr.h>
+#include <asm/signal.h>
 
 /*
  * This defines an RPC port mapping
diff -urN 2.5/ipc/shm.c build-2.5/ipc/shm.c
--- 2.5/ipc/shm.c	Mon Dec 17 17:23:59 2001
+++ build-2.5/ipc/shm.c	Sat Dec 29 17:41:07 2001
@@ -17,6 +17,7 @@
 
 #include <linux/config.h>
 #include <linux/slab.h>
+#include <linux/mm.h>
 #include <linux/shm.h>
 #include <linux/init.h>
 #include <linux/file.h>
diff -urN 2.5/kernel/exit.c build-2.5/kernel/exit.c
--- 2.5/kernel/exit.c	Fri Dec 28 00:31:37 2001
+++ build-2.5/kernel/exit.c	Sat Dec 29 16:24:21 2001
@@ -5,6 +5,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/smp_lock.h>
diff -urN 2.5/kernel/pm.c build-2.5/kernel/pm.c
--- 2.5/kernel/pm.c	Sat Apr 28 10:37:27 2001
+++ build-2.5/kernel/pm.c	Sat Dec 29 16:25:20 2001
@@ -20,6 +20,7 @@
 
 #include <linux/module.h>
 #include <linux/spinlock.h>
+#include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/pm.h>
 #include <linux/interrupt.h>
diff -urN 2.5/kernel/sysctl.c build-2.5/kernel/sysctl.c
--- 2.5/kernel/sysctl.c	Mon Dec 17 17:23:59 2001
+++ build-2.5/kernel/sysctl.c	Sat Dec 29 16:24:46 2001
@@ -19,6 +19,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/sysctl.h>
 #include <linux/swapctl.h>
diff -urN 2.5/mm/mempool.c build-2.5/mm/mempool.c
--- 2.5/mm/mempool.c	Mon Dec 17 17:23:59 2001
+++ build-2.5/mm/mempool.c	Sat Dec 29 16:11:18 2001
@@ -8,6 +8,7 @@
  *  started by Ingo Molnar, Copyright (C) 2001
  */
 
+#include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/mempool.h>
diff -urN 2.5/mm/mprotect.c build-2.5/mm/mprotect.c
--- 2.5/mm/mprotect.c	Sun Sep 30 16:25:56 2001
+++ build-2.5/mm/mprotect.c	Sat Dec 29 16:09:19 2001
@@ -3,6 +3,7 @@
  *
  *  (C) Copyright 1994 Linus Torvalds
  */
+#include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
 #include <linux/shm.h>
diff -urN 2.5/mm/mremap.c build-2.5/mm/mremap.c
--- 2.5/mm/mremap.c	Sun Sep 30 16:25:56 2001
+++ build-2.5/mm/mremap.c	Sat Dec 29 16:09:40 2001
@@ -4,6 +4,7 @@
  *	(C) Copyright 1996 Linus Torvalds
  */
 
+#include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
 #include <linux/shm.h>
diff -urN 2.5/mm/slab.c build-2.5/mm/slab.c
--- 2.5/mm/slab.c	Fri Dec 28 00:31:37 2001
+++ build-2.5/mm/slab.c	Sat Dec 29 15:49:01 2001
@@ -70,6 +70,8 @@
 
 #include	<linux/config.h>
 #include	<linux/slab.h>
+#include	<linux/mm.h>
+#include	<linux/cache.h>
 #include	<linux/interrupt.h>
 #include	<linux/init.h>
 #include	<linux/compiler.h>
diff -urN 2.5/mm/swapfile.c build-2.5/mm/swapfile.c
--- 2.5/mm/swapfile.c	Fri Dec 28 00:31:37 2001
+++ build-2.5/mm/swapfile.c	Sat Dec 29 16:10:31 2001
@@ -5,6 +5,7 @@
  *  Swap reorganised 29.12.95, Stephen Tweedie
  */
 
+#include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
 #include <linux/kernel_stat.h>
diff -urN 2.5/mm/vmscan.c build-2.5/mm/vmscan.c
--- 2.5/mm/vmscan.c	Fri Dec 28 00:31:37 2001
+++ build-2.5/mm/vmscan.c	Sat Dec 29 16:10:14 2001
@@ -11,6 +11,7 @@
  *  Multiqueue VM started 5.8.00, Rik van Riel.
  */
 
+#include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/kernel_stat.h>
 #include <linux/swap.h>
diff -urN 2.5/net/sunrpc/auth_null.c build-2.5/net/sunrpc/auth_null.c
--- 2.5/net/sunrpc/auth_null.c	Thu Aug 16 23:06:11 2001
+++ build-2.5/net/sunrpc/auth_null.c	Sat Dec 29 17:37:49 2001
@@ -7,11 +7,11 @@
  */
 
 #include <linux/types.h>
-#include <linux/slab.h>
 #include <linux/socket.h>
 #include <linux/in.h>
 #include <linux/utsname.h>
 #include <linux/sunrpc/clnt.h>
+#include <linux/sched.h>
 
 #ifdef RPC_DEBUG
 # define RPCDBG_FACILITY	RPCDBG_AUTH
diff -urN 2.5/net/sunrpc/auth_unix.c build-2.5/net/sunrpc/auth_unix.c
--- 2.5/net/sunrpc/auth_unix.c	Thu Aug 16 23:06:11 2001
+++ build-2.5/net/sunrpc/auth_unix.c	Sat Dec 29 17:39:28 2001
@@ -7,7 +7,7 @@
  */
 
 #include <linux/types.h>
-#include <linux/slab.h>
+#include <linux/sched.h>
 #include <linux/socket.h>
 #include <linux/in.h>
 #include <linux/sunrpc/clnt.h>
--- 2.5/fs/nls/nls_base.c	Fri Feb 23 15:25:23 2001
+++ build-2.5/fs/nls/nls_base.c	Sat Dec 29 18:50:02 2001
@@ -13,7 +13,7 @@
 #include <linux/string.h>
 #include <linux/config.h>
 #include <linux/nls.h>
-#include <linux/slab.h>
+#include <linux/kernel.h>
 #include <linux/errno.h>
 #ifdef CONFIG_KMOD
 #include <linux/kmod.h>
--- 2.5/fs/freevxfs/vxfs_inode.c	Mon Dec 17 17:23:58 2001
+++ build-2.5/fs/freevxfs/vxfs_inode.c	Sat Dec 29 18:54:34 2001
@@ -35,6 +35,7 @@
 #include <linux/fs.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
+#include <linux/pagemap.h>
 
 #include "vxfs.h"
 #include "vxfs_inode.h"
