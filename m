Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130099AbRBAFDM>; Thu, 1 Feb 2001 00:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130096AbRBAFCx>; Thu, 1 Feb 2001 00:02:53 -0500
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:14857 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S129715AbRBAFCm>; Thu, 1 Feb 2001 00:02:42 -0500
From: bsuparna@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net,
        Stephen Tweedie <sct@redhat.com>
Message-ID: <CA2569E6.001B9D72.00@d73mta03.au.ibm.com>
Date: Thu, 1 Feb 2001 10:25:22 +0530
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
	/notify + callback chains
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>My first comment is that this looks very heavyweight indeed.  Isn't it
>just over-engineered?

Yes, I know it is, in its current form (sigh !).

But at the same time, I do not want to give up (not yet, at least) on
trying to arrive at something that can serve the objectives, and yet be
simple in principle and lightweight too. I feel the need may  grow as we
have more filter layers coming in, and as async i/o and even i/o
cancellation usage increases. And it may not be just with kiobufs ...

I took a second pass attempt at it last night based on Ben's wait queue
extensions. Will write that up in a separate note after this. Do let me
know if it seems like any improvement at all.

>We _do_ need the ability to stack completion events, but as far as the
>kiobuf work goes, my current thoughts are to do that by stacking
>lightweight "clone" kiobufs.

Would that work with stackable filesystems ?

>
>The idea is that completion needs to pass upwards (a)
>bytes-transferred, and (b) errno, to satisfy the caller: everything
>else, including any private data, can be hooked by the caller off the
>kiobuf private data (or in fact the caller's private data can embed
>the clone kiobuf).
>
>A clone kiobuf is a simple header, nothing more, nothing less: it
>shares the same page vector as its parent kiobuf.  It has private
>length/offset fields, so (for example) a LVM driver can carve the
>parent kiobuf into multiple non-overlapping children, all sharing the
>same page list but each one actually referencing only a small region
>of the whole.
>
>That ought to clean up a great deal of the problems of passing kiobufs
>through soft raid, LVM or loop drivers.
>
>I am tempted to add fields to allow the children of a kiobuf to be
>tracked and identified, but I'm really not sure it's necessary so I'll
>hold off for now.  We already have the "io-count" field which
>enumerates sub-ios, so we can define each child to count as one such
>sub-io; and adding a parent kiobuf reference to each kiobuf makes a
>lot of sense if we want to make it easy to pass callbacks up the
>stack.  More than that seems unnecessary for now.

Being able to track the children of a kiobuf would help with I/O
cancellation (e.g. to pull sub-ios off their request queues if I/O
cancellation for the parent kiobuf was issued). Not essential, I guess, in
general, but useful in some situations.
With a clone kiobuf there is no direct way to reach a clone kiobuf given
the original kiobuf (without adding some indexing scheme ).

>
>--Stephen



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
