Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310552AbSCLLoc>; Tue, 12 Mar 2002 06:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310561AbSCLLoZ>; Tue, 12 Mar 2002 06:44:25 -0500
Received: from dsl-213-023-043-170.arcor-ip.net ([213.23.43.170]:2709 "EHLO
	starship") by vger.kernel.org with ESMTP id <S310552AbSCLLoO>;
	Tue, 12 Mar 2002 06:44:14 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [CFT] delayed allocation and multipage I/O patches for 2.5.6.
Date: Tue, 12 Mar 2002 12:39:28 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <3C8D9999.83F991DB@zip.com.au>
In-Reply-To: <3C8D9999.83F991DB@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16kkcq-0001rV-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 12, 2002 07:00 am, Andrew Morton wrote:
> dallocbase-15-pageprivate
> 
>   page->buffers is a bit of a layering violation.  Not all address_spaces
>   have pages which are backed by buffers.
> 
>   The exclusive use of page->buffers for buffers means that a piece of prime
>   real estate in struct page is unavailable to other forms of address_space.
> 
>   This patch turns page->buffers into `unsigned long page->private' and sets
>   in place all the infrastructure which is needed to allow other address_spaces
>   to use this storage.
> 
>   With this change in place, the multipage-bio no-buffer_head code can use
>   page->private to cache the results of an earlier get_block(), so repeated
>   calls into the filesystem are not needed in the case of file overwriting.

That's pragmatic, a good short term solution.  Getting rid of page->buffers 
entirely will be nicer, and in that case you want to cache the physical block
only for those pages that have one, e.g., not for swap-backed pages, which
keep that information in the page table.

I've been playing with the idea of caching the physical block in the radix
tree, which imposes the cost only on cache pages.  This forces you to do a
tree probe at IO time, but that cost is probably insignificant against the
cost of the IO.  This arrangement could make it quite convenient for the
filesystem to exploit the structure by doing opportunistic map-ahead, i.e.,
when ->get_block consults the metadata to fill in one physical address, why
not fill in several more, if it's convenient?

-- 
Daniel
