Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbWD3GpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbWD3GpT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 02:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbWD3GpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 02:45:19 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:9743 "EHLO spitz.ucw.cz")
	by vger.kernel.org with ESMTP id S1750987AbWD3GpS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 02:45:18 -0400
Date: Sun, 30 Apr 2006 06:45:05 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Shaohua Li <shaohua.li@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] don't use flush_tlb_all in suspend time
Message-ID: <20060430064505.GA5091@ucw.cz>
References: <1146367462.21486.10.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1146367462.21486.10.camel@sli10-desk.sh.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> flush_tlb_all uses on_each_cpu, which will disable/enable interrupt.
> In suspend/resume time, this will make interrupt wrongly enabled.

> diff -puN arch/i386/mm/init.c~flush_tlb_all_check arch/i386/mm/init.c
> --- linux-2.6.17-rc3/arch/i386/mm/init.c~flush_tlb_all_check	2006-04-29 08:47:05.000000000 +0800
> +++ linux-2.6.17-rc3-root/arch/i386/mm/init.c	2006-04-29 08:48:15.000000000 +0800
> @@ -420,7 +420,10 @@ void zap_low_mappings (void)
>  #else
>  		set_pgd(swapper_pg_dir+i, __pgd(0));
>  #endif
> -	flush_tlb_all();
> +	if (cpus_weight(cpu_online_map) == 1)
> +		local_flush_tlb();
> +	else
> +		flush_tlb_all();
>  }
>

Either it is okay to enable interrupts here -> unneccessary and ugly
test, or it is not, and then we are broken in SMP case.

							Pavel
-- 
Thanks, Sharp!
