Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964960AbVL2CTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964960AbVL2CTz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 21:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964962AbVL2CTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 21:19:55 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:22587 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S964960AbVL2CTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 21:19:54 -0500
X-IronPort-AV: i="3.99,305,1131350400"; 
   d="scan'208"; a="245799775:sNHT67783226"
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] [PATCH 11 of 20] ipath - core driver, part 4
 of 4
X-Message-Flag: Warning: May contain useful information
References: <e8af3873b0d910e0c623.1135816290@eng-12.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 28 Dec 2005 18:19:49 -0800
In-Reply-To: <e8af3873b0d910e0c623.1135816290@eng-12.pathscale.com> (Bryan
 O'Sullivan's message of "Wed, 28 Dec 2005 16:31:30 -0800")
Message-ID: <ada1wzwbq62.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 29 Dec 2005 02:19:52.0049 (UTC) FILETIME=[59B90E10:01C60C1E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't notice this before:

 > + * This is volatile as it's the target of a DMA from the chip.
 > + */
 > +
 > +static volatile uint64_t ipath_port0_rcvhdrtail[512]
 > +    __attribute__ ((aligned(4096)));

 ... and then much later ...

 > +	/*
 > +	 * kernel modules loaded into vmalloc'ed memory,
 > +	 * verify that when we assume that, map to phys, and back to virt,
 > +	 * that we get the right contents, so we did the mapping right.
 > +	 */
 > +	vpage = vmalloc_to_page((void *)ipath_port0_rcvhdrtail);
 > +	if (vpage == NOPAGE_SIGBUS || vpage == NOPAGE_OOM) {
 > +		_IPATH_UNIT_ERROR(t, "vmalloc_to_page for rcvhdrtail fails!\n");
 > +		ret = -ENOMEM;
 > +		goto done;
 > +	}

This seems very wrong to me: there's no guarantee that a module will
be loaded into memory that can be used as a DMA target.  For example,
on a non-cache-coherent architecture, I think this memory must be
accessed through a non-cached mapping.

I think the correct solution is to allocate a buffer for each device
with pci_alloc_consistent() (or maybe dma_alloc_coherent()).

(As a general comment, I'm still unhappy about how your driver has a
static, fixed-size table of devices rather than allocating per-device
data structures dynamically)

 - R.
