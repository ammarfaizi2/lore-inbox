Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268286AbRIDTkb>; Tue, 4 Sep 2001 15:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268342AbRIDTkU>; Tue, 4 Sep 2001 15:40:20 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:25746 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S268286AbRIDTkG>; Tue, 4 Sep 2001 15:40:06 -0400
Date: Tue, 4 Sep 2001 15:39:59 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: page_launder() on 2.4.9/10 issue
Message-ID: <20010904153958.A31994@cs.cmu.edu>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
In-Reply-To: <20010904135427.A30503@cs.cmu.edu> <E15eLGd-0004Gd-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15eLGd-0004Gd-00@the-village.bc.nu>
User-Agent: Mutt/1.3.20i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2001 at 07:49:47PM +0100, Alan Cox wrote:
> The VM tuning in the -ac tree is a lot more reliable for most loads (its
> certainly not perfect) and that is because the changes have been done and
> tested one at a time as they are merged. Real engineering process is the
> only way to get this sort of thing working well.

I grabbed the 2.4.9-ac7 patch and looked at some of the files.

Pages allocated with do_anonymous_page are not added to the active list.
as a result there is no aging information for a page until it is
unmapped. So we might be unmapping and allocating swap for shared pages
that another process is using heavily. In which case this page should
always have a high age in in the active list and won't actually get
swapped out. So we get both unnecessary minor faults, and the swap space
will never be reclaimed because we never swap it back in.

Also up aging of mapped process pages is still done in try_to_swap_out,
and all of these pages are still aged down indiscriminately in
refill_inactive_scan. I don't see how it could age that much
differently, so I'm assuming all pages in the active list are basically
at age 0 no matter what aging strategy is picked.

Especially because only down aging is performed periodically by kswapd,
while the only code that ages process pages up is only called once the
system hits free or inactive shortage.

There is some places where tests have been added that should never make
a difference anyways. In reclaim_page and page_launder a page on the
inactive list is checked for page->age. Because the page is not mapped
in any VM it is not possibly for age to be non-zero. If the page was
referenced it would have triggered a minor fault and reactivated the
page.

I guess it is just more carefully papering over the existing problems.

Jan

