Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287979AbSAUTpg>; Mon, 21 Jan 2002 14:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288006AbSAUTpZ>; Mon, 21 Jan 2002 14:45:25 -0500
Received: from 216-42-72-169.ppp.netsville.net ([216.42.72.169]:7374 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S287979AbSAUTpQ>; Mon, 21 Jan 2002 14:45:16 -0500
Date: Mon, 21 Jan 2002 14:44:17 -0500
From: Chris Mason <mason@suse.com>
To: Hans Reiser <reiser@namesys.com>
cc: Rik van Riel <riel@conectiva.com.br>, Shawn Starr <spstarr@sh0n.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Possible Idea with filesystem buffering.
Message-ID: <1819870000.1011642257@tiny>
In-Reply-To: <3C4C5414.2090104@namesys.com>
In-Reply-To: <Pine.LNX.4.33L.0201211153110.32617-100000@imladris.surriel.com>
 <3C4C20A2.9040009@namesys.com> <1780530000.1011633710@tiny>
 <3C4C5414.2090104@namesys.com>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday, January 21, 2002 08:47:00 PM +0300 Hans Reiser
<reiser@namesys.com> wrote:

> Chris Mason wrote:
> 
>> 
>> On Monday, January 21, 2002 05:07:30 PM +0300 Hans Reiser
>> <reiser@namesys.com> wrote:
>> 
>>> Rik van Riel wrote:
>>> 
>>>> On Mon, 21 Jan 2002, Hans Reiser wrote:
>>>> 
>>>>> Pressure received is not equal to pages yielded. ... The number of
>>>>> pages yielded should depend on the interplay of pressure received and
>>>>> accesses made.
>>>>> 
>> 
>> Ah, once the FS starts counting accesses, we get in trouble.  The FS
>> should strive to know only these 3 things:
>> 
>> How to read useful data into a page
>> How to flush a dirty page
>> How to free a pinned page
>> 
> You say this with the all the dogma of someone working with code that
> currently does things a particular way.  You provide no reasons though.

;-)  In general, every bit of the VM we modify and copy into the FS will:

A) break later on as the rest of the VM evolves
B) perform poorly on hardware we don't have (numa).
C) make odd, hard to trigger bugs due to strange interactions on large
machines and certain work loads.
D) require almost constant maintenance.

And that is how it works right now.  The journal is a subcache that does
not respond to memory pressure the same way on all the journaled
filesystems, and none of them are optimal.

>> 
>> Everything gets cleaner if we push this info up to the VM in a generic
>> fashion, instead of trying to push bits of the VM down into each
>> filesystem. 
>> The FS should have no idea of what memory pressure is, down that path
>> lies pain, suffering, and deadlocks against the journal ;-)
>> 
>> If the VM is telling the FS to write a pinned page when there are
>> unpinned pages that can be written with less cost, then we need to give
>> the VM better hints about the actual cost of writing the pinned page.
>> 
> 
> Oh, this means a much more complicated interface, 

Grin, we can't really compare interface complexity until both are written
and working.

> and it means that the
> VM must take into account the optimizations of each and every filesystem.
> Are you sure this isn't an unmaintainable centralized hell? 

Decentralization in this case seems much more risky.  The VM needs well
defined repeatable behaviour.

> In practice,
> will it really mean that optimizations specific to a particular
> filesystem will get ignored, because there will be too many of them to
> keep up with, and they will clutter each other up if implemented in one
> piece of code?  Will programmers really be able to experiment?

The idea is to find the basic interface required to do this for us.
Internally, the FS needs an interface to give hints to its own subcache, so
it must be possible to give hints to a VM.  I'm not pretending it will be
easy to generalize, but all the filesystems need a very similar set of
tools here, so it should be worth the effort.

>> 
>> 
>> For periodic group flushes (delayed allocation, journal commits, etc), we
>> need better throttling on dirty pages instead of just dirty buffers like
>> we do now.
>> 
>> I'm not delusional enough to think this will make all the vm<->journal
>> nastiness go away, but it hopefully should be less painful than adding
>> extra VM intelligence into each FS.
>> 
> Say more about what you mean by better throttling on dirty pages, and how
> that meets the needs of slum squeezing, transaction committing, write
> clustering, etc.  Last I remember, the generic write clustering code in
> VM didn't even understand packing localities.;-)

Most write throttling is done by bdflush right now, because most dirty
things that need to hit disk have dirty buffers.  For pinned pages, delayed
allocation etc, we probably want a rate limiter unrelated to buffers at
all, and one that can trigger complex actions from the FS instead of just a
simple write-one-page.  

I'm not saying we should teach the VM how to do these complex operations,
but I do think it should be in charge of deciding when they happen as much
as possible.  In other words, the journal would only trigger a commit on
its own when the transaction was full.  The other cases (too old, low ram,
too many dirty pages) would be triggered by the VM.

For write clustering, we could add an int clusterpage(struct page *p)
address space op that allow the FS to find pages close to p, or the FS
could choose to cluster in its own writepage func.

-chris

