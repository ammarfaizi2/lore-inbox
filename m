Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261823AbSJNPSp>; Mon, 14 Oct 2002 11:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261826AbSJNPSp>; Mon, 14 Oct 2002 11:18:45 -0400
Received: from holomorphy.com ([66.224.33.161]:34447 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261823AbSJNPSm>;
	Mon, 14 Oct 2002 11:18:42 -0400
Date: Mon, 14 Oct 2002 08:20:48 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [patch, feature] nonlinear mappings, prefaulting support, 2.5.42-F8
Message-ID: <20021014152048.GC4488@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20021014135232.GB4488@holomorphy.com> <Pine.LNX.4.44.0210141642160.3474-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210141642160.3474-100000@localhost.localdomain>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Oct 2002, William Lee Irwin III wrote:
>> ISTR suggesting vectorizing this to reduce syscall traffic.

On Mon, Oct 14, 2002 at 05:02:26PM +0200, Ingo Molnar wrote:
> well, i dont agree with vectorizing everything, unless it's some really
> lightweight thing and/or the operation is somehow naturally vectorized.  
> (block and network IO, etc.)

I would say it makes sense for its intended purpose, as large volumes
of pages are expected to be remapped this way.


On Mon, 14 Oct 2002, William Lee Irwin III wrote:
>> The semantics of faulting in pages on such a region, while not
>> incorrect, are at least unusual enough to raise the question of whether
>> it's appropriate for the kernel to fill the pages as opposed to
>> returning an error to userspace. [...]

On Mon, Oct 14, 2002 at 05:02:26PM +0200, Ingo Molnar wrote:
> the pagefault path simply does not have the information whether a mapping
> was nonlinear, possibly long before. In the initial patch i had a
> VM_RANDOM flag for vmas, which was set up at mmap() time, but this
> restricted the API needlessly. Tracking whether a mapping was remapped
> randomly before does not sound too useful to me either. So right now it's
> the responsibility of the user to use the API in a meaningful way - is it
> such a big problem?

The VM_RANDOM flag was a safety net I believed to be beneficial, in
part because userspace would be limited in how it can utilize the
remapping facility without guarantees that mappings are not implicitly
established in ways it does not expect.


On Mon, 14 Oct 2002, William Lee Irwin III wrote:
>> [...] The requirement of MAP_LOCKED or PROT_NONE might as well be
>> in-kernel if the file offset contiguity assumption is not met, [...]

On Mon, Oct 14, 2002 at 05:02:26PM +0200, Ingo Molnar wrote:
> how would you do this actually, without other restrictions?

It would be easy to keep the VM_RANDOM flag for truly random vma's,
and check for file offsets matching in the prefault path for others.


On Mon, 14 Oct 2002, William Lee Irwin III wrote:
>> sys_remap_file_pages() also interacts in an unusual way with the
>> semantics of MAP_POPULATE. MAP_POPULATE seems to perform a non-blocking
>> make_pages_present() operation not shared with MAP_LOCKED, [...]

On Mon, Oct 14, 2002 at 05:02:26PM +0200, Ingo Molnar wrote:
> what it does is a blocking make_pages_present(), for nonblocking you also
> need to specify MAP_NONBLOCK. I agree that the mlock path should/could be
> merged with the populate path, this was suggested by Linus as well.

It's optionally nonblocking, a small communication failure of mine.


On Mon, 14 Oct 2002, William Lee Irwin III wrote:
>> [...] and filemap_populate() performs the file offset contiguous
>> prefaulting which again doesn't mix well with the scatter gather
>> semantics desired.

On Mon, Oct 14, 2002 at 05:02:26PM +0200, Ingo Molnar wrote:
> huh?

A nonblocking filemap_populate() may partially populate a virtual
address range and the user may later fault in pages not file offset
contiguous in the prefaulted region as opposed to discovering them as
not present. For the MAP_LOCKED | PROT_NONE scenario this would apply
only with a nonblocking prefault on a MAP_LOCKED vma, where the caller
would find stale mappings where the prefault operation failed, and even
if the nonblocking path invalidated the pte's one would still return to
faulting in of the wrong pages. This is a safety question limiting the
usefulness of nonblocking prefaults on scatter gather vma's to userspace.


On Mon, 14 Oct 2002, William Lee Irwin III wrote:
>> Also, I see a significant portion of filemap_nopage() duplicated in
>> filemap_getpage(), including long-stale hashtable-related comments.

On Mon, Oct 14, 2002 at 05:02:26PM +0200, Ingo Molnar wrote:
> check the announcement email for details about the seemingly duplicated
> code of filemap_nopage() and filemap_getpage(). And which hashing comments
> do you mean? We still hash pagecache pages.

Since the inclusion of the radix tree pagecache I've regarded these
comments about hashing as stale.


Bill
