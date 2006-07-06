Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWGFUed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWGFUed (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 16:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbWGFUed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 16:34:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7822 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750817AbWGFUeb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 16:34:31 -0400
Date: Thu, 6 Jul 2006 13:34:14 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile'
In-Reply-To: <Pine.LNX.4.64.0607061237300.3869@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0607061333190.3869@g5.osdl.org>
References: <20060705114630.GA3134@elte.hu> <20060705101059.66a762bf.akpm@osdl.org>
 <20060705193551.GA13070@elte.hu> <20060705131824.52fa20ec.akpm@osdl.org>
 <Pine.LNX.4.64.0607051332430.12404@g5.osdl.org> <20060705204727.GA16615@elte.hu>
 <Pine.LNX.4.64.0607051411460.12404@g5.osdl.org> <20060705214502.GA27597@elte.hu>
 <Pine.LNX.4.64.0607051458200.12404@g5.osdl.org> <Pine.LNX.4.64.0607051555140.12404@g5.osdl.org>
 <20060706081639.GA24179@elte.hu> <Pine.LNX.4.64.0607061237300.3869@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 6 Jul 2006, Linus Torvalds wrote:
> 
> So I _think_ that we should change the "=m" to the much more correct "+m" 
> at the same time (or before - it's really a bug-fix regardless) as 
> removing the "volatile".

Here's a first cut (UNTESTED!) for x86. I didn't check any other 
architectures, I bet they have similar problems.

		Linus

----
diff --git a/include/asm-i386/atomic.h b/include/asm-i386/atomic.h
index 4f061fa..51a1662 100644
--- a/include/asm-i386/atomic.h
+++ b/include/asm-i386/atomic.h
@@ -46,8 +46,8 @@ static __inline__ void atomic_add(int i,
 {
 	__asm__ __volatile__(
 		LOCK_PREFIX "addl %1,%0"
-		:"=m" (v->counter)
-		:"ir" (i), "m" (v->counter));
+		:"+m" (v->counter)
+		:"ir" (i));
 }
 
 /**
@@ -61,8 +61,8 @@ static __inline__ void atomic_sub(int i,
 {
 	__asm__ __volatile__(
 		LOCK_PREFIX "subl %1,%0"
-		:"=m" (v->counter)
-		:"ir" (i), "m" (v->counter));
+		:"+m" (v->counter)
+		:"ir" (i));
 }
 
 /**
@@ -80,8 +80,8 @@ static __inline__ int atomic_sub_and_tes
 
 	__asm__ __volatile__(
 		LOCK_PREFIX "subl %2,%0; sete %1"
-		:"=m" (v->counter), "=qm" (c)
-		:"ir" (i), "m" (v->counter) : "memory");
+		:"+m" (v->counter), "=qm" (c)
+		:"ir" (i) : "memory");
 	return c;
 }
 
@@ -95,8 +95,7 @@ static __inline__ void atomic_inc(atomic
 {
 	__asm__ __volatile__(
 		LOCK_PREFIX "incl %0"
-		:"=m" (v->counter)
-		:"m" (v->counter));
+		:"+m" (v->counter));
 }
 
 /**
@@ -109,8 +108,7 @@ static __inline__ void atomic_dec(atomic
 {
 	__asm__ __volatile__(
 		LOCK_PREFIX "decl %0"
-		:"=m" (v->counter)
-		:"m" (v->counter));
+		:"+m" (v->counter));
 }
 
 /**
@@ -127,8 +125,8 @@ static __inline__ int atomic_dec_and_tes
 
 	__asm__ __volatile__(
 		LOCK_PREFIX "decl %0; sete %1"
-		:"=m" (v->counter), "=qm" (c)
-		:"m" (v->counter) : "memory");
+		:"+m" (v->counter), "=qm" (c)
+		: : "memory");
 	return c != 0;
 }
 
@@ -146,8 +144,8 @@ static __inline__ int atomic_inc_and_tes
 
 	__asm__ __volatile__(
 		LOCK_PREFIX "incl %0; sete %1"
-		:"=m" (v->counter), "=qm" (c)
-		:"m" (v->counter) : "memory");
+		:"+m" (v->counter), "=qm" (c)
+		: : "memory");
 	return c != 0;
 }
 
@@ -166,8 +164,8 @@ static __inline__ int atomic_add_negativ
 
 	__asm__ __volatile__(
 		LOCK_PREFIX "addl %2,%0; sets %1"
-		:"=m" (v->counter), "=qm" (c)
-		:"ir" (i), "m" (v->counter) : "memory");
+		:"+m" (v->counter), "=qm" (c)
+		:"ir" (i) : "memory");
 	return c;
 }
 
diff --git a/include/asm-i386/futex.h b/include/asm-i386/futex.h
index 7b8ceef..946d97c 100644
--- a/include/asm-i386/futex.h
+++ b/include/asm-i386/futex.h
@@ -20,8 +20,8 @@ #define __futex_atomic_op1(insn, ret, ol
 	.align	8\n\
 	.long	1b,3b\n\
 	.previous"						\
-	: "=r" (oldval), "=r" (ret), "=m" (*uaddr)		\
-	: "i" (-EFAULT), "m" (*uaddr), "0" (oparg), "1" (0))
+	: "=r" (oldval), "=r" (ret), "+m" (*uaddr)		\
+	: "i" (-EFAULT), "0" (oparg), "1" (0))
 
 #define __futex_atomic_op2(insn, ret, oldval, uaddr, oparg) \
   __asm__ __volatile (						\
@@ -38,9 +38,9 @@ #define __futex_atomic_op2(insn, ret, ol
 	.align	8\n\
 	.long	1b,4b,2b,4b\n\
 	.previous"						\
-	: "=&a" (oldval), "=&r" (ret), "=m" (*uaddr),		\
+	: "=&a" (oldval), "=&r" (ret), "+m" (*uaddr),		\
 	  "=&r" (tem)						\
-	: "r" (oparg), "i" (-EFAULT), "m" (*uaddr), "1" (0))
+	: "r" (oparg), "i" (-EFAULT), "1" (0))
 
 static inline int
 futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
@@ -123,7 +123,7 @@ futex_atomic_cmpxchg_inatomic(int __user
 		"	.long   1b,3b				\n"
 		"	.previous				\n"
 
-		: "=a" (oldval), "=m" (*uaddr)
+		: "=a" (oldval), "+m" (*uaddr)
 		: "i" (-EFAULT), "r" (newval), "0" (oldval)
 		: "memory"
 	);
diff --git a/include/asm-i386/local.h b/include/asm-i386/local.h
index 3b4998c..12060e2 100644
--- a/include/asm-i386/local.h
+++ b/include/asm-i386/local.h
@@ -17,32 +17,30 @@ static __inline__ void local_inc(local_t
 {
 	__asm__ __volatile__(
 		"incl %0"
-		:"=m" (v->counter)
-		:"m" (v->counter));
+		:"+m" (v->counter));
 }
 
 static __inline__ void local_dec(local_t *v)
 {
 	__asm__ __volatile__(
 		"decl %0"
-		:"=m" (v->counter)
-		:"m" (v->counter));
+		:"+m" (v->counter));
 }
 
 static __inline__ void local_add(long i, local_t *v)
 {
 	__asm__ __volatile__(
 		"addl %1,%0"
-		:"=m" (v->counter)
-		:"ir" (i), "m" (v->counter));
+		:"+m" (v->counter)
+		:"ir" (i));
 }
 
 static __inline__ void local_sub(long i, local_t *v)
 {
 	__asm__ __volatile__(
 		"subl %1,%0"
-		:"=m" (v->counter)
-		:"ir" (i), "m" (v->counter));
+		:"+m" (v->counter)
+		:"ir" (i));
 }
 
 /* On x86, these are no better than the atomic variants. */
diff --git a/include/asm-i386/posix_types.h b/include/asm-i386/posix_types.h
index 4e47ed0..133e31e 100644
--- a/include/asm-i386/posix_types.h
+++ b/include/asm-i386/posix_types.h
@@ -51,12 +51,12 @@ #if defined(__KERNEL__) || !defined(__GL
 #undef	__FD_SET
 #define __FD_SET(fd,fdsetp) \
 		__asm__ __volatile__("btsl %1,%0": \
-			"=m" (*(__kernel_fd_set *) (fdsetp)):"r" ((int) (fd)))
+			"+m" (*(__kernel_fd_set *) (fdsetp)):"r" ((int) (fd)))
 
 #undef	__FD_CLR
 #define __FD_CLR(fd,fdsetp) \
 		__asm__ __volatile__("btrl %1,%0": \
-			"=m" (*(__kernel_fd_set *) (fdsetp)):"r" ((int) (fd)))
+			"+m" (*(__kernel_fd_set *) (fdsetp)):"r" ((int) (fd)))
 
 #undef	__FD_ISSET
 #define __FD_ISSET(fd,fdsetp) (__extension__ ({ \
