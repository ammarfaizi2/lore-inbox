Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265257AbUF1WSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265257AbUF1WSo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 18:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265261AbUF1WSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 18:18:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:37552 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265257AbUF1WSl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 18:18:41 -0400
Date: Mon, 28 Jun 2004 15:17:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: george@mvista.com
Cc: boris.hu@intel.com, drepper@redhat.com, adam.li@intel.com,
       linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: [PATCH] Bugfix for CLOCK_REALTIME absolute timer.
Message-Id: <20040628151725.09b691e4.akpm@osdl.org>
In-Reply-To: <40E094DB.9000702@mvista.com>
References: <37FBBA5F3A361C41AB7CE44558C3448E04561419@PDSMSX403.ccr.corp.intel.com>
	<40E094DB.9000702@mvista.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Anzinger <george@mvista.com> wrote:
>
> Andrew,
> 
> Boris and I have kicked this around enough.  It think it is ready for prime time.
> 

>  static void schedule_next_timer(struct k_itimer *timr)
>  {
> ...
> +	do {
> +		seq = read_seqbegin(&xtime_lock);
> +		new_wall_to =	wall_to_monotonic;
> +		posix_get_now(&now);
> +	} while (read_seqretry(&xtime_lock, seq));
> +
> +	if (!list_empty(&timr->abs_timer_entry)) {
> +		spin_lock(&abs_list.lock);
> +		add_clockset_delta(timr, &new_wall_to);
> +	}
> +		    
>  	do {
>  		posix_bump_timer(timr);
>  	}while (posix_time_before(&timr->it_timer, &now));
>  
> +	if (!list_empty(&timr->abs_timer_entry))
> +		spin_unlock(&abs_list.lock);

The locking in here is a bit ugly.  Does the lock actually need to be held while
the timer is being bumped?

And what is the upper bound on that while loop?

>  	tmr->it_id = (timer_t)-1;
> +        INIT_LIST_HEAD(&tmr->abs_timer_entry);
>  	if (unlikely(!(tmr->sigq = sigqueue_alloc()))) {

The cat ate your tab key? ;)

> +	if (!list_empty(&timr->abs_timer_entry)) {
> +		spin_lock(&abs_list.lock);
> +		list_del_init(&timr->abs_timer_entry);
> +		spin_unlock(&abs_list.lock);
> +	}

This is repeated often.  Does it merit its own function?

> +static DECLARE_MUTEX(clock_was_set_lock);
> +#define mutex_enter(x) down(x)
> +#define mutex_enter_interruptable(x) down_interruptible(x)
> +#define mutex_exit(x) up(x)

Please open-code these operations.


