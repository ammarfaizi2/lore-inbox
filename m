Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289201AbSA1OyT>; Mon, 28 Jan 2002 09:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289193AbSA1Ox6>; Mon, 28 Jan 2002 09:53:58 -0500
Received: from mx2.elte.hu ([157.181.151.9]:193 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S289201AbSA1Oxu>;
	Mon, 28 Jan 2002 09:53:50 -0500
Date: Mon, 28 Jan 2002 17:50:48 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [patch] [sched] bitmap cleanup, speedup, 2.5.3-pre5
Message-ID: <Pine.LNX.4.33.0201281744070.9796-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch cleans up the runqueue-bitmap code to be more
straightforward: bit '0' now means that a runqueue is empty. The only
reason why it was done in an inverted way is the lack of apropriate
bitops.h functions. This patch adds them:

+static __inline__ int find_first_bit(void * addr, unsigned size)
+static __inline__ int find_next_bit (void * addr, int size, int offset)
+static __inline__ unsigned long __ffs(unsigned long word)

(i've tested the new assembly functions in user-space as well, they are
working as expected.)

these functions are faster because they do not have to invert bit values
before they are fed to BSFL.

i've also optimized sched_find_first_bit() for the RT and non-RT cases. In
the RT case we used to call find_first_zero_bit(), but that is suboptimal,
the SCASL instruction has a pretty high setup cost - around 40 cycles (!).
So even for the 100-bit RT search it's much cheaper to use a series of
branches and the new __ffs() function.

context-switch performance improves by about 2% with this patch applied.

	Ingo

diff -rNu linux/include/asm-i386/bitops.h linux/include/asm-i386/bitops.h
--- linux/include/asm-i386/bitops.h	Mon Jan 28 15:21:38 2002
+++ linux/include/asm-i386/bitops.h	Mon Jan 28 15:24:44 2002
@@ -292,6 +292,34 @@
 }

 /**
+ * find_first_bit - find the first set bit in a memory region
+ * @addr: The address to start the search at
+ * @size: The maximum size to search
+ *
+ * Returns the bit-number of the first set bit, not the number of the byte
+ * containing a bit.
+ */
+static __inline__ int find_first_bit(void * addr, unsigned size)
+{
+	int d0, d1;
+	int res;
+
+	/* This looks at memory. Mark it volatile to tell gcc not to move it around */
+	__asm__ __volatile__(
+		"xorl %%eax,%%eax\n\t"
+		"repe; scasl\n\t"
+		"jz 1f\n\t"
+		"leal -4(%%edi),%%edi\n\t"
+		"bsfl (%%edi),%%eax\n"
+		"1:\tsubl %%ebx,%%edi\n\t"
+		"shll $3,%%edi\n\t"
+		"addl %%edi,%%eax"
+		:"=a" (res), "=&c" (d0), "=&D" (d1)
+		:"1" ((size + 31) >> 5), "2" (addr), "b" (addr));
+	return res;
+}
+
+/**
  * find_next_zero_bit - find the first zero bit in a memory region
  * @addr: The address to base the search on
  * @offset: The bitnumber to start searching at
@@ -304,7 +332,7 @@

 	if (bit) {
 		/*
-		 * Look for zero in first byte
+		 * Look for zero in the first 32 bits.
 		 */
 		__asm__("bsfl %1,%0\n\t"
 			"jne 1f\n\t"
@@ -325,6 +353,39 @@
 }

 /**
+ * find_next_bit - find the first set bit in a memory region
+ * @addr: The address to base the search on
+ * @offset: The bitnumber to start searching at
+ * @size: The maximum size to search
+ */
+static __inline__ int find_next_bit (void * addr, int size, int offset)
+{
+	unsigned long * p = ((unsigned long *) addr) + (offset >> 5);
+	int set = 0, bit = offset & 31, res;
+
+	if (bit) {
+		/*
+		 * Look for nonzero in the first 32 bits:
+		 */
+		__asm__("bsfl %1,%0\n\t"
+			"jne 1f\n\t"
+			"movl $32, %0\n"
+			"1:"
+			: "=r" (set)
+			: "r" (*p >> bit));
+		if (set < (32 - bit))
+			return set + offset;
+		set = 32 - bit;
+		p++;
+	}
+	/*
+	 * No set bit yet, search remaining full words for a bit
+	 */
+	res = find_first_bit (p, size - 32 * (p - (unsigned long *) addr));
+	return (offset + set + res);
+}
+
+/**
  * ffz - find first zero in word.
  * @word: The word to search
  *
@@ -335,6 +396,20 @@
 	__asm__("bsfl %1,%0"
 		:"=r" (word)
 		:"r" (~word));
+	return word;
+}
+
+/**
+ * __ffs - find first bit in word.
+ * @word: The word to search
+ *
+ * Undefined if no bit exists, so code should check against 0 first.
+ */
+static __inline__ unsigned long __ffs(unsigned long word)
+{
+	__asm__("bsfl %1,%0"
+		:"=r" (word)
+		:"r" (word));
 	return word;
 }

