Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289097AbSAGDQm>; Sun, 6 Jan 2002 22:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289098AbSAGDQc>; Sun, 6 Jan 2002 22:16:32 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:52058 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S289097AbSAGDQT>; Sun, 6 Jan 2002 22:16:19 -0500
Date: Mon, 7 Jan 2002 04:16:36 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Alexander Viro <viro@math.psu.edu>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] truncate fixes
Message-ID: <20020107041636.I1561@athlon.random>
In-Reply-To: <3C36DEA9.AEA2A402@zip.com.au>, <3C36DEA9.AEA2A402@zip.com.au>; <20020107034654.G1561@athlon.random> <3C390DAA.3339768C@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3C390DAA.3339768C@zip.com.au>; from akpm@zip.com.au on Sun, Jan 06, 2002 at 06:53:30PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 06, 2002 at 06:53:30PM -0800, Andrew Morton wrote:
> Andrea Arcangeli wrote:
> > 
> > I prefer my fix that simply recalls the ->truncate callback if -ENOSPC
> > is returned by prepare_write. vmtruncate seems way overkill,
> 
> No opinion on that here.  This is what was in -ac.  Perhaps Al can
> comment?
> 
> > and after
> > calling ->truncate the __block_prepare_changes above won't be necessary
> > because the leftover will be correctly deallocated (no need to clear
> > them out and to mark them dirty, they will just go away before any
> > readpage can see them).
> 
> No, this code is needed if the write is _inside_ i_size, to an
> uninstantiated block.  truncate won't remove those blocks, and we've
> gone and added them to the file.

I see, I got mistaken because here we're not in a i_sem-less writepage, so
in those cases I wanted to always deallocate the blocks rather than
lefting zeroed leftovers. if the leftover blocks are over i_size (common
case I was thinking about incidentally :) that's automatica with
->truncate, but if they aren't over i_size that's not enough and we miss
a lowlevel API to decallocate a range of blocks, so your patch is the
only way indeed.

> 
> -


Andrea
