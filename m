Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130766AbQKXOT1>; Fri, 24 Nov 2000 09:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131072AbQKXOTT>; Fri, 24 Nov 2000 09:19:19 -0500
Received: from 213-123-74-93.btconnect.com ([213.123.74.93]:56837 "EHLO
        penguin.homenet") by vger.kernel.org with ESMTP id <S130765AbQKXNdG>;
        Fri, 24 Nov 2000 08:33:06 -0500
Date: Fri, 24 Nov 2000 13:04:52 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [patch-2.4.0-test11] various small fixes
In-Reply-To: <Pine.LNX.4.10.10011231551210.1702-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0011241257540.1361-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This patch does:

a) cleans up the show_mem() function on various architectures wrt
page_count() macro and the 'free' variable

b) corrects the comment above paging_init() about 0-8M page tables

c) changes the name of kflushd to bdflush. All kernel data structures
around this thread are called bdflush* so kflushd is a wrong name and
bdflush is right.

d) corrects the comments in fs/file.c about __get_free_page() usage; it
should say "vmalloc or kmalloc" for these two are used for array and fd
set allocation

e) corrects the comment in asm-i386/spinlock.h about semaphore.S

f) adds a free_mm() macro to kernel/fork.c to be symmetric to allocate_mm

g) optimizes the vmlist_lock usage by dropping it in vfree() before
freeing the 'tmp' element which was unlinked from vmlist but _after_ the
pages have been freed.

(another thing I wanted to do, but was in doubt, was to force the old lock
nfsservctl request to do do_exit(0) like we do in sys_bdlflush() for old
2.2.x userspace update to self-terminate. This way current rpc.lockd would
not spew out an error but quietly (and successfully, i.e. errcode=0) die,
just like update)

diff -urN -X dontdiff linux/arch/alpha/mm/init.c work/arch/alpha/mm/init.c
--- linux/arch/alpha/mm/init.c	Mon Oct 16 23:38:41 2000
+++ work/arch/alpha/mm/init.c	Fri Nov 24 12:40:52 2000
@@ -185,7 +185,7 @@
 			reserved++;
 		else if (PageSwapCache(mem_map+i))
 			cached++;
-		else if (!atomic_read(&mem_map[i].count))
+		else if (!page_count(mem_map+i))
 			free++;
 		else
 			shared += atomic_read(&mem_map[i].count) - 1;
diff -urN -X dontdiff linux/arch/i386/mm/init.c work/arch/i386/mm/init.c
--- linux/arch/i386/mm/init.c	Mon Oct 23 22:42:33 2000
+++ work/arch/i386/mm/init.c	Fri Nov 24 12:37:56 2000
@@ -198,7 +198,7 @@
 
 void show_mem(void)
 {
-	int i,free = 0, total = 0, reserved = 0;
+	int i, total = 0, reserved = 0;
 	int shared = 0, cached = 0;
 	int highmem = 0;
 
@@ -214,9 +214,7 @@
 			reserved++;
 		else if (PageSwapCache(mem_map+i))
 			cached++;
-		else if (!page_count(mem_map+i))
-			free++;
-		else
+		else if (page_count(mem_map+i))
 			shared += page_count(mem_map+i) - 1;
 	}
 	printk("%d pages of RAM\n", total);
@@ -437,7 +435,7 @@
 }
 
 /*
- * paging_init() sets up the page tables - note that the first 4MB are
+ * paging_init() sets up the page tables - note that the first 8MB are
  * already mapped by head.S.
  *
  * This routines also unmaps the page at virtual kernel address 0, so
diff -urN -X dontdiff linux/arch/ia64/mm/init.c work/arch/ia64/mm/init.c
--- linux/arch/ia64/mm/init.c	Tue Oct 10 01:54:56 2000
+++ work/arch/ia64/mm/init.c	Fri Nov 24 12:38:20 2000
@@ -245,7 +245,7 @@
 void
 show_mem (void)
 {
-	int i,free = 0,total = 0,reserved = 0;
+	int i, total = 0, reserved = 0;
 	int shared = 0, cached = 0;
 
 	printk("Mem-info:\n");
@@ -258,9 +258,7 @@
 			reserved++;
 		else if (PageSwapCache(mem_map+i))
 			cached++;
-		else if (!page_count(mem_map + i))
-			free++;
-		else
+		else if (page_count(mem_map + i))
 			shared += page_count(mem_map + i) - 1;
 	}
 	printk("%d pages of RAM\n", total);
diff -urN -X dontdiff linux/arch/ppc/mm/init.c work/arch/ppc/mm/init.c
--- linux/arch/ppc/mm/init.c	Thu Nov  9 03:01:34 2000
+++ work/arch/ppc/mm/init.c	Fri Nov 24 12:41:53 2000
@@ -293,7 +293,7 @@
 			reserved++;
 		else if (PageSwapCache(mem_map+i))
 			cached++;
-		else if (!atomic_read(&mem_map[i].count))
+		else if (!page_count(mem_map+i))
 			free++;
 		else
 			shared += atomic_read(&mem_map[i].count) - 1;
diff -urN -X dontdiff linux/arch/s390/mm/init.c work/arch/s390/mm/init.c
--- linux/arch/s390/mm/init.c	Mon Oct 16 20:58:51 2000
+++ work/arch/s390/mm/init.c	Fri Nov 24 12:42:08 2000
@@ -192,7 +192,7 @@
 
 void show_mem(void)
 {
-        int i,free = 0,total = 0,reserved = 0;
+        int i, total = 0, reserved = 0;
         int shared = 0, cached = 0;
 
         printk("Mem-info:\n");
@@ -205,9 +205,7 @@
                         reserved++;
                 else if (PageSwapCache(mem_map+i))
                         cached++;
-                else if (!atomic_read(&mem_map[i].count))
-                        free++;
-                else
+                else if (page_count(mem_map+i))
                         shared += atomic_read(&mem_map[i].count) - 1;
         }
         printk("%d pages of RAM\n",total);
diff -urN -X dontdiff linux/arch/sh/mm/init.c work/arch/sh/mm/init.c
--- linux/arch/sh/mm/init.c	Mon Oct 16 20:58:51 2000
+++ work/arch/sh/mm/init.c	Fri Nov 24 12:42:13 2000
@@ -150,7 +150,7 @@
 
 void show_mem(void)
 {
-	int i,free = 0,total = 0,reserved = 0;
+	int i, total = 0, reserved = 0;
 	int shared = 0, cached = 0;
 
 	printk("Mem-info:\n");
@@ -163,9 +163,7 @@
 			reserved++;
 		else if (PageSwapCache(mem_map+i))
 			cached++;
-		else if (!page_count(mem_map+i))
-			free++;
-		else
+		else if (page_count(mem_map+i))
 			shared += page_count(mem_map+i) - 1;
 	}
 	printk("%d pages of RAM\n",total);
diff -urN -X dontdiff linux/fs/buffer.c work/fs/buffer.c
--- linux/fs/buffer.c	Sun Nov 12 02:31:12 2000
+++ work/fs/buffer.c	Fri Nov 24 12:35:53 2000
@@ -2481,9 +2481,9 @@
 		return;
 	}
 
-	/* kflushd can wakeup us before we have a chance to
+	/* bdflush can wakeup us before we have a chance to
 	   go to sleep so we must be smart in handling
-	   this wakeup event from kflushd to avoid deadlocking in SMP
+	   this wakeup event from bdflush to avoid deadlocking in SMP
 	   (we are not holding any lock anymore in these two paths). */
 	__set_current_state(TASK_UNINTERRUPTIBLE);
 	add_wait_queue(&bdflush_done, &wait);
