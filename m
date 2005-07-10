Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262003AbVGJSMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbVGJSMN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 14:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbVGJSMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 14:12:13 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:40588 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262003AbVGJSMM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 14:12:12 -0400
Date: Sun, 10 Jul 2005 20:12:21 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [35/48] Suspend2 2.1.9.8 for 2.6.12: 611-io.patch
Message-ID: <20050710181221.GE10904@elf.ucw.cz>
References: <11206164393426@foobar.com> <1120616443224@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120616443224@foobar.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> +	//p->pageset_size = pageset_size;

Please don't leave commented code in.

> +unsigned long suspend2_get_nonconflicting_pages(const int order)
> +{
> +	struct page * page;
> +	unsigned long new_page;
> +	int more = 0;
> +	unsigned long pgcount;
> +
> +	do {
> +		new_page = __get_free_pages(GFP_ATOMIC | __GFP_NOWARN, order);
> +		if (!new_page)
> +			return 0;
> +		more = 0;
> +		for (pgcount = 0; pgcount < (1UL << order); pgcount++) {
> +			page = virt_to_page(new_page + PAGE_SIZE * pgcount);
> +			if (PagePageset1(page)) {
> +				more = 1;
> +				break;
> +			}
> +		}
> +		if (more) {
> +			page = virt_to_page(new_page);
> +			list_add(&page->lru, &conflicting_pages);
> +
> +			/* since this page is technically free, we can abuse it to
> +			 * store the order. When we resume it'll just be overwritten,
> +			 * but we need this value when freeing it in
> +			 * suspend2_release_conflicting_pages. */
> +			*((int*)new_page) = order;
> +		}
> +	}
> +	while (more);
> +
> +	memset((void*)new_page, 0, PAGE_SIZE * (1<<order));
> +	return new_page;
> +}
> +
> +/* suspend2_get_nonconflicting_page
> + *
> + * Description: Gets a page that will not be overwritten as we copy the
> + * 		original kernel page.
> + */
> +
> +unsigned long suspend2_get_nonconflicting_page(void)
> +{
> +	return suspend2_get_nonconflicting_pages(0);
> +}

Can you just replace it in callers?

> +#define pageset1_size (pagedir1.pageset_size)
> +#define pageset2_size (pagedir2.pageset_size)

This only makes reading code harder...

							Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
