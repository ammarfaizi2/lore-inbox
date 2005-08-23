Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbVHWNSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbVHWNSn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 09:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbVHWNSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 09:18:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52622 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750789AbVHWNSm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 09:18:42 -0400
Date: Tue, 23 Aug 2005 09:18:17 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Ulrich Drepper <drepper@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] FUTEX_WAKE_OP (pthread_cond_signal speedup)
Message-ID: <20050823131817.GA7403@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

ATM pthread_cond_signal is unnecessarily slow, because it wakes one
waiter (which at least on UP usually means an immediate context switch
to one of the waiter threads).  This waiter wakes up and after a few
instructions it attempts to acquire the cv internal lock, but that lock
is still held by the thread calling pthread_cond_signal.  So it goes
to sleep and eventually the signalling thread is scheduled in, unlocks
the internal lock and wakes the waiter again.

Now, before 2003-09-21 NPTL was using FUTEX_REQUEUE in pthread_cond_signal
to avoid this performance issue, but it was removed when locks were
redesigned to the 3 state scheme (unlocked, locked uncontended, locked
contended).

Following scenario shows why simply using FUTEX_REQUEUE in
pthread_cond_signal together with using lll_mutex_unlock_force
in place of lll_mutex_unlock is not enough and probably why it
has been disabled at that time:

The number is value in cv->__data.__lock.
        thr1            thr2            thr3
0       pthread_cond_wait
1       lll_mutex_lock (cv->__data.__lock)
0       lll_mutex_unlock (cv->__data.__lock)
0       lll_futex_wait (&cv->__data.__futex, futexval)
0                       pthread_cond_signal
1                       lll_mutex_lock (cv->__data.__lock)
1                                       pthread_cond_signal
2                                       lll_mutex_lock (cv->__data.__lock)
2                                         lll_futex_wait (&cv->__data.__lock, 2)
2                       lll_futex_requeue (&cv->__data.__futex, 0, 1, &cv->__data.__lock)
                          # FUTEX_REQUEUE, not FUTEX_CMP_REQUEUE
2                       lll_mutex_unlock_force (cv->__data.__lock)
0                         cv->__data.__lock = 0
0                         lll_futex_wake (&cv->__data.__lock, 1)
1       lll_mutex_lock (cv->__data.__lock)
0       lll_mutex_unlock (cv->__data.__lock)
          # Here, lll_mutex_unlock doesn't know there are threads waiting
          # on the internal cv's lock

Now, I believe it is possible to use FUTEX_REQUEUE in pthread_cond_signal,
but it will cost us not one, but 2 extra syscalls and, what's worse, one
of these extra syscalls will be done for every single waiting loop in
pthread_cond_*wait.
We would need to use lll_mutex_unlock_force in pthread_cond_signal
after requeue and lll_mutex_cond_lock in pthread_cond_*wait after
lll_futex_wait.

Another alternative is to do the unlocking pthread_cond_signal needs
to do (the lock can't be unlocked before lll_futex_wake, as that is racy)
in the kernel.

I have implemented both variants, futex-requeue-glibc.patch is the
first one and futex-wake_op{,-glibc}.patch is the unlocking
inside of the kernel.  The kernel interface allows userland to specify
how exactly an unlocking operation should look like (some atomic
arithmetic operation with optional constant argument and comparison
of the previous futex value with another constant).

It has been implemented just for ppc*, x86_64 and i?86, for other
architectures I'm including just a stub header which can be used as
a starting point by maintainers to write support for their arches
and ATM will just return -ENOSYS for FUTEX_WAKE_OP.  The requeue
patch has been (lightly) tested just on x86_64, the wake_op patch
on ppc64 kernel running 32-bit and 64-bit NPTL and x86_64 kernel running
32-bit and 64-bit NPTL.

With the following benchmark on UP x86-64 I get:

for i in nptl-orig nptl-requeue nptl-wake_op; do echo time elf/ld.so --library-path .:$i /tmp/bench; \
for j in 1 2; do echo ( time elf/ld.so --library-path .:$i /tmp/bench ) 2>&1; done; done
time elf/ld.so --library-path .:nptl-orig /tmp/bench
real 0m0.655s user 0m0.253s sys 0m0.403s
real 0m0.657s user 0m0.269s sys 0m0.388s
time elf/ld.so --library-path .:nptl-requeue /tmp/bench
real 0m0.496s user 0m0.225s sys 0m0.271s
real 0m0.531s user 0m0.242s sys 0m0.288s
time elf/ld.so --library-path .:nptl-wake_op /tmp/bench
real 0m0.380s user 0m0.176s sys 0m0.204s
real 0m0.382s user 0m0.175s sys 0m0.207s

The benchmark is at:
http://sourceware.org/ml/libc-alpha/2005-03/txt00001.txt
Older futex-requeue-glibc.patch version is at:
http://sourceware.org/ml/libc-alpha/2005-03/txt00002.txt
Older futex-wake_op-glibc.patch version is at:
http://sourceware.org/ml/libc-alpha/2005-03/txt00003.txt
Will post a new version (just x86-64 fixes so that the patch
applies against pthread_cond_signal.S) to libc-hacker ml soon.

Attached is the kernel FUTEX_WAKE_OP patch as well as a simple-minded
testcase that will not test the atomicity of the operation, but at least
check if the threads that should have been woken up are woken up and
whether the arithmetic operation in the kernel gave the expected results.

	Jakub

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="futex-wake_op.patch"

--- linux-2.6.12/include/linux/futex.h.jj	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12/include/linux/futex.h	2005-08-23 11:11:41.000000000 +0200
@@ -4,14 +4,40 @@
 /* Second argument to futex syscall */
 
 
-#define FUTEX_WAIT (0)
-#define FUTEX_WAKE (1)
-#define FUTEX_FD (2)
-#define FUTEX_REQUEUE (3)
-#define FUTEX_CMP_REQUEUE (4)
+#define FUTEX_WAIT		0
+#define FUTEX_WAKE		1
+#define FUTEX_FD		2
+#define FUTEX_REQUEUE		3
+#define FUTEX_CMP_REQUEUE	4
+#define FUTEX_WAKE_OP		5
 
 long do_futex(unsigned long uaddr, int op, int val,
 		unsigned long timeout, unsigned long uaddr2, int val2,
 		int val3);
 
+#define FUTEX_OP_SET		0	/* *(int *)UADDR2 = OPARG; */
+#define FUTEX_OP_ADD		1	/* *(int *)UADDR2 += OPARG; */
+#define FUTEX_OP_OR		2	/* *(int *)UADDR2 |= OPARG; */
+#define FUTEX_OP_ANDN		3	/* *(int *)UADDR2 &= ~OPARG; */
+#define FUTEX_OP_XOR		4	/* *(int *)UADDR2 ^= OPARG; */
+
+#define FUTEX_OP_OPARG_SHIFT	8	/* Use (1 << OPARG) instead of OPARG.  */
+
+#define FUTEX_OP_CMP_EQ		0	/* if (oldval == CMPARG) wake */
+#define FUTEX_OP_CMP_NE		1	/* if (oldval != CMPARG) wake */
+#define FUTEX_OP_CMP_LT		2	/* if (oldval < CMPARG) wake */
+#define FUTEX_OP_CMP_LE		3	/* if (oldval <= CMPARG) wake */
+#define FUTEX_OP_CMP_GT		4	/* if (oldval > CMPARG) wake */
+#define FUTEX_OP_CMP_GE		5	/* if (oldval >= CMPARG) wake */
+
+/* FUTEX_WAKE_OP will perform atomically
+   int oldval = *(int *)UADDR2;
+   *(int *)UADDR2 = oldval OP OPARG;
+   if (oldval CMP CMPARG)
+     wake UADDR2;  */
+
+#define FUTEX_OP(op, oparg, cmp, cmparg) \
+  (((op & 0xf) << 28) | ((cmp & 0xf) << 24)		\
+   | ((oparg & 0xfff) << 12) | (cmparg & 0xfff))
+
 #endif
--- linux-2.6.12/kernel/futex.c.jj	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12/kernel/futex.c	2005-08-23 11:11:59.000000000 +0200
@@ -40,6 +40,7 @@
 #include <linux/pagemap.h>
 #include <linux/syscalls.h>
 #include <linux/signal.h>
+#include <asm/futex.h>
 
 #define FUTEX_HASHBITS (CONFIG_BASE_SMALL ? 4 : 8)
 
@@ -327,6 +328,118 @@ out:
 }
 
 /*
+ * Wake up all waiters hashed on the physical page that is mapped
+ * to this virtual address:
+ */
+static int futex_wake_op(unsigned long uaddr1, unsigned long uaddr2, int nr_wake, int nr_wake2, int op)
+{
+	union futex_key key1, key2;
+	struct futex_hash_bucket *bh1, *bh2;
+	struct list_head *head;
+	struct futex_q *this, *next;
+	int ret, op_ret, attempt = 0;
+
+retryfull:
+	down_read(&current->mm->mmap_sem);
+
+	ret = get_futex_key(uaddr1, &key1);
+	if (unlikely(ret != 0))
+		goto out;
+	ret = get_futex_key(uaddr2, &key2);
+	if (unlikely(ret != 0))
+		goto out;
+
+	bh1 = hash_futex(&key1);
+	bh2 = hash_futex(&key2);
+
+retry:
+	if (bh1 < bh2)
+		spin_lock(&bh1->lock);
+	spin_lock(&bh2->lock);
+	if (bh1 > bh2)
+		spin_lock(&bh1->lock);
+
+	op_ret = futex_atomic_op_inuser(op, (int __user *)uaddr2);
+	if (unlikely(op_ret < 0)) {
+		int dummy;
+
+		spin_unlock(&bh1->lock);
+		if (bh1 != bh2)
+			spin_unlock(&bh2->lock);
+
+		/* futex_atomic_op_inuser needs to both read and write
+		 * *(int __user *)uaddr2, but we can't modify it
+		 * non-atomically.  Therefore, if get_user below is not
+		 * enough, we need to handle the fault ourselves, while
+		 * still holding the mmap_sem.  */
+		if (attempt++) {
+			struct vm_area_struct * vma;
+			struct mm_struct *mm = current->mm;
+
+			ret = -EFAULT;
+			if (attempt >= 2 ||
+			    !(vma = find_vma(mm, uaddr2)) ||
+			    vma->vm_start > uaddr2 ||
+			    !(vma->vm_flags & VM_WRITE))
+				goto out;
+
+			switch (handle_mm_fault(mm, vma, uaddr2, 1)) {
+			case VM_FAULT_MINOR:
+				current->min_flt++;
+				break;
+			case VM_FAULT_MAJOR:
+				current->maj_flt++;
+				break;
+			default:
+				goto out;
+			}
+			goto retry;
+		}
+
+		/* If we would have faulted, release mmap_sem,
+		 * fault it in and start all over again.  */
+		up_read(&current->mm->mmap_sem);
+
+		ret = get_user(dummy, (int __user *)uaddr2);
+		if (ret)
+			return ret;
+
+		goto retryfull;
+	}
+
+	head = &bh1->chain;
+
+	list_for_each_entry_safe(this, next, head, list) {
+		if (match_futex (&this->key, &key1)) {
+			wake_futex(this);
+			if (++ret >= nr_wake)
+				break;
+		}
+	}
+
+	if (op_ret > 0) {
+		head = &bh2->chain;
+
+		op_ret = 0;
+		list_for_each_entry_safe(this, next, head, list) {
+			if (match_futex (&this->key, &key2)) {
+				wake_futex(this);
+				if (++op_ret >= nr_wake2)
+					break;
+			}
+		}
+		ret += op_ret;
+	}
+
+	spin_unlock(&bh1->lock);
+	if (bh1 != bh2)
+		spin_unlock(&bh2->lock);
+out:
+	up_read(&current->mm->mmap_sem);
+	return ret;
+}
+
+/*
  * Requeue all waiters hashed on one physical page to another
  * physical page.
  */
