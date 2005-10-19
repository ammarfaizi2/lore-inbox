Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751512AbVJSAk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbVJSAk2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 20:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbVJSAk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 20:40:28 -0400
Received: from mail.suse.de ([195.135.220.2]:60081 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751512AbVJSAk1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 20:40:27 -0400
Date: Tue, 18 Oct 2005 20:40:18 -0400
From: Chris Mason <mason@suse.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix nr_unused accounting, and avoid recursing in iput with I_WILL_FREE set
Message-ID: <20051019004018.GZ1027@watt.suse.com>
References: <20051018082609.GC15717@x30.random> <20051018171335.3b308b3e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051018171335.3b308b3e.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2005 at 05:13:35PM -0700, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > Hello,
> > 
> > @@ -183,6 +183,7 @@ __sync_single_inode(struct inode *inode,
> >  			list_move(&inode->i_list, &inode_in_use);
> >  		} else {
> >  			list_move(&inode->i_list, &inode_unused);
> > +			inodes_stat.nr_unused++;
> >  		}
> >  	}
> >  	wake_up_inode(inode);
> > 
> > Are you sure the above diff is correct? It was added somewhere between
> > 2.6.5 and 2.6.8. I think it's wrong.
> > 
> > The only way I can imagine the i_count to be zero in the above path, is
> > that I_WILL_FREE is set. And if I_WILL_FREE is set, then we must not
> > increase nr_unused. So I believe the above change is buggy and it will
> > definitely overstate the number of unused inodes and it should be backed
> > out.
> 
> Well according to my assertion (below), the inode in __sync_single_inode()
> cannot have a zero refcount, so the whole if() statement is never executed.

generic_forget_inode->write_inode_now->__writeback_single_inode->
__sync_single_inode

We do have I_WILL_FREE, but i_count will be zero.

> 
> The thinking behind that increment is that __sync_single_inode() has just
> taken a dirty, zero-refcount inode and has cleaned it.  A dirty inode
> cannot have previously been on inode_unused, hence we now are newly moving
> it to inode_unused.

nr_unused doesn't seem to count the number of inodes on the unused list.
It is actually counting the number of inodes whose i_count is 0.  See
generic_forget_inode and invalidate_list to see what I mean.

generic_forget_inode took care of incrementing the unused count when
i_count went to zero. So, I don't think we need to worry about the
unused count in __writeback_single_inode.

-chris

