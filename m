Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbWE3GOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbWE3GOz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 02:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbWE3GOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 02:14:55 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:6560 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932156AbWE3GOy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 02:14:54 -0400
Date: Tue, 30 May 2006 08:15:04 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Simon Derr <Simon.Derr@bull.net>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>
Subject: Re: -rt IA64 update
Message-ID: <20060530061503.GA19870@elte.hu>
References: <Pine.LNX.4.61.0605291356170.14092@openx3.frec.bull.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0605291356170.14092@openx3.frec.bull.fr>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Simon Derr <Simon.Derr@bull.net> wrote:

> Hi Ingo,
> 
> This is an update of my IA64 port, against -rt25.

thanks - i have applied it.

> I have modified check_pgt_cache() as we discussed before, and the raw 
> spinlock in the struct zone is no longer needed.

ok, great!

> There's also a preliminary and certainly very bogus attempt to have 
> the HR timers on IA64. I'd love to have comments on that part.
> 
> Some bits of the Kconfig have been stolen from a previous patch by 
> Eric Piel.

i'll let Thomas and John comment on that - but at a quick glance it 
seems quite OK.

> This kernel boots OK on UP and SMP, and runs the sched_football test 
> successfully.
> 
> 
> A few notes:
> 
> * You can see at the end of the patch this ugly thing in 
> clockevents_set_next_event()
> 
> +#ifndef CONFIG_IA64
>         clc = mpy_sc32((unsigned long) delta, sources->nextevt->mult);
> +#else
> +       clc = (unsigned long) delta * (unsigned long) sources->nextevt->mult;
> +       clc = clc >> sources->nextevt->shift;
> +#endif
> +
> 
> I made this ia64-only, but it seems to me that this code should be 
> fixed as it works only for clocksources that have shift=32.

yeah, agreed.

> * This kernel, when booting, prints:
> 
> 	BUG in check_monotonic_clock at kernel/time/timeofday.c:164
> 
> But I think this happens because two get_monotonic_clock() are racing 
> on two cpus. There is a lock to prevent the race, but it is a seqlock. 
> That means that it is okay if the race happens since another try will 
> be attempted, but the message that has been printed on the console 
> can't be removed, and the user is unnecessarily scared.

that too comes from the GTOD patchset. John, should we pick up the 
latest from -mm?

	Ingo
