Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262678AbULPOce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262678AbULPOce (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 09:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262684AbULPOaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 09:30:20 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:31156 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S262678AbULPO2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 09:28:43 -0500
Date: Thu, 16 Dec 2004 15:28:20 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Dave Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at mm/rmap.c:480 in 2.6.10-rc3-bk7
Message-ID: <20041216142820.GN28286@dualathlon.random>
References: <20041215234141.GA9268@kroah.com> <Pine.LNX.4.44.0412160455520.4496-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0412160455520.4496-100000@localhost.localdomain>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2004 at 05:18:59AM +0000, Hugh Dickins wrote:
> going on, such avoidance may be the right course of action; but not yet.

Yes, the real reason of my changes are quite unrelated to this bug: i.e.
we to keep mapcount zero for all pages with page->mapping = NULL so they
don't even enter objrmap.c, and to enforce other nice bits like that
page-reserved must have page->mapping = NULL and other VM_RESERVED
related enforcements. It wasn't meant to hide bugs and infact we should
remove anything that that hides real bugs if my changes are truly hiding
them. I still don't excude they're a real fix though, the fact I can't
tell the exact reason why they help doesn't mean they're not fixing the
real bug (there's quite some code in objrmap.c that definitely should
not be involved with non-pageable pages, and my patch enforces this,
unlike mainline).

Infact if a page becomes suddenly unreserved, shouldn't the accounting
break anyways at the page->count level? The page would be freed twice
instead of once.

I wonder if the sg_cleanup explains why some mapped reserved page
suddenly become unreserved. Can you track if the DRM_IOCTL_SG_FREE is
being called in a mapped vma? I guess you could start by enabling
DRM(flags) in drm_init.h.

#if 0
int DRM(flags) = DRM_FLAG_DEBUG;
#else
int DRM(flags) = 0;
#endif

(set to 1 and then it should print something)
