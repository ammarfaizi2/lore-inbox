Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965037AbVLVCit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965037AbVLVCit (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 21:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965039AbVLVCis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 21:38:48 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:29379 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S965037AbVLVCis
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 21:38:48 -0500
Subject: Re: [PATCH/RFC 10/10] example of simple continuous gettimeofday
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0512220028250.30930@scrub.home>
References: <Pine.LNX.4.61.0512220028250.30930@scrub.home>
Content-Type: text/plain
Date: Wed, 21 Dec 2005 18:43:15 -0800
Message-Id: <1135219395.5873.96.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Roman,
	First, thanks for bringing code along. This will hopefully let us
narrow down the specific differences between the two designs without
much hand-waving. Please do be patient with me as sometimes you can be
difficult to understand, and really sometimes I can be just dumb. For
most of this I'll try to re-state my understanding of your point and go
from there, that way you'll have a better idea where the confusion is
arising from.

Unfortunately I'm out of town after tomorrow, so this discussion will
probably not get very far until after the new year.

On Thu, 2005-12-22 at 00:30 +0100, Roman Zippel wrote:
> The previous patches convert the ntp code to precalculate as much as
> possible, so that at every tick the reference time has only to be
> updated by tick_nsec_curr/time_adj_curr. What this patch adds over
> update_wall_time_one_tick() is that it modifies the frequency of the
> local time to match the reference time instead of simply jumping to it.
> It does this by maintaining an error value and modifying the multiplier
> to reduce the error. 

My read: Uses NTP to modify the clock frequency value rather then just
adding or subtracting fixed units from system time.

Yep, basically this is what my code does as well. So far I think we're
in agreement at a high level.

> The basic idea behind this is that ntp defines the frequency of the
> reference time, e.g. with a clock frequency of f=500MHz the clock should
> advance exactly 1 second after f cycles, but a quartz is usually not
> that precise and varies depending on the temperature, so ntp defines an
> adjustment, which should be applied every f cycles. tick_nsec and
> time_adj now specify this frequency by how much the time is advanced
> every tick. The resolution of the frequency is currently 2^-12nsec,
> which allows for a very stable clock.

My read: This is how the current tick based timekeeping functions.

Continued agreement.


> OTOH when reading the clock source it depends on the used multiplier by
> how much the time is advanced every f cycles (this is also the time
> visible to the user), e.g. in this case we would initialize the
> multiplier to 8388608 (the shift value used in the patch is 22, so
> m=10^9*2^22/f) so that after f cycles the time is f*m>>22=10^9nsec. To
> keep the time now incrementing monotonically we can change the
> multiplier to change the speed of the clock. It depends now on the used
> shift value and the update frequency, how close we can keep the user
> time to the reference time, e.g. with HZ=250 the possible frequency
> adjustment steps can be f/2^22/10^9/HZ or about 0.477nsec, as the
> resolution of the clock itself is 1/f (or 2nsec), the resulting
> resolution is still well within the practical limits of the clock. This
> also means a good shift value for a clock is around log2(f^2/10^9/HZ), a
> much larger shift value doesn't improve much over the clock resolution
> and a lower shift value makes the clock resolution worse.


My Read: Adjust the frequency multiplier (using mult/shift units) to
apply the frequency adjustment. Picking a good shift unit is desirable.

My clocksource code uses exactly the same method. See comments in the
clocksource drivers and cyc2ns() for details.

> In any case the clock resolution will be coarser than the resolution of
> the ntp reference time, so with every update step at a timer tick we
> accumulate an error of (ntp_update-xtime_update) and after some time the
> error is large enough that it can be corrected by adjusting the
> multiplier. The tricky part here is to prevent the error value from
> oscillating too much, what can happen if the update comes too late and
> we compensated too much, this is not much of a problem for small error
> values, but larger error values are incrementally corrected instead and
> not all at once. Another important detail is that the error value is
> calculated after possible adjustments from second_overflow(), this way
> we basically look ahead to the next timer tick and compensate for the
> expected error and don't wait until we exceeded the error. This means a
> well synchronized clock with small update delays almost always stays
> within the error limits.

The specifics here are a little fuzzy from the first read. It seems the
point is that since frequency adjustments are made at fixed points, the
longer the interval is between the point, the greater possible error.
Thus if ticks are lost, or for whatever reason the intervals between
frequency changes is large, we may over-compensate from what the NTP
reference clock tells us.

I think I agree here, basically. One of the differences between the two
designs is that I've drawn stronger lines between the timekeeping code
and the NTP/reference clock code.

Your design seems to suggest keeping an NTP calculated reference time
that the timekeeping code uses to correct itself from (again, let me
know if I'm mis-understanding you).  In my view this is a little
redundant, because fundamentally this is what the ntp daemon and
adjtimex is already doing. The daemon uses the server's reference time
and figures out how far off it is from the OS's system time. It does
some filtering and feeds that offset into adjtimex where it is dampened
and used to modify a frequency adjustment.

So instead of using those offset/frequency adjustment values directly
(which my design tries to do), your design converts it to a fixed
adjustment to xtime which then becomes yet another reference clock to
the timekeeping code, which calculates yet another offset value and
converts that into a frequency adjustment.

So I think the real difference here is that I calculate the frequency
adjustment directly from the NTP freq/offset/tick values inside the NTP
code and allow the NTP daemon (along w/ the tick based dampening)
provide the feedback as to how accurate we are.

Otherwise (outside of which function does what) I think we're very much
in sync. Below I hope to show you how similar the designs are.

> John, I hope this helps you to understand what I have in mind, please ask
> if something is unclear, I'm already working on it for a while, so I
> have no idea how digestable this is all at once. :)

I think I'm following it (although I'll let you judge how well).

