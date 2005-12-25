Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbVLYWLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbVLYWLQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 17:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750958AbVLYWLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 17:11:16 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:61083 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750956AbVLYWLP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 17:11:15 -0500
From: Roman Zippel <zippel@linux-m68k.org>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: [PATCH/RFC 10/10] example of simple continuous gettimeofday
Date: Sun, 25 Dec 2005 21:54:06 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0512220028250.30930@scrub.home> <1135219395.5873.96.camel@leatherman>
In-Reply-To: <1135219395.5873.96.camel@leatherman>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512252154.09253.zippel@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday 22 December 2005 03:43, john stultz wrote:

> > The basic idea behind this is that ntp defines the frequency of the
> > reference time, e.g. with a clock frequency of f=500MHz the clock should
> > advance exactly 1 second after f cycles, but a quartz is usually not
> > that precise and varies depending on the temperature, so ntp defines an
> > adjustment, which should be applied every f cycles. tick_nsec and
> > time_adj now specify this frequency by how much the time is advanced
> > every tick. The resolution of the frequency is currently 2^-12nsec,
> > which allows for a very stable clock.
>
> My read: This is how the current tick based timekeeping functions.
>
> Continued agreement.

Actually this is how every timekeeping works (only tick_nsec/time_adj are the 
implementation specific parts), NTP defines the reference frequency of the 
clock, i.e. by how much time the clock should be advanced every f cycles (or 
n ticks).

> > OTOH when reading the clock source it depends on the used multiplier by
> > how much the time is advanced every f cycles (this is also the time
> > visible to the user), e.g. in this case we would initialize the
> > multiplier to 8388608 (the shift value used in the patch is 22, so
> > m=10^9*2^22/f) so that after f cycles the time is f*m>>22=10^9nsec. To
> > keep the time now incrementing monotonically we can change the
> > multiplier to change the speed of the clock. It depends now on the used
> > shift value and the update frequency, how close we can keep the user
> > time to the reference time, e.g. with HZ=250 the possible frequency
> > adjustment steps can be f/2^22/10^9/HZ or about 0.477nsec, as the
> > resolution of the clock itself is 1/f (or 2nsec), the resulting
> > resolution is still well within the practical limits of the clock. This
> > also means a good shift value for a clock is around log2(f^2/10^9/HZ), a
> > much larger shift value doesn't improve much over the clock resolution
> > and a lower shift value makes the clock resolution worse.
>
> My Read: Adjust the frequency multiplier (using mult/shift units) to
> apply the frequency adjustment. Picking a good shift unit is desirable.
>
> My clocksource code uses exactly the same method. See comments in the
> clocksource drivers and cyc2ns() for details.

Yes, but I think it misses a few details of how to choose a good shift value 
for a specific target precision. That's what I try to provide above.

> > In any case the clock resolution will be coarser than the resolution of
> > the ntp reference time, so with every update step at a timer tick we
> > accumulate an error of (ntp_update-xtime_update) and after some time the
> > error is large enough that it can be corrected by adjusting the
> > multiplier. The tricky part here is to prevent the error value from
> > oscillating too much, what can happen if the update comes too late and
> > we compensated too much, this is not much of a problem for small error
> > values, but larger error values are incrementally corrected instead and
> > not all at once. Another important detail is that the error value is
> > calculated after possible adjustments from second_overflow(), this way
> > we basically look ahead to the next timer tick and compensate for the
> > expected error and don't wait until we exceeded the error. This means a
> > well synchronized clock with small update delays almost always stays
> > within the error limits.
>
> The specifics here are a little fuzzy from the first read. It seems the
> point is that since frequency adjustments are made at fixed points, the
> longer the interval is between the point, the greater possible error.
> Thus if ticks are lost, or for whatever reason the intervals between
> frequency changes is large, we may over-compensate from what the NTP
> reference clock tells us.

It has nothing to do with lost ticks, the important part are the different 
resolutions. The NTP reference time provides long term stability, so you can 
keep it stable within a 1nsec over a day.
The adjustment done with the multiplier are much coarser, here you quickly can 
accumulate an error of a few usec or even msec within a hour. The error is 
f/2^shift/2 nsec per second, so it all depends on the used shift value and 
the faster the clock the larger the error.

