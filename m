Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbTGODwX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 23:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbTGODwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 23:52:23 -0400
Received: from zeus.kernel.org ([204.152.189.113]:56209 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261741AbTGODwW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 23:52:22 -0400
Date: Mon, 14 Jul 2003 20:59:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, efault@gmx.de, felipe_alfaro@linuxmail.org
Subject: Re: [PATCH] N1int for interactivity
Message-Id: <20030714205915.5a4c8d16.akpm@osdl.org>
In-Reply-To: <200307151355.23586.kernel@kolivas.org>
References: <200307151355.23586.kernel@kolivas.org>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> I've modified Mike Galbraith's nanosleep work for greater resolution to help 
> the interactivity estimator work I've done in the O*int patches.

> +inline void __scheduler_tick(runqueue_t *rq, task_t *p)

Two callsites, this guy shouldn't be inlined.

Should it have static scope?  The code as-is generates a third copy...

>  static unsigned long long monotonic_clock_tsc(void)
>  {
>  	unsigned long long last_offset, this_offset, base;
> -	
> +	unsigned long flags;
> +
>  	/* atomically read monotonic base & last_offset */
> -	read_lock_irq(&monotonic_lock);
> +	read_lock_irqsave(&monotonic_lock, flags);
>  	last_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
>  	base = monotonic_base;
> -	read_unlock_irq(&monotonic_lock);
> +	read_unlock_irqrestore(&monotonic_lock, flags);
>  
>  	/* Read the Time Stamp Counter */

Why do we need to take a global lock here?  Can't we use
get_cycles() or something?


Have all the other architectures been reviewed to see if they need this
change?

