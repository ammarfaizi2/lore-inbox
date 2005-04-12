Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262134AbVDMA0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbVDMA0s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 20:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbVDLUUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:20:16 -0400
Received: from mail.mellanox.co.il ([194.90.237.34]:24446 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S262169AbVDLSV6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 14:21:58 -0400
Date: Tue, 12 Apr 2005 21:23:57 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Roland Dreier <roland@topspin.com>
Cc: Andrew Morton <akpm@osdl.org>, libor@topspin.com,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
Message-ID: <20050412182357.GA24047@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <200544159.Ahk9l0puXy39U6u6@topspin.com> <20050411142213.GC26127@kalmia.hozed.org> <52mzs51g5g.fsf@topspin.com> <20050411163342.GE26127@kalmia.hozed.org> <5264yt1cbu.fsf@topspin.com> <20050411180107.GF26127@kalmia.hozed.org> <52oeclyyw3.fsf@topspin.com> <20050411171347.7e05859f.akpm@osdl.org> <521x9gyhe7.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <521x9gyhe7.fsf@topspin.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Roland Dreier <roland@topspin.com>:
> Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
> 
>     Roland> Yes, because the kernel may go through and unmap pages
>     Roland> from userspace while trying to swap.  Since we have the
>     Roland> page locked in the kernel, the physical page won't go
>     Roland> anywhere, but userspace might end up with a different page
>     Roland> mapped at the same virtual address.
> 
>     Andrew> That shouldn't happen.  If get_user_pages() has elevated
>     Andrew> the refcount on a page then the following can happen:
> 
>     ...
> 
>     Andrew> IOW: while the page has an elevated refcount from
>     Andrew> get_user_pages(), that physical page is 100% pinned.
>     Andrew> Once you've done the set_page_dirty+put_page(), the page
>     Andrew> is again under control of the VM.
> 
> Hmm... I've never tested it first hand but Libor assures me there is a
> something like what I said.  Libor, did I get the explanation right?
> 
>  - R.

Roland, is it possible that what you describe is the behaviour of older kernels?

Digging around in rmap.c, I see the following code in try_to_unmap_one:

        /*
         * Don't pull an anonymous page out from under get_user_pages.
         * GUP carefully breaks COW and raises page count (while holding
         * page_table_lock, as we have here) to make sure that the page
         * cannot be freed.  If we unmap that page here, a user write
         * access to the virtual address will bring back the page, but
         * its raised count will (ironically) be taken to mean it's not
         * an exclusive swap page, do_wp_page will replace it by a copy
         * page, and the user never get to see the data GUP was holding
         * the original page for.
         *
         * This test is also useful for when swapoff (unuse_process) has
         * to drop page lock: its reference to the page stops existing
         * ptes from being unmapped, so swapoff can make progress.
         */
        if (PageSwapCache(page) &&
            page_count(page) != page_mapcount(page) + 2) {
                ret = SWAP_FAIL;
                goto out_unmap;
        }

This was added in http://linus.bkbits.net:8080/linux-2.5/patch@1.1722.120.6
on 2004-06-05 , i.e. as far as I can see around 2.6.7, and the comment says:

>>>>>>>>>>>>>>>>>>>>>>
> [PATCH] mm: get_user_pages vs. try_to_unmap
> 
> Andrea Arcangeli's fix to an ironic weakness with get_user_pages. 
> 
> try_to_unmap_one must check page_count against page->mapcount before unmapping
> a swapcache page: because the raised pagecount by which get_user_pages ensures
> the page cannot be freed, will cause any write fault to see that page as not
> exclusively owned, and therefore a copy page will be substituted for it - the
> reverse of what's intended.
> 
> rmap.c was entirely free of such page_count heuristics before, I tried hard to
> avoid putting this in.  But Andrea's fix rarely gives a false positive; and
> although it might be nicer to change exclusive_swap_page etc.  to rely on
> page->mapcount instead, it seems likely that we'll want to get rid of
> page->mapcount later, so better not to entrench its use.
> 
> Signed-off-by: Hugh Dickins <hugh@veritas.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> Signed-off-by: Linus Torvalds <torvalds@osdl.org>
>>>>>>>>>>>>>>>>>>>>>>

Seems quite like the situation that you described. Does my analysis make sence?

Since this case seems to be explicitly handled,
it is probably safe to rely on this behaviour or try_to_unmap,
avoiding the need for mlock, is it not?

-- 
MST - Michael S. Tsirkin
