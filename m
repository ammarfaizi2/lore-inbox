Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265351AbSLIM1A>; Mon, 9 Dec 2002 07:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265382AbSLIM1A>; Mon, 9 Dec 2002 07:27:00 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:36346 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S265351AbSLIM05>;
	Mon, 9 Dec 2002 07:26:57 -0500
Message-ID: <3DF48DBC.5A76CF6E@mvista.com>
Date: Mon, 09 Dec 2002 04:34:04 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@transmeta.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] High-res-timers part 3 (posix to hrposix) take 20
References: <3DB9A314.6CECA1AC@mvista.com> <3DF2F965.59D7CD84@mvista.com> <3DF3D706.977AC5BB@digeo.com> <3DF4487C.67FD90EF@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote:
> 
> Andrew Morton wrote:
> >
> > george anzinger wrote:
> > >
> > > --- linux-2.5.50-bk7-kb/include/linux/id_reuse.h        Wed Dec 31 16:00:00 1969
> > > +++ linux/include/linux/id_reuse.h      Sat Dec  7 21:37:58 2002
> >
> > Maybe I'm thick, but this whole id_resue layer seems rather obscure.
> >
> > As it is being positioned as a general-purpose utility it needs
> > API documentation as well as a general description.
> 
> Hm... This whole thing came up to solve and issue related to
> having a finite number of timers.  The ID layer is just a
> way of saving a pointer to a given "thing" (a timer
> structure in this case) in a way that it can be recovered
> quickly.  It is really just a tree structure with 32
> branches (or is it sizeof long branches) at each node.
> There is a bit map to indicate if any free slots are
> available and if so under which branch.  This makes
> allocation of a new ID quite fast.  The "reuse" thing is
> there to separate it from the original code which
> "attempted" to not reuse and ID for some time.
> >
> > > +extern inline void update_bitmap(struct idr_layer *p, int bit)
> >
> > Please use static inline, not extern inline.  If only for consistency,
> > and to lessen the amount of stuff which needs to be fixed up by those
> > of us who like to use `-fno-inline' occasionally.
> 
> OK, no problem.
> >
> > > +extern inline void update_bitmap_set(struct idr_layer *p, int bit)
> >
> > A lot of the functions in this header are too large to be inlined.
> 
> Hm...  What is "too large", i.e. how much code.  Also, is it
> used more than once?  I will look at this.
> >
> > > +extern inline void idr_lock(struct idr *idp)
> > > +{
> > > +       spin_lock(&idp->id_slock);
> > > +}
> >
> > Please, just open-code the locking.  This simply makes it harder to follow the
> > main code.
> 
> But makes it easy to change the lock method, to, for
> example, use irq or irqsave or "shudder" RCU.

Oh, I forgot, I needed to export the locking but did not
want to export the structure details.  See lock_timer() in
posix_timers.c (in the same patch which should by the POSIX
timers patch, sigh).
> >
> > > +
> > > +static struct idr_layer *id_free;
> > > +static int id_free_cnt;
> >
> > hm.  We seem to have a global private freelist here.  Is the more SMP-friendly
> > slab not suitable?
> 
> There is a short local free list to avoid calling slab with
> a spinlock held.  Only enough entries are kept to allocate a
> new node at each branch from the root to leaf, and only for
> this reason.

Oh, and yes, you are right, this should be a private free
list.  I will move it inside the structure...

Thanks, good find.

-g
> >
> > > ...
> > > +static int sub_alloc(struct idr_layer *p, int shift, void *ptr)
> > > +{
> > > +       int bitmap = p->bitmap;
> > > +       int v, n;
> > > +
> > > +       n = ffz(bitmap);
> > > +       if (shift == 0) {
> > > +               p->ary[n] = (struct idr_layer *)ptr;
> > > +               __set_bit(n, &p->bitmap);
> > > +               return(n);
> > > +       }
> > > +       if (!p->ary[n])
> > > +               p->ary[n] = alloc_layer();
> > > +       v = sub_alloc(p->ary[n], shift-IDR_BITS, ptr);
> > > +       update_bitmap_set(p, n);
> > > +       return(v + (n << shift));
> > > +}
> >
> > Recursion!
> 
> Yes, it is a tree after all.
> >
> > > +void idr_init(struct idr *idp)
> >
> > Please tell us a bit about this id layer: what problems it solves, how it
> > solves them, why it is needed and why existing kernel facilities are
> > unsuitable.
> >
> The prior version of the code had a CONFIG option to set the
> maximum number of timers.  This caused enough memory to be
> "compiled" in to keep pointers to this many timers.  The ID
> layer was invented (by Jim Houston, by the way) to eliminate
> this CONFIG thing.  If I were to ask for a capability from
> slab that would eliminate the need for this it would be the
> ability to, given an address and a slab pool, to validate
> that the address was "live" and from that pool.  I.e. that
> the address is a pointer to currently allocated block from
> that memory pool.  With this, I could just pass the address
> to the user as the timer_id.  As it is, I need a way to give
> the user a handle that he can pass back that will allow me
> to quickly find his timer and, along the way, validate that
> he was not spoofing, or just plain confused.
> 
> So what the ID layer does is pass back an available <id>
> (which I can pass to the user) while storing a pointer to
> the timer which is <id>ed.  Later, given the <id>, it passes
> back the pointer, or NULL if the id is not in use.
> 
> As I said above, the pointers are kept in "nodes" of 32
> along with a few bits of overhead, and these are arranged in
> a dynamic tree which grows as the number of allocated timers
> increases.  The depth of the tree is 1 for up to 32 , 2 for
> up to 1024, and so on.  The depth can never get beyond 5, by
> which time the system will, long since, be out of memory.
> At this time the leaf nodes are release when empty but the
> branch nodes are not.  (This is an enhancement saved for
> later, if it seems useful.)
> 
> I am open to a better method that solves the problem...
> 
> --
> George Anzinger   george@mvista.com
> High-res-timers:
> http://sourceforge.net/projects/high-res-timers/
> Preemption patch:
> http://www.kernel.org/pub/linux/kernel/people/rml
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
