Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291394AbSCIHOv>; Sat, 9 Mar 2002 02:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291475AbSCIHOn>; Sat, 9 Mar 2002 02:14:43 -0500
Received: from zeus.kernel.org ([204.152.189.113]:61645 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S291399AbSCIHOc>;
	Sat, 9 Mar 2002 02:14:32 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
In-Reply-To: <Pine.LNX.4.33.0203080953420.2608-100000@penguin.transmeta.com>
In-Reply-To: <E16i8x2-0008TV-00@wagner.rustcorp.com.au>
	<Pine.LNX.4.33.0203080953420.2608-100000@penguin.transmeta.com>
Date: Sat, 09 Mar 2002 15:51:24 +1100
Message-Id: <E16jYpc-0003UW-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Mar 2002 10:07:51 -0800 (PST)
Linus Torvalds <torvalds@transmeta.com> wrote:
> This doesn't work on highmem machines - doing the conversion from "<struct
> page, offset>" to "page_address(page)+offset" is simply not legal (not
> even for pure hashing purposes - page_address() changes as you kmap it).

Thanks for the catch.  Am not blessed (cursed?) with highmem here.

> You need to keep the <struct page,offset> tuple in that format, and no
> other. And when you actually touch the page, you need to do the
> kmap()/kunmap() (and you must not keep it mapped while you sleep, because
> that might trivially make the kernel run out of virtual mappings).

Ick: not allowing for one virtual mapping per process is pretty horrible.
Still, pretty easy to fix.

Also updated syscall numbers for 2.5.6, and changed FUTEX_UP/DOWN definitions
to be more logical for future expansions (eg. r/w).

Rusty.
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6/arch/i386/kernel/entry.S working-2.5.6-futex-6/arch/i386/kernel/entry.S
--- linux-2.5.6/arch/i386/kernel/entry.S	Fri Mar  8 14:49:11 2002
+++ working-2.5.6-futex-6/arch/i386/kernel/entry.S	Sat Mar  9 14:09:10 2002
@@ -717,6 +717,7 @@
 	.long SYMBOL_NAME(sys_fremovexattr)
 	.long SYMBOL_NAME(sys_tkill)
 	.long SYMBOL_NAME(sys_sendfile64)
+	.long SYMBOL_NAME(sys_futex)		/* 240 */
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long SYMBOL_NAME(sys_ni_syscall)
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6/arch/ppc/kernel/misc.S working-2.5.6-futex-6/arch/ppc/kernel/misc.S
--- linux-2.5.6/arch/ppc/kernel/misc.S	Fri Mar  8 14:49:11 2002
+++ working-2.5.6-futex-6/arch/ppc/kernel/misc.S	Sat Mar  9 14:08:24 2002
@@ -1289,6 +1289,7 @@
 	.long sys_removexattr
 	.long sys_lremovexattr
 	.long sys_fremovexattr	/* 220 */
+	.long sys_futex
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long sys_ni_syscall
 	.endr
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6/include/asm-i386/mman.h working-2.5.6-futex-6/include/asm-i386/mman.h
--- linux-2.5.6/include/asm-i386/mman.h	Wed Mar 15 12:45:20 2000
+++ working-2.5.6-futex-6/include/asm-i386/mman.h	Sat Mar  9 14:32:43 2002
@@ -4,6 +4,7 @@
 #define PROT_READ	0x1		/* page can be read */
 #define PROT_WRITE	0x2		/* page can be written */
 #define PROT_EXEC	0x4		/* page can be executed */
+#define PROT_SEM	0x8		/* page may be used for atomic ops */
 #define PROT_NONE	0x0		/* page can not be accessed */
 
 #define MAP_SHARED	0x01		/* Share changes */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6/include/asm-i386/unistd.h working-2.5.6-futex-6/include/asm-i386/unistd.h
--- linux-2.5.6/include/asm-i386/unistd.h	Fri Mar  8 14:49:28 2002
+++ working-2.5.6-futex-6/include/asm-i386/unistd.h	Sat Mar  9 14:09:31 2002
@@ -244,6 +244,7 @@
 #define __NR_fremovexattr	237
 #define __NR_tkill		238
 #define __NR_sendfile64		239
