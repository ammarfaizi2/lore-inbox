Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288248AbSAUUqC>; Mon, 21 Jan 2002 15:46:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288188AbSAUUpx>; Mon, 21 Jan 2002 15:45:53 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:38154 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S288185AbSAUUpo>; Mon, 21 Jan 2002 15:45:44 -0500
Message-ID: <3C4C7D08.2020707@namesys.com>
Date: Mon, 21 Jan 2002 23:41:44 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: Rik van Riel <riel@conectiva.com.br>, Shawn Starr <spstarr@sh0n.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <Pine.LNX.4.33L.0201211153110.32617-100000@imladris.surriel.com> <3C4C20A2.9040009@namesys.com> <1780530000.1011633710@tiny> <3C4C5414.2090104@namesys.com> <1819870000.1011642257@tiny>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:

>
>On Monday, January 21, 2002 08:47:00 PM +0300 Hans Reiser
><reiser@namesys.com> wrote:
>
>>Chris Mason wrote:
>>
>>>On Monday, January 21, 2002 05:07:30 PM +0300 Hans Reiser
>>><reiser@namesys.com> wrote:
>>>
>>>>Rik van Riel wrote:
>>>>
>>>>>On Mon, 21 Jan 2002, Hans Reiser wrote:
>>>>>
>>>>>>Pressure received is not equal to pages yielded. ... The number of
>>>>>>pages yielded should depend on the interplay of pressure received and
>>>>>>accesses made.
>>>>>>
>>>Ah, once the FS starts counting accesses, we get in trouble.  The FS
>>>should strive to know only these 3 things:
>>>
>>>How to read useful data into a page
>>>How to flush a dirty page
>>>How to free a pinned page
>>>
>>You say this with the all the dogma of someone working with code that
>>currently does things a particular way.  You provide no reasons though.
>>
>
>;-)  In general, every bit of the VM we modify and copy into the FS will:
>
>A) break later on as the rest of the VM evolves
>B) perform poorly on hardware we don't have (numa).
>C) make odd, hard to trigger bugs due to strange interactions on large
>machines and certain work loads.
>D) require almost constant maintenance.
>
>And that is how it works right now.  The journal is a subcache that does
>not respond to memory pressure the same way on all the journaled
>filesystems, and none of them are optimal.
>

This is because you didn't want to disturb VM enough to create a proper 
interface.  You were right to have this attitude during code freeze. 
 Code freeze is over.

>
>
>>>Everything gets cleaner if we push this info up to the VM in a generic
>>>fashion, instead of trying to push bits of the VM down into each
>>>filesystem. 
>>>The FS should have no idea of what memory pressure is, down that path
>>>lies pain, suffering, and deadlocks against the journal ;-)
>>>
>>>If the VM is telling the FS to write a pinned page when there are
>>>unpinned pages that can be written with less cost, then we need to give
>>>the VM better hints about the actual cost of writing the pinned page.
>>>
>>Oh, this means a much more complicated interface, 
>>
>
>Grin, we can't really compare interface complexity until both are written
>and working.
>

Yah, yah, as the Germans taught me to say.;-)

>
>
>>and it means that the
>>VM must take into account the optimizations of each and every filesystem.
>>Are you sure this isn't an unmaintainable centralized hell? 
>>
>
>Decentralization in this case seems much more risky.  The VM needs well
>defined repeatable behaviour.
>

Decentralization always seems more risky.  It is why we have so many 
centralized economies, errh, .....

>
>
>>In practice,
>>will it really mean that optimizations specific to a particular
>>filesystem will get ignored, because there will be too many of them to
>>keep up with, and they will clutter each other up if implemented in one
>>piece of code?  Will programmers really be able to experiment?
>>
>
>The idea is to find the basic interface required to do this for us.
>Internally, the FS needs an interface to give hints to its own subcache, so
>

Uh, the hints are called slums and balanced trees and unallocated 
extents and distinctions between overwrite sets and relocate sets and 
the difference between internal and leaf nodes and five different mount 
options for how to allocate blocks and....

I think that asking VM to understand this is simply awful.

>
>it must be possible to give hints to a VM.  I'm not pretending it will be
>easy to generalize, but all the filesystems need a very similar set of
>tools here, so it should be worth the effort.
>

I prefer the approach used in VFS, in which templates of generic FS code 
are supplied, and people can use as much or as little of the generic 
code as they want.  This allows people who just want to create a 
filesystem that can read a particular format to do so without unique 
optimizations for that FS, and people who want to write a seriously 
optimized filesystem that understands how to optimize for a particular 
layout to do so.

I think that what you and Saveliev did made sense for 2.4 where we were 
struggling against a code freeze (well, at least there was supposed to 
be a code freeze on VM/VFS, but that is history we should not 
revisit.....), but it is not appropriate for when there is no code freeze.

>
>
>>>
>>>For periodic group flushes (delayed allocation, journal commits, etc), we
>>>need better throttling on dirty pages instead of just dirty buffers like
>>>we do now.
>>>
>>>I'm not delusional enough to think this will make all the vm<->journal
>>>nastiness go away, but it hopefully should be less painful than adding
>>>extra VM intelligence into each FS.
>>>
>>Say more about what you mean by better throttling on dirty pages, and how
>>that meets the needs of slum squeezing, transaction committing, write
>>clustering, etc.  Last I remember, the generic write clustering code in
>>VM didn't even understand packing localities.;-)
>>
>
>Most write throttling is done by bdflush right now, because most dirty
>things that need to hit disk have dirty buffers.  For pinned pages, delayed
>allocation etc, we probably want a rate limiter unrelated to buffers at
>all, and one that can trigger complex actions from the FS instead of just a
>simple write-one-page.  
>
>I'm not saying we should teach the VM how to do these complex operations,
>but I do think it should be in charge of deciding when they happen as much
>as possible.  In other words, the journal would only trigger a commit on
>its own when the transaction was full.  The other cases (too old, low ram,
>too many dirty pages) would be triggered by the VM.
>
I read this and it sounds like you are agreeing with me, which is 
confusing;-), help me to understand what you mean by triggered.  Do you 
mean VM sends pressure to the FS?  Do you mean that VM understands what 
a transaction is?  Is this that generic journaling layer trying to come 
alive as a piece of the VM?  I am definitely confused.

I think what I need to understand, is do you see the VM as telling the 
FS when it has (too many dirty pages or too many clean pages) and 
letting the FS choose to commit a transaction if it wants to as its way 
of cleaning pages, or do you see the VM as telling the FS to commit a 
transaction?

If you think that VM should tell the FS when it has too many pages, does 
that mean that the VM understands that a particular page in the subcache 
has not been accessed recently enough?  Is that the pivot point of our 
disagreement?

>
>
>For write clustering, we could add an int clusterpage(struct page *p)
>address space op that allow the FS to find pages close to p, or the FS
>could choose to cluster in its own writepage func.
>
What you are proposing is not consistent with how Marcello is doing 
write clustering as part of the VM, you understand that, yes?  What 
Marcello is doing is fine for ReiserFS V3 but won't work well for v4, do 
you agree?

Hans

