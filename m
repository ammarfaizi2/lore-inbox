Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263304AbTJKN1p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 09:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263305AbTJKN1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 09:27:45 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:38406 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S263304AbTJKN1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 09:27:42 -0400
Date: Sat, 11 Oct 2003 17:27:00 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: David Brownell <david-b@pacbell.net>
Cc: mru@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: USB and DMA on Alpha with 2.6.0-test7
Message-ID: <20031011172700.A16499@jurassic.park.msu.ru>
References: <3F86E9D7.9020104@pacbell.net> <3F870BDC.8090806@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3F870BDC.8090806@pacbell.net>; from david-b@pacbell.net on Fri, Oct 10, 2003 at 12:43:24PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 12:43:24PM -0700, David Brownell wrote:
>  static inline int
>  dma_supported(struct device *dev, u64 mask)
>  {
> -	BUG_ON(dev->bus != &pci_bus_type);
> -
> -	return pci_dma_supported(to_pci_dev(dev), mask);
> +	/* device can dma, using those address bits */
> +	return dev->dma_mask
> +		&& (mask & *dev->dma_mask) == *dev->dma_mask;
>  }

This doesn't work. You will always return success if mask = ~0ULL.
But more important thing is that dma_supported() must not expect
valid *dev->dma_mask, as it's called from dma_set_mask().
That is, your usage of dma_supported() is buggy regardless of
DMA API implementation.

Ivan.
