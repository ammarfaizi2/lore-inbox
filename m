Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265446AbUF2E7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265446AbUF2E7N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 00:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265455AbUF2E7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 00:59:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:60396 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265446AbUF2E66 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 00:58:58 -0400
Date: Mon, 28 Jun 2004 21:57:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: george@mvista.com
Cc: boris.hu@intel.com, drepper@redhat.com, adam.li@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bugfix for CLOCK_REALTIME absolute timer.
Message-Id: <20040628215748.4ea128bc.akpm@osdl.org>
In-Reply-To: <40E0F48F.4030205@mvista.com>
References: <37FBBA5F3A361C41AB7CE44558C3448E04561419@PDSMSX403.ccr.corp.intel.com>
	<40E0F48F.4030205@mvista.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Anzinger <george@mvista.com> wrote:
>
> Ok, I think this does it.

patching file kernel/posix-timers.c
Hunk #10 FAILED at 529.
Hunk #11 succeeded at 776 (offset 18 lines).
Hunk #13 succeeded at 863 (offset 18 lines).
Hunk #15 succeeded at 977 (offset 18 lines).
Hunk #17 succeeded at 1062 (offset 18 lines).
Hunk #19 succeeded at 1435 (offset 18 lines).
1 out of 20 hunks FAILED -- saving rejects to file kernel/posix-timers.c.rej

I fixed that up - please test next -mm, check that it all works?

 +	do {
 +		do {
 +			seq = read_seqbegin(&xtime_lock);
 +			new_wall_to =	wall_to_monotonic;
 +		} while (read_seqretry(&xtime_lock, seq));
 +
 +		spin_lock_irq(&abs_list.lock);
 +		if (list_empty(&cws_list)) {
 +			spin_unlock_irq(&abs_list.lock);
 +			break;
 +		}
 +		timr = list_entry(cws_list.next, struct k_itimer, 
 +				   abs_timer_entry);
 +		
 +		list_del_init(&timr->abs_timer_entry);
 +		if (add_clockset_delta(timr, &new_wall_to) &&
 +		    del_timer(&timr->it_timer))  /* timer run yet? */
 +			add_timer(&timr->it_timer);
 +		list_add(&timr->abs_timer_entry, &abs_list.list);
 +		spin_unlock_irq(&abs_list.lock);
 +	} while (1);

nanonit:

	for ( ; ; ) {
		...
	}

is more readable than

	do {
		...
	} while (1);

because you can see what it's doing as the eye enters the code...
