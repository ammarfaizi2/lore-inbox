Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946223AbWKJJr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946223AbWKJJr6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 04:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946221AbWKJJr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 04:47:58 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:144 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1946223AbWKJJr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 04:47:57 -0500
Subject: Re: [patch 04/19] Add a framework to manage clock event devices.
From: Arjan van de Ven <arjan@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Len Brown <lenb@kernel.org>,
       John Stultz <johnstul@us.ibm.com>, Andi Kleen <ak@suse.de>,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <20061109233034.526217000@cruncher.tec.linutronix.de>
References: <20061109233030.915859000@cruncher.tec.linutronix.de>
	 <20061109233034.526217000@cruncher.tec.linutronix.de>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 10 Nov 2006 10:47:51 +0100
Message-Id: <1163152071.3138.627.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-09 at 23:38 +0000, Thomas Gleixner wrote:
> + * struct clock_event_device - clock event descriptor
> + *
> + * @name:		ptr to clock event name
> + * @capabilities:	capabilities of the event chip
> + * @max_delta_ns:	maximum delta value in ns
> + * @min_delta_ns:	minimum delta value in ns
> + * @mult:		nanosecond to cycles multiplier
> + * @shift:		nanoseconds to cycles divisor (power of two)
> + * @set_next_event:	set next event
> + * @set_mode:		set mode function
> + * @suspend:		suspend function (optional)
> + * @resume:		resume function (optional)
> + * @evthandler:		Assigned by the framework to be called by the low
> + *			level handler of the event source
> + */

it would be nice if the datastructure was "pure"; eg entirely owned by
the source (and could be made const), however the only way I can see
that done is by having a private duplicate datastructure in each clock
driver... which is way overkill for one single function pointer ;(


well you could do

struct clock_event_device 
{
	const struct clock_ops *ops;
	void *instance;
	evthndlr_t *evthandler;
}

that way if you have, say, 3 hpet channels you can use the same
"ops" (or maybe "props") structure for all three, but still register the
per channel state as well..


you maybe also want to have a "costs" member, so that you can pick the
cheapest available timer..


> +struct clock_event_device {
> +	const char	*name;
> +	unsigned int	capabilities;
> +	unsigned long	max_delta_ns;
> +	unsigned long	min_delta_ns;
> +	unsigned long	mult;
> +	int		shift;
> +	void		(*set_next_event)(unsigned long evt,
> +					  struct clock_event_device *);
> +	void		(*set_mode)(enum clock_event_mode mode,
> +				    struct clock_event_device *);
> +	void		(*event_handler)(struct pt_regs *regs);

is pt_regs really really needed here? We got rid of it in most places
(and made it a per tast struct thing), I wonder if it can be made to go
away here too.


> +/*
> + * Start up an event device
> + */
> +static void startup_event(struct clock_event_device *evt, unsigned int caps)
> +{
> +	int mode;
> +
> +	if (caps == CLOCK_CAP_NEXTEVT)

isn't caps a bitfield ? if so, shouldn't this be a & ?


> + */
> +int clockevents_set_next_event(ktime_t expires, int force)
> +{
> +	struct local_events *devices = &__get_cpu_var(local_eventdevices);
> +	struct clock_event_device *nextevt = devices->nextevt;
> +	int64_t delta = ktime_to_ns(ktime_sub(expires, ktime_get()));
> +
> +	if (delta <= 0 && !force) {
> +		devices->expires_next.tv64 = KTIME_MAX;
> +		return -ETIME;
> +	}

hmmm so if I set a timer 10 nsec in the future, and then I get an
interrupt, I suddenly get an infinite time timer? Sounds more like a
case of "please just run it right away"


> + * Resume the cpu local clock events
> + */
> +static void clockevents_resume_local_events(void *arg)
> +{
> +	struct local_events *devices = &__get_cpu_var(local_eventdevices);
> +	int i;
> +
> +	for (i = 0; i < devices->installed; i++) {
> +		if (devices->events[i].real_caps)
> +			startup_event(devices->events[i].event,
> +				      devices->events[i].real_caps);
> +	}
> +	touch_softlockup_watchdog();
> +}

what is this watchdog touching for?

> +static int clockevents_cpu_notify(struct notifier_block *self,
> +				  unsigned long action, void *hcpu)
> +{
> +	switch(action) {
> +	case CPU_UP_PREPARE:
> +		break;

don't you want to start the per cpu timer in such a case?




-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

