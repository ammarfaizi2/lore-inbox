Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265532AbSJSGet>; Sat, 19 Oct 2002 02:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265533AbSJSGet>; Sat, 19 Oct 2002 02:34:49 -0400
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:38095 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S265532AbSJSGeq>; Sat, 19 Oct 2002 02:34:46 -0400
Message-ID: <3DB0FE5B.5BAA2BDB@attbi.com>
Date: Sat, 19 Oct 2002 02:40:27 -0400
From: Jim Houston <jim.houston@attbi.com>
Reply-To: jim.houston@attbi.com
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: POSIX clocks & timers - more choices
References: <200210190252.g9J2quf16153@linux.local.suse.lists.linux.kernel> <p73r8ennltj.fsf@oldwotan.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> Jim Houston <jim.houston@attbi.com> writes:
> 
> > +struct id_layer {
> > +     unsigned int    bitmap: (1<<ID_BITS);
> 
> The bitfield is a bit weird here and the compiler will pad the
> field anyways always to unsigned int because of the aligned
> pointer next. It could potentially generate bad code.
> What's the rationale ?
> 

Hi Andi,

Thanks for the review.  I will try to answer your questions 
as inline.

The idea of declaring the bitmap with a field width was to
give an error if ID_BITS was made larger than the sizeof(int).
It would probably make more sense to set ID_BITS from
sizeof(int) or use an array for the bitmap and allow an
arbitrary value.

> > +     struct id_layer *ary[1<<ID_BITS];
> 
> > +void *id_lookup(struct id *idp, int id);
> > +int id_new(struct id *idp, void *ptr);
> > +void id_remove(struct id *idp, int id);
> > +void id_init(struct id *idp, int min_wrap);
> 
> Looks a bit like namespace pollution. Perhaps a bit more descriptive
> names ?

Coming up with good names is always hard.  Here is what they mean
what should they be called?

id_lookup - returns a pointer associated with an id value.
id_new - allocates a new id.  It returns the id and  
	saves the poiner in its data structure.
id_remove - frees the id and breaks the association between 
	the id and the pointer.
id_init - Initializes a "struct id" which is the basis for
	this id translation.
> 
> > +{
> > +     if (p->ary[bit] && p->ary[bit]->bitmap == (typeof(p->bitmap))-1)
> 
> Without bitfield this would look much less weird.
> 
> I would recommend using the bitops.h primitives for such stuff anyways.

I will.  This does look wierd, is this my code?

> 
> > + * Since we can't allocate memory with spinlock held and dropping the
> > + * lock to allocate gets ugly keep a free list which will satisfy the
> > + * worst case allocation.
> > + */
> > +
> > +struct id_layer *id_free;
> > +int id_free_cnt;
> > +
> > +static inline struct id_layer *alloc_layer(void)
> > +{
> 
> Standard way would be a mempool. Or better
> preallocation before you get the locks.

I prototyped this code in user space and then started thinking
about locking.  How is what I'm doing different than pre-allocating
before locking.  I would still need to lock and re-check that I
had enough data structures pre-allocated and loop.

> > +     if (id <= 0)
> > +             return(NULL);
> > +     id--;
> > +     spin_lock_irq(&id_lock);
> 
> Shouldn't this be irqsave ? Otherwise there could be hard to track
> down bugs later with this code turning on interrupts for other code
> by accident.

My assumption is that the id stuff would only be used from
code where I know interrupts are enabled. Saving the flags 
wouldn't hurt though.

> Overall I'm not sure all this radix tree stuff is worth the overhead
> and code complexity. Is just a bitmap with find_first_bit() and
> a last hit cache too slow ? How many timers do you expect to maintain ?
> 
> It looks like a similar problem to what kernel/pid.c does. If you're
> really determined to have an complicated implementation I would
> recommend seeing if you could share code with that.

When I wrote it I had hoped that it could be used for get_pid. See
my post:
http://marc.theaimsgroup.com/?l=linux-kernel&m=102916884821920&w=2

I guess the argument is that this approach is memory efficient 
and scales well for all possible id -> kernel pointer mappings.

> 
> > +struct k_clock {
> > +     struct timer_pq pq;
> > +     int  res;                       /* in nano seconds */
> 
> Hopefully it never overflows.

It better not its the resolution of the timer. Only a problem
if Hz is less than 1.

> 
> > +             default:
> > +                     printk(KERN_WARNING "sending signal failed: %d\n", ret);
> 
> printk should be removed or at least rate limited, because it could
> make the system unusable
> 
> > +/*
> > + * For some reason mips/mips64 define the SIGEV constants plus 128.
> > + * Here we define a mask to get rid of the common bits.       The
> > + * optimizer should make this costless to all but mips.
> > + */
> > +#if (ARCH == mips) || (ARCH == mips64)
> > +#define MIPS_SIGEV ~(SIGEV_NONE & \
> > +                   SIGEV_SIGNAL & \
> > +                   SIGEV_THREAD &  \
> > +                   SIGEV_THREAD_ID)
> > +#else
> > +#define MIPS_SIGEV (int)-1
> > +#endif
> 
> This definitely needs to be cleaned up.
> 
> > +{
> > +     struct task_struct * rtn = current;
> > +
> > +     if (event->sigev_notify & SIGEV_THREAD_ID & MIPS_SIGEV ) {
> > +             if ( !(rtn =
> > +                    find_task_by_pid(event->sigev_notify_thread_id)) ||
> 
> Are you holding any locks or how do you make sure rtn doesn't go away ?
> 

Good point.  It looks like  find_task_by_pid() needs to be protected
by a read_lock(&tasklist_lock).  The timers are linked into
a list so they will be removed when the process exits.  
Any sugestions on a code example that does this right are
welcome:-) 

> > +
> > +
> > +static struct k_itimer * alloc_posix_timer(void)
> > +{
> > +     struct k_itimer *tmr;
> > +     tmr = kmem_cache_alloc(posix_timers_cache, GFP_KERNEL);
> > +     memset(tmr, 0, sizeof(struct k_itimer));
> 
> Needs a NULL check.

O.K. You caught me being lazy.  I have the same problem in the 
id code as well.

> 
> Overall your code looks like overkill to me. I think it would
> be better to start with a simple implementation and only add
> all the complicated data structures if it should really be a
> bottle neck in some real world load. It also needs some cleanup
> to remove dead code etc.
> 
> -Andi

Thanks for the review.  

Jim Houston - Concurrent Computer Corp.