@@ -2646,7 +2646,7 @@
 
 	tsk->session = 1;
 	tsk->pgrp = 1;
-	strcpy(tsk->comm, "kflushd");
+	strcpy(tsk->comm, "bdflush");
 	bdflush_tsk = tsk;
 
 	/* avoid getting signals */
diff -urN -X dontdiff linux/fs/file.c work/fs/file.c
--- linux/fs/file.c	Fri Jul  7 20:20:04 2000
+++ work/fs/file.c	Fri Nov 24 12:32:26 2000
@@ -16,7 +16,7 @@
 
 
 /*
- * Allocate an fd array, using __get_free_page() if possible.
+ * Allocate an fd array, using kmalloc or vmalloc.
  * Note: the array isn't cleared at allocation time.
  */
 struct file ** alloc_fd_array(int num)
@@ -125,7 +125,7 @@
 }
 
 /*
- * Allocate an fdset array, using __get_free_page() if possible.
+ * Allocate an fdset array, using kmalloc or vmalloc.
  * Note: the array isn't cleared at allocation time.
  */
 fd_set * alloc_fdset(int num)
diff -urN -X dontdiff linux/include/asm-i386/spinlock.h work/include/asm-i386/spinlock.h
--- linux/include/asm-i386/spinlock.h	Sun Nov 19 04:56:59 2000
+++ work/include/asm-i386/spinlock.h	Fri Nov 24 12:42:55 2000
@@ -141,7 +141,7 @@
  * Changed to use the same technique as rw semaphores.  See
  * semaphore.h for details.  -ben
  */
-/* the spinlock helpers are in arch/i386/kernel/semaphore.S */
+/* the spinlock helpers are in arch/i386/kernel/semaphore.c */
 
 static inline void read_lock(rwlock_t *rw)
 {
diff -urN -X dontdiff linux/kernel/fork.c work/kernel/fork.c
--- linux/kernel/fork.c	Wed Nov 15 23:13:40 2000
+++ work/kernel/fork.c	Fri Nov 24 12:35:23 2000
@@ -196,6 +196,7 @@
 }
 
 #define allocate_mm()	(kmem_cache_alloc(mm_cachep, SLAB_KERNEL))
+#define free_mm(mm)	(kmem_cache_free(mm_cachep, (mm)))
 
 static struct mm_struct * mm_init(struct mm_struct * mm)
 {
@@ -206,7 +207,7 @@
 	mm->pgd = pgd_alloc();
 	if (mm->pgd)
 		return mm;
-	kmem_cache_free(mm_cachep, mm);
+	free_mm(mm);
 	return NULL;
 }
 	
@@ -236,7 +237,7 @@
 	if (mm == &init_mm) BUG();
 	pgd_free(mm->pgd);
 	destroy_context(mm);
-	kmem_cache_free(mm_cachep, mm);
+	free_mm(mm);
 }
 
 /*
diff -urN -X dontdiff linux/mm/vmalloc.c work/mm/vmalloc.c
--- linux/mm/vmalloc.c	Thu Nov  9 01:03:09 2000
+++ work/mm/vmalloc.c	Fri Nov 24 12:30:34 2000
@@ -215,8 +215,8 @@
 		if (tmp->addr == addr) {
 			*p = tmp->next;
 			vmfree_area_pages(VMALLOC_VMADDR(tmp->addr), tmp->size);
-			kfree(tmp);
 			write_unlock(&vmlist_lock);
+			kfree(tmp);
 			return;
 		}
 	}

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
