Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265542AbSJSD2d>; Fri, 18 Oct 2002 23:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265543AbSJSD2d>; Fri, 18 Oct 2002 23:28:33 -0400
Received: from ns.suse.de ([213.95.15.193]:50696 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265542AbSJSD2b>;
	Fri, 18 Oct 2002 23:28:31 -0400
To: Jim Houston <jim.houston@attbi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: POSIX clocks & timers - more choices
References: <200210190252.g9J2quf16153@linux.local.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 19 Oct 2002 05:34:32 +0200
In-Reply-To: Jim Houston's message of "19 Oct 2002 04:58:00 +0200"
Message-ID: <p73r8ennltj.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Houston <jim.houston@attbi.com> writes:

> +struct id_layer {
> +	unsigned int	bitmap: (1<<ID_BITS);

The bitfield is a bit weird here and the compiler will pad the
field anyways always to unsigned int because of the aligned
pointer next. It could potentially generate bad code.
What's the rationale ?

> +	struct id_layer	*ary[1<<ID_BITS];

> +void *id_lookup(struct id *idp, int id);
> +int id_new(struct id *idp, void *ptr);
> +void id_remove(struct id *idp, int id);
> +void id_init(struct id *idp, int min_wrap);

Looks a bit like namespace pollution. Perhaps a bit more descriptive
names ? 

> +{
> +	if (p->ary[bit] && p->ary[bit]->bitmap == (typeof(p->bitmap))-1)

Without bitfield this would look much less weird.

I would recommend using the bitops.h primitives for such stuff anyways.

> + * Since we can't allocate memory with spinlock held and dropping the
> + * lock to allocate gets ugly keep a free list which will satisfy the
> + * worst case allocation.
> + */
> +
> +struct id_layer *id_free;
> +int id_free_cnt;
> +
> +static inline struct id_layer *alloc_layer(void)
> +{

Standard way would be a mempool. Or better
preallocation before you get the locks.
> +	if (id <= 0)
> +		return(NULL);
> +	id--;
> +	spin_lock_irq(&id_lock);

Shouldn't this be irqsave ? Otherwise there could be hard to track
down bugs later with this code turning on interrupts for other code
by accident.

Overall I'm not sure all this radix tree stuff is worth the overhead
and code complexity. Is just a bitmap with find_first_bit() and
a last hit cache too slow ? How many timers do you expect to maintain ?

It looks like a similar problem to what kernel/pid.c does. If you're
really determined to have an complicated implementation I would 
recommend seeing if you could share code with that.

> +struct k_clock {
> +	struct timer_pq	pq;
> +	int  res;			/* in nano seconds */

Hopefully it never overflows.

> +		default:
> +			printk(KERN_WARNING "sending signal failed: %d\n", ret);

printk should be removed or at least rate limited, because it could
make the system unusable

> +/*
> + * For some reason mips/mips64 define the SIGEV constants plus 128.  
> + * Here we define a mask to get rid of the common bits.	 The 
> + * optimizer should make this costless to all but mips.
> + */
> +#if (ARCH == mips) || (ARCH == mips64)
> +#define MIPS_SIGEV ~(SIGEV_NONE & \
> +		      SIGEV_SIGNAL & \
> +		      SIGEV_THREAD &  \
> +		      SIGEV_THREAD_ID)
> +#else
> +#define MIPS_SIGEV (int)-1
> +#endif


This definitely needs to be cleaned up.


> +{
> +	struct task_struct * rtn = current;
> +
> +	if (event->sigev_notify & SIGEV_THREAD_ID & MIPS_SIGEV ) {
> +		if ( !(rtn = 
> +		       find_task_by_pid(event->sigev_notify_thread_id)) ||

Are you holding any locks or how do you make sure rtn doesn't go away ?


> +
> +
> +static struct k_itimer * alloc_posix_timer(void)
> +{
> +	struct k_itimer *tmr;
> +	tmr = kmem_cache_alloc(posix_timers_cache, GFP_KERNEL);
> +	memset(tmr, 0, sizeof(struct k_itimer));

Needs a NULL check.


Overall your code looks like overkill to me. I think it would 
be better to start with a simple implementation and only add
all the complicated data structures if it should really be a
bottle neck in some real world load. It also needs some cleanup
to remove dead code etc.


-Andi
