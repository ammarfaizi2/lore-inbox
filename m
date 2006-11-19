Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755527AbWKSCJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755527AbWKSCJq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 21:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755538AbWKSCJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 21:09:46 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:8067 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1755527AbWKSCJq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 21:09:46 -0500
Date: Sun, 19 Nov 2006 03:09:26 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [PATCH 2/4] swsusp: Untangle freeze_processes
Message-ID: <20061119020926.GD15873@elf.ucw.cz>
References: <200611182335.27453.rjw@sisk.pl> <200611182347.16692.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611182347.16692.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Move the loop from freeze_processes() to a separate function and call it
> independently for user space processes and kernel threads so that the order of
> freezing tasks is clearly visible.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  kernel/power/process.c |   88 ++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 58 insertions(+), 30 deletions(-)
>

>  		do_each_thread(g, p) {
> +			if (is_user_space(p)) {
> +				if(!freeze_user_space)
> +					continue;
> +			} else {
> +				if(freeze_user_space)
> +					continue;
> +			}

Needs space between if and (, but lets use if (is_user_space() !=
freeze_user_space) trick here, too. 

> +/**
> + *	freeze_processes - tell processes to enter the refrigerator
> + *
> + *	Returns 0 on success, or the number of processes that didn't freeze,
> + *	although they were told to.
> + */

Above you point out to the broken calling convention. Perhaps this is
great time to fix it, too? Hmm, or maybe not. Patch looks good,
otherwise.

							Pavel
> +int freeze_processes(void)
> +{
> +	unsigned int nr_unfrozen;
> +
> +	printk("Stopping tasks ... ");
> +	nr_unfrozen = try_to_freeze_tasks(FREEZER_USER_SPACE);
> +	if (nr_unfrozen)
> +		return nr_unfrozen;
> +
> +	sys_sync();
> +	nr_unfrozen = try_to_freeze_tasks(FREEZER_KERNEL_THREADS);
> +	if (nr_unfrozen)
> +		return nr_unfrozen;
> +
>  	printk("done.\n");
>  	BUG_ON(in_atomic());
>  	return 0;

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
