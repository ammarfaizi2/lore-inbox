Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130496AbRBAStW>; Thu, 1 Feb 2001 13:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131439AbRBAStL>; Thu, 1 Feb 2001 13:49:11 -0500
Received: from ns.caldera.de ([212.34.180.1]:14599 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S130496AbRBASs5>;
	Thu, 1 Feb 2001 13:48:57 -0500
Date: Thu, 1 Feb 2001 19:48:00 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christoph Hellwig <hch@caldera.de>, "Stephen C. Tweedie" <sct@redhat.com>,
        bsuparna@in.ibm.com, linux-kernel@vger.kernel.org,
        kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains
Message-ID: <20010201194800.A4653@caldera.de>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Stephen C. Tweedie" <sct@redhat.com>, bsuparna@in.ibm.com,
	linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net
In-Reply-To: <20010201191403.B448@caldera.de> <E14OOQ2-0004nq-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <E14OOQ2-0004nq-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Feb 01, 2001 at 06:25:16PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2001 at 06:25:16PM +0000, Alan Cox wrote:
> > array_len, io_count, the presence of wait_queue AND end_io, and the lack of
> > scatter gather in one kiobuf struct (you always need an array), and AFAICS
> > that is what the networking guys dislike.
> 
> You need a completion pointer. Its arguable whether you want the wait_queue
> in the default structure or as part of whatever its contained in and handled
> by the completion pointer.

I personaly think that Ben's function pointer on wakeup work is the alternative in
this area.

> And I've actually bothered to talk to the networking people and they dont have
> a problem with the completion pointer.

I have never said that they don't like it - but having both the waitqueue and the
completion handler in the kiobuf makes it bigger.

> > Now one could say: just let the networkers use their own kind of buffers
> > (and that's exactly what is done in the zerocopy patches), but that again leds
> > to inefficient buffer passing and ungeneric IO handling.
> 
> Careful.  This is the line of reasoning which also says
> 
> Aeroplanes are good for travelling long distances
> Cars are better for getting to my front door
> Therefore everyone should drive a 747 home

Hehe ;)

> It is quite possible that the right thing to do is to do conversions in the
> cases it happens.

Yes, this would be THE alternative to my suggestion.

> That might seem a good reason for having offset/length
> pairs on each block, because streaming from the network to disk you may well
> get a collection of partial pages of data you need to write to disk. 
> Unfortunately the reality of DMA support on almost (but not quite) all
> disk controllers is that you don't get that degree of scatter gather.
> 
> My I2O controllers and I think the fusion controllers could indeed benefit
> and cope with being given a pile of randomly located 1480 byte chunks of 
> data and being asked to put them on disk.

It doesn't really matter that much, because we write to the pagecache
first anyway.

The real thing is that we want to have some common data structure for
describing physical memory used for IO.  We could either use special
structures in every subsystem and then copy between them or pass
struct page * and lose meta information.  Or we could try to find a
structure that holds enough information to make passing it from one
subsystem to another usefull.  The cut-down kio design (heavily inspired
by Larry McVoy's splice paper) should allow just that, nothing more an
nothing less.  For use in disk-io and networking or v4l there are probably
other primary data structures needed, and that's ok.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
