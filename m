Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbVJVPk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbVJVPk6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 11:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbVJVPk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 11:40:58 -0400
Received: from mx1.rowland.org ([192.131.102.7]:44559 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S1751289AbVJVPk5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 11:40:57 -0400
Date: Sat, 22 Oct 2005 11:40:56 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jens Axboe <axboe@suse.de>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: BUG in the block layer (partial reads not reported)
In-Reply-To: <1129915917.3542.7.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44L0.0510221117160.3707-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Oct 2005, Alan Cox wrote:

> The block layer then retries (because there is no mechanism to report
> EOF upstream), this fails and the block layer is left with a page that
> contains 2048 bytes of valid data and 2048 bytes of undefined.
> Unfortunately it doesn't really know what do with this.
> 
> If you modify the drivers to fill the remaining 2048 bytes of the buffer
> with "JENSAXBOEPLEASEFIXME" or something similar and hand it up as
> completed instead of an error when the EOF case is hit that'll sort of
> do the right thing. Of course that assumes you can tell its an EOF but
> that will be the case even if the EOF handling is fixed.
> 
> Sort of related to this is that handling of read-ahead triggered errors
> is broken when the span a page because the kernel doesn't really know
> how to deal with a page of memory which is half valid and remember that.
> Thus accessing the page which contains the 2K of data you needed to save
> and the error block will give you an unneccessary error return and no
> data. The block layer ought to retry the I/O in this case and handle a
> short return correctly but it still seems not to.
> 
> The essential problem however is that if you say a disc is a given size
> and it turns out not to be (as happens with CD-R especially or with
> buggy readers) then Linux block layer can't cope. Its well known and
> causes endless problems for CD-R users with some IDE drives on Linux.
> Its a big generator of 2.6 vendor bug reports.
> 
> In the case where the media size is correctly set you should find the
> block layer never reads ahead beyond the declared EOF.

I gather then that there are really two separate problems:

	Handling an error somewhere in the middle of the medium, and

	Handling an error beyond the real end of the medium.

The mm and block subsystems have no way at all to retrieve partial data
for the first case.  Even though only one hardware sector may be bad,
failure to read an entire page means that none of the good sectors on that
page will be accessible.  While annoying, it's understandable and I don't 
see any simple way to accomodate such partial reads.

The second case appears to be more tractable, as you said.  In fact,
do_generic_mapping_read() in mm/filemap.c will recheck the inode's size
after a successful read, to avoid copying data beyond the end of the
device.

Could part of the problem also be that the set_capacity() call, used to
revise the device size downward when the CD driver realizes it is smaller
than originally thought, doesn't update the inode?  Should the driver call
bd_set_size() as well?  (In addition to completing the read successfully
with garbage data beyond the actual EOF.)

Incidentally, can you explain what bd_block_size in struct block_device is 
for?  Is the block_size used for anything important, that is, more 
important than the hardware sector size?  I ask because of the strange 
code in bd_set_size which sets bd_block_size equal to the largest power of 
2 that evenly divides the device size and is <= the PAGE_CACHE_SIZE.

Alan Stern

