Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbVAGVDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbVAGVDY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 16:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbVAGVBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 16:01:20 -0500
Received: from [213.85.13.118] ([213.85.13.118]:4226 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S261604AbVAGVAP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 16:00:15 -0500
To: Christoph Hellwig <hch@infradead.org>
Cc: Vladimir Saveliev <vs@namesys.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>
Subject: Re: [RFC] per thread page reservation patch
References: <20050103011113.6f6c8f44.akpm@osdl.org>
	<20050103114854.GA18408@infradead.org> <41DC2386.9010701@namesys.com>
	<1105019521.7074.79.camel@tribesman.namesys.com>
	<20050107144644.GA9606@infradead.org>
	<1105118217.3616.171.camel@tribesman.namesys.com>
	<20050107190545.GA13898@infradead.org> <m1pt0hq81x.fsf@clusterfs.com>
	<20050107205444.GA15969@infradead.org>
From: Nikita Danilov <nikita@clusterfs.com>
Date: Sat, 08 Jan 2005 00:00:00 +0300
In-Reply-To: <20050107205444.GA15969@infradead.org> (Christoph Hellwig's
 message of "Fri, 7 Jan 2005 20:54:44 +0000")
Message-ID: <m1hdltq7jj.fsf@clusterfs.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.5 (chayote, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> On Fri, Jan 07, 2005 at 11:48:58PM +0300, Nikita Danilov wrote:
>> sufficient to create and use per-thread reservations. Using
>> current->private_pages_count directly
>> 
>>  - makes API less uniform, not contained within single namespace
>>    (perthread_pages_*), and worse,
>> 
>>  - exhibits internal implementation detail to the user.
>
> Completely disagreed, hiding all the details doesn't help for such
> trivial access, it's just obsfucating things.
>
> But looking at it the API doesn't make sense at all.  Number of pages
> in the thread-pool is an internal implementation detail and no caller
> must look at it - think about two callers, e.g. filesystem and iscsi
> initiator using it in the same thread.
>
> Here's an updated patch with my suggestions implemented and other goodies
> such a kerneldoc comments (but completely untested so far):
>
>
> --- 1.20/include/linux/gfp.h	2005-01-05 18:30:39 +01:00
> +++ edited/include/linux/gfp.h	2005-01-07 20:30:20 +01:00
> @@ -130,6 +130,9 @@
>  #define __free_page(page) __free_pages((page), 0)
>  #define free_page(addr) free_pages((addr),0)
>  
> +extern int perthread_pages_reserve(unsigned int nrpages, unsigned int gfp_mask);
> +extern void perthread_pages_release(unsigned int nrpages);

I don't see how this can work.

        /* make conservative estimation... */
        perthread_pages_reserve(100, GFP_KERNEL);

        /* actually, use only 10 pages during atomic operation */

        /* want to release remaining 90 pages... */
        perthread_pages_release(???);

Can you elaborate how to calculate number of pages that has to be
released?

Nikita.
