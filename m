Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbWDUMav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbWDUMav (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 08:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbWDUMav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 08:30:51 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:59087 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932179AbWDUMau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 08:30:50 -0400
Date: Fri, 21 Apr 2006 14:30:49 +0200
From: Jan Kara <jack@suse.cz>
To: Belan Kumar <belkumar@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: VFS && UFS write support: possible on *BSD/Solaris, impossible on Linux?
Message-ID: <20060421123049.GE3154@atrey.karlin.mff.cuni.cz>
References: <84a104fc0604190222k49e4ebbcn7b807743afcd9fc3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84a104fc0604190222k49e4ebbcn7b807743afcd9fc3@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> May be better call subject something like: "Shortest way to ufs write support",
> but current subject give more chances to recieve answer.
> 
> First of all I try explain the current problem:
> UFS as other block file systems has notition of "block",
> but further to "block" notion it has "fragment" concept.
> "fragment" used for preventing waste of space.
> Usually fragment==block/8, and if "the rest of file" doesn't occupy
> the whole block, it occupy several fragments. If file grows, at some point
> "the rest of file"  will be occupy 8 fragments. And HERE IS PROBLEM,
> we should allocate block and move 8 fragments to it.
> 
> On *BSD/Solaris it is simple: they read analog of buffer_head and
> change analog of b_blocknr and that's all.
> 
> The current code of fs/ufs/balloc.c does the same:
> ----------------------
> sb_bread
> bh->b_blocknr =
> mark_buffer_dirty (bh)
> brelse (bh)
> --------------------------
> I suppose you guess: it doesn't work,
> latter when you do sb_getblk(old_blocknr) it give to us the same block
> and after that kernel hang up.
> 
> 
> Hence question: what would be the proper solution in this situation?
> Is it possible in current VFS change b_blocknr?
  I guess it is possible but certainly it's not that easy as just
changing b_blocknr. Each buffer head is attached to a page (either to a
page of a backing device mapping or to a page belonging to the inode
mapping). And if you look at e.g. __find_get_block_slow() you'll see
that we look for the buffer using that page. So you definitely need to
somehow attach the buffer to the new page at the correct location.

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
