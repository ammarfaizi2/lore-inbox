Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264934AbUGMMv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264934AbUGMMv3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 08:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264953AbUGMMv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 08:51:29 -0400
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:33657 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264934AbUGMMv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 08:51:27 -0400
Message-ID: <40F3DACC.9070703@yahoo.com.au>
Date: Tue, 13 Jul 2004 22:51:24 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: preempt-timing-2.6.8-rc1
References: <20040713122805.GZ21066@holomorphy.com>
In-Reply-To: <20040713122805.GZ21066@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> This patch uses the preemption counter increments and decrements to time
> non-preemptible critical sections.
> 
> This is an instrumentation patch intended to help determine the causes of
> scheduling latency related to long non-preemptible critical sections.
> 
> Changes from 2.6.7-based patch:
> (1) fix unmap_vmas() check correctly this time
> (2) add touch_preempt_timing() to cond_resched_lock()
> (3) depend on preempt until it's worked out wtf goes wrong without it
> 
> --- timing-2.6.8-rc1.orig/kernel/printk.c	2004-07-11 10:35:31.000000000 -0700
> +++ timing-2.6.8-rc1/kernel/printk.c	2004-07-13 03:56:37.901603496 -0700
> @@ -650,10 +650,8 @@
>   */
>  void console_conditional_schedule(void)
>  {
> -	if (console_may_schedule && need_resched()) {
> -		set_current_state(TASK_RUNNING);
> -		schedule();
> -	}
> +	if (console_may_schedule)
> +		cond_resched();
>  }

You should send that one in

> +void dec_preempt_count(void)
> +{
> +	if (preempt_count() == 1 && system_state == SYSTEM_RUNNING &&
> +					__get_cpu_var(preempt_entry)) {
> +		u64 hold;
> +		unsigned long preempt_exit
> +				= (unsigned long)__builtin_return_address(0);
> +		hold = sched_clock() - __get_cpu_var(preempt_timings) + 999999;
> +		do_div(hold, 1000000);
> +		if (preempt_thresh && hold > preempt_thresh &&
> +							printk_ratelimit()) {

This looks wrong. This means hold times of 1ns to 1000000ns trigger the
exceeded 1ms threshold, 1000001 to 2000000 trigger the 2ms one, etc.

Removing the + 999999 gives the correct result:
1000000 - 1999999ns triggers the 1ms threshold
2000000 - 2999999ns triggers the 2ms threshold
etc

Or have I missed something?
