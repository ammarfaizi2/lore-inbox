Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbVIETuR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbVIETuR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 15:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbVIETuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 15:50:17 -0400
Received: from mailfe11.swipnet.se ([212.247.155.65]:63224 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S1750786AbVIETuP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 15:50:15 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Date: Mon, 5 Sep 2005 21:50:01 +0200
From: Alexander Nyberg <alexn@telia.com>
To: linux-kernel@vger.kernel.org
Subject: Some debugging patches on top of -mm
Message-ID: <20050905195001.GA10223@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

These are debugging patches on-top of -mm that makes it possible
for those arches that want to be able to to save caller traces
of who allocates pages and slab objects.

Any arch that wants to use this could make a next_stack_func function
that goes through the stack starting at *prev_addr and finds the next
function return address. 'count' is for when we can use the frame
pointer (CONFIG_FRAME_POINTER) to get accurate backtraces.

For x86 it goes like:

unsigned long *next_stack_func(unsigned long *prev_addr, int count)
{
        struct thread_info *tinfo = current_thread_info();

        if (!prev_addr)
                return NULL;

#ifdef CONFIG_FRAME_POINTER
        /* In this case 'prev_addr' is a pointer to the last return
         * function found on the stack */
        if (count == 0) {
                unsigned long ebp;
                unsigned long *func_ptr;

                asm ("movl %%ebp, %0" : "=r" (ebp) : );
                /* We don't want the obvious caller to show up */
                ebp = *(unsigned long *) ebp;
                func_ptr = (unsigned long *)(ebp + 4);
                if (valid_stack_ptr(tinfo, func_ptr))
                        return func_ptr;
        } else {
                unsigned long *func_ptr;
                unsigned long ebp = (unsigned long) prev_addr;

                ebp -= 4;

                ebp = *(unsigned long *) ebp;
                func_ptr = (unsigned long *) ((unsigned long)ebp + 4);
                if (valid_stack_ptr(tinfo, func_ptr))
                        return func_ptr;
        }
#else
        while (prev_addr++) {
                if (!valid_stack_ptr(tinfo, prev_addr))
                        break;
                if (__kernel_text_address(*prev_addr))
                        return prev_addr;
        }
#endif
        return NULL;
}


1) A "generic" next_stack_func() for arches that want to have these
debugging facilities

2) Saving more slab object call traces via DBG_DEBUGWORDS. Now uses
next_stack_func(). This still prints to the console, oh well...
(I have not made SLAB_DEBUG conditional on x86 so it won't compile on
non-x86 arches with these patches currently...)

3) Simplification of the page-owner-leak-detector to use next_stack_func()
so that any arch that wants it can use it.



--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="generic_stack_trace.patch"

Index: mm/arch/i386/kernel/traps.c
===================================================================
--- mm.orig/arch/i386/kernel/traps.c	2005-09-03 11:22:39.000000000 +0200
+++ mm/arch/i386/kernel/traps.c	2005-09-03 18:17:00.000000000 +0200
@@ -148,6 +148,48 @@
 		p < (void *)tinfo + THREAD_SIZE - 3;
 }
 
+unsigned long *next_stack_func(unsigned long *prev_addr, int count)
+{
+	struct thread_info *tinfo = current_thread_info();
+
+	if (!prev_addr)
+		return NULL;
+
+#ifdef CONFIG_FRAME_POINTER
+	/* In this case 'prev_addr' is a pointer to the last return
+	 * function found on the stack */
+	if (count == 0) {
+		unsigned long ebp;
+		unsigned long *func_ptr;
+
+		asm ("movl %%ebp, %0" : "=r" (ebp) : );
+		/* We don't want the obvious caller to show up */
+		ebp = *(unsigned long *) ebp;
+		func_ptr = (unsigned long *)(ebp + 4);
+		if (valid_stack_ptr(tinfo, func_ptr))
+			return func_ptr;
+	} else {
+		unsigned long *func_ptr;
+		unsigned long ebp = (unsigned long) prev_addr;
+
+		ebp -= 4;
+
+		ebp = *(unsigned long *) ebp;
+		func_ptr = (unsigned long *) ((unsigned long)ebp + 4);
+		if (valid_stack_ptr(tinfo, func_ptr))
+			return func_ptr;
+	}
+#else
+	while (prev_addr++) {
+		if (!valid_stack_ptr(tinfo, prev_addr))
+			break;
+		if (__kernel_text_address(*prev_addr))
+			return prev_addr;
+	}
+#endif
+	return NULL;
+}
+
 static inline unsigned long print_context_stack(struct thread_info *tinfo,
 				unsigned long *stack, unsigned long ebp)
 {
Index: mm/include/linux/sched.h
===================================================================
--- mm.orig/include/linux/sched.h	2005-09-03 11:22:51.000000000 +0200
+++ mm/include/linux/sched.h	2005-09-03 15:52:20.000000000 +0200
@@ -171,6 +171,7 @@
  * trace (or NULL if the entire call-chain of the task should be shown).
  */
 extern void show_stack(struct task_struct *task, unsigned long *sp);
+extern unsigned long *next_stack_func(unsigned long *prev_addr, int count);
 
 void io_schedule(void);
 long io_schedule_timeout(long timeout);
Index: mm/arch/x86_64/kernel/traps.c
===================================================================
--- mm.orig/arch/x86_64/kernel/traps.c	2005-09-03 17:59:16.000000000 +0200
+++ mm/arch/x86_64/kernel/traps.c	2005-09-03 19:00:48.000000000 +0200
@@ -154,6 +154,54 @@
 	return NULL;
 }
 
