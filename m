Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266461AbUFQMAZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266461AbUFQMAZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 08:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266462AbUFQMAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 08:00:25 -0400
Received: from [213.146.154.40] ([213.146.154.40]:30122 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266461AbUFQMAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 08:00:21 -0400
Date: Thu, 17 Jun 2004 13:00:20 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Takao Indoh <indou.takao@soft.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@muc.de>
Subject: Re: [3/4] [PATCH]Diskdump - yet another crash dump function
Message-ID: <20040617120020.GA30691@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Takao Indoh <indou.takao@soft.fujitsu.com>,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	Andi Kleen <ak@muc.de>
References: <20040527210447.GA2029@elte.hu> <C7C4545F11DFBEindou.takao@soft.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C7C4545F11DFBEindou.takao@soft.fujitsu.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2004 at 08:34:37PM +0900, Takao Indoh wrote:
> Instead of redefinition, I add hooks into the timer/tasklet routines.
> 
> ex.
> 
>  int mod_timer(struct timer_list *timer, unsigned long expires)
>  {
>  	BUG_ON(!timer->function);
> 
> +	if (crashdump_mode()) {
> +		return diskdump_mod_timer(timer, expires);
> +	}
>  
>  	 check_timer(timer);
> 
> Please see the following patches for details.
> How do you think? 

Looks good in principle, some more comments on the actual patch below:

> diff -Nur linux-2.6.6.org/include/linux/diskdumplib.h linux-2.6.6/include/linux/diskdumplib.h
> --- linux-2.6.6.org/include/linux/diskdumplib.h	1970-01-01 09:00:00.000000000 +0900
> +++ linux-2.6.6/include/linux/diskdumplib.h	2004-06-17 18:28:01.000000000 +0900

Should probably just go to linux/dump.h or dump_priv.h

> diff -Nur linux-2.6.6.org/include/linux/interrupt.h linux-2.6.6/include/linux/interrupt.h
> --- linux-2.6.6.org/include/linux/interrupt.h	2004-06-04 21:22:09.000000000 +0900
> +++ linux-2.6.6/include/linux/interrupt.h	2004-06-17 18:28:01.000000000 +0900
> @@ -7,6 +7,7 @@
>  #include <linux/linkage.h>
>  #include <linux/bitops.h>
>  #include <linux/preempt.h>
> +#include <linux/diskdumplib.h>
>  #include <asm/atomic.h>
>  #include <asm/hardirq.h>
>  #include <asm/ptrace.h>
> @@ -172,6 +173,11 @@
>  
>  static inline void tasklet_schedule(struct tasklet_struct *t)
>  {
> +	if (crashdump_mode()) {
> +		diskdump_tasklet_schedule(t);
> +		return;
> +	}
> +
>  	if (!test_and_set_bit(TASKLET_STATE_SCHED, &t->state))
>  		__tasklet_schedule(t);
>  }

Please sprinclde unlikely's all over here.  Also the above could be
shortened to

static inline void tasklet_schedule(struct tasklet_struct *t)
{
	if (unlikely(crashdump_mode()))
		diskdump_tasklet_schedule(t);
	else if (!test_and_set_bit(TASKLET_STATE_SCHED, &t->state))
		__tasklet_schedule(t);
}

> +int diskdump_schedule_work(struct work_struct *work)
> +{
> +	list_add_tail(&work->entry, &diskdump_workq);
> +	return 1;
> +}

Should probably just inlined, I guess the function call is bigger
than all of list_add_tail.

> +void diskdump_add_timer(struct timer_list *timer)
> +{
> +	timer->base = (void *)1;
> +	list_add(&timer->entry, &diskdump_timers);
> +}

dito.

> +	/* run timers */
> +	list_for_each_safe(t, n, &diskdump_timers) {
> +		timer = list_entry(t, struct timer_list, entry);

list_for_each_entry_safe here please.

> @@ -255,6 +255,10 @@
>  {
>  	BUG_ON(!timer->function);
>  
> +	if (crashdump_mode()) {
> +		return diskdump_mod_timer(timer, expires);
> +	}

please remove the superflous braces here.

