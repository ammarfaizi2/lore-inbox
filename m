Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbVKTIFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbVKTIFs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 03:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbVKTIFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 03:05:47 -0500
Received: from gold.veritas.com ([143.127.12.110]:26464 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751109AbVKTIFr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 03:05:47 -0500
Date: Sun, 20 Nov 2005 08:05:37 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Miles Lane <miles.lane@gmail.com>
cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-rc1-mm2 -- Bad page state at free_hot_cold_page (in
 process 'aplay', page c18eef30)
In-Reply-To: <a44ae5cd0511192256u20f0e594kc65cbaba108ff06e@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0511200804500.3938@goblin.wat.veritas.com>
References: <a44ae5cd0511192256u20f0e594kc65cbaba108ff06e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 20 Nov 2005 08:05:47.0090 (UTC) FILETIME=[3694BB20:01C5EDA9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Nov 2005, Miles Lane wrote:
> [17179671.700000] Bad page state at free_hot_cold_page (in process
> 'aplay', page c18eef30)
> [17179671.700000] flags:0x80000414 mapping:00000000 mapcount:0 count:0

Please let me know if it's not fixed by:

--- 2.6.15-rc1-mm2/sound/core/memalloc.c	2005-11-12 09:01:28.000000000 +0000
+++ linux/sound/core/memalloc.c	2005-11-19 19:03:32.000000000 +0000
@@ -197,6 +197,7 @@ void *snd_malloc_pages(size_t size, gfp_
 
 	snd_assert(size > 0, return NULL);
 	snd_assert(gfp_flags != 0, return NULL);
+	gfp_flags |= __GFP_COMP;	/* compound page lets parts be mapped */
 	pg = get_order(size);
 	if ((res = (void *) __get_free_pages(gfp_flags, pg)) != NULL) {
 		mark_pages(virt_to_page(res), pg);
@@ -241,6 +242,7 @@ static void *snd_malloc_dev_pages(struct
 	snd_assert(dma != NULL, return NULL);
 	pg = get_order(size);
 	gfp_flags = GFP_KERNEL
+		| __GFP_COMP	/* compound page lets parts be mapped */
 		| __GFP_NORETRY /* don't trigger OOM-killer */
 		| __GFP_NOWARN; /* no stack trace print - this call is non-critical */
 	res = dma_alloc_coherent(dev, PAGE_SIZE << pg, dma, gfp_flags);