@@ -740,6 +853,9 @@ long do_futex(unsigned long uaddr, int o
 	case FUTEX_CMP_REQUEUE:
 		ret = futex_requeue(uaddr, uaddr2, val, val2, &val3);
 		break;
+	case FUTEX_WAKE_OP:
+		ret = futex_wake_op(uaddr, uaddr2, val, val2, val3);
+		break;
 	default:
 		ret = -ENOSYS;
 	}
--- linux-2.6.12/include/asm-ppc64/futex.h.jj	2005-08-23 11:11:41.000000000 +0200
+++ linux-2.6.12/include/asm-ppc64/futex.h	2005-08-23 11:11:41.000000000 +0200
@@ -0,0 +1,83 @@
+#ifndef _ASM_FUTEX_H
+#define _ASM_FUTEX_H
+
+#ifdef __KERNEL__
+
+#include <linux/futex.h>
+#include <asm/errno.h>
+#include <asm/memory.h>
+#include <asm/uaccess.h>
+
+#define __futex_atomic_op(insn, ret, oldval, uaddr, oparg) \
+  __asm__ __volatile (SYNC_ON_SMP				\
+"1:	lwarx	%0,0,%2\n"					\
+	insn							\
+"2:	stwcx.	%1,0,%2\n\
+	bne-	1b\n\
+	li	%1,0\n\
+3:	.section .fixup,\"ax\"\n\
+4:	li	%1,%3\n\
+	b	3b\n\
+	.previous\n\
+	.section __ex_table,\"a\"\n\
+	.align 3\n\
+	.llong	1b,4b,2b,4b\n\
+	.previous"						\
+	: "=&r" (oldval), "=&r" (ret)				\
+	: "b" (uaddr), "i" (-EFAULT), "1" (oparg)		\
+	: "cr0", "memory")
+
+static inline int
+futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
+{
+	int op = (encoded_op >> 28) & 7;
+	int cmp = (encoded_op >> 24) & 15;
+	int oparg = (encoded_op << 8) >> 20;
+	int cmparg = (encoded_op << 20) >> 20;
+	int oldval = 0, ret;
+	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
+		oparg = 1 << oparg;
+
+	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
+		return -EFAULT;
+
+	inc_preempt_count();
+
+	switch (op) {
+	case FUTEX_OP_SET:
+		__futex_atomic_op("", ret, oldval, uaddr, oparg);
+		break;
+	case FUTEX_OP_ADD:
+		__futex_atomic_op("add %1,%0,%1\n", ret, oldval, uaddr, oparg);
+		break;
+	case FUTEX_OP_OR:
+		__futex_atomic_op("or %1,%0,%1\n", ret, oldval, uaddr, oparg);
+		break;
+	case FUTEX_OP_ANDN:
+		__futex_atomic_op("andc %1,%0,%1\n", ret, oldval, uaddr, oparg);
+		break;
+	case FUTEX_OP_XOR:
+		__futex_atomic_op("xor %1,%0,%1\n", ret, oldval, uaddr, oparg);
+		break;
+	default:
+		ret = -ENOSYS;
+	}
+  
+	dec_preempt_count();
+
+	if (!ret) {
+		switch (cmp) {
+		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
+		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
+		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
+		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
+		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
+		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
+		default: ret = -ENOSYS;
+		}
+	}
+	return ret;
+}
+
+#endif
+#endif
--- linux-2.6.12/include/asm-ppc64/memory.h.jj	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12/include/asm-ppc64/memory.h	2005-08-23 11:11:41.000000000 +0200
@@ -18,9 +18,11 @@
 #ifdef CONFIG_SMP
 #define EIEIO_ON_SMP	"eieio\n"
 #define ISYNC_ON_SMP	"\n\tisync"
