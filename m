Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965029AbWIEI3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965029AbWIEI3O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 04:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964993AbWIEI3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 04:29:14 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:59616 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964943AbWIEI3N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 04:29:13 -0400
Date: Tue, 5 Sep 2006 10:28:57 +0200
From: Pavel Machek <pavel@ucw.cz>
To: abelay@novell.com, len.brown@intel.com, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
       arjan@linux.intel.com
Subject: Re: [RFC][PATCH 2/2] ACPI: handle timer ticks proactively
Message-ID: <20060905082855.GC5082@elf.ucw.cz>
References: <20060904131027.GD6279@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060904131027.GD6279@ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch takes advantage of the infrastructure introduced in the last
> patch, and allows the processor idle algorithm to proactively choose a
> c-state based on the time the next timer interrupt is expected to occur.
> It preserves the residency metric, so the algorithm should, in theory,
> remain effective against bursts of activity from other interrupt
> sources.
> 
> This patch is mostly intended to be illustrative.  There may be some
> "#ifdef CONFIG_ACPI" issues, and I would appreciate any advice on
> implementing this more cleanly.
> 
> Cheers,
> Adam

> --- a/kernel/timer.c	2006-08-03 13:39:22.000000000 -0400
> +++ b/kernel/timer.c	2006-08-28 17:16:36.000000000 -0400
> @@ -41,6 +41,9 @@
>  #include <asm/timex.h>
>  #include <asm/io.h>
>  
> +#include <acpi/acpi_bus.h>
> +#include <acpi/processor.h>
> +

I sense a problem here, like broken compilation for all non-x86
platforms.

> @@ -1175,6 +1178,10 @@
>  {
>  	struct task_struct *p = current;
>  	int cpu = smp_processor_id();
> +	struct acpi_processor *pr = processors[cpu];
> +
> +	if (pr)
> +		pr->power.timer_tick = inl(acpi_fadt.xpm_tmr_blk.address);
>

This probably needs to be encapsulated, somehow.

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
