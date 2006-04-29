Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbWD2GZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWD2GZE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 02:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWD2GZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 02:25:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24032 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750707AbWD2GZC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 02:25:02 -0400
Date: Fri, 28 Apr 2006 23:23:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: a.zummo@towertech.it, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RTC: rtc-dev UIE emulation
Message-Id: <20060428232306.5049c30d.akpm@osdl.org>
In-Reply-To: <20060429.011648.25910123.anemo@mba.ocn.ne.jp>
References: <20060429.011648.25910123.anemo@mba.ocn.ne.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
>
> Import genrtc's RTC UIE emulation (CONFIG_GEN_RTC_X) to rtc-dev driver
> with slight adjustments.  This makes UIE-less chips/drivers work
> better with programs doing read/poll on /dev/rtc, such as hwclock.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 65d090d..29ca46c 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -73,6 +73,12 @@ config RTC_INTF_DEV
>  	  This driver can also be built as a module. If so, the module
>  	  will be called rtc-dev.
>  
> +config RTC_INTF_DEV_X
> +	bool "Extended RTC operation"
> +	depends on RTC_INTF_DEV
> +	help
> +	  Provides an emulation for RTC_UIE.
> +

That help is somewhat terse.  A user might have trouble working out what it
does, and whether it's something they want to use.

>  comment "RTC drivers"
>  	depends on RTC_CLASS
>  
> diff --git a/drivers/rtc/rtc-dev.c b/drivers/rtc/rtc-dev.c
> index b1e3e61..0bbd181 100644
> --- a/drivers/rtc/rtc-dev.c
> +++ b/drivers/rtc/rtc-dev.c
> @@ -48,6 +48,93 @@ static int rtc_dev_open(struct inode *in
>  	return err;
>  }
>  
> +#ifdef CONFIG_RTC_INTF_DEV_X
> +/*
> + * Routine to poll RTC seconds field for change as often as possible,
> + * after first RTC_UIE use timer to reduce polling
> + */
> +static void rtc_uie_task(void *data)
> +{
> +	struct rtc_device *rtc = data;
> +	struct rtc_time tm;
> +	unsigned int tmp = rtc_read_time(&rtc->class_dev, &tm) ? 0 : tm.tm_sec;

If rtc_read_time() fails we proceed as if it returned 0.

Are you sure that's correct?

(In practice, it cannot fail.  Or, if it does, it'll fail 100% of the time.
 But still...)

> +	int num = 0;
> +
> +	spin_lock_irq(&rtc->irq_lock);
> +	if (rtc->stop_rtc_timers) {
> +		rtc->stask_active = 0;
> +		spin_unlock_irq(&rtc->irq_lock);
> +		return;
> +	}
> +
> +	if (rtc->oldsecs != tmp) {
> +		num = (tmp + 60 - rtc->oldsecs) % 60;
> +		rtc->oldsecs = tmp;
> +
> +		rtc->timer_task.expires = jiffies + HZ - (HZ/10);
> +		rtc->ttask_active = 1;
> +		rtc->stask_active = 0;
> +		add_timer(&rtc->timer_task);
> +	} else if (schedule_work(&rtc->uie_task) == 0)
> +		rtc->stask_active = 0;
> +	spin_unlock_irq(&rtc->irq_lock);
> +	if (num)
> +		rtc_update_irq(&rtc->class_dev, num, RTC_UF | RTC_IRQF);
> +}
> +
> +static void rtc_uie_timer(unsigned long data)
> +{
> +	struct rtc_device *rtc = (struct rtc_device *)data;
> +	unsigned long flags;
> +	spin_lock_irqsave(&rtc->irq_lock, flags);
> +	rtc->ttask_active = 0;
> +	rtc->stask_active = 1;
> +	if ((schedule_work(&rtc->uie_task) == 0))
> +		rtc->stask_active = 0;
> +	spin_unlock_irqrestore(&rtc->irq_lock, flags);
> +}

I see a schedule_work(), but I don't see a flush_scheduled_work().  Is
there anything preventing the scheduled work from still being pending after a
close() or an rmmod?

> +static void clear_uie(struct rtc_device *rtc)
> +{
> +	spin_lock_irq(&rtc->irq_lock);
> +	rtc->stop_rtc_timers = 1;
> +	if (rtc->ttask_active) {
> +		spin_unlock_irq(&rtc->irq_lock);
> +		del_timer_sync(&rtc->timer_task);
> +		spin_lock(&rtc->irq_lock);

Presumably that should be spin_lock_irq().

> +		rtc->ttask_active = 0;
> +	}
> +	while (rtc->stask_active) {
> +		spin_unlock_irq(&rtc->irq_lock);
> +		schedule();
> +		spin_lock_irq(&rtc->irq_lock);
> +	}

That's a busywait.  Please let's find a better way of doing this.

That way might be a flush_scheduled_work().  I don't know, because it's not
immediately clear what the responsibilities of this function are.  Please
add some comments to the code which explain things like this.

> +	rtc->irq_active = 0;
> +	spin_unlock_irq(&rtc->irq_lock);
> +}
> +
> +static void set_uie(struct rtc_device *rtc)
> +{
> +	int start = 0;
> +	spin_lock_irq(&rtc->irq_lock);
> +	if (!rtc->irq_active)
> +		start = rtc->irq_active = 1;
> +	rtc->irq_data = 0;
> +	spin_unlock_irq(&rtc->irq_lock);
> +	if (start) {
> +		struct rtc_time tm;
> +		rtc->stop_rtc_timers = 0;
> +		INIT_WORK(&rtc->uie_task, rtc_uie_task, rtc);
> +		rtc->oldsecs = rtc_read_time(&rtc->class_dev, &tm) ?
> +			0 : tm.tm_sec;
> +		setup_timer(&rtc->timer_task, rtc_uie_timer,
> +			    (unsigned long)rtc);
> +		rtc->stask_active = 1;
> +		if (schedule_work(&rtc->uie_task) == 0)
> +			rtc->stask_active = 0;
> +	}
> +}

Sometimes you have a blank line after the the declarations of the local
variables, sometimes not.  I prefer it to be there, personally.

The above code is slightly racy,

> +#ifdef CONFIG_RTC_INTF_DEV_X
> +	struct work_struct uie_task;
> +	struct timer_list timer_task;
> +	unsigned int oldsecs;
> +	unsigned int irq_active :1;
> +	unsigned int stop_rtc_timers :1;	/* don't requeue tasks */
> +	unsigned int stask_active :1;		/* schedule_work */
> +	unsigned int ttask_active :1;		/* timer_task */
> +#endif


because all these bitfields will occupy the same machine word.  We must
provide locking for that word, because the compiler won't do it.

Generally, rtc->irq_lock does provide that locking.  But not in the above
case - it's conceivable that the rtc_uie_task() callback will be executing
while this CPU is modifying rtc->stask_active.

A suitable fix would be to extend the rtc->irq_lock coverage here.  Plus,
of course, adding a comment above those four fields explaining what their
locking protocol is.

Also,

	unsigned int ttask_active:1;

is more conventional whitespace usage.

"timer_task" is a rather misleading name for a timer.  It implies that
it's, umm, a task.  "uie_timer", perhaps?

