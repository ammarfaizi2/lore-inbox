Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbVKTIEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbVKTIEY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 03:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbVKTIEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 03:04:24 -0500
Received: from gold.veritas.com ([143.127.12.110]:20832 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1750764AbVKTIEX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 03:04:23 -0500
Date: Sun, 20 Nov 2005 08:04:03 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc1-mm2
In-Reply-To: <6bffcb0e0511191623q31a143fdr@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0511200802460.3938@goblin.wat.veritas.com>
References: <20051117234645.4128c664.akpm@osdl.org> <6bffcb0e0511191623q31a143fdr@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 20 Nov 2005 08:04:18.0903 (UTC) FILETIME=[02047670:01C5EDA9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Nov 2005, Michal Piotrowski wrote:
> 
> It looks similar to Rafael J. Wysocki report. It's full reproductible
> and appears when playing mp3's in totem.
> 
> debian:/home/michal# cat /var/log/kern.log | grep -c "Bad page state
> at free_hot_cold_page"

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
