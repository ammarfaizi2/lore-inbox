Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751028AbWBFGWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbWBFGWl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 01:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbWBFGWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 01:22:41 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20953 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751027AbWBFGWk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 01:22:40 -0500
Date: Sun, 5 Feb 2006 22:22:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Chinner <dgc@sgi.com>
Cc: dgc@sgi.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Prevent large file writeback starvation
Message-Id: <20060205222215.313f30a9.akpm@osdl.org>
In-Reply-To: <20060206054815.GJ43335175@melbourne.sgi.com>
References: <20060206040027.GI43335175@melbourne.sgi.com>
	<20060205202733.48a02dbe.akpm@osdl.org>
	<20060206054815.GJ43335175@melbourne.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Chinner <dgc@sgi.com> wrote:
>
> > >From a quick peek, this code:
> > 
> > 			if (wbc->for_kupdate) {
> > 				/*
> > 				 * For the kupdate function we leave the inode
> > 				 * at the head of sb_dirty so it will get more
> > 				 * writeout as soon as the queue becomes
> > 				 * uncongested.
> > 				 */
> > 				inode->i_state |= I_DIRTY_PAGES;
> > 				list_move_tail(&inode->i_list, &sb->s_dirty);
> > 
> > 
> > isn't working right any more.
> 
> If the intent is to continue writing it back until fully
> sync'd, then shouldn't we be moving that to the tail of I/O list so
> we don't have to iterate over the dirty list again before we try to
> write another chunk out?

Only if dirtied_when has expired.  Until that's true I think it's right to
move onto other (potentially expired) inodes.

Your patch leaves these inodes on s_io, actually.

> > > 
> > > It appears that it is intended to handle congested devices. The thing
> > > is, 1024 pages on writeback is not enough to congest a single disk,
> > > let alone a RAID box 10 or 100 times faster than a single disk.
> > > Hence we're stopping writeback long before we congest the device.
> > 
> > I think the comment is misleading.  The writeout pass can terminate because
> > wbc->nr_to_write was satisfied, as well as for queue congestion.
> 
> Exactly my point and what the patch addresses - it allows writeback on
> that inode to continue from where it left off if the device was not
> congested.

But what will it do to other inodes?  Say, ones which have expired?  This
inode could take many minutes to write out if it's all fragmented.

s_dirty is supposed to be kept in dirtied_when order, btw.

> > I suspect what's happened here is that someone other than pdflush has tried
> > to do some writeback and didn't set for_kupdate, so we ended up resetting
> > dirtied_when.
> 
> If it's not wb_kupdate that is trying to write it back, and we have little
> memory pressure, and we completed writing the file long ago, then what behaves
> exactly like wb_kupdate for hours on end apart from wb_kupdate?

Don't know.   I'm not sure that we exactly know what's going on yet?

The list_move_tail is supposed to put the inode at the *head* of s_dirty. 
So it's the first one which gets encountered on the next pdflush pass.

And I guess that's working OK.  Except we only write 4MB of it each five
seconds.  Is that the case?

If so, why would that happen?  Take a look at wb_kupdate().  It's supposed
to work *continuously* on the inodes until writeback_inodes() failed to
write back enough pages.  It takes this as an indication that there's no
more work to do at this time.

It'd be interesting to take a look at what's happening in wb_kupdate().

> > > Therefore, lets only move the inode back onto the dirty list if the device
> > > really is congested. Patch against 2.6.15-rc2 below.
> > 
> > This'll break something else, I bet :(
> 
> Wonderful. What needs testing to indicate something else hasn't broken?

Hard.

> Does anyone have any regression tests for this code?

No.



