Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261423AbVDMTdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbVDMTdL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 15:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbVDMTdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 15:33:07 -0400
Received: from fire.osdl.org ([65.172.181.4]:42181 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261255AbVDMTcs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 15:32:48 -0400
Date: Wed, 13 Apr 2005 12:32:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roland Dreier <roland@topspin.com>
Cc: mst@mellanox.co.il, libor@topspin.com, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
Message-Id: <20050413123230.7a18dff5.akpm@osdl.org>
In-Reply-To: <52sm1upm4s.fsf@topspin.com>
References: <200544159.Ahk9l0puXy39U6u6@topspin.com>
	<20050411142213.GC26127@kalmia.hozed.org>
	<52mzs51g5g.fsf@topspin.com>
	<20050411163342.GE26127@kalmia.hozed.org>
	<5264yt1cbu.fsf@topspin.com>
	<20050411180107.GF26127@kalmia.hozed.org>
	<52oeclyyw3.fsf@topspin.com>
	<20050411171347.7e05859f.akpm@osdl.org>
	<521x9gyhe7.fsf@topspin.com>
	<20050412182357.GA24047@mellanox.co.il>
	<52sm1upm4s.fsf@topspin.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier <roland@topspin.com> wrote:
>
> OK, I'm by no means an expert on this, but Libor and I looked at
> rmap.c a little more, and there is code:
> 
> 	if ((vma->vm_flags & (VM_LOCKED|VM_RESERVED)) ||
> 			ptep_clear_flush_young(vma, address, pte)) {
> 		ret = SWAP_FAIL;
> 		goto out_unmap;
> 	}
> 
> before the check
> 
> 	if (PageSwapCache(page) &&
> 	    page_count(page) != page_mapcount(page) + 2) {
> 		ret = SWAP_FAIL;
> 		goto out_unmap;
> 	}
> 
> If userspace allocates some memory but doesn't touch it aside from
> passing the address in to the kernel, which does get_user_pages(), the
> PTE will be young in that first test, right?

If get_user_pages() was called with write=1, get_user_pages() will fault in
a real page and yes, I guess it'll be pte_young.

If get_user_pages() was called with write=0, get_user_pages() will fault
in a mapping of the zero page and we'd never get this far.

> Does that mean that
> the userspace mapping will be cleared and userspace will get a
> different physical page if it faults that address back in? 
>

We won't try to unmap a page's ptes until that page has file-or-swapcache
backing.

If the pte is then cleared, a subsequent minor fault will reestablish the
mapping to the same physical page.  A major fault cannot happen because the
page was pinned by get_user_pages().

