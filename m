Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269523AbUICBsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269523AbUICBsi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 21:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269540AbUICBsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 21:48:17 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:57850 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S269523AbUICBnw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 21:43:52 -0400
Message-ID: <4137CB3E.4060205@mvista.com>
Date: Thu, 02 Sep 2004 18:39:10 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       albert@users.sourceforge.net, Ulrich.Windl@rz.uni-regensburg.de,
       clameter@sgi.com, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       jimix@us.ibm.com, keith maanthey <kmannth@us.ibm.com>,
       greg kh <greg@kroah.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v.A0)
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com> <1094159379.14662.322.camel@cog.beaverton.ibm.com>
In-Reply-To: <1094159379.14662.322.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> All,
> 	This patch implements the architecture independent portion of the time
> of day subsystem. Included is timeofday.c (which includes all the time
> of day management and accessor functions), ntp.c (which includes the ntp
> scaling code, leap second processing, and ntp kernel state machine
> code), interface definition .h files, the example jiffies timesource
> (lowest common denominator time source, mainly for use as example code)
> and minimal hooks into arch independent code.
> 
> The patch does not function without minimal architecture specific hooks
> (i386 example to follow), and it can be applied to a tree without
> affecting the code.
> 
> I look forward to your comments and feedback.
> 
> thanks
> -john
~

> +static cycle_t jiffies_read(void)
> +{
> +	cycle_t ret = get_jiffies_64();
> +	return ret;
> +}
> +
> +static cycle_t jiffies_delta(cycle_t now, cycle_t then)
> +{
> +	/* simple subtraction, no need to mask */
> +	return now - then;
> +}

This should be inline...

> +
> +static nsec_t jiffies_cyc2ns(cycle_t cyc, cycle_t* remainder)
> +{
> +
> +	cyc *= NSEC_PER_SEC/HZ;

Hm... This assumes that 1/HZ is what is needed here.  Today this value is 
999898.  Not exactly reachable by NSEC_PER_SEC/HZ.  Or did I miss something, 
like the relationship of jiffie to 1/HZ and to real time.

> +
~

> +int ntp_leapsecond(struct timespec now)
> +{
> +	/*
> +	 * Leap second processing. If in leap-insert state at
> +	 * the end of the day, the system clock is set back one
> +	 * second; if in leap-delete state, the system clock is
> +	 * set ahead one second. The microtime() routine or
> +	 * external clock driver will insure that reported time
> +	 * is always monotonic. The ugly divides should be
> +	 * replaced.

??  Is this really to be hidden?  I rather though this was just the same as a 
user driven clock setting.  In any case, it is a slew of the wall clock and 
should be presented to abs timer code so that the abs timers can be corrected. 
This means a call to "clock_was_set()" AND an update of the mono_to_wall value.
> +	 */
> +	static time_t leaptime = 0;
> +
> +	switch (ntp_state) {
> +	case TIME_OK:
> +		if (ntp_status & STA_INS) {
> +			ntp_state = TIME_INS;
> +			/* calculate end of today (23:59:59)*/
> +			leaptime = now.tv_sec + SEC_PER_DAY - (now.tv_sec % SEC_PER_DAY) - 1;
> +		}
> +		else if (ntp_status & STA_DEL) {
> +			ntp_state = TIME_DEL;
> +			/* calculate end of today (23:59:59)*/
> +			leaptime = now.tv_sec + SEC_PER_DAY - (now.tv_sec % SEC_PER_DAY) - 1;
> +		}
> +		break;
> +
> +	case TIME_INS:
> +		/* Once we are at (or past) leaptime, insert the second */
> +		if (now.tv_sec > leaptime) {
> +			ntp_state = TIME_OOP;
> +			printk(KERN_NOTICE "Clock: inserting leap second 23:59:60 UTC\n");
> +
> +			return -1;
> +		}
> +		break;
> +
> +	case TIME_DEL:
> +		/* Once we are at (or past) leaptime, delete the second */
> +		if (now.tv_sec >= leaptime) {
> +			ntp_state = TIME_WAIT;
> +			printk(KERN_NOTICE "Clock: deleting leap second 23:59:59 UTC\n");
> +
> +			return 1;
> +		}
~

> +/* do_gettimeofday():
> + *		Returns the time of day
> + */
> +void do_gettimeofday(struct timeval *tv)
> +{
> +	nsec_t wall, sys;
> +	unsigned long seq;
> +
> +	/* atomically read wall and sys time */
> +	do {
> +		seq = read_seqbegin(&system_time_lock);
> +
> +		wall = wall_time_offset;
> +		sys = __monotonic_clock();
> +
> +	} while (read_seqretry(&system_time_lock, seq));
> +
> +	/* add them and convert to timeval */
> +	*tv = ns2timeval(wall+sys);
> +}
I am not sure you don't want to seperate the locking from the clock read.   This 
so one lock can be put around larger bits of code.  For example, in 
posix-times.c we need to get all three clocks under the same lock (that being 
monotonic, wall_time_offset, and jiffies (and possibly as sub jiffie value)).

Something like:
void get_tod_parts(nsec_t *wall, nsec_t *mon)
{
	*wall = wall_time_offset;
	*mon  = __monotonic_clock();
}

This could then be used in a larger function with out the double locking.

> +
> +
> +/* do_settimeofday():
> + *		Sets the time of day
> + */
> +int do_settimeofday(struct timespec *tv)
> +{
> +	/* convert timespec to ns */
> +	nsec_t newtime = timespec2ns(tv);
> +
> +	/* atomically adjust wall_time_offset to the desired value */
> +	write_seqlock_irq(&system_time_lock);
> +
> +	wall_time_offset = newtime - __monotonic_clock();
> +
> +	/* clear NTP settings */
> +	ntp_clear();
> +
> +	write_sequnlock_irq(&system_time_lock);

Also need a clock_was_set() call here.
> +
~
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

