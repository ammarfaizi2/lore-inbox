Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274427AbRJACct>; Sun, 30 Sep 2001 22:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274460AbRJACck>; Sun, 30 Sep 2001 22:32:40 -0400
Received: from out-of-band.media.mit.edu ([18.85.16.22]:48904 "EHLO
	out-of-band.media.mit.edu") by vger.kernel.org with ESMTP
	id <S274427AbRJACc1>; Sun, 30 Sep 2001 22:32:27 -0400
Date: Sun, 30 Sep 2001 22:32:47 -0400 (EDT)
Message-Id: <200110010232.WAA08046@out-of-band.media.mit.edu>
From: foner-reiserfs@media.mit.edu
To: pcg@goof.com
CC: sct@redhat.com, Nikita@Namesys.COM, Mason@Suse.COM,
        linux-kernel@vger.kernel.org, reiserfs-list@Namesys.COM
In-Reply-To: <20011001032627.A9991@schmorp.de> (pcg@goof.com)
Subject: [reiserfs-list] ReiserFS data corruption in very simple configuration
CC: foner-reiserfs@media.mit.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Date: Mon, 1 Oct 2001 03:26:27 +0200
    From: <pcg@goof.com ( Marc) (A.) (Lehmann )>

    On Sun, Sep 30, 2001 at 09:00:49PM -0400, foner-reiserfs@media.mit.edu wrote:
    > extending a file, the metadata is written -last-, e.g., file blocks
    > are allocated, file data is written, and -then- metadata is written.

    this is almost impossible to achieve with existing hardware (witness the
    many discussions about disk caching for example), and, without journaling,
    might even be slow.

I think perhaps we may be talking past each other; let me try to clarify.

As I said earlier in this thread, this has nothing at all to do with
disk caching.  Let me restate this again:  The scenario I'm discussing
is an otherwise-idle machine that had 2 (maybe 3) files modified, sat
idle for 30-60 seconds, and then had the reset button pushed.  I would
expect that either file data and metadata got written, or neither got
written, but not metadata without file data.  This is repeatable more
or less at will---I didn't -just- happen to catch it -just- as it
decided to frob the disks.  Instead, the problem seems to be that
reiserfs is perfectly happy to update the on-disk representation of
which disk blocks contain which files' data, and then -sit there- for
a long time (a minute? longer?) without -also- attempting to flush the
file data to the disk.  This then leads to corrupted files after the
reset.  It's not that the CPU sent data to the disk subsystem that
failed to be written by the time of the interruption; it's that the
data was still sitting in RAM and the CPU hadn't even decided to get
it out the IDE channel yet.  This means that there is -always- a giant
timing hole which can corrupt data, as opposed to just the much-tinier
hole that would be created if the file-bytes-to-disk-bytes correspondence
were updated immediately after the write that wrote the data---it
would be hard for me to accidentally hit such a hole.

    > of wtmp had data from the -previous- copy of XFree86.0.log that had
    > been freed (because it was unlinked when the next copy was written)
    > but which had not actually had the wtmp data written to it yet

    It's easily possible, but it could also be a bug. Let's the reiserfs authors
    decide.

    However, if it is indeed "a bug" then fixing it would only lower the
    frequency of occurance.

True, but as long as it makes it only happen if the disk is -in
progress of writing stuff- when the reset or power failure happens,
the risk is -greatly- reduced.  Right now, it's an enormous timing
hole, and one that's likely to be hit---it's happened to me -every
single time- I've had to hit the reset button because (for example)
I wedged X while debugging, and even if I waited a minute after the
wedge-up to do so!  The way I've avoided it is by running a job that
syncs once a second while doing debugging that might possibly make me
unable to take the machine down cleanly.  This is a disgusting and
unreliable kluge.

    Only ext3 (some modes) + turning off your harddisk's cache can ensure
    this, at the moment.

Or ext3 (some modes) + assuming that the disk will at least write data
that's been sent to it, even if the CPU gets reset.  (I know it's
hopeless if power fails, but that can be made arbitrarily unlikely,
compared to a kernel panic or having to do a CPU reset.)

    > to have that logfile in it (instead of zero bytes).  Is this what
    > you're talking about when you say "*old* data"?  I think so, and that
    > seems to match your comment below about file tails moving around
    > rapidly.

    appending to logfiles will result in a lot of movement. with other,
    strictly block-based filesystems this occurs relatively frequent, and data
    will not usually move around. with reiserfs tail movement is frequent.

Right.

    > Wouldn't it make more sense to commit metadata to disk -after- the
    > data blocks are written?

    The problem is that there is currently no easy way to achieve that.

Why not?  (Ignore the disk-caching issue and concentrate on when the
kernel asks for data to be written to the disk.  I am -assuming that
the kernel either (a) writes the data in the order requested, or at
least (b) once it decides to write anything, keeps sending it to the
disk until its queue is completely empty.)

    > file simply looks like the data was never added.  If the metadata is
    > written -first-, the file can scoop up random trash from elsewhere in

    Also, this is not a matter of metadata first or last. Sometimes you need
    metadata first, sometimes you need it last. And in many cases, "metadata"
    does not need to change, while data still changes.

I'm using "metadata" here as a shorthand for "how the filesystem knows
which byte on disk corresponds to which byte in the file", not just
things like atime, ctime, etc.

    > the filesystem.  I contend that this is -much- worse, because it can
    > render a previously-good file completely unparseable by tools that
    > expect that -all- of the file is in a particular syntax.

    It depends - with ext2 you frequently have garbled files, too. Basically, if
    you write to a file and turn off the power the outcome is unexpected, and
    will always be (unless you are ready to take the big speed hit).

    > Unfortunately, this behavior meant that X -did- fall over, because my
    > XF86Config file was trashed by being scrambled---I'd recently written
    > out a new version, after all---and the trashed copy no longer made any

    But the same thing can and does happen with ext2, depending on your editor
    and your timing. It is not a reiserfs thing.

Well, I've gotten several pieces of private mail from people
complaining that it's happening a lot more with reiserfs.  And
I've never been bitten this way in years of ext2 usage.

    > But if you write the metadata first, you foil this attempt to be safe,
    > because you might have this sequence at the actual disk:  [magnetic
    > oxide updated w/rename][start updating magnetic oxide with tempfile
    > data][power failure or reset]---ooops! original file gone, new file
    > doesn't have its data yet, so sorry, thanks for playing.

    Of course. If you want data to hit the disk, you have to use fsync. This
    does work with reiserfs and will ensure that the data hits the disk. If
    you don't do this then bad things might happen.

It's that I either want the data to hit the disk, or -not- to hit
the disk, but not to partially-update files such that things are
inconsistent even when the disk has been idle for 20 seconds
and the system isn't doing anything else.  It's even worse in
that the filesystem -believes- itself to be accurate, even though
the data it's actually storing is scrambled.

    > By writing metadata first, it seems that reiserfs violates the
    > idempotence of many filesystem operations, and does exactly the
    > opposite of what "journalling" implies to anyone who understands
    > databases, namely that either the operation completes entirely, or it
    > is completely undone.

    You are confusing databases with filesystems, however. Most journaling
    filesystems work that way. Some (like ext3) are nice enough to let you
    choose.

I am deliberately talking about databases, because the terminology and
technology of journalling came from there.  Using the term "journalling"
and then behaving very differently from the way it's used in database
design is misleading at best.  Several people who've written to me
have said they felt "cheated" to discover that reiserfs didn't
actually journal the data or otherwise misbehaved in ways similar
to my problem here.
