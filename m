Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278614AbRJXPuX>; Wed, 24 Oct 2001 11:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278609AbRJXPuP>; Wed, 24 Oct 2001 11:50:15 -0400
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:45447 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S278605AbRJXPuH>; Wed, 24 Oct 2001 11:50:07 -0400
Date: Wed, 24 Oct 2001 16:50:34 +0100 (BST)
From: James Sutherland <jas88@cam.ac.uk>
X-X-Sender: <jas88@yellow.csi.cam.ac.uk>
To: Jan Kara <jack@suse.cz>
cc: Neil Brown <neilb@cse.unsw.edu.au>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: RFC - tree quotas for Linux (2.4.12, ext2)
In-Reply-To: <20011024173930.A19777@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.SOL.4.33.0110241646420.24809-100000@yellow.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Oct 2001, Jan Kara wrote:
> > On Wed, 24 Oct 2001, Jan Kara wrote:
> >
> > >   But how do you solve the following: mv <dir> <some_other_dir>
> > > The parent changes. You need to go through all the subdirs of <dir> and change
> > > the TID. This is really hard to get right and to avoid deadlocks
> > > and races... At least it seems to me so.
> >
> > Provided you are tracking the total size in each directory, it's just a
> > matter of subtracting dir's size from the old parent, and adding it to the
> > new parent. (With suitable checks beforehand to avoid a result which
> > exceeds quota.)
>   Nope. If you'd just keep usage in directory than you need to go all the way
> up and decrease the usage and then go all the way down in the new directory.
> It's simplier but also nontrivial...

Yep, you're right: you'd need to ascend the target directory tree,
increasing the cumulative size all the way up, then do the move and
decrement the old location's totals in the same way. All wrapped up in a
transaction (on journalled FSs) or have fsck rebuild the totals on a dirty
mount. Fairly clean and painless on a JFS, but a bit of a mess on
others - still, quite workable, and the performance hit shouldn't be too
bad. Better than walking all the way DOWN the tree, anyway...


James.

