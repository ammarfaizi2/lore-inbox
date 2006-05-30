Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbWE3PJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWE3PJf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 11:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbWE3PJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 11:09:35 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:57528 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S932309AbWE3PJe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 11:09:34 -0400
Date: Tue, 30 May 2006 17:09:23 +0200 (CEST)
From: Simon Derr <Simon.Derr@bull.net>
X-X-Sender: derrs@openx3.frec.bull.fr
To: john stultz <johnstul@us.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, Simon Derr <Simon.Derr@bull.net>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: -rt IA64 update
In-Reply-To: <1148998842.23411.11.camel@leatherman>
Message-ID: <Pine.LNX.4.61.0605301658440.14092@openx3.frec.bull.fr>
References: <Pine.LNX.4.61.0605291356170.14092@openx3.frec.bull.fr> 
 <20060530061503.GA19870@elte.hu> <1148998842.23411.11.camel@leatherman>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 30/05/2006 17:12:56,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 30/05/2006 17:12:59,
	Serialize complete at 30/05/2006 17:12:59
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2006, john stultz wrote:

> On Tue, 2006-05-30 at 08:15 +0200, Ingo Molnar wrote:
> > * Simon Derr <Simon.Derr@bull.net> wrote:
> > > * This kernel, when booting, prints:
> > > 
> > > 	BUG in check_monotonic_clock at kernel/time/timeofday.c:164
> > > 
> > > But I think this happens because two get_monotonic_clock() are racing 
> > > on two cpus. There is a lock to prevent the race, but it is a seqlock. 
> > > That means that it is okay if the race happens since another try will 
> > > be attempted, but the message that has been printed on the console 
> > > can't be removed, and the user is unnecessarily scared.
> 
> Simon, I suspect here you actually have unsynced ITCs, as the
> check_monotonic_clock values are all locked w/ spinlocks.
> 
> You should probably add a cmpxchg in clocksource_itc_read() where you
> currently do the if (last_itc < now), or you'll race on setting
> last_itc. Let me know if you still see the issue w/ that fix.

I have already tried to add a raw_spinlock_t to avoid this race, and the 
message still appears.

What I believe is happening is that is that somewhere between 
__get_nsec_offset() and ktime_add_ns(), while in

static ktime_t __get_monotonic_clock(void)
{
        s64 offset = __get_nsec_offset();
#ifdef CONFIG_PARANOID_GENERIC_TIME
        ktime_t check = get_check_value();
#endif
        ktime_t ret;

        ret = ktime_add_ns(system_time, offset);
        check_monotonic_clock(check,ret);
        return ret;
}

the cycle_last and system_time are being updated by a concurrent 
timeofday_periodic_hook().

This can happen since system_time_lock is "only" a seqlock.

>From a correctness point of view this is okay as get_monotonic_clock() 
will detect the race and call __get_monotonic_clock() again. But the 
warning message has been already been printed.

	Simon.

