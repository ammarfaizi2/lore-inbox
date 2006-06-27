Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030310AbWF0T0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030310AbWF0T0x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 15:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030319AbWF0T0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 15:26:53 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:42455 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030310AbWF0T0w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 15:26:52 -0400
Subject: Re: [PATCH 6/7] bootmem: use pfn/page conversion macros
From: Dave Hansen <haveblue@us.ibm.com>
To: Franck <vagabon.xyz@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Mel Gorman <mel@skynet.ie>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <44A12A85.50303@innova-card.com>
References: <449FDD02.2090307@innova-card.com>
	 <1151344691.10877.44.camel@localhost.localdomain>
	 <44A12A85.50303@innova-card.com>
Content-Type: text/plain
Date: Tue, 27 Jun 2006 12:26:37 -0700
Message-Id: <1151436397.24103.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-27 at 14:54 +0200, Franck Bui-Huu wrote:
>  static void __init free_bootmem_core(bootmem_data_t *bdata, unsigned
> long addr,
>                                      unsigned long size)
>  {
> +       unsigned long sidx, eidx;
>         unsigned long i;
> -       unsigned long start;
> +
>         /*
>          * round down end of usable mem, partially free pages are
>          * considered reserved.
>          */
> -       unsigned long sidx;
> -       unsigned long eidx = (addr + size -
> bdata->node_boot_start)/PAGE_SIZE;
> -       unsigned long end = (addr + size)/PAGE_SIZE;
> -
>         BUG_ON(!size);
> -       BUG_ON(end > bdata->node_low_pfn);
> +       BUG_ON(PFN_DOWN(addr + size) > bdata->node_low_pfn);

In general, I like these kinds of conversions.  But, in this case, I
think it makes the code harder to read.  Those intermediate variables
are really nice and I think they make the code much more readable.  

Do you really prefer:

       BUG_ON(PFN_DOWN(addr + size) > bdata->node_low_pfn)

over

       BUG_ON(end > bdata->node_low_pfn);

Also, these do a bit more than just conversions to using the pfn/page
macros.  With this much churn, it is more than possible that bugs can
creep in.  How about a bit more restrictive conversion to the PFN_
macros, first?

Oh, and if you're going to chew through it later, feel free to make
things like sidx into decent variable names. ;)

Is everybody else OK with this code churn?  It doesn't appear that there
is too much in -mm pending in this area.

-- Dave

