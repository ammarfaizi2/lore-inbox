Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130018AbRBEPEA>; Mon, 5 Feb 2001 10:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130482AbRBEPDv>; Mon, 5 Feb 2001 10:03:51 -0500
Received: from zeus.kernel.org ([209.10.41.242]:65479 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130018AbRBEPDb>;
	Mon, 5 Feb 2001 10:03:31 -0500
Date: Mon, 5 Feb 2001 15:01:17 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: bsuparna@in.ibm.com
Cc: "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org,
        kiobuf-io-devel@lists.sourceforge.net,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Christoph Hellwig <hch@caldera.de>, Andi Kleen <ak@suse.de>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains
Message-ID: <20010205150117.D1167@redhat.com>
In-Reply-To: <CA2569EA.00506BBC.00@d73mta05.au.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <CA2569EA.00506BBC.00@d73mta05.au.ibm.com>; from bsuparna@in.ibm.com on Mon, Feb 05, 2001 at 08:01:45PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 05, 2001 at 08:01:45PM +0530, bsuparna@in.ibm.com wrote:
> 
> >It's the very essence of readahead that we wake up the earlier buffers
> >as soon as they become available, without waiting for the later ones
> >to complete, so we _need_ this multiple completion concept.
> 
> I can understand this in principle, but when we have a single request going
> down to the device that actually fills in multiple buffers, do we get
> notified (interrupted) by the device before all the data in that request
> got transferred ?

It depends on the device driver.  Different controllers will have
different maximum transfer size.  For IDE, for example, we get wakeups
all over the place.  For SCSI, it depends on how many scatter-gather
entries the driver can push into a single on-the-wire request.  Exceed
that limit and the driver is forced to open a new scsi mailbox, and
you get independent completion signals for each such chunk.

> >Which is exactly why we have one kiobuf per higher-level buffer, and
> >we chain together kiobufs when we need to for a long request, but we
> >still get the independent completion notifiers.
> 
> As I mentioned above, the alternative is to have the i/o completion related
> linkage information within the wakeup structures instead. That way, it
> doesn't matter to the lower level driver what higher level structure we
> have above (maybe buffer heads, may be page cache structures, may be
> kiobufs). We only chain together memory descriptors for the buffers during
> the io.

You forgot IO failures: it is essential, once the IO completes, to
know exactly which higher-level structures completed successfully and
which did not.  The low-level drivers have to have access to the
independent completion notifications for this to work.

Cheers,
 Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