+#define SYNC_ON_SMP	"lwsync\n\t"
 #else
 #define EIEIO_ON_SMP
 #define ISYNC_ON_SMP
+#define SYNC_ON_SMP
 #endif
 
 static inline void eieio(void)
--- linux-2.6.12/include/asm-x86_64/futex.h.jj	2005-08-23 11:11:41.000000000 +0200
+++ linux-2.6.12/include/asm-x86_64/futex.h	2005-08-23 11:11:41.000000000 +0200
@@ -0,0 +1,98 @@
+#ifndef _ASM_FUTEX_H
+#define _ASM_FUTEX_H
+
+#ifdef __KERNEL__
+
+#include <linux/futex.h>
+#include <asm/errno.h>
+#include <asm/system.h>
+#include <asm/uaccess.h>
+
+#define __futex_atomic_op1(insn, ret, oldval, uaddr, oparg) \
+  __asm__ __volatile (						\
+"1:	" insn "\n"						\
+"2:	.section .fixup,\"ax\"\n\
+3:	mov	%3, %1\n\
+	jmp	2b\n\
+	.previous\n\
+	.section __ex_table,\"a\"\n\
+	.align	8\n\
+	.quad	1b,3b\n\
+	.previous"						\
+	: "=r" (oldval), "=r" (ret), "=m" (*uaddr)		\
+	: "i" (-EFAULT), "m" (*uaddr), "0" (oparg), "1" (0))
+
+#define __futex_atomic_op2(insn, ret, oldval, uaddr, oparg) \
+  __asm__ __volatile (						\
+"1:	movl	%2, %0\n\
+	movl	%0, %3\n"					\
+	insn "\n"						\
+"2:	" LOCK_PREFIX "cmpxchgl %3, %2\n\
+	jnz	1b\n\
+3:	.section .fixup,\"ax\"\n\
+4:	mov	%5, %1\n\
+	jmp	3b\n\
+	.previous\n\
+	.section __ex_table,\"a\"\n\
+	.align	8\n\
+	.quad	1b,4b,2b,4b\n\
+	.previous"						\
+	: "=&a" (oldval), "=&r" (ret), "=m" (*uaddr),		\
+	  "=&r" (tem)						\
+	: "r" (oparg), "i" (-EFAULT), "m" (*uaddr), "1" (0))
+
+static inline int
+futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
+{
+	int op = (encoded_op >> 28) & 7;
+	int cmp = (encoded_op >> 24) & 15;
+	int oparg = (encoded_op << 8) >> 20;
+	int cmparg = (encoded_op << 20) >> 20;
+	int oldval = 0, ret, tem;
+	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
+		oparg = 1 << oparg;
+
+	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
+		return -EFAULT;
+
+	inc_preempt_count();
+
+	switch (op) {
+	case FUTEX_OP_SET:
+		__futex_atomic_op1("xchgl %0, %2", ret, oldval, uaddr, oparg);
+		break;
+	case FUTEX_OP_ADD:
+		__futex_atomic_op1(LOCK_PREFIX "xaddl %0, %2", ret, oldval,
+				   uaddr, oparg);
+		break;
+	case FUTEX_OP_OR:
+		__futex_atomic_op2("orl %4, %3", ret, oldval, uaddr, oparg);
+		break;
+	case FUTEX_OP_ANDN:
+		__futex_atomic_op2("andl %4, %3", ret, oldval, uaddr, ~oparg);
+		break;
+	case FUTEX_OP_XOR:
+		__futex_atomic_op2("xorl %4, %3", ret, oldval, uaddr, oparg);
+		break;
+	default:
+		ret = -ENOSYS;
+	}
+  
+	dec_preempt_count();
+
+	if (!ret) {
+		switch (cmp) {
+		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
+		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
+		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
+		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
+		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
+		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
+		default: ret = -ENOSYS;
+		}
+	}
+	return ret;
+}
+
+#endif
+#endif
--- linux-2.6.12/include/asm-i386/futex.h.jj	2005-08-23 11:11:41.000000000 +0200
+++ linux-2.6.12/include/asm-i386/futex.h	2005-08-23 11:11:41.000000000 +0200
@@ -0,0 +1,108 @@
+#ifndef _ASM_FUTEX_H
+#define _ASM_FUTEX_H
+
+#ifdef __KERNEL__
+
+#include <linux/futex.h>
+#include <asm/errno.h>
+#include <asm/system.h>
+#include <asm/processor.h>
+#include <asm/uaccess.h>
+
+#define __futex_atomic_op1(insn, ret, oldval, uaddr, oparg) \
+  __asm__ __volatile (						\
+"1:	" insn "\n"						\
+"2:	.section .fixup,\"ax\"\n\
+3:	mov	%3, %1\n\
+	jmp	2b\n\
+	.previous\n\
+	.section __ex_table,\"a\"\n\
+	.align	8\n\
+	.long	1b,3b\n\
+	.previous"						\
+	: "=r" (oldval), "=r" (ret), "=m" (*uaddr)		\
+	: "i" (-EFAULT), "m" (*uaddr), "0" (oparg), "1" (0))
+
+#define __futex_atomic_op2(insn, ret, oldval, uaddr, oparg) \
+  __asm__ __volatile (						\
+"1:	movl	%2, %0\n\
+	movl	%0, %3\n"					\
+	insn "\n"						\
+"2:	" LOCK_PREFIX "cmpxchgl %3, %2\n\
+	jnz	1b\n\
+3:	.section .fixup,\"ax\"\n\
+4:	mov	%5, %1\n\
+	jmp	3b\n\
+	.previous\n\
+	.section __ex_table,\"a\"\n\
+	.align	8\n\
+	.long	1b,4b,2b,4b\n\
+	.previous"						\
+	: "=&a" (oldval), "=&r" (ret), "=m" (*uaddr),		\
+	  "=&r" (tem)						\
+	: "r" (oparg), "i" (-EFAULT), "m" (*uaddr), "1" (0))
+
+static inline int
+futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
+{
+	int op = (encoded_op >> 28) & 7;
+	int cmp = (encoded_op >> 24) & 15;
+	int oparg = (encoded_op << 8) >> 20;
+	int cmparg = (encoded_op << 20) >> 20;
+	int oldval = 0, ret, tem;
+	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
+		oparg = 1 << oparg;
+
+	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
+		return -EFAULT;
+
+	inc_preempt_count();
+
+	if (op == FUTEX_OP_SET)
+		__futex_atomic_op1("xchgl %0, %2", ret, oldval, uaddr, oparg);
+	else {
+#ifndef CONFIG_X86_BSWAP
+		if (boot_cpu_data.x86 == 3)
+			ret = -ENOSYS;
+		else
+#endif
+		switch (op) {
+		case FUTEX_OP_ADD:
+			__futex_atomic_op1(LOCK_PREFIX "xaddl %0, %2", ret,
+					   oldval, uaddr, oparg);
+			break;
+		case FUTEX_OP_OR:
+			__futex_atomic_op2("orl %4, %3", ret, oldval, uaddr,
+					   oparg);
+			break;
+		case FUTEX_OP_ANDN:
+			__futex_atomic_op2("andl %4, %3", ret, oldval, uaddr,
+					   ~oparg);
+			break;
+		case FUTEX_OP_XOR:
+			__futex_atomic_op2("xorl %4, %3", ret, oldval, uaddr,
+					   oparg);
+			break;
+		default:
+			ret = -ENOSYS;
+		}
+	}
+  
+	dec_preempt_count();
+
+	if (!ret) {
+		switch (cmp) {
+		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
+		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
+		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
+		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
+		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
+		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
+		default: ret = -ENOSYS;
+		}
+	}
+	return ret;
+}
+
+#endif
+#endif
--- linux-2.6.12/include/asm-alpha/futex.h.jj	2005-08-23 11:13:38.000000000 +0200
+++ linux-2.6.12/include/asm-alpha/futex.h	2005-08-23 11:17:25.000000000 +0200
@@ -0,0 +1,53 @@
+#ifndef _ASM_FUTEX_H
+#define _ASM_FUTEX_H
+
+#ifdef __KERNEL__
+
+#include <linux/futex.h>
+#include <asm/errno.h>
+#include <asm/uaccess.h>
+
+static inline int
+futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
+{
+	int op = (encoded_op >> 28) & 7;
+	int cmp = (encoded_op >> 24) & 15;
+	int oparg = (encoded_op << 8) >> 20;
+	int cmparg = (encoded_op << 20) >> 20;
+	int oldval = 0, ret, tem;
+	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
+		oparg = 1 << oparg;
+
+	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
+		return -EFAULT;
+
+	inc_preempt_count();
+
+	switch (op) {
+	case FUTEX_OP_SET:
+	case FUTEX_OP_ADD:
+	case FUTEX_OP_OR:
+	case FUTEX_OP_ANDN:
+	case FUTEX_OP_XOR:
+	default:
+		ret = -ENOSYS;
+	}
+  
+	dec_preempt_count();
+
+	if (!ret) {
+		switch (cmp) {
+		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
+		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
+		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
+		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
+		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
+		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
+		default: ret = -ENOSYS;
+		}
+	}
+	return ret;
+}
+
+#endif
+#endif
--- linux-2.6.12/include/asm-arm/futex.h.jj	2005-08-23 11:13:38.000000000 +0200
+++ linux-2.6.12/include/asm-arm/futex.h	2005-08-23 11:17:25.000000000 +0200
@@ -0,0 +1,53 @@
+#ifndef _ASM_FUTEX_H
+#define _ASM_FUTEX_H
+
+#ifdef __KERNEL__
+
+#include <linux/futex.h>
+#include <asm/errno.h>
+#include <asm/uaccess.h>
+
+static inline int
+futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
+{
+	int op = (encoded_op >> 28) & 7;
+	int cmp = (encoded_op >> 24) & 15;
+	int oparg = (encoded_op << 8) >> 20;
+	int cmparg = (encoded_op << 20) >> 20;
+	int oldval = 0, ret, tem;
+	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
+		oparg = 1 << oparg;
+
+	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
+		return -EFAULT;
+
+	inc_preempt_count();
+
+	switch (op) {
+	case FUTEX_OP_SET:
+	case FUTEX_OP_ADD:
+	case FUTEX_OP_OR:
+	case FUTEX_OP_ANDN:
+	case FUTEX_OP_XOR:
+	default:
+		ret = -ENOSYS;
+	}
+  
+	dec_preempt_count();
+
+	if (!ret) {
+		switch (cmp) {
+		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
+		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
+		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
+		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
+		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
+		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
+		default: ret = -ENOSYS;
+		}
+	}
+	return ret;
+}
+
+#endif
+#endif
--- linux-2.6.12/include/asm-arm26/futex.h.jj	2005-08-23 11:13:38.000000000 +0200
+++ linux-2.6.12/include/asm-arm26/futex.h	2005-08-23 11:17:25.000000000 +0200
@@ -0,0 +1,53 @@
+#ifndef _ASM_FUTEX_H
+#define _ASM_FUTEX_H
+
+#ifdef __KERNEL__
+
+#include <linux/futex.h>
+#include <asm/errno.h>
+#include <asm/uaccess.h>
+
+static inline int
+futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
+{
+	int op = (encoded_op >> 28) & 7;
+	int cmp = (encoded_op >> 24) & 15;
+	int oparg = (encoded_op << 8) >> 20;
+	int cmparg = (encoded_op << 20) >> 20;
+	int oldval = 0, ret, tem;
+	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
+		oparg = 1 << oparg;
+
+	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
+		return -EFAULT;
+
+	inc_preempt_count();
+
+	switch (op) {
+	case FUTEX_OP_SET:
+	case FUTEX_OP_ADD:
+	case FUTEX_OP_OR:
+	case FUTEX_OP_ANDN:
+	case FUTEX_OP_XOR:
+	default:
+		ret = -ENOSYS;
+	}
+  
+	dec_preempt_count();
+
+	if (!ret) {
+		switch (cmp) {
+		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
+		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
+		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
+		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
+		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
+		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
+		default: ret = -ENOSYS;
+		}
+	}
+	return ret;
+}
+
+#endif
+#endif
--- linux-2.6.12/include/asm-cris/futex.h.jj	2005-08-23 11:13:38.000000000 +0200
+++ linux-2.6.12/include/asm-cris/futex.h	2005-08-23 11:17:25.000000000 +0200
@@ -0,0 +1,53 @@
+#ifndef _ASM_FUTEX_H
+#define _ASM_FUTEX_H
+
+#ifdef __KERNEL__
+
+#include <linux/futex.h>
+#include <asm/errno.h>
+#include <asm/uaccess.h>
+
+static inline int
+futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
+{
+	int op = (encoded_op >> 28) & 7;
+	int cmp = (encoded_op >> 24) & 15;
+	int oparg = (encoded_op << 8) >> 20;
+	int cmparg = (encoded_op << 20) >> 20;
+	int oldval = 0, ret, tem;
+	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
+		oparg = 1 << oparg;
+
+	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
+		return -EFAULT;
+
+	inc_preempt_count();
+
+	switch (op) {
+	case FUTEX_OP_SET:
+	case FUTEX_OP_ADD:
+	case FUTEX_OP_OR:
+	case FUTEX_OP_ANDN:
+	case FUTEX_OP_XOR:
+	default:
+		ret = -ENOSYS;
+	}
+  
+	dec_preempt_count();
+
+	if (!ret) {
+		switch (cmp) {
+		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
+		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
+		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
+		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
+		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
+		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
+		default: ret = -ENOSYS;
+		}
+	}
+	return ret;
+}
+
+#endif
+#endif
--- linux-2.6.12/include/asm-frv/futex.h.jj	2005-08-23 11:13:38.000000000 +0200
+++ linux-2.6.12/include/asm-frv/futex.h	2005-08-23 11:17:25.000000000 +0200
@@ -0,0 +1,53 @@
+#ifndef _ASM_FUTEX_H
+#define _ASM_FUTEX_H
+
+#ifdef __KERNEL__
+
+#include <linux/futex.h>
+#include <asm/errno.h>
+#include <asm/uaccess.h>
+
+static inline int
+futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
+{
+	int op = (encoded_op >> 28) & 7;
+	int cmp = (encoded_op >> 24) & 15;
+	int oparg = (encoded_op << 8) >> 20;
+	int cmparg = (encoded_op << 20) >> 20;
+	int oldval = 0, ret, tem;
+	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
+		oparg = 1 << oparg;
+
+	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
+		return -EFAULT;
+
+	inc_preempt_count();
+
+	switch (op) {
+	case FUTEX_OP_SET:
+	case FUTEX_OP_ADD:
+	case FUTEX_OP_OR:
+	case FUTEX_OP_ANDN:
+	case FUTEX_OP_XOR:
+	default:
+		ret = -ENOSYS;
+	}
+  
+	dec_preempt_count();
+
+	if (!ret) {
+		switch (cmp) {
+		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
+		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
+		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
+		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
+		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
+		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
+		default: ret = -ENOSYS;
+		}
+	}
+	return ret;
+}
+
+#endif
+#endif
--- linux-2.6.12/include/asm-h8300/futex.h.jj	2005-08-23 11:13:38.000000000 +0200
+++ linux-2.6.12/include/asm-h8300/futex.h	2005-08-23 11:17:25.000000000 +0200
@@ -0,0 +1,53 @@
+#ifndef _ASM_FUTEX_H
+#define _ASM_FUTEX_H
+
+#ifdef __KERNEL__
+
+#include <linux/futex.h>
+#include <asm/errno.h>
+#include <asm/uaccess.h>
+
+static inline int
+futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
+{
+	int op = (encoded_op >> 28) & 7;
+	int cmp = (encoded_op >> 24) & 15;
+	int oparg = (encoded_op << 8) >> 20;
+	int cmparg = (encoded_op << 20) >> 20;
+	int oldval = 0, ret, tem;
+	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
+		oparg = 1 << oparg;
+
+	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
+		return -EFAULT;
+
+	inc_preempt_count();
+
+	switch (op) {
+	case FUTEX_OP_SET:
+	case FUTEX_OP_ADD:
+	case FUTEX_OP_OR:
+	case FUTEX_OP_ANDN:
+	case FUTEX_OP_XOR:
+	default:
+		ret = -ENOSYS;
+	}
+  
+	dec_preempt_count();
+
+	if (!ret) {
+		switch (cmp) {
+		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
+		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
+		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
+		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
+		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
+		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
+		default: ret = -ENOSYS;
+		}
+	}
+	return ret;
+}
+
+#endif
+#endif
--- linux-2.6.12/include/asm-ia64/futex.h.jj	2005-08-23 11:13:38.000000000 +0200
+++ linux-2.6.12/include/asm-ia64/futex.h	2005-08-23 11:17:25.000000000 +0200
@@ -0,0 +1,53 @@
+#ifndef _ASM_FUTEX_H
+#define _ASM_FUTEX_H
+
+#ifdef __KERNEL__
+
+#include <linux/futex.h>
+#include <asm/errno.h>
+#include <asm/uaccess.h>
+
+static inline int
+futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
+{
+	int op = (encoded_op >> 28) & 7;
+	int cmp = (encoded_op >> 24) & 15;
+	int oparg = (encoded_op << 8) >> 20;
+	int cmparg = (encoded_op << 20) >> 20;
+	int oldval = 0, ret, tem;
+	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
+		oparg = 1 << oparg;
+
+	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
+		return -EFAULT;
+
+	inc_preempt_count();
+
+	switch (op) {
+	case FUTEX_OP_SET:
+	case FUTEX_OP_ADD:
+	case FUTEX_OP_OR:
+	case FUTEX_OP_ANDN:
+	case FUTEX_OP_XOR:
+	default:
+		ret = -ENOSYS;
+	}
+  
+	dec_preempt_count();
+
+	if (!ret) {
+		switch (cmp) {
+		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
+		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
+		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
+		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
+		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
+		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
+		default: ret = -ENOSYS;
+		}
+	}
+	return ret;
+}
+
+#endif
+#endif
--- linux-2.6.12/include/asm-m32r/futex.h.jj	2005-08-23 11:13:38.000000000 +0200
+++ linux-2.6.12/include/asm-m32r/futex.h	2005-08-23 11:17:25.000000000 +0200
@@ -0,0 +1,53 @@
+#ifndef _ASM_FUTEX_H
+#define _ASM_FUTEX_H
+
+#ifdef __KERNEL__
+
+#include <linux/futex.h>
+#include <asm/errno.h>
+#include <asm/uaccess.h>
+
+static inline int
+futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
+{
+	int op = (encoded_op >> 28) & 7;
+	int cmp = (encoded_op >> 24) & 15;
+	int oparg = (encoded_op << 8) >> 20;
+	int cmparg = (encoded_op << 20) >> 20;
+	int oldval = 0, ret, tem;
+	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
+		oparg = 1 << oparg;
+
+	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
+		return -EFAULT;
+
+	inc_preempt_count();
+
+	switch (op) {
+	case FUTEX_OP_SET:
+	case FUTEX_OP_ADD:
+	case FUTEX_OP_OR:
+	case FUTEX_OP_ANDN:
+	case FUTEX_OP_XOR:
+	default:
+		ret = -ENOSYS;
+	}
+  
+	dec_preempt_count();
+
+	if (!ret) {
+		switch (cmp) {
+		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
+		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
+		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
+		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
+		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
+		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
+		default: ret = -ENOSYS;
+		}
+	}
+	return ret;
+}
+
+#endif
+#endif
--- linux-2.6.12/include/asm-m68k/futex.h.jj	2005-08-23 11:13:38.000000000 +0200
+++ linux-2.6.12/include/asm-m68k/futex.h	2005-08-23 11:17:25.000000000 +0200
@@ -0,0 +1,53 @@
+#ifndef _ASM_FUTEX_H
+#define _ASM_FUTEX_H
+
+#ifdef __KERNEL__
+
+#include <linux/futex.h>
+#include <asm/errno.h>
+#include <asm/uaccess.h>
+
+static inline int
+futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
+{
+	int op = (encoded_op >> 28) & 7;
+	int cmp = (encoded_op >> 24) & 15;
+	int oparg = (encoded_op << 8) >> 20;
+	int cmparg = (encoded_op << 20) >> 20;
+	int oldval = 0, ret, tem;
+	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
+		oparg = 1 << oparg;
+
+	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
+		return -EFAULT;
+
+	inc_preempt_count();
+
+	switch (op) {
+	case FUTEX_OP_SET:
+	case FUTEX_OP_ADD:
+	case FUTEX_OP_OR:
+	case FUTEX_OP_ANDN:
+	case FUTEX_OP_XOR:
+	default:
+		ret = -ENOSYS;
+	}
+  
+	dec_preempt_count();
+
+	if (!ret) {
+		switch (cmp) {
+		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
+		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
+		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
+		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
+		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
+		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
+		default: ret = -ENOSYS;
+		}
+	}
+	return ret;
+}
+
+#endif
+#endif
--- linux-2.6.12/include/asm-m68knommu/futex.h.jj	2005-08-23 11:13:38.000000000 +0200
+++ linux-2.6.12/include/asm-m68knommu/futex.h	2005-08-23 11:17:25.000000000 +0200
@@ -0,0 +1,53 @@
+#ifndef _ASM_FUTEX_H
+#define _ASM_FUTEX_H
+
+#ifdef __KERNEL__
+
+#include <linux/futex.h>
+#include <asm/errno.h>
+#include <asm/uaccess.h>
+
+static inline int
+futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
+{
+	int op = (encoded_op >> 28) & 7;
+	int cmp = (encoded_op >> 24) & 15;
+	int oparg = (encoded_op << 8) >> 20;
+	int cmparg = (encoded_op << 20) >> 20;
+	int oldval = 0, ret, tem;
+	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
+		oparg = 1 << oparg;
+
+	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
+		return -EFAULT;
+
+	inc_preempt_count();
+
+	switch (op) {
+	case FUTEX_OP_SET:
+	case FUTEX_OP_ADD:
+	case FUTEX_OP_OR:
+	case FUTEX_OP_ANDN:
+	case FUTEX_OP_XOR:
+	default:
+		ret = -ENOSYS;
+	}
+  
+	dec_preempt_count();
+
+	if (!ret) {
+		switch (cmp) {
+		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
+		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
+		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
+		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
+		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
+		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
+		default: ret = -ENOSYS;
+		}
+	}
+	return ret;
+}
+
+#endif
+#endif
--- linux-2.6.12/include/asm-mips/futex.h.jj	2005-08-23 11:13:38.000000000 +0200
+++ linux-2.6.12/include/asm-mips/futex.h	2005-08-23 11:17:25.000000000 +0200
@@ -0,0 +1,53 @@
+#ifndef _ASM_FUTEX_H
+#define _ASM_FUTEX_H
+
+#ifdef __KERNEL__
+
+#include <linux/futex.h>
+#include <asm/errno.h>
+#include <asm/uaccess.h>
+
+static inline int
+futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
+{
+	int op = (encoded_op >> 28) & 7;
+	int cmp = (encoded_op >> 24) & 15;
+	int oparg = (encoded_op << 8) >> 20;
+	int cmparg = (encoded_op << 20) >> 20;
+	int oldval = 0, ret, tem;
+	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
+		oparg = 1 << oparg;
+
+	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
+		return -EFAULT;
+
+	inc_preempt_count();
+
+	switch (op) {
+	case FUTEX_OP_SET:
+	case FUTEX_OP_ADD:
+	case FUTEX_OP_OR:
+	case FUTEX_OP_ANDN:
+	case FUTEX_OP_XOR:
+	default:
+		ret = -ENOSYS;
+	}
+  
+	dec_preempt_count();
+
+	if (!ret) {
+		switch (cmp) {
+		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
+		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
+		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
+		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
+		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
+		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
+		default: ret = -ENOSYS;
+		}
+	}
+	return ret;
+}
+
+#endif
+#endif
--- linux-2.6.12/include/asm-parisc/futex.h.jj	2005-08-23 11:13:38.000000000 +0200
+++ linux-2.6.12/include/asm-parisc/futex.h	2005-08-23 11:17:25.000000000 +0200
@@ -0,0 +1,53 @@
+#ifndef _ASM_FUTEX_H
+#define _ASM_FUTEX_H
+
+#ifdef __KERNEL__
+
+#include <linux/futex.h>
+#include <asm/errno.h>
+#include <asm/uaccess.h>
+
+static inline int
+futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
+{
+	int op = (encoded_op >> 28) & 7;
+	int cmp = (encoded_op >> 24) & 15;
+	int oparg = (encoded_op << 8) >> 20;
+	int cmparg = (encoded_op << 20) >> 20;
+	int oldval = 0, ret, tem;
+	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
+		oparg = 1 << oparg;
+
+	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
+		return -EFAULT;
+
+	inc_preempt_count();
+
+	switch (op) {
+	case FUTEX_OP_SET:
+	case FUTEX_OP_ADD:
+	case FUTEX_OP_OR:
+	case FUTEX_OP_ANDN:
+	case FUTEX_OP_XOR:
+	default:
+		ret = -ENOSYS;
+	}
+  
+	dec_preempt_count();
+
+	if (!ret) {
+		switch (cmp) {
+		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
+		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
+		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
+		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
+		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
+		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
+		default: ret = -ENOSYS;
+		}
+	}
+	return ret;
+}
+
+#endif
+#endif
--- linux-2.6.12/include/asm-ppc/futex.h.jj	2005-08-23 11:13:38.000000000 +0200
+++ linux-2.6.12/include/asm-ppc/futex.h	2005-08-23 11:17:25.000000000 +0200
@@ -0,0 +1,53 @@
+#ifndef _ASM_FUTEX_H
+#define _ASM_FUTEX_H
+
+#ifdef __KERNEL__
+
+#include <linux/futex.h>
+#include <asm/errno.h>
+#include <asm/uaccess.h>
+
+static inline int
+futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
+{
+	int op = (encoded_op >> 28) & 7;
+	int cmp = (encoded_op >> 24) & 15;
+	int oparg = (encoded_op << 8) >> 20;
+	int cmparg = (encoded_op << 20) >> 20;
+	int oldval = 0, ret, tem;
+	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
+		oparg = 1 << oparg;
+
+	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
+		return -EFAULT;
+
+	inc_preempt_count();
+
+	switch (op) {
+	case FUTEX_OP_SET:
+	case FUTEX_OP_ADD:
+	case FUTEX_OP_OR:
+	case FUTEX_OP_ANDN:
+	case FUTEX_OP_XOR:
+	default:
+		ret = -ENOSYS;
+	}
+  
+	dec_preempt_count();
+
+	if (!ret) {
+		switch (cmp) {
+		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
+		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
+		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
+		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
+		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
+		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
+		default: ret = -ENOSYS;
+		}
+	}
+	return ret;
+}
+
+#endif
+#endif
--- linux-2.6.12/include/asm-s390/futex.h.jj	2005-08-23 11:13:38.000000000 +0200
+++ linux-2.6.12/include/asm-s390/futex.h	2005-08-23 11:17:25.000000000 +0200
@@ -0,0 +1,53 @@
+#ifndef _ASM_FUTEX_H
+#define _ASM_FUTEX_H
+
+#ifdef __KERNEL__
+
+#include <linux/futex.h>
+#include <asm/errno.h>
+#include <asm/uaccess.h>
+
+static inline int
+futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
+{
+	int op = (encoded_op >> 28) & 7;
+	int cmp = (encoded_op >> 24) & 15;
+	int oparg = (encoded_op << 8) >> 20;
+	int cmparg = (encoded_op << 20) >> 20;
+	int oldval = 0, ret, tem;
+	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
+		oparg = 1 << oparg;
+
+	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
+		return -EFAULT;
+
+	inc_preempt_count();
+
+	switch (op) {
+	case FUTEX_OP_SET:
+	case FUTEX_OP_ADD:
+	case FUTEX_OP_OR:
+	case FUTEX_OP_ANDN:
+	case FUTEX_OP_XOR:
+	default:
+		ret = -ENOSYS;
+	}
+  
+	dec_preempt_count();
+
+	if (!ret) {
+		switch (cmp) {
+		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
+		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
+		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
+		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
+		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
+		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
+		default: ret = -ENOSYS;
+		}
+	}
+	return ret;
+}
+
+#endif
+#endif
--- linux-2.6.12/include/asm-sh/futex.h.jj	2005-08-23 11:13:38.000000000 +0200
+++ linux-2.6.12/include/asm-sh/futex.h	2005-08-23 11:17:25.000000000 +0200
@@ -0,0 +1,53 @@
+#ifndef _ASM_FUTEX_H
+#define _ASM_FUTEX_H
+
+#ifdef __KERNEL__
+
+#include <linux/futex.h>
+#include <asm/errno.h>
+#include <asm/uaccess.h>
+
+static inline int
+futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
+{
+	int op = (encoded_op >> 28) & 7;
+	int cmp = (encoded_op >> 24) & 15;
+	int oparg = (encoded_op << 8) >> 20;
+	int cmparg = (encoded_op << 20) >> 20;
+	int oldval = 0, ret, tem;
+	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
+		oparg = 1 << oparg;
+
+	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
+		return -EFAULT;
+
+	inc_preempt_count();
+
+	switch (op) {
+	case FUTEX_OP_SET:
+	case FUTEX_OP_ADD:
+	case FUTEX_OP_OR:
+	case FUTEX_OP_ANDN:
+	case FUTEX_OP_XOR:
+	default:
+		ret = -ENOSYS;
+	}
+  
+	dec_preempt_count();
+
+	if (!ret) {
+		switch (cmp) {
+		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
+		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
+		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
+		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
+		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
+		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
+		default: ret = -ENOSYS;
+		}
+	}
+	return ret;
+}
+
+#endif
+#endif
--- linux-2.6.12/include/asm-sh64/futex.h.jj	2005-08-23 11:13:38.000000000 +0200
+++ linux-2.6.12/include/asm-sh64/futex.h	2005-08-23 11:17:25.000000000 +0200
@@ -0,0 +1,53 @@
+#ifndef _ASM_FUTEX_H
+#define _ASM_FUTEX_H
+
+#ifdef __KERNEL__
+
+#include <linux/futex.h>
+#include <asm/errno.h>
+#include <asm/uaccess.h>
+
+static inline int
+futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
+{
+	int op = (encoded_op >> 28) & 7;
+	int cmp = (encoded_op >> 24) & 15;
+	int oparg = (encoded_op << 8) >> 20;
+	int cmparg = (encoded_op << 20) >> 20;
+	int oldval = 0, ret, tem;
+	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
+		oparg = 1 << oparg;
+
+	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
+		return -EFAULT;
+
+	inc_preempt_count();
+
+	switch (op) {
+	case FUTEX_OP_SET:
+	case FUTEX_OP_ADD:
+	case FUTEX_OP_OR:
+	case FUTEX_OP_ANDN:
+	case FUTEX_OP_XOR:
+	default:
+		ret = -ENOSYS;
+	}
+  
+	dec_preempt_count();
+
+	if (!ret) {
+		switch (cmp) {
+		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
+		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
+		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
+		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
+		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
+		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
+		default: ret = -ENOSYS;
+		}
+	}
+	return ret;
+}
+
+#endif
+#endif
--- linux-2.6.12/include/asm-sparc/futex.h.jj	2005-08-23 11:13:38.000000000 +0200
+++ linux-2.6.12/include/asm-sparc/futex.h	2005-08-23 11:17:25.000000000 +0200
@@ -0,0 +1,53 @@
+#ifndef _ASM_FUTEX_H
+#define _ASM_FUTEX_H
+
+#ifdef __KERNEL__
+
+#include <linux/futex.h>
+#include <asm/errno.h>
+#include <asm/uaccess.h>
+
+static inline int
+futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
+{
+	int op = (encoded_op >> 28) & 7;
+	int cmp = (encoded_op >> 24) & 15;
+	int oparg = (encoded_op << 8) >> 20;
+	int cmparg = (encoded_op << 20) >> 20;
+	int oldval = 0, ret, tem;
+	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
+		oparg = 1 << oparg;
+
+	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
+		return -EFAULT;
+
+	inc_preempt_count();
+
+	switch (op) {
+	case FUTEX_OP_SET:
+	case FUTEX_OP_ADD:
+	case FUTEX_OP_OR:
+	case FUTEX_OP_ANDN:
+	case FUTEX_OP_XOR:
+	default:
+		ret = -ENOSYS;
+	}
+  
+	dec_preempt_count();
+
+	if (!ret) {
+		switch (cmp) {
+		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
+		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
+		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
+		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
+		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
+		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
+		default: ret = -ENOSYS;
+		}
+	}
+	return ret;
+}
+
+#endif
+#endif
--- linux-2.6.12/include/asm-sparc64/futex.h.jj	2005-08-23 11:13:38.000000000 +0200
+++ linux-2.6.12/include/asm-sparc64/futex.h	2005-08-23 11:17:25.000000000 +0200
@@ -0,0 +1,53 @@
+#ifndef _ASM_FUTEX_H
+#define _ASM_FUTEX_H
+
+#ifdef __KERNEL__
+
+#include <linux/futex.h>
+#include <asm/errno.h>
+#include <asm/uaccess.h>
+
+static inline int
+futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
+{
+	int op = (encoded_op >> 28) & 7;
+	int cmp = (encoded_op >> 24) & 15;
+	int oparg = (encoded_op << 8) >> 20;
+	int cmparg = (encoded_op << 20) >> 20;
+	int oldval = 0, ret, tem;
+	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
+		oparg = 1 << oparg;
+
+	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
+		return -EFAULT;
+
+	inc_preempt_count();
+
+	switch (op) {
+	case FUTEX_OP_SET:
+	case FUTEX_OP_ADD:
+	case FUTEX_OP_OR:
+	case FUTEX_OP_ANDN:
+	case FUTEX_OP_XOR:
+	default:
+		ret = -ENOSYS;
+	}
+  
+	dec_preempt_count();
+
+	if (!ret) {
+		switch (cmp) {
+		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
+		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
+		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
+		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
+		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
+		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
+		default: ret = -ENOSYS;
+		}
+	}
+	return ret;
+}
+
+#endif
+#endif
--- linux-2.6.12/include/asm-um/futex.h.jj	2005-08-23 11:13:38.000000000 +0200
+++ linux-2.6.12/include/asm-um/futex.h	2005-08-23 11:17:25.000000000 +0200
@@ -0,0 +1,53 @@
+#ifndef _ASM_FUTEX_H
+#define _ASM_FUTEX_H
+
+#ifdef __KERNEL__
+
+#include <linux/futex.h>
+#include <asm/errno.h>
+#include <asm/uaccess.h>
+
+static inline int
+futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
+{
+	int op = (encoded_op >> 28) & 7;
+	int cmp = (encoded_op >> 24) & 15;
+	int oparg = (encoded_op << 8) >> 20;
+	int cmparg = (encoded_op << 20) >> 20;
+	int oldval = 0, ret, tem;
+	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
+		oparg = 1 << oparg;
+
+	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
+		return -EFAULT;
+
+	inc_preempt_count();
+
+	switch (op) {
+	case FUTEX_OP_SET:
+	case FUTEX_OP_ADD:
+	case FUTEX_OP_OR:
+	case FUTEX_OP_ANDN:
+	case FUTEX_OP_XOR:
+	default:
+		ret = -ENOSYS;
+	}
+  
+	dec_preempt_count();
+
+	if (!ret) {
+		switch (cmp) {
+		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
+		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
+		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
+		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
+		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
+		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
+		default: ret = -ENOSYS;
+		}
+	}
+	return ret;
+}
+
+#endif
+#endif
--- linux-2.6.12/include/asm-v850/futex.h.jj	2005-08-23 11:13:38.000000000 +0200
+++ linux-2.6.12/include/asm-v850/futex.h	2005-08-23 11:17:25.000000000 +0200
@@ -0,0 +1,53 @@
+#ifndef _ASM_FUTEX_H
+#define _ASM_FUTEX_H
+
+#ifdef __KERNEL__
+
+#include <linux/futex.h>
+#include <asm/errno.h>
+#include <asm/uaccess.h>
+
+static inline int
+futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
+{
+	int op = (encoded_op >> 28) & 7;
+	int cmp = (encoded_op >> 24) & 15;
+	int oparg = (encoded_op << 8) >> 20;
+	int cmparg = (encoded_op << 20) >> 20;
+	int oldval = 0, ret, tem;
+	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
+		oparg = 1 << oparg;
+
+	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
+		return -EFAULT;
+
+	inc_preempt_count();
+
+	switch (op) {
+	case FUTEX_OP_SET:
+	case FUTEX_OP_ADD:
+	case FUTEX_OP_OR:
+	case FUTEX_OP_ANDN:
+	case FUTEX_OP_XOR:
+	default:
+		ret = -ENOSYS;
+	}
+  
+	dec_preempt_count();
+
+	if (!ret) {
+		switch (cmp) {
+		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
+		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
+		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
+		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
+		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
+		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
+		default: ret = -ENOSYS;
+		}
+	}
+	return ret;
+}
+
+#endif
+#endif

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="tf.c"

