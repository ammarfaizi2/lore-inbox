Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269742AbSISCBw>; Wed, 18 Sep 2002 22:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269745AbSISCBw>; Wed, 18 Sep 2002 22:01:52 -0400
Received: from dp.samba.org ([66.70.73.150]:26498 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S269742AbSISCBv>;
	Wed, 18 Sep 2002 22:01:51 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, anton@samba.org
Subject: Re: [PATCH] In-kernel module loader 3/7 
In-reply-to: Your message of "Thu, 19 Sep 2002 01:07:16 +0200."
             <Pine.LNX.4.44.0209190042370.8911-100000@serv> 
Date: Thu, 19 Sep 2002 12:05:05 +1000
Message-Id: <20020919020654.A70802C07C@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0209190042370.8911-100000@serv> you write:
> Hi,
> 
> On Wed, 18 Sep 2002, Rusty Russell wrote:
> 
> > +/* Stopping interrupts faster than atomics on many archs (and more
> > +   easily optimized if they're not) */
> > +static inline void bigref_inc(struct bigref *ref)
> > +{
> > +	unsigned long flags;
> > +	struct bigref_percpu *cpu;
> > +
> > +	local_irq_save(flags);
> > +	cpu = &ref->ref[smp_processor_id()];
> > +	if (likely(!cpu->slow_mode))
> > +		cpu->counter++;
> 
> Did you benchmark this? On most UP machines an inc/dec should be cheaper
> than irq enable/disable.

Oops, I forgot to test that: I had both implementations.

Doing a million loop (so there's loop overhead):

	350MHz dual Pentium II, atomic is almost twice as fast
	PPC 500MHz G4: atomic is 3.5 times as fast.
	Power3 4-way 375MHz machine: atomic is 10% faster.
	Power4 4-way 1.3GHz machine: atomic was 20% slower (depending
	       on version if irq_restore).

I suspect a P4 might get similar pro-irq results (code below,
anyone?)

Ideally we'd have a "local_inc()" and "local_dec()".  Architectures
which do soft interrupts enabling should see a real win from the
save/restore version.

Meanwhile, I'll revert to atomics, since it's sometimes dramatically
faster.

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

static void test(void)
{
	struct timeval start, end;
	atomic_t x;
	unsigned int tmp, i, diff;
	unsigned long flags;

	/* Atomic test. */
	atomic_set(&x, 0);
	do_gettimeofday(&start);
	for (i = 0; i < 1000000; i++)
		atomic_dec(&x);
	do_gettimeofday(&end);

	diff = (end.tv_sec - start.tv_sec) * 1000000
		+ (end.tv_usec - start.tv_usec);
	
	printk("Atomic test: %u usec\n", diff);

	/* Interrupt test (interrupts enabled) */
	tmp = 0;
	do_gettimeofday(&start);
	for (i = 0; i < 1000000; i++) {
		local_irq_save(flags);
		tmp++;
		local_irq_restore(flags);
	}
	do_gettimeofday(&end);

	diff = (end.tv_sec - start.tv_sec) * 1000000
		+ (end.tv_usec - start.tv_usec);
	
	printk("Interrupt test: %u usec\n", diff);

	/* Interrupt test (interrupts disabled) */
	tmp = 0;
	local_irq_disable();
	do_gettimeofday(&start);
	for (i = 0; i < 1000000; i++) {
		local_irq_save(flags);
		tmp++;
		local_irq_restore(flags);
	}
	do_gettimeofday(&end);
	local_irq_enable();

	diff = (end.tv_sec - start.tv_sec) * 1000000
		+ (end.tv_usec - start.tv_usec);
	
	printk("Interrupt test (interrupts disabled): %u usec\n", diff);
}
