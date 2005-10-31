Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbVJaOP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbVJaOP0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 09:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbVJaOP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 09:15:26 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:31405 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S932108AbVJaOP0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 09:15:26 -0500
Subject: Re: [patch 1/14] s390: statistics infrastructure.
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mschwid2@de.ibm.com
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OFF65B1AC3.67015638-ONC12570AB.00340CB7-C12570AB.0054A095@de.ibm.com>
From: Martin Peschke3 <MPESCHKE@de.ibm.com>
Date: Mon, 31 Oct 2005 15:15:21 +0100
X-MIMETrack: Serialize by Router on D12ML067/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 31/10/2005 15:15:23
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

> I agree with Christoph on this: please present it as a Kconfigurable
> generic option

Sure. Scanning through the kernel configuration with menuconfig, I see
several options:
  general setup,
  library routines,
  profiling support,
  device drivers (the most obvious potential exploiters,
                  though not the only ones),
  kernel hacking.
Please advise.

> and flesh out the changelog a bit.  If the documentation
> in the source file isn't sufficient, consider a Documentation/ file too,
> please.

A Documentation/ file will be in included in the patch next time.

There is some PDF with figures in the works. But I love the idea of a
Documentation/ file because it might be more helpful for lkml reviews.
I think I will manage to steal the most interesting text passages from
the unfinished PDF.

The source code documentation is propably fine for understanding the API
(comments welcome). But it falls short of explaining why this abstraction
makes sense, its concepts, as well as the user interface.

> Use gfp_t throughout.

will do

> Can we use EXPORT_SYMBOL_GPL throughout?

sure

> > +
> > +/**
> > + * sgrb_seg_release_all - releases scatter-gather buffer
> > + * @lh: list_head that holds list of scattered buffer parts
> > + */
> > +void
> > +sgrb_seg_release_all(struct list_head *lh)
>
> Coding style nit: please do
>
> void sgrb_seg_release_all(struct list_head *lh)
>
> as per the rest of the core kernel.

I will change it in all places.

> (If we end up deciding to keep all this in arch/s390 then I guess
> we can live with s390 peculiarities though)

I will be happy to see some feature like this included outside arch/s390.
What is about lib/, or kernel/?

> > +        list_for_each_entry(seg, &rb->seg_lh, list)
> > +                    break;
>
> eh?   Something's gone rather wrong here.

Intention here is to find the entry at the list's head.
Should work, though it might look fishy at first sight.
A substitute for this construct would look like this:

   seg = list_entry(rb->seg_lh.next, struct sgrb_seg, list);

I don't feel very comfortably messing with pointers inside struct
list_head. I know many people don't object. But IMHO the next and prev
pointers look like implementation specifics of list heads that are nicely
abstracted away for almost any purpose by list_for_each() and friends -
with the exception of something like the above.

Anyway, I will change these and similar lines if you want me to.

> > +/**
> > + * sgrb_produce_nooverwrite - put an entry into the ringbuffer
> > + *     if there is room whithout the need to overwrite the oldest
>
> spello

Thanks. Will fix it along with a few more that have gone unnoticed so far.

> > +/**
> > + * sgrb_consume_delete - get an entry from the ringbuffer and
> > + *     delete the entry from the ringbuffer so that it can't
> > + *     be consumed twice, and in order to free up its slot for
> > + *     another entry
> > + *
> > + * @rb: the ringbuffer to use
> > + *
> > + * Returns address of the entry read, if there is an entry available.
> > + * Returns NULL otherwise.
> > + **/
> > +void *
> > +sgrb_consume_delete(struct sgrb *rb)
> > +{
> > +        struct sgrb_ptr prev;
> > +
> > +        if (!sgrb_ptr_valid(&rb->first))
> > +                    return NULL;
> > +        sgrb_ptr_copy(&prev, &rb->first);
> > +        if (sgrb_ptr_identical(&rb->last, &rb->first))
> > +                    sgrb_init(rb);
> > +        else
> > +                    sgrb_next_entry(rb, &rb->first, &rb->first);
> > +        rb->entries--;
> > +        return sgrb_entry(&prev);
> > +}
> > +EXPORT_SYMBOL(sgrb_consume_delete);
>
> I guess all of these functions require caller-provided locking, and
> that's documented somewhere?

You are right. I tend to explain the (simple) locking rules in a comment
at the head of sgrb.c.

I don't think it would be beneficial to do locking inside these
functions, because exploiters most likely do some locking anyway.

