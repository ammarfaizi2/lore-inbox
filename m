Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751407AbVJYCVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbVJYCVY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 22:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbVJYCVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 22:21:24 -0400
Received: from cantor.suse.de ([195.135.220.2]:22430 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751407AbVJYCVX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 22:21:23 -0400
Date: Mon, 24 Oct 2005 22:21:02 -0400
From: Chris Mason <mason@suse.com>
To: Andrew Morton <akpm@osdl.org>
Cc: andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix nr_unused accounting, and avoid recursing in iput with I_WILL_FREE set
Message-ID: <20051025022102.GC5099@watt.suse.com>
References: <20051018082609.GC15717@x30.random> <20051018171335.3b308b3e.akpm@osdl.org> <20051019004018.GZ1027@watt.suse.com> <20051018181548.760dbf8c.akpm@osdl.org> <20051019015840.GC1027@watt.suse.com> <20051018192646.2ddcbf57.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051018192646.2ddcbf57.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2005 at 07:26:46PM -0700, Andrew Morton wrote:
> Chris Mason <mason@suse.com> wrote:
> >
> > On Tue, Oct 18, 2005 at 06:15:48PM -0700, Andrew Morton wrote:
> > > > > Well according to my assertion (below), the inode in __sync_single_inode()
> > > > > cannot have a zero refcount, so the whole if() statement is never executed.
> > > > 
> > > > generic_forget_inode->write_inode_now->__writeback_single_inode->
> > > > __sync_single_inode
> > > 
> > > oshit.
> > 
> > When does this ever happen?  Just for private inodes released during
> > put_super right?
> 
> I suppose so, yes.

It's not related to the bug, but prune_icache can jump in at any
time during generic_shutdown_super, except during the invalidate_inodes
runs.  Something like this:

proc1				proc2
generic_shutdown_super
s->s_flags &= ~MS_ACTIVE
invalidate_inodes
put_super
				shrink_icache_memory
				prune_icache
				invalidate_inode_pages
				try_to_release_page
				
I doubt any FS triggers this.  They would need to generate inodes
with pages during the put_super call, and get them onto the unused list.
But, I think prune_icache should just skip any inodes where the super
doesn't have MS_ACTIVE set.

At any rate, this wasn't the race I was looking for.  Aside from the
bugs fixed by Andrea's patch, we were seeing inodes go negative thanks
to a bad interaction between a latency fix and a backport of something
else from mainline.   Our latency code has a goto again, and mainline
has a big fat comment explaining why goto again isn't needed.  

If the super->s_inodes list was long enough to reschedule in invalidate_list,
we would process the same inodes in multiple times without removing them.

The short version is that no additional patches should be needed for
mainline.

-chris

