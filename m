Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbVJaUvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbVJaUvI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 15:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbVJaUvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 15:51:08 -0500
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:53005 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751278AbVJaUvG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 15:51:06 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: jgarzik@pobox.com (Jeff Garzik)
Subject: Re: [PATCH] kill 8139too kernel thread (sorta)
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <20051031130255.GA26626@havoc.gtf.org>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1EWgcG-0001dZ-00@gondolin.me.apana.org.au>
Date: Tue, 01 Nov 2005 07:50:52 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> +       if ((tp->time_to_die == 0) &&
> +           (rtnl_lock_interruptible() == 0)) {
>                rtl8139_thread_iter (dev, tp, tp->mmio_addr);
>                rtnl_unlock ();
>        }
> 
> -       complete_and_exit (&tp->thr_exited, 0);
> +       if (tp->time_to_die == 0)
> +               schedule_delayed_work(&tp->thread, next_tick);
> }

...

> +static void rtl8139_stop_thread(struct rtl8139_private *tp)
> +{
> +       if (tp->time_to_die < 0)
> +               return;
> +
> +       tp->time_to_die = 1;
> +       wmb();
> +
> +       if (cancel_delayed_work(&tp->thread) == 0)
> +               flush_scheduled_work();
> }

Race alert:

CPU0					CPU1
rtl8139_thread
	rtnl_lock
	rtl8139_thread_iter
	rtnl_unlock
	tp->time_to_die == 0
					rtl8139_stop_thread
						tp->time_to_die = 1
						cancel_delayed_work == 0
							flush_scheduled_work
		schedule_delayed_work

So by the time rtl8139_stop_thread returns, the work is still scheduled.

The standard way to solve this is to get rid of the time_to_die check
in rtl8139_thread before the rescheduling and then use the horrible
cancel_rearming_delayed_workqueue function.

However, in this case it's much easier than that.  Simply change
rtl8139_thread to do

	rtnl_lock();
	if (tp->time_to_die == 0) {
		rtl8139_thread_iter(dev, tp, tp->mmio_addr);
		schedule_delayed_work(&tp->thread, next_tick);
	}
	rtnl_unlock();

This is not racy because rtl8139_stop_thread is also run under the
RTNL.  Furthermore, you don't need the interruptible version anymore
since you are no longer using kill to kill the thread.

This also fixes the bug that if you fail to acquire RTNL the Work
is delayed by another next_tick ticks.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
