Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbVDSVEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbVDSVEf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 17:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVDSVE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 17:04:29 -0400
Received: from mx1.suse.de ([195.135.220.2]:52162 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261197AbVDSVDg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 17:03:36 -0400
Message-ID: <42657222.5080601@suse.de>
Date: Tue, 19 Apr 2005 23:03:30 +0200
From: Thomas Renninger <trenn@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20050317
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Tony Lindgren <tony@atomide.com>, Frank Sorenson <frank@tuxrocks.com>,
       linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Pavel Machek <pavel@suse.cz>, Arjan van de Ven <arjan@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>, George Anzinger <george@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Lee Revell <rlrevell@joe-job.com>,
       ML ACPI-devel <acpi-devel@lists.sourceforge.net>,
       Bodo Bauer <bb@suse.de>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Updated: Dynamic Tick version 050408-1 - C-state measures
References: <425451A0.7020000@tuxrocks.com> <20050407082136.GF13475@atomide.com> <4255A7AF.8050802@tuxrocks.com> <4255B247.4080906@tuxrocks.com> <20050408062537.GB4477@atomide.com> <20050408075001.GC4477@atomide.com> <42564584.4080606@tuxrocks.com> <42566C22.4040509@suse.de> <20050408115535.GI4477@atomide.com> <42651C38.6090807@suse.de> <20050419152723.GA9509@isilmar.linta.de>
In-Reply-To: <20050419152723.GA9509@isilmar.linta.de>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reducing the CC'd people a bit ...

Dominik Brodowski wrote:
> Hi,
>
> On Tue, Apr 19, 2005 at 04:56:56PM +0200, Thomas Renninger wrote:
>>If CONFIG_IDLE_HZ is set, the c-state will be evaluated on
>>three control values (averages of the last 4 measures):
>>
>>a) idle_ms -> if machine was active for longer than this
>>   value (avg), the machine is assumed to not be idle
>>   and C1 will be triggered.
>>
>>b) bm_promote_ms -> if the avg bus master activity is below
>>   this threshold, C2 is invoked.
>>
>>c) sleep_avg (no module param) -> the average sleep time of the
>>   last four C2 (or higher) invokations.
>>   If a and b does not apply, a C-state will be searched that has
>>   the highest latency, but still has a latency below the latest
>>   C2 (or higher) sleeping time and average sleeping time value.
>
> I think that we don't need this complication:
>
>>+//#define DEBUG 1
>>+#ifdef DEBUG
>>+#define myPrintk(string, args...) printk(KERN_INFO ""string, ##args);
>>+#else
>>+#define myPrintk(string, args...) {};
>>+#endif
>
> Please don't do that... dprintk() is much more common. Also, then don't
> comment dprintk() out below in the patch...
>
Ok, this patch is far from perfect, I am happy that it finally runs that nice on
my machine.

