Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275178AbRKMQgD>; Tue, 13 Nov 2001 11:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275265AbRKMQfw>; Tue, 13 Nov 2001 11:35:52 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:22776 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S275178AbRKMQfp>;
	Tue, 13 Nov 2001 11:35:45 -0500
Date: Tue, 13 Nov 2001 00:45:47 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Mike Fedyk <mfedyk@matchmail.com>, Andrew Morton <akpm@zip.com.au>,
        Ben Israel <ben@genesis-one.com>, linux-kernel@vger.kernel.org
Subject: Re: File System Performance
Message-ID: <20011113004547.J1778@lynx.no>
Mail-Followup-To: Richard Gooch <rgooch@ras.ucalgary.ca>,
	Mike Fedyk <mfedyk@matchmail.com>, Andrew Morton <akpm@zip.com.au>,
	Ben Israel <ben@genesis-one.com>, linux-kernel@vger.kernel.org
In-Reply-To: <00b201c16b81$9d7aaba0$5101a8c0@pbc.adelphia.net> <3BEFF9D1.3CC01AB3@zip.com.au> <00da01c16ba2$96aeda00$5101a8c0@pbc.adelphia.net> <3BF02702.34C21E75@zip.com.au> <200111121959.fACJxsj08462@vindaloo.ras.ucalgary.ca> <20011112150740.B32099@mikef-linux.matchmail.com> <200111130004.fAD04v912703@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <200111130004.fAD04v912703@vindaloo.ras.ucalgary.ca>; from rgooch@ras.ucalgary.ca on Mon, Nov 12, 2001 at 05:04:57PM -0700
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 12, 2001  17:04 -0700, Richard Gooch wrote:
> Mike Fedyk writes:
> > I don't think that would help at all... With the current file/dir
> > allocator it will choose a new block group for each directory no
> > matter what the parent is...
> 
> I thought the current implementation was that when creating a
> directory, ext2fs searches forward from the block group the parent
> directory is in, looking for a "relatively free" block group. So, a
> number of successive calls to mkdir(2) with the same parent directory
> will result in the child directories being in the same block group.
> 
> So, creating the directory tree by creating directories in the base
> directory and then shuffling should result in the directories be
> spread out over a modest number of block groups, rather than a large
> number.

I think that it doesn't matter what the starting directory is for the
creation of directories - we always scan all groups and will always
pick the directory with the minimum number of blocks, as long as it
doesn't have too many inodes (i.e. more than average, like /dev ;-).

> Addendum to my scheme: leaf nodes should be created in their
> directories, not in the base directory. IOW, it's only directories
> that should use this trick.

That is the current algorithm anyways - create leaf nodes in the same
group as the parent directories.



Now, if there _was_ a way to influence the creation of directories in
the same group, then this would do what Andrew wants - put all of the
directories, inodes, blocks into the same group, for fast access.

Maybe if there was some hysteresis in group selection it would be
enough - pick the best directory, and then continue to create subdirs
(and files, implicitly) there until we pass some threshold(s).  Some
thresholds are:

1) Block count too high.  We don't want to be totally wimpy here (e.g.
   bailing out when we hit the "average", but we (probably, maybe) also
   don't want to untar a kernel in a single group, fill it up, and then
   have to put all of the object files in another group.  Maybe fill
   until we hit (1 + average)/2, or (3 + average)/4? 
2) Inode count/directory count too high.  See #1.
3) Time (yucky, but reasonable if it is long enough, i.e. ten(s) of
   seconds), so we reset the metrics, possibly in conjuction with...
4) process ID (yucky also, but possible, IF we want "tar" to put all
   things in a single group), but not if the process is long-lived
   (e.g. nfs, so we need (3) also)

Using (3) and (4) is ugly, because it is somewhat non-deterministic,
but 4 at least is repeatable in that a single process will continue to
write into a single group, while a multiple-writer scenario will spread
the files around (but some write to a log file might screw it up).
Also, if we have "state" in selecting a group to create files, we also
want to periodically pick a new group which is "best" to create new
directories/files in.

>From what I can understand of the code, the Orlov allocator does something
like #1 and/or #2.  Andrew showed that this is an improvement for writing
a tarball, but with the "aging" tool he used, it didn't work as well
as the current algorithm.  Unfortunately, the weights/parameters of the
Orlov code is hard to deduce from the code, so I don't know how it would
be tuned.  Also, it is not certain that the aging tool is valid for our
needs.

So, the difference between the current allocator and the Orlov allocator
is that the current allocator always tries to find the "best" group for
each new directory, while the Orlov allocator will pick the parent unless
it is "bad" (i.e. too few inodes/blocks, too many directories).  It may
be that "too few" and "too many" are not tuned correctly yet.  Given that
tarballs and other archives are normally created with depth-first traversal,
we may not need to use the number of directories as a selection criterion
and clustering many small directories is not itself a bad thing.  I'm still
not sure of the "debt" thing going on there...

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

