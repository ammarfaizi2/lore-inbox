Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269015AbRHBScW>; Thu, 2 Aug 2001 14:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266808AbRHBScM>; Thu, 2 Aug 2001 14:32:12 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:24327 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S268468AbRHBScE>; Thu, 2 Aug 2001 14:32:04 -0400
From: Nikita Danilov <NikitaDanilov@Yahoo.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15209.40051.124575.787738@beta.namesys.com>
Date: Thu, 2 Aug 2001 22:31:15 +0400
To: Andreas Dilger <adilger@turbolinux.com>,
        Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <Torvalds@transmeta.com>,
        Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-dev] Re: [PATCH]: reiserfs: D-clear-i_blocks.patch
In-Reply-To: <200108021726.f72HQrMh027270@webber.adilger.int>
In-Reply-To: <15209.30134.699801.417492@beta.namesys.com>
	<200108021726.f72HQrMh027270@webber.adilger.int>
X-Mailer: VM 6.89 under 21.1 (patch 8) "Bryce Canyon" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger writes:
 > Nikita writes:
 > > This patch sets inode.i_blocks to zero on deletion of reiserfs
 > > file. This in particular cures hard to believe bug when saving file in
 > > EMACS caused top to loose sight of all processes:
 > >  . reiserfs didn't properly cleared i_blocks when removing
 > >    symlinks. Actually -7 was inserted into unsigned i_blocks field. This
 > >    didn't usually hurt because file is being deleted;
 > >  . inode is reused for procfs and neither get_new_inode() nor
 > >    proc_read_inode() cleared i_blocks;
 > >  . now procfs inode has huge i_blocks field;
 > >  . top calls stat on it and libc wrapper returns EOVERFLOW, as i_blocks
 > >    doesn't fit into user-level struct.
 > >  . top sees nothing.
 > 
 > I wonder if you don't have a different problem hiding in there somewhere.
 > I was thinking that if a non-zero i_blocks field was causing problems for
 > reiserfs, maybe clear_inode() should zero this out for everyone.
 > 
 > Looking through the reiserfs code (which is rather hard to follow), I see
 > that reiserfs_cut_from_item() and prepare_for_delete_or_cut() are changing
 > i_blocks, and this is (eventually) called from reiserfs_delete_item() and
 > reiserfs_delete_object().  Not that I can point to any specific code, but
 > to me it would seem that you are not counting i_blocks correctly somewhere,
 > and eventually decrement i_blocks too much (hence -7 in i_blocks).

The code path in which symlink gets i_blocks == -7 is precisely known and
only occurs when its being deleted, so it's not a problem.

 > 
 > So this makes me believe that setting i_blocks=0 is just hiding a block
 > leak somewhere in the reiserfs code, or math errors somewhere.
 > 
 > It is also true that clear_inode() or get_new_inode() (or proc_read_inode())
 > should initialize all of the used fields to zero so that a problem in one
 > filesystem can't cause problems elsewhere.  It appears that i_blocks is

Yes, I agree with you and Alexander on this. We just wanted this glaring
bug to fixed immediately and so sent out as small patch as possible.

 > set to zero by ext2_new_inode(), so probably proc_read_inode() should do
 > the same (since it uses i_blocks).
 > 
 > Cheers, Andreas
 > 
 > PS - could someone on the reiserfs team (or Linus) run the reiserfs code
 >      through "indent" (or auto format in emacs) per Documentation/CodingStyle?
 >      It is really a gross mess, to such a point that you can hardly see what

Oh, yes.

 >      is going on.  It's not just that it is a different indent style, it has
 >      no coherent indentation or comment formatting at all.  Maybe for 2.5?

I hope so. We already have 200k of cleanup patches in 2.4.7-ac3.

 > -- 
 > Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
 >                  \  would they cancel out, leaving him still hungry?"
 > http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

Nikita.
