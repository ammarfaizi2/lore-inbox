Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750877AbVKTSQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbVKTSQv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 13:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbVKTSQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 13:16:51 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:29384 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750813AbVKTSQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 13:16:50 -0500
Subject: Re: 2.6.15-rc1-mm2 -- Bad page state at free_hot_cold_page (in
	process 'aplay', page c18eef30)
From: Lee Revell <rlrevell@joe-job.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Miles Lane <miles.lane@gmail.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
       alsa-devel <alsa-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.61.0511200804500.3938@goblin.wat.veritas.com>
References: <a44ae5cd0511192256u20f0e594kc65cbaba108ff06e@mail.gmail.com>
	 <Pine.LNX.4.61.0511200804500.3938@goblin.wat.veritas.com>
Content-Type: text/plain
Date: Sun, 20 Nov 2005 13:14:27 -0500
Message-Id: <1132510467.6874.144.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Added alsa-devel to cc:)

Will this change have any ill effects on older kernels?  If not we
should fix it in the ALSA tree right?

Lee

On Sun, 2005-11-20 at 08:05 +0000, Hugh Dickins wrote:
> On Sat, 19 Nov 2005, Miles Lane wrote:
> > [17179671.700000] Bad page state at free_hot_cold_page (in process
> > 'aplay', page c18eef30)
> > [17179671.700000] flags:0x80000414 mapping:00000000 mapcount:0 count:0
> 
> Please let me know if it's not fixed by:
> 
> --- 2.6.15-rc1-mm2/sound/core/memalloc.c	2005-11-12 09:01:28.000000000 +0000
> +++ linux/sound/core/memalloc.c	2005-11-19 19:03:32.000000000 +0000
> @@ -197,6 +197,7 @@ void *snd_malloc_pages(size_t size, gfp_
>  
>  	snd_assert(size > 0, return NULL);
>  	snd_assert(gfp_flags != 0, return NULL);
> +	gfp_flags |= __GFP_COMP;	/* compound page lets parts be mapped */
>  	pg = get_order(size);
>  	if ((res = (void *) __get_free_pages(gfp_flags, pg)) != NULL) {
>  		mark_pages(virt_to_page(res), pg);
> @@ -241,6 +242,7 @@ static void *snd_malloc_dev_pages(struct
>  	snd_assert(dma != NULL, return NULL);
>  	pg = get_order(size);
>  	gfp_flags = GFP_KERNEL
> +		| __GFP_COMP	/* compound page lets parts be mapped */
>  		| __GFP_NORETRY /* don't trigger OOM-killer */
>  		| __GFP_NOWARN; /* no stack trace print - this call is non-critical */
>  	res = dma_alloc_coherent(dev, PAGE_SIZE << pg, dma, gfp_flags);
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

