Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267545AbRHBR2L>; Thu, 2 Aug 2001 13:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267782AbRHBR2D>; Thu, 2 Aug 2001 13:28:03 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:56059 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S267545AbRHBR1y>; Thu, 2 Aug 2001 13:27:54 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200108021726.f72HQrMh027270@webber.adilger.int>
Subject: Re: [PATCH]: reiserfs: D-clear-i_blocks.patch
In-Reply-To: <15209.30134.699801.417492@beta.namesys.com> "from Nikita Danilov
 at Aug 2, 2001 07:45:58 pm"
To: Nikita Danilov <NikitaDanilov@yahoo.com>
Date: Thu, 2 Aug 2001 11:26:52 -0600 (MDT)
CC: Linus Torvalds <Torvalds@transmeta.com>,
        Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
        linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita writes:
> This patch sets inode.i_blocks to zero on deletion of reiserfs
> file. This in particular cures hard to believe bug when saving file in
> EMACS caused top to loose sight of all processes:
>  . reiserfs didn't properly cleared i_blocks when removing
>    symlinks. Actually -7 was inserted into unsigned i_blocks field. This
>    didn't usually hurt because file is being deleted;
>  . inode is reused for procfs and neither get_new_inode() nor
>    proc_read_inode() cleared i_blocks;
>  . now procfs inode has huge i_blocks field;
>  . top calls stat on it and libc wrapper returns EOVERFLOW, as i_blocks
>    doesn't fit into user-level struct.
>  . top sees nothing.

I wonder if you don't have a different problem hiding in there somewhere.
I was thinking that if a non-zero i_blocks field was causing problems for
reiserfs, maybe clear_inode() should zero this out for everyone.

Looking through the reiserfs code (which is rather hard to follow), I see
that reiserfs_cut_from_item() and prepare_for_delete_or_cut() are changing
i_blocks, and this is (eventually) called from reiserfs_delete_item() and
reiserfs_delete_object().  Not that I can point to any specific code, but
to me it would seem that you are not counting i_blocks correctly somewhere,
and eventually decrement i_blocks too much (hence -7 in i_blocks).

So this makes me believe that setting i_blocks=0 is just hiding a block
leak somewhere in the reiserfs code, or math errors somewhere.

It is also true that clear_inode() or get_new_inode() (or proc_read_inode())
should initialize all of the used fields to zero so that a problem in one
filesystem can't cause problems elsewhere.  It appears that i_blocks is
set to zero by ext2_new_inode(), so probably proc_read_inode() should do
the same (since it uses i_blocks).

Cheers, Andreas

PS - could someone on the reiserfs team (or Linus) run the reiserfs code
     through "indent" (or auto format in emacs) per Documentation/CodingStyle?
     It is really a gross mess, to such a point that you can hardly see what
     is going on.  It's not just that it is a different indent style, it has
     no coherent indentation or comment formatting at all.  Maybe for 2.5?
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

