Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbTESWu6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 18:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263271AbTESWu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 18:50:58 -0400
Received: from palrel12.hp.com ([156.153.255.237]:27307 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S263205AbTESWur (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 18:50:47 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16073.25296.659748.225474@napali.hpl.hp.com>
Date: Mon, 19 May 2003 16:03:44 -0700
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, akpm@digeo.com, ak@muc.de,
       arjanv@redhat.com, johnstul@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: time interpolation hooks
In-Reply-To: <20030519.153758.71094061.davem@redhat.com>
References: <16069.24454.349874.198470@napali.hpl.hp.com>
	<1053139080.7308.6.camel@rth.ninka.net>
	<16073.5555.158600.61609@napali.hpl.hp.com>
	<20030519.153758.71094061.davem@redhat.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 19 May 2003 15:37:58 -0700 (PDT), "David S. Miller" <davem@redhat.com> said:

  DaveM> That's not the issue, if I have only ONE way to do this on my
  DaveM> platform, I can INLINE this thing and I DO NOT need function
  DaveM> pointers.

With the present code, an architecture does not have to use any
indirect function calls if there is only one known interpolator
(presumably based on a CPU cycle counter).  The only extra overhead is
the (inlined) read of variable time_interpolator and a check against
NULL.  Is this acceptable?

For convenience, I attached the current proposal.  In the SPARC case,
you'd simply never call register_time_interpolator() and use
arch-specific code to calculate (and update) last_nsec_offset.  The
time_interpolator_update() and time_interpolator_reset() code then
take care of the rest.

	--david

#ifdef CONFIG_TIME_INTERPOLATION

struct time_interpolator {
	/* cache-hot stuff first: */
	unsigned long (*get_offset) (void);
	void (*update) (long);
	void (*reset) (void);

	/* cache-cold stuff follows here: */
	struct time_interpolator *next;
	unsigned long frequency;	/* frequency in counts/second */
	long drift;			/* drift in parts-per-million (or -1) */
};

extern volatile unsigned long last_nsec_offset;
#ifndef __HAVE_ARCH_CMPXCHG
extern spin_lock_t last_nsec_offset_lock;
#endif
extern struct time_interpolator *time_interpolator;

extern void register_time_interpolator (struct time_interpolator *);
extern void unregister_time_interpolator (struct time_interpolator *);

/* Called with xtime read- OR write-lock acquired.  */
static inline void
time_interpolator_update (long delta_nsec)
{
	struct time_interpolator *ti = time_interpolator;

	if (last_nsec_offset > 0) {
#ifdef __HAVE_ARCH_CMPXCHG
		unsigned long new, old;

		do {
			old = last_nsec_offset;
			if (old > delta_nsec)
				new = old - delta_nsec;
			else
				new = 0;
		} while (cmpxchg(&last_nsec_offset, old, new) != old);
#else
		/*
		 * This really hurts, because it serializes gettimeofday(), but without an
		 * atomic single-word compare-and-exchange, there isn't all that much else
		 * we can do.
		 */
		spin_lock(&last_nsec_offset_lock);
		{
			last_nsec_offset -= min(last_nsec_offset, delta_nsec);
		}
		spin_unlock(&last_nsec_offset_lock);
#endif
	}

	if (ti)
		(*ti->update)(delta_nsec);
}

/* Called with xtime read- or write-lock acquired.  */
static inline void
time_interpolator_reset (void)
{
	struct time_interpolator *ti = time_interpolator;

	last_nsec_offset = 0;
	if (ti)
		(*ti->reset)();
}

static inline unsigned long
time_interpolator_get_offset (void)
{
	struct time_interpolator *ti = time_interpolator;
	if (ti)
		return (*ti->get_offset)();
	return last_nsec_offset;
}

#else /* !CONFIG_TIME_INTERPOLATION */

static inline void
time_interpolator_update (long delta_nsec)
{
}

static inline void
time_interpolator_reset (void)
{
}

static inline unsigned long
time_interpolator_get_offset (void)
{
	return 0;
}

#endif /* !CONFIG_TIME_INTERPOLATION */
