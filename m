Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266215AbSKFXXx>; Wed, 6 Nov 2002 18:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266216AbSKFXXx>; Wed, 6 Nov 2002 18:23:53 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:62964 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S266215AbSKFXXv>; Wed, 6 Nov 2002 18:23:51 -0500
From: Andreas Dilger <adilger@clusterfs.com>
Date: Wed, 6 Nov 2002 16:27:57 -0700
To: Christopher Li <chrisl@vmware.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Jeremy Fitzhardinge <jeremy@goop.org>,
       Ext2 devel <ext2-devel@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [Ext2-devel] Re: [PATCH] Fix bug in ext3 htree rename: doesn't delete old name, leaves ino with bad nlink
Message-ID: <20021106232757.GT588@clusterfs.com>
Mail-Followup-To: Christopher Li <chrisl@vmware.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Jeremy Fitzhardinge <jeremy@goop.org>,
	Ext2 devel <ext2-devel@lists.sourceforge.net>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <1036471670.21855.15.camel@ixodes.goop.org> <20021105212415.GB1472@vmware.com> <20021106082500.GA3680@vmware.com> <20021106214027.GA9711@think.thunk.org> <20021106172455.A7778@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021106172455.A7778@vmware.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 06, 2002  17:24 -0800, Christopher Li wrote:
> On Wed, Nov 06, 2002 at 04:40:27PM -0500, Theodore Ts'o wrote:
> > On Wed, Nov 06, 2002 at 12:25:00AM -0800, chrisl@vmware.com wrote:
> > > This should fix the ext3 htree rename problem. Please try it again.
> > 
> > I've looked over the patch, and I've got some comments....
> > 
> > >      handle = ext3_journal_start(old_dir, 2 * EXT3_DATA_TRANS_BLOCKS +
> > > -                                    EXT3_INDEX_EXTRA_TRANS_BLOCKS + 2);
> > > +                                    EXT3_INDEX_EXTRA_TRANS_BLOCKS + 3);
> > 
> > There's no need to increase the number of blocks that might need to be
> > dirtied; if ext3_delete_entry() can't find the missing entry, it won't
> > dirty the block, so the number of blocks that might need to modified
> > remains constant.
> 
> Even for the same block dirty twice? I am not sure about that case
> so I put it there. I got a lots of thing to do tonight.

Ted is correct on this one - if we hit this bug because both the source
and target names were in the same block before the split, then after the
split we will still need to dirty only 2 blocks because of the rename
(the split blocks are accounted for in EXT3_INDEX_EXTRA_TRANS_BLOCKS).

> > Simply retrying the ext3_delete_entry() isn't sufficient, since
> > another ext3_add_entry() could move the directory entry again while
> > you're reading in the blocks as part of ext3_find_entry().  OK, that
> > would be pretty rare, since enough other directory adds would have
> > to fill up enough that another split could happen, but *is* possible.
> > (Surely our scheduler isn't that unfair....)
> 
> I think we have the lock on ext3_rename. I might be wrong.
> If other process can change the dir between the add new entry
> and delete old entry. We should also need to check the entry have
> been delete from other process in case fall into dead loop? 

Chris is right on this one.  Like Al said, the VFS holds i_sem on
"both" directories (or the single directory if src_dir & tgt_dir are
the same).  We don't need additional locking within ext3...(yet)

<aside>
For _real_ scaling of large directories, it would be good to allow
locking just individual leaf blocks of the directories instead of the
entire directory.  Since the source and target directory leaf blocks
are the only possible locations for those filenames, we do not have
any races w.r.t. other threads adding/deleting files of the same name
if we lock those directory blocks.

We will probably need to do this in the next year or so for Lustre where
we have a requirement for millions of files being created/renamed/deleted
in the same directory by thousands of clients, and tens of metadata
servers load-balancing those requests.
</aside>

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

