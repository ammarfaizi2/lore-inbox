Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276494AbRI2MxC>; Sat, 29 Sep 2001 08:53:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276495AbRI2Mww>; Sat, 29 Sep 2001 08:52:52 -0400
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:23458 "EHLO
	mailout.plan9.de") by vger.kernel.org with ESMTP id <S276492AbRI2Mwo>;
	Sat, 29 Sep 2001 08:52:44 -0400
Date: Sat, 29 Sep 2001 14:52:29 +0200
From: <pcg@goof.com ( Marc) (A.) (Lehmann )>
To: Lenny Foner <foner-reiserfs@media.mit.edu>
Cc: sct@redhat.com, Nikita@Namesys.COM, Mason@Suse.COM,
        linux-kernel@vger.kernel.org, reiserfs-list@Namesys.COM
Subject: Re: [reiserfs-list] ReiserFS data corruption in very simple configuration
Message-ID: <20010929145229.C26231@schmorp.de>
Mail-Followup-To: Lenny Foner <foner-reiserfs@media.mit.edu>,
	sct@redhat.com, Nikita@Namesys.COM, Mason@Suse.COM,
	linux-kernel@vger.kernel.org, reiserfs-list@Namesys.COM
In-Reply-To: <20010925142854.A5384@redhat.com> <200109290444.AAA19624@out-of-band.media.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <200109290444.AAA19624@out-of-band.media.mit.edu>
X-Operating-System: Linux version 2.4.8-ac8 (root@cerebro) (gcc version 3.0.1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 29, 2001 at 12:44:59AM -0400, Lenny Foner <foner-reiserfs@media.mit.edu> wrote:
> isn't fixed by fsck?  [See outcome (d) below.]  I'm having difficulty
> believing how this can be possible for a non-journalling filesystem.

If you have difficulties in believing this, may I ask you how you think it
is possible for a non-journaling filesystem to prevent this at all?

> But what about written to the wrong files?  See below.

What you see is most probably *old* data, not data from another (still
existing) file.

> has not happened yet.  (I don't know how often reiserfs will be synced
> by default; 60 seconds?  Longer?  Presumably running "sync" will force

mostly like with any other filesystem (man bdflush)

> Now, we have the following possibilities for the outcome after the

> (a) Metadata correctly written, file data correctly written.

all filesystems ;)

> (b) Metadata correctly written, file data partially written.
>     (E.g., one or both files might have been partially or completely
>     updated.) 

ext2, reiserfs.

> (c) Metadata correctly written, file data completely unwritten.
>     (Neither file got updated at all.)

ext2, reiserfs.
   
> (d) Metadata correctly written, FILE DATA INTERCHANGED BETWEEN A AND B.

this shouldn't happen on reiserfs. however, the unwritten parts of file a can easily
contain data formerly in file b.

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

> P.P.S.  I say reset and not power-off, although I hope that this is
> moot, because I presume that the unsynced data, by virtue of being
> unsynced, is nowhere near the disk datapaths anyway.

this can make a big difference. many disks (ibm, maxtor) nowadays write
partial blocks on power outage, this gives "Uncorrectable read errors",
which is fatal, because no filesystem so far can work around this. It's
easy to repair (just rewrite the block), but would requite filesystem
feedback (hey, reisrefs, this metadata block is *garbage*).

> a reset should let the disks continue to write data out of their write
> buffers, assuming that a CPU reset doesn't flush such pending

they should, yes. OTOH, ide disks are cheap...

> not matter; is it common that disks might leave data buffered but
> unwritten for 30 seconds if there is no other disk activity?  I would

no. and it doesn't make sense. but it's not forbidden or sth.

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
