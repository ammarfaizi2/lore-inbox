Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269640AbUINSGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269640AbUINSGL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 14:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269648AbUINSCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 14:02:12 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:10411 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S269603AbUINRxc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 13:53:32 -0400
Date: Tue, 14 Sep 2004 10:49:41 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: john stultz <johnstul@us.ibm.com>
cc: george anzinger <george@mvista.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       Ulrich.Windl@rz.uni-regensburg.de, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       jimix@us.ibm.com, keith maanthey <kmannth@us.ibm.com>,
       greg kh <greg@kroah.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v.A0)
In-Reply-To: <1095114307.29408.285.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.58.0409141045370.6963@schroedinger.engr.sgi.com>
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
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a rev on the concept of a time source subsystem taking into
account some of the feedback:

1. add mask
2. rename time source so that its different from xtime
3. provide set_time functionality
4. add monotonic time support
5. Give some example of time sources including a function time source.

note that the original concept already includes the ability to switch time
sources. I would think that this would be necessary especially if the CPU
time sources frequency switches or if the system goes into sleep mode.

/****************************************************************
 * A concept for a new timer module
 * V2
 *
 * Christoph Lameter, September 14, 2003
 ***************************************************************/

struct time_source_t {
	u8 type;
	u8 shift;
	u32 multiply;
	void *address;
	u64 mask;
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

u64 time_source_to_ns(u64 x) {
	return (((x-time_source_at_base) & time_source->mask)*time_source->multiply) >> time_source->shift;
}

inline u64 now(void) {
	u64 t;
	unsigned long seq;

	do {
		seq = read_seqbegin(&time_lock);
		t = time_base + time_source_to_ns(time_source_get(time_source));
	} while (unlikely(seq_retry(&time_lock,seq)));
	return t;
}

#define now_mono() (now()+time_mono_offset)

/* Time adjustment (only possible forward, to go backwards adjust time_source->multiply and wait ...) */
void time_adjust_skip(u64 ns) {
	u64 c;

	write_seqlock(&time_lock);
	c = time_source_get(time_source);
	time_base += ns + time_source_to_ns(c);
	time_source_at_base = c;
	write_sequnlock(&time_lock);
}

void time_adjust_slower(void) {
	u64 c;

	write_seqlock(&time_lock);
	c = time_source_get(time_source);
	time_base += time_source_to_ns(c);
	time_source_at_base = c;
	time_source->multiply--;
	write_sequnlock(&time_lock);
}

void time_adjust_faster(void) {
	u64 c;

	write_seqlock(&time_lock);
	c = time_source_get(time_source);
	time_base += time_source_to_ns(c);
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

	time_base += time_source_to_ns(c_old);

	time_source_at_base = c_new;
	time_source = s;

	write_sequnlock(&time_lock);
}

struct time_source_t *make_time_source(u64 freq, int t,void *a, int bits) {
	struct time_source_t *s = kmalloc(sizeof(struct time_source_t));

	s->shift = 64 - bits;
	s->multiply = (NSEC_PER_SEC << s->shift) / freq;
	s->address = a;
	s->type = t;
	s->mask = 1 << bits -1;
}

void time_set(u64 ns) {
	u64 c;

	write_seqlock(&time_lock);
	c = time_source_get(time_source);
	/* Adjust monotonic time base */
	time_mono_offset += time_base + time_source_to_ns(c) - ns;
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

/* Exampe of a CPU time time source */

	make_time_source(1200000000, TIME_SOURCE_CPU, NULL, 44);

/* A memory based time source at 20Mhz 55 bits wide */

	make_time_source(20000000, TIME_SOURCE_MMIO64, &my_timer_address, 55);

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

	make_time_source(1200000000, TIME_SOURCE_FUNCTION, cpu_time_filtered, 44);
