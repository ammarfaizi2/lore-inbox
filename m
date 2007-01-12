Return-Path: <linux-kernel-owner+w=401wt.eu-S1161099AbXALW0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161099AbXALW0s (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 17:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161139AbXALW0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 17:26:48 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:21675 "EHLO hobbit.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161099AbXALW0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 17:26:47 -0500
Message-ID: <45A80B21.6040609@tls.msk.ru>
Date: Sat, 13 Jan 2007 01:26:41 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Icedove 1.5.0.8 (X11/20061128)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Chris Mason <chris.mason@oracle.com>, dean gaudet <dean@arctic.org>,
       Viktor <vvp01@inbox.ru>, Aubrey <aubreylee@gmail.com>,
       Hua Zhong <hzhong@gmail.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, hch@infradead.org,
       kenneth.w.chen@intel.com, akpm@osdl.org
Subject: Re: O_DIRECT question
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com> <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org> <45A629E9.70502@inbox.ru> <Pine.LNX.4.64.0701110750520.3594@woody.osdl.org> <Pine.LNX.4.64.0701112351520.18431@twinlark.arctic.org> <Pine.LNX.4.64.0701120955440.3594@woody.osdl.org> <20070112202316.GA28400@think.oraclecorp.com> <45A7F396.4080600@tls.msk.ru> <45A7F4F2.2080903@tls.msk.ru> <45A7F7A7.1080108@tls.msk.ru> <Pine.LNX.4.64.0701121611370.3470@woody.osdl.org> <45A8038F.2040609@tls.msk.ru> <Pine.LNX.4.64.0701121705440.3470@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701121705440.3470@woody.osdl.org>
X-Enigmail-Version: 0.94.1.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 13 Jan 2007, Michael Tokarev wrote:
>>> At that point, O_DIRECT would be a way of saying "we're going to do 
>>> uncached accesses to this pre-allocated file". Which is a half-way 
>>> sensible thing to do.
>> Half-way?
> 
> I suspect a lot of people actually have other reasons to avoid caches. 
> 
> For example, the reason to do O_DIRECT may well not be that you want to 
> avoid caching per se, but simply because you want to limit page cache 
> activity. In which case O_DIRECT "works", but it's really the wrong thing 
> to do. We could export other ways to do what people ACTUALLY want, that 
> doesn't have the downsides.
> 
> For example, the page cache is absolutely required if you want to mmap. 
> There's no way you can do O_DIRECT and mmap at the same time and expect 
> any kind of sane behaviour. It may not be what a DB wants to use, but it's 
> an example of where O_DIRECT really falls down.

Provided when the two are about the same part of a file.  If not, and if
the file is "divided" on a proper boundary (sector/page/whatever-aligned),
there's no issues, at least not if all the blocks of a file has been allocated
(no gaps, that is).

What I was referring to in my last email - and said it's a corner case - is:
mmap() start of a file, say, first megabyte of it, where some index/bitmap is
located, and use direct-io on the rest.  So the two aren't overlap.

Still problematic?

>>> But what O_DIRECT does right now is _not_ really sensible, and the 
>>> O_DIRECT propeller-heads seem to have some problem even admitting that 
>>> there _is_ a problem, because they don't care. 
>> Well.  In fact, there's NO problems to admit.
>>
>> Yes, yes, yes yes - when you think about it from a general point of
>> view, and think how non-O_DIRECT and O_DIRECT access fits together,
>> it's a complete mess, and you're 100% right it's a mess.
> 
> You can't admit that even O_DIRECT _without_ any non-O_DIRECT actually 
> fails in many ways right now.
> 
> I've already mentioned ftruncate and block allocation. You don't seem to 
> understand that those are ALSO a problem.

I do understand this.  And this is, too, solved right now in userspace.
For example, when oracle allocates a file for its data, or when it extends
the file, it writes something to every block of new space (using O_DIRECT
while at it, but that's a different story).  The thing is: while it is doing
that, no process tries to do anything with that (part of a) file (not counting
some external processes run by evil hackers ;)  So there's still no races
or fundamental brokeness *in usage*.

It uses ftruncate() to create or extend a file, *and* does O_DIRECT writes
to force block allocations.  That's probably not right, and that alone is
probably difficult to implement in kernel (I just don't know; what I know
for sure is that this way is very slow on ext3).  Maybe because there's no
way to tell kernel something like "set the file size to this and actually
*allocate* space for it" (if it doesn't write some structure to the file).

What I dislike very much is - half-solutions.  And current O_DIRECT indeed
looks like half-a-solution, because sometimes it works, and sometimes, in
*wrong* usage scenario, it doesn't, or racy, etc, and kernel *allows* such
a wrong scenario.  A software should either work correctly, or disallow
a usage where it can't guarantee correctness.  Currently, kernel allows
incorrect usage, and that, plus all the ugly things in code done in attempt
to fix that, suxx.

But the whole thing is not (fundamentally) broken.

/mjt
