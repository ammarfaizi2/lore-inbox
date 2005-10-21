Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965032AbVJURDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965032AbVJURDh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 13:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965034AbVJURDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 13:03:36 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:40164 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965032AbVJURDg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 13:03:36 -0400
Subject: Re: BUG in the block layer (partial reads not reported)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jens Axboe <axboe@suse.de>,
       Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0510201435400.4453-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0510201435400.4453-100000@iolanthe.rowland.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 21 Oct 2005 18:31:57 +0100
Message-Id: <1129915917.3542.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-10-20 at 16:39 -0400, Alan Stern wrote:
> The end result is that dd receives no data, only an error.  This is in 
> spite of the fact that the kernel was able to read successfully all the 
> data that had been requested!
> 
> Now I have only the vaguest notion of how the block layer works, and I 
> don't know where to begin solving this problem.  Any help would be 
> appreciated.


Yes I found this with the IDE layer work - I reported it last year. There is
no mechanism to return EOF through the block layer.

The driver behaviour you describe appears correct except for the (as far
as I can see harmless) 0 byte chunk.

It reports the first sector as correct and completed. It then reports
the second sector as failed and an error. It then completes the request.

The block layer then retries (because there is no mechanism to report
EOF upstream), this fails and the block layer is left with a page that
contains 2048 bytes of valid data and 2048 bytes of undefined.
Unfortunately it doesn't really know what do with this.

If you modify the drivers to fill the remaining 2048 bytes of the buffer
with "JENSAXBOEPLEASEFIXME" or something similar and hand it up as
completed instead of an error when the EOF case is hit that'll sort of
do the right thing. Of course that assumes you can tell its an EOF but
that will be the case even if the EOF handling is fixed.

Sort of related to this is that handling of read-ahead triggered errors
is broken when the span a page because the kernel doesn't really know
how to deal with a page of memory which is half valid and remember that.
Thus accessing the page which contains the 2K of data you needed to save
and the error block will give you an unneccessary error return and no
data. The block layer ought to retry the I/O in this case and handle a
short return correctly but it still seems not to.

The essential problem however is that if you say a disc is a given size
and it turns out not to be (as happens with CD-R especially or with
buggy readers) then Linux block layer can't cope. Its well known and
causes endless problems for CD-R users with some IDE drives on Linux.
Its a big generator of 2.6 vendor bug reports.

In the case where the media size is correctly set you should find the
block layer never reads ahead beyond the declared EOF.

Alan

