Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750938AbWBBMGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbWBBMGa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 07:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbWBBMG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 07:06:29 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:46725 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1750938AbWBBMG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 07:06:29 -0500
Date: Thu, 2 Feb 2006 13:06:28 +0100
From: Jan Kara <jack@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: mjt@tls.msk.ru, linux-kernel@vger.kernel.org
Subject: Re: Another Assertion failure in journal_start()
Message-ID: <20060202120628.GC18075@atrey.karlin.mff.cuni.cz>
References: <43DF445F.6060704@tls.msk.ru> <20060201185247.GK6547@atrey.karlin.mff.cuni.cz> <20060202000705.481421b6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060202000705.481421b6.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Jan Kara <jack@suse.cz> wrote:
> >
> >  > Just hit our main server, while doing kernel compile
> >  > (producing a .deb using custom script which does quite
> >  > some usage of symlinks - hence sys_symlink() operation
> >  > is in call trace) -- that particular filesystem stopped
> >  > working, while the rest of the system was still operational.
> >  > 
> >  > It's 2.6.15.1 kernel running on an athlon-1.3GHz, pretty
> >  > old but pretty stable box, with ECC memory.  The filesystem
> >  > in question is on top of a raid0 array out of 4 scsi drives
> >  > (it's used as a "staging area" for various temporary stuff,
> >  > incl. compiles and whatnot).
> >  > 
> >  > Any clues about this one?
> >  > 
> >  > Note it's the first time I encountered an error like this
> >  > one, but I did quite alot of kernel compiles on this box
> >  > already since last boot (I'm experimenting with Xen on
> >  > another box, this box is used as a "compiling server").
> >  > So I can hardly say the problem is "easily reproduceable".
> >    The trace you provided is good enough so that I don't need to
> >  reproduce the problem :). The bug is in ext3 - the problem is that we
> >  start a transaction and then do something that needs to allocate memory
> >  but we don't set GFP_NOFS. As we are low on memory we try to shrink
> >  caches and remove some inode on different filesystem from memory. We
> >  recurse back into the fs code which finds out we have already started
> >  transaction on different fs and BUGs.
> >    The right solution probably is to pass gfp flags to page_symlink().
> >  I'll write a patch.
> 
> That'd be the safest approach.  It'd be nicer to close off the transaction
> while running page_symlink(), although we'd need to think hard about the
> atomicity implications of that.
  Yes, I also thought about this but the atomicity is a problem here - we
have to create inode before calling page_symlink() and we cannot afford
to stop the transaction before calling page_symlink() as it attaches
some blocks to the inode... OK, we could play some tricks with attaching
the inode to the orphan list but I'm not sure it's worth the complexity.
I'll check whether it would really work.

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
