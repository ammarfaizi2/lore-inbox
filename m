Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbVARCOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVARCOj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 21:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVARCOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 21:14:39 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:55750 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261190AbVARBsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 20:48:17 -0500
From: Darren Williams <dsw@gelato.unsw.edu.au>
To: Ingo Molnar <mingo@elte.hu>
Date: Tue, 18 Jan 2005 12:47:52 +1100
Cc: Andrew Morton <akpm@osdl.org>, Chris Wedgwood <cw@f00f.org>,
       torvalds@osdl.org, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org, Ia64 Linux <linux-ia64@vger.kernel.org>
Subject: Re: Horrible regression with -CURRENT from "Don't busy-lock-loop in preemptable spinlocks" patch
Message-ID: <20050118014752.GA14709@cse.unsw.EDU.AU>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@osdl.org>, Chris Wedgwood <cw@f00f.org>,
	torvalds@osdl.org, benh@kernel.crashing.org,
	linux-kernel@vger.kernel.org,
	Ia64 Linux <linux-ia64@vger.kernel.org>
References: <20050117055044.GA3514@taniwha.stupidest.org> <20050116230922.7274f9a2.akpm@osdl.org> <20050117143301.GA10341@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050117143301.GA10341@elte.hu>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo

On Mon, 17 Jan 2005, Ingo Molnar wrote:

> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > > +BUILD_LOCK_OPS(spin, spinlock_t, spin_is_locked);
> > > +BUILD_LOCK_OPS(read, rwlock_t, rwlock_is_locked);
> > > +BUILD_LOCK_OPS(write, rwlock_t, spin_is_locked);
> > 
> > If you replace the last line with
> > 
> > 	BUILD_LOCK_OPS(write, rwlock_t, rwlock_is_locked);
> > 
> > does it help?
> 
> this is not enough - the proper solution should be the patch below,
> which i sent earlier today as a reply to Paul Mackerras' comments.
> 
> 	Ingo
> 
> --
> the first fix is that there was no compiler warning on x86 because it
> uses macros - i fixed this by changing the spinlock field to be
> '->slock'. (we could also use inline functions to get type protection, i
> chose this solution because it was the easiest to do.)
> 
> the second fix is to split rwlock_is_locked() into two functions:
> 
>  +/**
>  + * read_is_locked - would read_trylock() fail?
>  + * @lock: the rwlock in question.
>  + */
>  +#define read_is_locked(x) (atomic_read((atomic_t *)&(x)->lock) <= 0)
>  +
>  +/**
>  + * write_is_locked - would write_trylock() fail?
>  + * @lock: the rwlock in question.
>  + */
>  +#define write_is_locked(x) ((x)->lock != RW_LOCK_BIAS)
> 
> this canonical naming of them also enabled the elimination of the newly
> added 'is_locked_fn' argument to the BUILD_LOCK_OPS macro.
> 
> the third change was to change the other user of rwlock_is_locked(), and
> to put a migration helper there: architectures that dont have
> read/write_is_locked defined yet will get a #warning message but the
> build will succeed. (except if PREEMPT is enabled - there we really
> need.)
> 
> compile and boot-tested on x86, on SMP and UP, PREEMPT and !PREEMPT. 
> Non-x86 architectures should work fine, except PREEMPT+SMP builds which
> will need the read_is_locked()/write_is_locked() definitions.
> !PREEMPT+SMP builds will work fine and will produce a #warning.
> 
> 	Ingo
This may fix some archs however ia64 is still broken, with:

kernel/built-in.o(.spinlock.text+0x8b2): In function `sched_init_smp':
kernel/sched.c:650: undefined reference to `read_is_locked'
kernel/built-in.o(.spinlock.text+0xa52): In function `sched_init':
kernel/sched.c:687: undefined reference to `read_is_locked'
kernel/built-in.o(.spinlock.text+0xcb2): In function `schedule':
include/asm/bitops.h:279: undefined reference to `write_is_locked'
kernel/built-in.o(.spinlock.text+0xe72): In function `schedule':
include/linux/sched.h:1122: undefined reference to `write_is_locked'
make: *** [.tmp_vmlinux1] Error 1

include/asm-ia64/spinflock.h needs to define:
 read_is_locked(x)
 write_is_locked(x)

someone who knows the locking code will need to fill in
the blanks.

Darren

> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> 
> --- linux/kernel/spinlock.c.orig
> +++ linux/kernel/spinlock.c
> @@ -173,7 +173,7 @@ EXPORT_SYMBOL(_write_lock);
>   * (We do this in a function because inlining it would be excessive.)
>   */
>  
> -#define BUILD_LOCK_OPS(op, locktype, is_locked_fn)			\
> +#define BUILD_LOCK_OPS(op, locktype)					\
>  void __lockfunc _##op##_lock(locktype *lock)				\
>  {									\
>  	preempt_disable();						\
> @@ -183,7 +183,7 @@ void __lockfunc _##op##_lock(locktype *l
>  		preempt_enable();					\
>  		if (!(lock)->break_lock)				\
>  			(lock)->break_lock = 1;				\
> -		while (is_locked_fn(lock) && (lock)->break_lock)	\
> +		while (op##_is_locked(lock) && (lock)->break_lock)	\
>  			cpu_relax();					\
>  		preempt_disable();					\
>  	}								\
> @@ -205,7 +205,7 @@ unsigned long __lockfunc _##op##_lock_ir
>  		preempt_enable();					\
>  		if (!(lock)->break_lock)				\
>  			(lock)->break_lock = 1;				\
> -		while (is_locked_fn(lock) && (lock)->break_lock)	\
> +		while (op##_is_locked(lock) && (lock)->break_lock)	\
>  			cpu_relax();					\
>  		preempt_disable();					\
>  	}								\
> @@ -246,9 +246,9 @@ EXPORT_SYMBOL(_##op##_lock_bh)
>   *         _[spin|read|write]_lock_irqsave()
>   *         _[spin|read|write]_lock_bh()
>   */
> -BUILD_LOCK_OPS(spin, spinlock_t, spin_is_locked);
> -BUILD_LOCK_OPS(read, rwlock_t, rwlock_is_locked);
> -BUILD_LOCK_OPS(write, rwlock_t, spin_is_locked);
> +BUILD_LOCK_OPS(spin, spinlock_t);
> +BUILD_LOCK_OPS(read, rwlock_t);
> +BUILD_LOCK_OPS(write, rwlock_t);
>  
>  #endif /* CONFIG_PREEMPT */
>  
> --- linux/include/asm-i386/spinlock.h.orig
> +++ linux/include/asm-i386/spinlock.h
> @@ -15,7 +15,7 @@ asmlinkage int printk(const char * fmt, 
>   */
>  
>  typedef struct {
> -	volatile unsigned int lock;
> +	volatile unsigned int slock;
>  #ifdef CONFIG_DEBUG_SPINLOCK
>  	unsigned magic;
>  #endif
> @@ -43,7 +43,7 @@ typedef struct {
>   * We make no fairness assumptions. They have a cost.
>   */
>  
> -#define spin_is_locked(x)	(*(volatile signed char *)(&(x)->lock) <= 0)
> +#define spin_is_locked(x)	(*(volatile signed char *)(&(x)->slock) <= 0)
>  #define spin_unlock_wait(x)	do { barrier(); } while(spin_is_locked(x))
>  
>  #define spin_lock_string \
> @@ -83,7 +83,7 @@ typedef struct {
>  
>  #define spin_unlock_string \
>  	"movb $1,%0" \
> -		:"=m" (lock->lock) : : "memory"
> +		:"=m" (lock->slock) : : "memory"
>  
>  
>  static inline void _raw_spin_unlock(spinlock_t *lock)
> @@ -101,7 +101,7 @@ static inline void _raw_spin_unlock(spin
>  
>  #define spin_unlock_string \
>  	"xchgb %b0, %1" \
> -		:"=q" (oldval), "=m" (lock->lock) \
> +		:"=q" (oldval), "=m" (lock->slock) \
>  		:"0" (oldval) : "memory"
>  
>  static inline void _raw_spin_unlock(spinlock_t *lock)
> @@ -123,7 +123,7 @@ static inline int _raw_spin_trylock(spin
>  	char oldval;
>  	__asm__ __volatile__(
>  		"xchgb %b0,%1"
> -		:"=q" (oldval), "=m" (lock->lock)
> +		:"=q" (oldval), "=m" (lock->slock)
>  		:"0" (0) : "memory");
>  	return oldval > 0;
>  }
> @@ -138,7 +138,7 @@ static inline void _raw_spin_lock(spinlo
>  #endif
>  	__asm__ __volatile__(
>  	
	spin_lock_string
> -		:"=m" (lock->lock) : : "memory");
> +		:"=m" (lock->slock) : : "memory");
>  }
>  
>  static inline void _raw_spin_lock_flags (spinlock_t *lock, unsigned long flags)
> @@ -151,7 +151,7 @@ static inline void _raw_spin_lock_flags 
>  #endif
>  	__asm__ __volatile__(
>  		spin_lock_string_flags
> -		:"=m" (lock->lock) : "r" (flags) : "memory");
> +		:"=m" (lock->slock) : "r" (flags) : "memory");
>  }
>  
>  /*
> @@ -186,7 +186,17 @@ typedef struct {
>  
>  #define rwlock_init(x)	do { *(x) = RW_LOCK_UNLOCKED; } while(0)
>  
> -#define rwlock_is_locked(x) ((x)->lock != RW_LOCK_BIAS)
> +/**
> + * read_is_locked - would read_trylock() fail?
> + * @lock: the rwlock in question.
> + */
> +#define read_is_locked(x) (atomic_read((atomic_t *)&(x)->lock) <= 0)
> +
> +/**
> + * write_is_locked - would write_trylock() fail?
> + * @lock: the rwlock in question.
> + */
> +#define write_is_locked(x) ((x)->lock != RW_LOCK_BIAS)
>  
>  /*
>   * On x86, we implement read-write locks as a 32-bit counter
> --- linux/kernel/exit.c.orig
> +++ linux/kernel/exit.c
> @@ -861,8 +861,12 @@ task_t fastcall *next_thread(const task_
>  #ifdef CONFIG_SMP
>  	if (!p->sighand)
>  		BUG();
> +#ifndef write_is_locked
> +# warning please implement read_is_locked()/write_is_locked()!
> +# define write_is_locked rwlock_is_locked
> +#endif
>  	if (!spin_is_locked(&p->sighand->siglock) &&
> -				!rwlock_is_locked(&tasklist_lock))
> +				!write_is_locked(&tasklist_lock))
>  		BUG();
>  #endif
>  	return pid_task(p->pids[PIDTYPE_TGID].pid_list.next, PIDTYPE_TGID);
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--------------------------------------------------
Darren Williams <dsw AT gelato.unsw.edu.au>
Gelato@UNSW <www.gelato.unsw.edu.au>
--------------------------------------------------
