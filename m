Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262218AbVAYXnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262218AbVAYXnQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 18:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262232AbVAYXmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 18:42:45 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:14074 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262218AbVAYXjS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 18:39:18 -0500
Message-ID: <41F6D8A0.5090404@mvista.com>
Date: Tue, 25 Jan 2005 15:39:12 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] posix-timers: CPU clock support for POSIX timers
References: <200501232325.j0NNPUg7006501@magilla.sf.frob.com> <41F5AF72.8000502@mvista.com> <Pine.LNX.4.58.0501241834190.19044@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0501251450080.26368@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.58.0501251450080.26368@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Mon, 24 Jan 2005, Christoph Lameter wrote:
> 
> 
>>It would be great to have a kind of private field that other clocks (like
>>clock drivers) could use for their purposes. mmtimer f.e. does use some
>>of the fields for the tick based timers for its purposes.
> 
> 
> On that note:
> 
> Your patch breaks the mmtimer driver because it used k_itimer values for
> its own purposes. Here is a fix by defining an additional structure
> in k_itimer (same approach for mmtimer as the cpu timers):

I would like to get a read on the following defines...
#define mmclock mmtimer.clock
#define mmnode  mmtimer.node
#define mmincr  mmtimer.incr
#define mmexpires mmtimer.expires

Then, of course, you would use the defines instead of the "." references.  Is 
this a big no-no in kernel code.  Seems to me it makes things a bit easier to read.

