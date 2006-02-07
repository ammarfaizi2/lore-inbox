Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964894AbWBGAe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbWBGAe0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 19:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbWBGAe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 19:34:26 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:48565 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964889AbWBGAeY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 19:34:24 -0500
Date: Tue, 7 Feb 2006 11:34:10 +1100
From: David Chinner <dgc@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: David Chinner <dgc@sgi.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Prevent large file writeback starvation
Message-ID: <20060207003410.GS43335175@melbourne.sgi.com>
References: <20060206040027.GI43335175@melbourne.sgi.com> <20060205202733.48a02dbe.akpm@osdl.org> <20060206054815.GJ43335175@melbourne.sgi.com> <20060205222215.313f30a9.akpm@osdl.org> <20060206115500.GK43335175@melbourne.sgi.com> <20060206151435.731b786c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060206151435.731b786c.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2006 at 03:14:35PM -0800, Andrew Morton wrote:
> David Chinner <dgc@sgi.com> wrote:
> >
> >     306 static void
> >     307 sync_sb_inodes(struct super_block *sb, struct writeback_control *wbc)
> >     308 {
> >     309         const unsigned long start = jiffies;    /* livelock avoidance */
> >     310
> >     311         if (!wbc->for_kupdate || list_empty(&sb->s_io))
> >     312                 list_splice_init(&sb->s_dirty, &sb->s_io);
> >     313
> >     314         while (!list_empty(&sb->s_io)) {
> > 
> > Correct me if I'm wrong, but my reading of this is that for
> > wb_kupdate, we only ever move s_dirty to s_io when s_io is empty.
> > then we iterate over s_io until all inodes are moved off this list
> > or we hit someother termination criteria. This is why i left the
> > large inode on the head of the s_io list until congestion was
> > encountered - so that wb_kupdate returned to it first in it's next
> > pass.
> > 
> > So when we get to a young inode on the s_io list, we abort the
> > writeback loop for that filesystem with wbc->nr_to_write > 0 and
> > return to wb_kupdate....
> > 
> > However, we still have an inode with lots of dirty data on the head of
> > s_dirty, which we can do nothing with until s_io is emptied by
> > wb_kupdate.
> 
> That sounds right.  I guess what is happening is that we get into the state
> where your big-dirty-file is on s_dirty and there are a few
> small-dirty-files on s_io.  sync_sb_inodes() writes the small files,
> returns "small number of pages written" and that causes wb_kupdate() to
> terminate.
> 
> I think the problem here is that the wb_kupdate() termination test is wrong
> - it should just keep going.
> 
> We have another bug due to this: if you create a large number of
> zero-length files on a traditional filesystem (ext2, minix, ...), the
> writeout of these inodes doesn't work correctly - it takes ages.  Because
> the wb_kupdate logic is driven by "number of dirty pages", and all those
> dirty inodes have zero dirty pages associated with them.  wb_kupdate says
> "oh, nothing to do" and gives up.

Ok, i can see how that would be a problem ;)

> So to fix both these problems we need to be smarter about terminating the
> wb_kupdate() loop.  Something like "loop until no expired inodes have been
> written".
> 
> Wildly untested patch:

Wildly untested assertion - it won't fix my case for the same reason I'm seeing
the current code not working - we abort higher up in writeback_inodes()
on the age check. All this will do is cause wb_kupdate to do one
furhter iteration down the stack until we hit the same young inode
on the s_io list. because its at the head, we return with expired
inodes zero, just like we current return with nr_to_write > 0.

i think we need to leave the inodes which we have more work to
do on on the s_io list. Alternatively, we add a new list off
the superblock (the s_more_io list) and work on that list
when we have nothing more to do or cannot do anything on
s_io or s_dirty.

That is:

	splice s_dirty -> s_io

	while s_io is not empty {
		if young, break
		writeback inode
			if inode needs more work, put on s_more_io
	}

	while s_more_io is not empty {
		writeback inode
			if inode needs more work, move to end of s_more_io
	}

That way instead of pdflush going idle because s_io has not been emptied
and can't be emptied until the inodes expire, it continues to work
on the expired inodes that need more work. And it will flush out
new inodes that have expired prior to working on the indoes that require
lots of work, so the large inode writeback does not starve other,
smaller inodes being written back.

This, combined with the change you just posted, should fix both
of the conditions mentioned.  Does this sound like a reasonable approach?

Cheers,

dave.
-- 
Dave Chinner
R&D Software Enginner
SGI Australian Software Group
