Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbUDAAIU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 19:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262125AbUDAAIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 19:08:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:13248 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262104AbUDAAIQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 19:08:16 -0500
Date: Wed, 31 Mar 2004 16:08:05 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
In-Reply-To: <1080776487.1991.113.camel@sisko.scot.redhat.com>
Message-ID: <Pine.LNX.4.58.0403311550040.1116@ppc970.osdl.org>
References: <1080771361.1991.73.camel@sisko.scot.redhat.com> 
 <Pine.LNX.4.58.0403311433240.1116@ppc970.osdl.org>
 <1080776487.1991.113.camel@sisko.scot.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 1 Apr 2004, Stephen C. Tweedie wrote:
> 
> On Wed, 2004-03-31 at 23:37, Linus Torvalds wrote:
>
> > If you care about the data hitting the disk, you have to use fsync() or 
> > similar _anyway_, and pretending anything else is just bogus.
> 
> You can make the same argument for either implementation of MS_ASYNC. 

Exactly.

Which is why I say that the implementation cannot matter, because user 
space would be _buggy_ if it depended on some timing issue.

> And there's at least one way in which the "submit IO now" version can be
> used meaningfully --- if you've got several specific areas of data in
> one or more mappings that need flushed to disk, you'd be able to
> initiate IO with multiple MS_ASYNC calls and then wait for completion
> with either MS_SYNC or fsync().

Why wouldn't you be able to do that with the current one?

Tha advantage of the current MS_ASYNC is absolutely astoundingly HUGE: 
because we don't wait for in-progress IO, it can be used to efficiently 
synchronize multiple different areas, and then after that waiting for them 
with _one_ single fsync().

In contrast, the "wait for queued IO" approach can't sanely do that, 
exactly because it will wait in the middle, depending on other activity at 
the same time. It will always have the worry that it happens to do the 
msync() at the wrong time, and then wait synchronously when it shouldn't.

More importanrtly, the current behaviour makes certain patterns _possible_ 
that your suggested semantics simply cannot do efficiently. If we have 
data records smaller than a page, and want to mark them dirty as they 
happen, the current msync() allows that - it doesn't matter that another 
datum was marked dirty just a moment ago. Then, you do one fsync() only 
when you actually want to _commit_ a series of updates before you change 
the index. 

But if we want to have another flag, with MS_HALF_ASYNC, that's certainly
ok by me. I'm all for choice. It's just that I most definitely want the 
choice of doing it the way we do it now, since I consider that to be the 
_sane_ way.

> It's very much visible, just from a performance perspective, if you want
> to support "kick off this IO, I'm going to wait for the completion
> shortly."

That may well be worth a call of its own. It has nothing to do with memory 
mapping, though - what you're really looking for is fasync(). 

And yes, I agree that _that_ would make sense. Havign some primitives to 
start writeout of an area of a file would likely be a good thing.

I'd be perfectly happy with a set of file cache control operations, 
including

 - start writeback in [a,b]
 - wait for [a,b] stable
 - and maybe "punch hole in [a,b]"

Then you could use these for write() in addition to mmap(), and you can 
first mark multiple regions dirty, and then do a single wait (which is 
clearly more efficient than synchronously waiting for multiple regions).

But none of these have anything to do with what SuS or any other standard 
says about MS_ASYNC. 

> But whether that's a legal use of MS_ASYNC really depends on what the
> standard is requiring.  I could be persuaded either way.  Uli?

My argument was that a standard CANNOT say anything one way or the other, 
because the behaviour IS NOT USER-VISIBLE! A program fundamentally cannot 
care, since the only issue is a pure implementation issue of "which queue" 
the data got queued onto.

Bringing in a standards body is irrelevant. It's like trying to use the 
bible to determine whether protons have a positive charge. 

			Linus
