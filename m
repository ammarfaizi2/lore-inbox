Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbRBEMME>; Mon, 5 Feb 2001 07:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129525AbRBEMLx>; Mon, 5 Feb 2001 07:11:53 -0500
Received: from zeus.kernel.org ([209.10.41.242]:7894 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129436AbRBEMLs>;
	Mon, 5 Feb 2001 07:11:48 -0500
Date: Mon, 5 Feb 2001 12:09:34 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: bsuparna@in.ibm.com
Cc: "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org,
        kiobuf-io-devel@lists.sourceforge.net,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Christoph Hellwig <hch@caldera.de>, Andi Kleen <ak@suse.de>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains
Message-ID: <20010205120934.B1167@redhat.com>
In-Reply-To: <CA2569E9.004A4E23.00@d73mta05.au.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <CA2569E9.004A4E23.00@d73mta05.au.ibm.com>; from bsuparna@in.ibm.com on Sun, Feb 04, 2001 at 06:54:58PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Feb 04, 2001 at 06:54:58PM +0530, bsuparna@in.ibm.com wrote:
> 
> Can't we define a kiobuf structure as just this ? A combination of a
> frag_list and a page_list ?

Then all code which needs to accept an arbitrary kiobuf needs to be
able to parse both --- ugh.

> BTW, We could have a higher level io container that includes a <status>
> field and a <wait_queue_head> to take care of i/o completion

IO completion requirements are much more complex.  Think of disk
readahead: we can create a single request struct for an IO of a
hundred buffer heads, and as the device driver satisfies that request,
it wakes up the buffer heads as it goes.  There is a separete
completion notification for every single buffer head in the chain.

It's the very essence of readahead that we wake up the earlier buffers
as soon as they become available, without waiting for the later ones
to complete, so we _need_ this multiple completion concept.

Which is exactly why we have one kiobuf per higher-level buffer, and
we chain together kiobufs when we need to for a long request, but we
still get the independent completion notifiers.

Cheers,
 Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