> I certainly have now a much better picture of what's possible and how to
> further optimize this for different clocks. Here are a few general
> comments about your code:
> 
> - with the previous patches the ntp code doesn't need much more changes
>   anymore to implement a continuous time source, all you need is access
>   to tick_nsec_curr, time_adj_curr and second_overflow() and you have to
>   keep the generic code from calling update_wall_time().

I still prefer the stronger isolation in my design (NTP code does not
directly change any timekeeping values, but provides NTP adjustment
values via function interfaces), but yes, at first glance I don't
believe your NTP patches break how my code functions.

>   The ntp code certainly can use some more cosmetic changes, but I'd
>   prefer to leave it for later.

Indeed. That's why I dropped the majority of my NTP cleanups. If we can
trickle the smaller changes in slowly, that's fine. I just wanted to
drop to the bare minimum.

> - your code doesn't maintain the long term error, which will cause a
>   random drift. This basically means you need a large shift value to
>   increase the resolution and keep this error small. The code below can
>   maintain a stable clock even at low resolutions.

I disagree here. I keep a 64 bit remainder value in
timeofday_periodic_hook() that accumulates the sub-nanosecond error when
converting from cycles to nanoseconds. If this is not what you mean,
could you please clarify?


> - I still don't like the idea of a generic gettimeofday() as it prevents
>   more optimized versions, e.g. on the one end with a 1MHz clock you only
>   have usec resolution anyway and this allows to keep almost everything
>   within 32bits. On the other end 64bit archs can avoid the "if (nsec >
>   NSEC_PER_SEC)" by doing something like ppc64 does, but requires a
>   different scaling of the values (to sec instead of nsec).

Fair enough. I agree arches should be able to have their own arch
specific implementations. If you really have to micro-optimize
everything, just don't enable CONFIG_GENERIC_TIME and have your own
timekeeping subsystem! 

But at the same time, I don't like the idea of needlessly having 26
different versions of gettimeofday that do exactly the same thing modulo
a few bugs. :)


> - the clock switch infrastructure can be merged with the clock set
>   mechanism. When setting a clock some internal variables have to be
>   updated as well, which can be reused for the clock switch basically
>   by setting the clock immediately before the switch, so that both
>   clocks run synchronously for a few cycles.

Well, that's a little hand-wavy, but yes, being able to switch
clocksources requires more code and I don't think that's a point of
contention here. :)

> Anyway, most important for me right now is to make sure, the stuff below
> is understood and I didn't make a stupid mistake somewhere. After this 
> we'll see how to take it from there.

Let me know how I do. :)