+#define __NR_futex		240
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6/include/asm-ppc/mman.h working-2.5.6-futex-6/include/asm-ppc/mman.h
--- linux-2.5.6/include/asm-ppc/mman.h	Tue May 22 08:02:06 2001
+++ working-2.5.6-futex-6/include/asm-ppc/mman.h	Sat Mar  9 14:32:39 2002
@@ -7,6 +7,7 @@
 #define PROT_READ	0x1		/* page can be read */
 #define PROT_WRITE	0x2		/* page can be written */
 #define PROT_EXEC	0x4		/* page can be executed */
+#define PROT_SEM	0x8		/* page may be used for atomic ops */
 #define PROT_NONE	0x0		/* page can not be accessed */
 
 #define MAP_SHARED	0x01		/* Share changes */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6/include/asm-ppc/unistd.h working-2.5.6-futex-6/include/asm-ppc/unistd.h
--- linux-2.5.6/include/asm-ppc/unistd.h	Wed Feb 20 17:57:18 2002
+++ working-2.5.6-futex-6/include/asm-ppc/unistd.h	Sat Mar  9 14:08:27 2002
@@ -228,6 +228,7 @@
 #define __NR_removexattr	218
 #define __NR_lremovexattr	219
 #define __NR_fremovexattr	220
+#define __NR_futex		221
 
 #define __NR(n)	#n
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6/include/linux/futex.h working-2.5.6-futex-6/include/linux/futex.h
--- linux-2.5.6/include/linux/futex.h	Thu Jan  1 10:00:00 1970
+++ working-2.5.6-futex-6/include/linux/futex.h	Sat Mar  9 14:08:24 2002
@@ -0,0 +1,8 @@
+#ifndef _LINUX_FUTEX_H
+#define _LINUX_FUTEX_H
+
+/* Second argument to futex syscall */
+#define FUTEX_UP (0)
+#define FUTEX_DOWN (1)
+
+#endif
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6/include/linux/hash.h working-2.5.6-futex-6/include/linux/hash.h
--- linux-2.5.6/include/linux/hash.h	Thu Jan  1 10:00:00 1970
+++ working-2.5.6-futex-6/include/linux/hash.h	Sat Mar  9 14:08:27 2002
@@ -0,0 +1,58 @@
+#ifndef _LINUX_HASH_H
+#define _LINUX_HASH_H
+/* Fast hashing routine for a long.
+   (C) 2002 William Lee Irwin III, IBM */
+
+/*
+ * Knuth recommends primes in approximately golden ratio to the maximum
+ * integer representable by a machine word for multiplicative hashing.
+ * Chuck Lever verified the effectiveness of this technique:
+ * http://www.citi.umich.edu/techreports/reports/citi-tr-00-1.pdf
+ *
+ * These primes are chosen to be bit-sparse, that is operations on
+ * them can use shifts and additions instead of multiplications for
+ * machines where multiplications are slow.
+ */
+#if BITS_PER_LONG == 32
+/* 2^31 + 2^29 - 2^25 + 2^22 - 2^19 - 2^16 + 1 */
+#define GOLDEN_RATIO_PRIME 0x9e370001UL
+#elif BITS_PER_LONG == 64
+/*  2^63 + 2^61 - 2^57 + 2^54 - 2^51 - 2^18 + 1 */
+#define GOLDEN_RATIO_PRIME 0x9e37fffffffc0001UL
+#else
+#error Define GOLDEN_RATIO_PRIME for your wordsize.
+#endif
+
+static inline unsigned long hash_long(unsigned long val, unsigned int bits)
+{
+	unsigned long hash = val;
+
+#if BITS_PER_LONG == 64
+	/*  Sigh, gcc can't optimise this alone like it does for 32 bits. */
+	unsigned long n = hash;
+	n <<= 18;
+	hash -= n;
+	n <<= 33;
+	hash -= n;
+	n <<= 3;
+	hash += n;
+	n <<= 3;
+	hash -= n;
+	n <<= 4;
+	hash += n;
+	n <<= 2;
+	hash += n;
+#else
+	/* On some cpus multiply is faster, on others gcc will do shifts */
+	hash *= GOLDEN_RATIO_PRIME;
+#endif
+
+	/* High bits are more random, so use them. */
+	return hash >> (BITS_PER_LONG - bits);
+}
+	
+static inline unsigned long hash_ptr(void *ptr, unsigned int bits)
+{
+	return hash_long((unsigned long)ptr, bits);
+}
+#endif /* _LINUX_HASH_H */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6/include/linux/mmzone.h working-2.5.6-futex-6/include/linux/mmzone.h
--- linux-2.5.6/include/linux/mmzone.h	Fri Mar  1 22:58:34 2002
+++ working-2.5.6-futex-6/include/linux/mmzone.h	Sat Mar  9 14:52:15 2002
@@ -51,8 +51,7 @@
 	/*
 	 * wait_table		-- the array holding the hash table
 	 * wait_table_size	-- the size of the hash table array
-	 * wait_table_shift	-- wait_table_size
-	 * 				== BITS_PER_LONG (1 << wait_table_bits)
+	 * wait_table_bits	-- wait_table_size == (1 << wait_table_bits)
 	 *
 	 * The purpose of all these is to keep track of the people
 	 * waiting for a page to become available and make them
@@ -75,7 +74,7 @@
 	 */
 	wait_queue_head_t	* wait_table;
 	unsigned long		wait_table_size;