George
> 
> Signed-off-by: Christoph Lameter <clameter@sgi.com>
> 
> Index: linux-2.6.10/include/linux/posix-timers.h
> ===================================================================
> --- linux-2.6.10.orig/include/linux/posix-timers.h	2005-01-25 14:35:11.000000000 -0800
> +++ linux-2.6.10/include/linux/posix-timers.h	2005-01-25 14:35:16.000000000 -0800
> @@ -57,6 +57,12 @@ struct k_itimer {
>  			unsigned long incr; /* interval in jiffies */
>  		} real;
>  		struct cpu_timer_list cpu;
> +		struct {
> +			unsigned int clock;
> +			unsigned int node;
> +			unsigned long incr;
> +			unsigned long expires;
> +		} mmtimer;
>  	} it;
>  };
>
#define mmclock mmtimer.clock
#define mmnode  mmtimer.node
#define mmincr  mmtimer.incr
#define mmexpires mmtimer.expires
> Index: linux-2.6.10/drivers/char/mmtimer.c
> ===================================================================
> --- linux-2.6.10.orig/drivers/char/mmtimer.c	2005-01-25 14:35:09.000000000 -0800
> +++ linux-2.6.10/drivers/char/mmtimer.c	2005-01-25 14:34:41.000000000 -0800
> @@ -420,19 +420,19 @@ static int inline reschedule_periodic_ti
>  	int n;
>  	struct k_itimer *t = x->timer;
> 
> -	t->it_timer.magic = x->i;
> +	t->it.mmtimer.clock = x->i;
>  	t->it_overrun--;
> 
>  	n = 0;
>  	do {
> 
> -		t->it_timer.expires += t->it_incr << n;
> +		t->it.mmtimer.expires += t->it.mmtimer.incr << n;
>  		t->it_overrun += 1 << n;
>  		n++;
>  		if (n > 20)
>  			return 1;
> 
> -	} while (mmtimer_setup(x->i, t->it_timer.expires));
> +	} while (mmtimer_setup(x->i, t->it.mmtimer.expires));
> 
>  	return 0;
>  }
> @@ -468,7 +468,7 @@ mmtimer_interrupt(int irq, void *dev_id,
>  		spin_lock(&base[i].lock);
>  		if (base[i].cpu == smp_processor_id()) {
>  			if (base[i].timer)
> -				expires = base[i].timer->it_timer.expires;
> +				expires = base[i].timer->it.mmtimer.expires;
>  			/* expires test won't work with shared irqs */
>  			if ((mmtimer_int_pending(i) > 0) ||
>  				(expires && (expires < rtc_time()))) {
> @@ -505,7 +505,7 @@ void mmtimer_tasklet(unsigned long data)
> 
>  		t->it_overrun++;
>  	}
> -	if(t->it_incr) {
> +	if(t->it.mmtimer.incr) {
>  		/* Periodic timer */
>  		if (reschedule_periodic_timer(x)) {
>  			printk(KERN_WARNING "mmtimer: unable to reschedule\n");
> @@ -513,7 +513,7 @@ void mmtimer_tasklet(unsigned long data)
>  		}
>  	} else {
>  		/* Ensure we don't false trigger in mmtimer_interrupt */
> -		t->it_timer.expires = 0;
> +		t->it.mmtimer.expires = 0;
>  	}
>  	t->it_overrun_last = t->it_overrun;
>  out:
> @@ -524,7 +524,7 @@ out:
>  static int sgi_timer_create(struct k_itimer *timer)
>  {
>  	/* Insure that a newly created timer is off */
> -	timer->it_timer.magic = TIMER_OFF;
> +	timer->it.mmtimer.clock = TIMER_OFF;
>  	return 0;
>  }
> 
> @@ -535,8 +535,8 @@ static int sgi_timer_create(struct k_iti
>   */
>  static int sgi_timer_del(struct k_itimer *timr)
>  {
> -	int i = timr->it_timer.magic;
> -	cnodeid_t nodeid = timr->it_timer.data;
> +	int i = timr->it.mmtimer.clock;
> +	cnodeid_t nodeid = timr->it.mmtimer.node;
>  	mmtimer_t *t = timers + nodeid * NUM_COMPARATORS +i;
>  	unsigned long irqflags;
> 
> @@ -544,8 +544,8 @@ static int sgi_timer_del(struct k_itimer
>  		spin_lock_irqsave(&t->lock, irqflags);
>  		mmtimer_disable_int(cnodeid_to_nasid(nodeid),i);
>  		t->timer = NULL;
> -		timr->it_timer.magic = TIMER_OFF;
> -		timr->it_timer.expires = 0;
> +		timr->it.mmtimer.clock = TIMER_OFF;
> +		timr->it.mmtimer.expires = 0;
>  		spin_unlock_irqrestore(&t->lock, irqflags);
>  	}
>  	return 0;
> @@ -558,7 +558,7 @@ static int sgi_timer_del(struct k_itimer
>  static void sgi_timer_get(struct k_itimer *timr, struct itimerspec *cur_setting)
>  {
> 
> -	if (timr->it_timer.magic == TIMER_OFF) {
> +	if (timr->it.mmtimer.clock == TIMER_OFF) {
>  		cur_setting->it_interval.tv_nsec = 0;
>  		cur_setting->it_interval.tv_sec = 0;
>  		cur_setting->it_value.tv_nsec = 0;
> @@ -566,8 +566,8 @@ static void sgi_timer_get(struct k_itime
>  		return;
>  	}
> 
> -	ns_to_timespec(cur_setting->it_interval, timr->it_incr * sgi_clock_period);
> -	ns_to_timespec(cur_setting->it_value, (timr->it_timer.expires - rtc_time())* sgi_clock_period);
> +	ns_to_timespec(cur_setting->it_interval, timr->it.mmtimer.incr * sgi_clock_period);
> +	ns_to_timespec(cur_setting->it_value, (timr->it.mmtimer.expires - rtc_time())* sgi_clock_period);
>  	return;
>  }
> 
> @@ -640,19 +640,19 @@ retry:
>  	base[i].timer = timr;
>  	base[i].cpu = smp_processor_id();
> 
> -	timr->it_timer.magic = i;
> -	timr->it_timer.data = nodeid;
> -	timr->it_incr = period;
> -	timr->it_timer.expires = when;
> +	timr->it.mmtimer.clock = i;
> +	timr->it.mmtimer.node = nodeid;
> +	timr->it.mmtimer.incr = period;
> +	timr->it.mmtimer.expires = when;
> 
>  	if (period == 0) {
>  		if (mmtimer_setup(i, when)) {
>  			mmtimer_disable_int(-1, i);
>  			posix_timer_event(timr, 0);
> -			timr->it_timer.expires = 0;
> +			timr->it.mmtimer.expires = 0;
>  		}
>  	} else {
> -		timr->it_timer.expires -= period;
> +		timr->it.mmtimer.expires -= period;
>  		if (reschedule_periodic_timer(base+i))
>  			err = -EINVAL;
>  	}
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

