Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267936AbUIPLO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267936AbUIPLO6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 07:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267935AbUIPLO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 07:14:57 -0400
Received: from gprs214-194.eurotel.cz ([160.218.214.194]:20098 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S267920AbUIPLOx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 07:14:53 -0400
Date: Thu, 16 Sep 2004 13:14:38 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend2 Merge: e820 table support.
Message-ID: <20040916111438.GB5467@elf.ucw.cz>
References: <1095332590.3324.166.camel@laptop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095332590.3324.166.camel@laptop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch adds support for the e820 table for swsusp and Suspend2. It
> does so by setting the NoSave flag for unsavable pages at boot time.

> @@ -27,6 +27,9 @@
>  #include <linux/slab.h>
>  #include <linux/proc_fs.h>
>  #include <linux/efi.h>
> +#ifdef CONFIG_SOFTWARE_SUSPEND2
> +#include <linux/suspend-common.h>
> +#endif
>  
>  #include <asm/processor.h>
>  #include <asm/system.h>
> @@ -264,12 +267,19 @@
>  {
>  	if (page_is_ram(pfn) && !(bad_ppro && page_kills_ppro(pfn))) {
>  		ClearPageReserved(page);
> +#ifdef CONFIG_SOFTWARE_SUSPEND2
> +		ClearPageNosave(page);
> +#endif
>  		set_bit(PG_highmem, &page->flags);
>  		set_page_count(page, 1);
>  		__free_page(page);
>  		totalhigh_pages++;
> -	} else
> +	} else {
>  		SetPageReserved(page);
> +#ifdef CONFIG_SOFTWARE_SUSPEND2
> +		SetPageNosave(page);
> +#endif
> +	}
>  }
>  
>  #ifndef CONFIG_DISCONTIGMEM

Please, do not put ifdefs around #includes and statements like
ClearPageNosave. (And is it neccessary at all? I'd just say that all
pages that are Reserved are Nosave automatically.)

> +#ifdef CONFIG_SOFTWARE_SUSPEND2
> +			/*
> +			 * Mark nosave pages
> +			 */
> +			if (addr >= (void *)&__nosave_begin && addr < (void *)&__nosave_end)
> +				SetPageNosave(mem_map+tmp);
> +		} else
> +			/*
> +			 * Non-RAM pages are always nosave
> +			 */
> +			SetPageNosave(mem_map+tmp);
> +#else
> +		}
> +#endif
> +	}

Current -mm code does something funny with Nosave; I'm not sure it
will not try to free them after resume. I have fix in my tree but it
is little tested.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