#define _GNU_SOURCE 1
#include <errno.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>

#define FUTEX_WAIT		0
#define FUTEX_WAKE		1
#define FUTEX_FD		2
#define FUTEX_REQUEUE		3
#define FUTEX_CMP_REQUEUE	4
#define FUTEX_WAKE_OP		5

#define FUTEX_OP_SET		0	/* *(int *)UADDR2 = OPARG; */
#define FUTEX_OP_ADD		1	/* *(int *)UADDR2 += OPARG; */
#define FUTEX_OP_OR		2	/* *(int *)UADDR2 |= OPARG; */
#define FUTEX_OP_ANDN		3	/* *(int *)UADDR2 &= ~OPARG; */
#define FUTEX_OP_XOR		4	/* *(int *)UADDR2 ^= OPARG; */

#define FUTEX_OP_OPARG_SHIFT	8	/* Use (1 << OPARG) instead of OPARG.  */

#define FUTEX_OP_CMP_EQ		0	/* if (oldval == CMPARG) wake */
#define FUTEX_OP_CMP_NE		1	/* if (oldval != CMPARG) wake */
#define FUTEX_OP_CMP_LT		2	/* if (oldval < CMPARG) wake */
#define FUTEX_OP_CMP_LE		3	/* if (oldval <= CMPARG) wake */
#define FUTEX_OP_CMP_GT		4	/* if (oldval > CMPARG) wake */
#define FUTEX_OP_CMP_GE		5	/* if (oldval >= CMPARG) wake */