+static inline int valid_stack_ptr(struct thread_info *tinfo, void *p)
+{
+	return	p > (void *)tinfo &&
+		p < (void *)tinfo + THREAD_SIZE - 3;
+}
+
+unsigned long *next_stack_func(unsigned long *prev_addr, int count)
+{
+	struct thread_info *tinfo = current_thread_info();
+
+	if (!prev_addr)
+		return NULL;
+
+#ifdef CONFIG_FRAME_POINTER
+	/* In this case 'prev_addr' is a pointer to the last return
+	 * function found on the stack */
+	if (count == 0) {
+		unsigned long rbp;
+		unsigned long *func_ptr;
+
+		asm ("movq %%rbp, %0" : "=r" (rbp) : );
+		/* We don't want the obvious caller to show up */
+		rbp = *(unsigned long *) rbp;
+		func_ptr = (unsigned long *)(rbp + 8);
+		if (valid_stack_ptr(tinfo, func_ptr))
+			return func_ptr;
+	} else {
+		unsigned long *func_ptr;
+		unsigned long rbp = (unsigned long) prev_addr;
+
+		rbp -= 8;
+
+		rbp = *(unsigned long *) rbp;
+		func_ptr = (unsigned long *) ((unsigned long)rbp + 8);
+		if (valid_stack_ptr(tinfo, func_ptr))
+			return func_ptr;
+	}
+#else
+	while (prev_addr++) {
+		if (!valid_stack_ptr(tinfo, prev_addr))
+			break;
+		if (__kernel_text_address(*prev_addr))
+			return prev_addr;
+	}
+#endif
+	return NULL;
+}
+
 /*
  * x86-64 can have upto three kernel stacks: 
  * process stack

--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="slab_user_mult.patch"

Index: mm/mm/slab.c
===================================================================
--- mm.orig/mm/slab.c	2005-09-04 12:28:12.000000000 +0200
+++ mm/mm/slab.c	2005-09-05 21:47:06.000000000 +0200
@@ -491,6 +491,9 @@
 #define POISON_FREE	0x6b	/* for use-after-free poisoning */
 #define	POISON_END	0xa5	/* end-byte of poisoning */
 
+/* The number of object caller functions we save */
+#define DBG_USERWORDS 3
+
 /* memory layout of objects:
  * 0		: objp
  * 0 .. cachep->dbghead - BYTES_PER_WORD - 1: padding. This ensures that
@@ -522,14 +525,15 @@
 {
 	BUG_ON(!(cachep->flags & SLAB_RED_ZONE));
 	if (cachep->flags & SLAB_STORE_USER)
-		return (unsigned long*) (objp+cachep->objsize-2*BYTES_PER_WORD);
+		return (unsigned long*) (objp+cachep->objsize-(1+DBG_USERWORDS)*BYTES_PER_WORD);
 	return (unsigned long*) (objp+cachep->objsize-BYTES_PER_WORD);
 }
 
-static void **dbg_userword(kmem_cache_t *cachep, void *objp)
+static unsigned long *dbg_userword(kmem_cache_t *cachep, void *objp)
 {
+	BUILD_BUG_ON(DBG_USERWORDS == 0);
 	BUG_ON(!(cachep->flags & SLAB_STORE_USER));
-	return (void**)(objp+cachep->objsize-BYTES_PER_WORD);
+	return (unsigned long*)(objp+cachep->objsize - DBG_USERWORDS*BYTES_PER_WORD);
 }
 
 #else
@@ -1313,12 +1317,16 @@
 	}
 
 	if (cachep->flags & SLAB_STORE_USER) {
-		printk(KERN_ERR "Last user: [<%p>]",
-				*dbg_userword(cachep, objp));
-		print_symbol("(%s)",
-				(unsigned long)*dbg_userword(cachep, objp));
+		int i;
+
+		printk(KERN_ERR "Last user:\n");
+		for (i = 0; i < DBG_USERWORDS; i++) {
+			printk(KERN_ERR "[<%p>]", (void *) dbg_userword(cachep, objp)[i]);
+			print_symbol("(%s)", dbg_userword(cachep, objp)[i]);
+		}
 		printk("\n");
 	}
+
 	realobj = (char*)objp+obj_dbghead(cachep);
 	size = obj_reallen(cachep);
 	for (i=0; i<size && lines;i+=16, lines--) {
@@ -1533,7 +1541,7 @@
 	 * above the next power of two: caches with object sizes just above a
 	 * power of two have a significant amount of internal fragmentation.
 	 */
