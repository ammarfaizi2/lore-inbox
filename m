Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbUDAPku (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 10:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262673AbUDAPku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 10:40:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:23191 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261660AbUDAPkp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 10:40:45 -0500
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0403311550040.1116@ppc970.osdl.org>
References: <1080771361.1991.73.camel@sisko.scot.redhat.com>
	 <Pine.LNX.4.58.0403311433240.1116@ppc970.osdl.org>
	 <1080776487.1991.113.camel@sisko.scot.redhat.com>
	 <Pine.LNX.4.58.0403311550040.1116@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1080834032.2626.94.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 Apr 2004 16:40:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2004-04-01 at 01:08, Linus Torvalds wrote:

> > You can make the same argument for either implementation of MS_ASYNC. 
> Exactly.

> Which is why I say that the implementation cannot matter, because user 
> space would be _buggy_ if it depended on some timing issue.

I see it purely as a performance issue.  That's the context in which we
saw the initial complaint about the 2.4 behaviour change.

> > And there's at least one way in which the "submit IO now" version can be
> > used meaningfully --- if you've got several specific areas of data in
> > one or more mappings that need flushed to disk, you'd be able to
> > initiate IO with multiple MS_ASYNC calls and then wait for completion
> > with either MS_SYNC or fsync().
> 
> Why wouldn't you be able to do that with the current one?

You can, but only across one fd.

        A = mmap(..., a);
        B = mmap(..., b);
        
        msync(A, ..., MS_ASYNC);
        msync(B, ..., MS_ASYNC);
        fsync(a);
        fsync(b);
        
has rather different performance characteristics according to which way
you go.  Do deferred writeback and the two fsync()s do serialised IO,
with the fs idle in between.  Submit the background IO immediately and
you avoid that.

Anyway, I just tried on a Solaris-2.8 box, and the results are rather
interesting.  Doing a simple (touch-one-char, msync one page) loop on a
mmap'ed file on a local scsi disk, MS_ASYNC gives ~15000 msyncs per
second; MS_SYNC gives ~900.  [A null getpid() loop gives about 250,000
loops a second.]

However, the "iostat" shows *exactly* the same disk throughput in each
case.  MS_ASYNC is causing immediate IO kickoff, but shows only ~900 ios
per second, the same as the ios-per-second for MS_SYNC and the same as
the MS_SYNC loop frequency.

So it appears that on Solaris, MS_ASYNC is kicking off instant IO, but
is not waiting for existing IO to complete first.  So if we have an IO
already in progress, then many msync calls end up queuing the *same*
subsequent IO, and once one new IO is queued, further MS_ASYNC msyncs
don't bother scheduling a new one (on the basis that the
already-scheduled one hasn't started yet so the new data is already
guaranteed to hit disk.)

So Solaris behaviour is indeed to begin IO as soon as possible on
MS_ASYNC, but they are doing it far more efficiently than our current
msync code can do.

> Tha advantage of the current MS_ASYNC is absolutely astoundingly HUGE: 
> because we don't wait for in-progress IO, it can be used to efficiently 
> synchronize multiple different areas, and then after that waiting for them 
> with _one_ single fsync().

The Solaris one manages to preserve those properties while still
scheduling the IO "soon".  I'm not sure how we could do that in the
current VFS, short of having a background thread scheduling deferred
writepage()s as soon as the existing page becomes unlocked.

> More importanrtly, the current behaviour makes certain patterns _possible_ 
> that your suggested semantics simply cannot do efficiently. If we have 
> data records smaller than a page, and want to mark them dirty as they 
> happen, the current msync() allows that - it doesn't matter that another 
> datum was marked dirty just a moment ago. Then, you do one fsync() only 
> when you actually want to _commit_ a series of updates before you change 
> the index. 

> But if we want to have another flag, with MS_HALF_ASYNC, that's certainly
> ok by me. I'm all for choice.

Yes, but we _used_ to have that choice --- call msync() with flags == 0,
and you'd get the deferred kupdated writeback; call it with MS_ASYNC and
you'd get instant IO kickoff; call it with MS_SYNC and you'd get
synchronous completion.  But now we've lost the instant kickoff, async
completion option, and MS_ASYNC behaves just like flags==0.  

So I'm all for adding the choice back, and *documenting* it so that
people know exactly what to expect in all three cases.  Whether the
choice comes from an fadvise option or an msync() doesn't bother me that
much.

In that case, the decision about which version of the behaviour MS_ASYNC
should give is (as it should be) a matter of obeying the standard
correctly, and the other useful behaviours are preserved elsewhere. 
Which brings us back to trying to interpret the vague standard.  Both
Uli's interpretation and the Solaris implementation suggest that we need
to start the writepage sooner rather than later.

> > It's very much visible, just from a performance perspective, if you want
> > to support "kick off this IO, I'm going to wait for the completion
> > shortly."
> 
> That may well be worth a call of its own. It has nothing to do with memory 
> mapping, though - what you're really looking for is fasync(). 

Indeed.  And msync(flags==0) remains as a way of synchronising mmaps
with the inode-dirty-list fasync writeback.

> And yes, I agree that _that_ would make sense. Havign some primitives to 
> start writeout of an area of a file would likely be a good thing.
> 
> I'd be perfectly happy with a set of file cache control operations, 
> including
> 
>  - start writeback in [a,b]

posix_fadvise() seems to do something a little like this already: the
FADV_DONTNEED handler tries

		if (!bdi_write_congested(mapping->backing_dev_info))
			filemap_flush(mapping);

before going into the invalidate_mapping_pages() call.  Having that (a)
limited to the specific file range passed into the fadvise(), and (b)
available as a separate function independent of the DONTNEED page
invalidator, would seem like an entirely sensible extension.  

The obvious implementations would be somewhat inefficient in some cases,
though --- currently __filemap_fdatawrite simply list_splice()s the
inode dirty list into the io list.  Walking a long dirty list to flush
just a few pages from a narrow range could get slow, and walking the
radix tree would be inefficient if there are only a few dirty pages
hidden in a large cache of clean pages.

> My argument was that a standard CANNOT say anything one way or the other, 
> because the behaviour IS NOT USER-VISIBLE! 

Worse, it doesn't seem to be implemented consistently either.  I've been
trying on a few other Unixen while writing this.  First on a Tru64 box,
and it is _not_ kicking off any IO at all for MS_ASYNC, except for the
30-second regular sync.  The same appears to be true on FreeBSD.  And on
HP-UX, things go in the other direction: the performance of MS_ASYNC is
identical to MS_SYNC, both in terms of observed disk IO during the sync
and the overall rate of the msync loop.

So it appears we've got Unix precedent for pretty-much any reasonable
interpretation of MS_ASYNC that we want.  Patch withdrawn!

--Stephen

