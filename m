Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262022AbSIYQay>; Wed, 25 Sep 2002 12:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262023AbSIYQay>; Wed, 25 Sep 2002 12:30:54 -0400
Received: from pc-62-31-66-34-ed.blueyonder.co.uk ([62.31.66.34]:15748 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S262022AbSIYQaw>; Wed, 25 Sep 2002 12:30:52 -0400
Date: Wed, 25 Sep 2002 17:36:05 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Jakob Oestergaard <jakob@unthought.net>, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@zip.com.au>, Stephen Tweedie <sct@redhat.com>
Subject: Re: jbd bug(s) (?)
Message-ID: <20020925173605.A12911@redhat.com>
References: <20020924072117.GD2442@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020924072117.GD2442@unthought.net>; from jakob@unthought.net on Tue, Sep 24, 2002 at 09:21:17AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 24, 2002 at 09:21:17AM +0200, Jakob Oestergaard wrote:
 
> In Linux-2.4.19, I was wondering about the following:
> 
> In fs/jbd/commit.c:583, we find the following:
>  /* AKPM: buglet - add `i' to tmp! */
>  for (i = 0; i < jh2bh(descriptor)->b_size; i += 512) {

> As I see it, this means that jbd using filesystems (ext3) will only
> remember writing *ONE* entry from the journal.

> Isn't this a problem ?

Nah.  In fact I should just remove the loop entirely.  For commit
processing, only the header at the very, very start of a commit block
is cared about --- that way, we get atomic commits even if the commit
block is partially written out-of-order on disk.  As long as sector
writes within the fs block are atomic, the header remains intact.

> The jbd superblocks contains an index into the journal for the first
> transaction - but there is only *one* copy of the index, and there is no
> reasonable way to detect if it got written correctly to disk.
> 
> If the system loses power while updating the superblock, and only *half*
> of this index is written correctly, we have a journal which we cannot
> reach.

Again, only the data in the first sector matters there, and we assume
that disks write individual sectors atomically, or return IO failure
if things get messed up.  And the index sector is not updated all that
frequently anyway --- maybe once or twice per journal wrap, but it
doesn't have to be written for each transaction.

> Sort of removes the point of having the journal in the first place. (If
> my above assertion is true).

Actually, the number of single points of failure in a filesystem is
huge.  If we lose, say, the root directory, we're toast too (and that
can be due to an inode block or a directory block failure); similarly,
other key directories are critical, and within the journal itself, an
unreadable metadata descriptor block will rend parts of the journal
unusable for recovery.  

So if we detect incomplete sector writes, we can recover by forcing a
fsck, but if you want to be able to survive actual data loss, you need
raid.

> one can consider the two blocks and disregard the ones with invalid CRC.
> This leaves us with one or two blocks left - we then pick the one with
> the highest timestamp - and we are then guaranteed to *always* have a
> valid index.

> Wouldn't something like this be required for a journalling fs to be
> worth anything ?

No, ext3 just relies on the sector atomicity guarantees instead.
There _are_ multi-sector data structures in the journal, but those are
all protected by the sector-atomic commit block --- if we don't see
the commit sector, then we ignore all of the blocks of the prior
transaction in the log, and the commit sector is never written until
we've got a guarantee that the whole of the preceding blocks are
consistent on-disk.

Cheers, 
 Stephen
