Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265337AbTGCUCC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 16:02:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265346AbTGCUCC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 16:02:02 -0400
Received: from holomorphy.com ([66.224.33.161]:5059 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265337AbTGCUB5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 16:01:57 -0400
Date: Thu, 3 Jul 2003 13:16:07 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Rik van Riel <riel@redhat.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Mel Gorman <mel@csn.ul.ie>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What to expect with the 2.6 VM
Message-ID: <20030703201607.GK20413@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>, Rik van Riel <riel@redhat.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>, Mel Gorman <mel@csn.ul.ie>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030703125839.GZ23578@dualathlon.random> <Pine.LNX.4.44.0307030904260.16582-100000@chimarrao.boston.redhat.com> <20030703185341.GJ20413@holomorphy.com> <20030703192750.GM23578@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030703192750.GM23578@dualathlon.random>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 03, 2003 at 11:53:41AM -0700, William Lee Irwin III wrote:
>> No, it is not true that pagetable space can be wantonly wasted
>> on 64-bit.
>> Try mmap()'ing something sufficiently huge and accessing on average
>> every PAGE_SIZE'th virtual page, in a single-threaded single process.
>> e.g. various indexing schemes might do this. This is 1 pagetable page
>> per page of data (worse if shared), which blows major goats.

On Thu, Jul 03, 2003 at 09:27:50PM +0200, Andrea Arcangeli wrote:
> that's the very old exploit that touches 1 page per pmd.

It's not an exploit. It's called "random access" or a "sparse mapping".


On Thu, Jul 03, 2003 at 11:53:41AM -0700, William Lee Irwin III wrote:
>> There's a reason why those things use inverted pagetables... at any
>> rate, compacting virtualspace with remap_file_pages() solves it too.
>> Large pages won't help, since the data isn't contiguous.

On Thu, Jul 03, 2003 at 09:27:50PM +0200, Andrea Arcangeli wrote:
> if you can't use a sane design it's not a kernel issue.  this is bad
> userspace code seeking like crazy on disk too, working around it with a
> kernel feature sounds worthless. If algorithms have no locality at all,
> and they spread 1 page per pmd that's their problem.

Hashtables and B-trees are sane designs in my book.

The entire point of the exercise on 64-bit is to allow indexing
algorithms _some_ method of restoring virtual locality so as to
cooperate with the kernel and not throw away vast amounts of space
on pagetables.

Locality of reference in itself is typically already present in the
data access patterns.


On Thu, Jul 03, 2003 at 09:27:50PM +0200, Andrea Arcangeli wrote:
> the easiest way to waste ram with bad code is to add this in the first
> line of the main of a program:
> 	p = malloc(1G)
> 	bzero(p, 1G)
> you don't need 1 page per pmd to waste ram. Should we also write a
> kernel feature that checks if the page is zero and drops it so the above
> won't swap etc..?

I don't know what kind of moron you take me for but I don't care to be
patronized like that.

There is a very, very large difference between utter idiocy like the
above and sparse mappings. And there is a _much_ larger difference
when you add in direct cooperation from userspace to conserve resources
otherwise consumed by sparse mappings by compacting virtualspace with
remap_file_pages() and bullshit like implicitly checking if user pages
are 0 before trying to swap them out.

Color me thoroughly disgusted.


On Thu, Jul 03, 2003 at 09:27:50PM +0200, Andrea Arcangeli wrote:
> If you can come up with a real life example where the 1 page per pmd
> scattered over 1T of address space (we're talking about the file here of
> course, the on disk representation of the data) is the very best design
> possible ever (without any concept of locality at all) and it speeds up
> things of orders of magnitude not to have any locality at all,
> especially for the huge seeking it will generate no matter what the
> pagetable side is, you will then change my mind about it.

It doesn't even need to be an artifact of a design like a hash table or
a B-tree. It can be totally linear and 1:1 but the inputs will mandate
random access.

This entire tangent is ridiculous; the entire counterargument centers
around some desire not to go through the straightforward steps to
support a preexisting feature on the pretext of some notion that
cooperating with the kernel so as not to throw away vast amounts of
space on pagetables and/or vma's is an invalid application behavior.


-- wli
