Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267414AbUH1K2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267414AbUH1K2x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 06:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263736AbUH1KZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 06:25:42 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:24331 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267413AbUH1KXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 06:23:25 -0400
Date: Sat, 28 Aug 2004 11:23:24 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Takao Indoh <indou.takao@soft.fujitsu.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4][diskdump] x86-64 support
Message-ID: <20040828112324.B8000@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Takao Indoh <indou.takao@soft.fujitsu.com>,
	linux-kernel@vger.kernel.org
References: <89C48CE36A27FFindou.takao@soft.fujitsu.com> <8DC48CE421568Cindou.takao@soft.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <8DC48CE421568Cindou.takao@soft.fujitsu.com>; from indou.takao@soft.fujitsu.com on Sat, Aug 28, 2004 at 06:48:11PM +0900
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 06:48:11PM +0900, Takao Indoh wrote:
> +/*
> + *  Dump stuff...
> + */
> +#include <linux/diskdump.h>
> +
> +#define MPT_HOST_LOCK(host_lock)		\
> +	if (crashdump_mode()) 			\
> +		spin_lock(host_lock);		\
> +	else					\
> +		spin_lock_irq(host_lock);
> +
> +#define MPT_HOST_UNLOCK(host_lock)		\
> +	if (crashdump_mode())			\
> +		spin_unlock(host_lock);		\
> +	else					\
> +		spin_unlock_irq(host_lock);
> +

Please stop this macro madness.  Why can't you simply use
spin+lock_irqsave?

> +mptscsih_sanity_check(struct scsi_device *sdev)
> +{
> +	MPT_ADAPTER    *ioc;
> +	MPT_SCSI_HOST  *hd;
> +
> +	hd = (MPT_SCSI_HOST *) sdev->host->hostdata;
> +	if (!hd)
> +		return -ENXIO;
> +	ioc = hd->ioc;
> +
> +	/* message frame freeQ is busy */
> +	if (spin_is_locked(&ioc->FreeQlock))
> +		return -EBUSY;

As in the scsi code spin_is_locked checks are bogus and racy.  Only
a spin_trylock would be safe.  hd can't be NULL.

