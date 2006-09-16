Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbWIPGRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWIPGRq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 02:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbWIPGRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 02:17:46 -0400
Received: from cantor.suse.de ([195.135.220.2]:4270 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932198AbWIPGRp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 02:17:45 -0400
From: Andi Kleen <ak@suse.de>
To: "Dmitriy Zavin" <dmitriyz@google.com>
Subject: Re: [PATCH] x86_64/i386: Rework thermal throttling detection/handling code for Intel P4/Xeons.
Date: Sat, 16 Sep 2006 06:34:55 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, zwane@arm.linux.org.uk
References: <20060915004236.GA9766@google.com> <200609150859.28130.ak@suse.de> <404ea8000609151333h32547601x7f6de316ff0df985@mail.google.com>
In-Reply-To: <404ea8000609151333h32547601x7f6de316ff0df985@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609160634.55250.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 15 September 2006 22:33, Dmitriy Zavin wrote:

> > > +static DEFINE_PER_CPU(atomic_t, tt_report_flag);
> > > +static DEFINE_PER_CPU(struct timer_list, tt_report_timer);
> > > +
> > > +static DEFINE_PER_CPU(unsigned long, last_time);
> > > +static DEFINE_PER_CPU(unsigned long, thermal_throttle_count);
> > > +static DEFINE_PER_CPU(unsigned long, last_count);
> > > +static DEFINE_PER_CPU(atomic_t, tt_enabled);
> >
> > Do we really need all of this per CPU? I think global variables would
> > be just fine.
>
> Each cpu can throttle at different times and have different counts, so

The counts should be per CPU, but everything else (timestamp, enabled) 
etc. can be just global.  You just don't want the logs flooded with events,
but if the rate limiting is global or local doesn't make much difference
That would give much simpler code and I believe
is sufficient for basically everybody
 
Currently your patch is a bit too large for the relatively simple things
it tries to attempt, so such ways to simplify it and slim it down are needed.
If you have other ideas to make it simpler that would be appreciated too.

> > > + */
> > > +void __cpuinit thermal_throttle_count_init(unsigned int cpu)
> > > +{
> > > +     per_cpu(last_time, cpu)  = INITIAL_JIFFIES;
> > > +     per_cpu(thermal_throttle_count, cpu) = 0;
> > > +     per_cpu(last_count, cpu) = 0;
> >
> > Most of this can be just a normal initializer for the variable
>
> The zeros yes, I will remove that. What about the last_time to
> INITIAL_JIFFIES?

Should work as a initializer too.

> Then the caller has to maintain the thermal counter, which is what I
> don't want. I wanted the managmente code to be separate. I can make
> this an inline in the header if you want to get rid of the function
> call.

The function call doesn't matter, it is just that we don't want overabstracted
kernel in the Linux kernel and your patch currently definitely has too many
functions doing very simple things. That makes it harder to read etc.

> > > +
> > > +     /* Prevent flooding the logs with thermal entries */
> > > +     if (atomic_read(&__get_cpu_var(tt_report_flag)))
> > > +             return 0;
> >
> > Isn't the test the wrong way around?
>
> No. When the flag is cleared, the event should be reported (this way
> the flag has the right initial value when its declared). If the flag
> is set, i skip the report. The timer will clear the flag.

Looks like a quite strange way to do things, but ok.

> > I'm not sure what you need the timer for. Can't just just drive
> > that from the interrupt handlers and check time stamps to do
> > rate limiting? Then another timer wouldn't be needed.
>
> Problem is that the timestamps are in jiffies. You could potentially
> have very long periods of time in between thermal events, assuming the
> box has a long uptime. On  32bit systems, if the time delta in jiffies
> between 2 events is >= 0x80000000, the time elapsed will be negative,
> and will prevent you from logging events until jiffies wrap all the
> way around (the counter will still increment though). The timer takes
> care of clearing the flag after 5 minutes.

We have a 64bit jiffies for that now on 32bit too.

But Jiffies wrap is several years. Even if we get a bogus overheat event
after two years it isn't really a issue. Please just get rid of the timer

> > > +#ifdef CONFIG_HOTPLUG_CPU
> > > +static __cpuinit int thermal_throttle_remove_dev(struct sys_device *
> > > sys_dev) +{
> > > +     sysfs_remove_group(&sys_dev->kobj, &thermal_throttle_attr_group);
> > > +     return 0;
> > > +}
> >
> > You don't remove the timer?
>
> Oops. Will fix. At this point, does the PER_CPU variable still exist?

Yes, they always exist for all possible CPUs.

But better just get rid of the timer completely.

> > > +/* mce_log_thermal_throttle_event -
> > > + *     Add an mce_log entry for the thermal throttle event 'evinfo'.
> > > 'status' + *     should be whatever the user wants to put into the
> > > mce.status field, + *     and historically has been the register value
> > > of the
> > > + *     MSR_IA32_THERMAL_STATUS.
> > > + *
> > > + *     This will typically be called from a thermal throttle interrupt
> > > + *     if the event should be logged.
> > > + */
> > > +void mce_log_thermal_throttle_event(__u64 status,
> > > +                                 struct therm_throt_event_info
> > > *evinfo) +{
> >
> > Instead of having this evinfo structure you could just directly
> > fill in struct mces in the caller.
>
> But the caller won't know what to fill the struct mce with since this
> function does the logic of figuring out the thermal event info. I
> can't have this function take "struct mce *" since that doesn't exist
> on i386. I could have it accept pointers to values as arguments, but
> that's messy.

Then either define struct mce for i386 or use two different functions
for i386/x86-64.

>
> > > +     struct mce m;
> > > +
> > > +     memset(&m, 0, sizeof(m));
> > > +     m.cpu = evinfo->cpu;
> > > +     m.bank = MCE_THERMAL_BANK;
> >
> > So how should user space distingush that event from other thermal events?
>
> What do you mean? This is already what x86_64 code does today for
> thermal throttle events.

It should be just clear where it came from since you added a new way
to generate them.

-Andi
