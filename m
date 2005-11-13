Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbVKMVOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbVKMVOZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 16:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbVKMVOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 16:14:25 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:21686 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750708AbVKMVOY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 16:14:24 -0500
Date: Sun, 13 Nov 2005 22:14:09 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [RFT][PATCH 3/3] swsusp: improve freeing of memory
Message-ID: <20051113211409.GD2119@elf.ucw.cz>
References: <200511122113.22177.rjw@sisk.pl> <200511122124.42675.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511122124.42675.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch makes swsusp free only as much memory as needed and not as much
> as possible.

Looks okay to me. ACK, modulo few small things.

> -
>  /* References to section boundaries */
>  extern const void __nosave_begin, __nosave_end;
>  
>  extern unsigned int nr_copy_pages;
> -extern suspend_pagedir_t *pagedir_nosave;
> -extern suspend_pagedir_t *pagedir_save;
> +extern struct pbe *pagedir_nosave;
> +
> +/*
> + * This compilation switch determines the way in which memory will be freed
> + * during suspend.  If defined, only as much memory will be freed as needed
> + * to complete the suspend.  Otherwise, the largest possible amount of memory
> + * will be freed.
> + */
> +#define OPPORTUNISTIC_SHRINKING		1

Can you use little less tabelators? Also shorter name for this one
might be "FREE_ALL". 

> +/*
> + * During suspend, on each attempt to free some more memory SHRINK_BITE
> + * is used as the number of pages to free
> + */
> +#define SHRINK_BITE	10000

Does this really need this kind of visibility? There's nothing user
should tweak here.

>  /**
> + *	On resume it is necessary to trace and eventually free the unsafe
> + *	pages that have been allocated, because they are needed for I/O
> + *	(on x86-64 we likely will "eat" these pages once again while
> + *	creating the temporary page translation tables)
> + */
> +
> +struct eaten_page {
> +	struct eaten_page	*next;
> +	char			padding[PAGE_SIZE - sizeof(void *)];
> +};

Less tabelators here, please...

-- 
Thanks, Sharp!
