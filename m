Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261692AbVB1Qrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbVB1Qrx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 11:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbVB1Qro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 11:47:44 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:39822 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261682AbVB1Qqa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 11:46:30 -0500
Subject: Re: [PATCH] 2/2 Prezeroing large blocks of pages during allocation
From: Dave Hansen <haveblue@us.ibm.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       clameter@sgi.com
In-Reply-To: <20050227134316.2D0F1ECE4@skynet.csn.ul.ie>
References: <20050227134316.2D0F1ECE4@skynet.csn.ul.ie>
Content-Type: text/plain
Date: Mon, 28 Feb 2005 08:46:20 -0800
Message-Id: <1109609180.6921.22.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-02-27 at 13:43 +0000, Mel Gorman wrote:
> +		/*
> +		 * If this is a request for a zero page and the page was
> +		 * not taken from the USERZERO pool, zero it all
> +		 */
> +		if ((flags & __GFP_ZERO) && alloctype != ALLOC_USERZERO) {
> +			int zero_order=order;
> +
> +			/*
> +			 * This is important. We are about to zero a block
> +			 * which may be larger than we need so we have to
> +			 * determine do we zero just what we need or do
> +			 * we zero the whole block and put the pages in
> +			 * the zero page. 
> +			 *
> +			 * We zero the whole block in the event we are taking
> +			 * from the KERNNORCLM pools and otherwise zero just
> +			 * what we need. The reason we do not always zero
> +			 * everything is because we do not want unreclaimable
> +			 * pages to leak into the USERRCLM and KERNRCLM 
> +			 * pools
> +			 *
> +			 */
> +			if (alloctype != ALLOC_USERRCLM &&
> +			    alloctype != ALLOC_KERNRCLM) {
> +				area = zone->free_area_lists[ALLOC_USERZERO] +
> +					current_order;
> +				zero_order = current_order;
> +			}
> +
> +			
> +			spin_unlock_irqrestore(&zone->lock, *irq_flags);
> +			prep_zero_page(page, zero_order, flags);
> +			inc_zeroblock_count(zone, zero_order, flags);
> +			spin_lock_irqsave(&zone->lock, *irq_flags);
> +
> +		}
> +
>  		return expand(zone, page, order, current_order, area);
>  	}
>  

I think it would make sense to put that in its own helper function.
When comments get that big, they often reduce readability.  The only
outside variable that gets modified is "area", I think.

So, a static inline:

	area = my_new_function_with_the_huge_comment(zone, ..., area);

Should give the same behavior, generated code, and be a bit easier on
the eyes.  

BTW, what kernel does this apply against?  Is linux-2.6.11-rc4-v18 the
same as bk18?

-- Dave

