Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264127AbTF3Aoj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 20:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265693AbTF3Aoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 20:44:39 -0400
Received: from smtp-out.comcast.net ([24.153.64.109]:32280 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S264127AbTF3Aoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 20:44:37 -0400
Date: Sun, 29 Jun 2003 20:58:00 -0400
From: rmoser <mlmoser@comcast.net>
Subject: Re: File System conversion -- ideas
In-reply-to: <20030630000508.GA3657@cs78143044.pp.htv.fi>
To: Richard Braakman <dark@xs4all.nl>, linux-kernel@vger.kernel.org
Message-id: <200306292058000590.0331625D@smtp.comcast.net>
MIME-version: 1.0
X-Mailer: Calypso Version 3.30.00.00 (3)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk>
 <20030629132807.GA25170@mail.jlokier.co.uk> <3EFEEF8F.7050607@post.pl>
 <20030629192847.GB26258@mail.jlokier.co.uk>
 <20030629194215.GG27348@parcelfarce.linux.theplanet.co.uk>
 <200306291545410600.02136814@smtp.comcast.net> <3EFF4677.4050002@sktc.net>
 <200306291636150850.0241B66C@smtp.comcast.net>
 <20030630000508.GA3657@cs78143044.pp.htv.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



*********** REPLY SEPARATOR  ***********

On 6/30/2003 at 3:05 AM Richard Braakman wrote:

>On Sun, Jun 29, 2003 at 04:36:15PM -0400, rmoser wrote:
>> Told you, I can't code it.  I could work on making an initial design for
>the
>> most important part though, the datasystem that separates the two
>filesystems
>> and holds the meta-data and data in self-contained atoms.  I KNOW I won't
>> get it right the first time, but I can give you a place to start.
>
>I don't think that's the most important part.  The most important part
>is figuring out a layout for the filesystem while it's in transition,
>such that it is at the same time a valid ext3 filesystem (so that the
>ext3 export routines can work on it) and a valid reiser4 filesystem
>(so that the reiser4 import routines can work on it).  And you need
>to do it in such a way that the import routines won't stomp on data
>that hasn't been exported yet.
>

Nerg.  Filesystem isn't exactly readable while it's being disassembled.
Well, I'd leave everything in place for inodes that are there, but entries in
the inode table are slowly being removed.  The idea is that you keep what
you need to get to valid, and the hell with what you're done with.  For
example, once I've drained all data out of the superblock and categorized
it so that I can pass it to functions to deal with the orginal fs (OFS), you can
destroy the superblock on-disk, and just make logical copies of it in RAM
whenever it needbe referenced (just like buffering, before it's flushed to disk
the buffer is read for the changed data).

By the same token, once you grab all data and meta-data for an Inode and
place it into an atom, you're'm done with that inode and it's data.  You won't
be reading it again and you will NOT be writing to the OFS again.  Poof, free'd.
That space belongs to the converter datasystem.

Note that the inode table is now invalid.  Still, you can mark what I've taken
apart already down, and point out where to start.  The OFS driver will of
course have given you a chunk of all the important information from the
superblock and whatever else it needs to locate any given inode by index,
which it'll be querying when you tell it to get the NEXT inode.  Of course you
extract that inode, and you have exactly what you need to locate the data
belonging to it and pack it into another atom.

By the same token, you can probably start off with a valid filesystem for
your TFS (Target FS), by spewing out a superblock and a fresh, empty
Inode table that you fill in slowly.

Now I'm working on this upstairs, and I've run into the directory issue.
You know, the inode numbers change as you go along.  There's a way
to deal with that too.  Three ways actually.

-- Hold directories off until last.  As you rewrite inodes, you scan the
directory atoms and find the pointers to the original inode numbers.
Then change them to whatever the hell they changed to.

-- Inform the TFS of the original inode index for each inode as you send
it, and let it rewrite the directories

-- Make sure inodes match up

The last one is stupid.  It may not be possible, or may just not work.
It requires copying deleted inodes too.

The second one is an admirable attempt, but still stupid:  You have to
do a whole scan every time an inode is written to the TFS.

That first one is great.  It puts all directories at the end of the TFS, true.
but they're all together, interestingly enough.  Also, it lets the CDS
(Conversion DataSystem) control how these are indexed, which allows
universal optimization by rewriting the CDS' code.

>If you don't have that, then there's no point in putting it in the
>kernel because you won't be able to re-use the kernel fs code anyway.
>

Some of it has to be rewritten.

>Then you need to generalize this to work with any pair of filesystems.
>

Done.

>As for the datasystem to hold the metadata: I expect you'll find that
>backup/restore systems already implement this.  It's what they have to
>do, after all.
>

NOT in place they don't!

>Richard Braakman
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/



