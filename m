Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030315AbVHKOCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030315AbVHKOCi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 10:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030318AbVHKOCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 10:02:38 -0400
Received: from gold.veritas.com ([143.127.12.110]:42921 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1030315AbVHKOCh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 10:02:37 -0400
Date: Thu, 11 Aug 2005 15:04:29 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Gleb Natapov <glebn@voltaire.com>
cc: "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Roland Dreier <roland@topspin.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH repost] PROT_DONTCOPY: ifiniband
 uverbs fork support
In-Reply-To: <20050811080205.GR16361@minantech.com>
Message-ID: <Pine.LNX.4.61.0508111446030.10888@goblin.wat.veritas.com>
References: <20050719165542.GB16028@mellanox.co.il> <20050725171928.GC12206@mellanox.co.il>
 <Pine.LNX.4.61.0507261312460.16985@goblin.wat.veritas.com>
 <20050726133553.GA22276@mellanox.co.il> <Pine.LNX.4.61.0508091759050.14886@goblin.wat.veritas.com>
 <20050810083943.GM16361@minantech.com> <Pine.LNX.4.61.0508101412530.3153@goblin.wat.veritas.com>
 <20050810132611.GP16361@minantech.com> <Pine.LNX.4.61.0508101623480.4525@goblin.wat.veritas.com>
 <20050811080205.GR16361@minantech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 11 Aug 2005 14:02:35.0150 (UTC) FILETIME=[530EB2E0:01C59E7D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Aug 2005, Gleb Natapov wrote:
> What about the idea that was floating around about new VM flag that will
> instruct kernel to copy pages belonging to the vma on fork instead of mark
> them as cow?

It's a pretty good idea, and thanks for reminding us of it.

It suffers from the general difficulty with fixes within get_user_pages,
that we need down_write(&mm->mmap_sem) to split_vma, and even just to
update vm_flags, whereas get_user_pages is entered with down_read.

Really, we'd prefer not to mess with the vma itself in get_user_pages.
Could mark the ptes instead, perhaps, but that gets very architecture-
dependent.  A separate array?  not so nice if the vma is very large
and the get_user_pages area very small.

I had toyed with leaving the ptes in the parent as writable, made
readonly just in the child; but though that violation could be excused
while get_user_pages is active, it would have to be corrected at the
end, and that gets complicated again.

Hugh