diff -rNu linux/include/asm-i386/mmu_context.h linux/include/asm-i386/mmu_context.h
--- linux/include/asm-i386/mmu_context.h	Mon Jan 28 15:21:41 2002
+++ linux/include/asm-i386/mmu_context.h	Mon Jan 28 15:24:44 2002
@@ -16,17 +16,19 @@
 # error update this function.
 #endif

-static inline int sched_find_first_zero_bit(unsigned long *b)
+static inline int sched_find_first_bit(unsigned long *b)
 {
-	unsigned int rt;
-
-	rt = b[0] & b[1] & b[2] & b[3];
-	if (unlikely(rt != 0xffffffff))
-		return find_first_zero_bit(b, MAX_RT_PRIO);
-
-	if (b[4] != ~0)
-		return ffz(b[4]) + MAX_RT_PRIO;
-	return ffz(b[5]) + 32 + MAX_RT_PRIO;
+	if (unlikely(b[0]))
+		return __ffs(b[0]);
+	if (unlikely(b[1]))
+		return __ffs(b[1]) + 32;
+	if (unlikely(b[2]))
+		return __ffs(b[2]) + 64;
+	if (unlikely(b[3]))
+		return __ffs(b[3]) + 96;
+	if (b[4])
+		return __ffs(b[4]) + 128;
+	return __ffs(b[5]) + 32 + 128;
 }
 /*
  * possibly do the LDT unload here?
diff -rNu linux/kernel/sched.c linux/kernel/sched.c
--- linux/kernel/sched.c	Mon Jan 28 15:23:50 2002
+++ linux/kernel/sched.c	Mon Jan 28 15:24:44 2002
@@ -82,13 +82,13 @@
 	array->nr_active--;
 	list_del_init(&p->run_list);
 	if (list_empty(array->queue + p->prio))
-		__set_bit(p->prio, array->bitmap);
+		__clear_bit(p->prio, array->bitmap);
 }

 static inline void enqueue_task(struct task_struct *p, prio_array_t *array)
 {
 	list_add_tail(&p->run_list, array->queue + p->prio);
-	__clear_bit(p->prio, array->bitmap);
+	__set_bit(p->prio, array->bitmap);
 	array->nr_active++;
 	p->array = array;
 }
@@ -476,7 +479,7 @@
 	 */
 	idx = MAX_RT_PRIO;
 skip_bitmap:
-	idx = find_next_zero_bit(array->bitmap, MAX_PRIO, idx);
+	idx = find_next_bit(array->bitmap, MAX_PRIO, idx);
 	if (idx == MAX_PRIO) {
 		if (array == busiest->expired) {
 			array = busiest->active;
@@ -650,11 +678,12 @@
 		rq->expired_timestamp = 0;
 	}

-	idx = sched_find_first_zero_bit(array->bitmap);
+	idx = sched_find_first_bit(array->bitmap);
 	queue = array->queue + idx;
 	next = list_entry(queue->next, task_t, run_list);

 switch_tasks:
+	prefetch(next);
 	prev->need_resched = 0;

 	if (likely(prev != next)) {
@@ -837,7 +866,7 @@
 		return;
 #if CONFIG_SMP
 	current->state = TASK_UNINTERRUPTIBLE;
-	smp_migrate_task(ffz(~new_mask), current);
+	smp_migrate_task(__ffs(new_mask), current);

 	schedule();
 #endif
@@ -1156,7 +1194,7 @@
 	static const char * stat_nam[] = { "R", "S", "D", "Z", "T", "W" };

 	printk("%-13.13s ", p->comm);
-	state = p->state ? ffz(~p->state) + 1 : 0;
+	state = p->state ? __ffs(p->state) + 1 : 0;
 	if (((unsigned) state) < sizeof(stat_nam)/sizeof(char *))
 		printk(stat_nam[state]);
 	else
@@ -1307,10 +1347,10 @@
 			array->lock = &rq->lock;
 			for (k = 0; k < MAX_PRIO; k++) {
 				INIT_LIST_HEAD(array->queue + k);
-				__set_bit(k, array->bitmap);
+				__clear_bit(k, array->bitmap);
 			}
-			// zero delimiter for bitsearch
-			__clear_bit(MAX_PRIO, array->bitmap);
+			// delimiter for bitsearch
+			__set_bit(MAX_PRIO, array->bitmap);
 		}
 	}
 	/*

