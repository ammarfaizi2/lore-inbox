Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265246AbTBJVfu>; Mon, 10 Feb 2003 16:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265262AbTBJVfu>; Mon, 10 Feb 2003 16:35:50 -0500
Received: from packet.digeo.com ([12.110.80.53]:27383 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265246AbTBJVfq>;
	Mon, 10 Feb 2003 16:35:46 -0500
Date: Mon, 10 Feb 2003 13:44:34 -0800
From: Andrew Morton <akpm@digeo.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: torvalds@transmeta.com, mikulas@artax.karlin.mff.cuni.cz, pavel@suse.cz,
       linux-kernel@vger.kernel.org
Subject: Re: 2.0, 2.2, 2.4, 2.5: fsync buffer race
Message-Id: <20030210134434.72a59aed.akpm@digeo.com>
In-Reply-To: <20030210211806.GA22275@dualathlon.random>
References: <Pine.LNX.4.44.0302101723540.32095-100000@artax.karlin.mff.cuni.cz>
	<Pine.LNX.4.44.0302100846090.2127-100000@home.transmeta.com>
	<20030210124000.456318e7.akpm@digeo.com>
	<20030210211806.GA22275@dualathlon.random>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Feb 2003 21:45:24.0759 (UTC) FILETIME=[B7E30270:01C2D14D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> On Mon, Feb 10, 2003 at 12:40:00PM -0800, Andrew Morton wrote:
> > 	void sync_dirty_buffer(struct buffer_head *bh)
> > 	{
> > 		lock_buffer(bh);
> > 		if (test_clear_buffer_dirty(bh)) {
> > 			get_bh(bh);
> > 			bh->b_end_io = end_buffer_io_sync;
> > 			submit_bh(WRITE, bh);
> > 		} else {
> > 			unlock_buffer(bh);
> > 		}
> > 	}
> 
> If you we don't take the lock around the mark_dirty_buffer as Linus
> suggested (to avoid serializing in the non-sync case), why don't you
> simply add lock_buffer() to ll_rw_block() as we suggested originally

That is undesirable for READA.

> and
> you #define sync_dirty_buffer as ll_rw_block+wait_on_buffer if you
> really want to make the cleanup?

Linux 2.4 tends to contain costly confusion between writeout for memory
cleansing and writeout for data integrity.

In 2.5 I have been trying to make it very clear and explicit that these are
fundamentally different things.

> ...
> Especially in 2.4 I wouldn't like to make the below change that is
> 100% equivalent to a one liner patch that just adds lock_buffer()
> instead of the test-and-set-bit (for reads I see no problems either).

That'd probably be OK, with a dont-do-that for READA.

> BTW, Linus's way that suggests the lock around the data modifications
> (unconditionally), would also enforce metadata coherency so it would
> provide an additional coherency guarantee (but it's not directly related
> to this problem and it may be overkill). Normally we always allow
> in-core modifications of the buffer during write-IO to disk (also for
> the data in pagecache). Only the journal commits must be very careful in
> avoiding that (like applications must be careful to run fsync and not to
> overwrite the data during the fsync). So normally taking the lock around
> the in-core modification and mark_buffer_dirty, would be overkill IMHO.

Yup.  Except for a non-uptodate buffer.  If software is bringing a
non-uptodate buffer uptodate by hand it should generally be locked, else a
concurrent read may stomp on the changes.  There are few places where this
happens.

