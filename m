Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276439AbRI2EpQ>; Sat, 29 Sep 2001 00:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276440AbRI2EpH>; Sat, 29 Sep 2001 00:45:07 -0400
Received: from out-of-band.media.mit.edu ([18.85.16.22]:48399 "EHLO
	out-of-band.media.mit.edu") by vger.kernel.org with ESMTP
	id <S276439AbRI2Eoy>; Sat, 29 Sep 2001 00:44:54 -0400
Date: Sat, 29 Sep 2001 00:44:59 -0400 (EDT)
Message-Id: <200109290444.AAA19624@out-of-band.media.mit.edu>
From: Lenny Foner <foner-reiserfs@media.mit.edu>
To: sct@redhat.com
CC: Nikita@Namesys.COM, Mason@Suse.COM
CC: linux-kernel@vger.kernel.org, reiserfs-list@Namesys.COM
In-Reply-To: <20010925142854.A5384@redhat.com> (sct@redhat.com)
Subject: ReiserFS data corruption in very simple configuration
CC: foner-reiserfs@media.mit.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[As before, please make sure you CC me on replies or I won't see them.  Tnx!]

    Date: Tue, 25 Sep 2001 14:28:54 +0100
    From: "Stephen C. Tweedie" <sct@redhat.com>

    Hi,

    On Sat, Sep 22, 2001 at 04:44:21PM -0400, foner-reiserfs@media.mit.edu wrote:

    >     Stock reiserfs only provides meta-data journalling. It guarantees that
    >     structure of you file-system will be correct after journal replay, not
    >     content of a files. It will never "trash" file that wasn't accessed at
    >     the moment of crash, though.
    > 
    > Thanks for clarifying this.  However, I should point out that the
    > failure mode is quite serious---whereas ext2fs would simply fail
    > to record data written to a file before a sync, reiserfs seems to
    > have instead -swapped random pieces of one file with another-,
    > which is -much- harder to detect and fix.

    Not true.  ext2, ext3 in its "data=writeback" mode, and reiserfs can
    all demonstrate this behaviour.  Reiserfs is being no worse than ext2
    (the timings may make the race more or less likely in reiserfs, but
    ext2 _is_ vulnerable.)

ext2fs can write parts of file A to file B, and vice versa, and this
isn't fixed by fsck?  [See outcome (d) below.]  I'm having difficulty
believing how this can be possible for a non-journalling filesystem.

    e2fsck only restores metadata consistency on ext2 after a crash: it
    can't possibly guarantee that all the data blocks have been written.

But what about written to the wrong files?  See below.

    ext3 will let you do full data journaling, but also has a third mode
    (the default), which doesn't journal data, but which does make sure
    that data is flushed to disk before the transaction which allocated
    that data is allowed to commit.  That gives you most of the
    performance of ext3's fast-and-loose writeback mode, but with an
    absolute guarantee that you never see stale blocks in a file after a
    crash.

I've been getting a stream of private mail over the last few days
saying one thing or another about various filesystems with various
optional patches, so let me get this out in the open and see if we can
converge on an answer here.  [ext2f2, ext3fs, and reiserfs answers
should feel free to cite which mode they're talking about and URLs for
whatever patches are required to get to that mode; some impressions
about reliability and maturity would be useful, too.]

Let's take this scenario:  Files A and B have had blocks written to
them sometime in the recent past (30 to 60 seconds or so) and a sync
has not happened yet.  (I don't know how often reiserfs will be synced
by default; 60 seconds?  Longer?  Presumably running "sync" will force
it, but I don't know when else it will happen.)  File A may have been
completely rewritten or newly written (e.g., what Emacs does when it
saves a file), whereas file B may have simply been appended to (e.g.,
what happens when wtmp is updated).

The CPU reset button is then pushed.  [See P.P.S. at end of this message.]

Now, we have the following possibilities for the outcome after the
system comes back up and has finished checking its filesystem:

(a) Metadata correctly written, file data correctly written.
(b) Metadata correctly written, file data partially written.
    (E.g., one or both files might have been partially or completely
    updated.) 
(c) Metadata correctly written, file data completely unwritten.
    (Neither file got updated at all.)
(d) Metadata correctly written, FILE DATA INTERCHANGED BETWEEN A AND B.
    (E.g., File A gets some of file B written somewhere within it,
    and file B gets some of file A written somewhere within it---this
    is the behavior I observed, at least twice, with reiserfs.)
(e) Metadata corrupted in some fashion, file data undefined.
    ("Undefined" means could be any of (a) through (d) above; I don't care.)

Now, which filesystems can show each outcome?  I don't know.  I
contend that reiserfs does (d).  Stephen Tweedie talks above about
whether we can "guarantee that all the data blocks have been written",
but may be missing the point I was making, namely that THE BLOCKS HAVE
BEEN WRITTEN TO THE WRONG FILES.

It would be nice to know, for each of ext2fs, ext3fs, and reiserfs,
what the -intended- outcome is, and what the -actual- outcome is
(since implementation bugs might make the actual outcome different
from the intended outcome).  Any additional filesystems anyone would
like to toss into the pot would be welcome; maybe I'll post a matrix
of the results, if we get some.

I'm -assuming- that the intended outcome for reiserfs (without data
journalling) is one of (a), (b), or (c).  If the intended outcome for
reiserfs without data journalling [or -any- FS, really] is in fact
(d), then I don't understand how this filesystem can be intended for
any reliable service, since a failure will garble all files written in
the last several seconds in a fashion that is very, very difficult to
unscramble.  (-Perhaps-, if all the metadata is indeed correct, it
would be possible to at least -identify- which files may have gotten
smashed, by looking for all files whose mtime or ctime is in the last
60 seconds (more?) before the failure, but they'd still be trashed in
bizarre ways---it's much easier to fix a file (particularly a text
file) that is simply out of date (having had only some, or none, of
its recent data written) then it is to fix one that's had data from
other file(s) added to it in random places.  Furthermore, files such
as wtmp will probably get their mtime modified the instant the system
comes back up, further muddying the waters.)

Can someone(s) help to address the above?  And, even better, could
this information be placed prominently on the web pages describing the
relevant file systems?  It would be extremely useful for people trying
to decide which one to run to know this -before- they have committed
umpteen gigabytes to one or the other and -then- get bitten.

Thanks!

P.S.  Nikita Danilov said that there is a data-journalling patch to
reiserfs written Chris Mason <Mason@Suse.COM>, but has not responded
with a URL to it; can someone (or Chris? now CC'ed) do so?  A search
for reiserfs and mason is useless, yielding 12,000 hits.  (I'm
particularly interested in one for reiserfs 3.6.25 and Mandrake 8.0,
but I assume there may be several variants in the same repository.)
Benchmarking data on the performance impact of data journalling for
reiserfs, ext3fs, and anything else anyone cares to supply would
probably be useful to lots of people at well.

P.P.S.  I say reset and not power-off, although I hope that this is
moot, because I presume that the unsynced data, by virtue of being
unsynced, is nowhere near the disk datapaths anyway.  But either way,
a reset should let the disks continue to write data out of their write
buffers, assuming that a CPU reset doesn't flush such pending
transactions; I don't know if there's some IDE bus sequence that can
do this, and whether CPU reset would issue such a sequence.  It may
not matter; is it common that disks might leave data buffered but
unwritten for 30 seconds if there is no other disk activity?  I would
hope that this is -not- true and that the buffered data is buffered
only while there is other activity, since failing to flush the buffer
when the disk is idle only increases the risk of losing it without
improving performance at all.
