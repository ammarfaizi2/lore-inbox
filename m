Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281536AbRKMGgF>; Tue, 13 Nov 2001 01:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281543AbRKMGfq>; Tue, 13 Nov 2001 01:35:46 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:63369 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S281542AbRKMGfl>; Tue, 13 Nov 2001 01:35:41 -0500
Date: Mon, 12 Nov 2001 23:34:44 -0700
Message-Id: <200111130634.fAD6YiM19519@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Andrew Morton <akpm@zip.com.au>, Ben Israel <ben@genesis-one.com>,
        linux-kernel@vger.kernel.org
Subject: Re: File System Performance
In-Reply-To: <20011112172832.F32099@mikef-linux.matchmail.com>
In-Reply-To: <00b201c16b81$9d7aaba0$5101a8c0@pbc.adelphia.net>
	<3BEFF9D1.3CC01AB3@zip.com.au>
	<00da01c16ba2$96aeda00$5101a8c0@pbc.adelphia.net>
	<3BF02702.34C21E75@zip.com.au>
	<200111121959.fACJxsj08462@vindaloo.ras.ucalgary.ca>
	<20011112150740.B32099@mikef-linux.matchmail.com>
	<200111130004.fAD04v912703@vindaloo.ras.ucalgary.ca>
	<20011112160822.E32099@mikef-linux.matchmail.com>
	<200111130026.fAD0QVK13232@vindaloo.ras.ucalgary.ca>
	<20011112172832.F32099@mikef-linux.matchmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[In the interests of brevity, I'm going to trim this to respond to one
point only, which seems to be the cause of the confusion]

Mike Fedyk writes:
> On Mon, Nov 12, 2001 at 05:26:31PM -0700, Richard Gooch wrote:
> > Mike Fedyk writes:
> > > On Mon, Nov 12, 2001 at 05:04:57PM -0700, Richard Gooch wrote:
> > > > > > Here's an idea: add a "--compact" option to tar, so that it creates
> > > > > > *all* inodes (files and directories alike) in the base directory, and
> > > > > > then renames newly created entries to shuffle them into their correct
> > > > > > positions. That should limit the number of block groups that are used,
> > > > > > right?
> > > > > > 
> 
> Currently, without any patching, any new directory will be put in a
> different block group from its parent.

Your statement seems inconsistent with the comment above
fs/ext2/ialloc.c:ext2_new_inode():
/*
 * There are two policies for allocating an inode.  If the new inode is
 * a directory, then a forward search is made for a block group with both
 * free space and a low directory-to-inode ratio; if that fails, then of
 * the groups with above-average free space, that group with the fewest
 * directories already is chosen.
 *
 * For other inodes, search forward from the parent directory\'s block
 * group to find a free inode.
 */

So N successive calls to mkdir(2), with the same parent, should result
in those directories being stored in the same block group as each
other. And, furthermore, if the parent directory block group is mostly
empty, then the child directories are placed adjacent to the parent's
block group.

> So, if you create the dirs in the same dir and then shuffle them
> around, you gain nothing.

If my reading of the comment above is correct, then the shuffling will
provide a gain.

> > > > > > It would probably also be a good idea to do that for cp as well, so
> > > > > > that when I do a "cp -al" of a virgin kernel tree, I can keep all the
> > > > > > directory inodes together. It will make a cold diff even faster.
> > > > > 
> 
> This doesn't fix all fast growth type apps, only tar and cp...

Sure. But it would provide me with a way of getting a better layout
for my kernel trees, and it might prove useful for other applications
and kernels. And it will provide a good fallback if good in-kernel
heuristic isn't forthcoming.

> > > > Mike Fedyk writes:
> > > > > I don't think that would help at all... With the current file/dir
> > > > > allocator it will choose a new block group for each directory no
> > > > > matter what the parent is...
> > > > 
> 
> Now does this make sence?

It would, if you were correct about the current implementation. Which
I think isn't the case.

> > > On Mon, Nov 12, 2001 at 05:04:57PM -0700, Richard Gooch wrote:
> > > > I thought the current implementation was that when creating a
> > > > directory, ext2fs searches forward from the block group the parent
> > > > directory is in, looking for a "relatively free" block group. So, a
> > > > number of successive calls to mkdir(2) with the same parent directory
> > > > will result in the child directories being in the same block group.
> > > >
> 
> Not currently, but the patch that is out will do this.

I think it currently *does*. Check the comment. Straight from the
2.4.14 sources.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