> Your design seems to suggest keeping an NTP calculated reference time
> that the timekeeping code uses to correct itself from (again, let me
> know if I'm mis-understanding you).  In my view this is a little
> redundant, because fundamentally this is what the ntp daemon and
> adjtimex is already doing. The daemon uses the server's reference time
> and figures out how far off it is from the OS's system time. It does
> some filtering and feeds that offset into adjtimex where it is dampened
> and used to modify a frequency adjustment.

Indeed, the main part here is really the long term stability, my code corrects 
small errors immediately, where you leave this to the next ntp 
synchronisation step.

> So instead of using those offset/frequency adjustment values directly
> (which my design tries to do), your design converts it to a fixed
> adjustment to xtime which then becomes yet another reference clock to
> the timekeeping code, which calculates yet another offset value and
> converts that into a frequency adjustment.

Our code is not that different, so you basically do all this work as well. :)
total_sppm is basically just (tick_nsec + time_adj - TICK_NSEC) or the new 
multiplier could be calculated as (tick_nsec + time_adj) / update_cycles. The 
major difference that I keep the error (basically (tick_nsec+time_adj) % 
update_cycles) from the previous update and use it to correct the drift (see 
below).

Overall due to the precalculations from the other patches my code is also a 
bit simpler, e.g. you have multiple checks against NSEC_PER_SEC to some work 
once per second (interval_sum and second_check), which I keep together.
Another difference is that I keep everything scaled to the same base, you have 
to convert between different bases (mostly total_sppm). Keeping everything 
scaled equally has the big advantage that it's easy to change the scale (e.g. 
to implement the ppc64 version of gettimeofday()). Only some conversion 
factors and limits in adjtimex() change, all the rest of code stays the same, 
so you gain a lot of flexibility and still keep everything generic.

> So I think the real difference here is that I calculate the frequency
> adjustment directly from the NTP freq/offset/tick values inside the NTP
> code and allow the NTP daemon (along w/ the tick based dampening)
> provide the feedback as to how accurate we are.

This way you push more work to the daemon and create a larger jitter. This 
doesn't matter much for normal machines synchronised over the internet, but 
if you want to synchronise a few machines in a local network and want to 
reach usec resolution, you quickly hit the limits.

> > - with the previous patches the ntp code doesn't need much more changes
> >   anymore to implement a continuous time source, all you need is access
> >   to tick_nsec_curr, time_adj_curr and second_overflow() and you have to
> >   keep the generic code from calling update_wall_time().
>
> I still prefer the stronger isolation in my design (NTP code does not
> directly change any timekeeping values, but provides NTP adjustment
> values via function interfaces), but yes, at first glance I don't
> believe your NTP patches break how my code functions.

It's mainly still only example code, so a better separation is of course still 
possible.

> > - your code doesn't maintain the long term error, which will cause a
> >   random drift. This basically means you need a large shift value to
> >   increase the resolution and keep this error small. The code below can
> >   maintain a stable clock even at low resolutions.
>
> I disagree here. I keep a 64 bit remainder value in
> timeofday_periodic_hook() that accumulates the sub-nanosecond error when
> converting from cycles to nanoseconds. If this is not what you mean,
> could you please clarify?

I keep that remainder as well, but it's part of xtime_nsec, I even included 
this remainder in the gettimeofday() calculation, so time e.g. doesn't jump 
from 0.1 nsec to 0.9 nsec after an update.
The error I mean comes from ppm_to_mult_adj(), here you lose resolution. 
cs->mult depends on the chosen the shift value and the smaller the shift 
value/multiplier the more resolution you lose and the larger the error and 
the drift are.

> > - I still don't like the idea of a generic gettimeofday() as it prevents
> >   more optimized versions, e.g. on the one end with a 1MHz clock you only
> >   have usec resolution anyway and this allows to keep almost everything
> >   within 32bits. On the other end 64bit archs can avoid the "if (nsec >
> >   NSEC_PER_SEC)" by doing something like ppc64 does, but requires a
> >   different scaling of the values (to sec instead of nsec).
>
> Fair enough. I agree arches should be able to have their own arch
> specific implementations. If you really have to micro-optimize
> everything, just don't enable CONFIG_GENERIC_TIME and have your own
> timekeeping subsystem!

I don't think that's necessary, large parts are still generic and I don't 
think a config option is necessary at all (i.e. I didn't need one in my 
example).

> But at the same time, I don't like the idea of needlessly having 26
> different versions of gettimeofday that do exactly the same thing modulo
> a few bugs. :)

We can still provide a generic version, all the clock driver has to do is to 
add a line ".gettimeofday = generic_gettimeofday,". Even different versions 
can come from the same source template, the clock only defines some 
parameters and then includes the template, which generates the correct and 
optimised code.
There are a number of possibilities, which basically would provide the clock 
driver only a basic framework it can choose from, but overall there would 
only be one source version.

