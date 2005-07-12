Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbVGLIkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbVGLIkM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 04:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbVGLIhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 04:37:47 -0400
Received: from [203.171.93.254] ([203.171.93.254]:55265 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261261AbVGLIgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 04:36:24 -0400
Subject: Re: [PATCH] [35/48] Suspend2 2.1.9.8 for 2.6.12: 611-io.patch
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <nigel@suspend2.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050710181221.GE10904@elf.ucw.cz>
References: <11206164393426@foobar.com> <1120616443224@foobar.com>
	 <20050710181221.GE10904@elf.ucw.cz>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1121157488.13869.127.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 12 Jul 2005 18:38:08 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2005-07-11 at 04:12, Pavel Machek wrote:
> Hi!
> 
> > +	//p->pageset_size = pageset_size;
> 
> Please don't leave commented code in.

Fixed.

> > +unsigned long suspend2_get_nonconflicting_pages(const int order)
> > +{
> > +	struct page * page;
> > +	unsigned long new_page;
> > +	int more = 0;
> > +	unsigned long pgcount;
> > +
> > +	do {
> > +		new_page = __get_free_pages(GFP_ATOMIC | __GFP_NOWARN, order);
> > +		if (!new_page)
> > +			return 0;
> > +		more = 0;
> > +		for (pgcount = 0; pgcount < (1UL << order); pgcount++) {
> > +			page = virt_to_page(new_page + PAGE_SIZE * pgcount);
> > +			if (PagePageset1(page)) {
> > +				more = 1;
> > +				break;
> > +			}
> > +		}
> > +		if (more) {
> > +			page = virt_to_page(new_page);
> > +			list_add(&page->lru, &conflicting_pages);
> > +
> > +			/* since this page is technically free, we can abuse it to
> > +			 * store the order. When we resume it'll just be overwritten,
> > +			 * but we need this value when freeing it in
> > +			 * suspend2_release_conflicting_pages. */
> > +			*((int*)new_page) = order;
> > +		}
> > +	}
> > +	while (more);
> > +
> > +	memset((void*)new_page, 0, PAGE_SIZE * (1<<order));
> > +	return new_page;
> > +}
> > +
> > +/* suspend2_get_nonconflicting_page
> > + *
> > + * Description: Gets a page that will not be overwritten as we copy the
> > + * 		original kernel page.
> > + */
> > +
> > +unsigned long suspend2_get_nonconflicting_page(void)
> > +{
> > +	return suspend2_get_nonconflicting_pages(0);
> > +}
> 
> Can you just replace it in callers?

Done.

> > +#define pageset1_size (pagedir1.pageset_size)
> > +#define pageset2_size (pagedir2.pageset_size)
> 
> This only makes reading code harder...

Removed.

Regards,

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

