Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129279AbRBFN6X>; Tue, 6 Feb 2001 08:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129299AbRBFN6N>; Tue, 6 Feb 2001 08:58:13 -0500
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:267 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S129279AbRBFN6F>; Tue, 6 Feb 2001 08:58:05 -0500
From: bsuparna@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Christoph Hellwig <hch@caldera.de>, Andi Kleen <ak@suse.de>
Message-ID: <CA2569EB.004C9A58.00@d73mta03.au.ibm.com>
Date: Tue, 6 Feb 2001 19:20:21 +0530
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait 
	/notify + callback chains
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Hi,
>
>On Mon, Feb 05, 2001 at 08:01:45PM +0530, bsuparna@in.ibm.com wrote:
>>
>> >It's the very essence of readahead that we wake up the earlier buffers
>> >as soon as they become available, without waiting for the later ones
>> >to complete, so we _need_ this multiple completion concept.
>>
>> I can understand this in principle, but when we have a single request
going
>> down to the device that actually fills in multiple buffers, do we get
>> notified (interrupted) by the device before all the data in that request
>> got transferred ?
>
>It depends on the device driver.  Different controllers will have
>different maximum transfer size.  For IDE, for example, we get wakeups
>all over the place.  For SCSI, it depends on how many scatter-gather
>entries the driver can push into a single on-the-wire request.  Exceed
>that limit and the driver is forced to open a new scsi mailbox, and
>you get independent completion signals for each such chunk.

I see. I remember Jens Axboe mentioning something like this with IDE.
So, in this case, you want every such chunk to check if its completed
filling up a buffer and then trigger a wakeup on that ?
But, does this also mean that in such a case combining requests beyond this
limit doesn't really help ? (Reordering requests to get contiguity would
help of course in terms of seek times, I guess, but not merging beyond this
limit)

>> >Which is exactly why we have one kiobuf per higher-level buffer, and
>> >we chain together kiobufs when we need to for a long request, but we
>> >still get the independent completion notifiers.
>>
>> As I mentioned above, the alternative is to have the i/o completion
related
>> linkage information within the wakeup structures instead. That way, it
>> doesn't matter to the lower level driver what higher level structure we
>> have above (maybe buffer heads, may be page cache structures, may be
>> kiobufs). We only chain together memory descriptors for the buffers
during
>> the io.
>
>You forgot IO failures: it is essential, once the IO completes, to
>know exactly which higher-level structures completed successfully and
>which did not.  The low-level drivers have to have access to the
>independent completion notifications for this to work.
>
No, I didn't forget IO failures; just that I expect the wait structure
containing the wakeup function to be embedded in a cev structure that
contains a pointer to the wait_queue_head field in the higher level
structure. The rest is for the wakeup function to interpret (it can always
access the other fields in the higher level structure - just like
list_entry() does)

Later I realized that instead of having multiple wakeup functions queued on
the low level structures wait queue, its perhaps better to just sort of
turn the cev_wait structure upside down (entry on the lower level
structure's queue should link to the parent entries instead).




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
