Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbTESRVt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 13:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbTESRVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 13:21:49 -0400
Received: from palrel12.hp.com ([156.153.255.237]:60811 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S261844AbTESRVr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 13:21:47 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16073.5555.158600.61609@napali.hpl.hp.com>
Date: Mon, 19 May 2003 10:34:43 -0700
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@hpl.hp.com, Andrew Morton <akpm@digeo.com>, Andi Kleen <ak@muc.de>,
       Arjan van de Ven <arjanv@redhat.com>, john stultz <johnstul@us.ibm.com>,
       linux-kernel@vger.kernel.org,
       David Mosberger <davidm@napali.hpl.hp.com>
Subject: Re: time interpolation hooks
In-Reply-To: <1053139080.7308.6.camel@rth.ninka.net>
References: <20030516142311.3844ee97.akpm@digeo.com>
	<16069.24454.349874.198470@napali.hpl.hp.com>
	<1053139080.7308.6.camel@rth.ninka.net>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On 16 May 2003 19:38:01 -0700, "David S. Miller" <davem@redhat.com> said:

  DaveM> I think Andrew is really suggesting to declare these two
  DaveM> things in an arch header, so if one needs it to be a function
  DaveM> pointer one can make it so.

I don't think this should be (purely) an arch thing.  It's just as
much a driver issue.  For example, HPET will pretty much work the same
on x86 and ia64, so being able to have a shared "driver" would be
useful.  I agree though that it would be nice if arches that don't
care for time-interpolation at all could turn it off completely.
In the proposal below, an architecture could achieve that by turning
off CONFIG_TIME_INTERPOLATION.

>>>>> On Sat, 17 May 2003 09:09:51 +0000, Arjan van de Ven <arjanv@redhat.com> said:

  Arjan> I rather would have a "timer source" object that provides
  Arjan> those 2 functions as methods, so that one can write "timer"
  Arjan> drivers as more or less stand alone units that register
  Arjan> themselves with the generic timekeeping unit (probably with
  Arjan> an accuracy score so that the generic code can pick one in
  Arjan> the event of multiple timer sources).

Sounds reasonable.

To make this really possible, I think it makes the most sense to have
the last_nsec_offset variable implemented by the generic kernel.  I'm
thinking something along the lines of the below?

Comments?

	--david

struct time_interpolator {
	void (*update_wall_time) (long delta_nsec);
	void (*reset_wall_time) (long delta_nsec);
	unsigned long frequency;	/* frequency in counts/second */
	unsigned long drift;		/* drift in parts-per-million (?) */
};

extern void register_time_interpolator (struct time_interpolator *ti);
extern void unregister_time_interpolator (struct time_interpolator *ti);

#ifdef CONFIG_TIME_INTERPOLATION

extern volatile unsigned long last_nsec_offset;
extern struct time_interpolator *time_interpolator;

static inline void
update_wall_time (long delta_nsec)
{
	struct time_interpolator *ti = time_interpolator;

	/* This needs to be done atomically, either via cmpxchg() or
	   protected by a spinlock: */
	last_nsec_offset -= min(last_nsec_offset, delta_nsec);

	if (ti)
		(*ti->update_wall_time)(delta_nsec);
}

static inline void
reset_wall_time (long delta_nsec);
{
	struct time_interpolator *ti = time_interpolator;

	last_nsec_offset = 0;
	if (ti)
		(*ti->reset_wall_time)();
}

#else

static inline void
update_wall_time (long delta_nsec)
{
}

static inline void
reset_wall_time (long delta_nsec)
{
}

#endif
