Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751554AbWF1V3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554AbWF1V3r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 17:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751555AbWF1V3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 17:29:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22949 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751553AbWF1V3q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 17:29:46 -0400
Date: Wed, 28 Jun 2006 14:32:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: linux-kernel@vger.kernel.org, davej@redhat.com,
       alexey.y.starikovskiy@intel.com
Subject: Re: [RFC] Adding queue_delayed_work_on interface for workqueues
Message-Id: <20060628143242.486f9b15.akpm@osdl.org>
In-Reply-To: <20060628141028.A13221@unix-os.sc.intel.com>
References: <20060628141028.A13221@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Venkatesh Pallipadi <venkatesh.pallipadi@intel.com> wrote:
>
> 
> This patch is a part of cpufreq patches for ondemand governor optimizations
> and entire series is actually posted to cpufreq mailing list.
> Subject "minor optimizations to ondemand governor"
> 
> The following patch however is a generic change to workqueue interface and 
> I wanted to get comments on this on lkml.
> 
> ...
>
> Add queue_delayed_work_on() interface for workqueues.

It looks sensible to me.

> +extern int FASTCALL(queue_delayed_work_on(int cpu, struct workqueue_struct *wq, struct work_struct *work, unsigned long delay));

Please wrap at 80-cols.

I wouldn't bother making this FASTCALL.  It's an ugly thing, and why this
particular function?  And this isn't fastpath stuff.

>  
> -extern int schedule_delayed_work_on(int cpu, struct work_struct *work, unsigned long delay);
> +extern int FASTCALL(schedule_delayed_work_on(int cpu, struct work_struct *work, unsigned long delay));

Ditto.

>  }
>  
> +int fastcall queue_delayed_work_on(int cpu, struct workqueue_struct *wq,
> +			struct work_struct *work, unsigned long delay)
> +{
> +	int ret = 0;
> +	struct timer_list *timer = &work->timer;
> +
> +	if (!test_and_set_bit(0, &work->pending)) {
> +		BUG_ON(timer_pending(timer));
> +		BUG_ON(!list_empty(&work->entry));
> +
> +		/* This stores wq for the moment, for the timer_fn */
> +		work->wq_data = wq;
> +		timer->expires = jiffies + delay;
> +		timer->data = (unsigned long)work;
> +		timer->function = delayed_work_timer_fn;
> +		add_timer_on(timer, cpu);
> +		ret = 1;
> +	}
> +	return ret;
> +}

Feel free to add some kernel-doc for this function ;)

> @@ -608,6 +615,7 @@ void init_workqueues(void)
>  EXPORT_SYMBOL_GPL(__create_workqueue);
>  EXPORT_SYMBOL_GPL(queue_work);
>  EXPORT_SYMBOL_GPL(queue_delayed_work);
> +EXPORT_SYMBOL_GPL(queue_delayed_work_on);
>  EXPORT_SYMBOL_GPL(flush_workqueue);
>  EXPORT_SYMBOL_GPL(destroy_workqueue);

Opinions vary a bit, but I think we mostly prefer to put the
EXPORT_SYMBOL()s at the site of the thing which is being exported:

foo()
{
}
EXPORT_SYMBOL(foo);

because it keeps all the info in the same place.  (We don't declare
functions to be static or to return char* or to be __init at a different
place in the source file..).

Then again, it's legit to follow existing local style too.  Someone will
come along later and fix it all in a single hit.  Whatever.