>> 	if (pr->flags.bm_check) {
>>-		u32		bm_status = 0;
>>-		unsigned long	diff = jiffies - pr->power.bm_check_timestamp;
>>-
>>-		if (diff > 32)
>>-			diff = 32;
>>-
>>-		while (diff) {
>>-			/* if we didn't get called, assume there was busmaster activity */
>>-			diff--;
>>-			if (diff)
>>-				pr->power.bm_activity |= 0x1;
>>-			pr->power.bm_activity <<= 1;
>>-		}
>
> "All" we need to do is to update the "diff". Without dynamic ticks, if the
> idle loop didn't get called each jiffy, it was a big hint that there was so
> much activity in between, and if there is activity, there is most likely
> also bus master activity, or at least more work to do, so interrupt activity
> is likely. Therefore we assume there was bm_activity even if there was none.
>
If I understand this right you want at least wait 32 (or whatever value) ms if there was bm activity,
before it is allowed to trigger C3/C4?

I think the problem is (at least I made the experience with this particular machine)
that bm activity comes very often and regularly (each 30-150ms?).

I think the approach to directly adjust the latency to a deeper sleep state if the
average bus master and OS activity is low is very efficient.

Because I don't consider whether there was bm_activity the last ms, I only
consider the average, it seems to happen that I try to trigger
C3/C4 when there is just something copied and some bm active ?!? Therefore, it seems to happen
that triggering C3/C4 fails (sleep_ticks < 0). The value of failures is getting smaller if I increase
the limit for average bm activity before triggering C3/C4 (bm_promote_ms must be smaller than average bm activity),
but it never will reach zero.

The patch is useless if these failures end up in system freezes on other machines...
AFAIK there were a lot of freeze problems with C-states? Don't know, it works here.

The problem with the old approach is, that after (doesn't matter C1-Cx) sleep and dyn_idle_tick,
the chance to wake up because of bm activity is very likely.
You enter idle() again -> there was bm_activity -> C2. Wake up after e.g. 50ms, because
of bm_activity again (bm_sts bit set) -> stay in C2, wake up after 40ms -> bm activity...
You only have the chance to get into deeper states if the sleeps are interrupted by an interrupt, not bm activity.

I also thought about only reprogram timer if C1/C2 was successful x times and no bm activity was detected,
same mechanism as now, then only reprogram timer (dyn tick) for deeper sleep states -> like that, you
still can be sure the last x ms was no bm activity bit set before going to deep sleeps.
But I don't know how to do it.

> Now, we do know the jiffy value when we started sleeping. If we use
> ticks_elapsed(t1, t2), convert it to jiffies, and do
> 	diff = jiffies - (pr->power.bm_check_timestamp + last_sleep_jiffies);
> it should work. I wrote a quick patch to do that, but it locked up my
> notebook, so it is most likely broken; hopefully I'll find some time to debug
> it, if somebody does it earlier, that'd be great, though.
>
> Thanks,
> 	Dominik
>
>
> Only assume busmaster activity on non-idle ticks if we didn't sleep until
> that jiffy. Needed for dyn-idle.
>
> Signed-off-by: Dominik Brodowski <linux@brodo.de>
>
> --- linux/drivers/acpi/processor_idle.c.original	2005-04-10 20:04:12.000000000 +0200
> +++ linux/drivers/acpi/processor_idle.c	2005-04-10 20:14:33.000000000 +0200
> @@ -120,6 +120,14 @@
>  		return ((0xFFFFFFFF - t1) + t2);
>  }
>
> +static inline u32
> +ticks_to_jiffies (u32 pm_ticks)
> +{
> +	pm_ticks *= 286;
> +	pm_ticks = (pm_ticks >> 10);
> +	return (pm_ticks / (USEC_PER_SEC / HZ));
> +}
> +
>
>  static void
>  acpi_processor_power_activate (
> @@ -169,7 +177,7 @@
>  	struct acpi_processor_cx *cx = NULL;
>  	struct acpi_processor_cx *next_state = NULL;
>  	int			sleep_ticks = 0;
> -	u32			t1, t2 = 0;
> +	u32			t1, t2, td = 0;
>
>  	pr = processors[_smp_processor_id()];
>  	if (!pr)
> @@ -201,11 +209,13 @@
>  	 * for demotion.
>  	 */
>  	if (pr->flags.bm_check) {
> -		u32		bm_status = 0;
> -		unsigned long	diff = jiffies - pr->power.bm_check_timestamp;
> +		u32	bm_status = 0;
> +		long	diff = jiffies - pr->power.bm_check_timestamp;
>
>  		if (diff > 32)
>  			diff = 32;
> +		else if (diff < 0)
> +			diff = 0;
>
>  		while (diff) {
>  			/* if we didn't get called, assume there was busmaster activity */
> @@ -293,7 +303,9 @@
>  		/* Re-enable interrupts */
>  		local_irq_enable();
>  		/* Compute time (ticks) that we were actually asleep */
> -		sleep_ticks = ticks_elapsed(t1, t2) - cx->latency_ticks - C2_OVERHEAD;
> +		td = ticks_elapsed(t1, t2);
> +		sleep_ticks = td - cx->latency_ticks - C2_OVERHEAD;
> +		pr->power.bm_check_timestamp += ticks_to_jiffies(td);
>  		break;
>
>  	case ACPI_STATE_C3:
> @@ -312,7 +324,9 @@
>  		/* Re-enable interrupts */
>  		local_irq_enable();
>  		/* Compute time (ticks) that we were actually asleep */
> -		sleep_ticks = ticks_elapsed(t1, t2) - cx->latency_ticks - C3_OVERHEAD;
> +		td = ticks_elapsed(t1, t2);
> +		sleep_ticks = td - cx->latency_ticks - C3_OVERHEAD;
> +		pr->power.bm_check_timestamp += ticks_to_jiffies(td);
>  		break;
>
>  	default:

Hmm, I can give it a shot the next days ...

You could also test whether it was bm activity here that caused the end of sleep (it should be in most cases):

	        acpi_get_register(ACPI_BITREG_BUS_MASTER_RLD, &bm_wakeup, ACPI_MTX_DO_NOT_LOCK);
		if (bm_wakeup){
			printk(KERN_INFO "Woke up from C3 from bus master activity after %d ticks\n", td);
			acpi_set_register(ACPI_BITREG_BUS_MASTER_RLD, 1, ACPI_MTX_DO_NOT_LOCK);
			/* also reset bm_sts bit ?!? */
			pr->power.bm_activity++;
		}
		else{
			printk(KERN_INFO "Did not wake up from C3 from bus master activity\n");
		}
		pr->power.bm_check_timestamp += ticks_to_jiffies(td);

Hmm I wonder what the difference is after waking up and checking for bm_rld or bm_sts bit ...

          Thomas
