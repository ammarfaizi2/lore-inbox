Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbVLHSQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbVLHSQN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 13:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbVLHSQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 13:16:13 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:991 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932081AbVLHSQM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 13:16:12 -0500
Message-ID: <439889FA.BB08E5E1@tv-sign.ru>
Date: Thu, 08 Dec 2005 22:31:06 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix RCU race in access of nohz_cpu_mask
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:
>
> Accessing  nohz_cpu_mask before incrementing rcp->cur is racy. It can
> cause tickless idle CPUs to be included in rsp->cpumask, which will
> extend graceperiods unnecessarily.
> ...
> @@ -244,15 +244,15 @@ static void rcu_start_batch(struct rcu_c
>
>         if (rcp->next_pending &&
>                         rcp->completed == rcp->cur) {
> -               /* Can't change, since spin lock held. */
> -               cpus_andnot(rsp->cpumask, cpu_online_map, nohz_cpu_mask);
> -
>                 rcp->next_pending = 0;
>                 /* next_pending == 0 must be visible in __rcu_process_callbacks()
>                  * before it can see new value of cur.
>                  */
>                 smp_wmb();
>                 rcp->cur++;
> +               smp_mb();
> +               cpus_andnot(rsp->cpumask, cpu_online_map, nohz_cpu_mask);
> +

Could you explain why this patch makes any difference?

grep shows the only user of nohz_cpu_mask in arch/s390/kernel/time.c,
start_hz_timer() and stop_hz_timer().

I can't see how this change can prevent idle cpus to be included in
->cpumask, cpu can add itself to nohz_cpu_mask right after some other
cpu started new grace period.

I think cpu should call cpu_quiet() after adding itself to nohz mask
to eliminate this race.

No?

Oleg.
