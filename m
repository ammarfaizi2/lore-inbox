Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129245AbRBFOIO>; Tue, 6 Feb 2001 09:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129351AbRBFOIE>; Tue, 6 Feb 2001 09:08:04 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:24335 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129345AbRBFOHs>;
	Tue, 6 Feb 2001 09:07:48 -0500
Date: Tue, 6 Feb 2001 15:07:33 +0100
From: Jens Axboe <axboe@suse.de>
To: bsuparna@in.ibm.com
Cc: "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org,
        kiobuf-io-devel@lists.sourceforge.net,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Christoph Hellwig <hch@caldera.de>, Andi Kleen <ak@suse.de>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains
Message-ID: <20010206150733.G13967@suse.de>
In-Reply-To: <CA2569EB.004C9A58.00@d73mta03.au.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA2569EB.004C9A58.00@d73mta03.au.ibm.com>; from bsuparna@in.ibm.com on Tue, Feb 06, 2001 at 07:20:21PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06 2001, bsuparna@in.ibm.com wrote:
> >It depends on the device driver.  Different controllers will have
> >different maximum transfer size.  For IDE, for example, we get wakeups
> >all over the place.  For SCSI, it depends on how many scatter-gather
> >entries the driver can push into a single on-the-wire request.  Exceed
> >that limit and the driver is forced to open a new scsi mailbox, and
> >you get independent completion signals for each such chunk.

SCSI does not build a request bigger than the low level driver
can handle. If you exceed the scatter count in a single request,
you just stop and fire of that request, later on restarting I/O
on the remainder.

> I see. I remember Jens Axboe mentioning something like this with IDE.
> So, in this case, you want every such chunk to check if its completed
> filling up a buffer and then trigger a wakeup on that ?

Yes. Which is why dealing with buffer heads are so nice in this
regard, you never have problems with ending I/O on a single "piece".

> But, does this also mean that in such a case combining requests beyond this
> limit doesn't really help ? (Reordering requests to get contiguity would
> help of course in terms of seek times, I guess, but not merging beyond this
> limit)

There's a slight benefit in building bigger requests than the driver
can handle, in that you can have more I/O pending on the queue. It's
not worth spending too much time on though.

-- 
Jens Axboe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
