Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbWIOImL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWIOImL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 04:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWIOImL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 04:42:11 -0400
Received: from cantor2.suse.de ([195.135.220.15]:22474 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750759AbWIOImK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 04:42:10 -0400
From: Andi Kleen <ak@suse.de>
To: Dima Zavin <dmitriyz@google.com>
Subject: Re: [PATCH] x86_64/i386: Rework thermal throttling detection/handling code for Intel P4/Xeons.
Date: Fri, 15 Sep 2006 08:59:27 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, zwane@arm.linux.org.uk
References: <20060915004236.GA9766@google.com>
In-Reply-To: <20060915004236.GA9766@google.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609150859.28130.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 15 September 2006 02:42, Dima Zavin wrote:
> - Maintain a count of thermal throttle events and export them to
> /sys/devices/system/cpu/cpuX/thermal_throttle/count - Factor out the
> thermal throttle event handling (i.e. logging) to a separate file,
> therm_throt.c under i386/kernel/cpu/mcheck.

Please make a separate patch to do any refactoring. Otherwise
nobody can evaluate your changes. Then any other changes on top of it.


> +static DEFINE_PER_CPU(atomic_t, tt_report_flag);
> +static DEFINE_PER_CPU(struct timer_list, tt_report_timer);
> +
> +static DEFINE_PER_CPU(unsigned long, last_time);
> +static DEFINE_PER_CPU(unsigned long, thermal_throttle_count);
> +static DEFINE_PER_CPU(unsigned long, last_count);
> +static DEFINE_PER_CPU(atomic_t, tt_enabled);

Do we really need all of this per CPU? I think global variables would
be just fine.

> +#define define_one_ro(_name)                                              
>   \ +        static SYSDEV_ATTR(_name, 0444, show_##_name, NULL)
> +
> +#define define_show_func(name)                                            

The names are too generic

> +/* thermal_throttle_count_init -
> + *    Initialize all the internal state variables. The inits to 0 are not
> + *    that important since the BSS is always 0 in kernel.
> + *
> + *    This function should be called ONLY if thermal throttle detection
> was + *    enabled on this 'cpu'.

I don't think your comments are actually correct kerneldoc, so the scripts
parsing it would break.

> + */
> +void __cpuinit thermal_throttle_count_init(unsigned int cpu)
> +{
> +	per_cpu(last_time, cpu)  = INITIAL_JIFFIES;
> +	per_cpu(thermal_throttle_count, cpu) = 0;
> +	per_cpu(last_count, cpu) = 0;

Most of this can be just a normal initializer for the variable

> +	/* initialize the check-flag-timer */
> +	init_timer(&per_cpu(tt_report_timer, cpu));
> +	per_cpu(tt_report_timer, cpu).function = tt_report_timer_tick;
> +	per_cpu(tt_report_timer, cpu).data = cpu;
> +
> +	/* mark us as enabled */
> +	atomic_set(&per_cpu(tt_enabled, cpu), 1);
> +	return;

Useless return;

> +}
> +
> +/* thermal_throttle_inc_count -
> + *    This function is normally called by the thermal interrupt if
> + *    the code determines that we just entered into a thermal event.
> + */
> +void thermal_throttle_inc_count(void)
> +{
> +	__get_cpu_var(thermal_throttle_count)++;
> +}

Can you please just expand that in the caller. It looks like overabstraction.

> +
> +/* thermal_throttle_process_event -
> + *    This function is normally called by the thermal interrupt,
> + *    after the thermal event has been counted by calling
> + *    thermal_throttle_inc_count().
> + *
> + *    evinfo is a pointer to astructure where event info will be filled
> in. + *    Currently that's just the cpu#, time since last logged event,
> and + *    number of skipped (silently counted) events since last logged +
> *    event.
> + *
> + *    Since the thermal interrupt normally gets called both when the
> thermal + *    event begins and once the event has ended, the caller passes
> in a + *    boolean 'curr' to specify whether or not it is currently IN the
> + *    thermal event.
> + *
> + *  Returns: 0 : Event should NOT be further logged, i.e. still in
> + *               "timeout" from previous log message.
> + *           1 : Event should be logged, and a message has been printed.
> + */
> +int thermal_throttle_process_event(struct therm_throt_event_info *evinfo,
> +				   int curr)
> +{
> +	unsigned int cpu = smp_processor_id();
> +	__u64 intvl;
> +	__u64 intvl_cnt;
> +
> +	/* Prevent flooding the logs with thermal entries */
> +	if (atomic_read(&__get_cpu_var(tt_report_flag)))
> +		return 0;

Isn't the test the wrong way around?

> +
> +	/* set the flag, and add the timer that will clear it */
> +	atomic_set(&__get_cpu_var(tt_report_flag), 1);
> +	__get_cpu_var(tt_report_timer).expires = jiffies + CHECK_INTERVAL;
> +	add_timer_on(&__get_cpu_var(tt_report_timer), cpu);

I'm not sure what you need the timer for. Can't just just drive
that from the interrupt handlers and check time stamps to do 
rate limiting? Then another timer wouldn't be needed.

> +	/* get the interval */
> +	intvl = (jiffies - __get_cpu_var(last_time)) / HZ;

Are you sure this handles jiffies wrapping correctly?

> +#ifdef CONFIG_HOTPLUG_CPU
> +static __cpuinit int thermal_throttle_remove_dev(struct sys_device *
> sys_dev) +{
> +	sysfs_remove_group(&sys_dev->kobj, &thermal_throttle_attr_group);
> +	return 0;
> +}

You don't remove the timer?

> +/* Get notified when a cpu comes on/off. Be hotplug friendly. */

And don't initialize it? Better get rid of it anyways.

> +static __cpuinit int thermal_throttle_cpu_callback(struct notifier_block
> *nfb, +						   unsigned long action,
> +						   void *hcpu)
> +{
> +	unsigned int cpu = (unsigned long)hcpu;
> +	struct sys_device *sys_dev;
> +
> +	sys_dev = get_cpu_sysdev(cpu);
> +	switch (action) {
> +		case CPU_ONLINE:
> +			thermal_throttle_add_dev(sys_dev);
> +			break;
> +		case CPU_DEAD:
> +			thermal_throttle_remove_dev(sys_dev);
> +			break;
> +	}ss
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block thermal_throttle_cpu_notifier =
> +{
> +	.notifier_call = thermal_throttle_cpu_callback,
> +};
> +#endif
> +
> +static __init int thermal_throttle_init_device(void)
> +{
> +	unsigned int cpu = 0;
> +
> +	/* connect to sysfs */
> +	for_each_online_cpu(cpu) {
> +		preempt_disable();
> +		if (cpu_online(cpu)) {

If you put the preempt_disable around the loop you don't need a second
check and you even fix a race with new CPUs.

> +/* mce_log_thermal_throttle_event -
> + *     Add an mce_log entry for the thermal throttle event 'evinfo'.
> 'status' + *     should be whatever the user wants to put into the
> mce.status field, + *     and historically has been the register value of
> the
> + *     MSR_IA32_THERMAL_STATUS.
> + *
> + *     This will typically be called from a thermal throttle interrupt
> + *     if the event should be logged.
> + */
> +void mce_log_thermal_throttle_event(__u64 status,
> +				    struct therm_throt_event_info *evinfo)
> +{

Instead of having this evinfo structure you could just directly
fill in struct mces in the caller.

> +	struct mce m;
> +
> +	memset(&m, 0, sizeof(m));
> +	m.cpu = evinfo->cpu;
> +	m.bank = MCE_THERMAL_BANK;

So how should user space distingush that event from other thermal events? 

> +	m.status = status;
> +	rdtscll(m.tsc);
> +
> +	/* save the delta of the throttle count to let the consumer of this
> +	 * information know how many throttle instances have been seen.
> +	 *
> +	 * 'misc' is organized below as follows:
> +	 * bits 15:0  - Contains a capped value of thermal events for last
> +	 *              interval.
> +	 * bits 31:16 - Time in seconds to qualify the interval
> +	 *              (capped at 0xffff)
> +	 *
> +	 * We cap events count at 16 bits to leave room in 'misc' for future
> +	 * extensions to this report */

I trust you will be also submitting a mcelog patch to decode all this? 

-Andi