-	if ((size < 4096 || fls(size-1) == fls(size-1+3*BYTES_PER_WORD)))
+	if ((size < 4096 || fls(size-1) == fls(size-1+(2 + DBG_USERWORDS)*BYTES_PER_WORD)))
 		flags |= SLAB_RED_ZONE|SLAB_STORE_USER;
 	if (!(flags & SLAB_DESTROY_BY_RCU))
 		flags |= SLAB_POISON;
@@ -1608,12 +1616,11 @@
 		size += 2*BYTES_PER_WORD;
 	}
 	if (flags & SLAB_STORE_USER) {
-		/* user store requires word alignment and
-		 * one word storage behind the end of the real
-		 * object.
+		/* user store requires word alignment and DBG_USERWORDS*word 
+		 * storage behind the end of the real object.
 		 */
 		align = BYTES_PER_WORD;
-		size += BYTES_PER_WORD;
+		size += DBG_USERWORDS * BYTES_PER_WORD;
 	}
 #if FORCED_DEBUG && defined(CONFIG_DEBUG_PAGEALLOC)
 	if (size >= malloc_sizes[INDEX_L3+1].cs_size && cachep->reallen > cache_line_size() && size < PAGE_SIZE) {
@@ -2082,8 +2089,12 @@
 		/* need to poison the objs? */
 		if (cachep->flags & SLAB_POISON)
 			poison_obj(cachep, objp, POISON_FREE);
-		if (cachep->flags & SLAB_STORE_USER)
-			*dbg_userword(cachep, objp) = NULL;
+		if (cachep->flags & SLAB_STORE_USER) {
+			int i;
+
+			for (i = 0; i < DBG_USERWORDS; i++)
+				dbg_userword(cachep, objp)[i] = 0;
+		}
 
 		if (cachep->flags & SLAB_RED_ZONE) {
 			*dbg_redzone1(cachep, objp) = RED_INACTIVE;
@@ -2257,7 +2268,7 @@
 	}
 }
 
-static void *cache_free_debugcheck(kmem_cache_t *cachep, void *objp,
+static void inline *cache_free_debugcheck(kmem_cache_t *cachep, void *objp,
 					void *caller)
 {
 	struct page *page;
@@ -2287,8 +2298,17 @@
 		*dbg_redzone1(cachep, objp) = RED_INACTIVE;
 		*dbg_redzone2(cachep, objp) = RED_INACTIVE;
 	}
-	if (cachep->flags & SLAB_STORE_USER)
-		*dbg_userword(cachep, objp) = caller;
+	if (cachep->flags & SLAB_STORE_USER) {
+		unsigned long *call_ptr = (unsigned long *) &call_ptr;
+		int i;
+
+		for (i = 0; i < DBG_USERWORDS; i++) {
+			call_ptr = next_stack_func(call_ptr, i);
+			if (!call_ptr)
+				break;
+			dbg_userword(cachep, objp)[i] = *call_ptr;
+		}
+	}
 
 	objnr = (objp-slabp->s_mem)/cachep->objsize;
 
@@ -2463,7 +2483,7 @@
 }
 
 #if DEBUG
-static void *
+static void inline *
 cache_alloc_debugcheck_after(kmem_cache_t *cachep,
 			unsigned int __nocast flags, void *objp, void *caller)
 {
@@ -2480,8 +2500,17 @@
 #endif
 		poison_obj(cachep, objp, POISON_INUSE);
 	}
