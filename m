Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265077AbUE0Taz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265077AbUE0Taz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 15:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265088AbUE0Taz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 15:30:55 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:24020 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265077AbUE0Tan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 15:30:43 -0400
Date: Thu, 27 May 2004 21:25:37 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] SMP support for drain local pages.
Message-ID: <20040527192537.GC509@openzaurus.ucw.cz>
References: <40B473F7.4000100@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40B473F7.4000100@linuxmail.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch adds SMP support for drain_local_pages, so that suspend
> implementations can drain pcp structures on all CPUs and thus 
> accurately
> determine which pages are free.

Why do you need it, btw?

1st it might be easier to just on_each_cpu(drain_local_pages)
in suspend2

2nd all but one cpus are stopped, right? That mrans that their local pages can't
mess up suspnd's accounting => no need to drain them.
				Pavel

2.6.6-current-bk/mm/page_alloc.c 
> smp-drain-local-pages/mm/page_alloc.c
> --- 2.6.6-current-bk/mm/page_alloc.c    2004-05-26 19:47:15.000000000 
> +1000
> +++ smp-drain-local-pages/mm/page_alloc.c       2004-05-26 
> 19:56:19.000000000 +1000
> @@ -459,6 +459,24 @@
>         __drain_pages(smp_processor_id());
>         local_irq_restore(flags);
>  }
> +
> +#ifdef CONFIG_SMP
> +static void __smp_drain_local_pages(void * data)
> +{
> +       drain_local_pages();
> +}
> +
> +void smp_drain_local_pages(void)
> +{
> +       smp_call_function(__smp_drain_local_pages, NULL, 0, 1);
> +       drain_local_pages();
> +}
> +#else
> +void smp_drain_local_pages(void)
> +{
> +       drain_local_pages();
> +}
> +#endif
>  #endif /* CONFIG_PM */
> 
>  static void zone_statistics(struct zonelist *zonelist, struct zone 
>  *z)
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

