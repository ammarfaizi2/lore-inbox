Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbVD0Ifb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVD0Ifb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 04:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVD0Ifb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 04:35:31 -0400
Received: from web40712.mail.yahoo.com ([66.218.78.169]:24246 "HELO
	web40712.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261186AbVD0IfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 04:35:07 -0400
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=OrV9v6By/GK6StjBoiYa9l5s1rddhn8FWI3wynidSNtsg2Sm4kBLB/Qelrp214HqC9xswAZXvI0Fe0Oj/V1LJ3d8VWGiQDEsuUvc9q2zKz0SuUQwHgTifb+/1nIfhC5nCswOKUg/xPcJ58BRdU/mYSdOezj9xaCoPIoCZ5ScVKo=  ;
Message-ID: <20050427083455.41437.qmail@web40712.mail.yahoo.com>
Date: Wed, 27 Apr 2005 01:34:55 -0700 (PDT)
From: dipankar das <dipankar_dd@yahoo.com>
Subject: Re: [kernel oops when locking the cluster using HAS]
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
wrote:
> Hi,
> 
> This is a updated version of a patch for counting
> bouce buffer page.
> A major change is :
> /proc/vmstat is used to show usage.
> 
> Thanks
> -- Kame
> > 
> This is a patch for counting the number of pages for
> bounce buffer.
> It's shown in /proc/vmstat.
> 
> Currently, the number of bounce pages are not
> counted anywhere.
> So, if there are many bounce pages, it seems that
> there are
> leaked pages. And it's difficult for a user to
> imagine the usage of
> bounce pages. So, it's meaningful to show # of bouce
> pages.
> 
> Signed-off-by: KAMEZAWA Hiroyuki
> <kamezawa.hiroyu@jp.fujitsu.com>
> 
> 
> 
> ---
> 
> 
>
linux-2.6.12-rc2-mm3-kamezawa/include/linux/page-flags.h
> |    1 +
>  linux-2.6.12-rc2-mm3-kamezawa/mm/highmem.c         
>      |    2 ++
>  linux-2.6.12-rc2-mm3-kamezawa/mm/page_alloc.c      
>      |    1 +
>  3 files changed, 4 insertions(+)
> 
> diff -puN mm/highmem.c~count_bounce mm/highmem.c
> --- linux-2.6.12-rc2-mm3/mm/highmem.c~count_bounce
> 2005-04-25 12:04:28.000000000 +0900
> +++ linux-2.6.12-rc2-mm3-kamezawa/mm/highmem.c
> 2005-04-27 10:25:51.000000000 +0900
> @@ -325,6 +325,7 @@ static void bounce_end_io(struct
> bio *bi
>  			continue;
>  
>  		mempool_free(bvec->bv_page, pool);	
> +		dec_page_state(nr_bounce);
>  	}
>  
>  	bio_endio(bio_orig, bio_orig->bi_size, err);
> @@ -405,6 +406,7 @@ static void
> __blk_queue_bounce(request_q
>  		to->bv_page = mempool_alloc(pool, q->bounce_gfp);
>  		to->bv_len = from->bv_len;
>  		to->bv_offset = from->bv_offset;
> +		inc_page_state(nr_bounce);
>  
>  		if (rw == WRITE) {
>  			char *vto, *vfrom;
> diff -puN mm/page_alloc.c~count_bounce
> mm/page_alloc.c
> ---
> linux-2.6.12-rc2-mm3/mm/page_alloc.c~count_bounce
> 2005-04-27 10:15:39.000000000 +0900
> +++ linux-2.6.12-rc2-mm3-kamezawa/mm/page_alloc.c
> 2005-04-27 10:17:18.000000000 +0900
> @@ -1902,6 +1902,7 @@ static char *vmstat_text[] = {
>  	"nr_page_table_pages",
>  	"nr_mapped",
>  	"nr_slab",
> +	"nr_bounce",
>  
>  	"pgpgin",
>  	"pgpgout",
> diff -puN include/linux/page-flags.h~count_bounce
> include/linux/page-flags.h
> ---
>
linux-2.6.12-rc2-mm3/include/linux/page-flags.h~count_bounce
> 2005-04-27 10:23:15.000000000 +0900
> +++
>
linux-2.6.12-rc2-mm3-kamezawa/include/linux/page-flags.h
> 2005-04-27 10:24:11.000000000 +0900
> @@ -89,6 +89,7 @@ struct page_state {
>  	unsigned long nr_page_table_pages;/* Pages used
> for pagetables */
>  	unsigned long nr_mapped;	/* mapped into pagetables
> */
>  	unsigned long nr_slab;		/* In slab */
> +	unsigned long nr_bounce;	/* pages for bounce
> buffers */
>  #define GET_PAGE_STATE_LAST nr_slab
>  
>  	/*
> 
> _
> 

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
