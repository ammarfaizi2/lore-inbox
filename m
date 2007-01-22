Return-Path: <linux-kernel-owner+w=401wt.eu-S1751865AbXAVBri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865AbXAVBri (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 20:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751866AbXAVBri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 20:47:38 -0500
Received: from ns.suse.de ([195.135.220.2]:41008 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751865AbXAVBri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 20:47:38 -0500
Date: Mon, 22 Jan 2007 02:47:51 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: andersen@codepoet.org, Linus Torvalds <torvalds@osdl.org>,
       Michael Tokarev <mjt@tls.msk.ru>, Chris Mason <chris.mason@oracle.com>,
       dean gaudet <dean@arctic.org>, Viktor <vvp01@inbox.ru>,
       Aubrey <aubreylee@gmail.com>, Hua Zhong <hzhong@gmail.com>,
       Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       hch@infradead.org, kenneth.w.chen@intel.com
Subject: Re: O_DIRECT question
Message-ID: <20070122014751.GT13798@opteron.random>
References: <Pine.LNX.4.64.0701120955440.3594@woody.osdl.org> <20070112202316.GA28400@think.oraclecorp.com> <45A7F396.4080600@tls.msk.ru> <45A7F4F2.2080903@tls.msk.ru> <45A7F7A7.1080108@tls.msk.ru> <Pine.LNX.4.64.0701121611370.3470@woody.osdl.org> <45A8038F.2040609@tls.msk.ru> <Pine.LNX.4.64.0701121705440.3470@woody.osdl.org> <20070112223509.GA12512@codepoet.org> <20070112144748.6c4bb19e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070112144748.6c4bb19e.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

This is a long thread about O_DIRECT surprisingly without a single
bugreport in it, that's a good sign that O_DIRECT is starting to work
well in 2.6 too ;)

On Fri, Jan 12, 2007 at 02:47:48PM -0800, Andrew Morton wrote:
> On Fri, 12 Jan 2007 15:35:09 -0700
> Erik Andersen <andersen@codepoet.org> wrote:
> 
> > On Fri Jan 12, 2007 at 05:09:09PM -0500, Linus Torvalds wrote:
> > > I suspect a lot of people actually have other reasons to avoid caches. 
> > > 
> > > For example, the reason to do O_DIRECT may well not be that you want to 
> > > avoid caching per se, but simply because you want to limit page cache 
> > > activity. In which case O_DIRECT "works", but it's really the wrong thing 
> > > to do. We could export other ways to do what people ACTUALLY want, that 
> > > doesn't have the downsides.
> > 
> > I was rather fond of the old O_STREAMING patch by Robert Love,
> 
> That was an akpmpatch whcih I did for the Digeo kernel.  Robert picked it
> up to dehackify it and get it into mainline, but we ended up deciding that
> posix_fadvise() was the way to go because it's standards-based.
> 
> It's a bit more work in the app to use posix_fadvise() well.  But the
> results will be better.  The app should also use sync_file_range()
> intelligently to control its pagecache use.
> 
> The problem with all of these things is that the application needs to be
> changed, and people often cannot do that.  If we want a general way of

And if the application needs to be changed then IMHO it sounds better
to go the last mile and to use O_DIRECT instead of O_STREAMING to run
in zerocopy. Benchmarks have been posted here as well to show what a
kind of difference O_DIRECT can make. O_STREAMING really shouldn't
exist and all O_STREAMING users should be converted to
O_DIRECT.

The only reason O_DIRECT exists is to bypass the pagecache and to run
in zerocopy, to avoid all pagecache lookups and locking, to preserve
cpu caches, to avoid losing smp scalability in the memory bus in
not-numa systems, and to avoid the general cpu overhead of copying the
data with the cpu for no good reason. The cache polluting avoidance
that O_STREAMING and fadvise can also provide, is an almost not
interesting feature.

I'm afraid databases aren't totally stupid here using O_DIRECT, the
caches they keep in ram isn't necessarily always a 1:1 mapping of the
on-disk data, so replacing O_DIRECT with a MAP_SHARED of the source
file, wouldn't be the best even if they could be convinced to trust
the OS instead of insisting to bypass it (and if they could combine
MAP_SHARED with asyncio somehow). They don't have problems to trust
the OS when they map tmpfs as MAP_SHARED after all... Why to waste
time copying the data through pagecache if the pagecache itself won't
be useful when the db is properly tuned?

Linus may be right that perhaps one day the CPU will be so much faster
than disk that such a copy will not be measurable and then O_DIRECT
could be downgraded to O_STREAMING or an fadvise. If such a day will
come by, probably that same day Dr. Tanenbaum will be finally right
about his OS design too.

Storage speed is growing along cpu speeds, especially with contiguous
I/O and by using fast raid storage, so I don't see it very likely that
we can ignore those memory copies any time soon. Perhaps an average
amd64 desktop system with a single sata disk may never get a real
benefit from O_DIRECT compared to O_STREAMING, but that's not the
point as linux doesn't only run on desktops with a single SATA disk
running at only 50M/sec (and abysmal performance while seeking).

With regard to the locking mess, O_DIRECT already fallback to buffered
mode while creating new blocks and uses proper locking to serialize
against i_size changes (by sct). filling holes and i_size changes are
the forbidden sins of O_DIRECT. The rest is just a matter of cache
invalidates or cache flushes run at the right time.

With more recent 2.6 changes, even further complexity has been
introduced to allow mapped cache to see O_DIRECT writes, I've never
been convinced that this was really useful. There was nothing wrong in
having a not uptodate page mapped in userland (except to workaround an
artifical BUG_ON that tried to enforce that artificial invariant for
no apparent required reason), but it should work ok and it can be seen
as a new feature.
