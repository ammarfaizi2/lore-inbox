Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129805AbRAITh2>; Tue, 9 Jan 2001 14:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131193AbRAIThT>; Tue, 9 Jan 2001 14:37:19 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:48146 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130113AbRAIThN>; Tue, 9 Jan 2001 14:37:13 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Subtle MM bug
Date: 9 Jan 2001 11:37:05 -0800
Organization: Transmeta Corporation
Message-ID: <93fp91$26b$1@penguin.transmeta.com>
In-Reply-To: <dnbstgewoj.fsf@magla.iskon.hr> <Pine.LNX.4.10.10101091041150.2070-100000@penguin.transmeta.com> <3A5B61F7.FB0E79C1@innominate.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3A5B61F7.FB0E79C1@innominate.de>,
Daniel Phillips  <phillips@innominate.de> wrote:
>Linus Torvalds wrote:
>> (This is why I worked so hard at getting the PageDirty semantics right in
>> the last two months or so - and why I released 2.4.0 when I did. Getting
>> PageDirty right was the big step to make all of the VM stuff possible in
>> the first place. Even if it probably looked a bit foolhardy to change the
>> semantics of "writepage()" quite radically just before 2.4 was released).
>
>On the topic of writepage, it's not symmetric with readpage at the
>moment - it still takes (struct file *).  Is this in the cleanup
>pipeline?  It looks like nfs_readpage already ignores the struct file *,
>but maybe some other net filesystems are still depending on it.

readpage() is always a synchronous operation, and is actually much more
closely linked to "prepare_write()"/"commit_write()" than to writepage,
despite the naming similarities.

So no, the two are not symmetric, and they really shouldn't be. 

"readpage()" is for reading a page into the page cache, and is always
synchronous with the reader (even prefetching is "synchronous" in the
sense that it's done by the reader: it's asynchronous in the sense that
we don't wait for the results, but the _calling_ of readpage() is
synchronous, if you see what I mean).

Similarly, prepare_write() and commit_write() are synchronous to the
writer (again, we do not wait for the writes to have actually
_happened_, but we call the functions synchronously and they can choose
to let the actual IO happen asynchronously - the VM doesn't care about
that small detail). 

So "readpage()" and "prepare_write()/commit_write()" are pairs.  They
are different simply because reading is assumed to be a cacheable and
prefetchable operation (think regular CPU caches), while writing
obviously has to give a much stricter "write _these_ bytes, not the
whole cache line". 

In contrast, writepage() is a completely different animal. It's
basically a cache eviction notice, and happens asynchronously to any
operations that actually fill or dirty the cache. So despite the name,
it really as an operation has absolutely nothing in common with
readpage(), other than the fact that it is supposed to obviously do the
IO associated with the name.

Writepage has a friend in "sync_page()", which is another asynchronous
call-back that basically says "we want you to start your IO _now_". It's
similar to "writepage()" in that it's a kind of cache state
notification: while writepage() notifies that the cached page wants to
be evicted, "sync_page()" notifies that the cached page is waited upon
by somebody else and that we want to speed up any background IO on it.

You'll notice that writepage()/sync_page() have similar calling
convention, while readpage/prepare_write/commit_write have similar
calling conventions.

The one operation that _really_ stands out is "bmap()".  It has
absolutely no calling convention at all, and is not symmetric with
anything. Pretty ugly, but easily supported.

			Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
