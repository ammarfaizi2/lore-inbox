Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbUIOGxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUIOGxN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 02:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUIOGxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 02:53:13 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:30359 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261875AbUIOGuJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 02:50:09 -0400
Date: Tue, 14 Sep 2004 23:46:42 -0700 (PDT)
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
In-Reply-To: <41479369.6020506@mvista.com>
Message-ID: <Pine.LNX.4.58.0409142339470.11754@schroedinger.engr.sgi.com>
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com> 
 <1094159379.14662.322.camel@cog.beaverton.ibm.com>  <4137CB3E.4060205@mvista.com>
 <1094193731.434.7232.camel@cube>  <41381C2D.7080207@mvista.com> 
 <1094239673.14662.510.camel@cog.beaverton.ibm.com>  <4138EBE5.2080205@mvista.com>
  <1094254342.29408.64.camel@cog.beaverton.ibm.com>  <41390622.2010602@mvista.com>
  <1094666844.29408.67.camel@cog.beaverton.ibm.com>  <413F9F17.5010904@mvista.com>
  <1094691118.29408.102.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.58.0409082005370.28366@schroedinger.engr.sgi.com> 
 <1094700768.29408.124.camel@cog.beaverton.ibm.com>  <413FDC9F.1030409@mvista.com>
  <1094756870.29408.157.camel@cog.beaverton.ibm.com>  <4140C1ED.4040505@mvista.com>
  <Pine.LNX.4.58.0409131420500.490@schroedinger.engr.sgi.com>
 <1095114307.29408.285.camel@cog.beaverton.ibm.com>
 <Pine.LNX.4.58.0409141045370.6963@schroedinger.engr.sgi.com>
 <41479369.6020506@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

V3 of the concept for a time subsystem.
 * add a function to the time_source_t to be able to trigger the timer
   interrupt at a certain counter value instead of at regular intervals
 * function to map back from nanoseconds to counter units
 * add primitive scheduler that wakes up for timer events and
   figures out when to schedule the next event.
 * Some info at the end on how maybe have the NTP code interact with
   this stuff.

The deferral of the time_base updates actually is beneficial since it
allows a more accurate scaling of the counter and thus does not loose
remaining nanoseconds as often.

/****************************************************************
 * A concept for a new timer module
 * V3
 *
 * Christoph Lameter, September 14, 2003
 ***************************************************************/

struct time_source_t {
	u8 type;
	u8 shift;
	u32 multiply;
	void *address;
	u64 mask;
	int (*interrupt_at)(u64 counter_value);
};

#define TIME_SOURCE_CPU 0
#define TIME_SOURCE_MMIO32 1
#define TIME_SOURCE_MMIO64 2
#define TIME_SOURCE_FUNCTION 15

struct seqlock_t time_lock;	/* Protects access to time_base time_source time_mono_offset and time_source_at_base */
u64 time_base;
u64 time_mono_offset;
struct time_source_t *time_source;
u64 time_source_at_base;	/* time source value at time time_base */

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
}

/* Convert from time source units to ns */
u64 time_source_to_ns(u64 x) {
	return ((x & time_source->mask)*time_source->multiply) >> time_source->shift;
}

/* Convert from ns time to time source units */
u64 ns_to_time_source(u64 x) {
	return (x << time_source->shift ) / time_source->multiply;
}
inline u64 now(void) {
	u64 t;
	unsigned long seq;

	do {
		seq = read_seqbegin(&time_lock);
		t = time_base + time_source_to_ns(time_source_get(time_source) - time_source_at_base);
	} while (unlikely(seq_retry(&time_lock,seq)));
	return t;
}

#define now_mono() (now()+time_mono_offset)

/* Time adjustment (only possible forward, to go backwards adjust time_source->multiply and wait ...) */
void time_adjust_skip(u64 ns) {
	u64 c;

	write_seqlock(&time_lock);
	c = time_source_get(time_source);
	time_base += ns + time_source_to_ns(c - time_source_at_base);
	time_source_at_base = c;
	write_sequnlock(&time_lock);
}

void time_adjust_slower(void) {
	u64 c;

	write_seqlock(&time_lock);
	c = time_source_get(time_source);
	time_base += time_source_to_ns(c - time_source_at_base);
	time_source_at_base = c;
	time_source->multiply--;
	write_sequnlock(&time_lock);
}

void time_adjust_faster(void) {
	u64 c;

	write_seqlock(&time_lock);
	c = time_source_get(time_source);
	time_base += time_source_to_ns(c - time_source_at_base);
	time_source_at_base = c;
	time_source->multiply++;
	write_sequnlock(&time_unlock);
}

