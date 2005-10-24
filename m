Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbVJXV23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbVJXV23 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 17:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbVJXV23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 17:28:29 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:16264 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751305AbVJXV22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 17:28:28 -0400
Date: Mon, 24 Oct 2005 17:28:28 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jens Axboe <axboe@suse.de>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: BUG in the block layer (partial reads not reported)
In-Reply-To: <1130005390.15961.32.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44L0.0510241712050.4448-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Oct 2005, Alan Cox wrote:

> On Sad, 2005-10-22 at 11:40 -0400, Alan Stern wrote:
> > 	Handling an error somewhere in the middle of the medium, and
> > 
> > 	Handling an error beyond the real end of the medium.
> > 
> > The mm and block subsystems have no way at all to retrieve partial data
> > for the first case.  Even though only one hardware sector may be bad,
> 
> The block layer can handle this at the bottom level but the caches above
> it cannot. 

The problem is apparent when one reads end_buffer_async_read() in
fs/buffer.c.  If any of the buffer_heads in a page gets an error, the 
entire page is marked with SetPageError.

> > failure to read an entire page means that none of the good sectors on that
> > page will be accessible.  While annoying, it's understandable and I don't 
> > see any simple way to accomodate such partial reads.
> 
> Agreed it is hairy with things like mmap. One way is to use raw I/O and
> disable readahead.
> 
> > The second case appears to be more tractable, as you said.  In fact,
> > do_generic_mapping_read() in mm/filemap.c will recheck the inode's size
> > after a successful read, to avoid copying data beyond the end of the
> > device.
> > 
> > Could part of the problem also be that the set_capacity() call, used to
> > revise the device size downward when the CD driver realizes it is smaller
> > than originally thought, doesn't update the inode?  Should the driver call
> > bd_set_size() as well?  (In addition to completing the read successfully
> > with garbage data beyond the actual EOF.)
> 
> Beats me. Perhaps Jens can enlighten us and I can improve the ide-cd
> driver code further as well.

It turns out I was looking in the wrong place.  do_generic_mapping_read() 
merely initiates the I/O; the completion happens somewhere else.

Shrinking the inode size probably is not a good idea.  There may already 
be pages mapped to sectors beyond the true end of the device.  We can't 
just leave them hanging out to dry.  (But what happens when a media eject 
is detected while the device file is open -- how is that handled?)

At the moment I can think of just two possibilities:

    (1) We can continue to do what the SCSI CD driver does now.  Reads
	near the end of the medium might fail.  When the device is closed
	and then re-opened, the correct size will be installed in the
	inode and so everything will work.

    (2) We can return success for reads beyond the end of the medium
	(and fill the buffers with 0s).  The first time the device is
	opened, the user will then be able to read all the way up to
	(and perhaps a little beyond!) the end of the medium.

The advantage of (2) is that all the actual data is accessible all the 
time.  With (1), the last sector or so might not be accessible until the 
device is closed and re-opened.

Either way, it doesn't seem possible to do exactly the right thing.  Maybe 
there is a way to do it, though, and I simply don't know what it is.

Alan Stern

