Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964850AbWAQVWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbWAQVWh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 16:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbWAQVWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 16:22:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:7883 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964850AbWAQVWg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 16:22:36 -0500
Date: Tue, 17 Jan 2006 13:22:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andy Whitcroft <apw@shadowen.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zone gfp_flags generate from ZONE_ constants
Message-Id: <20060117132214.2db664e2.akpm@osdl.org>
In-Reply-To: <20060117155227.GA16176@shadowen.org>
References: <20060117155227.GA16176@shadowen.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft <apw@shadowen.org> wrote:
>
> +/*
>  + * Generate the zone modifier bit.  Zone ZONE_DEFAULT doesn't require a bit
>  + * as the absence of all zone modifiers implies this zone.  Renormalise the
>  + * zone number such that ZONE_DEFAULT is at the bottom and discard it.
>  + * These must fit within the bitmask GFP_ZONEMASK defined in linux/mmzone.h.
>  + */
>  +#define __ZONE_BIT(x) (((x) ^ ZONE_DEFAULT) - 1)
>  +#define ZONE_MODIFIER(x) ((__force gfp_t)(((x) == ZONE_DEFAULT)? (0) : \
>  +							1UL << __ZONE_BIT(x)))
>  +
>  +#define __GFP_DMA	ZONE_MODIFIER(ZONE_DMA)
>  +#define __GFP_HIGHMEM	ZONE_MODIFIER(ZONE_HIGHMEM)
>   #ifdef CONFIG_DMA_IS_DMA32
>  -#define __GFP_DMA32	((__force gfp_t)0x01)	/* ZONE_DMA is ZONE_DMA32 */
>  +#define __GFP_DMA32	ZONE_MODIFIER(ZONE_DMA)	/* ZONE_DMA is ZONE_DMA32 */
>   #elif BITS_PER_LONG < 64
>  -#define __GFP_DMA32	((__force gfp_t)0x00)	/* ZONE_NORMAL is ZONE_DMA32 */
>  +#define __GFP_DMA32	ZONE_MODIFIER(ZONE_NORMAL) /* ZONE_NORMAL is ZONE_DMA32 */
>   #else
>  -#define __GFP_DMA32	((__force gfp_t)0x04)	/* Has own ZONE_DMA32 */
>  +#define __GFP_DMA32	ZONE_MODIFIER(ZONE_DMA32) /* Has own ZONE_DMA32 */
>   #endif

eek.  We often look at the hex value of gfp flags in debug output to work
out what sort of allocation is being attempted.

I guess we could print out the values of these things at boot time..