/* FUTEX_WAKE_OP will perform atomically
   int oldval = *(int *)UADDR2;
   *(int *)UADDR2 = oldval OP OPARG;
   if (oldval CMP CMPARG)
     wake UADDR2;  */

#define FUTEX_OP(op, oparg, cmp, cmparg) \
  (((op & 0xf) << 28) | ((cmp & 0xf) << 24)		\
   | ((oparg & 0xfff) << 12) | (cmparg & 0xfff))

int futex;
int lock;
volatile int wake2;
pthread_barrier_t b;

#define N (5 * 2 * 6 * 20 + 1)

static void *
tf (void *arg)
{
  int i;
  for (i = 0; i < N; i++)
    {
      int xpect;
      pthread_barrier_wait (&b);
      xpect = arg ? lock : i;
      int ret = syscall (SYS_futex, arg ? &lock : &futex, FUTEX_WAIT,
			 xpect, 0);
      if (ret < 0 && errno == ENOSYS)
	error (EXIT_FAILURE, 0, "SYS_futex syscall FUTEX_WAIT returned ENOSYS");
      if (arg && !wake2)
	error (EXIT_FAILURE, 0, "%d: arg && !wake2", i);
      pthread_barrier_wait (&b);
      if (futex != i + 1)
	error (EXIT_FAILURE, 0, "tf%d: futex %d != i %d", arg ? 1 : 0, futex, i + 1);
    }
  return NULL;
}

