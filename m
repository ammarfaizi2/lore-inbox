Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbVAFOnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbVAFOnN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 09:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262842AbVAFOnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 09:43:13 -0500
Received: from colin2.muc.de ([193.149.48.15]:35598 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261875AbVAFOnI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 09:43:08 -0500
Date: 6 Jan 2005 15:43:07 +0100
Date: Thu, 6 Jan 2005 15:43:07 +0100
From: Andi Kleen <ak@muc.de>
To: Steve Longerbeam <stevel@mvista.com>
Cc: Hugh Dickins <hugh@veritas.com>, Ray Bryant <raybry@sgi.com>,
       Hirokazu Takahashi <taka@valinux.co.jp>,
       Dave Hansen <haveblue@us.ibm.com>,
       Marcello Tosatti <marcelo.tosatti@cyclades.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, andrew morton <akpm@osdl.org>
Subject: Re: page migration patchset
Message-ID: <20050106144307.GB59451@muc.de>
References: <Pine.LNX.4.44.0501052008160.8705-100000@localhost.localdomain> <41DC7EAD.8010407@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41DC7EAD.8010407@mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2005 at 03:56:29PM -0800, Steve Longerbeam wrote:
> Hugetlbfs is also defining its own shared policy RB tree in its
> inode info struct, but it doesn't seem to be used, just initialized
> and freed at alloc/destroy inode time. Does anyone know why that
> is there? A place-holder for future hugetlbfs mempolicy support?
> If so, it can be removed and use the generic_file policies instead.

You need lazy hugetlbfs to use it (= allocate at page fault time,
not mmap time). Otherwise the policy can never be applied. I implemented 
my own version of lazy allocation for SLES9, but when I wanted to 
merge it into mainline some other people told they had a much better 
singing&dancing lazy hugetlb patch. So I waited for them, but they 
never went forward with their stuff and their code seems to be dead
now. So this is still a dangling end :/

If nothing happens soon regarding the "other" hugetlb code I will
forward port my SLES9 code. It already has NUMA policy support.

For now you can remove the hugetlb policy code from mainline if you
want, it would be easy to readd it when lazy hugetlbfs is merged.

> 
> >(And I still don't know what should be done about NUMA policy versus
> >swap: it has not been anyone's priority, but swapin_readahead's NUMA
> >belief that swap is laid out linearly following vmas is quite wrong.
> >Should page migration be used instead?  Should swap be divided into
> >per-node extents?  Does swap readahead really serve a useful purpose,
> >or could we just delete that code?  Should NUMA policy on a file be
> >determining NUMA policy on private swap copies of that file?

It's on my TODO list, but I haven't had time to work on it. But Steve's
simple minded page migration is probably the right way to fix it anyways,
so once that it is in it just needs some extension.

Basically you would delete the code and then later migrate the pages.
Not very nice, but I didn't come up with a better design so far.

-Andi
