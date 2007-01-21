Return-Path: <linux-kernel-owner+w=401wt.eu-S1751427AbXAUMJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbXAUMJ6 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 07:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbXAUMJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 07:09:57 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:22154 "EHLO hobbit.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751427AbXAUMJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 07:09:56 -0500
Message-ID: <45B3580F.7040407@tls.msk.ru>
Date: Sun, 21 Jan 2007 15:09:51 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Icedove 1.5.0.8 (X11/20061128)
MIME-Version: 1.0
To: Denis Vlasenko <vda.linux@googlemail.com>
CC: Linus Torvalds <torvalds@osdl.org>, Viktor <vvp01@inbox.ru>,
       Aubrey <aubreylee@gmail.com>, Hua Zhong <hzhong@gmail.com>,
       Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       hch@infradead.org, kenneth.w.chen@intel.com, akpm@osdl.org
Subject: Re: O_DIRECT question
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com> <200701201736.22553.vda.linux@googlemail.com> <45B281BB.50607@tls.msk.ru> <200701210005.36274.vda.linux@googlemail.com>
In-Reply-To: <200701210005.36274.vda.linux@googlemail.com>
X-Enigmail-Version: 0.94.1.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> On Saturday 20 January 2007 21:55, Michael Tokarev wrote:
>> Denis Vlasenko wrote:
>>> On Thursday 11 January 2007 18:13, Michael Tokarev wrote:
>>>> example, which isn't quite possible now from userspace.  But as long as
>>>> O_DIRECT actually writes data before returning from write() call (as it
>>>> seems to be the case at least with a normal filesystem on a real block
>>>> device - I don't touch corner cases like nfs here), it's pretty much
>>>> THE ideal solution, at least from the application (developer) standpoint.
>>> Why do you want to wait while 100 megs of data are being written?
>>> You _have to_ have threaded db code in order to not waste
>>> gobs of CPU time on UP + even with that you eat context switch
>>> penalty anyway.
>> Usually it's done using aio ;)
>>
>> It's not that simple really.
>>
>> For reads, you have to wait for the data anyway before doing something
>> with it.  Omiting reads for now.
> 
> Really? All 100 megs _at once_? Linus described fairly simple (conceptually)
> idea here: http://lkml.org/lkml/2002/5/11/58
> In short, page-aligned read buffer can be just unmapped,
> with page fault handler catching accesses to yet-unread data.
> As data comes from disk, it gets mapped back in process'
> address space.

> This way read() returns almost immediately and CPU is free to do
> something useful.

And what the application does during that page fault?  Waits for the read
to actually complete?  How it's different from a regular (direct or not)
read?

Well, it IS different: now we can't predict *when* exactly we'll sleep waiting
for the read to complete.  And also, now we're in an unknown-corner-case when
an I/O error occurs, too (I/O errors iteracts badly with things like mmap, and
this looks more like mmap than like actual read).

Yes, this way we'll fix the problems in current O_DIRECT way of doing things -
all those rases and design stupidity etc.  Yes it may work, provided those
"corner cases" like I/O errors problems will be fixed.  And yes, sometimes
it's not really that interesting to know when exactly we'll sleep actually
waiting for the I/O - during read or during some memory access...

Now I wonder how it should look like from an applications standpoint.  It
has its "smart" cache.  A worker thread (process in case of oracle - there's
a very good reason why they don't use threads, and this architecture saved
our data several times already - but that's entirely different topic and
not really relevant here) -- so, a worker process which executes requests
coming from a user application wants to have (read) access a db block
(usually 8Kb in size, but can be 4..32Kb - definitely not 100megs), where
the requested data is located.  It checks whenever this block is in cache,
and if it's not, it is being read from the disk and added to the cache.
The cache resides in a shared memory (so that other processes will be able
to access it too).

With the proposed solution, it looks even better - that `read()' operation
which returns immediately, so all other processes which wants the same page
at the same time will start "using" it immediately.  Provided they all can
access the memory.

This is how a (large) index access or table-access-by-rowid (after index lookup
for example) is done - requesting usually just a single block in some random
place of a file.

There's another access pattern - like, full table scans, where alot of data
is being read sequentially.  It's done in chunks, say, 64 blocks (8Kb each)
at a time.  We read a chunk of data, do some thing on it, and discard it
(caching it isn't a very good idea).  For this access pattern, the proposal
should work fairy well.  Except of the I/O errors handling maybe.

By the way - the *whole* cache thing may be implemented in application
*using in-kernel page cache*, with clever usage of mmap() and friends.
Provided the whole database fits into an address space, or something like
that ;)

>> For writes, it's not that problematic - even 10-15 threads is nothing
>> compared with the I/O (O in this case) itself -- that context switch
>> penalty.
> 
> Well, if you have some CPU intensive thing to do (e.g. sort),
> why not benefit from lack of extra context switch?

There may be other reasons to "want" those extra context switches.
I mentioned above that oracle doesn't use threads, but processes.
I don't know why exactly it's done this way, but I know how it saved
our data.  The short answer is this: bugs ;)  A process doing somethin
with the data and generates write requests to the db goes crazy - some
memory corruption, doing some bad things... But that process does not
do any writes directly - instead, it generates those write requests
in shared memory, and ANOTHER process actually does the writing.  AND
verifies that the requests actually look sanely.  And detects the "bad"
writes, and immediately prevents data corruption.  That other (dbwr)
process does much simpler things, and has its own address space which
isn't accessible by that crazy one.

> Assume that we have "clever writes" like Linus described.
> 
> /* something like "caching i/o over this fd is mostly useless" */
> /* (looks like this API is easier to transition to
>  * than fadvise etc. - it's "looks like" O_DIRECT) */
> 	fd = open(..., flags|O_STREAM);
>         ...
> /* Starts writeout immediately due to O_STREAM,
>  * marks buf100meg's pages R/O to catch modifications,
>  * but doesn't block! */
> 	write(fd, buf100meg, 100*1024*1024);

And how do we know when the write completes?

> /* We are free to do something useful in parallel */
> 	sort();

.. which is done in another process, already started.

>>> I hope you agree that threaded code is not ideal performance-wise
>>> - async IO is better. O_DIRECT is strictly sync IO.
>> Hmm.. Now I'm confused.
>>
>> For example, oracle uses aio + O_DIRECT.  It seems to be working... ;)
>> As an alternative, there are multiple single-threaded db_writer processes.
>> Why do you say O_DIRECT is strictly sync?
> 
> I mean that O_DIRECT write() blocks until I/O really is done.
> Normal write can block for much less, or not at all.

So we either move that blocking into something like fdatasync_area(),
requiring two syscalls ([m]write and fdatasync_area) instead of just
one, or use async notifications (kevent anyone? ;) when the queued
writes completes.  The latter is probably more interesting.

Here again, we'll have two issues: that same error handling (when
the write fails due to bad disk etc), and a new one - ordering.
Which - probably - isn't an issue, I'm not sure.

>> In either case - I provided some real numbers in this thread before.
>> Yes, O_DIRECT has its problems, even security problems.  But the thing
>> is - it is working, and working WAY better - from the performance point
>> of view - than "indirect" I/O, and currently there's no alternative that
>> works as good as O_DIRECT.
> 
> Why we bothered to write Linux at all?
> There were other Unixes which worked ok.

Denis, please realize - I'm not an "oracle guy" (or "database guy" or whatever).
I'm not really a developer even - mostly a sysadmin (but I wrote some software,
and designed some (fairy small) APIs too - not kernel work, but still).  I have
some good expirience with running oracle stuff (and by the way, I hate it due to
many different reasons, but due to other, including historical (there's many code
which has been written and which works with this damn thing) reasons I'm sorta
stuck with it for some (more) time).

I tried to understand how it all works at an application (oracle) level.  I know
that *now* *in linux* O_DIRECT IS here, and orrible uses it, and without it the
whole thing is just damn slow.  After this thread I also know that O_DIRECT has
some... issues (I'm still unsure if I got it right), and that there are other
possible solutions to it.  I also knew that using O_DIRECT (again, as implemented
already) is a way to work around some other issues (like, f.e, when copying a
data from one disk to another using dd - without O_DIRECT, the system almost
stops working during all the copy operation, and the copy is very slow; but
with O_DIRECT, it's both faster and allows system to work the same as before
during the copy).

I spent quite alot of time watching how the damn thing (orrible db, that is)
works, and tuning it, and trying various storage settings, various filesystems
etc.  I didn't like all this.  But I become curious after all, because this
O_DIRECT thing behaves very differently on different filesystems and storage
configurations.  That's probably a reason why I has been Cc'ed in this thread
in the first place (I posted some questions about O_DIRECT to LKML before),
and why I'm replying, too ;)

I'm not arguing against better interfaces.  Not at all.  More, I spent quite
some time designing interfaces for my software, to be as much "pretty" as it
ever can be (both easy to use AND flexible, so that common tasks can be done
with easy, and all the "advanced" tasks will be possible too - the two contradicts
with each other in many cases) - I dislike "non-pretty" interfaces (which I've
seen alot, too, in other code ;)

The thing is - I don't know how it's all done in the kernel -- only some guesses.

Don't try to shot me - I'm the wrong person to do so.

With this orrible thing - it works now using O_DIRECT.  Works on many different
platforms.  It's a thing which predates linux, by the way.  It's important on
the market, and is being used on many "big" places.  For a long time.  With all
the lack of good taste of it, etc.  (I'm not sure it was oracle who "invented"
O_DIRECT, i think they're used existing inteface, it turned out to be good for
something, and other OSes followed, incl. linux, and it started being used for
other things too).

How about talking with those people (there are someone from oracle here on LKML)
about all this for example?  With postgresql people?

By the way, it's not only a question about prettines of an interface.  It's also
something to do with existing code and architecture.

/mjt
