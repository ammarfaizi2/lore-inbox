Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316500AbSGSNaD>; Fri, 19 Jul 2002 09:30:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316542AbSGSNaD>; Fri, 19 Jul 2002 09:30:03 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:43394 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S316500AbSGSNaC>; Fri, 19 Jul 2002 09:30:02 -0400
Date: Fri, 19 Jul 2002 08:32:56 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200207191332.IAA65963@tomcat.admin.navo.hpc.mil>
To: cat@zip.com.au, Larry McVoy <lm@work.bitmover.com>,
       Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
Subject: Re: Alright, I give up.  What does the "i" in "inode" stand for?
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CaT <cat@zip.com.au>:
> On Thu, Jul 18, 2002 at 09:38:57PM -0700, Larry McVoy wrote:
> > On Thu, Jul 18, 2002 at 06:33:54PM -0400, Rob Landley wrote:
> > > I've been sitting on this question for years, hoping I'd come
> > > across the answer, and I STILL don't know what the "i" is short for.
> > > Somebody here has got to know this. :)
> > 
> > Incore node, I believe.  In the original Unix code there was dinode and
> > inode if I remember correctly, for disk node and incore node.
> 
> That's a new one. I always thought it was 'information node' so in the
> above it'd be disk information node and just information node.
> 
> Makes sense to me in any case. :)

I believe the original description was "index node" since it contains
the contents of the file index - dinode was the disk resident file
index node, which is converted to the memory resident version "inode".

This index node also contains the index references to the disk blocks
allocated to the file.

In even earlier OSs (DEC RSX, TOPS 10) the file index table was actually a file
in the filesystem (usually named index.idx (or was it file.idx...). I don't
know what it was called in MULTICs where the UNIX varient would have
started.

Most of these filesystems were based on contigeuous allocation, or allocations
of contigeous segments. Hence the first file on the system would be a
contigeuous file, containing the references to all files. Since it was
contiguous, the files could be referenced directly by index, without
requiring special handling to retrieve pointers to where the next
segment of the index file - which is still true for most filesystems
under UNIX (the really large ones are moving to tree structures which
require multiple lookups just to find the inode entry...). Directory
structures (at least on the ones I worked with) contained:
	index number, version, name
triples.

Note - the version number had nothing to do with the file version -
it was used to aid file recovery and was only a reuse count of the index
node. The index node contents had to have the same version number as the
directory entry, or the directory entry was considered invalid. The
file name was a rad50, or sixbit (packed) characters, and sometimes was
stored in both inode and directory - again, for rebuilding the file system.

The pointers in the index node were (block, count) pairs
where the count was the number of blocks in the segment, starting at
"block" location. When the list of pointers in the index node were used
up, the last entry would be another (index number, version) pair pointing
to another index node.

This made it fairly fast for I/O since large chunks of the file could be
loaded in one disk access. Faster access could be had by preallocating
the file (useing the copy utility with a "contig" option).

Fragmentation, however, did force a relatively frequent backup/restore cycle
(took all afternoon on the first Saturday of every month for 8 80MB disks).

Sorry - irrestable nostalgia struck....
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
