Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030324AbWFIRob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030324AbWFIRob (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 13:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030328AbWFIRoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 13:44:30 -0400
Received: from thunk.org ([69.25.196.29]:49352 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1030324AbWFIRo3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 13:44:29 -0400
Date: Fri, 9 Jun 2006 13:44:05 -0400
From: Theodore Tso <tytso@mit.edu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alex Tomas <alex@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jeff@garzik.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060609174405.GA10524@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Linus Torvalds <torvalds@osdl.org>, Alex Tomas <alex@clusterfs.com>,
	Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
	ext2-devel <ext2-devel@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org, cmm@us.ibm.com,
	linux-fsdevel@vger.kernel.org,
	Andreas Dilger <adilger@clusterfs.com>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com> <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int> <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org> <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <m33beecntr.fsf@bzzz.home.net> <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org> <Pine.LNX.4.64.0606090933130.5498@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606090933130.5498@g5.osdl.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2006 at 09:54:49AM -0700, Linus Torvalds wrote:
> 
> 
> On Fri, 9 Jun 2006, Linus Torvalds wrote:
> > 
> > Just as an example: ext3 _sucks_ in many ways. It has huge inodes that 
> > take up way too much space in memory.
> 
> Btw, I'm not kidding you on this one.
> 
> THE NUMBER ONE MEMORY USAGE ON A LOT OF LOADS IS EXT3 INODES IN MEMORY!

To be fair, the bulk of the size of the size of the inode is is the
filesystem generic "struct inode", which is 480 bytes.  Ext3 just
includes the struct inode as part of its core data structure, which
makes the whole thing *look* big.  In fact, the ext3-specific part of
the in-core ext3 inode is only 188 bytes, for a total of 688 bytes for
the ext3_inode_info structure --- which is what you see in
/proc/slabinfo.   

Other filesystems store the struct inode via a pointer to a separately
allocated chunk of memory, which makes their in-core inode footprint
*look* smaller but that's just an illusion if the only place you look
is /proc/slabinfo.  For example, the xfs_inode_cache is 432 bytes, but
that's because struct inode is stored separately from xfs's
fake/pseudo "vfs inode" which it keeps around so the same code can be
used with Irix.  (It always amazes me that we allow this for XFS,
where when everywhere else we insist that that kind of cross-OS or
cross-version portability code is a fundamental violation of
CodingStyle which by increasing code bloat and making the code harder
to read and maintain by Linux developers, but that's a rant for
another day.)

Now, obviously I won't say that we can't do work to trim down
ext3_inode_info.  To be fair, reiserfs has an inode which is 576 bytes
long, so they only have 96 bytes of filesystem-specific information,
instead of the 188 bytes that we have in ext3.  So we can do look at
that, but remember that from the gross level, we're talking about 688
bytes per inode for ext3 compared to 576 bytes per inode for reiserfs
--- and at least 912 bytes per inode for xfs.

But I think you would agree that we would want to improve this number
"honestly", by trying to trim down actual memory structure use,
instead of just simply making the in-core data structure bushier so as
to hide the true size of the per-inode footprint from people looking
at /proc/slabinfo, right?  :-)


And in any case, this is why we have to think very carefully before
forking the codebase between ext3 and "ext4".  The work that we might
use to slim down ext4_inode_info would also have to be backported to
ext3_inode_info before ext3 users see the benefit.  And there may also
be bugs that now have to be fixed in _three_ separate codebases ---
ext2, ext3, and ext4.  To give another concrete example, adding
extents won't change the htree directory lookup code, so needlessly
having two copies of that htree code in the kernel would be a Bad
Idea(tm).  We've already on occasion found bugs that we had fixed in
ext3, but had forgotten to backport to ext2, and vice versa.  Adding a
third would triple our maintenance headache --- a similar reason why
we haven't started a 2.7 development tree yet, since we would have to
backport bug fixes back and forth between 2.6 and 2.7.

Not to say that forking ext3 to make a copy of the code that we call
"ext4" isn't automatically a bad idea to be dismissed out of hand,
just as someday that we might fork 2.6 and start a 2.7 development
branch.  But in both cases we need to think very hard about the
tradeoffs before we just go ahead and do it.

Regards,

						- Ted
