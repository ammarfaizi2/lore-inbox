Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287578AbSBKIVl>; Mon, 11 Feb 2002 03:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287545AbSBKIVc>; Mon, 11 Feb 2002 03:21:32 -0500
Received: from helen.CS.Berkeley.EDU ([128.32.131.251]:46258 "EHLO
	helen.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id <S287578AbSBKIVW>; Mon, 11 Feb 2002 03:21:22 -0500
Date: Mon, 11 Feb 2002 00:20:57 -0800
From: Josh MacDonald <jmacd@CS.Berkeley.EDU>
To: Larry McVoy <lm@work.bitmover.com>, Tom Lord <lord@regexps.com>,
        jaharkes@cs.cmu.edu, linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
Message-ID: <20020211002057.A17539@helen.CS.Berkeley.EDU>
In-Reply-To: <Pine.LNX.4.44.0202052328470.32146-100000@ash.penguinppc.org> <20020207165035.GA28384@ravel.coda.cs.cmu.edu> <200202072306.PAA08272@morrowfield.home> <20020207132558.D27932@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020207132558.D27932@work.bitmover.com>; from lm@bitmover.com on Thu, Feb 07, 2002 at 01:25:58PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Larry McVoy (lm@bitmover.com):
> > Arch will certainly need to be tuned for kernel hackers and perhaps
> > customized.  
> 
> {Note: I'm not going be drawn into a BK is better or worse than arch
> discussion.  It's not fair to Tom, and it would really need to be a BK now
> vs arch in 5 years discussion to be remotely apples to apples.  So here
> are my thoughts and then I'll leave this to the rest of you to discuss.}
> 
> An interesting experiment would be to take every kernel revision,
> including all the pre-patches, and import it into arch and report the
> resulting size of the repository and the time to generate each version
> of the tree from that repository.  I suspect that this will demonstrate
> the most serious issue that I have with the arch design.
> 
> In essence arch isn't that different from RCS in that arch is
> fundamentally a diff&patch based system with all of the limitations that
> implies.  There are very good reasons that BK, ClearCase, Aide De Camp,
> and other high end systems, are *not* diff&patch based revision histories,
> they are weave based.  Doing a weave based system is substantially
> harder but has some nice attributes.  Simple things like extracting any
> version of the file takes constant time, regardless of which version.
> Annotated listings work correctly in the face of multiple branches and
> multiple merges.  The revision history files are typically smaller,
> and are much smaller than arch's context diff based patches.


Larry, I don't think you're saying what you mean to say, and I doubt
that what you mean to say is even correct.  In fact, I've got a
master's thesis to prove you wrong.  I wish you would spend more time
thinking and less time flaming or actually _do some research_.  This
is not the first time you've misrepresented another version control
system in public with poor factual basis.

On the subject of "weave" vs. "diff&patch" methods of storage.  When
you describe the weave method operating in constant time, I just have
to wonder.  It sounds like you have a magic algorithm that can process
N bytes in less than O(N) time.  Unless you have a limit on file size,
you can't really expect any storage system to operate in less than
linear time (as a function of version size).

But as I understand your weave method, its not even linear as a
function of version size, its a function of _archive size_.  The
archive is the sum of the versions woven together, and that means your
operation is really O(N+A) = O(A).

Let's suppose that by "diff&patch" you really mean RCS--generalization
doesn't work here.  Your argument supposes that the cost of an RCS
operation is dominated by the application of an unbounded chain of
deltas.  The cost of that sub-operation is linear as a function of the
chain length C.  RCS has to process a version of length N, an archive
of size A, and a chain of length C giving a total time complexity of
O(N+C+A) = O(C+A).

And you would like us to believe that the weave method is faster
because of that extra processing cost (i.e., O(A) < O(C+A)).  I doubt
it.  The cost of these operations is likely dominated by the number of
blocks transferred to or from the disk, period.  Processing each delta
is a trivial operation--but both systems (yours and RCS) slow down as
the archive size grows because you have to pass through the entire
archive.  That's not constant time, that's not even linear time,
that's _unbounded growth_.

Now, putting the calculations aside, I've got a real system to prove
that you're wrong about the inadequacy of "diff&patch".  First of all,
neither the "weave" style or the RCS "diff -a" method properly capture
data that moves or is copied from one part of a file to another.  No
diff format does.  Remember, "diffs" are meant to be human readable,
and "deltas" are meant for efficient storage and/or transport.

I based the Xdelta2 storage system on some very fine research by
Randal Burns and Darrel Long.  Remember the formula O(N+C+A).  Neither
the C term (chain length) or the A term (disk blocks) should be
allowed to grow without bound.

Bounding the chain length is easy, it just means that instead of
storing 1000 deltas in a chain you store 50 fully-expanded versions
and 50 delta chains of max length 20.  Of course this means a little
extra storage, but really how much?  Observe that storing 50 out of
1000 versions is only 5%, which is pretty good as delta-compression
ratios go.  A typical delta is usually larger than 5% of the file
size.  I won't bore you all by carrying out the math, it can easily be
found in either my report or his.  The point is that bounding the
chain length by introducing full copies every once in a while does not
dramatically hurt your compression ratio.

Bounding the archive size is also easy, the set of versions and deltas
just cannot be stored as a single, conglomerate archive.  If you're
relying on the rename() system call for atomic updates in your system,
your performance sucks already.  Ideally you should only write as much
data as the delta you are inserting.  Let me show you:

    http://www.cs.berkeley.edu/~jmacd/xdfs-vs-rcs.eps

It is better to store full versions and deltas individually.  The
graph compares insertion-speed for RCS and (the research prototype of)
Xdelta2 as a function of version count.  RCS grows linearly with
version number (i.e., archive size).  Xdelta2 has truly bounded
insertion time (i.e., no growth).  The graph proves it.

The story gets even better (from Randal's research).  A chain length
of 20 could require 20 disk seeks (or worse, tape seeks in the
incremental backup system) to reconstruct a version.  You can make a
time-space tradeoff to fix the number of disk seeks at a constant
two--one full version and a single delta.  This gets rid of delta
chains altogether, but the degradation in compression is _only_ a
constant factor.  For example, you might compress down to 10% using
delta-chains of length 20, and with "forward version jumping", as he
calls it, your archive might compress to 20% instead.  Twice as much
storage, 1/10 the number of disk seeks.  Its a good tradeoff when
speed is your primary concern.

Note: implementing the system as I have described it requires some
kind of transaction support, since rename() is a performance-killer,
and it also requires efficient handling of small files.  That is why I
use Berkeley DB.  And that is also why I can claim, using the above
graph as proof, that adding support for file system transactions
stands to _improve application performance_.

There's another thing that this method can accomplish that I think the
"weave" method cannot.  When I started out designing this storage
system, what I really wanted to do was something like CVSup, where you
transfer (efficiently computed) deltas around between repositories to
keep mirrors up-to-date.  But the CVSup technique really only works in
a centralized RCS system, and I wanted decentralized version control.
The server, in such a system, should be able to generate a delta to
satisfy a client request regardless of what subset of versions the
client has or any ordering between versions on the server side.  Say
the server has 20 versions of a file, the client connects and says it
wants version 17 and it has version 7.  The server needs to
efficiently generate a delta from 7 to 17, and could it may have
stored those versions in any particular way.  When I say efficiently,
I don't mean "compute version 7, compute version 17, then compute a
delta".  The trivial implementation has at least O(N) time complexity
but you can do much better, assuming that deltas are small compared to
the file size.  Your computation should be propertional to the
computed delta's size, not the full versions.  There is an "extract
delta" operation in Xdelta2 can compute a delta between any two
versions--it works by merging and inverting delta chains.  It supports
both forward jumping chains (for best speed) and reverse chains (for
best compression).

And as long as I'm advertising, Mihut Ionescu and I have implemented a
delta-compressing HTTP proxy system called Xproxy demonstrating the
use of the "extract delta" operation.  I'm currently finishing up a
VCDIFF-encoding implementation of Xdelta, with which we will implement
the new RFCs for delta-encoded HTTP transfer.

So from my point of view, the "weave" method looks pretty inadequate.

Master's thesis, "File System Support for Delta Compression":
                 http://prdownloads.sourceforge.net/xdelta/xdfs.pdf
Xdelta code:     http://prdownloads.sourceforge.net/xdelta/xdelta-2.0-beta9.tar.gz
Xproxy paper:    http://prdownloads.sourceforge.net/xdelta/xproxy.pdf

-josh

-- 
PRCS version control system    http://sourceforge.net/projects/prcs
Xdelta storage & transport     http://sourceforge.net/projects/xdelta
Need a concurrent skip list?   http://sourceforge.net/projects/skiplist