int
main (int argc, char **argv)
{
  int verbose = (argc > 1 && strcmp (argv[1], "-v"));

  pthread_barrier_init (&b, NULL, 3);
  pthread_t th[2];
  if (pthread_create (&th[0], NULL, tf, (void *) 0L) != 0)
    error (EXIT_FAILURE, 0, "create failed");

  if (pthread_create (&th[1], NULL, tf, (void *) 1L) != 0)
    error (EXIT_FAILURE, 0, "create failed");

  int i;
  for (i = 0; i < N; i++)
    {
      int op, cmp, shift, cmd, cmparg, oparg, xpect;

      if (i != 0)
	{
	  cmd = i - 1;
	  op = cmd % 5;
	  cmd /= 5;
	  cmp = cmd % 6;
	  cmd /= 6;
	  shift = cmd % 2;
	  lock = (random () << 31) ^ random ();
	  oparg = (random () << 31) ^ random ();
	  cmparg = ((int) random () << 20) >> 20;
	  if (shift)
	    oparg &= 31;
	  else
	    {
	      lock = (lock << 20) >> 20;
	      oparg = (oparg << 20) >> 20;
	    }
	  cmd = FUTEX_OP (op | (shift ? FUTEX_OP_OPARG_SHIFT : 0),
			  oparg, cmp, cmparg);
	  if (shift)
	    oparg = (1 << oparg);
	  switch (cmp)
	    {
	    case FUTEX_OP_CMP_EQ: wake2 = (lock == cmparg); break;
	    case FUTEX_OP_CMP_NE: wake2 = (lock != cmparg); break;
	    case FUTEX_OP_CMP_LT: wake2 = (lock < cmparg); break;
	    case FUTEX_OP_CMP_LE: wake2 = (lock <= cmparg); break;
	    case FUTEX_OP_CMP_GT: wake2 = (lock > cmparg); break;
	    case FUTEX_OP_CMP_GE: wake2 = (lock >= cmparg); break;
	    default:
	      abort ();
	    }
	  xpect = lock;
	  switch (op)
	    {
	    case FUTEX_OP_SET: xpect = oparg; break;
	    case FUTEX_OP_ADD: xpect += oparg; break;
	    case FUTEX_OP_OR: xpect |= oparg; break;
	    case FUTEX_OP_ANDN: xpect &= ~oparg; break;
	    case FUTEX_OP_XOR: xpect ^= oparg; break;
	    default:
	      abort ();
	    }
	  if (verbose)
	    printf ("cmd %08x op %d shift %d cmp %d oparg %d cmparg %d lock %d\n",
		    (unsigned int) cmd, op, shift, cmp, oparg, cmparg, lock);
	}
      else
	{
	  xpect = lock;
	  wake2 = 0;
	}
      if (verbose)
	printf ("%d: wake2 %d\n", i, wake2);
      pthread_barrier_wait (&b);
      struct timespec ts = { 0, 10000000 };
      nanosleep (&ts, NULL);
      futex++;
      int ret;
      if (i == 0)
	ret = syscall (SYS_futex, &futex, FUTEX_WAKE, 1);
      else
	ret = syscall (SYS_futex, &futex, FUTEX_WAKE_OP, 1, 1, &lock, cmd);
      if (ret < 0 && errno == ENOSYS)
	error (EXIT_FAILURE, 0,
	       "SYS_futex syscall FUTEX_WAKE%s returned ENOSYS",
	       i ? "_OP" : "");
      if (lock != xpect)
	error (EXIT_FAILURE, 0, "%d: lock %d != xpect %d", i, lock, xpect);
      if (!wake2)
	{
	  nanosleep (&ts, NULL);
	  wake2 = 1;
	  syscall (SYS_futex, &lock, FUTEX_WAKE, 1);
	}
      pthread_barrier_wait (&b);
    }

  if (pthread_join (th[0], NULL) != 0)
    error (EXIT_FAILURE, 0, "join failed");
  if (pthread_join (th[1], NULL) != 0)
    error (EXIT_FAILURE, 0, "join failed");

  return 0;
}

--fdj2RfSjLxBAspz7--