This ringbuffer abstraction is actually a separate feature, the only
exploiter of which, for now, is the statistics layer. I see at least
one other piece of code that could be cleaned up using sgrb.c. It might
make sense to have a separate patch for the ringbuffer implementation.

I think this code should go into lib/.

> > +
> > +extern void tod_to_timeval(__u64, struct timespec *);
>
> Please don't put extern decls in .c files - put them in a header file.

I agree. Will discuss this with Martin Schwidefsky, because it would be one
of the header files he maintains.

> > +static inline void
> > +statistic_nsec_to_timespec(u64 nsec, struct timespec *xtime)
> > +{
> > +        unsigned long long sec;
> > +
> > +        sec = nsec;
> > +        do_div(sec, 1000000000);
> > +        xtime->tv_sec = sec;
> > +        xtime->tv_nsec = nsec - sec * 1000000000;
> > +}
> > +
> > +static inline u64
> > +statistic_timespec_to_nsec(struct timespec *xtime)
> > +{
> > +        return (xtime->tv_sec * 1000000000 + xtime->tv_nsec);
> > +}
>
> Maybe these should be put in jiffies.h.

Agreed. I don't want this stuff to stay in my code. There are other places
in drivers/s390/scsi/ and arch/s390/kernel which do similar things.
It doesn't belong in there either.
Another issue to tackle together with Martin Schwidefsky.

> It's a lot of code, and it'll be some work to make it generic.

Well, I hope it's not too difficult. It's - intentionally - neither
architecture specific nor device driver specific.
I guess additional work would be mostly concerned with covering
additional requirements of other potential exploiters.

And I assume that the most controversial part will be the user interface.
That seems to be a candidate for changes in my eyes, although I am
satisfied with it by and large with regard to the exploiting device
driver.

> Can you help us decide whether there's actually any point in making
> it generic?
> What problems was it designed to solve, and what additional
> problems might it all be useful for?

I am convinced that its worthwile to provide some statictics facility
for any device driver programmer or whoever thinks about implementing
statistics for his devices or algorithms.

We have got statistics in the dasd driver, some networking interface
drivers, plus rudimentary stuff in the old 2.4 zfcp driver (all s390),
for example. So far we have been reinventing the wheel every time.
Bad. I bet there are other examples scattered throughout the kernel.

The current code is good enough for zfcp, while it is intended to be
a starting point for a generic solution at the same time, if people
are interested.

My initial plan was to find another exploiter in s390 land and make
adaptions if required. But actually it doesn't matter whether early
feedback comes from a s390 device driver developer or a PCI
device driver developer, for example. It's fine with me to go ahead
and find out how this piece of code fits into the kernel in general.

I see several advantages of a generic approach:

clean design:
There is no point in coming up with another user interface and
new algorithms for data processing for every device driver that
is going to implement statistics. Actual semantics of the data that
feeds a statistic is unimportant when it comes to data processing.
All that matters is how the user wants the data to be presented
(counters, histograms, and so on). That's something that can be dealt
with by a generic layer without intervention by the device driver
being the source of data.
Its like a cow giving milk. Everytime some milk has been gathered
it is rushed to the dairy. Its not the cows business to worry about
the various products made of milk and how these products are packaged
and delivered. Nor is it the business of sheep or goat, for that
matter. Its a question of customer demand observed by the dairy
whether milk is sold as cheese, yogurt, cream,... or simply milk.

reduced development and test effort:
Once the generic layer was almost finished (using a test module),
implementation and test of an assortment of statistics for the zfcp
driver took me about 2 days. I spend more time evaluating which
statistics make sense and which don't than coding the device driver
extension. By not putting the statistics code into the device driver,
I separated about 90 percent of it out into a reusable layer, which
has seen some testing that the next exploiter can rely on.
This makes it also cheap to put private patches for performance
debugging purposes together which can be thrown away once the
performance problem is understood.

common user interface:
Once a user has learned to read and adjust statistics of component A
they will have little or no problems applying this knowledge to
statistics of component B.
Besides, I can imagine a single script that would suffice to generate
input for the spreadsheet program of your choice from statistics output
of any component.

lots of features commonly available:
The generic layer provides a superset of features of the
"reinventing the wheel"-statistics I am aware of. This includes many
ways data processing can be done. It's all there for everbody.
It also means plenty of flexibility from a users perspective, because
there are enough knobs available that make it unnecessary for me to
respond to requests like "Hey Martin, could you rebuild the zfcp module
for me, because I need a finer resolution for that latency histogram?"

Thanks,
Martin Peschke