> > - the clock switch infrastructure can be merged with the clock set
> >   mechanism. When setting a clock some internal variables have to be
> >   updated as well, which can be reused for the clock switch basically
> >   by setting the clock immediately before the switch, so that both
> >   clocks run synchronously for a few cycles.
>
> Well, that's a little hand-wavy, but yes, being able to switch
> clocksources requires more code and I don't think that's a point of
> contention here. :)

Actually it's not so much hand-wavy, the time_was_set() in my example provides 
already almost everything to switch from one clock source to another.

> Sooo.. let's rework this a bit (also dropping the printks):
> 	u64 cycle_delta, nsec_delta
>
> 	rdtscll(cycles);
> 	while ((off = cycles - cycles_offset) >= update_cycles) {
> 		cycles_delta += update_cycles;
> 		nsec_delta += xtime_update;
>
> 		xtime_error += (u64)tick_nsec_curr << 22;
> 		xtime_error += (u64)time_adj_curr << (22 - SHIFT_SCALE);
> 		xtime_error -= xtime_update;
> 	}
> 	xtime_nsec += nsec_delta;
> 	cycle_offset += cycle_delta;
>
> 	while (xtime_nsec >= (u64)NSEC_PER_SEC << 22) {
> 		xtime_nsec -= (u64)NSEC_PER_SEC << 22;
> 		xtime.tv_sec++;
> 		second_overflow();
> 	}
> 	xtime.tv_nsec = xtime_nsec >> 22;
>
>
> Now lets look at my code in timeofday_periodic_hook():
>
> 	/* read time source & calc time since last call: */
> 	cycle_now = read_clocksource(clock);
>
> 	cycle_delta = (cycle_now - cycle_last) & clock->mask;
>
> 	delta_nsec = cyc2ns_fixed_rem(ts_interval, &cycle_delta, &remainder);
> 	cycle_last = (cycle_now - cycle_delta)&clock->mask;
>
> 	/* update system_time:  */
> 	__increment_system_time(delta_nsec);
>
>
> You might take a look at cyc2ns_fixed_rem() to see exactly how similar
> these are, but so far we're talking *really* close.

Your cyc2ns_fixed_rem() is still a bit more complex than my simple "nsec_delta 
+= xtime_update;", i.e. no special remainder handling. The xtime_error is not 
the same as your remainder (see below).

> > +	if (xtime_error > update_cycles / 2) {
> > [..]
>
> Ok, so here's where we start to see a difference. First it looks like
> this should be in a function. I broke what would be considered  similar
> functionality into the following two functions:
>
> 	ntp_advance(delta_nsec);
> and
> 	ppm = ntp_get_ppm_adjustment();
>
> Where ntp_advance() tells the NTP code to increment the NTP state values
> for the interval that just passed. This is very similar to the
> second_overflow() bits done in the first chunk of your code, only it is
> not fixed to only being run at the wall-time second boundery. Instead an
> arbitrary but constant second interval length is used (from boot time).

I think here is where you misunderstand my code. All the ntp_advance() 
business is already done in the previous loop and at a wall-time second 
boundary.
This part is equivalent to your ntp_get_ppm_adjustment() and could also be 
written as:

	nsec = error;
	nsec += (u64)tick_nsec_curr << 22;
	nsec += (u64)time_adj_curr << (22 - SHIFT_SCALE);

	mult = nsec / update_cycles;
	error = nsec % update_cycles;

You basically drop the error now, which is needed to keep the clock stable.
(Although to accurately maintain the error this also had to be done in the 
loop, i.e. xtime_error above).
My code now avoids the rather expensive recalculations and only has work to do 
if the error is larger than update_cycles/2 and the common case is that the 
multiplier only differs by one from the previous value.
So our code does indeed pretty much the same work, but I update all the values 
incrementally and avoid any possibly expensive calculations on any arch.

> The remaining functional difference here is the fact I mentioned above,
> where I'm using the NTP state values in a way that I feel is more direct
> in manipulating the frequency multiplier and where you're generating the
> multiplier adjustment via the difference in the current time from the
> reference time. But really, hide this difference away in a similar
> function to ntp_advance() and its all pretty moot.

The code could be moved of course into separate functions, although I'm not 
sure about the name ntp_advance(). tick_nsec/time_adj and second_overflow() 
are the only interfaces to the ntp code left and the rest are really clock 
specific parameters.
This code can now be basically turned into some template code, which can be 
optimised for every clock driver, so we can completely avoid the 
CONFIG_GENERIC_TIME, arch_getoffset() and is_continuous stuff.

> Does this sound about right? Are we really in this much agreement or has
> my looking forward to a full week off tinted my glasses rosy? :)

It seems a few details are missing, but overall it looks good. :)

bye, Roman
