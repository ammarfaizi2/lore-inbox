Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281322AbRKEUSb>; Mon, 5 Nov 2001 15:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281323AbRKEUSV>; Mon, 5 Nov 2001 15:18:21 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:46839 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S281322AbRKEUSC>;
	Mon, 5 Nov 2001 15:18:02 -0500
Date: Mon, 5 Nov 2001 13:16:37 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Mike Fedyk <mfedyk@matchmail.com>, lkml <linux-kernel@vger.kernel.org>,
        ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] disk throughput
Message-ID: <20011105131636.C3957@lynx.no>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	"Albert D. Cahalan" <acahalan@cs.uml.edu>,
	Mike Fedyk <mfedyk@matchmail.com>,
	lkml <linux-kernel@vger.kernel.org>,
	ext2-devel@lists.sourceforge.net
In-Reply-To: <20011104193232.A16679@mikef-linux.matchmail.com> <200111050554.fA55swt273156@saturn.cs.uml.edu> <3BE647F4.AD576FF2@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3BE647F4.AD576FF2@zip.com.au>; from akpm@zip.com.au on Mon, Nov 05, 2001 at 12:04:04AM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 05, 2001  00:04 -0800, Andrew Morton wrote:
> My original make-100,000-4k-files test creates the files
> in a tree - each node has 10 leafs.  For a total of 11,110
> directories and 100,000 files.  It originally did it 
> in-order, so:
> 
> mkdir(00)
> mkdir(00/00)
> mkdir(00/00/00)
> mkdir(00/00/00/00)
> creat(00/00/00/00/00)
> creat(00/00/00/00/01)
> ...
> mkdir(00/00/00/01)
> 
> etc.
> 
> So I changed it to create the 11,110 directories, and then
> to go back and create the 100,000 files.  This will ensure that the
> file's data are not contiguous with their parent directory.
> 
> With the ialloc.c change, plus the other changes I mentioned
> the time to create all these directories and files and then run
> /bin/sync fell from 1:53 to 0:28.  Fourfold.
> 
> And this was on an 8 gig fs.  On a 32 gig fs I'd expect to see
> a fifteen-fold difference due to the additional block groups.
> 
> Can you suggest a better test?

Well, just to emphasize the "block group" issues, you could try testing
with a 1kB or 2kB block filesystem.  This will give you 64x or 8x as
many groups as a 4kB block filesystem, respectively.

A more "valid" test, IMHO, would be "untar the kernel, (flush buffers),
build kernel" on both the original, and your "all in one group" inode
allocation heuristics.  It should be especially noticable on a 1kB
filesystem.  What this will show (I think) is that while untar/read
with your method will be fast (all inodes/files contiguous on disk)
once you start trying to write to that filesystem, you will have more
fragmentation/seeking for the writes.  It may be that with large-memory
systems you will cache so much you don't see a difference, hence the
(flush buffers) part, which is probably umount, mount.

An even better test would be untar kernel, patch up a few major versions,
then try to compile.  The old heuristic would probably be OK, as there
is space in each group for files to grow, while your heuristic would
move files into groups other than their parent because there is no space.

In the end, though, while the old heuristic has a good theory, it _may_
be that in practise, you are _always_ seeking to get data from different
groups, rather than _theoretically_ seeking because of fragmented files.
I don't know what the answer is - probably depends on finding "valid"
benchmarks (cough).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

