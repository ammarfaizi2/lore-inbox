Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbWBMKvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWBMKvy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 05:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbWBMKvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 05:51:54 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:49798
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932084AbWBMKvx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 05:51:53 -0500
Subject: Re: [PATCH 01/13] hrtimer: round up relative start time
From: Thomas Gleixner <tglx@linutronix.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <Pine.LNX.4.61.0602130207560.23745@scrub.home>
References: <Pine.LNX.4.61.0602130207560.23745@scrub.home>
Content-Type: text/plain
Date: Mon, 13 Feb 2006 10:52:07 +0000
Message-Id: <1139827927.4932.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.5 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-13 at 02:09 +0100, Roman Zippel wrote:
> When starting a relative timer we have to round it up the next clock
> tick to avoid an early expiry. The problem is that we don't know the
> real clock resolution, so we have to assume the worst case, but it's
> basically the same as the old code did, so it won't be worse than 2.6.15
> and with a better clock interface we can improve this.
> 
> Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

NACK

This adds an artificial offset to the expiry time, for what reason? The
expiry code makes sure that timers can not expire early. See:

	timer = rb_entry(node, struct hrtimer, node);
	if (now.tv64 <= timer->expires.tv64)
		break;

in kernel/hrtimers.c:run_hrtimer_queue(), where now is already tick
aligned.

Please provide a testcase (or detailed use-case) which proves that this
is necessary.

	tglx

> ---
> 
>  kernel/hrtimer.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6-git/kernel/hrtimer.c
> ===================================================================
> --- linux-2.6-git.orig/kernel/hrtimer.c	2006-02-12 18:32:48.000000000 +0100
> +++ linux-2.6-git/kernel/hrtimer.c	2006-02-12 18:32:57.000000000 +0100
> @@ -419,7 +419,8 @@ hrtimer_start(struct hrtimer *timer, kti
>  	new_base = switch_hrtimer_base(timer, base);
>  
>  	if (mode == HRTIMER_REL)
> -		tim = ktime_add(tim, new_base->get_time());
> +		tim = ktime_add(ktime_add(tim, new_base->get_time()),
> +				base->resolution);
>  	timer->expires = tim;
>  
>  	enqueue_hrtimer(timer, new_base);

