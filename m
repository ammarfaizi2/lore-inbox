Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S261418AbVCFP3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbVCFP3R (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 6 Mar 2005 10:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbVCFP3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 10:29:17 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:18349 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261418AbVCFP3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 10:29:13 -0500
Date: Sun, 6 Mar 2005 15:28:19 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Adrian Bunk <bunk@stusta.de>
cc: Russell King <rmk@arm.uk.linux.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] mm/swap_state.c: unexport swapper_space
In-Reply-To: <20050306144758.GJ5070@stusta.de>
Message-ID: <Pine.LNX.4.61.0503061515200.19898@goblin.wat.veritas.com>
References: <20050306144758.GJ5070@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Mar 2005, Adrian Bunk wrote:

> I didn't find any possible modular usage in the kernel.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.11-mm1-full/mm/swap_state.c.old	2005-03-04 16:25:54.000000000 +0100
> +++ linux-2.6.11-mm1-full/mm/swap_state.c	2005-03-04 16:26:16.000000000 +0100
> @@ -40,7 +40,6 @@
>  	.i_mmap_nonlinear = LIST_HEAD_INIT(swapper_space.i_mmap_nonlinear),
>  	.backing_dev_info = &swap_backing_dev_info,
>  };
> -EXPORT_SYMBOL(swapper_space);
>  
>  #define INC_CACHE_INFO(x)	do { swap_cache_info.x++; } while (0)

I think this one should stay exported (or at least be re-exported
immediately on demand).  It's used by the inline page_mapping() in
include/linux/mm.h, which _was_ used by various arch cacheflushing
inlines, which could reasonably be called from modular filesystems.

I think those architectures hit the missed export when the dependence
on &swapper_space got added to page_mapping(), the export was soon
added to mainline, but meanwhile they moved their inlines out-of-line
- perhaps temporarily, but not yet reverted.

Better leave it exported so long as page_mapping is using it.

Hugh