-	unsigned long		wait_table_shift;
+	unsigned long		wait_table_bits;
 
 	/*
 	 * Discontig memory support fields.
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6/kernel/Makefile working-2.5.6-futex-6/kernel/Makefile
--- linux-2.5.6/kernel/Makefile	Wed Feb 20 17:56:17 2002
+++ working-2.5.6-futex-6/kernel/Makefile	Sat Mar  9 14:08:27 2002
@@ -15,7 +15,7 @@
 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o info.o time.o softirq.o resource.o \
 	    sysctl.o acct.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o context.o 
+	    signal.o sys.o kmod.o context.o futex.o
 
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6/kernel/futex.c working-2.5.6-futex-6/kernel/futex.c
--- linux-2.5.6/kernel/futex.c	Thu Jan  1 10:00:00 1970
+++ working-2.5.6-futex-6/kernel/futex.c	Sat Mar  9 15:03:13 2002
@@ -0,0 +1,232 @@
+/*
+ *  Fast Userspace Mutexes (which I call "Futexes!").
+ *  (C) Rusty Russell, IBM 2002
+ *
+ *  Thanks to Ben LaHaise for yelling "hashed waitqueues" loudly
+ *  enough at me, Linus for the original (flawed) idea, Matthew
+ *  Kirkwood for proof-of-concept implementation.
+ *
+ *  "The futexes are also cursed."
+ *  "But they come in a choice of three flavours!"
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#include <linux/kernel.h>
+#include <linux/spinlock.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/hash.h>
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/futex.h>
+#include <linux/highmem.h>
+#include <asm/atomic.h>
+
+/* These mutexes are a very simple counter: the winner is the one who
+   decrements from 1 to 0.  The counter starts at 1 when the lock is
+   free.  A value other than 0 or 1 means someone may be sleeping.
+   This is simple enough to work on all architectures, but has the
+   problem that if we never "up" the semaphore it could eventually
+   wrap around. */
+
+/* FIXME: This may be way too small. --RR */
+#define FUTEX_HASHBITS 6
+
+/* We use this instead of a normal wait_queue_t, so we can wake only
+   the relevent ones (hashed queues may be shared) */
+struct futex_q {
+	struct list_head list;
+	struct task_struct *task;
+	/* Page struct and offset within it. */
+	struct page *page;
+	unsigned int offset;
+};
+
+/* The key for the hash is the address + index + offset within page */
+static struct list_head futex_queues[1<<FUTEX_HASHBITS];
+static spinlock_t futex_lock = SPIN_LOCK_UNLOCKED;
+
+static inline struct list_head *hash_futex(struct page *page,
+					   unsigned long offset)
+{
+	unsigned long h;
+
+	/* struct page is shared, so we can hash on its address */
+	h = (unsigned long)page + offset;
+	return &futex_queues[hash_long(h, FUTEX_HASHBITS)];
+}
+
+static inline void wake_one_waiter(struct list_head *head,
+				   struct page *page,
+				   unsigned int offset)
+{
+	struct list_head *i;
+
+	spin_lock(&futex_lock);
+	list_for_each(i, head) {
+		struct futex_q *this = list_entry(i, struct futex_q, list);
+
+		if (this->page == page && this->offset == offset) {
+			wake_up_process(this->task);
+			break;
+		}
+	}
+	spin_unlock(&futex_lock);
+}
+
+/* Add at end to avoid starvation */
+static inline void queue_me(struct list_head *head,
+			    struct futex_q *q,
+			    struct page *page,
+			    unsigned int offset)
+{
+	q->task = current;
+	q->page = page;
+	q->offset = offset;
+
+	spin_lock(&futex_lock);
+	list_add_tail(&q->list, head);
+	spin_unlock(&futex_lock);
+}
+
+static inline void unqueue_me(struct futex_q *q)
+{
+	spin_lock(&futex_lock);
+	list_del(&q->list);
+	spin_unlock(&futex_lock);
+}
+
+/* Get kernel address of the user page and pin it. */
+static struct page *pin_page(unsigned long page_start)
+{
+	struct mm_struct *mm = current->mm;
+	struct page *page;
+	int err;
+
+	down_read(&mm->mmap_sem);
+	err = get_user_pages(current, current->mm, page_start,
+			     1 /* one page */,
+			     1 /* writable */,
+			     0 /* don't force */,
+			     &page,
+			     NULL /* don't return vmas */);
+	up_read(&mm->mmap_sem);
+
+	if (err < 0)
+		return ERR_PTR(err);
+	return page;
+}
+
+/* Try to decrement the user count to zero. */
+static int decrement_to_zero(struct page *page, unsigned int offset)
+{
+	atomic_t *count;
+	int ret = 0;
+
+	count = kmap(page) + offset;
+	/* If we take the semaphore from 1 to 0, it's ours.  If it's
+           zero, decrement anyway, to indicate we are waiting.  If
+           it's negative, don't decrement so we don't wrap... */
+	if (atomic_read(count) >= 0 && atomic_dec_and_test(count))
+		ret = 1;
+	kunmap(page);
+	return ret;
+}
+
+/* Simplified from arch/ppc/kernel/semaphore.c: Paul M. is a genius. */
+static int futex_down(struct list_head *head, struct page *page, int offset)
+{
+	int retval = 0;
+	struct futex_q q;
+
+	current->state = TASK_INTERRUPTIBLE;
+	queue_me(head, &q, page, offset);
+
+	while (!decrement_to_zero(page, offset)) {
+		if (signal_pending(current)) {
+			retval = -EINTR;
+			break;
+		}
+		schedule();
+		current->state = TASK_INTERRUPTIBLE;
+	}
+	current->state = TASK_RUNNING;
+	unqueue_me(&q);
+	/* If we were signalled, we might have just been woken: we
+	   must wake another one.  Otherwise we need to wake someone
+	   else (if they are waiting) so they drop the count below 0,
+	   and when we "up" in userspace, we know there is a
+	   waiter. */
+	wake_one_waiter(head, page, offset);
+	return retval;
+}
+
+static int futex_up(struct list_head *head, struct page *page, int offset)
+{
+	atomic_t *count;
+
+	count = kmap(page) + offset;
+	atomic_set(count, 1);
+	smp_wmb();
+	kunmap(page);
+	wake_one_waiter(head, page, offset);
+	return 0;
+}
+
+asmlinkage int sys_futex(void *uaddr, int op)
+{
+	int ret;
+	unsigned long pos_in_page;
+	struct list_head *head;
+	struct page *page;
+
+	pos_in_page = ((unsigned long)uaddr) % PAGE_SIZE;
+
+	/* Must be "naturally" aligned, and not on page boundary. */
+	if ((pos_in_page % __alignof__(atomic_t)) != 0
+	    || pos_in_page + sizeof(atomic_t) > PAGE_SIZE)
+		return -EINVAL;
+
+	/* Simpler if it doesn't vanish underneath us. */
+	page = pin_page((unsigned long)uaddr - pos_in_page);
+	if (IS_ERR(page))
+		return PTR_ERR(page);
+
+	head = hash_futex(page, pos_in_page);
+	switch (op) {
+	case FUTEX_UP:
+		ret = futex_up(head, page, pos_in_page);
+		break;
+	case FUTEX_DOWN:
+		ret = futex_down(head, page, pos_in_page);
+		break;
+	/* Add other lock types here... */
+	default:
+		ret = -EINVAL;
+	}
+	put_page(page);
+
+	return ret;
+}
+
+static int __init init(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(futex_queues); i++)
+		INIT_LIST_HEAD(&futex_queues[i]);
+	return 0;
+}
+__initcall(init);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6/mm/filemap.c working-2.5.6-futex-6/mm/filemap.c
--- linux-2.5.6/mm/filemap.c	Fri Mar  8 14:49:30 2002
+++ working-2.5.6-futex-6/mm/filemap.c	Sat Mar  9 14:08:27 2002
@@ -25,6 +25,7 @@
 #include <linux/iobuf.h>
 #include <linux/compiler.h>
 #include <linux/fs.h>