-	if (cachep->flags & SLAB_STORE_USER)
-		*dbg_userword(cachep, objp) = caller;
+	if (cachep->flags & SLAB_STORE_USER) {
+		unsigned long *call_ptr = (unsigned long *) &call_ptr;
+		int i;
+
+		for (i = 0; i < DBG_USERWORDS; i++) {
+			call_ptr = next_stack_func(call_ptr, i);
+			if (!call_ptr)
+				break;
+			dbg_userword(cachep, objp)[i] = *call_ptr;
+		}
+	}
 
 	if (cachep->flags & SLAB_RED_ZONE) {
 		if (*dbg_redzone1(cachep, objp) != RED_INACTIVE || *dbg_redzone2(cachep, objp) != RED_INACTIVE) {
@@ -3518,6 +3547,34 @@
 	.show	= s_show,
 };
 
+#if DEBUG
+#include <linux/nmi.h>
+static inline void dump_slab(kmem_cache_t *cachep, struct slab *slabp)
+{
+	int i;
+	int slab_user = cachep->flags & SLAB_STORE_USER;
+
+	for (i = 0; i < cachep->num; i++) {
+		if (slab_user) {
+			void *objp = slabp->s_mem + cachep->objsize * i;
+			int x;
+
+			for (x = 0; x < DBG_USERWORDS; x++) {
+				printk("obj:%p [%p] ", objp, (void *) dbg_userword(cachep, objp)[x]);
+				print_symbol("<%s>", dbg_userword(cachep, objp)[x]);
+				printk("\n");
+			}
+		} else {
+			unsigned long sym = slab_bufctl(slabp)[i];
+
+			printk("obj %p/%d: %p", slabp, i, (void *)sym);
+			print_symbol(" <%s>", sym);
+			printk("\n");
+		}
+	}
+}
+#endif
+
 static void do_dump_slabp(kmem_cache_t *cachep)
 {
 #if DEBUG
@@ -3531,16 +3588,9 @@
 		spin_lock(&rl3->list_lock);
 
 		list_for_each(q, &rl3->slabs_full) {
-			int i;
 			struct slab *slabp = list_entry(q, struct slab, list);
-
-			for (i = 0; i < cachep->num; i++) {
-				unsigned long sym = slab_bufctl(slabp)[i];
-
-				printk("obj %p/%d: %p", slabp, i, (void *)sym);
-				print_symbol(" <%s>", sym);
-				printk("\n");
-			}
+			dump_slab(cachep, slabp);
+			touch_nmi_watchdog();
 		}
 		spin_unlock(&rl3->list_lock);
 	}

--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="simplify_page_owner.patch"

Index: mm/mm/page_alloc.c
===================================================================
--- mm.orig/mm/page_alloc.c	2005-09-03 19:21:21.000000000 +0200
+++ mm/mm/page_alloc.c	2005-09-03 22:15:07.000000000 +0200
@@ -769,54 +769,22 @@
 }
 
 #ifdef CONFIG_PAGE_OWNER
-static inline int valid_stack_ptr(struct thread_info *tinfo, void *p)
-{
-	return	p > (void *)tinfo &&
-		p < (void *)tinfo + THREAD_SIZE - 3;
-}
-
-static inline void __stack_trace(struct page *page, unsigned long *stack,
-			unsigned long bp)
+static inline void set_page_owner(struct page *page,
+			unsigned int order, unsigned int gfp_mask)
 {
-	int i = 0;
-	unsigned long addr;
-	struct thread_info *tinfo = (struct thread_info *)
-		((unsigned long)stack & (~(THREAD_SIZE - 1)));
+	int i;
+	unsigned long *ptr = (unsigned long *) &ptr;
 
 	memset(page->trace, 0, sizeof(long) * 8);
 
-#ifdef CONFIG_FRAME_POINTER
-	while (valid_stack_ptr(tinfo, (void *)bp)) {
-		addr = *(unsigned long *)(bp + sizeof(long));
-		page->trace[i] = addr;
-		if (++i >= 8)
-			break;
-		bp = *(unsigned long *)bp;
-	}
-#else
-	while (valid_stack_ptr(tinfo, stack)) {
-		addr = *stack++;
-		if (__kernel_text_address(addr)) {
-			page->trace[i] = addr;
-			if (++i >= 8)
-				break;
-		}
-	}
-#endif
-}
-
-static inline void set_page_owner(struct page *page,
-			unsigned int order, unsigned int gfp_mask)
-{
-	unsigned long address, bp;
-#ifdef X86_64
-	asm ("movq %%rbp, %0" : "=r" (bp) : );
-#else
-	asm ("movl %%ebp, %0" : "=r" (bp) : );
-#endif
 	page->order = (int) order;
 	page->gfp_mask = gfp_mask;
-	__stack_trace(page, &address, bp);
+	for (i = 0; i < 8; i++) {
+		ptr = next_stack_func(ptr, i);
+		if (!ptr)
+			return;
+		page->trace[i] = *ptr;
+	}
 }
 #endif /* CONFIG_PAGE_OWNER */
 

--45Z9DzgjV8m4Oswq--
