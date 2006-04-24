Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbWDXWRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWDXWRN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 18:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWDXWRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 18:17:13 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20412 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751105AbWDXWRN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 18:17:13 -0400
Date: Tue, 25 Apr 2006 00:16:32 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [RFC][PATCH] swsusp: support creating bigger images
Message-ID: <20060424221632.GQ3386@elf.ucw.cz>
References: <200604242355.08111.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604242355.08111.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The appended patch allows swsusp to break the "50% of the normal zone" limit.
> This is achieved by using the observation that pages mapped by frozen
> userland tasks need not be copied before saving.

I've not followed the patch too carefully, but it is not as bad as I
expected...

> With this patch applied I was able to save (and restore ;-)) ~800 MB suspend
> images on a box with 1 GB of RAM.

And did it also work second time? ;-).

Okay, so it can be done, and patch does not look too bad. It still
scares me. Is 800MB image more responsive than 500MB after resume?

I guess we can revert to old behaviour by simply returning 1 from
need_to_copy, right?

I assume that need_to_copy returns 1 in case page is shared by current
and some other process?

> [Please don't beat me very hard, just couldn't resist. ;-)]

Well, you are about to force me to learn about mm internals. Plus you
force everyone who tries to modify swsusp. ... it may be okay if
benefit is great enough and if it gets proper testing. Not 2.6.17
material.

Is benefit worth it?


> --- linux-2.6.17-rc1-mm3.orig/include/linux/rmap.h	2006-04-22 10:34:33.000000000 +0200
> +++ linux-2.6.17-rc1-mm3/include/linux/rmap.h	2006-04-22 10:34:45.000000000 +0200
> @@ -104,6 +104,12 @@ pte_t *page_check_address(struct page *,
>   */
>  unsigned long page_address_in_vma(struct page *, struct vm_area_struct *);
>  
> +#ifdef CONFIG_SOFTWARE_SUSPEND
> +int page_mapped_by_current(struct page *);
> +#else
> +static inline int page_mapped_by_current(struct page *page) { return 0; }
> +#endif /* CONFIG_SOFTWARE_SUSPEND */

I'd leave it undefined. That will prevent nasty surprise when someone
tries to use it w/o CONFIG_SOFTWARE_SUSPEND set.

> @@ -251,6 +253,14 @@ int restore_special_mem(void)
>  	return ret;
>  }
>  
> +/* Represents a stacked allocated page to be used in the future */
> +struct res_page {
> +	struct res_page *next;
> +	char padding[PAGE_SIZE - sizeof(void *)];
> +};
> +
> +static struct res_page *page_list;
> +
>  static int pfn_is_nosave(unsigned long pfn)
>  {
>  	unsigned long nosave_begin_pfn = __pa(&__nosave_begin) >>
> PAGE_SHIFT;

Is this part of some other patch?


> @@ -490,6 +613,11 @@ void swsusp_free(void)
>  	buffer = NULL;
>  }
>  
> +void swsusp_free(void)
> +{
> +	free_image();
> +	restore_active_inactive_lists();
> +}

This still scares me. Nice test would be to
save/restore_active_inactive_lists repeatedly in a loop ... on running
system ... aha, but it probably can't work outside of refrigerator?

>  	case SNAPSHOT_UNFREEZE:
>  		if (!data->frozen)
>  			break;
> +		if (data->ready) {
> +			error = -EPERM;
> +			break;
> +		}
>  		down(&pm_sem);
>  		thaw_processes();
>  		enable_nonboot_cpus();

Error from UNFREEZE is not nice:

Unfreeze:
        unfreeze(snapshot_fd);
        return error;
}
... we don't handle it. OTOH I guess it will be all fixed on exit()?

								Pavel

-- 
Thanks for all the (sleeping) penguins.
