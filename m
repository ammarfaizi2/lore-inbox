Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292815AbSCEG6c>; Tue, 5 Mar 2002 01:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292865AbSCEG6Z>; Tue, 5 Mar 2002 01:58:25 -0500
Received: from [202.135.142.194] ([202.135.142.194]:25103 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S292815AbSCEG6Q>; Tue, 5 Mar 2002 01:58:16 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----- =_aaaaaaaaaa0"
Content-ID: <32578.1015311652.0@rustcorp.com.au>
Date: Tue, 05 Mar 2002 18:01:32 +1100
Message-Id: <E16i8x2-0008TV-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------- =_aaaaaaaaaa0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <32578.1015311652.1@rustcorp.com.au>

1) FUTEX_UP and FUTEX_DOWN defines. (Robert Love)
2) Fix for the "decrement wraparound" problem (Paul Mackerras)
3) x86 fixes: tested on dual x86 box.

Example userspace lib attached,
Rusty.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.6-pre2/include/linux/futex.h working-2.5.6-pre2-futex/include/linux/futex.h
--- linux-2.5.6-pre2/include/linux/futex.h	Thu Jan  1 10:00:00 1970
+++ working-2.5.6-pre2-futex/include/linux/futex.h	Tue Mar  5 13:53:33 2002
@@ -0,0 +1,8 @@
+#ifndef _LINUX_FUTEX_H
+#define _LINUX_FUTEX_H
+
+/* Second argument to futex syscall */
+#define FUTEX_UP (1)
+#define FUTEX_DOWN (-1)
+
+#endif
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.6-pre2/kernel/futex.c working-2.5.6-pre2-futex/kernel/futex.c
--- linux-2.5.6-pre2/kernel/futex.c	Thu Jan  1 10:00:00 1970
+++ working-2.5.6-pre2-futex/kernel/futex.c	Tue Mar  5 13:53:33 2002
@@ -0,0 +1,208 @@
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
+	atomic_t *count;
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
+	/* If someone is sleeping, page is pinned.  ie. page_address
+           is a constant when we care about it. */
+	h = (unsigned long)page_address(page) + offset;
+	return &futex_queues[hash_long(h, FUTEX_HASHBITS)];
+}
+
+static inline void wake_one_waiter(struct list_head *head, atomic_t *count)
+{
+	struct list_head *i;
+
+	spin_lock(&futex_lock);
+	list_for_each(i, head) {
+		struct futex_q *this = list_entry(i, struct futex_q, list);
+
+		if (this->count == count) {
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
+			    atomic_t *count)
+{
+	q->task = current;
+	q->count = count;
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
+/* Simplified from arch/ppc/kernel/semaphore.c: Paul M. is a genius. */
+static int futex_down(struct list_head *head, atomic_t *count)
+{
+	int retval = 0;
+	struct futex_q q;
+
+	current->state = TASK_INTERRUPTIBLE;
+	queue_me(head, &q, count);
+
+	/* If we take the semaphore from 1 to 0, it's ours.  But don't
+           bother decrementing if it's already negative. */
+	while (atomic_read(count) < 0 || !atomic_dec_and_test(count)) {
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
+	wake_one_waiter(head, count);
+	return retval;
+}
+
+static int futex_up(struct list_head *head, atomic_t *count)
+{
+	atomic_set(count, 1);
+	smp_wmb();
+	wake_one_waiter(head, count);
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
+		ret = futex_up(head, page_address(page) + pos_in_page);
+		break;
+	case FUTEX_DOWN:
+		ret = futex_down(head, page_address(page) + pos_in_page);
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
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.6-pre2/arch/i386/kernel/entry.S working-2.5.6-pre2-futex/arch/i386/kernel/entry.S
--- linux-2.5.6-pre2/arch/i386/kernel/entry.S	Wed Feb 20 17:56:59 2002
+++ working-2.5.6-pre2-futex/arch/i386/kernel/entry.S	Tue Mar  5 13:53:33 2002
@@ -716,6 +716,7 @@
 	.long SYMBOL_NAME(sys_lremovexattr)
 	.long SYMBOL_NAME(sys_fremovexattr)
 	.long SYMBOL_NAME(sys_tkill)
+	.long SYMBOL_NAME(sys_futex)
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long SYMBOL_NAME(sys_ni_syscall)
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.6-pre2/arch/ppc/kernel/misc.S working-2.5.6-pre2-futex/arch/ppc/kernel/misc.S
--- linux-2.5.6-pre2/arch/ppc/kernel/misc.S	Wed Feb 20 17:57:04 2002
+++ working-2.5.6-pre2-futex/arch/ppc/kernel/misc.S	Tue Mar  5 13:53:33 2002
@@ -1246,6 +1246,7 @@
 	.long sys_removexattr
 	.long sys_lremovexattr
 	.long sys_fremovexattr	/* 220 */
+	.long sys_futex
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long sys_ni_syscall
 	.endr
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.6-pre2/include/asm-i386/mman.h working-2.5.6-pre2-futex/include/asm-i386/mman.h
--- linux-2.5.6-pre2/include/asm-i386/mman.h	Wed Mar 15 12:45:20 2000
+++ working-2.5.6-pre2-futex/include/asm-i386/mman.h	Tue Mar  5 13:53:33 2002
@@ -4,6 +4,7 @@
 #define PROT_READ	0x1		/* page can be read */
 #define PROT_WRITE	0x2		/* page can be written */
 #define PROT_EXEC	0x4		/* page can be executed */
+#define PROT_SEM	0x8		/* page may be used for atomic ops */
 #define PROT_NONE	0x0		/* page can not be accessed */
 
 #define MAP_SHARED	0x01		/* Share changes */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.6-pre2/include/asm-i386/unistd.h working-2.5.6-pre2-futex/include/asm-i386/unistd.h
--- linux-2.5.6-pre2/include/asm-i386/unistd.h	Wed Feb 20 17:56:40 2002
+++ working-2.5.6-pre2-futex/include/asm-i386/unistd.h	Tue Mar  5 13:53:33 2002
@@ -243,6 +243,7 @@
 #define __NR_lremovexattr	236
 #define __NR_fremovexattr	237
 #define __NR_tkill		238
+#define __NR_futex		239
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.6-pre2/include/asm-ppc/mman.h working-2.5.6-pre2-futex/include/asm-ppc/mman.h
--- linux-2.5.6-pre2/include/asm-ppc/mman.h	Tue May 22 08:02:06 2001
+++ working-2.5.6-pre2-futex/include/asm-ppc/mman.h	Tue Mar  5 13:53:33 2002
@@ -7,6 +7,7 @@
 #define PROT_READ	0x1		/* page can be read */
 #define PROT_WRITE	0x2		/* page can be written */
 #define PROT_EXEC	0x4		/* page can be executed */
+#define PROT_SEM	0x8		/* page may be used for atomic ops */
 #define PROT_NONE	0x0		/* page can not be accessed */
 
 #define MAP_SHARED	0x01		/* Share changes */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.6-pre2/include/asm-ppc/unistd.h working-2.5.6-pre2-futex/include/asm-ppc/unistd.h
--- linux-2.5.6-pre2/include/asm-ppc/unistd.h	Wed Feb 20 17:57:18 2002
+++ working-2.5.6-pre2-futex/include/asm-ppc/unistd.h	Tue Mar  5 13:53:33 2002
@@ -228,6 +228,7 @@
 #define __NR_removexattr	218
 #define __NR_lremovexattr	219
 #define __NR_fremovexattr	220
+#define __NR_futex		221
 
 #define __NR(n)	#n
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.6-pre2/kernel/Makefile working-2.5.6-pre2-futex/kernel/Makefile
--- linux-2.5.6-pre2/kernel/Makefile	Wed Feb 20 17:56:17 2002
+++ working-2.5.6-pre2-futex/kernel/Makefile	Tue Mar  5 13:53:33 2002
@@ -15,7 +15,7 @@
 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o info.o time.o softirq.o resource.o \
 	    sysctl.o acct.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o context.o 
+	    signal.o sys.o kmod.o context.o futex.o
 
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.6-pre2/include/linux/hash.h working-2.5.6-pre2-futex/include/linux/hash.h
--- linux-2.5.6-pre2/include/linux/hash.h	Thu Jan  1 10:00:00 1970
+++ working-2.5.6-pre2-futex/include/linux/hash.h	Tue Mar  5 13:53:33 2002
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
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.6-pre2/include/linux/mmzone.h working-2.5.6-pre2-futex/include/linux/mmzone.h
--- linux-2.5.6-pre2/include/linux/mmzone.h	Fri Mar  1 22:58:34 2002
+++ working-2.5.6-pre2-futex/include/linux/mmzone.h	Tue Mar  5 14:03:15 2002
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
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.6-pre2/mm/filemap.c working-2.5.6-pre2-futex/mm/filemap.c
--- linux-2.5.6-pre2/mm/filemap.c	Fri Mar  1 23:27:15 2002
+++ working-2.5.6-pre2-futex/mm/filemap.c	Tue Mar  5 13:53:33 2002
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
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.6-pre2/mm/mprotect.c working-2.5.6-pre2-futex/mm/mprotect.c
--- linux-2.5.6-pre2/mm/mprotect.c	Wed Feb 20 17:57:21 2002
+++ working-2.5.6-pre2-futex/mm/mprotect.c	Tue Mar  5 13:53:33 2002
@@ -280,7 +280,7 @@
 	end = start + len;
 	if (end < start)
 		return -EINVAL;
-	if (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC))
+	if (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM))
 		return -EINVAL;
 	if (end == start)
 		return 0;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.6-pre2/mm/page_alloc.c working-2.5.6-pre2-futex/mm/page_alloc.c
--- linux-2.5.6-pre2/mm/page_alloc.c	Wed Feb 20 17:57:21 2002
+++ working-2.5.6-pre2-futex/mm/page_alloc.c	Tue Mar  5 13:53:33 2002
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

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.


------- =_aaaaaaaaaa0
Content-Type: application/octet-stream; name="futex-1.0.tar.bz2"
Content-ID: <32578.1015311652.2@rustcorp.com.au>
Content-Description: Futex example library
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWSLCwkwACXn/zPy4EIB/////f+////////5AAAAQAAEACGAMXzxO7FGrN0btk6dU
zuczsztUICqBREop0EokDSMkejCap+kPQkHpNlGRhojJo8oaaBoA0A0ABJIBGQIp6Gk1P0TUPU9Q
0B6TQAyaBoA9QAGR6gA4GgaAaBoaADQyGmgBpoBoAAyGIADQSakknqnqGnqBpo0BkBpoNAaGmho9
QAAAAAAOBoGgGgaGgA0MhpoAaaAaAAMhiAA0EiIQQEYjU8hMgaT1TehNTxE2mkDQyD1PIgNNBso0
09R+4v9qB+k+r1+uVz3dAHevMEFCGCXLBGUEkWaSQdzuz3Ywp09NBAwKQ3V178WvpalrqHFYEb0C
SQ/zla8Cm6bAmETUPwVNyJIKoKSMyixoF1yRmgJQoJ6My0ktAYkUipFWb9gJySi0BgjBEWERh/N0
5FxXwH/Tl67qYlISq2MUMgCCCGWKFnXAs1JIXFKQXeohkXhR1UEjahjChQoUTeSLWJDRBSGEMyan
bumQR6zSeQ1PnkQ6px6tIa/Cc23tTemO7u5b0sbpIuhempWgUUJ1ESJ1AfVHh1lxaKGDw2WghDYw
lGDSohdlI2AtXtQQK5JhZf5MSPOcybYMabGmak6Zymq5Wfo3/0VdhyFpCU0aGX3wj7SpOkqY8xs4
NtfT44VN12FePTWOcZVl4/ljLZYC0DgofY5xpDiq1vpO222T5y0zVgNSkTMKZxm9t96Odh83gdrY
2IOHGZKrJmO0amdg/1rRs356jJoIKPZyXUx5NPIZDCqO5Qup2xL7i/UajRj55OlrA5Xiq2nXRBBU
0GY/NpRSSe+Knty9HV3Og4CmJznbh5S6fX4XQM9N6m9yOqwaGlil7HnqlnwLjlON2JI3PEXPGhfJ
YYckjgnNmJvDPvipWuJkusbbmYToLa7qZzqsSDGTpxvLpue+ZgO1cOHZOC/iK4y3Re+j9gfyBCfW
/Wq+9caSWlQZM9QwmwQhM+8tgaOOEajMRTdiaLpmAHBt2q1Gl4jwQUqWamFRKIkUrQMm0jZFSsoS
9aw8tHgU2/drw29+0SjhIINKMhHvGTxHBqk7DXlaFYt1rAtgYsLGCQnQGEtx/NUs5rfeZyDkYxn0
Xk1RY6t/mrp7UM6DlUsHyV498GzuBNtDLEpH0EjRI4xZRl5tVkSiYpK7o5KB6JIwIyFaY0xE0YUq
RGqiIJO+fNhy6YOCTpPT8b/bsJUwwJzkLpnq5sjIH2UocJHIbWYYnKKFVCVUikSbBYiSPMNZwlaR
zI7SJvQI8+EYJT6dtKGj8E8oqW7lPS5wO0wBtMddEiNLQlLY0lt73EaxrFZxkatQW57CaSArnXUw
Vi6ZaSzdqh30VKkE1HZB0oBiBj0nHAU6XEY2g7qrgFcxceR2wWct3eZfnnBLR1iJcOjtl5mnc5st
Hlg7dIUbTQy6f+GJWSimStLUryajlhIhoDjM/mXV5UDiCBjG3Qu5y2rmxrTkM1FS6FWVBngwYQKy
2BUzs2iHFRjziwPNYY4F4Q32OQWMiB/4oBP1/2+v7I8P2PFBcIOl+r15JZt6m4kC1yCmjeQtiNR2
SK5cKlBPkhbR+GEoRCD5bAYhk7FgyYM7P+qAg2nErZLDi6jWRyrjUbdG5oYFJO0ROjXkMlzpOUqX
CCjvjC6l0UcNNteALrxWoBSp2dRCpBOCj0SDWAyHqLqNKZ9lMMJOucILni1R4VHaJ9a/Cipggs8Z
vviiB42SCJqog3OhRZWSt9Dr0a0MZxQdh/F72wI5i3X48C/JIBpZKSZ9qDl6JUhhXZZNsG7oyfDR
Mhi6aU4vEWtVYoQNHyiKNU1pVRYaA6+WY9W4DGXBj8BIcHkZjklFeh3ng5C/fTbz/E3A3Dgs56CX
xDqHIgrLLRlEJwImbaGQaqEiB+a6vBoRWsY9sqg7oy8EypUza13edFTkqDGNkYEzeL1vlLU6NmyB
UnsIh7/hN8mwsCA9hrKKfUyug2LEmeIYKqkrudqJfyRsCZLXaPYRFkXoaospihayFvWK3F6WK4VC
3FVlURbBHAhH00hzQ6A6lp2EeYz9gm8B2df18u/sQb+zs/ndiywnoFOMzHEI4XaEA65jNc1TIjyX
1rMSdRRHzp8RW7NKZhECwXSJewFgYYGqsRjnygqCE2Uy2xppdxBIuOptNMRiR9MnwjF2s58Z8WHB
HbPPnghM7/ifmp28iu0rzslAZiUDWj5dVux9IyBiDCDRTuaHDunNeE7UhCB3gIUjRtJcM+HIdUra
8KeqcVh33UIBZcwx50C8qKjxSlIQFT9uYaQ2Fwq3IYq7jiGgQYvvOSLhJWR4yeYcSx1Q6+XaeyZG
tVMB6UiDTHORSnCjQcIyCU0zldUxkioZhMfNXKjAJpOVURUvyFruFu2kghAJwcO06yR3MfOHBjj3
ePKssfeVpvmgzookiB3rczC+DbN4WyEzdz2gX0LVvGmxazihYgFvKsTLjC6pS5EkMnKCTqE0UhdN
4w5xIiHwMKZMJyazUtvbEcsFDJwFGQ5joa9D0YY8pEqDgiFW3FL0ZtkymNgPstCQnc80qzwQNfpN
xrF06BikQiUUgZ6Sy3xgFyQlqSNPZW1iCF8vRJYwYp6eDUukyEhfYxksQKirSSBQLtGXnUiKNGB8
439J9vz+n2ev2e793uy5PD16DQ6jGTMERMlFJP3GzV7t6XML9nhEZAu3AwqC8geIYhfeWJXQvQw7
zoMXjrWRvydYXLqv2dZ0qblsIp1nvmQXiBvrwQZkMzWW8Fi2oZ8AY4Oy2/gyjBi8NL6jMXgkJ6Rq
8WCOQeXHJz++HkaMFsBgzMvhFLIDwUx1cwHzZyi3BnXk2w6TfHo49gtMxjhHjd1IcnGS6LocQBSn
YmykPOSZZQIM8ru6ij/FMTDI70a06FCFxgWshXZiGIXnY+h6L8v7sYFnGDRjyGrKBRKbxJQPXv0k
atAhj72Tq9roLYWgCGMWc2pmY5yQfgLBuNeBl7rRVEoxwRvVSSiKo1o46HgT1IOYdLriV2nP+wsN
Q04VRqxMJrObhlgKT4gshBWbiF1KAoK9chCMiyKmV0BssYCgTBopVlSKkUqmJjQNoTTTkPPARMJg
aFMLIZuQ8SYPcoOdmUulnZlhUzGQz9ncYrpSO2wIxFO7mgjvkFeYczLLaZZzaK1En0kxxDFeEyA1
1Mig6vWZSurmRhj/7DD57xLg6ea+31HEhRvFdyigfKQaESLfx0c8EkUNOUC/hvBjO8leFbBjFu3U
x21vNor8aW6S9BRlHlJYtx3CUumg3HAK5ys2lEU+rXvDNwqavODajvTUdYMhkY3QLgBwHw7iFmsU
wEoLNzi2wUAL6REJq5gu330H+oNvPSZRGR/UOZPGGr4gNxyyjqambTqOHF1PIAr9w456sLDJujDc
bWeFaUnZGCWR7SSz53nB8A6Ri5GxtQZUELiHTKMMRjKwlCClfMlOgWAuMXDMpBE+3Z4mIxqPL0If
C9Y1A5IYa8syLA9jrMLusOhIYsg68cF7JvM9iaECVzRCJCj0zoJIg/VKEEWXJVFGgnQtD2RERGKQ
lUCALvTvCVlSWDVlmoIlZvKEZijzg0Bc4ZQLh6SeWAZCLrS3BZ+gLrCSi/dTQxgzt4HBwHYqJcVF
2IAh3+TOAWri3cu/PN19Xo9yDWkFGeDJckAb15QWXhDKdd3IN0WwqdBIcQqlmVNw9ghiwSTTLbZL
XmAYTeIXxIjIMd6WPVLQAoINbeRXJTre0N4cQ0jnAM4BqQn6jxrn8V+NyNqQ0mn4BJH/xdyRThQk
CLCwkwA=

------- =_aaaaaaaaaa0--
