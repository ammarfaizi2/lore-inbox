Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932669AbVKBM1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932669AbVKBM1h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 07:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932670AbVKBM1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 07:27:37 -0500
Received: from silver.veritas.com ([143.127.12.111]:4898 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932669AbVKBM1g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 07:27:36 -0500
Date: Wed, 2 Nov 2005 12:26:34 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nick's core remove PageReserved broke vmware...
In-Reply-To: <4368139A.30701@vc.cvut.cz>
Message-ID: <Pine.LNX.4.61.0511021208070.7300@goblin.wat.veritas.com>
References: <4367C25B.7010300@vc.cvut.cz> <4368097A.1080601@yahoo.com.au>
 <4368139A.30701@vc.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 02 Nov 2005 12:27:36.0572 (UTC) FILETIME=[CEB9F3C0:01C5DFA8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Nov 2005, Petr Vandrovec wrote:
> 
> Nope.  We are not having PageReserved() set on our pages since we want them
> refcounted.  But old SuSE kernels contained this code which was rather unhappy
> if page did not have ->mapping set.

Yes, Andrea's do_no_page enforced some tests which I found confusing and
unhelpful, so I didn't propagate them to mainline when porting his rmap.

> So we just marked vma VM_RESERVED, as it
> did not hurt, and all pages in this vma have refcount > 1 anyway so there is
> no point in trying to cleanup these page tables.  Now rmap catches this by
> page_count() != page_mapcount(), so VM_RESERVED is not needed anymore, but
> there did not seem to be any reason to remove it.

Well, beware.  That "page_count() != page_mapcount() + 2" check in rmap.c
went away in 2.6.13: the problem it was there to solve being solved
instead by a can_share_swap_page based on page_mapcount instead of
page_count (partly to fix a page migration progress problem).

So, you may still be in trouble?  But how do the pages you're concerned
with come to be on the LRU in the first place?  If they're not on the
LRU, vmscanning will never try to take them away.  Most drivers with
special pages, and ->mapping unset, don't put the pages on the LRU.

> --- vmmon-only/linux/driver.c.orig	2005-11-02 02:00:46.000000000 +0100
> +++ vmmon-only/linux/driver.c	2005-11-01 20:12:13.000000000 +0100
> @@ -1283,9 +1283,13 @@
> /*
> * It seems that SuSE's 2.6.4-52 needs this.  Hopefully
> * it will not break anything else.
> +    *
> +    * It breaks on post 2.6.14 kernels, so get rid of it on them.
>    */
>  #ifdef VM_RESERVED
> +#  if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 14)
>     vma->vm_flags |= VM_RESERVED;
> +#  endif
> #endif
>   return 0;
> }

Nick's PageReserved/VM_RESERVED changes are not in 2.6.14 so I'd expect
2.6.15 there.  Ah, you're trying to handle this awkward interval before
2.6.15-rc1 brings the numbering up to 2.6.15, okay.

Hugh
