Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161224AbWAHWg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161224AbWAHWg5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 17:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161225AbWAHWg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 17:36:57 -0500
Received: from solarneutrino.net ([66.199.224.43]:4612 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S1161224AbWAHWg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 17:36:56 -0500
Date: Sun, 8 Jan 2006 17:36:41 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kai Makisara <Kai.Makisara@kolumbus.fi>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       ryan@tau.solarneutrino.net
Subject: Re: Fw: crash on x86_64 - mm related?
Message-ID: <20060108223641.GB283@tau.solarneutrino.net>
References: <Pine.LNX.4.64.0512121007220.15597@g5.osdl.org> <1134411882.9994.18.camel@mulgrave> <20051215190930.GA20156@tau.solarneutrino.net> <1134705703.3906.1.camel@mulgrave> <20051226234238.GA28037@tau.solarneutrino.net> <Pine.LNX.4.63.0512271807130.4955@kai.makisara.local> <20060104172727.GA320@tau.solarneutrino.net> <Pine.LNX.4.63.0601042334310.5087@kai.makisara.local> <20060105201249.GB1795@tau.solarneutrino.net> <Pine.LNX.4.64.0601051312380.3169@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601051312380.3169@g5.osdl.org>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 01:18:57PM -0800, Linus Torvalds wrote:

OK, I can trash a few tapes again now.

> ---
> diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
> index c4aade8..18e60e1 100644
> --- a/drivers/scsi/st.c
> +++ b/drivers/scsi/st.c
> @@ -4481,6 +4481,7 @@ static int sgl_unmap_user_pages(struct s
>  	for (i=0; i < nr_pages; i++) {
>  		struct page *page = sgl[i].page;
>  
> +		sgl[i].page = NULL;
>  		if (dirtied)
>  			SetPageDirty(page);
>  		/* FIXME: cache flush missing for rw==READ

This hunk fails on 2.6.15+Kai's patch.  There's already a
sgl[i].page = NULL;
in there - here's what my copy of the function looks like:

/* And unmap them... */
static int sgl_unmap_user_pages(struct scatterlist *sgl, const unsigned int nr_pages,
                                int dirtied)
{
        int i;
        static int ctr;


        if ((ctr++ % 10000) == 0)
                prt_pages(sgl, nr_pages, "before");
        for (i=0; i < nr_pages; i++) {
                struct page *page = sgl[i].page;

                if (!page) {
                        printk("st: trying double free: %d %d\n", i, nr_pages);
                        continue;
                }
                if (dirtied)
                        SetPageDirty(page);
                /* FIXME: cache flush missing for rw==READ
                 * FIXME: call the correct reference counting function
                 */
                page_cache_release(page);
                sgl[i].page = NULL;
        }

        return 0;
}

I left it like that.

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index a06a84d..daf504d 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -299,6 +299,7 @@ struct page {
>  #define put_page_testzero(p)				\
>  	({						\
>  		BUG_ON(page_count(p) == 0);		\
> +		BUG_ON(page_count(p) <= page_mapcount(p));	\
>  		atomic_add_negative(-1, &(p)->_count);	\
>  	})
>

The first backup run with this patch didn't crash - that's the first
time with 2.6.15.  I wonder if it's a coincidence.  Nothing else has
changed, AFAICS, but the kernel output is different (or there's more of
it):

st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933526
 1: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933496
 2: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933498
 3: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933499
 4: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933500
 5: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933501
 6: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933525
 7: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933523
st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1007909
 1: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963403
 2: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:992653
 3: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963620
 4: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:985187
 5: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:966121
 6: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1007992
 7: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933594
st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1007909
 1: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963403
 2: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:992653
 3: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963620
 4: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:985187
 5: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:966121
 6: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1007992
 7: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933594
st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1007909
 1: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963403
 2: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:992653
 3: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963620
 4: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:985187
 5: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:966121
 6: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1007992
 7: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933594
st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1007909
 1: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963403
 2: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:992653
 3: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963620
 4: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:985187
 5: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:966121
 6: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1007992
 7: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933594
st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1007909
 1: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963403
 2: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:992653
 3: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963620
 4: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:985187
 5: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:966121
 6: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1007992
 7: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933594
st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1007909
 1: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963403
 2: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:992653
 3: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963620
 4: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:985187
 5: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:966121
 6: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1007992
 7: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933594
st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1007909
 1: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963403
 2: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:992653
 3: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963620
 4: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:985187
 5: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:966121
 6: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1007992
 7: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933594
st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1007909
 1: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963403
 2: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:992653
 3: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963620
 4: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:985187
 5: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:966121
 6: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1007992
 7: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933594
st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1007909
 1: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963403
 2: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:992653
 3: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963620
 4: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:985187
 5: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:966121
 6: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1007992
 7: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933594
st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1007909
 1: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963403
 2: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:992653
 3: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963620
 4: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:985187
 5: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:966121
 6: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1007992
 7: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933594
st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1007909
 1: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963403
 2: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:992653
 3: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963620
 4: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:985187
 5: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:966121
 6: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1007992
 7: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933594
st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1007909
 1: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963403
 2: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:992653
 3: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963620
 4: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:985187
 5: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:966121
 6: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1007992
 7: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933594
st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1007909
 1: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963403
 2: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:992653
 3: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963620
 4: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:985187
 5: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:966121
 6: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1007992
 7: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933594
st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1007909
 1: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963403
 2: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:992653
 3: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963620
 4: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:985187
 5: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:966121
 6: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1007992
 7: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933594
st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1007909
 1: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963403
 2: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:992653
 3: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963620
 4: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:985187
 5: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:966121
 6: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1007992
 7: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933594
st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1007909
 1: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963403
 2: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:992653
 3: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963620
 4: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:985187
 5: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:966121
 6: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1007992
 7: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933594
st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1007909
 1: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963403
 2: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:992653
 3: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963620
 4: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:985187
 5: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:966121
 6: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1007992
 7: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933594
st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1007909
 1: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963403
 2: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:992653
 3: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963620
 4: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:985187
 5: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:966121
 6: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1007992
 7: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933594
st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933522
 1: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963590
 2: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:931906
 3: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933763
 4: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963777
 5: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933718
 6: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963619
 7: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:207313
st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933522
 1: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963590
 2: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:931906
 3: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933763
 4: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963777
 5: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933718
 6: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963619
 7: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:207313
st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933606
 1: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933323
 2: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963420
 3: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:959854
 4: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:962968
 5: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933602
 6: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933600
 7: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933339
st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933606
 1: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933323
 2: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963420
 3: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:959854
 4: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:962968
 5: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933602
 6: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933600
 7: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933339
st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933606
 1: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933323
 2: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963420
 3: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:959854
 4: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:962968
 5: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933602
 6: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933600
 7: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933339
st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933606
 1: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933323
 2: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963420
 3: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:959854
 4: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:962968
 5: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933602
 6: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933600
 7: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933339
st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933606
 1: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933323
 2: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963420
 3: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:959854
 4: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:962968
 5: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933602
 6: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933600
 7: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933339
st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933606
 1: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933323
 2: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963420
 3: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:959854
 4: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:962968
 5: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933602
 6: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933600
 7: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933339
st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933606
 1: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933323
 2: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963420
 3: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:959854
 4: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:962968
 5: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933602
 6: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933600
 7: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933339
st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933606
 1: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933323
 2: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963420
 3: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:959854
 4: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:962968
 5: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933602
 6: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933600
 7: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933339
st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933606
 1: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933323
 2: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963420
 3: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:959854
 4: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:962968
 5: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933602
 6: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933600
 7: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933339
st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933606
 1: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933323
 2: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963420
 3: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:959854
 4: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:962968
 5: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933602
 6: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933600
 7: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933339
st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933606
 1: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933323
 2: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963420
 3: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:959854
 4: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:962968
 5: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933602
 6: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933600
 7: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933339
st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933606
 1: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933323
 2: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:963420
 3: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:959854
 4: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:962968
 5: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933602
 6: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933600
 7: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:933339
st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1009784
 1: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:186937
 2: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1008366
 3: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:968112
 4: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:962986
 5: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:932668
 6: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:932637
 7: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:962435
st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1009784
 1: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:186937
 2: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1008366
 3: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:968112
 4: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:962986
 5: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:932668
 6: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:932637
 7: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:962435
st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1009784
 1: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:186937
 2: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1008366
 3: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:968112
 4: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:962986
 5: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:932668
 6: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:932637
 7: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:962435
st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1009784
 1: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:186937
 2: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1008366
 3: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:968112
 4: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:962986
 5: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:932668
 6: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:932637
 7: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:962435
st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1009784
 1: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:186937
 2: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1008366
 3: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:968112
 4: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:962986
 5: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:932668
 6: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:932637
 7: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:962435
st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1009784
 1: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:186937
 2: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1008366
 3: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:968112
 4: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:962986
 5: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:932668
 6: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:932637
 7: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:962435
st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1009784
 1: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:186937
 2: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1008366
 3: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:968112
 4: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:962986
 5: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:932668
 6: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:932637
 7: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:962435
st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1009784
 1: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:186937
 2: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1008366
 3: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:968112
 4: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:962986
 5: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:932668
 6: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:932637
 7: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:962435
st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1009784
 1: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:186937
 2: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1008366
 3: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:968112
 4: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:962986
 5: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:932668
 6: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:932637
 7: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:962435
st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1009784
 1: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:186937
 2: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1008366
 3: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:968112
 4: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:962986
 5: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:932668
 6: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:932637
 7: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:962435
st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1009784
 1: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:186937
 2: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1008366
 3: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:968112
 4: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:962986
 5: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:932668
 6: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:932637
 7: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:962435
st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1009784
 1: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:186937
 2: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1008366
 3: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:968112
 4: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:962986
 5: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:932668
 6: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:932637
 7: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:962435
st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1009784
 1: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:186937
 2: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1008366
 3: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:968112
 4: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:962986
 5: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:932668
 6: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:932637
 7: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:962435
st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1009784
 1: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:186937
 2: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1008366
 3: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:968112
 4: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:962986
 5: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:932668
 6: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:932637
 7: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:962435
st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1009784
 1: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:186937
 2: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:1008366
 3: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:968112
 4: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:962986
 5: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:932668
 6: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:932637
 7: flags:0x010000000000006c mapping:ffff81000c354278 mapcount:2 count:4 pfn:962435

There are 48 of those, not quite the same as the number of filesystems
written to tape (58).

I'll run a few more tonight.

-ryan  
