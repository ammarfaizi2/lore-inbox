Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290767AbSBFTsq>; Wed, 6 Feb 2002 14:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290779AbSBFTsg>; Wed, 6 Feb 2002 14:48:36 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64017 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S290767AbSBFTsY>;
	Wed, 6 Feb 2002 14:48:24 -0500
Message-ID: <3C618863.DA7AC3B9@zip.com.au>
Date: Wed, 06 Feb 2002 11:47:47 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Benjamin LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __free_pages_ok oops
In-Reply-To: <Pine.LNX.4.21.0202061844450.1856-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> 
> Sorry, no solution, but maybe another oops in __free_pages_ok might help?

What problem are you trying to solve?

> 
> --- 2.4.18-pre8/mm/page_alloc.c Tue Feb  5 12:55:36 2002
> +++ linux/mm/page_alloc.c       Wed Feb  6 18:31:07 2002
> @@ -73,9 +73,11 @@
>         /* Yes, think what happens when other parts of the kernel take
>          * a reference to a page in order to pin it for io. -ben
>          */
> -       if (PageLRU(page))
> +       if (PageLRU(page)) {
> +               if (in_interrupt())
> +                       BUG();
>                 lru_cache_del(page);
> -
> +       }

Yes.  lru_cache_del() in interrupt context will deadlock on SMP
or wreck the LRU list on UP.  I can't see how we can ever perform
the final release of a PageLRU page in interrupt context but I agree
this test is a good one.

-
