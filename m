Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422805AbWAMSgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422805AbWAMSgT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 13:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422810AbWAMSgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 13:36:19 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:22746 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1422805AbWAMSgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 13:36:18 -0500
Subject: Re: [PATCHSET] block: fix PIO cache coherency bug
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Dave Miller <davem@redhat.com>, Tejun Heo <htejun@gmail.com>,
       axboe@suse.de, bzolnier@gmail.com, james.steward@dynamicratings.com,
       jgarzik@pobox.com, linux-kernel@vger.kernel.org
In-Reply-To: <20060113182035.GC25849@flint.arm.linux.org.uk>
References: <11371658562541-git-send-email-htejun@gmail.com>
	 <1137167419.3365.5.camel@mulgrave>
	 <20060113182035.GC25849@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Fri, 13 Jan 2006 12:35:24 -0600
Message-Id: <1137177324.3365.67.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-13 at 18:20 +0000, Russell King wrote:
> I think you're misunderstanding the issue.  I'll give you essentially
> my understanding of the explaination that Dave Miller gave me a number
> of years ago.  This is from memory, so Dave may wish to correct it.
> 
> 1. When a driver DMAs data into a page cache page, it is written directly
>    to RAM and is made visible to the kernel mapping via the DMA API.  As
>    a result, there will be no cache lines associated with the kernel
>    mapping at the point when the driver hands the page back to the page
>    cache.

Yes ... that's essentially what I said: DMA API makes us kernel
coherent.  However, we explicitly *don't* mandate the way architectures
do this.  It's certainly true, all the ones I know work by flushing the
kernel mapping cache lines, but I don't think you're entitled to rely on
this behaviour ... it's not inconcievable for large external cache
machines that the DMA could be done straight into the kernel cache.

>    However, in the PIO case, there is the possibility that the data read
>    from the device into the kernel mapping results in cache lines
>    associated with the page.  Moreover, if the cache is write-allocate,
>    you _will_ have cache lines.
> 
>    Therefore, you have two completely differing system states depending
>    on how the driver decided to transfer data from the device to the page
>    cache.
> 
>    As such, drivers must ensure that PIO data transfers have the same
>    system state guarantees as DMA data transfers.
> 
>    ISTR davem recommended flush_dcache_page() be used for this.

Ah ... perhaps this is the misunderstanding.  To clear the kernel lines
associated with the page you use flush_kernel_dcache_page().
flush_dcache_page() is used to make a page cache page coherent with its
user mappings.

> 2. (this is my own)  The cachetlb document specifies quite clearly what
>    is required whenever a page cache page is written to - that is
>    flush_dcache_page() is called.  The situation when a driver uses PIO
>    quote clearly violates the requirements set out in that document.
> 
> >From (2), it is quite clear that flush_dcache_page() is the correct
> function to use, otherwise we would end up with random set of state
> of pages in the page cache.  (1) merely reinforces that it's the
> correct place for the decision to be made.  In fact, it's the only
> part of the kernel which _knows_ what needs to be done.

True, but your assumption that a driver should be doing this is what I'm
saying is incorrect.  A driver's job is to deliver data coherently to
the kernel.  The kernel's job is to deliver it coherently to the user.

Perhaps we should take this to linux-arch ... the audience there is well
versed in these arcane problems?

James


