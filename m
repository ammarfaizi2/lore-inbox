Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751409AbWIOUdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbWIOUdn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 16:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbWIOUdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 16:33:42 -0400
Received: from smtp-out.google.com ([216.239.45.12]:22713 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751409AbWIOUdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 16:33:41 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=Sg8vVJFmAp74Cas/L6SmfD15TW9nSaBKAAKqqPzeorC27anfcWGSqqa1bHLLqS97K
	rQXGyw64Ojeazn9F2XAAA==
Message-ID: <404ea8000609151333h32547601x7f6de316ff0df985@mail.google.com>
Date: Fri, 15 Sep 2006 13:33:32 -0700
From: "Dmitriy Zavin" <dmitriyz@google.com>
To: "Andi Kleen" <ak@suse.de>
Subject: Re: [PATCH] x86_64/i386: Rework thermal throttling detection/handling code for Intel P4/Xeons.
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, zwane@arm.linux.org.uk
In-Reply-To: <200609150859.28130.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060915004236.GA9766@google.com> <200609150859.28130.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

>
> Please make a separate patch to do any refactoring. Otherwise
> nobody can evaluate your changes. Then any other changes on top of it.

Will do.

> > +static DEFINE_PER_CPU(atomic_t, tt_report_flag);
> > +static DEFINE_PER_CPU(struct timer_list, tt_report_timer);
> > +
> > +static DEFINE_PER_CPU(unsigned long, last_time);
> > +static DEFINE_PER_CPU(unsigned long, thermal_throttle_count);
> > +static DEFINE_PER_CPU(unsigned long, last_count);
> > +static DEFINE_PER_CPU(atomic_t, tt_enabled);
>
> Do we really need all of this per CPU? I think global variables would
> be just fine.

Each cpu can throttle at different times and have different counts, so
that is necessary on a per cpu basis. Maybe the enable can be shared,
since it is highly unlikely that one cpu will have thermal throttle
enabled and others not. But there can be BIOS bugs where it might
register it's own SMIs for some cpu's and not others.

> > +/* thermal_throttle_count_init -
> > + *    Initialize all the internal state variables. The inits to 0 are not
> > + *    that important since the BSS is always 0 in kernel.
> > + *
> > + *    This function should be called ONLY if thermal throttle detection
> > was + *    enabled on this 'cpu'.
>
> I don't think your comments are actually correct kerneldoc, so the scripts
> parsing it would break.

My fault, I haven't pushed anything upstream before. Will fix.

>
> > + */
> > +void __cpuinit thermal_throttle_count_init(unsigned int cpu)
> > +{
> > +     per_cpu(last_time, cpu)  = INITIAL_JIFFIES;
> > +     per_cpu(thermal_throttle_count, cpu) = 0;
> > +     per_cpu(last_count, cpu) = 0;
>
> Most of this can be just a normal initializer for the variable

The zeros yes, I will remove that. What about the last_time to INITIAL_JIFFIES?

> > +}
> > +
> > +/* thermal_throttle_inc_count -
> > + *    This function is normally called by the thermal interrupt if
> > + *    the code determines that we just entered into a thermal event.
> > + */
> > +void thermal_throttle_inc_count(void)
> > +{
> > +     __get_cpu_var(thermal_throttle_count)++;
> > +}
>
> Can you please just expand that in the caller. It looks like overabstraction.

Then the caller has to maintain the thermal counter, which is what I
don't want. I wanted the managmente code to be separate. I can make
this an inline in the header if you want to get rid of the function
call.

> > +
> > +     /* Prevent flooding the logs with thermal entries */
> > +     if (atomic_read(&__get_cpu_var(tt_report_flag)))
> > +             return 0;
>
> Isn't the test the wrong way around?

No. When the flag is cleared, the event should be reported (this way
the flag has the right initial value when its declared). If the flag
is set, i skip the report. The timer will clear the flag.

> I'm not sure what you need the timer for. Can't just just drive
> that from the interrupt handlers and check time stamps to do
> rate limiting? Then another timer wouldn't be needed.

Problem is that the timestamps are in jiffies. You could potentially
have very long periods of time in between thermal events, assuming the
box has a long uptime. On  32bit systems, if the time delta in jiffies
between 2 events is >= 0x80000000, the time elapsed will be negative,
and will prevent you from logging events until jiffies wrap all the
way around (the counter will still increment though). The timer takes
care of clearing the flag after 5 minutes.

>
> > +     /* get the interval */
> > +     intvl = (jiffies - __get_cpu_var(last_time)) / HZ;
>
> Are you sure this handles jiffies wrapping correctly?

Not sure. Will fix.

> > +#ifdef CONFIG_HOTPLUG_CPU
> > +static __cpuinit int thermal_throttle_remove_dev(struct sys_device *
> > sys_dev) +{
> > +     sysfs_remove_group(&sys_dev->kobj, &thermal_throttle_attr_group);
> > +     return 0;
> > +}
>
> You don't remove the timer?

Oops. Will fix. At this point, does the PER_CPU variable still exist?

> > +/* Get notified when a cpu comes on/off. Be hotplug friendly. */
>
> And don't initialize it? Better get rid of it anyways.

The timer is initialized in thermal_throttle_count_init.

> > +     /* connect to sysfs */
> > +     for_each_online_cpu(cpu) {
> > +             preempt_disable();
> > +             if (cpu_online(cpu)) {
>
> If you put the preempt_disable around the loop you don't need a second
> check and you even fix a race with new CPUs.

Thanks, will fix.

> > +/* mce_log_thermal_throttle_event -
> > + *     Add an mce_log entry for the thermal throttle event 'evinfo'.
> > 'status' + *     should be whatever the user wants to put into the
> > mce.status field, + *     and historically has been the register value of
> > the
> > + *     MSR_IA32_THERMAL_STATUS.
> > + *
> > + *     This will typically be called from a thermal throttle interrupt
> > + *     if the event should be logged.
> > + */
> > +void mce_log_thermal_throttle_event(__u64 status,
> > +                                 struct therm_throt_event_info *evinfo)
> > +{
>
> Instead of having this evinfo structure you could just directly
> fill in struct mces in the caller.

But the caller won't know what to fill the struct mce with since this
function does the logic of figuring out the thermal event info. I
can't have this function take "struct mce *" since that doesn't exist
on i386. I could have it accept pointers to values as arguments, but
that's messy.

> > +     struct mce m;
> > +
> > +     memset(&m, 0, sizeof(m));
> > +     m.cpu = evinfo->cpu;
> > +     m.bank = MCE_THERMAL_BANK;
>
> So how should user space distingush that event from other thermal events?

What do you mean? This is already what x86_64 code does today for
thermal throttle events.

> > +     m.status = status;
> > +     rdtscll(m.tsc);
> > +
> > +     /* save the delta of the throttle count to let the consumer of this
> > +      * information know how many throttle instances have been seen.
> > +      *
> > +      * 'misc' is organized below as follows:
> > +      * bits 15:0  - Contains a capped value of thermal events for last
> > +      *              interval.
> > +      * bits 31:16 - Time in seconds to qualify the interval
> > +      *              (capped at 0xffff)
> > +      *
> > +      * We cap events count at 16 bits to leave room in 'misc' for future
> > +      * extensions to this report */
>
> I trust you will be also submitting a mcelog patch to decode all this?

Oops. Yes, I will add a patch for that as well.

Thank you very much for your feedback.

--Dima