diff --git a/include/asm-i386/rwlock.h b/include/asm-i386/rwlock.h
index 94f0019..96b0bef 100644
--- a/include/asm-i386/rwlock.h
+++ b/include/asm-i386/rwlock.h
@@ -37,7 +37,7 @@ #define __build_read_lock_const(rw, help
 			"popl %%eax\n\t" \
 			"1:\n", \
 			"subl $1,%0\n\t", \
-			"=m" (*(volatile int *)rw) : : "memory")
+			"+m" (*(volatile int *)rw) : : "memory")
 
 #define __build_read_lock(rw, helper)	do { \
 						if (__builtin_constant_p(rw)) \
@@ -63,7 +63,7 @@ #define __build_write_lock_const(rw, hel
 			"popl %%eax\n\t" \
 			"1:\n", \
 			"subl $" RW_LOCK_BIAS_STR ",%0\n\t", \
-			"=m" (*(volatile int *)rw) : : "memory")
+			"+m" (*(volatile int *)rw) : : "memory")
 
 #define __build_write_lock(rw, helper)	do { \
 						if (__builtin_constant_p(rw)) \
diff --git a/include/asm-i386/rwsem.h b/include/asm-i386/rwsem.h
index 2f07601..43113f5 100644
--- a/include/asm-i386/rwsem.h
+++ b/include/asm-i386/rwsem.h
@@ -111,8 +111,8 @@ LOCK_PREFIX	"  incl      (%%eax)\n\t" /*
 		"  jmp       1b\n"
 		LOCK_SECTION_END
 		"# ending down_read\n\t"
-		: "=m"(sem->count)
-		: "a"(sem), "m"(sem->count)
+		: "+m" (sem->count)
+		: "a" (sem)
 		: "memory", "cc");
 }
 
@@ -133,8 +133,8 @@ LOCK_PREFIX	"  cmpxchgl  %2,%0\n\t"
 		"  jnz	     1b\n\t"
 		"2:\n\t"
 		"# ending __down_read_trylock\n\t"
-		: "+m"(sem->count), "=&a"(result), "=&r"(tmp)
-		: "i"(RWSEM_ACTIVE_READ_BIAS)
+		: "+m" (sem->count), "=&a" (result), "=&r" (tmp)
+		: "i" (RWSEM_ACTIVE_READ_BIAS)
 		: "memory", "cc");
 	return result>=0 ? 1 : 0;
 }
@@ -161,8 +161,8 @@ LOCK_PREFIX	"  xadd      %%edx,(%%eax)\n
 		"  jmp       1b\n"
 		LOCK_SECTION_END
 		"# ending down_write"
-		: "=m"(sem->count), "=d"(tmp)
-		: "a"(sem), "1"(tmp), "m"(sem->count)
+		: "+m" (sem->count), "=d" (tmp)
+		: "a" (sem), "1" (tmp)
 		: "memory", "cc");
 }
 
@@ -205,8 +205,8 @@ LOCK_PREFIX	"  xadd      %%edx,(%%eax)\n
 		"  jmp       1b\n"
 		LOCK_SECTION_END
 		"# ending __up_read\n"
-		: "=m"(sem->count), "=d"(tmp)
-		: "a"(sem), "1"(tmp), "m"(sem->count)
+		: "+m" (sem->count), "=d" (tmp)
+		: "a" (sem), "1" (tmp)
 		: "memory", "cc");
 }
 
@@ -231,8 +231,8 @@ LOCK_PREFIX	"  xaddl     %%edx,(%%eax)\n
 		"  jmp       1b\n"
 		LOCK_SECTION_END
 		"# ending __up_write\n"
-		: "=m"(sem->count)
-		: "a"(sem), "i"(-RWSEM_ACTIVE_WRITE_BIAS), "m"(sem->count)
+		: "+m" (sem->count)
+		: "a" (sem), "i" (-RWSEM_ACTIVE_WRITE_BIAS)
 		: "memory", "cc", "edx");
 }
 
@@ -256,8 +256,8 @@ LOCK_PREFIX	"  addl      %2,(%%eax)\n\t"
 		"  jmp       1b\n"
 		LOCK_SECTION_END
 		"# ending __downgrade_write\n"
-		: "=m"(sem->count)
-		: "a"(sem), "i"(-RWSEM_WAITING_BIAS), "m"(sem->count)
+		: "+m" (sem->count)
+		: "a" (sem), "i" (-RWSEM_WAITING_BIAS)
 		: "memory", "cc");
 }
 
@@ -268,8 +268,8 @@ static inline void rwsem_atomic_add(int 
 {
 	__asm__ __volatile__(
 LOCK_PREFIX	"addl %1,%0"
-		: "=m"(sem->count)
-		: "ir"(delta), "m"(sem->count));
+		: "+m" (sem->count)
+		: "ir" (delta));
 }
 
 /*
@@ -280,10 +280,9 @@ static inline int rwsem_atomic_update(in
 	int tmp = delta;
 
 	__asm__ __volatile__(
-LOCK_PREFIX	"xadd %0,(%2)"
-		: "+r"(tmp), "=m"(sem->count)
-		: "r"(sem), "m"(sem->count)
-		: "memory");
+LOCK_PREFIX	"xadd %0,%1"
+		: "+r" (tmp), "+m" (sem->count)
+		: : "memory");
 
 	return tmp+delta;
 }
diff --git a/include/asm-i386/semaphore.h b/include/asm-i386/semaphore.h
index f7a0f31..d51e800 100644
--- a/include/asm-i386/semaphore.h
+++ b/include/asm-i386/semaphore.h
@@ -107,7 +107,7 @@ static inline void down(struct semaphore
 		"call __down_failed\n\t"
 		"jmp 1b\n"
 		LOCK_SECTION_END
-		:"=m" (sem->count)
+		:"+m" (sem->count)
 		:
 		:"memory","ax");
 }
@@ -132,7 +132,7 @@ static inline int down_interruptible(str
 		"call __down_failed_interruptible\n\t"
 		"jmp 1b\n"
 		LOCK_SECTION_END
-		:"=a" (result), "=m" (sem->count)
+		:"=a" (result), "+m" (sem->count)
 		:
 		:"memory");
 	return result;
@@ -157,7 +157,7 @@ static inline int down_trylock(struct se
 		"call __down_failed_trylock\n\t"
 		"jmp 1b\n"
 		LOCK_SECTION_END
-		:"=a" (result), "=m" (sem->count)
+		:"=a" (result), "+m" (sem->count)
 		:
 		:"memory");
 	return result;
@@ -182,7 +182,7 @@ static inline void up(struct semaphore *
 		"jmp 1b\n"
 		LOCK_SECTION_END
 		".subsection 0\n"
-		:"=m" (sem->count)
+		:"+m" (sem->count)
 		:
 		:"memory","ax");
 }
diff --git a/include/asm-i386/spinlock.h b/include/asm-i386/spinlock.h
index 87c40f8..d816c62 100644
--- a/include/asm-i386/spinlock.h
+++ b/include/asm-i386/spinlock.h
@@ -65,7 +65,7 @@ static inline void __raw_spin_lock(raw_s
 	alternative_smp(
 		__raw_spin_lock_string,
 		__raw_spin_lock_string_up,
-		"=m" (lock->slock) : : "memory");
+		"+m" (lock->slock) : : "memory");
 }
 
 /*
@@ -79,7 +79,7 @@ static inline void __raw_spin_lock_flags
 	alternative_smp(
 		__raw_spin_lock_string_flags,
 		__raw_spin_lock_string_up,
-		"=m" (lock->slock) : "r" (flags) : "memory");
+		"+m" (lock->slock) : "r" (flags) : "memory");
 }
 #endif
 
@@ -88,7 +88,7 @@ static inline int __raw_spin_trylock(raw
 	char oldval;
 	__asm__ __volatile__(
 		"xchgb %b0,%1"
-		:"=q" (oldval), "=m" (lock->slock)
+		:"=q" (oldval), "+m" (lock->slock)
 		:"0" (0) : "memory");
 	return oldval > 0;
 }
@@ -104,7 +104,7 @@ #if !defined(CONFIG_X86_OOSTORE) && !def
 
 #define __raw_spin_unlock_string \
 	"movb $1,%0" \
-		:"=m" (lock->slock) : : "memory"
+		:"+m" (lock->slock) : : "memory"
 
 
 static inline void __raw_spin_unlock(raw_spinlock_t *lock)
@@ -118,7 +118,7 @@ #else
 
 #define __raw_spin_unlock_string \
 	"xchgb %b0, %1" \
-		:"=q" (oldval), "=m" (lock->slock) \
+		:"=q" (oldval), "+m" (lock->slock) \
 		:"0" (oldval) : "memory"
 
 static inline void __raw_spin_unlock(raw_spinlock_t *lock)
@@ -199,13 +199,13 @@ static inline int __raw_write_trylock(ra
 
 static inline void __raw_read_unlock(raw_rwlock_t *rw)
 {
-	asm volatile(LOCK_PREFIX "incl %0" :"=m" (rw->lock) : : "memory");
+	asm volatile(LOCK_PREFIX "incl %0" :"+m" (rw->lock) : : "memory");
 }
 
 static inline void __raw_write_unlock(raw_rwlock_t *rw)
 {
 	asm volatile(LOCK_PREFIX "addl $" RW_LOCK_BIAS_STR ", %0"
-				 : "=m" (rw->lock) : : "memory");
+				 : "+m" (rw->lock) : : "memory");
 }
 
 #endif /* __ASM_SPINLOCK_H */
