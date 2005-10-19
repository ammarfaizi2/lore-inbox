Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbVJSC6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbVJSC6K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 22:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbVJSC6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 22:58:10 -0400
Received: from mx1.suse.de ([195.135.220.2]:37563 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932431AbVJSC6I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 22:58:08 -0400
Date: Tue, 18 Oct 2005 22:58:05 -0400
From: Chris Mason <mason@suse.com>
To: Andrew Morton <akpm@osdl.org>
Cc: andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix nr_unused accounting, and avoid recursing in iput with I_WILL_FREE set
Message-ID: <20051019025805.GD1027@watt.suse.com>
References: <20051018082609.GC15717@x30.random> <20051018171335.3b308b3e.akpm@osdl.org> <20051019004018.GZ1027@watt.suse.com> <20051018181548.760dbf8c.akpm@osdl.org> <20051019015840.GC1027@watt.suse.com> <20051018192646.2ddcbf57.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051018192646.2ddcbf57.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2005 at 07:26:46PM -0700, Andrew Morton wrote:
> > > hm, OK.  It'd be nice to make that more explicit.  Something like this?
> > 
> > Well, I can't quite convince myself it is wrong, but when 
> > (!sb || (sb->s_flags & MS_ACTIVE), we're dropping the
> > inode_lock with an inode with i_count == 0 and nr_unused hasn't been
> > incremented.
> > 
> > So, if someone (sync_sb_inodes?) comes in and runs __iget,
> > the counts end up wrong.  Then again, whoever ran __iget would also run
> > iput and things would go horribly wrong anyway.
> 
> Nope, it's equivalent:

The math ends up the same, but for your version there is a window where
the lock isn't held and the count doesn't reflect reality.  I don't know
if anyone can race in and mess with the inode though.  It is still on
various lists, but if we're only in that part of generic_forget_inode
during unmount, the super semaphore will keep out most potential racers.

I need to read harder.

> > Did I mention the part where Andrea and I are hunting a bug where the
> > count of unused inodes goes negative and the everyone ends up spinning
> > in shrink_icache_memory?
> 
> No.
> 
> >  Andrea's patch doesn't fix the spinning, but
> > it might have fixed the unused inode count going negative.  We're
> > waiting for another reproduce on the ppc64 race monster.
> 
> I assume you have BUG_ON(inode_stat.nr_unused < 0)s in there everywhere?
> 
> In fact WARN_ON(inode_stat.nr_unused < 100) might be better - something's
> obviously doing a bogus decrement a lot of times.
> 

It goes negative in the invalidate_inodes run during unmount.  I
think Andrea's patch will solve that part, hopefully we'll know more
tomorrow.

-chris

