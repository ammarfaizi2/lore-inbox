Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261824AbSJNOpi>; Mon, 14 Oct 2002 10:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261826AbSJNOpi>; Mon, 14 Oct 2002 10:45:38 -0400
Received: from mx1.elte.hu ([157.181.1.137]:41642 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S261824AbSJNOpg>;
	Mon, 14 Oct 2002 10:45:36 -0400
Date: Mon, 14 Oct 2002 17:02:26 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>
Subject: Re: [patch, feature] nonlinear mappings, prefaulting support,
 2.5.42-F8
In-Reply-To: <20021014135232.GB4488@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0210141642160.3474-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 14 Oct 2002, William Lee Irwin III wrote:

> > +int sys_remap_file_pages(unsigned long start, unsigned long size,
> > +	unsigned long prot, unsigned long pgoff, unsigned long flags)
> 
> ISTR suggesting vectorizing this to reduce syscall traffic.

well, i dont agree with vectorizing everything, unless it's some really
lightweight thing and/or the operation is somehow naturally vectorized.  
(block and network IO, etc.)

> The semantics of faulting in pages on such a region, while not
> incorrect, are at least unusual enough to raise the question of whether
> it's appropriate for the kernel to fill the pages as opposed to
> returning an error to userspace. [...]

the pagefault path simply does not have the information whether a mapping
was nonlinear, possibly long before. In the initial patch i had a
VM_RANDOM flag for vmas, which was set up at mmap() time, but this
restricted the API needlessly. Tracking whether a mapping was remapped
randomly before does not sound too useful to me either. So right now it's
the responsibility of the user to use the API in a meaningful way - is it
such a big problem?

> [...] The requirement of MAP_LOCKED or PROT_NONE might as well be
> in-kernel if the file offset contiguity assumption is not met, [...]

how would you do this actually, without other restrictions?

> sys_remap_file_pages() also interacts in an unusual way with the
> semantics of MAP_POPULATE. MAP_POPULATE seems to perform a non-blocking
> make_pages_present() operation not shared with MAP_LOCKED, [...]

what it does is a blocking make_pages_present(), for nonblocking you also
need to specify MAP_NONBLOCK. I agree that the mlock path should/could be
merged with the populate path, this was suggested by Linus as well.

> [...] and filemap_populate() performs the file offset contiguous
> prefaulting which again doesn't mix well with the scatter gather
> semantics desired.

huh?

> Also, a stranger phenomenon appears in filemap_populate(), where
> nonblock may be true, and so filemap_getpage() will return NULL, but
> -ENOMEM is returned if filemap_getpage() returns NULL.

true, this is a bug, i fixed it in the -F9 patch at:

	http://redhat.com/~mingo/remap-file-pages-patches/

> Also, I see a significant portion of filemap_nopage() duplicated in
> filemap_getpage(), including long-stale hashtable-related comments.

check the announcement email for details about the seemingly duplicated
code of filemap_nopage() and filemap_getpage(). And which hashing comments
do you mean? We still hash pagecache pages.

	Ingo

