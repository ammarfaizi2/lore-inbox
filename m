Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274886AbRJALav>; Mon, 1 Oct 2001 07:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274890AbRJALal>; Mon, 1 Oct 2001 07:30:41 -0400
Received: from chunnel.redhat.com ([199.183.24.220]:55544 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S274886AbRJALa2>; Mon, 1 Oct 2001 07:30:28 -0400
Date: Mon, 1 Oct 2001 12:30:17 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Lenny Foner <foner-reiserfs@media.mit.edu>
Cc: sct@redhat.com, linux-kernel@vger.kernel.org, reiserfs-list@Namesys.COM
Subject: Re: ReiserFS data corruption in very simple configuration
Message-ID: <20011001123017.B20459@redhat.com>
In-Reply-To: <20010925142854.A5384@redhat.com> <200109290444.AAA19624@out-of-band.media.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200109290444.AAA19624@out-of-band.media.mit.edu>; from foner-reiserfs@media.mit.edu on Sat, Sep 29, 2001 at 12:44:59AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Sep 29, 2001 at 12:44:59AM -0400, Lenny Foner wrote:

>     Not true.  ext2, ext3 in its "data=writeback" mode, and reiserfs can
>     all demonstrate this behaviour.  Reiserfs is being no worse than ext2
>     (the timings may make the race more or less likely in reiserfs, but
>     ext2 _is_ vulnerable.)
> 
> ext2fs can write parts of file A to file B, and vice versa, and this
> isn't fixed by fsck?

No, we're not talking about incorrect writes, but *incomplete* writes,
which is a totally different thing.  An ext2 write of new data
involves many steps: the inode needs to be written to mark the file's
new size, the indirect mapping block[s] may have to be written to
record where the data is, and the data blocks themselves need to be
written.

Not only that, but a delete also requires multiple writes.  If you
delete a file and rapidly create a new one, then the image of the
filesystem in cache remains totally consistent, but the copy on disk
is updated incrementally and if you crash before the entire image is
updated, you can end up seeing both bits of the old file that was in
the process of being deleted, and the new file that was being created.

In addition, journaling prevents metadata inconsistencies from
occuring due to incomplete writes, but on its own, metadata journaling
doesn't mean that the data blocks are also in sync --- the disk blocks
describing a new file might be on disk, but the data blocks that the
file contains might not be.  Reiserfs, and also ext3 in its fastest
"writeback" mode, both behave like this (but ext3's other modes order
data writes so that this situation never happens: data blocks are
always flushed to disk before the metadata is committed.)

>     e2fsck only restores metadata consistency on ext2 after a crash: it
>     can't possibly guarantee that all the data blocks have been written.
> 
> But what about written to the wrong files?  See below.

See above.  If all the metadata is intact, how can e2fsck *possibly*
detect whether a data block contains the old or the new contents of
the block?

> Let's take this scenario:  Files A and B have had blocks written to
> them sometime in the recent past (30 to 60 seconds or so) and a sync
> has not happened yet.  (I don't know how often reiserfs will be synced
> by default; 60 seconds?  Longer?  Presumably running "sync" will force
> it, but I don't know when else it will happen.)  File A may have been
> completely rewritten or newly written (e.g., what Emacs does when it
> saves a file), whereas file B may have simply been appended to (e.g.,
> what happens when wtmp is updated).
> 
> The CPU reset button is then pushed.  [See P.P.S. at end of this message.]
> 
> Now, we have the following possibilities for the outcome after the
> system comes back up and has finished checking its filesystem:
> 
> (a) Metadata correctly written, file data correctly written.
> (b) Metadata correctly written, file data partially written.
>     (E.g., one or both files might have been partially or completely
>     updated.) 
> (c) Metadata correctly written, file data completely unwritten.
>     (Neither file got updated at all.)
> (d) Metadata correctly written, FILE DATA INTERCHANGED BETWEEN A AND B.
>     (E.g., File A gets some of file B written somewhere within it,
>     and file B gets some of file A written somewhere within it---this
>     is the behavior I observed, at least twice, with reiserfs.)
> (e) Metadata corrupted in some fashion, file data undefined.
>     ("Undefined" means could be any of (a) through (d) above; I don't care.)
> 
> Now, which filesystems can show each outcome?  I don't know.  I
> contend that reiserfs does (d).  Stephen Tweedie talks above about
> whether we can "guarantee that all the data blocks have been written",
> but may be missing the point I was making, namely that THE BLOCKS HAVE
> BEEN WRITTEN TO THE WRONG FILES.

For ext3, (d) will never happen in this case.  You can only get
"wrong" data blocks if one of the files is being *deleted*, and its
blocks have been allocated to a new file, and the handover of those
blocks is incomplete at the time of the crash.

ext3 will only give you (a) (both metadata and data correctly written)
or (f) (neither have yet been written at all) if it is running in
ordered or data-journaling mode.  (b) and (c) are possible only if you
are in writeback mode.  (d) and (e) never happen if you're creating
two files, although in writeback mode (d) is possible if, say, you are
deleting A and writing B at the same time (the other ext3 modes
prevent this scenario too.)

Cheers,
 Stephen
