Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268930AbTBZUrM>; Wed, 26 Feb 2003 15:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268932AbTBZUrM>; Wed, 26 Feb 2003 15:47:12 -0500
Received: from mx12.arcor-online.net ([151.189.8.88]:39135 "EHLO
	mx12.arcor-online.net") by vger.kernel.org with ESMTP
	id <S268930AbTBZUrL>; Wed, 26 Feb 2003 15:47:11 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Rik van Riel <riel@imladris.surriel.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: Minutes from Feb 21 LSE Call
Date: Thu, 27 Feb 2003 04:48:42 +0100
X-Mailer: KMail [version 1.3.2]
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@digeo.com>,
       Hanna Linder <hannal@us.ibm.com>, "" <lse-tech@lists.sf.et>,
       "" <linux-kernel@vger.kernel.org>
References: <20030225174359.GA10411@holomorphy.com> <10220000.1046239279@[10.10.2.4]> <Pine.LNX.4.50L.0302261258280.6749-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.50L.0302261258280.6749-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20030226205727.AD930EACC9@mx12.arcor-online.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 February 2003 17:02, Rik van Riel wrote:
> On Tue, 25 Feb 2003, Martin J. Bligh wrote:
> > It seemed, at least on the simple kernel compile tests that I did, that
> > all the long chains are not anonymous. It killed 95% of the space issue,
> > which given the simplicity of the patch was pretty damned stunning. Yes,
> > there's a pointer per page I guess we could kill in the struct page
> > itself, but I think you already have a better method for killing mem_map
> > bloat ;-)
>
> Also, with copy-on-write and mremap after fork, doing an
> object based rmap scheme for anonymous pages is just complex,
> almost certainly far too complex to be worth it, since it just
> has too many issues.  Just read the patches by bcrl and davem,
> things get hairy fast.
>
> The pte chain rmap scheme is clean, but suffers from too much
> overhead for file mappings.

There is a lot of redundancy in the rmap chains that could be exploited.  If 
a pte page happens to reference a group of  (say) 32 anon pages, then you can 
set each anon page's page->index to its position in the group and let a 
pte_chain node point at the pte of the first page of the group.  You can then 
find each page's pte by adding its page->index to the pte_chain node's pte 
pointer.  This allows a single rmap chain to be shared by all the pages in 
the group.

This much of the idea is simple, however there are some tricky details to 
take care of.  How does a copy-on-write break out one page of the group from 
one of the pte pages?  I tried putting a (32 bit) bitmap in each pte_chain 
node to indicate which pte entries actually belong to the group, and that 
wasn't too bad except for doubling the per-link memory usage, turning a best 
case 32x gain into only 16x.  It's probably better to break the group up, 
creating log2(groupsize) new chains.  (This can be avoided in the common case 
that you already know every page in the group is going to be copied, as with 
a copy_from_user.)  Getting rid of the bitmaps makes the single-page case the 
same as the current arrangement and makes it easy to let the size of a page 
be as large as the capacity of a whole pte page.

There's also the problem of detecting groupable clusters of pages, e.g., in 
do_anon_page.  Swap-out and swap-in introduce more messiness, as does mremap. 
In the end, I decided it's not needed in the current cycle, but probably 
worth investigating later.

My purpose in bringing it up now is to show that there are still some more 
incremental gains to be had without needing radical surgery.

> As shown by Dave's patch, a hybrid system really is simple and
> clean, and it removes most of the pte chain overhead while still
> keeping the code nice and efficient.
>
> I think this hybrid system is the way to go, possibly with a few
> more tweaks left and right...

Emphatically, yes.

Regards,

Daniel
