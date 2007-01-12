Return-Path: <linux-kernel-owner+w=401wt.eu-S1161100AbXALVyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161100AbXALVyb (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 16:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161105AbXALVyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 16:54:31 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:23480 "EHLO hobbit.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161100AbXALVya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 16:54:30 -0500
Message-ID: <45A8038F.2040609@tls.msk.ru>
Date: Sat, 13 Jan 2007 00:54:23 +0300
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
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com> <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org> <45A629E9.70502@inbox.ru> <Pine.LNX.4.64.0701110750520.3594@woody.osdl.org> <Pine.LNX.4.64.0701112351520.18431@twinlark.arctic.org> <Pine.LNX.4.64.0701120955440.3594@woody.osdl.org> <20070112202316.GA28400@think.oraclecorp.com> <45A7F396.4080600@tls.msk.ru> <45A7F4F2.2080903@tls.msk.ru> <45A7F7A7.1080108@tls.msk.ru> <Pine.LNX.4.64.0701121611370.3470@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701121611370.3470@woody.osdl.org>
X-Enigmail-Version: 0.94.1.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
[]
> My point is that you can get basically ALL THE SAME GOOD BEHAVIOUR without 
> having all the BAD behaviour that O_DIRECT adds.

*This* point I got from the beginning, once I tried to think how it all
is done internally (I never thought about that, because I'm not a kernel
hacker to start with) -- currently, linux has ugly/racy places which are
either difficult or impossible to fix, all due to this O_DIRECT thing
which iteracts badly with other access "methods".

> For example, just the requirement that O_DIRECT can never create a file 
> mapping, and can never interact with ftruncate would actually make 
> O_DIRECT a lot more palatable to me. Together with just the requirement 
> that an O_DIRECT open would literally disallow any non-O_DIRECT accesses, 
> and flush the page cache entirely, would make all the aliases go away.
> 
> At that point, O_DIRECT would be a way of saying "we're going to do 
> uncached accesses to this pre-allocated file". Which is a half-way 
> sensible thing to do.

Half-way?

> But what O_DIRECT does right now is _not_ really sensible, and the 
> O_DIRECT propeller-heads seem to have some problem even admitting that 
> there _is_ a problem, because they don't care. 

Well.  In fact, there's NO problems to admit.

Yes, yes, yes yes - when you think about it from a general point of
view, and think how non-O_DIRECT and O_DIRECT access fits together,
it's a complete mess, and you're 100% right it's a mess.

But.  Those damn "database people" don't mix and match the two accesses
together (I'm not one of them, either - I'm just trying to use a DB
product on linux).  So there's just no issue.  The solution to in-kernel
races and problems in this case is the usage scenario, and in following
simple usage rules.  Basically, the above requiriment - "don't mix&match
the two together" - is implemented in userspace (yes, there's no guarantee
that someone/thing will not do some evil thing, but that's controlled by
file permisions).  That is, database software itself will not try to use
the thing in a wrong way.  Simple as that.

> A lot of DB people seem to simply not care about security or anything 
> else.anything else. I'm trying to tell you that quoting numbers is 
> pointless, when simply the CORRECTNESS of O_DIRECT is very much in doubt.

When done properly - be it in user- or kernel-space, it IS correct.  No
database people are ftruncating() a file *and* reading from the past-end
of it at the same time for example, and don't mix-n-match cached and direct
io, at least not for the same part of a file (if there are, they're really
braindead, or it's just a plain bug).

> I can calculate PI to a billion decimal places in my head in .1 seconds. 
> If you don't care about the CORRECTNESS of the result, that is.
> 
> See? It's not about performance. It's about O_DIRECT being fundamentally 
> broken as it behaves right now.

I recall again the above: the actual USAGE of O_DIRECT, as implemented
in database software, tries to ensure there's no brokeness, especially
fundamental brokeness, just by not performing parallel direct/non-direct
read/writes/truncates.  This way, the thing Just Works, works *correctly*
(provided there's no bugs all the way down to a device), *and* works *fast*.

By the way, I can think of some useful cases where *parts* of a file are
mmap()ed (even for RW access), and parts are being read/written with O_DIRECT.
But that's probably some corner cases.

/mjt
