Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268982AbUIMVfb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268982AbUIMVfb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 17:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268907AbUIMVfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 17:35:31 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:12264 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268982AbUIMVeN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 17:34:13 -0400
Date: Mon, 13 Sep 2004 14:29:50 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: George Anzinger <george@mvista.com>
cc: john stultz <johnstul@us.ibm.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       Ulrich.Windl@rz.uni-regensburg.de, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       jimix@us.ibm.com, keith maanthey <kmannth@us.ibm.com>,
       greg kh <greg@kroah.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v.A0)
In-Reply-To: <4140C1ED.4040505@mvista.com>
Message-ID: <Pine.LNX.4.58.0409131420500.490@schroedinger.engr.sgi.com>
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com> 
 <1094159379.14662.322.camel@cog.beaverton.ibm.com>  <4137CB3E.4060205@mvista.com>
 <1094193731.434.7232.camel@cube>  <41381C2D.7080207@mvista.com> 
 <1094239673.14662.510.camel@cog.beaverton.ibm.com>  <4138EBE5.2080205@mvista.com>
  <1094254342.29408.64.camel@cog.beaverton.ibm.com>  <41390622.2010602@mvista.com>
  <1094666844.29408.67.camel@cog.beaverton.ibm.com>  <413F9F17.5010904@mvista.com>
  <1094691118.29408.102.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.58.0409082005370.28366@schroedinger.engr.sgi.com> 
 <1094700768.29408.124.camel@cog.beaverton.ibm.com>  <413FDC9F.1030409@mvista.com>
 <1094756870.29408.157.camel@cog.beaverton.ibm.com> <4140C1ED.4040505@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm... I am still thinking that making xtime an u64 could help simplify a
lot of things. Together with some other parameters it would allow a
tickless system where there is no need to update xtime regularly. It would
also simplify gettimeofday and jiffies calculation.

In order to calculate the current time, one then has to use a counter that
started running at a certain point. The counter can be used to calculate
an offset to xtime after scaling it. It is then only necessary to update
xtime if the value calculated by xtime and the counter deviates
significantly from the real value. Then time keeping may be corrected
(after xtime has been updated, we might have handed out time before
this event and we cannot change time keeping without a new starting point
for the calculation of the offset!) by

1. Adding a number to xtime resulting in a time jump forward. This
needs to be a small number.
2. Slowing down the clock by reducing the scaling (time cannot
jump backward. This is the only way to correct the clock if its
running too fast).
3. Speeding up the clock by increasing the scaling. This would presumably
be done if the time jumps become too large.

All of this is based a lot on the work done for the time interpolator.

/****************************************************************
 * A concept for a new timer module
 *
 ***************************************************************/

struct time_source_t {
	u8 type;
	u8 shift;
	u32 multiply;
	void *address;
};

#define TIME_SOURCE_CPU 0
#define TIME_SOURCE_MMIO32 1
#define TIME_SOURCE_MMIO64 2
#define TIME_SOURCE_FUNCTION 15

struct seqlock_t xtime_lock;	/* Protects access to xtime time_source and time_source_last, may be used by
				time retrieval routines if 64 bit atomic operations are not available */
u64 xtime;
struct time_source_t *time_source;
u64 time_source_last;

u64 inline time_source_get(struct time_source_t *s) {
	switch (s->type) {
		case TIME_SOURCE_CPU	: return cycles();
		case TIME_SOURCE_MMIO32	: return readl(s->address);
		case TIME_SOURCE_MMIO64	: return readq(s->address);
		case TIME_SOURCE_FUNCTION: {
			u64 (*x)(void);
			x = s->address;
			return x();
		}
		default : return 0;
	}
}

u64 time_source_to_ns(u64 x) {
	return ((x-time_source_last)*time_source->multiply) >> time_source->shift;
}

inline u64 now(void) {
	u64 t;
	unsigned long seq;

	do {
		seq = read_seqbegin(&xtime_lock);
		t = xtime + time_source_to_ns(time_source_get(time_source));
	} while (unlikely(seq_retry(&xtime_lock,seq)));
	return t;
}

/* Time adjustment (only possible forward, to go backwards adjust time_source->multiply and wait ...) */
void time_adjust_skip(u64 ns) {
	u64 c;

	write_seqlock(&xtime_lock);
	c = time_source_get(time_source);
	xtime += ns + time_source_to_ns(c);
	time_source_last = c;
	write_sequnlock(&xtime_lock);
}

void time_adjust_slower(void) {
	u64 c;

	write_seqlock(&xtime_lock);
	c = time_source_get(time_source);
	xtime += time_source_to_ns(c);
	time_source_last = c;
	time_source->multiply--;
	write_sequnlock(&xtime_lock);
}

void time_adjust_faster(void) {
	u64 c;

	write_seqlock(&xtime_lock);
	c = time_source_get(time_source);
	xtime += time_source_to_ns(c);
	time_source_last = c;
	time_source->multiply++;
	write_sequnlock(&xtime_unlock);
}

/* Switch to another time source */
void new_time_source(struct time_source_t *s) {
	u64 c_old;
	u64 c_new;

	write_seqlock(&xtime_lock);
	c_old = time_source_get(time_source);
	c_new = time_source_get(s);

	xtime += time_source_to_ns(c_old);

	time_source_last = c_new;
	time_source = s;

	write_sequnlock(&xtime_lock);
}

struct time_source_t *make_time_source(u64 freq, int t,void *a, int bits) {
	struct time_source_t *s = kmalloc(sizeof(struct time_source_t));

	s->shift = 64 - bits;
	s->multiply = (NSEC_PER_SEC << s->shift) / freq;
	s->address = a;
	s->type = t;
}

/* Values in use in the kernel and how they may be derived from xtime */

#define jiffies (now()/1000000)
#define seconds(x) ((x)/1000000000)
#define nanoseconds_within_second(x) ((x)%1000000000)
#define microseconds_within_second(x) (nanoseconds_within_second(x) / 1000)

u32 time(void) {
	return seconds(now());
}

void gettimeofday(struct timeval *p) {
	u64 t=now();

	p->tv_sec = seconds(t);
	p->tv_usec = microseconds_within_second(t);
}

void clock_gettime(int clock, struct timespec *p) {
	u64 t=now();

	p->tv_sec = seconds(t);
	p->tv_nsec = nanoseconds_within_second(t);
}