[snip - basic setup bits]
> Index: linux-2.6-mm/arch/i386/kernel/timers/timer_tsc.c
> ===================================================================
> --- linux-2.6-mm.orig/arch/i386/kernel/timers/timer_tsc.c	2005-12-21 12:09:42.000000000 +0100
> +++ linux-2.6-mm/arch/i386/kernel/timers/timer_tsc.c	2005-12-21 12:12:30.000000000 +0100
> @@ -455,6 +456,124 @@ static void mark_offset_tsc(void)
>  	if (lost && abs(delay - delay_at_last_interrupt) > (900000/HZ))
>  		jiffies_64++;
>  }
> +#endif
> +
> +extern unsigned long tick_nsec_curr, time_adj_curr;
> +extern void second_overflow(void);
> +
> +u32 cycles_mult, update_cycles;
> +u64 cycles_offset, xtime_nsec, xtime_update;
> +s64 xtime_error;
> +int error_adj;
> +
> +static void mark_offset_tsc(void)
> +{
> +	u64 cycles, update;
> +	s64 off;
> +	int adj;
> +
> +	//printk("[");
> +	rdtscll(cycles);
> +
> +	while ((off = cycles - cycles_offset) >= update_cycles) {
> +		//printk("*");
> +		cycles_offset += update_cycles;
> +		xtime_nsec += xtime_update;
> +		if (xtime_nsec >= (u64)NSEC_PER_SEC << 22) {
> +			xtime_nsec -= (u64)NSEC_PER_SEC << 22;
> +			xtime.tv_sec++;
> +			second_overflow();
> +			if (!(xtime.tv_sec & 7))
> +				printk("ft: %lld,%u,%llu,%u\n", xtime_error, cycles_mult, xtime_nsec, error_adj);
> +		}
> +		xtime.tv_nsec = xtime_nsec >> 22;
> +		xtime_error += (u64)tick_nsec_curr << 22;
> +		xtime_error += (u64)time_adj_curr << (22 - SHIFT_SCALE);
> +		xtime_error -= xtime_update;
> +	}


Sooo.. let's rework this a bit (also dropping the printks):
	u64 cycle_delta, nsec_delta

	rdtscll(cycles);
	while ((off = cycles - cycles_offset) >= update_cycles) {
		cycles_delta += update_cycles;
		nsec_delta += xtime_update;

		xtime_error += (u64)tick_nsec_curr << 22;
		xtime_error += (u64)time_adj_curr << (22 - SHIFT_SCALE);
		xtime_error -= xtime_update;
	}
	xtime_nsec += nsec_delta;
	cycle_offset += cycle_delta;

	while (xtime_nsec >= (u64)NSEC_PER_SEC << 22) {
		xtime_nsec -= (u64)NSEC_PER_SEC << 22;
		xtime.tv_sec++;
		second_overflow();
	}
	xtime.tv_nsec = xtime_nsec >> 22;


Now lets look at my code in timeofday_periodic_hook():

	/* read time source & calc time since last call: */
	cycle_now = read_clocksource(clock);

	cycle_delta = (cycle_now - cycle_last) & clock->mask;

	delta_nsec = cyc2ns_fixed_rem(ts_interval, &cycle_delta, &remainder);
	cycle_last = (cycle_now - cycle_delta)&clock->mask;

	/* update system_time:  */
	__increment_system_time(delta_nsec);


You might take a look at cyc2ns_fixed_rem() to see exactly how similar
these are, but so far we're talking *really* close.


> +	if (xtime_error > update_cycles / 2) {
> +		//long dummy, tmp = div_ll_X_l_rem(xtime_error + update_cycles / 2, update_cycles, &dummy);
> +		//printk("+");
> +		adj = error_adj;
> +		update = (u64)update_cycles << adj;
> +		if (xtime_error > update) {
> +			if (xtime_error > update << 1) {
> +				update <<= 1;
> +				error_adj = ++adj;
> +				//printk("e+^:%ld\n", tmp);
> +			}
> +		} else if (adj) {
> +			//printk("e+v:%ld\n", tmp);
> +			error_adj--;
> +			adj = 0;
> +			update = update_cycles;
> +		}
> +		off <<= adj;
> +		cycles_mult += 1 << adj;
> +		xtime_update += update;
> +		xtime_error -= update - off;
> +		xtime_nsec -= off;
> +	} else if (-xtime_error > update_cycles / 2) {
> +		//long dummy, tmp = -div_ll_X_l_rem(-xtime_error + update_cycles / 2, update_cycles, &dummy);
> +		//printk("-");
> +		adj = error_adj;
> +		update = (u64)update_cycles << adj;
> +		if (-xtime_error > update) {
> +			if (-xtime_error > update << 1) {
> +				update <<= 1;
> +				error_adj = ++adj;
> +				//printk("e-^:%ld\n", tmp);
> +			}
> +		} else if (adj) {
> +			//printk("e-v:%ld\n", tmp);
> +			error_adj--;
> +			adj = 0;
> +			update = update_cycles;
> +		}
> +		off <<= adj;
> +		cycles_mult -= 1 << adj;
> +		xtime_update -= update;
> +		xtime_error += update - off;
> +		xtime_nsec += off;
> +	}
> +	//printk("]");
> +}

Ok, so here's where we start to see a difference. First it looks like
this should be in a function. I broke what would be considered  similar
functionality into the following two functions:

	ntp_advance(delta_nsec);
and 
	ppm = ntp_get_ppm_adjustment();

Where ntp_advance() tells the NTP code to increment the NTP state values
for the interval that just passed. This is very similar to the
second_overflow() bits done in the first chunk of your code, only it is
not fixed to only being run at the wall-time second boundery. Instead an
arbitrary but constant second interval length is used (from boot time).

Then ntp_get_ppm_adjustment() provides the ppm adjustment value from the
NTP subsystem to be used in adjusting the frequency multiplier value.
Just as your code adjusts the cycles_mult value. 

(One subtle difference is that I keep the multiplier adjustment
separately from the multiplier value, just so its easier to reset back
to the clocksource drivers original value when needed. This isn't
required but I feel makes the code more understandable for the cost of
an add.)

The remaining functional difference here is the fact I mentioned above,
where I'm using the NTP state values in a way that I feel is more direct
in manipulating the frequency multiplier and where you're generating the
multiplier adjustment via the difference in the current time from the
reference time. But really, hide this difference away in a similar
function to ntp_advance() and its all pretty moot.

Does this sound about right? Are we really in this much agreement or has
my looking forward to a full week off tinted my glasses rosy? :)

thanks
-john