+#include <linux/hash.h>
 
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
@@ -773,32 +774,8 @@
 static inline wait_queue_head_t *page_waitqueue(struct page *page)
 {
 	const zone_t *zone = page_zone(page);
-	wait_queue_head_t *wait = zone->wait_table;
-	unsigned long hash = (unsigned long)page;
 
-#if BITS_PER_LONG == 64
-	/*  Sigh, gcc can't optimise this alone like it does for 32 bits. */
-	unsigned long n = hash;
-	n <<= 18;
-	hash -= n;
-	n <<= 33;
-	hash -= n;
-	n <<= 3;
-	hash += n;
-	n <<= 3;
-	hash -= n;
-	n <<= 4;
-	hash += n;
-	n <<= 2;
-	hash += n;
-#else
-	/* On some cpus multiply is faster, on others gcc will do shifts */
-	hash *= GOLDEN_RATIO_PRIME;
-#endif
-
-	hash >>= zone->wait_table_shift;
-
-	return &wait[hash];
+	return &zone->wait_table[hash_ptr(page, zone->wait_table_bits)];
 }
 
 /* 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6/mm/mprotect.c working-2.5.6-futex-6/mm/mprotect.c
--- linux-2.5.6/mm/mprotect.c	Wed Feb 20 17:57:21 2002
+++ working-2.5.6-futex-6/mm/mprotect.c	Sat Mar  9 14:32:32 2002
@@ -280,7 +280,7 @@
 	end = start + len;
 	if (end < start)
 		return -EINVAL;
-	if (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC))
+	if (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM))
 		return -EINVAL;
 	if (end == start)
 		return 0;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6/mm/page_alloc.c working-2.5.6-futex-6/mm/page_alloc.c
--- linux-2.5.6/mm/page_alloc.c	Fri Mar  8 14:49:30 2002
+++ working-2.5.6-futex-6/mm/page_alloc.c	Sat Mar  9 14:08:27 2002
@@ -776,8 +776,8 @@
 		 * per zone.
 		 */
 		zone->wait_table_size = wait_table_size(size);
-		zone->wait_table_shift =
-			BITS_PER_LONG - wait_table_bits(zone->wait_table_size);
+		zone->wait_table_bits =
+			wait_table_bits(zone->wait_table_size);
 		zone->wait_table = (wait_queue_head_t *)
 			alloc_bootmem_node(pgdat, zone->wait_table_size
 						* sizeof(wait_queue_head_t));
