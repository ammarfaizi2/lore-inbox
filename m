Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267186AbUBMU0g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 15:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267188AbUBMU0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 15:26:36 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:10922 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S267186AbUBMU0e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 15:26:34 -0500
Message-ID: <402D3244.6020402@pacbell.net>
Date: Fri, 13 Feb 2004 12:23:32 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: dmapool (was: Re: Linux 2.6.3-rc2)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +static inline int
> +dma_supported(struct device *dev, u64 mask)
> +{
> +	BUG();
> +	return 0;
> +}

dma_supported() in particular shouldn't BUG(); this should work:

    if (use_dma && dma_supported(dev, ~(u32)0)) {
        ... set up for DMA ...
    } else {
        ... just use PIO instead ...
    }

Likewise the other routines that have clearly defined fault paths
should probably just use those instead of BUG().  Examples of this
type would be dma_alloc_coherent(), dma_map_sg() and maybe also
dma_get_cache_alignment().


Of course the API still lacks clean fault reporting for the single
shot mapping calls -- like maybe an arch-settable

   #define DMA_ADDR_INVALID (~(dma_addr_t)0)

return value -- but that'd be a different patch.

- Dave



