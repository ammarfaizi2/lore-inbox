Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262789AbTBJQTO>; Mon, 10 Feb 2003 11:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264940AbTBJQTO>; Mon, 10 Feb 2003 11:19:14 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:27550 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262789AbTBJQTM>; Mon, 10 Feb 2003 11:19:12 -0500
Date: Mon, 10 Feb 2003 17:28:55 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: torvalds@transmeta.com
Cc: Andrea Arcangeli <andrea@suse.de>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@digeo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.0, 2.2, 2.4, 2.5: fsync buffer race
In-Reply-To: <20030210130704.GO31401@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0302101723540.32095-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, do you remember what "nasty deadlock" did you mean when writing
this to 2.[0-2].* and maybe 1.*?

ll_rw_blk.c - ll_rw_block():
        /* Uhhuh.. Nasty dead-lock possible here.. */
        if (buffer_locked(bh))
                return;
        /* Maybe the above fixes it, and maybe it doesn't boot. Life is
interesting */
        lock_buffer(bh);

Mikulas

On Mon, 10 Feb 2003, Andrea Arcangeli wrote:

> On Wed, Feb 05, 2003 at 12:16:53AM +0100, Pavel Machek wrote:
> > Hi!
> >
> > > > there's a race condition in filesystem
> > > >
> > > > let's have a two inodes that are placed in the same buffer.
> > > >
> > > > call fsync on inode 1
> > > > it goes down to ext2_update_inode [update == 1]
> > > > it calls ll_rw_block at the end
> > > > ll_rw_block starts to write buffer
> > > > ext2_update_inode waits on buffer
> > > >
> > > > while the buffer is writing, another process calls fsync on inode 2
> > > > it goes again to ext2_update_inode
> > > > it calls ll_rw_block
> > > > ll_rw_block sees buffer locked and exits immediatelly
> > > > ext2_update_inode waits for buffer
> > > > the first write finished, ext2_update_inode exits and changes made by
> > > > second proces to inode 2 ARE NOT WRITTEN TO DISK.
> > > >
> > >
> > > hmm, yes.  This is a general weakness in the ll_rw_block() interface.  It is
> > > not suitable for data-integrity writeouts, as you've pointed out.
> > >
> > > A suitable fix would be do create a new
> > >
> > > void wait_and_rw_block(...)
> > > {
> > > 	wait_on_buffer(bh);
> > > 	ll_rw_block(...);
> > > }
> > >
> > > and go use that in all the appropriate places.
> > >
> > > I shall make that change for 2.5, thanks.
> >
> > Should this be fixed at least in 2.4, too? It seems pretty serious for
> > mail servers (etc)...
>
> actually the lowlevel currently is supposed to take care of that if it
> writes directly with ll_rw_block like fsync_buffers_list takes care of
> it before calling ll_rw_block. But the whole point is that normally the
> write_inode path only marks the buffer dirty, it never writes directly,
> and no dirty bitflag can be lost and we flush those dirty buffers right
> with the proper wait_on_buffer before ll_rw_block. So I don't think it's
> happening really in 2.4, at least w/o mounting the fs with -osync.
>
> But I thought about about Mikulas suggestion of adding lock_buffer
> in place of the test and set bit. This looks very appealing. the main
> reason we didn't do that while fixing fsync_buffers_list a few months
> ago in 2.4.20 or so, is been that it is a very risky change, I mean, I'm
> feeling like it'll break something subtle.
>
> In theory the only thing those bitflags controls are the coherency of
> the buffer cache here, the rest is serialized by design at the
> highlevel. And the buffer_cache should be ok with the lock_buffer(),
> since we'll see the buffer update and we'll skip the write if we race
> with other reads (we'll sleep in lock_buffer rather than in
> wait_on_buffer). For the writes we'll overwrite the data one more time
> (the feature incidentally ;).  so it sounds safe.  Performance wise it
> shouldn't matter, for read it can't matter infact.
>
> So I guess it's ok to make that change, then we could even move the
> wait_on_buffer from fsync_buffers_list to the xfs buffer_delay path of
> write_buffer. I'm tempted to make this change for next -aa. I feel it
> makes more sense and it's a better fix even if if risky. Can anybody see
> a problem with that?
>
> Andrea
>