/* Switch to another time source */
void new_time_source(struct time_source_t *s) {
	u64 c_old;
	u64 c_new;

	write_seqlock(&time_lock);
	c_old = time_source_get(time_source);
	c_new = time_source_get(s);

	time_base += time_source_to_ns(c_old - time_source_at_base);

	time_source_at_base = c_new;
	time_source = s;

	write_sequnlock(&time_lock);
}

struct time_source_t *make_time_source(u64 freq, int t,void *a, int bits, void *i) {
	struct time_source_t *s = kmalloc(sizeof(struct time_source_t));

	s->shift = 64 - bits;
	s->multiply = (NSEC_PER_SEC << s->shift) / freq;
	s->address = a;
	s->type = t;
	s->mask = 1 << bits -1;
	s->interrupt_at = i;
}

void time_set(u64 ns) {
	u64 c;

	write_seqlock(&time_lock);
	c = time_source_get(time_source);
	/* Adjust monotonic time base */
	time_mono_offset += time_base + time_source_to_ns(c - time_source_at_base) - ns;
	/* Setup new time base */
	time_base = ns;
	time_source_at_base = c;
	write_sequnlock(&time_lock);
}

void time_init(struct time_source_t *s) {
{
	write_seqlock(&time_lock);
	time_base = 0;
	time_mono_offset = 0;
	time_source_at_base = time_source_get(s);
	time_source = s;
	write_sequnlock(&time_lock);
}

/* Values in use in the kernel and how they may be derived from xtime */
#define jiffies (now() * HZ /1000000000)
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

/* Exampe of a CPU time time source */
	int itm_setup(u64 counter) {
		set_itm(counter);
		return 1;	/* Success */
	}

	make_time_source(1200000000, TIME_SOURCE_CPU, NULL, 44,itm_setup);

/* A memory based time source at 20Mhz 55 bits wide, no ability to fire an interrupt */

	make_time_source(20000000, TIME_SOURCE_MMIO64, &my_timer_address, 55, NULL);

/* Example of handling a difficult time source. In SMP systems the CPU time sources are notoriously difficult to
 * sync. If we have such a problem  then insure at least sure that the time source never goes backward.
 */

u64 time_source_last;

u64 get_cpu_time_filtered() {
	u64 x;
	u64 l;

	do {
		l = time_source_last;
		x = cycles();
		if (x<l) return l;
		/* the cmpxchg is going to hurt in terms of scalability ! */
	} while (cmpxchg(&time_source_last, l, x) != l);
	return x;
}

Generate the time_source with

	make_time_source(1200000000, TIME_SOURCE_FUNCTION, cpu_time_filtered, 44, itm_setup);


/* event scheduler to be able to run events at specific times */

struct event {
	u64 when;
	u64 param;
	void (*run)(u64);
	struct event next;
}

struct event *event_queue;

void event_run(void) {
	u64 t;

	spin_lock(event_handler);
	t = now();
redo:
	/* Run all events scheduled before now */
	while (event_queue && event_queue->when <= t) {
		struct event *e=event_queue;

		e->run(e->param);
		event_queue = e->next;
		kfree(e);
	}
	if (event_queue = NULL) {
		spin_unlock(event_handler);
		return;
	}
	t = now();
	d = t - event_queue->when;
	if (d<= 0) goto retry;

	time_source->interrupt_at(time_source_at_base + ns_to_time_source(event_queue->when - time_base));
	spin_unlock(event_handler);
}

void event_new(u64 w,void (*r)(u64), u64 p) {
	struct event *e=kmalloc(sizeof(struct event));

	e->when =w;
	e->param = p;
	e->run = r;
	spin_lock(event_handler);
	if (event_queue) {
		/* Insert time event at the appropriate time */
		struct event *p = event_queue;
		while (p->next && p->next->w < w) p = p->next;
		e->next = p->next;
		p->next = e;
	} else
		event_queue=e;
	spin_unlock(event_handler);
	event_run();
}

void scheduled_timer_interrupt(void) {
	event_run();
}

/* simulation of the old tick behavior */
tick(u64 when) {
	/* do tick stuff */

	/* time base update .... */
	time_source_adjust(0);
	/* Schedule next timer tick */
	event_new(when + NSEC_PER_SEC / HZ , tick,  when + NSEC_PER_SEC / HZ);
}

/* New tick would be scheduled by the ntp logic when a correction is needed.
 * ntp logic needs to decide when to skip a few nanosecond or slow down the clock or
 * make the clock run faster.
 * One way to do this is to accumulate a time difference to real time.
 * if this time difference is small and positive then skip time forward a bit.
 * if the time difference is negative then slow down the clock.
 * if the time difference is way too high then accelerate the clock
 */


