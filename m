Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317385AbSHOUTp>; Thu, 15 Aug 2002 16:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317400AbSHOUTp>; Thu, 15 Aug 2002 16:19:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54798 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317385AbSHOUTp>;
	Thu, 15 Aug 2002 16:19:45 -0400
Message-ID: <3D5C0D3D.E68137BA@zip.com.au>
Date: Thu, 15 Aug 2002 13:21:17 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>, j-nomura@ce.jp.nec.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.18(19) swapcache oops
References: <20020815.213929.846960657.nomura@hpc.bs1.fc.nec.co.jp> <Pine.LNX.4.44.0208151515420.1610-100000@localhost.localdomain> <3D5C0995.CEE36FC8@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> ...
> --- 2.4.19/mm/swap.c~lru-race   Thu Aug 15 13:03:48 2002
> +++ 2.4.19-akpm/mm/swap.c       Thu Aug 15 13:04:19 2002
> @@ -57,9 +57,10 @@ void activate_page(struct page * page)
>   */
>  void lru_cache_add(struct page * page)
>  {
> -       if (!TestSetPageLRU(page)) {
> +       if (!PageLRU(page)) {
>                 spin_lock(&pagemap_lru_lock);
> -               add_page_to_inactive_list(page);
> +               if (!TestSetPageLRU(page))
> +                       add_page_to_inactive_list(page);
>                 spin_unlock(&pagemap_lru_lock);
>         }
>  }

Seems that I fixed this in 2.5.32.  That set_bit outside
the lock gave me the willes, and I couldn't put my finger on why.
Never occurred to me that the page could be found via pagecache
lookup in this manner.

In 2.5, it is effectively:

void lru_cache_add(struct page * page)
{
        spin_lock(&pagemap_lru_lock);
        if (TestSetPageLRU(page))
                BUG();
        add_page_to_inactive_list(page);
        spin_unlock(&pagemap_lru_lock);
}

which is what should be tested in 2.4.  It's stricter, and significantly
faster.
