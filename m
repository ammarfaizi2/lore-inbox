Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274362AbRJABBH>; Sun, 30 Sep 2001 21:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274365AbRJABA6>; Sun, 30 Sep 2001 21:00:58 -0400
Received: from out-of-band.media.mit.edu ([18.85.16.22]:47878 "EHLO
	out-of-band.media.mit.edu") by vger.kernel.org with ESMTP
	id <S274362AbRJABAl>; Sun, 30 Sep 2001 21:00:41 -0400
Date: Sun, 30 Sep 2001 21:00:49 -0400 (EDT)
Message-Id: <200110010100.VAA07189@out-of-band.media.mit.edu>
From: foner-reiserfs@media.mit.edu
To: pcg@goof.com
CC: sct@redhat.com, Nikita@Namesys.COM, Mason@Suse.COM,
        linux-kernel@vger.kernel.org, reiserfs-list@Namesys.COM
In-Reply-To: <20010929145229.C26231@schmorp.de> (pcg@goof.com)
Subject: [reiserfs-list] ReiserFS data corruption in very simple configuration
CC: foner-reiserfs@media.mit.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Date: Sat, 29 Sep 2001 14:52:29 +0200
    From: <pcg@goof.com ( Marc) (A.) (Lehmann )>

Thanks for your response!  Bear with me, though, because I'm asking
a design question below that relates to this.

    On Sat, Sep 29, 2001 at 12:44:59AM -0400, Lenny Foner <foner-reiserfs@media.mit.edu> wrote:
    > isn't fixed by fsck?  [See outcome (d) below.]  I'm having difficulty
    > believing how this can be possible for a non-journalling filesystem.

    If you have difficulties in believing this, may I ask you how you think it
    is possible for a non-journaling filesystem to prevent this at all?

Naively, one would assume that any non-journalling FS that has written
correct metadata through to the disk would either have written updates
into files, or failed to write them, but would not have written new
(<60 second old) data into different files than the data was destined for.
(I suppose the assumption I'm making here is that, when creating or
extending a file, the metadata is written -last-, e.g., file blocks
are allocated, file data is written, and -then- metadata is written.
That way, a failure anywhere before finality simply seems to vanish,
whereas writing metadata first seems to cause the lossage below.)

    > But what about written to the wrong files?  See below.

    What you see is most probably *old* data, not data from another (still
    existing) file.

I'm...  dubious, but maybe.  As mentioned earlier in this thread,
one of the failures I saw consisted of having several lines of my
XFree86.0.log file appended to wtmp---when I logged in after the
failure, I got "Last login: " followed by several lines from that file
instead of a date.  (Other failures scrambled other files worse.)

Now, it's -possible- that rsfs allocated an extra portion to the end
of wtmp for the last-login data (as a user of the fs, I don't care
whether officially this was a "block", an entry in a journal, etc),
login "wrote" to that region (but it wasn't committed yet 'cause no
sync), my XFree86.0.log file was "created" and "written" (again
uncommitted), I pushed reset, and then when it came back up, the end
of wtmp had data from the -previous- copy of XFree86.0.log that had
been freed (because it was unlinked when the next copy was written)
but which had not actually had the wtmp data written to it yet
(because a sync hadn't happened).  I have no way to verify this, since
one XFree86.0.log looks much like the other.  Conceptually, this would
imply that wtmp was extended into disk freespace, which just happened
to have that logfile in it (instead of zero bytes).  Is this what
you're talking about when you say "*old* data"?  I think so, and that
seems to match your comment below about file tails moving around
rapidly.

But it doesn't explain -why- it works this way in the first place.
Wouldn't it make more sense to commit metadata to disk -after- the
data blocks are written?  After all, if -either one- isn't written,
the file is incomplete.  But if the metadata is written -last-, the
file simply looks like the data was never added.  If the metadata is
written -first-, the file can scoop up random trash from elsewhere in
the filesystem.  I contend that this is -much- worse, because it can
render a previously-good file completely unparseable by tools that
expect that -all- of the file is in a particular syntax.  It's just
an accident, I guess, that login will accept any random trash when
it prints its "last-login" message, rather than falling over with a
coredump because it doesn't look like a date.  [And see * below.]

Unfortunately, this behavior meant that X -did- fall over, because my
XF86Config file was trashed by being scrambled---I'd recently written
out a new version, after all---and the trashed copy no longer made any
sense.  I would have been -much- happier to have had the -unmodified-,
-old- version than a scrambled "new" version!  Without Emacs ~ files,
this would have been much worse.  Consider an app that, "for reliability",
rewrites a file by creating a temp copy, writing it out, then renaming
the temp over the original [this is how Emacs typically saves files].
But if you write the metadata first, you foil this attempt to be safe,
because you might have this sequence at the actual disk:  [magnetic
oxide updated w/rename][start updating magnetic oxide with tempfile
data][power failure or reset]---ooops! original file gone, new file
doesn't have its data yet, so sorry, thanks for playing.

By writing metadata first, it seems that reiserfs violates the
idempotence of many filesystem operations, and does exactly the
opposite of what "journalling" implies to anyone who understands
databases, namely that either the operation completes entirely, or it
is completely undone.  Yes, yes, I know (now!) that it claims to only
journal the metadata, but how does this help when what it's essentially
doing is trashing the -data- in unexpected ways exactly when such
journalling is supposed to help, namely across a machine failure?

This seems like such an elementary design defect that I'm at a loss
to understand why it's there.  There -must- be some excellent reason,
right?  But what?  And if not, can it be fixed?

I'm also still waiting to find out how to make reiserfs actually
journal its data, and what the performance implications of this are.
No one has responded with a URL.

[*] It's also a security hole.  If I want to read a file that I'm not
authorized to read, -but- I can cause a kernel panic (or a blackout!),
then I can craftily wait until up to several seconds after the
"secure" file is being rewritten (presumably via the write-tempfile-
and-relink method), create a big file of my own, and force the
panic---my file may then get some of the secure blocks from the old
copy.  And, unlike filesystems that write metadata last, the "secure"
program can't just zero out the blocks of the file it's about to
unlink, because---since metadata is written first---those zeroes won't
have made it to disk yet even though the blocks have been declared
free and included in my file.  I now know what's in your file.
Whoops.  And this is such an enormous timing hole that I can write a
program that just checks every 5 seconds or so for a new copy of the
secure file, -then- forces the failure---I need not get the timing
very good, as long as it's likely that I'll do so before the next
sync.  It's so bad that, even if I can't force a panic, my program
can just beep and I'll immediately go short out the outlet that
happens to be on the same circuit as the machine I'm attacking.

    [ . . . ]

    > (d) Metadata correctly written, FILE DATA INTERCHANGED BETWEEN A AND B.

    this shouldn't happen on reiserfs. however, the unwritten parts of file a can easily
    contain data formerly in file b.

Then why allow metadata to be written first instead of last?

    > (e) Metadata corrupted in some fashion, file data undefined.
    >     ("Undefined" means could be any of (a) through (d) above; I don't care.)

    this should be prevented by journaling (of course, this won't help against
    harddisk failures) on reiserfs. ext2 often has this problem, but fsck usually
    can repair it. it's easy to tell metadata from filedata on ext2.

    > whether we can "guarantee that all the data blocks have been written",
    > but may be missing the point I was making, namely that THE BLOCKS HAVE
    > BEEN WRITTEN TO THE WRONG FILES.

    remember that the blocks have previous content, and reiserfs' tails
    optimization means that files appended all the time (wtmp) can move around
    rapidly (at least their tail).

    [ . . . ]
