Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278139AbRJLVID>; Fri, 12 Oct 2001 17:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278140AbRJLVHx>; Fri, 12 Oct 2001 17:07:53 -0400
Received: from [204.177.156.37] ([204.177.156.37]:50843 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S278139AbRJLVHk>; Fri, 12 Oct 2001 17:07:40 -0400
Date: Fri, 12 Oct 2001 22:09:37 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
cc: linux-kernel@vger.kernel.org, Alan Cox <laughing@shared-source.org>
Subject: Re: Linux 2.4.10-ac11: swapoff frees memory + swap?
In-Reply-To: <20011011045909.A13276@emma1.emma.line.org>
Message-ID: <Pine.LNX.4.21.0110122115480.975-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Oct 2001, Matthias Andree wrote:
> 
> It swaps blazingly fast, but one strange observation. After the efenced
> application had died at approx 300 MB in RAM and 180 MB of swap, I had
> somewhat around 130 MB in swap and like 250 MB "USED+SHAR" as per
> xosview. That looked too high a number, so I did swapoff -av, and after
> that, I had 90 MB used. The swapoff was rather fast, compared with older
> 2.4.x vanilla kernels.
> 
> It may well be a cosmetic issue, but it's irritating that switching the
> swap off looks like freeing main memory as well, one might expect pages
> are swapped back into RAM, so USED increases.

That's because when your application exits, zap_pte_range frees page and
swap for the present ptes, but only swap_free for the non-present ptes:
sometimes that brings the swap count down to 1 (still used), but that 1
corresponds to page remaining in the swap cache which could now be freed.

There's no lookup in that case, intentionally.  A patch was posted a few
months ago to do so, but Linus preferred not to add such unmap overhead.
Indeed, for a while we didn't even free swap for the present ptes, but a
number of problems arose from that (maybe now fixed in other ways, but I
don't think we dare to reopen that wormcan).

In due course, when memory pressure demands, reclaim_page (Alan+Rik)
or shrink_cache (Linus+Andrea) will discover those pages and make them
available.  Or, as you found, swapoff will free them: one of the reasons
swapoff is now faster is that it no longers searches mms in that case.

Hugh

