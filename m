Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272774AbRIVUoW>; Sat, 22 Sep 2001 16:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272197AbRIVUoN>; Sat, 22 Sep 2001 16:44:13 -0400
Received: from out-of-band.media.mit.edu ([18.85.16.22]:18704 "EHLO
	out-of-band.media.mit.edu") by vger.kernel.org with ESMTP
	id <S272264AbRIVUn6>; Sat, 22 Sep 2001 16:43:58 -0400
Date: Sat, 22 Sep 2001 16:44:21 -0400 (EDT)
Message-Id: <200109222044.QAA11638@out-of-band.media.mit.edu>
From: foner-reiserfs@media.mit.edu
To: Nikita@Namesys.COM
CC: linux-kernel@vger.kernel.org, Reiserfs-List@Namesys.COM
In-Reply-To: <15276.34915.301069.643178@beta.reiserfs.com> (message from
	Nikita Danilov on Sat, 22 Sep 2001 16:47:31 +0400)
Subject: ReiserFS data corruption in very simple configuration
CC: foner-reiserfs@media.mit.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Date: Sat, 22 Sep 2001 16:47:31 +0400
    From: Nikita Danilov <Nikita@Namesys.COM>

    Stock reiserfs only provides meta-data journalling. It guarantees that
    structure of you file-system will be correct after journal replay, not
    content of a files. It will never "trash" file that wasn't accessed at
    the moment of crash, though.

Thanks for clarifying this.  However, I should point out that the
failure mode is quite serious---whereas ext2fs would simply fail
to record data written to a file before a sync, reiserfs seems to
have instead -swapped random pieces of one file with another-,
which is -much- harder to detect and fix.  I can live with uncommitted
changes, but it's hard to justify the behavior I saw---it means that
any even slightly-busy machine that experiences a crash could have
dozens or hundreds of files with each others' contents all mixed
together---remember, parts of my XF86Config file wound up in wtmp!
And both XF86Config and wtmp had been written at least 20 seconds
before I had to push the reset button, and perhaps > 30 seconds; I
don't recall how often the FS is syncing by default, but it's
disturbing behavior.  After all, at the time I pushed reset, I had
-no- files actually being written by any process under my direct
control; I'd merely written one file out from Emacs under a minute
earlier.  I'd hate to think of what would happen if this sort of thing
hit a CVS repository.

This seems to outweigh the convenience of a rapid start after failure
(one of the reasons I decided to try reiserfs in the first place),
because a failure means possibly having to recover an entire file
server from backups (hence losing -lots more- data) because you don't
know which files might have been trashed if the machine loses power or
the kernel panics.  There's no simple test ("did my edits make it into
the file?"), and no way to really know if the machine might later
misbehave because critical files have been overwritten with parts of
others.  (This inability to easily figure out what might have been
affected also means that the damage will rapidly propagate to backups,
hence making the backups useless.)  About the only way around it would
seem to be to checksum every file in the FS at regular intervals, and
rechecksum after a crash---at which point, what's the point of not
having to run fsck?

Is this -really- how reiserfs is supposed to behave in a crash?
It seems like this should be prominently documented in the description
of the file system---I know that I'm rather nervous about using it if
this is true, since it turns a few minutes of fsck'ing (for ext2fs)
into a restore-the-whole-file-system exercise instead.  Surely that's
not right.  If this is really supposed to be how reiserfs behaves any
time it doesn't get to sync before a machine dies on it, I can't see
how it can be justified for any production use, and I'll probably have
to reinstall my OS using ext2fs instead.

                                 Full data-journaling comes at cost. There
    is patch by Chris Mason <Mason@Suse.COM> to support data journaling in
    reiserfs. Ext3 supports it also.

Do you have a URL for this?  A search for reiserfs and mason yields
12,000 hits.  (I'm particularly interested in one for reiserfs 3.6.25
and Mandrake 8.0, but I assume there may be several variants in the
same repository.)

     > So I now have possibly-undetected filesystem damage.  My -guess- is
     > that only files written within a few minutes of the reset are likely
     > to be affected, but I really don't know, and don't know of a good way
     > to find out.  Must I reinstall the OS -again-, starting from a blank
     > partition, to be sure?  Maybe I should just give up on ReiserFS completely.
     > 
     > [If there is a more-appropriate place for me to send this---such as
     > a particular Mandrake list, or a particular ReiserFS list---please let
     > me know, particularly if I can get a quick answer -without- going

    Reiserfs mail-list <Reiserfs-List@Namesys.COM>,
    archive at http://marc.theaimsgroup.com/?l=reiserfs&r=1&w=2

Thanks.  I saw that list before, and I'm glad that you've included it
in this discussion.
