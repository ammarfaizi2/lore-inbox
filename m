Return-Path: <linux-kernel-owner+w=401wt.eu-S1750870AbXAKRNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbXAKRNy (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 12:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbXAKRNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 12:13:54 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:21498 "EHLO hobbit.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750725AbXAKRNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 12:13:53 -0500
Message-ID: <45A6704A.40205@tls.msk.ru>
Date: Thu, 11 Jan 2007 20:13:46 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Icedove 1.5.0.8 (X11/20061128)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Viktor <vvp01@inbox.ru>, Aubrey <aubreylee@gmail.com>,
       Hua Zhong <hzhong@gmail.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, hch@infradead.org,
       kenneth.w.chen@intel.com, akpm@osdl.org
Subject: Re: O_DIRECT question
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com> <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org> <45A629E9.70502@inbox.ru> <Pine.LNX.4.64.0701110750520.3594@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701110750520.3594@woody.osdl.org>
X-Enigmail-Version: 0.94.1.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 11 Jan 2007, Viktor wrote:
>> OK, madvise() used with mmap'ed file allows to have reads from a file
>> with zero-copy between kernel/user buffers and don't pollute cache
>> memory unnecessarily. But how about writes? How is to do zero-copy
>> writes to a file and don't pollute cache memory without using O_DIRECT?
>> Do I miss the appropriate interface?
> 
> mmap()+msync() can do that too.

It can, somehow... until there's an I/O error.  And *that* is just terrbile.

Granted, I didn't check 2.6.x kernels, especially the latest ones.  But
in 2.4, if an I/O space behind mmap becomes unREADable, the process gets
stuck in some unkillable state forever.  I don't know what happens with
write errors, but that behaviour with read errors is just inacceptable.

Sure it's not something like posix_madvise() (whicih is for reads anyway,
not writes).  But I'd very strongly disagree about usage of mmap for
anything more-or-less serious.  Because of umm... difficulties with
error recovery (if it's at all possible).

Note also that anything but O_DIRECT isn't... portable.  O_DIRECT, with
all its shortcomings and ugliness, works, and works on quite.. some
systems.  Having something else, especially with very different usage --
I mean, if the whole I/O subsystem in application has to be redesigned
and re-written in order to use that advanced (or just "right") mechanism
(O_DIRECT is not different from basic read()/write() - just one extra
bit at open() time, and all your code, which evolved during years and
got years of testing, too -- just works, at least in theory, if O_DIRECT
interface is working (ok ok, i know alignment issues, but that's also
handled easily)), -- that'd be somewhat problematic.  *Unless* there's
a very noticeable gain from that.

>From my expirience with databases (mostly Oracle, and some with Postgres
and Mysql), O_DIRECT has *dramatic* impact on performance.  You don't
use O_DIRECT, and you lose alot.  O_DIRECT is *already* a fastest way
possible, I think - for example, it gives maximum speed when writing to
or reading from a raw device (/dev/sdb etc).  I don't think there's a
way to improve that performance...  Yes, there ARE, it seems, some ways
for improvements, in other areas - like, utilizing write barriers for
example, which isn't quite possible now from userspace.  But as long as
O_DIRECT actually writes data before returning from write() call (as it
seems to be the case at least with a normal filesystem on a real block
device - I don't touch corner cases like nfs here), it's pretty much
THE ideal solution, at least from the application (developer) standpoint.

By the way, ext[23]fs is terrible slow with O_DIRECT writes - it gives
about 1/4 of the speed of raw device when multiple concurrent direct
readers and writers are running.  Xfs gives full raw device speed here.
I think that MAY be related to locking issues in ext[23], but I don't
know for sure.

And another "btw" - when creating files, O_DIRECT is quite a killer - each
write takes alot more time than "necessary".  But once a file has been
written, re-writes are pretty much fast.

Also, and it's quite.. funny (to me at least).  Being curious, I compared
write speed (random small-blocks I/O scattered all around the disk) of
modern disk drives with and without write cache (WCE=[01] bit in the
SCSI "Cache control" page of every disk drive).  The fun is: with write
cache turned on, actual speed is LOWER than without cache.  I don't
remember exact numbers, something like 120mb/sec vs 90mb/sec.  And I
think it's quite expectable, as well - first writes all goes to the
cache, but since data stream is going on and on, the cache fills up
quickly, and in order to accept the next data, the drive has to free
some place in its cache.  So instead of just doing its work, it is
spending its time to bounce data to/from the cache...

Sure it's not about linux pagecache or something like that, but it's
still somehow related.  :)

[]
> O_DIRECT - by bypassing the "real" kernel - very fundamentally breaks the 
> whole _point_ of the kernel. There's tons of races where an O_DIRECT user 
> (or other users that expect to see the O_DIRECT data) will now see the 
> wrong data - including seeign uninitialized portions of the disk etc etc. 

Huh?  Well, I plug in a shiny new harddisk into my computer, and do an O_DIRECT
read of it - will I see uninitialized data?  Sure I will (well, in most cases
the whole disk is filled with zeros anyway, so it isn't uninitialized).  The
same applies to regular read, too.

If what you're saying applies to O_DIRECT read of a file on a filesystem, --
well, that's definitely a kernel bug.  It should either not allow to read
if the file size isn't sector-aligned - to read that last part which isn't
a whole sector or whatever, -- or it should ensure the "extra" data is
initialized.  Yes, that's difficult to implement in the kernel.  But it's
not an excuse to not to do that.  AND I think just failing the read is
exactly the way to go here.

What about "seeing wrong data" ?  Where's that race?  Do you mean the case
when one application writes to disk while the other is reading it, so that
it's not obvious which data will be read, the old one or the new one?  If
it's the case, just don't worry about that - the same happens with any
variable access in multi-threaded application for example (that's why
locks - mutexes etc - are here).  For most serious users of O_DIRECT,
this is no problem at all - for example, Oracle implements its own cache
manager, and all reads and writes goes so that the cache knows what's
going on, which data is being read or written at a given moment and so
on - if it's important anyway.

> In short, the whole "let's bypass the OS" notion is just fundamentally 
> broken. It sounds simple, but it sounds simple only to an idiot who writes 
> databases and doesn't even UNDERSTAND what an OS is meant to do. For some 
> reasons, db people think that they don't need one, and don't ever seem to 
> really understand the concept fo "security" and "correctness". They 
> understand it (sometimes) _within_ their own database, but seem to have a 
> really hard time seeing past their own sandbox.
> 
> Some of the O_DIRECT breakage could probably be fixed:
> 
>  - An O_DIRECT operation must never allocate new blocks on the disk. It's 
>    fundamentally broken. If you *cannot* write new blocks, and can only 
>    read and re-write previous allocations, things are much easier, and a 
>    lot of the races go away.

Not only races, but *terrible* speed too ;)  At least on some filesystems.

>    This is probably _perfectly_ fine for the users (namely databases). 
>    People who do O_DIRECT really expect to see a "raw disk image", but 
>    they (exactly _because_ they expect a raw disk image) are perfectly 
>    happy to "set up" that image beforehand.

Well, *right now* O_DIRECT is useful (despite of the terrible performance
for new files mentioned above) for things like copying large files/directories
around.  If I'm copying a directory tree which doesn't fit in RAM, all the
pagecache gets trashed by a high pressure going on from the copy process.
During that time, the system is just unresponsive, read: unusable.  When
I modify `cp' to use O_DIRECT for everything, the process is running in
the background and everything else just works as there was no copy running.

>  - An O_DIRECT operation must never race with any metadata operation, 
>    most notably truncate(), but also any file extension operation like a 
>    normal write() that extends the size of the file.
> 
>    This should be reasonably easy to do. Any O_DIRECT operation would just 
>    take the inode->i_mutex for reading. HOWEVER. Right now it's a mutex, 
>    not a read-write semaphore, so that is actually pretty painful. But it 
>    would be fairly simple.

Isn't it will be the reason for slowdown?  I'm not a kernel hacker, I don't
know, for example, what's the difference between a mutex and a semaphore... ;)

I once tried to measure concurrent read/write operations against a single
file on a FreeBSD - it just DoesNotScale, exactly - i think - due to some
locking, as it tries to make reads and writes "atomic" (see above - i think
it's due to that "reading data which is being written by another process"
thing).  Linux work very well from this standpoint.  So I wonder if, by
introducing such a locking, we'll introduce the same "DontScale" behaviour...

BUT - the same rules can be applied to writing, too - I mean, taking some
mutext/whatever wich protects against - say - concurrent ftruncate() or
whatever...

But I can come up with even simpler solution, which MIGHT be acceptable.
Just disallow any - at least write - access to a file which is open in
O_DIRECT mode, IF that other operation isnt' ALSO used with O_DIRECT flag.
I.e, don't allow open(O_TRUNC), ftruncate(), even maybe write(), if another
process has it open with O_DIRECT|O_WRITE.

> With those two rules, a lot of the complexity of the nasty side effects of 
> O_DIRECT that the db people obviously never even thought about would go 
> away. We'd still have to have some way to synchronize the page cache, but 
> it could be as simple as having an O_DIRECT open simply _flush_ the whole 
> page cache, and set some flag saying "can't do normal opens, we're 
> exclusively open for O_DIRECT".

Yup, like this.  But one comment still: normal (non-DIRECT) reads should
be allowed.  Needs momre thinking....  The reason is: with that damn oracle,
i can do online backups of tablespaces or the whole database, by saying
 "alter tablespace foo beging backup;",
backing up the files, and saying "...end backup;".  I'm not sure whenever
during those 'alter tablespace', oracle re-opens the files read/only and
next back read/write.  It will not do any writes - that's for sure, but
I don't know if it will reopen r/o.

In any case... mixing direct and non-direct i/o is just not supported, that
is, no words about "consistency", or "atomicity" of reads vs writes etc
(and sure thing - when you're backing up a file which is being modified,
you're screwed by you own anyway - it's an operator error, there's nothing
an OS can do - unless the operator uses some snapshot mechanism...)

> I dunno. A lot of filesystems don't want to (or can't) actually do a 
> "write in place" ANYWAY (writes happen through the log, and hit the "real 
> filesystem" part of the disk later), and O_DIRECT really only makes sense 
> if you do the write in place, so the above rules would help make that 
> obvious too - O_DIRECT really is a totally different thing from a normal 
> IO, and an O_DIRECT write() or read() really has *nothing* to do with a 
> regular write() or read() system call. 
> 
> Overloading a totally different operation with a flag is a bad idea, which 
> is one reason I really hate O_DIRECT. It's just doing things badly on so 
> many levels.
> 
> 			Linus

/mjt
