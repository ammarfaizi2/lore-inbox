Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129355AbRBDNcU>; Sun, 4 Feb 2001 08:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129146AbRBDNcK>; Sun, 4 Feb 2001 08:32:10 -0500
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:6148 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S129355AbRBDNbz>; Sun, 4 Feb 2001 08:31:55 -0500
From: bsuparna@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Christoph Hellwig <hch@caldera.de>, Andi Kleen <ak@suse.de>
Message-ID: <CA2569E9.004A45B6.00@d73mta03.au.ibm.com>
Date: Sun, 4 Feb 2001 18:54:58 +0530
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait 
	/notify + callback chains
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Hi,
>
>On Fri, Feb 02, 2001 at 12:51:35PM +0100, Christoph Hellwig wrote:
>> >
>> > If I have a page vector with a single offset/length pair, I can build
>> > a new header with the same vector and modified offset/length to split
>> > the vector in two without copying it.
>>
>> You just say in the higher-level structure ignore from x to y even if
>> they have an offset in their own vector.
>
>Exactly --- and so you end up with something _much_ uglier, because
>you end up with all sorts of combinations of length/offset fields all
>over the place.
>
>This is _precisely_ the mess I want to avoid.
>
>Cheers,
> Stephen

It appears that we are coming across 2 kinds of requirements for kiobuf
vectors - and quite a bit of debate centering around that.

1. In the block device i/o world, where large i/os may be involved, we'd
like to be able to describe chunks/fragments that contain multiple pages;
which is why it  make sense to have a single <offset, length> pair for the
entire set of pages in a kiobuf, rather than having to deal with per page
offset/len fields.

2. In the networking world, we deal with smaller fragments (for protocol
headers and stuff, and small packets) ideally chained together, typically
not page aligned, with the ability to extend the list at least at the head
and tail (and maybe some reshuffling in case of ip fragmentation?); so I
guess that's why it seems good to have an <offset, length> pair per
page/fragment. (If there can be multiple fragments in a page, even this
might not be frugal enough ... )

Looks like there are 2 kinds of entities that we are looking for in the kio
descriptor:
     - A collection of physical memory pages (call it say, a page_list)
     - A collection of fragments of memory described as <offset, len>
tuples w.r.t this collection
     (offset in turn could be <index in page-list, offset-in-page> if it
helps) (call this collection a frag_list)

Can't we define a kiobuf structure as just this ? A combination of a
frag_list and a page_list ? (Clone kiobufs might share the original
kiobuf's page_list, but just split parts of the frag_list)
How hard is it to maintain and to manipulate such a structure ?

BTW, We could have a higher level io container that includes a <status>
field and a <wait_queue_head> to take care of i/o completion (If we have a
wait queue head, then I don't think we need a separate callback function if
we have Ben's wakeup functions in place).

Or,  is this going in the direction of a cross between and elephant and a
bicycle :-)  ?

Regards
Suparna


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
